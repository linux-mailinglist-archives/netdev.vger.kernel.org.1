Return-Path: <netdev+bounces-149401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769C29E5737
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 14:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D67E281F34
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 13:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8EC21A44A;
	Thu,  5 Dec 2024 13:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPCB87JF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C506219A9B
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733405519; cv=none; b=R5geAk6abncd71oxoUgNOzTE75gB8br+jkY1fSwyVn5VFeqP3ALqKVWDYmbs/2j+NrHG+9yi+wbpCTF9w/eGf5PQaG7e4rnNIMICiURphWpGR3PwIHnacMUI/1FqXiUU53xK7NKLYMiYdYMInjZLRjLjGJOziCOTuz+28qiDnYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733405519; c=relaxed/simple;
	bh=S3CCHUywvGD8qfDi7dyr7uupCCIODj9jz85uHMlYPP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V60vDPCf+ibMfz+rgCpO2acSP+yr6+QqAbIc8NEDJLceP9DAs0x7ANG+NNuuOfMaDhM1HNZ+aiiuDdQxUo5o2/YMB6TZcdHVGFNBcK/pcOV/1C8TFtcEs//RRkYJuQIp5bE25JAiOOCdl3HXmJN8c3Ilr8z/F9ZRNIEgVSAhIhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPCB87JF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a2f3bae4so9927055e9.3
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 05:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733405515; x=1734010315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0ZRQMk2CGXqpoVWIuM6uZi5DuwSjgZRELAS6N0IOis=;
        b=JPCB87JFsBoWM9aOzyJi7vSWu4d3c/d1IXZ2pJ1cIP3UwlrmlV92ZGljJQ8OLoDGdz
         qYuXUVpuBlqV4YD+sRmCVBd1eLzvE7DvqliPMG5reJz+/XzGrbM5YE9/HH/IDzG+ByD7
         ljKNNlAyjdUcrlxHcdV5JFsozMllNRBe7tzJssVmQQlXSbQCmnhOjKh52pyYirwwv6hl
         ZPWi1BL3e0N+3X8UGiRuDuanOxTyEPnupx0I5x8gimOFEsqVhEz9SFQmH8a48lcpq0WB
         J9hqeLGymwpD7O7UEULJxfw8FPVLluvjbetroccRUhquhoOi18X57e7QmZ2lC7ZoOo3k
         QfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733405515; x=1734010315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0ZRQMk2CGXqpoVWIuM6uZi5DuwSjgZRELAS6N0IOis=;
        b=VKYko/3nMQPENW/ntkt18Gnfiywgd9RSr3EgHQGdBlolWYqq5vSovggcR3KS/qrTi2
         dt9DQTIpP7s8XzG6h9w7I+qfQVk2W+LBni7h5ldaCZNwhMD2hfAtT0runvptW2TgOrCi
         vi9V+gObrK5VTTkaQdYCv9JhaE9bMyJD2k81KmoJjjG3ijMKBm/ovmMQw2LKQBJynQEq
         mb0oDFhx5FGUGyUbvPRKfFX53+QSp0e/kMOlg+fynfcHY0xFw7dEz6pALtsagDcwWp1c
         r4KgEquxsARSUANynvooEAN1PK4K/eObjsfprsZBFZNxDcauazIvN1Xkn6I9yRtCXSod
         i3xQ==
X-Gm-Message-State: AOJu0YwiOm9Q3WMnYS39CmVlvu0K14C5WqnYIeNR1SULuQSo67E43r4s
	fhX2o9FSQvuAO56kY47r9BU2NjH6gS3Os9u1da8Hez+4ad/2nssbmooFhD9WSgY=
X-Gm-Gg: ASbGncuKjnpFR1FxhEkxjCLHWLn3u1eYwRzPC2nzGRgaEAVWKPnoG6o89+ZM+3twbKM
	NTnAE1br4SdmsjF72W23bWva6f0M0u9mnn7YtZctFFNHohao6m2Ujww5SxL3NJGLjQq8z1IEhKz
	9EE3QBmP7loLp6ACEehzS1kBfEPUbaRDp6mDL4pqGpYYsYDQ/piBEPtRaAO8B+deLGo4+aTROog
	xKYwLSSzi+ocVL1U6vrwQgSsP5tHture3DBQd/uztgFEzVdgUt8d9uoJzclVepbEU+u8NQ9eJvm
	Pz17JngESnuB+BhH4eJzd470FB8GJ9MLAe2eS4ehv+941MCY6IiiNtuA1g==
