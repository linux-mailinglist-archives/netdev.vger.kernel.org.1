Return-Path: <netdev+bounces-26825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E1E77918D
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6038D1C20B91
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 14:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C697B2AB48;
	Fri, 11 Aug 2023 14:13:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7CE63B1
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 14:13:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E145A10E4
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 07:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691763216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CtV3e+HD9BoIlT79jMVbL1N6olCYOvPaKFweEyzLJQ8=;
	b=dQ3yWf+aihj8lVmDXzUCadRPVmTdwvC9eRKCEGg0iqvaijaA9isfzvOR4lJVefUuFAoXZ+
	IF0Lh5Jh1RnHqbJVusAmP81WVdWrDMgEWTlZd5vQ+/n3o8NVROJcR43S4PZmv3kQ6wabbe
	WtwQELlMM+xp1Q1GzNmVhL7rkHSPtos=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-rT-uie-gOO-DdV4IWX-WvQ-1; Fri, 11 Aug 2023 10:13:32 -0400
X-MC-Unique: rT-uie-gOO-DdV4IWX-WvQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7769B185A78F;
	Fri, 11 Aug 2023 14:13:32 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.192.142])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 321091121314;
	Fri, 11 Aug 2023 14:13:31 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	aconole@redhat.com,
	i.maximets@ovn.org,
	eric@garver.life,
	dev@openvswitch.org
Subject: [net-next v5 7/7] selftests: openvswitch: add explicit drop testcase
Date: Fri, 11 Aug 2023 16:12:54 +0200
Message-ID: <20230811141255.4103827-8-amorenoz@redhat.com>
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
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Test explicit drops generate the right drop reason. Also, verify that
the kernel rejects flows with actions following an explicit drop.

Acked-by: Aaron Conole <aconole@redhat.com>
Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index a10c345f40ef..9c2012d70b08 100755
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
 
@@ -458,6 +483,16 @@ test_netlink_checks () {
 	    wc -l) == 2 ] || \
 	      return 1
 
+	ERR_MSG="Flow actions may not be safe on all matching packets"
+	PRE_TEST=$(dmesg | grep -c "${ERR_MSG}")
+	ovs_add_flow "test_netlink_checks" nv0 \
+		'in_port(1),eth(),eth_type(0x0806),arp()' 'drop(0),2' \
+		&> /dev/null && return 1
+	POST_TEST=$(dmesg | grep -c "${ERR_MSG}")
+	if [ "$PRE_TEST" == "$POST_TEST" ]; then
+		info "failed - error not generated"
+		return 1
+	fi
 	return 0
 }
 
-- 
2.41.0


