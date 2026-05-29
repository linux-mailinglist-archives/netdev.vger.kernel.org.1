Return-Path: <netdev+bounces-292957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPXQNvMGGWr7pggAu9opvQ
	(envelope-from <netdev+bounces-292957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 05:24:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D59A5FCB5A
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 05:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2092C301724F
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A014B367B73;
	Fri, 29 May 2026 03:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZmWvFfw1"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95952E739C
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 03:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024845; cv=none; b=JEVCfeVo74pdK0ky8kppfMPmJAIyeUc8mTero5HTmqqjkXIQPiPY/JIWEFGrkDoWQ5pBHDuPE2Kty/dY/JBuKIWKn+Whfe8nYywGCbd1F2+GVmVp9QMUXBV/zf9rFY12W3abqTm7ifb2m33l72s3juVNmXo9tLNuzVNvyb3c114=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024845; c=relaxed/simple;
	bh=RB3qOs2Ohx6Lg4He1Ag2kH5Y/QXyI/UlS5MiaZD55JI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYFcMfnTm6z/rmMG+KboztTJ6bHvw4bACtXdKsogEnVDBP7QyaGxPLhaRAyhRc8rg6L6dDKSXIrH2wXks4lBvY5/gkMBRQi27glaaTkgXI8X6GGhVYBto/M/Gr5QfDkHjZTS6Vmq4JMMaBM1J4HX2VPRUjjqtcTmIKbOI1BeKjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZmWvFfw1; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780024840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Jx7dJ3LrSYHkDmTM3C5e8iRNjYq89+NASBYIOXgzJoU=;
	b=ZmWvFfw1S5HaZrtgg4Q6iNLHX/ASXIzovM5ogMfXVEwEFIzkvg2vd30VMFbeGb/HWn9wb3
	foJFayJAzLRjC+TX0EhDaAE1dVjdStrcLhzH8heSNrZzdGLnK1gnEwBnhIqARTBBa03+Kz
	ZSwHj/KilAjlDhrzgRH3d4xid4C1XgY=
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
	Kuniyuki Iwashima <kuniyu@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] ipv6: anycast: insert aca into global hash under idev->lock
Date: Fri, 29 May 2026 11:20:25 +0800
Message-ID: <20260529032026.363856-1-jiayuan.chen@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292957-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 5D59A5FCB5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot reported a splat [1]: a slab-use-after-free in
ipv6_chk_acast_addr(), which walks the global inet6_acaddr_lst[] hash
under RCU and dereferences a struct ifacaddr6 that has already been
freed while still linked in the hash, so a later reader walks into a
dangling node.

In __ipv6_dev_ac_inc() the aca is allocated with refcount 1, then
aca_get() bumps it to 2 to keep it alive across the unlocked region.
It is published to idev->ac_list under idev->lock, but
ipv6_add_acaddr_hash() runs after write_unlock_bh(). A concurrent
teardown (ipv6_ac_destroy_dev() from addrconf_ifdown(), under RTNL)
can slip into that window:

  CPU0 __ipv6_dev_ac_inc           CPU1 ipv6_ac_destroy_dev (RTNL)
  ------------------------------   ------------------------------------
  aca_alloc()              refcnt 1
  aca_get()               refcnt 2
  write_lock_bh(idev->lock)
    add aca to ac_list
  write_unlock_bh(idev->lock)
                                   write_lock_bh(idev->lock)
                                     pull aca off ac_list
                                   write_unlock_bh(idev->lock)
                                   ipv6_del_acaddr_hash(aca)
                                     hlist_del_init_rcu() is a no-op,
                                     aca is not in the hash yet
                                   aca_put()           refcnt 2->1
  ipv6_add_acaddr_hash(aca)
    aca now inserted into the hash
  aca_put()                refcnt 1->0
    call_rcu(aca_free_rcu) -> kfree(aca)

The hash removal becomes a no-op because the insertion has not
happened yet, so once CPU0 inserts and drops the last reference, the
aca is freed while still linked in inet6_acaddr_lst[], and readers
dereference freed memory after the slab slot is reused.

This window opened once RTNL stopped serializing the join path against
device teardown. Move ipv6_add_acaddr_hash() inside the idev->lock
section so the ac_list and hash insertions are atomic with respect to
teardown: a racing remover now either misses the aca entirely or finds
it in both lists.

[1] https://syzkaller.appspot.com/bug?extid=a01df04303c131efbf3a

Fixes: eb1ac9ff6c4a ("ipv6: anycast: Don't hold RTNL for IPV6_JOIN_ANYCAST.")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv6/anycast.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
index 67a42e01dfc3..cd8c02a1ad4c 100644
--- a/net/ipv6/anycast.c
+++ b/net/ipv6/anycast.c
@@ -371,10 +371,10 @@ int __ipv6_dev_ac_inc(struct inet6_dev *idev, const struct in6_addr *addr)
 	aca->aca_next = idev->ac_list;
 	rcu_assign_pointer(idev->ac_list, aca);
 
-	write_unlock_bh(&idev->lock);
-
 	ipv6_add_acaddr_hash(net, aca);
 
+	write_unlock_bh(&idev->lock);
+
 	ip6_ins_rt(net, f6i);
 
 	addrconf_join_solict(idev->dev, &aca->aca_addr);
-- 
2.43.0


