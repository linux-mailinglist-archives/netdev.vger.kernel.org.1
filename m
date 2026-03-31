Return-Path: <netdev+bounces-273753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGXBDJY4zGn7RQYAu9opvQ
	(envelope-from <netdev+bounces-273753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:11:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E563716C8
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 255923075C79
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 21:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC1C41B36E;
	Tue, 31 Mar 2026 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEKV47/O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ABF3F7E85;
	Tue, 31 Mar 2026 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991294; cv=none; b=vDSrhqpLqKm4xPu4tMn6R3G0/gTsseUMRG/fvonm+KfyfSOJBj29H90JNCc6h+ZoLIZZRUFJ/urwnYpnD+kdNfrTrq7vNulwW21VzpUfarjv6ChImjNSVZ8eC94eJsjr6z/V3b3Xd6uwIkl42Z1FA+RTd6SheElkHHvD3YqfoMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991294; c=relaxed/simple;
	bh=JdBj+HtDMVC42XbqSpihFgQM2SrH7WKTCtHvC61tAU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzbC5D2k0Zx9Am/taR2l7Bayd6xvVxcVQFtrGqqxfxnBYB+YlaGn/sCmIaVFb63MPJzZZxeAOhNvM6wLrCKEVrm98Nz6C+4hSgY611ouyfqZXt17lYZVqPc7m/alaz9McWrVyyAp6Ql9zOZn18FuYjeLKkg+kM6NXR2+y+RLjkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEKV47/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD90BC19423;
	Tue, 31 Mar 2026 21:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774991294;
	bh=JdBj+HtDMVC42XbqSpihFgQM2SrH7WKTCtHvC61tAU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BEKV47/OeccX0pCIeAJET1rM8GcFyMFpdLlhu1bq+rLQDwddZ3kfIAEmuzNB1hZpm
	 FmEKAFj10pTghwtW8cuIr749BGpLvj+cpMi2x++8FJIdTJCgqeCsbLjT2Ytklr5//l
	 ihIcW0nPspOufmnpxeDB9OAIzU50+8qRuwy0H0dD/ooLx1CNnWWftRpr00bNhCU7Ih
	 Z7STgi/q0Gu/Ub21g7/sVWhO5ZF9zIiAGOdaaCz0Rrsrk9XHLa/i1rSOn0D+yBKlrc
	 WGnHFSyn2xhWe/SGtZ2d0Svj0dK7vW6psu2o/BDSsikj59e3z8+6bNjyqcfHj46wiu
	 0v4bBxBJkP7uQ==
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
Subject: [RFC PATCH net-next 1/4] ipv4: make inet_addr_lst hash table size configurable
Date: Tue, 31 Mar 2026 23:07:36 +0200
Message-ID: <20260331210739.3998753-2-hawk@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273753-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: 18E563716C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jesper Dangaard Brouer <hawk@kernel.org>

On servers with many IPv4 addresses, __ip_dev_find() becomes visible in
perf profiles on the unconnected UDP sendmsg path. The call chain is:

  udpv6_sendmsg / udp_sendmsg
    ip_route_output_flow
      ip_route_output_key_hash_rcu
        __ip_dev_find              <-- source address validation

__ip_dev_find() calls inet_lookup_ifaddr_rcu() which walks a hash chain
in inet_addr_lst. With the current fixed table size of 256 buckets, a
host with ~700 IPv4 addresses averages ~2.8 entries per chain, adding
unnecessary cache misses under RCU on every unconnected send.

Add CONFIG_INET_ADDR_HASH_BUCKETS (default 256, range 64-16384, EXPERT)
so hosts with many addresses can size the table appropriately. The value
is rounded up to the nearest power of 2 at compile time via
order_base_2(). Memory cost is one hlist_head pointer per bucket per net
namespace.

Reported-by: Ivan Babrou <ivan@cloudflare.com>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 net/ipv4/Kconfig   | 16 ++++++++++++++++
 net/ipv4/devinet.c |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index df922f9f5289..3c5e5e74b3e4 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -402,6 +402,22 @@ config INET_IPCOMP
 
 	  If unsure, say Y.
 
+config INET_ADDR_HASH_BUCKETS
+	int "IPv4 address hash table size" if EXPERT
+	range 64 16384
+	default 256
+	help
+	  Number of hash buckets for looking up local IPv4 addresses,
+	  e.g. during route output to validate the source address via
+	  __ip_dev_find().  Rounded up to the nearest power of 2.
+
+	  Hosts with many IPv4 addresses benefit from a larger table to reduce
+	  hash chain lengths. This is particularly relevant when sending using
+	  unconnected UDP sockets.
+
+	  The default of 256 is fine for most systems.  A value of 1024
+	  suits hosts with ~500+ addresses.
+
 config INET_TABLE_PERTURB_ORDER
 	int "INET: Source port perturbation table size (as power of 2)" if EXPERT
 	default 16
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 58fe7cb69545..9e3da06fb618 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -108,7 +108,7 @@ static const struct nla_policy ifa_ipv4_policy[IFA_MAX+1] = {
 	[IFA_PROTO]		= { .type = NLA_U8 },
 };
 
-#define IN4_ADDR_HSIZE_SHIFT	8
+#define IN4_ADDR_HSIZE_SHIFT	order_base_2(CONFIG_INET_ADDR_HASH_BUCKETS)
 #define IN4_ADDR_HSIZE		(1U << IN4_ADDR_HSIZE_SHIFT)
 
 static u32 inet_addr_hash(const struct net *net, __be32 addr)
-- 
2.43.0


