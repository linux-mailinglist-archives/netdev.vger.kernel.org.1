Return-Path: <netdev+bounces-264085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHewLyy8qGlbwwAAu9opvQ
	(envelope-from <netdev+bounces-264085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:11:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF1F208E2E
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2DDD312691E
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 23:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFD6388364;
	Wed,  4 Mar 2026 23:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="NJ7jvaQS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6715A37F8CD
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 23:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772665632; cv=none; b=U0gpnwas1TmhyECzEGGxY465bCzhAB3oi33HVnDSwvQkBEhgHV1jS/qhjzGDzWyw5Z5F/cX/KGqjaI1IrCHKxiczJNOlasqzJr7kGb4nXyfMc5GLge5SYxDOOPT+sZ3dzQVEBnip8w8zAJ+bR4BxxwdJaVtmMPfZgyN7OshQ/wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772665632; c=relaxed/simple;
	bh=qqo/sXxeUcdg1LLDHEKSMtN5BtI0DxP3q5LlITq11LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IE1IgRulZTIuQjJUNXDZm9qlWrFQ3zmExruVvenxY36FCH5ctokc2m1pu2WH4rxwpeIgaBdndF6MruEEeM0l7lkWt7VLxnZPfrzhHCLVp9NfHnAy0bM45pWBXvAQgybWAfqp8W8+iepAPe9aVV5IZHyZUt3SXxFNVMYwM86DGY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=NJ7jvaQS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48371bb515eso110264185e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 15:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1772665628; x=1773270428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAXxJSztMHv22laPSgiqC3TIngmb2awX71/Jw/42qZM=;
        b=NJ7jvaQS5lQdImf1FROY8w5QiH1xpuP0gsJI/YdyG6wvQh1m7hN6cQI8FYflaRM5/M
         YGLUKW3/rE7JlErlyVo8PmCBw5Zod6X1cJ9OG+9BdMIc+yV/2kTCLra9hLrmNLML5mLX
         1+pMZxRNzBVfp+ylfjmCx7qFqXNjNhbStqDtG5LRpLQpwm9GacfiEC06dTaF8HGJFFA1
         kdcaz0c/7DQW3IXcaYYRKuUlo1tls91uYx3C6vqNJgclhtbAaevCxWvnHWPy0baJ+Gz9
         7UMN56TBF/0zpeZPGQMx8UFakyQCZ8s0eiEcYD/QcwDHZY14LjKQ3+Ry0Nxd9lkgAn56
         3shA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772665628; x=1773270428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fAXxJSztMHv22laPSgiqC3TIngmb2awX71/Jw/42qZM=;
        b=HOqIBfOy1EV1MaShDFcmbWyu1LEgVYZ2MWKVMT2fe9IkOhSJuvoac10uREYr/CJO/0
         LN2UYzbgT7OvVUsbusKfQL5s6n03EWnOr+tqJhLuHLoPTcoe5JbpIABUvuT02gL/A8gX
         3vBS4VaqkgAo78+nZybDl43wIYGgCQvu80lJjUvnN69Id+8kZ6kPcaIsmmxMll8qXJh2
         MICgOMcGeq3nWT49KwGqUIG3efNTgIEL6YaGNHF0QYsvlptMFUNZAtqgv0UFRT+LPlQp
         q8Ubr5AL1GYErNz0Lbam3Dzhdtnu10dJmk0WMTNvdJMrD5LA/PGJxc4ARnHEMtzT125D
         EUSw==
X-Gm-Message-State: AOJu0Yyk6gOthG+qRf+YPWINVYRvE16ZyrVP90wxTAO9Oj4h57LfSUba
	B3MPwLBa9sb4DXBCoXpbAwSAExscY0z45fKLHMf42/lN84Qx5DTekZ0VrH7Tm+v9QXLjW9QyYuz
	1IIv0IuJfuc1gYJl/Ly4Vl/OzTw1eR7gSbtS2DlqRyO6N9Lbyd/uycnoV5cpX+WlI
X-Gm-Gg: ATEYQzz97dwQu5+WsVBjq4Qog0q6IsJ9O+lZR7TtBzAmHMOEYdpdQq9bZ0ZV9RWZhgp
	iZKuwDa80/i/PEZkCKYgX2t8Wnk7yqsD4sky64v4oy/kz9/x9GQCx9QEwhvq2xSUjTfTf5tWmOW
	3RhDJss8UBVVWV0VsX3AnkL1Y9bsWTrMiy8jZJ6Mb9nzeamqPdeKP9Zz33SI6kQlvupakRYp1TO
	P2QCD7HAE/ncO7YLEXK7QtZjkjfQTXjWcsgNs20N3dwYoBr0O4YYyTecpVLv5OGHDL95w8zIFHN
	Cv8pqEBRZjR41P/U+8kxwCU/YgrU08W4o4cqBG9tGXJOVAKLWpZSqlyfsf097K7xUkBYEsFUXfC
	IVkWYM8B8nNxmef2tl5emANhhuY2MTl5cgoF9mkl9TaYcU5cH+zfLgmu/9dZDoHVlQEc1hGLhPz
	T9upoQBErBktjcIxAOT+R5Od7gwuxM5hGvbwc=
X-Received: by 2002:a05:600c:8105:b0:477:7bca:8b34 with SMTP id 5b1f17b1804b1-4851983bf08mr56561535e9.6.1772665628413;
        Wed, 04 Mar 2026 15:07:08 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:880:4d86:fc53:5d46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485187caf9fsm87713475e9.7.2026.03.04.15.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:07:08 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	horms@kernel.org,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 8/9] selftests: ovpn: add test for the FW mark feature
