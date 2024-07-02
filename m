Return-Path: <netdev+bounces-108374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598EA9239D5
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9092B1C22316
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88D415444E;
	Tue,  2 Jul 2024 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="P/9yp74U"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F6114039D;
	Tue,  2 Jul 2024 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719912274; cv=none; b=PqkjzmYN4TLq+s1Au2adTnux74qhkAdXP075DCEnLBIIAvjIf/w0O8YDLbp0FQtgDw4s1cExe1be0VtHN9XCy/CxOo9RcB2v2QH2xRWVb1N+OKag7Wz17YuFmvfQwMWarplh61fk82WKPtCW36UnjDIjL8cOZCfvfbSWGiyU1WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719912274; c=relaxed/simple;
	bh=W/ktJn8e7bfFOA1ysYs0qBqx0srBXnMv4xozdusU1tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pei2IrQWlE9Tpjc3iJTGTrOzjKkkk9UVMggf7D4/N/fZ6XWwhBzA9rlGtfGylFiiLiJ/p2gEerNQ7PLc2lW0Adys0xVzDyjDianXXOQzoBCoq65W1G6XJHScMgMZfz4sYtFtGlb3h86aakcFZeNX1oybyVVKvcefiZiSGoPN5oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=P/9yp74U; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wqt/0ARIKXvi4QP6QE0niQ5YasBWqRnDOAxUw7dP/9E=; b=P/9yp74U59ZXc+uDj4tV7AgCAr
	BSg1Ho5T3yRKpdnVHpxtP+eAVNPM5ad9Vp/UQjdrQyWXror58ptuNyksO0o5T3FiXK+Fy15x6+Y9I
	euHLvrrq/sGVMrO6LIfn6exx/kDg82Z/jMig+hsETjKaprAZVzFSZNrTqeeZj3G7TLXYWmpgzjTea
	ImCdbIEgpyqyrbXS/hTN732ZCoh5DRE2sq1XoY488OO2Pgj5eucExK9W/tyUhDmepGjJH2M9gwFB5
	ZycPRpDELb7yis/RgLAqDQbYIYFmm0WukCz+jL7fTQXzs8FLtjVYt4rZ5o9J3IBNu46d+4T4KtoiR
	9B9dw0CQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36046)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sOZkH-00036O-1d;
	Tue, 02 Jul 2024 10:24:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sOZkI-0001pb-RO; Tue, 02 Jul 2024 10:24:18 +0100
Date: Tue, 2 Jul 2024 10:24:18 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/6] net: phy: dp83869: Disable autonegotiation
 in RGMII/1000Base-X mode
Message-ID: <ZoPHQms2bDo5zWZm@shell.armlinux.org.uk>
References: <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
 <20240701-b4-dp83869-sfp-v1-1-a71d6d0ad5f8@bootlin.com>
 <a244ce05-28a1-47b7-9093-12899f2c447f@lunn.ch>
 <3818335.kQq0lBPeGt@fw-rgant>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3818335.kQq0lBPeGt@fw-rgant>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 02, 2024 at 10:44:12AM +0200, Romain Gantois wrote:
> To be clear, "fiber mode" in the DP83869 linguo also includes
> 1000Base-X which can be used with a direct-attach copper cable. From
> what I've seen, autonegotiation is not supported in this configuration.

Why? Direct-attached cables are 1000base-CX, which is defined by 802.3.
It uses the 1000base-X PCS which is shared with 1000base-SX, 1000base-LX
etc. If one looks at 37.1.3, Relationship to architectural layering,
or 36.1.5, Inter-sublayer interfaces, one can see in that diagram that
the PCS *including* auto-negotiation is included for SX, LX *and* CX.

Moreover, 39.3 states that TP1 and TP4 will be commin in many
implementations of LX, SX and CX.

Moreover, 39.1, 1000base-CX introduction, states that it incorporates
clause 36 and clause 38. Clause 36.2.2 states that the 1000base-X PCS
incorporates clause 37 auto-negotiation.

So, I think AN is supposed to be supported on CX in the same way that
it's supported for SX and LX.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

