Return-Path: <netdev+bounces-277454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPLmFrIT2Wm7lwgAu9opvQ
	(envelope-from <netdev+bounces-277454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:13:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC37D3D906D
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D00B530657A6
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516F23CC9FE;
	Fri, 10 Apr 2026 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="Aq34bqNF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gtwjy26i"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF84E3D9031
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833838; cv=none; b=orFqaoRV4Vyo8VJizpKxwW8u9rhvrcft+0MaBm7gZCPQWe1Y8NPvPhMecwVkN0BWCxXx+5aEHYx5vXJ42/yK+2CEVob8cmEi+nGVPiGdaOR5J5snSRr0XfHb+oRr0US14Iv4DYIJlDWLocA5nklRvRGn8VtWlY6CpZ1PaZC7ea8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833838; c=relaxed/simple;
	bh=EZ0vUC2EZNK82iKy89iF58UIFKbQ/1m5/IlLaOwADBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Or1of7VtF7PFBTdeyG153Ku0HR6i8MjS6lKcsf2rFD5waKkqEFQGDimvyP3YN7Zuap214YmY5HIauJLw32iJVNHgTbFDsZHNpbB4je56AQ4Cct1L/GFN14ZMmaeLxMongh/jsmo2jlocx6wBY5QqF9tXW7tReqkHARGlYqY+Ry8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=Aq34bqNF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gtwjy26i; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 20127EC0445;
	Fri, 10 Apr 2026 11:10:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 10 Apr 2026 11:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1775833836; x=
	1775920236; bh=dFGt4ZHrKpXoNOA7fEKIDehhguiEGziu08du6+mV1vE=; b=A
	q34bqNFIATq4Q+NuGtNqJ7hNAUD7fKbOnRlvkAFIXGDMth0AKGiQTWI3s9GWyZZo
	XhN2SNclGUSc8ESZolW2j9Lla1DEJP+KJfmbun5MBuPb4z2fLUuXJQqB9I2NCoNP
	wrMAGSy7a4roZ8wSshRs1EtksHNagT+Jt8KZQXeHqLyDWoyPRfXC1A4hbrbE6o1u
	hJ8Jy5b0EoQL6McsqMpurNFIX/2kpF3XZmDeX6+JV0L0Ll3ds4HJjk3+Rj0g3anP
	HhNDeZj1VTFa+MdeFgfWIYmzXeKPM7OrUJf088ye8W6fhOWKffoSzhD+jtnt5OVv
	Lv9cqyzDzu0AEWSgdzaJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775833836; x=1775920236; bh=d
	FGt4ZHrKpXoNOA7fEKIDehhguiEGziu08du6+mV1vE=; b=Gtwjy26iuGSml7xYZ
	F7MRgKuPOul5oWKgKetUMnaJmczDmK3/6Hl+Q2My+9W0Ag8l5rwsGQVepurr4K2O
	YppkEOrWjB9mMA1yVqeByr3S4y2C4/7CQCAScB7U8tbCs0bpvlkmb7nhNzmn1Lix
	4Tl+R0Zj+cC3VbqSTAyW+MZb9d7fzzBFrHSHq1tqhQoDoTqbI3neBMwC4Pn44Q6K
	TEaL2T3EVn/S9Bk7czIF6TMrOvYhfHyJtfSR+mJXvIITNdzZ/QZ/PT7Zvapm/toI
	a++wsPuMoY3jzI0XojouyqxycVOd+m48PSxa/veUMgFz8lH8At0hXfjy5QZ6tT8w
	GFCsw==
X-ME-Sender: <xms:7BLZaUxNqBl2Qan5gDzo-WxINYYs6iT6dKGSj7gPcutloPrIZMgiKA>
    <xme:7BLZaY6hDq0wKZqH5JWp_hhXrvVV3VURQUpFN8rNSlh3MVP2E2OPvRYxqMhAuz4sB
    p3gXE3asI2uDWJJ52J0ozHCWrIu7XJL8t6aGrOlpDDHtkAPJoaEntc>
X-ME-Received: <xmr:7BLZaRct2j0gPQhEKIPkqzBQId3D_R00mUHzQ2dgzsfjUFAncNOMexlM9AGzwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhhitggvucfo
    ihhkihhthigrnhhskhgruceorghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrih
    hmqeenucggtffrrghtthgvrhhnpeetffeljeefvdfhheeijeelgfekleejveeugeegveet
    hffguefhudffgeekvddttdenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrdhimhdpnhgs
    pghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghnih
    gvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehluhgtihgvnhdrgihinhesghhmrg
    hilhdrtghomhdprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghl
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrgh
X-ME-Proxy: <xmx:7BLZaXHnRvjZoVP-PVBxbdbZfYaZ5Wi8t8ST6tPUZIlO52XkAueLAg>
    <xmx:7BLZaZ5w_3eklVB_0m3b5RY-H1he8cFvYtBh97SNvN_vGaF3TfJq3Q>
    <xmx:7BLZaStv6oCnKrwdVKZ2Dld0RdjwZh3gGx_8ylbAHkOxZmC1a14WjQ>
    <xmx:7BLZaV813ChIvznMpGd-xFkgVPmNXdXwrMtdls3O4q4j49zX4XSq3Q>
    <xmx:7BLZaR_85qDazMsMSPQwnGMufJMfm-Bw2mrteH7EMs__axmW_lxXq6FC>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 11:10:35 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v3 12/12] selftests: net: Add a test for BIG TCP in UDP tunnels
Date: Fri, 10 Apr 2026 18:09:43 +0300
Message-ID: <20260410150943.993350-13-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410150943.993350-1-alice.kernel@fastmail.im>
References: <20260410150943.993350-1-alice.kernel@fastmail.im>
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
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-277454-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fastmail.im:dkim,fastmail.im:mid,messagingengine.com:dkim,big_tcp_tunnels.sh:url]
X-Rspamd-Queue-Id: BC37D3D906D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alice Mikityanska <alice@isovalent.com>

The test sets up VXLAN and GENEVE tunnels over IPv4 and IPv6 and runs
IPv4 and IPv6 traffic through them with BIG TCP enabled. It checks that
a non-negligible amount of big aggregated packets are seen in tcpdump.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/big_tcp_tunnels.sh  | 145 ++++++++++++++++++
 2 files changed, 146 insertions(+)
 create mode 100755 tools/testing/selftests/net/big_tcp_tunnels.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index cab74ebdaced..c8ea9d4bb94f 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -13,6 +13,7 @@ TEST_PROGS := \
 	arp_ndisc_untracked_subnets.sh \
 	bareudp.sh \
 	big_tcp.sh \
+	big_tcp_tunnels.sh \
 	bind_bhash.sh \
 	bpf_offload.py \
 	bridge_vlan_dump.sh \
diff --git a/tools/testing/selftests/net/big_tcp_tunnels.sh b/tools/testing/selftests/net/big_tcp_tunnels.sh
new file mode 100755
index 000000000000..b819911519ac
--- /dev/null
+++ b/tools/testing/selftests/net/big_tcp_tunnels.sh
@@ -0,0 +1,145 @@
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
+PACKETS_THRESHOLD=10000
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
+	ip netns exec "$SERVER_NS" killall netserver
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
+		-r 80000:80000 > /dev/null
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
2.53.0


