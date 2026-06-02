Return-Path: <netdev+bounces-294123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eK+TK/6mHmq3IwAAu9opvQ
	(envelope-from <netdev+bounces-294123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:48:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FE162BDC3
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00643308FC97
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7153D1CA8;
	Tue,  2 Jun 2026 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="Gh7owAnJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K7qvfQmN"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1114D3D331D
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393279; cv=none; b=ewqeir3UagyJ4BqvzwZM/oMvfjoKcY/X/zYVsSRozTXEQ0kzzVWkAIi81ItDIvWKootMgXAA9JHe4Dfcbxz0PExf5QgfbtguJ9r6Afp8PgIfWvZeA5WceqVLWa6jx50kkS6h8RlrjZfsKGtXcbAK7O4IjCnVIq6Et1ji7889r8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393279; c=relaxed/simple;
	bh=IcTa34JM6Ln8abElOh1Nk0yxzd+N8+BO21gYVKPFo3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOxAug+beXeELHc9VId5etK09xfTw4PHsDGG2i3V3xvNRDVK/6k4GeiQ5lRfiwxtJyNiYpCVTth00EX3JJZuuyuoDMvIlVwkrPlTrMh8TWtEUf8mT1VFE4Eisns4CvFifFSJL83Dd3FVk40rgEBMM19oUrlRXfRBmnDowC28uWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=Gh7owAnJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K7qvfQmN; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EF8BD7A013A;
	Tue,  2 Jun 2026 05:41:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 02 Jun 2026 05:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1780393276; x=
	1780479676; bh=YPOlzuigh2xsIb6ykABbPx55nx/illDTqrlxylgdzrc=; b=G
	h7owAnJ6i/LoGAC4ZyGZFtmqYN00x0RzitbMzvzUlEZOCDEikHy4rQpHl+ZPWRtU
	NTJXgeRzTenD8SnesTAyfC4L0F3nV9gNEsjIKQXitkmiGSIIl+mKoQzdzO3vzLvq
	bM85czB73KZ+mi6n6Q0WdHkob4Xoe8BVHJfU9FgzM7zoMz5fmbGJA1L5Hp3jvafo
	94rJb8pXlXhfhmnZUYdF6jugNC5z2KKFCw+QhRYVUUQOa2DmQQzi6mp2KemZ5Q4x
	gj3Of2H31anPmTPoNoAxIl24bP2FVpJqITCxSAyrhmy1ZWbfI0bGXN5+XkfiKCDI
	6LLNIxN8Smq94KIYC9iqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780393276; x=1780479676; bh=Y
	POlzuigh2xsIb6ykABbPx55nx/illDTqrlxylgdzrc=; b=K7qvfQmNCsHyUUlkP
	Vp1YQlf2N+THfozqCM5JzcVJp1EVYksv+zBvpXKDohyum9ztBWL6wqkpcPQclddi
	R32PDGE1DOWP35Tl5SifuvzuxYPXWnjldSPvxz60iSMXSTbL+MT8y99/Mm44FEzP
	1IDoCITKLzD7d16WzHcJBeA9WEfuL93IpZXLYnyEr4EnlFrnhfwFc/G5Lu8kFNbd
	JRW4E+d+oYvU2hA+IGKoYKPaHVD1WYLn8zOoKjKsfpJ/JLUhWg7Vsf/camEvt1ck
	+j3YRGVkzlIAalOiUICBzUQqtcdGqLSLWDEOPrm+nROjr6amfAu1LhUlK9LQRx5h
	tLizA==
X-ME-Sender: <xms:PKUeau14eZ2QyhPJ1XWNWq3DFRnGbrX8731fuJqAPEtxXYeEFYFjOg>
    <xme:PKUeavmoXw_IteqSEgOSTDXZB-mqxyzxtnN8d2W_gUYSVIXnVxrbR5DUP9UqbmK3X
    wDIqpJ8hV5ebWPychUFMvNMTwwgcZI9xyPiQMOsgAgeoOdWG7CNGl6h>
X-ME-Received: <xmr:PKUeatvDEqcs20isuysalDw9eUv9p0zbrB16BoYFOxviKjZ_MyVuZwlto3peGapYCOtgF64QxeQWNRmInHs>
X-ME-Proxy-Cause: dmFkZTF9LO8Fhxl0/MdIK8BUY2JQgdWC+kkwHzGCIWrHCsyDgpRCDULHq0hEGzyXg7aDpH
    g3idQFp6N72tYF5QG6bTYSL3eQwKt+GpNR9rRcOTWJ9aKqTbORCHN5RI0R3wf58tsokbGN
    73Oy3xbuLKf0ntd6qSFQ28IzEhKMpOn7OfJQEFkKh1lsoSzS++LYbp+YX7Ns1szQyPSQjh
    hCAd3cOuhsD0YiKkxrqbt+hTWsi0LuT8Uc8YC8KjARG9EUDuMmJngbTSfecH7xW9NWHZBH
    WXsEdIAJ98cxIFXJncDak9wr72KOFdCkyGNyS03qdQ0B7zZZ2h0tltUFvmvWxjCoYF/QNR
    FGZYzZx4HsYbvTqpvP8rtPsTBGTcUMxKCC6x30uUjbDeO5X7ORZOegwx57d+LQ2A8VsWwB
    NhFe3ygZLRGk62fk6GwQfdycN3JfV4y+nAy3dBHwyCocG4fAN5QP1eEbgewCsVSdq4e38E
    AGOIdzEKpUUoP6rtqfTYx5AZ++359TDpJmzZU9MVuwr3rkdgm79x92SyCFIYwWMiJcCxIj
    n4dNmV+uLO+76T4GZZfzNibASUwTYvrpx6qC+AQ7gqZoBv44M7mEMGQEEUFlAFXYKWMfD5
    Os67/Vjg/r3AagsnB+DhpOP0DfIs4d7UIXmyl3kpkkitBV76NJojS4NlUvmw
X-ME-Proxy: <xmx:PKUeav1xPki9jOaTvcsYSRdrrgKUVzn_2UDj9bCmFClQmoYP_NsmbA>
    <xmx:PKUeapQUOyh3WL_UPdQrD-6TUWcRBSBnu50j_oGy4KGYbwHgcttZ6g>
    <xmx:PKUeajs5TcL-gIDpumK8z01nmRNoD3sp27J8xv7agpGNX_qakfbwxA>
    <xmx:PKUeavJlXecGW4j_93dSO4hflfEAGj2SeiqniNdOOUENPQif6oK4pw>
    <xmx:PKUeavC46EL2Z1MYCVyyK-PjpXk8x91OPi5Az7RJxFl9FN5EEVUQwiyX>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 05:41:16 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v6 11/11] selftests: net: Add a test for BIG TCP in UDP tunnels
