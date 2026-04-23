Return-Path: <netdev+bounces-280789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yH6eKew26mk+xAIAu9opvQ
	(envelope-from <netdev+bounces-280789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 17:12:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EB7454239
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 17:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E06D0302D583
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C2435B651;
	Thu, 23 Apr 2026 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihB2MWoI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B34C282F0A
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956872; cv=none; b=IfDPrvBoKfGum+r5zBwtroGWnq0TSc0eMDwIU6uL3FoKPuNyDZpjsqk4Z6+HA3A/L1TdI2q9oZgdQp6+aP2qVGbbNX/aIKTPsYqEGCZEzvnmSyS+5pCPHbcbVz2cZInm+LS7kUluMWuaceOFGiUj5lAeOaoGiG2nH96OTaNoR2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956872; c=relaxed/simple;
	bh=WMI4VjYNu03MckjM9rAUqTjjkeYUXUrN2E0VKTqs8mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWCRQ14kGA64RvM+vYOKXEjUYem6qOWjdS8iB6pmxi4YYDnPmVr0/7QQwUnm+nDPkBGcVYNlTyRMoFUKOLnlVwK926Ani79WP2Vw9u3BYq2LwOj5xTFbfZbmysQnzCQM4eXAbctGupQ4dAF2Cx/V2tm2+oHDeUseXw82OXYEmAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihB2MWoI; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c70c38515d3so120982a12.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 08:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776956871; x=1777561671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ncRdIw57dAdFwEniSDi8OzdJOxPZzPJeYFRngcHEmo=;
        b=ihB2MWoI59lNit2/C1GJfrVa7kioQX0IDEeHRx36bLiIfjkJ/v3HGzo7GL00wyB7zN
         ZFTfrfFN1dy9+Qx+F5o2sMMe10uPJ/kDxeax9oCKU6R34b4eMensrHPrR1czmYyjYRx3
         Q+ErfxAkpA55ZW9lDZk8PHelYXSur/gA7XyoPiO1YRBPEurPDgAr6C9dV8GMCa8d3B8c
         WLE1yN+S7qQ1bTkF0wOMjsKq36YItcw+IMJwNwtAtoZLnn4wR5EsJz1pO61xf23qMWsb
         0plMHC6xovdo+s7rpG7QqO0MiJDZQrKDyQjPqIlQxyuW0pQsVdiHtLHttKNPvJz04Dun
         hXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776956871; x=1777561671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ncRdIw57dAdFwEniSDi8OzdJOxPZzPJeYFRngcHEmo=;
        b=WZdbFAsd1GfSgT3jJCDy+JwzAwh48+F8N/by3RqCHj+aY76sYBCmCyZE3LqLnVJwZK
         Vy0cpCIWAEd6tlkfpdbli0V6usVN5vjfKFAcCMle5lEW/ee1+R0tndmOGrNK83DDgKUD
         PAmYFZqNuktyLpZ+EQ5X2xLdQKE3BZJgmeWJysCw5vilwd1G32C/5zGzzU/riCqGNflM
         bPkQRFq4R5U3i2hTchfR/UY6t7UrZo/2XqqEEFVZOhVKKV1wbCQpMTPFzmCkBFv//w8s
         x3iQjThQWtHuTa78uTTUC+GtM/+dBzS2+F1CHAqLddBcdPeI7NvIb6ubkxtKq/1rr44J
         ce1A==
X-Forwarded-Encrypted: i=1; AFNElJ/ZANMVqI1LpuMeC34KL9kyXj3cFoffUH3ACNCtJkj+lCwhNq/H4fSvqCE75ZGyxIY/53eh4qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjlKCnA6eEth0j63Bdpt+78Z8jMai+4QpOZGI7M5FRrR2h8FRr
	GoDSw8fvEnzG62D5C7nxilJ7rLR6+BjdgEW01R9ttQNM4kvngNYa2TT7
X-Gm-Gg: AeBDietaiBPxGHlplBpJin/N6wjV8wnMvhHugAqEc+nAycSx7WOJuZUSMOMZW7WrHwm
	lVfqke3mXcffiGw77e5LZe8kZUTtIA3OlvhNWWwixA4e3Z0ky/2j2Qv6BruW0AsfOqrLu1kGYF8
	k7N5mzzbyfNUAAelVV9o7xprPH612hf19HXD/NUvmx/+4Hk4PqvK05Qf5+unxUjZh1aa/q9C9Pl
	mHdzBKUMyP6MeKxnjuJhj37thQTGujs00sQDWnkr0BqmEwCDJU6/4O2FwlWsx/jCbBTcEfhYhzA
	RwSoAiXrLxgRfUioUhxZdaYjSrWvtUGItRzV57BFcZThIL9CfhRWrb+1CaZzG5zZpweJTYz8sig
	5Lg5Y875dAI31h3AmP0QtCcj6EvVQPANWjFRJyGvUWvEUA+YJRcoNSorOG+mfeUK7GXhVBKH3xa
	8wQg+eTRoYxpV9EpwD1wNMsfMnyRc=
X-Received: by 2002:a05:6a20:7350:b0:3a2:d58a:b749 with SMTP id adf61e73a8af0-3a2d58b0db2mr10284603637.7.1776956870472;
        Thu, 23 Apr 2026 08:07:50 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797703ddf8sm15903101a12.28.2026.04.23.08.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 08:07:49 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: w@1wt.eu,
	pabeni@redhat.com
Cc: chandrashekar.devegowda@intel.com,
	linux-wwan@lists.linux.dev,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v5] net: wwan: t7xx: validate port_count against message length in t7xx_port_enum_msg_handler
