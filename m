Return-Path: <netdev+bounces-197720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1366AD9B17
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AA797AE8C9
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 07:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118DD1FBCB5;
	Sat, 14 Jun 2025 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2MFunfp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E621F6667;
	Sat, 14 Jun 2025 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749888011; cv=none; b=bXH+t6WHrdYfhegpka60WCS8jVmEAcnmNWs6ocXalrnbbhw6YkYMNYhXRlqBteWwUrLXVoJcCjmcSN0CBSUGIdCqNtdLwjV118+B0ff0qo6JOGe9WcoN0arMHek03mjbu8JcN8AVPmJOer03edD5mxDiEMor3BTmkdpJZMDZ0oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749888011; c=relaxed/simple;
	bh=hBIC7ibZJprFVGAbStn9nVa6o5lngPlDH7dJWIaSKoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7x3qkotsgA4EJUQXNl9olnZO+ghmsZfsLWx6Tg9ERGu43ADBE79oLkhDHp2j0I/4Nr5AXLsyby81vsWwVRTHJfzQgKHC5oD4d3PCXC3ZECdLIgeWOS4329tCmZOAk5jRole4UxPc0ITD4ekQNlR5i1Nt32x71zPzAwXjm7MlIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2MFunfp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450cfb79177so17324695e9.0;
        Sat, 14 Jun 2025 01:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749888007; x=1750492807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saBAdVrgLoJUYxuzwdl958AD6BoFHw9mf+Va4ZiZ2S8=;
        b=F2MFunfpnM7tZwaNvCdsD3ltLG1BXHTY486LmiXBYPWgIkqXAy9UgV55IzwdtzHSwE
         GNLEVpoT8GX2sBSiVHmKlqpL0qERq4RkdqUtCXOoF89mvN0Fs1kjCe1G5ud96IyDRrvx
         rcAm6vrrafFXbhjQemkAp6gvn7icwKeocfe+yaaERpD82Vtc/+vpFFu4CKObuAfc7rGc
         sodfN65+/4KF4AlzB+7NjKNN2gw/lJDy79tc23pAtJhRqMhPZ9D/z3bfMblgR81NN4wC
         HYJXBBemea0YuJ8NWvzehvtCjabACxpbrLKJBkHSTR4f1fWUS2xD3AQ73PuiRhBEL+Jj
         EPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749888007; x=1750492807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=saBAdVrgLoJUYxuzwdl958AD6BoFHw9mf+Va4ZiZ2S8=;
        b=kg572iOiQxw48rsTk1IaUl2uyZpoSngx2NClRuqPq7+eYqfghNFY73F6JcSHwAuUug
         hnUINHxu5A8989zFZHZ/nO8afPYkmVq8Xs51eL+2e+KmWq4C2+aH6etXAp7Isseyh1Pz
         WDayV9LBEHwd0w2boipHUif9dFsFStvxhucndZN6GghFOabqxBalK6SrEpQCEFimAa3O
         wVKlaFKrofO0xx0Kuvb6srqMSiJeD+yjfA/WnZ77qxdaIzMsC1/kxDyitqzwLvUEm+6K
         fFS+YA1MTxwmNA9xUOi3REj82y/dfC92FeOUWSbdGBXfYr8Xc/DtvFlrWdNeZMmVghdE
         IX6A==
X-Forwarded-Encrypted: i=1; AJvYcCVAdEJ6nk6LB6EGBllkP6lOcS3K2u0JSHhafRpSzy5U77mQMvCyPK9NAIUzeLqa9qnIfkwceSSRCug+RII=@vger.kernel.org, AJvYcCVtY8kNhYZmiVYc6HxGYO9AiPARfYQsucs6dQlHY6l+1VbJwB/LbH6jjwAcQ6vhMCekQek6c9+J@vger.kernel.org
X-Gm-Message-State: AOJu0YwSJQc7QdQkiHvMVfdquVOcrAinfJ0ul/sITRlprTfZBkXVK5Ha
	ER0M8NoYFr+wa8iGcJicPIywgqXKQqy50CNPa5zF8zCSrDzgf42lyq51
