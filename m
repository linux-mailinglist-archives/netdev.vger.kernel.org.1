Return-Path: <netdev+bounces-26823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BCD77918B
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305011C216A5
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 14:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344BB2AB34;
	Fri, 11 Aug 2023 14:13:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4E063B1
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 14:13:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74E110E4
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 07:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691763213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W93V+18PDZBkp0H+NbABnu4hRuz3rJTSQ0lWLTh187o=;
	b=gnaAiiENcZdMmoTE/LehvJp8YsBaCTTAsULMW9g54zbOEdgHF7IEyc6QwoU1hGAvxnOO3P
	xF/eYK5X5EBmRs2hJ6g5U+4Ua+HK7HQ2eZ+2KzFQiwkb87n+022fnwcFLZTooFTAuCw+EW
	tKwmOEHlZV+djaNBOaiuz9XYptqaMpY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-HpxFU8LpPnmGmxQqUKmwvw-1; Fri, 11 Aug 2023 10:13:29 -0400
X-MC-Unique: HpxFU8LpPnmGmxQqUKmwvw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59CCB1C07555;
	Fri, 11 Aug 2023 14:13:29 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.192.142])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 180391121314;
	Fri, 11 Aug 2023 14:13:27 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	aconole@redhat.com,
	i.maximets@ovn.org,
	eric@garver.life,
	dev@openvswitch.org
Subject: [net-next v5 5/7] net: openvswitch: add misc error drop reasons
Date: Fri, 11 Aug 2023 16:12:52 +0200
Message-ID: <20230811141255.4103827-6-amorenoz@redhat.com>
In-Reply-To: <20230811141255.4103827-1-amorenoz@redhat.com>
References: <20230811141255.4103827-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use drop reasons from include/net/dropreason-core.h when a reasonable
candidate exists.

Acked-by: Aaron Conole <aconole@redhat.com>
Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/openvswitch/actions.c   | 17 ++++++++++-------
 net/openvswitch/conntrack.c |  3 ++-
 net/openvswitch/drop.h      |  6 ++++++
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 122211478606..fd66014d8a76 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -782,7 +782,7 @@ static int ovs_vport_output(struct net *net, struct sock *sk,
 	struct vport *vport = data->vport;
 
 	if (skb_cow_head(skb, data->l2_len) < 0) {
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
 		return -ENOMEM;
 	}
 
@@ -853,6 +853,7 @@ static void ovs_fragment(struct net *net, struct vport *vport,
 			 struct sk_buff *skb, u16 mru,
 			 struct sw_flow_key *key)
 {
+	enum ovs_drop_reason reason;
 	u16 orig_network_offset = 0;
 
 	if (eth_p_mpls(skb->protocol)) {
@@ -862,6 +863,7 @@ static void ovs_fragment(struct net *net, struct vport *vport,
 
 	if (skb_network_offset(skb) > MAX_L2_LEN) {
 		OVS_NLERR(1, "L2 header too long to fragment");
+		reason = OVS_DROP_FRAG_L2_TOO_LONG;
 		goto err;
 	}
 
@@ -902,12 +904,13 @@ static void ovs_fragment(struct net *net, struct vport *vport,
 		WARN_ONCE(1, "Failed fragment ->%s: eth=%04x, MRU=%d, MTU=%d.",
 			  ovs_vport_name(vport), ntohs(key->eth.type), mru,
 			  vport->dev->mtu);
+		reason = OVS_DROP_FRAG_INVALID_PROTO;
 		goto err;
 	}
 
 	return;
 err:
-	kfree_skb(skb);
+	ovs_kfree_skb_reason(skb, reason);
 }
 
 static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
@@ -934,10 +937,10 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 
 			ovs_fragment(net, vport, skb, mru, key);
 		} else {
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_PKT_TOO_BIG);
 		}
 	} else {
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_DEV_READY);
 	}
 }
 
@@ -1011,7 +1014,7 @@ static int dec_ttl_exception_handler(struct datapath *dp, struct sk_buff *skb,
 		return clone_execute(dp, skb, key, 0, nla_data(actions),
 				     nla_len(actions), true, false);
 
-	consume_skb(skb);
+	ovs_kfree_skb_reason(skb, OVS_DROP_IP_TTL);
 	return 0;
 }
 
@@ -1564,7 +1567,7 @@ static int clone_execute(struct datapath *dp, struct sk_buff *skb,
 		/* Out of per CPU action FIFO space. Drop the 'skb' and
 		 * log an error.
 		 */
-		kfree_skb(skb);
+		ovs_kfree_skb_reason(skb, OVS_DROP_DEFERRED_LIMIT);
 
 		if (net_ratelimit()) {
 			if (actions) { /* Sample action */
@@ -1616,7 +1619,7 @@ int ovs_execute_actions(struct datapath *dp, struct sk_buff *skb,
 	if (unlikely(level > OVS_RECURSION_LIMIT)) {
 		net_crit_ratelimited("ovs: recursion limit reached on datapath %s, probable configuration error\n",
 				     ovs_dp_name(dp));
-		kfree_skb(skb);
+		ovs_kfree_skb_reason(skb, OVS_DROP_RECURSION_LIMIT);
 		err = -ENETDOWN;
 		goto out;
 	}
diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index fa955e892210..0cfa1e9482e6 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -29,6 +29,7 @@
 #include <net/netfilter/nf_conntrack_act_ct.h>
 
 #include "datapath.h"
+#include "drop.h"
 #include "conntrack.h"
 #include "flow.h"
 #include "flow_netlink.h"
@@ -1035,7 +1036,7 @@ int ovs_ct_execute(struct net *net, struct sk_buff *skb,
 
 	skb_push_rcsum(skb, nh_ofs);
 	if (err)
-		kfree_skb(skb);
+		ovs_kfree_skb_reason(skb, OVS_DROP_CONNTRACK);
 	return err;
 }
 
diff --git a/net/openvswitch/drop.h b/net/openvswitch/drop.h
index a35e63d71094..cedf9b7b5796 100644
--- a/net/openvswitch/drop.h
+++ b/net/openvswitch/drop.h
@@ -14,6 +14,12 @@
 	R(OVS_DROP_EXPLICIT)			\
 	R(OVS_DROP_EXPLICIT_WITH_ERROR)		\
 	R(OVS_DROP_METER)			\
+	R(OVS_DROP_RECURSION_LIMIT)		\
+	R(OVS_DROP_DEFERRED_LIMIT)		\
+	R(OVS_DROP_FRAG_L2_TOO_LONG)		\
+	R(OVS_DROP_FRAG_INVALID_PROTO)		\
+	R(OVS_DROP_CONNTRACK)			\
+	R(OVS_DROP_IP_TTL)			\
 	/* deliberate comment for trailing \ */
 
 enum ovs_drop_reason {
-- 
2.41.0


