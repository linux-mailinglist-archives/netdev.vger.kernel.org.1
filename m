Return-Path: <netdev+bounces-60002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2774181D0E2
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 01:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22EF51C22740
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 00:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387E1384;
	Sat, 23 Dec 2023 00:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfAA3umn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04E117C9
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 00:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7b7fbe3db16so94411539f.3
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 16:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703292846; x=1703897646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kc5wN80BR2U8GV+88Z/d9P5IYzQQTezbGgSZQA3Aei8=;
        b=lfAA3umnP/8fZ14Yei4vJpFTuEWZk/qx0hsMhXuVzvY8y2Xe1hmEJWtjkOVD+UoEPv
         hvpJB+zVW5Anl5SSKH167ZFG3skaPGTl8V9gVLcT6bxH8+iOLA31lQlymmTvFpOmEWOq
         wUnibBMeJWlchtmkEcHZ+A6DHYXACpu2yDMbyhJ/0aa4gE9fiauGeYBwTZ73McA16V5G
         Yr6rC3U4+itcFP64Xa13gkQl1LFxgCbf38v9uxc7epPTjOHy5Ys6TCeaK1UNLXiwmyhi
         igDOv/9EW9OmJbj3oaI46IsWe8T4BkVTzTjX8OpWdvKY+DqCoW2GbJvMFroK8lU2hFmn
         EMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703292846; x=1703897646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kc5wN80BR2U8GV+88Z/d9P5IYzQQTezbGgSZQA3Aei8=;
        b=S6H0FVBcJLaeeMmBRzbDkxqSapNsMO9jvq03RMaHRFmH17mFxydnow+5zC8oRpG83l
         5JLEA2Bd4P1O5vpWk4ySXnkCBPhryTl3hKO1LVr4vhg+Hr3tl2rQVk1JbO0NIr2eT9rF
         Ff1DbwIbYqLLTSYGrC/mOoTwej7x6AsLVMwoRgG/vffOMSS7aL+vdnncMjYgkkvvQSgX
         kAhpeGq1NyFveVE83jV9nujnTJ4URBw4CcCw+XUbiQPkDooOG3HRUQOEh3/yX9YDX0LY
         aFAs06MyPcweQwvpD5NanOZzPJiRbaF2De9cdTuT06jxo8dNGedBUA/occouI1NuJKMM
         sIxQ==
X-Gm-Message-State: AOJu0Yypmpnd2uvRb63AhdXrlgdcSzet1fwmLp/7ZPWNqsxlBSNu2dqT
	pLsN9OtlsrpyNUP7jnywmbadXZFmgxUxfv/+
X-Google-Smtp-Source: AGHT+IGv2LY1ep6JaG8+d7/Ipme4hqlAoWpIdbhAjB4kjMtxI1oFHZqF50YdubJNCbw8Y+Gilv6H7g==
X-Received: by 2002:a6b:6114:0:b0:7b9:c344:6e77 with SMTP id v20-20020a6b6114000000b007b9c3446e77mr2559960iob.8.1703292845908;
        Fri, 22 Dec 2023 16:54:05 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id iz11-20020a170902ef8b00b001d076c2e336sm4028257plb.100.2023.12.22.16.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 16:54:05 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	arinc.unal@arinc9.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH net-next v3 7/8] net: dsa: realtek: embed dsa_switch into realtek_priv
Date: Fri, 22 Dec 2023 21:46:35 -0300
Message-ID: <20231223005253.17891-8-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223005253.17891-1-luizluca@gmail.com>
References: <20231223005253.17891-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To eliminate the need for a second memory allocation for dsa_switch, it
has been embedded within realtek_priv.

Suggested-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek-common.c | 16 ++++++----------
 drivers/net/dsa/realtek/realtek-mdio.c   |  2 +-
 drivers/net/dsa/realtek/realtek-smi.c    |  2 +-
 drivers/net/dsa/realtek/realtek.h        |  2 +-
 drivers/net/dsa/realtek/rtl8365mb.c      | 12 ++++++------
 drivers/net/dsa/realtek/rtl8366rb.c      |  2 +-
 6 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-common.c b/drivers/net/dsa/realtek/realtek-common.c
index 03fbc80f42b4..99c9270fd3e7 100644
--- a/drivers/net/dsa/realtek/realtek-common.c
+++ b/drivers/net/dsa/realtek/realtek-common.c
@@ -155,16 +155,12 @@ int realtek_common_register_switch(struct realtek_priv *priv)
 		return ret;
 	}
 
-	priv->ds = devm_kzalloc(priv->dev, sizeof(*priv->ds), GFP_KERNEL);
-	if (!priv->ds)
-		return -ENOMEM;
+	priv->ds.priv = priv;
+	priv->ds.dev = priv->dev;
+	priv->ds.ops = priv->variant->ds_ops;
+	priv->ds.num_ports = priv->num_ports;
 
