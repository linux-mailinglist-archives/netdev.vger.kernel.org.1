Return-Path: <netdev+bounces-236685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E886C3EF12
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 09:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D8B188C34E
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 08:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C1B30F81B;
	Fri,  7 Nov 2025 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RxoLq0aG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D07F30F7FB
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504088; cv=none; b=Ilza/LVuBB+0i0ElHw+7fz+yC0Wo0kNQmtBRKYcavtYwH31miUrxj4KXHua0sNMXSlRQWXV7mghg8T/ZfJvyyqU7a3GInaDO1JlKa4JLkPspiJtGe2RVor4k41/bhCd6TGvC7aQtT/4lKpVsHaoM4TymqAPPKtVNX++/M2X3FGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504088; c=relaxed/simple;
	bh=5mnVfnY0AGY608Hotv1EJcHOjDEPcdnEzG8s3KXzc2U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hf91rcvXjtHNkksUE9JXDUN34fW6Wno06iCd3Gmj6MduKOGDRj0EY1aH6LIvP7o5IYQgn2xK0QQXWT7cmJBredb5f+LQoXN7/ON8jYb7luAykbSAtXih2X999DQdaBY9/m/FX8fcjFM0qFT/0gao5+ld5508Rz2e31vlDG6LVyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RxoLq0aG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qzpp8wSwYUgP9C3Q7z5OhTyRVCbxhzGffU2XwkPMaNw=; b=RxoLq0aGB2xpS1m8fA9PhMa5Sv
	HTTuaxXneVdb7GFdYuCmAZ9r4/2shFfT8jTzWlPQn+zDregrwGvChDawtORrxNc5prea+SbrbqPxf
	ZHlLoUNGIWv6Jfq7iTwjsvsaiMkM51T0OZRhfjQPHatsNBvU0NgF18gM0zM3x1/H1ZEp2IAQW5mXf
	eRQ0gg2fFJNdb1QNHw/EKKLByUYSCChK3UAqG0ecWHvt6ymhEAIqoz02s/yTC+GjHBWm67sL7yaTO
	buT3pgV+jgNOwTT+BTVjtotE2q5h2S6wc2g46Z0hd9AAvipITgCuQk3wTtJNhzVw/b9Fvo/BNViEY
	D3y8SW6Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36028)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vHHox-0000000068F-2Pqg;
	Fri, 07 Nov 2025 08:27:47 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vHHou-000000007RV-21ho;
	Fri, 07 Nov 2025 08:27:44 +0000
Date: Fri, 7 Nov 2025 08:27:44 +0000
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
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3 00/11] net: stmmac: ingenic: convert to
 set_phy_intf_sel()
Message-ID: <aQ2tgEu-dudzlZlg@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Convert ingenic to use the new ->set_phy_intf_sel() method that was
recently introduced in net-next.

This is the largest of the conversions, as there is scope for cleanups
along with the conversion.

v2: fix build warnings in patch 9 by rearranging the code
v3: fix smatch warning in patch 11, added Maxime's r-b.

 .../net/ethernet/stmicro/stmmac/dwmac-ingenic.c    | 165 ++++++---------------
 1 file changed, 45 insertions(+), 120 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

