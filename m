Return-Path: <netdev+bounces-268564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG/WNw04uWk8vgEAu9opvQ
	(envelope-from <netdev+bounces-268564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:16:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B35E2A8955
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2595A301E3C5
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F79B371CF2;
	Tue, 17 Mar 2026 11:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uIwuaBhM"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB8C3A6402
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 11:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745941; cv=none; b=nggAo7DqFBy9p3/OGhaUkLciuokRZtVcnoAUiIoaX34tM9OMegZlHM+A7L5sWiFgk3btpcevgvVb9jz64umvFQ6XdPNfaOYsW0856ECzbKO30Olo5/hUDe4M7aWbj+e7mmoqsvo9Y8ZKYK+CY1t42YtWwom5NIymSRs7yyo6RdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745941; c=relaxed/simple;
	bh=rA/XGWBVSwV6WkEA9hC1XASwdiR0LlBbFXPZuNQANB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o8jebCxU8r+CeSBMs+ACdwlEPcdiWcJXMt1IPDzmZckbwh0LbQjTz9GZaGk8CnqGfj1GLsf725V1zhbCZPKLuxhjHX6TOZWynvTKTR85MUiRTprF01wqBIoORHKuKJbQx7rgx84IHXgnGfTKhOBjV7jtoOHmJHeASAmLP80rOtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uIwuaBhM; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773745937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=897jkTgnjiAFKnQbHCe/dvrTlPgcHYV1gcXdliQJBes=;
	b=uIwuaBhMySWttAgmzgOJluxX/OLwXGXwCVlpsHuugMFdk96LYXatFzfNRkyRoE050i3u0w
	byW/imwY4+t5oBVspYfyeT3tbvGK4+U/ScXBhGK8ijsrA2nRtMCK1N2VtZOWpVsOQdtFox
	c4RO9e1bF8y3PTs796BxJf0o190bB04=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+afbcf622635e98bf40d2@syzkaller.appspotmail.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Taehee Yoo <ap420073@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v1] net/ipv6: mcast: fix circular locking dependency in __ipv6_dev_mc_inc()
Date: Tue, 17 Mar 2026 19:12:07 +0800
Message-ID: <20260317111208.62667-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[shopee.com,syzkaller.appspotmail.com,linux.dev,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-268564-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,afbcf622635e98bf40d2];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 4B35E2A8955
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiayuan Chen <jiayuan.chen@shopee.com>

syzbot reported a possible circular locking dependency:

  fs_reclaim --> sk_lock-AF_INET6 --> &idev->mc_lock

  CPU0                              CPU1
  ----                              ----
  lock(&idev->mc_lock)
                                    lock(sk_lock-AF_INET6)
                                    lock(&idev->mc_lock)  // blocked
  kzalloc(GFP_KERNEL)
    fs_reclaim
      ...nbd I/O...
        sk_lock-AF_INET6            // blocked -> DEADLOCK

__ipv6_dev_mc_inc() does GFP_KERNEL allocation inside mc_lock via
mca_alloc(). This can enter memory reclaim, which through nbd block
I/O may need sk_lock-AF_INET6. But sk_lock -> mc_lock already exists
via setsockopt -> __ipv6_sock_mc_join, so we have a deadlock.

Before commit 63ed8de4be81 ("mld: add mc_lock for protecting
per-interface mld data"), only RTNL was held during the allocation.
The lock ordering was always RTNL -> sk_lock (the nbd path doesn't
involve RTNL), so there was no circular dependency.

Split mca_alloc() into mca_alloc() + mca_init(): mca_alloc() does the
GFP_KERNEL allocation before mc_lock, mca_init() initializes under
mc_lock. If the address already exists, the pre-allocated memory is
simply freed. Also move inet6_ifmcaddr_notify() outside mc_lock since
it also does GFP_KERNEL allocation.

Fixes: 63ed8de4be81 ("mld: add mc_lock for protecting per-interface mld data")
Reported-by: syzbot+afbcf622635e98bf40d2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69b7dc76.050a0220.248e02.0113.GAE@google.com/T/
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 net/ipv6/mcast.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 3330adcf26db..2dfa7ed54d17 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -860,18 +860,16 @@ static void ma_put(struct ifmcaddr6 *mc)
 	}
 }
 
