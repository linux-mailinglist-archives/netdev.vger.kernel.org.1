Return-Path: <netdev+bounces-261580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAJXMsiroGlulgQAu9opvQ
	(envelope-from <netdev+bounces-261580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:23:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 253661AF0D9
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADC7430B9938
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA0C44D025;
	Thu, 26 Feb 2026 20:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="MiJJlP8f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UA5ww/yi"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795BB4657CC
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137035; cv=none; b=PweL+pCbLabkK/n2dy+GItYV5oM4PVIq+o1fWBijmhfiSlaJuOoMehbpkEaY4GbGKTASHljH8BwP5ueXFqlHb4ei9wriAna1HD4Ky/cdu4N+/93sNL6IvwmPwdHirGj/lBaftvZ+RLqZmEarxHlP0WVTU1i38ni6f0pSRWtx6V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137035; c=relaxed/simple;
	bh=2Wwaqc4oz7+1hpucZTSSnkJ70zAcZ6ROnqxLbVU2IZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NzphxGNGZ4FjB/5DqElLjiJRkLyaNENoFOlxc7Phnryc8csJf4TGIObWjv4/QPkIFqSzcKKFfu1yu1Hx3GCdGAGrn41EiPj6xJ4v7rUrgu0lMDY6MDjkDVJMZ4Tzt0Dbawh9ZpUxWxhbnGxXf6Ze9tehw8+f9uo0IkD6V5ML3QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=MiJJlP8f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UA5ww/yi; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 870CA1D001C8;
	Thu, 26 Feb 2026 15:17:13 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 26 Feb 2026 15:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1772137033; x=
	1772223433; bh=io5fcKK6p1uSXILH2RV1zPuVPuGLpNFaG88CJ6NNneo=; b=M
	iJJlP8f15VjiRBoXM6yqCachwP5IFwAucC0xhnR72jjkaYixqvZOFLLB7zwd2GNG
	3jsr7g8AIR5fREvL7N4GIpfxFfQTSnGNimQVAnNAHOReDM3YyEwEx8W/VhGEU/i1
	Y7D1i2JI7Vr6idiRd1zRBX2y7iBR30Bz3Ww46DAEt5EeQNuSQBWCxXlqm2rHxsN3
	8pDfA5nPou1ee+Z3iShvbuU6hJBCYFxD7xHoHOXZe42Jl+OFSDI/9F8UbtTmsDmZ
	OwMxomB4oxtG9VjQgPdnjLT2A9bF7QZP1ZfSN8QoJKvHWKgzdBSBQj/Pa81WRFlC
	gSgXqbTse5r0+li70vOWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1772137033; x=1772223433; bh=i
	o5fcKK6p1uSXILH2RV1zPuVPuGLpNFaG88CJ6NNneo=; b=UA5ww/yiRFDPphgMq
	RKDFE7M65edhbP/gb26vTqJiT0GqdrEjARNRTfvNqFWSgrm3qGDt/HPk4syrxY4L
	qNLlJZAutIvIN92UkZI6lKtzLImIWJx+eqQ4vIoTzTR5dBRQazTsZIWXuVJOghrZ
	k0sWd1kS1C8b7FnRn5q2aCMYfZmoJ5s0CFt/oNwQnlXNbeEvFKTzsfwE/3hzKHqt
	K4pxkxKb4eYF2VXTLHxyl/46+uMDtF1XotYF4awZzvKCofdVEvyJDEp3fQN/MdCs
	YqPRsdnE2TO5licSN96rEc7ypURyPb8clweD36MB8OjMPt37HnHxO4y3/kSdGSrX
	CFtCw==
X-ME-Sender: <xms:SaqgaWsRY-ycu1ZvxStvWuPuqxVr5g9MqPOKMIYHzXdvSTVToFjbrg>
    <xme:Saqgab7_IrS6x8R0GIzoM2mfznA_kptSYSN3rx2HnnWRVUSrSXRTRZ_2wS_p1hwrr
    LZhX_wyh_WBk1Y_WfQqxYK7XuWlxUjSGK5N3cyCGE5oAqzRR25tfbs>
X-ME-Received: <xmr:SaqgaRgItwxlERMZ1tERpWWYabMvzCyHvTH6fSA7B9n3onP3Uq-0U8ge69fVHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:SaqgadnR5XcknUpY6mOwDdp4jaTMI88fy_ctcRIHxW6AcAvGvHpBiQ>
    <xmx:SaqgaQtaGkSDkGYnZElqTDZKOP5u36Qx1zjN48-lyuZEskTe1Zznyw>
    <xmx:SaqgaTCY9eu4uGa82ZLJW3-aWQqSITY-svmOTWhgLo9m8qw8ecgYvQ>
    <xmx:SaqgaVV03h5TB01AUZXw-XgbplraIGPVhfHoUfwPl7wLAsKjXG7t_A>
    <xmx:SaqgaWm6GAHhKxtlsjiKa_xvFX9gRQCmxAjIe2AOXaTVTZpJ7tjH8oyr>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 15:17:12 -0500 (EST)
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
Subject: [PATCH net-next v2 12/12] selftests: net: Add a test for BIG TCP in UDP tunnels
Date: Thu, 26 Feb 2026 22:16:00 +0200
Message-ID: <20260226201600.222044-13-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226201600.222044-1-alice.kernel@fastmail.im>
References: <20260226201600.222044-1-alice.kernel@fastmail.im>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-261580-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,isovalent.com:email]
X-Rspamd-Queue-Id: 253661AF0D9
X-Rspamd-Action: no action

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
index e97c90886f34..0134fa84fc2c 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -13,6 +13,7 @@ TEST_PROGS := \
 	arp_ndisc_untracked_subnets.sh \
 	bareudp.sh \
 	big_tcp.sh \
+	big_tcp_tunnels.sh \
 	bind_bhash.sh \
 	bpf_offload.py \
 	broadcast_ether_dst.sh \
diff --git a/tools/testing/selftests/net/big_tcp_tunnels.sh b/tools/testing/selftests/net/big_tcp_tunnels.sh
new file mode 100755
index 000000000000..6896bf36ee00
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
+	ip netns exec "$SERVER_NS" netserver 2>&1 >/dev/null
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
2.52.0


