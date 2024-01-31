Return-Path: <netdev+bounces-67643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A55EC84468A
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 18:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23665B23115
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 17:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4BB12F590;
	Wed, 31 Jan 2024 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9X9MHg8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC5412DDAD
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723572; cv=none; b=gy5NQJsyEqyUHqEQ+axeooan9iFTEx61HL7RvxbPUe5xB0pIAQLkZroWAqXdiRIn2YJ+wgNCekTVgHarkSTPGufittwl2KKT5+jbH8UazfW1sXvTR64PPQ2pGTg475/umIGbMDA+Cvvq29MPWsT15p2scXcqYDUZKD9UdT81WU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723572; c=relaxed/simple;
	bh=kLf/Q9ZIoIeaKBi/0damf+ZeOBQhXeQUNr/Hvey+DGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsEyTk5xQALMtOxYXh+HEFQvU4DMLkx3uVuK4ENiJPllAJGeGdxbYnr7ZEOSER8YunUx11bncFv6UI0OtOeKdMfznoMMhiFw4okPTR2opCmG0ozprBO1TIb4pVi9WPVNJbXkhpPUC9wfgusdmadolKUe+3E7lsEJqaAPVVgCZzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9X9MHg8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706723569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YpOeKVqI0ILGtiMGt3955YtaEeWDHn2315Jhfo6mUSo=;
	b=Y9X9MHg8BtlZelNKkdvSSMDGoovjzr5rgKkkGlVA4aFjuUc1HAt6B6iP0kaP0am5ouWxU4
	BtPCZM8RNBsM4t3Ye2F7uk28cfJdlkqVqwRNJ5dH06zc+PdMxldc7V0Tn/YJXpLpdpnTeE
	GWpfjGo7rdV1GrISzOnAlfTuG+9ykUs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-auBgBLZlPwustRNd4XFW7A-1; Wed,
 31 Jan 2024 12:52:44 -0500
X-MC-Unique: auBgBLZlPwustRNd4XFW7A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F12A11C06909;
	Wed, 31 Jan 2024 17:52:42 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.202])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 534FE8B;
	Wed, 31 Jan 2024 17:52:41 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 1/3] selftests: net: cut more slack for gro fwd tests.
Date: Wed, 31 Jan 2024 18:52:27 +0100
Message-ID: <a3f6cb0da122d28f89f528bc36a4267ef36f4bce.1706723341.git.pabeni@redhat.com>
In-Reply-To: <cover.1706723341.git.pabeni@redhat.com>
References: <cover.1706723341.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

The udpgro_fwd.sh self-tests are somewhat unstable. There are
a few timing constraints the we struggle to meet on very slow
environments.

Instead of skipping the whole tests in such envs, increase the
test resilience WRT very slow hosts: increase the inter-packets
timeouts, avoid resetting the counters every second and finally
disable reduce the background traffic noise.

Tested with:

for I in $(seq 1 100); do
	./tools/testing/selftests/kselftest_install/run_kselftest.sh \
		-t net:udpgro_fwd.sh || exit -1
done

in a slow environment.

Fixes: a062260a9d5f ("selftests: net: add UDP GRO forwarding self-tests")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/udpgro_fwd.sh     | 14 ++++++++++++--
 tools/testing/selftests/net/udpgso_bench_rx.c |  2 +-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/udpgro_fwd.sh b/tools/testing/selftests/net/udpgro_fwd.sh
index d6b9c759043c..9cd5e885e91f 100755
--- a/tools/testing/selftests/net/udpgro_fwd.sh
+++ b/tools/testing/selftests/net/udpgro_fwd.sh
@@ -39,6 +39,10 @@ create_ns() {
 	for ns in $NS_SRC $NS_DST; do
 		ip netns add $ns
 		ip -n $ns link set dev lo up
+
+		# disable route solicitations to decrease 'noise' traffic
+		ip netns exec $ns sysctl -qw net.ipv6.conf.default.router_solicitations=0
+		ip netns exec $ns sysctl -qw net.ipv6.conf.all.router_solicitations=0
 	done
 
 	ip link add name veth$SRC type veth peer name veth$DST
@@ -80,6 +84,12 @@ create_vxlan_pair() {
 		create_vxlan_endpoint $BASE$ns veth$ns $BM_NET_V6$((3 - $ns)) vxlan6$ns 6
 		ip -n $BASE$ns addr add dev vxlan6$ns $OL_NET_V6$ns/24 nodad
 	done
+
+	# preload neighbur cache, do avoid some noisy traffic
+	local addr_dst=$(ip -j -n $BASE$DST link show dev vxlan6$DST  |jq -r '.[]["address"]')
+	local addr_src=$(ip -j -n $BASE$SRC link show dev vxlan6$SRC  |jq -r '.[]["address"]')
+	ip -n $BASE$DST neigh add dev vxlan6$DST lladdr $addr_src $OL_NET_V6$SRC
+	ip -n $BASE$SRC neigh add dev vxlan6$SRC lladdr $addr_dst $OL_NET_V6$DST
 }
 
 is_ipv6() {
@@ -119,7 +129,7 @@ run_test() {
 	# not enable GRO
 	ip netns exec $NS_DST $ipt -A INPUT -p udp --dport 4789
 	ip netns exec $NS_DST $ipt -A INPUT -p udp --dport 8000
-	ip netns exec $NS_DST ./udpgso_bench_rx -C 1000 -R 10 -n 10 -l 1300 $rx_args &
+	ip netns exec $NS_DST ./udpgso_bench_rx -C 2000 -R 100 -n 10 -l 1300 $rx_args &
 	local spid=$!
 	wait_local_port_listen "$NS_DST" 8000 udp
 	ip netns exec $NS_SRC ./udpgso_bench_tx $family -M 1 -s 13000 -S 1300 -D $dst
@@ -168,7 +178,7 @@ run_bench() {
 	# bind the sender and the receiver to different CPUs to try
 	# get reproducible results
 	ip netns exec $NS_DST bash -c "echo 2 > /sys/class/net/veth$DST/queues/rx-0/rps_cpus"
-	ip netns exec $NS_DST taskset 0x2 ./udpgso_bench_rx -C 1000 -R 10  &
+	ip netns exec $NS_DST taskset 0x2 ./udpgso_bench_rx -C 2000 -R 100  &
 	local spid=$!
 	wait_local_port_listen "$NS_DST" 8000 udp
 	ip netns exec $NS_SRC taskset 0x1 ./udpgso_bench_tx $family -l 3 -S 1300 -D $dst
diff --git a/tools/testing/selftests/net/udpgso_bench_rx.c b/tools/testing/selftests/net/udpgso_bench_rx.c
index f35a924d4a30..1cbadd267c96 100644
--- a/tools/testing/selftests/net/udpgso_bench_rx.c
+++ b/tools/testing/selftests/net/udpgso_bench_rx.c
@@ -375,7 +375,7 @@ static void do_recv(void)
 			do_flush_udp(fd);
 
 		tnow = gettimeofday_ms();
-		if (tnow > treport) {
+		if (!cfg_expected_pkt_nr && tnow > treport) {
 			if (packets)
 				fprintf(stderr,
 					"%s rx: %6lu MB/s %8lu calls/s\n",
-- 
2.43.0


