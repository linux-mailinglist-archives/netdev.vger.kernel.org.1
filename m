Return-Path: <netdev+bounces-134993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C146799BBE6
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 23:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670A22829CE
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 21:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00AC1494A5;
	Sun, 13 Oct 2024 21:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="BR/SWXqc"
X-Original-To: netdev@vger.kernel.org
Received: from mx14lb.world4you.com (mx14lb.world4you.com [81.19.149.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D40148314
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728853405; cv=none; b=Qut4UsHMJEFJRud7UjujzYG4nZ2Qs9AFn4ymUSfj6R/92k3aItTiNKsubqbqU8JUNZOUOrAKEeMpQ3mpiAG3C5YfnlcPQuZApjckbRiSyqroX3zr5/owxRsjLxN94pOyXJ8PZNdfoqBiUzM9qQdgBgMfafvwH4wGBAhbgTY4Zkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728853405; c=relaxed/simple;
	bh=9CQpwdgXVc21I8EUQ4DUE2KYJ69fMnFI7RjT7KcNiM0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nhoiwB5Q6h/PaB/i+6kVWv5RBK/V8yHoUbO174RyjoaZmAXKeKDX/2McEglOkngZrIOsPlwlQzqA7frnz/5jC4up/TLgwzgljvdGvP6clRUe2u0FoRFa1c1oPrm4/UV4B182OibZNSjeHDVGcb3NWormurC/Cwjw88Aw+Jf6HvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=BR/SWXqc; arc=none smtp.client-ip=81.19.149.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=19LHjx0sTM0kv9XanzWE8FODtpIz64O5KVgtFRfu2pg=; b=BR/SWXqcnkjCCWdpyB32ql0pPa
	gJ1TxElsH/THb7IGM+1fNhCeAaAiPp4UQIg2ZgtAg7om6weUiWSn5mUTgW3wL5plBUIfKLR7edi2z
	gcHYPN2V4D8Wmc43/P2cEwcXC+Udo+dMs5ZGCarxE0uLzkE9RK5XhdPfVGbFrDze/ptE=;
Received: from [88.117.56.173] (helo=hornet.engleder.at)
	by mx14lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1t0594-000000008Un-3qzu;
	Sun, 13 Oct 2024 22:24:55 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH RFC net-next] net: phy: micrel: Improve loopback support if autoneg is enabled
Date: Sun, 13 Oct 2024 22:24:30 +0200
Message-Id: <20241013202430.93851-1-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

Prior to commit 6ff3cddc365b it was possible to enable loopback with
a defined speed. First a fixed speed was set with ETHTOOL_SLINKSETTINGS
and afterwards the loopback was enabled. This worked, because
genphy_loopback() uses the current speed and duplex. I used this
mechanism to test tsnep in loopback with different speeds. A KSZ9031 PHY
is used.

With commit 6ff3cddc365b for 1000 Mbit/s auto negotiation was enabled.
Setting a fixed speed with ETHTOOL_SLINKSETTINGS does not work anymore
for 1000 Mbit/s as speed and duplex of the PHY now depend on the result
of the auto negotiation. As a result, genphy_loopback() also depends on
the result of the auto negotiation. But enabling loopback shall be
independent of any auto negotiation process.

Make loopback of KSZ9031 PHY work even if current speed and/or duplex of
PHY are unkown because of autoneg.

Fixes: 6ff3cddc365b ("net: phylib: do not disable autoneg for fixed speeds >= 1G")
Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 drivers/net/phy/micrel.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 65b0a3115e14..3cbe40265190 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1028,6 +1028,32 @@ static int ksz9021_config_init(struct phy_device *phydev)
 #define MII_KSZ9031RN_EDPD		0x23
 #define MII_KSZ9031RN_EDPD_ENABLE	BIT(0)
 
+static int ksz9031_set_loopback(struct phy_device *phydev, bool enable)
+{
+	if (enable) {
+		u16 ctl = BMCR_LOOPBACK;
+		int ret, val;
+
+		if ((phydev->speed != SPEED_10) && (phydev->speed != SPEED_100))
+			phydev->speed = SPEED_1000;
+		phydev->duplex = DUPLEX_FULL;
+
+		ctl |= mii_bmcr_encode_fixed(phydev->speed, phydev->duplex);
+
+		phy_modify(phydev, MII_BMCR, ~0, ctl);
+
+		ret = phy_read_poll_timeout(phydev, MII_BMSR, val,
+					    val & BMSR_LSTATUS, 5000, 500000,
+					    true);
+		if (ret)
+			return ret;
+	} else {
+		return genphy_loopback(phydev, enable);
+	}
+
+	return 0;
+}
+
 static int ksz9031_of_load_skew_values(struct phy_device *phydev,
 				       const struct device_node *of_node,
 				       u16 reg, size_t field_sz,
@@ -5478,6 +5504,7 @@ static struct phy_driver ksphy_driver[] = {
 	.resume		= kszphy_resume,
 	.cable_test_start	= ksz9x31_cable_test_start,
 	.cable_test_get_status	= ksz9x31_cable_test_get_status,
+	.set_loopback	= ksz9031_set_loopback,
 }, {
 	.phy_id		= PHY_ID_LAN8814,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
-- 
2.39.2


