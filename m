Return-Path: <netdev+bounces-175110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4BCA63577
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 12:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F29116DCB8
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 11:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D826E1A2547;
	Sun, 16 Mar 2025 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="046gZfLX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5145CA32
	for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742125904; cv=none; b=pK3w8N1SwDjAOx/aof5ARc/gL2fLNLh1ufuO3+TIrFtpv1b3jRNVZpKYSFssvvBczqBVr5siLVRaT3gNOUwtEUSO9PYNAlySkm8Msjv8jm/dEM9O2fLO6yTupVl1na3YTl50ABudquDGydBHgmnEfAfDptMHzwjzl9FJUaUFR/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742125904; c=relaxed/simple;
	bh=bDQq7zN9ddH0EaUX3GNLQuNK4R/4TQOhL1AlTpRTwqY=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=hXmZVNQVdp+USMUUlGNgm2LqPD06npLJKaZMRzfiCUPFnTa/I2enkmADRhZlaor97Oq0ci5aB/Dh7O+16PiaQKggLQxxntaq8oti0vt8llxWHb5gL5SGgU75duPO0DGWf4IVgk0eE7ZDMRytd+g+ZMGHVHveAdC8MO5MI3esIQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=046gZfLX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U0ZzA4b6Mfmr+mjzghazvliOL1BYxIRTN6USB7AluuM=; b=046gZfLXoPChGHPiPqfb4KOKbW
	6fp21YGhw5xwic+kU+O8ff9lWWDbTna4c1J9tTFO6v/bTunolrNbPsAl/kKzvmqR11wpBk9kPVEbv
	IvQBcqbhw3IaiN9WXBOULXwtNsfHrZAX5a92tcgtHcz/5vZ0Ml6PyPfcnn1JEg2RtaxX2YASC1Fky
	OQG1Q4/aJLmpJAn7uWd0C4YK5IYYHtSQnri+s7oFasahEiVf3HVSOWCvLjnQr2iXSTExc5N/TQY0I
	NfLSmBr7YGaQM7/0IAG46fRtQPLtvPUYv+XM/WR60ZLczxcP4jBiWEEchkqHv482jFCErjCDxku0A
	TBz0sAQA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42350 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1ttmWi-0002Pw-1O;
	Sun, 16 Mar 2025 11:51:32 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1ttmWN-0077Mb-Q6; Sun, 16 Mar 2025 11:51:11 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: phy: fix genphy_c45_eee_is_active() for
 disabled EEE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ttmWN-0077Mb-Q6@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 16 Mar 2025 11:51:11 +0000

Commit 809265fe96fe ("net: phy: c45: remove local advertisement
parameter from genphy_c45_eee_is_active") stopped reading the local
advertisement from the PHY earlier in this development cycle, which
broke "ethtool --set-eee ethX eee off".

When ethtool is used to set EEE off, genphy_c45_eee_is_active()
indicates that EEE was active if the link partner reported an
advertisement, which causes phylib to set phydev->enable_tx_lpi on
link up, despite our local advertisement in hardware being empty.
However, phydev->advertising_eee is preserved while EEE is turned off,
which leads to genphy_c45_eee_is_active() incorrectly reporting that
EEE is active.

Fix it by checking phydev->eee_cfg.eee_enabled, and if clear,
immediately indicate that EEE is not active.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy-c45.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 0bcbdce38107..f1973ed90072 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1476,6 +1476,9 @@ int genphy_c45_eee_is_active(struct phy_device *phydev, unsigned long *lp)
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
 	int ret;
 
+	if (!phydev->eee_cfg.eee_enabled)
+		return 0;
+
 	ret = genphy_c45_read_eee_lpa(phydev, tmp_lp);
 	if (ret)
 		return ret;
-- 
2.30.2


