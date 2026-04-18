Return-Path: <netdev+bounces-279554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LDYLovi42mbMAEAu9opvQ
	(envelope-from <netdev+bounces-279554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 21:59:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F69422289
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 21:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9EA793007B09
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 19:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044D53368BF;
	Sat, 18 Apr 2026 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Snvl1j2j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5449F274B53
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776542340; cv=none; b=KZ/ZQ7UV6PdhzDJB6TZTHrxAskHCgQG8Mp2tA+wffRN8/GS+pxgH93qPx/JVxecjpAi0VQrqtZOXHJzzRSI1X5CkM/cPRRD2m0x10f6GPTzG/z+uIA+mBmYeUGoNbdPCrzTrCQ8QSssvsgZUL4RCQ/dgMOhpTY+CQHc74OkmYog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776542340; c=relaxed/simple;
	bh=g+jbqedVJeXVkDa41E9XlF9r/7lQOFTqNLPXjDQEnlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rYvVlMZnE/v/vOe/5a6/O67o4Yu/G/FPKvOkBj7wnGizuVy2LGsR4D8AosipI9eVc6O3NC1TVEUcH3J1Y1HX2oKCvG5kUOM4KuqcBSKyTdXrCohqMzvUcGJRj7zYJAO6c2q8P8gV9c8JhqN1jpYR1wRBQ6FDbMlGPgdLr/kqDdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Snvl1j2j; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso13078235e9.0
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 12:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776542338; x=1777147138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tm2PCGa1F10nJuRUcP6mAyFe2uLBjcoG5dv2Op3y66U=;
        b=Snvl1j2jPaRYyS/BArRe630VPb4NfR7OSMs9o2Lf/4Ir7Woa8sYFSdSU4/AbOqJZn2
         rjDCY2xWDxTTn5b/kgk2VfTWR0Q8sq9+VaBxNOGuaBDYxv2+Mwbu8RTwbDLcMtOOuzbg
         plG2kntcEsywSVXyqfWE6Y/QYhLFzGH9mt+SMDkttE/NAD1tGL9Jpw74Q3ls7gNNzmIq
         UVYe+109de7YeZkRayHeh+HElHFq2DGy98BuC6cNJJw9GBKDVDCyZ8SoSOUxymY5N75Y
         pBRWSFkiqY4CwK8kPEKKjHfQucVVfF6HJ3QRa4gkPlv/3dIoOlSuBNmyNFbCFWRUQGBI
         VKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776542338; x=1777147138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tm2PCGa1F10nJuRUcP6mAyFe2uLBjcoG5dv2Op3y66U=;
        b=TREhzITxs/K7VmwcFSR3JDv2u3HF19P9nQp/VB1l7gQcw/M1ypopvl7pCdRZhcavZM
         8hqAfzLwFV9ljEwISAZm9yg4BpioxNRDL4v/KtAAXWyI3s2gAA5FmvxjoI6XkLwOhxW3
         aeuWAEtAqPepNbldZXAa3+ouwsBIYR5/kZul6GAFsI9OmsR6vYVkzaF2Vm9iHZc7CSFA
         k6cOiEy8YMx0JR+rHEs709ZvyusbNd3Qw53GQjMwvEOsCRMggNAXWTuLW2rgv8hupcFQ
         9M233M+5n1Ayisk3zUX7wTNURmXy6/2MAUQDqcqfv7PjbWkVJizo6T56Fl0kn9YGnf97
         GnUA==
X-Forwarded-Encrypted: i=1; AFNElJ+1lV/owEAfcaiqODWOXwtuXI4vFeqVC2CoDdlgdofVN4SJiIECehYLQgdzSzVLKwVaItxPgDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc0lUt9seRMyBTJboFPpF05fXB+O7cuEKFRdHXpRRhTeOdNHD7
	UsNdDByyOgOSJmSDiAV31P+MrF4YiNEIjwaPUPDUb9VHCGw416SaBvoZ
X-Gm-Gg: AeBDies8lk6uhALU0zl/sAnWw66pJoqzmjXzBGLn/jJPyOiahULJXku5F6Mh+jLpN2I
	JmZCa7tizlbRZagMTCADHc9zhw7puGhZJH0gz5k0cFZkoYcRaWqkRl6rzklFVQmZUMpo7M24ppX
	iy4n5oRmkQpSliEtVg4kLDo3/ol//kdIaoS69t9mr76tNcAl0UiLgWH6RDvSOU1DicvTM011ORE
	/O+2J97Lg49tYxatvHh90MxvC7OXNZjshUG4xq4zLN5DBubL0dLv1cqOC+txhs8xRddMqjP0EaI
	CJx+kXa6gpv2Z7YNKpxGfLFDdLWo9drCEQiHMQSh+nOZzTHQthEHcz2lfOBy9tWuioWBIcwBlp7
	PGm/0+Dvduo7Qyvk3qJUBEoYloopirQrKIMjwzOjLxw11hCpy12VErDwvkr5ISU0XrG5tlawWZX
	/+NUArOczCZlA=
X-Received: by 2002:a05:600c:a404:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-488fb73b2a3mr96678055e9.5.1776542337501;
        Sat, 18 Apr 2026 12:58:57 -0700 (PDT)
Received: from yiche-laptop ([2a09:0:1:2::30c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb78becdsm72593675e9.5.2026.04.18.12.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 12:58:57 -0700 (PDT)
From: Yi Chen <yiche.cy@gmail.com>
To: Yi Chen <yiche.cy@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Long Xin <lucien.xin@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: coreteam@netfilter.org,
	netfilter-devel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net v2] selftests: netfilter: conntrack_sctp_collision.sh: Introduce SCTP INIT collision test
Date: Sun, 19 Apr 2026 03:58:43 +0800
Message-ID: <20260418195843.303946-1-yiche.cy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279554-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,netfilter.org,strlen.de,nwl.cc,davemloft.net,kernel.org,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yichecy@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.975];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.sh:url]
X-Rspamd-Queue-Id: B2F69422289
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The existing test covered a scenario where a delayed INIT_ACK chunk
updates the vtag in conntrack after the association has already been
established.

