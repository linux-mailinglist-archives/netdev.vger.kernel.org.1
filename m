Return-Path: <netdev+bounces-268548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMG+EVUxuWn4uAEAu9opvQ
	(envelope-from <netdev+bounces-268548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:47:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BD12A8353
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4842830A0058
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAC53A8732;
	Tue, 17 Mar 2026 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="LCqTe50o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3985E3A7F61
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744042; cv=none; b=cBJTEpJRUjjWARuhV4tGRNWIG3tia/p/46ARrqO5Hbevq4B0GG4JHbFuJw5UN2zVJvCpNMzPGd7X0KXrG6VxcEcGGJVKZJzPMVmBdAeMr4tL8A/mTUPneY5g06gkeRPpdEeR+0nUBvSbu0dkQnbj+CdTLELPOiYtFJA8Vm5PXB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744042; c=relaxed/simple;
	bh=Z7TKiU2baXfDULkwj1ImK1LH2PaAIfWpDYtrKG0uRPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBEQIGClcuKZ/3CUS6+5J79t5qi/RjW/SgSgHf5rssxjux6Tqqi1FWcKwITB+++z+v5AkUrvuk/IzgES0Ybz4tergWEQsNo+/rm0KCK6bZAqsIgREUy/DDifKZQ0b43+Xq+KuL8MHv2nJkhqfZ2agOhdCIoWEHOJD/y6xFF5noY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=LCqTe50o; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43b3d9d0695so574871f8f.0
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 03:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1773744038; x=1774348838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAk6/0FI/V+IuzszsYv8m/anwRDhiaLOVZ296LqlboI=;
        b=LCqTe50o3NCebmiEQNYPbm4oPyRF4PFXLOoyATFgvgLcT00wL/XG6eDQiI8gnkj0JS
         5+zJpn1js/ByujKoqoCHIPtnkdfC7mKW+rG6KvL3FbBWHh5MyqrHcyKaYwMyZ85IT4Lr
         aS7V++b0liGxfajrqUmmajzAFZ6Qrx/GObEAMXiBssX+21yT/6YT/e9PyezzwgZwvY/H
         tY0B1hTxe1xFDlON47GqaFgbmiCogNoE7WJfz60w+SCrfMjWUMJYchYJpUVOwxGh6y50
         zs+Yt7alLUVfvzTX7EiYTEIPfIWN300TJGeIFSvSQUDtzEReEhxJGcA3AX90qGLdu45+
         Cp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773744038; x=1774348838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xAk6/0FI/V+IuzszsYv8m/anwRDhiaLOVZ296LqlboI=;
        b=Korm5RU67cpc66J316BnMWVOUVPR5lXHwTVsPdf2VY7iCqjVYsPpRCYUbSwIdpDng7
         gKYMCAy9pRVlCEEdLnBvX9HQ5n4zpCYC3fnZF1XOnGhOkOkYAJYH1pT1fzhiVcx/0fP4
         1Jhi0MktxhUqGqK/DH3i2hdYn3ekhaa6UdDWPyV0IrKIkG3I9860A7OR7kNR+XxFxVz/
         8q5b7i2tvfmocSueAG1RAcbwXsXCeFBI+wALKcYUciDiT84tATrLhtyiYSMW777satdh
         MIMJf1a4hV6acLNXOfVBhBizynregeO4ARoZ6CuS3UG88Tv1Jxe2LnzgGf5Hg8sGkzWr
         UVSA==
X-Gm-Message-State: AOJu0YxQfM7b/eaNod0YRo9lRLJ/RJAofE0JfFnT9apjAADsLAqMcAXH
	UqDGuYJJiKbBf/CFLeTU8cBSiX1ZrtALVEfHXyyojDzc2vNcb2Bz9Ay6Kebrnv51zAMCh7oAiUm
	cOEPiY1nK42Sozr5YZZNvC2M17aZ99Vzj1bUU9YikBQ9xh7E5UDpZN0goA3a+lm9K
X-Gm-Gg: ATEYQzyl6y+7e/wrOMegfRLn3z0rVys1yiod51Jnz90ShZ8h1gIEJ/d9L+QmZqd1t6o
	VncIfVB8oj1N4F9BVsHJgEwOwuqYoSKgjvTq2Zdunzb2c0QmdrpUZ6BV+QGkEMtyZjIjN5I+wj6
	ykhDqVgGzA7g2q7LKcJqxSG1jGBomFB5GCUoFpCEJ/LQrJtaWYQH+rPVOQ513Bzeqss6jwq3agv
	yDieOm662XNnlsqDT7wtZf0GnhegT2929AFBonSW0ymsoKwADnHMlGudtlJa2IDy0ZOrG/u87Wb
	5ZeuFY4ZA4VEXQp5d3lHgjVaN9/dQiO12RLpxioxdrfTqm6IKDvkhtAnDl8M0bnx1DPm9V1uCP6
	gVyJHGPzgScgVvp+yPwmpSbhEwql0ZizVPAffyIv55WJIgMojYBGeyA6r3KdJVujZyTUJHe+B/o
	/PD1Izbt9wrTpGkP6aj5j+2GeFCCCEhwmb/bc=
X-Received: by 2002:a05:6000:616:b0:439:bee4:8a93 with SMTP id ffacd0b85a97d-43b498207b4mr5243996f8f.12.1773744038046;
        Tue, 17 Mar 2026 03:40:38 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:4f22:3f9:13dd:cf23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22529csm49948215f8f.31.2026.03.17.03.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 03:40:37 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
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
Date: Tue, 17 Mar 2026 11:40:22 +0100
Message-ID: <20260317104023.192548-9-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317104023.192548-1-antonio@openvpn.net>
References: <20260317104023.192548-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-268548-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mandelbit.com:email,test-mark.sh:url,openvpn.net:dkim,openvpn.net:email,openvpn.net:mid]
X-Rspamd-Queue-Id: A6BD12A8353
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 tools/testing/selftests/net/ovpn/ovpn-cli.c   | 23 ++++-
 tools/testing/selftests/net/ovpn/test-mark.sh | 96 +++++++++++++++++++
 3 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/ovpn/test-mark.sh

