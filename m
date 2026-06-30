Return-Path: <netdev+bounces-303147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pkg0DJG2Q2qMfgoAu9opvQ
	(envelope-from <netdev+bounces-303147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:29:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E6B6E42C3
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:29:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=DWYr8mqN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303147-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303147-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8A293004621
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD7B403151;
	Tue, 30 Jun 2026 12:24:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02B73EF652;
	Tue, 30 Jun 2026 12:24:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822278; cv=none; b=UsN7gXLHAw3qN3jwPRrHx6xrMxqKcMO1M//XkON6WoUW22WwVppHEdn705kX5Ni7egOFxqiOBqW3Hy23iUCC/cP0SjQqXGEIPDgllH1ryxFubifmkxOsVaM8GxqUdOn2Z6Uvqhy+3oD8yozUKFXWNFI4WD0V3p6nTKYyFYBMkq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822278; c=relaxed/simple;
	bh=O6+X9QTUzXhwCOUIBraPDNwO+JprxI33iNH1ljFEotI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VBrvwRav6JrRVnIyCL9Q+f6uEX/yCETuPdbsORTBM52fKqDPf7wy6OpmEzjxagsyRGvRuPEE35oNMqm7Baw3SaqF/YYWhxblcIXWRCeW+nTc4rLhlTQlb0tK3KO3fIGojyjXu3b8Y4cA5H2UlxZUiSu/aoLmMRLfr5/JzVtvu04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DWYr8mqN; arc=none smtp.client-ip=117.135.210.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=YX
	Y6r1fk7y28Yf2otFgDxIkz3YePwaCXOV/6Sk9Zb8A=; b=DWYr8mqNzeRwf5CBS6
	4cPw2qaWIhGzbhGbUQ7ZzT1p9qEFLh0KjvH5dVAcIWOVVXTPkXB3izr9tS8hq5KQ
	zIS5AnKplYTBQipd4RFo8fWwg1NkDOVu7gv4DydOoUd2+gf+pfMekDWj3mgFSOhZ
	KuyjElQ4+e8CgCkdEE5dMWq44=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3V29UtUNqEXipGw--.149S2;
	Tue, 30 Jun 2026 20:23:48 +0800 (CST)
From: Lei Huang <huanglei814@163.com>
To: dsahern@kernel.org,
	idosch@nvidia.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lei Huang <huanglei@kylinos.cn>
Subject: [PATCH] net: ipv4: fix TOCTOU race in __ip_do_redirect
Date: Tue, 30 Jun 2026 20:23:33 +0800
Message-Id: <20260630122333.935406-1-huanglei814@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3V29UtUNqEXipGw--.149S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cry7XF4xWw47ArWDCr45ZFb_yoW8WryrpF
	WFk348Wr45WF1Uuws5A3W2yrySga18trZrCr4vkwsxtrn5JrnagF9xJryYvFyYvrWfur42
	qr1jvr4DAFWDGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UD739UUUUU=
X-CM-SenderInfo: xkxd0wxohlmiqu6rljoofrz/xtbC8xTt5GpDtVR97AAA33
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303147-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:huanglei@kylinos.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[huanglei814@163.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huanglei814@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71E6B6E42C3

From: Lei Huang <huanglei@kylinos.cn>

fib_lookup() internally acquires and releases rcu_read_lock and always uses
FIB_LOOKUP_NOREF (no refcount on fib_info). After it returns, res (a local
struct fib_result on the stack) has its nhc field pointing into the
fib_info internal nexthop array, but RCU protection is already dropped.
A concurrent route deletion can free the fib_info via kfree_rcu, making
res.nhc a stale pointer. Subsequent FIB_RES_NHC(res) reads this stale value
and update_or_create_fnhe() dereferences it, causing UAF.

Fix by wrap the entire fib_lookup + FIB_RES_NHC + update_or_create_fnhe
region in an explicit rcu_read_lock/unlock to keep the fib_info alive
throughout the critical section.

Signed-off-by: Lei Huang <huanglei@kylinos.cn>
---
 net/ipv4/route.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 3f3de5164d6e..86f4b6325050 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -793,6 +793,7 @@ static void __ip_do_redirect(struct rtable *rt, struct sk_buff *skb, struct flow
 		if (!(READ_ONCE(n->nud_state) & NUD_VALID)) {
 			neigh_event_send(n, NULL);
 		} else {
+			rcu_read_lock();
 			if (fib_lookup(net, fl4, &res, 0) == 0) {
 				struct fib_nh_common *nhc;
 
@@ -802,6 +803,7 @@ static void __ip_do_redirect(struct rtable *rt, struct sk_buff *skb, struct flow
 						0, false,
 						jiffies + ip_rt_gc_timeout);
 			}
+			rcu_read_unlock();
 			if (kill_route)
 				WRITE_ONCE(rt->dst.obsolete, DST_OBSOLETE_KILL);
 			call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, n);
-- 
2.25.1


