Return-Path: <netdev+bounces-142838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6DA9C0730
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332681C2262C
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719AC212169;
	Thu,  7 Nov 2024 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgX47SZa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5F12101A2
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730985788; cv=none; b=aYsrMDFnaify8vyCgnRHaJq9ATbKAy65ezuR8tB7fvEhHeNrPTDbjrmtOaDuTqp/nY1N9hlx3exXKWpuNqU+pHnvBGkoWOr2qjnVkd5BVj4lifGCE8paVzDbz/eD6xEUjGjfmnVxK1S8s9N3aTt7c212PcmOx0/Y0XZSofq+OcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730985788; c=relaxed/simple;
	bh=QrKnFThf7Ojg+CHdcfzz7KPz55eHvLQBTLw9aj0u7/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffMt/ienYAZ+W0sConSHOnaRZO3ch7UEI+L3rEdqi78waPnz3f1UK5Zz9zrCJEYG758mYYZOAS7ov5Gb4JBw03/1j1U4HTHAdCQdv3/tFz6CLcEtzXTD2CSvDo5ocMudmkFegKmiQA/FEtr/rSEzkz5YQeYCtrxZCZspiuEOEqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgX47SZa; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37ed7eb07a4so636414f8f.2
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 05:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730985785; x=1731590585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AWOfXlIgdSR56jbZ5dsGGdY8onlRqeVAIoHDtSILrY=;
        b=dgX47SZa18oniURJzPDlgQ+RfFUyI7tlnkZOpCiWjTIU+RSY5zMWfwBDn9usClbGTy
         T6OjQVHoLMPX7lBc2Y6D5l6hHyKCuM3XhffJ4sq7JxaUH0wQUxtspeOqI9ybUgZ+Kd1e
         iiupBTbyK6zPY6k09SW4VnPRH7JqnDmtsp2kZvWZL3MZUu+86IoleflwwttdjE5n0bSC
         0gdQbXBFf/XWpq1zoQ8EOiU+Y22U3z1Y+4vHixhCh0xc1S2zpRm98UDsRZOrduZMh15C
         /k/2TTfgxWmD3v83SXszed6X66e6aSntT7SGfhAM5aA7xjBcmdEGshysU8zToOio4ZHs
         z0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730985785; x=1731590585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AWOfXlIgdSR56jbZ5dsGGdY8onlRqeVAIoHDtSILrY=;
        b=jMxh9cZiDYyTd3M+g+nV6karGk9oHcYPyYld9tp/r0+ggVZtglF2doUlUrPGQiSZR+
         AkGPNHdXTch4pnKFMl5x+atdJwf37GMm9Y37FTVw7kEUMJOV6Ni4jTAkIRMoi869tXRC
         qBGPU3Wcvqbuot0eMvTI8JP2rZ+xW/cHikG5fHoiQDmdtASOSKddE0tpz/aJVoRkwgzG
         EWXPbEdBTYcPFaa8UpgxSw/m94Wr4Gx69IheZmk4Tz2D4rFL2vyqwoQHCKCgRe7sdPWe
         73etM363O/MSXm3k7TQYGkx2Qyjk5aVIwZA/kelqARzsTl4onX66tkAgR2ESt4eCTfDp
         q3gQ==
X-Gm-Message-State: AOJu0YzZnMzfzJyd9og0Gc3wYsToWyZTcr2app+BdnikayPP/j8PnWaa
	eoGhya/9tETO8vAfo3WqIFqsHAnMOuFcsuP4OGjxaZhXiyiHY3EiqIvl9FbI
X-Google-Smtp-Source: AGHT+IF2yJoWifQ2nskmji6rQ67wTpx1FVksSQorsMsJHwkEmYCStPE1EmBhQ5Oq4uxUwOfDwfBkcw==
X-Received: by 2002:a05:6000:1548:b0:37d:4cd5:fff2 with SMTP id ffacd0b85a97d-381ef681c7emr1080823f8f.6.1730985784590;
        Thu, 07 Nov 2024 05:23:04 -0800 (PST)
Received: from localhost.localdomain (20014C4E1E912B00E77793ED09024636.dsl.pool.telekom.hu. [2001:4c4e:1e91:2b00:e777:93ed:902:4636])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e5bddsm24372355e9.38.2024.11.07.05.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:23:04 -0800 (PST)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	annaemesenyiri@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	Ido Schimmel <idosch@idosch.org>
Subject: [PATCH net-next v3 3/3] selftest: net: test SO_PRIORITY ancillary data with cmsg_sender
Date: Thu,  7 Nov 2024 14:22:31 +0100
Message-ID: <20241107132231.9271-4-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241107132231.9271-1-annaemesenyiri@gmail.com>
References: <20241107132231.9271-1-annaemesenyiri@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend cmsg_sender.c with a new option '-Q' to send SO_PRIORITY
ancillary data.

