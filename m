Return-Path: <netdev+bounces-301855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GJQDMfaaPGoRpwgAu9opvQ
	(envelope-from <netdev+bounces-301855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 05:05:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D756C286C
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 05:05:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301855-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301855-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53C933033FAA
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CBA39935E;
	Thu, 25 Jun 2026 03:05:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE40E3A7852;
	Thu, 25 Jun 2026 03:05:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782356719; cv=none; b=XVslvcSGs+mzLPWwaziS3G4GSDMeEO0oOix1KJecfMuOx0aBtbA74ZX/kTrCEQJvvNXv+0JVd0xAq46VWBUBP1b+eRPZoeM6ap5U8W6+vR9NY7Olac15tD5V+dPSvqQG5kIGu2BldhcDHmnknUlczJqUIrw5VEuQP7yQJ/Ct0lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782356719; c=relaxed/simple;
	bh=E6J+CPfTbYkpgmJX9dMelrZt3Q8YzKgIcSVrSy0WQmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eIJqLfgXJyxFlsOomWme8jqQp0CkWVvly6TG/YsIXElet7RseWXanJxzE0GyXXxn3wf+Rf515unICj9F9mL2HS88TvZuF8M8O25JT2N4QdkPcdZRptp2HlhDIV1guHXaerGN+o5Iv763GYK56gJpTS2GTyjqiHQSh8OlwCJXJs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowABnB9Dgmjxqc1kkAw--.47259S2;
	Thu, 25 Jun 2026 11:05:05 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH] net: pch_gbe: return errors from MIIM accesses
Date: Thu, 25 Jun 2026 11:05:03 +0800
Message-ID: <20260625030503.93588-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnB9Dgmjxqc1kkAw--.47259S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKr47AFyxGF1fGrW7Kw4kJFb_yoW3GF15pa
	yDJrZ8JF1kK3WUJFs7GrWUX3WUuw4Iq34UKasrCw4F9F1Y9F1qyFWagFySvF1vyrZ8XF13
	AF17Zay5Xr1DJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjZNVP
	UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301855-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pengpeng@iscas.ac.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23D756C286C

pch_gbe_mac_ctrl_miim() polls for the MIIM controller to become ready,
but returns zero on the initial ready timeout and ignores the completion
timeout after issuing the operation. MDIO and PHY helpers can then report
success with zero or stale data.

Make the MIIM helper return an errno and pass read data through an output
parameter. Propagate the error through the MDIO read path, the probe-time
PHY discovery path, and the internal PHY register helpers that already
return an error status.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 .../net/ethernet/oki-semi/pch_gbe/pch_gbe.h   |  4 +-
 .../ethernet/oki-semi/pch_gbe/pch_gbe_main.c  | 54 ++++++++++++++-----
 .../ethernet/oki-semi/pch_gbe/pch_gbe_phy.c   | 22 +++++---
 3 files changed, 57 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h
index 108f312bc542..4bdf0afca462 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h
@@ -619,6 +619,6 @@ void pch_gbe_set_ethtool_ops(struct net_device *netdev);
 
 /* pch_gbe_mac.c */
 s32 pch_gbe_mac_force_mac_fc(struct pch_gbe_hw *hw);
-u16 pch_gbe_mac_ctrl_miim(struct pch_gbe_hw *hw, u32 addr, u32 dir, u32 reg,
-			  u16 data);
+int pch_gbe_mac_ctrl_miim(struct pch_gbe_hw *hw, u32 addr, u32 dir, u32 reg,
+			  u16 data, u16 *read_data);
 #endif /* _PCH_GBE_H_ */
diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index 62f05f4569b1..61d47b529a0e 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -476,35 +476,48 @@ static void pch_gbe_mac_set_wol_event(struct pch_gbe_hw *hw, u32 wu_evt)
  * @dir:  Operetion. (Write or Read)
  * @reg:  Access register of PHY
  * @data: Write data.
+ * @read_data: Read data.
  *
- * Returns: Read date.
+ * Return: 0 on success, negative error code on failure.
  */
