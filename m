Return-Path: <netdev+bounces-65227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A03C839B4D
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E72286204
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A6E3A8F5;
	Tue, 23 Jan 2024 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHQ42DCm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BC739AE5
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046279; cv=none; b=kZTH77qzfvuQkgC86X9TGiMCZ/B0FshIiebyXErLMFDvBZYu+VRBQr+R8nGy6MSBOEI3zJnK/LOgc/yl2gbYiyQ/9QNuNEeOq+wIsKPK9D/Zh0hJOiwShz5ST66RQp66lg0QeOiiYezwT+33UHRRVucFd7j0iMLmQ82OFYJ9HQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046279; c=relaxed/simple;
	bh=JxlhgfKDAH9pG+T7CbuWIczAu124O8TR8etJzIuzVIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cuqiZtynVmOU8vqVQAyO1o3n5FEKkPhYKLIq50mU3OmXzMKYUw4xxZ5PAp+oRKruqB6wuZVu5Ll29oublVgsaxxyF5DrMe+6owLCe8lmxbIQ9R3PwA287CLapJZ1IXMSbqW3BRELhSg0SkCFP6A+Hco/nD7Dl3aKpd8RiL8OmGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHQ42DCm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d73066880eso27679605ad.3
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706046276; x=1706651076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOT+C6LeaBh5H7EKXV1iub7JX9Ztsgpq6Az56Cc9H5k=;
        b=jHQ42DCmTRKSS6t0VFmU1AJc+gINM6dG5z679GLvDKJpnclnkpaqcR7L/C16JXwhEm
         8jfDR8UeGaiwZItVxgB7JNS8wRcuOUFJQ6HwlT27nlh9vMziNtt30tgB8EaEvrI7zXeL
         +FHeg/GF6v4bgJNnoKbxasfA8ErHdboNU+V5ietnWPDUa+JtDinM0xcDfUzxmWE8QAOr
         0wbg2eD+OcejZC1LMeibJ4UPGPsP9QJEHi6xy1A/HmFiC6bWBSFM14tcyjWkA2CVFG83
         AcndsxO6DcOB72WNe5KKvOoePerFu2py4/o/lwNbI0xrcCAJiALZvbUlmQXNZcLxjlRO
         vNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046276; x=1706651076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOT+C6LeaBh5H7EKXV1iub7JX9Ztsgpq6Az56Cc9H5k=;
        b=Ob7hanEvvODCzNOWl7tegZNbr41ezO4XtYnPhhWOs/bHXby+6ene5zuKJbb7kDSkGD
         mtLw+FZXvmg93aXEkJxB3DPI4u2+zXgllFQFFS2vp1qSr+JVdW9Qou1kVy5Sj1Q4qJUt
         T6rCxDMJW6PgAxJ6b/0f1oKIeCCT3+2lU0KLdfxHOH/MztUSiEbWx5bKSQxiW/m5XdQD
         QNplCMtqaq/J/Du/bv76O+toxPn8M//4OZDlsAo7zYnI+kjBvtfWNO2v/0w8dPMuyk/C
         P6Pi8yOkywH4VP7cHlQYghoE6FfHoY4kErWKyQerAPLyCqrDtB/i6l7zOYGUGBmE8Q5v
         S0Rg==
X-Gm-Message-State: AOJu0YzN4yA96R7oTeyvBRglxWGrBegFEY10tmj7kbi7i/3ZUXUhM/hh
	SVPPw6dc1z3M6//6f72pegdEqh8ZsdpdUeK4hKB28USm0pSi65LCHwzbng+FyRY=
X-Google-Smtp-Source: AGHT+IGoaBmsXUcbwSEbesKEcFiz6JliQ+rvBy+4K91T34yX35Dw4Ay9YdpEX//b1wWpgRrXutcxpA==
X-Received: by 2002:a17:902:d489:b0:1d7:752f:1e23 with SMTP id c9-20020a170902d48900b001d7752f1e23mr1145162plg.76.1706046276320;
        Tue, 23 Jan 2024 13:44:36 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902bc4a00b001d714a1530bsm8108858plz.176.2024.01.23.13.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:44:35 -0800 (PST)
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
Subject: [PATCH 02/11] net: dsa: realtek: introduce REALTEK_DSA namespace
Date: Tue, 23 Jan 2024 18:44:10 -0300
Message-ID: <20240123214420.25716-3-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123214420.25716-1-luizluca@gmail.com>
References: <20240123214420.25716-1-luizluca@gmail.com>
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


