Return-Path: <netdev+bounces-103720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE42909334
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 22:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1D8287C0D
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 20:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAA51A3BA4;
	Fri, 14 Jun 2024 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TmjYE89E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756891A2549
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 20:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718395786; cv=none; b=OvNvUocG2KuXHjGPQEPrt3sYEmsT1WVBmU5XccYHzo8tGLmmN0fz1gk/mls4ZSv3eLlVZRG7f9HVc2puw+GK+ghlTHYqsdcdYn3oVf/Mo5l/S5xKwk0ewpTe/O/+Ahj+hGpD9JWBTUyof+Y+N11clKWcu8GrWiTPofOH691WMgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718395786; c=relaxed/simple;
	bh=IMMXUONo88bfbozKksdsXdqq8kI6YKG0w3+D32DhhjI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXjKwhi//1EGvDPqu6MMMZ4fKGlXQXSYaHYPKTDqOcPjcFEQjb6qa4o0S+Jgi0AKtzEVQ8O/pEiQU5VgA2nQTV9B0L7QIkcPZrVxz0VvYevsospHS4mls8PeiQW4I0tHb/xqqMBaedqT04Ca5POr5V32axfNC0pYAryKtjRxRog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TmjYE89E; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718395784; x=1749931784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FMtfoZtz6DBaLn34IQSpkLseHXJiHAnjjhdWRt9JpVM=;
  b=TmjYE89Eq/4ZZiNs79IoVDh+M43g/mKgzMRZlGxD+JcEzwXXeM8JtIv8
   K2131bqEtFkdwwfssIIQKTQ42fHfMfKyCMt1dhRgBDeyF6lKOUX/+LcEU
   3rlcePxGyhkixn6ShmaXNGab6Ek/ESjVJD2mzLnEq0K8hYqV40qnUr/zP
   Y=;
X-IronPort-AV: E=Sophos;i="6.08,238,1712620800"; 
   d="scan'208";a="407906807"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 20:09:43 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:62060]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.14:2525] with esmtp (Farcaster)
 id 633795c6-b47c-4059-824b-9ae484250401; Fri, 14 Jun 2024 20:09:42 +0000 (UTC)
X-Farcaster-Flow-ID: 633795c6-b47c-4059-824b-9ae484250401
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 20:09:37 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 20:09:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 05/11] af_unix: Don't acquire unix_state_lock() for sock_i_ino().
Date: Fri, 14 Jun 2024 13:07:09 -0700
Message-ID: <20240614200715.93150-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240614200715.93150-1-kuniyu@amazon.com>
References: <20240614200715.93150-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

sk_diag_dump_peer() and sk_diag_dump() call unix_state_lock() for
sock_i_ino() which reads SOCK_INODE(sk->sk_socket)->i_ino, but it's
protected by sk->sk_callback_lock.

Let's remove unnecessary unix_state_lock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/diag.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/net/unix/diag.c b/net/unix/diag.c
index 937edf4afed4..d2d66727b0da 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -47,9 +47,7 @@ static int sk_diag_dump_peer(struct sock *sk, struct sk_buff *nlskb)
 
 	peer = unix_peer_get(sk);
 	if (peer) {
-		unix_state_lock(peer);
 		ino = sock_i_ino(peer);
-		unix_state_unlock(peer);
 		sock_put(peer);
 
 		return nla_put_u32(nlskb, UNIX_DIAG_PEER, ino);
@@ -180,22 +178,6 @@ static int sk_diag_fill(struct sock *sk, struct sk_buff *skb, struct unix_diag_r
 	return -EMSGSIZE;
 }
 
-static int sk_diag_dump(struct sock *sk, struct sk_buff *skb, struct unix_diag_req *req,
-			struct user_namespace *user_ns,
-			u32 portid, u32 seq, u32 flags)
-{
-	int sk_ino;
-
-	unix_state_lock(sk);
-	sk_ino = sock_i_ino(sk);
-	unix_state_unlock(sk);
-
-	if (!sk_ino)
-		return 0;
-
-	return sk_diag_fill(sk, skb, req, user_ns, portid, seq, flags, sk_ino);
-}
-
 static int unix_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct net *net = sock_net(skb->sk);
@@ -213,14 +195,22 @@ static int unix_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		num = 0;
 		spin_lock(&net->unx.table.locks[slot]);
 		sk_for_each(sk, &net->unx.table.buckets[slot]) {
+			int sk_ino;
+
 			if (num < s_num)
 				goto next;
+
 			if (!(req->udiag_states & (1 << READ_ONCE(sk->sk_state))))
 				goto next;
-			if (sk_diag_dump(sk, skb, req, sk_user_ns(skb->sk),
+
+			sk_ino = sock_i_ino(sk);
+			if (!sk_ino)
+				goto next;
+
+			if (sk_diag_fill(sk, skb, req, sk_user_ns(skb->sk),
 					 NETLINK_CB(cb->skb).portid,
 					 cb->nlh->nlmsg_seq,
-					 NLM_F_MULTI) < 0) {
+					 NLM_F_MULTI, sk_ino) < 0) {
 				spin_unlock(&net->unx.table.locks[slot]);
 				goto done;
 			}
-- 
2.30.2


