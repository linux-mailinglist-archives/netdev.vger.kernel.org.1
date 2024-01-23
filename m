Return-Path: <netdev+bounces-65241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD329839B8D
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CAB61F23EB1
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC22487B9;
	Tue, 23 Jan 2024 21:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNoTbq3s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705BC487AE
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047019; cv=none; b=GCuknoxr56SFjiH3bjQ5NeDwVK/+YcYAOtiduA4IRGSxE8Kr4aXacvDcJABqK9z0AOpzq9Gfq90yMmb2rlLvVWlUwkxONHIboWJwN02cbPl9a6jArwM0HqHZACJpZuvbEZKroydtxHK6qA8dbdod4tAsv9kT0lyleGGWA6+aiLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047019; c=relaxed/simple;
	bh=JxlhgfKDAH9pG+T7CbuWIczAu124O8TR8etJzIuzVIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGQUZc7UrCk4kped3Kl47qXO8M6yIqWfCRyrbOCMRz/mswfZAlFZjTRXzjXmldS9iOpGmuLssoBSHPX/ijbZepGPnpvvBR5na8WQvSbNgR1TDXZE5EHaaqduxG4mvoLsMLZjp/WJmFNWiZusPmZp5MEzbc0+5/WKo43e4o1GSHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNoTbq3s; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3627e9f1b40so12017705ab.1
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706047016; x=1706651816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOT+C6LeaBh5H7EKXV1iub7JX9Ztsgpq6Az56Cc9H5k=;
        b=jNoTbq3sIjomgB5b6pPywuob+8xavc3Y5ffg/ferUPBz5MlS8iX3Fj2h2FOYIYTOSh
         0kAKEfuhDHDXPMU+LVthzJCUtUhZEnaw7PeqUsm19BHmAfN5+3SEeLO3SLvjUNPLRsz7
         NnDI9pAZ3PVwwNgyJ9FpZjb7Wdu8ONgLQpYz5KTuWOakgLCjDqve3AoefaRxlaNypUxd
         bZGVTRBYHeEgG1ZHH2YgbW7uAzEjedLhIISeQzaIVCzl29mEzgWT3lxcGT2pJPrPkYAe
         mTtACLyfglzDBseGK/Pj7EHYgt1HBI07IexlYbr53M/GUHO2z0jfXBmuDpmmI45BQr3y
         0cGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706047016; x=1706651816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOT+C6LeaBh5H7EKXV1iub7JX9Ztsgpq6Az56Cc9H5k=;
        b=PvoxVKReeZ4v4sfq9XD9l9DCJDcUPHznWMzzAJePJcZ1myN87D97Z1WjpafahySNRh
         3+sb+Snh0MttJMNMyzggPso32zRpvuBNZFKPWafih/QQK1b0aOoCzL0URYFxnWUUy1Rs
         zYbHLY10fG1/DggyQulzg++FQ19H6wGQg82/V9cIid50bylka/RD2UhghHD0E7LO1boy
         zjwfZfsXv2GYfZ+MsnBPVMjcXBeQbmQ9qsWuVvD43p9t8VzAheD1RB81nuAQDZbJJGNj
         BmXre2GCmhQADaDecab4WrLFHMWz/pSjwThZLVmY+Tlvn/jQ2iAvORoH/anUVcmG36cn
         LKYQ==
X-Gm-Message-State: AOJu0Yw+oGBP5s+qlB6IvIh+NaKWFMlgW/nWFCJaetOlWH81FnOoEshG
	63QO3ECG8C+sPzVeIoibAiGlJZvgRdU329caW0s8rGgMOTX9YHdYaYCeQPrIKNo=
X-Google-Smtp-Source: AGHT+IFjvWlVF5jYNXkSr+otgd1Lc+b1W4omhXkT4Nqy45p5Hz5eMimf/IPPgLshJ4vyQ1VGfPNZAw==
X-Received: by 2002:a92:cc49:0:b0:360:a340:dae5 with SMTP id t9-20020a92cc49000000b00360a340dae5mr486271ilq.31.1706047016652;
        Tue, 23 Jan 2024 13:56:56 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br (177-131-126-82.acessoline.net.br. [177.131.126.82])
        by smtp.gmail.com with ESMTPSA id q17-20020a637511000000b005d43d5a9678sm693738pgc.35.2024.01.23.13.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:56:56 -0800 (PST)
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
Subject: [PATCH net-next v4 02/11] net: dsa: realtek: introduce REALTEK_DSA namespace
Date: Tue, 23 Jan 2024 18:55:54 -0300
Message-ID: <20240123215606.26716-3-luizluca@gmail.com>
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

Create a namespace to group the exported symbols.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek-mdio.c |  2 ++
 drivers/net/dsa/realtek/realtek-smi.c  |  2 ++
 drivers/net/dsa/realtek/rtl8365mb.c    |  2 ++
 drivers/net/dsa/realtek/rtl8366-core.c | 22 +++++++++++-----------
 drivers/net/dsa/realtek/rtl8366rb.c    |  2 ++
 5 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 292e6d087e8b..df214b2f60d1 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -288,3 +288,5 @@ mdio_module_driver(realtek_mdio_driver);
 MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
 MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via MDIO interface");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(REALTEK_DSA);
