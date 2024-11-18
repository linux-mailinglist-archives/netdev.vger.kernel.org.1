Return-Path: <netdev+bounces-145882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EF99D13AA
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9291F23852
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 14:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ED21A9B3D;
	Mon, 18 Nov 2024 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyiOO4Vl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107811A9B34
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731941560; cv=none; b=hYg7OESJrHjWaDmM5M+Rjrt0suECn+hpIrHu8jsUc/Rbnc2P/reDcUrHP12hpYy7HJ9l9pGMZ81qf8SMsGUEv0+5qrm+TnFZXFPGVQf6KYzlQT2lbBJmeZBRSXtl7Wpb8byhDQrgT+U5HllR4K3BSX2/cFHYiS425s3qRVqrkZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731941560; c=relaxed/simple;
	bh=ULVpsfd6yX1ZnvmuTVSBNsBKjYCvwRllmj5MPpr/Zyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WG9v7UyG7xI4fS2OzQAv14PV8i/xV8SpXqMm1qWnryAas/SFSpZy5TD3cG6/6EiJbaCLHesQ6Exg1Bon0dGPvPzg2vgNhpn423qeiNVpB5U+XoqBI9hpF9+WGNIELdHiS5WH4NSJj6ohe0UZUhotoQcv0SpnWaRdK3YnFR8fvOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyiOO4Vl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so35385495e9.3
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 06:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731941557; x=1732546357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zU6lwIqx/RoICKHObiqUzLzsxG3XRnjTTOYZ2wKnqv4=;
        b=PyiOO4Vl7GCOsQ7TL86Ks6Sp7VVJDBv4Kv/RI8bdOxRn4S+D/tWIafqQBYUIYe7nPg
         W6ZfSQZan5jmY1xb8qCwGvr/ySh8K/3yzs4q92XC76amGhhtuCKQoRVT3Bz0FaJ0O93o
         ZBfjRDZDXGCEoPN3YI6GdwYeqvhKN4NTxHiDCVNXn/KUGQPdiUB2CXwfX2Lylx7NxNsf
         XYoRH5kvlkt0rTMvT5jMlTTJkeIKvWYJH+nGneUvtEcWvHKb08aFEaTc5VydVI7/EXr+
         hbMt3QUaFSaPZE6B28PTRskGCR4Wz/XqJIIW7VBrhseOVr4g2NauWs2/WvG1pzAbkj2H
         6aOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731941557; x=1732546357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zU6lwIqx/RoICKHObiqUzLzsxG3XRnjTTOYZ2wKnqv4=;
        b=XJcrOtT9Xa1RhTrA2vwnX1erM5jCQbLfDEUfhdGqU2HnyjoIgf516kIyB/GDyMP1at
         3VCiBKEiQmSyd6L1KCwM1rFkvkvqAcY6mlBIfrOR1ah+DKKmWF1aDER8jo3N493qRxyH
         oEH7XIKhWN2zmzU/mwX6k4hjDqujXigyR6Fre+11bhlbsOna5JDFV6YCjMZny5bEjBxX
         jxlx/D8rstLJQQZEtEJ2s4hpLqpHvW1DjUh1EKwkwCUOiVgt3xJ2MuSa2Zfvoy71mpXC
         4xm01KUzjoa1bs4vfaxf0GSIFDzSNP1AdYESvW38YCx2sjG8fxK+MdIK3ZqpHSb5CVYo
         pugQ==
X-Gm-Message-State: AOJu0YwuGL21IHC3iqV88/TuMpFlAFQJr1tfCLQ09+kOUMkoowY17HtR
	0Agzw1DND7mUqnjGtUU9BFDzfAGSTxd3GkuAGyTChbL93eOTSZ3V2+nw6+yGeEw=
X-Google-Smtp-Source: AGHT+IH60fBtjdKf0ywXT/QXZz98x4qet5ODx5/p6TnH/8+b2cjZiCiRPrDLYrL3mYJ6woxbG31S+g==
X-Received: by 2002:a05:600c:314a:b0:42c:a89e:b0e6 with SMTP id 5b1f17b1804b1-432df72c1b9mr103719445e9.11.1731941557002;
        Mon, 18 Nov 2024 06:52:37 -0800 (PST)