X-Google-Smtp-Source: AGHT+IFFJUrhKgC63y8QEgCUKVGN55uMdJP92WWuUYFkpUju6TOaaAL/eHW7SE1i8Apm3eYijLiYFA==
X-Received: by 2002:a05:600c:220b:b0:434:a815:2b5d with SMTP id 5b1f17b1804b1-434d1116ebbmr87167805e9.24.1733405514838;
        Thu, 05 Dec 2024 05:31:54 -0800 (PST)
Received: from localhost.localdomain (20014C4E37C0C700ABF575982C3B3E76.dsl.pool.telekom.hu. [2001:4c4e:37c0:c700:abf5:7598:2c3b:3e76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5280fc4sm60852465e9.24.2024.12.05.05.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 05:31:54 -0800 (PST)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	idosch@idosch.org,
	Anna Emese Nyiri <annaemesenyiri@gmail.com>
Subject: [PATCH net-next v5 3/4] selftests: net: test SO_PRIORITY ancillary data with cmsg_sender
Date: Thu,  5 Dec 2024 14:31:11 +0100
Message-ID: <20241205133112.17903-4-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205133112.17903-1-annaemesenyiri@gmail.com>
References: <20241205133112.17903-1-annaemesenyiri@gmail.com>
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
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/cmsg_sender.c     |  11 +-
 .../testing/selftests/net/cmsg_so_priority.sh | 151 ++++++++++++++++++
 3 files changed, 162 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/cmsg_so_priority.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index cb2fc601de66..f09bd96cc978 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -32,6 +32,7 @@ TEST_PROGS += ioam6.sh
 TEST_PROGS += gro.sh
 TEST_PROGS += gre_gso.sh
 TEST_PROGS += cmsg_so_mark.sh
+TEST_PROGS += cmsg_so_priority.sh
 TEST_PROGS += cmsg_time.sh cmsg_ipv6.sh
 TEST_PROGS += netns-name.sh
 TEST_PROGS += nl_netdev.py
diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/selftests/net/cmsg_sender.c
index 876c2db02a63..99b0788f6f0c 100644
--- a/tools/testing/selftests/net/cmsg_sender.c
+++ b/tools/testing/selftests/net/cmsg_sender.c
@@ -59,6 +59,7 @@ struct options {
 		unsigned int proto;
 	} sock;
 	struct option_cmsg_u32 mark;
+	struct option_cmsg_u32 priority;
 	struct {
 		bool ena;
 		unsigned int delay;
@@ -97,6 +98,8 @@ static void __attribute__((noreturn)) cs_usage(const char *bin)
 	       "\n"
 	       "\t\t-m val  Set SO_MARK with given value\n"
 	       "\t\t-M val  Set SO_MARK via setsockopt\n"
+	       "\t\t-P val  Set SO_PRIORITY via setsockopt\n"
+	       "\t\t-Q val  Set SO_PRIORITY via cmsg\n"
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
+			opt.priority.ena = true;
+			opt.priority.val = atoi(optarg);
+			break;
 		case 'M':
 			opt.sockopt.mark = atoi(optarg);
 			break;
@@ -252,6 +259,8 @@ cs_write_cmsg(int fd, struct msghdr *msg, char *cbuf, size_t cbuf_sz)
 
 	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
 			  SOL_SOCKET, SO_MARK, &opt.mark);
+	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
+			SOL_SOCKET, SO_PRIORITY, &opt.priority);
 	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
 			  SOL_IPV6, IPV6_DONTFRAG, &opt.v6.dontfrag);
 	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