Date: Thu, 23 Apr 2026 11:07:33 -0400
Message-ID: <20260423150733.2025838-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <3c2f573f-c457-4aec-b929-9e049b4c1d25@redhat.com>
References: <3c2f573f-c457-4aec-b929-9e049b4c1d25@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280789-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lists.linux.dev,vger.kernel.org,gmail.com];
	MAILSPIKE_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35EB7454239
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

t7xx_port_enum_msg_handler() uses the modem-supplied port_count field as
a loop bound over port_msg->data[] without checking that the message buffer
contains sufficient data. A modem sending port_count=65535 in a 12-byte
buffer triggers a slab-out-of-bounds read of up to 262140 bytes.

Add a struct_size() check after extracting port_count and before the loop.
Pass msg_len to t7xx_port_enum_msg_handler() and use it to validate
the message size before accessing port_msg->data[].
Pass msg_len from both call sites: skb->len at the DPMAIF path after
skb_pull(), and the captured rt_feature->data_len at the handshake path.

Fixes: 39d439047f1d ("net: wwan: t7xx: Add control DMA interface")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
 drivers/net/wwan/t7xx/t7xx_modem_ops.c     | 10 +++++++---
 drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c | 12 ++++++++++--
 drivers/net/wwan/t7xx/t7xx_port_proxy.h    |  2 +-
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
index 7968e208d..dc90691ef 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
@@ -453,12 +453,14 @@ static int t7xx_parse_host_rt_data(struct t7xx_fsm_ctl *ctl, struct t7xx_sys_inf
 {
 	enum mtk_feature_support_type ft_spt_st, ft_spt_cfg;
 	struct mtk_runtime_feature *rt_feature;
+	size_t feat_data_len;
 	int i, offset;
 
 	offset = sizeof(struct feature_query);
 	for (i = 0; i < FEATURE_COUNT && offset < data_length; i++) {
 		rt_feature = data + offset;
-		offset += sizeof(*rt_feature) + le32_to_cpu(rt_feature->data_len);
+		feat_data_len = le32_to_cpu(rt_feature->data_len);
+		offset += sizeof(*rt_feature) + feat_data_len;
 
 		ft_spt_cfg = FIELD_GET(FEATURE_MSK, core->feature_set[i]);
 		if (ft_spt_cfg != MTK_FEATURE_MUST_BE_SUPPORTED)
@@ -468,8 +470,10 @@ static int t7xx_parse_host_rt_data(struct t7xx_fsm_ctl *ctl, struct t7xx_sys_inf
 		if (ft_spt_st != MTK_FEATURE_MUST_BE_SUPPORTED)
 			return -EINVAL;
 
-		if (i == RT_ID_MD_PORT_ENUM || i == RT_ID_AP_PORT_ENUM)
-			t7xx_port_enum_msg_handler(ctl->md, rt_feature->data);
+		if (i == RT_ID_MD_PORT_ENUM || i == RT_ID_AP_PORT_ENUM) {
+			t7xx_port_enum_msg_handler(ctl->md, rt_feature->data,
+						   feat_data_len);
+		}
 	}
 
 	return 0;
diff --git a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
index ae632ef96..fa2428444 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
@@ -117,6 +117,7 @@ static int fsm_ee_message_handler(struct t7xx_port *port, struct t7xx_fsm_ctl *c
  * t7xx_port_enum_msg_handler() - Parse the port enumeration message to create/remove nodes.
  * @md: Modem context.
  * @msg: Message.
+ * @msg_len:	Length of @msg in bytes.
  *
  * Used to control create/remove device node.
  *
@@ -124,7 +125,7 @@ static int fsm_ee_message_handler(struct t7xx_port *port, struct t7xx_fsm_ctl *c
  * * 0		- Success.
  * * -EFAULT	- Message check failure.
  */
-int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg)
+int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg, size_t msg_len)
 {
 	struct device *dev = &md->t7xx_dev->pdev->dev;
 	unsigned int version, port_count, i;
@@ -141,6 +142,13 @@ int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg)
 	}
 
 	port_count = FIELD_GET(PORT_MSG_PRT_CNT, le32_to_cpu(port_msg->info));
+
+	if (msg_len < struct_size(port_msg, data, port_count)) {
+		dev_err(dev, "Port enum msg too short: need %zu, have %zu\n",
+			struct_size(port_msg, data, port_count), msg_len);
+		return -EINVAL;
+	}
+
 	for (i = 0; i < port_count; i++) {
 		u32 port_info = le32_to_cpu(port_msg->data[i]);
 		unsigned int ch_id;
@@ -191,7 +199,7 @@ static int control_msg_handler(struct t7xx_port *port, struct sk_buff *skb)
 
 	case CTL_ID_PORT_ENUM:
 		skb_pull(skb, sizeof(*ctrl_msg_h));
-		ret = t7xx_port_enum_msg_handler(ctl->md, (struct port_msg *)skb->data);
+		ret = t7xx_port_enum_msg_handler(ctl->md, (struct port_msg *)skb->data, skb->len);
 		if (!ret)
 			ret = port_ctl_send_msg_to_md(port, CTL_ID_PORT_ENUM, 0);
 		else
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.h b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
index f0918b36e..7c3190bf0 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
@@ -103,7 +103,7 @@ void t7xx_port_proxy_reset(struct port_proxy *port_prox);
 void t7xx_port_proxy_uninit(struct port_proxy *port_prox);
 int t7xx_port_proxy_init(struct t7xx_modem *md);
 void t7xx_port_proxy_md_status_notify(struct port_proxy *port_prox, unsigned int state);
-int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg);
+int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg, size_t msg_len);
 int t7xx_port_proxy_chl_enable_disable(struct port_proxy *port_prox, unsigned int ch_id,
 				       bool en_flag);
 void t7xx_port_proxy_set_cfg(struct t7xx_modem *md, enum port_cfg_id cfg_id);
-- 
2.53.0


