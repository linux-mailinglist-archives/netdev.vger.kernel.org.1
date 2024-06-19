Return-Path: <netdev+bounces-105056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FC790F7FF
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 23:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D2F5B24693
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 21:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2BD15D5AE;
	Wed, 19 Jun 2024 21:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ND/uvG+p"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAB615CD78
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718830863; cv=none; b=Y5lmAgxOV7Shqu3Ny+FbwQ32cp+uWIO9JgVCgWA3vLEusLSxuWQ7E1F4n5X1FnmPzqM17RGN1JTuoOpLifEPYKbQYH2OpsjxqfHWdC2lkC34UNgrSP1f/n3FsuSl0StL8Ce9NwgeMh8LAlFF8gNZlIhZp/0U5u7xO0wrMmfcVh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718830863; c=relaxed/simple;
	bh=Zumneq81eiljykQ8RIwCddzlhrN+5rsE9LSCAfREeIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPV85ZEs/T4H3hmxxmdlUe5bVipm+sh/fWLpx8K+7Ik+nWv/syils1242eZd+0U2twb74SSI8PA/y2BGlQZ+z6SRXhRpG7j6ZLbSllSIIf6f6lezx6IvaHMKHhD88/cfJeOL/jBn2c3GR2Am6tyEg/eT3zaJ+oCFz895EBq5BwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ND/uvG+p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718830860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5FUrIUhVXKVgK6nxNd7chmVT3XlygQ/EuvuoIwTLMhw=;
	b=ND/uvG+pafC+ZI+9vNgx9BtMddHyojm0yGp4KQFq0BhHoXWzmocEj9o2fEocS+MjHjNpmC
	XJ29q5Iztz4E9ROc4NebAgqLGUBAXaORWeYX1luyHmU8ReKMcmB1qT/KKVU53eaXhJcpL7
	cd9NlqUDYTu3Xuh1TMl6sm74kov3WmA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-m7EehPZfNAOMPdGeYBBvDA-1; Wed,
 19 Jun 2024 17:00:57 -0400
X-MC-Unique: m7EehPZfNAOMPdGeYBBvDA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA7FC195608C;
	Wed, 19 Jun 2024 21:00:55 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.189])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E04F19560AE;
	Wed, 19 Jun 2024 21:00:51 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 05/10] net: openvswitch: add emit_sample action
Date: Wed, 19 Jun 2024 23:00:06 +0200
Message-ID: <20240619210023.982698-6-amorenoz@redhat.com>
In-Reply-To: <20240619210023.982698-1-amorenoz@redhat.com>
References: <20240619210023.982698-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add support for a new action: emit_sample.

This action accepts a u32 group id and a variable-length cookie and uses
the psample multicast group to make the packet available for
observability.

The maximum length of the user-defined cookie is set to 16, same as
tc_cookie, to discourage using cookies that will not be offloadable.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 Documentation/netlink/specs/ovs_flow.yaml | 17 +++++++++
 include/uapi/linux/openvswitch.h          | 27 ++++++++++++++
 net/openvswitch/Kconfig                   |  1 +
 net/openvswitch/actions.c                 | 45 +++++++++++++++++++++++
 net/openvswitch/flow_netlink.c            | 33 ++++++++++++++++-
 5 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
index 4fdfc6b5cae9..a7ab5593a24f 100644
--- a/Documentation/netlink/specs/ovs_flow.yaml
+++ b/Documentation/netlink/specs/ovs_flow.yaml
@@ -727,6 +727,12 @@ attribute-sets:
         name: dec-ttl
         type: nest
         nested-attributes: dec-ttl-attrs
+      -
+        name: emit-sample
+        type: nest
+        nested-attributes: emit-sample-attrs
+        doc: |
+          Sends a packet sample to psample for external observation.
   -
     name: tunnel-key-attrs
     enum-name: ovs-tunnel-key-attr
@@ -938,6 +944,17 @@ attribute-sets:
       -
         name: gbp
         type: u32
+  -
+    name: emit-sample-attrs
+    enum-name: ovs-emit-sample-attr
+    name-prefix: ovs-emit-sample-attr-
+    attributes:
+      -
+        name: group
+        type: u32
+      -
+        name: cookie
+        type: binary
 
 operations:
   name-prefix: ovs-flow-cmd-
diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
index efc82c318fa2..b91b4c3cc230 100644
--- a/include/uapi/linux/openvswitch.h
+++ b/include/uapi/linux/openvswitch.h
@@ -914,6 +914,30 @@ struct check_pkt_len_arg {
 };
 #endif
 