Date: Thu,  5 Mar 2026 00:06:26 +0100
Message-ID: <20260304230643.1014-9-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260304230643.1014-1-antonio@openvpn.net>
References: <20260304230643.1014-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6AF1F208E2E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264085-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,test-mark.sh:url,openvpn.net:dkim,openvpn.net:email,openvpn.net:mid,mandelbit.com:email]
X-Rspamd-Action: no action

From: Ralf Lici <ralf@mandelbit.com>

Add a selftest to verify that the FW mark socket option is correctly
supported and its value propagated by ovpn.

The test adds and removes nftables DROP rules based on the mark value,
and checks that the rule counter aligns with the number of lost ping
packets.

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Cc: horms@kernel.org
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/Makefile     |  1 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c   | 26 ++++-
 tools/testing/selftests/net/ovpn/test-mark.sh | 95 +++++++++++++++++++
 3 files changed, 120 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/net/ovpn/test-mark.sh

diff --git a/tools/testing/selftests/net/ovpn/Makefile b/tools/testing/selftests/net/ovpn/Makefile
index d3a070db0bb5..7c87c95d957e 100644
--- a/tools/testing/selftests/net/ovpn/Makefile
+++ b/tools/testing/selftests/net/ovpn/Makefile
@@ -31,6 +31,7 @@ TEST_PROGS := \
 	test-close-socket.sh \
 	test-float.sh \
 	test-large-mtu.sh \
+	test-mark.sh \
 	test-tcp.sh \
 	test.sh \
 # end of TEST_PROGS
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index 8c684f61220b..01bdcc0a8049 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -6,6 +6,7 @@
  *  Author:	Antonio Quartulli <antonio@openvpn.net>
  */
 
+#include <stdint.h>
 #include <stdio.h>
 #include <inttypes.h>
 #include <stdbool.h>
@@ -133,6 +134,8 @@ struct ovpn_ctx {
 	enum ovpn_key_slot key_slot;
 	int key_id;
 
+	uint32_t mark;
+
 	const char *peers_file;
 };
 
@@ -521,6 +524,15 @@ static int ovpn_socket(struct ovpn_ctx *ctx, sa_family_t family, int proto)
 		return ret;
 	}
 
