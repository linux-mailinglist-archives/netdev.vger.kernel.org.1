Return-Path: <netdev+bounces-23308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B820A76B859
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1D51C20F54
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190821ADCF;
	Tue,  1 Aug 2023 15:17:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8FB1ADCE
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 15:17:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553B21BE9
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 08:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690903028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eUB43eeXi+X6o9CX1HV0nvj3/68xObOxlRkWW+YLFb8=;
	b=VWELJ/0HYtK5Z/F5R2aPgI9HD29oH8sClXyCy0OsmD9Km5y27d2xDkbVoQT+jrW3O/HMAy
	HPexuMht/bUCJ0FdpJTF5aRHNGAGdsYJbW1+qSYUlXTGBofElVpgrI5U/LSXjuEULOiyrO
	fNjMLBz0TLlSYX6geEP+gNJoPJqvGaA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-zKJfAZMrOG-G6XVUsKaYhw-1; Tue, 01 Aug 2023 11:17:03 -0400
X-MC-Unique: zKJfAZMrOG-G6XVUsKaYhw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13243856F67;
	Tue,  1 Aug 2023 15:17:03 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.90])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F06FFC57964;
	Tue,  1 Aug 2023 15:17:01 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Garver <eric@garver.life>,
	aconole@redhat.com,
	i.maximets@ovn.org,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>
Subject: [RFC net-next v2 3/7] net: openvswitch: add explicit drop action
Date: Tue,  1 Aug 2023 17:16:44 +0200
Message-ID: <20230801151649.744695-4-amorenoz@redhat.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Eric Garver <eric@garver.life>

From: Eric Garver <eric@garver.life>

This adds an explicit drop action. This is used by OVS to drop packets
for which it cannot determine what to do. An explicit action in the
kernel allows passing the reason _why_ the packet is being dropped or
zero to indicate no particular error happened (i.e: OVS intentionally
dropped the packet).

Since the error codes coming from userspace mean nothing for the kernel,
we squash all of them into only two drop reasons:
- OVS_DROP_EXPLICIT_ACTION_ERROR to indicate a non-zero value was passed
- OVS_DROP_EXPLICIT_ACTION to indicate a zero value was passed (no
  error)

e.g. trace all OVS dropped skbs

 # perf trace -e skb:kfree_skb --filter="reason >= 0x30000"
 [..]
 106.023 ping/2465 skb:kfree_skb(skbaddr: 0xffffa0e8765f2000, \
  location:0xffffffffc0d9b462, protocol: 2048, reason: 196611)

reason: 196611 --> 0x30003 (OVS_DROP_EXPLICIT_ACTION)

Signed-off-by: Eric Garver <eric@garver.life>
Co-developed-by: Adrian Moreno <amorenoz@redhat.com>
Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 include/uapi/linux/openvswitch.h                     |  2 ++
 net/openvswitch/actions.c                            |  9 +++++++++
 net/openvswitch/drop.h                               |  2 ++
 net/openvswitch/flow_netlink.c                       | 10 +++++++++-
 tools/testing/selftests/net/openvswitch/ovs-dpctl.py |  3 +++
 5 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
