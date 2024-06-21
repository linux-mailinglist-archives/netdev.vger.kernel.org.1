Return-Path: <netdev+bounces-105732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F5D91283D
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 16:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9A228195D
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 14:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D116C28DD1;
	Fri, 21 Jun 2024 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="PEWugDnB"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F151381AF
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981024; cv=none; b=qq34jwP2jQYkmQvSABFS+7pE7PV+zzGOS3QCGJdBtNnXIfzaUL/Z0zKx4Ysu0fce8SSdWeG0JQ5uBmHHMBIP1mFw7j897DOBQAwKU4VRZeEMDPYC+PqGCCSbLMcieWDNto9moVNcLEaZdn2kzw/6JhRy1rR6VN2VyN4Im+4Pb44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981024; c=relaxed/simple;
	bh=5sq7Ct2FV8LgwB+xH81sWThHmXAYpPgkC4LP/K8Jyvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hIrQzyF7RvfdwoPQTC4cNLRHrrOu50hBce9nO/u9vTmgTh7AbCoOXeh2q4Z+pkiInTl8hM2oqNSSxiRkZs0+ld0BoJt9WwPMDXatA396XYIRT9U0/w/GT7WaTlgliL9b99F9kLiA2gvR4+lB64xFOvu1bFATM2Ubh8LzLEahCk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=PEWugDnB; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 34EF69C5B17;
	Fri, 21 Jun 2024 10:43:36 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 1Q3caU-oPc-k; Fri, 21 Jun 2024 10:43:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 61BA99C5A85;
	Fri, 21 Jun 2024 10:43:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 61BA99C5A85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1718981014; bh=s4nOfBHEpxOrkUtPmqzC9WJXUZFF/lFGqBwIAo/rsjM=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=PEWugDnBfcAGMRQFIBVZpX6vVHQlgItycFn3E9/tNuswxUhFMCWCFQalWRX1tTM8P
	 pTuvbftXS7fnoM4WmahiOMD6FruwyWtUylLiWohwppEVt0YlBtf/39iZO03RmVF5CL
	 +3Q+QwB/1xiHnuD8W4pJ0ZEmT1ZHoBlTGL9XEiBlscAUGeHwCS/9byiCCoxQkZSp6t
	 uA5j05P3ZLob4LnxcgR6WrRybwzmOtUH51Clvx663f3G7nLG3GUdOIz5fH1QUPKMRd
	 HzGX8c0Wz1PbFohkwJcF+asj73zfveJz5dSkU1S2DS6Q22+62ENPD5jLxXIuMj1rKn
	 48HQ4kLRLzSQA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id wX9ybClgMN94; Fri, 21 Jun 2024 10:43:34 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 300F59C5B17;
	Fri, 21 Jun 2024 10:43:33 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	horms@kernel.org,
	Tristram.Ha@microchip.com,
	Arun.Ramadoss@microchip.com,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [PATCH net v7 3/3] net: dsa: microchip: monitor potential faults in half-duplex mode
Date: Fri, 21 Jun 2024 16:43:22 +0200
Message-Id: <20240621144322.545908-4-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621144322.545908-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240621144322.545908-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The errata DS80000754 recommends monitoring potential faults in
half-duplex mode for the KSZ9477 family.

half-duplex is not very common so I just added a critical message
when the fault conditions are detected. The switch can be expected
to be unable to communicate anymore in these states and a software
reset of the switch would be required which I did not implement.

Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
---
v7:
 - use dev_crit_once instead of dev_crit_ratelimited
   The condition will remain true forever and the routine called every
   5 seconds. There's no need to repeat the message.
 - add explanations in the comment above the warning to help users
   anticipate the consequences of the fault.
v6: https://lore.kernel.org/netdev/20240614094642.122464-4-enguerrand.de-=
ribaucourt@savoirfairelinux.com/
 - use macros for PORT_INTF_SPEED_MASK check
 - add VLAN condition before checking the resources
v5: https://lore.kernel.org/all/20240604092304.314636-5-enguerrand.de-rib=
aucourt@savoirfairelinux.com/
 - use macros for bitmasks
 - check for return values on ksz_pread*
v4: https://lore.kernel.org/all/20240531142430.678198-6-enguerrand.de-rib=
aucourt@savoirfairelinux.com/
 - rebase on net/main
 - add Fixes tag
 - reverse x-mas tree
v3: https://lore.kernel.org/all/20240530102436.226189-6-enguerrand.de-rib=
aucourt@savoirfairelinux.com/
---
 drivers/net/dsa/microchip/ksz9477.c     | 51 +++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz9477.h     |  2 +
 drivers/net/dsa/microchip/ksz9477_reg.h | 10 ++++-
 drivers/net/dsa/microchip/ksz_common.c  | 11 ++++++
 drivers/net/dsa/microchip/ksz_common.h  |  1 +
 5 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microc=
