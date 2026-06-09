Return-Path: <netdev+bounces-297231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HzmNAEVcKGreCgMAu9opvQ
	(envelope-from <netdev+bounces-297231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:32:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8378F663574
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:32:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kn8GhElk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297231-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297231-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C63343010BE0
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 18:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D34D370AC7;
	Tue,  9 Jun 2026 18:32:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A823EB10C
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 18:32:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029947; cv=none; b=SDdq7HBaprlv8UorFvadC+PynO9Gv+4+/JeLNKhBKd3YQwXdonHzzUS2bEA5m1oIGBvriw7MJ7dytBgXQwy9vlCPxwew0o6dmw0lzi31Jkckm8qE71+9AXhcPl0ZyXgUouQ4ddxsJJCeFJ0ECgfYd55BgXnVdfbsx2X2k7f+56Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029947; c=relaxed/simple;
	bh=ppqrKWeX2SUhDIVfIuk0Sy26k22lrmVkJp3JuMkyzqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQJBEJWV+fDVDJJlrDOCnRoxiWhumjlTrDXbTGdCjsU9l/nWh07irWLS2G0LjoKkKKx4IvET71XFAo3JlgcmK1ODSnhjWR8px9apzLK5zEAH0lFfaj1Y2WXFlmRJq3e5mS2kYZ3bMfBYU61PitbSiVw/4eh6KjnAZBE/eXPnw9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kn8GhElk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D681F00898;
	Tue,  9 Jun 2026 18:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781029946;
	bh=mCb3slxG7UoQ8SpNQv63Rr3cO0P7ZJI1gM7mOvLXJAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kn8GhElkz/Ptq3b1DZ5OJn94VRxPQApGMLlIkySjroo4a7z1Oz0UfqDZ42wmzXS3y
	 Nqk+3YWZjDxOg2OO1qcVbvs7Yr1OuGsbjSiwCe/5cQxTV936JWCEN/zk23oeU2JVa7
	 361fJqNeZktbm2LEURK4K77Dg92yp4o7ZDJFGgJ0DaPrV7NiIh9rOmPX/v9wO2jNBT
	 88SZsjfEIcPYhr0BPH85aiM8eu3ULlhf2STd+5XfGKAWrHgd8OsjpAgQ3Vsu+w1coq
	 uAJlFxKw9T13uB+yBHj1GVD1ZtU47niMrnQDdOEtX4Nk65WZJq2o/d4xjrP1cj4YwS
	 ITuQN8A9mge2g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/4] net: shaper: drop redundant xa_lock() bracketing
Date: Tue,  9 Jun 2026 11:32:21 -0700
Message-ID: <20260609183224.1108521-2-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297231-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8378F663574

The shaper insertion and update code takes xa_lock() explicitly.
Paolo explained that the locking was purely to avoid re-taking
the lock in loops. But it may be mis-read as if it was expecting
readers to be fenced off by xa_lock. Readers of XArray are purely
under RCU. Remove explicit taking of xa_lock().

All writers to hierarchy->shapers are serialized by the netdev
instance lock (or run after netdev is made inaccessible to readers).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/shaper/shaper.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index dea9270f3e57..a5b42b697a93 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -429,7 +429,6 @@ static void net_shaper_commit(struct net_shaper_binding *binding,
 	int index;
 	int i;
 
-	xa_lock(&hierarchy->shapers);
 	for (i = 0; i < nr_shapers; ++i) {
 		index = net_shaper_handle_to_index(&shapers[i].handle);
 
@@ -442,7 +441,6 @@ static void net_shaper_commit(struct net_shaper_binding *binding,
 		/* ... publish to lockless readers. */
 		smp_store_release(&cur->valid, true);
 	}
-	xa_unlock(&hierarchy->shapers);
 }
 
 /* Rollback all the tentative inserts from the hierarchy. */
@@ -455,14 +453,12 @@ static void net_shaper_rollback(struct net_shaper_binding *binding)
 	if (!hierarchy)
 		return;
 
-	xa_lock(&hierarchy->shapers);
 	xa_for_each(&hierarchy->shapers, index, cur) {
 		if (cur->valid)
 			continue;
-		__xa_erase(&hierarchy->shapers, index);
+		xa_erase(&hierarchy->shapers, index);
 		kfree_rcu(cur, rcu);
 	}
-	xa_unlock(&hierarchy->shapers);
 }
 
 static int net_shaper_parse_handle(const struct nlattr *attr,
@@ -1472,12 +1468,10 @@ static void net_shaper_flush(struct net_shaper_binding *binding)
 	if (!hierarchy)
 		return;
 
-	xa_lock(&hierarchy->shapers);
 	xa_for_each(&hierarchy->shapers, index, cur) {
-		__xa_erase(&hierarchy->shapers, index);
+		xa_erase(&hierarchy->shapers, index);
 		kfree(cur);
 	}
-	xa_unlock(&hierarchy->shapers);
 
 	kfree(hierarchy);
 }
-- 
2.54.0


