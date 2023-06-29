Return-Path: <netdev+bounces-14669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDCC742E67
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 22:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0641C20B5A
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 20:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF05171D1;
	Thu, 29 Jun 2023 20:32:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF658171CC
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 20:32:03 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC3E30DF
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 13:32:01 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-VV3UmycvMBqzWEaIfccp4Q-1; Thu, 29 Jun 2023 16:30:08 -0400
X-MC-Unique: VV3UmycvMBqzWEaIfccp4Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E7FC1C07546;
	Thu, 29 Jun 2023 20:30:06 +0000 (UTC)
Received: from wsfd-netdev-vmhost.ntdv.lab.eng.bos.redhat.com (wsfd-netdev-vmhost.ntdv.lab.eng.bos.redhat.com [10.19.188.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E138CC00049;
	Thu, 29 Jun 2023 20:30:05 +0000 (UTC)
From: Eric Garver <eric@garver.life>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	Pravin B Shelar <pshelar@ovn.org>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net-next 2/2] net: openvswitch: add drop action
Date: Thu, 29 Jun 2023 16:30:05 -0400
Message-Id: <20230629203005.2137107-3-eric@garver.life>
In-Reply-To: <20230629203005.2137107-1-eric@garver.life>
References: <20230629203005.2137107-1-eric@garver.life>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: garver.life
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,FROM_SUSPICIOUS_NTLD,
	RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This adds an explicit drop action. This is used by OVS to drop packets
for which it cannot determine what to do. An explicit action in the
kernel allows passing the reason _why_ the packet is being dropped. We
can then use perf tracing to match on the drop reason.

e.g. trace all OVS dropped skbs

 # perf trace -e skb:kfree_skb --filter=3D"reason >=3D 0x30000"
 [..]
 106.023 ping/2465 skb:kfree_skb(skbaddr: 0xffffa0e8765f2000, \
  location:0xffffffffc0d9b462, protocol: 2048, reason: 196610)

reason: 196610 --> 0x30002 (OVS_XLATE_RECURSION_TOO_DEEP)

Signed-off-by: Eric Garver <eric@garver.life>
---
 include/uapi/linux/openvswitch.h                    |  2 ++
 net/openvswitch/actions.c                           | 13 +++++++++++++
 net/openvswitch/flow_netlink.c                      | 12 +++++++++++-
 .../testing/selftests/net/openvswitch/ovs-dpctl.py  |  3 +++
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswi=
tch.h
index e94870e77ee9..a967dbca3574 100644
--- a/include/uapi/linux/openvswitch.h
+++ b/include/uapi/linux/openvswitch.h
@@ -965,6 +965,7 @@ struct check_pkt_len_arg {
  * start of the packet or at the start of the l3 header depending on the v=
alue
  * of l3 tunnel flag in the tun_flags field of OVS_ACTION_ATTR_ADD_MPLS
  * argument.
+ * @OVS_ACTION_ATTR_DROP: Explicit drop action.
  *
  * Only a single header can be set with a single %OVS_ACTION_ATTR_SET.  No=
t all
  * fields within a header are modifiable, e.g. the IPv4 protocol and fragm=
ent
@@ -1002,6 +1003,7 @@ enum ovs_action_attr {
 =09OVS_ACTION_ATTR_CHECK_PKT_LEN, /* Nested OVS_CHECK_PKT_LEN_ATTR_*. */
 =09OVS_ACTION_ATTR_ADD_MPLS,     /* struct ovs_action_add_mpls. */
 =09OVS_ACTION_ATTR_DEC_TTL,      /* Nested OVS_DEC_TTL_ATTR_*. */
+=09OVS_ACTION_ATTR_DROP,         /* u32 xlate_error. */
=20
 =09__OVS_ACTION_ATTR_MAX,=09      /* Nothing past this will be accepted
 =09=09=09=09       * from userspace. */
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index cab1e02b63e0..4ad9a45dc042 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -32,6 +32,7 @@
 #include "vport.h"
 #include "flow_netlink.h"
 #include "openvswitch_trace.h"
+#include "drop.h"
=20
 struct deferred_action {
 =09struct sk_buff *skb;
@@ -1477,6 +1478,18 @@ static int do_execute_actions(struct datapath *dp, s=
truct sk_buff *skb,
 =09=09=09=09return dec_ttl_exception_handler(dp, skb,
 =09=09=09=09=09=09=09=09 key, a);
 =09=09=09break;
+
+=09=09case OVS_ACTION_ATTR_DROP:
+=09=09=09u32 reason =3D nla_get_u32(a);
+
+=09=09=09reason |=3D SKB_DROP_REASON_SUBSYS_OPENVSWITCH <<
+=09=09=09=09=09SKB_DROP_REASON_SUBSYS_SHIFT;
+
+=09=09=09if (reason =3D=3D OVS_XLATE_OK)
+=09=09=09=09break;
+
+=09=09=09kfree_skb_reason(skb, reason);
+=09=09=09return 0;
 =09=09}
=20
 =09=09if (unlikely(err)) {
diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.=
c
index 41116361433d..23d39eae9a0d 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -39,6 +39,7 @@
 #include <net/erspan.h>
=20
 #include "flow_netlink.h"
+#include "drop.h"
=20
 struct ovs_len_tbl {
 =09int len;
@@ -61,6 +62,7 @@ static bool actions_may_change_flow(const struct nlattr *=
actions)
 =09=09case OVS_ACTION_ATTR_RECIRC:
 =09=09case OVS_ACTION_ATTR_TRUNC:
 =09=09case OVS_ACTION_ATTR_USERSPACE:
+=09=09case OVS_ACTION_ATTR_DROP:
 =09=09=09break;
=20
 =09=09case OVS_ACTION_ATTR_CT:
@@ -2394,7 +2396,7 @@ static void ovs_nla_free_nested_actions(const struct =
nlattr *actions, int len)
 =09/* Whenever new actions are added, the need to update this
 =09 * function should be considered.
 =09 */
-=09BUILD_BUG_ON(OVS_ACTION_ATTR_MAX !=3D 23);
+=09BUILD_BUG_ON(OVS_ACTION_ATTR_MAX !=3D 24);
=20
 =09if (!actions)
 =09=09return;
@@ -3182,6 +3184,7 @@ static int __ovs_nla_copy_actions(struct net *net, co=
nst struct nlattr *attr,
 =09=09=09[OVS_ACTION_ATTR_CHECK_PKT_LEN] =3D (u32)-1,
 =09=09=09[OVS_ACTION_ATTR_ADD_MPLS] =3D sizeof(struct ovs_action_add_mpls)=
,
 =09=09=09[OVS_ACTION_ATTR_DEC_TTL] =3D (u32)-1,
+=09=09=09[OVS_ACTION_ATTR_DROP] =3D sizeof(u32),
 =09=09};
 =09=09const struct ovs_action_push_vlan *vlan;
 =09=09int type =3D nla_type(a);
@@ -3453,6 +3456,13 @@ static int __ovs_nla_copy_actions(struct net *net, c=
onst struct nlattr *attr,
 =09=09=09skip_copy =3D true;
 =09=09=09break;
=20
+=09=09case OVS_ACTION_ATTR_DROP:
+=09=09=09if (nla_get_u32(a) >=3D
+=09=09=09    u32_get_bits(OVS_XLATE_MAX,
+=09=09=09=09=09 ~SKB_DROP_REASON_SUBSYS_MASK))
+=09=09=09=09return -EINVAL;
+=09=09=09break;
+
 =09=09default:
 =09=09=09OVS_NLERR(log, "Unknown Action type %d", type);
 =09=09=09return -EINVAL;
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/t=
esting/selftests/net/openvswitch/ovs-dpctl.py
index 1c8b36bc15d4..526ebad7d514 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -115,6 +115,7 @@ class ovsactions(nla):
         ("OVS_ACTION_ATTR_CHECK_PKT_LEN", "none"),
         ("OVS_ACTION_ATTR_ADD_MPLS", "none"),
         ("OVS_ACTION_ATTR_DEC_TTL", "none"),
+        ("OVS_ACTION_ATTR_DROP", "uint32"),
     )
=20
     class ctact(nla):
@@ -261,6 +262,8 @@ class ovsactions(nla):
                     print_str +=3D "recirc(0x%x)" % int(self.get_attr(fiel=
d[0]))
                 elif field[0] =3D=3D "OVS_ACTION_ATTR_TRUNC":
                     print_str +=3D "trunc(%d)" % int(self.get_attr(field[0=
]))
+                elif field[0] =3D=3D "OVS_ACTION_ATTR_DROP":
+                    print_str +=3D "drop"
             elif field[1] =3D=3D "flag":
                 if field[0] =3D=3D "OVS_ACTION_ATTR_CT_CLEAR":
                     print_str +=3D "ct_clear"
--=20
2.39.0


