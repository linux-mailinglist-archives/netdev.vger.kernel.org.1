Return-Path: <netdev+bounces-99350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB778D499F
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A27283C55
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 10:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6768514D71B;
	Thu, 30 May 2024 10:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="EVWhdLlD"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6C9176AAE
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717064719; cv=none; b=MC3/xKxWGS49nk7U6gjYkUotBtdLoP54tuDlMpICEyzpkZAMptbfT99KrNGgZjtr2EB6AouW19HDuMK+kdQgdG9+gKreJ601yaC2WAdUCm9xTpkeHsXa1krxOc+2VDJhPDo48kRutjixZQYe+f1cNr2cV9CkyVKE8adKPZVVxY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717064719; c=relaxed/simple;
	bh=T+XWsFi7Zp00QuXleTyFDfLRSGyq5aoe0Ao7ucW+MvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nKHbosl7xcJHNLTPT9SVIQopuyEECjVh5bA9UtbjQceQn+3dLFkssWO6+kX5a/swL8xI8hcoH7SaEFd0afWy8YHxoNmxLIGaPJsqX4q3PN39j5ZnPnl9nosScaZtBoY+QUTiXrOURdGm/XiJu3DGvOCHRoGZQw0ORORe3CkAwSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=EVWhdLlD; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3206F9C32FC;
	Thu, 30 May 2024 06:25:14 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 0IWIx_esQcaR; Thu, 30 May 2024 06:25:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D61139C5847;
	Thu, 30 May 2024 06:25:12 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com D61139C5847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717064712; bh=tfhRbGUxBvcpFrVufTpKrccUBh0CLoH/U4j9Wubt0+k=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=EVWhdLlD7OLpqBh6cWZLQoq9ejub6lktdhSYQzwvC0hxfFgEDrN8o6cprtXDseHSJ
	 dFHgY8o4meYlapeeB4YxCRICYtejr91kJ6mWLGaS2Wfs/rJw1cfWkTi17qhV66uw0k
	 PWXgcwkh6jaXglSdbMSqlCciVbj9wMooPV3NxJFL9GJy3+HRj/fLFzBr/l3Xh54tXl
	 22eoC24A8sliJ3vWH8Z7dZVMyIMm0lkfWLTRIG561G7pfqbfI8RkcELyFKvUae4Meo
	 aKdNQid7PX2tiIVntogNBRZ1V32WeE38rwTizMYX3lBH4OUiAVpv1ukWDoA0NULEqz
	 aqZ3XnCA0CHxA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id ACq2z9obPSgR; Thu, 30 May 2024 06:25:12 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id EAC4E9C32FC;
	Thu, 30 May 2024 06:25:11 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	woojung.huh@microchip.com,
	embedded-discuss@lists.savoirfairelinux.net,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [PATCH v3 5/5] net: dsa: microchip: monitor potential faults in half-duplex mode
Date: Thu, 30 May 2024 10:24:36 +0000
Message-Id: <20240530102436.226189-6-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The errata DS80000754 recommends monitoring potential faults in
half-duplex mode for the KSZ9477 familly.

half-duplex is not very common so I just added a critical message
when the fault conditions are detected. The switch can be expected
to be unable to communicate anymore in these states and a software
reset of the switch would be required which I did not implement.

Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
---
 drivers/net/dsa/microchip/ksz9477.c     | 34 +++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz9477.h     |  2 ++
 drivers/net/dsa/microchip/ksz9477_reg.h |  8 ++++--
 drivers/net/dsa/microchip/ksz_common.c  |  7 +++++
 drivers/net/dsa/microchip/ksz_common.h  |  1 +
 5 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microc=
hip/ksz9477.c
index 343b9d7538e9..ea1c12304f7f 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -429,6 +429,40 @@ void ksz9477_freeze_mib(struct ksz_device *dev, int =
port, bool freeze)
 	mutex_unlock(&p->mib.cnt_mutex);
 }