X-Gm-Gg: ASbGncuAO8HyMFCXZZQew4Z9YZqJ1EePv3cm3tqGBtl/fpphvsIbA7VjI86CH+U3yHx
	2JoeoDs4t4PegLmJ8coBKpGFCT5f0kesY+y0HGePV0uTvkR3oh8Tn2Ssh/7DBpWo7/D+GztYxrQ
	4fh+c2XPZv/wlLfAIH2l0s7Kq+i/gyMHgCcPGPo0zNZB+7SL0Fk5CfU944NlcyYmGWhcsG2mCfT
	z8PrcWNwMMrVLVmX8avdRbER04DeW7VUVHW5evtsghSVFNnFA3PQFguRM3bJt8jTTIn+Cl6xt35
	ugsbcpMla68Cx2lvlnbv5yvpupYTcZk6uSICNSJtyhaEEmuYHvm9Sle3ezv4zd7kvftLDVvajbj
	6F4O3Q2PtIhmH187/B9/gb5zHDCRWMcx6jIGtGsvk7SKT408PbXW/wUHvLAx64iWSmHhPcCMXUA
	==
X-Google-Smtp-Source: AGHT+IH5+fBJtfNrQ1pa+00DSZ6P+qfFQvM+MNRZnXi49bNexZSo+L0uOFotlkimSwmvZVn6bJph9w==
X-Received: by 2002:a05:600c:524b:b0:44a:b793:9e4f with SMTP id 5b1f17b1804b1-4533cad6e4emr24017135e9.19.1749888006906;
        Sat, 14 Jun 2025 01:00:06 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-2300-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:2300::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c50esm75443535e9.4.2025.06.14.01.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 01:00:05 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net-next v4 02/14] net: dsa: tag_brcm: add support for legacy FCS tags
Date: Sat, 14 Jun 2025 09:59:48 +0200
Message-Id: <20250614080000.1884236-3-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250614080000.1884236-1-noltari@gmail.com>
References: <20250614080000.1884236-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for legacy Broadcom FCS tags, which are similar to
DSA_TAG_PROTO_BRCM_LEGACY.
BCM5325 and BCM5365 switches require including the original FCS value and
length, as opposed to BCM63xx switches.
Adding the original FCS value and length to DSA_TAG_PROTO_BRCM_LEGACY would
impact performance of BCM63xx switches, so it's better to create a new tag.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 include/net/dsa.h  |  2 ++
 net/dsa/Kconfig    | 16 ++++++++--
 net/dsa/tag_brcm.c | 73 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 88 insertions(+), 3 deletions(-)

 v4: fix line length warning.

 v3: fix warnings:
  - Improve Kconfig description.
  - Use __le32 type.
  - Use crc32_le() instead of crc32().

 v2: replace swab32 with cpu_to_le32.

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 55e2d97f247e..d73ea0880066 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -54,11 +54,13 @@ struct tc_action;
 #define DSA_TAG_PROTO_RZN1_A5PSW_VALUE		26
 #define DSA_TAG_PROTO_LAN937X_VALUE		27
 #define DSA_TAG_PROTO_VSC73XX_8021Q_VALUE	28
+#define DSA_TAG_PROTO_BRCM_LEGACY_FCS_VALUE	29
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
 	DSA_TAG_PROTO_BRCM		= DSA_TAG_PROTO_BRCM_VALUE,
 	DSA_TAG_PROTO_BRCM_LEGACY	= DSA_TAG_PROTO_BRCM_LEGACY_VALUE,
