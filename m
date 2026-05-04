Return-Path: <netdev+bounces-284079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFDPGZsl+Wmz5wIAu9opvQ
	(envelope-from <netdev+bounces-284079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:02:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EFF4C4B63
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53C42303816A
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A189D38F928;
	Mon,  4 May 2026 23:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRtCWPJV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C89390200
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777935676; cv=none; b=hAqky/xbjS7QEX7pJ3WXi4ZG1r6ck9vH3OTzRYtNIZf1DAXb79n5B0aoJIo58/PL8dEJ+4JE4bDXdHoAI/TGkJLhkTK+7JqDyl3pP7wXvZwMFsrVJvQSxNQ+z42ce1wPLqyM1l7C3OkxYN43XxBAGYtrmwB4yM/d0AhAJxAickQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777935676; c=relaxed/simple;
	bh=gneGMkR0ASvQZ37c9GwK/zzVqoMp3hFE7djEdoXWiVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0YWp4S4inRqemOVmD7tAAE96kanZT8IkhRIZABtjO5IcZF/Nrsfdqmza4e0YgV9PCZjmIUTxvTmvOLH4yhH5wPAwaIebxtkUQbBFREdM8B9ayTNByezfJlPysiT6oSBmm4ACg4N/Rat5F5xq/FXyzhRXiSAjLRkeVq/+Wy+580=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRtCWPJV; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7b178633e35so4598257b3.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777935673; x=1778540473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbbwm3heYPFjXUTwZFhK0FRHSpOQq81mr66T6HkSCs0=;
        b=cRtCWPJVy7T4KmBADlj5EfINee3PfUjvFKfxim36NsQVXSMNFYhgAU/Xfq5f/d2kBl
         I80YDAm5R9EBrA1CgkvqHCvula5VcCSGsaIAbyqJNgko6DuRyYDno6W8Of4mURnEIbfu
         BsoWcoDTe5734NELsLWJQ+pm9KEKy/8LFJuQoGeDl+2GeuaGKeZzhjDK5FTEbKMwAIz1
         I8onX2qLvcAuHmRwSXndqUABCYPh932GytzIrVFNLLOdTxn73cdaC+n5bq4cESCF5EWq
         eI6Le/1NVXHFZEyk8ITcUD/Qa2jpgm5llsHho1oQNOBSONONOZp5+ebEYcwUFqDL0sWT
         QKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777935673; x=1778540473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cbbwm3heYPFjXUTwZFhK0FRHSpOQq81mr66T6HkSCs0=;
        b=VQ95hQ/ACv5Maj9WaVyArvftjaes4HNorLc83UcCaDNEUkfoiro93k0GHhPz+eTlIN
         NLHjWguHKaZQGrIxp4PLd1FllEtT7nUQOeOcpIN5dXDUpGqbHDMkEEKBEbXC1KS7KGnA
         oAyueJ6Jv0cjsLULdnyiQ8rI/Td1lX39MpI5Ymt0KqsfQXGmNWeJqClVlRzdBFR71h1x
         xykhST3q9kvqsUrDdR2P7rGyYOPNFf/2BpHsGFrgtDu/hPGFfTu9NfNLEsi56aQOGrZZ
         9k+iG5DaxzlCS/0AIXebvPQ/sGJSqhlbukwOwWfOyX7c5FR5pmjPukWXKCuY3JWPtzKc
         rlIw==
X-Gm-Message-State: AOJu0YwT7CxKVpNhS1eDK42gHSNyqrjr4vnDYRlgudbspYnQ8aEdYKdm
	3ghIk4TqyqZNB6zw6skFAqSObDXXFNFe8LSI8scSnakFFof+0Nj/oUsdwKAcfg==
X-Gm-Gg: AeBDieuIm4CFeayqcfNRjUsXgT82yOifC7+jYd2R3I/6OB/dXY0td6Psbf/EVFCJt9n
	4i03h+njkOWq17mNaeoZ1Aihiwp/0Z+bVWWicUg9tbYgQwPhtLELE08KGM9fFfawOG3TvUSP7nb
	+KuEYCzJPmYE5n2+mOoBwSAWrbCPk2NcrgYgT78vN0jkSpbq44C4LlbmWg8HHDBhpl3bRsBWijP
	AkSrxTrrhkf/n+dbC/5d2a0zbrjDuDJSBPHrn6+wYaJOjvD/2wdNV2wqXOBXBQY/u8YcGMGt9cp
	8cZT4QFVzVAfd9Itf8H1CDwRk/zcxb6Cap6Qx2GQ0B/tVDZyFiBkOOkYDGcSwzWsCHdb2fWNSFS
	nKiWPCXIa/Rssw8MLCNpsG2V6bEVqEAw2c+jQFFbaPRKWpJtbuqloULTghlwmLy7EHRAohYzFWJ
	YJOGD+1F8sl8D+O6xdnt/XzPOYJ/eo0t1ZxQ==
X-Received: by 2002:a05:690c:c4f6:b0:7b6:db48:2f1d with SMTP id 00721157ae682-7bd76d8b008mr77886837b3.0.1777935672493;
        Mon, 04 May 2026 16:01:12 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:8::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66019105sm56579657b3.0.2026.05.04.16.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:01:12 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Wei Wang <weibunny@fb.com>
Subject: [PATCH v13 net-next 2/5] psp: add new netlink cmd for dev-assoc and dev-disassoc
Date: Mon,  4 May 2026 16:00:52 -0700
Message-ID: <20260504230056.917415-3-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260504230056.917415-1-weibunny.kernel@gmail.com>
References: <20260504230056.917415-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D9EFF4C4B63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284079-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,redhat.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fb.com:email]

