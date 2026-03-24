Return-Path: <netdev+bounces-271129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIHNCfiswmkyggQAu9opvQ
	(envelope-from <netdev+bounces-271129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:25:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B68B317F8A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BDCE30C2FD7
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561103FF89C;
	Tue, 24 Mar 2026 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AiyHZzH3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3863F7876
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365755; cv=none; b=nY4EArd0aWh9zE/a+yTDxpbTBDRQX+lbKbXSPDHwtmYIWGlwNDEjOQcyaUETLoxWCL/gGIjlz0ekZY7pAYBIoXp73ol4Nbtc1S4cAsUwhY81Ducev8yyDRBnQcx5vyGHzuOLZXUfdrj8Xr8y/jfCGqy+0TUrtrn9MlxDAK/fyu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365755; c=relaxed/simple;
	bh=cDv4z8F3ZU1hhs7Pr440qDVgfpZge4BRntmyZP3PyQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XJtM8zOXNxoj62gqazAPAhwl2lq6NYt8fZSljOuT+RPDWbsEs+z5WGdChfblgDIfWi8GhUWokcpZeViRJNpjYnSiJW2vpxiJaVcWLHSsJdfPiwfAS++kRQ7AONxpaTmAC6NGb8A8e/7CMaJw82D7dbUX3Y1AZnnpnCs0DElZNeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AiyHZzH3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774365752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AljYupB1W5aqbCV281Bnsa6QEAqHijDWaQk+OgN80V4=;
	b=AiyHZzH3iZIoq+nRpBmMqwYtcwnXm3RSui/XvKtSOmpdang31mxtL46000sB92dMoDCIce
	nzAPfWXBlBeMxkFoPhnYw+S6KR/td/NqF9UMWru//ERqj+X4ocmvH+tYY+ixHNJOKPKhKr
	B+2H+0jOa9nRDAp0ngB/ywTPws0jCNE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-Jz810WUoOXyAdPYLnfaQXQ-1; Tue,
 24 Mar 2026 11:22:28 -0400
X-MC-Unique: Jz810WUoOXyAdPYLnfaQXQ-1
X-Mimecast-MFC-AGG-ID: Jz810WUoOXyAdPYLnfaQXQ_1774365746
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95E981800245;
	Tue, 24 Mar 2026 15:22:26 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.158])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8C2A218001FE;
	Tue, 24 Mar 2026 15:22:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next] ipv6: move IFA_F_PERMANENT percpu allocation in process scope
Date: Tue, 24 Mar 2026 16:22:08 +0100
Message-ID: <8c8bfe2e1a324e501f0e15fef404a77443fd8caf.1774365668.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271129-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B68B317F8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Observed at boot time:

 CPU: 43 UID: 0 PID: 3595 Comm: (t-daemon) Not tainted 6.12.0 #1
 Call Trace:
  <TASK>
  dump_stack_lvl+0x4e/0x70
  pcpu_alloc_noprof.cold+0x1f/0x4b
  fib_nh_common_init+0x4c/0x110
  fib6_nh_init+0x387/0x740
  ip6_route_info_create+0x46d/0x640
  addrconf_f6i_alloc+0x13b/0x180
  addrconf_permanent_addr+0xd0/0x220
  addrconf_notify+0x93/0x540
  notifier_call_chain+0x5a/0xd0
  __dev_notify_flags+0x5c/0xf0
  dev_change_flags+0x54/0x70
  do_setlink+0x36c/0xce0
  rtnl_setlink+0x11f/0x1d0
  rtnetlink_rcv_msg+0x142/0x3f0
  netlink_rcv_skb+0x50/0x100
  netlink_unicast+0x242/0x390
  netlink_sendmsg+0x21b/0x470
  __sys_sendto+0x1dc/0x1f0
  __x64_sys_sendto+0x24/0x30
  do_syscall_64+0x7d/0x160
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f5c3852f127
 Code: 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 80 3d 85 ef 0c 00 00 41 89 ca 74 10 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 71 c3 55 48 83 ec 30 44 89 4c 24 2c 4c 89 44
 RSP: 002b:00007ffe86caf4c8 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
 RAX: ffffffffffffffda RBX: 0000556c5cd93210 RCX: 00007f5c3852f127
 RDX: 0000000000000020 RSI: 0000556c5cd938b0 RDI: 0000000000000003
 RBP: 00007ffe86caf5a0 R08: 00007ffe86caf4e0 R09: 0000000000000080
 R10: 0000000000000000 R11: 0000000000000202 R12: 0000556c5cd932d0
 R13: 00000000021d05d1 R14: 00000000021d05d1 R15: 0000000000000001