+	if (ctx->mark != 0) {
+		ret = setsockopt(s, SOL_SOCKET, SO_MARK, (void *)&ctx->mark,
+				 sizeof(ctx->mark));
+		if (ret < 0) {
+			perror("setsockopt for SO_MARK");
+			return ret;
+		}
+	}
+
 	if (family == AF_INET6) {
 		opt = 0;
 		if (setsockopt(s, IPPROTO_IPV6, IPV6_V6ONLY, &opt,
@@ -1693,12 +1705,13 @@ static void usage(const char *cmd)
 	fprintf(stderr, "\tvpnaddr: peer VPN IP\n");
 
 	fprintf(stderr,
-		"* new_multi_peer <iface> <lport> <peers_file>: add multiple peers as listed in the file\n");
+		"* new_multi_peer <iface> <lport> <peers_file> [mark]: add multiple peers as listed in the file\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
 	fprintf(stderr, "\tlport: local UDP port to bind to\n");
 	fprintf(stderr,
 		"\tpeers_file: text file containing one peer per line. Line format:\n");
-	fprintf(stderr, "\t\t<peer_id> <tx_id> <raddr> <rport> <laddr> <lport> <vpnaddr>\n");
+	fprintf(stderr, "\t\t<peer_id> <tx_id> <raddr> <rport> <laddr> <lport> <vpnaddr> [mark]\n");
+	fprintf(stderr, "\tmark: socket FW mark value\n");
 
 	fprintf(stderr,
 		"* set_peer <iface> <peer_id> <keepalive_interval> <keepalive_timeout>: set peer attributes\n");
@@ -2241,6 +2254,15 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 		}
 
 		ovpn->peers_file = argv[4];
+
+		ovpn->mark = 0;
+		if (argc > 5) {
+			ovpn->mark = strtoul(argv[5], NULL, 10);
+			if (errno == ERANGE || ovpn->mark > UINT32_MAX) {
+				fprintf(stderr, "mark value out of range\n");
+				return -1;
+			}
+		}
 		break;
 	case CMD_SET_PEER:
 		if (argc < 6)
diff --git a/tools/testing/selftests/net/ovpn/test-mark.sh b/tools/testing/selftests/net/ovpn/test-mark.sh
new file mode 100755
index 000000000000..1a107f9b5431
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/test-mark.sh
@@ -0,0 +1,95 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020-2025 OpenVPN, Inc.
+#
+#	Author:	Ralf Lici <ralf@mandelbit.com>
+#		Antonio Quartulli <antonio@openvpn.net>
+
+#set -x
+set -e
+
+MARK=1056
+
+source ./common.sh
+
+cleanup
+
+modprobe -q ovpn || true
+
+for p in $(seq 0 "${NUM_PEERS}"); do
+	create_ns "${p}"
+done
+
+for p in $(seq 0 3); do
+	setup_ns "${p}" 5.5.5.$((p + 1))/24
+done
+
+# add peer0 with mark
+ip netns exec peer0 "${OVPN_CLI}" new_multi_peer tun0 any any 1 ASYMM \
+	"${UDP_PEERS_FILE}" ${MARK}
+for p in $(seq 1 3); do
+	ip netns exec peer0 "${OVPN_CLI}" new_key tun0 "${p}" 1 0 "${ALG}" 0 \
+		data64.key
+done
+
+for p in $(seq 1 3); do
+	add_peer "${p}"
+done
+
+for p in $(seq 1 3); do
+	ip netns exec peer0 "${OVPN_CLI}" set_peer tun0 "${p}" 60 120
+	ip netns exec peer"${p}" "${OVPN_CLI}" set_peer tun"${p}" \
+		$((p + 9)) 60 120
+done
+
+sleep 1
+
+for p in $(seq 1 3); do
+	ip netns exec peer0 ping -qfc 500 -w 3 5.5.5.$((p + 1))
+done
+
+echo "Adding an nftables drop rule based on mark value ${MARK}"
+ip netns exec peer0 nft flush ruleset
+ip netns exec peer0 nft 'add table inet filter'
+ip netns exec peer0 nft 'add chain inet filter output {
+	type filter hook output priority 0;
+	policy accept;
+}'
+ip netns exec peer0 nft add rule inet filter output \
+	meta mark == ${MARK} \
+	counter drop
+
+DROP_COUNTER=$(ip netns exec peer0 nft list chain inet filter output \
+	| sed -n 's/.*packets \([0-9]*\).*/\1/p')
+sleep 1
+
+# ping should fail
+for p in $(seq 1 3); do
+	PING_OUTPUT=$(ip netns exec peer0 ping \
+		-qfc 500 -w 1 5.5.5.$((p + 1)) 2>&1) && exit 1
+	echo "${PING_OUTPUT}"
+	LOST_PACKETS=$(echo "$PING_OUTPUT" \
+		| awk '/packets transmitted/ { print $1 }')
+	# increment the drop counter by the amount of lost packets
+	DROP_COUNTER=$((DROP_COUNTER + LOST_PACKETS))
+done
+
+# check if the final nft counter matches our counter
+TOTAL_COUNT=$(ip netns exec peer0 nft list chain inet filter output \
+	| sed -n 's/.*packets \([0-9]*\).*/\1/p')
+if [ "${DROP_COUNTER}" -ne "${TOTAL_COUNT}" ]; then
+	echo "Expected ${TOTAL_COUNT} drops, got ${DROP_COUNTER}"
+	exit 1
+fi
+
+echo "Removing the drop rule"
+ip netns exec peer0 nft flush ruleset
+sleep 1
+
+for p in $(seq 1 3); do
+	ip netns exec peer0 ping -qfc 500 -w 3 5.5.5.$((p + 1))
+done
+
+cleanup
+
+modprobe -r ovpn || true
-- 
2.52.0


