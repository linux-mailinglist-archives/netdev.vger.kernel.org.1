Return-Path: <netdev+bounces-272248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJc2FBCcxWnP/wQAu9opvQ
	(envelope-from <netdev+bounces-272248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:50:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F3233B915
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86637308DDB2
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE133A6F0B;
	Thu, 26 Mar 2026 20:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="NBkVZArV";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="CfAQsauh"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6100C3A7585
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557912; cv=none; b=lcU2DZwpLgWCj/Qo78y1QhQx0PO1/OIHcEvcNzVKYCAHWW2hh+14bpQJQ0M2DabrcrN7H8PVB121Rry1adjF6VS3yDoZI2uBRjQ2gnm2IW0iWXKzIWT3NQXIs8pq0CjnUeySiRJyY+LvitKbyhwflz/X4Cmmxyjs895WtIdCjJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557912; c=relaxed/simple;
	bh=UVGTkL9ok5W1QfwaA+6IjrabqWEP58upZp8CyzRNJYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USaRjZMTVcVpVF1tDJVrDLdqnje6psY2A4WCt6h86a50yQG/fhUZFHm0E+35vyufKkYhnpYFaHaBD58Ta2olJG5zporXjwZNWs3UysY4sxXoqs0x06ohg4tz9pTn9pMR6xiEFTHi52QagJ3vAKau3wss/xDPPDEE41RgFFgob7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=NBkVZArV; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=CfAQsauh; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=NBkVZArVmBknKGf7i0q8zehOSVQy6pFVZJMKHgZSVbiF0Cn0qNMmHt5qZ5nl1ylSqjLibt1leqDntv6SW/E0fYTK8Tkp6NDFn2a5TNDCz2aInbPjRWTwDJUm/TYzfiSxepXBAmHPtB3II+LtxurOgZ3WS+QtWxbHdZvZaUnv131qph+qc2oqZscocT85UrmgGPkQlVxDmHhYd2zKUvgyAe7KqiP6TzAiQcL4/QMswF3nek2f2JZQ1K9EENQD2eUXHG1lF3VdCu/CNMkbZjJRRIo8hgd8UIuINTc7GbOmI0WJ8vN+9D2+2kqtZCwZZdthD6vLsf5MNuDktQgrTSfL1Q==; s=purelymail1; d=tinyisr.com; v=1; bh=UVGTkL9ok5W1QfwaA+6IjrabqWEP58upZp8CyzRNJYA=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=CfAQsauhyYO2b08TnmfigV8C3StnQl4txJF7AYyrsP9aASPrAioK3s6FW8lR/AoNEhZA4acn6r1mwETniGGwMRkAg0qqTSR3zfLLaDO7bpBuJZkiZdPSz9w1cYNksHATnmATJJK78m0fb0Z7+Wc+qBRai5ua8bogXrzxBm2Wdml9X+xM+gRlD6CFBtpIekPa2LUgf4dzDvLB9Re9F1hfZf3xvhMHv2RkVZLeHZt08zWvf8AXfRBL7L/IB7rUEXoxkfJ+NGCcLP9pjuh8xJJDNaOgnACYfYyoHZuv5Ci5Xf6qtwAI2RqsfuxvmbVAc29kPrjLX2sdnez3OYqoT0/yXQ==; s=purelymail1; d=purelymail.com; v=1; bh=UVGTkL9ok5W1QfwaA+6IjrabqWEP58upZp8CyzRNJYA=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1206586277;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 26 Mar 2026 20:44:34 +0000 (UTC)
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
	Joris Vaisvila <joey@tinyisr.com>
Subject: [PATCH net-next 2/4] net: phy: mediatek: add phy driver for MT7628 built-in Fast Ethernet PHYs
Date: Thu, 26 Mar 2026 22:44:11 +0200
Message-ID: <20260326204413.3317584-3-joey@tinyisr.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326204413.3317584-1-joey@tinyisr.com>
References: <20260326204413.3317584-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail1,purelymail.com:s=purelymail1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272248-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch,vger.kernel.org,tinyisr.com];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tinyisr.com:dkim,tinyisr.com:email,tinyisr.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,purelymail.com:dkim]
X-Rspamd-Queue-Id: C4F3233B915
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Fast Ethernet PHYs present in the MT7628 SoCs require an
undocumented bit to be set before they can establish 100mbps links.

