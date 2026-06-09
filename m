Return-Path: <netdev+bounces-297232-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q5JwGEtcKGrfCgMAu9opvQ
	(envelope-from <netdev+bounces-297232-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:32:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F22DC66357A
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:32:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VUw+Gcfm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297232-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297232-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE4393015870
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 18:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C634C6F14;
	Tue,  9 Jun 2026 18:32:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5313EB114
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 18:32:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029948; cv=none; b=afI8ydW3ZM+2nrMZRXQPzqrtYwvMW7GnucAFRO2HlfHstKDufLKG0lguYejPA2HLKGUqEFGgUXlu6/1wU9qGjJNcnufMma0khU3ofadIP/E0WPXVcm/0MB3oTRvuZj1UOlXEpSii6Ibei4y6CqgTTXcUdK7ksn41P/G+Lsj+wys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029948; c=relaxed/simple;
	bh=/qu2BSr+iBthGCMoYTyJdgMJ748+2ydtUQXTpunJU08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRTBABOxDPWoVhDxnM6zV150V++yyycjLQmie0iH3Yf0cOKS4bNk5O8hPeEWiXqgS2Dm2teFHVXkriOMqw6L0t+c6unWPq6R6gZphviuQktofRWvnFAheBx8dmayE/isTO/9RxgbcYZXWoojuWO/1ZhgYtf9GUugTq+J0nYeDig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUw+Gcfm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F741F0089A;
	Tue,  9 Jun 2026 18:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781029946;
	bh=nUUvvKklIjZzg63JaFgSbx5oWv0Zv057Z+XikoE1ZxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VUw+GcfmHIdtCkO0db7pCqwGdEthJqZ0psogxuQcoei0ZMIerQ1r5xPjmQVw2EhyW
	 ITTqYOeFONOXtjSI7wamSg9oVDdznKDknq2MjvMmZ7W+NLAYeR8szd5308FDUlWT0/
	 WNYeh0lVzO4FDWsaYbbgEf/9zdAyy/1PMSkWcx/gYi6MRzq4zQ/acIII9AsEIuaJUn
	 NOHqpt8PEAvZeaBj6StwhjMvIw1R9gxADVlmrimSqDT12fSvfODDVgEI5W0WhyyHZT
	 R8K15B7pNIGEG2AF2pT/69Qd4Dlyzh+6TNm01QNBM+VFg170qhmeWtO3HtXvRVMfrO
	 EsLxh71s8J6Jg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/4] net: shaper: drop unnecessary kfree_rcu in pre_insert
Date: Tue,  9 Jun 2026 11:32:22 -0700
Message-ID: <20260609183224.1108521-3-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609183224.1108521-1-kuba@kernel.org>
References: <20260609183224.1108521-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297232-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuba@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F22DC66357A

If we fail to insert a node into the XArray in net_shaper_pre_insert()
we can free it directly - it was never visible to the RCU readers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/shaper/shaper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index a5b42b697a93..33958462e5e9 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -406,7 +406,7 @@ static int net_shaper_pre_insert(struct net_shaper_binding *binding,
 	prev = xa_store(&hierarchy->shapers, index, cur, GFP_KERNEL);
 	if (xa_err(prev)) {
 		NL_SET_ERR_MSG(extack, "Can't insert shaper into device store");
-		kfree_rcu(cur, rcu);
+		kfree(cur);
 		ret = xa_err(prev);
 		goto free_id;
 	}
-- 
2.54.0


