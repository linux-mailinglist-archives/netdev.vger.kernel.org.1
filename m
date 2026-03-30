Return-Path: <netdev+bounces-273138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPWzFAVgymn27gUAu9opvQ
	(envelope-from <netdev+bounces-273138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:35:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B79DA35A59B
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECB4D3006471
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 11:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025313BED32;
	Mon, 30 Mar 2026 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhqU71P0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EFC3BD65B
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 11:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774870530; cv=none; b=UhO2LH6gm/HkaNUYJaMvKkuWWwbAMB6b+A33aS9z+bhQfkEQfwvqV6hfQ9pJ6zSSzsDzMb/ReCblRsSX5qrCoEgnBtYAXCygPxO9FAP68/oJn0FnAHDk+tyPU3SxJ4VXFrAr/jfGKO2JZWF+JVEnno/CGX13uDNT0VjuQmtCW5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774870530; c=relaxed/simple;
	bh=s0GYGHG3bHHnLSUpuw3XwU4YANaEchmaJvsIJazD/8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QKAFV5XibIHIS8Z5FAzPNKchplP3lZFb/yqQhpS06iojFLeMPnPeZrniOSzfUfVJMnRf9fqGfCWZPh924bPk4gFYWV5efivmNsRhp//ICxjClQqw69ihjY8eoj9AQ4KxzcV7Tp9ceo4sAbo6YeDsXlBX5DM91+MD0AGe+PriaFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HhqU71P0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774870528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FiZviYo8L2f9R9HpzuBCyEjwLeRZJHeIjS+87uHF2Oc=;
	b=HhqU71P03dSYseWStW1VMndlYNKtpnoxL58xrGfvw/8Bs+1rIqcxNS3Ur6XvGc9L1NJaa3
	2ox/it8XKMdBjdtcoQyVNZCDKj7bt0vhr4Saod7P2xHwdtHdm/EQkr7Wy2Es/idLP6mUwN
	Ceg8h1kqil88fusH8GEiCDbvXmJMWlw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-oMNhOeO0MPygyrTPLK-6HQ-1; Mon,
 30 Mar 2026 07:35:23 -0400
X-MC-Unique: oMNhOeO0MPygyrTPLK-6HQ-1
X-Mimecast-MFC-AGG-ID: oMNhOeO0MPygyrTPLK-6HQ_1774870521
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EDEC19560B1;
	Mon, 30 Mar 2026 11:35:20 +0000 (UTC)
Received: from yiche-laptop.redhat.com (unknown [10.72.112.165])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 627951955D84;
	Mon, 30 Mar 2026 11:35:12 +0000 (UTC)
From: Yi Chen <yiche@redhat.com>
To: Chen Yi <yiche@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Long Xin <lxin@redhat.com>,
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
Subject: [PATCH] selftests: netfilter: conntrack_sctp_collision.sh: Introduce SCTP INIT collision test
Date: Mon, 30 Mar 2026 19:35:09 +0800
Message-ID: <20260330113509.23990-1-yiche@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273138-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yiche@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B79DA35A59B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The existing test covered a scenario where a delayed INIT_ACK chunk
updates the vtag in conntrack after the association has already been
established.

A similar issue can occur with a delayed SCTP INIT chunk.

Add a new simultaneous-open test case where the client's INIT is
delayed, allowing conntrack to establish the association based on
the server-initiated handshake.

When the stale INIT arrives later, it may overwirte the vtag in
conntrack, causing subsequent SCTP DATA chunks to be considered
as invalid and then dropped by nft rules matching on ct state invalid.

This test verifies such stale INIT chunks do not corrupt conntrack
state.

Signed-off-by: Yi Chen <yiche@redhat.com>
---
 .../net/netfilter/conntrack_sctp_collision.sh | 84 ++++++++++++++-----
 1 file changed, 65 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/conntrack_sctp_collision.sh b/tools/testing/selftests/net/netfilter/conntrack_sctp_collision.sh
index d860f7d9744b..7f8f1b6b746a 100755
--- a/tools/testing/selftests/net/netfilter/conntrack_sctp_collision.sh
+++ b/tools/testing/selftests/net/netfilter/conntrack_sctp_collision.sh
@@ -23,8 +23,19 @@ SERVER_PORT=1234
 CLIENT_GW="198.51.200.2"
 SERVER_GW="198.51.100.2"
 
+assert_pass()
+{
+	local ret=$?
+	if [ $ret != 0 ]; then
+		echo "FAIL: ${@}"
+		exit $ksft_fail
+	else
+		echo "PASS: ${@}"
+	fi
+}
+
 # setup the topo
-setup() {
+topo_setup() {
 	setup_ns CLIENT_NS SERVER_NS ROUTER_NS
 	ip -n "$SERVER_NS" link add link0 type veth peer name link1 netns "$ROUTER_NS"
 	ip -n "$CLIENT_NS" link add link3 type veth peer name link2 netns "$ROUTER_NS"
@@ -42,21 +53,51 @@ setup() {
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
-		echo "SKIP: Cannot add netem qdisc"
-		exit $ksft_skip
-	fi
+conf_delay()
+{
+	# simulate the delay on OVS upcall by setting up a delay for INIT_ACK/INIT with
+	case $1 in
+	"INIT") chunk_type=1
+		# tc on $CLIENT_NS side
+		tc -n "$CLIENT_NS" qdisc add dev link3 root handle 1: htb r2q 64
+		tc -n "$CLIENT_NS" class add dev link3 parent 1: classid 1:1 htb rate 100mbit
+		tc -n "$CLIENT_NS" filter add dev link3 parent 1: protocol ip \
+			u32 match ip protocol 132 0xff match u8 $chunk_type 0xff at 32 flowid 1:1
+		if ! tc -n "$CLIENT_NS" qdisc add dev link3 parent 1:1 handle 10: \
+			netem delay 1200ms; then
+			echo "SKIP: Cannot add netem qdisc"
+			exit $ksft_skip
+		fi
+		;;
+	"INIT_ACK") chunk_type=2
+		# tc on $SERVER_NS side
+		tc -n "$SERVER_NS" qdisc add dev link0 root handle 1: htb r2q 64
+		tc -n "$SERVER_NS" class add dev link0 parent 1: classid 1:1 htb rate 100mbit
+		tc -n "$SERVER_NS" filter add dev link0 parent 1: protocol ip \
+			u32 match ip protocol 132 0xff match u8 $chunk_type 0xff at 32 flowid 1:1
+		if ! tc -n "$SERVER_NS" qdisc add dev link0 parent 1:1 handle 10: \
+			netem delay 1200ms; then
+			echo "SKIP: Cannot add netem qdisc"
+			exit $ksft_skip
+		fi
+		;;
+	esac
 
 	# simulate the ctstate check on OVS nf_conntrack
-	ip net exec "$ROUTER_NS" iptables -A FORWARD -m state --state INVALID,UNTRACKED -j DROP
-	ip net exec "$ROUTER_NS" iptables -A INPUT -p sctp -j DROP
+	ip net exec "$ROUTER_NS" nft -f - <<-EOF
+	table ip t {
+	        chain forward {
+	                type filter hook forward priority filter; policy accept;
+	                meta l4proto { icmp, icmpv6 } accept
+	                ct state new counter accept
+	                ct state established,related counter accept
+	                ct state invalid log flags all counter drop
+	                counter
+	        }
+	}
+	EOF
 
 	# use a smaller number for assoc's max_retrans to reproduce the issue
 	modprobe -q sctp
@@ -64,8 +105,6 @@ setup() {
 }
 
 cleanup() {
-	ip net exec "$CLIENT_NS" pkill sctp_collision >/dev/null 2>&1
-	ip net exec "$SERVER_NS" pkill sctp_collision >/dev/null 2>&1
 	cleanup_all_ns
 }
 
@@ -81,7 +120,14 @@ do_test() {
 
 # run the test case
 trap cleanup EXIT
-setup && \
-echo "Test for SCTP Collision in nf_conntrack:" && \
-do_test && echo "PASS!"
-exit $?
+
+echo "Test for SCTP INIT_ACK Collision in nf_conntrack:"
+topo_setup && conf_delay INIT_ACK
+do_test
+assert_pass "The delayed INIT_ACK chunk did not disrupt sctp ct tracking."
+
+echo "Test for SCTP INIT Collision in nf_conntrack:"
+
+topo_setup && conf_delay INIT
+do_test
+assert_pass "The delayed INIT chunk did not disrupt sctp ct tracking."
-- 
2.53.0


