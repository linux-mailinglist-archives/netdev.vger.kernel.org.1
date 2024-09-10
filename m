Return-Path: <netdev+bounces-126828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FCA9729D8
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DEE21F254BC
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F0617BED4;
	Tue, 10 Sep 2024 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="N2v389ax"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BA017A924
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951326; cv=none; b=XrNWflpd6MaPf7k8Nb1I2E2JKAC8i7I/rJNhXKF8/QKiHf1VpOBdw6evMOTNraVONORCQ53K+YA6vgeUilltBq5b5NwU3LWC+aprzMursJ3wwVeA3p9oLkykxGLPiD41bkNF5AU5KaPZUHSXy/WcKh1pFR0NQEJH3m/55a92+Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951326; c=relaxed/simple;
	bh=spbVtfa0Dr5cgnF2hpi5CTZymMhRHKxU/wSw2iiAnw8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kT+hpf2YfTJH+lLg2t9s6ADnwKdr6igIAOGm/msRfnkfsiRPRuFRRKu4/vZIr3q1WNzq++xG6gq9Fu63tNk1ZdCGVOHUrjB1wDCBI/KW41zsPovKlnHKiILEwOw2nQBYJtdH+W5Psxz9EU9bb20W3wtc65r6lCIdSg1wu8a2q1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=N2v389ax; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id BD76420892;
	Tue, 10 Sep 2024 08:55:21 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gwovq_UsdWa8; Tue, 10 Sep 2024 08:55:21 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 18A362074B;
	Tue, 10 Sep 2024 08:55:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 18A362074B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725951321;
	bh=EHOr8s/HBbtLH+uAsT9WukfOMwSiBwLTMomAdHJ77RE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=N2v389axxC1VKoi6qtkFT1yJP7FIiOf5WQ5lRuAnDrM2LQoExUho5NWF7DWyECcbM
	 mh7aflDtysl/3SE5rS+FdRav2H5MKMN6dBd4rxoJb0CevBNK8Vqa/BFdJz3f5a+j9N
	 VYId9gnll/yDHsBUgYtIPzo3oYVA8Xr61S2egBEU+yba7SeabTNzdC2A7ml8uGUlSk
	 t5ksZqaPd+DAmSrMMIcRavPsQReDkSPiNSe42Ohd812gLqOywkwBVnCJBkyVtEYKvD
	 cevhauTzXPAT0ATaRS7ualX9JiSypN/TFb3de7R1FEzL9sAARE6y7tNntrbxNIyCWp
	 +fFDks8tsmQWw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 08:55:20 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 08:55:20 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 3B4393182C58; Tue, 10 Sep 2024 08:55:20 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 04/13] selftests: add xfrm policy insertion speed test script
Date: Tue, 10 Sep 2024 08:54:58 +0200
Message-ID: <20240910065507.2436394-5-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910065507.2436394-1-steffen.klassert@secunet.com>
References: <20240910065507.2436394-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Florian Westphal <fw@strlen.de>

Nothing special, just test how long insertion of x policies takes.
This should ideally show linear insertion speeds.

Do not run this by default, it has little value, but it can be useful to
check for insertion speed chahnges when altering the xfrm policy db
implementation.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
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
2.34.1


