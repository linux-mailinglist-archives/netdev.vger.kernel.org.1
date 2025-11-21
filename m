Return-Path: <netdev+bounces-240597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7538DC76BFF
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 01:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFB434E6991
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 00:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A79D22541B;
	Fri, 21 Nov 2025 00:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="gA6pxalI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A10F2264CB
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684458; cv=none; b=NjNAgsG80wmNf1A9i/PT7wW9V4/fxYG+JuL9yKpQjFsrCyogR4+2+MjN7X6nFkZJb4YLEJiS4IGmvanu8KybfAW04fGiwnYGRaTN9dHBt8yiDD9e1hk3Db5/xbm8vs2yPpL15sPnWauuMHWI7BPD3Pw/oqF1N9DVOlSykM5orTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684458; c=relaxed/simple;
	bh=gdYrKhRj3kzju7DU7sKCHHC6ZsHI13PpfXJohTkEgDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJBhDD4LBbwDEHx9Yxv9BzLdbOb+ROEtcPXX+12fxx1R59CGdoWsl2jPuC5z37mMO66vgcKVSz40yORemD5N1WJ90lRqb6rEKL+5o9IUrPDhEERM4LR+xz3kR8rZZL5Smzf5tb0xuGR9xSCRw1JBnidq2tGuv6PTsusIuBJ7dpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=gA6pxalI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4775ae77516so15910815e9.1
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 16:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1763684453; x=1764289253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keqbujaUrQ9/mbdh4PnlSuWLx1cD1KFzHl7vLu5L6l4=;
        b=gA6pxalIt6SSiFGu+0Zh5hMwPIAa2xYOhULsFhAdiivBbUe4V2OrsySxckwKRkONrG
         jzMHTAJ7DgyERNwiRev9mWC8y27NQA5fHp5qqs6KdXfMLkYvElU/kFcmnOxokIyKB0wK
         L8OxORYvbi40420FWHVmTi7oJpXleHskkeVoiwgavbFeCFBnPzf5+7PT/5hgslWFazDU
         6vhK98MslOC9DkUHOLWRLkj59RNTcb251wU4k1WQCisIHgROY/CXQITdK+7/XuHjHWr8
         It0bZ0Dv5mqcX5GsU87ix+IJnBSGiQvj5T+Q0ZWRMAevg0xYIINrkTGfdhgOh2eSo9Jv
         e4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763684453; x=1764289253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=keqbujaUrQ9/mbdh4PnlSuWLx1cD1KFzHl7vLu5L6l4=;
        b=aYidTDMJ1dspA2N4bNQKBPFirxspJAIu7yFzt1IT5Iqjwu1VABu94j7Du1KmqPgt0p
         sexW0Pe+Ygv1J+a7C0MYJyVuPgiJfLGSUU362fEcc+bAaI7EAKD2hCCiCdvKjLhK8uef
         wM6jr8VDm3Tphphy+O7rVsmrZrngRNQCxXZq9jN5xML85bJseZ38XsV2mVhE8/0yrhzo
         sWD2SOPhZ66nyIZLpoz0HoUjE64eqSOGyELeAo6gb1kM4W6N1gjtJlzifQUXUXhSbZh2
         nqAiAc8U7fhc19szCF1OFOcNMNiFISMFLpCQuXd3bZUVWWR1JiAnuHNoNS9Coq5JY1w+
         ngtw==
X-Gm-Message-State: AOJu0YyGbSpgBHvdDXPflxJap87xOuM9eKaZlj3ZIGy1BOWC6+aoK6j8
	85uUN0QEWYEKXw7bsAN9oRetVFvbmBylE706xlF0uHkB8lduqk9pN8z8ziIPb3JcQv8YVGj5WH0
	zFEvM+DL1+2czO++1/CzMh1b61ZZzGGCnrUR41bvByrOMlEbo3ZCgf6GicqkbWGM1DRQ=
