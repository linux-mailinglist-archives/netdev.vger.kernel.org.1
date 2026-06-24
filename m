Return-Path: <netdev+bounces-301759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 21sJLx0lPGoDkggAu9opvQ
	(envelope-from <netdev+bounces-301759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 20:42:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A70646C0C76
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 20:42:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=carlosgrillet.me header.s=zmail header.b=P8PdAzW1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301759-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301759-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 321E73021BE3
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448C933B6F8;
	Wed, 24 Jun 2026 18:42:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F6533469C
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 18:42:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782326522; cv=pass; b=TmwEfqbSnc8Zg7lNtGR/cLNpGfZLcxbpik0rxGN6WNLUq0VxLJW3G7xy+cCwsPA1BZxOX9VEwEEOMh3M2aNDrN/M1se1CtaKV23d3t7XknzTALNh3MFkv5LEo/UFLwkRihsMrRumtf/tGhhEiIPJ6z8JkFm+TBYZ0mXwCbQS1ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782326522; c=relaxed/simple;
	bh=Q8zxDNi/EjehTzh/2KoenWXg+wvxtwcqfPf024Tarcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLZXu/xfrGQcn7CJ1ycoyzylOopsCmGpUdWCQTEkfLzZsHSV/yJvDXTCW408Sb4TxHB2kXdTrusxtUnQxyWmUkDtUbAUp57iavDX0DxIynSFPRVpkT+DNopbkWhmcqQyBs8M/PSZioPW8vuTONpNqTehm540D2BELJ2iHGkbBUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carlosgrillet.me; spf=pass smtp.mailfrom=carlosgrillet.me; dkim=pass (1024-bit key) header.d=carlosgrillet.me header.i=carlos@carlosgrillet.me header.b=P8PdAzW1; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal: i=1; a=rsa-sha256; t=1782326469; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=NGXXageK7JPC8YvZ+QYFKneQ4iatNsfLoQq79WsVsLgS8S4bUuqSNtcW4pjF0L8RsTPVu5ihnQKZJfGgZzh5SS6u/1I9P8R1sGCWyCGkFh/2WACvMfdKfvGlQU1ujaJwSZctzxzCb3xAk3gs3oOJaBXHhchBnlurtilbJXPxQGU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1782326469; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tjsqCk8XummZfBV9VHYmhW07fJViEagjkxcJggc8Kn8=; 
	b=W1LlBH6Qvox4CVoeMM2ZofxQVm6RVuPRIsp3axsDv3aqvemdPf8ha0yBawEgjIOdfAcLQSb3Q8ukM4Weta57g5FSoFZjRPC4yXiZoFhyHAJHbR5zQ3xjH5nXjI/2zeO9oARF8H1U2cBZVEDMntcUU2FDoBVAQ/zM1wArQv+miSg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=carlosgrillet.me;
	spf=pass  smtp.mailfrom=carlos@carlosgrillet.me;
	dmarc=pass header.from=<carlos@carlosgrillet.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782326469;
	s=zmail; d=carlosgrillet.me; i=carlos@carlosgrillet.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=tjsqCk8XummZfBV9VHYmhW07fJViEagjkxcJggc8Kn8=;
	b=P8PdAzW1Wxt0TPpPbvQTrWuGUG0xCk3pHH0VWIlRLhwJbBgCsAduL+uC+IG/sC99
	zsFYwNjUbFp5Rs7dKEAoz6fmYFq5Pmn3osSRXEcWUZ1J9tj5TypYf3cXIpFQ3CwLFTO
	o1386xuph4MkbZdmQEsHUHquaZvhFzwT7IcF5PgY=
Received: by mx.zoho.eu with SMTPS id 1782326467724706.8461402572215;
	Wed, 24 Jun 2026 20:41:07 +0200 (CEST)
From: Carlos Grillet <carlos@carlosgrillet.me>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH nf-next 2/4] netfilter: nf_conntrack_h323_main: replace u_int8_t with u8
Date: Wed, 24 Jun 2026 20:40:32 +0200
Message-ID: <20260624184036.71051-3-carlos@carlosgrillet.me>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624184036.71051-1-carlos@carlosgrillet.me>
References: <20260624184036.71051-1-carlos@carlosgrillet.me>
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
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[carlosgrillet.me];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[carlos@carlosgrillet.me,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301759-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: A70646C0C76

Use preferred kernel integer type u8 instead of the POSIX u_int8_t
variant.

No functional change.

Signed-off-by: Carlos Grillet <carlos@carlosgrillet.me>
---
 net/netfilter/nf_conntrack_h323_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_h323_main.c b/net/netfilter/nf_conntrack_h323_main.c
index 7f189dceb3c4..68ecaf0daf95 100644
--- a/net/netfilter/nf_conntrack_h323_main.c
+++ b/net/netfilter/nf_conntrack_h323_main.c
@@ -671,7 +671,7 @@ static int expect_h245(struct sk_buff *skb, struct nf_conn *ct,
 static int callforward_do_filter(struct net *net,
 				 const union nf_inet_addr *src,
 				 const union nf_inet_addr *dst,
-				 u_int8_t family)
+				 u8 family)
 {
 	int ret = 0;
 
-- 
2.54.0


