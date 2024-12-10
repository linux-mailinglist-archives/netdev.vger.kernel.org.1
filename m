Return-Path: <netdev+bounces-150810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F371F9EB9E2
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 20:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2EA283BFA
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 19:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9E020469D;
	Tue, 10 Dec 2024 19:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKR9yMUY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D8821421A
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858033; cv=none; b=gKKLpIDVtA4dhn0oPQVTgrLUdDnivP3NN8Iy+/Y4OAgHEcMoSsDgBJp2eY5F+h+dZxfQp9wiw5K9FLA6gO1KK+oscIxEbRluY97C7L0XPnDn0VcXC1jrOk8Tn5OaW3bpmnYA3U1TbTIbYyAKpz5ZEOzmMVrPBz5/cDZZ3IZUSOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858033; c=relaxed/simple;
	bh=E0tfY8DtEA+lUArihpzkp+PRkoGjvKpf54KtysAyjgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0yQsEoOA6ogM8HBTbJIhYdtvLlVlUDkhSWgp842zC/uwlZqhq/zSO1y/HNIK/gfuJHIz51FFC5unl6aIm1zJrAFB5bZNzWHl/BA8cRFMRmWLQgRG7fhhq+NwNlBHMAmjYqJ9FerX/y3BKCObBowB2WDY3vjZVI/E6yPx61gYWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKR9yMUY; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385e0e224cbso3050944f8f.2
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 11:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733858029; x=1734462829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGNIdJo5GtCbb1G+d15g9WXnHQIINZ8/4f4oyVHFkIo=;
        b=DKR9yMUYdfdMUxXgTEjMOSgHQ1EzDF0HTp2q+9HMr2jviFYFJXx3OBgcLrDxpnS2dh
         C6OvkdUraRcxLl5mkY0GMRE4OsNohH9h/Nf1QeSbqLwY4odJLHT8psae2FnAnau8XkHJ
         X8kshfe1KnYpRDduNCBpPY0g3hIGk/n4ypxH5Tg7fXeNqGnunF/wYX1bfZ+Br+BlHK8i
         wmt93e7vkFP68F8FJjYUtQYDmZK1lz8NtrzLPMpK0C2KJbEy5GhSU/LfyQqTGarcH3WP
         c3sy8gJNhPd0Dp8Q03Ed/ViVJkfbAzkFIdelcy2C3eM9AMYq6GbKlKvoyNe8nGlhR82+
         oluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733858029; x=1734462829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGNIdJo5GtCbb1G+d15g9WXnHQIINZ8/4f4oyVHFkIo=;
        b=bQzbLRlaUAoDlVvOHXvzbTG8vZdL7cw7wQaK/l6grVXbF8gOS2XsRkAp9gWTnjbopZ
         m5GwrgnRcWoqd2J0RTPGFmZTHVLMZ5utpI/l3qZW1jDnACg0VpPh1nAyFTU7NhvRT5CV
         A7xJKMCoDKpVKlxHIsiFhuMJhkFTNV1SPn3b52mv16P0IcKC7B+9jvAzh0YycxNMfyr6
         SwxA4PY1Ff+S92aQv/J8Hl1ok4BV8Puczktp0MAQEjXQMkGmRUm5Qk3pdh2VuOlX5D/q
         EDVyCm5U7LKi/n27FI+wReglsbAAwcE5LL5tP0idaLorhS5WNWw5CYjknjFjd7IMy8Fq
         9x+A==
X-Gm-Message-State: AOJu0YyCQVIkI2stwxZqcFAWhUrDFDJur9b1yVDbv7lCEQ16853zPkYs
	XLaAa8AEszUwAuDf+drOHgFH/beVcIEusEOGUZVkfRNoX8OzPqgjagUBuDwKRFE=
X-Gm-Gg: ASbGncsdMyjzwIZbYuN/PAwBxISFjKX5+gJ6cspNbzY6YTYHjEjfI4yGzB8pOp6zmZA
	GMbpvcnKswbVhfhSbnrfmVECs/34pRzfTLqVnmpwvJHvSl8S7xW/yn453Ne21afsftGYrmJNs3C
	GXscMyKgnO/w2VC7DmYWWT0LNn6qLRC23iv08x7BNnkrbYestLjSd5TvvMJ1LLgRE7MFQSzWzps
	vCIdlvcc2JB0ckRUFs6mDDJkzm8Mw1Wr/Adt0QCSs+MfjXZ6ChhrXmwxdSFeyReuxpAi9gOqTp2
	9rfRgBjBfXwsiPQvTANgUApmDSaLZ26pBtg4h/9JD0NAS7Enwx+WZ4pKWxeBJw==
X-Google-Smtp-Source: AGHT+IH0HaGYj60uaaLEFtjkP+hYj1wLpgj0YQdH5TRKAlpw6PgmopgthJIF85ti2/D5yZtF3WTZ5w==
X-Received: by 2002:a05:6000:1449:b0:385:f409:b42 with SMTP id ffacd0b85a97d-3864cea44c2mr220562f8f.53.1733858028763;
        Tue, 10 Dec 2024 11:13:48 -0800 (PST)
Received: from localhost.localdomain (20014C4E37C0C7006406573B5E53AD5C.dsl.pool.telekom.hu. [2001:4c4e:37c0:c700:6406:573b:5e53:ad5c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862d3f57a0sm13310345f8f.108.2024.12.10.11.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:13:48 -0800 (PST)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	idosch@idosch.org,
	Anna Emese Nyiri <annaemesenyiri@gmail.com>
Subject: [PATCH net-next v6 3/4] selftests: net: test SO_PRIORITY ancillary data with cmsg_sender
Date: Tue, 10 Dec 2024 20:13:08 +0100
Message-ID: <20241210191309.8681-4-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210191309.8681-1-annaemesenyiri@gmail.com>
References: <20241210191309.8681-1-annaemesenyiri@gmail.com>
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
 .../testing/selftests/net/cmsg_so_priority.sh | 153 ++++++++++++++++++
 3 files changed, 164 insertions(+), 1 deletion(-)
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
index 000000000000..1fdfe6939a97
--- /dev/null
+++ b/tools/testing/selftests/net/cmsg_so_priority.sh
@@ -0,0 +1,153 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source lib.sh
+
+readonly KSFT_SKIP=4
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
+    echo "SKIP cmsg_so_priroity.sh test: jq is not installed." >&2
+    exit "$KSFT_SKIP"
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
+ip -n $NS address add $IP6 dev dummy1.10 nodad
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


