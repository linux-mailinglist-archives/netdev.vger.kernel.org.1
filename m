Return-Path: <netdev+bounces-292097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHbPH9eBFmr6mwcAu9opvQ
	(envelope-from <netdev+bounces-292097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:32:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F14C5DF76E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29EFD301487A
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 05:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D606D2C11F9;
	Wed, 27 May 2026 05:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M2kRKYrS"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB9B30C615
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 05:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779859911; cv=none; b=OCWd81HVYgypW7WeM2mdvpdaPp8p4K15nrEGvtyl/DuMgWwtTxoRL0g1UUPPjZx7h5L9MxIfWDWKhlZGJaVIJTaEMaO76gA1nziUALnxUB5WJCN+kGgKrIPnec8U5mP3nmbUgbeqFsIaUdAnxT384YhitEf5ajA1k+QYPQAuLqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779859911; c=relaxed/simple;
	bh=efcP7seEd8eYexEwqH3bu0W16GfYFarnjpUz8goC46I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gg//eMVPQi50saMhA5+jjLp2aHA+m2nsGUagpsiyehriw3CCXGCuJ4GJRnHxmavfP3nyaItrUkdzbtLMgOn6ms6OjzRnK3zKlCIMdcsdZ8mzFnr95LdtkG3VtKlDdhTjZyZJ+PO7zg9trkaXF+/Mptl4sbo2Bkgo1WfOs2zR/C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M2kRKYrS; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779859908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CubyQoG2dmy5XU3vaYjR4ZF+sYT6/l/kwwPcDhfdO9c=;
	b=M2kRKYrSC2OLnH0z8siUYxioufoIs0ibXHVFptvHGwYx8K9BkqnFhzQFn93/Ujjs6al4Mh
	wlAc0tze8fxjUT0puz8AwI286+KBa/6qvw/TyjhmP0pf1jcayIt8DC10gSC5Mop1rd/6YK
	bhZnEwdJIcCK3j6Br5VljeStTbP+bj4=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] ipv6: fix possible infinite loop in fib6_select_path()
Date: Wed, 27 May 2026 13:31:31 +0800
Message-ID: <20260527053133.180695-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260527053133.180695-1-jiayuan.chen@linux.dev>
References: <20260527053133.180695-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292097-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 6F14C5DF76E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Found while auditing the same pattern Sashiko reported in
rt6_fill_node() [1]. Apply the same fix as
commit f8d8ce1b515a ("ipv6: fix possible infinite loop in fib6_info_uses_dev()").

Writers holding tb6_lock can list_del_rcu(&first->fib6_siblings)
without waiting for RCU readers; first->fib6_siblings.next then
still points into the old ring and this softirq-side walker never
reaches &first->fib6_siblings as its terminator. fib6_purge_rt()
always WRITE_ONCE()s first->fib6_nsiblings to 0 before
list_del_rcu(), so an inside-loop check is a reliable detach signal.

[1] https://sashiko.dev/#/patchset/20260526020227.4857-1-jiayuan.chen%40linux.dev

Fixes: d9ccb18f83ea ("ipv6: Fix soft lockups in fib6_select_path under high next hop churn")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv6/route.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index dad416fdc585..636f0120d7e3 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -481,6 +481,9 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
 		const struct fib6_nh *nh = sibling->fib6_nh;
 		int nh_upper_bound;
 
+		if (!READ_ONCE(first->fib6_nsiblings))
+			break;
+
 		nh_upper_bound = atomic_read(&nh->fib_nh_upper_bound);
 		if (hash > nh_upper_bound)
 			continue;
-- 
2.43.0


