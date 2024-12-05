Return-Path: <netdev+bounces-149333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D9E9E52AB
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1334C281229
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CC31DC05F;
	Thu,  5 Dec 2024 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qg0PuLbU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09F61D4600
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395312; cv=none; b=ZUZhAcrP1i0r+WF+JJLWCtDLFIVsL0EiVlZM4DETxWpNHLJhGSszhnkfoK/HoNlryPVAoi3eJ0ag3z4ov0i7tH+nZN7PCWA3gQQb59UZa3RTed+G1RFzoavg1Zh8vROdYtcostm3ngWC8C1M9uMl5y6itkLIkOzF31jmb9pfZSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395312; c=relaxed/simple;
	bh=CD23YOnW6PzejW2qo2fwFTZSS1XjZfF9wBMKgpqb1aU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uhkCkxw84h42WIj4ic97lBQ2P/RxWNMJpB3UXPa59mzWIcRJ39rBz+j4NOzyLEKsGAJ0pq8ZWqqTbz+wGApAOavhPg4Xzz63E1nw7qKbqwFqYXaEBTQMruOXOpDNUBCf5hrlc6RJchb0WNIId09qepGVJplh1KW3MO/RVZG+1M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qg0PuLbU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RyES79fS8WpEtqkC/+FprrNNAiwJuH1cZHlQFZ6IDew=; b=qg0PuLbUZzPn8JJUMOxuNz5xr+
	QSQm85RWU1sEMCVLMUrVaYOjwLAQpZe2FWuziqo55lNpDZ72Ey1/DqgsSngrq1MtTX0rRmlL7C+4X
	nioDSHDd5Fw1uZq3Fr+LaG4FincbV3xe+BkWEUKAS7VQw4SSbu4wpAKMP1/jzEoih9AfCTJVQkZ1U
	M2GJXCJ8F09JEB53l9O1uehS9oKge05NsyTmWiCtfgzlwPvc2OUU7VD2asew5Y6WXEETOULnlF/cG
	mYyMtF/76R462/iFPUxML1oAunrS39z6U5JUlSWyeBFfv3VQuBKOn/tiQEOR99e1zbzlsvsk/OSfS
	MPfyU/jQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34364)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tJ9Im-0004ZG-1C;
	Thu, 05 Dec 2024 10:41:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tJ9Ik-0006Ta-2l;
	Thu, 05 Dec 2024 10:41:42 +0000
Date: Thu, 5 Dec 2024 10:41:42 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/4] net: phylib EEE cleanups
Message-ID: <Z1GDZlFyF2fsFa3S@shell.armlinux.org.uk>
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

Clean up phylib's EEE support. Patches previously posted as RFC as part
of the phylink EEE series.

Patch 1 changes the Marvell driver to use the state we store in
struct phy_device, rather than manually calling
phydev->eee_cfg.eee_enabled.

Patch 2 avoids genphy_c45_ethtool_get_eee() setting ->eee_enabled, as
we copy that from phydev->eee_cfg.eee_enabled later, and after patch 3
mo one uses this after calling genphy_c45_ethtool_get_eee(). In fact,
the only caller of this function now is phy_ethtool_get_eee().

As all callers to genphy_c45_eee_is_active() now pass NULL as its
is_enabled flag, this is no longer useful. Remove the argument in
patch 3.

Patch 4 updates the phylib documentation to make it absolutely clear
that phy_ethtool_get_eee() now fills in all members of struct
ethtool_keee, which is why we now have so many buggy network drivers.

 drivers/net/phy/marvell.c |  4 +---
 drivers/net/phy/phy-c45.c | 14 ++++----------
 drivers/net/phy/phy.c     |  9 ++++-----
 include/linux/phy.h       |  2 +-

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

