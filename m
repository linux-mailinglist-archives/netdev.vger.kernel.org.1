Return-Path: <netdev+bounces-57471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBDA81322E
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023FE282174
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367D1584E6;
	Thu, 14 Dec 2023 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="01onLI0m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E1D114
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:50:57 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c9f84533beso93370981fa.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1702561856; x=1703166656; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=owAbKHRLM5CNmwwYL+/3BuYTq1Qv59kc3y2MuYm6OgA=;
        b=01onLI0mOYR2/Fg1DoKg8B8cf8cD0AsRaoC0xv6HeMvD5kwC2FIWPqjL01eDQVKdxx
         IddvFc7uG9I3YLi6cX303PxQ4kt4MFjmi1+STCHrqB8l+6k/cb99pr2PLkflp+Aagvlg
         EUuW5hwRt3TCy9P293oCVx8Py0lC01X4AjF3n3SpOoadhUOwCEpKdXxqmOOIi+bHQmVC
         rbXbdC1CblKS3jG/AseEgzJbNSgidD/SO19pFNX9NrQeV4C41AhAg5glEYf8E6oYMD5W
         TSucbsobVCrmtYgmEr6I1Tci9CZlV2NHo39yHiVO5HoDEtJXYOogPFwxCCLcr/gr8FH+
         m4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561856; x=1703166656;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=owAbKHRLM5CNmwwYL+/3BuYTq1Qv59kc3y2MuYm6OgA=;
        b=t5NARCiisH6PuJl4JIbS7vaUbaRFCNoE/Jc8WDPFJ92g+uPwH+AbFipAoN5rPa1npS
         bghlUAcMA2KOhefg2aQ41EVKlL6qmCUsLvmoX4wPkzAXRMefpfmdficWex3jjMnz+r5G
         674fNrmUXHH1fCGPvb5SRZKCwqNoxcKcyYwnzG0U+KBIP1iGabpgt0wJpvR7ehhWTC9n
         2BH+ekzrduqqSrQuJ1BeCnK+40G0U6ui1RYSeyOJgN5EFcMx41rep9a97s3QLOBchANk
         ozDB4IE7qk4Ce3NEmRiJH6kKL4rvMugDWXX5EXS/4HF5POm2eUmbEy5PXffcQM/RYc05
         kkDg==
X-Gm-Message-State: AOJu0Yy47ECLRNVVz2VODNpCgrtsVsotOFs4eMGrUoiMRlE/5Rh8gXZU
	EsWdhcHyxr2m6eT5ppjr0fmAog==
X-Google-Smtp-Source: AGHT+IFR26RCpO8cUfoDshRh6nb/QPYYoph5FR2BIsbleO2t6Qtoc8CfC9vGzUIrg2w5IAtGeWErsQ==
X-Received: by 2002:a05:651c:201c:b0:2cc:3f92:e9c9 with SMTP id s28-20020a05651c201c00b002cc3f92e9c9mr648055ljo.17.1702561855839;
        Thu, 14 Dec 2023 05:50:55 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id h4-20020a2ebc84000000b002cc258b5491sm1154010ljf.10.2023.12.14.05.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:50:55 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH v4 net-next 8/8] selftests: forwarding: ethtool_rmon: Add histogram counter test
Date: Thu, 14 Dec 2023 14:50:29 +0100
Message-Id: <20231214135029.383595-9-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214135029.383595-1-tobias@waldekranz.com>
References: <20231214135029.383595-1-tobias@waldekranz.com>
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
 .../selftests/net/forwarding/ethtool_rmon.sh  | 143 ++++++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh |   9 ++
 3 files changed, 153 insertions(+)
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
index 000000000000..41a34a61f763
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/ethtool_rmon.sh
@@ -0,0 +1,143 @@
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
+ETH_FCS_LEN=4
+ETH_HLEN=$((6+6+2))
+
+declare -A netif_mtu
+
+ensure_mtu()
+{
+	local iface=$1; shift
+	local len=$1; shift
+	local current=$(ip -j link show dev $iface | jq -r '.[0].mtu')
+	local required=$((len - ETH_HLEN - ETH_FCS_LEN))
+
+	if [ $current -lt $required ]; then
+		ip link set dev $iface mtu $required || return 1
+	fi
+}
+
+bucket_test()
+{
+	local iface=$1; shift
+	local neigh=$1; shift
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
+	len=$((len - ETH_FCS_LEN))
+
+	before=$(ethtool --json -S $iface --groups rmon | \
+		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][$bucket].val")
+
+	# Send 10k one way and 20k in the other, to detect counters
+	# mapped to the wrong direction
+	$MZ $neigh -q -c $num_rx -p $len -a own -b bcast -d 10us
+	$MZ $iface -q -c $num_tx -p $len -a own -b bcast -d 10us
+
+	after=$(ethtool --json -S $iface --groups rmon | \
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
+	local iface=$1; shift
+	local neigh=$1; shift
+	local set=$1; shift
+	local nbuckets=0
+	local step=
+
+	RET=0
+
+	while read -r -a bucket; do
+		step="$set-pkts${bucket[0]}to${bucket[1]} on $iface"
+
+		for if in $iface $neigh; do
+			if ! ensure_mtu $if ${bucket[0]}; then
+				log_test_skip "$if does not support the required MTU for $step"
+				return
+			fi
+		done
+
+		if ! bucket_test $iface $neigh $set $nbuckets ${bucket[0]}; then
+			check_err 1 "$step failed"
+			return 1
+		fi
+		log_test "$step"
+		nbuckets=$((nbuckets + 1))
+	done < <(ethtool --json -S $iface --groups rmon | \
+		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][]|[.low, .high]|@tsv" 2>/dev/null)
+
+	if [ $nbuckets -eq 0 ]; then
+		log_test_skip "$iface does not support $set histogram counters"
+		return
+	fi
+}
+
+rmon_rx_histogram()
+{
+	rmon_histogram $h1 $h2 rx
+	rmon_histogram $h2 $h1 rx
+}
+
+rmon_tx_histogram()
+{
+	rmon_histogram $h1 $h2 tx
+	rmon_histogram $h2 $h1 tx
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	h2=${NETIFS[p2]}
+
+	for iface in $h1 $h2; do
+		netif_mtu[$iface]=$(ip -j link show dev $iface | jq -r '.[0].mtu')
+		ip link set dev $iface up
+	done
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	for iface in $h2 $h1; do
+		ip link set dev $iface \
+			mtu ${netif_mtu[$iface]} \
+			down
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


