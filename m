Return-Path: <netdev+bounces-304702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q4a+JUrnSGqVvAAAu9opvQ
	(envelope-from <netdev+bounces-304702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 12:58:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B47707610
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 12:58:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tinyisr.com header.s=purelymail3 header.b=pusXz9V2;
	dkim=pass header.d=purelymail.com header.s=purelymail3 header.b=YZbh57LS;
	dmarc=pass (policy=reject) header.from=tinyisr.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304702-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304702-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6CE2F3012B2D
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 10:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FB43A75B6;
	Sat,  4 Jul 2026 10:57:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E263A718D
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 10:57:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783162678; cv=none; b=Tijs4qt+foeSQhZ9hl+bIbyW+BV5wOMAGzL+xp/SfcMXMSFakh46gD4MfIZ0aKeP2Uuu4Q2m8oXGmsSAbuCJPlyQ6fcvLE7NLixzwza2K/fr9fHh3l+tCYoDv+cWhjS3qboZtqhE+MEYzviCc14Qiw1Doa+HRbfztD+LH/zCuyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783162678; c=relaxed/simple;
	bh=e2xvOUGB6UxohJ6YrHFIKJom9IDsGDwaAtdqSHio/rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdHIaYSGzbZttVGiyv/S8H/Y2+kUsAVPOXxy9aYMwCh5l8xEu/feRhjnDr5VD/BRZZQO96aiKb0lPdYZFEe34QVCYCpF5LZvbkGVbmad6nhllijkY2mhkUVZI8r7nayJ62RKz2qGgqkVg4viaOKLn3vhb9SvWCywVG5DDmbedxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=pusXz9V2; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=YZbh57LS; arc=none smtp.client-ip=34.202.193.197
DKIM-Signature: a=rsa-sha256; b=pusXz9V29HkCkZw6VHNQRiwjveCGRgMv+PC0bOx7y5dCkEQGM72y1kH8k30Pmn0EDBsSsUIHpcjjGO3QuvYq3Y1Qvgp15itvDF/u7o0njcE5JGZi/vuo5NmfF7TD3TihdYufJ96z6KjMTHY3W3ctEeCMVUU5tlJkI1obnLBHIrALnFPy7/bVCQtwSRLE+CwDhdmGWF4TC9MPET6JId7kDwb660sWYBOsPal0zmje1UxRItlHD7AWJsMlgSiI8utIJRAlkfXzDO/R2cbTcPg5sv7y5uId3TN4ZAMF1p0M1eqIygyrsX5LT11kRGMCRhYhAHGSB2FY8kCT7i28M5z1dg==; s=purelymail3; d=tinyisr.com; v=1; bh=e2xvOUGB6UxohJ6YrHFIKJom9IDsGDwaAtdqSHio/rM=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=YZbh57LSynqYun3aSRaMdqcSdBiTXag+Hhrp+3KWtKt6jSEDpcktWhfiwuQbNy2cTu8hiRPaDEV8v/vQbG0xXKTTS77xx6t/KEiUagxNVsdJIdzxArQl1H2WYGm9kHJ4mLIP9nQhD8DI+eQIXUmQOQhrmrvM0fJhLWjpiUOLGqZsiGcnZsdH4uMGktmCaShq7j4YbwDFKizmjkeCDvRPWZQ/citvXfy7Jx049UvUL7jdB3I8DMRSP/G4IyEVH++b7Qmc4zWJ57bWghXlSHBu50dfjXXupLNOGYbhwI/Y1jqCCVpPzQI4Q52rnlrGcswO2UguEOgx0WyeX6cPIJ4Oew==; s=purelymail3; d=purelymail.com; v=1; bh=e2xvOUGB6UxohJ6YrHFIKJom9IDsGDwaAtdqSHio/rM=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1846076314;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 04 Jul 2026 10:57:52 +0000 (UTC)
From: Joris Vaisvila <joey@tinyisr.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	olteanv@gmail.com,
	Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Joris Vaisvila <joey@tinyisr.com>
Subject: [PATCH net-next v6 4/4] net: dsa: initial support for MT7628 embedded switch
Date: Sat,  4 Jul 2026 13:56:59 +0300
Message-ID: <20260704105659.140970-5-joey@tinyisr.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260704105659.140970-1-joey@tinyisr.com>
References: <20260704105659.140970-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail3,purelymail.com:s=purelymail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304702-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:olteanv@gmail.com,m:andrew@lunn.ch,m:devicetree@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:arinc.unal@arinc9.com,m:Landen.Chao@mediatek.com,m:dqfext@gmail.com,m:sean.wang@mediatek.com,m:daniel@makrotopia.org,m:joey@tinyisr.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch,vger.kernel.org,arinc9.com,mediatek.com,makrotopia.org,tinyisr.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purelymail.com:dkim,tinyisr.com:from_mime,tinyisr.com:email,tinyisr.com:mid,tinyisr.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,openwrt.org:email,nbd.name:email,vittgam.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30B47707610

Add support for the MT7628 embedded switch.

The switch has 5 built-in 100Mbps user ports (ports 0-4) and one 1Gbps
port that is internally attached to the SoCs CPU MAC and serves as the
CPU port.

The switch hardware has a very limited 16 entry VLAN table. Configuring
VLANs is the only way to control switch forwarding. Currently 6 entries
are used by tag_8021q to isolate the ports. Double tag feature is
enabled to force the switch to append the VLAN tag even if the incoming
packet is already tagged, this simulates VLAN-unaware functionality and
simplifies the tagger implementation.

Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
Reviewed-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/Kconfig  |   8 +
 drivers/net/dsa/Makefile |   1 +
 drivers/net/dsa/mt7628.c | 649 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 658 insertions(+)
 create mode 100644 drivers/net/dsa/mt7628.c

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 4ab567c5bbaf..daa1d3d4ba60 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -63,6 +63,14 @@ config NET_DSA_MT7530_MMIO
 =09  are directly mapped into the SoCs register space rather than being
 =09  accessible via MDIO.
=20
+config NET_DSA_MT7628
+=09tristate "MediaTek MT7628 Embedded Ethernet switch support"
+=09select NET_DSA_TAG_MT7628
+=09select MEDIATEK_FE_SOC_PHY
+=09help
+=09  This enables support for the built-in Ethernet switch found
+=09  in the MT7628 SoC.
+
 config NET_DSA_MV88E6060
 =09tristate "Marvell 88E6060 ethernet switch chip support"
 =09select NET_DSA_TAG_TRAILER
diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index d2975badffc0..6ceb78a755d7 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_NET_DSA_KS8995) =09+=3D ks8995.o
 obj-$(CONFIG_NET_DSA_MT7530)=09+=3D mt7530.o
 obj-$(CONFIG_NET_DSA_MT7530_MDIO) +=3D mt7530-mdio.o
 obj-$(CONFIG_NET_DSA_MT7530_MMIO) +=3D mt7530-mmio.o
