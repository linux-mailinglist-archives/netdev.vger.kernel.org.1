Return-Path: <netdev+bounces-302328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NNQuL1GjP2ofVgkAu9opvQ
	(envelope-from <netdev+bounces-302328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 12:17:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C706D1BC4
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 12:17:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=Y9kQqJWg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302328-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302328-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F24E300CB05
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 10:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5A33A641F;
	Sat, 27 Jun 2026 10:17:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFEE3A544C;
	Sat, 27 Jun 2026 10:17:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782555471; cv=none; b=N+9OlQrzGseiau4yDol/E7y54BNve+FoIRr2DGOMbmg8LJG/NYpeHs+mrVz1jb6Vh71+XIoUT1P+bpXK65+Ey7OTj++vhoSbB6FA5YSMdZqPpj1AdIsYk7K1mkONVQCu2Z1vgbiCdU/pmjPBngjXSOld2iroG/h+vXUD23Qted4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782555471; c=relaxed/simple;
	bh=eMDVfHEmWPsHdSPZRkjes4kf5KjgXTROVanzOwvBuQw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NMsLeJW5ZU34/Iy/Z7sjcP55idxv6nSVRmoeyz0LT6xI6wRWZKH39NibruPR2t+3LK2Z3RoIRQAZEqGFiqUUa50cSZDS8Thc7ZEwLQeb6U7xUjMUUARCX7u6i52U3OkeHqnLl6clmnS9BK9GB9JPQ3fgkEbpsmcJOJeoVcwmx34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Y9kQqJWg; arc=none smtp.client-ip=45.254.49.198
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 43fe79121;
	Sat, 27 Jun 2026 18:12:33 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	leitao@debian.org,
	sashal@kernel.org,
	bigeasy@linutronix.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn
Subject: [RFC PATCH net-next] netpoll: hold RCU while walking napi_list
Date: Sat, 27 Jun 2026 18:12:28 +0800
Message-Id: <20260627101228.1191586-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f0891139303a1kunm83ec8a9eca6f0
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTkwfVkwYGElPT0pNGE1CTlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Y9kQqJWghBOamBAZM/j/dCUAJyMyC7okvWBTDs0qz4NKfVb9nA6bYh4Gkp38fg1/5eEfggYmngE4EVC/0NjHdF5oR8OTrZW/awX1+fGry//ReNyc3rkVtfGIHtKaLLkc3+/FIl0X41zk7c8LcvEovaiY4BP6Hw9nVD5D/x8QRyQ=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=MgOidj7nN/ur4ptkB6qoK6lGw8f6hMFm5hFk0+CnxW0=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302328-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:leitao@debian.org,m:sashal@kernel.org,m:bigeasy@linutronix.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:runyu.xiao@seu.edu.cn,m:jianhao.xu@seu.edu.cn,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,seu.edu.cn:dkim,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 53C706D1BC4

poll_napi() walks dev->napi_list with list_for_each_entry_rcu(). Some
netpoll send paths are already inside an RCU read-side section, but the
helper itself does not document or enforce that contract.

CONFIG_PROVE_RCU_LIST reports the poll_napi() traversal when the helper
is exercised directly from netpoll_poll_dev(). The current source has
important lifetime defenses around NAPI deletion and netpoll device
close, so this is not presented as a proven use-after-free. The issue is
that the RCU-list reader contract is implicit at the helper boundary.

Take rcu_read_lock() locally while walking the NAPI list. This keeps the
contract with netif_napi_del() and synchronize_net() explicit and avoids
relying on every current or future caller to provide the read-side
section.

This was found by our static analysis tool and then manually reviewed
against the current tree. CONFIG_PROVE_RCU_LIST was used as
target-matched triage evidence; the RFC is limited to making the
helper's RCU-list reader contract explicit.

This is an RFC because maintainers may prefer to express the existing
netpoll dev_lock/NAPI-list lifetime contract instead of adding a local
RCU reader around the polling loop.

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 net/core/netpoll.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 5af14f14a362..2e13ca0d09fe 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -165,12 +165,14 @@ static void poll_napi(struct net_device *dev)
 	struct napi_struct *napi;
 	int cpu = smp_processor_id();
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(napi, &dev->napi_list, dev_list) {
 		if (cmpxchg(&napi->poll_owner, -1, cpu) == -1) {
 			poll_one_napi(napi);
 			smp_store_release(&napi->poll_owner, -1);
 		}
 	}
+	rcu_read_unlock();
 }
 
 void netpoll_poll_dev(struct net_device *dev)
-- 
2.34.1


