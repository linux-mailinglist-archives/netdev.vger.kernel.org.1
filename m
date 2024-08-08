Return-Path: <netdev+bounces-116809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A0794BC6B
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE491F2129E
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74858189BBE;
	Thu,  8 Aug 2024 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uXUcC4CQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B087B12C7FD
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723117257; cv=none; b=VeampiDiWJ3HcUS6r2Iq1KAH/mQpOdOAJc2qvM4v3z3aeDMf7sPS6FGKQZLPl51Gj+u75WhNxGyG8fhmxX9lLQMw6E9KVY1zme6KvY1naiAhQ5+BVMy4AjA3yGbZttO8bSZCSREAOfiWZunWCPBLzzMGLoQORX6bQwrSKY1aSXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723117257; c=relaxed/simple;
	bh=22OLO19TW7AKaEhL6797VH5qoo+NYzBuxH6V5QtaxYE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NXtpW4BMHB0qxje612ztR4yiPXRRm09ID5RKj2G7sMnZaqbQq5YyxurGS9izkwzPN6g03vDchNP2sRgGkeqXPeiW/VLvzW5SdCROQMzy2NpIaT89bGdyG9rDj/FEcVJhrShAIoj7APplDDjwEzCwzONt2eJxoXevQR6jJTyRIbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uXUcC4CQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fzeC/wk5Tv7gI/RAoVXXCfxuUOD8OlFtjXY//ZIQsiY=; b=uXUcC4CQXPriIiCMI58/hlrlk4
	EwQCwYBiAy7+izWLKtiSc6sTVXG5fJVFKy0O1YLkd6I1KHC5B/8QvcFacpxVRPYDh0qAz2toKkqbC
	j7CYhwQa1KfjgGiSGL6Hzh2Ng20/GuAt+MUE76gaeeI9wYs719QvY4D6zZI1MQN6wzGFHYUVzEOGn
	MhA7/HodDSX3KhMySSLjbydmsOanBcfAYJFYdNVXF3iNeOv1cVx/BAlrh0kmfRULNtbPXroaBFhkG
	Oi2GVTpUgneW3wSdAUIf8wdGC0Gr00SmX5x6080VNebv6U45FSdxbC2mgYwHXV3n1dbwLkBN7RLP9
	r2opOBxA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35920)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sc1VR-0001Bl-2B;
	Thu, 08 Aug 2024 12:40:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sc1VU-0005BM-UI; Thu, 08 Aug 2024 12:40:36 +0100
Date: Thu, 8 Aug 2024 12:40:36 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 0/2] net: phylib: fix fixed-speed >= 1G
Message-ID: <ZrSutHAqb6uLfmHh@shell.armlinux.org.uk>
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

This is v2 of the patch (now patches) adding support for ethtool
!autoneg while respecting the requirements of IEEE 802.3.

v2 fixes the build errors in the previous patch by first constifying
the "advertisement" argument to the linkmode functions that only
read from this pointer. It also fixes the incorrectly named
linkmode_set function.

 drivers/net/phy/phy_device.c | 34 +++++++++++++++++++++++++---------
 include/linux/mii.h          |  7 ++++---
 2 files changed, 29 insertions(+), 12 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

