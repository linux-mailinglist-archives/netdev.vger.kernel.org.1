Return-Path: <netdev+bounces-231871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091CFBFE0EF
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3253219C6EB9
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FC034AAED;
	Wed, 22 Oct 2025 19:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzqCHuMS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221EC2E2EF1
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761161863; cv=none; b=magOebhtf6B3mVcELNYX8wDu1nhGCmxOer+LwU+1nv9DcBS/BhFsl2oCjcUUKbVtrpjdFjBI9G7Yrh/sblOsJtOCY4oruOA7jo+NS8CZL/4MNeKIrkfKcFvJoanx5IzsIZ8tQHF/Q8MaJtbONsQMZWIxbbzllB7Pn0d7tUQU+gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761161863; c=relaxed/simple;
	bh=I3cHTrAxy2U+MxqnGLbfk7CvSLkrAOGgZJa4QBXHuVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yj+O/n5i6dqhVUf8+JVMENXSpHCyS3BU6pc0+GnwgsZUDRB+A9fcEdLhwf8xvR+6b7z63u/NI6LirMMF1C+xag3rztedBdstct0+2+66kU5DaFUHQ5egAR/Y+juZA4xRDw9EUdrm9sL/6Hr58weVzu+v6ikoJTd5VPnjFC/moNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzqCHuMS; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7817c2d909cso83593117b3.1
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 12:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761161861; x=1761766661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1I6BBnxvi5qLac/74f/dMlgM8GZOp/rYTvMusxZK7TQ=;
        b=VzqCHuMSIaBKAMoqf+FSBQNxK7D7vboglEyqofZ67lHAcGxPISA0HMo2YERgFce/Mm
         VxkrZka3UKNhhsyCvBCWAqrjkrkLhKJWW8g3NrCFVSye30Osi0Nn7U+Z+a5Z8HIiSsv6
         n50FGhiZexvjR3haAQ/kLYRsvb7fyjo8R1sbV1Bi54Q8MX7n+21j0XtojazDjGIWc08h
         SLQQGKVqySIX87t0IvME3ZGrcacmP+SvWo+5fyzuGJnA6WDZ3c2M30938EcUbjpYbng6
         zgBI8auMjeN7GCM4lvYUpSay0MqdaxysMTm92AArdpXpgqTdKQJxvPAxhG1xdsNc5QZo
         bYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761161861; x=1761766661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1I6BBnxvi5qLac/74f/dMlgM8GZOp/rYTvMusxZK7TQ=;
        b=kGN20WDxdvG6op30g9R4eVAD9yAnbsVehyq2MCDSvc8sy/RgzxQo0/VoCiY8y5Q2cP
         WIZxuLtTjUypBVSFwpK1n/MrfP2vN3pFev2AkydTjBWRpddzIWhmegc4vGaifqxQjDcU
         1OWOzJDE92v4dU4ofvdv+XR+v/ZcSsttWtXYREZOS7zzhyazvYxUQtJnwVACESbzCgrP
         8BlWQgb+J23KpMwXFNS4ORgnBTaZ8f2KQszF11xORsh4UJYytZ7nAN68cVCdtu/bPmLh
         Kbe/3J8L8LkOzQjwfgP8CmCNkcpI0z6e9cEPUqxBcTUSs/Yq4P3r8Lapt5BNlNX4eJnh
         D8dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPTbozLUlgHcD4BAXg1PupXyMO80EF6fG4bL0sewXSsKfXSpn0BIWS29QTugKC1aMBKNCNFaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmAnd1VFeOonPBlA8BqWA504Mx//xgQte3qvB+tmB7j3C7YQ1B
	Bk7djQbGrefEOhlyy82B29afADZkChQrJVkt4apdpvMWf9ir7AvjcpGx