+
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 755546ed8db6..f628b54de538 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -565,3 +565,5 @@ module_platform_driver(realtek_smi_driver);
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via SMI interface");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(REALTEK_DSA);
+
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index b072045eb154..462d5a9a280e 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -2177,3 +2177,5 @@ EXPORT_SYMBOL_GPL(rtl8365mb_variant);
 MODULE_AUTHOR("Alvin Šipraga <alsi@bang-olufsen.dk>");
 MODULE_DESCRIPTION("Driver for RTL8365MB-VC ethernet switch");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(REALTEK_DSA);
+
diff --git a/drivers/net/dsa/realtek/rtl8366-core.c b/drivers/net/dsa/realtek/rtl8366-core.c
index 59f98d2c8769..7c6520ba3a26 100644
--- a/drivers/net/dsa/realtek/rtl8366-core.c
+++ b/drivers/net/dsa/realtek/rtl8366-core.c
@@ -34,7 +34,7 @@ int rtl8366_mc_is_used(struct realtek_priv *priv, int mc_index, int *used)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rtl8366_mc_is_used);
+EXPORT_SYMBOL_NS_GPL(rtl8366_mc_is_used, REALTEK_DSA);
 
 /**
  * rtl8366_obtain_mc() - retrieve or allocate a VLAN member configuration
@@ -187,7 +187,7 @@ int rtl8366_set_vlan(struct realtek_priv *priv, int vid, u32 member,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(rtl8366_set_vlan);
+EXPORT_SYMBOL_NS_GPL(rtl8366_set_vlan, REALTEK_DSA);
 
 int rtl8366_set_pvid(struct realtek_priv *priv, unsigned int port,
 		     unsigned int vid)
@@ -217,7 +217,7 @@ int rtl8366_set_pvid(struct realtek_priv *priv, unsigned int port,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rtl8366_set_pvid);
+EXPORT_SYMBOL_NS_GPL(rtl8366_set_pvid, REALTEK_DSA);
 
 int rtl8366_enable_vlan4k(struct realtek_priv *priv, bool enable)
 {
@@ -243,7 +243,7 @@ int rtl8366_enable_vlan4k(struct realtek_priv *priv, bool enable)
 	priv->vlan4k_enabled = enable;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rtl8366_enable_vlan4k);
+EXPORT_SYMBOL_NS_GPL(rtl8366_enable_vlan4k, REALTEK_DSA);
 
 int rtl8366_enable_vlan(struct realtek_priv *priv, bool enable)
 {
@@ -265,7 +265,7 @@ int rtl8366_enable_vlan(struct realtek_priv *priv, bool enable)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(rtl8366_enable_vlan);
+EXPORT_SYMBOL_NS_GPL(rtl8366_enable_vlan, REALTEK_DSA);
 
 int rtl8366_reset_vlan(struct realtek_priv *priv)
 {
@@ -290,7 +290,7 @@ int rtl8366_reset_vlan(struct realtek_priv *priv)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rtl8366_reset_vlan);
+EXPORT_SYMBOL_NS_GPL(rtl8366_reset_vlan, REALTEK_DSA);
 
 int rtl8366_vlan_add(struct dsa_switch *ds, int port,
 		     const struct switchdev_obj_port_vlan *vlan,
@@ -345,7 +345,7 @@ int rtl8366_vlan_add(struct dsa_switch *ds, int port,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rtl8366_vlan_add);
+EXPORT_SYMBOL_NS_GPL(rtl8366_vlan_add, REALTEK_DSA);
 
 int rtl8366_vlan_del(struct dsa_switch *ds, int port,
 		     const struct switchdev_obj_port_vlan *vlan)
@@ -389,7 +389,7 @@ int rtl8366_vlan_del(struct dsa_switch *ds, int port,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rtl8366_vlan_del);
+EXPORT_SYMBOL_NS_GPL(rtl8366_vlan_del, REALTEK_DSA);
 
 void rtl8366_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 			 uint8_t *data)
@@ -403,7 +403,7 @@ void rtl8366_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 	for (i = 0; i < priv->num_mib_counters; i++)
 		ethtool_puts(&data, priv->mib_counters[i].name);
 }
-EXPORT_SYMBOL_GPL(rtl8366_get_strings);
+EXPORT_SYMBOL_NS_GPL(rtl8366_get_strings, REALTEK_DSA);
 
 int rtl8366_get_sset_count(struct dsa_switch *ds, int port, int sset)
 {
@@ -417,7 +417,7 @@ int rtl8366_get_sset_count(struct dsa_switch *ds, int port, int sset)
 
 	return priv->num_mib_counters;
 }
-EXPORT_SYMBOL_GPL(rtl8366_get_sset_count);
+EXPORT_SYMBOL_NS_GPL(rtl8366_get_sset_count, REALTEK_DSA);
 
 void rtl8366_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 {
@@ -441,4 +441,4 @@ void rtl8366_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 		data[i] = mibvalue;
 	}
 }
-EXPORT_SYMBOL_GPL(rtl8366_get_ethtool_stats);
+EXPORT_SYMBOL_NS_GPL(rtl8366_get_ethtool_stats, REALTEK_DSA);
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index e3b6a470ca67..baeab5445d99 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -1938,3 +1938,5 @@ EXPORT_SYMBOL_GPL(rtl8366rb_variant);
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Driver for RTL8366RB ethernet switch");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(REALTEK_DSA);
+
-- 
2.43.0


