Return-Path: <netdev+bounces-32453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD8D797A21
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 19:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19F0281730
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F38313AE4;
	Thu,  7 Sep 2023 17:31:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFB8134D0
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 17:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CE9C433C8;
	Thu,  7 Sep 2023 17:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694107885;
	bh=LlWdzoTKEpuYNv8XM2gUMgmeHf+5SJjgG1ozmMS2HuE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e3b92T5q/sluLVYSMLlXh73MxVSe7AfyY4zI/A5kmGP/sYB7LJC1kdmJNZ4m6b94I
	 MeSx8VyUXKGp08zEj8/5w3XmMrZFyl868nLWQAj/gbnWa2Z2rcSXR8Gm7Hw7jTi/YN
	 DzvWThwI+npuboOMTv7wMN3DSdpoB06SHi1G/S5bI3ICLVe5WqcUgjVE12qY0EyRDe
	 cLgwYIDMYbv9w29JMBQLVkx+7vZi6rAm8uT//qG9EQ7zbRbc3NLTf4LINNXMp9wfme
	 s2N7FDB7SZN93QoXDAy3kvXMI6VeX54y1nh5YXKaen8UOBSYtBCkIf7xKz8reLru1D
	 YrtfwwA/OvWwA==
Date: Thu, 7 Sep 2023 10:31:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 jiri@resnulli.us, netdev@vger.kernel.org,
 syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: team: do not use dynamic lockdep key
Message-ID: <20230907103124.6adb7256@kernel.org>
In-Reply-To: <20230905084610.3659354-1-ap420073@gmail.com>
References: <20230905084610.3659354-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Sep 2023 08:46:10 +0000 Taehee Yoo wrote:
> @@ -1203,18 +1203,31 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
>  
>  	memcpy(port->orig.dev_addr, port_dev->dev_addr, port_dev->addr_len);
>  
> -	err = team_port_enter(team, port);
> +	err = dev_open(port_dev, extack);
>  	if (err) {
> -		netdev_err(dev, "Device %s failed to enter team mode\n",
> +		netdev_dbg(dev, "Device %s opening failed\n",
>  			   portname);
> -		goto err_port_enter;
> +		goto err_dev_open;
>  	}
>  
> -	err = dev_open(port_dev, extack);
> +	err = team_upper_dev_link(team, port, extack);

I'm guessing the syzbot complaint:

https://lore.kernel.org/all/000000000000e44e4a0604c66b67@google.com/

is related to this reordering of team_upper_dev_link() before things
are initialized. I'll revert this version in net, let's target v2 at
net-next, next week? "lockdep runs out of keys" isn't a real bug,
or at least I don't think the benefit is high enough for pushing
functional code changes into current release. Sounds reasonable?

>  	if (err) {
> -		netdev_dbg(dev, "Device %s opening failed\n",
> +		netdev_err(dev, "Device %s failed to set upper link\n",
>  			   portname);
> -		goto err_dev_open;
> +		goto err_set_upper_link;
> +	}
> +
> +	/* lockdep subclass variable(dev->nested_level) was updated by
> +	 * team_upper_dev_link().
> +	 */
> +	team_unlock(team);
> +	team_lock(team);
> +
> +	err = team_port_enter(team, port);
> +	if (err) {
> +		netdev_err(dev, "Device %s failed to enter team mode\n",
> +			   portname);
> +		goto err_port_enter;
>  	}
>  
>  	err = vlan_vids_add_by_dev(port_dev, dev);
> @@ -1242,13 +1255,6 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
>  		goto err_handler_register;
>  	}
>  
> -	err = team_upper_dev_link(team, port, extack);
> -	if (err) {
> -		netdev_err(dev, "Device %s failed to set upper link\n",
> -			   portname);
> -		goto err_set_upper_link;
> -	}