+obj-$(CONFIG_NET_DSA_MT7628) +=3D mt7628.o
 obj-$(CONFIG_NET_DSA_MV88E6060) +=3D mv88e6060.o
 obj-$(CONFIG_NET_DSA_RZN1_A5PSW) +=3D rzn1_a5psw.o
 obj-$(CONFIG_NET_DSA_SMSC_LAN9303) +=3D lan9303-core.o
diff --git a/drivers/net/dsa/mt7628.c b/drivers/net/dsa/mt7628.c
new file mode 100644
index 000000000000..eccdb05fce9b
--- /dev/null
+++ b/drivers/net/dsa/mt7628.c
@@ -0,0 +1,649 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mediatek MT7628 Embedded Switch (ESW) DSA driver
+ * Copyright (C) 2026 Joris Vaisvila <joey@tinyisr.com>
+ *
+ * Portions derived from OpenWRT esw_rt3050 driver:
+ * Copyright (C) 2009-2015 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2009-2015 Felix Fietkau <nbd@nbd.name>
+ * Copyright (C) 2013-2015 Michael Lee <igvtee@gmail.com>
+ * Copyright (C) 2016 Vittorio Gambaletta <openwrt@vittgam.net>
+ */
+
+#include <linux/platform_device.h>
+#include <linux/etherdevice.h>
+#include <linux/netdevice.h>
+#include <linux/dsa/8021q.h>
+#include <linux/if_bridge.h>
+#include <linux/module.h>
+#include <linux/mdio.h>
+#include <linux/of.h>
+#include <linux/of_mdio.h>
+#include <linux/of_net.h>
+#include <linux/kernel.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <net/dsa.h>
+
+#define MT7628_ESW_REG_IMR 0x04
+#define MT7628_ESW_REG_FCT0 0x08
+#define MT7628_ESW_REG_PFC1 0x14
+#define MT7628_ESW_REG_PVIDC(port) (0x40 + 4 * ((port) / 2))
+#define MT7628_ESW_REG_VLANI(vlan) (0x50 + 4 * ((vlan) / 2))
+#define MT7628_ESW_REG_VMSC(vlan) (0x70 + 4 * ((vlan) / 4))
+#define MT7628_ESW_REG_VUB(vlan) (0x100 + 4 * ((vlan) / 4))
+#define MT7628_ESW_REG_SOCPC 0x8c
+#define MT7628_ESW_REG_POC0 0x90
+#define MT7628_ESW_REG_POC2 0x98
+#define MT7628_ESW_REG_SGC 0x9c
+#define MT7628_ESW_REG_PCR0 0xc0
+#define MT7628_ESW_REG_PCR1 0xc4
+#define MT7628_ESW_REG_FPA2 0xc8
+#define MT7628_ESW_REG_FCT2 0xcc
+#define MT7628_ESW_REG_SGC2 0xe4
+
+#define MT7628_ESW_FCT0_DROP_SET_TH GENMASK(7, 0)
+#define MT7628_ESW_FCT0_DROP_RLS_TH GENMASK(15, 8)
+#define MT7628_ESW_FCT0_FC_SET_TH GENMASK(23, 16)
+#define MT7628_ESW_FCT0_FC_RLS_TH GENMASK(31, 24)
+
+#define MT7628_ESW_PFC1_EN_VLAN GENMASK(22, 16)
+
+#define MT7628_ESW_PVID_S 12
+#define MT7628_ESW_PVID_M GENMASK(11, 0)
+#define MT7628_ESW_PVID_SHIFT(port) \
+=09(MT7628_ESW_PVID_S * ((port) % 2))
+#define MT7628_ESW_PVID_MASK(port) \
+=09(MT7628_ESW_PVID_M << MT7628_ESW_PVID_SHIFT(port))
+#define MT7628_ESW_PVID_PREP(port, pvid) \
+=09(((pvid) & MT7628_ESW_PVID_M) << MT7628_ESW_PVID_SHIFT(port))
+
+#define MT7628_ESW_VID_S 12
+#define MT7628_ESW_VID_M GENMASK(11, 0)
+#define MT7628_ESW_VID_SHIFT(vlan) \
+=09(MT7628_ESW_VID_S * ((vlan) % 2))
+#define MT7628_ESW_VID_MASK(vlan) \
+=09(MT7628_ESW_VID_M << MT7628_ESW_VID_SHIFT(vlan))
+#define MT7628_ESW_VID_PREP(vlan, vid) \
+=09(((vid) & MT7628_ESW_VID_M) << MT7628_ESW_VID_SHIFT(vlan))
+
+#define MT7628_ESW_VMSC_S 8
+#define MT7628_ESW_VMSC_M GENMASK(7, 0)
+#define MT7628_ESW_VMSC_SHIFT(vlan) \
+=09(MT7628_ESW_VMSC_S * ((vlan) % 4))
+#define MT7628_ESW_VMSC_MASK(vlan) \
+=09(MT7628_ESW_VMSC_M << MT7628_ESW_VMSC_SHIFT(vlan))
+#define MT7628_ESW_VMSC_PREP(vlan, vmsc) \
+=09(((vmsc) & MT7628_ESW_VMSC_M) << MT7628_ESW_VMSC_SHIFT(vlan))
+
+#define MT7628_ESW_VUB_S 7
+#define MT7628_ESW_VUB_M GENMASK(6, 0)
+#define MT7628_ESW_VUB_SHIFT(vlan) \
+=09(MT7628_ESW_VUB_S * ((vlan) % 4))
+#define MT7628_ESW_VUB_MASK(vlan) \
+=09(MT7628_ESW_VUB_M << MT7628_ESW_VUB_SHIFT(vlan))
+#define MT7628_ESW_VUB_PREP(vlan, vub) \
+=09(((vub) & MT7628_ESW_VUB_M) << MT7628_ESW_VUB_SHIFT(vlan))
+
+#define MT7628_ESW_SOCPC_CRC_PADDING BIT(25)
+#define MT7628_ESW_SOCPC_DISBC2CPU GENMASK(22, 16)
+#define MT7628_ESW_SOCPC_DISMC2CPU GENMASK(14, 8)
+#define MT7628_ESW_SOCPC_DISUN2CPU GENMASK(6, 0)
+
+#define MT7628_ESW_POC0_PORT_DISABLE GENMASK(29, 23)
+
+#define MT7628_ESW_POC2_PER_VLAN_UNTAG_EN BIT(15)
+
+#define MT7628_ESW_SGC_AGING_INTERVAL GENMASK(3, 0)
+#define MT7628_ESW_BC_STORM_PROT GENMASK(5, 4)
+#define MT7628_ESW_PKT_MAX_LEN GENMASK(7, 6)
+#define MT7628_ESW_DIS_PKT_ABORT BIT(8)
+#define MT7628_ESW_ADDRESS_HASH_ALG GENMASK(10, 9)
+#define MT7628_ESW_DISABLE_TX_BACKOFF BIT(11)
+#define MT7628_ESW_BP_JAM_CNT GENMASK(15, 12)
+#define MT7628_ESW_DISMIIPORT_WASTX GENMASK(17, 16)
+#define MT7628_ESW_BP_MODE GENMASK(19, 18)
+#define MT7628_ESW_BISH_DIS BIT(20)
+#define MT7628_ESW_BISH_TH GENMASK(22, 21)
+#define MT7628_ESW_LED_FLASH_TIME GENMASK(24, 23)
+#define MT7628_ESW_RMC_RULE GENMASK(26, 25)
+#define MT7628_ESW_IP_MULT_RULE GENMASK(28, 27)
+#define MT7628_ESW_LEN_ERR_CHK BIT(29)
+#define MT7628_ESW_BKOFF_ALG BIT(30)
+
+#define MT7628_ESW_PCR0_WT_NWAY_DATA GENMASK(31, 16)
+#define MT7628_ESW_PCR0_RD_PHY_CMD BIT(14)
+#define MT7628_ESW_PCR0_WT_PHY_CMD BIT(13)
+#define MT7628_ESW_PCR0_CPU_PHY_REG GENMASK(12, 8)
+#define MT7628_ESW_PCR0_CPU_PHY_ADDR GENMASK(4, 0)
+
+#define MT7628_ESW_PCR1_RD_DATA GENMASK(31, 16)
+#define MT7628_ESW_PCR1_RD_DONE BIT(1)
+#define MT7628_ESW_PCR1_WT_DONE BIT(0)
+
+#define MT7628_ESW_FPA2_AP_EN BIT(29)
+#define MT7628_ESW_FPA2_EXT_PHY_ADDR_BASE GENMASK(28, 24)
+#define MT7628_ESW_FPA2_FORCE_RGMII_LINK1 BIT(13)
+#define MT7628_ESW_FPA2_FORCE_RGMII_EN1 BIT(11)
+
+#define MT7628_ESW_FCT2_MUST_DROP_RLS_TH GENMASK(17, 13)
+#define MT7628_ESW_FCT2_MUST_DROP_SET_TH GENMASK(12, 8)
+#define MT7628_ESW_FCT2_MC_PER_PORT_TH GENMASK(5, 0)
+
+#define MT7628_ESW_SGC2_SPECIAL_TAG_EN BIT(23)
+#define MT7628_ESW_SGC2_TX_CPU_TPID_BIT_MAP GENMASK(22, 16)
+#define MT7628_ESW_SGC2_DOUBLE_TAG_EN GENMASK(6, 0)
+
+#define MT7628_ESW_PORTS_NOCPU GENMASK(5, 0)
+#define MT7628_ESW_PORTS_CPU BIT(6)
+#define MT7628_ESW_PORTS_ALL GENMASK(6, 0)
+
+#define MT7628_ESW_NUM_PORTS 7
+#define MT7628_NUM_VLANS 16
+
+static const struct regmap_config mt7628_esw_regmap_cfg =3D {
+=09.name =3D "mt7628-esw",
+=09.reg_bits =3D 32,
+=09.val_bits =3D 32,
+=09.reg_stride =3D 4,
+=09.fast_io =3D true,
+=09.reg_format_endian =3D REGMAP_ENDIAN_LITTLE,
+=09.val_format_endian =3D REGMAP_ENDIAN_LITTLE,
+};
+
+struct mt7628_vlan {
+=09bool active;
+=09u8 members;
+=09u8 untag;
+=09u16 vid;
+};
+
+struct mt7628_esw {
+=09struct reset_control *rst_ephy;
+=09struct reset_control *rst_esw;
+=09struct regmap *regmap;
+=09struct dsa_switch *ds;
+=09u16 tag_8021q_pvid[MT7628_ESW_NUM_PORTS];
+=09struct mt7628_vlan vlans[MT7628_NUM_VLANS];
+=09struct device *dev;
+};
+
+static int mt7628_mii_read(struct mii_bus *bus, int port, int regnum)
+{
+=09struct mt7628_esw *esw =3D bus->priv;
+=09int ret;
+=09u32 val;
+
+=09/*
+=09 * RD_DONE bit is read to clear. Read PCR1 once to acknowledge any
+=09 * stale completion indicator before starting a new transaction.
+=09 */
+=09ret =3D regmap_read(esw->regmap, MT7628_ESW_REG_PCR1, &val);
+=09if (ret)
+=09=09goto out;
+
+=09ret =3D regmap_write(esw->regmap, MT7628_ESW_REG_PCR0,
+=09=09=09   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_REG,
+=09=09=09=09      regnum) |
+=09=09=09   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_ADDR,
+=09=09=09=09      port) | MT7628_ESW_PCR0_RD_PHY_CMD);
+=09if (ret)
+=09=09goto out;
+
+=09ret =3D regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,
+=09=09=09=09       (val & MT7628_ESW_PCR1_RD_DONE), 10,
+=09=09=09=09       5000);
+=09if (ret)
+=09=09goto out;
+
+=09return FIELD_GET(MT7628_ESW_PCR1_RD_DATA, val);
+
+out:
+=09dev_err(&bus->dev, "read failed. MDIO timeout?\n");
+=09return ret;
+}
+
+static int mt7628_mii_write(struct mii_bus *bus, int port, int regnum, u16=
 dat)
