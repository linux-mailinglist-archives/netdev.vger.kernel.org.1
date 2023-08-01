Return-Path: <netdev+bounces-23305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B87E76B853
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E77281973
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4684DC8A;
	Tue,  1 Aug 2023 15:17:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12C04DC6D
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 15:17:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D571BE7
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 08:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690903026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1UIk9Q6jh2x7rSdTcmYd0G7jfP4+n7PKRmz8qLc2+k=;
	b=aJOPA4lvCOA+voP3wqeD+BVQ36JTxrVpDlS4kJ8qkQ+qij3xiPOL0D0ARvPrCkGYplJa3r
	dWMLZIziDGDi9TPG+qnPHVgY919cqi7O2tYZMcXkoBFHzBo4GVsyUxjRW6cPLwnrAAq1MU
	y9vVa5JBRpJDh7FBiC87kaxOf5GgIoM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-JCo05jM8McCxjOWIT9lGdA-1; Tue, 01 Aug 2023 11:17:00 -0400
X-MC-Unique: JCo05jM8McCxjOWIT9lGdA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52137185A7A3;
	Tue,  1 Aug 2023 15:17:00 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.90])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3C36AC57964;
	Tue,  1 Aug 2023 15:16:59 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	aconole@redhat.com,
	i.maximets@ovn.org,
	eric@garver.life,
	dev@openvswitch.org
Subject: [RFC net-next v2 1/7] net: openvswitch: add datapath flow drop reason
Date: Tue,  1 Aug 2023 17:16:42 +0200
Message-ID: <20230801151649.744695-2-amorenoz@redhat.com>
In-Reply-To: <20230801151649.744695-1-amorenoz@redhat.com>
References: <20230801151649.744695-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Create a new drop reason subsystem for openvswitch and add the first
drop reason to represent flow drops.

A flow drop happens when a flow has an empty action-set or there is no
action that consumes the packet (output, userspace, recirc, etc).

Implementation-wise, most of these skb-consuming actions already call
"consume_skb" internally and return directly from within the
do_execute_actions() loop so with minimal changes we can assume that
any skb that exits the loop normally is a packet drop.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 include/net/dropreason.h   |  6 ++++++
 net/openvswitch/actions.c  | 12 ++++++++++--
 net/openvswitch/datapath.c | 16 ++++++++++++++++
 net/openvswitch/drop.h     | 24 ++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 2 deletions(-)
 create mode 100644 net/openvswitch/drop.h

diff --git a/include/net/dropreason.h b/include/net/dropreason.h
index 685fb37df8e8..56cb7be92244 100644
--- a/include/net/dropreason.h
+++ b/include/net/dropreason.h
@@ -23,6 +23,12 @@ enum skb_drop_reason_subsys {
 	 */
 	SKB_DROP_REASON_SUBSYS_MAC80211_MONITOR,
 
+	/**
+	 * @SKB_DROP_REASON_SUBSYS_OPENVSWITCH: openvswitch drop reasons,
+	 * see net/openvswitch/drop.h
+	 */
+	SKB_DROP_REASON_SUBSYS_OPENVSWITCH,
+
 	/** @SKB_DROP_REASON_SUBSYS_NUM: number of subsystems defined */
 	SKB_DROP_REASON_SUBSYS_NUM
 };
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index cab1e02b63e0..af676dcac2b4 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -27,6 +27,7 @@
 #include <net/sctp/checksum.h>
 
 #include "datapath.h"
+#include "drop.h"
 #include "flow.h"
 #include "conntrack.h"
 #include "vport.h"
@@ -1036,7 +1037,7 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
 	if ((arg->probability != U32_MAX) &&
 	    (!arg->probability || get_random_u32() > arg->probability)) {
 		if (last)
-			consume_skb(skb);
+			kfree_skb_reason(skb, OVS_DROP_FLOW);
 		return 0;
 	}
 
@@ -1297,6 +1298,9 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 		if (trace_ovs_do_execute_action_enabled())
 			trace_ovs_do_execute_action(dp, skb, key, a, rem);
 
+		/* Actions that rightfully have to consume the skb should do it
+		 * and return directly.
+		 */
 		switch (nla_type(a)) {
 		case OVS_ACTION_ATTR_OUTPUT: {
 			int port = nla_get_u32(a);
@@ -1332,6 +1336,10 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 			output_userspace(dp, skb, key, a, attr,
 						     len, OVS_CB(skb)->cutlen);
 			OVS_CB(skb)->cutlen = 0;
+			if (nla_is_last(a, rem)) {
+				consume_skb(skb);
+				return 0;
+			}
 			break;
 
 		case OVS_ACTION_ATTR_HASH:
@@ -1485,7 +1493,7 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 		}
 	}
 
-	consume_skb(skb);
+	kfree_skb_reason(skb, OVS_DROP_FLOW);
 	return 0;
 }
 
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index a6d2a0b1aa21..d33cb739883f 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -41,6 +41,7 @@
 #include <net/pkt_cls.h>
 
 #include "datapath.h"
+#include "drop.h"
 #include "flow.h"
 #include "flow_table.h"
 #include "flow_netlink.h"
@@ -2702,6 +2703,17 @@ static struct pernet_operations ovs_net_ops = {
 	.size = sizeof(struct ovs_net),
 };
 
+static const char * const ovs_drop_reasons[] = {
+#define S(x)	(#x),
+	OVS_DROP_REASONS(S)
+#undef S
+};
+
+static struct drop_reason_list drop_reason_list_ovs = {
+	.reasons = ovs_drop_reasons,
+	.n_reasons = ARRAY_SIZE(ovs_drop_reasons),
+};
+
 static int __init dp_init(void)
 {
 	int err;
@@ -2743,6 +2755,9 @@ static int __init dp_init(void)
 	if (err < 0)
 		goto error_unreg_netdev;
 
+	drop_reasons_register_subsys(SKB_DROP_REASON_SUBSYS_OPENVSWITCH,
+				     &drop_reason_list_ovs);
+
 	return 0;
 
 error_unreg_netdev:
@@ -2769,6 +2784,7 @@ static void dp_cleanup(void)
 	ovs_netdev_exit();
 	unregister_netdevice_notifier(&ovs_dp_device_notifier);
 	unregister_pernet_device(&ovs_net_ops);
+	drop_reasons_unregister_subsys(SKB_DROP_REASON_SUBSYS_OPENVSWITCH);
 	rcu_barrier();
 	ovs_vport_exit();
 	ovs_flow_exit();
diff --git a/net/openvswitch/drop.h b/net/openvswitch/drop.h
new file mode 100644
index 000000000000..cdd10629c6be
--- /dev/null
+++ b/net/openvswitch/drop.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * OpenvSwitch drop reason list.
+ */
+
+#ifndef OPENVSWITCH_DROP_H
+#define OPENVSWITCH_DROP_H
+#include <net/dropreason.h>
+
+#define OVS_DROP_REASONS(R)			\
+	R(OVS_DROP_FLOW)		        \
+	/* deliberate comment for trailing \ */
+
+enum ovs_drop_reason {
+	__OVS_DROP_REASON = SKB_DROP_REASON_SUBSYS_OPENVSWITCH <<
+				SKB_DROP_REASON_SUBSYS_SHIFT,
+#define ENUM(x) x,
+	OVS_DROP_REASONS(ENUM)
+#undef ENUM
+
+	OVS_DROP_MAX,
+};
+
+#endif /* OPENVSWITCH_DROP_H */
-- 
2.41.0


