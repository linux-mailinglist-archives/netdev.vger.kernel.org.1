Return-Path: <netdev+bounces-298642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +MbsGoX/K2obJQQAu9opvQ
	(envelope-from <netdev+bounces-298642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:45:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCB367974A
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:45:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=carlosgrillet.me header.s=zmail header.b=Mv2lNupw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298642-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298642-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42DEF301E475
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F473E2768;
	Fri, 12 Jun 2026 12:42:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455A33E6386
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 12:42:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781268167; cv=pass; b=BFVl5r9JVc9qkfehMkhTOTZ8eEEFJ4cOEHRd1czSNXdGLqY2gsaL6/A93c0VjCKIQmVXZfldQastTU/L50vr39a/IgWEaevvBV8mCvR5TfwkaJDjKZznCVT35hhmCqJncI8K8IOYr2YFYJ/WGslYdrHv9BQqVbyllDyouHqhbQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781268167; c=relaxed/simple;
	bh=ngt+z5NZNP2bLxE1iGJFOZGpI8x5OafjofmlhPbgNfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tg7o44605uinjvGiz+8Misk7IaXMHU0wnGsqXYPVKI7cyzSpsDrnWhbFVzYz7jRW7sore6tn1doB5wMtFPUs/SgDvG1uZ8lOjm2iPHgHrNJy0zstmbSZy6jqJulthXaV/GsG+LDRh4s6s3tvXxIFq0aa+ci4eo8rMazZGoKYUa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carlosgrillet.me; spf=pass smtp.mailfrom=carlosgrillet.me; dkim=pass (1024-bit key) header.d=carlosgrillet.me header.i=carlos@carlosgrillet.me header.b=Mv2lNupw; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal: i=1; a=rsa-sha256; t=1781268137; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Ih6aNhdo2cEG8E3Cfgp1c+Q82WzXFmvVbMCDcPS5CFeUvlZvZ0GweLcpzkI1GfPmkUGue7QZTYAFYlXve/0Ivx7Fs8bv23Usf4zwwKRUC37/bGlJ6E1WoKmmQiqLlh91RKBfQrjcG6DoEKmNeCWksnhmgifkEPp5J3wf3UPNb7A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1781268137; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JPDMg/1vcqRmkkaVbSyViyubTh4oMaFo0jk8Xx+5uoQ=; 
	b=DW6Gl6LfNUG3EceJovnKVLV3IZAp0dxMG3veXBBpwBy79M3qc3+rgMxX8eF81cPTCc0Pbsy4fdiX6kSNEQPLuaDZHGY1QC6hr4Dektn631b1ry2dpJxUXm1uKunuwPyeinpAuKEPX0cZ+VxmOFbL0UqRbiS+FSgvDUqbV+gx2SQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=carlosgrillet.me;
	spf=pass  smtp.mailfrom=carlos@carlosgrillet.me;
	dmarc=pass header.from=<carlos@carlosgrillet.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781268137;
	s=zmail; d=carlosgrillet.me; i=carlos@carlosgrillet.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=JPDMg/1vcqRmkkaVbSyViyubTh4oMaFo0jk8Xx+5uoQ=;
	b=Mv2lNupwxMNtIpYPlujRU2pN5U1Nxv39ibnhv0R+2y/Yp6jX0dJ2B2GeFBeGlSE/
	ZDzAk5gXcZ/ITGofudER7KwbZ2IY+RE8/ORiU+0ktWF752S6ClT4ygsPRzj01FX9Ekn
	N2yXBd/nsw3/CN6ClFji2aFREkIFwk4DJlRVEk6Q=
Received: by mx.zoho.eu with SMTPS id 1781268135355851.5949726788033;
	Fri, 12 Jun 2026 14:42:15 +0200 (CEST)
From: Carlos Grillet <carlos@carlosgrillet.me>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org (open list:NETFILTER),
	coreteam@netfilter.org (open list:NETFILTER),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Cc: Carlos Grillet <carlos@carlosgrillet.me>
Subject: [PATCH nf-next 5/6] netfilter: xt_TCPOPTSTRIP: replace u_int8_t and u_int16_t with u8 and u16
Date: Fri, 12 Jun 2026 14:40:25 +0200
Message-ID: <20260612124027.71673-6-carlos@carlosgrillet.me>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[carlosgrillet.me:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:carlos@carlosgrillet.me,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[carlosgrillet.me];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[carlos@carlosgrillet.me,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298642-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos@carlosgrillet.me,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[carlosgrillet.me:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,carlosgrillet.me:dkim,carlosgrillet.me:email,carlosgrillet.me:mid,carlosgrillet.me:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DCB367974A

Replace POSIX u_int8_t/u_int16_t with preferred kernel types u8/u16

No functional changes.

Signed-off-by: Carlos Grillet <carlos@carlosgrillet.me>
---
 net/netfilter/xt_TCPOPTSTRIP.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/xt_TCPOPTSTRIP.c b/net/netfilter/xt_TCPOPTSTRIP.c
index 93f064306901..265d21697847 100644
--- a/net/netfilter/xt_TCPOPTSTRIP.c
+++ b/net/netfilter/xt_TCPOPTSTRIP.c
@@ -16,7 +16,7 @@
 #include <linux/netfilter/x_tables.h>
 #include <linux/netfilter/xt_TCPOPTSTRIP.h>
 
-static inline unsigned int optlen(const u_int8_t *opt, unsigned int offset)
+static inline unsigned int optlen(const u8 *opt, unsigned int offset)
 {
 	/* Beware zero-length options: make finite progress */
 	if (opt[offset] <= TCPOPT_NOP || opt[offset+1] == 0)
@@ -33,8 +33,8 @@ tcpoptstrip_mangle_packet(struct sk_buff *skb,
 	const struct xt_tcpoptstrip_target_info *info = par->targinfo;
 	struct tcphdr *tcph, _th;
 	unsigned int optl, i, j;
-	u_int16_t n, o;
-	u_int8_t *opt;
+	u16 n, o;
+	u8 *opt;
 	int tcp_hdrlen;
 
 	/* This is a fragment, no TCP header is available */
@@ -97,7 +97,7 @@ tcpoptstrip_tg6(struct sk_buff *skb, const struct xt_action_param *par)
 {
 	struct ipv6hdr *ipv6h = ipv6_hdr(skb);
 	int tcphoff;
-	u_int8_t nexthdr;
+	u8 nexthdr;
 	__be16 frag_off;
 
 	nexthdr = ipv6h->nexthdr;
-- 
2.54.0