+{
+=09struct mt7628_esw *esw =3D bus->priv;
+=09u32 val;
+=09int ret;
+
+=09/*
+=09 * WT_DONE bit is read to clear. Read PCR1 once to acknowledge any
+=09 * stale completion indicator before starting a new transaction.
+=09 */
+=09ret =3D regmap_read(esw->regmap, MT7628_ESW_REG_PCR1, &val);
+=09if (ret)
+=09=09goto out;
+
+=09ret =3D regmap_write(esw->regmap, MT7628_ESW_REG_PCR0,
+=09=09=09   FIELD_PREP(MT7628_ESW_PCR0_WT_NWAY_DATA, dat) |
+=09=09=09   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_REG,
+=09=09=09=09      regnum) |
+=09=09=09   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_ADDR,
+=09=09=09=09      port) | MT7628_ESW_PCR0_WT_PHY_CMD);
+=09if (ret)
+=09=09goto out;
+
+=09ret =3D regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,
+=09=09=09=09       (val & MT7628_ESW_PCR1_WT_DONE), 10,
+=09=09=09=09       5000);
+=09if (ret)
+=09=09goto out;
+
+=09return 0;
+
+out:
+=09dev_err(&bus->dev, "write failed. MDIO timeout?\n");
+=09return ret;
+}
+
+static int mt7628_setup_internal_mdio(struct dsa_switch *ds)
+{
+=09struct mt7628_esw *esw =3D ds->priv;
+=09struct device *dev =3D ds->dev;
+=09struct mii_bus *bus;
+
+=09bus =3D devm_mdiobus_alloc(dev);
+=09if (!bus)
+=09=09return -ENOMEM;
+
+=09bus->name =3D "MT7628 internal MDIO bus";
+=09snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mii", dev_name(dev));
+=09bus->priv =3D esw;
+=09bus->read =3D mt7628_mii_read;
+=09bus->write =3D mt7628_mii_write;
+=09bus->parent =3D dev;
+
+=09ds->user_mii_bus =3D bus;
+=09bus->phy_mask =3D ~ds->phys_mii_mask;
+
+=09return devm_mdiobus_register(dev, bus);
+}
+
+static void mt7628_switch_init(struct dsa_switch *ds)
+{
+=09struct mt7628_esw *esw =3D ds->priv;
+
+=09regmap_write(esw->regmap, MT7628_ESW_REG_FCT0,
+=09=09     FIELD_PREP(MT7628_ESW_FCT0_DROP_SET_TH, 0x50) |
+=09=09     FIELD_PREP(MT7628_ESW_FCT0_DROP_RLS_TH, 0x78) |
+=09=09     FIELD_PREP(MT7628_ESW_FCT0_FC_SET_TH, 0xa0) |
+=09=09     FIELD_PREP(MT7628_ESW_FCT0_FC_RLS_TH, 0xc8));
+
+=09regmap_write(esw->regmap, MT7628_ESW_REG_FCT2,
+=09=09     FIELD_PREP(MT7628_ESW_FCT2_MC_PER_PORT_TH, 0xc) |
+=09=09     FIELD_PREP(MT7628_ESW_FCT2_MUST_DROP_SET_TH, 0x10) |
+=09=09     FIELD_PREP(MT7628_ESW_FCT2_MUST_DROP_RLS_TH, 0x12));
+
+=09/*
+=09 * general switch configuration:
+=09 * 300s aging interval
+=09 * broadcast storm prevention disabled
+=09 * max packet length 1536 bytes
+=09 * disable collision 16 packet abort and late collision abort
+=09 * use xor48 for address hashing
+=09 * disable tx backoff
+=09 * 10 packet back pressure jam
+=09 * disable was_transmit
+=09 * jam until BP condition released
+=09 * 30ms LED flash
+=09 * rmc tb fault to all ports
+=09 * unmatched IGMP as broadcast
+=09 */
+=09regmap_write(esw->regmap, MT7628_ESW_REG_SGC,
+=09=09     FIELD_PREP(MT7628_ESW_SGC_AGING_INTERVAL, 1) |
+=09=09     FIELD_PREP(MT7628_ESW_BC_STORM_PROT, 0) |
+=09=09     FIELD_PREP(MT7628_ESW_PKT_MAX_LEN, 0) |
+=09=09     MT7628_ESW_DIS_PKT_ABORT |
+=09=09     FIELD_PREP(MT7628_ESW_ADDRESS_HASH_ALG, 1) |
+=09=09     MT7628_ESW_DISABLE_TX_BACKOFF |
+=09=09     FIELD_PREP(MT7628_ESW_BP_JAM_CNT, 10) |
+=09=09     FIELD_PREP(MT7628_ESW_DISMIIPORT_WASTX, 0) |
+=09=09     FIELD_PREP(MT7628_ESW_BP_MODE, 0b10) |
+=09=09     FIELD_PREP(MT7628_ESW_LED_FLASH_TIME, 0) |
+=09=09     FIELD_PREP(MT7628_ESW_RMC_RULE, 0) |
+=09=09     FIELD_PREP(MT7628_ESW_IP_MULT_RULE, 0));
+
+=09regmap_write(esw->regmap, MT7628_ESW_REG_SOCPC,
+=09=09     MT7628_ESW_SOCPC_CRC_PADDING |
+=09=09     FIELD_PREP(MT7628_ESW_SOCPC_DISUN2CPU,
+=09=09=09=09MT7628_ESW_PORTS_CPU) |
+=09=09     FIELD_PREP(MT7628_ESW_SOCPC_DISMC2CPU,
+=09=09=09=09MT7628_ESW_PORTS_CPU) |
+=09=09     FIELD_PREP(MT7628_ESW_SOCPC_DISBC2CPU,
+=09=09=09=09MT7628_ESW_PORTS_CPU));
+
+=09regmap_set_bits(esw->regmap, MT7628_ESW_REG_FPA2,
+=09=09=09MT7628_ESW_FPA2_FORCE_RGMII_EN1 |
+=09=09=09MT7628_ESW_FPA2_FORCE_RGMII_LINK1 |
+=09=09=09MT7628_ESW_FPA2_AP_EN);
+
+=09regmap_update_bits(esw->regmap, MT7628_ESW_REG_FPA2,
+=09=09=09   MT7628_ESW_FPA2_EXT_PHY_ADDR_BASE,
+=09=09=09   FIELD_PREP(MT7628_ESW_FPA2_EXT_PHY_ADDR_BASE, 31));
+
+=09/* disable all interrupts */
+=09regmap_write(esw->regmap, MT7628_ESW_REG_IMR, 0);
+
+=09/* enable MT7628 DSA tag on CPU port */
+=09regmap_write(esw->regmap, MT7628_ESW_REG_SGC2,
+=09=09     MT7628_ESW_SGC2_SPECIAL_TAG_EN |
+=09=09     FIELD_PREP(MT7628_ESW_SGC2_TX_CPU_TPID_BIT_MAP,
+=09=09=09=09MT7628_ESW_PORTS_CPU));
+
+=09/*
+=09 * Double tag feature allows switch to always append the port PVID VLAN=
 tag
+=09 * regardless of if the incoming packet already has a VLAN tag.
+=09 * This is enabled to simulate VLAN unawareness.
+=09 */
+=09regmap_set_bits(esw->regmap, MT7628_ESW_REG_SGC2,
+=09=09=09FIELD_PREP(MT7628_ESW_SGC2_DOUBLE_TAG_EN,
+=09=09=09=09   MT7628_ESW_PORTS_NOCPU));
+
+=09regmap_set_bits(esw->regmap, MT7628_ESW_REG_POC2,
+=09=09=09MT7628_ESW_POC2_PER_VLAN_UNTAG_EN);
+
+=09regmap_update_bits(esw->regmap, MT7628_ESW_REG_PFC1,
+=09=09=09   MT7628_ESW_PFC1_EN_VLAN,
+=09=09=09   FIELD_PREP(MT7628_ESW_PFC1_EN_VLAN,
+=09=09=09=09      MT7628_ESW_PORTS_ALL));
+}
+
+static void mt7628_esw_set_pvid(struct mt7628_esw *esw, unsigned int port,
+=09=09=09=09unsigned int pvid)
+{
+=09regmap_update_bits(esw->regmap, MT7628_ESW_REG_PVIDC(port),
+=09=09=09   MT7628_ESW_PVID_MASK(port),
+=09=09=09   MT7628_ESW_PVID_PREP(port, pvid));
+}
+
+static void mt7628_esw_set_vlan_id(struct mt7628_esw *esw, unsigned int vl=
an,
+=09=09=09=09   unsigned int vid)
+{
+=09regmap_update_bits(esw->regmap, MT7628_ESW_REG_VLANI(vlan),
+=09=09=09   MT7628_ESW_VID_MASK(vlan),
+=09=09=09   MT7628_ESW_VID_PREP(vlan, vid));
+}
+
+static void mt7628_esw_set_vmsc(struct mt7628_esw *esw, unsigned int vlan,
+=09=09=09=09unsigned int msc)
+{
+=09regmap_update_bits(esw->regmap, MT7628_ESW_REG_VMSC(vlan),
+=09=09=09   MT7628_ESW_VMSC_MASK(vlan),
+=09=09=09   MT7628_ESW_VMSC_PREP(vlan, msc));
+}
+
+static void mt7628_esw_set_vub(struct mt7628_esw *esw, unsigned int vlan,
+=09=09=09       unsigned int vub)
+{
+=09regmap_update_bits(esw->regmap, MT7628_ESW_REG_VUB(vlan),
+=09=09=09   MT7628_ESW_VUB_MASK(vlan),
+=09=09=09   MT7628_ESW_VUB_PREP(vlan, vub));
+}
+
+static void mt7628_vlan_sync(struct dsa_switch *ds)
+{
+=09struct mt7628_esw *esw =3D ds->priv;
+=09int i;
+
+=09for (i =3D 0; i < MT7628_NUM_VLANS; i++) {
+=09=09struct mt7628_vlan *vlan =3D &esw->vlans[i];
+
+=09=09mt7628_esw_set_vmsc(esw, i, vlan->members);
+=09=09mt7628_esw_set_vlan_id(esw, i, vlan->vid);
+=09=09mt7628_esw_set_vub(esw, i, vlan->untag);
+=09}
+
+=09for (i =3D 0; i < ds->num_ports; i++)
+=09=09mt7628_esw_set_pvid(esw, i, esw->tag_8021q_pvid[i]);
+}
+
+static int mt7628_setup(struct dsa_switch *ds)
+{
+=09struct mt7628_esw *esw =3D ds->priv;
+=09int ret;
+
+=09ret =3D reset_control_reset(esw->rst_esw);
+=09if (ret)
+=09=09return ret;
+=09usleep_range(1000, 2000);
+
+=09ret =3D reset_control_reset(esw->rst_ephy);
+=09if (ret)
+=09=09return ret;
+=09usleep_range(1000, 2000);
+=09/*
+=09 * all MMIO reads hang if esw is not out of reset
+=09 * ephy needs extra time to get out of reset or it ends up misconfigure=
d
+=09 */
+
+=09mt7628_switch_init(ds);
+
+=09ret =3D mt7628_setup_internal_mdio(ds);
+=09if (ret)
+=09=09return ret;
+
+=09rtnl_lock();
+=09ret =3D dsa_tag_8021q_register(ds, htons(ETH_P_8021Q));
+=09rtnl_unlock();
+
+=09return ret;
+}
+
+static int mt7628_port_enable(struct dsa_switch *ds, int port,
+=09=09=09      struct phy_device *phy)
+{
+=09struct mt7628_esw *esw =3D ds->priv;
+
+=09regmap_clear_bits(esw->regmap, MT7628_ESW_REG_POC0,
+=09=09=09  FIELD_PREP(MT7628_ESW_POC0_PORT_DISABLE, BIT(port)));
+=09return 0;
+}
+
+static void mt7628_port_disable(struct dsa_switch *ds, int port)
+{
+=09struct mt7628_esw *esw =3D ds->priv;
+
+=09regmap_set_bits(esw->regmap, MT7628_ESW_REG_POC0,
+=09=09=09FIELD_PREP(MT7628_ESW_POC0_PORT_DISABLE, BIT(port)));
+}
+
+static enum dsa_tag_protocol
+mt7628_get_tag_proto(struct dsa_switch *ds, int port, enum dsa_tag_protoco=
l mp)
+{
+=09return DSA_TAG_PROTO_MT7628;
+}
+
+static void mt7628_phylink_get_caps(struct dsa_switch *ds, int port,
+=09=09=09=09    struct phylink_config *config)
+{
+=09switch (port) {
+=09case 6:
+=09=09config->mac_capabilities |=3D MAC_1000;
+=09=09fallthrough;
+=09case 0 ... 4:
+=09=09config->mac_capabilities |=3D MAC_100 | MAC_10;
+=09=09__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+=09=09=09  config->supported_interfaces);
+=09=09break;
+=09default:
+=09=09break;=09=09/* port 5 does not exist on MT7628 */
+=09}
+}
+
+static int mt7628_dsa_8021q_vlan_add(struct dsa_switch *ds, int port,
+=09=09=09=09     u16 vid, u16 flags)
+{
+=09struct mt7628_esw *esw =3D ds->priv;
+=09struct mt7628_vlan *vlan =3D NULL;
+=09int i;
+
+=09for (i =3D 0; i < MT7628_NUM_VLANS; i++) {
+=09=09struct mt7628_vlan *check_vlan =3D &esw->vlans[i];
+
+=09=09if (!check_vlan->active && !vlan)
+=09=09=09vlan =3D check_vlan;
+
+=09=09if (check_vlan->active && check_vlan->vid =3D=3D vid) {
+=09=09=09vlan =3D check_vlan;
+=09=09=09break;
+=09=09}
+=09}
+
+=09if (!vlan)
+=09=09return -ENOSPC;
+
+=09vlan->vid =3D vid;
+=09vlan->active =3D true;
+=09vlan->members |=3D BIT(port);
+
+=09if (flags & BRIDGE_VLAN_INFO_PVID)
+=09=09esw->tag_8021q_pvid[port] =3D vid;
+
+=09if (flags & BRIDGE_VLAN_INFO_UNTAGGED)
+=09=09vlan->untag |=3D BIT(port);
+
+=09mt7628_vlan_sync(ds);
+=09return 0;
+}
+
+static int mt7628_dsa_8021q_vlan_del(struct dsa_switch *ds, int port, u16 =
vid)
+{
+=09struct mt7628_esw *esw =3D ds->priv;
+=09struct mt7628_vlan *vlan =3D NULL;
+=09int i;
+
+=09for (i =3D 0; i < MT7628_NUM_VLANS; i++) {
+=09=09struct mt7628_vlan *check_vlan =3D &esw->vlans[i];
+
+=09=09if (!check_vlan->active || check_vlan->vid !=3D vid)
+=09=09=09continue;
+=09=09vlan =3D check_vlan;
+=09=09break;
+=09}
+=09if (!vlan)
+=09=09return -ENOENT;
+
+=09if (esw->tag_8021q_pvid[port] =3D=3D vid)
+=09=09esw->tag_8021q_pvid[port] =3D 0;
+
+=09vlan->members &=3D ~BIT(port);
+=09vlan->untag &=3D ~BIT(port);
+
+=09if (!vlan->members) {
+=09=09vlan->active =3D false;
+=09=09vlan->vid =3D 0;
+=09}
+
+=09mt7628_vlan_sync(ds);
+=09return 0;
+}
+
+static void mt7628_teardown(struct dsa_switch *ds)
+{
+=09rtnl_lock();
+=09dsa_tag_8021q_unregister(ds);
+=09rtnl_unlock();
+}
+
+static const struct dsa_switch_ops mt7628_switch_ops =3D {
+=09.get_tag_protocol =3D mt7628_get_tag_proto,
+=09.setup =3D mt7628_setup,
+=09.teardown =3D mt7628_teardown,
+=09.port_enable =3D mt7628_port_enable,
+=09.port_disable =3D mt7628_port_disable,
+=09.phylink_get_caps =3D mt7628_phylink_get_caps,
+=09.tag_8021q_vlan_add =3D mt7628_dsa_8021q_vlan_add,
+=09.tag_8021q_vlan_del =3D mt7628_dsa_8021q_vlan_del,
+};
+
+static int mt7628_probe(struct platform_device *pdev)
+{
+=09struct device *dev =3D &pdev->dev;
+=09struct mt7628_esw *esw;
+=09struct dsa_switch *ds;
+=09void __iomem *base;
+
+=09ds =3D devm_kzalloc(&pdev->dev, sizeof(*ds), GFP_KERNEL);
+=09if (!ds)
+=09=09return -ENOMEM;
+
+=09esw =3D devm_kzalloc(&pdev->dev, sizeof(*esw), GFP_KERNEL);
+=09if (!esw)
+=09=09return -ENOMEM;
+
+=09base =3D devm_platform_ioremap_resource(pdev, 0);
+=09if (IS_ERR(base))
+=09=09return PTR_ERR(base);
+
+=09esw->regmap =3D devm_regmap_init_mmio(&pdev->dev, base,
+=09=09=09=09=09    &mt7628_esw_regmap_cfg);
+=09if (IS_ERR(esw->regmap))
+=09=09return PTR_ERR(esw->regmap);
+
+=09esw->rst_ephy =3D devm_reset_control_get_exclusive(&pdev->dev, "ephy");
+=09if (IS_ERR(esw->rst_ephy))
+=09=09return dev_err_probe(dev, PTR_ERR(esw->rst_ephy),
+=09=09=09=09     "failed to get EPHY reset\n");
+
+=09esw->rst_esw =3D devm_reset_control_get_exclusive(&pdev->dev, "esw");
+=09if (IS_ERR(esw->rst_esw))
+=09=09return dev_err_probe(dev, PTR_ERR(esw->rst_esw),
+=09=09=09=09     "failed to get ESW reset\n");
+
+=09ds->dev =3D dev;
+=09ds->num_ports =3D MT7628_ESW_NUM_PORTS;
+=09ds->ops =3D &mt7628_switch_ops;
+=09ds->priv =3D esw;
+=09esw->ds =3D ds;
+=09esw->dev =3D dev;
+=09dev_set_drvdata(dev, esw);
+
+=09return dsa_register_switch(ds);
+}
+
+static void mt7628_remove(struct platform_device *pdev)
+{
+=09struct mt7628_esw *esw =3D platform_get_drvdata(pdev);
+
+=09if (!esw)
+=09=09return;
+
+=09dsa_unregister_switch(esw->ds);
+}
+
+static void mt7628_shutdown(struct platform_device *pdev)
+{
+=09struct mt7628_esw *esw =3D platform_get_drvdata(pdev);
+
+=09if (!esw)
+=09=09return;
+
+=09dsa_switch_shutdown(esw->ds);
+=09dev_set_drvdata(&pdev->dev, NULL);
+}
+
+static const struct of_device_id mt7628_of_match[] =3D {
+=09{ .compatible =3D "mediatek,mt7628-esw" },
+=09{}
+};
+
+MODULE_DEVICE_TABLE(of, mt7628_of_match);
+
+static struct platform_driver mt7628_driver =3D {
+=09.driver =3D {
+=09=09   .name =3D "mt7628-esw",
+=09=09   .of_match_table =3D mt7628_of_match,
+=09=09    },
+=09.probe =3D mt7628_probe,
+=09.remove =3D mt7628_remove,
+=09.shutdown =3D mt7628_shutdown,
+};
+
+module_platform_driver(mt7628_driver);
+
+MODULE_AUTHOR("Joris Vaisvila <joey@tinyisr.com>");
+MODULE_DESCRIPTION("Driver for Mediatek MT7628 embedded switch");
+MODULE_LICENSE("GPL");
--=20
2.54.0