X-Gm-Gg: ASbGncsPJEhGpvdaGqMB6Gg3FNO0S1P9ijlzwGl+KWPgtcVa/9YCAeYuxTuHHE01xA6
	8NzmwiSS+5Fzhu7zvZWCmU2OQwYco2tHSKGfhu/Kp/1AVCPm3LEt2m8vr67eOJE/978UkZocLy3
	OkbqB5WbbBQB3POx67n5HVcHQE5yo2uv3cwJGrStwINvtt7LZk4lChdl9ZT17LJcCM3n18z+WEp
	SbVw4oFHIWbVdjpIjOSLPzfeNBBM7F1Gy+PGWHlFYg6Tq9CXQw9U+I4Zr3VSTmmEfDCyGEknF2L
	moEHgP5el/cFEUFxARlmgrUpmdg0wnQU6EBlJ76QXKT8/ykWl7AQby8CNIOYNBx6nVobz5jtqnR
	AhJYWQiOgDhPlzq0SZI1HJ1KVcXB35OR1pAre8uQBL3SUVnArhKyILoAlSm8wzBlY1+f5Q/xt/L
	y2qvWvn4jX
X-Google-Smtp-Source: AGHT+IH+iLB6X3B/A9qOT5qQojJ/eSkqHMtJhTbDnR+YPsUvzwnyluoqh2ZL2XNJmLBjojFYz9a/pg==
X-Received: by 2002:a05:690c:3809:b0:783:6f8d:e7a6 with SMTP id 00721157ae682-7836f8df439mr333615937b3.51.1761161861001;
        Wed, 22 Oct 2025 12:37:41 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd6ec6besm301287b3.50.2025.10.22.12.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 12:37:40 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Willem de Bruijn <willemb@google.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 1/5] psp: report basic stats from the core
Date: Wed, 22 Oct 2025 12:37:33 -0700
Message-ID: <20251022193739.1376320-2-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251022193739.1376320-1-daniel.zahka@gmail.com>
References: <20251022193739.1376320-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Track and report stats common to all psp devices from the core. A
'stale-event' is when the core marks the rx state of an active
psp_assoc as incapable of authenticating psp encapsulated data.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 Documentation/netlink/specs/psp.yaml | 40 ++++++++++++++
 include/net/psp/types.h              |  9 ++++
 include/uapi/linux/psp.h             | 10 ++++
 net/psp/psp-nl-gen.c                 | 19 +++++++
 net/psp/psp-nl-gen.h                 |  2 +
 net/psp/psp_nl.c                     | 79 ++++++++++++++++++++++++++++
 net/psp/psp_sock.c                   |  4 +-
 7 files changed, 162 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
index 944429e5c9a8..914148221384 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -76,6 +76,28 @@ attribute-sets:
         name: spi
         doc: Security Parameters Index (SPI) of the association.
         type: u32
+  -
+    name: stats
+    attributes:
+      -
+        name: dev-id
+        doc: PSP device ID.
+        type: u32
+        checks:
+          min: 1
+      -
+        name: key-rotations
+        type: uint
+        doc: |
+          Number of key rotations during the lifetime of the device.
+          Kernel statistic.
+      -
+        name: stale-events
+        type: uint
+        doc: |
+          Number of times a socket's Rx got shut down due to using
+          a key which went stale (fully rotated out).
+          Kernel statistic.
 
 operations:
   list:
@@ -177,6 +199,24 @@ operations:
         pre: psp-assoc-device-get-locked
         post: psp-device-unlock
 
+    -
+      name: get-stats
+      doc: Get device statistics.
+      attribute-set: stats
+      do:
+        request:
+          attributes:
+            - dev-id
+        reply: &stats-all
+          attributes:
+            - dev-id
+            - key-rotations
+            - stale-events
+        pre: psp-device-get-locked
+        post: psp-device-unlock
+      dump:
+        reply: *stats-all
+
 mcast-groups:
   list:
     -
