Return-Path: <netdev+bounces-274217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIRPNqZkzWkHdAYAu9opvQ
	(envelope-from <netdev+bounces-274217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 20:32:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5626437F4D1
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 20:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDD21304BCDE
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 18:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2B83F2119;
	Wed,  1 Apr 2026 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGPBv+OD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B5439FCC5;
	Wed,  1 Apr 2026 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775067996; cv=none; b=mkFYqm5acGwdOylH9Z5C5AOBOYXayPqSss+OmL+v1BazKN5ISNGhS4DrgwFvd/DvPmW0RKK6kK+CgpMzxyr/O9PXGbB45YUifLWsz2gT/Z0V98MPPH692WsRULKwEB4AeYqDD72rJSyqdQGu0tBIriUoSOO0IQy1KAtJr7NVxJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775067996; c=relaxed/simple;
	bh=Xi+dTdDIK5HDbWpLyGuLlpABz13saNlRwVqi3YkzRKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szNabBMGB7MTJOyZ+WAwIdt+tZqRtzCHt24C7OyojAlWJyUppt6UFNkAqn5Jt2HG0ye4IIEJWcs2eGubVYiBJcWyAIHz+8EmgT6tTYTcKBdqJETs0vh5N5ACc3wU0C7/3OhIq/6coXkF47zYVeR9ZDAiXftMdujtiulFhlltXdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGPBv+OD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503E2C2BCB5;
	Wed,  1 Apr 2026 18:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775067995;
	bh=Xi+dTdDIK5HDbWpLyGuLlpABz13saNlRwVqi3YkzRKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fGPBv+ODnfHd1bCIignZcrqw6q9YpphjHZdraE8gC3fcK28wfYBjw4fhUNf5Uatra
	 I7wJbIqaj7OERH+U7MyDW2CoOVyylfslVe3qu9rf66Ss5VVdTyBjzHgSg5WEvf6B9P
	 bKyTzYm6BhKfwFNt/dNWWi+4Eig6h68wloewuADmboo4A7WgO2NHSYNBqLVd50R24V
	 qMUeRujg7bPErVbo6eTfdYlC9uunxx5l9MUFRCCS0744XRdLl1769adsJKTg3V1v4y
	 lsCZ5uDeLmfIkyeakJc50HbhmJchQfs9vk/CgxaFV1jjMG2vG7BNpbuzGOf4kGkcPL
	 6FbdzHnTZFgsQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	anubhavsinggh@google.com,
	richardbgobert@gmail.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/6] selftests: drv-net: gro: test ip6ip6
Date: Wed,  1 Apr 2026 11:26:24 -0700
Message-ID: <20260401182625.372605-6-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401182625.372605-1-kuba@kernel.org>
References: <20260401182625.372605-1-kuba@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-274217-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5626437F4D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We explicitly test ipip encap. Let's add ip6ip6, too. Having
just ipip seems like favoring IPv4 which we should not do :)
Testing all combinations is left for future work, not sure
it's actually worth it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/gro.c      | 29 ++++++++++++++++------
 tools/testing/selftests/drivers/net/gro.py | 19 ++++++++------
 2 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/lib/gro.c b/tools/testing/selftests/net/lib/gro.c
index 57080ecc3df8..762e88932ed2 100644
--- a/tools/testing/selftests/net/lib/gro.c
+++ b/tools/testing/selftests/net/lib/gro.c
@@ -94,11 +94,14 @@
 #define START_SEQ 100
 #define START_ACK 100
 #define ETH_P_NONE 0
-#define TOTAL_HDR_LEN (ETH_HLEN + sizeof(struct ipv6hdr) + sizeof(struct tcphdr))
+#define TOTAL_HDR_LEN \
+	(ETH_HLEN + sizeof(struct ipv6hdr) * 2 + sizeof(struct tcphdr))
 #define MSS (4096 - sizeof(struct tcphdr) - sizeof(struct ipv6hdr))
-#define MAX_PAYLOAD (IP_MAXPACKET - sizeof(struct tcphdr) - sizeof(struct ipv6hdr))
+#define MAX_PAYLOAD \
+	(IP_MAXPACKET - sizeof(struct tcphdr) - sizeof(struct ipv6hdr))
 #define NUM_LARGE_PKT (MAX_PAYLOAD / MSS)
-#define MAX_HDR_LEN (ETH_HLEN + sizeof(struct ipv6hdr) + sizeof(struct tcphdr))
+#define MAX_HDR_LEN \
+	(ETH_HLEN + sizeof(struct ipv6hdr) * 2 + sizeof(struct tcphdr))
 #define MIN_EXTHDR_SIZE 8
 #define EXT_PAYLOAD_1 "\x00\x00\x00\x00\x00\x00"
 #define EXT_PAYLOAD_2 "\x11\x11\x11\x11\x11\x11"
@@ -131,6 +134,7 @@ static int tcp_offset = -1;
 static int total_hdr_len = -1;
 static int ethhdr_proto = -1;
 static bool ipip;
+static bool ip6ip6;
 static uint64_t txtime_ns;
 static int num_flows = 4;
 static bool order_check;
