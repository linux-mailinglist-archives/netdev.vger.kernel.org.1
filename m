Return-Path: <netdev+bounces-196841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB16AD6B00
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310DD175A36
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AAD223DFD;
	Thu, 12 Jun 2025 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNeXat5e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F91221FDD;
	Thu, 12 Jun 2025 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717474; cv=none; b=uvZB6jGlNKCIVvboBPZPsipUnFqw0Hsqg7CCY6atR1lUhre9Y69R467h/Wa2kbJNYs84ehEQC5jiHdQbLcGPaXoI0/rTH31OXidMIFYpne7TfuBThO6598UWXYgxjopxsipcx4WhvZJoiWytcVzHeZmhPcRyfqhcIq43sjPy4g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717474; c=relaxed/simple;
	bh=oV8NiAb7Ct+i7S9WzFcFRYBoFqF6dVQhRk9sWRium9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEovtLk4dv8S4AOZZ9XQ9X3jGYBhfc7vT75GJHVDC2VWj91XaVSby+e/MEp/uz8Nq/MJTNwa2fDoIUMrF4RItfydktJFKbJFhmP/IL4SiY5abqxVZy3Y25VrvZ1m1JaN6F6TBCube1ZzKRPxAPdLYPgED8KiSrjpzgSnakui/PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNeXat5e; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so5099815e9.1;
        Thu, 12 Jun 2025 01:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749717471; x=1750322271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3B32SeXRU526IkGF7S2nlgc/H8nFrvkPADRZbi9N/o=;
        b=eNeXat5edu4Q454/h+Ln/n4FXXuYsc+aHEoFYzW7uXhzrkiwtGgB7mSV3f8psMbZZQ
         FJB19Dc0Q5CESmz3JvfvP3/WqVrTYhsBtOQPuELq5u+SlpAsxm7oKxpQi+5scdtcpSp6
         00M0Y4A888HtKbkPPIN9DjyNXfaV1Jo2XiZFcBqR1EDNUHNmujqc4ooCV58ROKoUT1qv
         zRFMCgkxnJDXXItmY8Dw7Nz8U+otDDRu/ZVKdP59/wQztf2a/+UMLfoKPszk60C2KDdO
         4JGCVXsdiN2P70iOriIXf89HOztySNgNnTZ2u+45iZHk7EIiNt09nTsxR+GoOXVbbwh7
         06mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749717471; x=1750322271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3B32SeXRU526IkGF7S2nlgc/H8nFrvkPADRZbi9N/o=;
        b=blyXFMcWPXJsGQ+SnaleaVOmMfvMJ1fmDs+Z3n3bYqPIprKZk4hxtx7dBAzARxFC0m
         x7wp1pF9ZP9G6jLhZM5ZX7PGD09XD8kvkkXYEmgP62NBnkuDAcEatqeCLFIl6gGHd3ZY
         lVsQ5c6UzT62jsaKRIXuzDrxWRcr4MJ39MO4QIvqpuY4WOgKArKr3pqjbhRi2viEn6I1
         hCXig7qSlPd6vCI9ox7Id5K3z2xSQYvgL83SAuk3vkpck1JDrRbkSFIDOofMGi5rN9MS
         6uISbbxN71kQjBlUPVzatLGJvqbbbqpWy+q+cTg954qJN/KiPCW4/NOoGO9KFj20FplA
         q/Dg==
X-Forwarded-Encrypted: i=1; AJvYcCULVPjythqz/n90P/eppZx00GdLc9eMfG83Pucv+x2wlsm2clOFloy8m1ebwaPhAvbCAhS3r7OZ4PvSnsY=@vger.kernel.org, AJvYcCVLrVjr1DwptyIFQ3kZCU12CHm70NPNU7ZYhBS7IA35LgQusqRDKsI5Ql83vT586v7utIeSjJxd@vger.kernel.org
X-Gm-Message-State: AOJu0YwrkZeUvpzQyfi1CLwuETVQLJzUJs+CIe99fOpLLnVlymjSOmcB
	AoZX0uu9z2DZ+nAsg4EsVKUvDl538tQ1MEg3HsaXemzg9lchntua7y7l
X-Gm-Gg: ASbGncsP9kvBsuR9RGxI6J5/sMvT438vICJkwHUAeYCcPiS15hwBwR/zIfdhuazcwM7
	DPUz4GQfeOguoskL+0eFyZeHoc1c8TvmnM8jXL6OV+0b4osuiSAA1EDUFiLRb35wtSpJQdtogbL
	gKjDLaIFxU4Ng0+YP3dTCNZIaSNbSZPINzQ3JKOPieEQJh7Xz/gH2ljIyRbp9RTGGUm3xDnSn6g
	K0tkBh6JAbwuW7fYmv+8LZkqguU7UzZMdexWiGFgJ7/0JLz46k4dYpcCxXiWfAko4OaE25s9riN
	vioGIAFbr3VJU8Mab0ukeuB4Nnz6a40hdMiE54ZWUlEWsODd5p8QNAuOPGi7wf75JClbwoCgrDc
	P88HFCGsSy40O2G2yrxG5jXJzWuG9ZXTk5cJ81YEHRASs8gAkPK3mNd9aqz91X2YI68MeMhwKx1
	H5Jg==
X-Google-Smtp-Source: AGHT+IGgWJM8N/ee9Uhm6kLiiR+LpUOOBnfVs53QkFTh3jN8SEhb0+ZcZ4CLVdTwkLFLC3YuX+Fycw==
X-Received: by 2002:a05:600c:1d22:b0:450:cc79:676 with SMTP id 5b1f17b1804b1-453248f972amr48568415e9.20.1749717470920;
        Thu, 12 Jun 2025 01:37:50 -0700 (PDT)
Received: from slimbook.localdomain (2a02-9142-4580-1900-0000-0000-0000-0011.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1900::11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224956sm13350975e9.4.2025.06.12.01.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:37:50 -0700 (PDT)
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
Subject: [PATCH net-next v3 02/14] net: dsa: tag_brcm: add support for legacy FCS tags
Date: Thu, 12 Jun 2025 10:37:35 +0200
Message-Id: <20250612083747.26531-3-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250612083747.26531-1-noltari@gmail.com>
References: <20250612083747.26531-1-noltari@gmail.com>
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

 v3: fix warnings:
  - Improve Kconfig description.
  - Use __le32 type.
  - Use crc32_le() instead of crc32().

 v2: replace swab32 with cpu_to_le32.

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
index 2dfe9063613fe..869cbe57162f9 100644
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
index 9f4b0bcd95cde..801f90d136f12 100644
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


