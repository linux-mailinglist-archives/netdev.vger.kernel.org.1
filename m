Return-Path: <netdev+bounces-291594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4D/hHL1gFWoiUwcAu9opvQ
	(envelope-from <netdev+bounces-291594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:58:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E4F5D2D33
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9C04300C812
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15583D0BFB;
	Tue, 26 May 2026 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abUwY5JN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D6E3CC33D
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785871; cv=none; b=iLi+rLB9jEonDQNRw6HMJWzaplqu1D7ZlOfvJEqp1mdpQe6EAxV086p0RN6Pl3oNjx7ybNcxSmqRECcejGMskO9xqK5o3+LEQR8rUoJQ4SsK8BIs47ZBPMLwmSZxKEv9xVkqPQVmjHbXXvsLMShwkpwX8f0WaLdQ3Fc1DfC0aBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785871; c=relaxed/simple;
	bh=Z5KBPZCcPU+MaBqAiYS5stC35AH1mL4g3zz4ejevnkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XzvpXv5wqcJikQRtR8GgYXAUJ9eWEasuXxUpOJLs5R2qaJBWuUShHL9Qk1UOwJy8d++U+B6sKiGE3FNqoI0jy87JR+YB85bOJo/jhq9JJuOARa7M5O9pXuUObs8VehDASj9Wj9KqzGIr+SL6LNwYkgujB7ng8WtD9S3Gzti8TeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abUwY5JN; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c801912c903so4560658a12.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 01:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779785863; x=1780390663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KunGhSCrk96qTBkynTCA5j2HMdY8U+GRQlqdEqrz/o0=;
        b=abUwY5JNcFCZJ9cHKIEWwDK9wQO7uGTE+w+l4+edZUhRfkktRCAtpp8dXmPotMbZvF
         wSJVOVGBzQMd+6192uGpeehGiTc2MyyxkGNCkBNEjT8dltQInieGSKcA7Ki9NqFYVIhi
         wTCB5GCSCe0mZDdm29+gJNFEsHTo2KD1XJ+Jqa4NsTFRSWwps7xkPPtrpipBwVCPfVml
         gHWdZSq3GfnFrYInQ4JyiD5iNSP20nnv4JS2jYZP5oQjKi6n7qmHHik/HoPR4E5wYlro
         qPI7fLioJLNF0nVvfRm4O5ud5SqTHpyAocRCbJmFBCBJvzRFfWvlcyrph6dRs9yHtX3E
         yPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779785863; x=1780390663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KunGhSCrk96qTBkynTCA5j2HMdY8U+GRQlqdEqrz/o0=;
        b=iTy3frVMrfQ3CVerkcT7QAZnIT0R3Hj3XMyZ7WcvYEyXcOQdBxcEutNeedE5TuUif6
         2UF52fFUvit9WUbEsZg/EljHvl7ztd6kgiTvhu1yUejOsZXBCccarhJLw1NK+sltdtwf
         VWSXpy9JzdUmZAK7PMg3fWicFAMvhKcbNun1+AXLpEXrOSgmL7uaoMGg1YoyG75NkQFy
         K2gJLmed4uz6kd4aooJ6TY8+xqOOQX+A2vrztIxxqBpEOSyY7Gd7+pNc+egYIErpWUau
         B+N/KJmUZT64NDlGvo3WSB+mccyPPPy2T7J9nXc02/ouDZTVeOWFLujMZ42tlYHF6m7W
         i/Hg==
X-Gm-Message-State: AOJu0YyQzZ2ZyAzduILi/ilE6R0Ff5/J4LUyKYLrEbq6UvnSxsTbaEy0
	lrZeMXbuOYXTQ+10llhsMvtmzb4ixkNgkM+GQt/2m1a22MtlDbfzo3nC
X-Gm-Gg: Acq92OHFzbf+4PYJmZrR6JbFraTUgaanWSXe+5Bdfie+hTAv9XJAmyAE9ltX5WGz/jZ
	kx7KJPFP1ejyvBK6YOLlWVnktRQSEXDL3X640x7JyavOJnbQo+1ToRcwjwwz36pQNv1TJTjby+w
	b7sA9W+joH8MmX7eAuonNZolkiGSLOZ83iksFPp2+uRjweRqrs3Dqk19eeSFEpefMbbkiAmu4Gl
	rUNcZ1H4bt6zzJEiGZ0bOq+BJUGn+97fIHBjcQJFVppofu+AyJd0Y37T8bVioWgX/VZMvFron78
	Qs1jL2KYTvScw0QJXef+WN2MBbEk7jzrtL6R6A0c+ZEvge7ePd5Nk/L4xKMuMNpdDDrfbL6h8eL
	wb1wTfM0PPQbq6seE8gqeU3SDvI4IDnobud0Sjf2jpt40qpRcp97vbRCYhk6EcHzp+gpPHLHvk0
	d5Z7M+pJH3L27Wf4fJVvPkXB3/itk4j7zYSLtZ0ecxQEpp0p/xsmA1i2JU3+7i
X-Received: by 2002:a05:6a20:7350:b0:3a2:e0d3:37ea with SMTP id adf61e73a8af0-3b328c7070cmr18010782637.11.1779785862795;
        Tue, 26 May 2026 01:57:42 -0700 (PDT)
Received: from KIPREYXIAO-MC2.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9b5asm11808516b3a.12.2026.05.26.01.57.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 01:57:42 -0700 (PDT)
From: Zhenghang Xiao <kipreyyy@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Zhenghang Xiao <kipreyyy@gmail.com>
Subject: [PATCH net] appletalk: fix use-after-free in atalk_sendmsg due to route lookup race
Date: Tue, 26 May 2026 16:57:35 +0800
Message-ID: <20260526085735.61445-1-kipreyyy@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-291594-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kipreyyy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E7E4F5D2D33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

atrtr_find() returns a raw pointer after releasing atalk_routes_lock.
In atalk_sendmsg(), both the primary route (rt) and loopback route
(rt_lo) pointers are held across sock_alloc_send_skb() which can sleep.
Concurrent atrtr_delete() or atrtr_device_down() can kfree() the route
during this window, causing UAF when rt->flags, rt->gateway, or
rt_lo->dev are accessed.

Fix by deferring route frees with kfree_rcu() and caching all needed
route fields under rcu_read_lock() before the sleeping allocation.
Take dev_hold() on both route devices to prevent disappearance after
the route's dev_put() in the delete path.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
---
 include/linux/atalk.h |  1 +
 net/appletalk/ddp.c   | 52 +++++++++++++++++++++++++++----------------
 2 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/include/linux/atalk.h b/include/linux/atalk.h
index a55bfc6567d0..932cb72379c2 100644
--- a/include/linux/atalk.h
+++ b/include/linux/atalk.h
@@ -12,6 +12,7 @@ struct atalk_route {
 	struct atalk_addr  gateway;
 	int		   flags;
 	struct atalk_route *next;
+	struct rcu_head	   rcu;
 };
 
 /**
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index 30a6dc06291c..2c754378fa08 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -603,7 +603,7 @@ static int atrtr_delete(struct atalk_addr *addr)
 		     tmp->target.s_node == addr->s_node)) {
 			*r = tmp->next;
 			dev_put(tmp->dev);
-			kfree(tmp);
+			kfree_rcu(tmp, rcu);
 			goto out;
 		}
 		r = &tmp->next;
@@ -628,7 +628,7 @@ static void atrtr_device_down(struct net_device *dev)
 		if (tmp->dev == dev) {
 			*r = tmp->next;
 			dev_put(dev);
-			kfree(tmp);
+			kfree_rcu(tmp, rcu);
 		} else
 			r = &tmp->next;
 	}
@@ -1553,10 +1553,13 @@ static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	int loopback = 0;
 	struct sockaddr_at local_satalk, gsat;
 	struct sk_buff *skb;
-	struct net_device *dev;
+	struct net_device *dev = NULL;
+	struct net_device *dev_lo = NULL;
 	struct ddpehdr *ddp;
 	int size, hard_header_len;
 	struct atalk_route *rt, *rt_lo = NULL;
+	int rt_flags;
+	struct atalk_addr rt_gateway;
 	int err;
 
 	if (flags & ~(MSG_DONTWAIT|MSG_CMSG_COMPAT))
@@ -1600,6 +1603,7 @@ static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	/* For headers */
 	size = sizeof(struct ddpehdr) + len + ddp_dl->header_length;
 
+	rcu_read_lock();
 	if (usat->sat_addr.s_net || usat->sat_addr.s_node == ATADDR_ANYNODE) {
 		rt = atrtr_find(&usat->sat_addr);
 	} else {
@@ -1610,29 +1614,38 @@ static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 
 		rt = atrtr_find(&at_hint);
 	}
-	err = -ENETUNREACH;
-	if (!rt)
+	if (!rt) {
+		rcu_read_unlock();
+		err = -ENETUNREACH;
 		goto out;
+	}
 
 	dev = rt->dev;
-
-	net_dbg_ratelimited("SK %p: Size needed %d, device %s\n",
-			sk, size, dev->name);
+	dev_hold(dev);
+	rt_flags = rt->flags;
+	rt_gateway = rt->gateway;
 
 	hard_header_len = dev->hard_header_len;
 	/* Leave room for loopback hardware header if necessary */
 	if (usat->sat_addr.s_node == ATADDR_BCAST &&
-	    (dev->flags & IFF_LOOPBACK || !(rt->flags & RTF_GATEWAY))) {
+	    (dev->flags & IFF_LOOPBACK || !(rt_flags & RTF_GATEWAY))) {
 		struct atalk_addr at_lo;
 
 		at_lo.s_node = 0;
 		at_lo.s_net  = 0;
 
 		rt_lo = atrtr_find(&at_lo);
-
-		if (rt_lo && rt_lo->dev->hard_header_len > hard_header_len)
-			hard_header_len = rt_lo->dev->hard_header_len;
+		if (rt_lo) {
+			dev_lo = rt_lo->dev;
+			dev_hold(dev_lo);
+			if (dev_lo->hard_header_len > hard_header_len)
+				hard_header_len = dev_lo->hard_header_len;
+		}
 	}
+	rcu_read_unlock();
+
+	net_dbg_ratelimited("SK %p: Size needed %d, device %s\n",
+			sk, size, dev->name);
 
 	size += hard_header_len;
 	release_sock(sk);
@@ -1675,7 +1688,7 @@ static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	 * to group we are in)
 	 */
 	if (ddp->deh_dnode == ATADDR_BCAST &&
-	    !(rt->flags & RTF_GATEWAY) && !(dev->flags & IFF_LOOPBACK)) {
+	    !(rt_flags & RTF_GATEWAY) && !(dev->flags & IFF_LOOPBACK)) {
 		struct sk_buff *skb2 = skb_copy(skb, GFP_KERNEL);
 
 		if (skb2) {
@@ -1693,19 +1706,18 @@ static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		/* loop back */
 		skb_orphan(skb);
 		if (ddp->deh_dnode == ATADDR_BCAST) {
-			if (!rt_lo) {
+			if (!dev_lo) {
 				kfree_skb(skb);
 				err = -ENETUNREACH;
 				goto out;
 			}
-			dev = rt_lo->dev;
-			skb->dev = dev;
+			skb->dev = dev_lo;
 		}
-		ddp_dl->request(ddp_dl, skb, dev->dev_addr);
+		ddp_dl->request(ddp_dl, skb, skb->dev->dev_addr);
 	} else {
 		net_dbg_ratelimited("SK %p: send out.\n", sk);
-		if (rt->flags & RTF_GATEWAY) {
-		    gsat.sat_addr = rt->gateway;
+		if (rt_flags & RTF_GATEWAY) {
+		    gsat.sat_addr = rt_gateway;
 		    usat = &gsat;
 		}
 
@@ -1718,6 +1730,8 @@ static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 
 out:
 	release_sock(sk);
+	dev_put(dev);
+	dev_put(dev_lo);
 	return err ? : len;
 }
 
-- 
2.50.1 (Apple Git-155)


