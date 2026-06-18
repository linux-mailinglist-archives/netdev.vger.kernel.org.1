Return-Path: <netdev+bounces-300534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GZVEEFpVNGqDVAYAu9opvQ
	(envelope-from <netdev+bounces-300534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 22:30:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFA76A289C
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 22:30:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Go+4d1Vb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300534-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300534-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AD363090B94
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 20:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72911344030;
	Thu, 18 Jun 2026 20:27:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3706D346795
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 20:27:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814472; cv=none; b=bKCg2zSIAgUFIduG0zW38/cgV3krN3FNRct5Ei+hMxEzHPJix+iLGejgYDMuFt+aVvb5VSpqFzWXqjWs1XcMQrnxcxQN7eaHo3vvO7D2IUZFfTQBlVgxCpvNQ+SLgNNSVKakabZN64ozfpCZFdgZhmusjgBuvQTxP84tVvmcmKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814472; c=relaxed/simple;
	bh=xSLcwZJKJShzelaP73TL7hcqrpej3I62EOAK5a9rXsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clsgEPjfbCPXsbeatk71KYxvX1dyTAUJIzHtZKZvixcnE12CJzjaHVaSY8xXyPXPF6nAm1SuG2GbJ97HgGbRqyF1kPbKldcjWmwvz1zF7RbsuPh6LOoih0jpX4lcYbm0eY2MA4VNQC7XdcGv8BizpKrBHOW7allOFsl64V4any8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Go+4d1Vb; arc=none smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84231305a80so808656b3a.0
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 13:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781814467; x=1782419267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faT0HyLRowlHDJuq+xtAJKIPK6m36fYH+bAOKq3mdZc=;
        b=Go+4d1VbwjZetrn5s45xTI22i7QaeAtJ8CJ2nCB73TXlP6kXaqAqYkn4h9QMwuxpwY
         Z4kPAKTSbBtAnxpbSN0nGfu1LJ7U9Gd1WNcEPZvOJ/JHJgDhaI8BWhPVGqitiuql/KH1
         csW0LMjgCnS6r1hGWYBjwwDDcoiLFkCF8oe7fpK+kIauHyxcd0DRR1mNReBBs+DiHulr
         Gj37BBQLJ9tvgTRI0vI7xWyMxssg3dYiK3VwdWgxjEU2E3WWV3iLROGh/BH2ULHCY4V0
         ZVN/91fl3URPMb2Gc64qrKYQg1znGvkLPhHmz66YMEpr5oIg0vs3NpFsZgK1K2/IGqnK
         yJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781814467; x=1782419267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=faT0HyLRowlHDJuq+xtAJKIPK6m36fYH+bAOKq3mdZc=;
        b=dWmqKOcRsdZu5x+iSk7+viPLukFMnIWbd3Pq5RvGoskms6KqF//EEPwOjMxkDRBjvC
         flCcdwthBleBWyke6lUcrmMOkXL9QyFGM5N1hgP1luL7DBLFbl7It2prLR76z2nmNyqN
         M6yAE0IXAZRHM1w8ltc5MWOCvdANd5h1a1pGqXTXFuNlIVNcFoib+mfPeh3i5otZswR2
         txjbNEh5xUdHP0OZyArO3ho/DudtOJfzCyw1Y2Iv7G8COgetiH6+3ru/+vVA1YMgnuEC
         OGZPOqwyP57er+vjS5L9ELmIE1Bf1XiCAlLej6Bt86N6bm+COHcil9KstCLduXWQYJ4m
         kfLw==
X-Gm-Message-State: AOJu0YzWsDp+RC1NVrVRgNfWcvXYcY1nu4fxNHinQxcipZedO4kzuzMq
	PjgzpAmN8iqilmDUcVEZ78W2wTCFjzvV/8yFTAzGf30bnyhaLsTq21U6YMcMivGz
X-Gm-Gg: AfdE7clgH+ObsHDBuQM3oQeXmYRKUrzZo4/Txn6DLEGMIg9NDiGT/3LUXPY5nB4kHpf
	qnrVVpflVDNMmKttlJ2mOG5NeRLORFwDVpPnqPQDKw0RM9pNJOU9ywS7Gn2vvD0d9EfXVtH5LTs
	nUFxHB8xUEgLawOhoMSD/ocTmc+TZVoSIzgZHB9o2bEuVtLtZZWz6aV6OSYKQ8dJhUz+pjKVgV5
	7rCPrbXdrRffC0439uyGOsw2kQa3jH6LmnPcGAqemFPsemzZIHsaf+QNvHWO0Mm84NHwftaq/Od
	dIb/AyjkLmyfUesX7DLbATIhKkPG11A5ciFFOMTGP/Vl3nEq6BdOflWc+NdDZPUrlKj/P9E00oh
	X68OfInF2fM3fNR8BA3sfpr1xmB7pzRdRjnR4tGtuu8us8FmGL0gJJi6p4PXpLwOT0lx3sODsJ2
	cwo67p9jg4gNiadS/1vhSOgJKgGITdUAu2dT6/75njU5pscRqQXw0=
X-Received: by 2002:a05:6a00:4f8d:b0:842:4612:55f6 with SMTP id d2e1a72fcca58-845508671e8mr459429b3a.21.1781814466265;
        Thu, 18 Jun 2026 13:27:46 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.215.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845536758ddsm3590b3a.15.2026.06.18.13.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 13:27:45 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 4/4] net: dsa: motorcomm: Add LED support