diff --git a/tools/testing/selftests/net/ovpn/Makefile b/tools/testing/selftests/net/ovpn/Makefile
index ce9f79c4f892..169f0464ac3a 100644
--- a/tools/testing/selftests/net/ovpn/Makefile
+++ b/tools/testing/selftests/net/ovpn/Makefile
@@ -38,6 +38,7 @@ TEST_PROGS := \
 	test-close-socket.sh \
 	test-float.sh \
 	test-large-mtu.sh \
+	test-mark.sh \
 	test-symmetric-id-float.sh \
 	test-symmetric-id-tcp.sh \
 	test-symmetric-id.sh \
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index 085446471397..d40953375c86 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -6,6 +6,7 @@
  *  Author:	Antonio Quartulli <antonio@openvpn.net>
  */
 
+#include <stdint.h>
 #include <stdio.h>
 #include <inttypes.h>
 #include <stdbool.h>
@@ -133,6 +134,7 @@ struct ovpn_ctx {
 	enum ovpn_key_slot key_slot;
 	int key_id;
 
+	uint32_t mark;
 	bool asymm_id;
 
 	const char *peers_file;
@@ -523,6 +525,15 @@ static int ovpn_socket(struct ovpn_ctx *ctx, sa_family_t family, int proto)
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
@@ -1704,7 +1715,7 @@ static void usage(const char *cmd)
 	fprintf(stderr, "\tvpnaddr: peer VPN IP\n");
 
 	fprintf(stderr,
-		"* new_multi_peer <iface> <lport> <id_type> <peers_file>: add multiple peers as listed in the file\n");
+		"* new_multi_peer <iface> <lport> <id_type> <peers_file> [mark]: add multiple peers as listed in the file\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
 	fprintf(stderr, "\tlport: local UDP port to bind to\n");
 	fprintf(stderr, "\tid_type:\n");
@@ -1716,6 +1727,7 @@ static void usage(const char *cmd)
 		"\tpeers_file: text file containing one peer per line. Line format:\n");
 	fprintf(stderr,
 		"\t\t<peer_id> <tx_id> <raddr> <rport> <laddr> <lport> <vpnaddr>\n");
+	fprintf(stderr, "\tmark: socket FW mark value\n");
 
 	fprintf(stderr,
 		"* set_peer <iface> <peer_id> <keepalive_interval> <keepalive_timeout>: set peer attributes\n");
@@ -2284,6 +2296,15 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 		}
 
 		ovpn->peers_file = argv[5];
+
+		ovpn->mark = 0;
+		if (argc > 6) {
+			ovpn->mark = strtoul(argv[6], NULL, 10);
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
index 000000000000..8534428ed3eb
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/test-mark.sh
@@ -0,0 +1,96 @@
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
+ip netns exec peer0 "${OVPN_CLI}" new_multi_peer tun0 1 ASYMM \
+	"${UDP_PEERS_FILE}" \
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


