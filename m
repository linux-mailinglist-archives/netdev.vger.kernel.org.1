Return-Path: <netdev+bounces-194393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2DCAC92D0
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 17:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A167AE642
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7F92367C9;
	Fri, 30 May 2025 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZO4+3wh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1E2236424;
	Fri, 30 May 2025 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748620588; cv=none; b=lVVjvmXdsiuDsvfCw7xSrdmJ/ztLgwlsTfgL4exkiBh+TMDwp9n8TVGoIBFqTgDkJJ7YWSmGozGuvegmFWyh+CWlirpTV7JE/S6kZxX/wrwY2vgwlfBTvuJFzeYB9Z8aQDl32HWAiULKIwZCAhe4T0maoxc2p5mv2IlW9CYM4RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748620588; c=relaxed/simple;
	bh=/LPk1N5k7MXThjuyp7NMfhydFaa+6+izx6Kc0JuVp3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efAZfiGqV8DVMhx9mtwOUxSpbNBtY4D5z2Y8L8k7BK5AY2SlC/YBTAaGd4FDY18638anV9sj+LETIY1MSij2z7r1jcu/KMnenxlciF2zxYySBKQrNqDFw7Duo2364GKpXRI7Gi/laf2+CBipNow/6ZM1bmR3oPK07ZKBVQrI7mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZO4+3wh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-441c99459e9so14433405e9.3;
        Fri, 30 May 2025 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748620584; x=1749225384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2NxGwlnS9jui1sAzHmxX0cVs9lSeCFCYZqyRvSDhDw=;
        b=FZO4+3whwMsAiGiHZOHUYdf1gLXmOLgd4TTf4GmPjnxl4Vr1rFqnsjgAQbhFDpkKu3
         yGChYh/GO12/a2y0DdB8HqcWA+e7rO3KBuahbSYjHrkW85i9F64v8aYBJHaqQ3qB/kOk
         tmCRrfIAMgILIPWIyMfOhECamAbvq9OEzjcLcAS1EPdxTpSUs3iMfzAY5y8+K1sCfZo9
         sLG0g3I+FhC6ZSgcH1LOst5r0APHholvfOlxiqsEPpPOEI1c2Q5yZnP4GyRn6u3X61Zm
         xN0mFM6/nnXJUcZaU+c9hApxHNRWpzJjOS9X2pQyzZHj5NpH5tmpY9yEbXytNvDm1+NV
         RC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748620584; x=1749225384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2NxGwlnS9jui1sAzHmxX0cVs9lSeCFCYZqyRvSDhDw=;
        b=VZjEAhU2/fCAxq978s59cU2NYfBOTSPlMKb/pfBhXiAlslR6eF1mMJv0NrZwtmJf/t
         62Nj/Av5GaAVD1oh13Zg+DCP/p25zGjR1VGKtvnlWcOZsa8+LLxGvp8Z7fZUdriWLP5E
         gvqFqA+5KA8e0dNKiZZVEkVQwXBerYr1fp6V+nVcv/qWRIN2KOP/4flv53ef/CSUryG2
         nwxuIpga1fm6+kaHZ3PyXAJ3DgTLhMYaGXTff4xCR4tndqYwoH3RZBLTDPe2LHOAPm5B
         Z/OWm589b5Qwkwls0sFpLd2/JHaL1jIoY8MBEgch/rAN7hES7DO5mWsbj9yLFjK3W7bZ
         Lrsg==
X-Forwarded-Encrypted: i=1; AJvYcCWxFkzOewIG6gEOLwGg/mErat3RyVnBpc8oaOszc7AU0etQ+aC2kKCpBI08JS4orwKEwIbjK9KR@vger.kernel.org, AJvYcCXJALRKU61jYguNDTIBurSNlb3jEYtCmtFy0QVAFSimNmgdFcf1YLWnSwZqKJ8WJEFllmoWXgyHUG8I1bA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOoJNVJ/RN5tGXqB6C9hBMf371JukQV8SFN5GKh7Hs9yHk+VlX
	4lO89p+TCOrNDd8Y9IHlM/w1d4fO1Wjor6fGBdBaPh8OLH+cxz1X9Ja6fqfg3Q==