From: Wei Wang <weibunny@fb.com>

The main purpose of this cmd is to be able to associate a
non-psp-capable device (e.g. veth or netkit) with a psp device.
One use case is if we create a pair of veth/netkit, and assign 1 end
inside a netns, while leaving the other end within the default netns,
with a real PSP device, e.g. netdevsim or a physical PSP-capable NIC.
With this command, we could associate the veth/netkit inside the netns
with PSP device, so the virtual device could act as PSP-capable device
to initiate PSP connections, and performs PSP encryption/decryption on
the real PSP device.

Signed-off-by: Wei Wang <weibunny@fb.com>
Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 Documentation/netlink/specs/psp.yaml |  67 +++++-
 include/net/psp/types.h              |  23 ++
 include/uapi/linux/psp.h             |  13 ++
 net/psp/psp-nl-gen.c                 |  32 +++
 net/psp/psp-nl-gen.h                 |   2 +
 net/psp/psp_main.c                   |  21 ++
 net/psp/psp_nl.c                     | 336 ++++++++++++++++++++++++++-
 7 files changed, 483 insertions(+), 11 deletions(-)

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
index e3b0fe296e8f..ce0a03e2d746 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -13,6 +13,17 @@ definitions:
               hdr0-aes-gmac-128, hdr0-aes-gmac-256]
 
 attribute-sets:
+  -
+    name: assoc-dev-info
+    attributes:
+      -
+        name: ifindex
+        doc: ifindex of an associated network device.
+        type: u32
+      -
+        name: nsid
+        doc: Network namespace ID of the associated device.
+        type: s32
   -
     name: dev
     attributes:
@@ -24,7 +35,9 @@ attribute-sets:
           min: 1
       -
         name: ifindex
-        doc: ifindex of the main netdevice linked to the PSP device.
+        doc: |
+          ifindex of the main netdevice linked to the PSP device,
+          or the ifindex to associate with the PSP device.
         type: u32
       -
         name: psp-versions-cap
@@ -38,6 +51,28 @@ attribute-sets:
         type: u32
         enum: version
         enum-as-flags: true
+      -
+        name: assoc-list
+        doc: List of associated virtual devices.
+        type: nest
+        nested-attributes: assoc-dev-info
+        multi-attr: true
+      -
+        name: nsid
+        doc: |
+          Network namespace ID for the device to associate/disassociate.
+          Optional for dev-assoc and dev-disassoc; if not present, the
+          device is looked up in the caller's network namespace.
+        type: s32
+      -
+        name: by-association
+        doc: |
+          Flag indicating the PSP device is an associated device from a
+          different network namespace.
+          Present when in associated namespace, absent when in primary/host
+          namespace.
+        type: flag
+
   -
     name: assoc
     attributes:
@@ -170,6 +205,8 @@ operations:
             - ifindex
             - psp-versions-cap
             - psp-versions-ena
+            - assoc-list
+            - by-association
         pre: psp-device-get-locked
         post: psp-device-unlock
       dump:
@@ -281,6 +318,34 @@ operations:
         post: psp-device-unlock
       dump:
         reply: *stats-all
+    -
+      name: dev-assoc
+      doc: Associate a network device with a PSP device.
+      attribute-set: dev
+      do:
+        request:
+          attributes:
+            - id
+            - ifindex
+            - nsid
+        reply:
+          attributes: []
+        pre: psp-device-get-locked
+        post: psp-device-unlock
+    -
+      name: dev-disassoc
+      doc: Disassociate a network device from a PSP device.
+      attribute-set: dev
+      do:
+        request:
+          attributes:
+            - id
+            - ifindex
+            - nsid
+        reply:
+          attributes: []
+        pre: psp-device-get-locked
+        post: psp-device-unlock
 
 mcast-groups:
   list:
diff --git a/include/net/psp/types.h b/include/net/psp/types.h
index 25a9096d4e7d..87991a1ea02d 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -5,6 +5,7 @@
 
 #include <linux/mutex.h>
 #include <linux/refcount.h>
+#include <net/net_trackers.h>
 
 struct netlink_ext_ack;
 
@@ -43,9 +44,29 @@ struct psp_dev_config {
 	u32 versions;
 };
 