Date: Fri, 19 Jun 2026 04:26:32 +0800
Message-ID: <20260618202716.2166450-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618202716.2166450-1-mmyangfl@gmail.com>
References: <20260618202716.2166450-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300534-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8BFA76A289C

LEDs can be described in the device tree using the same format as qca8k.
Each port can configure up to 3 LEDs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/Kconfig  |   9 +
 drivers/net/dsa/motorcomm/Makefile |   1 +
 drivers/net/dsa/motorcomm/chip.c   |   7 +-
 drivers/net/dsa/motorcomm/chip.h   |  18 +
 drivers/net/dsa/motorcomm/leds.c   | 530 +++++++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/leds.h   | 104 ++++++
 6 files changed, 667 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/leds.c
 create mode 100644 drivers/net/dsa/motorcomm/leds.h

diff --git a/drivers/net/dsa/motorcomm/Kconfig b/drivers/net/dsa/motorcomm/Kconfig
index 64ff7d07a91b..7c4d1eaa16c2 100644
--- a/drivers/net/dsa/motorcomm/Kconfig
+++ b/drivers/net/dsa/motorcomm/Kconfig
@@ -6,3 +6,12 @@ config NET_DSA_YT921X
 	help
 	  This enables support for the Motorcomm YT9215 ethernet switch
 	  chip.
+
+config NET_DSA_YT921X_LEDS
+	bool "LED support for Motorcomm YT9215"
+	default y
+	depends on NET_DSA_YT921X
+	depends on LEDS_CLASS=y || LEDS_CLASS=NET_DSA_YT921X
+	help
+	  This enabled support for controlling the LEDs attached to the
+	  Motorcomm YT9215 switch chips.
diff --git a/drivers/net/dsa/motorcomm/Makefile b/drivers/net/dsa/motorcomm/Makefile
index 9fa24929007c..6bb3adfbcc2d 100644
--- a/drivers/net/dsa/motorcomm/Makefile
+++ b/drivers/net/dsa/motorcomm/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_NET_DSA_YT921X) += yt921x.o
 yt921x-objs := chip.o
 yt921x-objs += smi.o
+yt921x-$(CONFIG_NET_DSA_YT921X_LEDS) += leds.o
diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index d44f7749de02..4856db69e2ea 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -26,6 +26,7 @@
 #include <net/pkt_cls.h>
 
 #include "chip.h"