index e94870e77ee9..efc82c318fa2 100644
--- a/include/uapi/linux/openvswitch.h
+++ b/include/uapi/linux/openvswitch.h
@@ -965,6 +965,7 @@ struct check_pkt_len_arg {
  * start of the packet or at the start of the l3 header depending on the value
  * of l3 tunnel flag in the tun_flags field of OVS_ACTION_ATTR_ADD_MPLS
  * argument.
+ * @OVS_ACTION_ATTR_DROP: Explicit drop action.
  *
  * Only a single header can be set with a single %OVS_ACTION_ATTR_SET.  Not all
  * fields within a header are modifiable, e.g. the IPv4 protocol and fragment
@@ -1002,6 +1003,7 @@ enum ovs_action_attr {
 	OVS_ACTION_ATTR_CHECK_PKT_LEN, /* Nested OVS_CHECK_PKT_LEN_ATTR_*. */
 	OVS_ACTION_ATTR_ADD_MPLS,     /* struct ovs_action_add_mpls. */
 	OVS_ACTION_ATTR_DEC_TTL,      /* Nested OVS_DEC_TTL_ATTR_*. */
+	OVS_ACTION_ATTR_DROP,         /* u32 error code. */
 
 	__OVS_ACTION_ATTR_MAX,	      /* Nothing past this will be accepted
 				       * from userspace. */
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 9b66a3334aaa..285b1243b94f 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -1485,6 +1485,15 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 				return dec_ttl_exception_handler(dp, skb,
 								 key, a);
 			break;
+
+		case OVS_ACTION_ATTR_DROP: {
+			enum ovs_drop_reason reason = nla_get_u32(a)
+				? OVS_DROP_EXPLICIT_ACTION_ERROR
+				: OVS_DROP_EXPLICIT_ACTION;
+
+			kfree_skb_reason(skb, reason);
+			return 0;
+		}
 		}
 
 		if (unlikely(err)) {
diff --git a/net/openvswitch/drop.h b/net/openvswitch/drop.h
index 3cd6489a5a2b..be51ff5039fb 100644
--- a/net/openvswitch/drop.h
+++ b/net/openvswitch/drop.h
@@ -10,6 +10,8 @@
 #define OVS_DROP_REASONS(R)			\
 	R(OVS_DROP_FLOW)		        \
 	R(OVS_DROP_ACTION_ERROR)		\
+	R(OVS_DROP_EXPLICIT_ACTION)		\
+	R(OVS_DROP_EXPLICIT_ACTION_ERROR)	\
 	/* deliberate comment for trailing \ */
 
 enum ovs_drop_reason {
diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index 41116361433d..88965e2068ac 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -38,6 +38,7 @@
 #include <net/tun_proto.h>
 #include <net/erspan.h>
 
+#include "drop.h"
 #include "flow_netlink.h"
 
 struct ovs_len_tbl {
@@ -61,6 +62,7 @@ static bool actions_may_change_flow(const struct nlattr *actions)
 		case OVS_ACTION_ATTR_RECIRC:
 		case OVS_ACTION_ATTR_TRUNC:
 		case OVS_ACTION_ATTR_USERSPACE:
+		case OVS_ACTION_ATTR_DROP:
 			break;
 
 		case OVS_ACTION_ATTR_CT:
@@ -2394,7 +2396,7 @@ static void ovs_nla_free_nested_actions(const struct nlattr *actions, int len)
 	/* Whenever new actions are added, the need to update this
 	 * function should be considered.
 	 */
-	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX != 23);
+	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX != 24);
 
 	if (!actions)
 		return;
@@ -3182,6 +3184,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 			[OVS_ACTION_ATTR_CHECK_PKT_LEN] = (u32)-1,
 			[OVS_ACTION_ATTR_ADD_MPLS] = sizeof(struct ovs_action_add_mpls),
 			[OVS_ACTION_ATTR_DEC_TTL] = (u32)-1,
+			[OVS_ACTION_ATTR_DROP] = sizeof(u32),
 		};
 		const struct ovs_action_push_vlan *vlan;
 		int type = nla_type(a);
@@ -3453,6 +3456,11 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 			skip_copy = true;
 			break;
 
+		case OVS_ACTION_ATTR_DROP:
+			if (!nla_is_last(a, rem))
+				return -EINVAL;
+			break;
+
 		default:
 			OVS_NLERR(log, "Unknown Action type %d", type);
 			return -EINVAL;
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 9c04e2ef425f..b5599a229ec8 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -301,6 +301,7 @@ class ovsactions(nla):
         ("OVS_ACTION_ATTR_CHECK_PKT_LEN", "none"),
         ("OVS_ACTION_ATTR_ADD_MPLS", "none"),
         ("OVS_ACTION_ATTR_DEC_TTL", "none"),
+        ("OVS_ACTION_ATTR_DROP", "uint32"),
     )
 
     class ctact(nla):
@@ -447,6 +448,8 @@ class ovsactions(nla):
                     print_str += "recirc(0x%x)" % int(self.get_attr(field[0]))
                 elif field[0] == "OVS_ACTION_ATTR_TRUNC":
                     print_str += "trunc(%d)" % int(self.get_attr(field[0]))
+                elif field[0] == "OVS_ACTION_ATTR_DROP":
+                    print_str += "drop"
             elif field[1] == "flag":
                 if field[0] == "OVS_ACTION_ATTR_CT_CLEAR":
                     print_str += "ct_clear"
-- 
2.41.0