-u16 pch_gbe_mac_ctrl_miim(struct pch_gbe_hw *hw, u32 addr, u32 dir, u32 reg,
-			u16 data)
+int pch_gbe_mac_ctrl_miim(struct pch_gbe_hw *hw, u32 addr, u32 dir, u32 reg,
+			  u16 data, u16 *read_data)
 {
 	struct pch_gbe_adapter *adapter = pch_gbe_hw_to_adapter(hw);
 	unsigned long flags;
 	u32 data_out;
+	int ret;
 
 	spin_lock_irqsave(&hw->miim_lock, flags);
 
-	if (readx_poll_timeout_atomic(ioread32, &hw->reg->MIIM, data_out,
-				      data_out & PCH_GBE_MIIM_OPER_READY, 20, 2000)) {
+	ret = readx_poll_timeout_atomic(ioread32, &hw->reg->MIIM, data_out,
+					data_out & PCH_GBE_MIIM_OPER_READY, 20,
+					2000);
+	if (ret) {
 		netdev_err(adapter->netdev, "pch-gbe.miim won't go Ready\n");
 		spin_unlock_irqrestore(&hw->miim_lock, flags);
-		return 0;	/* No way to indicate timeout error */
+		return ret;
 	}
 	iowrite32(((reg << PCH_GBE_MIIM_REG_ADDR_SHIFT) |
 		  (addr << PCH_GBE_MIIM_PHY_ADDR_SHIFT) |
 		  dir | data), &hw->reg->MIIM);
-	readx_poll_timeout_atomic(ioread32, &hw->reg->MIIM, data_out,
-				  data_out & PCH_GBE_MIIM_OPER_READY, 20, 2000);
+	ret = readx_poll_timeout_atomic(ioread32, &hw->reg->MIIM, data_out,
+					data_out & PCH_GBE_MIIM_OPER_READY, 20,
+					2000);
+	if (ret) {
+		netdev_err(adapter->netdev, "pch-gbe.miim operation timed out\n");
+		spin_unlock_irqrestore(&hw->miim_lock, flags);
+		return ret;
+	}
 	spin_unlock_irqrestore(&hw->miim_lock, flags);
 
 	netdev_dbg(adapter->netdev, "PHY %s: reg=%d, data=0x%04X\n",
 		   dir == PCH_GBE_MIIM_OPER_READ ? "READ" : "WRITE", reg,
 		   dir == PCH_GBE_MIIM_OPER_READ ? data_out : data);
-	return (u16) data_out;
+	if (dir == PCH_GBE_MIIM_OPER_READ && read_data)
+		*read_data = (u16)data_out;
+
+	return 0;
 }
 
 /**
@@ -589,14 +602,20 @@ static int pch_gbe_init_phy(struct pch_gbe_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
 	u32 addr;
-	u16 bmcr, stat;
+	int bmcr, stat;
 
 	/* Discover phy addr by searching addrs in order {1,0,2,..., 31} */
 	for (addr = 0; addr < PCH_GBE_PHY_REGS_LEN; addr++) {
 		adapter->mii.phy_id = (addr == 0) ? 1 : (addr == 1) ? 0 : addr;
 		bmcr = pch_gbe_mdio_read(netdev, adapter->mii.phy_id, MII_BMCR);
+		if (bmcr < 0)
+			return bmcr;
 		stat = pch_gbe_mdio_read(netdev, adapter->mii.phy_id, MII_BMSR);
+		if (stat < 0)
+			return stat;
 		stat = pch_gbe_mdio_read(netdev, adapter->mii.phy_id, MII_BMSR);
+		if (stat < 0)
+			return stat;
 		if (!((bmcr == 0xFFFF) || ((stat == 0) && (bmcr == 0))))
 			break;
 	}
@@ -611,6 +630,8 @@ static int pch_gbe_init_phy(struct pch_gbe_adapter *adapter)
 					   BMCR_ISOLATE);
 		} else {
 			bmcr = pch_gbe_mdio_read(netdev, addr, MII_BMCR);
+			if (bmcr < 0)
+				return bmcr;
 			pch_gbe_mdio_write(netdev, addr, MII_BMCR,
 					   bmcr & ~BMCR_ISOLATE);
 		}
