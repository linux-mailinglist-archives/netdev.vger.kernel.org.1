Return-Path: <netdev+bounces-211448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D17B18AD1
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 07:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4651E5659CE
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 05:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003471DF751;
	Sat,  2 Aug 2025 05:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ok28SDrJ"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD70E1CAA7D;
	Sat,  2 Aug 2025 05:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754113505; cv=none; b=kagJMkeQZau/ggaD+EuK63Tvy1plg52P18uppyTKNsrAfwsKo9te1Weq3/bhEJ4+W3Wr7UAu7UVZ13AqPCy37wR63Dg1tbZqcsWDqcQk+zrA50KhMLjTQ3icJ8chFoPyjCs03j3O7LJuUvwbWqTb9p1dJnPda0faKEWwonxQeVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754113505; c=relaxed/simple;
	bh=gQzI2gwKNmv9R97Gt9Jlthq8kskAwUNfnmi4KeSKs1g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F66bH1I+C8/edrHI0sjNfVCx+KFnMVAOjf+YY+M7yI+a6iJk3K7L+WKIqMLMHZmY3G0LjmC5qNNMF93v/kk3MX0fQlFKWAb5sjCOMX0/g6+ncVikXKrA/MMxuS3j/C9/KOr/iEPZ5kN28c/clDzzAE6fecAvq5j5bdZdUQXozfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ok28SDrJ; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5725iQYO3876820;
	Sat, 2 Aug 2025 00:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754113466;
	bh=eO+pNC2Kq3EhIuBpo+lO/zj40iLRQifl41nP1SpBuaM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=ok28SDrJe+vmG2O1YnTK/lD2ZDWMkvePlEA8ubal2tRQxdrOynzzkFKU62Y66zQsp
	 OrNnubIN6f2BrKZYknXXrHfy274KBFvybrhvsjavpyQu/FfhB1wKhb5xVbJcTbwHGx
	 jrpiIoEwtMLUcb1+9S9HjLDyN9wwECH6XMtBPCw8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5725iQkm1067612
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sat, 2 Aug 2025 00:44:26 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 2
 Aug 2025 00:44:25 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sat, 2 Aug 2025 00:44:25 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5725iOOf1162612;
	Sat, 2 Aug 2025 00:44:24 -0500
Date: Sat, 2 Aug 2025 11:14:23 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Michael Walle
	<mwalle@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Roger Quadros <rogerq@kernel.org>,
        Simon Horman
	<horms@kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Maxime
 Chevallier <maxime.chevallier@bootlin.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@ew.tq-group.com>
Subject: Re: [PATCH net-next] Revert "net: ethernet: ti: am65-cpsw: fixup PHY
 mode for fixed RGMII TX delay"
Message-ID: <47b0406f-7980-422e-b63b-cc0f37d86b18@ti.com>
References: <20250728064938.275304-1-mwalle@kernel.org>
 <57823bd1-265c-4d01-92d9-9019a2635301@lunn.ch>
 <DBOD5ICCVSL1.23R4QZPSFPVSM@kernel.org>
 <d9b845498712e2372967e40e9e7b49ddb1f864c1.camel@ew.tq-group.com>
 <DBOEPHG2V5WY.Q47MW1V5ZJZE@kernel.org>
 <2269f445fb233a55e63460351ab983cf3a6a2ed6.camel@ew.tq-group.com>
 <88972e3aa99d7b9f4dd1967fbb445892829a9b47.camel@ew.tq-group.com>
 <84588371-ddae-453e-8de9-2527c5e15740@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <84588371-ddae-453e-8de9-2527c5e15740@lunn.ch>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Wed, Jul 30, 2025 at 04:27:52PM +0200, Andrew Lunn wrote:
> > I can confirm that the undocumented/reserved bit switches the MAC-side TX delay
> > on and off on the J722S/AM67A.
> 
> Thanks.
> 
> > I have not checked if there is anything wrong with the undelayed
> > mode that might explain why TI doesn't want to support it, but
> > traffic appears to flow through the interface without issue if I
> > disable the MAC-side and enable the PHY-side delay.
> 
> I cannot say this is true for TI, but i've often had vendors say that
> they want the MAC to do the delay so you can use a PHY which does not
> implement delays. However, every single RGMII PHY driver in Linux
> supports all four RGMII modes. So it is a bit of a pointless argument.
> 
> And MAC vendors want to make full use of the hardware they have, so
> naturally want to do the delay in the MAC because they can.
> 
> TI is a bit unusual in this, in that they force the delay on. So that
> adds a little bit of weight towards maybe there being a design issue
> with it turned off.

Based on internal discussions with the SoC and Documentation teams,
disabling TX delay in the MAC (CPSW) is not officially supported by
TI. The RGMII switching characteristics have been validated only with
the TX delay enabled - users are therefore expected not to disable it.
Disabling the TX delay may or may not result in an operational system.
This holds true for all SoCs with various CPSW instances that are
programmed by the am65-cpsw-nuss.c driver along with the phy-gmii-sel.c
driver.

In addition to the above, I would like to point out the source of
confusion. When the am65-cpsw-nuss.c driver was written(2020), the
documentation indicated that the internal delay could be disabled.
Later on, the documentation was updated to indicate that internal
delay cannot (should not) be disabled by marking the feature reserved.
This was done to be consistent with the hardware validation performed.
As a result, older documentation contains references to the possibility
of disabling the internal delay whereas newer documentation doesn't.

Regards,
Siddharth.

