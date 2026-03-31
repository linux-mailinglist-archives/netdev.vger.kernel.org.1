Return-Path: <netdev+bounces-273754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cICRGZ44zGn7RQYAu9opvQ
	(envelope-from <netdev+bounces-273754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:11:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BF43716D7
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ADD18304458F
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 21:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A444C3F7E85;
	Tue, 31 Mar 2026 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khGugw4J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8121241323C;
	Tue, 31 Mar 2026 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991297; cv=none; b=pePK+ZjRzcuTGEYLfEaw7ih620JvIegfaeGR0JUDp/fymEnDSh+5IHaHbvJ7kgWsVCN/GQvH5UPDYOiZPGN1+R4lCPNeSWmjZpw5LgT2agRtFUrBcaprTBujpkE67v6oAAwE6Njxis3iprwnxYVEu/o8PsYzu0sjADxijWBppFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991297; c=relaxed/simple;
	bh=Cyg0OgS3jjG2kLGWNtFAfuJOGcQ0Gbkr6O2xIRnNmS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGD9j102m3RwZJHR7asPlPdyYj1t2FClS/1CpOEwo8lATs20V+NK5CneMYs3+K+oJOhdz3du9+kgu9SCVUb1L1A0YaGhYtieiwIt8pfSSz8+hgTP2NUsKdU/XpZAQn+FOxH15uTghCrR9SO7z6q8F9z3NixTMoKw3saIm3hiUOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khGugw4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47EFC2BC9E;
	Tue, 31 Mar 2026 21:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774991297;
	bh=Cyg0OgS3jjG2kLGWNtFAfuJOGcQ0Gbkr6O2xIRnNmS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=khGugw4J1U+G1A4fMZWUWMmTVJzu3BfpMeUzM15FknZIAQqK7tm10avMOUzQXwjl/
	 /aVOn1AQm+PvLucyB2dX2DIyq8hJpm9BDs2O8hYl/7uvDHgRN+MMj2IG+SPFVrpDsi
	 ul7khj5juWoPfPj0I7BGunVjEwxmXe0iYO1yTDxs12wTVM4u17W0p4zz/nzcEkDABn
	 uvpJkqti6psOBuX5Qqkt6+eJfR2/nGPklGFrppqd+ThlflGGC/iM/ysqGev0kvwHpk
	 IvdVzXIi2WNzGxThXpJREsZUqTmMiUdniT6uVxzMMH/aCC0zsKWuagQ5xrh89Ny3v1
	 Biy5+bFfC7oqA==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	hawk@kernel.org,
	ivan@cloudflare.com,
	kernel-team@cloudflare.com
Subject: [RFC PATCH net-next 2/4] ipv6: make inet6_addr_lst hash table size configurable
Date: Tue, 31 Mar 2026 23:07:37 +0200
Message-ID: <20260331210739.3998753-3-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331210739.3998753-1-hawk@kernel.org>
References: <20260331210739.3998753-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273754-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09BF43716D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jesper Dangaard Brouer <hawk@kernel.org>

Similar to the IPv4 inet_addr_lst hash table, IPv6 also uses a fixed
256-bucket hash table for address lookups. On hosts with many IPv6
addresses, this results in long hash chains walked under RCU.

The inet6_addr_lst table is used in the route lookup path when no
output interface is specified (oif == 0):

  udpv6_sendmsg
    ip6_sk_dst_lookup_flow
      ip6_dst_lookup_tail
        ip6_route_output -> fib6 lookup
          __rt6_device_match
            ipv6_chk_addr              <-- walks inet6_addr_lst

Add CONFIG_INET6_ADDR_HASH_BUCKETS (default 256, range 64-16384, EXPERT)
so hosts with many addresses can size the table appropriately. The value
is rounded up to the nearest power of 2 at compile time via
order_base_2(). Memory cost is one hlist_head pointer per bucket per net
namespace.

Reported-by: Ivan Babrou <ivan@cloudflare.com>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 net/ipv6/Kconfig    | 15 +++++++++++++++
 net/ipv6/addrconf.c |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/Kconfig b/net/ipv6/Kconfig
index b8f9a8c0302e..963fa0e1a014 100644
--- a/net/ipv6/Kconfig
+++ b/net/ipv6/Kconfig
@@ -238,6 +238,21 @@ config IPV6_FOU_TUNNEL
 	default NET_FOU_IP_TUNNELS && IPV6_FOU
 	select IPV6_TUNNEL
 
+config INET6_ADDR_HASH_BUCKETS
+	int "IPv6 address hash table size" if EXPERT
+	range 64 16384
+	default 256
+	help
+	  Number of hash buckets for looking up local IPv6 addresses,
+	  e.g. in ipv6_chk_addr() and related callers.  Rounded up to
+	  the nearest power of 2.
+
+	  Hosts with many IPv6 addresses benefit from a larger table to
+	  reduce hash chain lengths.
+
+	  The default of 256 is fine for most systems.  A value of 1024
+	  suits hosts with ~500+ addresses.
+
 config IPV6_MULTIPLE_TABLES
 	bool "IPv6: Multiple Routing Tables"
 	select FIB_RULES
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 0e55f139e05d..dad08f0733ef 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -144,7 +144,7 @@ static int ipv6_generate_stable_address(struct in6_addr *addr,
 					u8 dad_count,
 					const struct inet6_dev *idev);
 
-#define IN6_ADDR_HSIZE_SHIFT	8
+#define IN6_ADDR_HSIZE_SHIFT	order_base_2(CONFIG_INET6_ADDR_HASH_BUCKETS)
 #define IN6_ADDR_HSIZE		(1 << IN6_ADDR_HSIZE_SHIFT)
 
 static void addrconf_verify(struct net *net);
-- 
2.43.0


