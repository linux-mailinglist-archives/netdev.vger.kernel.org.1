Return-Path: <netdev+bounces-96488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9577F8C629E
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 10:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 317EDB211CC
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 08:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610184C61C;
	Wed, 15 May 2024 08:16:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout37.expurgate.net (mxout37.expurgate.net [91.198.224.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B49C38394;
	Wed, 15 May 2024 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715761005; cv=none; b=Pag61lRWsOL36Syds1O3urp8jaZhZ9ly7HfJrbaVHcZOsfmTtEBAi2S4J57plg0hzK2dsduoB/ezIeHMEkGrCFBVfGYPXGc+Wj/YkJOb9Yis3EPS1pwgbLFRrhtwwFJVfJyqosEuIz2L6KpRrUtBVRqd1ZK1ahAYGqhhKHP3n78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715761005; c=relaxed/simple;
	bh=0CMSPU5h0J/+LSIFiRA0tPZIyssveOFv2H3maVZ1/UE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nkDJ/R4gsoeCHlMK9NBpszOu67lmjgRA6eg2QeHxNxaNry/ZnarzKFHtffEaWJnQMJc2GL3SylY89Pi8lbXJ7mCJhboiPS+CiCTWa1XjEeR0esJCuP5YhRY2vbUJ1j1gZ+eIWQSb3LCCOt4lm4vfHDoKKT5hi1d5FDLrbYad4rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brueckmann-gmbh.de; spf=pass smtp.mailfrom=brueckmann-gmbh.de; arc=none smtp.client-ip=91.198.224.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brueckmann-gmbh.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brueckmann-gmbh.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <gessler_t@brueckmann-gmbh.de>)
	id 1s79oI-00GvF1-Jj; Wed, 15 May 2024 10:16:26 +0200
Received: from [217.239.223.202] (helo=zimbra.brueckmann-gmbh.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <gessler_t@brueckmann-gmbh.de>)
	id 1s79oH-00FeBY-7h; Wed, 15 May 2024 10:16:25 +0200
Received: from zimbra.brueckmann-gmbh.de (localhost [127.0.0.1])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTPS id 16524CA6082;
	Wed, 15 May 2024 10:16:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTP id 073C6CA6122;
	Wed, 15 May 2024 10:16:24 +0200 (CEST)
Received: from zimbra.brueckmann-gmbh.de ([127.0.0.1])
 by localhost (zimbra.brueckmann-gmbh.de [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Tando0cXENj8; Wed, 15 May 2024 10:16:24 +0200 (CEST)
Received: from [10.0.11.14] (unknown [10.0.11.14])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTPSA id DE4B5CA6082;
	Wed, 15 May 2024 10:16:23 +0200 (CEST)
Date: Wed, 15 May 2024 10:15:33 +0200 (CEST)
From: =?ISO-8859-15?Q?Thomas_Ge=DFler?= <gessler_t@brueckmann-gmbh.de>
To: Andrew Lunn <andrew@lunn.ch>
cc: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>, 
    Heiner Kallweit <hkallweit1@gmail.com>, 
    Russell King <linux@armlinux.org.uk>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org, MD Danish Anwar <danishanwar@ti.com>, 
    Ravi Gunasekaran <r-gunasekaran@ti.com>
Subject: Re: [PATCH 2/2] net: phy: dp83869: Fix RGMII-SGMII and 1000BASE-X
In-Reply-To: <38bc6947-391b-478d-ab71-6cc8d9428275@lunn.ch>
Message-ID: <338669-229a-5eac-3170-3477e5ae840@brueckmann-gmbh.de>
References: <20240514122728.1490156-1-thomas.gessler@brueckmann-gmbh.de> <20240514122728.1490156-2-thomas.gessler@brueckmann-gmbh.de> <38bc6947-391b-478d-ab71-6cc8d9428275@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1715760986-FD9A0776-272ED94F/0/0

On Tue, 14 May 2024, Andrew Lunn wrote:
> On Tue, May 14, 2024 at 02:27:28PM +0200, Thomas Gessler wrote:
> > The RGMII-to-SGMII mode is special, because the chip does not really act
> > as a PHY in this mode but rather as a bridge.
> 
> It is known as a media converter. You see them used between an RGMII
> port and an SFP cage. Is that your use case?

Basically. I would call this an RGMII-SGMII bridge. A "media converter" I
would call a device that changes the physical medium, like 1000BASE-T
copper/RJ45 to 1000BASE-X fiber/SFP.

We have this chip on a daughter card with exposed SGMII lines that can be
plugged into customer-specific motherboards. The motherboard will have
either an SGMII-copper PHY (this can also be a DP83869) with 10/100/1000
auto-neg enabled but without MDIO exposed to the CPU on the daughter card;
or an SFP cage. The SFP module, in turn, can be for 1000BASE-X fiber,
1000BASE-X-to-1000-BASE-T copper, or SGMII copper supporting 10/100/1000
auto-neg.

So I would like to support all those configurations, which can be done
with this chip.

> > SGMII PHY and gets the negotiated speed and duplex from it through SGMII
> > auto-negotiation. To use the DP83869 as a virtual PHY, we assume that
> > the connected SGMII PHY supports 10/100/1000M half/full duplex and
> > therefore support and always advertise those settings.
> 
> Not all copper SFP modules support auto-neg. This is all really messy
> because there is no standardisation. Also 1000BaseT_Half is often not
> supported.

I agree. Is there a better way to implement this use case? The problem
remains that in this mode the chip is not really a PHY, but rather a
bridge to an external PHY. See also Russell's e-mail.

I actually started out by NOT supporting or advertising any of the
10/100/1000BASE-T speeds when in RGMII-to-SGMII mode. This also works for
the SGMII auto-negotiation, since all it does is get the negotiated
speed/duplex from the connected PHY. However, this leads to a problem when
trying to disable auto-neg and force speed with ethtool.
phy_sanitize_settings() will then limit the speed to 10M because 100M and
1000M do not match any supported speeds.

Thomas