+#define OVS_EMIT_SAMPLE_COOKIE_MAX_SIZE 16
+/**
+ * enum ovs_emit_sample_attr - Attributes for %OVS_ACTION_ATTR_EMIT_SAMPLE
+ * action.
+ *
+ * @OVS_EMIT_SAMPLE_ATTR_GROUP: 32-bit number to identify the source of the
+ * sample.
+ * @OVS_EMIT_SAMPLE_ATTR_COOKIE: A variable-length binary cookie that contains
+ * user-defined metadata. The maximum length is OVS_EMIT_SAMPLE_COOKIE_MAX_SIZE
+ * bytes.
+ *
+ * Sends the packet to the psample multicast group with the specified group and
+ * cookie. It is possible to combine this action with the
+ * %OVS_ACTION_ATTR_TRUNC action to limit the size of the packet being emitted.
+ */
+enum ovs_emit_sample_attr {
+	OVS_EMIT_SAMPLE_ATTR_UNPSEC,
+	OVS_EMIT_SAMPLE_ATTR_GROUP,	/* u32 number. */
+	OVS_EMIT_SAMPLE_ATTR_COOKIE,	/* Optional, user specified cookie. */
+	__OVS_EMIT_SAMPLE_ATTR_MAX
+};
+
+#define OVS_EMIT_SAMPLE_ATTR_MAX (__OVS_EMIT_SAMPLE_ATTR_MAX - 1)
+
 /**
  * enum ovs_action_attr - Action types.
  *
@@ -966,6 +990,8 @@ struct check_pkt_len_arg {
  * of l3 tunnel flag in the tun_flags field of OVS_ACTION_ATTR_ADD_MPLS
  * argument.
  * @OVS_ACTION_ATTR_DROP: Explicit drop action.
+ * @OVS_ACTION_ATTR_EMIT_SAMPLE: Send a sample of the packet to external
+ * observers via psample.
  *
  * Only a single header can be set with a single %OVS_ACTION_ATTR_SET.  Not all
  * fields within a header are modifiable, e.g. the IPv4 protocol and fragment
@@ -1004,6 +1030,7 @@ enum ovs_action_attr {
 	OVS_ACTION_ATTR_ADD_MPLS,     /* struct ovs_action_add_mpls. */
 	OVS_ACTION_ATTR_DEC_TTL,      /* Nested OVS_DEC_TTL_ATTR_*. */
 	OVS_ACTION_ATTR_DROP,         /* u32 error code. */
+	OVS_ACTION_ATTR_EMIT_SAMPLE,  /* Nested OVS_EMIT_SAMPLE_ATTR_*. */
 
 	__OVS_ACTION_ATTR_MAX,	      /* Nothing past this will be accepted
 				       * from userspace. */
diff --git a/net/openvswitch/Kconfig b/net/openvswitch/Kconfig
index 29a7081858cd..2535f3f9f462 100644
--- a/net/openvswitch/Kconfig
+++ b/net/openvswitch/Kconfig
@@ -10,6 +10,7 @@ config OPENVSWITCH
 		   (NF_CONNTRACK && ((!NF_DEFRAG_IPV6 || NF_DEFRAG_IPV6) && \
 				     (!NF_NAT || NF_NAT) && \
 				     (!NETFILTER_CONNCOUNT || NETFILTER_CONNCOUNT)))
+	depends on PSAMPLE || !PSAMPLE
 	select LIBCRC32C
 	select MPLS
 	select NET_MPLS_GSO
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 964225580824..1f555cbba312 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -24,6 +24,11 @@
 #include <net/checksum.h>
 #include <net/dsfield.h>
 #include <net/mpls.h>
+
+#if IS_ENABLED(CONFIG_PSAMPLE)
+#include <net/psample.h>
+#endif
+
 #include <net/sctp/checksum.h>
 
 #include "datapath.h"
@@ -1299,6 +1304,37 @@ static int execute_dec_ttl(struct sk_buff *skb, struct sw_flow_key *key)
 	return 0;
 }
 
