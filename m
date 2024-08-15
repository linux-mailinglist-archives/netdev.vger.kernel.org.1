Return-Path: <netdev+bounces-118966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73227953B32
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4C05B20BCA
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 19:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE4513C81C;
	Thu, 15 Aug 2024 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="l9njajc2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557775A0F5;
	Thu, 15 Aug 2024 19:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723751828; cv=none; b=Wv4w55+VuDa7lRsmFeOoBm5kHc+ubTllK+6o6/q3pVDl9aIFP4f9++NchrKfX6WHByVcbu9ENIKzHguOdd+5yyv4CYJbyYaziOu/ZP1PohuSjF0fv8fsQoFiNbf0mSLWNMrEGiSD+6BwsXu61LHfhZCbgp2ppGZoBF58bUNjM+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723751828; c=relaxed/simple;
	bh=feu46mf8V8KT+QQdsoaIbTOPPVAE1/mj1S85hocTI3s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBT6dOan2/AfuTeyRj/wjmBGRcTzyU7FiEO/EXWJxJSmr1KP7IV3kCb3lX8sdcFfnAakw3W+ca2Po5dqXTGfrbKJdI8ijrLRSqy4ss1UObNbAom+S4waSF9pSBCffpVmbnvUrG4LKeBeygvHSpRFke1qOyuNNMUeyNyMs3ufFIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=l9njajc2; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723751826; x=1755287826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sWRo8z/c0hTkwKpcQpYiaasM1XYNZGlVmju7dSB97NQ=;
  b=l9njajc2n8jfIrQDA6mvfyERAcafc79I23yb9ObsIi5ox43ruswBc2tz
   eu1sqGllUfFDz04wYv3hk9fxSWbDq/J7ze/koKVKntamf1PbYHXBVvEeq
   TddBmJOfEtxMwTS74ennJsNlIzHwnEV8/6B+dyvpkGYJvdSLztNKEoc+o
   4=;
X-IronPort-AV: E=Sophos;i="6.10,149,1719878400"; 
   d="scan'208";a="362510511"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 19:56:59 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:38126]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.153:2525] with esmtp (Farcaster)
 id 11d1a420-e338-4bb0-91ea-c17e247e603a; Thu, 15 Aug 2024 19:56:57 +0000 (UTC)
X-Farcaster-Flow-ID: 11d1a420-e338-4bb0-91ea-c17e247e603a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 15 Aug 2024 19:56:57 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 15 Aug 2024 19:56:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <sunyiqixm@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH] net: do not release sk in sk_wait_event
Date: Thu, 15 Aug 2024 12:56:45 -0700
Message-ID: <20240815195645.43808-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240815102329.172161-1-sunyiqixm@gmail.com>
References: <20240815102329.172161-1-sunyiqixm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: sunyiqi <sunyiqixm@gmail.com>
Date: Thu, 15 Aug 2024 18:23:29 +0800
> On Thu, 15 Aug 2024 12:03:37 +0200, Paolo Abeni wrote:
> > On 8/15/24 10:49, sunyiqi wrote:
> > > When investigating the kcm socket UAF which is also found by syzbot,
> > > I found that the root cause of this problem is actually in
> > > sk_wait_event.
> > > 
> > > In sk_wait_event, sk is released and relocked and called by
> > > sk_stream_wait_memory. Protocols like tcp, kcm, etc., called it in some
> > > ops function like *sendmsg which will lock the sk at the beginning.
> > > But sk_stream_wait_memory releases sk unexpectedly and destroy
> > > the thread safety. Finally it causes the kcm sk UAF.
> > > 
> > > If at the time when a thread(thread A) calls sk_stream_wait_memory
> > > and the other thread(thread B) is waiting for lock in lock_sock,
> > > thread B will successfully get the sk lock as thread A release sk lock
> > > in sk_wait_event.
> > > 
> > > The thread B may change the sk which is not thread A expecting.
> > > 
> > > As a result, it will lead kernel to the unexpected behavior. Just like
> > > the kcm sk UAF, which is actually cause by sk_wait_event in
> > > sk_stream_wait_memory.
> > > 
> > > Previous commit d9dc8b0f8b4e ("net: fix sleeping for sk_wait_event()")
> > > in 2016 seems do not solved this problem. Is it necessary to release
> > > sock in sk_wait_event? Or just delete it to make the protocol ops
> > > thread-secure.
> > 
> > As a I wrote previously, please describe the suspected race more 
> > clearly, with the exact calls sequence that lead to the UAF.
> > 
> > Releasing the socket lock is not enough to cause UAF.
> 
> Thread A                 Thread B
> kcm_sendmsg
>  lock_sock               kcm_sendmsg
>                           lock_sock (blocked & waiting)
>  head = sk->seq_buf
>  sk_stream_wait_memory
>   sk_wait_event
>    release_sock
>                           lock_sock (get the lock)
>                           head = sk->seq_buf
>                           add head to sk->sk_write_queue
>                           release_sock
>    lock_sock              return
>  err_out to free(head)
>  release_sock
>  return
> // ...
> kcm_release
>  // ...
>  __skb_queue_purge(&sk->sk_write_queue) // <--- UAF
>  // ...
> 
> The repro can be downloaded here:
> https://syzkaller.appspot.com/bug?extid=b72d86aa5df17ce74c60

