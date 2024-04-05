Return-Path: <netdev+bounces-85190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BD8899B66
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 12:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938182824FC
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 10:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B0816ABDD;
	Fri,  5 Apr 2024 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHwMPTy0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8B416ABDE
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314488; cv=none; b=Ph9dKNSspfNx9c9IyUFeVmUuqMNtAy7yxf4lwzmufpgt2pfjplhfVfP2snLDUsrlllXiowsWExLdtx+jnjFfMejuZ/5xaAphofE3HnGpf0sAjfL+JThrxCoP7lp82d1SbUKdl9K9XHIdmBHNosn8P/Fu9XUxBmM8uwu6BJU1f1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314488; c=relaxed/simple;
	bh=To5A4M4WOKRZoEHIzugmE9TFkdwevHaM2rNN+ZTcRr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RTBo5HjjMPV+bIerMt+TcFWex8FWtrxOJyZ+5jhUP1S311Tq1FxFf/g/TyrWIWesIBpgzAsgSvZf3FcDzK8J5oCaVZ5HQRCVMOyOA7VJyK/rQWkjk8ecIgKYz12TRoODiTD5YVId13k7UUi4Z3SSRWKYeB/9Lwo9joGj+sd0YJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IHwMPTy0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712314485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9nZAWSaBPuynx66B5XqJ60TNqoFuIzxwkDzDU3J2744=;
	b=IHwMPTy06oO88xRxmkpg7+F3p2mBJe/pwa55QIR2fr5qLOY7igZUTas8dN4zz8i+0mY1LD
	bMKahhM9E78eLC7ki9TC7ozQX1CGXtEykshkBQwXDxbdEUpwDaIT+dFPZ8GFao9iEib2Dt
	HCiJCP3Y8nVuTdUVvER5DN/bmvNBc9M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-DblAvW_iNb-yn94ctt2OFw-1; Fri,
 05 Apr 2024 06:54:41 -0400
X-MC-Unique: DblAvW_iNb-yn94ctt2OFw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D9D23C0F458;
	Fri,  5 Apr 2024 10:54:41 +0000 (UTC)
Received: from griffin.upir.cz (unknown [10.45.225.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B61CC40735E1;
	Fri,  5 Apr 2024 10:54:40 +0000 (UTC)
From: Jiri Benc <jbenc@redhat.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net] ipv6: fix race condition between ipv6_get_ifaddr and ipv6_del_addr
Date: Fri,  5 Apr 2024 12:54:05 +0200
Message-ID: <8bbe1218656e66552ff28cbee8c7d1f0ffd8e9fd.1712314149.git.jbenc@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Although ipv6_get_ifaddr walks inet6_addr_lst under the RCU lock, it
still means hlist_for_each_entry_rcu can return an item that got removed
from the list. The memory itself of such item is not freed thanks to RCU
but nothing guarantees the actual content of the memory is sane.

In particular, the reference count can be zero. This can happen if
ipv6_del_addr is called in parallel. ipv6_del_addr removes the entry
from inet6_addr_lst (hlist_del_init_rcu(&ifp->addr_lst)) and drops all
references (__in6_ifa_put(ifp) + in6_ifa_put(ifp)). With bad enough
timing, this can happen:

1. In ipv6_get_ifaddr, hlist_for_each_entry_rcu returns an entry.

2. Then, the whole ipv6_del_addr is executed for the given entry. The
   reference count drops to zero and kfree_rcu is scheduled.

3. ipv6_get_ifaddr continues and increments the reference count
   (in6_ifa_hold).

4. The rcu is unlocked and the entry is freed.

5. Later, the reference count is dropped to zero (again) and kfree_rcu
   is scheduled (again).

Prevent increasing of the reference count in such case. The name
in6_ifa_hold_safe is chosen to mimic the existing fib6_info_hold_safe.

Fixes: 5c578aedcb21d ("IPv6: convert addrconf hash list to RCU")
Signed-off-by: Jiri Benc <jbenc@redhat.com>
---

Side note: While this fixes one bug, there may be more locking bugs
lurking aroung inet6_ifaddr. The semantics of locking of inet6_ifaddr is
wild and fragile. Some of the fields are freed in ipv6_del_addr and
guarded by ifa->state == INET6_IFADDR_STATE_DEAD and RTNL. Some of the
fields are freed in inet6_ifa_finish_destroy and guarded by ifa->refcnt
and RCU. Needless to say, this semantics is undocumented. Worse,
ifa->state guard may not be enough. For example, ipv6_get_ifaddr can
still return an entry that proceeded through ipv6_del_addr, which means
ifa->state is INET6_IFADDR_STATE_DEAD. However, at least some callers
(e.g. ndisc_recv_ns) seem to change ifa->state to something else. As
another example, ipv6_del_addr relies on ifa->flags, which are changed
throughout the code without RTNL. All of this may be okay but it's far
from clear.
---
 include/net/addrconf.h | 4 ++++
 net/ipv6/addrconf.c    | 7 ++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 9d06eb945509..62a407db1bf5 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -438,6 +438,10 @@ static inline void in6_ifa_hold(struct inet6_ifaddr *ifp)
 	refcount_inc(&ifp->refcnt);
 }
 
+static inline bool in6_ifa_hold_safe(struct inet6_ifaddr *ifp)
+{
+	return refcount_inc_not_zero(&ifp->refcnt);
+}
 
 /*
  *	compute link-local solicited-node multicast address
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 92db9b474f2b..779aa6ecdd49 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2091,9 +2091,10 @@ struct inet6_ifaddr *ipv6_get_ifaddr(struct net *net, const struct in6_addr *add
 		if (ipv6_addr_equal(&ifp->addr, addr)) {
 			if (!dev || ifp->idev->dev == dev ||
 			    !(ifp->scope&(IFA_LINK|IFA_HOST) || strict)) {
-				result = ifp;
-				in6_ifa_hold(ifp);
-				break;
+				if (in6_ifa_hold_safe(ifp)) {
+					result = ifp;
+					break;
+				}
 			}
 		}
 	}
-- 
2.42.0