IFA_F_PERMANENT addresses require the allocation of a bunch of percpu
pointers, currently in atomic scope.

Similar to commit 51454ea42c1a ("ipv6: fix locking issues with loops
over idev->addr_list"), move fixup_permanent_addr() outside the
&idev->lock scope, and do the allocations with GFP_KERNEL. With such
change fixup_permanent_addr() is invoked with the BH enabled, and the
ifp lock acquired there needs the BH variant.

Note that we don't need to acquire a reference to the permanent
addresses before releasing the mentioned write lock, because
addrconf_permanent_addr() runs under RTNL and ifa removal always happens
under RTNL, too.

Also the PERMANENT flag is constant in the relevant scope, as it can be
cleared only by inet6_addr_modify() under the RTNL lock.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
explicitly targeting net-next as this is IMHO an improvement more than a
bug fix
---
 net/ipv6/addrconf.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 0e55f139e05d..5f61dd27bddd 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3585,15 +3585,15 @@ static int fixup_permanent_addr(struct net *net,
 		struct fib6_info *f6i, *prev;
 
 		f6i = addrconf_f6i_alloc(net, idev, &ifp->addr, false,
-					 GFP_ATOMIC, NULL);
+					 GFP_KERNEL, NULL);
 		if (IS_ERR(f6i))
 			return PTR_ERR(f6i);
 
 		/* ifp->rt can be accessed outside of rtnl */
-		spin_lock(&ifp->lock);
+		spin_lock_bh(&ifp->lock);
 		prev = ifp->rt;
 		ifp->rt = f6i;
-		spin_unlock(&ifp->lock);
+		spin_unlock_bh(&ifp->lock);
 
 		fib6_info_release(prev);
 	}
@@ -3601,7 +3601,7 @@ static int fixup_permanent_addr(struct net *net,
 	if (!(ifp->flags & IFA_F_NOPREFIXROUTE)) {
 		addrconf_prefix_route(&ifp->addr, ifp->prefix_len,
 				      ifp->rt_priority, idev->dev, 0, 0,
-				      GFP_ATOMIC);
+				      GFP_KERNEL);
 	}
 
 	if (ifp->state == INET6_IFADDR_STATE_PREDAD)
@@ -3612,29 +3612,37 @@ static int fixup_permanent_addr(struct net *net,
 
 static void addrconf_permanent_addr(struct net *net, struct net_device *dev)
 {
-	struct inet6_ifaddr *ifp, *tmp;
+	struct inet6_ifaddr *ifp;
+	LIST_HEAD(tmp_addr_list);
 	struct inet6_dev *idev;
 
+	/* Mutual exclusion with other if_list_aux users. */
+	ASSERT_RTNL();
+
 	idev = __in6_dev_get(dev);
 	if (!idev)
 		return;
 
 	write_lock_bh(&idev->lock);
+	list_for_each_entry(ifp, &idev->addr_list, if_list) {
+		if (ifp->flags & IFA_F_PERMANENT)
+			list_add_tail(&ifp->if_list_aux, &tmp_addr_list);
+	}
+	write_unlock_bh(&idev->lock);
 
-	list_for_each_entry_safe(ifp, tmp, &idev->addr_list, if_list) {
-		if ((ifp->flags & IFA_F_PERMANENT) &&
-		    fixup_permanent_addr(net, idev, ifp) < 0) {
-			write_unlock_bh(&idev->lock);
+	while (!list_empty(&tmp_addr_list)) {
+		ifp = list_first_entry(&tmp_addr_list,
+				       struct inet6_ifaddr, if_list_aux);
+		list_del(&ifp->if_list_aux);
+
+		if (fixup_permanent_addr(net, idev, ifp) < 0) {
 			in6_ifa_hold(ifp);
 			ipv6_del_addr(ifp);
-			write_lock_bh(&idev->lock);
 
 			net_info_ratelimited("%s: Failed to add prefix route for address %pI6c; dropping\n",
 					     idev->dev->name, &ifp->addr);
 		}
 	}
-
-	write_unlock_bh(&idev->lock);
 }
 
 static int addrconf_notify(struct notifier_block *this, unsigned long event,
-- 
2.53.0


