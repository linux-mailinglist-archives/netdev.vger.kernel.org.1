Return-Path: <netdev+bounces-267744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADOPBiR6tWn80wAAu9opvQ
	(envelope-from <netdev+bounces-267744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:09:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4A228D9E2
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60001300F5B2
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 15:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1270637DE8B;
	Sat, 14 Mar 2026 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="sQVSUp5z";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="fi0U4wcS"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCF737D126
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773500959; cv=none; b=fymoV8xRhLyOZAWIkzu745tRIFXsE+Wf7EBVX8YQlwCGLrOkxuiJQ0ImnvydzInluIPvokalCgG4H6GGXCWdrjp7qaONsqt0G3dKzCV+TigtekV5itAoQNlGcwqoWS2jCOUcdSJMRJ/q/8eExV21a7EgD5KvT+TgXWN8Nesm/8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773500959; c=relaxed/simple;
	bh=2Ca3YNdwpDnLyQzbc0yrblbnQsf2cpv7gY/YMT1h01A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIWWu1/vH8+9Rg4ZijsuScpJaJYG+bxRCwxxJjn2w2REgXGja/wn2ACHpKgG4gRs8BK/8fRp059Xm8TP9K+WWZkhbquca96gjK8PA1rzFbuzxFjR+81JTEd0xW/SL08RGAG0lbb6oP7+lWlrFjFa+ugWTM/NaN/851ug/mObvGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=sQVSUp5z; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=fi0U4wcS; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=sQVSUp5zTIf9Rqk95P6CT6G5zXhirHovxUk4dyhuVLLUZ8wRd4i1y9dbKIFvJnGJuali3H1wIAw7b3smLaXB56TdSX+Gf0Uqfl/jx2oxqE29fJnV083VEs5d65+Rl/6yeEn+bAGeEIlAVWTpvdDfHM5BH9o3DcwKweuV31cTKP+aU2lNU7ayjkXRT8W9vOYu98S/ccbrQ5r0lWCrKqUMwiadPFnM60qtM8e9yqwHEhcl/8KBvqI4B7vIzqwY+CA92l7Qjdkwv8xqTztVmG2HmGGbjJx1kXnYpqnc42B/2WPmq9tyTSSYo8+psXXt+QI28vDDeoZXffB0poVik0h4QA==; s=purelymail2; d=tinyisr.com; v=1; bh=2Ca3YNdwpDnLyQzbc0yrblbnQsf2cpv7gY/YMT1h01A=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=fi0U4wcSjsRmKN+8XYxqxdBJZcf5sxwD6CrAJG+MBLYEFAbxGzUkG/tYVV2oibhcTAIaDClzg4OWojGl4KGXiJUniRXGRePv7juYskKEAYHNOgErVe2MDOxwpmvTFqeE8Tz1Mb7D5kxzSfJff5tHtQLWIqLa2ur1lnvNjZ4mNYv9zNhILVvCQwkf20I2VNwlvcs/Xlyu3/xbHG3mRNv0nNjYWPgZyXIxGtZcfx7W4U3qhJZcynovenSa4S07ystvi8eKHpjJ0ESP/BuXhcAasYLIb4gPMUqyTY3o/2OIeXdhjYAh8zcjLoFRdnI5mwxkkZOKf7ggh+zviG3cycNdcg==; s=purelymail2; d=purelymail.com; v=1; bh=2Ca3YNdwpDnLyQzbc0yrblbnQsf2cpv7gY/YMT1h01A=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2038631184;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 14 Mar 2026 15:09:15 +0000 (UTC)
From: Joris Vaisvila <joey@tinyisr.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	olteanv@gmail.com,
	Andrew Lunn <andrew@lunn.ch>,
	Joris Vaisvila <joey@tinyisr.com>
Subject: [RFC v2 1/3] net: phy: mediatek: add phy driver for MT7628 built-in Fast Ethernet PHYs
Date: Sat, 14 Mar 2026 17:08:43 +0200
Message-ID: <20260314150845.653866-2-joey@tinyisr.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260314150845.653866-1-joey@tinyisr.com>
References: <20260314150845.653866-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail2,purelymail.com:s=purelymail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch,tinyisr.com];
	TAGGED_FROM(0.00)[bounces-267744-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tinyisr.com:dkim,tinyisr.com:email,tinyisr.com:mid,purelymail.com:dkim]
X-Rspamd-Queue-Id: DC4A228D9E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Fast Ethernet PHYs present in the MT7628 SoCs require an
undocumented bit to be set before they can establish 100mbps links.

This commit adds the Kconfig option MEDIATEK_FE_SOC_PHY and the
corresponding driver mtk-fe-soc.c.

Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
---
 drivers/net/phy/mediatek/Kconfig      |  6 +++
 drivers/net/phy/mediatek/Makefile     |  1 +
 drivers/net/phy/mediatek/mtk-fe-soc.c | 54 +++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)
 create mode 100644 drivers/net/phy/mediatek/mtk-fe-soc.c

diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kc=
onfig
index bb7dc876271e..62355d46cb1e 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -36,5 +36,11 @@ config MEDIATEK_GE_SOC_PHY
 =09  present in the SoCs efuse and will dynamically calibrate VCM
 =09  (common-mode voltage) during startup.
=20
+config MEDIATEK_FE_SOC_PHY
+=09tristate "MediaTek MT7628 SoC Ethernet PHYs"
+=09select PHY_PACKAGE
+=09help
+=09  Support for MediaTek MT7628 built-in Fast Ethernet PHYs.
+
 config MTK_NET_PHYLIB
 =09tristate
diff --git a/drivers/net/phy/mediatek/Makefile b/drivers/net/phy/mediatek/M=
akefile
index ac57ecc799fc..54cea813c7ad 100644
--- a/drivers/net/phy/mediatek/Makefile
+++ b/drivers/net/phy/mediatek/Makefile
@@ -2,4 +2,5 @@
 obj-$(CONFIG_MEDIATEK_2P5GE_PHY)=09+=3D mtk-2p5ge.o
 obj-$(CONFIG_MEDIATEK_GE_PHY)=09=09+=3D mtk-ge.o
 obj-$(CONFIG_MEDIATEK_GE_SOC_PHY)=09+=3D mtk-ge-soc.o
+obj-$(CONFIG_MEDIATEK_FE_SOC_PHY)=09+=3D mtk-fe-soc.o
 obj-$(CONFIG_MTK_NET_PHYLIB)=09=09+=3D mtk-phy-lib.o
diff --git a/drivers/net/phy/mediatek/mtk-fe-soc.c b/drivers/net/phy/mediat=
ek/mtk-fe-soc.c
new file mode 100644
index 000000000000..4e6ec402296d
--- /dev/null
+++ b/drivers/net/phy/mediatek/mtk-fe-soc.c
@@ -0,0 +1,54 @@
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
+=09=09.config_intr =3D genphy_no_config_intr,
+=09=09.handle_interrupt =3D genphy_handle_interrupt_no_ack,
+=09=09.suspend =3D genphy_suspend,
+=09=09.resume =3D genphy_resume,
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


