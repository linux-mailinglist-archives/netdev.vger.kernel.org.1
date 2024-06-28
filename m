Return-Path: <netdev+bounces-107652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCE591BD13
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 13:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF531C21883
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 11:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB34215572D;
	Fri, 28 Jun 2024 11:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9YUDYYV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F0115746E
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719572804; cv=none; b=kyp3iAH0aw48rV9+RpyVhmUr72uw6RZM9DJgJ4OwHSlxeTVjBt+sRkVCty4sZpv1e1U4cNPbMrpTtSK6bQFyU3aTQ5mCjLXrm2oDb9FUj3s9HGfpkKMDeGL0uEUMzf6N68BucIYaY3XUYTeEeDhmPdPR7EW+kbGIo24FNX2H+a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719572804; c=relaxed/simple;
	bh=+uAgLPKFLsP4TswwiIJ3ActchtkYUi29ms0BIlGBZao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sfpfl2VLaYbd3XM749dN1HUKSbAyLx3w6FzCU6AEeun0iJb3obkMh37KEVrx9uvQbYscqqyeb2KpgJUaJKy5Urh/anJgpkXgbMNaOlp0rfkI6eCfv7Q0tTzfQEIMR/vhtceF4APJmjZHD3XPU4Y75rujR9cQZhHJZiK1gTqlNig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V9YUDYYV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719572802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oXu04IK4fF8bwMpUsTqoG/e0GWqCXa5t1JBcGAanHDw=;
	b=V9YUDYYVjDStHjX+KXTXGwm6AtTYSZ2xXBww5U1gZ4vjAXsW1R0nHCqi5jGkdKHUtyHU9L
	EXq0Kgd/As4w/qeZ5VguHhU6CJYhIqXLjBrgheYQ5/kUYYeLKTr61fpmE3/vHb5NYBnlBf
	8EVYkiWAgf8dJkwFj55PQcRiCMD/ypw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-JtQLXT5_Nf2dKHaKXLgK4Q-1; Fri,
 28 Jun 2024 07:06:37 -0400
X-MC-Unique: JtQLXT5_Nf2dKHaKXLgK4Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7E8D192DE05;
	Fri, 28 Jun 2024 11:06:33 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.194.173])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4200019560B2;
	Fri, 28 Jun 2024 11:06:29 +0000 (UTC)
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
Subject: [PATCH net-next v6 05/10] net: openvswitch: add psample action
Date: Fri, 28 Jun 2024 13:05:41 +0200
Message-ID: <20240628110559.3893562-6-amorenoz@redhat.com>
In-Reply-To: <20240628110559.3893562-1-amorenoz@redhat.com>
References: <20240628110559.3893562-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add support for a new action: psample.

This action accepts a u32 group id and a variable-length cookie and uses
the psample multicast group to make the packet available for
observability.

The maximum length of the user-defined cookie is set to 16, same as
tc_cookie, to discourage using cookies that will not be offloadable.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 Documentation/netlink/specs/ovs_flow.yaml | 17 ++++++++
 include/uapi/linux/openvswitch.h          | 28 ++++++++++++++
 net/openvswitch/Kconfig                   |  1 +
 net/openvswitch/actions.c                 | 47 +++++++++++++++++++++++
 net/openvswitch/flow_netlink.c            | 32 ++++++++++++++-
 5 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
index 4fdfc6b5cae9..46f5d1cd8a5f 100644
--- a/Documentation/netlink/specs/ovs_flow.yaml
+++ b/Documentation/netlink/specs/ovs_flow.yaml
@@ -727,6 +727,12 @@ attribute-sets:
         name: dec-ttl
         type: nest
         nested-attributes: dec-ttl-attrs
+      -
+        name: psample
+        type: nest
+        nested-attributes: psample-attrs
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
+    name: psample-attrs
+    enum-name: ovs-psample-attr
+    name-prefix: ovs-psample-attr-
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
index efc82c318fa2..07086759556b 100644
--- a/include/uapi/linux/openvswitch.h
+++ b/include/uapi/linux/openvswitch.h
@@ -914,6 +914,31 @@ struct check_pkt_len_arg {
 };
 #endif
 
+#define OVS_PSAMPLE_COOKIE_MAX_SIZE 16
+/**
+ * enum ovs_pample_attr - Attributes for %OVS_ACTION_ATTR_PSAMPLE
+ * action.
+ *
+ * @OVS_PSAMPLE_ATTR_GROUP: 32-bit number to identify the source of the
+ * sample.
+ * @OVS_PSAMPLE_ATTR_COOKIE: An optional variable-length binary cookie that
+ * contains user-defined metadata. The maximum length is
+ * OVS_PSAMPLE_COOKIE_MAX_SIZE bytes.
+ *
+ * Sends the packet to the psample multicast group with the specified group and
+ * cookie. It is possible to combine this action with the
+ * %OVS_ACTION_ATTR_TRUNC action to limit the size of the sample.
+ */
+enum ovs_psample_attr {
+	OVS_PSAMPLE_ATTR_GROUP = 1,	/* u32 number. */
+	OVS_PSAMPLE_ATTR_COOKIE,	/* Optional, user specified cookie. */
+
+	/* private: */
+	__OVS_PSAMPLE_ATTR_MAX
+};
+
+#define OVS_PSAMPLE_ATTR_MAX (__OVS_PSAMPLE_ATTR_MAX - 1)
+
 /**
  * enum ovs_action_attr - Action types.
  *
@@ -966,6 +991,8 @@ struct check_pkt_len_arg {
  * of l3 tunnel flag in the tun_flags field of OVS_ACTION_ATTR_ADD_MPLS
  * argument.
  * @OVS_ACTION_ATTR_DROP: Explicit drop action.
+ * @OVS_ACTION_ATTR_PSAMPLE: Send a sample of the packet to external observers
+ * via psample.
  *
  * Only a single header can be set with a single %OVS_ACTION_ATTR_SET.  Not all
  * fields within a header are modifiable, e.g. the IPv4 protocol and fragment
@@ -1004,6 +1031,7 @@ enum ovs_action_attr {
 	OVS_ACTION_ATTR_ADD_MPLS,     /* struct ovs_action_add_mpls. */
 	OVS_ACTION_ATTR_DEC_TTL,      /* Nested OVS_DEC_TTL_ATTR_*. */
 	OVS_ACTION_ATTR_DROP,         /* u32 error code. */
