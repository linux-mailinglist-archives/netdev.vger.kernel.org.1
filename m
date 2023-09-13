Return-Path: <netdev+bounces-33579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF5579EACD
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 16:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67FB3281B0C
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 14:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275341F17C;
	Wed, 13 Sep 2023 14:17:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB9A3D6C
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 14:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C816C433CA;
	Wed, 13 Sep 2023 14:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694614624;
	bh=/rNYMfmPg+JGRzNdRuWzEsyg8yvemb1m47ESpOOafwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g2uI7QNFhk6zUFRfrqsp17vuk306nqCbi1llBnDYOLVTtrliQ/6/ZwRYO2+Sfd8dI
	 4YO8yO1WYcDralnrpJOr0S0tMlBVyM1UhkQaNOzyxMsa1wq+rb4a6RSRbf/+F3n2mE
	 Fuz2gEUz/ChF5Ovx3MwHuiGcEmBFiKjCQJiRrSBHiMjA5mArn2IptGVJ2D+q5UqJ46
	 Wbj1wUHByl1bRy9D3W+m21+zRz9t7xTEcFLZx0BIzDX0UpvnFmL5F2+uj/98ynr7X9
	 y+UWsgniWcFR6vVMV/CuZ03JeFhxRhbSxqrnAua2l4SZSKWy347zlVnVZF58Acl3EO
	 gc01oA5q58odA==
Date: Wed, 13 Sep 2023 16:16:58 +0200
From: Simon Horman <horms@kernel.org>
To: Jinjian Song <songjinjian@hotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com, jiri@resnulli.us, johannes@sipsolutions.net,
	chandrashekar.devegowda@intel.com, linuxwwan@intel.com,
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, nmarupaka@google.com,
	vsankar@lenovo.com, danielwinkler@google.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: Re: [net-next v4 4/5] net: wwan: t7xx: Adds sysfs attribute of modem
 event
Message-ID: <20230913141658.GV401982@kernel.org>
References: <20230912094845.11233-1-songjinjian@hotmail.com>
 <ME3P282MB27032EB049D5135D68ADE09FBBF1A@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ME3P282MB27032EB049D5135D68ADE09FBBF1A@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>

On Tue, Sep 12, 2023 at 05:48:44PM +0800, Jinjian Song wrote:
> From: Jinjian Song <jinjian.song@fibocom.com>
> 
> Adds support for t7xx wwan device firmware flashing & coredump collection
> using devlink.
> 
> Provides sysfs attribute on user space to query the event from modem
> about flashing/coredump/reset.
> 
> Base on the v5 patch version of follow series:
> 'net: wwan: t7xx: fw flashing & coredump support'
> (https://patchwork.kernel.org/project/netdevbpf/patch/fc8bbb0b66a5ff3a489ea9857d79b374508090ef.1674307425.git.m.chetan.kumar@linux.intel.com/)
> 
> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>

Hi Jinjian Song,

some minor feedback from my side.

...

> diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c

...

> +static ssize_t t7xx_event_show(struct device *dev, struct device_attribute *attr,
> +			       char *buf)
> +{
> +	enum t7xx_event event = T7XX_UNKNOWN;
> +	struct pci_dev *pdev;
> +	struct t7xx_pci_dev *t7xx_dev;

Please arrange local variables in networking code in reverse xmas tree
order - longest line to shortest.

https://github.com/ecree-solarflare/xmastree can be helpful here.

...

> diff --git a/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c

...

> @@ -361,6 +367,10 @@ static int t7xx_devlink_flash_update(struct devlink *devlink,
>  	clear_bit(T7XX_FLASH_STATUS, &flash_dump->status);
>  
>  err_out:
> +	if (ret)
> +		atomic_set(&port->t7xx_dev->event, T7XX_FLASH_FAILURE);
> +	else
> +		atomic_set(&port->t7xx_dev->event, T7XX_FLASH_SUCCESS);

If the lines immediately above are reached as the result of jumping
to err_out, then port is not initialised.

>  	return ret;
>  }

...

