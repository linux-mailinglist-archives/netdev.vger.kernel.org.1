Return-Path: <netdev+bounces-306468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XEKqKf+4UGoT4AIAu9opvQ
	(envelope-from <netdev+bounces-306468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:18:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03009738F33
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:18:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=k7uVzNcq;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306468-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306468-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D18D3130218
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 08:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C943DA7D6;
	Fri, 10 Jul 2026 08:58:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B76C3CBE6D
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 08:58:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673909; cv=none; b=DNXSCHKGROCAFxHVjVJYLb6lOzSduXJI18KEVYQN7cX0DOJQIAehG+uV23jO1Lue2LVa8aNc9TNpm4OocfZ32Qs9/xAky0hzcd0WlsVQujlOusP4kZbM7l3ksUMlJaT4Oz4bDEQZuKuZtuwvURWbLPVqbpxeNd0BfEYNjUx16YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673909; c=relaxed/simple;
	bh=ndX6aQet6+bY8N8rkyjG+9hY1rp5uolLAQLvAF+KO2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tLYrG8VtXHGylQz2suZp4G/1kjg5qxB7LDqJcPXYazVZCQiCIGDBVxPtsvNY47U5JP4Je/EK/4w6JPmkPocAbI4QhFddLAG2okL4psu0WoEZ0m4LPCkbh40HwofhuqBMk+I31kL3R9rjKxw1Y99Umx2qbobXnTnzEJ5gbiYYuik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7uVzNcq; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c7cfa17fedso8825625ad.3
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 01:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783673907; x=1784278707; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6OkQKVlwvD+WNl1QpiIUbf+i0jakbMBoOvXvnGzvw6Q=;
        b=k7uVzNcqrqsRAahz8VcgJGwHWzsRnrde6H2CIDd3QaXn/8Amm0mGopcEppgRpJJMw1
         yGCmO89bqX5CO3NP8yQL+6833K62wYli4ewRa3G/9D6MfUnzrFL1/0bzqMSbYiDKqaRg
         UNjwlwfYdQM/cxPIXbruYxtdpZLajsIZQ4r+DgSd8DdNCjydvl0S5iSu3ZoAdfSWPdzL
         v98zUmF982eLhoBwFGb9gIk90j6YF9ndSeMiCCfkyz5zCT7BMbCHMtcwxPy96v50Gbjy
         wdmql52iwmhP2KKgmWS6K76z1pYYXfl8C6hkropGNN9gokn0lRJ9C7LUZo+cTXljUyXT
         6OSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783673907; x=1784278707;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6OkQKVlwvD+WNl1QpiIUbf+i0jakbMBoOvXvnGzvw6Q=;
        b=fAsQJi+lVPDb1lxUKR42Lrtpx6zHDiHnm2y0LzPjNllv72JUdCBDEfvTiebJinUkOU
         leioKiw6iWPhW6YOEIu71JROZpZgip9NSVcQxjedP9o1iwJhGhMx04xF8fQ0ZizuRhnt
         OhFQBbpuTxH4g6pNLQ41VE1g/fzSYxKn61wiExGbyXT1XJSoTW4sTaP3mMTikszj3yiR
         CdwCsfaDVifYSDrimP3yb/R0K8BV49Lf19woQMvwFvdezr5fYypeHlFd2QK6hse9Y5gG
         WsKKDLPBhBHwGgRqB05O6T3cVpQXkAA3q3NAoFicGQypnGRjgca5CibibK1rZc0R6pfW
         Jetg==
X-Forwarded-Encrypted: i=1; AHgh+RpAhzyVsnFy/wzaoTGDkTpp6f5frjXZSHSebcXv+oQf+GQMIMBGJmlgG8MWa9YJL781r/trUao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlnKsQiWEN2GvcaJx1o7MvnQ7JWNtufs9p/52z2uIrpqrAMZYZ
	eLiwkNUUwW8swwfiV08SFG4zIourlSVIjHj3ZR5zhLnGejTWE710ZCuD
X-Gm-Gg: AfdE7clZvv/5l9B0nTOmZYDyQtv8wHARfK2qDzIOqVj6BVnrgOApNkopoQ75+a9d3cR
	MPTSZz4e8YfTMmUrmh7j9wSlCFxbX6sjBrBxz9xytiRufJAew0fx/XhfkPA5x7aOrRyAPctrgSm
	KUjMo90nkXlyb6Tuw+K/v16fXIs9i974O8doUUzTCtk+goa6kDONKZfWbWpRdxA3JfzjhbWjK+m
	HsYPo3ZebzNaWxMAXow4XNS0BSWJsBX2l6aFKatLs+rvvda60nlTo3XtGWZ5mFgVEVQF74m2e9G
	ekPYc+3TSPVINxEPYPNy66LAwlyIg2NjfHkxciBsnqgJXD7nt8XXDbz8p2OH1DSA9tZkPkBaKpf
	tNVZr4ZAszsAhiJsX0vDzTcs+N7WJ3FKPqpvDAJNQ/SfNgfR8e8Flp8HKnwFz52bMbiwtg/djNE
	VCruQ8JXbgGgXFNIWaOnRzmaA=
X-Received: by 2002:a17:903:1a08:b0:2cc:fe03:dc75 with SMTP id d9443c01a7336-2ccfe03ebf4mr81373155ad.27.1783673906628;
        Fri, 10 Jul 2026 01:58:26 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3da55sm56674275ad.71.2026.07.10.01.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 01:58:25 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Fri, 10 Jul 2026 17:58:17 +0900
Subject: [PATCH RFC net-next 2/2] selftests: seg6: add selftest for End.MAP
 behavior
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-seg6-mobile-end-map-v1-2-99be02d68143@gmail.com>
References: <20260710-seg6-mobile-end-map-v1-0-99be02d68143@gmail.com>
In-Reply-To: <20260710-seg6-mobile-end-map-v1-0-99be02d68143@gmail.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 Andrea Mayer <andrea@common-net.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=17841;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=ndX6aQet6+bY8N8rkyjG+9hY1rp5uolLAQLvAF+KO2Y=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqULQp+ZXxPG7wcdcD6qqIPSvsWyE/KR5fJ7w0l
 xm0mek0griJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCalC0KQAKCRAq19F1Kl0b
 Tcm0D/9PJmh78M/HePx1+5k0Y9uvjYbT/gFq70tfBunZUVoi8K1fdPUt9hmcwnX7Z49sY41FIlA
 eQRgn92t6ao4CHh6YLoTDzkNi+rptb2FvhgSJeobRGsmSRPCOEeXRC4mwOKnLisbS6ULsFAf9I+
 Q7tGK9+TSE4ZIm7K56QsVQtTYPcSEZl58kFzD9Ba/8lxWf/XCS+WLxe3O1czn8VvgyKRUqkd9z0
 1VpnswipX7nmey58LJ6RPz7BLbu+mycysllIpf0qyHITPajvquUCAVBTOr579su0x7NxbWKbx+N
 QtNryU8OPTLy2yCv0kaix8OXaOsZjlOtCV4xmJ63khahdEIAhwfnZy7O7lyPRkBTiqv3VcGjZYF
 PVBE27QK/ktAgPs+DOW6MXhgUMFxgrF7BfdponqVAC/MJNxrULgYNm6GeLUx6pk2HPuFr47DPJa
 ATbgXVvhCSTw4HbcWmxEIvnI1H42gQOio1EtUyYjODPY81Nj96MFHGR5WTuyYPzpXW7tHdzDDRQ
 2nfNmv1n5qqIMx73Opm421CfxcJAaTUoOHJnWg74/l6aegJ8E9iZYysK88RnGKRYYHc+TASbSOw
 iP+zAdh+7Yl/6MTwPsSD7w5deOZvSpTO6rs0E0M1+t2lVkHd2u/CY5xeKN0AfNxd/WLKZ3ZXGTY
 QSWrOkp7rX7dXJA==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306468-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrea.mayer@uniroma2.it,m:andrea@common-net.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:yuya.kusakabe@gmail.com,m:yuyakusakabe@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,end.map:url,srv6_end_map_test.sh:url,lib.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03009738F33

Add tools/testing/selftests/net/srv6_end_map_test.sh covering the
End.MAP behavior over a three-node topology (the script header
documents the address plan).  Five cases are exercised: SRH-absent,
SRH-present (H.Encaps) and SRH-inline (H.Insert) forwarding verified
by ICMPv6 echo with Icmp6InCsumErrors asserted to stay zero, a
malformed routing header verified to be dropped via the route's own
errors counter, and a Hop Limit expiring at the End.MAP node answered
with an ICMPv6 Time Exceeded.  The original and replacement addresses
are chosen with different 16-bit word sums so a transport-checksum
regression cannot cancel out.  The malformed packet is crafted by a
small C helper (srv6_mobile_send) added to TEST_GEN_FILES; the test
SKIPs when iproute2 lacks the seg6mobile keyword.

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 tools/testing/selftests/net/Makefile             |   2 +
 tools/testing/selftests/net/srv6_end_map_test.sh | 360 +++++++++++++++++++++++
 tools/testing/selftests/net/srv6_mobile_send.c   | 139 +++++++++
 3 files changed, 501 insertions(+)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 708d960ae07d..9acdd4187762 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -91,6 +91,7 @@ TEST_PROGS := \
 	srv6_end_dx4_netfilter_test.sh \
 	srv6_end_dx6_netfilter_test.sh \
 	srv6_end_flavors_test.sh \
+	srv6_end_map_test.sh \
 	srv6_end_next_csid_l3vpn_test.sh \
 	srv6_end_x_next_csid_l3vpn_test.sh \
 	srv6_hencap_red_l3vpn_test.sh \
@@ -161,6 +162,7 @@ TEST_GEN_FILES := \
 	so_netns_cookie \
 	so_rcv_listener \
 	socket \
+	srv6_mobile_send \
 	stress_reuseport_listen \
 	tcp_fastopen_backup_key \
 	tcp_inq \
diff --git a/tools/testing/selftests/net/srv6_end_map_test.sh b/tools/testing/selftests/net/srv6_end_map_test.sh
new file mode 100755
index 000000000000..2a45997b6728
--- /dev/null
+++ b/tools/testing/selftests/net/srv6_end_map_test.sh
@@ -0,0 +1,360 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Selftest for the SRv6 End.MAP behavior (RFC 9433).
+#
+#   +------+    2001:db8:1::/64    +------+    2001:db8:2::/64    +------+
+#   | rt-1 | --------------------- | rt-2 | --------------------- | rt-3 |
+#   +------+         veth1         +------+         veth2         +------+
+#                                 (End.MAP)
+#
+# rt-2 holds the End.MAP route for 2001:db8:f::/64 that replaces the
+# IPv6 destination with 2001:db8:3::3 (an address on rt-3's loopback,
+# also used as the final SRv6 segment in the SRH-present scenarios).
+#
+# The original destination 2001:db8:f::1 and the replacement
+# 2001:db8:3::3 have different 16-bit word sums, so any regression in
+# the transport-checksum diff update would corrupt the ICMPv6
+# checksum and bump Icmp6InCsumErrors -- this test asserts that the
+# counter stays at zero across the run.
+#
+# Five cases are exercised:
+#
+#   1. SRH absent     -- plain ICMPv6 echo to the End.MAP SID.
+#   2. SRH present    -- the destination is reached through an
+#                        H.Encaps wrapper that carries an SRH with
+#                        two segments; End.MAP must leave the SRH
+#                        structurally intact.
+#   3. SRH inline     -- the destination is reached through an
+#                        H.Insert wrapper that inserts an SRH whose
+#                        first hop is the End.MAP SID; End.MAP must
+#                        NOT patch the L4 checksum, because the
+#                        receiver's SRv6 processing restores the
+#                        destination from segments[0] before the
+#                        ICMPv6 handler verifies it.
+#   4. SRH malformed  -- a C helper sends a packet whose Routing
+#                        Header type is not 4; End.MAP must drop it.
+#                        The behavior's own errors counter binds the
+#                        assertion to the drop.
+#   5. Hop Limit      -- an echo whose Hop Limit is 1 on arrival at
+#                        the End.MAP node must yield an ICMPv6 Time
+#                        Exceeded from that node, confirming Hop Limit
+#                        handling is delegated to the ip6_forward path.
+
+source lib.sh
+
+readonly PING_TIMEOUT_SEC=4
+readonly END_MAP_PREFIX="2001:db8:f::/64"
+readonly END_MAP_SID="2001:db8:f::1"
+readonly RT3_SID="2001:db8:3::3"
+HELPER_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
+readonly HELPER_DIR
+readonly HELPER="${HELPER_DIR}/srv6_mobile_send"
+
+ret=0
+nsuccess=0
+nfail=0
+
+PAUSE_ON_FAIL=${PAUSE_ON_FAIL:=no}
+
+log_test()
+{
+	local rc=$1
+	local expected=$2
+	local msg="$3"
+
+	if [ "${rc}" -eq "${expected}" ]; then
+		nsuccess=$((nsuccess + 1))
+		printf "\n    TEST: %-60s  [ OK ]\n" "${msg}"
+	else
+		ret=1
+		nfail=$((nfail + 1))
+		printf "\n    TEST: %-60s  [FAIL]\n" "${msg}"
+		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
+			echo
+			echo "hit enter to continue, 'q' to quit"
+			read -r a
+			[ "$a" = "q" ] && exit 1
+		fi
+	fi
+}
+
+print_log_test_results()
+{
+	printf "\nTests passed: %3d\n" "${nsuccess}"
+	printf "Tests failed: %3d\n"   "${nfail}"
+}
+
+cleanup()
+{
+	cleanup_all_ns
+}
+
+trap cleanup EXIT
+
+check_dependencies()
+{
+	if [ "$(id -u)" -ne 0 ]; then
+		echo "SKIP: need root privileges"
+		exit "${ksft_skip}"
+	fi
+
+	for cmd in ip ping; do
+		if ! command -v "$cmd" >/dev/null; then
+			echo "SKIP: ${cmd} is required"
+			exit "${ksft_skip}"
+		fi
+	done
+
+	if [ ! -x "${HELPER}" ]; then
+		echo "SKIP: ${HELPER} not built"
+		exit "${ksft_skip}"
+	fi
+
+	if ! ip route help 2>&1 | grep -qF "seg6mobile"; then
+		echo "SKIP: iproute2 lacks seg6mobile support"
+		exit "${ksft_skip}"
+	fi
+
+	if ! ip route help 2>&1 | grep -qF "End.MAP"; then
+		echo "SKIP: iproute2 lacks End.MAP action"
+		exit "${ksft_skip}"
+	fi
+}
+
+setup()
+{
+	setup_ns rt1 rt2 rt3
+
+	ip -n "$rt1" link set lo up
+	ip -n "$rt2" link set lo up
+	ip -n "$rt3" link set lo up
+
+	ip link add veth1 netns "$rt1" \
+		type veth peer name veth1-rt2 netns "$rt2"
+	ip link add veth2 netns "$rt2" \
+		type veth peer name veth2-rt3 netns "$rt3"
+
+	ip -n "$rt1" addr add 2001:db8:1::1/64 dev veth1 nodad
+	ip -n "$rt2" addr add 2001:db8:1::2/64 dev veth1-rt2 nodad
+	ip -n "$rt2" addr add 2001:db8:2::1/64 dev veth2 nodad
+	ip -n "$rt3" addr add 2001:db8:2::2/64 dev veth2-rt3 nodad
+	# rt-3 also owns the End.MAP replacement SID / SRH endpoint.
+	ip -n "$rt3" addr add "$RT3_SID/128" dev lo nodad
+
+	ip -n "$rt1" link set veth1 up
+	ip -n "$rt2" link set veth1-rt2 up
+	ip -n "$rt2" link set veth2 up
+	ip -n "$rt3" link set veth2-rt3 up
+
+	ip netns exec "$rt2" sysctl -wq net.ipv6.conf.all.forwarding=1
+
+	# rt-3 must accept SRv6 packets so ipv6_srh_rcv lets the
+	# extension header chain through to local delivery.
+	ip netns exec "$rt3" sysctl -wq net.ipv6.conf.all.seg6_enabled=1
+	ip netns exec "$rt3" \
+		sysctl -wq net.ipv6.conf.veth2-rt3.seg6_enabled=1
+	ip netns exec "$rt3" sysctl -wq net.ipv6.conf.lo.seg6_enabled=1
+
+	# Disable HW checksum offload so the kernel software checksum
+	# path runs unconditionally and any csum bug surfaces.
+	ip netns exec "$rt1" ethtool -K veth1 tx off rx off 2>/dev/null
+	ip netns exec "$rt2" ethtool -K veth1-rt2 tx off rx off \
+		2>/dev/null
+	ip netns exec "$rt2" ethtool -K veth2 tx off rx off 2>/dev/null
+	ip netns exec "$rt3" ethtool -K veth2-rt3 tx off rx off \
+		2>/dev/null
+
+	# rt-1: route the End.MAP locator into rt-2.
+	ip -n "$rt1" -6 route add "$END_MAP_PREFIX" via 2001:db8:1::2
+
+	# rt-1: a separate H.Encaps route for the SRH-present scenario,
+	# wrapping the inner ICMPv6 echo in an outer IPv6+SRH carrying
+	# [End.MAP_SID, RT3_SID].
+	ip -n "$rt1" -6 route add "$RT3_SID/128" via 2001:db8:1::2 \
+		encap seg6 mode encap \
+		segs "$END_MAP_SID","$RT3_SID" \
+		dev veth1
+
+	# rt-2: End.MAP -- swap DA from the End.MAP SID to RT3_SID
+	# (an address on rt-3) and forward via the IPv6 FIB.  "count"
+	# enables the per-behavior counters the malformed-SRH test reads.
+	ip -n "$rt2" -6 route add "$END_MAP_PREFIX" \
+		encap seg6mobile action End.MAP nh6 "$RT3_SID" count \
+		dev veth2
+
+	# rt-2: reach RT3_SID (on rt-3's loopback) through the
+	# directly connected neighbour 2001:db8:2::2.
+	ip -n "$rt2" -6 route add "$RT3_SID/128" via 2001:db8:2::2
+
+	# rt-3: return route for the ICMPv6 echo reply.
+	ip -n "$rt3" -6 route add 2001:db8:1::/64 via 2001:db8:2::1
+}
+
+read_nstat_counter()
+{
+	local ns=$1
+	local name=$2
+
+	# nstat -az reports a counter that has never incremented as 0,
+	# which is what we rely on for a clean before/after delta.
+	ip netns exec "$ns" nstat -az "$name" \
+		| awk -v n="$name" '$1 == n {print $2}'
+}
+
+read_route_errors()
+{
+	# The End.MAP route carries "count", so its errors counter
+	# increments once for every packet the behavior drops.  Reading it
+	# binds the negative test to the drop itself rather than to any
+	# unrelated loss on the path to rt-3.
+	ip -n "$rt2" -j -s -6 route show "$END_MAP_PREFIX" \
+		| grep -oE '"errors":[0-9]+' | grep -oE '[0-9]+'
+}
+
+# Test 1: SRH absent.
+test_srh_absent()
+{
+	local before after rc=0
+
+	before=$(read_nstat_counter "$rt3" Icmp6InCsumErrors)
+
+	if ! ip netns exec "$rt1" \
+			ping -6 -c 1 -W "$PING_TIMEOUT_SEC" "$END_MAP_SID" \
+			>/dev/null 2>&1; then
+		rc=1
+	fi
+
+	if [ "$rc" -eq 0 ]; then
+		after=$(read_nstat_counter "$rt3" Icmp6InCsumErrors)
+		[ "$before" != "$after" ] && rc=1
+	fi
+
+	log_test "$rc" 0 "End.MAP forwards an ICMPv6 echo without an SRH"
+}
+
+# Test 2: SRH present (H.Encaps from rt-1).
+#
+# The packet rt-1 emits carries an SRH whose only intermediate
+# segment is the End.MAP SID; the final segment is RT3_SID.  End.MAP
+# rewrites the outer destination from END_MAP_SID to RT3_SID
+# without touching the SRH, so on rt-3 the SRH processing advances
+# to segments[0] = RT3_SID (local) and the encapsulated inner
+# packet is decapsulated and replied to.  A regression that mangles
+# the SRH (e.g. flipping bits in segments_left) would break the chain
+# and the ping would not return.
+test_srh_present()
+{
+	local before after rc=0
+
+	before=$(read_nstat_counter "$rt3" Icmp6InCsumErrors)
+
+	if ! ip netns exec "$rt1" \
+			ping -6 -c 1 -W "$PING_TIMEOUT_SEC" "$RT3_SID" \
+			>/dev/null 2>&1; then
+		rc=1
+	fi
+
+	if [ "$rc" -eq 0 ]; then
+		after=$(read_nstat_counter "$rt3" Icmp6InCsumErrors)
+		[ "$before" != "$after" ] && rc=1
+	fi
+
+	log_test "$rc" 0 "End.MAP preserves an SRH carried by H.Encaps"
+}
+
+# Test 3: SRH inserted in-place by H.Insert (mode inline).
+#
+# rt-1 inserts an SRH between the IPv6 header and the L4 payload;
+# segments[0] is the original DA (2001:db8:2::2), segments[1] is the
+# End.MAP SID.  End.MAP rewrites the outer DA to RT3_SID but must
+# NOT patch the L4 checksum, because the kernel's standard SRv6
+# processing on rt-3 will decrement Segments Left to 0 and restore
+# the destination to segments[0] before the ICMPv6 handler verifies
+# the checksum against the original pseudo-header.  Over-patching the
+# checksum would corrupt it and bump Icmp6InCsumErrors.
+test_srh_inline()
+{
+	local before after rc=0
+
+	ip -n "$rt1" -6 route add 2001:db8:2::2/128 via 2001:db8:1::2 \
+		encap seg6 mode inline segs "$END_MAP_SID" \
+		dev veth1
+
+	before=$(read_nstat_counter "$rt3" Icmp6InCsumErrors)
+
+	if ! ip netns exec "$rt1" \
+			ping -6 -c 1 -W "$PING_TIMEOUT_SEC" 2001:db8:2::2 \
+			>/dev/null 2>&1; then
+		rc=1
+	fi
+
+	if [ "$rc" -eq 0 ]; then
+		after=$(read_nstat_counter "$rt3" Icmp6InCsumErrors)
+		[ "$before" != "$after" ] && rc=1
+	fi
+
+	log_test "$rc" 0 "End.MAP preserves L4 csum across mode inline SRH"
+}
+
+# Test 4: SRH malformed (negative test).
+#
+# A C helper crafts an IPv6 packet whose Routing Header type is 0
+# rather than 4 (SRH), then sends it from rt-1 toward the End.MAP
+# SID.  End.MAP's seg6_mobile_get_and_validate_srh() must return
+# MALFORMED and the handler must drop the packet.  The assertion reads
+# the behavior's own errors counter, so it is satisfied only by the
+# End.MAP drop and not by any unrelated loss.
+test_srh_malformed()
+{
+	local before after rc=0
+
+	before=$(read_route_errors)
+
+	ip netns exec "$rt1" "$HELPER" 2001:db8:1::1 "$END_MAP_SID" \
+		>/dev/null 2>&1
+
+	after=$(read_route_errors)
+	[ "$((after - before))" -eq 1 ] || rc=1
+
+	log_test "$rc" 0 "End.MAP drops a packet carrying a malformed SRH"
+}
+
+# Test 5: Hop Limit expiry.
+#
+# End.MAP delegates the Hop Limit check and decrement to the ip6_forward
+# path.  An echo whose Hop Limit is 1 when it reaches rt-2 must elicit
+# an ICMPv6 Time Exceeded from rt-2 instead of being forwarded, so
+# rt-2's Icmp6OutTimeExcds increments by exactly one.
+test_hoplimit_expiry()
+{
+	local before after rc=0
+
+	before=$(read_nstat_counter "$rt2" Icmp6OutTimeExcds)
+
+	ip netns exec "$rt1" \
+		ping -6 -c 1 -t 1 -W "$PING_TIMEOUT_SEC" "$END_MAP_SID" \
+		>/dev/null 2>&1
+
+	after=$(read_nstat_counter "$rt2" Icmp6OutTimeExcds)
+	[ "$((after - before))" -eq 1 ] || rc=1
+
+	log_test "$rc" 0 "End.MAP delegates Hop Limit expiry to ip6_forward"
+}
+
+main()
+{
+	check_dependencies
+	setup
+
+	test_srh_absent
+	test_srh_present
+	test_srh_inline
+	test_srh_malformed
+	test_hoplimit_expiry
+
+	print_log_test_results
+	exit "${ret}"
+}
+
+main "$@"
diff --git a/tools/testing/selftests/net/srv6_mobile_send.c b/tools/testing/selftests/net/srv6_mobile_send.c
new file mode 100644
index 000000000000..37d75df3704b
--- /dev/null
+++ b/tools/testing/selftests/net/srv6_mobile_send.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Helper for SRv6 Mobile (RFC 9433) selftests.
+ *
+ * Usage: srv6_mobile_send <src-addr> <dst-addr>
+ */
+
+#include <arpa/inet.h>
+#include <errno.h>
+#include <netinet/in.h>
+#include <netinet/ip6.h>
+#include <netinet/icmp6.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+/* RFC 8200 Routing header common fields are 4 bytes; an additional
+ * 4 bytes of type-specific data follow (the Reserved field for the
+ * deprecated type 0, or first_segment/flags/tag for SRH type 4).  The
+ * segment list then runs in 16-byte units, giving a total of 24 bytes
+ * for one segment -- which is what ip6r_len = 2 advertises.
+ */
+struct srh {
+	struct ip6_rthdr rthdr;
+	uint32_t type_data;
+	struct in6_addr segments[];
+};
+
+#define SRH_ONE_SEG_LEN (sizeof(struct srh) + sizeof(struct in6_addr))
+
+static uint16_t csum_fold(uint32_t sum)
+{
+	while (sum >> 16)
+		sum = (sum & 0xffff) + (sum >> 16);
+	return ~sum;
+}
+
+static uint32_t csum_partial(const void *buf, size_t len, uint32_t sum)
+{
+	const uint16_t *p = buf;
+
+	while (len > 1) {
+		sum += *p++;
+		len -= 2;
+	}
+	if (len)
+		sum += *(const uint8_t *)p;
+	return sum;
+}
+
+static uint16_t icmpv6_checksum(const struct in6_addr *src,
+				const struct in6_addr *dst,
+				const void *payload, size_t len)
+{
+	uint32_t nexthdr = htonl(IPPROTO_ICMPV6);
+	uint32_t plen = htonl(len);
+	uint32_t sum;
+
+	sum = csum_partial(src, sizeof(*src), 0);
+	sum = csum_partial(dst, sizeof(*dst), sum);
+	sum = csum_partial(&plen, sizeof(plen), sum);
+	sum = csum_partial(&nexthdr, sizeof(nexthdr), sum);
+	sum = csum_partial(payload, len, sum);
+	return csum_fold(sum);
+}
+
+int main(int argc, char **argv)
+{
+	uint8_t frame[sizeof(struct ip6_hdr) + SRH_ONE_SEG_LEN +
+		      sizeof(struct icmp6_hdr)];
+	struct sockaddr_in6 dst_addr = {};
+	struct icmp6_hdr *icmp6;
+	struct ip6_hdr *ip6;
+	struct srh *srh;
+	ssize_t res;
+	int fd;
+
+	if (argc != 3) {
+		fprintf(stderr, "usage: %s <src-addr> <dst-addr>\n", argv[0]);
+		return 1;
+	}
+
+	memset(frame, 0, sizeof(frame));
+	ip6 = (struct ip6_hdr *)frame;
+	srh = (struct srh *)(frame + sizeof(*ip6));
+	icmp6 = (struct icmp6_hdr *)(frame + sizeof(*ip6) + SRH_ONE_SEG_LEN);
+
+	ip6->ip6_flow = htonl(6u << 28);
+	ip6->ip6_plen = htons(SRH_ONE_SEG_LEN + sizeof(*icmp6));
+	ip6->ip6_nxt = IPPROTO_ROUTING;
+	ip6->ip6_hops = 64;
+	if (inet_pton(AF_INET6, argv[1], &ip6->ip6_src) != 1) {
+		fprintf(stderr, "invalid src %s\n", argv[1]);
+		return 1;
+	}
+	if (inet_pton(AF_INET6, argv[2], &ip6->ip6_dst) != 1) {
+		fprintf(stderr, "invalid dst %s\n", argv[2]);
+		return 1;
+	}
+
+	srh->rthdr.ip6r_nxt = IPPROTO_ICMPV6;
+	srh->rthdr.ip6r_len = 2;		/* (1 + ip6r_len) * 8 = 24 */
+	srh->rthdr.ip6r_type = 0;		/* RFC 8754: SRH is type 4 */
+	srh->rthdr.ip6r_segleft = 0;
+	srh->segments[0] = ip6->ip6_dst;
+
+	icmp6->icmp6_type = ICMP6_ECHO_REQUEST;
+	icmp6->icmp6_code = 0;
+	icmp6->icmp6_cksum = 0;
+	icmp6->icmp6_dataun.icmp6_un_data16[0] = htons(0x1234);
+	icmp6->icmp6_dataun.icmp6_un_data16[1] = htons(1);
+	icmp6->icmp6_cksum =
+		icmpv6_checksum(&ip6->ip6_src, &ip6->ip6_dst,
+				icmp6, sizeof(*icmp6));
+
+	fd = socket(AF_INET6, SOCK_RAW, IPPROTO_RAW);
+	if (fd < 0) {
+		perror("socket");
+		return 1;
+	}
+
+	dst_addr.sin6_family = AF_INET6;
+	dst_addr.sin6_addr = ip6->ip6_dst;
+
+	res = sendto(fd, frame, sizeof(frame), 0,
+		     (struct sockaddr *)&dst_addr, sizeof(dst_addr));
+	if (res != (ssize_t)sizeof(frame)) {
+		perror("sendto");
+		close(fd);
+		return 1;
+	}
+
+	close(fd);
+	return 0;
+}

-- 
2.50.1


