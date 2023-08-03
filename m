Return-Path: <netdev+bounces-24128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 120EE76EE12
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 17:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF332821BE
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C912E23BFE;
	Thu,  3 Aug 2023 15:27:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE90F23BF4
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 15:27:13 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC7D35A6
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:27:12 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qRaEI-00067G-M7; Thu, 03 Aug 2023 17:27:10 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: sbrivio@redhat.com,
	"David S. Miller" <davem@davemloft.net>,
	dsahern@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	shuah@kernel.org,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net 2/2] selftests: net: test vxlan pmtu exceptions with tcp
Date: Thu,  3 Aug 2023 17:26:50 +0200
Message-ID: <20230803152653.29535-3-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803152653.29535-1-fw@strlen.de>
References: <20230803152653.29535-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

TCP might get stuck if a nonlinear skb exceeds the path MTU,
icmp error contains an incorrect icmp checksum in that case.

Extend the existing test for vxlan to also send at least 1MB worth of
data via TCP in addition to the existing 'large icmp packet adds
route exception'.

On my test VM this fails due to 0-size output file without
"tunnels: fix kasan splat when generating ipv4 pmtu error".

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tools/testing/selftests/net/pmtu.sh | 35 +++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index dfe3d287f01d..f838dd370f6a 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -361,6 +361,7 @@ err_buf=
 tcpdump_pids=
 nettest_pids=
 socat_pids=
+tmpoutfile=
 
 err() {
 	err_buf="${err_buf}${1}
@@ -951,6 +952,7 @@ cleanup() {
 	ip link del veth_A-R1			2>/dev/null
 	ovs-vsctl --if-exists del-port vxlan_a	2>/dev/null
 	ovs-vsctl --if-exists del-br ovs_br0	2>/dev/null
+	rm -f "$tmpoutfile"
 }
 
 mtu() {
@@ -1328,6 +1330,39 @@ test_pmtu_ipvX_over_bridged_vxlanY_or_geneveY_exception() {
 	check_pmtu_value ${exp_mtu} "${pmtu}" "exceeding link layer MTU on bridged ${type} interface"
 	pmtu="$(route_get_dst_pmtu_from_exception "${ns_a}" ${dst})"
 	check_pmtu_value ${exp_mtu} "${pmtu}" "exceeding link layer MTU on locally bridged ${type} interface"
+
+	tmpoutfile=$(mktemp)
+
+	# Flush Exceptions, retry with TCP
+	run_cmd ${ns_a} ip route flush cached ${dst}
+	run_cmd ${ns_b} ip route flush cached ${dst}
+	run_cmd ${ns_c} ip route flush cached ${dst}
+
+	for target in "${ns_a}" "${ns_c}" ; do
+		if [ ${family} -eq 4 ]; then
+			TCPDST=TCP:${dst}:50000
+		else
+			TCPDST="TCP:[${dst}]:50000"
+		fi
+		${ns_b} socat -T 3 -u -6 TCP-LISTEN:50000 STDOUT > $tmpoutfile &
+
+		sleep 1
+
+		dd if=/dev/zero of=/dev/stdout status=none bs=1M count=1 | ${target} socat -T 3 -u STDIN $TCPDST,connect-timeout=3
+
+		size=$(du -sb $tmpoutfile)
+		size=${size%%/tmp/*}
+
+		[ $size -ne 1048576 ] && err "File size $size mismatches exepcted value in locally bridged vxlan test" && return 1
+	done
+
+	rm -f "$tmpoutfile"
+
+	# Check that exceptions were created
+	pmtu="$(route_get_dst_pmtu_from_exception "${ns_c}" ${dst})"
+	check_pmtu_value ${exp_mtu} "${pmtu}" "tcp: exceeding link layer MTU on bridged ${type} interface"
+	pmtu="$(route_get_dst_pmtu_from_exception "${ns_a}" ${dst})"
+	check_pmtu_value ${exp_mtu} "${pmtu}" "tcp exceeding link layer MTU on locally bridged ${type} interface"
 }
 
 test_pmtu_ipv4_br_vxlan4_exception() {
-- 
2.41.0