+	DSA_TAG_PROTO_BRCM_LEGACY_FCS	= DSA_TAG_PROTO_BRCM_LEGACY_FCS_VALUE,
 	DSA_TAG_PROTO_BRCM_PREPEND	= DSA_TAG_PROTO_BRCM_PREPEND_VALUE,
 	DSA_TAG_PROTO_DSA		= DSA_TAG_PROTO_DSA_VALUE,
 	DSA_TAG_PROTO_EDSA		= DSA_TAG_PROTO_EDSA_VALUE,
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 2dfe9063613f..869cbe57162f 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -42,12 +42,24 @@ config NET_DSA_TAG_BRCM
 	  Broadcom switches which place the tag after the MAC source address.
 
 config NET_DSA_TAG_BRCM_LEGACY
-	tristate "Tag driver for Broadcom legacy switches using in-frame headers"
+	tristate "Tag driver for BCM63xx legacy switches using in-frame headers"
 	select NET_DSA_TAG_BRCM_COMMON
 	help
 	  Say Y if you want to enable support for tagging frames for the
-	  Broadcom legacy switches which place the tag after the MAC source
+	  BCM63xx legacy switches which place the tag after the MAC source
 	  address.
+	  This tag is used in BCM63xx legacy switches which work without the
+	  original FCS and length before the tag insertion.
+
+config NET_DSA_TAG_BRCM_LEGACY_FCS
+	tristate "Tag driver for BCM53xx legacy switches using in-frame headers"
+	select NET_DSA_TAG_BRCM_COMMON
+	help
+	  Say Y if you want to enable support for tagging frames for the
+	  BCM53xx legacy switches which place the tag after the MAC source
+	  address.
+	  This tag is used in BCM53xx legacy switches which expect original
+	  FCS and length before the tag insertion to be present.
 
 config NET_DSA_TAG_BRCM_PREPEND
 	tristate "Tag driver for Broadcom switches using prepended headers"
diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
index 9f4b0bcd95cd..26bb657ceac3 100644
--- a/net/dsa/tag_brcm.c
+++ b/net/dsa/tag_brcm.c
@@ -15,6 +15,7 @@
 
 #define BRCM_NAME		"brcm"
 #define BRCM_LEGACY_NAME	"brcm-legacy"
+#define BRCM_LEGACY_FCS_NAME	"brcm-legacy-fcs"
 #define BRCM_PREPEND_NAME	"brcm-prepend"
 
 /* Legacy Broadcom tag (6 bytes) */
@@ -32,6 +33,10 @@
 #define BRCM_LEG_MULTICAST	(1 << 5)
 #define BRCM_LEG_EGRESS		(2 << 5)
 #define BRCM_LEG_INGRESS	(3 << 5)
+#define BRCM_LEG_LEN_HI(x)	(((x) >> 8) & 0x7)
+
+/* 4th byte in the tag */
+#define BRCM_LEG_LEN_LO(x)	((x) & 0xff)
 
 /* 6th byte in the tag */
 #define BRCM_LEG_PORT_ID	(0xf)
@@ -212,7 +217,8 @@ DSA_TAG_DRIVER(brcm_netdev_ops);
 MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_BRCM, BRCM_NAME);
 #endif
 
-#if IS_ENABLED(CONFIG_NET_DSA_TAG_BRCM_LEGACY)
+#if IS_ENABLED(CONFIG_NET_DSA_TAG_BRCM_LEGACY) || \
+	IS_ENABLED(CONFIG_NET_DSA_TAG_BRCM_LEGACY_FCS)
 static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
 					struct net_device *dev)
 {
@@ -244,7 +250,9 @@ static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
 
 	return skb;
 }
+#endif /* CONFIG_NET_DSA_TAG_BRCM_LEGACY || CONFIG_NET_DSA_TAG_BRCM_LEGACY_FCS */
 
+#if IS_ENABLED(CONFIG_NET_DSA_TAG_BRCM_LEGACY)
 static struct sk_buff *brcm_leg_tag_xmit(struct sk_buff *skb,
 					 struct net_device *dev)
 {
@@ -294,6 +302,66 @@ DSA_TAG_DRIVER(brcm_legacy_netdev_ops);
 MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_BRCM_LEGACY, BRCM_LEGACY_NAME);
 #endif /* CONFIG_NET_DSA_TAG_BRCM_LEGACY */
 
