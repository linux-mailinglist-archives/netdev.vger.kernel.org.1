Return-Path: <netdev+bounces-286392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIt8JAzdAGoZNwEAu9opvQ
	(envelope-from <netdev+bounces-286392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 21:31:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE94E505FF8
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 21:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B96223032F4E
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770E7336881;
	Sun, 10 May 2026 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5TibhNY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54777335564;
	Sun, 10 May 2026 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778441353; cv=none; b=pXdne3W1zEOrAK2delubO53TQ2fe2EDBw0DOa4tinZ/uo/Z7ZiVykDO4wYPh6SurfKNVBmO8khBYXlwgUWzx2YU3YvACrAuEq/Qgi9k6LKEoTIsLVvCzPORebVRGsNc2WmFPoyFZTSMaOzjt1mLTwN+4kD+uYF+nk8ksuK9RyYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778441353; c=relaxed/simple;
	bh=6k4eCHJTBWFeleNsJMDu0yalSZFn75Hjwqd6QNayE6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKNPOQIIPKsWNJNgR7/vVLNfGI8Hk8UAUAmSQo4EZP0UlVsjd9YAx9il9kryBa1VxXWPtDhPowCppX8PytG9ltVJ4ztvvYFEJ2VAjllqiO6CdIr3XPaao/RPuDmp7zCuZk5czAQ7EQEAWuTj06kh2GTIrbd08HcLmAl6DHjjpzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5TibhNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB5CC2BCF7;
	Sun, 10 May 2026 19:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778441353;
	bh=6k4eCHJTBWFeleNsJMDu0yalSZFn75Hjwqd6QNayE6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s5TibhNYGcBTrrCLetgaTJZ96eJEnCkEfZxM+a+YJDQg3h9R0wnNUmZfixNHzZKSa
	 A49EwqOfwgmvquX9P7GG+kpMxIqIz/bto3WWVB6+ZxdklVrE12BLYDfqStT2W2Ejnb
	 clTtjzPavHgIvDci7f4ttqpvJWV13kHSWhgbvoeQSLe0osOgSYWrz+TQT0ttgRgzn7
	 Dw9kRtOXHB9ZDGp5H16t3kuEeb/GnAQ74rNvB2b+SSMVFOghRFexXrBG0uYOd28AdU
	 wChevVlziquyxB7ytCLWYsRHmgf6bPhL/zWB8Mcyc5xjn2YMKkYGrg7eI63gGLWACk
	 lbLjKQm3ZxBYQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 08/10] net: shaper: reject handle IDs exceeding internal bit-width
Date: Sun, 10 May 2026 12:29:02 -0700
Message-ID: <20260510192904.3987113-9-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510192904.3987113-1-kuba@kernel.org>
References: <20260510192904.3987113-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EE94E505FF8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286392-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

net_shaper_parse_handle() reads the user-supplied handle ID via
nla_get_u32(), accepting the full u32 range. However, the xarray key
is built by net_shaper_handle_to_index() using
FIELD_PREP(NET_SHAPER_ID_MASK, handle->id), where NET_SHAPER_ID_MASK
is GENMASK(25, 0) - only 26 bits wide. FIELD_PREP silently masks off
the upper bits at runtime. A user-supplied NODE id like 0x04000123
becomes id 0x123.

Additionally, a user-supplied id equal to NET_SHAPER_ID_UNSPEC
(0x03FFFFFF, which is NET_SHAPER_ID_MASK itself) would collide with
the sentinel used internally by the group operation to signal
"allocate a new NODE id".

Reject user-supplied IDs >= NET_SHAPER_ID_MASK (i.e., >= 0x03FFFFFF)
in the policy.

Fixes: 4b623f9f0f59 ("net-shapers: implement NL get operation")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/net_shaper.yaml | 7 +++++++
 net/shaper/shaper_nl_gen.h                  | 2 ++
 net/shaper/shaper.c                         | 4 +++-
 net/shaper/shaper_nl_gen.c                  | 7 ++++++-
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/net_shaper.yaml b/Documentation/netlink/specs/net_shaper.yaml
index 3f2ad772b64b..de01f922040a 100644
--- a/Documentation/netlink/specs/net_shaper.yaml
+++ b/Documentation/netlink/specs/net_shaper.yaml
@@ -33,6 +33,11 @@ doc: |
   @cap-get operation.
 
 definitions:
+  -
+    type: const
+    name: max-handle-id
+    value: 0x3fffffe
+    scope: kernel
   -
     type: enum
     name: scope
@@ -140,6 +145,8 @@ doc: |
       -
         name: id
         type: u32
+        checks:
+          max: max-handle-id
         doc: |
           Numeric identifier of a shaper. The id semantic depends on
           the scope. For @queue scope it's the queue id and for @node
diff --git a/net/shaper/shaper_nl_gen.h b/net/shaper/shaper_nl_gen.h
index 42c46c52c775..2406652a9014 100644
--- a/net/shaper/shaper_nl_gen.h
+++ b/net/shaper/shaper_nl_gen.h
@@ -12,6 +12,8 @@
 
 #include <uapi/linux/net_shaper.h>
 
+#define NET_SHAPER_MAX_HANDLE_ID	67108862
+
 /* Common nested types */
 extern const struct nla_policy net_shaper_handle_nl_policy[NET_SHAPER_A_HANDLE_ID + 1];
 extern const struct nla_policy net_shaper_leaf_info_nl_policy[NET_SHAPER_A_WEIGHT + 1];
diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 08fde2d9e8aa..eb049847fed6 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -21,6 +21,8 @@
 
 #define NET_SHAPER_ID_UNSPEC NET_SHAPER_ID_MASK
 
+static_assert(NET_SHAPER_ID_UNSPEC == NET_SHAPER_MAX_HANDLE_ID + 1);
+
 struct net_shaper_hierarchy {
 	struct xarray shapers;
 };
@@ -360,7 +362,7 @@ static int net_shaper_pre_insert(struct net_shaper_binding *binding,
 	    handle->id == NET_SHAPER_ID_UNSPEC) {
 		u32 min, max;
 
-		handle->id = NET_SHAPER_ID_MASK - 1;
+		handle->id = NET_SHAPER_MAX_HANDLE_ID;
 		max = net_shaper_handle_to_index(handle);
 		handle->id = 0;
 		min = net_shaper_handle_to_index(handle);
diff --git a/net/shaper/shaper_nl_gen.c b/net/shaper/shaper_nl_gen.c
index 9b29be3ef19a..76eff85ec66d 100644
--- a/net/shaper/shaper_nl_gen.c
+++ b/net/shaper/shaper_nl_gen.c
@@ -11,10 +11,15 @@
 
 #include <uapi/linux/net_shaper.h>
 
+/* Integer value ranges */
+static const struct netlink_range_validation net_shaper_a_handle_id_range = {
+	.max	= NET_SHAPER_MAX_HANDLE_ID,
+};
+
 /* Common nested types */
 const struct nla_policy net_shaper_handle_nl_policy[NET_SHAPER_A_HANDLE_ID + 1] = {
 	[NET_SHAPER_A_HANDLE_SCOPE] = NLA_POLICY_MAX(NLA_U32, 3),
-	[NET_SHAPER_A_HANDLE_ID] = { .type = NLA_U32, },
+	[NET_SHAPER_A_HANDLE_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &net_shaper_a_handle_id_range),
 };
 
 const struct nla_policy net_shaper_leaf_info_nl_policy[NET_SHAPER_A_WEIGHT + 1] = {
-- 
2.54.0


