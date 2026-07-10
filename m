Return-Path: <netdev+bounces-306576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EB6SDVj4UGrt9AIAu9opvQ
	(envelope-from <netdev+bounces-306576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:49:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A1573B69D
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:49:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm2 header.b="i 23KWi7";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=R6t709bk;
	dmarc=pass (policy=none) header.from=fastmail.im;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306576-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306576-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B94F3050468
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB7C42314A;
	Fri, 10 Jul 2026 13:43:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2007E427A1A
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 13:43:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691033; cv=none; b=bwaSD0RpDftsEInNIpJt8PohZI/LNG/DzKIMl4hJOttGbb+olffGdBf/JWnjbCb7a22fvxDuNLi5R6apQYnyAgW8mVPzMVNT3Psh8KMhoZL3NPzbwmAGgKpY0PYnMegR+cUBD0WwMBw7yh9yVDDXRzSUSQOyMKObguRfy9qg/YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691033; c=relaxed/simple;
	bh=fYc/KcQsZZw+AOGACuw/jlT6nYbJoUrYEvYJKeboX1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2FZAVm2A55CKgR979CdZ10ZGLl7wf6Mi8SOjHZX/PnuwDWd2OhO2N0A/Yon08MXEC8hTxtBC753lXlAbKWUUU0OdTyjBax+Un/xYp5ukkJxj/bnedktPylH8X+x0/d/pLbjvt8dYWUV7aFW0iacSwtVGjjyIhNFSdr9/Wygl7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=i23KWi7J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R6t709bk; arc=none smtp.client-ip=103.168.172.148
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 51CB4EC01D6;
	Fri, 10 Jul 2026 09:43:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 10 Jul 2026 09:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1783691031; x=
	1783777431; bh=L1E50YgG3iZ8r77GNfyhQ9vTq8sKnq3BNSZf7YoI08E=; b=i
	23KWi7J/aYV5lhkze5MRNp1ZN9FYhUdmmt1ZeaBjDZju8t7YJ2K07LPqLmAgveUB
	oXmR19/J93ZvJOscv8KdKT8U12GVgrXcV8Ke0MuiCS7slGPfzlzo5AB2tb8d3oVa
	/TOQI+9IFzf/CQdWyLPTAZqGAz3l//Y0OXbGk3HyWNyNR+sOOWKhMoEBbBqpiT+m
	iZvVv3+k7iMgburWMlELOwXh9ocO0++3/hbt6m7ElMS3Ctf2PnYwGoSSjlJ0tJUx
	MziDJ2+ibvYOi1Xi2AQbKIdFj/1qQsILNRI25WrJ4oYM/4BRWj9gP6+aUObh9IV3
	27+At2Cugp+BlxofTvn3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783691031; x=1783777431; bh=L
	1E50YgG3iZ8r77GNfyhQ9vTq8sKnq3BNSZf7YoI08E=; b=R6t709bkycDS9gyaJ
	pTtg2cx5gSiRhS8MHcmTwgaNRC2wkFMfEN98FvJJjx5cf6Yq9dvC03u5cSsRAT2k
	k/p/5i7fdeSbMm6rSTAl9W1ppHJF9B3EZ5795rMoc09bSh6PBJGQgCFci/RYcLvi
	SUUGR5Waop4F+IbCloOrrE/UDa6J0dpvthUoIK7q60EIkTaE9tI+qUL9nbFkB2Co
	r07cM6xA3yjMApkZyMnlpuiOo3yI9KZ+YtLP2T0zjKQWU/M8xgd/GZsLKffvNAJU
	sJo09kyq88mbg152JBu8U5A/AWNCJVX6IUlEobbl0GjgXCvX4UCA8UyfU+7N0AkG
	d3XkQ==
X-ME-Sender: <xms:F_dQamd5CgBbcEAs00g5zBwV4Ldtg6UGtwlLe_VGpIRnLy0ejB7-Tg>
    <xme:F_dQaut4AopAGtV-sIUm5sr__2KzGLAtGXk7ALUy8zZyUVa9Y6tiTtM-8nsVliOQ6
    NeF88YMqYvlfRkVwSt7SfIyrxrRJnAw0FAw2EF7ChIVQW0CsxwQmQ>
X-ME-Received: <xmr:F_dQauW5ULRRmdFZmEOrTFk2F7_BRh3qIQYm3M9RZ_J68hN8WrQeC0WDL6q7CRK2uCwed1Kx54qgvVh-XZ0NW1iy-Vxkbk6Vh9xrUw>
X-ME-Proxy-Cause: dmFkZTEalHbXeXQ4gMKgDOTqUvoI5XrWkniatliD6pKUEnZKv7P9ZRAGKvAOXyyPK4B3t5
    JgNAuq1gMNWM3F379bjKhQ0kUBfbMQ8moVW/Kn5k1GSeCtL9SmiX/pLFWLF/zBDVs5L500
    21jX/OY8u2eE5HpL+qEZS4uZ6bDFPlRGISx5ovMCW2SJhRd6NWCQ/d3V/iCp/7qK4rBVm/
    7LD5Jn5dncpM1xb8bWzPni8dEuzsWNxMx7Yek06NWQh3v2BfajT0qECUn0HkHvJGbHMFTV
    nsCZ6KoMuiQRTTD++HtzSQ/RCSQVRTML6DOgGPQ04EOeF9Nb73ctUn264opVBKQ2XvLNJ2
    +QzexE5OoJV/+2x9f/nCjH7MzUwVsarI2gS5Go0rlW2xC3/zFvFEAISri1kxP1DzCcx5Wy
    JrQuCg1TxA3PCAfLXMbXFDFljXhDM92Qr19fzOJZy2F+QPMiiMJEpuGRw+SipJBCHOafeN
    RxphuYQY9SC7UjyUZsTBHYJj0JRgrAWoTyFTRrlHjzwE/1ddyglBuDMvK73QQo4WcQyJC4
    Iur9Yx8+WOeYzzxnGnvKPBnkLqRhFEwsnu36TbDSTo/4bJzd7+VKHQOauWGLzergDq3cmg
    12QEDvguGlUrtt4FXfAwSZ5MEFgJa32Di6xYEqmx9oFMvMSq1K3NVJFeh+Pw
X-ME-Proxy: <xmx:F_dQaj8w5RNyFGvwqxawHjKlAyBeTrO0VVaskjj2E51xcxpoWOogPg>
    <xmx:F_dQaq5iAU5vbOpUYRMTg-ZUdJ35bcycyALdtdNBL9-cCbaUysAAAw>
    <xmx:F_dQak3W342BCHzPJtyl3zdSF36SggrHOxQS6IBdqrD1oLVGNpCayw>
    <xmx:F_dQapxygLaDroX8mmo_kJMZ67DvAnIALL7iXQsJ9EZFazhMIVbeyw>
    <xmx:F_dQavKuMEzPi0M1JxJ_SMXkSQd2fmHi6tO4uVWVs9LgRG9rE7EHsi49>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 09:43:50 -0400 (EDT)
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
Subject: [PATCH net-next v9 9/9] selftests: net: Add a test for BIG TCP in UDP tunnels
Date: Fri, 10 Jul 2026 16:42:42 +0300
Message-ID: <20260710134242.216538-10-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710134242.216538-1-alice.kernel@fastmail.im>
References: <20260710134242.216538-1-alice.kernel@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306576-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,isovalent.com:email,fastmail.im:from_mime,fastmail.im:dkim,fastmail.im:mid,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75A1573B69D

From: Alice Mikityanska <alice@isovalent.com>

The test sets up VXLAN and GENEVE tunnels over IPv4 and IPv6 and runs
IPv4 and IPv6 traffic through them with BIG TCP enabled. It checks that
a non-negligible amount of big aggregated packets are seen by setting up
iptables counters.

Check the number of packets on both TX and RX sides to verify that GSO
packets are valid and not dropped. Capture on the lower netdev (veth),
when checksum offload is on, to verify that encapsulated BIG TCP packets
can get to their destination. In the test with TX checksum offload off,
software GSO splits aggregated VXLAN packets before passing them to
veth, so capture inside the tunnel instead to check that the big packets
are not dropped.

Check that the amount of SACKs is negligible. On unsupported kernels,
some amount of broken GSO packets bigger than 65536 bytes can be
produced in VXLAN tunnels, but they don't reach the destination. Seeing
TCP SACKs is a sign that such packets could have been dropped (in such
cases, the amount of SACKs is a few times bigger than the number of
attempts to send BIG TCP packets).

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/big_tcp_tunnels.sh  | 188 ++++++++++++++++++
 2 files changed, 189 insertions(+)
 create mode 100755 tools/testing/selftests/net/big_tcp_tunnels.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 708d960ae07d..4cb0a0bc1eea 100644
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
index 000000000000..d6513ed8d4e8
--- /dev/null
+++ b/tools/testing/selftests/net/big_tcp_tunnels.sh
@@ -0,0 +1,188 @@
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
+: "${PACKETS_THRESHOLD:=1000}"
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
+		echo "Setting up ${1^^} over IPv4, veth tx csum offload $3"
+	else
+		SERVER_IP="$SERVER_IP6"
+		CLIENT_IP="$CLIENT_IP6"
+		echo "Setting up ${1^^} over IPv6, veth tx csum offload $3"
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
+
+	ip netns exec "$CLIENT_NS" ethtool -K link0 tx-checksumming "$3" > /dev/null
+	ip netns exec "$SERVER_NS" ethtool -K link1 tx-checksumming "$3" > /dev/null
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
+	rm -rf "$WORKDIR"
+}
+
+do_test() {
+	# When tx csum offload is off, software GSO is performed before passing the
+	# packet to veth. Check BIG TCP packets inside the VXLAN tunnel to verify
+	# the software checksum path: if the checksum code is broken, these packets
+	# will be dropped.
+	if [ "$3" = on ]; then
+		CAPTURE_IFACE='link'
+		if [ "$1" = 4 ]; then
+			IPTABLES=iptables
+		else
+			IPTABLES=ip6tables
+		fi
+	else
+		CAPTURE_IFACE='tun'
+		if [ "$2" = 4 ]; then
+			IPTABLES=iptables
+		else
+			IPTABLES=ip6tables
+		fi
+	fi
+	if [ "$2" = 4 ]; then
+		IPTABLES_SACK=iptables
+	else
+		IPTABLES_SACK=ip6tables
+	fi
+
+	ip netns exec "$SERVER_NS" "$IPTABLES" -w -t raw -I PREROUTING -i "${CAPTURE_IFACE}1" -m length ! --length 0:65535 -m comment --comment "bigtcp"
+	ip netns exec "$CLIENT_NS" "$IPTABLES" -w -t raw -I OUTPUT -o "${CAPTURE_IFACE}0" -m length ! --length 0:65535 -m comment --comment "bigtcp"
+	ip netns exec "$SERVER_NS" "$IPTABLES_SACK" -w -t raw -I OUTPUT -o "tun1" -p tcp -m tcp --tcp-flags ACK ACK --tcp-option 5 -m comment --comment "sack"
+
+	if [ "$2" = 4 ]; then
+		SERVER_IP="$SERVER_IP4_TUN"
+		echo "Running IPv4 traffic in the tunnel"
+	else
+		SERVER_IP="$SERVER_IP6_TUN"
+		echo "Running IPv6 traffic in the tunnel"
+	fi
+
+	ip netns exec "$CLIENT_NS" netperf -t TCP_STREAM -l 5 -H "$SERVER_IP" -- \
+		-m 80000 > /dev/null
+
+	PACKETS_SERVER=$(ip netns exec "$SERVER_NS" "$IPTABLES-save" -c -t raw | sed -rn '/ --comment bigtcp/{s/^\[([0-9]+):.*/\1/p;q}')
+	PACKETS_CLIENT=$(ip netns exec "$CLIENT_NS" "$IPTABLES-save" -c -t raw | sed -rn '/ --comment bigtcp/{s/^\[([0-9]+):.*/\1/p;q}')
+	PACKETS_SACK=$(ip netns exec "$SERVER_NS" "$IPTABLES_SACK-save" -c -t raw | sed -rn '/ --comment sack/{s/^\[([0-9]+):.*/\1/p;q}')
+	ip netns exec "$SERVER_NS" "$IPTABLES" -w -t raw -D PREROUTING -i "${CAPTURE_IFACE}1" -m length ! --length 0:65535 -m comment --comment "bigtcp"
+	ip netns exec "$CLIENT_NS" "$IPTABLES" -w -t raw -D OUTPUT -o "${CAPTURE_IFACE}0" -m length ! --length 0:65535 -m comment --comment "bigtcp"
+	ip netns exec "$SERVER_NS" "$IPTABLES_SACK" -w -t raw -D OUTPUT -o "tun1" -p tcp -m tcp --tcp-flags ACK ACK --tcp-option 5 -m comment --comment "sack"
+
+	echo "Captured BIG TCP RX packets: $PACKETS_SERVER"
+	echo "Captured BIG TCP TX packets: $PACKETS_CLIENT"
+	echo "Captured TCP SACK packets: $PACKETS_SACK"
+	[ "$PACKETS_SERVER" -gt "$PACKETS_THRESHOLD" ] || return 1
+	[ "$PACKETS_CLIENT" -gt "$PACKETS_THRESHOLD" ] || return 1
+	[ "$PACKETS_SACK" -lt "$(( PACKETS_CLIENT / 2 ))" ] || return 1
+}
+
+if ! netperf -V &> /dev/null; then
+	echo "SKIP: Could not run test without netperf tool"
+	exit "$ksft_skip"
+fi
+
+if ! iptables --version &> /dev/null; then
+	echo "SKIP: Could not run test without iptables tool"
+	exit "$ksft_skip"
+fi
+
+if ! ethtool --version &> /dev/null; then
+	echo "SKIP: Could not run test without ethtool tool"
+	exit "$ksft_skip"
+fi
+
+if ! ip link help 2>&1 | grep gso_ipv4_max_size &> /dev/null; then
+	echo "SKIP: Could not run test without gso/gro_ipv4_max_size supported in ip-link"
+	exit "$ksft_skip"
+fi
+
+WORKDIR=$(mktemp -d)
+trap cleanup EXIT
+setup
+for tunnel in vxlan geneve; do
+	for tun_family in 4 6; do
+		for traffic_family in 4 6; do
+			for csum_offload in on off; do
+				setup_tunnel "$tunnel" "$tun_family" "$csum_offload" || exit "$?"
+				do_test "$tun_family" "$traffic_family" "$csum_offload" || exit "$?"
+				cleanup_tunnel
+			done
+		done
+	done
+done
-- 
2.54.0


