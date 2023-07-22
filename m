Return-Path: <netdev+bounces-20127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E4975DB84
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 11:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373542823F9
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 09:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9362E18AE2;
	Sat, 22 Jul 2023 09:43:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ED41EA9B
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 09:43:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751049B
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 02:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690018981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ph718/SVn7g3NMKG2TQpwCyQXByESErmZlHp/XZ8kjM=;
	b=ZlbRI19S6waeWAs10U13ZZ8GM1xew2RfzQ4ZxnkfQ3gVUsxU9cK1VUI7x8oBMZdotrhjhR
	85tWZx9ywKFkIA+NGlcIX4ReqwXP9dlOESi70DsS6vLbEEABBZsUwqgmpQqMIgQiZYEnSX
	Rxcs7FUM5lJucjIrFOjJeZFkwAmEpM0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-QwMAsHHOODqnDePiVTWiOQ-1; Sat, 22 Jul 2023 05:42:57 -0400
X-MC-Unique: QwMAsHHOODqnDePiVTWiOQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6368E800FF1;
	Sat, 22 Jul 2023 09:42:57 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.192.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9EFDC40C6F4C;
	Sat, 22 Jul 2023 09:42:55 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	dev@openvswitch.org,
	aconole@redhat.com,
	i.maximets@ovn.org,
	eric@garver.life
Subject: [PATCH net-next 7/7] selftests: openvswitch: add explicit drop testcase
Date: Sat, 22 Jul 2023 11:42:37 +0200
Message-ID: <20230722094238.2520044-8-amorenoz@redhat.com>
In-Reply-To: <20230722094238.2520044-1-amorenoz@redhat.com>
References: <20230722094238.2520044-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Make ovs-dpctl.py support explicit drops as:
"drop" -> implicit empty-action drop
"drop(0)" -> explicit non-error action drop
"drop(42)" -> explicit error action drop

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 25 +++++++++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 18 ++++++++++---
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index a10c345f40ef..398a69f1c923 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -217,6 +217,31 @@ test_drop_reason() {
 		return 1
 	fi
 
+	# Drop UDP 6000 traffic with an explicit action and an error code.
+	ovs_add_flow "test_drop_reason" dropreason \
+		"in_port(1),eth(),eth_type(0x0800),ipv4(src=172.31.110.10,proto=17),udp(dst=6000)" \
+                'drop(42)'
+	# Drop UDP 7000 traffic with an explicit action with no error code.
+	ovs_add_flow "test_drop_reason" dropreason \
+		"in_port(1),eth(),eth_type(0x0800),ipv4(src=172.31.110.10,proto=17),udp(dst=7000)" \
+                'drop(0)'
+
+	ovs_drop_record_and_run \
+            "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 6000
+	ovs_drop_reason_count 0x30003 # OVS_DROP_EXPLICIT_ACTION_ERROR
+	if [[ "$?" -ne "1" ]]; then
+		info "Did not detect expected explicit error drops: $?"
+		return 1
+	fi
+
+	ovs_drop_record_and_run \
+            "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 7000
+	ovs_drop_reason_count 0x30002 # OVS_DROP_EXPLICIT_ACTION
+	if [[ "$?" -ne "1" ]]; then
+		info "Did not detect expected explicit drops: $?"
+		return 1
+	fi
+
 	return 0
 }
 
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 0bc944f36e02..de6db59ab115 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -448,7 +448,7 @@ class ovsactions(nla):
                 elif field[0] == "OVS_ACTION_ATTR_TRUNC":
                     print_str += "trunc(%d)" % int(self.get_attr(field[0]))
                 elif field[0] == "OVS_ACTION_ATTR_DROP":
-                    print_str += "drop"
+                    print_str += "drop(%d)" % int(self.get_attr(field[0]))
             elif field[1] == "flag":
                 if field[0] == "OVS_ACTION_ATTR_CT_CLEAR":
                     print_str += "ct_clear"
@@ -470,9 +470,19 @@ class ovsactions(nla):
         parsed = False
         while len(actstr) != 0:
             if actstr.startswith("drop"):
-                # for now, drops have no explicit action, so we
-                # don't need to set any attributes.  The final
-                # act of the processing chain will just drop the packet
+                # If no reason is provided, the implicit drop is used (i.e no
+                # action). If some reason is given, an explicit action is used.
+                actstr, reason = parse_extract_field(
+                    actstr,
+                    "drop(",
+                    "([0-9]+)",
+                    lambda x: int(x, 0),
+                    False,
+                    None,
+                )
+                if reason is not None:
+                    self["attrs"].append(["OVS_ACTION_ATTR_DROP", reason])
+
                 return
 
             elif parse_starts_block(actstr, "^(\d+)", False, True):
-- 
2.41.0


