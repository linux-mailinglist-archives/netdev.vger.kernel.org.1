Return-Path: <netdev+bounces-251596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAhGNOjbb2n8RwAAu9opvQ
	(envelope-from <netdev+bounces-251596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:47:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E8C4AB4A
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A78CAAA80D3
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535F9478E2A;
	Tue, 20 Jan 2026 19:18:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFB43EF0D6;
	Tue, 20 Jan 2026 19:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768936708; cv=none; b=RqYdx1sqbOA3yK3MhlgSRDN4JcPdk0mINAhqokrSOsNATHCeuGRY2JfsyCBiy46yFQPEkrqrUbqaXUOTiAcmPyVfJtWkjiwCMGaN75uIpoYmVQlVE1ZeIYaOFUquhjuY02YCdn784Q+9DG6kCiWZBgqKmLhuoay5JsqSS8JN+x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768936708; c=relaxed/simple;
	bh=H3tmlovnjM+llIHdacwn3VOg7pXgsDocfYYuFBYsJNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSjaF1lhpHOEaRRBrYi9Figxli5spImCyxvoYBix5cM1UnECh6SHtueqyVKLPwrWaxvjxJX+cbaMgLa2i3pDseuoninuWKnK138e130NBFhCvkkq3VSvm3itrGvL7oBz2fLL4FpQvSJYfq4xpotX4YRT1zul60k7l6ZOFh40M2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 99A15602AB; Tue, 20 Jan 2026 20:18:24 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 04/10] netfilter: nf_conntrack: enable icmp clash support
Date: Tue, 20 Jan 2026 20:17:57 +0100
Message-ID: <20260120191803.22208-5-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120191803.22208-1-fw@strlen.de>
References: <20260120191803.22208-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.24 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-251596-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,strlen.de:email,strlen.de:mid]
X-Rspamd-Queue-Id: 61E8C4AB4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Not strictly required, but should not be harmful either:
This isn't a stateful protocol, hence clash resolution should work fine.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_conntrack_proto_icmp.c   | 1 +
 net/netfilter/nf_conntrack_proto_icmpv6.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/netfilter/nf_conntrack_proto_icmp.c b/net/netfilter/nf_conntrack_proto_icmp.c
index b38b7164acd5..32148a3a8509 100644
--- a/net/netfilter/nf_conntrack_proto_icmp.c
+++ b/net/netfilter/nf_conntrack_proto_icmp.c
@@ -365,6 +365,7 @@ void nf_conntrack_icmp_init_net(struct net *net)
 const struct nf_conntrack_l4proto nf_conntrack_l4proto_icmp =
 {
 	.l4proto		= IPPROTO_ICMP,
+	.allow_clash		= true,
 #if IS_ENABLED(CONFIG_NF_CT_NETLINK)
 	.tuple_to_nlattr	= icmp_tuple_to_nlattr,
 	.nlattr_tuple_size	= icmp_nlattr_tuple_size,
diff --git a/net/netfilter/nf_conntrack_proto_icmpv6.c b/net/netfilter/nf_conntrack_proto_icmpv6.c
index 327b8059025d..e508b3aa370a 100644
--- a/net/netfilter/nf_conntrack_proto_icmpv6.c
+++ b/net/netfilter/nf_conntrack_proto_icmpv6.c
@@ -343,6 +343,7 @@ void nf_conntrack_icmpv6_init_net(struct net *net)
 const struct nf_conntrack_l4proto nf_conntrack_l4proto_icmpv6 =
 {
 	.l4proto		= IPPROTO_ICMPV6,
+	.allow_clash		= true,
 #if IS_ENABLED(CONFIG_NF_CT_NETLINK)
 	.tuple_to_nlattr	= icmpv6_tuple_to_nlattr,
 	.nlattr_tuple_size	= icmpv6_nlattr_tuple_size,
-- 
2.52.0


