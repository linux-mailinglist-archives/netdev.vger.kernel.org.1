Return-Path: <netdev+bounces-96274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C44828C4C6E
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 08:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CBE91F21835
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 06:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0EADDB8;
	Tue, 14 May 2024 06:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZJVVBplm"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5944BA42;
	Tue, 14 May 2024 06:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715669184; cv=none; b=GJYZF0k6EG3DX56gPvtmU+OM0NqUjgv7Ekk/Kaem2y1IiuXNTpjWaixNk80lD/vpql5bqbAclSQvbuO/sNg0x/RXTcnXe9D7YbdN90oR07I6EM3EpNS0IjufnvjG/8qsoANpZGL7NYBwanx009IL5wsPPmULq2ly9zfb3HACH4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715669184; c=relaxed/simple;
	bh=a6DB1WcNs+wkC8Nd15u74tUpw7IM923v5EY2W4mxMq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RHe1t3xq2j5iS8sON+wYIT1LeqodbCoGoaCmimd2B8NwHyrYxOnjrA0VAM6tkmAcTqkPC0YIIMxw12mKpC88B6AY54aYBvL4Jb0HVzOUp8xBATODwvYRL7mug6BHOtftd/q6uA2Er/mUWgB7XQ8r6YhzTyX0ZliqMF1+gVgfWJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZJVVBplm; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AD58EFF808;
	Tue, 14 May 2024 06:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715669178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KCIrRriEzgk/G7WM/sS3L+fxbWtFNIOHOsZ1sDN8iUw=;
	b=ZJVVBplmWrmGcwSr5bCK8FekXBM8wIgMszHR6IDo2Z01gVTViowSMZmJAAE8YLNimRHUYF
	tHWjNA5JrSOgDm52+eUbFb8aS4ZlQb9yiEfCG72dF12+DgimIo3dxGTicOfrYU1gLD0YRE
	7vGn5G/TRMYHMlg4SptNG9CDHf3U84RD/RYrzcwqZmyP8at26cPvSWbxciJdbEkwXjh5HI
	D+U0NWH5bwj80nJ/CPw1Hum3nR9MG+UFXPCA1UanUr1ljgxK2NeckttU/9WD2G8Y6uwQT/
	KF/ISjU+jZ3DWpW88oClpuvkHOyb+szNkiwZfdmcLdUTX+dPxvW8HA4ArVERWg==
Date: Tue, 14 May 2024 08:46:14 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Nathan Chancellor
 <nathan@kernel.org>, davem@davemloft.net, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, linux-arm-kernel@lists.infradead.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next 0/2] Fix phy_link_topology initialization
Message-ID: <20240514084614.1f00e2ed@device-28.home>
In-Reply-To: <20240513081138.7e7eb3d0@kernel.org>
References: <20240507102822.2023826-1-maxime.chevallier@bootlin.com>
	<20240513063636.GA652533@thelio-3990X>
	<ZkHaRD8WGrhrzemn@shell.armlinux.org.uk>
	<20240513081138.7e7eb3d0@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Jakub,

On Mon, 13 May 2024 08:11:38 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 13 May 2024 10:15:48 +0100 Russell King (Oracle) wrote:
> > ... and Maxime has been working on trying to get an acceptable fix for
> > it over that time, with to-and-fro discussions. Maxime still hasn't got
> > an ack from Heiner for the fixes, and changes are still being
> > requested.
> > 
> > I think, sadly, the only way forward at this point would be to revert
> > the original commit. I've just tried reverting 6916e461e793 in my
> > net-next tree and it's possible, although a little noisy:
> > 
> > $ git revert 6916e461e793
> > Performing inexact rename detection: 100% (8904/8904), done.
> > Auto-merging net/core/dev.c
> > Auto-merging include/uapi/linux/ethtool.h
> > Removing include/linux/phy_link_topology_core.h
> > Removing include/linux/phy_link_topology.h
> > Auto-merging include/linux/phy.h
> > Auto-merging include/linux/netdevice.h
> > Removing drivers/net/phy/phy_link_topology.c
> > Auto-merging drivers/net/phy/phy_device.c
> > Auto-merging MAINTAINERS
> > hint: Waiting for your editor to close the file...
> > 
> > I haven't checked whether that ends up with something that's buildable.
> > 
> > Any views Jakub/Dave/Paolo?  
> 
> I think you're right. The series got half-merged, we shouldn't push it
> into a release in this state. We should revert all of it, I reckon?
> 
> 6916e461e793 ("net: phy: Introduce ethernet link topology representation")
> 0ec5ed6c130e ("net: sfp: pass the phy_device when disconnecting an sfp module's PHY")
> e75e4e074c44 ("net: phy: add helpers to handle sfp phy connect/disconnect")
> fdd353965b52 ("net: sfp: Add helper to return the SFP bus name")
> 841942bc6212 ("net: ethtool: Allow passing a phy index for some commands")
> 
> Does anyone feel strongly that we should try to patch it up instead?

It's OK for me, at least this showed some of the shortcomings with the
current code, let's come back with a better version for the next round.

Thanks,

Maxime

