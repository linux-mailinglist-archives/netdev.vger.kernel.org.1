Return-Path: <netdev+bounces-58265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FB6815B03
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 19:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032791C2160C
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 18:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D377C31739;
	Sat, 16 Dec 2023 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTIBdmqu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98783066C
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 18:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D153EC433C7;
	Sat, 16 Dec 2023 18:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702750787;
	bh=9GhNFtS7ftpmGcQln2/O3fa0QpAQ4hTvmG69X4+UJIg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qTIBdmquM85HAtxSkWoadKv6nqxpnLxAM8bTiXgkIlTFSbOUETokdd4V7tBXsMZ/K
	 952dpfbx3zPe/NdsXscK2EZVslYY+nhzNZq8/iyt0lsaQbDqXhjh9+Dau0zaiz7O9J
	 GCwf89pAbUyUOgBfJFSGLNsweM1G1AU+TrLHoJgyxjwtO1zThHQNJ6Niq2KuYDmnES
	 ofulHqt+Yx0s6MqYGkCUo59wz02ZX7lzkF7oPJXhqqlzB5TX0IW6rZxvwWXAOzUddD
	 sh3jROhMsyzySb79qFS00gRnThD8wfdIw/R2d0PRPajDSVO8rTQhEfJZTbyHxnRlW6
	 X/X73+zEZlJBw==
Message-ID: <10569cc5-1624-4edf-88b9-ec9110c11890@kernel.org>
Date: Sat, 16 Dec 2023 11:19:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RFC: net: ipconfig: temporarily bring interface down when
 changing MTU.
Content-Language: en-US
To: Graeme Smecher <gsmecher@threespeedlogic.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 claudiu.beznea@tuxon.dev, nicolas.ferre@microchip.com, mdf@kernel.org
References: <58519bfa-260c-4745-a145-fdca89b4e9d1@kernel.org>
 <20231216010431.84776-1-gsmecher@threespeedlogic.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231216010431.84776-1-gsmecher@threespeedlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/15/23 5:04 PM, Graeme Smecher wrote:
\> diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
> index c56b6fe6f0d7..69c2a41393a0 100644
> --- a/net/ipv4/ipconfig.c
> +++ b/net/ipv4/ipconfig.c
> @@ -396,9 +396,21 @@ static int __init ic_setup_if(void)
>  	 */
>  	if (ic_dev_mtu != 0) {
>  		rtnl_lock();
> -		if ((err = dev_set_mtu(ic_dev->dev, ic_dev_mtu)) < 0)
> -			pr_err("IP-Config: Unable to set interface mtu to %d (%d)\n",
> -			       ic_dev_mtu, err);
> +		/* Some Ethernet adapters only allow MTU to change when down. */
> +		if((err = dev_change_flags(ic_dev->dev, ic_dev->dev->flags | IFF_UP, NULL)))

IFF_UP?

> +			pr_err("IP-Config: About to set MTU, but failed to "
> +				 "bring interface %s down! (%d)\n",
> +				 ic_dev->dev->name, err);
> +		else {
> +			if ((err = dev_set_mtu(ic_dev->dev, ic_dev_mtu)) < 0)

try to set the MTU even if DOWN fails otherwise a regression.


> +				pr_err("IP-Config: Unable to set interface mtu to %d (%d)\n",
> +				       ic_dev_mtu, err);
> +
> +			if((err = dev_change_flags(ic_dev->dev, ic_dev->dev->flags | IFF_UP, NULL)))
> +				pr_err("IP-Config: Trying to set MTU, but unable "
> +					 "to bring interface %s back up! (%d)\n",


This step is not "trying to set MTU"; the last one did:

pr_err("IP-Config: Failed to bring interface %s up after changing MTU
(%d)\n",

> +					 ic_dev->dev->name, err);
> +		}
>  		rtnl_unlock();
>  	}
>  	return 0;