+/* Max number of devices that can be associated with a single PSP device.
+ * Each entry consumes ~24 bytes in the netlink dev-get response, and the
+ * response must fit in GENLMSG_DEFAULT_SIZE (~3.7KB).
+ */
+#define PSP_ASSOC_DEV_MAX	128
+
+/**
+ * struct psp_assoc_dev - wrapper for associated net_device
+ * @dev_list: list node for psp_dev::assoc_dev_list
+ * @assoc_dev: the associated net_device
+ * @dev_tracker: tracker for the net_device reference
+ */
+struct psp_assoc_dev {
+	struct list_head dev_list;
+	struct net_device *assoc_dev;
+	netdevice_tracker dev_tracker;
+};
+
 /**
  * struct psp_dev - PSP device struct
  * @main_netdev: original netdevice of this PSP device
+ * @assoc_dev_list: list of psp_assoc_dev entries associated with this PSP device
+ * @assoc_dev_cnt: number of entries in @assoc_dev_list
  * @ops:	driver callbacks
  * @caps:	device capabilities
  * @drv_priv:	driver priv pointer
@@ -67,6 +88,8 @@ struct psp_dev_config {
  */
 struct psp_dev {
 	struct net_device *main_netdev;
+	struct list_head assoc_dev_list;
+	int assoc_dev_cnt;
 
 	struct psp_dev_ops *ops;
 	struct psp_dev_caps *caps;
diff --git a/include/uapi/linux/psp.h b/include/uapi/linux/psp.h
index a3a336488dc3..1c8899cd4da5 100644
--- a/include/uapi/linux/psp.h
+++ b/include/uapi/linux/psp.h
@@ -17,11 +17,22 @@ enum psp_version {
 	PSP_VERSION_HDR0_AES_GMAC_256,
 };
 
+enum {
+	PSP_A_ASSOC_DEV_INFO_IFINDEX = 1,
+	PSP_A_ASSOC_DEV_INFO_NSID,
+
+	__PSP_A_ASSOC_DEV_INFO_MAX,
+	PSP_A_ASSOC_DEV_INFO_MAX = (__PSP_A_ASSOC_DEV_INFO_MAX - 1)
+};
+
 enum {
 	PSP_A_DEV_ID = 1,
 	PSP_A_DEV_IFINDEX,
 	PSP_A_DEV_PSP_VERSIONS_CAP,
 	PSP_A_DEV_PSP_VERSIONS_ENA,
+	PSP_A_DEV_ASSOC_LIST,
+	PSP_A_DEV_NSID,
+	PSP_A_DEV_BY_ASSOCIATION,
 
 	__PSP_A_DEV_MAX,
 	PSP_A_DEV_MAX = (__PSP_A_DEV_MAX - 1)
@@ -74,6 +85,8 @@ enum {
 	PSP_CMD_RX_ASSOC,
 	PSP_CMD_TX_ASSOC,
 	PSP_CMD_GET_STATS,
+	PSP_CMD_DEV_ASSOC,
+	PSP_CMD_DEV_DISASSOC,
 
 	__PSP_CMD_MAX,
 	PSP_CMD_MAX = (__PSP_CMD_MAX - 1)
diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
index a71dd629aeab..18a6e8bdb6a1 100644
--- a/net/psp/psp-nl-gen.c
+++ b/net/psp/psp-nl-gen.c
@@ -53,6 +53,20 @@ static const struct nla_policy psp_get_stats_nl_policy[PSP_A_STATS_DEV_ID + 1] =
 	[PSP_A_STATS_DEV_ID] = NLA_POLICY_MIN(NLA_U32, 1),
 };
 
+/* PSP_CMD_DEV_ASSOC - do */
+static const struct nla_policy psp_dev_assoc_nl_policy[PSP_A_DEV_NSID + 1] = {
+	[PSP_A_DEV_ID] = NLA_POLICY_MIN(NLA_U32, 1),
+	[PSP_A_DEV_IFINDEX] = { .type = NLA_U32, },
+	[PSP_A_DEV_NSID] = { .type = NLA_S32, },
+};
+
+/* PSP_CMD_DEV_DISASSOC - do */
+static const struct nla_policy psp_dev_disassoc_nl_policy[PSP_A_DEV_NSID + 1] = {
+	[PSP_A_DEV_ID] = NLA_POLICY_MIN(NLA_U32, 1),
+	[PSP_A_DEV_IFINDEX] = { .type = NLA_U32, },
+	[PSP_A_DEV_NSID] = { .type = NLA_S32, },
+};
+
 /* Ops table for psp */
 static const struct genl_split_ops psp_nl_ops[] = {
 	{
@@ -119,6 +133,24 @@ static const struct genl_split_ops psp_nl_ops[] = {
 		.dumpit	= psp_nl_get_stats_dumpit,
 		.flags	= GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= PSP_CMD_DEV_ASSOC,
+		.pre_doit	= psp_device_get_locked,
+		.doit		= psp_nl_dev_assoc_doit,
+		.post_doit	= psp_device_unlock,
+		.policy		= psp_dev_assoc_nl_policy,
+		.maxattr	= PSP_A_DEV_NSID,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= PSP_CMD_DEV_DISASSOC,
+		.pre_doit	= psp_device_get_locked,
+		.doit		= psp_nl_dev_disassoc_doit,
+		.post_doit	= psp_device_unlock,
+		.policy		= psp_dev_disassoc_nl_policy,
+		.maxattr	= PSP_A_DEV_NSID,
+		.flags		= GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group psp_nl_mcgrps[] = {
diff --git a/net/psp/psp-nl-gen.h b/net/psp/psp-nl-gen.h
index 977355455395..4dd0f0f23053 100644
--- a/net/psp/psp-nl-gen.h
+++ b/net/psp/psp-nl-gen.h
@@ -33,6 +33,8 @@ int psp_nl_rx_assoc_doit(struct sk_buff *skb, struct genl_info *info);
 int psp_nl_tx_assoc_doit(struct sk_buff *skb, struct genl_info *info);
 int psp_nl_get_stats_doit(struct sk_buff *skb, struct genl_info *info);
 int psp_nl_get_stats_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *info);
+int psp_nl_dev_disassoc_doit(struct sk_buff *skb, struct genl_info *info);
 
 enum {
 	PSP_NLGRP_MGMT,
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index b56a51d524f5..792a47105a6c 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -37,8 +37,18 @@ struct mutex psp_devs_lock;
  */
 int psp_dev_check_access(struct psp_dev *psd, struct net *net, bool admin)
 {
+	struct psp_assoc_dev *entry;
+
 	if (dev_net(psd->main_netdev) == net)
 		return 0;
+
+	if (!admin) {
+		list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
+			if (dev_net(entry->assoc_dev) == net)
+				return 0;
+		}
+	}
+
 	return -ENOENT;
 }
 
@@ -74,6 +84,7 @@ psp_dev_create(struct net_device *netdev,
 		return ERR_PTR(-ENOMEM);
 
 	psd->main_netdev = netdev;
+	INIT_LIST_HEAD(&psd->assoc_dev_list);
 	psd->ops = psd_ops;
 	psd->caps = psd_caps;
 	psd->drv_priv = priv_ptr;
@@ -125,6 +136,7 @@ void psp_dev_free(struct psp_dev *psd)
  */
 void psp_dev_unregister(struct psp_dev *psd)
 {
+	struct psp_assoc_dev *entry, *entry_tmp;
 	struct psp_assoc *pas, *next;
 
 	mutex_lock(&psp_devs_lock);
@@ -144,6 +156,15 @@ void psp_dev_unregister(struct psp_dev *psd)
 	list_for_each_entry_safe(pas, next, &psd->stale_assocs, assocs_list)
 		psp_dev_tx_key_del(psd, pas);
 
+	list_for_each_entry_safe(entry, entry_tmp, &psd->assoc_dev_list,
+				 dev_list) {
+		list_del(&entry->dev_list);
+		rcu_assign_pointer(entry->assoc_dev->psp_dev, NULL);
+		netdev_put(entry->assoc_dev, &entry->dev_tracker);
+		kfree(entry);
+	}
+	psd->assoc_dev_cnt = 0;
+
 	rcu_assign_pointer(psd->main_netdev->psp_dev, NULL);
 
 	psd->ops = NULL;
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index b4f1b7f9b0c2..8dbe2fe882dd 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/ethtool.h>
+#include <linux/net_namespace.h>
 #include <linux/skbuff.h>
 #include <linux/xarray.h>
 #include <net/genetlink.h>
@@ -38,6 +39,73 @@ static int psp_nl_reply_send(struct sk_buff *rsp, struct genl_info *info)
 	return genlmsg_reply(rsp, info);
 }
 
+/**
+ * psp_nl_multicast_per_ns() - multicast a notification to each unique netns
+ * @psd: PSP device (must be locked)
+ * @group: multicast group
+ * @build_ntf: callback to build an skb for a given netns, or NULL on failure
+ * @ctx: opaque context passed to @build_ntf
+ *
+ * Iterates all unique network namespaces from the associated device list
+ * plus the main device's netns. For each unique netns, calls @build_ntf
+ * to construct a notification skb and multicasts it.
+ */
+static void psp_nl_multicast_per_ns(struct psp_dev *psd, unsigned int group,
+				    struct sk_buff *(*build_ntf)(struct psp_dev *,
+								 struct net *,
+								 void *),
+				    void *ctx)
+{
+	struct psp_assoc_dev *entry;
+	struct xarray sent_nets;
+	struct net *main_net;
+	struct sk_buff *ntf;
+
+	main_net = dev_net(psd->main_netdev);
+	xa_init(&sent_nets);
+
+	list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
+		struct net *assoc_net = dev_net(entry->assoc_dev);
+		int ret;
+
+		if (net_eq(assoc_net, main_net))
+			continue;
+
+		ret = xa_insert(&sent_nets, (unsigned long)assoc_net, assoc_net,
+				GFP_KERNEL);
+		if (ret == -EBUSY)
+			continue;
+
+		ntf = build_ntf(psd, assoc_net, ctx);
+		if (!ntf)
+			continue;
+
+		genlmsg_multicast_netns(&psp_nl_family, assoc_net, ntf, 0,
+					group, GFP_KERNEL);
+	}
+	xa_destroy(&sent_nets);
+
+	/* Send to main device netns */
+	ntf = build_ntf(psd, main_net, ctx);
+	if (!ntf)
+		return;
+	genlmsg_multicast_netns(&psp_nl_family, main_net, ntf, 0, group,
+				GFP_KERNEL);
+}
+
+static struct sk_buff *psp_nl_clone_ntf(struct psp_dev *psd, struct net *net,
+					void *ctx)
+{
+	return skb_clone(ctx, GFP_KERNEL);
+}
+
+static void psp_nl_multicast_all_ns(struct psp_dev *psd, struct sk_buff *ntf,
+				    unsigned int group)
+{
+	psp_nl_multicast_per_ns(psd, group, psp_nl_clone_ntf, ntf);
+	nlmsg_free(ntf);
+}
+
 /* Device stuff */
 
 static struct psp_dev *
@@ -79,18 +147,58 @@ static int __psp_device_get_locked(const struct genl_split_ops *ops,
 	return PTR_ERR_OR_ZERO(info->user_ptr[0]);
 }
 
+/*
+ * Admin version of psp_device_get_locked() where it returns psd only if
+ * current netns is the same as psd->main_netdev's netns.
+ */
 int psp_device_get_locked_admin(const struct genl_split_ops *ops,
 				struct sk_buff *skb, struct genl_info *info)
 {
 	return __psp_device_get_locked(ops, skb, info, true);
 }
 
+/*
+ * Non-admin version of psp_device_get_locked() where it returns psd in netns
+ * for not only psd->main_netdev but all netdevs in psd->assoc_dev_list.
+ */
 int psp_device_get_locked(const struct genl_split_ops *ops,
 			  struct sk_buff *skb, struct genl_info *info)
 {
 	return __psp_device_get_locked(ops, skb, info, false);
 }
 
+static struct net *psp_nl_resolve_assoc_dev_ns(struct psp_dev *psd,
+					       struct genl_info *info)
+{
+	struct net *net;
+	int nsid;
+
+	if (GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_IFINDEX))
+		return ERR_PTR(-EINVAL);
+
+	if (info->attrs[PSP_A_DEV_NSID]) {
+		/* Only callers in the main netns may specify nsid */
+		if (dev_net(psd->main_netdev) != genl_info_net(info)) {
+			NL_SET_BAD_ATTR(info->extack,
+					info->attrs[PSP_A_DEV_NSID]);
+			return ERR_PTR(-EPERM);
+		}
+
+		nsid = nla_get_s32(info->attrs[PSP_A_DEV_NSID]);
+
+		net = get_net_ns_by_id(genl_info_net(info), nsid);
+		if (!net) {
+			NL_SET_BAD_ATTR(info->extack,
+					info->attrs[PSP_A_DEV_NSID]);
+			return ERR_PTR(-EINVAL);
+		}
+	} else {
+		net = get_net(genl_info_net(info));
+	}
+
+	return net;
+}
+
 void
 psp_device_unlock(const struct genl_split_ops *ops, struct sk_buff *skb,
 		  struct genl_info *info)
@@ -103,11 +211,74 @@ psp_device_unlock(const struct genl_split_ops *ops, struct sk_buff *skb,
 		sockfd_put(socket);
 }
 
+static bool psp_has_assoc_dev_in_ns(struct psp_dev *psd, struct net *net)
+{
+	struct psp_assoc_dev *entry;
+
+	list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
+		if (dev_net(entry->assoc_dev) == net)
+			return true;
+	}
+
+	return false;
+}
+
+static int psp_nl_fill_assoc_dev_list(struct psp_dev *psd, struct sk_buff *rsp,
+				      struct net *cur_net,
+				      struct net *filter_net)
+{
+	struct psp_assoc_dev *entry;
+	struct net *dev_net_ns;
+	struct nlattr *nest;
+	int nsid;
+
+	list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
+		dev_net_ns = dev_net(entry->assoc_dev);
+
+		if (filter_net && dev_net_ns != filter_net)
+			continue;
+
+		/* When filtering by namespace, all devices are in the caller's
+		 * namespace so nsid is always NETNSA_NSID_NOT_ASSIGNED (-1).
+		 * Otherwise, calculate the nsid relative to cur_net.
+		 */
+		nsid = filter_net ? NETNSA_NSID_NOT_ASSIGNED :
+				    peernet2id_alloc(cur_net, dev_net_ns,
+						     GFP_KERNEL);
+
+		nest = nla_nest_start(rsp, PSP_A_DEV_ASSOC_LIST);
+		if (!nest)
+			return -1;
+
+		if (nla_put_u32(rsp, PSP_A_ASSOC_DEV_INFO_IFINDEX,
+				entry->assoc_dev->ifindex) ||
+		    nla_put_s32(rsp, PSP_A_ASSOC_DEV_INFO_NSID, nsid)) {
+			nla_nest_cancel(rsp, nest);
+			return -1;
+		}
+
+		nla_nest_end(rsp, nest);
+	}
+
+	return 0;
+}
+
 static int
 psp_nl_dev_fill(struct psp_dev *psd, struct sk_buff *rsp,
 		const struct genl_info *info)
 {
+	struct net *cur_net;
 	void *hdr;
+	int err;
+
+	cur_net = genl_info_net(info);
+
+	/* Skip this device if we're in an associated netns but have no
+	 * associated devices in cur_net
+	 */
+	if (cur_net != dev_net(psd->main_netdev) &&
+	    !psp_has_assoc_dev_in_ns(psd, cur_net))
+		return 0;
 
 	hdr = genlmsg_iput(rsp, info);
 	if (!hdr)
@@ -119,6 +290,22 @@ psp_nl_dev_fill(struct psp_dev *psd, struct sk_buff *rsp,
 	    nla_put_u32(rsp, PSP_A_DEV_PSP_VERSIONS_ENA, psd->config.versions))
 		goto err_cancel_msg;
 
+	if (cur_net == dev_net(psd->main_netdev)) {
+		/* Primary device - dump assoc list */
+		err = psp_nl_fill_assoc_dev_list(psd, rsp, cur_net, NULL);
+		if (err)
+			goto err_cancel_msg;
+	} else {
+		/* In netns: set by-association flag and dump filtered
+		 * assoc list containing only devices in cur_net
+		 */
+		if (nla_put_flag(rsp, PSP_A_DEV_BY_ASSOCIATION))
+			goto err_cancel_msg;
+		err = psp_nl_fill_assoc_dev_list(psd, rsp, cur_net, cur_net);
+		if (err)
+			goto err_cancel_msg;
+	}
+
 	genlmsg_end(rsp, hdr);
 	return 0;
 
@@ -127,27 +314,34 @@ psp_nl_dev_fill(struct psp_dev *psd, struct sk_buff *rsp,
 	return -EMSGSIZE;
 }
 
-void psp_nl_notify_dev(struct psp_dev *psd, u32 cmd)
+static struct sk_buff *psp_nl_build_dev_ntf(struct psp_dev *psd,
+					    struct net *net, void *ctx)
 {
+	u32 cmd = *(u32 *)ctx;
 	struct genl_info info;
 	struct sk_buff *ntf;
 
-	if (!genl_has_listeners(&psp_nl_family, dev_net(psd->main_netdev),
-				PSP_NLGRP_MGMT))
-		return;
+	if (!genl_has_listeners(&psp_nl_family, net, PSP_NLGRP_MGMT))
+		return NULL;
 
 	ntf = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!ntf)
-		return;
+		return NULL;
 
 	genl_info_init_ntf(&info, &psp_nl_family, cmd);
+	genl_info_net_set(&info, net);
 	if (psp_nl_dev_fill(psd, ntf, &info)) {
 		nlmsg_free(ntf);
-		return;
+		return NULL;
 	}
 
-	genlmsg_multicast_netns(&psp_nl_family, dev_net(psd->main_netdev), ntf,
-				0, PSP_NLGRP_MGMT, GFP_KERNEL);
+	return ntf;
+}
+
+void psp_nl_notify_dev(struct psp_dev *psd, u32 cmd)
+{
+	psp_nl_multicast_per_ns(psd, PSP_NLGRP_MGMT,
+				psp_nl_build_dev_ntf, &cmd);
 }
 
 int psp_nl_dev_get_doit(struct sk_buff *req, struct genl_info *info)
@@ -281,8 +475,9 @@ int psp_nl_key_rotate_doit(struct sk_buff *skb, struct genl_info *info)
 	psd->stats.rotations++;
 
 	nlmsg_end(ntf, (struct nlmsghdr *)ntf->data);
-	genlmsg_multicast_netns(&psp_nl_family, dev_net(psd->main_netdev), ntf,
-				0, PSP_NLGRP_USE, GFP_KERNEL);
+
+	psp_nl_multicast_all_ns(psd, ntf, PSP_NLGRP_USE);
+
 	return psp_nl_reply_send(rsp, info);
 
 err_free_ntf:
@@ -292,6 +487,127 @@ int psp_nl_key_rotate_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct psp_dev *psd = info->user_ptr[0];
+	struct psp_assoc_dev *psp_assoc_dev;
+	struct net_device *assoc_dev;
+	struct sk_buff *rsp;
+	u32 assoc_ifindex;
+	struct net *net;
+	int err;
+
+	if (psd->assoc_dev_cnt >= PSP_ASSOC_DEV_MAX) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Maximum number of associated devices reached");
+		return -ENOSPC;
+	}
+
+	net = psp_nl_resolve_assoc_dev_ns(psd, info);
+	if (IS_ERR(net))
+		return PTR_ERR(net);
+
+	psp_assoc_dev = kzalloc_obj(*psp_assoc_dev, GFP_KERNEL);
+	if (!psp_assoc_dev) {
+		err = -ENOMEM;
+		goto err_put_net;
+	}
+
+	assoc_ifindex = nla_get_u32(info->attrs[PSP_A_DEV_IFINDEX]);
+	assoc_dev = netdev_get_by_index(net, assoc_ifindex,
+					&psp_assoc_dev->dev_tracker,
+					GFP_KERNEL);
+	if (!assoc_dev) {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_DEV_IFINDEX]);
+		err = -ENODEV;
+		goto assoc_dev_err;
+	}
+
+	/* Check if device is already associated with a PSP device */
+	if (cmpxchg(&assoc_dev->psp_dev, NULL, RCU_INITIALIZER(psd))) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Device already associated with a PSP device");
+		err = -EBUSY;
+		goto cmpxchg_err;
+	}
+
+	psp_assoc_dev->assoc_dev = assoc_dev;
+	rsp = psp_nl_reply_new(info);
+	if (!rsp) {
+		err = -ENOMEM;
+		goto rsp_err;
+	}
+
+	list_add_tail(&psp_assoc_dev->dev_list, &psd->assoc_dev_list);
+	psd->assoc_dev_cnt++;
+
+	put_net(net);
+
+	psp_nl_notify_dev(psd, PSP_CMD_DEV_CHANGE_NTF);
+
+	return psp_nl_reply_send(rsp, info);
+
+rsp_err:
+	rcu_assign_pointer(assoc_dev->psp_dev, NULL);
+cmpxchg_err:
+	netdev_put(assoc_dev, &psp_assoc_dev->dev_tracker);
+assoc_dev_err:
+	kfree(psp_assoc_dev);
+err_put_net:
+	put_net(net);
+
+	return err;
+}
+
+int psp_nl_dev_disassoc_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct psp_assoc_dev *entry, *found = NULL;
+	struct psp_dev *psd = info->user_ptr[0];
+	struct sk_buff *rsp;
+	u32 assoc_ifindex;
+	struct net *net;
+
+	net = psp_nl_resolve_assoc_dev_ns(psd, info);
+	if (IS_ERR(net))
+		return PTR_ERR(net);
+
+	assoc_ifindex = nla_get_u32(info->attrs[PSP_A_DEV_IFINDEX]);
+
+	/* Search the association list by ifindex and netns */
+	list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
+		if (entry->assoc_dev->ifindex == assoc_ifindex &&
+		    dev_net(entry->assoc_dev) == net) {
+			found = entry;
+			break;
+		}
+	}
+
+	if (!found) {
+		put_net(net);
+		NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_DEV_IFINDEX]);
+		return -ENODEV;
+	}
+
+	rsp = psp_nl_reply_new(info);
+	if (!rsp) {
+		put_net(net);
+		return -ENOMEM;
+	}
+
+	/* Remove from the association list */
+	list_del(&found->dev_list);
+	psd->assoc_dev_cnt--;
+	rcu_assign_pointer(found->assoc_dev->psp_dev, NULL);
+	netdev_put(found->assoc_dev, &found->dev_tracker);
+	kfree(found);
+
+	put_net(net);
+
+	psp_nl_notify_dev(psd, PSP_CMD_DEV_CHANGE_NTF);
+
+	return psp_nl_reply_send(rsp, info);
+}
+
 /* Key etc. */
 
 int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
-- 
2.52.0