When a thread is building a skb with MSG_MORE, another thread
must not touch it nor complete building it by queuing it to
write queue and setting NULL to kcm->seq_skb.

I think the correct fix is simply serialise them with mutex.

---8<---
diff --git a/include/net/kcm.h b/include/net/kcm.h
index 90279e5e09a5..441e993be634 100644
--- a/include/net/kcm.h
+++ b/include/net/kcm.h
@@ -70,6 +70,7 @@ struct kcm_sock {
 	struct work_struct tx_work;
 	struct list_head wait_psock_list;
 	struct sk_buff *seq_skb;
+	struct mutex tx_mutex;
 	u32 tx_stopped : 1;
 
 	/* Don't use bit fields here, these are set under different locks */
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 2f191e50d4fc..d4118c796290 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -755,6 +755,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		  !(msg->msg_flags & MSG_MORE) : !!(msg->msg_flags & MSG_EOR);
 	int err = -EPIPE;
 
+	mutex_lock(&kcm->tx_mutex);
 	lock_sock(sk);
 
 	/* Per tcp_sendmsg this should be in poll */
@@ -926,6 +927,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	KCM_STATS_ADD(kcm->stats.tx_bytes, copied);
 
 	release_sock(sk);
+	mutex_unlock(&kcm->tx_mutex);
 	return copied;
 
 out_error:
@@ -951,6 +953,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		sk->sk_write_space(sk);
 
 	release_sock(sk);
+	mutex_unlock(&kcm->tx_mutex);
 	return err;
 }
 
@@ -1204,6 +1207,7 @@ static void init_kcm_sock(struct kcm_sock *kcm, struct kcm_mux *mux)
 	spin_unlock_bh(&mux->lock);
 
 	INIT_WORK(&kcm->tx_work, kcm_tx_work);
+	mutex_init(&kcm->tx_mutex);
 
 	spin_lock_bh(&mux->rx_lock);
 	kcm_rcv_ready(kcm);
---8<---


We can allow another thread to complete building skb by the
following but it doesn't sound correct to me.

---8<---
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 2f191e50d4fc..51f2409d6113 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -748,7 +748,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct kcm_sock *kcm = kcm_sk(sk);
-	struct sk_buff *skb = NULL, *head = NULL;
+	struct sk_buff *skb = NULL, *head = NULL, *seq_skb;
 	size_t copy, copied = 0;
 	long timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 	int eor = (sock->type == SOCK_DGRAM) ?
@@ -763,6 +763,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	if (sk->sk_err)
 		goto out_error;
 
+	seq_skb = kcm->seq_skb;
 	if (kcm->seq_skb) {
 		/* Previously opened message */
 		head = kcm->seq_skb;
@@ -888,6 +889,8 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		err = sk_stream_wait_memory(sk, &timeo);
 		if (err)
 			goto out_error;
+		if (seq_skb && seq_skb != kcm->seq_skb)
+			goto out_stolen;
 	}
 
 	if (eor) {
@@ -943,7 +946,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		kfree_skb(head);
 		kcm->seq_skb = NULL;
 	}
-
+out_stolen:
 	err = sk_stream_error(sk, msg->msg_flags, err);
 
 	/* make sure we wake any epoll edge trigger waiter */
---8<---