+static void execute_emit_sample(struct datapath *dp, struct sk_buff *skb,
+				const struct sw_flow_key *key,
+				const struct nlattr *attr)
+{
+#if IS_ENABLED(CONFIG_PSAMPLE)
+	struct psample_group psample_group = {};
+	struct psample_metadata md = {};
+	const struct nlattr *a;
+	int rem;
+
+	nla_for_each_attr(a, nla_data(attr), nla_len(attr), rem) {
+		switch (nla_type(a)) {
+		case OVS_EMIT_SAMPLE_ATTR_GROUP:
+			psample_group.group_num = nla_get_u32(a);
+			break;
+
+		case OVS_EMIT_SAMPLE_ATTR_COOKIE:
+			md.user_cookie = nla_data(a);
+			md.user_cookie_len = nla_len(a);
+			break;
+		}
+	}
+
+	psample_group.net = ovs_dp_get_net(dp);
+	md.in_ifindex = OVS_CB(skb)->input_vport->dev->ifindex;
+	md.trunc_size = skb->len - OVS_CB(skb)->cutlen;
+
+	psample_sample_packet(&psample_group, skb, 0, &md);
+#endif
+}
+
 /* Execute a list of actions against 'skb'. */
 static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 			      struct sw_flow_key *key,
@@ -1502,6 +1538,15 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 			ovs_kfree_skb_reason(skb, reason);
 			return 0;
 		}
+
+		case OVS_ACTION_ATTR_EMIT_SAMPLE:
+			execute_emit_sample(dp, skb, key, a);
+			OVS_CB(skb)->cutlen = 0;
+			if (nla_is_last(a, rem)) {
+				consume_skb(skb);
+				return 0;
+			}
+			break;
 		}
 
 		if (unlikely(err)) {
diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index f224d9bcea5e..29c8cdc44433 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -64,6 +64,7 @@ static bool actions_may_change_flow(const struct nlattr *actions)
 		case OVS_ACTION_ATTR_TRUNC:
 		case OVS_ACTION_ATTR_USERSPACE:
 		case OVS_ACTION_ATTR_DROP:
+		case OVS_ACTION_ATTR_EMIT_SAMPLE:
 			break;
 
 		case OVS_ACTION_ATTR_CT:
@@ -2409,7 +2410,7 @@ static void ovs_nla_free_nested_actions(const struct nlattr *actions, int len)
 	/* Whenever new actions are added, the need to update this
 	 * function should be considered.
 	 */
-	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX != 24);
+	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX != 25);
 
 	if (!actions)
 		return;
@@ -3157,6 +3158,29 @@ static int validate_and_copy_check_pkt_len(struct net *net,
 	return 0;
 }
 
+static int validate_emit_sample(const struct nlattr *attr)
+{
+	static const struct nla_policy policy[OVS_EMIT_SAMPLE_ATTR_MAX + 1] = {
+		[OVS_EMIT_SAMPLE_ATTR_GROUP] = { .type = NLA_U32 },
+		[OVS_EMIT_SAMPLE_ATTR_COOKIE] = {
+			.type = NLA_BINARY,
+			.len = OVS_EMIT_SAMPLE_COOKIE_MAX_SIZE,
+		},
+	};
+	struct nlattr *a[OVS_EMIT_SAMPLE_ATTR_MAX + 1];
+	int err;
+
+	if (!IS_ENABLED(CONFIG_PSAMPLE))
+		return -EOPNOTSUPP;
+
+	err = nla_parse_nested(a, OVS_EMIT_SAMPLE_ATTR_MAX, attr, policy,
+			       NULL);
+	if (err)
+		return err;
+
+	return a[OVS_EMIT_SAMPLE_ATTR_GROUP] ? 0 : -EINVAL;
+}
+
 static int copy_action(const struct nlattr *from,
 		       struct sw_flow_actions **sfa, bool log)
 {
@@ -3212,6 +3236,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 			[OVS_ACTION_ATTR_ADD_MPLS] = sizeof(struct ovs_action_add_mpls),
 			[OVS_ACTION_ATTR_DEC_TTL] = (u32)-1,
 			[OVS_ACTION_ATTR_DROP] = sizeof(u32),
+			[OVS_ACTION_ATTR_EMIT_SAMPLE] = (u32)-1,
 		};
 		const struct ovs_action_push_vlan *vlan;
 		int type = nla_type(a);
@@ -3490,6 +3515,12 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 				return -EINVAL;
 			break;
 
+		case OVS_ACTION_ATTR_EMIT_SAMPLE:
+			err = validate_emit_sample(a);
+			if (err)
+				return err;
+			break;
+
 		default:
 			OVS_NLERR(log, "Unknown Action type %d", type);
 			return -EINVAL;
-- 
2.45.1


