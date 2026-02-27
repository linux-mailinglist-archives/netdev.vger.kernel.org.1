Return-Path: <netdev+bounces-262013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GByTMyQxomke0wQAu9opvQ
	(envelope-from <netdev+bounces-262013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:04:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3072B1BF4F7
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9B5631A75B2
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 00:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C580C24E4C4;
	Sat, 28 Feb 2026 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="TIiHhRoR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21158245005
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236832; cv=none; b=TSsJi2TsZQLN+hR4B5yG7X8zP02A/MNo5CCe3jPgKdVrcdBKz7Zge/CdzPk9e+r1iL97gKULMbL6Mn57r74DXbkNJr25xn2H1bVWzV9ogf5E2Z1SszX9oEBt3TSkaxCYWUkD9iMDnM7/CQcReGwTPWKqsbTwcdRltFybvmYCK/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236832; c=relaxed/simple;
	bh=Z3FMzG5/gMTg1JaeaXsHyYULxW5TABm37KkuUeZhTfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSZL6ibgPHZMb7vfdFT3sBqG4KHj/DxoUIeD8/oZli8lO9upWHTvbGFuBEkQ5S59KYNMV2+uaT2Gw8v3AqaVZ0UeUOvd8VHgeLPe6Qg4GxQdTVu3d1rHiU2bugktbLAeO/esixTiFojhhUSfRRKkaPRb7QTsuQa3Jq+VX5yHsiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=TIiHhRoR; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48371bb515eso36524715e9.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 16:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1772236829; x=1772841629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZs/y3v7Q+HvPJBfJ0hxcanhVIoQ4rzVvMW7sgsWwVs=;
        b=TIiHhRoRjW20My1vZvGKbgfHVAJUP6PftCw+/UA5B9cqOb1W0HMdBSVGz63VyZcDSM
         de0CprxoiRVJSoEnE+R21Zh6RSXWLQHVfTauNsM+kXJX7WebZZdYwDjFQGJHueOOMElk
         MiWxavOUrz17ORodmLkzX7eUxUJKmXJzIb8970oVsMxrZrsEtEj9a6MNMopF9QJMcgxo
         ZlZVtKdS/OlFlkIUmg0MdXG/CyCy85bo8Dh+aX1S8ISJDQcN7yzdXK6Z07NnONJMc5Lg
         N4KEnNicQX/plzsrDT8AfHep6/fafcm99KRNFy0aA2yazTpEFE15BiPC7tyzwz6QWllc
         fr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236829; x=1772841629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gZs/y3v7Q+HvPJBfJ0hxcanhVIoQ4rzVvMW7sgsWwVs=;
        b=q5zgVJPRgA2AsdtGe/a6PSZPztcVy/TmAmjZFj9vIOI6+L1p7R8OxCOtZEcdJCS75P
         1v994dJuMKCTnIHHxE4vS40Y+Rr1A1xo1oDsYZqM0wTbxaJw8NTcBTyVfGVrzs3gO5cz
         /JnlGGq9e/CKUzBk9DhWWm79Fuhfdh3nBQ0mlrgUr3mebWcfY2sIoLVfO1jmM3I9ZlBr
         VkqFw8OrUEv37AIm+8oB5UdcbVR2xd/Jk6ydcar84/0xmlNgVenJfOaowi9UW/JvZjWt
         nxSwhLpv+QkPMxqoNeClRe3JJW69ML/2XSvRPXVnvm0n+vCyCgeSOoNh0Ef8fNQvgUpY
         wBCw==
X-Gm-Message-State: AOJu0Yyq8ecBCbNghRNdLhT6/fRorL+Ohmsy/o09HEdgGc8ZI4oI/5kh
	n7TVT0nsAa1WIFYbtWK+kD0mqB42DK3b0mUOshchqcZJJqNei0A8YTgjv9yo6QSJ0e2J9ORnT38
	fxRWg1Rb/EvNaSZApCt3MKvf1kbLdogXUO0uuFuxOUIDQh5KuCL5t/MlHkXIASqlF
X-Gm-Gg: ATEYQzxJ5CaGiYntFWilIVmvoEKR1Cgjd/NBbsiFtKgM6ewwqSB4g/S6XNehHXfZY+2
	SGZ5987+T+sh6TgYSh6KynkJPYgc4N+ebjeJ0cu3lGGdTdRpcDmVyxTcFY4fkDzYSKxPEnO5etf
	0S3Wiv9u7ug803DhM0hEZSZW8Fx+y7G2j6hfujPz16n8qpceFuckLYhZM11UXk00PD/2f1LSULH
	zaKQBFeh7ePsVZBeCghp2cEXS6+PevOWidqglzRiYtP9N/ACxPpkH8jE7SoBZbDKGafSj5gsxjM
	Q3kyKwsscciG054SA5YOB51j8LGdMKIDENz5m1DYTNcH8u3z+j9VApBdP5eHyPkEuXLA37SbUk2
	VTGF2L3u3pzFe1ODz5R7gEhS2roNtYH0o63rE/KJfkrnhcyVl/nA5mxddu2S2tDHmDoK0xpBFax
	jD/N4MLh31RlKQ/MXSXsGzmyPe/tz4JmT9YaPt
X-Received: by 2002:a05:600c:a16:b0:483:c35d:3662 with SMTP id 5b1f17b1804b1-483c9c0b96fmr68816455e9.18.1772236829132;
        Fri, 27 Feb 2026 16:00:29 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:d378:d869:cb10:1603])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb77466sm94420695e9.5.2026.02.27.16.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 16:00:27 -0800 (PST)
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
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 8/9] selftests: ovpn: add test for the FW mark feature
Date: Sat, 28 Feb 2026 00:59:54 +0100
Message-ID: <20260227235955.660-9-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227235955.660-1-antonio@openvpn.net>
References: <20260227235955.660-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262013-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.987];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mandelbit.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openvpn.net:mid,openvpn.net:dkim,openvpn.net:email,test-mark.sh:url]
X-Rspamd-Queue-Id: 3072B1BF4F7
X-Rspamd-Action: no action