diff --git a/tools/testing/selftests/net/cmsg_so_priority.sh b/tools/testing/selftests/net/cmsg_so_priority.sh
new file mode 100755
index 000000000000..016458b219ba
--- /dev/null
+++ b/tools/testing/selftests/net/cmsg_so_priority.sh
@@ -0,0 +1,151 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source lib.sh
+
+IP4=192.0.2.1/24
+TGT4=192.0.2.2
+TGT4_RAW=192.0.2.3
+IP6=2001:db8::1/64
+TGT6=2001:db8::2
+TGT6_RAW=2001:db8::3
+PORT=1234
+DELAY=4000
+TOTAL_TESTS=0
+FAILED_TESTS=0
+
+if ! command -v jq &> /dev/null; then
+    echo "Error: jq is not installed." >&2
+    exit 1
+fi
+
+check_result() {
+    ((TOTAL_TESTS++))
+    if [ "$1" -ne 0 ]; then
+        ((FAILED_TESTS++))
+    fi
+}
+
+cleanup()
+{
+    cleanup_ns $NS
+}
+
+trap cleanup EXIT
+
+setup_ns NS
+
+create_filter() {
+    local handle=$1
+    local vlan_prio=$2
+    local ip_type=$3
+    local proto=$4
+    local dst_ip=$5
+    local ip_proto
+
+    if [[ "$proto" == "u" ]]; then
+        ip_proto="udp"
+    elif [[ "$ip_type" == "ipv4" && "$proto" == "i" ]]; then
+        ip_proto="icmp"
+    elif [[ "$ip_type" == "ipv6" && "$proto" == "i" ]]; then
+        ip_proto="icmpv6"
+    fi
+
+    tc -n $NS filter add dev dummy1 \
+        egress pref 1 handle "$handle" proto 802.1q \
+        flower vlan_prio "$vlan_prio" vlan_ethtype "$ip_type" \
+        dst_ip "$dst_ip" ${ip_proto:+ip_proto $ip_proto} \
+        action pass
+}
+
+ip -n $NS link set dev lo up
+ip -n $NS link add name dummy1 up type dummy
+
+ip -n $NS link add link dummy1 name dummy1.10 up type vlan id 10 \
+    egress-qos-map 0:0 1:1 2:2 3:3 4:4 5:5 6:6 7:7
+
+ip -n $NS address add $IP4 dev dummy1.10
+ip -n $NS address add $IP6 dev dummy1.10
+
+ip netns exec $NS sysctl -wq net.ipv4.ping_group_range='0 2147483647'
+
+ip -n $NS neigh add $TGT4 lladdr 00:11:22:33:44:55 nud permanent \
+    dev dummy1.10
+ip -n $NS neigh add $TGT6 lladdr 00:11:22:33:44:55 nud permanent \
+    dev dummy1.10
+ip -n $NS neigh add $TGT4_RAW lladdr 00:11:22:33:44:66 nud permanent \
+    dev dummy1.10
+ip -n $NS neigh add $TGT6_RAW lladdr 00:11:22:33:44:66 nud permanent \
+    dev dummy1.10
+
+tc -n $NS qdisc add dev dummy1 clsact
+
+FILTER_COUNTER=10
+
+for i in 4 6; do
+    for proto in u i r; do
+        echo "Test IPV$i, prot: $proto"
+        for priority in {0..7}; do
+            if [[ $i == 4 && $proto == "r" ]]; then
+                TGT=$TGT4_RAW
+            elif [[ $i == 6 && $proto == "r" ]]; then
+                TGT=$TGT6_RAW
+            elif [ $i == 4 ]; then
+                TGT=$TGT4
+            else
+                TGT=$TGT6
+            fi
+
+            handle="${FILTER_COUNTER}${priority}"
+
+            create_filter $handle $priority ipv$i $proto $TGT
+
+            pkts=$(tc -n $NS -j -s filter show dev dummy1 egress \
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
+            ip netns exec $NS ./cmsg_sender -$i -Q $priority -d "${DELAY}" \
+	            -p $proto $TGT $PORT
+
+            pkts=$(tc -n $NS -j -s filter show dev dummy1 egress \
+                | jq ".[] | select(.options.handle == ${handle}) | \
+                .options.actions[0].stats.packets")
+            if [[ $pkts == 1 ]]; then
+                check_result 0
+            else
+                echo "prio $priority -Q: expected 1, got $pkts"
+                check_result 1
+            fi
+
+            ip netns exec $NS ./cmsg_sender -$i -P $priority -d "${DELAY}" \
+	            -p $proto $TGT $PORT
+
+            pkts=$(tc -n $NS -j -s filter show dev dummy1 egress \
+                | jq ".[] | select(.options.handle == ${handle}) | \
+                .options.actions[0].stats.packets")
+            if [[ $pkts == 2 ]]; then
+                check_result 0
+            else
+                echo "prio $priority -P: expected 2, got $pkts"
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
+
-- 
2.43.0