@@ -1113,7 +1117,8 @@ static void check_recv_pkts(int fd, int *correct_payload,
 
 		if (iph->version == 4)
 			ip_ext_len = (iph->ihl - 5) * 4;
-		else if (ip6h->version == 6 && ip6h->nexthdr != IPPROTO_TCP)
+		else if (ip6h->version == 6 && !ip6ip6 &&
+			 ip6h->nexthdr != IPPROTO_TCP)
 			ip_ext_len = MIN_EXTHDR_SIZE;
 
 		tcph = (struct tcphdr *)(buffer + tcp_offset + ip_ext_len);
@@ -1175,7 +1180,8 @@ static void check_capacity_pkts(int fd)
 
 		if (iph->version == 4)
 			ip_ext_len = (iph->ihl - 5) * 4;
-		else if (ip6h->version == 6 && ip6h->nexthdr != IPPROTO_TCP)
+		else if (ip6h->version == 6 && !ip6ip6 &&
+			 ip6h->nexthdr != IPPROTO_TCP)
 			ip_ext_len = MIN_EXTHDR_SIZE;
 
 		tcph = (struct tcphdr *)(buffer + tcp_offset + ip_ext_len);
@@ -1688,6 +1694,7 @@ static void parse_args(int argc, char **argv)
 		{ "ipv4", no_argument, NULL, '4' },
 		{ "ipv6", no_argument, NULL, '6' },
 		{ "ipip", no_argument, NULL, 'e' },
+		{ "ip6ip6", no_argument, NULL, 'E' },
 		{ "num-flows", required_argument, NULL, 'n' },
 		{ "rx", no_argument, NULL, 'r' },
 		{ "saddr", required_argument, NULL, 's' },
@@ -1699,7 +1706,7 @@ static void parse_args(int argc, char **argv)
 	};
 	int c;
 
-	while ((c = getopt_long(argc, argv, "46d:D:ei:n:rs:S:t:ov", opts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "46d:D:eEi:n:rs:S:t:ov", opts, NULL)) != -1) {
 		switch (c) {
 		case '4':
 			proto = PF_INET;
@@ -1714,6 +1721,11 @@ static void parse_args(int argc, char **argv)
 			proto = PF_INET;
 			ethhdr_proto = htons(ETH_P_IP);
 			break;
+		case 'E':
+			ip6ip6 = true;
+			proto = PF_INET6;
+			ethhdr_proto = htons(ETH_P_IPV6);
+			break;
 		case 'd':
 			addr4_dst = addr6_dst = optarg;
 			break;
@@ -1758,12 +1770,15 @@ int main(int argc, char **argv)
 	if (ipip) {
 		tcp_offset = ETH_HLEN + sizeof(struct iphdr) * 2;
 		total_hdr_len = tcp_offset + sizeof(struct tcphdr);
+	} else if (ip6ip6) {
+		tcp_offset = ETH_HLEN + sizeof(struct ipv6hdr) * 2;
+		total_hdr_len = tcp_offset + sizeof(struct tcphdr);
 	} else if (proto == PF_INET) {
 		tcp_offset = ETH_HLEN + sizeof(struct iphdr);
 		total_hdr_len = tcp_offset + sizeof(struct tcphdr);
 	} else if (proto == PF_INET6) {
 		tcp_offset = ETH_HLEN + sizeof(struct ipv6hdr);
-		total_hdr_len = MAX_HDR_LEN;
+		total_hdr_len = tcp_offset + sizeof(struct tcphdr);
 	} else {
 		error(1, 0, "Protocol family is not ipv4 or ipv6");
 	}
diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
index 73436d16b40d..68b7b29ea2ee 100755
--- a/tools/testing/selftests/drivers/net/gro.py
+++ b/tools/testing/selftests/drivers/net/gro.py
@@ -213,7 +213,7 @@ def _run_gro_bin(cfg, test_name, protocol=None, num_flows=None,
     return rx_proc
 
 
-def _setup(cfg, mode, test_name):
+def _setup(cfg, mode, test_name, protocol):
     """ Setup hardware loopback mode for GRO testing. """
 
     if not hasattr(cfg, "bin_remote"):
@@ -225,10 +225,15 @@ def _run_gro_bin(cfg, test_name, protocol=None, num_flows=None,
         cfg.remote_feat = ethtool(f"-k {cfg.remote_ifname}",
                                   host=cfg.remote, json=True)[0]
 
-    # "large_*" tests need at least 4k MTU
+    # "large_*" tests need at least 4k MTU, bump more for encapsulation
     if test_name.startswith("large_"):
-        _set_mtu_restore(cfg.dev, 4096, None)
-        _set_mtu_restore(cfg.remote_dev, 4096, cfg.remote)
+        mtu = 4096
+        if protocol == "ipip":
+            mtu += 20  # outer IPv4 header
+        elif protocol == "ip6ip6":
+            mtu += 40  # outer IPv6 header
+        _set_mtu_restore(cfg.dev, mtu, None)
+        _set_mtu_restore(cfg.remote_dev, mtu, cfg.remote)
 
     if mode == "sw":
         flush_path = f"/sys/class/net/{cfg.ifname}/gro_flush_timeout"
@@ -313,7 +318,7 @@ def _run_gro_bin(cfg, test_name, protocol=None, num_flows=None,
     ]
 
     for mode in ["sw", "hw", "lro"]:
-        for protocol in ["ipv4", "ipv6", "ipip"]:
+        for protocol in ["ipv4", "ipv6", "ipip", "ip6ip6"]:
             for test_name in common_tests:
                 yield mode, protocol, test_name
 
@@ -332,7 +337,7 @@ def _run_gro_bin(cfg, test_name, protocol=None, num_flows=None,
     ipver = "6" if protocol[-1] == "6" else "4"
     cfg.require_ipver(ipver)
 
-    _setup(cfg, mode, test_name)
+    _setup(cfg, mode, test_name, protocol)
 
     # Each test is run 6 times to deflake, because given the receive timing,
     # not all packets that should coalesce will be considered in the same flow
@@ -382,7 +387,7 @@ def _run_gro_bin(cfg, test_name, protocol=None, num_flows=None,
     """
     max_retries = 3
 
-    _setup(cfg, mode, "capacity")
+    _setup(cfg, mode, "capacity", None)
     queue_id = setup_func(cfg)
 
     num_flows = 8
-- 
2.53.0


