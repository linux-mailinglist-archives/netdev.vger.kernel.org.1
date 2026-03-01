Return-Path: <netdev+bounces-262453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SQggGnOXpGlrlwUAu9opvQ
	(envelope-from <netdev+bounces-262453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 20:45:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DF01D1633
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 20:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22AD03010DB5
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 19:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E7918A6A8;
	Sun,  1 Mar 2026 19:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jiqfns1s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B1EEEC0
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 19:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772394352; cv=none; b=E816rdv7p0UkG77eq3Alq34Dss4WtO8AE0J2zBQ+ERXg+XnDenl2QW99wcCGbEKFn+0RoHPBt8rQ7i6qgozY/gzC33suyWRGPwUqIGuIFDXarM4XZGcyKKyYmvhJIEtsqfO1kwW3E7RKzZD6vVrKJ++crnSbEfH4dyfd3wqf3Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772394352; c=relaxed/simple;
	bh=58XDJ2Xb3PSp3pzdLNs0B+8vC7iHFWVRHOpUoQlJOMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lI+VW/TAME0gUYhiMs0UszmhUUvKzKxrZPaQzgdsci0XlJ7revvFM11LCPztwhKiwTK/E3H6meb686ARzW3hoR5Bm9eljaqvBU0lGIp+t0taHj5BDLDhn4zTgCm1VRZVj+uYPet8M2AvIXR8BQPc7QoJtpJPy2fiU90wodVWbUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jiqfns1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6655AC116C6;
	Sun,  1 Mar 2026 19:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772394351;
	bh=58XDJ2Xb3PSp3pzdLNs0B+8vC7iHFWVRHOpUoQlJOMY=;
	h=From:To:Cc:Subject:Date:From;
	b=Jiqfns1sHZ0I8OKlw/cqU169NH5tVDJCyyUhW2A9i5ByfRWuLnn4bq9qsTyNoaMQ+
	 evQuN+DSNiDmjvIPaNBuEzk98gnV7Uop7f07H90YXVBZM5keDgvLn0E57s5hTDN0XS
	 qMakyJlU8RDCkIxUEnH7f/aJ97QbH+NWsSKqGUiBMvxVGwHjjtr/nmmwjvp7M+RraC
	 HBA/OzySlqFI2j3k6XwdIp46QO5jKNJoNMC4fKzMYtFBApCwa+TKrSvGFsbxtppyks
	 /SQ0cycO0AlcTfTivNZLyshR9FeH9e8z93UZjbLE1pgt0SydDZ5eP4CB1xMgNEoeLO
	 dQI3JybRGk0CA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	dsahern@kernel.org
Subject: [PATCH net] ipv6: fix NULL pointer deref in ip6_rt_get_dev_rcu()
Date: Sun,  1 Mar 2026 11:45:48 -0800
Message-ID: <20260301194548.927324-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262453-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fcnal_ipv6.sh:url]
X-Rspamd-Queue-Id: B1DF01D1633
X-Rspamd-Action: no action

l3mdev_master_dev_rcu() can return NULL when the slave device is being
un-slaved from a VRF. All other callers deal with this, but we lost
the fallback to loopback in ip6_rt_pcpu_alloc() -> ip6_rt_get_dev_rcu()
with commit 4832c30d5458 ("net: ipv6: put host and anycast routes on
device with address").

  KASAN: null-ptr-deref in range [0x0000000000000108-0x000000000000010f]
  RIP: 0010:ip6_rt_pcpu_alloc (net/ipv6/route.c:1418)
  Call Trace:
   ip6_pol_route (net/ipv6/route.c:2318)
   fib6_rule_lookup (net/ipv6/fib6_rules.c:115)
   ip6_route_output_flags (net/ipv6/route.c:2607)
   vrf_process_v6_outbound (drivers/net/vrf.c:437)

I was tempted to rework the un-slaving code to clear the flag first
and insert synchronize_rcu() before we remove the upper. But looks like
the explicit fallback to loopback_dev is an established pattern.
And I guess avoiding the synchronize_rcu() is nice, too.

Fixes: 4832c30d5458 ("net: ipv6: put host and anycast routes on device with address")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
now that NIPA is not full of the tc-action.sh crashes this 1 in ~30 runs
crash in fcnal_ipv6.sh pops out quite clearly.

CC: dsahern@kernel.org
---
 net/ipv6/route.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 85df25c36409..7db0c837196c 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1063,7 +1063,8 @@ static struct net_device *ip6_rt_get_dev_rcu(const struct fib6_result *res)
 		 */
 		if (netif_is_l3_slave(dev) &&
 		    !rt6_need_strict(&res->f6i->fib6_dst.addr))
-			dev = l3mdev_master_dev_rcu(dev);
+			dev = l3mdev_master_dev_rcu(dev) ? :
+			      dev_net(dev)->loopback_dev;
 		else if (!netif_is_l3_master(dev))
 			dev = dev_net(dev)->loopback_dev;
 		/* last case is netif_is_l3_master(dev) is true in which
-- 
2.53.0


