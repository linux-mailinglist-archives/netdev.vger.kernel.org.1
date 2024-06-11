Return-Path: <netdev+bounces-102740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D799046F2
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 00:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41D5286FB1
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 22:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECFE15444C;
	Tue, 11 Jun 2024 22:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jKsHxHSB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204A014EC73
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 22:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718145083; cv=none; b=aq3r+4o40BroG1TESAUsALS/OjBLc9jEZX4W4cgb6oe5W+Xf0Hbl/MzFKRTGYdowX9oxFVmSZ/QxD4NOGfDTUQrSgsCg4eSKYpRVeHlY+z/mkVJWE2aYIRvn3a47dOpnYZSSCN5ET/sEhH3lpQI0/AYJL9Fm5AeCqhOY+IH7Tik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718145083; c=relaxed/simple;
	bh=IMMXUONo88bfbozKksdsXdqq8kI6YKG0w3+D32DhhjI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3aYf9YjQefVd2zBwctSvqrr+TvDXN2NlN7mfzhofaPYWRrLHRJFIBoSGWW185GgYJpGe4Fk/CmkmwjSmPMi+jfQVOZTmw4NdT9IPbGUX5Lbq1WF82L6jOa1Q0xUdMN1mDsfMALxY2l1zZUNHLHYwaZYoXEaz1y4qBBmsFAsVWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jKsHxHSB; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718145082; x=1749681082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FMtfoZtz6DBaLn34IQSpkLseHXJiHAnjjhdWRt9JpVM=;
  b=jKsHxHSBpUc+yZmskunckSJWzBeyBMse7eXxjthjBNJEzjMHo62r6jht
   euAknBkCHq0L+s8F0ZiIh1jNLwkLKrSXifzdR1TuHSIaGwXWaQslI59TO
   hNJ4wBce0ZanckgjTagqGgcULzyHvoe1yMiFkUzaTRBcdNUgkbXTxgRBH
   4=;
X-IronPort-AV: E=Sophos;i="6.08,231,1712620800"; 
   d="scan'208";a="402691478"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 22:31:20 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:38251]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.96:2525] with esmtp (Farcaster)
 id f1758150-1e7c-4028-8fff-f2a0789938fd; Tue, 11 Jun 2024 22:31:19 +0000 (UTC)
X-Farcaster-Flow-ID: f1758150-1e7c-4028-8fff-f2a0789938fd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 22:31:19 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 22:31:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 05/11] af_unix: Don't acquire unix_state_lock() for sock_i_ino().
Date: Tue, 11 Jun 2024 15:28:59 -0700
Message-ID: <20240611222905.34695-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240611222905.34695-1-kuniyu@amazon.com>
References: <20240611222905.34695-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
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