A similar issue can occur with a delayed SCTP INIT chunk.

Add a new simultaneous-open test case where the client's INIT is
delayed, allowing conntrack to establish the association based on
the server-initiated handshake.

When the stale INIT arrives later, it may get recorded and cause a
following INIT_ACK from the peer to be accepted instead of dropped.
This INIT_ACK overwrites the vtag in conntrack, causing subsequent
SCTP DATA chunks to be considered as invalid and then dropped by
nft rules matching on ct state invalid.

This test verifies such stale INIT chunks do not cause problems.

Signed-off-by: Yi Chen <yiche.cy@gmail.com>
Acked-by: Xin Long <lucien.xin@gmail.com>
---
v1 -> v2:
- Simplify conf_delay() by passing arguments.
- Avoid calling exit() inside the function.
- Enable nft log by setting net.netfilter.nf_log_all_netns=1.
- Add a description for the "ct invalid drop" rule match.
---
 .../net/netfilter/conntrack_sctp_collision.sh | 85 ++++++++++++++-----
 1 file changed, 63 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/conntrack_sctp_collision.sh b/tools/testing/selftests/net/netfilter/conntrack_sctp_collision.sh
index d860f7d9744b..31823050391e 100755
--- a/tools/testing/selftests/net/netfilter/conntrack_sctp_collision.sh
+++ b/tools/testing/selftests/net/netfilter/conntrack_sctp_collision.sh
@@ -2,18 +2,32 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 # Testing For SCTP COLLISION SCENARIO as Below:
-#
+# 1. Stale INIT_ACK capture:
 #   14:35:47.655279 IP CLIENT_IP.PORT > SERVER_IP.PORT: sctp (1) [INIT] [init tag: 2017837359]
 #   14:35:48.353250 IP SERVER_IP.PORT > CLIENT_IP.PORT: sctp (1) [INIT] [init tag: 1187206187]
 #   14:35:48.353275 IP CLIENT_IP.PORT > SERVER_IP.PORT: sctp (1) [INIT ACK] [init tag: 2017837359]
 #   14:35:48.353283 IP SERVER_IP.PORT > CLIENT_IP.PORT: sctp (1) [COOKIE ECHO]
 #   14:35:48.353977 IP CLIENT_IP.PORT > SERVER_IP.PORT: sctp (1) [COOKIE ACK]
 #   14:35:48.855335 IP SERVER_IP.PORT > CLIENT_IP.PORT: sctp (1) [INIT ACK] [init tag: 164579970]
+#   (Delayed)
+#
+# 2. Stale INIT capture:
+#   14:35:48.353250 IP SERVER_IP.PORT > CLIENT_IP.PORT: sctp (1) [INIT] [init tag: 1187206187]
+#   14:35:48.353275 IP CLIENT_IP.PORT > SERVER_IP.PORT: sctp (1) [INIT ACK] [init tag: 2017837359]
+#   14:35:48.353283 IP SERVER_IP.PORT > CLIENT_IP.PORT: sctp (1) [COOKIE ECHO]
+#   14:35:48.353977 IP CLIENT_IP.PORT > SERVER_IP.PORT: sctp (1) [COOKIE ACK]
+#   14:35:47.655279 IP CLIENT_IP.PORT > SERVER_IP.PORT: sctp (1) [INIT] [init tag: 2017837359]
+#   (Delayed)
+#   14:35:48.855335 IP SERVER_IP.PORT > CLIENT_IP.PORT: sctp (1) [INIT ACK] [init tag: 164579970]
 #
 # TOPO: SERVER_NS (link0)<--->(link1) ROUTER_NS (link2)<--->(link3) CLIENT_NS
 
 source lib.sh
 
+checktool "nft --version" "run test without nft"
+checktool "tc -h" "run test without tc"
+checktool "modprobe -q sctp" "load sctp module"
+
 CLIENT_IP="198.51.200.1"
 CLIENT_PORT=1234
 
