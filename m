Return-Path: <netdev+bounces-267599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILcbA115tGmOogAAu9opvQ
	(envelope-from <netdev+bounces-267599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:53:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6A9289EBD
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82EA531DDF08
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0959637F8DE;
	Fri, 13 Mar 2026 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="CWgrv5BF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CF937F8A5
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773435119; cv=none; b=aQ0E7C6tZ0AFTvh2bzHN0zZM57BkB4qoLa64jgZVK9h3bdOjOr59vuXVIRb2q5sw6ZINtcbMl906HV7DZEzrcGItegYqZ7sREC5GRA52jIg6svHWxZpeOE8EwNxjXL+BUube23n6OWfMSDYrsXV192ebrz4oXVv4SdS+kG9z2wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773435119; c=relaxed/simple;
	bh=EL7bEloufVd322LyZQ/4VMdRZeI+RtsZTJlnbBdoG38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZZ2MSAU56Za4Jo1WdM//HGu5FOFEluHAWHuX8xxNLxMoc6+sVTWPwAAUpBhcpWPJrLqHuWFLF5zr84QJVzyGGrlilrUl2tC9aMBN2qKGbKQ9xZCSjE65EcvgSg8DVXUrWEGNvD/ItJshjN7Gvev3ypg/MEr8Zbki75xXcLIqE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=CWgrv5BF; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439d8dc4ae4so2767687f8f.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1773435114; x=1774039914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWL4aDXH6aVGqYwwMqh4s3vekahA3tRfBinVDUZZsZw=;
        b=CWgrv5BFfZUZFy9pW3i54ohP/wVK31bq2vVQ/HeEJQ/NNvnvdC1fDGvZ1uwHkQCw5K
         FqXa4BhcaIMRqYWKEeUYyDSmrN5rFqlnGdZRrgKCSceeEwyrvAeGHHPSjYaVNqlYsWXz
         EBRpVAGA9DYPNUZQoQFtRWpoWc/TPaot4Gajjy5BZsqijdz7QZmWcWKn9tjJcqfidzwL
         Co6pI/1GaqmGyJ9ITK+QxZjdUElzV9EJFU3uK2qSwiADxlxsrvZRjyFjuKty/JWCNmTg
         0GA/ri3MAp85oiSIzuDBVg+g50aOm9cnpnU2ai+Wr2lO748Io+wiKkWxRXh0ow7IwNN2
         HlbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773435114; x=1774039914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TWL4aDXH6aVGqYwwMqh4s3vekahA3tRfBinVDUZZsZw=;
        b=BdckNO6+w1A5NvnxoBc4qKyI1EdM7niPQk19uYugx11YYn0x8se6wTxgkRcHmcRW0e
         vXThFLlo2vSbwHSwBDZ/h1PsJjjQoJbpbg4YF5I8IttoWMnAs7WYfUpljZUjlsq9Ikcd
         DSVU9wsPYd4SegHYXGLvcUPdQyQhdQPa2s6/d5vkTjexTMuGsP3kY2BvBTEGdh/A6QUm
         FRtjvjv/LiISIWY2LNyB3ZDpqgwd9w1dKe56/EuhsSlI7dEhqgchZdd+FgVmklkc7rWn
         b5msJYv9Q+qeTpjp+At5SLnNF9iY4E+E1kxwqLIQZkPjAW/KVwVs/1aYIwFumyQSUnX+
         X36A==
X-Gm-Message-State: AOJu0YyB3VFM+HX3ZaFBJo/x0CR1TvoYkg139dq5Gt+uIkvWxWwR/hqp
	GNrOMsrUXbJJikw2cG4mBS5Ukg0pLfzzxp/bWlr2a3Q3t2nxZw+a6+EiXwmj+t0I0Ntj9Q1wvKi
	QL6s9rGkKGZFUyrXfXk1ZMkyInQyAhBN6PS3hj8oSLyRY8OKxtAK85DOTcZm4XZ1e
X-Gm-Gg: ATEYQzzHJymcS6vkjT1yE2si91HeYJ/jmNfTl58MMi/3L0iv707gTLvYg9im45WA7Tu
	IEvo4sy3wmXwlSB08ui6Z+0/TVSkA9n3YtVy3oPahXeaIzyF+DQMYxCExNp0xV4/Yl+SHdh64VZ
	CSO7xc2rLg66t5GNMhRXI2EToLHZxYua3UpcFtKs7e8sGRAiTBf/4IXzHDGkop9I/yfyp59b5xn
	mXPnl/qZwJ1T+0cDps5vBJQWxDGYFzTGvM7hKGqC2xpq86i5qgnJJdDgqIYmlyf5sQSmKPrbeA7
	PJ9JqYGfg/Dj2G7A0jpgaeRgyfVVnsJ3s79LrhwwLH8en4KN1qqJ14i+XN7k8TT/CzY+yynQt/k
	fT6iQuzj5uLmH12IewEAPKoEsAEUEW2MnvhqJsWcUcsEiGOj9TE/Ki9yTjD98JvaOVR3nqV3rU+
	3uIzqIJQbHD+Y36eURaAcFd44gA9nQPaJCH8ODWMHwhe+ehhU=
X-Received: by 2002:a05:6000:22c3:b0:439:b440:b8b0 with SMTP id ffacd0b85a97d-43a04dc08afmr8110021f8f.45.1773435114186;
        Fri, 13 Mar 2026 13:51:54 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:9684:4355:e76d:6ae9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2273d9sm23120468f8f.34.2026.03.13.13.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 13:51:53 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	horms@kernel.org,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 5/9] selftests: ovpn: add notification parsing and matching
