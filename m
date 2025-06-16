Return-Path: <netdev+bounces-198265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2DAADBBAD
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7BC3B4740
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 21:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92DA21171B;
	Mon, 16 Jun 2025 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sseSvX+k"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666381F429C
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 21:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750107961; cv=none; b=d6AyGt8t9nHBrt2Qhd9qv2PSzBM2Ll2e7ELyYprfua+NOiPTP1Obu9zvtxlMLsTdCLe6Zuedepx2zqZ9vmK6zWsDXjzoIZmP+eiQDwb73ODA5FRH7kN9WlseI7z+69AKeob5Mb2liwZSWan/9sF0I57LbI6TS9TPvmFzk6REEYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750107961; c=relaxed/simple;
	bh=xCOlAB7koITZwDw3jajegfK9amftWjCyftT3QFt857s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WOw8tTi1v7C2Rt9JnmlYKghFjsm6UYqaAYQ+vqaPeJgIxAsV+vp8mtUCX50TFsa7LBqXeB1A/QvKRb4XQ7dIAqxs1bcFdye1pgDCNHH+zMttVBFoo4uzOCzWcQQitWRas56mgmJabQXdAjmGozjzshxv7EfA6oSnjKqmQBiqcos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sseSvX+k; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EFMIuX82Zyu0j5AT6fptyrLq5xQV9BOFFIAyu6ii4C4=; b=sseSvX+kEeHUp6/ITIrfE5ZP1r
	xRxBO+p5YGkgGEoF+uthmOEm0FtwC0Qa79a49S3aAlL/p8iQJeWTrXQV6fVzP1ERp+P6igak/VBa4
	vaefgvtD9lAir9Av0CYtvhHmvKGLqaT6uf5XMmW8zLG5PxWbxfI9sLyU1zQK1/INrRTKKUmiu5cgH
	4vJ7KCyWU7NIK8lisM1hjtjgk0hBFHiU6ybT02EuzRE1jaPlU1WqilSzoDUpuQ5+Txhyjis/YPeUJ
	D3XfDwkPgNYR2dn6f+BLbGbcJvIdftTdbuluER8rqxB0knpmk/XCt3ZlvVkiDk8eMCXMcP4GEgKMv
	PBggaxNg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45550)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uRH1W-0004GN-1h;
	Mon, 16 Jun 2025 22:05:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uRH1R-00058Y-1g;
	Mon, 16 Jun 2025 22:05:41 +0100
Date: Mon, 16 Jun 2025 22:05:41 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/4] nte: stmmac: visconti: cleanups
Message-ID: <aFCHJWXSLbUoogi6@shell.armlinux.org.uk>
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

A short series of cleanups to the visconti dwmac glue.

 .../net/ethernet/stmicro/stmmac/dwmac-visconti.c   | 129 ++++++++++++---------
 1 file changed, 74 insertions(+), 55 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