@@ -24,7 +38,8 @@ CLIENT_GW="198.51.200.2"
 SERVER_GW="198.51.100.2"
 
 # setup the topo
-setup() {
+topo_setup() {
+	# setup_ns cleans up existing net namespaces first.
 	setup_ns CLIENT_NS SERVER_NS ROUTER_NS
 	ip -n "$SERVER_NS" link add link0 type veth peer name link1 netns "$ROUTER_NS"
 	ip -n "$CLIENT_NS" link add link3 type veth peer name link2 netns "$ROUTER_NS"
@@ -38,35 +53,53 @@ setup() {
 	ip -n "$ROUTER_NS" addr add $SERVER_GW/24 dev link1
 	ip -n "$ROUTER_NS" addr add $CLIENT_GW/24 dev link2
 	ip net exec "$ROUTER_NS" sysctl -wq net.ipv4.ip_forward=1
+	sysctl -wq net.netfilter.nf_log_all_netns=1
 
 	ip -n "$CLIENT_NS" link set link3 up
 	ip -n "$CLIENT_NS" addr add $CLIENT_IP/24 dev link3
 	ip -n "$CLIENT_NS" route add $SERVER_IP dev link3 via $CLIENT_GW
+}
 
-	# simulate the delay on OVS upcall by setting up a delay for INIT_ACK with
-	# tc on $SERVER_NS side
-	tc -n "$SERVER_NS" qdisc add dev link0 root handle 1: htb r2q 64
-	tc -n "$SERVER_NS" class add dev link0 parent 1: classid 1:1 htb rate 100mbit
-	tc -n "$SERVER_NS" filter add dev link0 parent 1: protocol ip u32 match ip protocol 132 \
-		0xff match u8 2 0xff at 32 flowid 1:1
-	if ! tc -n "$SERVER_NS" qdisc add dev link0 parent 1:1 handle 10: netem delay 1200ms; then
+conf_delay()
+{
+	# simulate the delay on OVS upcall by setting up a delay for INIT_ACK/INIT with
+	local ns=$1
+	local link=$2
+	local chunk_type=$3
+
+	# use a smaller number for assoc's max_retrans to reproduce the issue
+	ip net exec "$CLIENT_NS" sysctl -wq net.sctp.association_max_retrans=3
+
+	tc -n "$ns" qdisc add dev "$link" root handle 1: htb r2q 64
+	tc -n "$ns" class add dev "$link" parent 1: classid 1:1 htb rate 100mbit
+	tc -n "$ns" filter add dev "$link" parent 1: protocol ip \
+		u32 match ip protocol 132 0xff match u8 "$chunk_type" 0xff at 32 flowid 1:1
+	if ! tc -n "$ns" qdisc add dev "$link" parent 1:1 handle 10: netem delay 1200ms; then
 		echo "SKIP: Cannot add netem qdisc"
-		exit $ksft_skip
+		return $ksft_skip
 	fi
 
 	# simulate the ctstate check on OVS nf_conntrack
-	ip net exec "$ROUTER_NS" iptables -A FORWARD -m state --state INVALID,UNTRACKED -j DROP
-	ip net exec "$ROUTER_NS" iptables -A INPUT -p sctp -j DROP
-
-	# use a smaller number for assoc's max_retrans to reproduce the issue
-	modprobe -q sctp
-	ip net exec "$CLIENT_NS" sysctl -wq net.sctp.association_max_retrans=3
+	ip net exec "$ROUTER_NS" nft -f - <<-EOF
+	table ip t {
+		chain forward {
+			type filter hook forward priority filter; policy accept;
+			meta l4proto icmp counter accept
+			ct state new counter accept
+			ct state established,related counter accept
+			ct state invalid log flags all counter drop comment \
+			"Expect to drop stale INIT/INIT_ACK chunks"
+			counter
+		}
+	}
+	EOF
+	return 0
 }
 
 cleanup() {
-	ip net exec "$CLIENT_NS" pkill sctp_collision >/dev/null 2>&1
-	ip net exec "$SERVER_NS" pkill sctp_collision >/dev/null 2>&1
+	# cleanup_all_ns terminates running processes in the namespaces.
 	cleanup_all_ns
+	sysctl -wq net.netfilter.nf_log_all_netns=0
 }
 
 do_test() {
@@ -81,7 +114,15 @@ do_test() {
 
 # run the test case
 trap cleanup EXIT
-setup && \
-echo "Test for SCTP Collision in nf_conntrack:" && \
-do_test && echo "PASS!"
-exit $?
+
+echo "Test for SCTP INIT_ACK Collision in nf_conntrack:"
+(topo_setup && conf_delay $SERVER_NS link0 2) || exit $?
+if ! do_test; then
+	exit $ksft_fail
+fi
+
+echo "Test for SCTP INIT Collision in nf_conntrack:"
+(topo_setup && conf_delay $CLIENT_NS link3 1) || exit $?
+if ! do_test; then
+	exit $ksft_fail
+fi
-- 
2.53.0


