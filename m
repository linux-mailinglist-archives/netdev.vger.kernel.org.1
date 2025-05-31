Return-Path: <netdev+bounces-194473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD3CAC99A9
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 08:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDCC4A6729
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 06:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA52D230BC3;
	Sat, 31 May 2025 06:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEI15wk5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EB8AD5E;
	Sat, 31 May 2025 06:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748674005; cv=none; b=f/Gft2vuwUQePR2M2/gfTJ5DJ8EVC4dFdZWjGJl4CY7T1bT0qJ1gdkTYn5A/JmPoqFeP3fS4ZyKe0mhPenS0TcLaFg4HTc0lJ68RwQSlECvLHIXEo3euWvrucfYsuoueEk706IJpn6INn8ok6rA2h0cp4v3J4w6cX3Fy2ddvWK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748674005; c=relaxed/simple;
	bh=QpX4INai12rEc4lYqmYoW3rZpCMemLfH8bOj0eZZmKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQ35b3ri3ykGl0a0zjRNMNvyfA5kbRxMQE0nVf4yMUoL+DQIUhtEi8g5OnwpGdU4xMFBdwRnZVwbmhF7EKLTkL7Eh8Qx2TdE0LfhI9y/9js9xEBGcKzPAZbEyiJFgZW8y/H7c8MAVp1r2xLsd9dX/H9mbYFw1DInoYvTz1BZhNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEI15wk5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-442fda876a6so22467365e9.0;
        Fri, 30 May 2025 23:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748674002; x=1749278802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdaIBNSavuoTQhY/Ym+rzlqZGexagOcedemyTbznHrE=;
        b=NEI15wk5SfEFgfmRETomBMifW6ZEINZeHMzQ6icBlrBQR92A6zyvwR7UGM5yGPN0mt
         zkAxiQQnAUp1v75Tonw5mVrE9TOMoLqQ3klXw8DNq1tnFookV9WowgGeqIHx5EsPjjAV
         EnIks9MqdDgV5FdsbyQ2CwCF5TUuavL0P1o8nR+yQbjBTnKBczekgM2LmCs8JdFpi2/0
         Bt8suxEHBNpvg6bYY/2GE/G2w/GSmELWU5FAVL/wB7V8D+pNM/Y00UK1NhLivMc6QIv/
         JvUWah9iWcQ4N4NqNm03zFF8InL3dHGYQZCKAXJRJhp7uYSox/X63H32J7lvhmBY9wFW
         AFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748674002; x=1749278802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdaIBNSavuoTQhY/Ym+rzlqZGexagOcedemyTbznHrE=;
        b=vkJAQthlMv4N2wbbVRm169/qoBbKtFqBmXYX1lDmF9i9kT+UGvhrAghAMv6uxCNEwb
         Wl8WNz94O1+K8KC0Ek5KtVIyHMKK8AFKslIKDU/buz/0CVBktakw3YyLCkbuuWhlwU/5
         Qhu3zku68JpOGuhJU8R3ADofxbdBqqtugKfAKl9W3IDzt44xm5U4vLwriBj/JrAYfw4l
         qxzAkMS4CtRTmXcogloSY5qdBmmUScBfTqjB7ORQNCUbjKpxd5BfExBajGa6K4WREIiD
         PIXwzy0MTZEm4ne/r03oLnGErs4hkV+XM3lRxZrMngLHV3W5dv75KViVopfCN+q6qc/C
         maPw==
X-Forwarded-Encrypted: i=1; AJvYcCUSi8iNUk2v/8M8zcxw44iUF0LzhCpymfrdDip9owUCHWP7Z6bsgRMMbSSs48gdUbUE+ZR7DkG07jCe+xY=@vger.kernel.org, AJvYcCWk2yIwXQEFX7R5Ug7imcQnkaJDtBAqVVbR1sIRvTmiblsGbkQRVaFI6RPH/FW6DOgNnTQ4h91I@vger.kernel.org
X-Gm-Message-State: AOJu0YyoKy/rqBN1HEYvlMLKDdJAMMVEQRW3FKXG9bx2NsjDyjupsN/W
	UpdQ8k3Dny650w1PJ1Sn4Dav24deuRk5kf2gdtXkMEV6FcxaXwTX7L0a
X-Gm-Gg: ASbGnctBViBeVmfxforuSVN4m2i8hZ79ssVnwwTgqrMlCy4ok6sWw0GEylA/mCNYXy2
	e8laA1bhJHXIFBV+traKC2oznAq1MHETWtJvnIH5cVGHdchxbID9LYTUAGb5EATE21diJweRb4H
	eMzDM2fpbiwh/YkJLQolbigAm/yx4sRiB/ZJKQNVolMfXdTRNegcOtawTMpuyikCPvnnI+XCWIH
	VniIPkCc9VYPtnR3KRVOBFHecH1KRQZKqt/mN4Gqmp/2QgactcdFJpzX4tAWZoURwfEgYSrz45Q
	SRhtvi83IhtTutJQWQXzremerixcsehSewW7tWAuNYkhZfIjDMUE29GLWhdnrMKEVz/mM9dD8UX
	gcXTK6FcIBDWcFJqHwW6WwsGCOqJCrG9Bc8H4dfX3L9S0lqXJJB/v
X-Google-Smtp-Source: AGHT+IEI0oC4nl1aRUNiCzuUeC4fajDnNqq1pPE1WfgajfM56IDPKqd3h5QD77BqubtxgvYclAUbNQ==
X-Received: by 2002:a05:600c:1e0d:b0:450:cde3:f266 with SMTP id 5b1f17b1804b1-4511ee150cdmr5802975e9.22.1748674002134;
        Fri, 30 May 2025 23:46:42 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1200-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1200::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000e9asm38324765e9.21.2025.05.30.23.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 23:46:41 -0700 (PDT)
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
Subject: [RFC PATCH 2/3] net: dsa: tag_brcm: add support for legacy FCS tags
Date: Sat, 31 May 2025 08:46:34 +0200
Message-Id: <20250531064635.119740-3-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250531064635.119740-1-noltari@gmail.com>
References: <20250531064635.119740-1-noltari@gmail.com>
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
index 2dfe9063613f..e6696e8212cf 100644
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
index 9f4b0bcd95cd..80157bd51c64 100644
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


