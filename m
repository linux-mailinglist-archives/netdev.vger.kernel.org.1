Return-Path: <netdev+bounces-196228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D0BAD3F05
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 18:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B6C3A8FAB
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C89242D94;
	Tue, 10 Jun 2025 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSsPpxCu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D13241670;
	Tue, 10 Jun 2025 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573123; cv=none; b=Hg8d3zVqBKOpbPfGWVbp/5XLfVB3BBVFaLfXMq4PR4r0EXURU3IbOnDosV6l/s7Y1f3RzVX7OsSgFGPp/g0k7lXeJvxpzL1R0+scK+aGVknVyxoT0mEZ0nsA9kB6t/OaW3s7U7gvl8uPg78YtgxckePXR/4I3uX6pob4pNpiSbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573123; c=relaxed/simple;
	bh=69Ph4qN5AbrieLOuNLe0CycEnwhgvHagqWcWERsJcGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fj3IMm4DM1tr1lC6VjJkqb0ikosBqR/M97Jbmst0HkDb0nr8HcJ7SeVQbqUuwZNrNnqgx44Xf69lWw2TXLSUlLQP6fu029l6JQdhEL/D/HMhezIRTBNzvdXR1+s8rIVnhzQ9QrbbxBbd8cQo5iRHBXcQT0DqRX29gO+oVB6vSzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSsPpxCu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-441ab63a415so59348495e9.3;
        Tue, 10 Jun 2025 09:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749573120; x=1750177920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4MJjtgDSJ5yuAT0IXtcih6B+H1GEhUVeCOcySAr2TI=;
        b=nSsPpxCuFzJ4wFITScMhjs/Er6Rg5+cTCdK4zqi4cJtMZ1/7N2cl/eToyEP9iqDCtC
         +xNSo2YAcAykJmS9nTB/TYXHG/tmLnvh8T4RmOVikTGVLSwjyMRJ4qoPyGjN/8Lgef1U
         KnATVFkIGHOya82SvdP2xrLCFdnwOPHUaDnCmAP4ptlH8iNAmUI5cagshkiKVvMOLnH4
         HAElYwUtMBoWRWoiI3skuNZPsDIr9nbAD1/WQ53SpyJD5x2AoiQCRIBzmK+hXYsHV+cb
         n42hXRflTkRLO3axA05Xhv5oWv8KntOzpB7PjNMTYTmnOqbOTKubg/RV8Z405UHa8rPN
         7y5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749573120; x=1750177920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4MJjtgDSJ5yuAT0IXtcih6B+H1GEhUVeCOcySAr2TI=;
        b=btw6XAsNERw9boYSejP1H+6nvnzbZ1yDPPWVdjsKGLnCniZv4zG02PrPav1Z84Lcwj
         HiAM7Ecsf8A33GTMvsOUMJUZxtrjz/AZ1WqhQRvqgOpZQVapm5AP00YF2CoRz2twVUPh
         OP3R4Jw1nh+14dq8xpJlQV1q1/FGnUtbJYAnJOYH8HF28VBiETQ3hFBV1ckdL+KY3AYv
         hBBw4WPPYFL0G4+AYq5a108j4UMSsHoy2Cz5bRKOz8boPVmfwJM7edOod29BIOj5fcSr
         z3W+n9dPDReb8dJkK7wF+Foo+I6Cf2zxXhIihnRdDOkHzhEjmJKhnZiEudmWzBBqas6x
         Rn+g==
X-Forwarded-Encrypted: i=1; AJvYcCUyDPevyMZKdj+KJLBqUss6P6AE0kuJQuxfz+AowLgCXXVUDWyindLhtDofgSCTXGPvG90W7aS2@vger.kernel.org, AJvYcCVk/RcfQdrqOyyE0hUGyreWaAWMT+YkYFmbHL9xr+69Wo1eGFxyLv84AQ2fLOH33LNZEP2ZwP7lkJdXiPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/uw9Mj3weEaPWkGj8MoBdrYXByluXbokpz36cf8v71xOWFYkW
	lZ8ZH8VT13g/7PMDWJqzvDI8iX6wUGfZOcfWtYv+Jwuk/89HAEyNnuZq
X-Gm-Gg: ASbGncv3yCz5rXr5tJkbqSxE1ZQIvKTGTMJP7TgDSrSMkyAEXK2I1fki80VgKeewSjP
	pmCRTZPOE+1n08AkbfShS438CZR94poPu3Gp9VRuWiCr+rO8gcSPuDod1cnvSJ70s+EWiNoNNg9
	/AwPUNPhLrtGhIVkDif39x6JKyy7BHlZIWLDiv0ighAGmn91c81ymxkAKN9Fd74EMlDmiYe7zRX
	NPrIgs9YxAyGSF4CjSWEyOm7HxszD/JlntVLXM+6ENx8LPJ9WvFr6m+l4SoQzD4IPHKOvYtj9WY
	bHllGs38MeD2MqUov/MupOLGOF2wB1wnY2hMRLkBu308fkK2OutZCO+MFEvf8fblzVEI3C12xvw
	0QaFEctOHQCDJgrFY2Rr798NiQTk+qpGuxFQHd8mGIwmzoOdML0Os2J9HJ6sGqj0=
X-Google-Smtp-Source: AGHT+IFwl4qYzXd3CIV23prGLSwvqxAnPYNbmC9hCSF3eqN6eJ45zy/iCjrcI9iUx3voe7oSkdEtpA==
X-Received: by 2002:a05:6000:26ca:b0:3a5:2949:6c38 with SMTP id ffacd0b85a97d-3a5522ddd75mr2829526f8f.52.1749573119784;
        Tue, 10 Jun 2025 09:31:59 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1900-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1900::8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532435fa6sm12494857f8f.48.2025.06.10.09.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 09:31:59 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/3] net: dsa: tag_brcm: add support for legacy FCS tags
Date: Tue, 10 Jun 2025 18:31:53 +0200
Message-Id: <20250610163154.281454-3-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610163154.281454-1-noltari@gmail.com>
References: <20250610163154.281454-1-noltari@gmail.com>
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
 net/dsa/Kconfig    |  8 +++++
 net/dsa/tag_brcm.c | 73 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 82 insertions(+), 1 deletion(-)

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
index 9f4b0bcd95cde..fff05ed3318f7 100644
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
+	fcs_val = cpu_to_le32(crc32(~0, skb->data, fcs_len) ^ ~0);
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


