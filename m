Return-Path: <netdev+bounces-300703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c+cMNLkuNWqCoAYAu9opvQ
	(envelope-from <netdev+bounces-300703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 13:57:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C742A6A58CB
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 13:57:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=CM8BZWsU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300703-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300703-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD2C630228AB
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F2E385D61;
	Fri, 19 Jun 2026 11:55:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22AD3859CF;
	Fri, 19 Jun 2026 11:55:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781870116; cv=none; b=Uz6a0tg3glTtMeS0VmRKP5G0OZHqkq5LhKVIyS5I1AMvPT3skIpMoKHn7mY+XkBL9Q5FXyW/9wpeHTXMbRw0MgnDLE0clSuynxx+ipef32UWamCQQ6oABOEo7WGhOaIuG1oZK+/7N3zhNkj6bUTGPtD4tPf+s9wdKUVg5Qu4vV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781870116; c=relaxed/simple;
	bh=RsDaxyPuvOrBmPdJ6FVONCDxwowu3uBw/KYyrv/aet4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWmcYtURTfJ8hBLlli7UP401l3I1uB7oL2yn/GwMYPZYPPBluPyjG8fBXeRRaIHkHnyrIE7zEURBnehbEnV7BKWHl7CC07mLOAqKjjaPy4QmmDokI8tvjVkDpT5tlUF5ANg2fh4NWEa7QncRSFEJaBoveXrw5N/bzwC3osKPhrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=CM8BZWsU; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id C1079601A8;
	Fri, 19 Jun 2026 13:55:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1781870113;
	bh=UBi8nAYVNxDOC9Fca/g+kEvutyyeLg3iui/uJTcXf3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CM8BZWsUn6m+pH7GMpebrF+Kp7nqeX3HNlkCmpJqgHK2Ja2xFpW+nIhsnYYTCb8vD
	 j74/Z6B9m2j3tRDsrvcbSuTxZTOfEhymEkYOXPI5fCbbswbZ5CL/BBv2wGOWPSycpU
	 tUt13GyENEtNDSosD1Edvbv9lFtxyGZv5XR6Gn6a57yRf0H3mDaW7zbsBBF/a/+8sA
	 xzCmcRSsEU7CoDiQ2fA6h1opgtvg8eDB+K+49IK9l8uHd8dSUp7cLyNekLjZ5tCvGg
	 cpVel7Vo6bMvTdpEJqQ0ersKCrLX8YDJBPvPis5+enqshk7lIUq/DYstxoQEPpY+z7
	 PigAqSG1zbl9A==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net 12/16] netfilter: nft_flow_offload: zero device address for non-ether case
Date: Fri, 19 Jun 2026 13:54:47 +0200
Message-ID: <20260619115452.93949-13-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619115452.93949-1-pablo@netfilter.org>
References: <20260619115452.93949-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-300703-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:dkim,netfilter.org:email,netfilter.org:mid,netfilter.org:from_mime,strlen.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,nbd.name:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C742A6A58CB

From: Florian Westphal <fw@strlen.de>

LLM points out that the skip causes unitialised stack array to
propagate down into dev_fill_forward_path().  Its not clear to me that
there is a guarantee that a later ctx.dev->netdev_ops->ndo_fill_forward_path()
would always fix this up.

Cc: Felix Fietkau <nbd@nbd.name>
Fixes: 45ca3e61999e ("netfilter: nft_flow_offload: skip dst neigh lookup for ppp devices")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_flow_table_path.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index 1e7e216b9f89..98c03b487f52 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -53,8 +53,10 @@ static int nft_dev_fill_forward_path(const struct nf_flow_route *route,
 	struct neighbour *n;
 	u8 nud_state;
 
-	if (!nft_is_valid_ether_device(dev))
+	if (!nft_is_valid_ether_device(dev)) {
+		eth_zero_addr(ha);
 		goto out;
+	}
 
 	n = dst_neigh_lookup(dst_cache, daddr);
 	if (!n)
-- 
2.47.3


