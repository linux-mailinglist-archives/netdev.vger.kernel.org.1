Return-Path: <netdev+bounces-131971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0729900D8
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 12:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22CA281DE6
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D110014C5A7;
	Fri,  4 Oct 2024 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VcYWel3X"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AFA14B962
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 10:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037313; cv=none; b=puCyspbyupvnzZaMjWnuXEa0MZsuC/wHR9P4bjmsJM70l2KpoDUPIsd3ZPOkBEJyh2i5E9+dmxVKv/UMMueaifaRh95LJv1YI/H+jtp3DXL4It+mNxW+b0YhCHhy5QE2/x9TvV6K13B/fYMnVpScxrFTyKv1Lv50EpX+lJzW7+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037313; c=relaxed/simple;
	bh=kGMjf7cgmIDDqOB/Ifpu8SSr/5ictnA6+Ep7Ama3HAo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=WGyJYuD7iE8rriVu25OGDU9B+x9/GCriBQQh/njwsyHaRtI6z1iZ70ms1iZJMTgQJK+NK8Luf1ZwPQvmDKQ3lboFBntmSmVVW8RuYix4b8ARSyFIu4FjLghUN6+4c1cSJ3OPZrinRLOTyUU/LDUiSYoH8Yw+5bTce7Og68z5wfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VcYWel3X; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yjH4OJWzvXV/GMJcgj/l1TsPW7ofS0uCuRH9YNOrJVk=; b=VcYWel3XIoTm7LyPXYRZZSLEkS
	PoWYI/XZ5aYRUpQx4h//6VkOJ3nijQM8NTfgN7YFqlk8iUHIxFM+NBArr8tt+2gmFUxzwY80agCoT
	mMPrAoNsPxuEvqja/xtWoyEmhbNraezIOL4AgjRJ/ftM824pqNiNu5a77XzrBOUb0vIX3ef1t+ITK
	04zm71E8AJs/75WOapN12fFpGDC1+RwTB32Dt/gxZsUSBAL5Ui4dFqaQ4niY7iCdwVYzMStMoKOMN
	fS1ZCPy+mVFhFB/L4/wEY+7/ni4zppmTQnE7rMeAgVFzGdqCt0mkd3USAu4feTQSKrsFLIcO9Y2x0
	vcfRt79w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41722 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1swfRL-0001jB-1T;
	Fri, 04 Oct 2024 11:21:39 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1swfRJ-006Dg4-Lc; Fri, 04 Oct 2024 11:21:37 +0100
In-Reply-To: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
References: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 12/13] net: pcs: xpcs: correctly place
 DW_VR_MII_DIG_CTRL1_2G5_EN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1swfRJ-006Dg4-Lc@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 04 Oct 2024 11:21:37 +0100

Place DW_VR_MII_DIG_CTRL1_2G5_EN with the other DW_VR_MII_DIG_CTRL1
definitions rather than in the middle of a register list.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index b80b956ec286..9a22eed4404d 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -60,8 +60,6 @@
 #define DW_VR_MII_DIG_CTRL1		0x8000
 #define DW_VR_MII_AN_CTRL		0x8001
 #define DW_VR_MII_AN_INTR_STS		0x8002
-/* Enable 2.5G Mode */
-#define DW_VR_MII_DIG_CTRL1_2G5_EN	BIT(2)
 /* EEE Mode Control Register */
 #define DW_VR_MII_EEE_MCTRL0		0x8006
 #define DW_VR_MII_EEE_MCTRL1		0x800b
@@ -69,6 +67,7 @@
 
 /* VR_MII_DIG_CTRL1 */
 #define DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW		BIT(9)
+#define DW_VR_MII_DIG_CTRL1_2G5_EN		BIT(2)
 #define DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL	BIT(0)
 
 /* VR_MII_DIG_CTRL2 */
-- 
2.30.2


