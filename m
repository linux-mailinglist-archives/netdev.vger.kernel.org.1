Return-Path: <netdev+bounces-128175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6409785F6
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 18:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35CA28A0CC
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 16:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A96F745CB;
	Fri, 13 Sep 2024 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UF02V0tb"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F892D052
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726245662; cv=none; b=YEktvHS3SsCCH9Srtxhj7hske000sqa2wmmJWuOu/iDSJFaBbvKUUKSe65Kj3MkRxZ5cEzXmXvTWTI3pfPh1HVdTal3iqmhxrnzUGeUkyEYepdsBft3yJI+7+640/jNsX45OPZZds8bKyXR7LYjDR1/wKho56H+0ePsl8h+/J6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726245662; c=relaxed/simple;
	bh=HhYMYnEDCfAu/czHEFoDMqeqegceDcImzlGxTPN4FyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iA7JyD3anhPQJ3hj+lVaqhujzj4qIo7mkBOK65D9b5tU8nuhi0ajQog2PToO4ztCEP6Dapihg3gSQuZoN3n9PisLHwpgOVBURN8GlcZzSs+JZvKtkTg1FUvKoH5u/5+U6rre/rqvizS5L82Sj2/hGi6a/ikmR00dMHqHCWDeO+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UF02V0tb; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <14e6f307-1aaa-4862-a22f-4833fc18920a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726245658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wG4ZcFkaU9wM1fuGnOPOZ06ynoZgWADJYJlzgy7RAcM=;
	b=UF02V0tbxau1xdYEebDycBjEwN7gqdm1KS9I+SduH4IbyKxFCL+ASKhsM1b54NFQBURG3z
	Uw2fj9quCfJjJcBlpDtB6SciWQh6xm+fU/Jo+ujz0huJ78UO90YOz5f2HrOE/ehfFbw/lP
	O6UII46xxunMiGzSDCs6n91R4rVbAV0=
Date: Fri, 13 Sep 2024 17:40:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: ethtool: phy: Don't set the context dev
 pointer for unfiltered DUMP
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Nathan Chancellor <nathan@kernel.org>, Antoine Tenart <atenart@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com, davem@davemloft.net
References: <20240913100515.167341-1-maxime.chevallier@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240913100515.167341-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/09/2024 11:05, Maxime Chevallier wrote:
> The context info allows continuing DUMP requests, shall they fill the
> netlink buffer.
> 
> In the case of filtered DUMP requests, a reference on the netdev is
> grabbed in the .start() callback and release in .done().
> 
> Unfiltered DUMP request don't need the dev pointer to be set in the context
> info, doing so will trigger an unwanted netdev_put() in .done().
> 
> Reported-by: syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/000000000000d3bf150621d361a7@google.com/
> Fixes: 17194be4c8e1 ("net: ethtool: Introduce a command to list PHYs on an interface")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> This patch fixes a commit that still lives in net-next.
> 
>   net/ethtool/phy.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
> index 4ef7c6e32d10..ed8f690f6bac 100644
> --- a/net/ethtool/phy.c
> +++ b/net/ethtool/phy.c
> @@ -251,8 +251,6 @@ static int ethnl_phy_dump_one_dev(struct sk_buff *skb, struct net_device *dev,
>   	int ret = 0;
>   	void *ehdr;
>   
> -	pri->base.dev = dev;
> -
>   	if (!dev->link_topo)
>   		return 0;
>   

I've checked that this is leftover from the previous series.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