=20
+void ksz9477_errata_monitor(struct ksz_device *dev, int port,
+			    u64 tx_late_col)
+{
+	u8 status;
+	u16 pqm;
+	u32 pmavbc;
+
+	ksz_pread8(dev, port, REG_PORT_STATUS_0, &status);
+	if (!((status & PORT_INTF_SPEED_MASK) =3D=3D PORT_INTF_SPEED_MASK) &&
+	    !(status & PORT_INTF_FULL_DUPLEX)) {
+		dev_warn_once(dev->dev,
+			      "Half-duplex detected on port %d, transmission halt may occur\n=
",
+			      port);
+		/* Errata DS80000754 recommends monitoring potential faults in
+		 * half-duplex mode. The switch might not be able to communicate anymo=
re
+		 * in these states.
+		 */
+		if (tx_late_col !=3D 0) {
+			/* Transmission halt with late collisions */
+			dev_crit_ratelimited(dev->dev,
+					     "TX late collisions detected, transmission may be halted on po=
rt %d\n",
+					     port);
+		}
+		ksz_pread16(dev, port, REG_PORT_QM_TX_CNT_0__4, &pqm);
+		ksz_read32(dev, REG_PMAVBC, &pmavbc);
+		if (((pmavbc & PMAVBC_MASK) >> PMAVBC_SHIFT <=3D 0x580) ||
+		    ((pqm & PORT_QM_TX_CNT_M) >=3D 0x200)) {
+			/* Transmission halt with Half-Duplex and VLAN */
+			dev_crit_ratelimited(dev->dev,
+					     "resources out of limits, transmission may be halted\n");
+		}
+	}
+}
+
 void ksz9477_port_init_cnt(struct ksz_device *dev, int port)
 {
 	struct ksz_port_mib *mib =3D &dev->ports[port].mib;
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microc=
hip/ksz9477.h
index ce1e656b800b..3312ef28e99c 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -36,6 +36,8 @@ int ksz9477_port_mirror_add(struct ksz_device *dev, int=
 port,
 			    bool ingress, struct netlink_ext_ack *extack);
 void ksz9477_port_mirror_del(struct ksz_device *dev, int port,
 			     struct dsa_mall_mirror_tc_entry *mirror);
+void ksz9477_errata_monitor(struct ksz_device *dev, int port,
+			    u64 tx_late_col);
 void ksz9477_get_caps(struct ksz_device *dev, int port,
 		      struct phylink_config *config);
 int ksz9477_fdb_dump(struct ksz_device *dev, int port,
diff --git a/drivers/net/dsa/microchip/ksz9477_reg.h b/drivers/net/dsa/mi=
crochip/ksz9477_reg.h
index f3a205ee483f..3238b9748d0f 100644
--- a/drivers/net/dsa/microchip/ksz9477_reg.h
+++ b/drivers/net/dsa/microchip/ksz9477_reg.h
@@ -842,8 +842,7 @@
=20
 #define REG_PORT_STATUS_0		0x0030
=20
-#define PORT_INTF_SPEED_M		0x3
-#define PORT_INTF_SPEED_S		3
+#define PORT_INTF_SPEED_MASK		0x0018
 #define PORT_INTF_FULL_DUPLEX		BIT(2)
 #define PORT_TX_FLOW_CTRL		BIT(1)
 #define PORT_RX_FLOW_CTRL		BIT(0)
@@ -1167,6 +1166,11 @@
 #define PORT_RMII_CLK_SEL		BIT(7)
 #define PORT_MII_SEL_EDGE		BIT(5)
=20
+#define REG_PMAVBC				0x03AC
+
+#define PMAVBC_MASK				0x7ff0000
+#define PMAVBC_SHIFT			16
+
 /* 4 - MAC */
 #define REG_PORT_MAC_CTRL_0		0x0400
=20
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/mic=
rochip/ksz_common.c
index 1e0085cd9a9a..26e2fcd74ba8 100644
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
@@ -1861,6 +1865,9 @@ void ksz_r_mib_stats64(struct ksz_device *dev, int =
port)
 	pstats->rx_pause_frames =3D raw->rx_pause;
=20
 	spin_unlock(&mib->stats64_lock);
+
+	if (dev->info->phy_errata_9477)
+		ksz9477_errata_monitor(dev, port, raw->tx_late_col);
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


