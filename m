Return-Path: <netdev+bounces-48660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFF07EF266
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 13:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE041C2012B
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 12:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271073035E;
	Fri, 17 Nov 2023 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="YF50WvbB"
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 337 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Nov 2023 04:11:34 PST
Received: from proxima.lasnet.de (proxima.lasnet.de [IPv6:2a01:4f8:121:31eb:3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B96BC;
	Fri, 17 Nov 2023 04:11:34 -0800 (PST)
Received: from [192.168.2.51] (p4fe71630.dip0.t-ipconnect.de [79.231.22.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id E9CEBC0D81;
	Fri, 17 Nov 2023 13:06:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1700222770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hvWfBuY8zILDhRg65fSk2vABR2JIQ9meo5junjfeFUI=;
	b=YF50WvbB8xln0pfsf5scbODzhHqN4MrB04NZjb9QQ55EhGOMAQgApC/WmCnSF1ChTpusfX
	cpCYTLKAG+nPjvFh90nehbayhgfi1v5LDzENDzBP89x1HRKaRQFqnqpJuMMb9pI1/Pv9kQ
	VmR9S6zM36y7uIP5SzVjyYX/Fuubxy78lBdwTOKiwkdcke/WgDx7wflKOea3Q23iIxvkyu
	IX3Lowcq5oy9BRnzDy+l53calLxgxoRRf2Miu/LRSdd2c9vNG6e5TPeMmJI5MOWy4yeb8t
	Lj158CUM2YzIgLMdKX7S7U+7evtUwfWjMOkDAigVmDRkQ3OXKEUoxX/8MPEnMA==
Message-ID: <559092f8-6b50-b816-99dc-109555cf872a@datenfreihafen.org>
Date: Fri, 17 Nov 2023 13:06:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 10/10] ieee802154: hwsim: Convert to platform
 remove callback returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Alexander Aring <alex.aring@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, kernel@pengutronix.de
References: <20231117095922.876489-1-u.kleine-koenig@pengutronix.de>
 <20231117095922.876489-11-u.kleine-koenig@pengutronix.de>
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20231117095922.876489-11-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello.

On 17.11.23 10:59, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/net/ieee802154/mac802154_hwsim.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
> index 31cba9aa7636..2c2483bbe780 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.c
> +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> @@ -1035,7 +1035,7 @@ static int hwsim_probe(struct platform_device *pdev)
>   	return err;
>   }
>   
> -static int hwsim_remove(struct platform_device *pdev)
> +static void hwsim_remove(struct platform_device *pdev)
>   {
>   	struct hwsim_phy *phy, *tmp;
>   
> @@ -1043,13 +1043,11 @@ static int hwsim_remove(struct platform_device *pdev)
>   	list_for_each_entry_safe(phy, tmp, &hwsim_phys, list)
>   		hwsim_del(phy);
>   	mutex_unlock(&hwsim_phys_lock);
> -
> -	return 0;
>   }
>   
>   static struct platform_driver mac802154hwsim_driver = {
>   	.probe = hwsim_probe,
> -	.remove = hwsim_remove,
> +	.remove_new = hwsim_remove,
>   	.driver = {
>   			.name = "mac802154_hwsim",
>   	},


Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>

regards
Stefan Schmidt