From: Ralf Lici <ralf@mandelbit.com>

Add a selftest to verify that the FW mark socket option is correctly
supported and its value propagated by ovpn.

The test adds and removes nftables DROP rules based on the mark value,
and checks that the rule counter aligns with the number of lost ping
packets.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/Makefile     |  1 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c   | 26 +++++-
 tools/testing/selftests/net/ovpn/test-mark.sh | 84 +++++++++++++++++++
 3 files changed, 109 insertions(+), 2 deletions(-)
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
index 000000000000..9fb02f611794
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/test-mark.sh
@@ -0,0 +1,84 @@
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
+PROTO=UDP
+MARK=1056
+
+source ./common.sh
+
+cleanup
+
+modprobe -q ovpn || true
+
+for p in $(seq 0 ${NUM_PEERS}); do
+	create_ns ${p}
+done
+
+for p in $(seq 0 3); do
+	setup_ns ${p} 5.5.5.$((${p} + 1))/24
+done
+
+# add peer0 with mark
+ip netns exec peer0 ${OVPN_CLI} new_multi_peer tun0 1 ${UDP_PEERS_FILE} ${MARK}
+for p in $(seq 1 3); do
+	ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 1 0 ${ALG} 0 data64.key
+done
+
+for p in $(seq 1 3); do
+	add_peer ${p}
+done
+
+for p in $(seq 1 3); do
+	ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 60 120
+	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} $((${p} + 9)) 60 120
+done
+
+sleep 1
+
+for p in $(seq 1 3); do
+	ip netns exec peer0 ping -qfc 500 -s 3000 -w 3 5.5.5.$((${p} + 1))
+done
+
+echo "Adding an nftables drop rule based on mark value ${MARK}"
+ip netns exec peer0 nft flush ruleset
+ip netns exec peer0 nft 'add table inet filter'
+ip netns exec peer0 nft \
+	'add chain inet filter output { type filter hook output priority 0; policy accept; }'
+ip netns exec peer0 nft add rule inet filter output meta mark == ${MARK} counter drop
+
+DROP_COUNTER=$(ip netns exec peer0 nft list chain inet filter output | \
+	sed -n 's/.*packets \([0-9]*\).*/\1/p')
+sleep 1
+
+# ping should fail
+for p in $(seq 1 3); do
+	PING_OUTPUT=$(ip netns exec peer0 ping -qfc 500 -w 1 5.5.5.$((p+1)) 2>&1) && exit 1
+	echo "${PING_OUTPUT}"
+	LOST_PACKETS=$(echo "$PING_OUTPUT" | grep 'packets transmitted' | awk '{ print $1 }')
+	# increment the drop counter by the amount of lost packets
+	DROP_COUNTER=$(($DROP_COUNTER+$LOST_PACKETS))
+done
+
+# check if the final nft counter matches our counter
+TOTAL_COUNT=$(ip netns exec peer0 nft list chain inet filter output | \
+	sed -n 's/.*packets \([0-9]*\).*/\1/p')
+[ ${DROP_COUNTER} -eq ${TOTAL_COUNT} ] || exit 1
+
+echo "Removing the drop rule"
+ip netns exec peer0 nft flush ruleset
+sleep 1
+
+for p in $(seq 1 3); do
+	ip netns exec peer0 ping -qfc 500 -s 3000 -w 3 5.5.5.$((${p} + 1))
+done
+
+cleanup
+
+modprobe -r ovpn || true
-- 
2.52.0