X-Gm-Gg: ASbGnctnkQCXWcOa0qeSCxi+uLmK0C8bdfx24KYbWFWQZtzPCz0yVpqM8jJBD1CGugB
	yubmapJh43KyEfmJweEgHG/1QbAe4PpKLbwD73Bwkrd9rqVW5kHyNCLo4EVmmbouFdEs+o12ICm
	utn5vbUe7ADP2lVClscucFGBCg4yMy5DA4DATH7rux8GeCaeF7YxyrK1W8MjSfO3XzORKe+Dau3
	WUCQ8AiTVPDKBvnfbYoxVYByg+GCxzk2kYbwFy/jVFecOF9Hd2aywt4/9S9w8hoxGhk28HbjRQo
	ESkzv2s7EPaezyxU34tesdD85LlbJJA4B8lahRiDCHqAz/rDwNfgSVnF0kV9fHDMK5qrEGDRnOn
	wFxfViiycmkXDUH+VS34C8wCGXHEaySj5p7xqgQTGq93TM5rC65z7838Tg6MrLLgCas/YPm1VyN
	RU2JpCHSTJUWUTkCrTsrHvHsPUIcPMQjYoVoQ=
X-Google-Smtp-Source: AGHT+IHhYXs2hrM6dLL1MHkJ82WPBKUDKUmWh4KtzKc+lO91Y8elBtxhvasECave9iLFTvRHqwEiFA==
X-Received: by 2002:a05:600c:3ba1:b0:475:dd89:acb with SMTP id 5b1f17b1804b1-477c11160cdmr1393435e9.22.1763684453289;
        Thu, 20 Nov 2025 16:20:53 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:85ee:9871:b95c:24cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf226bf7sm15287345e9.11.2025.11.20.16.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 16:20:52 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [RFC net-next 02/13] selftests: ovpn: add notification parsing and matching
Date: Fri, 21 Nov 2025 01:20:33 +0100
Message-ID: <20251121002044.16071-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251121002044.16071-1-antonio@openvpn.net>
References: <20251121002044.16071-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 .../selftests/net/ovpn/check_requirements.py  | 37 +++++++++++++++++++
 tools/testing/selftests/net/ovpn/common.sh    | 34 +++++++++++++++++
 .../selftests/net/ovpn/json/peer0-float.json  |  9 +++++
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
 19 files changed, 110 insertions(+)
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
index 000000000000..1b8764c2527d
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/check_requirements.py
@@ -0,0 +1,37 @@
+#!/usr/bin/env python3
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
index 88869c675d03..b91cf17ab01f 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -7,12 +7,17 @@
 UDP_PEERS_FILE=${UDP_PEERS_FILE:-udp_peers.txt}
 TCP_PEERS_FILE=${TCP_PEERS_FILE:-tcp_peers.txt}
 OVPN_CLI=${OVPN_CLI:-./ovpn-cli}
+YNL_CLI=${YNL_CLI:-../../../../net/ynl/pyynl/cli.py}
 ALG=${ALG:-aes}
 PROTO=${PROTO:-UDP}
 FLOAT=${FLOAT:-0}
 
+JQ_FILTER='map(select(.msg.peer | has("remote-ipv6") | not)) | map(del(.msg.ifindex)) | sort_by(.msg.peer.id)[]'
 LAN_IP="11.11.11.11"
 
+declare -A tmp_jsons=()
+declare -A listener_pids=()
+
 create_ns() {
 	ip netns add peer${1}
 }
@@ -48,6 +53,18 @@ setup_ns() {
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
@@ -82,6 +99,23 @@ add_peer() {
 	fi
 }
 
+compare_ntfs() {
+	if [ ${#tmp_jsons[@]} -gt 0 ]; then
+		[ "$FLOAT" == 1 ] && suffix="-float"
+		expexted="json/peer${1}${suffix}.json"
+		received="${tmp_jsons[$1]}"
+
+		kill -TERM ${listener_pids[$1]} || true
+		wait ${listener_pids[$1]} || true
+		printf "Checking notifications for peer ${1}... "
+		diff <(jq -s "${JQ_FILTER}" ${expexted}) \
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
2.51.2


