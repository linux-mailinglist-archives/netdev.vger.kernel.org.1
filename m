Return-Path: <netdev+bounces-14667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233EE742E5F
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 22:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5399F1C20B5A
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 20:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CD112B62;
	Thu, 29 Jun 2023 20:31:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC1E23C8E
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 20:31:18 +0000 (UTC)
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Jun 2023 13:31:16 PDT
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41780213D
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 13:31:16 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244--k4yb8QzN_eDwI-TdIp0Ew-1; Thu, 29 Jun 2023 16:30:08 -0400
X-MC-Unique: -k4yb8QzN_eDwI-TdIp0Ew-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D98C11C07542;
	Thu, 29 Jun 2023 20:30:05 +0000 (UTC)
Received: from wsfd-netdev-vmhost.ntdv.lab.eng.bos.redhat.com (wsfd-netdev-vmhost.ntdv.lab.eng.bos.redhat.com [10.19.188.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B843DC00049;
	Thu, 29 Jun 2023 20:30:05 +0000 (UTC)
From: Eric Garver <eric@garver.life>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	Pravin B Shelar <pshelar@ovn.org>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net-next 1/2] net: openvswitch: add drop reasons
Date: Thu, 29 Jun 2023 16:30:04 -0400
Message-Id: <20230629203005.2137107-2-eric@garver.life>
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

These are counterparts to userspace's xlate_error values.

Signed-off-by: Eric Garver <eric@garver.life>
---
 include/net/dropreason.h   |  6 ++++++
 net/openvswitch/datapath.c | 17 +++++++++++++++++
 net/openvswitch/drop.h     | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 net/openvswitch/drop.h

diff --git a/include/net/dropreason.h b/include/net/dropreason.h
index 685fb37df8e8..653675bba758 100644
--- a/include/net/dropreason.h
+++ b/include/net/dropreason.h
@@ -23,6 +23,12 @@ enum skb_drop_reason_subsys {
 =09 */
 =09SKB_DROP_REASON_SUBSYS_MAC80211_MONITOR,
=20
+=09/**
+=09 * @SKB_DROP_REASON_SUBSYS_OPENVSWITCH: openvswitch drop reasons
+=09 * see net/openvswitch/drop.h
+=09 */
+=09SKB_DROP_REASON_SUBSYS_OPENVSWITCH,
+
 =09/** @SKB_DROP_REASON_SUBSYS_NUM: number of subsystems defined */
 =09SKB_DROP_REASON_SUBSYS_NUM
 };
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index a6d2a0b1aa21..4ebdc52856ab 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -48,6 +48,7 @@
 #include "openvswitch_trace.h"
 #include "vport-internal_dev.h"
 #include "vport-netdev.h"
+#include "drop.h"
=20
 unsigned int ovs_net_id __read_mostly;
=20
@@ -2702,6 +2703,18 @@ static struct pernet_operations ovs_net_ops =3D {
 =09.size =3D sizeof(struct ovs_net),
 };
=20
+static const char * const ovs_drop_reasons[] =3D {
+=09[0] =3D "OVS_XLATE_OK",
+#define S(x) #x,
+=09OVS_DROP_REASONS(S)
+#undef S
+};
+
+static struct drop_reason_list drop_reason_list_ovs =3D {
+=09.reasons =3D ovs_drop_reasons,
+=09.n_reasons =3D ARRAY_SIZE(ovs_drop_reasons),
+};
+
 static int __init dp_init(void)
 {
 =09int err;
@@ -2743,6 +2756,9 @@ static int __init dp_init(void)
 =09if (err < 0)
 =09=09goto error_unreg_netdev;
=20
+=09drop_reasons_register_subsys(SKB_DROP_REASON_SUBSYS_OPENVSWITCH,
+=09=09=09=09     &drop_reason_list_ovs);
+
 =09return 0;
=20
 error_unreg_netdev:
@@ -2769,6 +2785,7 @@ static void dp_cleanup(void)
 =09ovs_netdev_exit();
 =09unregister_netdevice_notifier(&ovs_dp_device_notifier);
 =09unregister_pernet_device(&ovs_net_ops);
+=09drop_reasons_unregister_subsys(SKB_DROP_REASON_SUBSYS_OPENVSWITCH);
 =09rcu_barrier();
 =09ovs_vport_exit();
 =09ovs_flow_exit();
diff --git a/net/openvswitch/drop.h b/net/openvswitch/drop.h
new file mode 100644
index 000000000000..787eda0083c1
--- /dev/null
+++ b/net/openvswitch/drop.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * openvswitch drop reason list
+ */
+
+#ifndef OPENVSWITCH_DROP_H
+#define OPENVSWITCH_DROP_H
+#include <net/dropreason.h>
+
+/* these are counterparts to userspace xlate_error */
+#define OVS_DROP_REASONS(R)                      \
+=09R(OVS_XLATE_BRIDGE_NOT_FOUND)            \
+=09R(OVS_XLATE_RECURSION_TOO_DEEP)          \
+=09R(OVS_XLATE_TOO_MANY_RESUBMITS)          \
+=09R(OVS_XLATE_STACK_TOO_DEEP)              \
+=09R(OVS_XLATE_NO_RECIRCULATION_CONTEXT)    \
+=09R(OVS_XLATE_RECIRCULATION_CONFLICT)      \
+=09R(OVS_XLATE_TOO_MANY_MPLS_LABELS)        \
+=09R(OVS_XLATE_INVALID_TUNNEL_METADATA)     \
+=09R(OVS_XLATE_UNSUPPORTED_PACKET_TYPE)     \
+=09R(OVS_XLATE_CONGESTION_DROP)             \
+=09R(OVS_XLATE_FORWARDING_DISABLED)         \
+=09/* deliberate comment for trailing \ */
+
+enum ovs_drop_reason {
+=09OVS_XLATE_OK =3D SKB_DROP_REASON_SUBSYS_OPENVSWITCH <<
+=09=09=09SKB_DROP_REASON_SUBSYS_SHIFT,
+#define ENUM(x) x,
+=09OVS_DROP_REASONS(ENUM)
+#undef ENUM
+=09OVS_XLATE_MAX,
+};
+
+#endif /* OPENVSWITCH_DROP_H */
--=20
2.39.0


