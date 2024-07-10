Return-Path: <netdev+bounces-110527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CDE92CDDF
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 11:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91331C22BAF
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 09:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C9F18F2EC;
	Wed, 10 Jul 2024 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6i/T4HN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E60A18EA9E
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720602314; cv=none; b=bnyKvxyRc9iHUYYOkGJvO6RrYQUb/0hrX3mlV3QaGVxW3cwC8ttZ2eVBgDC/BHeg4oXJpWLB1nvpuTOho6EXLAx41k0KYbbcHsRW1TFhs1SXCoB8BsdoHnNj/lG+QX/texojmVtAH9hUjjEnPq5ZMHIxjTxDMOOLerZy3/zYBvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720602314; c=relaxed/simple;
	bh=PBIpta0YjOKEnNozLsSWGsjK6vJDUcH8zexdl5Nhcxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TKqS/LWWQN1U0BvhLL0zjitnOrDk6dNdh9kSH+xmsd1VTyIHXG8/a8LniOp04kSQKusS/AHA1+14bxOKwI25JEgyFD7+YRge2gcVR/hPEKOc0a6eK9xoTy991yxWj7fAPJ1zgpyUx9ytb3HTKNmCodVYdbiScBuzcTVDoRVV5dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R6i/T4HN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720602311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Lo9HjTqXg+zsuHsAZC/cmPCTHvmkkLcTQoYiizXM1HQ=;
	b=R6i/T4HNm4lLSHg985dcTmb1XSfLgcnhQmITsj0IVA/ibACOUB4ITxUcYRnD3GY8qkuRb3
	QWI8f4qpfS/zLFTckHOp1rsevyQrlOisZE2s0bKUfwcdRocDB4RszmJetM2/6Bv00q5tmQ
	8M2ZtIqudA7CDLkVuUXxNAjvR/6SElM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-zbX3YZPhOjaKYtuR5Kmb6g-1; Wed,
 10 Jul 2024 05:05:08 -0400
X-MC-Unique: zbX3YZPhOjaKYtuR5Kmb6g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75FAC19560AA;
	Wed, 10 Jul 2024 09:05:06 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.192.91])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DCE313000181;
	Wed, 10 Jul 2024 09:05:02 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] selftests: openvswitch: retry instead of sleep
Date: Wed, 10 Jul 2024 11:04:59 +0200
Message-ID: <20240710090500.1655212-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

There are a couple of places where the test script "sleep"s to wait for
some external condition to be met.

This is error prone, specially in slow systems (identified in CI by
"KSFT_MACHINE_SLOW=yes").

To fix this, add a "ovs_wait" function that tries to execute a command
a few times until it succeeds. The timeout used is set to 5s for
"normal" systems and doubled if a slow CI machine is detected.

This should make the following work:

$ vng --build  \
    --config tools/testing/selftests/net/config \
    --config kernel/configs/debug.config

$ vng --run . --user root -- "make -C tools/testing/selftests/ \
    KSFT_MACHINE_SLOW=yes TARGETS=net/openvswitch run_tests"

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 45 +++++++++++++++----
 .../selftests/net/openvswitch/ovs-dpctl.py    |  1 +
 2 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index bc71dbc18b21..cc0bfae2bafa 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -11,6 +11,11 @@ ksft_skip=4
 PAUSE_ON_FAIL=no
 VERBOSE=0
 TRACING=0
+WAIT_TIMEOUT=5
+
+if test "X$KSFT_MACHINE_SLOW" == "Xyes"; then
+	WAIT_TIMEOUT=10
+fi
 
 tests="
 	arp_ping				eth-arp: Basic arp ping between two NS
@@ -29,6 +34,30 @@ info() {
 	[ $VERBOSE = 0 ] || echo $*
 }
 
+ovs_wait() {
+	info "waiting $WAIT_TIMEOUT s for: $@"
+
+	if "$@" ; then
+		info "wait succeeded immediately"
+		return 0
+	fi
+
+	# A quick re-check helps speed up small races in fast systems.
+	# However, fractional sleeps might not necessarily work.
+	local start=0
+	sleep 0.1 || { sleep 1; start=1; }
+
+	for (( i=start; i<WAIT_TIMEOUT; i++ )); do
+		if "$@" ; then
+			info "wait succeeded after $i seconds"
+			return 0
+		fi
+		sleep 1
+	done
+	info "wait failed after $i seconds"
+	return 1
+}
+
 ovs_base=`pwd`
 sbxs=
 sbx_add () {
@@ -278,20 +307,19 @@ test_psample() {
 
 	# Record psample data.
 	ovs_spawn_daemon "test_psample" python3 $ovs_base/ovs-dpctl.py psample-events
+	ovs_wait grep -q "listening for psample events" ${ovs_dir}/stdout
 
 	# Send a single ping.
-	sleep 1
 	ovs_sbx "test_psample" ip netns exec client ping -I c1 172.31.110.20 -c 1 || return 1
-	sleep 1
 
 	# We should have received one userspace action upcall and 2 psample packets.
-	grep -E "userspace action command" $ovs_dir/s0.out >/dev/null 2>&1 || return 1
+	ovs_wait grep -q "userspace action command" $ovs_dir/s0.out || return 1
 
 	# client -> server samples should only contain the first 14 bytes of the packet.
-	grep -E "rate:4294967295,group:1,cookie:c0ffee data:[0-9a-f]{28}$" \
-			 $ovs_dir/stdout >/dev/null 2>&1 || return 1
-	grep -E "rate:4294967295,group:2,cookie:eeff0c" \
-			 $ovs_dir/stdout >/dev/null 2>&1 || return 1
+	ovs_wait grep -qE "rate:4294967295,group:1,cookie:c0ffee data:[0-9a-f]{28}$" \
+		$ovs_dir/stdout || return 1
+
+	ovs_wait grep -q "rate:4294967295,group:2,cookie:eeff0c" $ovs_dir/stdout || return 1
 
 	return 0
 }
@@ -711,7 +739,8 @@ test_upcall_interfaces() {
 	ovs_add_netns_and_veths "test_upcall_interfaces" ui0 upc left0 l0 \
 	    172.31.110.1/24 -u || return 1
 
-	sleep 1
+	ovs_wait grep -q "listening on upcall packet handler" ${ovs_dir}/left0.out
+
 	info "sending arping"
 	ip netns exec upc arping -I l0 172.31.110.20 -c 1 \
 	    >$ovs_dir/arping.stdout 2>$ovs_dir/arping.stderr
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 1e15b0818074..8a0396bfaf99 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -2520,6 +2520,7 @@ class PsampleEvent(EventSocket):
     marshal_class = psample_msg
 
     def read_samples(self):
+        print("listening for psample events", flush=True)
         while True:
             try:
                 for msg in self.get():
-- 
2.45.2


