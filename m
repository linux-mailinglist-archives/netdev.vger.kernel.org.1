Return-Path: <netdev+bounces-137850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31C29AA13E
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48470B22BDF
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E155F19AD94;
	Tue, 22 Oct 2024 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RPGbRHqq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71BF19AD73
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729597156; cv=none; b=rIsoSClthMfeHlI52M/QIf/MrWAwa0SLQKTMek1+OIKP+EpizXLhSXvd4GsqolOLbPQkB6o3ENwuJ+eRv+5lFY+EycXo5GqBYeNzhj6AkQ3nJ9qMnIsUObDo0gVpBnuSXhA26lP/SF57srzA8o6EFwv0RB7hI0Uc1oETR84O0Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729597156; c=relaxed/simple;
	bh=sifbPP0ixfPNct94r9HV0gUAfM2GV+sT47ZT+zmmYlc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hkZz73g4StYzYCDHuB295DXk0QF/+D0xSStL/0p4EltZNbC16b7eiTFl9wOUBVmjDRXy9akwZExpJjfSo2QdxlWkxr2l+JtXz+KM/QJrlnSnEx147riQpuWBhLDntmamb1B6aG7WpLkHszj8P9RdymHrvwWwKriXgWIh7eVIAhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RPGbRHqq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zIvAu+n/7zpZXsFcIkznw6aCZvFYjHfM2OHjku5PixU=; b=RPGbRHqqtxC3HyKn0MEk5BfLv2
	4M2vFauWxPNAfkeLO806jrsRIoJUKbll7GercKnUSfv2mWgiR3KvaBmxZlua8Mej3DB11TluwJBJg
	LvaHr4S0tkHiuMKjbTCvJH10wFmeqWY5I64kyGgfcDAsomvBE0pv1z6otjxgoFgg5NBQXI7Q4Dt65
	a8H2uHeFY2hMg2NAPh+hH/gXxTO7HlSLFTNMXUDmmRGwonGnHP4xgk3g5bUyFRejQTS7w6gaW7Xsk
	cBDbWgC4vYkJwm2OpZEaz69bagcdARYjOTy0n3soVSp0M5o1VYO4XOGNU6fQndXUvqyCuzzXOstpT
	8aPZi4GQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37548)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t3DED-0004n2-00;
	Tue, 22 Oct 2024 12:39:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t3DEA-0002fr-2Z;
	Tue, 22 Oct 2024 12:39:06 +0100
Date: Tue, 22 Oct 2024 12:39:06 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/3] net: phylink: simplify SFP PHY attachment
Message-ID: <ZxeO2oJeQcH5H55X@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

These two patches simplify how we attach SFP PHYs.

The first patch notices that at the two sites where we call
sfp_select_interface(), if that fails, we always print the same error.
Move this into its own function.

The second patch adds an additional level of validation, checking that
the returned interface is one that is supported by the MAC/PCS.

The last patch simplifies how SFP PHYs are attached, reducing the
number of times that we do validation in this path.

 drivers/net/phy/phylink.c | 82 ++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 40 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