-	priv->ds->priv = priv;
-	priv->ds->dev = priv->dev;
-	priv->ds->ops = priv->variant->ds_ops;
-	priv->ds->num_ports = priv->num_ports;
-
-	ret = dsa_register_switch(priv->ds);
+	ret = dsa_register_switch(&priv->ds);
 	if (ret) {
 		dev_err_probe(priv->dev, ret, "unable to register switch\n");
 		return ret;
@@ -179,7 +175,7 @@ void realtek_common_remove(struct realtek_priv *priv)
 	if (!priv)
 		return;
 
-	dsa_unregister_switch(priv->ds);
+	dsa_unregister_switch(&priv->ds);
 
 	if (priv->user_mii_bus)
 		of_node_put(priv->user_mii_bus->dev.of_node);
diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index e2b5432eeb26..0305b2f69b41 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -166,7 +166,7 @@ void realtek_mdio_shutdown(struct mdio_device *mdiodev)
 	if (!priv)
 		return;
 
-	dsa_switch_shutdown(priv->ds);
+	dsa_switch_shutdown(&priv->ds);
 
 	dev_set_drvdata(&mdiodev->dev, NULL);
 }
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 383689163057..fa5a4c5e4210 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -383,7 +383,7 @@ void realtek_smi_shutdown(struct platform_device *pdev)
 	if (!priv)
 		return;
 
-	dsa_switch_shutdown(priv->ds);
+	dsa_switch_shutdown(&priv->ds);
 
 	platform_set_drvdata(pdev, NULL);
 }
diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 7af6dcc1bb24..0217b8032c01 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -59,7 +59,7 @@ struct realtek_priv {
 	int			mdio_addr;
 
 	spinlock_t		lock; /* Locks around command writes */
-	struct dsa_switch	*ds;
+	struct dsa_switch	ds;
 	struct irq_domain	*irqdomain;
 	bool			leds_disabled;
 
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 81ec8f6f69c6..e710b636042e 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -880,7 +880,7 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
 	if (!extint)
 		return -ENODEV;
 
-	dp = dsa_to_port(priv->ds, port);
+	dp = dsa_to_port(&priv->ds, port);
 	dn = dp->dn;
 
 	/* Set the RGMII TX/RX delay
@@ -1543,7 +1543,7 @@ static void rtl8365mb_stats_setup(struct realtek_priv *priv)
 	for (i = 0; i < priv->num_ports; i++) {
 		struct rtl8365mb_port *p = &mb->ports[i];
 
-		if (dsa_is_unused_port(priv->ds, i))
+		if (dsa_is_unused_port(&priv->ds, i))
 			continue;
 
 		/* Per-port spinlock to protect the stats64 data */
@@ -1564,7 +1564,7 @@ static void rtl8365mb_stats_teardown(struct realtek_priv *priv)
 	for (i = 0; i < priv->num_ports; i++) {
 		struct rtl8365mb_port *p = &mb->ports[i];
 
-		if (dsa_is_unused_port(priv->ds, i))
+		if (dsa_is_unused_port(&priv->ds, i))
 			continue;
 
 		cancel_delayed_work_sync(&p->mib_work);
@@ -1963,7 +1963,7 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 		dev_info(priv->dev, "no interrupt support\n");
 
 	/* Configure CPU tagging */
-	dsa_switch_for_each_cpu_port(cpu_dp, priv->ds) {
+	dsa_switch_for_each_cpu_port(cpu_dp, &priv->ds) {
 		cpu->mask |= BIT(cpu_dp->index);
 
 		if (cpu->trap_port == RTL8365MB_MAX_NUM_PORTS)
@@ -1978,7 +1978,7 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	for (i = 0; i < priv->num_ports; i++) {
 		struct rtl8365mb_port *p = &mb->ports[i];
 
-		if (dsa_is_unused_port(priv->ds, i))
+		if (dsa_is_unused_port(&priv->ds, i))
 			continue;
 
 		/* Forward only to the CPU */
@@ -1995,7 +1995,7 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 		 * ports will still forward frames to the CPU despite being
 		 * administratively down by default.
 		 */
-		rtl8365mb_port_stp_state_set(priv->ds, i, BR_STATE_DISABLED);
+		rtl8365mb_port_stp_state_set(&priv->ds, i, BR_STATE_DISABLED);
 
 		/* Set up per-port private data */
 		p->priv = priv;
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 56619aa592ec..f5b32c77db7f 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -1662,7 +1662,7 @@ static int rtl8366rb_set_mc_index(struct realtek_priv *priv, int port, int index
 	 * not drop any untagged or C-tagged frames. Make sure to update the
 	 * filtering setting.
 	 */
-	if (dsa_port_is_vlan_filtering(dsa_to_port(priv->ds, port)))
+	if (dsa_port_is_vlan_filtering(dsa_to_port(&priv->ds, port)))
 		ret = rtl8366rb_drop_untagged(priv, port, !pvid_enabled);
 
 	return ret;
-- 
2.43.0


