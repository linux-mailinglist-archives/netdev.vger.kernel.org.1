Return-Path: <netdev+bounces-292098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDjgEPiBFmr6mwcAu9opvQ
	(envelope-from <netdev+bounces-292098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:32:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE57C5DF776
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91395304C34A
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 05:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2E02D73A0;
	Wed, 27 May 2026 05:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RuCVUET9"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AC08F7D
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 05:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779859917; cv=none; b=SVD1DcNWM7GdOZyDpSvKhU83bzj4WTW/A21DQlMUcf/HZBUHqxxKkJRtFbFkgem3zWHc2EVA5EB0iDY8RCeK6NNGhrJAxXK8ZwWGcSCT76VJfI5OSCL19qHZ0MaDaG8H493O1fMOVFrrKJdpyMNwil//1F1CXM+OoSfs3gesnjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779859917; c=relaxed/simple;
	bh=rBP1B0zsdgZeSNqZnpoqHsJ2GoGSqehpngS+l3OSoys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U8TSZox21GbIag4qK4dmsrRqCErtHYuc3ojtcFbw64YsysrQmRn8e7DnSwQhqkCGcJxxRkus7mvGJASc/kbqk+Sc8mI4Pq8/KzFS2B6xluKY+nGJPNKD4hybTsuTBdCTZ47fg/8ti5d0XepobXNJcjD7h7GZPcFHWqWpJAUosBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RuCVUET9; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779859904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i6GF9NC+0hGkQWtIqtJgv6M4Qu8CawQflj87HW5iRwU=;
	b=RuCVUET955jNhfQMhFMzRXdBXnmDo2tc8nDuqFsws6qMEMsPQUGbNkaJzkc4tm1pAs9k48
	owqS7t80tEP6kSnffAUpVSNfkCG9/vmH6Ht/yxgA1jivLRc2zHM9JNQ+MlW7ijJbivFeAZ
	tn/vJtu+YdnA3bzuudzoX3scKmbPlmc=
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
Subject: [PATCH net 1/2] ipv6: fix possible infinite loop in rt6_fill_node()
Date: Wed, 27 May 2026 13:31:30 +0800
Message-ID: <20260527053133.180695-1-jiayuan.chen@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292098-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: AE57C5DF776
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko reported this issue [1]. Apply the same fix as
commit f8d8ce1b515a ("ipv6: fix possible infinite loop in fib6_info_uses_dev()").

Writers holding tb6_lock can list_del_rcu(&rt->fib6_siblings)
without waiting for RCU readers; rt->fib6_siblings.next then still
points into the old ring and this softirq-side walker never reaches
&rt->fib6_siblings, causing a CPU stall. fib6_purge_rt() always
WRITE_ONCE()s rt->fib6_nsiblings to 0 before list_del_rcu(), so an
inside-loop check is a reliable detach signal.

[1] https://sashiko.dev/#/patchset/20260526020227.4857-1-jiayuan.chen%40linux.dev

Fixes: d9ccb18f83ea ("ipv6: Fix soft lockups in fib6_select_path under high next hop churn")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv6/route.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b106e5fef9cb..dad416fdc585 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5902,6 +5902,8 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 
 				goto nla_put_failure;
 			}
+			if (!READ_ONCE(rt->fib6_nsiblings))
+				break;
 		}
 
 		rcu_read_unlock();
-- 
2.43.0