+	OVS_ACTION_ATTR_PSAMPLE,      /* Nested OVS_PSAMPLE_ATTR_*. */
 
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
index 964225580824..a035b7e677dd 100644
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
@@ -1299,6 +1304,39 @@ static int execute_dec_ttl(struct sk_buff *skb, struct sw_flow_key *key)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_PSAMPLE)
+static void execute_psample(struct datapath *dp, struct sk_buff *skb,
+			    const struct nlattr *attr)
+{
+	struct psample_group psample_group = {};
+	struct psample_metadata md = {};
+	const struct nlattr *a;
+	int rem;
+
+	nla_for_each_attr(a, nla_data(attr), nla_len(attr), rem) {
+		switch (nla_type(a)) {
+		case OVS_PSAMPLE_ATTR_GROUP:
+			psample_group.group_num = nla_get_u32(a);
+			break;
+
+		case OVS_PSAMPLE_ATTR_COOKIE:
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
+}
+#else
+static inline void execute_psample(struct datapath *dp, struct sk_buff *skb,
+				   const struct nlattr *attr) {}
+#endif
+
 /* Execute a list of actions against 'skb'. */
 static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 			      struct sw_flow_key *key,
@@ -1502,6 +1540,15 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 			ovs_kfree_skb_reason(skb, reason);
 			return 0;
 		}
+
+		case OVS_ACTION_ATTR_PSAMPLE:
+			execute_psample(dp, skb, a);
+			OVS_CB(skb)->cutlen = 0;
+			if (nla_is_last(a, rem)) {
+				consume_skb(skb);
+				return 0;
+			}
+			break;
 		}
 
 		if (unlikely(err)) {
diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index f224d9bcea5e..c92bdc4dfe19 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -64,6 +64,7 @@ static bool actions_may_change_flow(const struct nlattr *actions)
 		case OVS_ACTION_ATTR_TRUNC:
 		case OVS_ACTION_ATTR_USERSPACE:
 		case OVS_ACTION_ATTR_DROP:
+		case OVS_ACTION_ATTR_PSAMPLE:
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
@@ -3157,6 +3158,28 @@ static int validate_and_copy_check_pkt_len(struct net *net,
 	return 0;
 }
 
+static int validate_psample(const struct nlattr *attr)
+{
+	static const struct nla_policy policy[OVS_PSAMPLE_ATTR_MAX + 1] = {
+		[OVS_PSAMPLE_ATTR_GROUP] = { .type = NLA_U32 },
+		[OVS_PSAMPLE_ATTR_COOKIE] = {
+			.type = NLA_BINARY,
+			.len = OVS_PSAMPLE_COOKIE_MAX_SIZE,
+		},
+	};
+	struct nlattr *a[OVS_PSAMPLE_ATTR_MAX + 1];
+	int err;
+
+	if (!IS_ENABLED(CONFIG_PSAMPLE))
+		return -EOPNOTSUPP;
+
+	err = nla_parse_nested(a, OVS_PSAMPLE_ATTR_MAX, attr, policy, NULL);
+	if (err)
+		return err;
+
+	return a[OVS_PSAMPLE_ATTR_GROUP] ? 0 : -EINVAL;
+}
+
 static int copy_action(const struct nlattr *from,
 		       struct sw_flow_actions **sfa, bool log)
 {
@@ -3212,6 +3235,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 			[OVS_ACTION_ATTR_ADD_MPLS] = sizeof(struct ovs_action_add_mpls),
 			[OVS_ACTION_ATTR_DEC_TTL] = (u32)-1,
 			[OVS_ACTION_ATTR_DROP] = sizeof(u32),
+			[OVS_ACTION_ATTR_PSAMPLE] = (u32)-1,
 		};
 		const struct ovs_action_push_vlan *vlan;
 		int type = nla_type(a);
@@ -3490,6 +3514,12 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 				return -EINVAL;
 			break;
 
+		case OVS_ACTION_ATTR_PSAMPLE:
+			err = validate_psample(a);
+			if (err)
+				return err;
+			break;
+
 		default:
 			OVS_NLERR(log, "Unknown Action type %d", type);
 			return -EINVAL;
-- 
2.45.2