Date: Tue,  2 Jun 2026 11:39:31 +0200
Message-ID: <20260602093931.516281-12-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602093931.516281-1-alice.kernel@fastmail.im>
References: <20260602093931.516281-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 28FE162BDC3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294123-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.im];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fastmail.im:dkim,fastmail.im:mid,isovalent.com:email,big_tcp_tunnels.sh:url]
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

The test sets up VXLAN and GENEVE tunnels over IPv4 and IPv6 and runs
IPv4 and IPv6 traffic through them with BIG TCP enabled. It checks that
a non-negligible amount of big aggregated packets are seen in tcpdump.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/big_tcp_tunnels.sh  | 151 ++++++++++++++++++
 2 files changed, 152 insertions(+)
 create mode 100755 tools/testing/selftests/net/big_tcp_tunnels.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 5ca6c557fc3f..f32aa5495751 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -13,6 +13,7 @@ TEST_PROGS := \
 	arp_ndisc_untracked_subnets.sh \
 	bareudp.sh \
 	big_tcp.sh \
+	big_tcp_tunnels.sh \
 	bind_bhash.sh \
 	bpf_offload.py \
 	bridge_stp_mode.sh \
diff --git a/tools/testing/selftests/net/big_tcp_tunnels.sh b/tools/testing/selftests/net/big_tcp_tunnels.sh
new file mode 100755
index 000000000000..792a27fcd56d
--- /dev/null
+++ b/tools/testing/selftests/net/big_tcp_tunnels.sh
@@ -0,0 +1,151 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Testing for IPv4 and IPv6 BIG TCP over VXLAN and GENEVE tunnels.
+
+SERVER_NS=$(mktemp -u server-XXXXXXXX)
+SERVER_IP4="192.168.1.1"
+SERVER_IP6="2001:db8::1:1"
+SERVER_IP4_TUN="192.168.2.1"
+SERVER_IP6_TUN="2001:db8::2:1"
+
+CLIENT_NS=$(mktemp -u client-XXXXXXXX)
+CLIENT_IP4="192.168.1.2"
+CLIENT_IP6="2001:db8::1:2"
+CLIENT_IP4_TUN="192.168.2.2"
+CLIENT_IP6_TUN="2001:db8::2:2"
+
+: "${PACKETS_THRESHOLD:=5000}"
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+setup() {
+	ip netns add "$SERVER_NS"
+	ip netns add "$CLIENT_NS"
+	ip -netns "$SERVER_NS" link add link1 type veth peer name link0 netns "$CLIENT_NS"
+
+	ip -netns "$CLIENT_NS" link set link0 up
+	ip -netns "$CLIENT_NS" addr replace "$CLIENT_IP4/24" dev link0
+	ip -netns "$CLIENT_NS" addr replace "$CLIENT_IP6/112" dev link0 nodad
+	ip -netns "$CLIENT_NS" link set link0 \
+		gso_max_size 196608 gso_ipv4_max_size 196608 \
+		gro_max_size 196608 gro_ipv4_max_size 196608
+	ip -netns "$SERVER_NS" link set link1 up
+	ip -netns "$SERVER_NS" addr replace "$SERVER_IP4/24" dev link1
+	ip -netns "$SERVER_NS" addr replace "$SERVER_IP6/112" dev link1 nodad
+	ip -netns "$SERVER_NS" link set link1 \
+		gso_max_size 196608 gso_ipv4_max_size 196608 \
+		gro_max_size 196608 gro_ipv4_max_size 196608
+
+	ip netns exec "$SERVER_NS" netserver >/dev/null
+}
+
+setup_tunnel() {
+	if [ "$2" = 4 ]; then
+		SERVER_IP="$SERVER_IP4"
+		CLIENT_IP="$CLIENT_IP4"
+		echo "Setting up ${1^^} over IPv4"
+	else
+		SERVER_IP="$SERVER_IP6"
+		CLIENT_IP="$CLIENT_IP6"
+		echo "Setting up ${1^^} over IPv6"
+	fi
+
+	if [ "$1" = vxlan ]; then
+		ip -netns "$CLIENT_NS" link add tun0 type vxlan \
+			id 5001 remote "$SERVER_IP" local "$CLIENT_IP" dev link0 dstport 4789
+	else
+		ip -netns "$CLIENT_NS" link add tun0 type geneve \
+			id 5001 remote "$SERVER_IP"
+	fi
+	ip -netns "$CLIENT_NS" link set tun0 up
+	ip -netns "$CLIENT_NS" addr replace "$CLIENT_IP4_TUN/24" dev tun0
+	ip -netns "$CLIENT_NS" addr replace "$CLIENT_IP6_TUN/112" dev tun0 nodad
+	ip -netns "$CLIENT_NS" link set tun0 \
+		gso_max_size 196608 gso_ipv4_max_size 196608 \
+		gro_max_size 196608 gro_ipv4_max_size 196608
+	if [ "$1" = vxlan ]; then
+		ip -netns "$SERVER_NS" link add tun1 type vxlan \
+			id 5001 remote "$CLIENT_IP" local "$SERVER_IP" dev link1 dstport 4789
+	else
+		ip -netns "$SERVER_NS" link add tun1 type geneve \
+			id 5001 remote "$CLIENT_IP"
+	fi
+	ip -netns "$SERVER_NS" link set tun1 up
+	ip -netns "$SERVER_NS" addr replace "$SERVER_IP4_TUN/24" dev tun1
+	ip -netns "$SERVER_NS" addr replace "$SERVER_IP6_TUN/112" dev tun1 nodad
+	ip -netns "$SERVER_NS" link set tun1 \
+		gso_max_size 196608 gso_ipv4_max_size 196608 \
+		gro_max_size 196608 gro_ipv4_max_size 196608
+}
+
+cleanup_tunnel() {
+	ip -netns "$CLIENT_NS" link del tun0
+	ip -netns "$SERVER_NS" link del tun1
+}
+
+cleanup() {
+	ip netns pids "$SERVER_NS" | xargs -r kill
+	ip netns pids "$CLIENT_NS" | xargs -r kill
+	ip netns del "$SERVER_NS"
+	ip netns del "$CLIENT_NS"
+}
+
+do_test() {
+	exec 3< <(ip netns exec "$SERVER_NS" tcpdump -nn -i link1 greater 65536 2> /dev/null)
+	TCPDUMP_SERVER_PID="$!"
+	exec 4< <(wc -l <&3)
+	exec 5< <(ip netns exec "$CLIENT_NS" tcpdump -nn -i link0 greater 65536 2> /dev/null)
+	TCPDUMP_CLIENT_PID="$!"
+	exec 6< <(wc -l <&5)
+
+	if [ "$1" = 4 ]; then
+		SERVER_IP="$SERVER_IP4_TUN"
+		echo "Running IPv4 traffic in the tunnel"
+	else
+		SERVER_IP="$SERVER_IP6_TUN"
+		echo "Running IPv6 traffic in the tunnel"
+	fi
+
+	ip netns exec "$CLIENT_NS" netperf -t TCP_STREAM -l 5 -H "$SERVER_IP" -- \
+		-m 80000 > /dev/null
+	kill "$TCPDUMP_SERVER_PID" "$TCPDUMP_CLIENT_PID"
+	wait "$TCPDUMP_SERVER_PID" "$TCPDUMP_CLIENT_PID"
+	PACKETS_SERVER=$(cat <&4)
+	PACKETS_CLIENT=$(cat <&6)
+	exec 3>&- 4>&- 5>&- 6>&-
+
+	# One line is empty, each packet is two lines (inner and outer).
+	echo "Captured BIG TCP GRO packets: $(((PACKETS_SERVER - 1) / 2))"
+	echo "Captured BIG TCP GSO packets: $(((PACKETS_CLIENT - 1) / 2))"
+	[ "$PACKETS_SERVER" -gt "$(( PACKETS_THRESHOLD * 2 + 1))" ] || return 1
+	[ "$PACKETS_CLIENT" -gt "$(( PACKETS_THRESHOLD * 2 + 1))" ] || return 1
+}
+
+if ! netperf -V &> /dev/null; then
+	echo "SKIP: Could not run test without netperf tool"
+	exit "$ksft_skip"
+fi
+
+if ! tcpdump --version &> /dev/null; then
+	echo "SKIP: Could not run test without tcpdump tool"
+	exit "$ksft_skip"
+fi
+
+if ! ip link help 2>&1 | grep gso_ipv4_max_size &> /dev/null; then
+	echo "SKIP: Could not run test without gso/gro_ipv4_max_size supported in ip-link"
+	exit "$ksft_skip"
+fi
+
+trap cleanup EXIT
+setup
+for tunnel in vxlan geneve; do
+	for tun_family in 4 6; do
+		for traffic_family in 4 6; do
+			setup_tunnel "$tunnel" "$tun_family" || exit "$?"
+			do_test "$traffic_family" || exit "$?"
+			cleanup_tunnel
+		done
+	done
+done
-- 
2.54.0


