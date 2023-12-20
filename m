Return-Path: <netdev+bounces-59147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9378197CA
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 05:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F63284A3A
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 04:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6806EC128;
	Wed, 20 Dec 2023 04:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIr9ka/r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6DFFBE0
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 04:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9338bc11fso1207711b3a.1
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 20:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703046436; x=1703651236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kIW0Cf3SJjyvqLsTMwL5XxQayNH2PxqL5+IfUjcdIo=;
        b=nIr9ka/rjAKxLlSlht3LHl0aacF7t1pWY4bFAE6rWRiBGnfCgvS3xjtSjPwE35X+XD
         KuUxOeNderNKQ84ili2EG4gbFC1cRxpcl/8BcWJAf5G3p479dNkk2Wo1tt0XLh124s8Z
         lUATFpauW49vylYIP8tG2ORw03ln25DKYbYhJYJALBF7BjTMxYOqD5lg9KEQeHCYj4Bv
         HVejnO+vhoFgVwsnODz1CKh++CyxN8cwKFdlUkKMUkhOUqeBG9hklnv3vCIljtQOTOaa
         SydZEPsbELkRhDos3rKNwD2C/gjxipuhbci5Ee55doU1MSUBsNI15fl1yVwwh7EEfxbi
         BDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703046436; x=1703651236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kIW0Cf3SJjyvqLsTMwL5XxQayNH2PxqL5+IfUjcdIo=;
        b=f9L5+C16o/XFVmlrZtHKnogyv1JonXscsqdR0OisL9g+USwrUEPC/x6JsOJamekBpl
         ULzYplropzeLoW9yumvQ7Wqv/HENjYWsF52wGpUO4SFzdgW/J9X86zgMtAsWw8IEfpvv
         Lko8arqzMGYUbRk55+dNQe62IXMlm8hzpmxyb/hcrOYjhm+wDCxX34QLPgF605PNxr0N
         Eu1HZBBKthFp4ABiJGp4Uv4RP78cNDMDS6DglzMyDoGo59gGNNFymU9/EMr0tATgpAMp
         sa8DJaol1jFLfQSb0o0cDT6//cpMZGyV4ffoan20eTtCQ5Mb6K9NsfWdvKYqrEkPAgvo
         7AZg==
X-Gm-Message-State: AOJu0YxX/bX6/L27Kq5sVXCWj28w1b15P25CNGgV5CMm517c9jdsulrz
	BCHEk/ht2I3nuT1WFm37NGCR7xQr5MajdUmc
X-Google-Smtp-Source: AGHT+IFEdRbXhs/78Wa5nU7saCsJhEJqhfLrLEmhCm/l4mSBOsIAmqSlIo+7yf1ucsvC1j9OGqsAbA==
X-Received: by 2002:a05:6a00:888:b0:6d0:89be:e4aa with SMTP id q8-20020a056a00088800b006d089bee4aamr21656548pfj.37.1703046436303;
        Tue, 19 Dec 2023 20:27:16 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id ei3-20020a056a0080c300b006d46af912a7sm6325554pfb.23.2023.12.19.20.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 20:27:15 -0800 (PST)
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
Subject: [PATCH net-next v2 6/7] net: dsa: realtek: embed dsa_switch into realtek_priv
Date: Wed, 20 Dec 2023 01:24:29 -0300
Message-ID: <20231220042632.26825-7-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220042632.26825-1-luizluca@gmail.com>
References: <20231220042632.26825-1-luizluca@gmail.com>
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
index b1f0095d5bce..5c3efbcd6449 100644
--- a/drivers/net/dsa/realtek/realtek-common.c
+++ b/drivers/net/dsa/realtek/realtek-common.c
@@ -182,16 +182,12 @@ int realtek_common_register_switch(struct realtek_priv *priv)
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
@@ -206,7 +202,7 @@ void realtek_common_remove(struct realtek_priv *priv)
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
index e890ad113ba3..b05cf6fb56c0 100644
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


