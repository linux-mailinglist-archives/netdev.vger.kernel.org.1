Return-Path: <netdev+bounces-114318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D989421C3
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 22:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4600F285B0E
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 20:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F97618DF62;
	Tue, 30 Jul 2024 20:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYuTzw/+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5253518DF79
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722372109; cv=none; b=I8wjCF3MEFi2QCv2TmV4DTNG7OqOjZXUM1TwCjU3xii2zTQ6tz0iHNNOPQK7DvY3nyKzMWo/K7RNk5bivQhy+HMeHAsyvwa8mc7SbwGc7Q0c1LS/MIyRS1M9UqxztjibeHfZFC1vv01hYh0rCDa3W2EMTrdrxNyNV+wWM5+lKG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722372109; c=relaxed/simple;
	bh=hBj8hPbxDCs/SvEU1/cvJBP8okcqiAF1C45QOF3veO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyqdf+FM8t8T/UvntAcU0KNQ8w9lZUH6g//D1i694BwE3299i6Z9nKNzrmc6Y7WM3wANOuaYiJcF/P/k2BuVhAQTzikLC4zvYawcg/3OBo/XfS2J4PhSG2ZH1Sn5UvHlSWBoCGBl4VeNN1OmAKbSAzNZOFWqU3ZZv+zbYLljOCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYuTzw/+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722372106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqFpph3mAoPqXuKTwLZ1kq8OvYm/2Qjo1pGtTZBbEVA=;
	b=JYuTzw/+vwReEEKwQ94VsqPlbBFp1ZhDk1SkqTRMKCwyOCSxvlaNMHiuRIcYbughFTEe8P
	B2k7Lhrk4x+TJGizLygfmBh7I+CFeGQCI11Rv+hUogdhoXPl9Nbbf6H5+wpEX+8puJHIOn
	OCD5oFXQ/ZqNbpS8e+FVjmQUIiyJXyU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-kGFPaYi7O5-4rARO3yn8kg-1; Tue,
 30 Jul 2024 16:41:40 -0400
X-MC-Unique: kGFPaYi7O5-4rARO3yn8kg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B17DA1955D4C;
	Tue, 30 Jul 2024 20:41:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E96273000192;
	Tue, 30 Jul 2024 20:41:34 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH v3 06/12] netlink: spec: add shaper introspection support
Date: Tue, 30 Jul 2024 22:39:49 +0200
Message-ID: <8f7b753a8eb346d3f9ed2990f60f12d3bb5a6f4a.1722357745.git.pabeni@redhat.com>
In-Reply-To: <cover.1722357745.git.pabeni@redhat.com>
References: <cover.1722357745.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Allow the user-space to fine-grain query the shaping features
supported by the NIC on each domain.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 Documentation/netlink/specs/shaper.yaml | 75 +++++++++++++++++++++++++
 include/uapi/linux/net_shaper.h         | 17 ++++++
 net/shaper/shaper.c                     | 11 ++++
 net/shaper/shaper_nl_gen.c              | 25 +++++++++
 net/shaper/shaper_nl_gen.h              |  3 +
 5 files changed, 131 insertions(+)

diff --git a/Documentation/netlink/specs/shaper.yaml b/Documentation/netlink/specs/shaper.yaml
index 7327f5596fdb..55bf4e49fb2f 100644
--- a/Documentation/netlink/specs/shaper.yaml
+++ b/Documentation/netlink/specs/shaper.yaml
@@ -169,6 +169,52 @@ attribute-sets:
         name: priority
       -
         name: weight
+  -
+    name: capabilities
+    attributes:
+      -
+        name: ifindex
+        type: u32
+      -
+        name: scope
+        type: u32
+        enum: scope
+        doc: The scope to which the queried capabilities apply
+      -
+        name: support-metric-bps
+        type: flag
+        doc: the device accepts 'bps' metric for bw-min, bw-max and burst
+      -
+        name: support-metric-pps
+        type: flag
+        doc: the device accepts 'pps' metric for bw-min, bw-max and burst
+      -
+        name: support-nesting
+        type: flag
+        doc: |
+          the device supports nesting shaper belonging to this scope
+          below 'detached' scoped shapers. Only 'queue' and 'detached'
+          scope and flag 'support-nesting'.
+      -
+        name: support-bw-min
+        type: flag
+        doc: the device supports a minimum guaranteed bw
+      -
+        name: support-bw-max
+        type: flag
+        doc: the device supports maximum bw shaping
+      -
+        name: support-burst
+        type: flag
+        doc: the device supports a maximum burst size
+      -
+        name: support-priority
+        type: flag
+        doc: the device supports priority scheduling
+      -
+        name: support-weight
+        type: flag
+        doc: the device supports weighted round robin scheduling
 
 operations:
   list:
@@ -260,3 +306,32 @@ operations:
         reply:
           attributes:
             - handle
+
+    -
+      name: cap-get
+      doc: |
+        Get / Dump the shaper capabilities supported by the given device
+      attribute-set: capabilities
+
+      do:
+        request:
+          attributes:
+            - ifindex
+            - scope
+        reply:
+          attributes: &cap-attrs
+            - support-metric-bps
+            - support-metric-pps
+            - support-nesting
+            - support-bw-min
+            - support-bw-max
+            - support-burst
+            - support-priority
+            - support-weight
+
+      dump:
+        request:
+          attributes:
+            - ifindex
+        reply:
+          attributes: *cap-attrs
diff --git a/include/uapi/linux/net_shaper.h b/include/uapi/linux/net_shaper.h
index ab3d4eb0e1ab..12d16d30472e 100644
--- a/include/uapi/linux/net_shaper.h
+++ b/include/uapi/linux/net_shaper.h
@@ -61,11 +61,28 @@ enum {
 	NET_SHAPER_A_MAX = (__NET_SHAPER_A_MAX - 1)
 };
 
