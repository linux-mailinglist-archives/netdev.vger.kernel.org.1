Return-Path: <netdev+bounces-218567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76476B3D4A0
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 19:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2534B3BABF3
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 17:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5073E270EA3;
	Sun, 31 Aug 2025 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1mwtRX0L"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EE2170A37
	for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756661668; cv=none; b=r2Cl7J0v1HECfujpUP+K9iwh44dsDFQO9xu1YUWI7uokCb4MNhX9FZtim782RGUTMc/E/P+xN3uhYiT1FQzVWj0Fcmffvr0cCV2/Voe6+0ZmH5qI0H2kzNcVWYehak560n0wyn/7LXyXE34UaUZDiWEdEly3GJmd1rkquywgRSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756661668; c=relaxed/simple;
	bh=gGKeiX4WYRwdXNf11wmkcCRGuw/LsXagtSIMw7ZWbpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TcLBQx9XNOR/EHsT8vusEnFsE8dRkA8JB2yUgk0cjdVN4XB9phfX7H48EiksDROZqCZ27ZYY7EwZ/qakTv6+OH1ALNN7BtjJrlHfRrsjnakDg8VWO2+LKTV3KiyinosN9q/SFfYNYk4tTTvlNNN/LKWaR0lFr+u7WMEfcuq3HA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1mwtRX0L; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g8T1693/WfDP6Ji7iG6OVLO+v/vDk8KZP5eOic0WNpU=; b=1mwtRX0L2LbiZ8U0sv9rbymVW8
	2fcQqzmWekn5HSJs0OZyY9cp08FFvyFR667ozS7X/8M6io2xN1kHEVeXvEM+eekO+ftMM+yqyKY2J
	Jhq7/IBnfkjSZpnIezy1+qDxMGGSeGDtJEQ0vKh7BV/OntivzwCr80lmkvP81nfu8S6dL4AKrmQ87
	iBzj30GszdNFk4FdN3ghqQ2iw9/1R649GRhToc1lDqAlMoO7Fru4ThUZj+DdA98pJ4TGk8O3JRG8a
	TcVGgF9oMv//KE1+sJgPx3wLdCIdA5k0shWFPVKLsIpssAqha+7w9ffQ/4PK+k2h69RTVecFnXywU
	Ql8htcag==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55220)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uslwa-0000000057p-11Kj;
	Sun, 31 Aug 2025 18:34:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uslwX-000000006E1-2Jvg;
	Sun, 31 Aug 2025 18:34:17 +0100
Date: Sun, 31 Aug 2025 18:34:17 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Mathew McBride <matt@traverse.com.au>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 0/3] net: fix optical SFP failures
Message-ID: <aLSHmddAqiCISeK3@shell.armlinux.org.uk>
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

A regression was reported back in April concerning pcs-lynx and 10G
optical SFPs. This patch series addresses that regression, and likely
similar unreported regressions.

These patches:
- Add phy_interface_weight() which will be used in the solution.
- Split out the code that determines the inband "type" for an
  interface mode.
- Clear the Autoneg bit in the advertising mask, or the Autoneg bit
  in the support mask and the entire advertising mask if the selected
  interface mode has no inband capabilties.

Tested with the mvpp2 patch posted earlier today.

 drivers/net/phy/phylink.c | 97 ++++++++++++++++++++++++++++++-----------------
 include/linux/phy.h       |  5 +++
 2 files changed, 67 insertions(+), 35 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

