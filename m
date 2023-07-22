Return-Path: <netdev+bounces-20125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 333B375DB82
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 11:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D5B1C2111F
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 09:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A331D31C;
	Sat, 22 Jul 2023 09:42:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890141D2E3
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 09:42:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF6C90
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 02:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690018977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X0H27HUs/4N6894tkBGV+HMZ74Rlqaf1W5bXuDoUZCU=;
	b=dSfElebVDyiPVU+guelRYgY4D1IikwW9KtWIWf14yW78Dzj3SRKxpN72kLjs068LnrHRZJ
	7v/nSJg3VopknrnTZgX6oLcEAA27w60W0FdJoIKFuELee0LPNtTOZmMPzIP1sqwBeKV4SY
	pYtYzbX9fQXd4d0/Gx2CgIyPBbE2ZyI=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-Hi-M1hIpM5acUzZo_dgX-Q-1; Sat, 22 Jul 2023 05:42:55 -0400
X-MC-Unique: Hi-M1hIpM5acUzZo_dgX-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3592C38025FB;
	Sat, 22 Jul 2023 09:42:55 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.192.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ABDD840C6CCC;
	Sat, 22 Jul 2023 09:42:53 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	dev@openvswitch.org,
	aconole@redhat.com,
	i.maximets@ovn.org,
	eric@garver.life
Subject: [PATCH net-next 6/7] selftests: openvswitch: add drop reason testcase
Date: Sat, 22 Jul 2023 11:42:36 +0200
Message-ID: <20230722094238.2520044-7-amorenoz@redhat.com>
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


