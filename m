Return-Path: <netdev+bounces-262010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHnoGuEwomke0wQAu9opvQ
	(envelope-from <netdev+bounces-262010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:03:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3EA1BF4E6
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF305309136A
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 00:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36561F30A4;
	Sat, 28 Feb 2026 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="FVeaD7YL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BFB30F53B
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 00:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236826; cv=none; b=WwDcj0+K8uVOtxIKvOH3evLrBuDQnD98XoqfxnjU2G4e3SH4YXo3Tnwt/ql+x255LGGuONlBGf6SvR95BFFmeLw4TimvTNe648P06ELlcHwTMaGtPNwTmCzugPgHppRch5M6BVu/akQeVC7V8Do3ppJ+xwBetHgAdlrQBsF41J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236826; c=relaxed/simple;
	bh=853rT8A9XYIfjtXw4TG6HterQA/NNw0zBx8/dhtdAEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pr+b1OLvysH9nZfBtv2c7XNubcSHbuWpMFHZe2rlZu7TV6FF0ARf+EgdYVwvsoYNbHKTbGAwIfa/xrRsg3l+2859Wz0M2iejoz7EBz+684h3gDPCk0dJ7oGrG7IG6eakg8JM93YsrNRgJlhv+tOInjsI1d0wV2juYZn5UNvdCeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=FVeaD7YL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4836f363ad2so29678715e9.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 16:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1772236821; x=1772841621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbB2Tr331FC//FQzvZHi0Oll7EQUhGq6//q/S/UKOtY=;
        b=FVeaD7YLbJI6ze6AACRG5NmqNDbtGGWjFRVzB721QUe5Dt5fM6SXZqVoZxLiOv2VUz
         wRKcTAGP2YuwdSFOg9do+vpeWQLIWS+9IPWsaiQpCCBphic/dJaCVgkpb7mZF6TqL5Uo
         vJ6gWkXyDCDT+EDcJcR9Km+Nd6jJHcLZhldXvgGr92qF2AdyQ9se3gcOJ2z8Uc13v/T2
         7Z27+0gSTT11oIQLl1RgWm+VcWPs2R0i4//pHnHnwbIYVoCfvKH+VWwA4mWIsFZrRMlv
         lmGsJiuHcMVYThnXNki4YlrKBkvDRbz7E8BHptFiBW2HEI0t+99soxlxMu+NWLJhrPL+
         zXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236821; x=1772841621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zbB2Tr331FC//FQzvZHi0Oll7EQUhGq6//q/S/UKOtY=;
        b=YD4A7V+LUx74O0GPgyGzfITrkjzhC+Ds+EQM4UwbbSIfcQ+8nt60hoEpjqcd7If9lH
         IYjsnIxWH7ytRFcbuh3ZPmF/8AMH9C2D+afLAEN9bdpNEVbvPFCCTrxUEnAPy8nkGrOM
         85vrZavROF8E4PhJ/pBop90/dx9Te75TKF/paj37RsJKIHacrARjbRPWisQ/MpfvPjaZ
         SAFFfsF+uM5RmP3A0XCMNwqKNI0vXcqHUIwykozMAkmKOwWP8AM47HutRzJ8YGa3JZCj
         G/JsI25PRVJdpM6zJdi2+PIjUlxjZbSSBekNOU5TpR5ExIzgH2ThTPQTm0fWVS87vT5T
         oKyg==
X-Gm-Message-State: AOJu0YxeGi0FuqP5zq95TaBcbZ/cN1WyVxvtzs2GwE3vr7/dFtQuv8hp
	MPzYZGEYo+DXtD0FChcZr6p4NyNP0pAgPcqdVdtkp9wIjsh85lGq7HSDzt+/jOOml+2MG4cRvZq
	MjJ/H8a0mzIcVaP7qboUsJAOOVyy7clOeTq5WtTKenUj7A2j3SsN1uBG2Y6qKyvra
X-Gm-Gg: ATEYQzxmdnjDQNxbSylj5w5tgqBDycrekt+RCJbaklCWtqb1DxO3OK2f6lcGuCQBP+Z
	U2JGCU3KkLk75u2G83rw28BXxxmrdlDI4C1xotpcEkiZAZuJSBpQrf8TqOpHnPSsYwIRWNxxlFW
	oSpSc7l8PMQiK6YRiG8fyt66T6iWL2WP9A/KiWYuRwHLlOcbWFPALpAkG4a5oBnBO+NVlrBG1m+
	konYMtIo0SofSR1YWpbwD6xT2LbUVoFkBgy5gKH927C91/VsNT3Fg9uQ97BmbecVMOymma0HCrf
	j/4yOoZI7PcyqGqC9s5rscZIAW7Zgsrr/GRUNKtWUPTjecCpDRT2XMGy0iYc8LTypwrP/5Wo7Jp
	/pGDoSthJGReAzmMY8uP9BF2GjSqIoTT7Ox30s5VbEx2iCBYRkivj+svtIQyYYoiLWDFfGqWhu3
	VSmxY7zhdSNQWPC1zzpu2Gud8BSYXfa6BlWlHD
X-Received: by 2002:a05:600c:a16:b0:483:2c98:4368 with SMTP id 5b1f17b1804b1-483c9c02ef1mr70044625e9.18.1772236820704;
        Fri, 27 Feb 2026 16:00:20 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:d378:d869:cb10:1603])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb77466sm94420695e9.5.2026.02.27.16.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 16:00:19 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 5/9] selftests: ovpn: add notification parsing and matching
