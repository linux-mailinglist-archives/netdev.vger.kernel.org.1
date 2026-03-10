Return-Path: <netdev+bounces-266204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CbTF6Y3sGkKhQIAu9opvQ
	(envelope-from <netdev+bounces-266204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:24:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EE92534F3
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E720C3292FA9
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D0C30C356;
	Tue, 10 Mar 2026 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="AMt3zVbc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E8D30F806
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154240; cv=none; b=tlm7IfdKa3SHXcgdrAKBkHzSBT+v7x57DP4eErNQs7KcJ/YUlpBJb9lupUmti0jt43zmmILkU6a8WNsOHmEaUfosfOSmuvavR3/yCAQt/9NJWqpEvRX2CHhiYiQ5YvsDS2bsTxooJH1tJy6Qs54613qjaXuKlt0DnVh5ZqATr0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154240; c=relaxed/simple;
	bh=HeMGDyF9dBpQXaVmwG0QTiwumSdppPensQWCjcnsyos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StJyMNfVkuvzrb+ZDVxN5RCoHj1R6GIxsep1H6vTUjc2qFo6YV770eEpZFkdYIEFoBEb/cX/mAJ4iAODjta/hOizPH0140219bcHzjlVhbAwYNF1UJvunX89BX9v9oBq2Sr8tHdzvN2vfIn7nTbO0uXveDFsRwNARCQDX7cXQbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=AMt3zVbc; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439b2965d4bso7663571f8f.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1773154237; x=1773759037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nK4qYZgQdyi3oF+Fs4fMvWt7l8FWxonwPMP9g/CfoUo=;
        b=AMt3zVbc5JVTVODfD8uiUunZzdCl1baFN8IXAxUwUsM7Lq5uOrNCHL48WVDKaedUz5
         OFgJUw3scz/vboczlK7pfdxoYdY1FEEcBcqO6vx1oLjRzlrkw9D8Ljwoobu+X1uZifpw
         HqXzLRPIIk21mbYMby5QAj/VyMwU8dx3IDE4zqi7UwkFcZZVMIaMeP/iicL8eAttfulg
         +9MavkGPZDdNYFiGGbkusGhIMcyKLTQNcvWj68YQxgaCt8HHYdHQcebXj1VGmAQKb9ge
         f5DmplbttwSoKFjRI+XJk0/kahfyj6iX/Mi5S6qmJ2FddIF69UXIyFJOh4xa2CkQY7XC
         YLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773154237; x=1773759037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nK4qYZgQdyi3oF+Fs4fMvWt7l8FWxonwPMP9g/CfoUo=;
        b=VWPBBOCpiY2+K1BJ2fRHBs0gkpw962EoAgA5BuZ+t0oLIBYFU+gBz3x6L5P9IG7MQV
         PdIOXEIqdaGvaI8zT/euECRTqcWkwt/IyxK71uDp35Qcub2U/KZnzjvyBHClErEf8lvC
         KytHa/AoYjMLYGsaFXWTPxjTgS6EIgMD74yyMSj74f3nsEViwbus/i7kxV0bbap5UxVq
         E9ZiXTyWCP6Q29hL0MwmbEff64xFajz+wXorx8i9xLj8MtmZd1Wghhr0VDp9PPY6ZX0c
         KBD16r+63YLi9zz7JFklYJKokDpaWXxzcskQz7HbDJ3UQ42c200ez3soF3MSwhkbp8Qi
         7YqQ==
X-Gm-Message-State: AOJu0Yy6SnUuxOJdhOELYmFtM5aYrDMVXt2ujWXojSoO2XXzRpftO7ZQ
	h5jxUwWGlTNJCxK7XatuHyzIaUXywzOiWakgEzquhpc8sYcJ2k1hX+J9Gq+eTIJHfAt5uZXYoXR
	XRqoPEOS2o7+loR96ORFzAoCgC6ZlUwWQMx906X23npKdONAmMINKdo7ARqc1YbDl
X-Gm-Gg: ATEYQzy5Kk20s9IaW0jVZp2XQXhXRfHwppi7/9fw5AKoLXRwIjhqO3kca/H15a/o1WH
	9tJ2QGVVrHdGgJc3Sg3gaGjYiiPMWGlScKRa+1r+2nWwCsNxihB0Un6cK/xOxSajx1N8JaWnFnp
	NgWA1mcsQGZA/PFH5tc8Yvjj4QrAFzJaCZLp3Pqc+RcTPRMjl/sCIs1wfyIsbMoJfOCBigaQ0pn
	AxM8g+tj8ceZQW0djsTS84Q1Dgjp5LkEqch7zxrqBVrnnlJNu8mNnLevGFtypk17bL8NvK5VuK1
	cV0qYCd3WGIZF9bupEmbQRw97KHkyFaIo1WzWgjbWLSeYIBRctj5qOJPa1vdSpEylnb9980gjlF
	wCYMdFu2Ei9o5VZ7VzBlwVmoqzB5sbpUF5RUwvlUApsCSALuW9yCoN5P/XvfUVNE9H7HWEhFCSW
	RMDdbQLdVuTWz6zEX4jsT63eTzK2HI6cV7JmQl
X-Received: by 2002:a05:6000:40cc:b0:439:b811:11de with SMTP id ffacd0b85a97d-439da3483c8mr27444471f8f.7.1773154236464;
        Tue, 10 Mar 2026 07:50:36 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:5594:94ef:1bd6:89e8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm35586700f8f.6.2026.03.10.07.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:50:36 -0700 (PDT)
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
Date: Tue, 10 Mar 2026 15:50:05 +0100
Message-ID: <20260310145006.30858-9-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260310145006.30858-1-antonio@openvpn.net>
References: <20260310145006.30858-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 08EE92534F3
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
	TAGGED_FROM(0.00)[bounces-266204-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:dkim,openvpn.net:email,openvpn.net:mid,test-mark.sh:url,mandelbit.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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
index 0a673327ba9d..5d17d7330bd5 100644
--- a/tools/testing/selftests/net/ovpn/Makefile
+++ b/tools/testing/selftests/net/ovpn/Makefile
@@ -38,6 +38,7 @@ TEST_PROGS := \
 	test-close-socket.sh \
 	test-float.sh \
 	test-large-mtu.sh \
+	test-mark.sh \
 	test-tcp.sh \
 	test.sh \
 # end of TEST_PROGS
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index 5b58aca9366c..7f5a3737666c 100644
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
@@ -1693,13 +1705,14 @@ static void usage(const char *cmd)
 	fprintf(stderr, "\tvpnaddr: peer VPN IP\n");
 
 	fprintf(stderr,
-		"* new_multi_peer <iface> <lport> <peers_file>: add multiple peers as listed in the file\n");
+		"* new_multi_peer <iface> <lport> <peers_file> [mark]: add multiple peers as listed in the file\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
 	fprintf(stderr, "\tlport: local UDP port to bind to\n");
 	fprintf(stderr,
 		"\tpeers_file: text file containing one peer per line. Line format:\n");
 	fprintf(stderr,
-		"\t\t<peer_id> <tx_id> <raddr> <rport> <laddr> <lport> <vpnaddr>\n");
+		"\t\t<peer_id> <tx_id> <raddr> <rport> <laddr> <lport> <vpnaddr> [mark]\n");
+	fprintf(stderr, "\tmark: socket FW mark value\n");
 
 	fprintf(stderr,
 		"* set_peer <iface> <peer_id> <keepalive_interval> <keepalive_timeout>: set peer attributes\n");
@@ -2243,6 +2256,15 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
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
index 000000000000..80fb31b99710
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
+ip netns exec peer0 "${OVPN_CLI}" new_multi_peer tun0 1 "${UDP_PEERS_FILE}" \
+	${MARK}
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


