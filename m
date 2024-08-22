Return-Path: <netdev+bounces-121002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F3995B640
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA21AB22F82
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349E51CB12E;
	Thu, 22 Aug 2024 13:17:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58FA26AC1
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332647; cv=none; b=tAKj1zqqCSz2Nm4vzK3pxYd8ZA511dAkjxmx41h5lwsskSpttEBmlRsm1+nf6SVV0yNrlnlQh3z5yvl7tiQCsc3N7uhxEDG2gNNDPBiD+/uCYyLEcfCXVFBdfF5Os5gduwlm56+Yoepea0J5NlilAMlIUENapmW67wOrZFTF6Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332647; c=relaxed/simple;
	bh=DNBuh+2h2HIr5XhifteUj0DOGeQUWo2ENokE9fiHD7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVtb/pQKU0p8zZuYvd+m8J8vx3epbh0aZ3XMQ/MciUOrSavBQDVTksZY2Ek95Ryv/2pSwN3jjGZf+xrarCk/s8wHyehHhyujq7FhQsTVM8afP5eFeoJz7juAecne7mrFxOp4OH1ieIYJ4EpN0/J6guaXnD7nT7a0CPIUL73RKOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sh7go-0006on-8S; Thu, 22 Aug 2024 15:17:22 +0200
From: Florian Westphal <fw@strlen.de>
To: netdev@vger.kernel.org
Cc: herbert@gondor.apana.org.au,
	steffen.klassert@secunet.com,
	noel@familie-kuntze.de,
	tobias@strongswan.org,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH ipsec-next 1/4] selftests: add xfrm policy insertion speed test script
Date: Thu, 22 Aug 2024 15:04:29 +0200
Message-ID: <20240822130643.5808-2-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240822130643.5808-1-fw@strlen.de>
References: <20240822130643.5808-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nothing special, just test how long insertion of x policies takes.
This should ideally show linear insertion speeds.

Do not run this by default, it has little value, but it can be useful to
check for insertion speed chahnges when altering the xfrm policy db
implementation.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tools/testing/selftests/net/Makefile          |  2 +-
 .../selftests/net/xfrm_policy_add_speed.sh    | 83 +++++++++++++++++++
 2 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/xfrm_policy_add_speed.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 8eaffd7a641c..e127a80ff713 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -56,7 +56,7 @@ TEST_PROGS += ip_local_port_range.sh
 TEST_PROGS += rps_default_mask.sh
 TEST_PROGS += big_tcp.sh
 TEST_PROGS += netns-sysctl.sh
-TEST_PROGS_EXTENDED := toeplitz_client.sh toeplitz.sh
+TEST_PROGS_EXTENDED := toeplitz_client.sh toeplitz.sh xfrm_policy_add_speed.sh
 TEST_GEN_FILES =  socket nettest
 TEST_GEN_FILES += psock_fanout psock_tpacket msg_zerocopy reuseport_addr_any
 TEST_GEN_FILES += tcp_mmap tcp_inq psock_snd txring_overwrite
diff --git a/tools/testing/selftests/net/xfrm_policy_add_speed.sh b/tools/testing/selftests/net/xfrm_policy_add_speed.sh
new file mode 100755
index 000000000000..2fab29d3cb91
--- /dev/null
+++ b/tools/testing/selftests/net/xfrm_policy_add_speed.sh
@@ -0,0 +1,83 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+source lib.sh
+
+timeout=4m
+ret=0
+tmp=$(mktemp)
+cleanup() {
+	cleanup_all_ns
+	rm -f "$tmp"
+}
+
+trap cleanup EXIT
+
+maxpolicies=100000
+[ "$KSFT_MACHINE_SLOW" = "yes" ] && maxpolicies=10000
+
+do_dummies4() {
+	local dir="$1"
+	local max="$2"
+
+	local policies
+	local pfx
+	pfx=30
+	policies=0
+
+	ip netns exec "$ns" ip xfrm policy flush
+
+	for i in $(seq 1 100);do
+		local s
+		local d
+		for j in $(seq 1 255);do
+			s=$((i+0))
+			d=$((i+100))
+
+			for a in $(seq 1 8 255); do
+				policies=$((policies+1))
+				[ "$policies" -gt "$max" ] && return
+				echo xfrm policy add src 10.$s.$j.0/30 dst 10.$d.$j.$a/$pfx dir $dir action block
+			done
+			for a in $(seq 1 8 255); do
+				policies=$((policies+1))
+				[ "$policies" -gt "$max" ] && return
+				echo xfrm policy add src 10.$s.$j.$a/30 dst 10.$d.$j.0/$pfx dir $dir action block
+			done
+		done
+	done
+}
+
+setup_ns ns
+
+do_bench()
+{
+	local max="$1"
+
+	start=$(date +%s%3N)
+	do_dummies4 "out" "$max" > "$tmp"
+	if ! timeout "$timeout" ip netns exec "$ns" ip -batch "$tmp";then
+		echo "WARNING: policy insertion cancelled after $timeout"
+		ret=1
+	fi
+	stop=$(date +%s%3N)
+
+	result=$((stop-start))
+
+	policies=$(wc -l < "$tmp")
+	printf "Inserted %-06s policies in $result ms\n" $policies
+
+	have=$(ip netns exec "$ns" ip xfrm policy show | grep "action block" | wc -l)
+	if [ "$have" -ne "$policies" ]; then
+		echo "WARNING: mismatch, have $have policies, expected $policies"
+		ret=1
+	fi
+}
+
+p=100
+while [ $p -le "$maxpolicies" ]; do
+	do_bench "$p"
+	p="${p}0"
+done
+
+exit $ret
-- 
2.44.2


