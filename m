Return-Path: <netdev+bounces-188501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 620FDAAD1BC
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 01:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA00F983422
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 23:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F1721D5B5;
	Tue,  6 May 2025 23:57:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B78218ACA;
	Tue,  6 May 2025 23:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746575824; cv=none; b=ixehY+ZazJOBhqQy0alXW++xu0l/0CuK+kNJG1J/c+TX3B+jRDbsh4KC4ZDqVy8TqtbT5zJ3EG+/CsN9jmeyTxdU/cnz7EGhAgSmk2gBG5fFM4fShfl9zsCyIHAbKRAElp2/vF9q/ci4B8vAZ0EG0v2+k8WtTupjMDW5oQhomfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746575824; c=relaxed/simple;
	bh=ykAHd5Is/09WaVAT2pFbXqZo5I4E9ja1ZRV8IBy1puE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krPcBv4LLs2WW95bIbejCfYxMp9P0OVmknY5a/Z0UIHdGTHmq3SMslYLV3DFzrhnu8qiNyaA6B2Co4U/sxk6qUPAngf5eWT98fbCP/ZEhJLt0BwKI9C2Sp+NzGCPWPv/lV6Ze0UGWFvOLGD7jrT7TfjAdbQw/8ZsEcpO2e/G1s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uCS3l-000000004RO-19ao;
	Tue, 06 May 2025 23:56:44 +0000
Date: Wed, 7 May 2025 00:56:38 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, upstream@airoha.com,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Joyce Ooi <joyce.ooi@intel.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	UNGLinuxDriver@microchip.com, Wei Fang <wei.fang@nxp.com>,
	imx@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next PATCH v3 05/11] net: pcs: lynx: Convert to an MDIO
 driver
Message-ID: <aBqhtl3m03J6pw3V@makrotopia.org>
References: <20250415193323.2794214-6-sean.anderson@linux.dev>
 <20250506215841.54rnxy3wqtlywxgb@skbuf>
 <20250415193323.2794214-1-sean.anderson@linux.dev>
 <20250415193323.2794214-1-sean.anderson@linux.dev>
 <20250415193323.2794214-6-sean.anderson@linux.dev>
 <20250415193323.2794214-6-sean.anderson@linux.dev>
 <20250506215841.54rnxy3wqtlywxgb@skbuf>
 <50e809ea-62a4-413d-af63-7900929c3247@linux.dev>
 <50e809ea-62a4-413d-af63-7900929c3247@linux.dev>
 <20250506221834.uw5ijjeyinehdm3x@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506221834.uw5ijjeyinehdm3x@skbuf>

On Wed, May 07, 2025 at 01:18:34AM +0300, Vladimir Oltean wrote:
> On Tue, May 06, 2025 at 06:03:35PM -0400, Sean Anderson wrote:
> > On 5/6/25 17:58, Vladimir Oltean wrote:
> > > Hello Sean,
> > > 
> > > On Tue, Apr 15, 2025 at 03:33:17PM -0400, Sean Anderson wrote:
> > >> diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
> > >> index 23b40e9eacbb..bacba1dd52e2 100644
> > >> --- a/drivers/net/pcs/pcs-lynx.c
> > >> +++ b/drivers/net/pcs/pcs-lynx.c
> > >> @@ -1,11 +1,15 @@
> > >> -// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> > >> -/* Copyright 2020 NXP
> > >> +// SPDX-License-Identifier: GPL-2.0+
> > >> +/* Copyright (C) 2022 Sean Anderson <seanga2@gmail.com>
> > >> + * Copyright 2020 NXP
> > >>   * Lynx PCS MDIO helpers
> > >>   */
> > >>  
> > >> -MODULE_DESCRIPTION("NXP Lynx PCS phylink library");
> > >> -MODULE_LICENSE("Dual BSD/GPL");
> > >> +MODULE_DESCRIPTION("NXP Lynx PCS phylink driver");
> > >> +MODULE_LICENSE("GPL");
> > > 
> > > What's the idea with the license change for this code?
> > 
> > I would like to license my contributions under the GPL in order to
> > ensure that they remain free software.
> > 
> > --Sean
> 
> But in the process, you are relicensing code which is not yours.
> Do you have agreement from the copyright owners of this file that the
> license can be changed?
> 

I think there is a misunderstanding here.

Of course the licence for the file remains dual BSD-3-Clause and GPL-2.0+ up
to the change Sean wants to contribute. However, as he only permits GPL-2.0+
the file after applying the change would then only be covered by GPL-2.0+ and
no longer by BSD-3-Clause. Legally speaking there is no need to ask any of the
previous authors for permission because they already agreed on having the
code under GPL-2.0+ **OR** BSD-3-Clause, which means that everyone is free
to distribute it under GPL-2.0+ (which is already the case when distributing
it along with the Linux Kernel, obviously). Only netdev maintainers need to
agree to drop the BSD-3-Clause licence **from future versions including his
changes**, and there are obviously reasons for and against that.

