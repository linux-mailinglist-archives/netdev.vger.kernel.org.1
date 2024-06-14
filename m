Return-Path: <netdev+bounces-103440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A094908093
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 03:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3071C211B6
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 01:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A37181D0C;
	Fri, 14 Jun 2024 01:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1Ta7p4A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5FC181D00;
	Fri, 14 Jun 2024 01:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718327895; cv=none; b=fJ6rPUGAhb3WlTgDuGzSNDvaF/J0V2/HIuxDg7utznFwkzc8t2s9wFbFyQWPnWVGtQT72m1mr/ze9iYZxfdgF5+XcaJrydB4aOK/zpvlOzVfwJhiUa3vW1ADH4XdwCKu+UFrMPp9IfEtpUpUZ6uGh0myQzfSzsupx39HOx7C5ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718327895; c=relaxed/simple;
	bh=mgyOAziEuF5dLoY3SVasa/F54zKNQeGUaNP4KbuGUY4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YH4zhsc7IVanyakwPm6/xN8ddwg0jTbmVVPkVWPyHO+O/ZI8YrR7lUPOFljQRNT359gwoT4fgcwZ+DvYowOUJ5MtrgQje9IiXlRWbIGokRGaRdzxISB9uZvehl8oYAO+tHmYTUD5KKHreSKMCsSn0YrFWilKvEjYZf+VRfooTxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1Ta7p4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE72C2BBFC;
	Fri, 14 Jun 2024 01:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718327894;
	bh=mgyOAziEuF5dLoY3SVasa/F54zKNQeGUaNP4KbuGUY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s1Ta7p4A4luCkj5qnPlasVhv+/Gg3eidQjjiELWr1vIgCQ2GEElJxlBsKXYji0rd+
	 FMhle+qqBxCo39gDdg/MJFSfnJ9VQD8iKv+c3kY2RmnPkKQiWx3Ru53tK9wqybpFhi
	 9eu0cbPkTzJdmR/+WEideu4BWXkzz5gN0YPW2a6Zw3jsvHvZbtr87eQ+TeOeymWbQm
	 G38vGvjT9CXKcocFRUxbPl1t4xIwxHbQ7zatTnYYw1lbbE8eTOdDNb+JUFA2tfvje2
	 yUsyedtNqFR214FM/UlEK+r5w6yVVFmxkxwNI2DtI/2TqfbxAJEwVlfaOuoilI+rIT
	 JEmJsRXCyTgxw==
Date: Thu, 13 Jun 2024 18:18:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
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
 <atenart@kernel.org>
Subject: Re: [PATCH net-next v13 07/13] net: ethtool: Introduce a command to
 list PHYs on an interface
Message-ID: <20240613181812.27d02c88@kernel.org>
In-Reply-To: <20240607071836.911403-8-maxime.chevallier@bootlin.com>
References: <20240607071836.911403-1-maxime.chevallier@bootlin.com>
	<20240607071836.911403-8-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri,  7 Jun 2024 09:18:20 +0200 Maxime Chevallier wrote:
> +                                                it's parent PHY through =
an SFP

its

> +static int ethnl_phy_parse_request(struct ethnl_req_info *req_base,
> +				   struct nlattr **tb)
> +{
> +	struct phy_link_topology *topo =3D req_base->dev->link_topo;
> +	struct phy_req_info *req_info =3D PHY_REQINFO(req_base);
> +	struct phy_device_node *pdn;
> +
> +	if (!req_base->phydev)
> +		return 0;
> +
> +	if (!topo)
> +		return 0;
> +
> +	pdn =3D xa_load(&topo->phys, req_base->phydev->phyindex);
> +	memcpy(&req_info->pdn, pdn, sizeof(*pdn));

> +	xa_for_each_start(&dev->link_topo->phys, ctx->phy_index, pdn, ctx->phy_=
index) {
> +		ehdr =3D ethnl_dump_put(skb, cb, ETHTOOL_MSG_PHY_GET_REPLY);
> +		if (!ehdr) {
> +			ret =3D -EMSGSIZE;
> +			break;
> +		}
> +
> +		ret =3D ethnl_fill_reply_header(skb, dev, ETHTOOL_A_PHY_HEADER);
> +		if (ret < 0) {
> +			genlmsg_cancel(skb, ehdr);
> +			break;
> +		}
> +
> +		memcpy(&pri->pdn, pdn, sizeof(*pdn));

Why do you copy the pdn each time =F0=9F=A4=94=EF=B8=8F

> +	return ret;
> +}
> +

double new line at the end