X-Gm-Gg: ASbGncvnUMMRJ0LNeh/Zt0M57GSNqzaf11Qsa88wEw0nYxzO0/KGlsbJAB6YRmUZxhS
	6cbMO04PjuZHoFC+uWsG7y6Ns+cc9SChSTcwbbfb4fMXl/V5nIZ2qJ7jlrj+iDhRgIQ3P92UNxA
	oi++TFKl2dIlUWiMaoT8z/ONdQaUrOIwSCz3I9f7k3kBYoTxaCJs/8H+ytRwTJ1EputiUmSN/w/
	TUC6SlTrUDIiUP6T/eQ2EkGnizveqJfXrD5RjwKNTCU61xf0UAxsDQPQB8AFaIpdimBTPC7hm0R
	soy4HC9yfSAc97JFSpsQpIs93NmshbjmSAs1/cpSRvK547HMTQDvUEMpQVsUmEYDn7QTkpX2riZ
	Fmx0az3a6JHd9RXxtzp6dW4WgOgrgdyW7xOIfreNCCqBA5z/pxw9Q
X-Google-Smtp-Source: AGHT+IGgN9Bd4s2Wf6eELsqaSmkRaUuiFulYQqeLa5sxC++eyn/zB8apRzAEHbS7zZ35kbSOmamBeQ==
X-Received: by 2002:a05:600c:4f46:b0:441:d437:ed19 with SMTP id 5b1f17b1804b1-450d64d469amr39085095e9.11.1748620583803;
        Fri, 30 May 2025 08:56:23 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1200-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1200::8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe74165sm5211620f8f.53.2025.05.30.08.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 08:56:23 -0700 (PDT)
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
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH] net: dsa: tag_brcm: add support for legacy FCS tags
Date: Fri, 30 May 2025 17:56:17 +0200
Message-Id: <20250530155618.273567-3-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530155618.273567-1-noltari@gmail.com>
References: <20250530155618.273567-1-noltari@gmail.com>
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
 net/dsa/Kconfig    |  8 ++++++
 net/dsa/tag_brcm.c | 71 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 55e2d97f247eb..d73ea08800660 100644
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
index 2dfe9063613fe..e6696e8212cf3 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -49,6 +49,14 @@ config NET_DSA_TAG_BRCM_LEGACY
 	  Broadcom legacy switches which place the tag after the MAC source
 	  address.
 
+config NET_DSA_TAG_BRCM_LEGACY_FCS
+	tristate "Tag driver for Broadcom legacy switches using in-frame headers, FCS and length"
+	select NET_DSA_TAG_BRCM_COMMON
+	help
+	  Say Y if you want to enable support for tagging frames for the
+	  Broadcom legacy switches which place the tag after the MAC source
+	  address and require the original FCS and length.
+
 config NET_DSA_TAG_BRCM_PREPEND
 	tristate "Tag driver for Broadcom switches using prepended headers"
 	select NET_DSA_TAG_BRCM_COMMON
diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
index 9f4b0bcd95cde..7bf4bde2d8672 100644
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
@@ -294,6 +302,64 @@ DSA_TAG_DRIVER(brcm_legacy_netdev_ops);
 MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_BRCM_LEGACY, BRCM_LEGACY_NAME);
 #endif /* CONFIG_NET_DSA_TAG_BRCM_LEGACY */
 
+#if IS_ENABLED(CONFIG_NET_DSA_TAG_BRCM_LEGACY_FCS)
+static struct sk_buff *brcm_leg_fcs_tag_xmit(struct sk_buff *skb,
+					     struct net_device *dev)
+{
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	unsigned int fcs_len;
+	u32 fcs_val;
+	u8 *brcm_tag;
+
+	/* The Ethernet switch we are interfaced with needs packets to be at
+	 * least 64 bytes (including FCS) otherwise they will be discarded when
+	 * they enter the switch port logic. When Broadcom tags are enabled, we
+	 * need to make sure that packets are at least 70 bytes
+	 * (including FCS and tag) because the length verification is done after
+	 * the Broadcom tag is stripped off the ingress packet.
+	 *
+	 * Let dsa_user_xmit() free the SKB
+	 */
+	if (__skb_put_padto(skb, ETH_ZLEN + BRCM_LEG_TAG_LEN, false))
+		return NULL;
+
+	fcs_len = skb->len;
+	fcs_val = swab32(crc32(~0, skb->data, fcs_len) ^ ~0);
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
@@ -328,6 +394,9 @@ static struct dsa_tag_driver *dsa_tag_driver_array[] =	{
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


