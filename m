Return-Path: <netdev+bounces-107450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8875C91B03D
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 22:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFAA281E05
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 20:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1A919DF67;
	Thu, 27 Jun 2024 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bwplx4Do"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A019DF65
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719519480; cv=none; b=PtEtWxniOt5FqGnqh0HTXYz6qW3YX1S0F6FiUUzrGcoZM3vAC7biWYjsIdjq6YKnx+Wce1L+uzIPsrpfl25VhCZYy5GxTlSsTNMC01LqzydgGGfRnrFYAW7Begu4xIFVFpc/2vWGOEQCsEGsO1+Y2RZhmeizyJl5BCrDEP70kL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719519480; c=relaxed/simple;
	bh=CE7Lcc6Kugop0x63m29YEbSQSN+wyk/+P0yjGiVq+1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nj4TnEmvOHRD4KOOxw6V3b/FBHmtD3/0jvBk0411jS5qJ621zShihT+4XB7jHazbHzeSsQztXi/tAg7GyYQKXt+/VTCwQ3T326+h6XselwYNcASHH2FvC4v1U9NXWY/P4lN+xQVfy1/eiWpCGS8R3MweE5R1GPShuBV3uVHds7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bwplx4Do; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719519478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Qfa00H03C81VrBOAG40c/a4ORQZ+vcBggWQU+aVvlo=;
	b=Bwplx4DoxiKHTJ2sb2T3BMTovBLjORSAZsD/TjwXlrhZCXor3VJsWma8m5P0EqY1ooEJGJ
	kDX3jFzWzKG50XKlNkNBmK2OfQrJJFIbhoBYRofDU0X+XhQ7ONafW8yFRB2by+gSfzPlFh
	keDrxWHpZ9IssDtCQtZZPNM6RuLGNl8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-fMEvCqzdN3qermnlTuywLw-1; Thu,
 27 Jun 2024 16:17:52 -0400
X-MC-Unique: fMEvCqzdN3qermnlTuywLw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DBA2419560AD;
	Thu, 27 Jun 2024 20:17:50 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.42])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CDD591955BE0;
	Thu, 27 Jun 2024 20:17:46 +0000 (UTC)
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
Subject: [PATCH net-next 3/5] netlink: spec: add shaper introspection support
Date: Thu, 27 Jun 2024 22:17:20 +0200
Message-ID: <aff9151bd0cdb8bc79b4247c0574531b97350fc9.1719518113.git.pabeni@redhat.com>
In-Reply-To: <cover.1719518113.git.pabeni@redhat.com>
References: <cover.1719518113.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Allow the user-space to fine-grain query the shaping features
supported by the NIC on each domain.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 Documentation/netlink/specs/shaper.yaml | 74 +++++++++++++++++++++++++
 include/uapi/linux/net_shaper.h         | 17 ++++++
 net/shaper/shaper.c                     | 11 ++++
 net/shaper/shaper_nl_gen.c              | 25 +++++++++
 net/shaper/shaper_nl_gen.h              |  3 +
 5 files changed, 130 insertions(+)

diff --git a/Documentation/netlink/specs/shaper.yaml b/Documentation/netlink/specs/shaper.yaml
index 8563c85de68d..2762aa9bc2bd 100644
--- a/Documentation/netlink/specs/shaper.yaml
+++ b/Documentation/netlink/specs/shaper.yaml
@@ -125,6 +125,51 @@ attribute-sets:
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
+      -
+        name: support-metric-bps
+        doc: the device accepts 'bps' metric for bw-min, bw-max and burst
+        type: flag
+      -
+        name: support-metric-pps
+        doc: the device accepts 'pps' metric for bw-min, bw-max and burst
+        type: flag
+      -
+        name: support-nesting
+        doc: |
+          the device supports nesting shaper belonging to this scope
+          below 'detached' scoped shapers. Only 'queue', 'netdev' and
+          'detached' scope and flag 'support-nesting'.
+        type: flag
+      -
+        name: support-bw-min
+        doc: the device supports a minimum guaranteed bw
+        type: flag
+      -
+        name: support-bw-max
+        doc: the device supports maximum bw shaping
+        type: flag
+      -
+        name: support-burst
+        doc: the device supports a maximum burst size
+        type: flag
+      -
+        name: support-priority
+        doc: the device supports priority scheduling
+        type: flag
+      -
+        name: support-weight
+        doc: the device supports weighted round robin scheduling
+        type: flag
 
 operations:
   list:
@@ -200,3 +245,32 @@ operations:
         reply:
           attributes:
             - modified
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
index 7e6b655e6c6d..83cf94fe4a2f 100644
--- a/include/uapi/linux/net_shaper.h
+++ b/include/uapi/linux/net_shaper.h
@@ -61,10 +61,27 @@ enum {
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
+	NET_SHAPER_CMD_CAP_GET,
 
 	__NET_SHAPER_CMD_MAX,
 	NET_SHAPER_CMD_MAX = (__NET_SHAPER_CMD_MAX - 1)
diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index b1c63cfa21c4..74da98aaa078 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -558,6 +558,17 @@ int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info)
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
 	struct net_shaper_info *cur;
diff --git a/net/shaper/shaper_nl_gen.c b/net/shaper/shaper_nl_gen.c
index 159b4cb6d2b8..38dd6900d2c6 100644
--- a/net/shaper/shaper_nl_gen.c
+++ b/net/shaper/shaper_nl_gen.c
@@ -50,6 +50,17 @@ static const struct nla_policy net_shaper_delete_nl_policy[NET_SHAPER_A_HANDLES
 	[NET_SHAPER_A_HANDLES] = NLA_POLICY_NESTED(net_shaper_handle_nl_policy),
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
@@ -80,6 +91,20 @@ static const struct genl_split_ops net_shaper_nl_ops[] = {
 		.maxattr	= NET_SHAPER_A_HANDLES,
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
index 663406224d62..aa28ddc0a812 100644
--- a/net/shaper/shaper_nl_gen.h
+++ b/net/shaper/shaper_nl_gen.h
@@ -19,6 +19,9 @@ int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info);
 int net_shaper_nl_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int net_shaper_nl_set_doit(struct sk_buff *skb, struct genl_info *info);
 int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info);
+int net_shaper_nl_cap_get_doit(struct sk_buff *skb, struct genl_info *info);
+int net_shaper_nl_cap_get_dumpit(struct sk_buff *skb,
+				 struct netlink_callback *cb);
 
 extern struct genl_family net_shaper_nl_family;
 
-- 
2.45.1


