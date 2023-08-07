Return-Path: <netdev+bounces-25034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A5F772B6B
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 18:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF8E281489
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 16:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9981B111A9;
	Mon,  7 Aug 2023 16:46:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8848A12B70
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 16:46:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14C5171A
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 09:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691426766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sgJc+Ydiz+sqobUMkAvt15bRS6zdVV4EnXl70OBHUdk=;
	b=JFPDxsWPVMxChyUED//1kAf+tACSxWSmgsM+GZBzzBAuJ/Gc0pASGVcmk0j3sdOIG4zZ9O
	ZuXtGQDDYk+/ySzrP4fzMljvPWsNkSwZt7aEgoNwOZ/XGEEoZZxYob1nLJEyLDJdkYQtzj
	gsHviGW3JhzlrIF5ki4lkqT3ybOMxn0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-AGmgCRqoMwCVlenDBSbekA-1; Mon, 07 Aug 2023 12:46:04 -0400
X-MC-Unique: AGmgCRqoMwCVlenDBSbekA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 471E0101A52E;
	Mon,  7 Aug 2023 16:46:04 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.194.141])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1CECC2166B25;
	Mon,  7 Aug 2023 16:46:02 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	aconole@redhat.com,
	i.maximets@ovn.org,
	eric@garver.life,
	dev@openvswitch.org
Subject: [net-next v3 7/7] selftests: openvswitch: add explicit drop testcase
Date: Mon,  7 Aug 2023 18:45:48 +0200
Message-ID: <20230807164551.553365-8-amorenoz@redhat.com>
In-Reply-To: <20230807164551.553365-1-amorenoz@redhat.com>
References: <20230807164551.553365-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Make ovs-dpctl.py support explicit drops as:
"drop" -> implicit empty-action drop
"drop(0)" -> explicit non-error action drop
"drop(42)" -> explicit error action drop

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 25 +++++++++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 21 ++++++++++++----
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index a10c345f40ef..c568ba1b7900 100755
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
+	ovs_drop_reason_count 0x30004 # OVS_DROP_EXPLICIT_ACTION_ERROR
+	if [[ "$?" -ne "1" ]]; then
+		info "Did not detect expected explicit error drops: $?"
+		return 1
+	fi
+
+	ovs_drop_record_and_run \
+            "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 7000
+	ovs_drop_reason_count 0x30003 # OVS_DROP_EXPLICIT_ACTION
+	if [[ "$?" -ne "1" ]]; then
+		info "Did not detect expected explicit drops: $?"
+		return 1
+	fi
+
 	return 0
 }
 
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 5fee330050c2..912dc8c49085 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -449,7 +449,7 @@ class ovsactions(nla):
                 elif field[0] == "OVS_ACTION_ATTR_TRUNC":
                     print_str += "trunc(%d)" % int(self.get_attr(field[0]))
                 elif field[0] == "OVS_ACTION_ATTR_DROP":
-                    print_str += "drop"
+                    print_str += "drop(%d)" % int(self.get_attr(field[0]))
             elif field[1] == "flag":
                 if field[0] == "OVS_ACTION_ATTR_CT_CLEAR":
                     print_str += "ct_clear"
@@ -471,10 +471,21 @@ class ovsactions(nla):
         while len(actstr) != 0:
             parsed = False
             if actstr.startswith("drop"):
-                # for now, drops have no explicit action, so we
-                # don't need to set any attributes.  The final
-                # act of the processing chain will just drop the packet
-                return
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
+                    parsed = True
+                else:
+                    return
 
             elif parse_starts_block(actstr, "^(\d+)", False, True):
                 actstr, output = parse_extract_field(
-- 
2.41.0


