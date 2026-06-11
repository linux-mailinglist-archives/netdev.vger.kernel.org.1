Return-Path: <netdev+bounces-298322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XEPUHSUNK2qN1wMAu9opvQ
	(envelope-from <netdev+bounces-298322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:31:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3BD674C25
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:31:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm1 header.b="b IvZF/f";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=Z3O4e9dC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298322-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298322-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=fastmail.im;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 172B430D01EA
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D25A30C62E;
	Thu, 11 Jun 2026 19:31:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB629D265
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 19:31:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206286; cv=none; b=fmJtPw6I18kbLU2vp55AYwM6jczvEN05nwFlwwFkRZq6sfyDXS3eZDs5zERD1UFz7V4XxaLuoGTNS5gtWa1vedWNH53ivT8C8/NpLU1mMAalxe2VVc+/6WUw1w41T+I4M4P4oM03lR3ObQK2RYYiOGRPgHPvvBtYTrDjbZOn1v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206286; c=relaxed/simple;
	bh=Yqu0mHzY+Hgc7NwbXzAp9GDpFyPfjq+2WWa6a53ui4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+RVffc9EtjRQU+l8ZJGwD2Ib0NKDuAaqOc7GoyPkJ/eBcQ4GO045lXqlaWtC5tOzQydP6GfHies2TQJsPfQo4ZH9kYK/Rt7ftNRHQbVMaArFFMGwNo959aEia/5AP01IHuIITp2dTczkoIySDy8UghXF/hGE1N+9/aN6iw+nd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=bIvZF/ft; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z3O4e9dC; arc=none smtp.client-ip=202.12.124.157
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CD7D97A00E0;
	Thu, 11 Jun 2026 15:31:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 11 Jun 2026 15:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1781206283; x=
	1781292683; bh=EQAIfiQCUq/FU8PweCVTmrgAPbZKdxBVTAgsobyjDUU=; b=b
	IvZF/ftn0sQYkFjRsuy/hG9QPn5j1Ebb9cwypfzW7Fag0ijpdGVqjDFo2o6UJdb1
	ThN3EU3aavLVXtvOlgYgQ8LTDEuaD3wzwGBJlwbMvGdgsExYcqj4YNdbVFK2//Od
	kkhST6ttg/6gcXVG6JzQcelQB0QpLjgecafW7vMszP4dihF6e8bo0qdTF22HMBVw
	e6yKBxlC/W6x5zWTN/4Br+MP5nJL2ZHCIEB59rpW/cie4Kjwu2ZnjN/Q/4jfF4uS
	gcm5qtJN7mBOtZfCWWHfSCs38SIi7mA9jDrroMVeD/RTsA/A3MzDDfpx7WaEKsuX
	4hepuZo841t3AudKToTYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781206283; x=1781292683; bh=E
	QAIfiQCUq/FU8PweCVTmrgAPbZKdxBVTAgsobyjDUU=; b=Z3O4e9dCoHT6jH0Yp
	0C9Olpi6UKp2l5eDEoLmxSogOal5o0lhbBr4/3BD8DP60nHDDajnePTBx0VroQ3D
	NT/yOe+7/A6BiCyqm9F/wnwQIZANzf4y9oUF8YR45BUiJ+xsqSGNjo1nI3SYJABM
	+a5GjLJIze9pwy+wfOz6izlpIKFOA9Royq2Rj1A84MJT0JDEu2CZMzA44Alg2V2a
	HxwR8Aa0wZtIp1b/O4uJo7MIwhTS8yLi3Eg7+6HC8TfiSp0splYdj0WdnpAGY61N
	4789JtOV4a3QmkiTVc8Z0SDZ4UnCQaJP0AK8AWgWrvKsjZXxQUMxVVzRG97E44Ot
	6ilJw==
X-ME-Sender: <xms:Cw0ragZCMrg2KuRY1lOVYGXEJx5m3lDckklW8EXfYTUMMLnmL4Fb6A>
    <xme:Cw0ramScOxxZlfNX0-F1VY0vGWcP00P70Y2iwbQUklUJXHbLzzyyAzU7bprJW9PIh
    ZCNZ5y_AF1LJUqHdIF2-opA6kyN-ILLQN4yQRg_kEtbYBCAMXYxjQ>
X-ME-Received: <xmr:Cw0ralK6eUkenyr8xlyaUyxm07yWnSLhymvh8T2g4l3i_R42AumESdnaOX-UdpAK5EK28VISPDyrmDb5euCzjCI>
X-ME-Proxy-Cause: dmFkZTElDtKTZfl5mw59UBLLPrW8aIITHryvQ2nPkfR7IXQ9ce1folsZykrD4I9OVTdkfp
    PMWjjl6nkuUXhLPbzt3qohwu1pOBTiStMWOIUcSQ2JhziTT8P9Z7ptkabt25QYIUJA0UOb
    FtEClpW4Bxy5E5GbhcVpSAvd39BhalKdENFIjjg5M8mt9vzdyTxQPQIawEj0TawS+6EvUM
    3lb7CKhsn8uOyh1x6Nvw7C8IYqOO5CnLcYyVOQsMYJzI/yQEl4fZJSdk+e4k9YEIKrgg0p
    HjAxpNruOba/po3Nzd3U9dYI01SxZs0DBy/ExNAPd5vx4HhDPE+V7c+PMN+ehBtEKt0AF6
    YkSCkMsw5AzzRDvfipH26AbNVFHNd87s+7hhxTmzuGGcZew9td7Ab3Nk8o/wbNvEDwUA7S
    f1uYz7NzSkbyedpdXOrPYm/qfWPo8I+AA9c5PV/15+E45myhE+LbbJzT2eUZUX1KPo6Akz
    H7ZRy71vYwx8LjFUb0T5x9MWMZSPDk/aiLSIqNQvpbiaR6dytyhG6xXlwnj3c1KgXu2Onm
    ZmPyPRdx3msvz1Utb52lIa+9wD4h1rT24DEXPOwltFRcF88SM/m+P/nasafSwSXnfPccc5
    nAU8c6rLRuitVZ0n19dbI2J3m6+BFBFVcUXu0xjgPQKKv7ZSIZZwKGtAzRLg
X-ME-Proxy: <xmx:Cw0rasU-0VVCCN5g1zItj7mhpcfKI_sAIYAduKbfL3VlnUSxKZqb3g>
    <xmx:Cw0rahg2UXjUQUHLWKDAMC7fTyN9MaB3fTWmuxDn3qvpwXbG9A6zLg>
    <xmx:Cw0rague-r25bQNXVdtP7DMTPGmWRC0mwwQ2q1QdhV8CJGTb0pV00w>
    <xmx:Cw0rapz2WPfLICY9IVs-TOGxdpr6vBaMX1zHEgrXrLH7ADPLto6_eQ>
    <xmx:Cw0ralC_liRUY9vtfd_kOpTJdji8KZaRqDtt3DXGKkMRJ2t1_V8-acB9>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 15:31:22 -0400 (EDT)
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
Subject: [PATCH net-next v7 11/11] selftests: net: Add a test for BIG TCP in UDP tunnels
Date: Thu, 11 Jun 2026 21:29:55 +0200
Message-ID: <20260611192955.604661-12-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611192955.604661-1-alice.kernel@fastmail.im>
References: <20260611192955.604661-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298322-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_SENDER(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[fastmail.im];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,vger.kernel.org:from_smtp,isovalent.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,fastmail.im:dkim,fastmail.im:mid,fastmail.im:from_mime,big_tcp_tunnels.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD3BD674C25

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
index 6a190a525a39..9b97aedd8058 100644
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