+#include "leds.h"
 #include "smi.h"
 
 struct yt921x_mib_desc {
@@ -151,8 +152,6 @@ static const struct yt921x_info yt921x_infos[] = {
 	{}
 };
 
-#define YT921X_NAME	"yt921x"
-
 #define YT921X_VID_UNWARE	4095
 
 /* The interval should be small enough to avoid overflow of 32bit MIBs.
@@ -4559,6 +4558,10 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 		return res;
 #endif
 
+	res = yt921x_led_setup(priv);
+	if (res)
+		return res;
+
 	/* Clear MIB */
 	ctrl = YT921X_MIB_CTRL_CLEAN | YT921X_MIB_CTRL_ALL_PORT;
 	res = yt921x_reg_write(priv, YT921X_MIB_CTRL, ctrl);
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 950a5799f8b6..ea889319d996 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -850,9 +850,13 @@ enum yt921x_fdb_entry_status {
 #define YT921X_ACL_NUM		(YT921X_ACL_BLK_NUM * YT921X_ACL_ENT_PER_BLK)
 #define YT921X_UDF_NUM		8
 
+#define YT921X_LED_GROUP_NUM	3
+
 /* 8 internal + 2 external + 1 mcu */
 #define YT921X_PORT_NUM			11
 
+#define YT921X_NAME	"yt921x"
+
 #define yt921x_port_is_internal(port) ((port) < 8)
 #define yt921x_port_is_external(port) (8 <= (port) && (port) < 9)
 
@@ -928,6 +932,14 @@ struct yt921x_acl_blk {
 	struct yt921x_acl_rule *rules[YT921X_ACL_ENT_PER_BLK];
 };
 
+struct yt921x_led {
+	struct led_classdev cdev;
+	unsigned char group;
+
+	bool use_cycle;
+	bool use_duty;
+};
+
 struct yt921x_port {
 	struct yt921x_priv *priv;
 	unsigned char index;
@@ -939,6 +951,12 @@ struct yt921x_port {
 	struct yt921x_mib mib;
 	u64 rx_frames;
 	u64 tx_frames;
+
+#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
+	struct yt921x_led leds[YT921X_LED_GROUP_NUM];
+	unsigned int blink_cycle;
+	unsigned int blink_duty;
+#endif
 };
 
 struct yt921x_reg_ops {
diff --git a/drivers/net/dsa/motorcomm/leds.c b/drivers/net/dsa/motorcomm/leds.c
new file mode 100644
index 000000000000..49d657b38822
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/leds.c
@@ -0,0 +1,530 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 David Yang
+ */
+
+#include "chip.h"
+#include "leds.h"
+#include "smi.h"
+
+#define to_yt921x_led(led_cdev) \
+	container_of_const((led_cdev), struct yt921x_led, cdev)
+#define to_yt921x_port(led) \
+	((void *)((led) - (led)->group) - offsetof(struct yt921x_port, leds))
+#define to_yt921x_priv(pp) ((pp)->priv)
+#define to_device(priv) ((priv)->ds.dev)
+
+static u32 yt921x_led_regaddr(struct yt921x_priv *priv, int port, int group)
+{
+	switch (group) {
+	case 0:
+	default:
+		return YT921X_LED0_PORTn(port);
+	case 1:
+		return YT921X_LED1_PORTn(port);
+	case 2:
+		return YT921X_LED2_PORTn(port);
+	}
+}
+
+static int
+yt921x_led_force_get(struct yt921x_priv *priv, int port, int group, bool *onp)
+{
+	u32 val;
+	int res;
+
+	res = yt921x_reg_read(priv, YT921X_LED2_PORTn(port), &val);
+	if (res)
+		return res;
+
+	*onp = (val & YT921X_LED2_PORT_FORCEn_M(group)) ==
+	       YT921X_LED2_PORT_FORCEn_ON(group);
+	return 0;
+}
+
+static int
+yt921x_led_force_set(struct yt921x_priv *priv, int port, int group, bool on)
+{
+	struct yt921x_port *pp = priv->ports[port];
+	struct yt921x_led *led = &pp->leds[group];
+	u32 ctrl;
+	u32 mask;
+
+	if (!pp)
+		return -ENODEV;
+
+	led->use_cycle = false;
+	led->use_duty = false;
+
+	mask = YT921X_LED2_PORT_FORCEn_M(group);
+	ctrl = on ? YT921X_LED2_PORT_FORCEn_ON(group) :
+	       YT921X_LED2_PORT_FORCEn_OFF(group);
+	return yt921x_reg_update_bits(priv, YT921X_LED2_PORTn(port), mask,
+				      ctrl);
+}
+
+/* 2*lcm(2,3,4,6) */
+#define YT921X_LED_DUTY_DENOM 24
+#define YT921X_LED_DUTY(nom, denom) (YT921X_LED_DUTY_DENOM * (nom) / (denom))
+
+#define M_SQRT2 1.41421356237309504880
+
+static int
+yt921x_led_blink_select(const struct yt921x_priv *priv, unsigned long on,
+			unsigned long off, unsigned int *cyclep,
+			unsigned int *dutyp)
+{
+	unsigned int cycle_upper;
+	unsigned int cycle_req;
+	unsigned int cycle;
+	unsigned int duty;
+
+	if (!on && !off) {
+		*cyclep = YT921X_LED_BLINK_DEF;
+		*dutyp = YT921X_LED_DUTY(1, 2);
+		return 0;
+	}
+
+	cycle = YT921X_LED_BLINK_MAX;
+	cycle_upper = M_SQRT2 * YT921X_LED_BLINK_MAX + 1;
+	if (cycle_upper <= on + off)
+		return -EOPNOTSUPP;
+
+	cycle_req = on + off;
+	for (; cycle > YT921X_LED_BLINK_MIN; cycle_upper >>= 1, cycle >>= 1)
+		if (cycle_upper >> 1 <= cycle_req)
+			break;
+
+	duty = YT921X_LED_DUTY(on > off ? off : on, cycle_req);
+	if (duty < YT921X_LED_DUTY(5, 24))
+		duty = YT921X_LED_DUTY(1, 6);
+	else if (duty < YT921X_LED_DUTY(7, 24))
+		duty = YT921X_LED_DUTY(1, 4);
+	else if (duty < YT921X_LED_DUTY(5, 12))
+		duty = YT921X_LED_DUTY(1, 3);
+	else
+		duty = YT921X_LED_DUTY(1, 2);
+	if (on > off)
+		duty = YT921X_LED_DUTY_DENOM - duty;
+
+	*cyclep = cycle;
+	*dutyp = duty;
+	return 0;
+}
+
+static int
+yt921x_led_blink_set(struct yt921x_priv *priv, int port, int group,
+		     unsigned long *onp, unsigned long *offp)
+{
+	struct yt921x_port *pp = priv->ports[port];
+	struct yt921x_led *led = &pp->leds[group];
+	unsigned int cycle;
+	unsigned int duty;
+	bool change_cycle;
+	bool change_duty;
+	bool use_cycle;
+	u32 ctrl;
+	u32 mask;
+	u32 val;
+	int res;
+
+	if (!pp)
+		return -ENODEV;
+
+	res = yt921x_led_blink_select(priv, *onp, *offp, &cycle, &duty);
+	if (res)
+		return res;
+
+	use_cycle = cycle < YT921X_LED_BLINK_DEF;
+	change_cycle = use_cycle && cycle != pp->blink_cycle;
+	change_duty = duty != pp->blink_duty;
+	if (change_cycle || change_duty)
+		for (unsigned int i = 0; i < YT921X_LED_GROUP_NUM; i++) {
+			if (i == group)
+				continue;
+			if ((change_cycle && pp->leds[i].use_cycle) ||
+			    (change_duty && pp->leds[i].use_duty))
+				return -EOPNOTSUPP;
+		}
+
+	mask = YT921X_LED1_PORT_BLINK_DUTY_M | YT921X_LED1_PORT_BLINK_DUTY_COMP;
+	switch (duty >= YT921X_LED_DUTY(1, 2) ? duty :
+		YT921X_LED_DUTY_DENOM - duty) {
+	default:
+		duty = YT921X_LED_DUTY(1, 2);
+		fallthrough;
+	case YT921X_LED_DUTY(1, 2):
+		ctrl = YT921X_LED1_PORT_BLINK_DUTY_1_2;
+		break;
+	case YT921X_LED_DUTY(2, 3):
+		ctrl = YT921X_LED1_PORT_BLINK_DUTY_2_3;
+		break;
+	case YT921X_LED_DUTY(3, 4):
+		ctrl = YT921X_LED1_PORT_BLINK_DUTY_3_4;
+		break;
+	case YT921X_LED_DUTY(5, 6):
+		ctrl = YT921X_LED1_PORT_BLINK_DUTY_5_6;
+		break;
+	}
+	if (duty < YT921X_LED_DUTY(1, 2))
+		ctrl |= YT921X_LED1_PORT_BLINK_DUTY_COMP;
+	if (use_cycle) {
+		mask |= YT921X_LED1_PORT_OTHER_BLINK_M;
+		ctrl |= YT921X_LED1_PORT_OTHER_BLINK(9 - __fls(cycle));
+	}
+	res = yt921x_reg_update_bits(priv, YT921X_LED1_PORTn(port), mask, ctrl);
+	if (res)
+		return res;
+
+	res = yt921x_reg_read(priv, YT921X_LED2_PORTn(port), &val);
+	if (res)
+		return res;
+
+	/* The chip seems to jam a while if changing duty only */
+	ctrl = val & ~YT921X_LED2_PORT_FORCEn_M(group);
+	ctrl |= YT921X_LED2_PORT_FORCEn_OFF(group);
+	if (ctrl != val) {
+		res = yt921x_reg_write(priv, YT921X_LED2_PORTn(port), ctrl);
+		if (res)
+			return res;
+	}
+
+	ctrl = val & ~(YT921X_LED2_PORT_FORCEn_M(group) |
+		       YT921X_LED2_PORT_FORCE_BLINKn_M(group));
+	ctrl |= YT921X_LED2_PORT_FORCEn_BLINK(group);
+	if (use_cycle)
+		ctrl |= YT921X_LED2_PORT_FORCE_BLINKn_OTHER(group);
+	else
+		ctrl |= YT921X_LED2_PORT_FORCE_BLINKn(group, __fls(cycle) - 9);
+	res = yt921x_reg_write(priv, YT921X_LED2_PORTn(port), ctrl);
+	if (res)
+		return res;
+
+	if (use_cycle) {
+		led->use_cycle = true;
+		pp->blink_cycle = cycle;
+	}
+	led->use_duty = true;
+	pp->blink_duty = duty;
+
+	*onp = duty * cycle / YT921X_LED_DUTY_DENOM;
+	*offp = cycle - *onp;
+	return 0;
+}
+
+static u32 yt921x_led_trigger_maps[__TRIGGER_NETDEV_MAX] = {
+	[TRIGGER_NETDEV_LINK]		= YT921X_LEDx_PORT_ACT_ACTIVE,
+	[TRIGGER_NETDEV_LINK_10]	= YT921X_LEDx_PORT_ACT_10M,
+	[TRIGGER_NETDEV_LINK_100]	= YT921X_LEDx_PORT_ACT_100M,
+	[TRIGGER_NETDEV_LINK_1000]	= YT921X_LEDx_PORT_ACT_1000M,
+	[TRIGGER_NETDEV_HALF_DUPLEX]	= YT921X_LEDx_PORT_ACT_DUPLEX_HALF,
+	[TRIGGER_NETDEV_FULL_DUPLEX]	= YT921X_LEDx_PORT_ACT_DUPLEX_FULL,
+	[TRIGGER_NETDEV_TX]		= YT921X_LEDx_PORT_ACT_TX,
+	[TRIGGER_NETDEV_RX]		= YT921X_LEDx_PORT_ACT_RX,
+};
+
+static bool yt921x_led_trigger_is_supported(int group, unsigned long flags)
+{
+	unsigned int i;
+
+	for_each_set_bit(i, &flags, __TRIGGER_NETDEV_MAX)
+		if (!yt921x_led_trigger_maps[i])
+			return false;
+
+	return true;
+}
+
+static int
+yt921x_led_trigger_get(struct yt921x_priv *priv, int port, int group,
+		       unsigned long *flagsp)
+{
+	u32 addr = yt921x_led_regaddr(priv, port, group);
+	u32 val;
+	int res;
+
+	res = yt921x_reg_read(priv, addr, &val);
+	if (res)
+		return res;
+
+	*flagsp = 0;
+	for (unsigned int i = 0; i < __TRIGGER_NETDEV_MAX; i++)
+		if (val & yt921x_led_trigger_maps[i])
+			*flagsp |= BIT(i);
+
+	return 0;
+}
+
+static int
+yt921x_led_trigger_set(struct yt921x_priv *priv, int port, int group,
+		       unsigned long flags)
+{
+	struct yt921x_port *pp = priv->ports[port];
+	struct yt921x_led *led = &pp->leds[group];
+	unsigned int i;
+	u32 addr;
+	u32 ctrl;
+	u32 mask;
+	int res;
+
+	if (!pp)
+		return -ENODEV;
+
+	ctrl = 0;
+	for_each_set_bit(i, &flags, __TRIGGER_NETDEV_MAX) {
+		if (!yt921x_led_trigger_maps[i])
+			return -EOPNOTSUPP;
+
+		ctrl |= yt921x_led_trigger_maps[i];
+	}
+
+	led->use_cycle = false;
+	led->use_duty = false;
+
+	mask = !group ? YT921X_LED0_PORT_ACT_M : YT921X_LEDx_PORT_ACT_M;
+	if (group == 2) {
+		mask |= YT921X_LED2_PORT_FORCEn_M(group);
+		ctrl |= YT921X_LED2_PORT_FORCEn_DONTCARE(group);
+	}
+	addr = yt921x_led_regaddr(priv, port, group);
+	res = yt921x_reg_update_bits(priv, addr, mask, ctrl);
+	if (res)
+		return res;
+
+	if (group != 2) {
+		mask = YT921X_LED2_PORT_FORCEn_M(group);
+		ctrl = YT921X_LED2_PORT_FORCEn_DONTCARE(group);
+		res = yt921x_reg_update_bits(priv, YT921X_LED2_PORTn(port),
+					     mask, ctrl);
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
+static enum led_brightness
+yt921x_cled_brightness_get(struct led_classdev *led_cdev)
+{
+	struct yt921x_led *led = to_yt921x_led(led_cdev);
+	struct yt921x_port *pp = to_yt921x_port(led);
+	struct yt921x_priv *priv = to_yt921x_priv(pp);
+	bool on = false;
+
+	mutex_lock(&priv->reg_lock);
+	yt921x_led_force_get(priv, pp->index, led->group, &on);
+	mutex_unlock(&priv->reg_lock);
+
+	return on ? LED_ON : LED_OFF;
+}
+
+static int
+yt921x_cled_brightness_set_blocking(struct led_classdev *led_cdev,
+				    enum led_brightness brightness)
+{
+	struct yt921x_led *led = to_yt921x_led(led_cdev);
+	struct yt921x_port *pp = to_yt921x_port(led);
+	struct yt921x_priv *priv = to_yt921x_priv(pp);
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_led_force_set(priv, pp->index, led->group, brightness);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int
+yt921x_cled_blink_set(struct led_classdev *led_cdev, unsigned long *delay_on,
+		      unsigned long *delay_off)
+{
+	struct yt921x_led *led = to_yt921x_led(led_cdev);
+	struct yt921x_port *pp = to_yt921x_port(led);
+	struct yt921x_priv *priv = to_yt921x_priv(pp);
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_led_blink_set(priv, pp->index, led->group, delay_on,
+				   delay_off);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static struct device * __maybe_unused
+yt921x_cled_hw_control_get_device(struct led_classdev *led_cdev)
+{
+	struct yt921x_led *led = to_yt921x_led(led_cdev);
+	struct yt921x_port *pp = to_yt921x_port(led);
+	struct yt921x_priv *priv = to_yt921x_priv(pp);
+	struct dsa_port *dp;
+
+	dp = dsa_to_port(&priv->ds, pp->index);
+	if (!dp || !dp->user)
+		return NULL;
+	return &dp->user->dev;
+}
+
+static int __maybe_unused
+yt921x_cled_hw_control_is_supported(struct led_classdev *led_cdev,
+				    unsigned long flags)
+{
+	struct yt921x_led *led = to_yt921x_led(led_cdev);
+
+	return yt921x_led_trigger_is_supported(led->group, flags) ? 0 :
+	       -EOPNOTSUPP;
+}
+
+static int __maybe_unused
+yt921x_cled_hw_control_get(struct led_classdev *led_cdev, unsigned long *flagsp)
+{
+	struct yt921x_led *led = to_yt921x_led(led_cdev);
+	struct yt921x_port *pp = to_yt921x_port(led);
+	struct yt921x_priv *priv = to_yt921x_priv(pp);
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_led_trigger_get(priv, pp->index, led->group, flagsp);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int __maybe_unused
+yt921x_cled_hw_control_set(struct led_classdev *led_cdev, unsigned long flags)
+{
+	struct yt921x_led *led = to_yt921x_led(led_cdev);
+	struct yt921x_port *pp = to_yt921x_port(led);
+	struct yt921x_priv *priv = to_yt921x_priv(pp);
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_led_trigger_set(priv, pp->index, led->group, flags);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int
+yt921x_led_setup_port(struct yt921x_priv *priv, int port,
+		      struct fwnode_handle *fwnode, u32 *invp)
+{
+	struct yt921x_port *pp = priv->ports[port];
+	struct device *dev = to_device(priv);
+	struct led_init_data init_data = {};
+	struct led_classdev *led_cdev;
+	enum led_default_state state;
+	struct yt921x_led *led;
+	char name[64];
+	u32 group;
+	int res;
+
+	if (!pp)
+		return -ENODEV;
+
+	res = fwnode_property_read_u32(fwnode, "reg", &group);
+	if (res)
+		return res;
+
+	if (group >= YT921X_LED_GROUP_NUM) {
+		dev_warn(dev, "Invalid LED reg %d defined for port %d", group,
+			 port);
+		return -EINVAL;
+	}
+
+	led = &pp->leds[group];
+	led->group = group;
+
+	led_cdev = &led->cdev;
+	state = led_init_default_state_get(fwnode);
+	switch (state) {
+	case LEDS_DEFSTATE_OFF:
+	case LEDS_DEFSTATE_ON:
+		res = yt921x_led_force_set(priv, port, group, state);
+		if (res)
+			return res;
+		led_cdev->brightness = state;
+		break;
+	case LEDS_DEFSTATE_KEEP: {
+		bool on;
+
+		res = yt921x_led_force_get(priv, port, group, &on);
+		if (res)
+			return res;
+		led_cdev->brightness = on ? LED_ON : LED_OFF;
+		break;
+	}
+	}
+	led_cdev->max_brightness = 1;
+	led_cdev->flags = LED_RETAIN_AT_SHUTDOWN;
+	led_cdev->brightness_get = yt921x_cled_brightness_get;
+	led_cdev->brightness_set_blocking = yt921x_cled_brightness_set_blocking;
+	led_cdev->blink_set = yt921x_cled_blink_set;
+#ifdef CONFIG_LEDS_TRIGGERS
+	led_cdev->hw_control_trigger = "netdev";
+	led_cdev->hw_control_get_device = yt921x_cled_hw_control_get_device;
+	led_cdev->hw_control_is_supported = yt921x_cled_hw_control_is_supported;
+	led_cdev->hw_control_get = yt921x_cled_hw_control_get;
+	led_cdev->hw_control_set = yt921x_cled_hw_control_set;
+#endif
+
+	init_data.fwnode = fwnode;
+	snprintf(name, sizeof(name), YT921X_NAME "-%d:%02d:%d", priv->ds.index,
+		 port, group);
+	init_data.devicename = name;
+	init_data.devname_mandatory = true;
+
+	res = devm_led_classdev_register_ext(dev, led_cdev, &init_data);
+	if (res) {
+		dev_warn(dev, "Failed to init LED %d for port %d", group, port);
+		return res;
+	}
+
+	return 0;
+}
+
+int yt921x_led_setup(struct yt921x_priv *priv)
+{
+	struct dsa_switch *ds = &priv->ds;
+	struct dsa_port *dp;
+	u32 mask;
+	u32 ctrl;
+	int res;
+
+	mask = YT921X_LED_CTRL_MODE_M | YT921X_LED_CTRL_PORT_NUM_M |
+	       YT921X_LED_CTRL_EN;
+	ctrl = YT921X_LED_CTRL_MODE_PARALLEL | YT921X_LED_CTRL_PORT_NUM_M |
+	       YT921X_LED_CTRL_EN;
+	res = yt921x_reg_update_bits(priv, YT921X_LED_CTRL, mask, ctrl);
+	if (res)
+		return res;
+
+	ctrl = 0;
+	dsa_switch_for_each_port(dp, ds) {
+		struct device_node *leds_np;
+
+		if (!dp->dn)
+			continue;
+
+		leds_np = of_get_child_by_name(dp->dn, "leds");
+		if (!leds_np)
+			continue;
+
+		for_each_child_of_node_scoped(leds_np, led_np) {
+			res = yt921x_led_setup_port(priv, dp->index,
+						    of_fwnode_handle(led_np),
+						    &ctrl);
+			if (res)
+				break;
+		}
+
+		of_node_put(leds_np);
+		if (res)
+			return res;
+	}
+
+	res = yt921x_reg_write(priv, YT921X_LED_PAR_INV, ctrl);
+	if (res)
+		return res;
+
+	return 0;
+}
diff --git a/drivers/net/dsa/motorcomm/leds.h b/drivers/net/dsa/motorcomm/leds.h
new file mode 100644
index 000000000000..265d5ea5f04e
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/leds.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2026 David Yang
+ */
+
+#ifndef _YT_LEDS_H
+#define _YT_LEDS_H
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/kconfig.h>
+
+#define YT921X_LED_CTRL			0xd0000
+#define  YT921X_LED_CTRL_EN			BIT(21)
+#define  YT921X_LED_CTRL_LOOPDETECT_BLINK_M	GENMASK(20, 19)	/* cycle = 512 * x ms */
+#define   YT921X_LED_CTRL_LOOPDETECT_BLINK(x)		FIELD_PREP(YT921X_LED_CTRL_LOOPDETECT_BLINK_M, (x))
+#define  YT921X_LED_CTRL_PORT_NUM_M		GENMASK(16, 13)
+#define   YT921X_LED_CTRL_PORT_NUM(x)			FIELD_PREP(YT921X_LED_CTRL_PORT_NUM_M, (x))
+#define  YT921X_LED_CTRL_MODE_M			GENMASK(1, 0)
+#define   YT921X_LED_CTRL_MODE(x)			FIELD_PREP(YT921X_LED_CTRL_MODE_M, (x))
+#define   YT921X_LED_CTRL_MODE_PARALLEL			YT921X_LED_CTRL_MODE(0)
+#define   YT921X_LED_CTRL_MODE_SERIAL			YT921X_LED_CTRL_MODE(2)
+#define YT921X_LED0_PORTn(port)		(0xd0004 + 4 * (port))
+#define  YT921X_LED0_PORT_ACT_M			GENMASK(17, 0)
+#define  YT921X_LED0_PORT_ACT_LINK_TRY_DIS	BIT(17)
+#define  YT921X_LED0_PORT_ACT_COLLISION_BLINK	BIT(16)
+#define YT921X_LED1_PORTn(port)		(0xd0040 + 4 * (port))
+#define  YT921X_LED1_PORT_OTHER_BLINK_M		GENMASK(31, 30)	/* cycle = 512 >> x ms */
+#define   YT921X_LED1_PORT_OTHER_BLINK(x)		FIELD_PREP(YT921X_LED1_PORT_OTHER_BLINK_M, (x))
+#define  YT921X_LED1_PORT_EEE_BLINK_M		GENMASK(29, 28)	/* cycle = 512 >> x ms */
+#define   YT921X_LED1_PORT_EEE_BLINK(x)			FIELD_PREP(YT921X_LED1_PORT_EEE_BLINK_M, (x))
+#define  YT921X_LED1_PORT_BLINK_DUTY_COMP	BIT(27)
+#define  YT921X_LED1_PORT_BLINK_DUTY_M		GENMASK(26, 25)
+#define   YT921X_LED1_PORT_BLINK_DUTY(x)		FIELD_PREP(YT921X_LED1_PORT_BLINK_DUTY_M, (x))
+#define   YT921X_LED1_PORT_BLINK_DUTY_1_2		YT921X_LED1_PORT_BLINK_DUTY(0)
+#define   YT921X_LED1_PORT_BLINK_DUTY_2_3		YT921X_LED1_PORT_BLINK_DUTY(1)
+#define   YT921X_LED1_PORT_BLINK_DUTY_3_4		YT921X_LED1_PORT_BLINK_DUTY(2)
+#define   YT921X_LED1_PORT_BLINK_DUTY_5_6		YT921X_LED1_PORT_BLINK_DUTY(3)
+#define YT921X_LED2_PORTn(port)		(0xd0080 + 4 * (port))
+#define  YT921X_LED2_PORT_FORCEn_M(grp)		GENMASK(4 * (grp) + 19, 4 * (grp) + 18)
+#define   YT921X_LED2_PORT_FORCEn(grp, x)		((x) << (4 * (grp) + 18))
+#define   YT921X_LED2_PORT_FORCEn_DONTCARE(grp)		YT921X_LED2_PORT_FORCEn(grp, 0)
+#define   YT921X_LED2_PORT_FORCEn_BLINK(grp)		YT921X_LED2_PORT_FORCEn(grp, 1)
+#define   YT921X_LED2_PORT_FORCEn_ON(grp)		YT921X_LED2_PORT_FORCEn(grp, 2)
+#define   YT921X_LED2_PORT_FORCEn_OFF(grp)		YT921X_LED2_PORT_FORCEn(grp, 3)
+#define  YT921X_LED2_PORT_FORCE_BLINKn_M(grp)	GENMASK(4 * (grp) + 17, 4 * (grp) + 16)	/* cycle = 512 << x ms */
+#define   YT921X_LED2_PORT_FORCE_BLINKn(grp, x)		((x) << (4 * (grp) + 16))
+#define   YT921X_LED2_PORT_FORCE_BLINKn_OTHER(grp)	YT921X_LED2_PORT_FORCE_BLINKn(grp, 3)
+#define  YT921X_LEDx_PORT_ACT_M			GENMASK(16, 0)
+#define  YT921X_LEDx_PORT_ACT_EEE		BIT(15)
+#define  YT921X_LEDx_PORT_ACT_LOOPDETECT	BIT(14)
+#define  YT921X_LEDx_PORT_ACT_ACTIVE		BIT(13)
+#define  YT921X_LEDx_PORT_ACT_DUPLEX_FULL	BIT(12)
+#define  YT921X_LEDx_PORT_ACT_DUPLEX_HALF	BIT(11)
+#define  YT921X_LEDx_PORT_ACT_TX_BLINK		BIT(10)
+#define  YT921X_LEDx_PORT_ACT_RX_BLINK		BIT(9)
+#define  YT921X_LEDx_PORT_ACT_TX		BIT(8)
+#define  YT921X_LEDx_PORT_ACT_RX		BIT(7)
+#define  YT921X_LEDx_PORT_ACT_1000M		BIT(6)
+#define  YT921X_LEDx_PORT_ACT_100M		BIT(5)
+#define  YT921X_LEDx_PORT_ACT_10M		BIT(4)
+#define  YT921X_LEDx_PORT_ACT_COLLISION_BLINK_EN	BIT(3)
+#define  YT921X_LEDx_PORT_ACT_1000M_BLINK	BIT(2)
+#define  YT921X_LEDx_PORT_ACT_100M_BLINK	BIT(1)
+#define  YT921X_LEDx_PORT_ACT_10M_BLINK		BIT(0)
+#define YT921X_LED_SER_CTRL		0xd0100
+#define  YT921X_LED_SER_CTRL_EN			GENMASK(25, 24)
+#define  YT921X_LED_SER_CTRL_ACTIVE_LOW		BIT(4)
+#define  YT921X_LED_SER_CTRL_LED_NUM_M		GENMASK(1, 0)	/* #led - 1 */
+#define   YT921X_LED_SER_CTRL_LED_NUM(x)		FIELD_PREP(YT921X_LED_SER_CTRL_LED_NUM_M, (x))
+#define YT921X_LED_SER_MAPnm(grp, port)	(0xd0104 + 8 * (2 - (grp)) + 4 * ((port) / 5))
+#define  YT921X_LED_SER_MAP_DSTn_PORT_M(port)	GENMASK(6 * ((port) % 5) + 5, 6 * ((port) % 5) + 2)
+#define   YT921X_LED_SER_MAP_DSTn_PORT(port, x)		((x) << (6 * ((port) % 5) + 2))
+#define  YT921X_LED_SER_MAP_DSTn_LED_M(port)	GENMASK(6 * ((port) % 5) + 1, 6 * ((port) % 5))
+#define   YT921X_LED_SER_MAP_DSTn_LED(port, x)		((x) << (6 * ((port) % 5)))
+#define YT921X_LED_PAR_PORTS		0xd01c4
+#define YT921X_LED_PAR_INV		0xd01c8
+#define  YT921X_LED_PAR_INV_INVnm(grp, port)	BIT(10 * (grp) + (port))
+#define YT921X_LED_PAR_MAPn(port)	(0xd01d0 + 4 * (port))
+#define  YT921X_LED_PAR_MAP_DSTn_PORT_M(grp)	GENMASK(6 * (grp) + 5, 6 * (grp) + 2)
+#define   YT921X_LED_PAR_MAP_DSTn_PORT(grp, x)		((x) << (6 * (grp) + 2))
+#define  YT921X_LED_PAR_MAP_DSTn_LED_M(grp)	GENMASK(6 * (grp) + 1, 6 * (grp))
+#define   YT921X_LED_PAR_MAP_DSTn_LED(grp, x)		((x) << (6 * (grp)))
+
+#define YT921X_LED_BLINK_MIN	64
+#define YT921X_LED_BLINK_DEF	512
+#define YT921X_LED_BLINK_MAX	2048
+
+struct yt921x_priv;
+
+#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
+
+int yt921x_led_setup(struct yt921x_priv *priv);
+
+#else
+
+static inline int yt921x_led_setup(struct yt921x_priv *priv)
+{
+	return 0;
+}
+
+#endif
+
+#endif
-- 
2.53.0