+enum {
+	NET_SHAPER_A_CAPABILITIES_IFINDEX = 1,
+	NET_SHAPER_A_CAPABILITIES_SCOPE,
+	NET_SHAPER_A_CAPABILITIES_SUPPORT_METRIC_BPS,
+	NET_SHAPER_A_CAPABILITIES_SUPPORT_METRIC_PPS,
+	NET_SHAPER_A_CAPABILITIES_SUPPORT_NESTING,
+	NET_SHAPER_A_CAPABILITIES_SUPPORT_BW_MIN,
+	NET_SHAPER_A_CAPABILITIES_SUPPORT_BW_MAX,
+	NET_SHAPER_A_CAPABILITIES_SUPPORT_BURST,
+	NET_SHAPER_A_CAPABILITIES_SUPPORT_PRIORITY,
+	NET_SHAPER_A_CAPABILITIES_SUPPORT_WEIGHT,
+
+	__NET_SHAPER_A_CAPABILITIES_MAX,
+	NET_SHAPER_A_CAPABILITIES_MAX = (__NET_SHAPER_A_CAPABILITIES_MAX - 1)
+};
+
 enum {
 	NET_SHAPER_CMD_GET = 1,
 	NET_SHAPER_CMD_SET,
 	NET_SHAPER_CMD_DELETE,
 	NET_SHAPER_CMD_GROUP,
+	NET_SHAPER_CMD_CAP_GET,
 
 	__NET_SHAPER_CMD_MAX,
 	NET_SHAPER_CMD_MAX = (__NET_SHAPER_CMD_MAX - 1)
diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 87db541de646..5363e10606e2 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -837,6 +837,17 @@ int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+int net_shaper_nl_cap_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return 0;
+}
+
+int net_shaper_nl_cap_get_dumpit(struct sk_buff *skb,
+				 struct netlink_callback *cb)
+{
+	return 0;
+}
+
 void dev_shaper_flush(struct net_device *dev)
 {
 	struct xarray *xa = __sc_container(dev);
diff --git a/net/shaper/shaper_nl_gen.c b/net/shaper/shaper_nl_gen.c
index b444d1ff55a1..cc98d58c0862 100644
--- a/net/shaper/shaper_nl_gen.c
+++ b/net/shaper/shaper_nl_gen.c
@@ -67,6 +67,17 @@ static const struct nla_policy net_shaper_group_nl_policy[NET_SHAPER_A_OUTPUT +
 	[NET_SHAPER_A_OUTPUT] = NLA_POLICY_NESTED(net_shaper_ns_output_info_nl_policy),
 };
 
+/* NET_SHAPER_CMD_CAP_GET - do */
+static const struct nla_policy net_shaper_cap_get_do_nl_policy[NET_SHAPER_A_CAPABILITIES_SCOPE + 1] = {
+	[NET_SHAPER_A_CAPABILITIES_IFINDEX] = { .type = NLA_U32, },
+	[NET_SHAPER_A_CAPABILITIES_SCOPE] = NLA_POLICY_MAX(NLA_U32, 4),
+};
+
+/* NET_SHAPER_CMD_CAP_GET - dump */
+static const struct nla_policy net_shaper_cap_get_dump_nl_policy[NET_SHAPER_A_CAPABILITIES_IFINDEX + 1] = {
+	[NET_SHAPER_A_CAPABILITIES_IFINDEX] = { .type = NLA_U32, },
+};
+
 /* Ops table for net_shaper */
 static const struct genl_split_ops net_shaper_nl_ops[] = {
 	{
@@ -104,6 +115,20 @@ static const struct genl_split_ops net_shaper_nl_ops[] = {
 		.maxattr	= NET_SHAPER_A_OUTPUT,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NET_SHAPER_CMD_CAP_GET,
+		.doit		= net_shaper_nl_cap_get_doit,
+		.policy		= net_shaper_cap_get_do_nl_policy,
+		.maxattr	= NET_SHAPER_A_CAPABILITIES_SCOPE,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= NET_SHAPER_CMD_CAP_GET,
+		.dumpit		= net_shaper_nl_cap_get_dumpit,
+		.policy		= net_shaper_cap_get_dump_nl_policy,
+		.maxattr	= NET_SHAPER_A_CAPABILITIES_IFINDEX,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
 };
 
 struct genl_family net_shaper_nl_family __ro_after_init = {
diff --git a/net/shaper/shaper_nl_gen.h b/net/shaper/shaper_nl_gen.h
index 00cee4efd21e..97fbd4502364 100644
--- a/net/shaper/shaper_nl_gen.h
+++ b/net/shaper/shaper_nl_gen.h
@@ -21,6 +21,9 @@ int net_shaper_nl_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int net_shaper_nl_set_doit(struct sk_buff *skb, struct genl_info *info);
 int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info);
 int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info);
+int net_shaper_nl_cap_get_doit(struct sk_buff *skb, struct genl_info *info);
+int net_shaper_nl_cap_get_dumpit(struct sk_buff *skb,
+				 struct netlink_callback *cb);
 
 extern struct genl_family net_shaper_nl_family;
 
-- 
2.45.2


