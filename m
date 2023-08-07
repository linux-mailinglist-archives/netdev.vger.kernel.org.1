Return-Path: <netdev+bounces-25036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1541C772B6F
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 18:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA9B1C20C0A
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 16:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AC712B97;
	Mon,  7 Aug 2023 16:46:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E687D12B68
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 16:46:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB6A172A
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 09:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691426766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X0H27HUs/4N6894tkBGV+HMZ74Rlqaf1W5bXuDoUZCU=;
	b=UIGbL/MHPzRQh1C0+Xlos0eeoMVQR7+Lh7QEeTqPrZIyhV6rILuE+tIPJjzWVI0rS1Rkso
	/nhASp8/RfZAWYk3W3fCMqSBE9zRDCkgi0Qw0bf8IofQ4b2uwGJlxNrCK+BUNu1FED+qU3
	XZcSCbxbYOj2D9F0LytCG97d1w8/+dI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-JNaXd5GJOEmMBwun2DOe8w-1; Mon, 07 Aug 2023 12:46:03 -0400
X-MC-Unique: JNaXd5GJOEmMBwun2DOe8w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCE41185A78F;
	Mon,  7 Aug 2023 16:46:02 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.194.141])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A09EE2166B25;
	Mon,  7 Aug 2023 16:46:01 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	aconole@redhat.com,
	i.maximets@ovn.org,
	eric@garver.life,
	dev@openvswitch.org
Subject: [net-next v3 6/7] selftests: openvswitch: add drop reason testcase
Date: Mon,  7 Aug 2023 18:45:47 +0200
Message-ID: <20230807164551.553365-7-amorenoz@redhat.com>
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

Test if the correct drop reason is reported when OVS drops a packet due
to an explicit flow.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 67 ++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index dced4f612a78..a10c345f40ef 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -16,7 +16,8 @@ tests="
 	connect_v4				ip4-xon: Basic ipv4 ping between two NS
 	nat_connect_v4				ip4-nat-xon: Basic ipv4 tcp connection via NAT
 	netlink_checks				ovsnl: validate netlink attrs and settings
-	upcall_interfaces			ovs: test the upcall interfaces"
+	upcall_interfaces			ovs: test the upcall interfaces
+	drop_reason				drop: test drop reasons are emitted"
 
 info() {
     [ $VERBOSE = 0 ] || echo $*
@@ -141,6 +142,25 @@ ovs_add_flow () {
 	return 0
 }
 
+ovs_drop_record_and_run () {
+	local sbx=$1
+	shift
+
+	perf record -a -q -e skb:kfree_skb -o ${ovs_dir}/perf.data $* \
+		>> ${ovs_dir}/stdout 2>> ${ovs_dir}/stderr
+	return $?
+}
+
+ovs_drop_reason_count()
+{
+	local reason=$1
+
+	local perf_output=`perf script -i ${ovs_dir}/perf.data -F trace:event,trace`
+	local pattern="skb:kfree_skb:.*reason: $reason"
+
+	return `echo "$perf_output" | grep "$pattern" | wc -l`
+}
+
 usage() {
 	echo
 	echo "$0 [OPTIONS] [TEST]..."
@@ -155,6 +175,51 @@ usage() {
 	exit 1
 }
 
+# drop_reason test
+# - drop packets and verify the right drop reason is reported
+test_drop_reason() {
+	which perf >/dev/null 2>&1 || return $ksft_skip
+
+	sbx_add "test_drop_reason" || return $?
+
+	ovs_add_dp "test_drop_reason" dropreason || return 1
+
+	info "create namespaces"
+	for ns in client server; do
+		ovs_add_netns_and_veths "test_drop_reason" "dropreason" "$ns" \
+			"${ns:0:1}0" "${ns:0:1}1" || return 1
+	done
+
+	# Setup client namespace
+	ip netns exec client ip addr add 172.31.110.10/24 dev c1
+	ip netns exec client ip link set c1 up
+
+	# Setup server namespace
+	ip netns exec server ip addr add 172.31.110.20/24 dev s1
+	ip netns exec server ip link set s1 up
+
+	# Allow ARP
+	ovs_add_flow "test_drop_reason" dropreason \
+		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
+	ovs_add_flow "test_drop_reason" dropreason \
+		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
+
+	# Allow client ICMP traffic but drop return path
+	ovs_add_flow "test_drop_reason" dropreason \
+		"in_port(1),eth(),eth_type(0x0800),ipv4(src=172.31.110.10,proto=1),icmp()" '2'
+	ovs_add_flow "test_drop_reason" dropreason \
+		"in_port(2),eth(),eth_type(0x0800),ipv4(src=172.31.110.20,proto=1),icmp()" 'drop'
+
+	ovs_drop_record_and_run "test_drop_reason" ip netns exec client ping -c 2 172.31.110.20
+	ovs_drop_reason_count 0x30001 # OVS_DROP_FLOW_ACTION
+	if [[ "$?" -ne "2" ]]; then
+		info "Did not detect expected drops: $?"
+		return 1
+	fi
+
+	return 0
+}
+
 # arp_ping test
 # - client has 1500 byte MTU
 # - server has 1500 byte MTU
-- 
2.41.0


