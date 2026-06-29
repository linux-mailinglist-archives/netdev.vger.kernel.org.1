Return-Path: <netdev+bounces-302467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q2IjFQkPQmpczgkAu9opvQ
	(envelope-from <netdev+bounces-302467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 08:22:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 617106D64DA
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 08:22:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=F8taenjp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302467-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302467-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 413943031AF2
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 06:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2FD391E7B;
	Mon, 29 Jun 2026 06:18:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F50C2E7657
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 06:18:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713932; cv=none; b=Gf1fcY0ocKTm8ignfBG0bSMHf3YjPe7i8ngFnCW8QZV+mutaXBNyB+XaGHi9FY350o0z2hrotK9LaL6erZbypjkOWa8/QdYD7CdvBxk1HLeqfBG2N8Leu14hsNx3pr49s1ZIZSSA3S/ILU+nm7mPdDT5aoPTswQbHUY9XUqLw1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713932; c=relaxed/simple;
	bh=HGk9UVGmAbmA3odVg7kJ7xRqVfqD4yYQvkjewh7Wz3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QNWazqMBK0I6qm8oVsXQZdCyhGFCVM0vb2+NGLoPyk+wqJ2PCjZmFHqlClzPdwDP8qQNbpDhfErH0lWMq6zqn5Hf+dalLqimBvM2kk0TfoG4RM7Ku20DhdydyBvU9rRP2l4l8WUboHQ1/BDU317T8rHAJ939Qh30t3fVIhWIaDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F8taenjp; arc=none smtp.client-ip=95.215.58.182
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782713928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ux8UviHmtp42bq5Mj42P3iQrtCrT1OHBNCOpDvkvzwc=;
	b=F8taenjph9ADimw1E4BWbIwj2Pet9W5UusgXJzlJ4SZfXGcdO+WHkvb4FCEkYf05jWXrge
	/W0NudiUJPGDw4gK1y54Jv+zarPAgX7P0QpamnS7t0H8zDzJOFYcGBhoD44bmkzVe4P6nW
	30gL2S0k8WmOgaZC0+Van3WC1aICI5Q=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	Chenguang Zhao <chenguang.zhao@linux.dev>,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH net-next v2] ipv6: honor per-interface proxy_ndp in forward and NA paths
Date: Mon, 29 Jun 2026 14:18:31 +0800
Message-Id: <20260629061831.1211922-1-chenguang.zhao@linux.dev>
In-Reply-To: <20260623085600.396401-1-zhaochenguang@kylinos.cn>
References: <20260623085600.396401-1-zhaochenguang@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302467-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[chenguang.zhao@linux.dev,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:chenguang.zhao@linux.dev,m:zhaochenguang@kylinos.cn,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenguang.zhao@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 617106D64DA

ndisc_recv_ns() has always checked both devconf_all and idev->cnf for
proxy_ndp, but ip6_forward() and ndisc_recv_na() only looked at the
global setting. The original commit left XXX comments in these paths
likely because idev was not available there at the time; ip6_forward()
now obtains idev from IP6CB(skb)->iif.

Honor per-interface proxy_ndp in both places to match the NS path and
allow setups that only enable proxy_ndp on specific interfaces.

In ip6_forward(), idev is looked up via the ingress interface (iif) while
pneigh_lookup() uses skb->dev. For ND packets this is correct because
vrf_ip6_rcv() does not modify skb->dev for neighbour discovery frames,
so both refer to the ingress interface.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
v2:
 Per Ido's review, the following changes were made in v2:
 - Target net-next instead of net
 - Drop Fixes tag
 - Expand commit message: XXX comment history, idev vs skb->dev for ND packets
 - Fix subject prefix

v1:
 - https://lore.kernel.org/all/20260623085600.396401-1-zhaochenguang@kylinos.cn/

 net/ipv6/ip6_output.c | 4 ++--
 net/ipv6/ndisc.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 368e4fa3b43c..c4ca4a813479 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -579,8 +579,8 @@ int ip6_forward(struct sk_buff *skb)
 		return -ETIMEDOUT;
 	}
 
-	/* XXX: idev->cnf.proxy_ndp? */
-	if (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
+	if ((READ_ONCE(net->ipv6.devconf_all->proxy_ndp) ||
+	     (idev && READ_ONCE(idev->cnf.proxy_ndp))) &&
 	    pneigh_lookup(&nd_tbl, net, &hdr->daddr, skb->dev)) {
 		int proxied = ip6_forward_proxy_check(skb);
 
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index f867ec8d3d90..e03e94681738 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1096,9 +1096,9 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 		 */
 		if (lladdr && !memcmp(lladdr, dev->dev_addr, dev->addr_len) &&
 		    READ_ONCE(net->ipv6.devconf_all->forwarding) &&
-		    READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
+		    (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) ||
+		     (idev && READ_ONCE(idev->cnf.proxy_ndp))) &&
 		    pneigh_lookup(&nd_tbl, net, &msg->target, dev)) {
-			/* XXX: idev->cnf.proxy_ndp */
 			goto out;
 		}
 
-- 
2.25.1


