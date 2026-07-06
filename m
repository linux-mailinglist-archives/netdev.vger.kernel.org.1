Return-Path: <netdev+bounces-305194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Sh3oMuT0S2q7dgEAu9opvQ
	(envelope-from <netdev+bounces-305194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:33:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A66EE7148BB
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:33:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm2 header.b="C q5COIW";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=dkZv+qnu;
	dmarc=pass (policy=none) header.from=fastmail.im;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305194-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305194-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2718F304C2CE
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 18:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B865436BDA;
	Mon,  6 Jul 2026 18:21:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9193BBFB6
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 18:21:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362084; cv=none; b=kjCgOTqNFxkuxJmWQ0z7v0LEPUssWkUsoxG8/8nVVY0HsqH4JJqbyEyGLmMm96v+TjvUb5yeyvI9XyQinflHQE7KozMmJ2n4x15iXPpVCSkTDYcDUfiTts6ywbEFBh6WZnRJRr4iWpYw68lUHXkpuA06lDDKEfRv/6aYuvttB8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362084; c=relaxed/simple;
	bh=M2BSyy2yINMYuwsvQFRMhFXd2S6hHyckfgfETT82GyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ho/gqvP8SFwaqWDQNj5coNwkapUS4zLL6wFnKCse6Ma3yXF7wOe4rskaJE3tthlPNwXnggQaIAZX0E113Vf0Ypge1N1tJgnhC0uv4bw1HIPfR+zlYMTbMQ+ubEuscVE+rhwW+Ndtzmo8jONbJb50VDp2jpZIl0uJdMrj3/zalEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=Cq5COIWQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dkZv+qnu; arc=none smtp.client-ip=103.168.172.144
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 73CF4EC0170;
	Mon,  6 Jul 2026 14:21:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 06 Jul 2026 14:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1783362082; x=
	1783448482; bh=pwSrpC+fI9+So9XpNmR/XSK5MT07nDzIPZeA4Cq8C2A=; b=C
	q5COIWQiUgJby55IdwKlT3gHXFXbHIHLvI9GIZemEJbkImI2fQXZfTaueJOjsRHX
	9Zea2F+2mDFJaiqKde1mO7sGUOeo2OMUaZcOrngtQQgkF4Xx5S3wAlwVA/56aQla
	AjtXSxnrUnTlHqnx+JCXty7+jKl8QWIa1LYi+Hcc9EKglBp46AdxNgC5EqMNNLEK
	YQYaROl7cnQ0kFuj4oqKf3UqXRxYNKTqc4H4sh2cABiKoPabU2rLfjso6qKKZnG5
	3Tqk4PGtCPfWvtVBo92OSYZfUrTPq4urqEjd3IWCei+nWZFkjoXKW1V/OqiF6gqM
	H4KM1ONt71X23SP5QXLqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783362082; x=1783448482; bh=p
	wSrpC+fI9+So9XpNmR/XSK5MT07nDzIPZeA4Cq8C2A=; b=dkZv+qnuGhUPlsyVf
	2Uir7V6hBshLotL4ZTN8HlS3+5NtpNTSPSt9cUTzWJ9B8j35JRDfxb/j4MX+o0Si
	LQ2AItCsUt9WKVNp316BRMPbg9EJizugzq4W2A4IBKrtj+5NJzZHNuPgh9dezbEO
	mmmZI3x56XNW8Lb11cSGzoYBMk8dxZf+S3DmB5vdG5yCfNCSo4eshMyA2PKDs4gF
	fo5Lr6vw3WwbiMu6xPqltT0ydOvezcdKJ01B7F7m+VqQPunxBu1JlVbBr/qx0FTW
	4tr1oRHX7zefXKBGQ+DBsT+SQj8c2WWmR/VnFRs78veWMtGOCRmz3bSd2dqu89qC
	wT57g==
X-ME-Sender: <xms:IvJLaggYIrwJH-nXI44S-FH8k4jsaAaR5FN0sFS0t5EjsrbDik2WZw>
    <xme:IvJLanipAbOPEcvS_E01tIVtBeLLz5a-QZPL_42560c-mj-XxGiVAaygAFEJzLAPD
    QOQaXD_BqSKy7E384FsiK0_Bdj6PKMyUweag26spOl0QdlSw8SAzHU>
X-ME-Received: <xmr:IvJLau4Tk3bX4cBOkQABljxH9tT5Wrpj3BXUXAR2vV5VmvH92CqX6Yu_WXM>
X-ME-Proxy-Cause: dmFkZTFbIBwHZZQggc7WF/1olKgTNxKyqtMFe1o5AKCoT99Rnn4xxrTiP0hUlyLK5mjj0D
    D4GNGhxx8/tbHzW7vIaJtDF85W67FXOyiw79VsWxMflon68gslMlp2JDjuK1WtYHifMfMr
    VM1DDLK0AU9PPt1588+vJCUm5FWDdk9KKWPytjzPkV3ZVH9J28EqRQcmXNGUFis+ungWdl
    AbXAezeM4pFnPeLDBorONxYGMP+IPUqc5cX5RHKUScGgQckeaj0yZIeEoPYyLwpnzBlhNg
    ohv2URCXVXlgnizBwZyhSieeCgN8x7LYr3nHNsSWOnsw46r89+yhRHaaCM8I+xis2z4rSv
    3uyEahjqlO4sll0rrDrDIhkb1Huq7N7+4j/4nxYFyvAnGOF9fvhHmLJFzKjX2pGVGxdA9B
    Fwyt9WqPety4ggGsBzmgwfeGycxVEg/gGdVJEcdq5hqdgbPD4UHf/EkOHQv0ZVXNA29JRY
    LfY+b1hV/8fwoNjmdCu8fmBBT0d3qkgTyGN16zM+0GvWNfNZbX4FcB4X4gGUCLE7OkuAs8
    V7K5VgKZvPeJ91c510DqFR4fXzVxE7U4bXd91A5siQnsAPlQIeVcneWmoMCX/A2KEy+/UK
    q/tisGLfKi0t0WZNQaWm7/SsYnDt+ZXwv4nGTG08a6lAP984b9nqRQlFPAJw
X-ME-Proxy: <xmx:IvJLahScVTXEzGTGLUMFnhE977uN0hYVjqx3wpIfcLLmdf6mA0F_6g>
    <xmx:IvJLal-qHKrJtRz6wH4RY820okU2KE3sa5pMuLLAqOjenGjYK3t9Gw>
    <xmx:IvJLaqpiEt3wIRB_kb7d1btY71lLDh7p_dEFpBOEDra-YDEWveWWJA>
    <xmx:IvJLajXE3eS7o6wNxEHc4CSRIOQ8kbdJw67JHXDGJh_82sKRgPRj7w>
    <xmx:IvJLaqq3uUPZuQ8EQAgGJ-F9rI7QhamBMZuvKsusU0aw06acyXAkP5eM>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 14:21:21 -0400 (EDT)
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
Subject: [PATCH net-next v8 9/9] selftests: net: Add a test for BIG TCP in UDP tunnels
Date: Mon,  6 Jul 2026 21:19:41 +0300
Message-ID: <20260706181941.385672-10-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706181941.385672-1-alice.kernel@fastmail.im>
References: <20260706181941.385672-1-alice.kernel@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305194-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fastmail.im:from_mime,fastmail.im:dkim,fastmail.im:mid,messagingengine.com:dkim,isovalent.com:email,vger.kernel.org:from_smtp,big_tcp_tunnels.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A66EE7148BB

From: Alice Mikityanska <alice@isovalent.com>

The test sets up VXLAN and GENEVE tunnels over IPv4 and IPv6 and runs
IPv4 and IPv6 traffic through them with BIG TCP enabled. It checks that
a non-negligible amount of big aggregated packets are seen in tcpdump.

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
 .../testing/selftests/net/big_tcp_tunnels.sh  | 183 ++++++++++++++++++
 2 files changed, 184 insertions(+)
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
index 000000000000..128a710e74ad
--- /dev/null
+++ b/tools/testing/selftests/net/big_tcp_tunnels.sh
@@ -0,0 +1,183 @@
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
+	if [ "$2" = on ]; then
+		CAPTURE_IFACE='link'
+	else
+		CAPTURE_IFACE='tun'
+	fi
+
+	ip netns exec "$SERVER_NS" tcpdump -nn -s 256 -i "${CAPTURE_IFACE}1" greater 65536 -w "$WORKDIR/server.pcap" 2> /dev/null &
+	TCPDUMP_SERVER_PID="$!"
+	ip netns exec "$CLIENT_NS" tcpdump -nn -s 256 -i "${CAPTURE_IFACE}0" greater 65536 -w "$WORKDIR/client.pcap" 2> /dev/null &
+	TCPDUMP_CLIENT_PID="$!"
+
+	# This filter doesn't capture all possible variants of SACK, but it's aimed
+	# at the typical one where SACK follows after [nop, nop, timestamp, nop,
+	# nop] (14 bytes after the 20-byte TCP header). IPv6 needs a separate match,
+	# because man tcpdump says:
+	# > Arithmetic expression against transport layer headers, like tcp[0], does
+	# > not work against IPv6 packets.  It only looks at IPv4 packets.
+	ip netns exec "$SERVER_NS" tcpdump -nn -s 256 -i "tun1" '(tcp[tcpflags] & (tcp-syn|tcp-ack) = tcp-ack and tcp[34:2] & 0xffc3 = 0x0502) or (ip6[6] = 0x06 and ip6[53] & 0x12 = 0x10 and ip6[74:2] & 0xffc3 = 0x0502)' -w "$WORKDIR/sack.pcap" 2> /dev/null &
+	TCPDUMP_SACK_PID="$!"
+
+	if [ "$1" = 4 ]; then
+		SERVER_IP="$SERVER_IP4_TUN"
+		echo "Running IPv4 traffic in the tunnel"
+	else
+		SERVER_IP="$SERVER_IP6_TUN"
+		echo "Running IPv6 traffic in the tunnel"
+	fi
+
+	sleep 1 # Give tcpdump a second to spin up.
+	ip netns exec "$CLIENT_NS" netperf -t TCP_STREAM -l 5 -H "$SERVER_IP" -- \
+		-m 80000 > /dev/null
+	sleep 1 # Give tcpdump a second to process buffered packets.
+	kill "$TCPDUMP_SERVER_PID" "$TCPDUMP_CLIENT_PID" "$TCPDUMP_SACK_PID"
+	wait "$TCPDUMP_SERVER_PID" "$TCPDUMP_CLIENT_PID" "$TCPDUMP_SACK_PID"
+	PACKETS_SERVER=$(tcpdump --count -r "$WORKDIR/server.pcap" 2> /dev/null | cut -d ' ' -f 1)
+	PACKETS_CLIENT=$(tcpdump --count -r "$WORKDIR/client.pcap" 2> /dev/null | cut -d ' ' -f 1)
+	PACKETS_SACK=$(tcpdump --count -r "$WORKDIR/sack.pcap" 2> /dev/null | cut -d ' ' -f 1)
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
+if ! tcpdump --version &> /dev/null; then
+	echo "SKIP: Could not run test without tcpdump tool"
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
+				do_test "$traffic_family" "$csum_offload" || exit "$?"
+				cleanup_tunnel
+			done
+		done
+	done
+done
-- 
2.54.0