Add the `cmsg_so_priority.sh` script, which sets up two network  
namespaces (red and green) and uses the `cmsg_sender.c` program to  
send messages between them. The script sets packet priorities both  
via `setsockopt` and control messages (cmsg) and verifies whether  
packets are routed to the same queue based on priority settings.

Suggested-by: Ido Schimmel <idosch@idosch.org>
Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
---
 tools/testing/selftests/net/cmsg_sender.c     |  11 +-
 .../testing/selftests/net/cmsg_so_priority.sh | 115 ++++++++++++++++++
 2 files changed, 125 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/cmsg_so_priority.sh

diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/selftests/net/cmsg_sender.c
index 876c2db02a63..6fbe93dd63d2 100644
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
index 000000000000..706d29b251e9
--- /dev/null
+++ b/tools/testing/selftests/net/cmsg_so_priority.sh
@@ -0,0 +1,115 @@
+#!/bin/bash
+
+source lib.sh
+
+IP4=192.168.0.2/16
+TGT4=192.168.0.3/16
+TGT4_NO_MASK=192.168.0.3
+IP6=2001:db8::2/64
+TGT6=2001:db8::3/64
+TGT6_NO_MASK=2001:db8::3
+IP4BR=192.168.0.1/16
+IP6BR=2001:db8::1/64
+PORT=8080
+DELAY=400000
+QUEUE_NUM=4
+
+
+cleanup() {
+    ip netns del red 2>/dev/null
+    ip netns del green 2>/dev/null
+    ip link del br0 2>/dev/null
+    ip link del vethcab0 2>/dev/null
+    ip link del vethcab1 2>/dev/null
+}
+
+trap cleanup EXIT
+
+priority_values=($(seq 0 $((QUEUE_NUM - 1))))
+
+queue_config=""
+for ((i=0; i<$QUEUE_NUM; i++)); do
+    queue_config+=" 1@$i"
+done
+
+map_config=$(seq 0 $((QUEUE_NUM - 1)) | tr '\n' ' ')
+
+ip netns add red
+ip netns add green
+ip link add br0 type bridge
+ip link set br0 up
+ip addr add $IP4BR dev br0
+ip addr add $IP6BR dev br0
+
+ip link add vethcab0 type veth peer name red0
+ip link set vethcab0 master br0
+ip link set red0 netns red
+ip netns exec red bash -c "
+ip link set lo up
+ip link set red0 up
+ip addr add $IP4 dev red0
+ip addr add $IP6 dev red0
+sysctl -w net.ipv4.ping_group_range='0 2147483647'
+exit"
+ip link set vethcab0 up
+
+ip link add vethcab1 type veth peer name green0
+ip link set vethcab1 master br0
+ip link set green0 netns green
+ip netns exec green bash -c "
+ip link set lo up
+ip link set green0 up
+ip addr add $TGT4 dev green0
+ip addr add $TGT6 dev green0
+exit"
+ip link set vethcab1 up
+
+ip netns exec red bash -c "
+sudo ethtool -L red0 tx $QUEUE_NUM rx $QUEUE_NUM
+sudo tc qdisc add dev red0 root mqprio num_tc $QUEUE_NUM queues $queue_config map $map_config hw 0
+exit"
+
+get_queue_bytes() {
+    ip netns exec red sudo tc -s qdisc show dev red0 | grep 'Sent' | awk '{print $2}'
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
+
+for i in 4 6; do
+    [ $i == 4 ] && TGT=$TGT4_NO_MASK || TGT=$TGT6_NO_MASK
+
+    for p in u i r; do
+        echo "Test IPV$i, prot: $p"
+        for value in "${priority_values[@]}"; do
+            ip netns exec red ./cmsg_sender -$i -Q $value -d "${DELAY}" -p $p $TGT $PORT
+            setsockopt_priority_bytes_num=($(get_queue_bytes))
+
+            ip netns exec red ./cmsg_sender -$i -P $value -d "${DELAY}" -p $p $TGT $PORT
+            cmsg_priority_bytes_num=($(get_queue_bytes))
+
+            if [[ "${cmsg_priority_bytes_num[$actual_queue]}" != \
+            "${setsockopt_priority_bytes_num[$actual_queue]}" ]]; then
+                check_result 0
+            else
+                check_result 1
+            fi
+        done
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