@@ -639,9 +660,15 @@ static int pch_gbe_mdio_read(struct net_device *netdev, int addr, int reg)
 {
 	struct pch_gbe_adapter *adapter = netdev_priv(netdev);
 	struct pch_gbe_hw *hw = &adapter->hw;
+	u16 data;
+	int ret;
+
+	ret = pch_gbe_mac_ctrl_miim(hw, addr, PCH_GBE_HAL_MIIM_READ, reg,
+				    0, &data);
+	if (ret)
+		return ret;
 
-	return pch_gbe_mac_ctrl_miim(hw, addr, PCH_GBE_HAL_MIIM_READ, reg,
-				     (u16) 0);
+	return data;
 }
 
 /**
@@ -657,7 +684,8 @@ static void pch_gbe_mdio_write(struct net_device *netdev,
 	struct pch_gbe_adapter *adapter = netdev_priv(netdev);
 	struct pch_gbe_hw *hw = &adapter->hw;
 
-	pch_gbe_mac_ctrl_miim(hw, addr, PCH_GBE_HAL_MIIM_WRITE, reg, data);
+	pch_gbe_mac_ctrl_miim(hw, addr, PCH_GBE_HAL_MIIM_WRITE, reg, data,
+			      NULL);
 }
 
 /**
diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_phy.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_phy.c
index 3426f6fa2b57..edf3644f7589 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_phy.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_phy.c
@@ -139,9 +139,10 @@ s32 pch_gbe_phy_read_reg_miic(struct pch_gbe_hw *hw, u32 offset, u16 *data)
 			   offset);
 		return -EINVAL;
 	}
-	*data = pch_gbe_mac_ctrl_miim(hw, phy->addr, PCH_GBE_HAL_MIIM_READ,
-				      offset, (u16)0);
-	return 0;
+
+	*data = 0;
+	return pch_gbe_mac_ctrl_miim(hw, phy->addr, PCH_GBE_HAL_MIIM_READ,
+				     offset, 0, data);
 }
 
 /**
@@ -164,9 +165,8 @@ s32 pch_gbe_phy_write_reg_miic(struct pch_gbe_hw *hw, u32 offset, u16 data)
 			   offset);
 		return -EINVAL;
 	}
-	pch_gbe_mac_ctrl_miim(hw, phy->addr, PCH_GBE_HAL_MIIM_WRITE,
-				 offset, data);
-	return 0;
+	return pch_gbe_mac_ctrl_miim(hw, phy->addr, PCH_GBE_HAL_MIIM_WRITE,
+				     offset, data, NULL);
 }
 
 /**
@@ -266,13 +266,19 @@ static int pch_gbe_phy_tx_clk_delay(struct pch_gbe_hw *hw)
 	case PHY_AR803X_ID:
 		netdev_dbg(adapter->netdev,
 			   "Configuring AR803X PHY for 2ns TX clock delay\n");
-		pch_gbe_phy_read_reg_miic(hw, PHY_AR8031_DBG_OFF, &mii_reg);
+		ret = pch_gbe_phy_read_reg_miic(hw, PHY_AR8031_DBG_OFF,
+						&mii_reg);
+		if (ret)
+			break;
 		ret = pch_gbe_phy_write_reg_miic(hw, PHY_AR8031_DBG_OFF,
 						 PHY_AR8031_SERDES);
 		if (ret)
 			break;
 
-		pch_gbe_phy_read_reg_miic(hw, PHY_AR8031_DBG_DAT, &mii_reg);
+		ret = pch_gbe_phy_read_reg_miic(hw, PHY_AR8031_DBG_DAT,
+						&mii_reg);
+		if (ret)
+			break;
 		mii_reg |= PHY_AR8031_SERDES_TX_CLK_DLY;
 		ret = pch_gbe_phy_write_reg_miic(hw, PHY_AR8031_DBG_DAT,
 						 mii_reg);
-- 
2.50.1 (Apple Git-155)