+#if IS_ENABLED(CONFIG_NET_DSA_TAG_BRCM_LEGACY_FCS)
+static struct sk_buff *brcm_leg_fcs_tag_xmit(struct sk_buff *skb,
+					     struct net_device *dev)
+{
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	unsigned int fcs_len;
+	__le32 fcs_val;
+	u8 *brcm_tag;
+
+	/* The Ethernet switch we are interfaced with needs packets to be at
+	 * least 64 bytes (including FCS) otherwise they will be discarded when
+	 * they enter the switch port logic. When Broadcom tags are enabled, we
+	 * need to make sure that packets are at least 70 bytes (including FCS
+	 * and tag) because the length verification is done after the Broadcom
+	 * tag is stripped off the ingress packet.
+	 *
+	 * Let dsa_user_xmit() free the SKB.
+	 */
+	if (__skb_put_padto(skb, ETH_ZLEN + BRCM_LEG_TAG_LEN, false))
+		return NULL;
+
+	fcs_len = skb->len;
+	fcs_val = cpu_to_le32(crc32_le(~0, skb->data, fcs_len) ^ ~0);
+
+	skb_push(skb, BRCM_LEG_TAG_LEN);
+
+	dsa_alloc_etype_header(skb, BRCM_LEG_TAG_LEN);
+
+	brcm_tag = skb->data + 2 * ETH_ALEN;
+
+	/* Broadcom tag type */
+	brcm_tag[0] = BRCM_LEG_TYPE_HI;
+	brcm_tag[1] = BRCM_LEG_TYPE_LO;
+
+	/* Broadcom tag value */
+	brcm_tag[2] = BRCM_LEG_EGRESS | BRCM_LEG_LEN_HI(fcs_len);
+	brcm_tag[3] = BRCM_LEG_LEN_LO(fcs_len);
+	brcm_tag[4] = 0;
+	brcm_tag[5] = dp->index & BRCM_LEG_PORT_ID;
+
+	/* Original FCS value */
+	if (__skb_pad(skb, ETH_FCS_LEN, false))
+		return NULL;
+	skb_put_data(skb, &fcs_val, ETH_FCS_LEN);
+
+	return skb;
+}
+
+static const struct dsa_device_ops brcm_legacy_fcs_netdev_ops = {
+	.name = BRCM_LEGACY_FCS_NAME,
+	.proto = DSA_TAG_PROTO_BRCM_LEGACY_FCS,
+	.xmit = brcm_leg_fcs_tag_xmit,
+	.rcv = brcm_leg_tag_rcv,
+	.needed_headroom = BRCM_LEG_TAG_LEN,
+};
+
+DSA_TAG_DRIVER(brcm_legacy_fcs_netdev_ops);
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_BRCM_LEGACY_FCS, BRCM_LEGACY_FCS_NAME);
+#endif /* CONFIG_NET_DSA_TAG_BRCM_LEGACY_FCS */
+
 #if IS_ENABLED(CONFIG_NET_DSA_TAG_BRCM_PREPEND)
 static struct sk_buff *brcm_tag_xmit_prepend(struct sk_buff *skb,
 					     struct net_device *dev)
@@ -328,6 +396,9 @@ static struct dsa_tag_driver *dsa_tag_driver_array[] =	{
 #if IS_ENABLED(CONFIG_NET_DSA_TAG_BRCM_LEGACY)
 	&DSA_TAG_DRIVER_NAME(brcm_legacy_netdev_ops),
 #endif
+#if IS_ENABLED(CONFIG_NET_DSA_TAG_BRCM_LEGACY_FCS)
+	&DSA_TAG_DRIVER_NAME(brcm_legacy_fcs_netdev_ops),
+#endif
 #if IS_ENABLED(CONFIG_NET_DSA_TAG_BRCM_PREPEND)
 	&DSA_TAG_DRIVER_NAME(brcm_prepend_netdev_ops),
 #endif
-- 
2.39.5


