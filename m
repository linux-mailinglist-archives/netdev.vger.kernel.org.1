Return-Path: <netdev+bounces-98984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5C58D34F1
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 12:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C209BB23ADF
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D804D17B4E7;
	Wed, 29 May 2024 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i90DO7cw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3641383A5
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716980085; cv=none; b=Ms0ixA62osvJuUeBuqFWnoyjWLvDrGRKlD8Am/tlSmCoIx+vZmrVOaAW55/qpDAscA64k8ywiksw7Ajd4XOp4O8Lyynvn2JWV7ckePNgOu2KixrMknMY7RsJiS3/a8+1iF77ZYWt1/QFK0BL+t21snqkQbUeGP9v7cXEcq8b8nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716980085; c=relaxed/simple;
	bh=4V/sresAqPdiTF9fC5C0nQAFIWSRcOBsf41vCnRgJco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gNR+g3uIF5UUvBYdUVGTszufIDmdz1JNROqu3UWueuq1fjmcsS6kcx6SHYqY31HSnDRIYDlXwiJSqMhXfzRJVbjDE7nyly76sm/ZFlJlcPTWr2yeqPrdXRfE2/KuY7b1iOKq3si+fWybuy9RU27AUzcVNTaJYI8O3ZVfgcZggXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i90DO7cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C5AC2BD10;
	Wed, 29 May 2024 10:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716980085;
	bh=4V/sresAqPdiTF9fC5C0nQAFIWSRcOBsf41vCnRgJco=;
	h=From:To:Cc:Subject:Date:From;
	b=i90DO7cwCIp5k/ewVCWkcqRRTWlntjVtb8p1ZdvfOf6PG1cs3WdAZugo/zsfpSeyE
	 yh639arBGg59p5Vl59jkYew8jqvJKhyTzqOlLc8HxGGH07A21HMEDJoGJILSJgfYRX
	 qFRBnwmESeyKc+X3k4dsDFCTUO9XTuv6T6N8B95vHwt+oD4zyNwtRaU5gR0dA4A7B8
	 esEf6ykmGUkeuVX2FysBz0XlPKLuYxhEKJ+X5baV3wPMYOzTIg+Wix5P085Bv9fkVh
	 /vOE7aX836CuX98SDwr3yzJQBLiR5ig5ORK8eh+V0r4APLOlU4ZCuutpw5HZf7pPYB
	 lOMxaT2s4Um2A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: arinc.unal@arinc9.com,
	daniel@makrotopia.org,
	dqfext@gmail.com,
	sean.wang@mediatek.com,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-mediatek@lists.infradead.org,
	lorenzo.bianconi83@gmail.com,
	nbd@nbd.name
Subject: [PATCH net-next] net: dsa: mt7530: Add debugfs support
Date: Wed, 29 May 2024 12:54:37 +0200
Message-ID: <0999545cf558ded50087e174096bb631e59b5583.1716979901.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce debugfs support for mt7530 dsa switch.
Add the capability to read or write device registers through debugfs:

$echo 0x7ffc > regidx
$cat regval
0x75300000

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/dsa/mt7530-mmio.c | 12 +++++++++-
 drivers/net/dsa/mt7530.c      | 41 +++++++++++++++++++++++++++++++++++
 drivers/net/dsa/mt7530.h      |  5 +++++
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530-mmio.c b/drivers/net/dsa/mt7530-mmio.c
index b74a230a3f13..cedb046ea2a3 100644
--- a/drivers/net/dsa/mt7530-mmio.c
+++ b/drivers/net/dsa/mt7530-mmio.c
@@ -60,7 +60,17 @@ mt7988_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
 
-	return dsa_register_switch(priv->ds);
+	ret = dsa_register_switch(priv->ds);
+	if (ret)
+		return ret;
+
+	ret = mt7530_register_debugfs(priv);
+	if (ret) {
+		dsa_unregister_switch(priv->ds);
+		return ret;
+	}
+
+	return 0;
 }
 
 static void mt7988_remove(struct platform_device *pdev)
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 598434d8d6e4..18cb42a771e8 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -3,6 +3,7 @@
  * Mediatek MT7530 DSA Switch driver
  * Copyright (C) 2017 Sean Wang <sean.wang@mediatek.com>
  */
+#include <linux/debugfs.h>
 #include <linux/etherdevice.h>
 #include <linux/if_bridge.h>
 #include <linux/iopoll.h>
@@ -271,6 +272,28 @@ mt7530_clear(struct mt7530_priv *priv, u32 reg, u32 val)
 	mt7530_rmw(priv, reg, val, 0);
 }
 
+static int
+mt7530_reg_set(void *data, u64 val)
+{
+	struct mt7530_priv *priv = data;
+
+	mt7530_write(priv, priv->debugfs_reg, val);
+
+	return 0;
+}
+
+static int
+mt7530_reg_get(void *data, u64 *val)
+{
+	struct mt7530_priv *priv = data;
+
+	*val = mt7530_read(priv, priv->debugfs_reg);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops, mt7530_reg_get, mt7530_reg_set, "0x%08llx\n");
+
 static int
 mt7530_fdb_cmd(struct mt7530_priv *priv, enum mt7530_fdb_cmd cmd, u32 *rsp)
 {
@@ -3218,6 +3241,22 @@ const struct mt753x_info mt753x_table[] = {
 };
 EXPORT_SYMBOL_GPL(mt753x_table);
 
+int
+mt7530_register_debugfs(struct mt7530_priv *priv)
+{
+	priv->debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
+	if (IS_ERR(priv->debugfs_dir))
+		return PTR_ERR(priv->debugfs_dir);
+
+	debugfs_create_u32("regidx", 0600, priv->debugfs_dir,
+			   &priv->debugfs_reg);
+	debugfs_create_file_unsafe("regval", 0600, priv->debugfs_dir, priv,
+				   &fops);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7530_register_debugfs);
+
 int
 mt7530_probe_common(struct mt7530_priv *priv)
 {
@@ -3252,6 +3291,8 @@ EXPORT_SYMBOL_GPL(mt7530_probe_common);
 void
 mt7530_remove_common(struct mt7530_priv *priv)
 {
+	debugfs_remove(priv->debugfs_dir);
+
 	if (priv->irq)
 		mt7530_free_irq(priv);
 
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 2ea4e24628c6..b7568c1c6d5e 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -798,6 +798,8 @@ struct mt753x_info {
  * @create_sgmii:	Pointer to function creating SGMII PCS instance(s)
  * @active_cpu_ports:	Holding the active CPU ports
  * @mdiodev:		The pointer to the MDIO device structure
+ * @debugfs_dir:	Debugfs entry point
+ * @debugfs_reg:	Selected register to read or write through debugfs
  */
 struct mt7530_priv {
 	struct device		*dev;
@@ -825,6 +827,8 @@ struct mt7530_priv {
 	int (*create_sgmii)(struct mt7530_priv *priv);
 	u8 active_cpu_ports;
 	struct mdio_device *mdiodev;
+	struct dentry *debugfs_dir;
+	u32 debugfs_reg;
 };
 
 struct mt7530_hw_vlan_entry {
@@ -861,6 +865,7 @@ static inline void INIT_MT7530_DUMMY_POLL(struct mt7530_dummy_poll *p,
 	p->reg = reg;
 }
 
+int mt7530_register_debugfs(struct mt7530_priv *priv);
 int mt7530_probe_common(struct mt7530_priv *priv);
 void mt7530_remove_common(struct mt7530_priv *priv);
 
-- 
2.45.1


