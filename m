Return-Path: <netdev+bounces-122757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40410962743
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F206428534F
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6F5176228;
	Wed, 28 Aug 2024 12:37:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5232116C865;
	Wed, 28 Aug 2024 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724848677; cv=none; b=cxSrgRT0ZZyoy0Yx76vTrF3Q1uoidSYUgmfIuqSdlBjekFrkaZb0OQVOBzDExXoRyzL7ROiOU7RXu4vITGe56RdhYbCdBoTyrR1rdscs6tM7iZmhWSklkj31AuVMvw9V1zZUQwnKYnl08Iqlb/cGX8ESl3L2B63sz/569vr9UZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724848677; c=relaxed/simple;
	bh=BEofx4i8qQ9H7CSevMVf5sNaMv3SeNVdD44h8Cyrf9E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YU/5aeWLAzhl7p5C/ASRNAIn1I0CYjRMbUnnCo8zZo2ddxyh9C9WLh7p3Tcny/1mui7mMb5NHqj7DUfgre6d3VOhUwJVBbWoE9MGEqD37/qthSLvfoAAK2fw0LupsmdzDj+LdSX8QRgJUUynGmJV+gmSi6GpcjHIR2BsWTjjuU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wv3l016Drz6H7RN;
	Wed, 28 Aug 2024 20:34:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A9B7140447;
	Wed, 28 Aug 2024 20:37:52 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 13:37:51 +0100
Date: Wed, 28 Aug 2024 13:37:50 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
CC: <woojung.huh@microchip.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linus.walleij@linaro.org>,
	<alsi@bang-olufsen.dk>, <justin.chen@broadcom.com>,
	<sebastian.hesselbarth@gmail.com>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>, <wens@csie.org>,
	<jernej.skrabec@gmail.com>, <samuel@sholland.org>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <ansuelsmth@gmail.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bcm-kernel-feedback-list@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-stm32@st-md-mailman.stormreply.com>, <krzk@kernel.org>,
	<jic23@kernel.org>
Subject: Re: [PATCH net-next v2 04/13] net: dsa: realtek: Use __free() to
 simplify code
Message-ID: <20240828133750.00007963@Huawei.com>
In-Reply-To: <20240828032343.1218749-5-ruanjinjie@huawei.com>
References: <20240828032343.1218749-1-ruanjinjie@huawei.com>
	<20240828032343.1218749-5-ruanjinjie@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 28 Aug 2024 11:23:34 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> Avoid need to manually handle of_node_put() by using __free(), which
> can simplfy code.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
One suggestion inline.

> ---
> v2
> - Split into 2 patches.
> ---
>  drivers/net/dsa/realtek/rtl8366rb.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
> index 7001b8b1c028..0acdcdd93ea2 100644
> --- a/drivers/net/dsa/realtek/rtl8366rb.c
> +++ b/drivers/net/dsa/realtek/rtl8366rb.c
> @@ -1009,7 +1009,6 @@ static int rtl8366rb_setup_all_leds_off(struct realtek_priv *priv)
>  
>  static int rtl8366rb_setup_leds(struct realtek_priv *priv)
>  {
> -	struct device_node *leds_np;
>  	struct dsa_switch *ds = &priv->ds;
>  	struct dsa_port *dp;
>  	int ret = 0;
> @@ -1018,7 +1017,8 @@ static int rtl8366rb_setup_leds(struct realtek_priv *priv)
>  		if (!dp->dn)
>  			continue;
>  
> -		leds_np = of_get_child_by_name(dp->dn, "leds");
> +		struct device_node *leds_np __free(device_node) =
> +			of_get_child_by_name(dp->dn, "leds");
>  		if (!leds_np) {
>  			dev_dbg(priv->dev, "No leds defined for port %d",
>  				dp->index);
> @@ -1032,7 +1032,6 @@ static int rtl8366rb_setup_leds(struct realtek_priv *priv)
>  				break;
>  		}
>  
> -		of_node_put(leds_np);
>  		if (ret)
>  			return ret;

Move this return up to the only place it can come from which is
inside the loop where the break is.

You can then avoid initializing ret and indeed could bring it's
scope into the loop

		for_each_child_of_node(leds_np, led_np) {
			int ret = rtl8366rb_setup_led(priv, dp,
						      of_fwnode_handle(led_np));
			if (ret)
				return ret;
		}	

>  	}