Received: from localhost.localdomain (20014C4E1E82D600957C45913C6586B5.dsl.pool.telekom.hu. [2001:4c4e:1e82:d600:957c:4591:3c65:86b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da27fbd2sm162639285e9.19.2024.11.18.06.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:52:36 -0800 (PST)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	annaemesenyiri@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	idosch@idosch.org
Subject: [PATCH net-next v4 3/3] selftests: net: test SO_PRIORITY ancillary data with cmsg_sender
Date: Mon, 18 Nov 2024 15:51:47 +0100
Message-ID: <20241118145147.56236-4-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241118145147.56236-1-annaemesenyiri@gmail.com>
References: <20241118145147.56236-1-annaemesenyiri@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend cmsg_sender.c with a new option '-Q' to send SO_PRIORITY
ancillary data.

cmsg_so_priority.sh script added to validate SO_PRIORITY behavior 
by creating VLAN device with egress QoS mapping and testing packet
priorities using flower filters. Verify that packets with different
priorities are correctly matched and counted by filters for multiple
protocols and IP versions.

Suggested-by: Ido Schimmel <idosch@idosch.org>
Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
---
 tools/testing/selftests/net/cmsg_sender.c     |  11 +-
 .../testing/selftests/net/cmsg_so_priority.sh | 147 ++++++++++++++++++
 2 files changed, 157 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/cmsg_so_priority.sh

diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/selftests/net/cmsg_sender.c
index 876c2db02a63..5267eacc35df 100644
--- a/tools/testing/selftests/net/cmsg_sender.c
+++ b/tools/testing/selftests/net/cmsg_sender.c
@@ -52,6 +52,7 @@ struct options {
 		unsigned int tclass;
 		unsigned int hlimit;
 		unsigned int priority;
+		unsigned int priority_cmsg;
 	} sockopt;
 	struct {
 		unsigned int family;
@@ -59,6 +60,7 @@ struct options {
 		unsigned int proto;
 	} sock;
 	struct option_cmsg_u32 mark;
+	struct option_cmsg_u32 priority_cmsg;
 	struct {
 		bool ena;
 		unsigned int delay;
@@ -97,6 +99,7 @@ static void __attribute__((noreturn)) cs_usage(const char *bin)
 	       "\n"
 	       "\t\t-m val  Set SO_MARK with given value\n"
 	       "\t\t-M val  Set SO_MARK via setsockopt\n"
+		   "\t\t-Q val  Set SO_PRIORITY via cmsg\n"
 	       "\t\t-d val  Set SO_TXTIME with given delay (usec)\n"
 	       "\t\t-t      Enable time stamp reporting\n"
 	       "\t\t-f val  Set don't fragment via cmsg\n"
@@ -115,7 +118,7 @@ static void cs_parse_args(int argc, char *argv[])
 {
 	int o;
 
-	while ((o = getopt(argc, argv, "46sS:p:P:m:M:n:d:tf:F:c:C:l:L:H:")) != -1) {
+	while ((o = getopt(argc, argv, "46sS:p:P:m:M:n:d:tf:F:c:C:l:L:H:Q:")) != -1) {
 		switch (o) {
 		case 's':
 			opt.silent_send = true;
@@ -148,6 +151,10 @@ static void cs_parse_args(int argc, char *argv[])
 			opt.mark.ena = true;
 			opt.mark.val = atoi(optarg);
 			break;
+		case 'Q':
+			opt.priority_cmsg.ena = true;
+			opt.priority_cmsg.val = atoi(optarg);
+			break;
 		case 'M':
 			opt.sockopt.mark = atoi(optarg);
 			break;
@@ -252,6 +259,8 @@ cs_write_cmsg(int fd, struct msghdr *msg, char *cbuf, size_t cbuf_sz)
 
 	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
 			  SOL_SOCKET, SO_MARK, &opt.mark);
+	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
+			SOL_SOCKET, SO_PRIORITY, &opt.priority_cmsg);
 	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
 			  SOL_IPV6, IPV6_DONTFRAG, &opt.v6.dontfrag);
 	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
diff --git a/tools/testing/selftests/net/cmsg_so_priority.sh b/tools/testing/selftests/net/cmsg_so_priority.sh
new file mode 100755
index 000000000000..e5919c5ed1a4
--- /dev/null
+++ b/tools/testing/selftests/net/cmsg_so_priority.sh
@@ -0,0 +1,147 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+IP4=192.0.2.1/24
+TGT4=192.0.2.2/24
+TGT4_NO_MASK=192.0.2.2
+TGT4_RAW=192.0.2.3/24
+TGT4_RAW_NO_MASK=192.0.2.3
+IP6=2001:db8::1/64
+TGT6=2001:db8::2/64
+TGT6_NO_MASK=2001:db8::2
+TGT6_RAW=2001:db8::3/64
+TGT6_RAW_NO_MASK=2001:db8::3
+PORT=1234
+DELAY=4000
+
+
+create_filter() {
+
+    local ns=$1
+    local dev=$2
+    local handle=$3
+    local vlan_prio=$4
+    local ip_type=$5
+    local proto=$6
+    local dst_ip=$7
+
+    local cmd="tc -n $ns filter add dev $dev egress pref 1 handle $handle \
+    proto 802.1q flower vlan_prio $vlan_prio vlan_ethtype $ip_type"
+
+    if [[ "$proto" == "u" ]]; then
+        ip_proto="udp"
+    elif [[ "$ip_type" == "ipv4" && "$proto" == "i" ]]; then
+        ip_proto="icmp"
+    elif [[ "$ip_type" == "ipv6" && "$proto" == "i" ]]; then
+        ip_proto="icmpv6"
+    fi
+
+    if [[ "$proto" != "r" ]]; then
+        cmd="$cmd ip_proto $ip_proto"
+    fi
+
+    cmd="$cmd dst_ip $dst_ip action pass"
+
+    eval $cmd
+}
+
+TOTAL_TESTS=0
+FAILED_TESTS=0
+
+check_result() {
+    ((TOTAL_TESTS++))
+    if [ "$1" -ne 0 ]; then
+        ((FAILED_TESTS++))
+    fi
+}
+
+cleanup() {
+    ip link del dummy1 2>/dev/null
+    ip -n ns1 link del dummy1.10 2>/dev/null
+    ip netns del ns1 2>/dev/null
+}
+
+trap cleanup EXIT
+
+
+
+ip netns add ns1
+
+ip -n ns1 link set dev lo up
+ip -n ns1 link add name dummy1 up type dummy
+
+ip -n ns1 link add link dummy1 name dummy1.10 up type vlan id 10 \
+        egress-qos-map 0:0 1:1 2:2 3:3 4:4 5:5 6:6 7:7
+
+ip -n ns1 address add $IP4 dev dummy1.10
+ip -n ns1 address add $IP6 dev dummy1.10
+
+ip netns exec ns1 bash -c "
+sysctl -w net.ipv4.ping_group_range='0 2147483647'
+exit"
+
+
+ip -n ns1 neigh add $TGT4_NO_MASK lladdr 00:11:22:33:44:55 nud permanent dev \
+        dummy1.10
+ip -n ns1 neigh add $TGT6_NO_MASK lladdr 00:11:22:33:44:55 nud permanent dev dummy1.10
+ip -n ns1 neigh add $TGT4_RAW_NO_MASK lladdr 00:11:22:33:44:66 nud permanent dev dummy1.10
+ip -n ns1 neigh add $TGT6_RAW_NO_MASK lladdr 00:11:22:33:44:66 nud permanent dev dummy1.10
+
+tc -n ns1 qdisc add dev dummy1 clsact
+
+FILTER_COUNTER=10
+
+for i in 4 6; do
+    for proto in u i r; do
+        echo "Test IPV$i, prot: $proto"
+        for priority in {0..7}; do
+            if [[ $i == 4 && $proto == "r" ]]; then
+                TGT=$TGT4_RAW_NO_MASK
+            elif [[ $i == 6 && $proto == "r" ]]; then
+                TGT=$TGT6_RAW_NO_MASK
+            elif [ $i == 4 ]; then
+                TGT=$TGT4_NO_MASK
+            else
+                TGT=$TGT6_NO_MASK
+            fi
+
+            handle="${FILTER_COUNTER}${priority}"
+
+            create_filter ns1 dummy1 $handle $priority ipv$i $proto $TGT
+
+            pkts=$(tc -n ns1 -j -s filter show dev dummy1 egress \
+                | jq ".[] | select(.options.handle == ${handle}) | \
+                .options.actions[0].stats.packets")
+
+            if [[ $pkts == 0 ]]; then
+                check_result 0
+            else
+                echo "prio $priority: expected 0, got $pkts"
+                check_result 1
+            fi
+
+            ip netns exec ns1 ./cmsg_sender -$i -Q $priority -d "${DELAY}" -p $proto $TGT $PORT
+            ip netns exec ns1 ./cmsg_sender -$i -P $priority -d "${DELAY}" -p $proto $TGT $PORT
+
+
+            pkts=$(tc -n ns1 -j -s filter show dev dummy1 egress \
+                | jq ".[] | select(.options.handle == ${handle}) | \
+                .options.actions[0].stats.packets")
+            if [[ $pkts == 2 ]]; then
+                check_result 0
+            else
+                echo "prio $priority: expected 2, got $pkts"
+                check_result 1
+            fi
+        done
+        FILTER_COUNTER=$((FILTER_COUNTER + 10))
+    done
+done
+
+if [ $FAILED_TESTS -ne 0 ]; then
+    echo "FAIL - $FAILED_TESTS/$TOTAL_TESTS tests failed"
+    exit 1
+else
+    echo "OK - All $TOTAL_TESTS tests passed"
+    exit 0
+fi
-- 
2.43.0