-static struct ifmcaddr6 *mca_alloc(struct inet6_dev *idev,
-				   const struct in6_addr *addr,
-				   unsigned int mode)
+static struct ifmcaddr6 *mca_alloc(void)
 {
-	struct ifmcaddr6 *mc;
+	return kzalloc_obj(struct ifmcaddr6);
+}
 
+static void mca_init(struct inet6_dev *idev, const struct in6_addr *addr,
+		     unsigned int mode, struct ifmcaddr6 *mc)
+{
 	mc_assert_locked(idev);
 
-	mc = kzalloc_obj(*mc);
-	if (!mc)
-		return NULL;
-
 	INIT_DELAYED_WORK(&mc->mca_work, mld_mca_work);
 
 	mc->mca_addr = *addr;
@@ -887,8 +885,6 @@ static struct ifmcaddr6 *mca_alloc(struct inet6_dev *idev,
 	if (ipv6_addr_is_ll_all_nodes(&mc->mca_addr) ||
 	    IPV6_ADDR_MC_SCOPE(&mc->mca_addr) < IPV6_ADDR_SCOPE_LINKLOCAL)
 		mc->mca_flags |= MAF_NOREPORT;
-
-	return mc;
 }
 
 static void inet6_ifmcaddr_notify(struct net_device *dev,
@@ -932,6 +928,7 @@ static void inet6_ifmcaddr_notify(struct net_device *dev,
 static int __ipv6_dev_mc_inc(struct net_device *dev,
 			     const struct in6_addr *addr, unsigned int mode)
 {
+	struct ifmcaddr6 *mc_alloced;
 	struct inet6_dev *idev;
 	struct ifmcaddr6 *mc;
 
@@ -940,10 +937,17 @@ static int __ipv6_dev_mc_inc(struct net_device *dev,
 	if (!idev)
 		return -EINVAL;
 
+	mc_alloced = mca_alloc();
+	if (!mc_alloced) {
+		in6_dev_put(idev);
+		return -ENOMEM;
+	}
+
 	mutex_lock(&idev->mc_lock);
 
 	if (READ_ONCE(idev->dead)) {
 		mutex_unlock(&idev->mc_lock);
+		kfree(mc_alloced);
 		in6_dev_put(idev);
 		return -ENODEV;
 	}
@@ -953,26 +957,24 @@ static int __ipv6_dev_mc_inc(struct net_device *dev,
 			mc->mca_users++;
 			ip6_mc_add_src(idev, &mc->mca_addr, mode, 0, NULL, 0);
 			mutex_unlock(&idev->mc_lock);
+			kfree(mc_alloced);
 			in6_dev_put(idev);
 			return 0;
 		}
 	}
 
-	mc = mca_alloc(idev, addr, mode);
-	if (!mc) {
-		mutex_unlock(&idev->mc_lock);
-		in6_dev_put(idev);
-		return -ENOMEM;
-	}
+	mca_init(idev, addr, mode, mc_alloced);
+	mc = mc_alloced;
 
 	rcu_assign_pointer(mc->next, idev->mc_list);
 	rcu_assign_pointer(idev->mc_list, mc);
 
 	mld_del_delrec(idev, mc);
 	igmp6_group_added(mc);
-	inet6_ifmcaddr_notify(dev, mc, RTM_NEWMULTICAST);
 	mutex_unlock(&idev->mc_lock);
 
+	inet6_ifmcaddr_notify(dev, mc, RTM_NEWMULTICAST);
+
 	return 0;
 }
 
-- 
2.43.0


