Return-Path: <netdev+bounces-56119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5E280DE55
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6B11C2157F
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 22:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3180F56751;
	Mon, 11 Dec 2023 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="WalfjvWP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFD7AD
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 14:34:09 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50be58a751cso5733916e87.2
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 14:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1702334048; x=1702938848; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fktK+FqKP4B225M6qYTWB00oFsvOERim7cHismtvLGs=;
        b=WalfjvWPTLb93riLGSyE/SG5QgyaPTW0ugugnxq+Q/kEFSI9RnC2nJziOA1dPB0yji
         fpKPljXCI8iv3UKxxEDkti3ipunYwC9Xmpj3gzu2NdpOoeXs8n+jDlLGp+U59gaHZYoE
         84QXyJvixGxoRcSevSBU/Uu9zT+6lLpME/w4MTgpesD9RE36+WwaFDNmoB+ceFvlOQoZ
         1yvd+H81hQqTFGojEHdRRslt0cFTJzMc5AzgoSRXOpxPP/Te+sQxoyR4Cu0EVE367isU
         Lvzki/JQKqlTld92cQX1RZyd11RGFzu4DwAK4Cet9sTeoxuSptPb8I1zMHmWQdV9yBgf
         JreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702334048; x=1702938848;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fktK+FqKP4B225M6qYTWB00oFsvOERim7cHismtvLGs=;
        b=fJwr8vPrUgQ5woIaf0ijtnN5IH4FbopaZ0ouvTryn1neVvrabUOCp5wLvpbONef/sf
         BzQVTA00y/foR7JiOAXabZyPszmBh7SNd1yqnh8tMeDFwCC52IHMiRT56TjHJhCVEo3Q
         sLuFER+CGyYcZMjgCG8mR/iajgSP8H5jVFjUXLVL+csULBI6RgRWoDn3mEixoJHeNkxg
         W+e/XBgZO849tLy6GRAdNQCtv77HITRIf3ZZMxefiPTq/Edd8P/lxi8Hm9jdxUA1Krx6
         hb3HHWX76g+eknRxtcZ1/ozvRYxjXcIY5x1wXsuq4mB1guCOqgxBv6GIZDU1k+MjCF+W
         nUdg==
X-Gm-Message-State: AOJu0Yx5PN5W00v6Q/dsRmC4zOwcsQLwAhAvbWPr1umXlLULyPS0PSxm
	b0Z3yjiKRALvjaYKNpmHmylHyA==
X-Google-Smtp-Source: AGHT+IFwUTYMTowNL86e/mt1fmSwURHQAIqMrZOMTjdpSt3qnhVaPGIgJw24n0/o5IhmREDkDS+jIA==
X-Received: by 2002:a05:6512:2147:b0:50b:fa85:c147 with SMTP id s7-20020a056512214700b0050bfa85c147mr2016604lfr.132.1702334047429;
        Mon, 11 Dec 2023 14:34:07 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id f17-20020a05651232d100b0050bfc6dbb8asm1217649lfg.302.2023.12.11.14.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 14:34:06 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH v3 net-next 8/8] selftests: forwarding: ethtool_rmon: Add histogram counter test
Date: Mon, 11 Dec 2023 23:33:46 +0100
Message-Id: <20231211223346.2497157-9-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211223346.2497157-1-tobias@waldekranz.com>
References: <20231211223346.2497157-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

Validate the operation of rx and tx histogram counters, if supported
by the interface, by sending batches of packets targeted for each
bucket.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../selftests/net/forwarding/ethtool_rmon.sh  | 106 ++++++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh |   9 ++
 3 files changed, 116 insertions(+)
 create mode 100755 tools/testing/selftests/net/forwarding/ethtool_rmon.sh

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index df593b7b3e6b..452693514be4 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -17,6 +17,7 @@ TEST_PROGS = bridge_fdb_learning_limit.sh \
 	dual_vxlan_bridge.sh \
 	ethtool_extended_state.sh \
 	ethtool_mm.sh \
+	ethtool_rmon.sh \
 	ethtool.sh \
 	gre_custom_multipath_hash.sh \
 	gre_inner_v4_multipath.sh \
diff --git a/tools/testing/selftests/net/forwarding/ethtool_rmon.sh b/tools/testing/selftests/net/forwarding/ethtool_rmon.sh
new file mode 100755
index 000000000000..73e3fbe28f37
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/ethtool_rmon.sh
@@ -0,0 +1,106 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+ALL_TESTS="
+	rmon_rx_histogram
+	rmon_tx_histogram
+"
+
+NUM_NETIFS=2
+source lib.sh
+
+bucket_test()
+{
+	local set=$1; shift
+	local bucket=$1; shift
+	local len=$1; shift
+	local num_rx=10000
+	local num_tx=20000
+	local expected=
+	local before=
+	local after=
+	local delta=
+
+	# Mausezahn does not include FCS bytes in its length - but the
+	# histogram counters do
+	len=$((len - 4))
+
+	before=$(ethtool --json -S $h2 --groups rmon | \
+		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][$bucket].val")
+
+	# Send 10k one way and 20k in the other, to detect counters
+	# mapped to the wrong direction
+	$MZ $h1 -q -c $num_rx -p $len -a own -b bcast -d 10us
+	$MZ $h2 -q -c $num_tx -p $len -a own -b bcast -d 10us
+
+	after=$(ethtool --json -S $h2 --groups rmon | \
+		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][$bucket].val")
+
+	delta=$((after - before))
+
+	expected=$([ $set = rx ] && echo $num_rx || echo $num_tx)
+
+	# Allow some extra tolerance for other packets sent by the stack
+	[ $delta -ge $expected ] && [ $delta -le $((expected + 100)) ]
+}
+
+rmon_histogram()
+{
+	local set=$1; shift
+	local nbuckets=0
+
+	RET=0
+
+	while read -r -a bucket; do
+		bucket_test $set $nbuckets ${bucket[0]}
+		check_err "$?" "Verification failed for bucket ${bucket[0]}-${bucket[1]}"
+		nbuckets=$((nbuckets + 1))
+	done < <(ethtool --json -S $h2 --groups rmon | \
+		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][]|[.low, .high, .val]|@tsv" 2>/dev/null)
+
+	if [ $nbuckets -eq 0 ]; then
+		log_test_skip "$h2 does not support $set histogram counters"
+		return
+	fi
+
+	log_test "$set histogram counters"
+}
+
+rmon_rx_histogram()
+{
+	rmon_histogram rx
+}
+
+rmon_tx_histogram()
+{
+	rmon_histogram tx
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	h2=${NETIFS[p2]}
+
+	for iface in $h1 $h2; do
+		ip link set dev $iface up
+	done
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	for iface in $h2 $h1; do
+		ip link set dev $iface down
+	done
+}
+
+check_ethtool_counter_group_support
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+
+tests_run
+
+exit $EXIT_STATUS
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 8f6ca458af9a..e3740163c384 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -146,6 +146,15 @@ check_ethtool_mm_support()
 	fi
 }
 
+check_ethtool_counter_group_support()
+{
+	ethtool --help 2>&1| grep -- '--all-groups' &> /dev/null
+	if [[ $? -ne 0 ]]; then
+		echo "SKIP: ethtool too old; it is missing standard counter group support"
+		exit $ksft_skip
+	fi
+}
+
 check_locked_port_support()
 {
 	if ! bridge -d link show | grep -q " locked"; then
-- 
2.34.1