Date: Sat, 28 Feb 2026 00:59:51 +0100
Message-ID: <20260227235955.660-6-antonio@openvpn.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262010-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.987];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openvpn.net:mid,openvpn.net:dkim,openvpn.net:email,mandelbit.com:email,req.name:url]
X-Rspamd-Queue-Id: BD3EA1BF4E6
X-Rspamd-Action: no action

From: Ralf Lici <ralf@mandelbit.com>

To verify that netlink notifications are correctly emitted and contain
the expected fields, this commit uses the tools/net/ynl/pyynl/cli.py
script to create multicast listeners. These listeners record the
captured notifications to a JSON file, which is later compared to the
expected output.

Since this change introduces additional dependencies (jq, pyyaml,
jsonschema), the tests are configured to check for their presence and
conditionally skip the notification check if they are missing.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 .../selftests/net/ovpn/check_requirements.py  | 41 +++++++++++++++++++
 tools/testing/selftests/net/ovpn/common.sh    | 35 ++++++++++++++++
 .../selftests/net/ovpn/json/peer0-float.json  |  9 ++++
 .../selftests/net/ovpn/json/peer0.json        |  6 +++
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
 .../selftests/net/ovpn/requirements.txt       |  1 +
 .../testing/selftests/net/ovpn/tcp_peers.txt  |  1 +
 tools/testing/selftests/net/ovpn/test.sh      | 10 +++++
 19 files changed, 115 insertions(+)
 create mode 100755 tools/testing/selftests/net/ovpn/check_requirements.py
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
 create mode 120000 tools/testing/selftests/net/ovpn/requirements.txt

diff --git a/tools/testing/selftests/net/ovpn/check_requirements.py b/tools/testing/selftests/net/ovpn/check_requirements.py
new file mode 100755
index 000000000000..6434ebbfe7fe
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/check_requirements.py
@@ -0,0 +1,41 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 OpenVPN, Inc.
+#
+#  Author:  Ralf Lici <ralf@mandelbit.com>
+
+from importlib.metadata import version, PackageNotFoundError
+from packaging.requirements import Requirement
+from packaging.version import Version, InvalidVersion
+from pathlib import Path
+import sys
+
+def check_requirements(requirements_path="requirements.txt"):
+    issues = []
+    with open(requirements_path) as f:
+        for line in f:
+            line = line.strip()
+            if not line or line.startswith("#"):
+                continue
+            try:
+                req = Requirement(line)
+                try:
+                    installed_version = Version(version(req.name))
+                    if req.specifier and installed_version not in req.specifier:
+                        issues.append(f"{req.name}=={installed_version} does not satisfy {req.specifier}")
+                except PackageNotFoundError:
+                    issues.append(f"{req.name} is not installed")
+                except InvalidVersion:
+                    issues.append(f"{req.name} has an invalid installed version")
+            except Exception as e:
+                issues.append(f"Could not parse requirement line: '{line}' ({e})")
+    return issues
+
+problems = check_requirements()
+if problems:
+    print("Dependency issues found:")
+    for p in problems:
+        print(" -", p)
+    sys.exit(1)
+else:
+    sys.exit(0)
diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 88869c675d03..f2b58361255d 100644
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
@@ -48,6 +54,18 @@ setup_ns() {
 	ip -n peer${1} link set tun${1} up
 }
 
+has_listener_requirements() {
+	./check_requirements.py && jq --version >/dev/null 2>&1
+}
+
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
@@ -82,6 +100,23 @@ add_peer() {
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
+		diff <(jq -s "${JQ_FILTER}" ${expected}) \
+			<(jq -s "${JQ_FILTER}" ${received})
+		echo "OK"
+
+		rm -f ${received} || true
+	fi
+}
+
 cleanup() {
 	# some ovpn-cli processes sleep in background so they need manual poking
 	killall $(basename ${OVPN_CLI}) 2>/dev/null || true
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
diff --git a/tools/testing/selftests/net/ovpn/requirements.txt b/tools/testing/selftests/net/ovpn/requirements.txt
new file mode 120000
index 000000000000..da9fd54081c5
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/requirements.txt
@@ -0,0 +1 @@
+../../../../net/ynl/requirements.txt
\ No newline at end of file
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
index e8acdc303307..3ec036fd7ebc 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -17,6 +17,12 @@ for p in $(seq 0 ${NUM_PEERS}); do
 	create_ns ${p}
 done
 
+if has_listener_requirements; then
+	for p in $(seq 0 ${NUM_PEERS}); do
+		setup_listener ${p}
+	done
+fi
+
 for p in $(seq 0 ${NUM_PEERS}); do
 	setup_ns ${p} 5.5.5.$((${p} + 1))/24 ${MTU}
 done
@@ -112,6 +118,10 @@ for p in $(seq 3 ${NUM_PEERS}); do
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