hip/ksz9477.c
index c2878dd0ad7e..6924b3818357 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -429,6 +429,57 @@ void ksz9477_freeze_mib(struct ksz_device *dev, int =
port, bool freeze)
 	mutex_unlock(&p->mib.cnt_mutex);
 }
=20
+int ksz9477_errata_monitor(struct ksz_device *dev, int port,
+			   u64 tx_late_col)
+{
+	u32 pmavbc;
+	u8 status;
+	u16 pqm;
+	int ret;
+
+	ret =3D ksz_pread8(dev, port, REG_PORT_STATUS_0, &status);
+	if (ret)
+		return ret;
+	if (!(FIELD_GET(PORT_INTF_SPEED_MASK, status) =3D=3D PORT_INTF_SPEED_NO=
NE) &&
+	    !(status & PORT_INTF_FULL_DUPLEX)) {
+		/* Errata DS80000754 recommends monitoring potential faults in
+		 * half-duplex mode. The switch might not be able to communicate anymo=
re
+		 * in these states.
+		 * If you see this message, please read the errata-sheet for more info=
rmation:
+		 * https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Prod=
uctDocuments/Errata/KSZ9477S-Errata-DS80000754.pdf
+		 * To workaround this issue, half-duplex mode should be avoided.
+		 * A software reset could be implemented to recover from this state.
+		 */
+		dev_warn_once(dev->dev,
+			      "Half-duplex detected on port %d, transmission halt may occur\n=
",
+			      port);
+		if (tx_late_col !=3D 0) {
+			/* Transmission halt with late collisions */
+			dev_crit_once(dev->dev,
+				      "TX late collisions detected, transmission may be halted on po=
rt %d\n",
+				      port);
+		}
+		ret =3D ksz_read8(dev, REG_SW_LUE_CTRL_0, &status);
+		if (ret)
+			return ret;
+		if (status & SW_VLAN_ENABLE) {
+			ret =3D ksz_pread16(dev, port, REG_PORT_QM_TX_CNT_0__4, &pqm);
+			if (ret)
+				return ret;
+			ret =3D ksz_read32(dev, REG_PMAVBC, &pmavbc);
+			if (ret)
+				return ret;
+			if ((FIELD_GET(PMAVBC_MASK, pmavbc) <=3D PMAVBC_MIN) ||
+			    (FIELD_GET(PORT_QM_TX_CNT_M, pqm) >=3D PORT_QM_TX_CNT_MAX)) {
+				/* Transmission halt with Half-Duplex and VLAN */
+				dev_crit_once(dev->dev,
+					      "resources out of limits, transmission may be halted\n");
+			}
+		}
+	}
+	return ret;
+}
+
 void ksz9477_port_init_cnt(struct ksz_device *dev, int port)
 {
 	struct ksz_port_mib *mib =3D &dev->ports[port].mib;
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microc=
hip/ksz9477.h
index ce1e656b800b..239a281da10b 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -36,6 +36,8 @@ int ksz9477_port_mirror_add(struct ksz_device *dev, int=
 port,
 			    bool ingress, struct netlink_ext_ack *extack);
 void ksz9477_port_mirror_del(struct ksz_device *dev, int port,
 			     struct dsa_mall_mirror_tc_entry *mirror);
+int ksz9477_errata_monitor(struct ksz_device *dev, int port,
+			   u64 tx_late_col);
 void ksz9477_get_caps(struct ksz_device *dev, int port,
 		      struct phylink_config *config);
 int ksz9477_fdb_dump(struct ksz_device *dev, int port,
diff --git a/drivers/net/dsa/microchip/ksz9477_reg.h b/drivers/net/dsa/mi=
crochip/ksz9477_reg.h
index fb124be8edd3..d5354c600ea1 100644
--- a/drivers/net/dsa/microchip/ksz9477_reg.h
+++ b/drivers/net/dsa/microchip/ksz9477_reg.h
@@ -843,8 +843,8 @@
=20
 #define REG_PORT_STATUS_0		0x0030
=20
-#define PORT_INTF_SPEED_M		0x3
-#define PORT_INTF_SPEED_S		3
+#define PORT_INTF_SPEED_MASK		GENMASK(4, 3)
+#define PORT_INTF_SPEED_NONE		GENMASK(1, 0)
 #define PORT_INTF_FULL_DUPLEX		BIT(2)
 #define PORT_TX_FLOW_CTRL		BIT(1)
 #define PORT_RX_FLOW_CTRL		BIT(0)
@@ -1168,6 +1168,11 @@
 #define PORT_RMII_CLK_SEL		BIT(7)
 #define PORT_MII_SEL_EDGE		BIT(5)
=20
+#define REG_PMAVBC			0x03AC
+
+#define PMAVBC_MASK			GENMASK(26, 16)
+#define PMAVBC_MIN			0x580
+
 /* 4 - MAC */
 #define REG_PORT_MAC_CTRL_0		0x0400
=20
@@ -1495,6 +1500,7 @@
=20
 #define PORT_QM_TX_CNT_USED_S		0
 #define PORT_QM_TX_CNT_M		(BIT(11) - 1)
+#define PORT_QM_TX_CNT_MAX		0x200
=20
 #define REG_PORT_QM_TX_CNT_1__4		0x0A14
=20
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/mic=
rochip/ksz_common.c
index 2818e24e2a51..0433109b42e5 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1382,6 +1382,7 @@ const struct ksz_chip_data ksz_switch_chips[] =3D {
 		.tc_cbs_supported =3D true,
 		.ops =3D &ksz9477_dev_ops,
 		.phylink_mac_ops =3D &ksz9477_phylink_mac_ops,
+		.phy_errata_9477 =3D true,
 		.mib_names =3D ksz9477_mib_names,
 		.mib_cnt =3D ARRAY_SIZE(ksz9477_mib_names),
 		.reg_mib_cnt =3D MIB_COUNTER_NUM,
@@ -1416,6 +1417,7 @@ const struct ksz_chip_data ksz_switch_chips[] =3D {
 		.num_ipms =3D 8,
 		.ops =3D &ksz9477_dev_ops,
 		.phylink_mac_ops =3D &ksz9477_phylink_mac_ops,
+		.phy_errata_9477 =3D true,
 		.mib_names =3D ksz9477_mib_names,
 		.mib_cnt =3D ARRAY_SIZE(ksz9477_mib_names),
 		.reg_mib_cnt =3D MIB_COUNTER_NUM,
@@ -1450,6 +1452,7 @@ const struct ksz_chip_data ksz_switch_chips[] =3D {
 		.num_ipms =3D 8,
 		.ops =3D &ksz9477_dev_ops,
 		.phylink_mac_ops =3D &ksz9477_phylink_mac_ops,
+		.phy_errata_9477 =3D true,
 		.mib_names =3D ksz9477_mib_names,
 		.mib_cnt =3D ARRAY_SIZE(ksz9477_mib_names),
 		.reg_mib_cnt =3D MIB_COUNTER_NUM,
@@ -1540,6 +1543,7 @@ const struct ksz_chip_data ksz_switch_chips[] =3D {
 		.tc_cbs_supported =3D true,
 		.ops =3D &ksz9477_dev_ops,
 		.phylink_mac_ops =3D &ksz9477_phylink_mac_ops,
+		.phy_errata_9477 =3D true,
 		.mib_names =3D ksz9477_mib_names,
 		.mib_cnt =3D ARRAY_SIZE(ksz9477_mib_names),
 		.reg_mib_cnt =3D MIB_COUNTER_NUM,
@@ -1820,6 +1824,7 @@ void ksz_r_mib_stats64(struct ksz_device *dev, int =
port)
 	struct rtnl_link_stats64 *stats;
 	struct ksz_stats_raw *raw;
 	struct ksz_port_mib *mib;
+	int ret;
=20
 	mib =3D &dev->ports[port].mib;
 	stats =3D &mib->stats64;
@@ -1861,6 +1866,12 @@ void ksz_r_mib_stats64(struct ksz_device *dev, int=
 port)
 	pstats->rx_pause_frames =3D raw->rx_pause;
=20
 	spin_unlock(&mib->stats64_lock);
+
+	if (dev->info->phy_errata_9477) {
+		ret =3D ksz9477_errata_monitor(dev, port, raw->tx_late_col);
+		if (ret)
+			dev_err(dev->dev, "Failed to monitor transmission halt\n");
+	}
 }
=20
 void ksz88xx_r_mib_stats64(struct ksz_device *dev, int port)
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/mic=
rochip/ksz_common.h
index c784fd23a993..ee7db46e469d 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -66,6 +66,7 @@ struct ksz_chip_data {
 	bool tc_cbs_supported;
 	const struct ksz_dev_ops *ops;
 	const struct phylink_mac_ops *phylink_mac_ops;
+	bool phy_errata_9477;
 	bool ksz87xx_eee_link_erratum;
 	const struct ksz_mib_names *mib_names;
 	int mib_cnt;
--=20
2.34.1


