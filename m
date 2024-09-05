Return-Path: <netdev+bounces-125396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 572E896CFE1
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 09:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA2F1C22892
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 07:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9BB188A37;
	Thu,  5 Sep 2024 07:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dKM2clBz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F5E156883;
	Thu,  5 Sep 2024 07:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725519616; cv=none; b=qto+owkYSLGGTqLRKzTqbWmYy1fNlPvYMFqNtO5moA/j52HkixJjLwdgChxQHVWW3x4uRdPGjmi3z8/w5ILh6dz+Sv5LvR/HAiJlwjTP3Lov69ejQn5f+q/XehsoS4Bb09L0c1zS48Mt0T/8SKLcGvH8pKUxfY30PTii72GUltI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725519616; c=relaxed/simple;
	bh=IvoGT47CSOcRI53r+F1uXaKUyLMUgGspaXXR2zcX36w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8fwlQ5mF1bkD1+Mh6AFBNdolKMfcY8khB8NhbQUcA6aW/XxtcQC2mEspBsJqX8GM6CerPqdw5s4RnYZox6wJkjgyhmKDwQOs98jZ4rYDaZjgA69E6dTxi6uNlfdFYFqKYvC78XDkkfXAZ9AGYShteGVrHwsyqtkhfWRd/wzJ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dKM2clBz; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725519614; x=1757055614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4iqwrQDG5eM85faw8/CTnn+E6kdH/nn6dSuER7474ZM=;
  b=dKM2clBzdsQxw57MOGhWVcY0iiOSIY5pw7Tc1sphwdiRtFQGYmBownnz
   /PFBvauYZWRIbzZJCChx4liocppLBNAlPaTjxP5DwlZERYctN9BF8pq3R
   w3vbQ436iS9qRIN8LWFNARefKFxwXyPfvSjhKvMSBuqo9siRQXOmOxnn2
   Y=;
X-IronPort-AV: E=Sophos;i="6.10,204,1719878400"; 
   d="scan'208";a="450804037"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 07:00:09 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:62662]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.90:2525] with esmtp (Farcaster)
 id c2c91d75-b580-4f96-9904-f4e33928f9d1; Thu, 5 Sep 2024 07:00:08 +0000 (UTC)
X-Farcaster-Flow-ID: c2c91d75-b580-4f96-9904-f4e33928f9d1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 5 Sep 2024 07:00:06 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 5 Sep 2024 07:00:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <lizhi.xu@windriver.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>, <kuniyu@amazon.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in unix_stream_read_actor (2)
Date: Wed, 4 Sep 2024 23:59:55 -0700
Message-ID: <20240905065955.17065-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240905052532.533159-1-lizhi.xu@windriver.com>
References: <20240905052532.533159-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Lizhi Xu <lizhi.xu@windriver.com>
Date: Thu, 5 Sep 2024 13:25:32 +0800
> The sock queue oob twice, the first manage_oob (in unix_stream_read_generic) peek next skb only,
> and the next skb is the oob skb, so if skb is oob skb we need use manage_oob dealwith it.

I think the correct fix should be like this.

The issue happens only when the head oob is consumed (!unix_skb_len(skb))
and the next skb is peeked.  Then, we can fallback to the else branch in
manage_oob().

#syz test

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index a1894019ebd5..9913a447b758 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2654,51 +2654,49 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 				  int flags, int copied)
 {
+	struct sk_buff *consumed_skb = NULL;
+	struct sk_buff *unread_skb = NULL;
 	struct unix_sock *u = unix_sk(sk);
 
-	if (!unix_skb_len(skb)) {
-		struct sk_buff *unlinked_skb = NULL;
-
-		spin_lock(&sk->sk_receive_queue.lock);
+	spin_lock(&sk->sk_receive_queue.lock);
 
+	if (!unix_skb_len(skb)) {
 		if (copied && (!u->oob_skb || skb == u->oob_skb)) {
 			skb = NULL;
 		} else if (flags & MSG_PEEK) {
 			skb = skb_peek_next(skb, &sk->sk_receive_queue);
 		} else {
-			unlinked_skb = skb;
+			consumed_skb = skb;
 			skb = skb_peek_next(skb, &sk->sk_receive_queue);
-			__skb_unlink(unlinked_skb, &sk->sk_receive_queue);
+			__skb_unlink(consumed_skb, &sk->sk_receive_queue);
 		}
 
-		spin_unlock(&sk->sk_receive_queue.lock);
-
-		consume_skb(unlinked_skb);
-	} else {
-		struct sk_buff *unlinked_skb = NULL;
+		if (!u->oob_skb || skb != u->oob_skb)
+			goto unlock;
+	}
 
-		spin_lock(&sk->sk_receive_queue.lock);
+	if (skb == u->oob_skb) {
+		if (copied) {
+			skb = NULL;
+		} else if (!(flags & MSG_PEEK)) {
+			WRITE_ONCE(u->oob_skb, NULL);
 
-		if (skb == u->oob_skb) {
-			if (copied) {
-				skb = NULL;
-			} else if (!(flags & MSG_PEEK)) {
-				WRITE_ONCE(u->oob_skb, NULL);
-
-				if (!sock_flag(sk, SOCK_URGINLINE)) {
-					__skb_unlink(skb, &sk->sk_receive_queue);
-					unlinked_skb = skb;
-					skb = skb_peek(&sk->sk_receive_queue);
-				}
-			} else if (!sock_flag(sk, SOCK_URGINLINE)) {
-				skb = skb_peek_next(skb, &sk->sk_receive_queue);
+			if (!sock_flag(sk, SOCK_URGINLINE)) {
+				__skb_unlink(skb, &sk->sk_receive_queue);
+				unread_skb = skb;
+				skb = skb_peek(&sk->sk_receive_queue);
 			}
+		} else if (!sock_flag(sk, SOCK_URGINLINE)) {
+			skb = skb_peek_next(skb, &sk->sk_receive_queue);
 		}
+	}
 
-		spin_unlock(&sk->sk_receive_queue.lock);
+unlock:
+	spin_unlock(&sk->sk_receive_queue.lock);
+
+	consume_skb(consumed_skb);
+	kfree_skb(unread_skb);
 
-		kfree_skb(unlinked_skb);
-	}
 	return skb;
 }
 #endif

