Return-Path: <netdev+bounces-65250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 354B1839B9A
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6A528AD62
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417FC4A987;
	Tue, 23 Jan 2024 21:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7CdFSw5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF604F605
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047064; cv=none; b=jiJ04TNtwqA3sdrXW2P87sjqNKXEOLFzXbeKP9sKLQ7TaxgRwehsxdtPbbRe67Ov/wT+lAz8modWm833ze2hDm5prm13cyP7PPZ8bNGuX9WEK5sLPqkraq8O/ct52GB0PDaDHozpvOGEAD8PLa/fEaWsLlgnyseUDv76f2kKuYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047064; c=relaxed/simple;
	bh=rQ95yVJFqylTALu1gdEHyaUYJGg4ZYRQB8hCxjrmITc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBLHsRlZJ+wI793W1NoJguYQtDZLXUGTMt9lZhphWF9fdpWn4az/Sro1NHmwarSWbTmXcpL08gPGqtl/Au3N7G9rLsv3WgWbkKeteXo9crqT1/eiD1q+dLiuAfMNrobDvM2UhBQ/MLSdgvf3E5LfYHItsHERGA8mmfckrUzP8I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7CdFSw5; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-20503dc09adso2959368fac.2
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706047058; x=1706651858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPphyBFl2ZkZLekwDj2ZKLqYREeo0SxOjMGIDks01l0=;
        b=j7CdFSw5Rb2OA+cdTPCtWRmmYC5CyLI3I42Ljq7lzh5gK1oA9d40+ncL8lQF7UrKlK
         kUAvt53SQCXWdkXqRw9CsZSZ6luZGlB7g5KR0WgGc+jfs+eyW3DYLMTIYGVky3kKFz6z
         ExypjfDLCqvEvVVLVuK63QoxBEb3I1MFT9MsoW6w05L83UhU7Rxt6wOLoSuLMjH2Dk0X
         VIEjk/fDtDMyLGLGRKx89/D+OMiKv4UaVjfHxVKXw4f3BIMcCwF+LWwa8hIwOdE97q+o
         IjD+QhXBKKHQ19Nfsq85HQ0UUiuy0u5WlE1zZSzX/w+1NygssoU98O6YKHM/OuZMIiLB
         WXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706047058; x=1706651858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPphyBFl2ZkZLekwDj2ZKLqYREeo0SxOjMGIDks01l0=;
        b=fWndVxFJMKvRtxAbEV+5XoLji5gGaPUtKwa8cxeqWnzy1ldDmKqFuujZLoxyTNB2mf
         /962lUtknLKa8h99NBi8mNhrUYUuEfxdJmKiz9VmeF/e5NPKwVLdIGAsCW1RfG8Avn+F
         fmb1QyRrlwZAxxiShHDd5W5ywTLlkJghUSUYzVCLiDzz8qIZb+qG3o8xr75iU378MGBw
         LkI7TLnCdsqAwHutRrwehrf3AebPaUGbx2/GSiM10iRJ23U/biNnUULC9EBpl7U6DXaW
         DdI0YhEdTayhrDoXyFxAkLsiybeDVzYtdugK6RuCwwOGf4aRHqu1waXmg6pNUDcLX1Zy
         rQqQ==
X-Gm-Message-State: AOJu0YxzV4ibN8SwoyzDwxQRsmxNEQm592Izi2bG9pU5zpeBCjH0Uu9h
	s5pv/IbzRCLtnUa0j+ioYfpfhxlB7Aeu66jksqaguoeznDY1pENfPvkVtn/hdvc=
X-Google-Smtp-Source: AGHT+IEwjCtnU8c1WBu09AOyU6D6JCRi+x8GDQMgyntn8cUUCA392/XldVxZvMuJiojwUvsdMx9gIQ==
X-Received: by 2002:a05:6870:344c:b0:210:8e39:9a6c with SMTP id i12-20020a056870344c00b002108e399a6cmr2082787oah.84.1706047058584;
        Tue, 23 Jan 2024 13:57:38 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br (177-131-126-82.acessoline.net.br. [177.131.126.82])
        by smtp.gmail.com with ESMTPSA id q17-20020a637511000000b005d43d5a9678sm693738pgc.35.2024.01.23.13.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:57:37 -0800 (PST)
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
	ansuelsmth@gmail.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH net-next v4 11/11] net: dsa: realtek: embed dsa_switch into realtek_priv
Date: Tue, 23 Jan 2024 18:56:03 -0300
Message-ID: <20240123215606.26716-12-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123215606.26716-1-luizluca@gmail.com>
References: <20240123215606.26716-1-luizluca@gmail.com>
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
 drivers/net/dsa/realtek/realtek-mdio.c |  2 +-
 drivers/net/dsa/realtek/realtek-smi.c  |  2 +-
 drivers/net/dsa/realtek/realtek.h      |  2 +-
 drivers/net/dsa/realtek/rtl8365mb.c    | 12 ++++++------
 drivers/net/dsa/realtek/rtl8366rb.c    |  2 +-
 drivers/net/dsa/realtek/rtl83xx.c      | 16 ++++++----------
 6 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 6415408c337d..cb3bc6219c6c 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -179,7 +179,7 @@ void realtek_mdio_shutdown(struct mdio_device *mdiodev)
 	if (!priv)
 		return;
 
-	dsa_switch_shutdown(priv->ds);
+	dsa_switch_shutdown(&priv->ds);
 
 	dev_set_drvdata(&mdiodev->dev, NULL);
 }
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index b9523ebc7413..eac9ce5d6ae0 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -396,7 +396,7 @@ void realtek_smi_shutdown(struct platform_device *pdev)
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
index d7d3ae4746f6..c9dbe0240ab7 100644
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
index 5084ad151f0f..30ae30cdbea5 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -1675,7 +1675,7 @@ static int rtl8366rb_set_mc_index(struct realtek_priv *priv, int port, int index
 	 * not drop any untagged or C-tagged frames. Make sure to update the
 	 * filtering setting.
 	 */
-	if (dsa_port_is_vlan_filtering(dsa_to_port(priv->ds, port)))
+	if (dsa_port_is_vlan_filtering(dsa_to_port(&priv->ds, port)))
 		ret = rtl8366rb_drop_untagged(priv, port, !pvid_enabled);
 
 	return ret;
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 2f39472a44d2..ac8c632263c6 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -223,16 +223,12 @@ int rtl83xx_register_switch(struct realtek_priv *priv)
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
@@ -257,7 +253,7 @@ void rtl83xx_remove(struct realtek_priv *priv)
 	if (!priv)
 		return;
 
-	dsa_unregister_switch(priv->ds);
+	dsa_unregister_switch(&priv->ds);
 
 	/* leave the device reset asserted */
 	if (priv->reset)
-- 
2.43.0