diff --git a/include/net/psp/types.h b/include/net/psp/types.h
index 31cee64b7c86..5b0ccaac3882 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -59,6 +59,10 @@ struct psp_dev_config {
  *			device key
  * @stale_assocs:	associations which use a rotated out key
  *
+ * @stats:	statistics maintained by the core
+ * @stats.rotations:	See stats attr key-rotations
+ * @stats.stales:	See stats attr stale-events
+ *
  * @rcu:	RCU head for freeing the structure
  */
 struct psp_dev {
@@ -81,6 +85,11 @@ struct psp_dev {
 	struct list_head prev_assocs;
 	struct list_head stale_assocs;
 
+	struct {
+		unsigned long rotations;
+		unsigned long stales;
+	} stats;
+
 	struct rcu_head rcu;
 };
 
diff --git a/include/uapi/linux/psp.h b/include/uapi/linux/psp.h
index 607c42c39ba5..31592760ad79 100644
--- a/include/uapi/linux/psp.h
+++ b/include/uapi/linux/psp.h
@@ -45,6 +45,15 @@ enum {
 	PSP_A_KEYS_MAX = (__PSP_A_KEYS_MAX - 1)
 };
 
+enum {
+	PSP_A_STATS_DEV_ID = 1,
+	PSP_A_STATS_KEY_ROTATIONS,
+	PSP_A_STATS_STALE_EVENTS,
+
+	__PSP_A_STATS_MAX,
+	PSP_A_STATS_MAX = (__PSP_A_STATS_MAX - 1)
+};
+
 enum {
 	PSP_CMD_DEV_GET = 1,
 	PSP_CMD_DEV_ADD_NTF,
@@ -55,6 +64,7 @@ enum {
 	PSP_CMD_KEY_ROTATE_NTF,
 	PSP_CMD_RX_ASSOC,
 	PSP_CMD_TX_ASSOC,
+	PSP_CMD_GET_STATS,
 
 	__PSP_CMD_MAX,
 	PSP_CMD_MAX = (__PSP_CMD_MAX - 1)
diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
index 9fdd6f831803..73f8b06d66f0 100644
--- a/net/psp/psp-nl-gen.c
+++ b/net/psp/psp-nl-gen.c
@@ -47,6 +47,11 @@ static const struct nla_policy psp_tx_assoc_nl_policy[PSP_A_ASSOC_SOCK_FD + 1] =
 	[PSP_A_ASSOC_SOCK_FD] = { .type = NLA_U32, },
 };
 
+/* PSP_CMD_GET_STATS - do */
+static const struct nla_policy psp_get_stats_nl_policy[PSP_A_STATS_DEV_ID + 1] = {
+	[PSP_A_STATS_DEV_ID] = NLA_POLICY_MIN(NLA_U32, 1),
+};
+
 /* Ops table for psp */
 static const struct genl_split_ops psp_nl_ops[] = {
 	{
@@ -99,6 +104,20 @@ static const struct genl_split_ops psp_nl_ops[] = {
 		.maxattr	= PSP_A_ASSOC_SOCK_FD,
 		.flags		= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= PSP_CMD_GET_STATS,
+		.pre_doit	= psp_device_get_locked,
+		.doit		= psp_nl_get_stats_doit,
+		.post_doit	= psp_device_unlock,
+		.policy		= psp_get_stats_nl_policy,
+		.maxattr	= PSP_A_STATS_DEV_ID,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= PSP_CMD_GET_STATS,
+		.dumpit	= psp_nl_get_stats_dumpit,
+		.flags	= GENL_CMD_CAP_DUMP,
+	},
 };
 
 static const struct genl_multicast_group psp_nl_mcgrps[] = {
diff --git a/net/psp/psp-nl-gen.h b/net/psp/psp-nl-gen.h
index 25268ed11fb5..5bc3b5d5a53e 100644
--- a/net/psp/psp-nl-gen.h
+++ b/net/psp/psp-nl-gen.h
@@ -28,6 +28,8 @@ int psp_nl_dev_set_doit(struct sk_buff *skb, struct genl_info *info);
 int psp_nl_key_rotate_doit(struct sk_buff *skb, struct genl_info *info);
 int psp_nl_rx_assoc_doit(struct sk_buff *skb, struct genl_info *info);
 int psp_nl_tx_assoc_doit(struct sk_buff *skb, struct genl_info *info);
+int psp_nl_get_stats_doit(struct sk_buff *skb, struct genl_info *info);
+int psp_nl_get_stats_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 
 enum {
 	PSP_NLGRP_MGMT,
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index 8aaca62744c3..094da52e357e 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -262,6 +262,7 @@ int psp_nl_key_rotate_doit(struct sk_buff *skb, struct genl_info *info)
 		     psd->generation & ~PSP_GEN_VALID_MASK);
 
 	psp_assocs_key_rotated(psd);
+	psd->stats.rotations++;
 
 	nlmsg_end(ntf, (struct nlmsghdr *)ntf->data);
 	genlmsg_multicast_netns(&psp_nl_family, dev_net(psd->main_netdev), ntf,
@@ -503,3 +504,81 @@ int psp_nl_tx_assoc_doit(struct sk_buff *skb, struct genl_info *info)
 	nlmsg_free(rsp);
 	return err;
 }
+
+static int
+psp_nl_stats_fill(struct psp_dev *psd, struct sk_buff *rsp,
+		  const struct genl_info *info)
+{
+	void *hdr;
+
+	hdr = genlmsg_iput(rsp, info);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (nla_put_u32(rsp, PSP_A_STATS_DEV_ID, psd->id) ||
+	    nla_put_uint(rsp, PSP_A_STATS_KEY_ROTATIONS,
+			 psd->stats.rotations) ||
+	    nla_put_uint(rsp, PSP_A_STATS_STALE_EVENTS, psd->stats.stales))
+		goto err_cancel_msg;
+
+	genlmsg_end(rsp, hdr);
+	return 0;
+
+err_cancel_msg:
+	genlmsg_cancel(rsp, hdr);
+	return -EMSGSIZE;
+}
+
+int psp_nl_get_stats_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct psp_dev *psd = info->user_ptr[0];
+	struct sk_buff *rsp;
+	int err;
+
+	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!rsp)
+		return -ENOMEM;
+
+	err = psp_nl_stats_fill(psd, rsp, info);
+	if (err)
+		goto err_free_msg;
+
+	return genlmsg_reply(rsp, info);
+
+err_free_msg:
+	nlmsg_free(rsp);
+	return err;
+}
+
+static int
+psp_nl_stats_get_dumpit_one(struct sk_buff *rsp, struct netlink_callback *cb,
+			    struct psp_dev *psd)
+{
+	if (psp_dev_check_access(psd, sock_net(rsp->sk)))
+		return 0;
+
+	return psp_nl_stats_fill(psd, rsp, genl_info_dump(cb));
+}
+
+int psp_nl_get_stats_dumpit(struct sk_buff *rsp, struct netlink_callback *cb)
+{
+	struct psp_dev *psd;
+	unsigned long index;
+	int err = 0;
+
+	mutex_lock(&psp_devs_lock);
+	xa_for_each_start(&psp_devs, index, psd, cb->args[0]) {
+		mutex_lock(&psd->lock);
+		err = psp_nl_stats_get_dumpit_one(rsp, cb, psd);
+		mutex_unlock(&psd->lock);
+		if (err)
+			break;
+	}
+	mutex_unlock(&psp_devs_lock);
+
+	if (err != -EMSGSIZE)
+		return err;
+
+	cb->args[0] = index;
+	return err;
+}
diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index a931d825d1cc..f785672b7df6 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -253,8 +253,10 @@ void psp_assocs_key_rotated(struct psp_dev *psd)
 	/* Mark the stale associations as invalid, they will no longer
 	 * be able to Rx any traffic.
 	 */
-	list_for_each_entry_safe(pas, next, &psd->prev_assocs, assocs_list)
+	list_for_each_entry_safe(pas, next, &psd->prev_assocs, assocs_list) {
 		pas->generation |= ~PSP_GEN_VALID_MASK;
+		psd->stats.stales++;
+	}
 	list_splice_init(&psd->prev_assocs, &psd->stale_assocs);
 	list_splice_init(&psd->active_assocs, &psd->prev_assocs);
 
-- 
2.47.3


