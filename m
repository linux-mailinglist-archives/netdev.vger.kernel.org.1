Return-Path: <netdev+bounces-263781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAThMFscqGmYoAAAu9opvQ
	(envelope-from <netdev+bounces-263781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 12:49:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6797F1FF46F
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 12:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 595D3301A7A9
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 11:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4CE3A8733;
	Wed,  4 Mar 2026 11:49:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157153A0E98;
	Wed,  4 Mar 2026 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624979; cv=none; b=hblPEbkJ+zgma4+3e6vdTGo9vIwRLCtnbBo9qDs6G7g+R6Il6RhzQaIHSpuPqJ1xcTnTVhzxJLXXvTw/myvHolQCNyJ4/XpCx4lOTBWuJwB/PuudAkF8HYmxVUyYWnuW9YizbRnYH6oCOHSXEjUFu0DkFMM4LchhvkE5MTr9cZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624979; c=relaxed/simple;
	bh=bkAPlfxtnZWDn9ZtMK68CXG0xVXHkPrjL43HSBcU664=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIuEKefedCfNgc3KsOuBy7CVoB17gy/1S1+M7j0KO9AUeEMrlx6LcxstHCx6pqL/I78rwxMCeGGomtdH3Au5ojWF2CjAuMufd9lZmUUyX8Nr8NTKyMmXhTVZujx75zMHz0hJaUfAZSG21uQm5za4IeMYT4BvkzS4Ga5/oprVFks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 61AFB60492; Wed, 04 Mar 2026 12:49:34 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 01/14] ipv6: export fib6_lookup for nft_fib_ipv6
Date: Wed,  4 Mar 2026 12:49:08 +0100
Message-ID: <20260304114921.31042-2-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260304114921.31042-1-fw@strlen.de>
References: <20260304114921.31042-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6797F1FF46F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263781-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Upcoming patch will call fib6_lookup from nft_fib_ipv6.  The EXPORT_SYMBOL is
added twice because there are two implementations of the function, one
is a small stub for MULTIPLE_TABLES=n, only one is compiled into the
kernel depending on .config settings.

Alternative to EXPORT_SYMBOL is to use an indirect call via the
ipv6_stub->fib6_lookup() indirection, but thats more expensive than the
direct call.

Also, nft_fib_ipv6 cannot be builtin if ipv6 is a module.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/ipv6/fib6_rules.c | 3 +++
 net/ipv6/ip6_fib.c    | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index fd5f7112a51f..e1b2b4fa6e18 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -92,6 +92,9 @@ int fib6_lookup(struct net *net, int oif, struct flowi6 *fl6,
 
 	return err;
 }
+#if IS_MODULE(CONFIG_NFT_FIB_IPV6)
+EXPORT_SYMBOL_GPL(fib6_lookup);
+#endif
 
 struct dst_entry *fib6_rule_lookup(struct net *net, struct flowi6 *fl6,
 				   const struct sk_buff *skb,
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 9058e71241dc..a6e58a435735 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -342,6 +342,9 @@ int fib6_lookup(struct net *net, int oif, struct flowi6 *fl6,
 	return fib6_table_lookup(net, net->ipv6.fib6_main_tbl, oif, fl6,
 				 res, flags);
 }
+#if IS_MODULE(CONFIG_NFT_FIB_IPV6)
+EXPORT_SYMBOL_GPL(fib6_lookup);
+#endif
 
 static void __net_init fib6_tables_init(struct net *net)
 {
-- 
2.52.0


