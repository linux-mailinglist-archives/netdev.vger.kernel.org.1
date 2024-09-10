Return-Path: <netdev+bounces-127076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE77973F40
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 19:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958F11F27162
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 17:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4C91A4F3E;
	Tue, 10 Sep 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lUKkbX3r"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284AF1A38DE;
	Tue, 10 Sep 2024 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988829; cv=none; b=tWTcOoxgOyNnzHrAqyvALfswedPWvh6qLxj5XlYWnls63JQ19yNbzD8xbKg1UPHcZRn9d1PbPo3vBqy22uvAVgkeQykPxvbmJ86ghCIPzZQrLMV5n6m93xYIXWg6JNdPn+9nEsp/TxW5XGUGgR2AaFcdWsJDr9iNtwS/v+XDs1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988829; c=relaxed/simple;
	bh=vcyFLnkvkzznCnm5LV7YtX/JXny9Ysa/px35H5yc/ik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5dabkpzgDD5ar69w+FB52/KFOBq7DnDeKcZjYuoshZSiHc6ctt/LYemSCxLfDVGhtPJbOC0CxrdteuuXbp+21q4JOuHX4tbwOQmbx2FaMmxVopV+stWHqFjQIWbiMt2GZgRtQDVr85MOidKzY4xRtvldIlVnjL6m6mWt9THG20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lUKkbX3r; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 58A31C0006;
	Tue, 10 Sep 2024 17:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725988824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Ch6z1tjobzI++fJXbYA525eKQI+H40wH6oOlBG7IOc=;
	b=lUKkbX3rbHq1e4tO1l0fOwoRZXIt/PkRz0pR5KPautsjwVgzUwmxgKIhykoNZVTg4GCGkf
	uvBZZ/E2vfQNih9denOi5GN3XL/bHcdUjK9k5QVUscTl/t3G7IyrT++rvxZh092ZsYAaa+
	SVnjd/MynHtbdqNhXn9IXRWfM/zNuLg2vOWpipNXKT23Pfy32l4by+xIyYCI4GLncHhVkR
	rjrR5LwOBUsTJ7iq/nCOCRMkby3uVUQVITJ7zCdpYeP/r6X6o92aciYBzOClvnoNFuiwJm
	zDmy4WZ7nw9NSI/sx9m5TuAlvJJvVx7lcdKQ8XC8aVuLJyvhO/v7o8yOGaN5Mg==
Date: Tue, 10 Sep 2024 19:20:20 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>, Antoine Tenart
 <atenart@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Dan Carpenter
 <dan.carpenter@linaro.org>, Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v18 07/13] net: ethtool: Introduce a command to
 list PHYs on an interface
Message-ID: <20240910192020.5ab9cd16@fedora.home>
In-Reply-To: <CANn89iLQYsyADrdW04PpuxEdAEhBkVQm+uVV8=CDmX_Fswdvrw@mail.gmail.com>
References: <20240821151009.1681151-1-maxime.chevallier@bootlin.com>
	<20240821151009.1681151-8-maxime.chevallier@bootlin.com>
	<CANn89iLQYsyADrdW04PpuxEdAEhBkVQm+uVV8=CDmX_Fswdvrw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Eric,

On Tue, 10 Sep 2024 18:41:03 +0200
Eric Dumazet <edumazet@google.com> wrote:

> > +int ethnl_phy_doit(struct sk_buff *skb, struct genl_info *info)
> > +{
> > +       struct phy_req_info req_info = {};
> > +       struct nlattr **tb = info->attrs;
> > +       struct sk_buff *rskb;
> > +       void *reply_payload;
> > +       int reply_len;
> > +       int ret;
> > +
> > +       ret = ethnl_parse_header_dev_get(&req_info.base,
> > +                                        tb[ETHTOOL_A_PHY_HEADER],
> > +                                        genl_info_net(info), info->extack,
> > +                                        true);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       rtnl_lock();
> > +
> > +       ret = ethnl_phy_parse_request(&req_info.base, tb, info->extack);
> > +       if (ret < 0)
> > +               goto err_unlock_rtnl;
> > +
> > +       /* No PHY, return early */  
> 
> I got a syzbot report here.

I seem to have missed the report, sorry about that.

> 
> Should we fix this with :
> 
> diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
> index 560dd039c6625ac0925a0f28c14ce77cf768b6a5..4ef7c6e32d1087dc71acb467f9cd2ab8faf4dc39
> 100644
> --- a/net/ethtool/phy.c
> +++ b/net/ethtool/phy.c
> @@ -164,7 +164,7 @@ int ethnl_phy_doit(struct sk_buff *skb, struct
> genl_info *info)
>                 goto err_unlock_rtnl;
> 
>         /* No PHY, return early */
> -       if (!req_info.pdn->phy)
> +       if (!req_info.pdn)
>                 goto err_unlock_rtnl;
> 
>         ret = ethnl_phy_reply_size(&req_info.base, info->extack);
> 
> 

Indeed that's the correct fix. Should I send it ? ( including
suggested-by/reported-by )

Thanks,

Maxime