Date: Fri, 13 Mar 2026 21:51:35 +0100
Message-ID: <20260313205139.2950-6-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260313205139.2950-1-antonio@openvpn.net>
References: <20260313205139.2950-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267599-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[openvpn.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5D6A9289EBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ralf Lici <ralf@mandelbit.com>

To verify that netlink notifications are correctly emitted and contain
the expected fields, this commit uses the tools/net/ynl/pyynl/cli.py
script to create multicast listeners. These listeners record the
captured notifications to a JSON file, which is later compared to the
expected output.

Since this change introduces additional dependencies (jq, pyyaml,
jsonschema), the tests are configured to check for their presence and
conditionally skip the notification check if they are missing.

Cc: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org
Cc: horms@kernel.org
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/Makefile     |  9 ++++-
 tools/testing/selftests/net/ovpn/common.sh    | 34 +++++++++++++++++--
 .../selftests/net/ovpn/json/peer0-float.json  |  9 +++++
 .../selftests/net/ovpn/json/peer0.json        |  6 ++++
 .../selftests/net/ovpn/json/peer1-float.json  |  1 +
 .../selftests/net/ovpn/json/peer1.json        |  1 +
 .../selftests/net/ovpn/json/peer2-float.json  |  1 +
 .../selftests/net/ovpn/json/peer2.json        |  1 +
 .../selftests/net/ovpn/json/peer3-float.json  |  1 +
 .../selftests/net/ovpn/json/peer3.json        |  1 +
 .../selftests/net/ovpn/json/peer4-float.json  |  1 +
 .../selftests/net/ovpn/json/peer4.json        |  1 +
 .../selftests/net/ovpn/json/peer5-float.json  |  1 +
 .../selftests/net/ovpn/json/peer5.json        |  1 +
 .../selftests/net/ovpn/json/peer6-float.json  |  1 +
 .../selftests/net/ovpn/json/peer6.json        |  1 +
 .../testing/selftests/net/ovpn/tcp_peers.txt  |  1 +
 tools/testing/selftests/net/ovpn/test.sh      |  8 +++++
 18 files changed, 76 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer0-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer0.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer1-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer1.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer2-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer2.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer3-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer3.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer4-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer4.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer5-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer5.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer6-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer6.json

diff --git a/tools/testing/selftests/net/ovpn/Makefile b/tools/testing/selftests/net/ovpn/Makefile
index e59271a25d76..88891d9f5c56 100644
--- a/tools/testing/selftests/net/ovpn/Makefile
+++ b/tools/testing/selftests/net/ovpn/Makefile
@@ -23,7 +23,14 @@ endif
 LDLIBS += $(NL_LDLIBS)
 
 
-TEST_FILES = common.sh
+TEST_FILES = \
+	common.sh \
+	data64.key \
+	json \
+	tcp_peers.txt \
+	udp_peers.txt \
+	../../../../net/ynl/pyynl/cli.py \
+# end of TEST_FILES
 
 TEST_PROGS := \
 	test-chachapoly.sh \
diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 88869c675d03..df0a541148fe 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -7,12 +7,18 @@
 UDP_PEERS_FILE=${UDP_PEERS_FILE:-udp_peers.txt}
 TCP_PEERS_FILE=${TCP_PEERS_FILE:-tcp_peers.txt}
 OVPN_CLI=${OVPN_CLI:-./ovpn-cli}
+YNL_CLI=${YNL_CLI:-../../../../net/ynl/pyynl/cli.py}
 ALG=${ALG:-aes}
 PROTO=${PROTO:-UDP}
 FLOAT=${FLOAT:-0}
 
+JQ_FILTER='map(select(.msg.peer | has("remote-ipv6") | not)) |
+	map(del(.msg.ifindex)) | sort_by(.msg.peer.id)[]'
 LAN_IP="11.11.11.11"
 
+declare -A tmp_jsons=()
+declare -A listener_pids=()
+
 create_ns() {
 	ip netns add peer${1}
 }
@@ -48,6 +54,14 @@ setup_ns() {
 	ip -n peer${1} link set tun${1} up
 }
 
+setup_listener() {
+	file=$(mktemp)
+	PYTHONUNBUFFERED=1 ip netns exec peer${p} ${YNL_CLI} --family ovpn \
+		--subscribe peers --output-json --duration 40 > ${file} &
+	listener_pids[$1]=$!
+	tmp_jsons[$1]="${file}"
+}
+
 add_peer() {
 	if [ "${PROTO}" == "UDP" ]; then
 		if [ ${1} -eq 0 ]; then
@@ -82,6 +96,24 @@ add_peer() {
 	fi
 }
 
+compare_ntfs() {
+	if [ ${#tmp_jsons[@]} -gt 0 ]; then
+		[ "$FLOAT" == 1 ] && suffix="-float"
+		expected="json/peer${1}${suffix}.json"
+		received="${tmp_jsons[$1]}"
+
+		kill -TERM ${listener_pids[$1]} || true
+		wait ${listener_pids[$1]} || true
+		printf "Checking notifications for peer ${1}... "
+		if diff <(jq -s "${JQ_FILTER}" ${expected}) \
+			<(jq -s "${JQ_FILTER}" ${received}); then
+			echo "OK"
+		fi
+
+		rm -f ${received} || true
+	fi
+}
+
 cleanup() {
 	# some ovpn-cli processes sleep in background so they need manual poking
 	killall $(basename ${OVPN_CLI}) 2>/dev/null || true
@@ -104,5 +136,3 @@ if [ "${PROTO}" == "UDP" ]; then
 else
 	NUM_PEERS=${NUM_PEERS:-$(wc -l ${TCP_PEERS_FILE} | awk '{print $1}')}
 fi
-
-
diff --git a/tools/testing/selftests/net/ovpn/json/peer0-float.json b/tools/testing/selftests/net/ovpn/json/peer0-float.json
new file mode 100644
index 000000000000..682fa58ad4ea
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer0-float.json
@@ -0,0 +1,9 @@
+{"name": "peer-float-ntf", "msg": {"ifindex": 0, "peer": {"id": 1, "remote-ipv4": "10.10.1.3", "remote-port": 1}}}
+{"name": "peer-float-ntf", "msg": {"ifindex": 0, "peer": {"id": 2, "remote-ipv4": "10.10.2.3", "remote-port": 1}}}
+{"name": "peer-float-ntf", "msg": {"ifindex": 0, "peer": {"id": 3, "remote-ipv4": "10.10.3.3", "remote-port": 1}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 1}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 2}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 3}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 4}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 5}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 6}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer0.json b/tools/testing/selftests/net/ovpn/json/peer0.json
new file mode 100644
index 000000000000..7c46a33d5ecd
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer0.json
@@ -0,0 +1,6 @@
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 1}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 2}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 3}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 4}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 5}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 6}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer1-float.json b/tools/testing/selftests/net/ovpn/json/peer1-float.json
new file mode 120000
index 000000000000..d28c328d1452
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer1-float.json
@@ -0,0 +1 @@
+peer1.json
\ No newline at end of file
diff --git a/tools/testing/selftests/net/ovpn/json/peer1.json b/tools/testing/selftests/net/ovpn/json/peer1.json
new file mode 100644
index 000000000000..5da4ea9d51fb
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer1.json
@@ -0,0 +1 @@
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 1}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer2-float.json b/tools/testing/selftests/net/ovpn/json/peer2-float.json
new file mode 120000
index 000000000000..b9f09980aaa0
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer2-float.json
@@ -0,0 +1 @@
+peer2.json
\ No newline at end of file
diff --git a/tools/testing/selftests/net/ovpn/json/peer2.json b/tools/testing/selftests/net/ovpn/json/peer2.json
new file mode 100644
index 000000000000..8f6db4f8c2ac
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer2.json
@@ -0,0 +1 @@
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 2}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer3-float.json b/tools/testing/selftests/net/ovpn/json/peer3-float.json
new file mode 120000
index 000000000000..2700b55bcf2e
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer3-float.json
@@ -0,0 +1 @@
+peer3.json
\ No newline at end of file
diff --git a/tools/testing/selftests/net/ovpn/json/peer3.json b/tools/testing/selftests/net/ovpn/json/peer3.json
new file mode 100644
index 000000000000..bdabd6fa2e64
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer3.json
@@ -0,0 +1 @@
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 3}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer4-float.json b/tools/testing/selftests/net/ovpn/json/peer4-float.json
new file mode 120000
index 000000000000..460f6c14cd60
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer4-float.json
@@ -0,0 +1 @@
+peer4.json
\ No newline at end of file
diff --git a/tools/testing/selftests/net/ovpn/json/peer4.json b/tools/testing/selftests/net/ovpn/json/peer4.json
new file mode 100644
index 000000000000..c3734bb9251b
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer4.json
@@ -0,0 +1 @@
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 4}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer5-float.json b/tools/testing/selftests/net/ovpn/json/peer5-float.json
new file mode 120000
index 000000000000..0f725c50ce19
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer5-float.json
@@ -0,0 +1 @@
+peer5.json
\ No newline at end of file
diff --git a/tools/testing/selftests/net/ovpn/json/peer5.json b/tools/testing/selftests/net/ovpn/json/peer5.json
new file mode 100644
index 000000000000..46c4a348299d
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer5.json
@@ -0,0 +1 @@
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 5}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer6-float.json b/tools/testing/selftests/net/ovpn/json/peer6-float.json
new file mode 120000
index 000000000000..4d9ded3e0a84
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer6-float.json
@@ -0,0 +1 @@
+peer6.json
\ No newline at end of file
diff --git a/tools/testing/selftests/net/ovpn/json/peer6.json b/tools/testing/selftests/net/ovpn/json/peer6.json
new file mode 100644
index 000000000000..aa30f2cff625
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer6.json
@@ -0,0 +1 @@
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 6}}}
diff --git a/tools/testing/selftests/net/ovpn/tcp_peers.txt b/tools/testing/selftests/net/ovpn/tcp_peers.txt
index d753eebe8716..b8f3cb33eaa2 100644
--- a/tools/testing/selftests/net/ovpn/tcp_peers.txt
+++ b/tools/testing/selftests/net/ovpn/tcp_peers.txt
@@ -3,3 +3,4 @@
 3 5.5.5.4
 4 5.5.5.5
 5 5.5.5.6
+6 5.5.5.7
diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index e8acdc303307..c2904342ec57 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -17,6 +17,10 @@ for p in $(seq 0 ${NUM_PEERS}); do
 	create_ns ${p}
 done
 
+for p in $(seq 0 ${NUM_PEERS}); do
+	setup_listener ${p}
+done
+
 for p in $(seq 0 ${NUM_PEERS}); do
 	setup_ns ${p} 5.5.5.$((${p} + 1))/24 ${MTU}
 done
@@ -112,6 +116,10 @@ for p in $(seq 3 ${NUM_PEERS}); do
 done
 sleep 5
 
+for p in $(seq 0 ${NUM_PEERS}); do
+	compare_ntfs ${p}
+done
+
 cleanup
 
 modprobe -r ovpn || true
-- 
2.52.0


