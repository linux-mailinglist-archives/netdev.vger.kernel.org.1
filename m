Return-Path: <netdev+bounces-235797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F2DC35D27
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 14:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C13118C0D0B
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 13:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A69309DDD;
	Wed,  5 Nov 2025 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="U/LuntPC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62DC2E88B3
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349179; cv=none; b=ESTTZjkwQnbMgCoG7qCnz7hAN6ioAktMiQ5GGBw+NfhtcglfFt7NDSwyuOQakAxsehcsjpETDLKj3JzQYXFwz8+Mw0CWzkF5+tyeZz54wbQ4E7mRb1QJmrAGTcvAOKk9D1SatMrMBwBvvSMGBWDyR4/Nb2vc8PgGgxCKDvimyv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349179; c=relaxed/simple;
	bh=eLu29QHmf7g9WkL/kOOKfB5yFoaidXkBjqk9edcRQE8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aZCJUWYL0JqIhdoju+EEFYDHMJrntb0QA/Hm8k+o3Fl5N8i0ejzRgfTc6o7lOqnEysQux8fjxJx4OaqgmCR1TWaTqRFNvGTMmsTm35mLFO/GCCOevrg57I1f5OdNKmmcyV5LZoaQCVSX1cbkL0GrDb7AlUgyfaQg12aqvQplqIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=U/LuntPC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=E0ixb7GMsnOWkEi1aAM8HlFRsmoAcl10ETJQIWoehyM=; b=U/LuntPCDlWzd/OP1uqIoyWv3h
	zP6dvfRZXh+1LP0a1VgY/FrNJhUTCE7T7trEQfyp+VBY1VIRsvVTjKA1od+cSRwZ+t8OJd8zwqo52
	DIAGLnLCrCO5a8rSjRqs7M7c9F7WDbaFmLKJKOqqt75srKcvOzjdQGVeu7IZdn6NKc89M2RQFCbmi
	pCBwqoUF4r9mXWntFNN/tx894hbu9BsADw59Nl75JZYDcXViBeSMENAFMyPSaU2XISfqAiNAjCw+P
	uig9zbubG+Vn5KaOV4F3gM5NkESRHiogIDxp9ARXE1vQPh7CZDLx2eq0N4w9f6J4Yr3Rd4JHlD5JQ
	JIykmDUg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34720)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vGdWP-000000003RK-2Ar9;
	Wed, 05 Nov 2025 13:25:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vGdWM-000000005js-0lOQ;
	Wed, 05 Nov 2025 13:25:54 +0000
Date: Wed, 5 Nov 2025 13:25:54 +0000
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
Subject: [PATCH net-next 0/11] net: stmmac: ingenic: convert to
 set_phy_intf_sel()
Message-ID: <aQtQYlEY9crH0IKo@shell.armlinux.org.uk>
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

 .../net/ethernet/stmicro/stmmac/dwmac-ingenic.c    | 169 ++++++---------------
 1 file changed, 47 insertions(+), 122 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