This commit adds the Kconfig option MEDIATEK_FE_SOC_PHY and the
corresponding driver mtk-fe-soc.c.

Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
---
 drivers/net/phy/mediatek/Kconfig      | 10 +++++-
 drivers/net/phy/mediatek/Makefile     |  1 +
 drivers/net/phy/mediatek/mtk-fe-soc.c | 50 +++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/mediatek/mtk-fe-soc.c

diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kc=
onfig
index bb7dc876271e..b6a51f38c358 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -21,8 +21,16 @@ config MEDIATEK_GE_PHY
 =09  common operations with MediaTek SoC built-in Gigabit
 =09  Ethernet PHYs.
=20
+config MEDIATEK_FE_SOC_PHY
+=09tristate "MediaTek SoC Fast Ethernet PHYs"
+=09help
+=09  Support for MediaTek MT7628 built-in Fast Ethernet PHYs.
+=09  This driver only sets an initialization bit required for the PHY
+=09  to establish 100 Mbps links. All other PHY operations are handled
+=09  by the kernel's generic PHY code.
+
 config MEDIATEK_GE_SOC_PHY
-=09tristate "MediaTek SoC Ethernet PHYs"
+=09tristate "MediaTek SoC Gigabit Ethernet PHYs"
 =09depends on ARM64 || COMPILE_TEST
 =09depends on ARCH_AIROHA || (ARCH_MEDIATEK && NVMEM_MTK_EFUSE) || \
 =09=09   COMPILE_TEST
diff --git a/drivers/net/phy/mediatek/Makefile b/drivers/net/phy/mediatek/M=
akefile
index ac57ecc799fc..6f9cacf7f906 100644
--- a/drivers/net/phy/mediatek/Makefile
+++ b/drivers/net/phy/mediatek/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_MEDIATEK_2P5GE_PHY)=09+=3D mtk-2p5ge.o
+obj-$(CONFIG_MEDIATEK_FE_SOC_PHY)=09+=3D mtk-fe-soc.o
 obj-$(CONFIG_MEDIATEK_GE_PHY)=09=09+=3D mtk-ge.o
 obj-$(CONFIG_MEDIATEK_GE_SOC_PHY)=09+=3D mtk-ge-soc.o
 obj-$(CONFIG_MTK_NET_PHYLIB)=09=09+=3D mtk-phy-lib.o
diff --git a/drivers/net/phy/mediatek/mtk-fe-soc.c b/drivers/net/phy/mediat=
ek/mtk-fe-soc.c
new file mode 100644
index 000000000000..317944411fbe
--- /dev/null
+++ b/drivers/net/phy/mediatek/mtk-fe-soc.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for MT7628 Embedded Switch internal Fast Ethernet PHYs
+ */
+#include <linux/module.h>
+#include <linux/phy.h>
+
+#define MTK_FPHY_ID_MT7628=090x03a29410
+#define MTK_EXT_PAGE_ACCESS=090x1f
+
+static int mt7628_phy_read_page(struct phy_device *phydev)
+{
+=09return __phy_read(phydev, MTK_EXT_PAGE_ACCESS);
+}
+
+static int mt7628_phy_write_page(struct phy_device *phydev, int page)
+{
+=09return __phy_write(phydev, MTK_EXT_PAGE_ACCESS, page);
+}
+
+static int mt7628_phy_config_init(struct phy_device *phydev)
+{
+=09/*
+=09 * This undocumented bit is required for the PHYs to be able to
+=09 * establish 100mbps links.
+=09 */
+=09return phy_write_paged(phydev, 0x8000, 30, BIT(13));
+}
+
+static struct phy_driver mtk_soc_fe_phy_driver[] =3D {
+=09{
+=09=09PHY_ID_MATCH_EXACT(MTK_FPHY_ID_MT7628),
+=09=09.name =3D "MediaTek MT7628 PHY",
+=09=09.config_init =3D mt7628_phy_config_init,
+=09=09.read_page =3D mt7628_phy_read_page,
+=09=09.write_page =3D mt7628_phy_write_page,
+=09},
+};
+
+module_phy_driver(mtk_soc_fe_phy_driver);
+static const struct mdio_device_id __maybe_unused mtk_soc_fe_phy_tbl[] =3D=
 {
+=09{ PHY_ID_MATCH_EXACT(MTK_FPHY_ID_MT7628) },
+=09{ }
+};
+
+MODULE_DESCRIPTION("MediaTek SoC Fast Ethernet PHY driver");
+MODULE_AUTHOR("Joris Vaisvila <joey@tinyisr.com>");
+MODULE_LICENSE("GPL");
+
+MODULE_DEVICE_TABLE(mdio, mtk_soc_fe_phy_tbl);
--=20
2.53.0


