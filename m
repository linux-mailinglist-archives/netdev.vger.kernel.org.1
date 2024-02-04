Return-Path: <netdev+bounces-68920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 913F8848D74
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 13:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C6A6B216CD
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 12:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87EA22626;
	Sun,  4 Feb 2024 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mSiogrBI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A098822627
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707048809; cv=none; b=KstFNUyjDh1His85/s0HNGHbYW+DP5j/gNWFhXHMo5085E7etfW0YPV3lqy0tlG8VbZL6vtIOh0Y2Me1z0f1EUSru3kSaQ1SncUFDKssNSmwMDI24sIG5BDwpfSxUrPJjyPOY8QZbSgGaNQIw8Av4htePzz8wT6CsWimWcQ0DhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707048809; c=relaxed/simple;
	bh=bkdHMEh+qJqoKb346Grsmt3QHErcD0aiPN+hdRyu0iM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=rq8CslnuPKNtzcgV8+JkawdORa+sB9fyp0Vr4bZ6Q5wyNO04KjNPI434leqOMMqPuhTJnb82hI9D1yS/qmgN5hMzD0gUMa7uIHeZ4V5UhsVUpdLDnU79NE9ObfF5aMIN4m8r4iE87Q2xW4HDZnbKe/GSC2pjJYY323z2WR7gQTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mSiogrBI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h2e2qQbupPLjDt7RKJD14LZY6ZDC/UDMiQaHqNdcgDc=; b=mSiogrBIUuUXYfEHNmMb9pCKXX
	qjt2VTB8BwJmk8LtOiCuIXPLVV/YKC3Gtq8WJdlOPkiBnq1oJhuDLn/++zRb+gd4QDA6Lx45Mpxn7
	/GEEtcDGrKgXnsIoXjrVo7z/fAuLk5cwfLdLiOafrTI4khu6iHkH6t9CR8FhKcvTjzewKn77G8OEx
	r1oR1GjewgiQ1tYlLYdkugQNMOmqmweSDmkPfndGI1ZNHj+alvoyOytdzoV5HBvmdFpsN3U4BAxcN
	R7f4CG9u+e9JKtSM4xpOEvJMCI0/HVrSy3fFT/f3RZDs54QaW0WnEAeZUtjWPoUNdvGHcowJn7esu
	AaR6G6Ng==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43562 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rWbN3-0007wH-3A;
	Sun, 04 Feb 2024 12:13:14 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rWbN2-002cCh-MY; Sun, 04 Feb 2024 12:13:12 +0000
In-Reply-To: <Zb9/O81fVAZw4ANr@shell.armlinux.org.uk>
References: <Zb9/O81fVAZw4ANr@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Byungho An <bh74.an@samsung.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Doug Berger <opendmb@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	Justin Chen <justin.chen@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	NXP Linux Team <linux-imx@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Wei Fang <wei.fang@nxp.com>
Subject: [PATCH net-next v2 3/6] net: fec: remove eee_enabled/eee_active in
 fec_enet_get_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rWbN2-002cCh-MY@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 04 Feb 2024 12:13:12 +0000

fec_enet_get_eee() sets edata->eee_active and edata->eee_enabled from
its own copy, and then calls phy_ethtool_get_eee() which in turn will
call genphy_c45_ethtool_get_eee().

genphy_c45_ethtool_get_eee() will overwrite eee_enabled and eee_active
with its own interpretation from the PHYs settings and negotiation
result.

Therefore, setting these members in fec_enet_get_eee() is redundant.
Remove this, and remove the setting of fep->eee.eee_active member which
becomes a write-only variable.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 63707e065141..42bdc01a304e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3139,8 +3139,6 @@ static int fec_enet_eee_mode_set(struct net_device *ndev, bool enable)
 	}
 
 	p->tx_lpi_enabled = enable;
-	p->eee_enabled = enable;
-	p->eee_active = enable;
 
 	writel(sleep_cycle, fep->hwp + FEC_LPI_SLEEP);
 	writel(wake_cycle, fep->hwp + FEC_LPI_WAKE);
@@ -3160,8 +3158,6 @@ fec_enet_get_eee(struct net_device *ndev, struct ethtool_keee *edata)
 	if (!netif_running(ndev))
 		return -ENETDOWN;
 
-	edata->eee_enabled = p->eee_enabled;
-	edata->eee_active = p->eee_active;
 	edata->tx_lpi_timer = p->tx_lpi_timer;
 	edata->tx_lpi_enabled = p->tx_lpi_enabled;
 
-- 
2.30.2


