Return-Path: <netdev+bounces-99477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB6B8D5001
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CDF1C20D0C
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17E323741;
	Thu, 30 May 2024 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="blNjvEEK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548E422EF0
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717087399; cv=none; b=KZrNEumN0j3fTUeQKU36k0Y138hesdMXIkl8xYJXO1Y9pCtG/seWl+eQLuQCkW35CKEV57kClKfb3gF4fs4VAwwxDM8oVvRUoj1p0HKGG1NlI1D6SmfzhmmdyUDhkICfpGqyqPnGlr9w4jdV1E3bn2DT/7+1ntxhTODXzND/XtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717087399; c=relaxed/simple;
	bh=8yVE5Ju3UvH7bIY9DAfoleFC5+dHH+egQht1QL4jAiE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p+AVSnEUx9Hlt455d2127GbmbUnrj5GaiDaDl6z2QQzxC33w1xbyTQcMnf2qFGu/SvhY5A3pPrnwvLY7I73Mg9AiVsUhlBrZsjm9ivKJf6o9w7awl87ug9+FodwdWsmdztD7SggWwBBUb/G+4LGWYKxTSnb3TxMntOLFmteqrhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=blNjvEEK; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717087398; x=1748623398;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9Ni7hx70Ikzbzb0f1Uh0LjhdiWDPiS0iWVUEr5u9O5o=;
  b=blNjvEEK6QxhfRRt9EvtKv/kc7IAgEDMW5A2uCHQ2FSv+KGR5OlIRo0b
   JHa6P0Zya8jjqvxQ7h9JajiLm936aNhOFygdf4KDVEdN22mLICZnzfI8O
   eGUBKU7lNn5r7/P/oE/ag2eKGPTbRKtHoRZReQfwGaWl7d7foJ7oww8Di
   Q=;
X-IronPort-AV: E=Sophos;i="6.08,202,1712620800"; 
   d="scan'208";a="729395992"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 16:43:10 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:58435]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.188:2525] with esmtp (Farcaster)
 id fc3a4c12-019a-4229-a72a-918fc74f59d8; Thu, 30 May 2024 16:43:09 +0000 (UTC)
X-Farcaster-Flow-ID: fc3a4c12-019a-4229-a72a-918fc74f59d8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 30 May 2024 16:43:09 +0000
Received: from 88665a182662.ant.amazon.com.com (10.88.142.126) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 30 May 2024 16:43:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next] af_unix: Don't check last_len in unix_stream_data_wait().
Date: Thu, 30 May 2024 09:42:56 -0700
Message-ID: <20240530164256.40223-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA004.ant.amazon.com (10.13.139.68) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When commit 869e7c62486e ("net: af_unix: implement stream sendpage
support") added sendpage() support, data could be appended to the last
skb in the receiver's queue.

That's why we needed to check if the length of the last skb was changed
while waiting for new data in unix_stream_data_wait().

However, commit a0dbf5f818f9 ("af_unix: Support MSG_SPLICE_PAGES") and
commit 57d44a354a43 ("unix: Convert unix_stream_sendpage() to use
MSG_SPLICE_PAGES") refactored sendmsg(), and now data is always added
to a new skb.

Now we no longer need to check the length of the last skb, so let's
remove the dead logic in unix_stream_data_wait().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e4af6616e1df..6b710043dd41 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2505,11 +2505,9 @@ static int unix_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
  *	Sleep until more data has arrived. But check for races..
  */
 static long unix_stream_data_wait(struct sock *sk, long timeo,
-				  struct sk_buff *last, unsigned int last_len,
-				  bool freezable)
+				  struct sk_buff *last, bool freezable)
 {
 	unsigned int state = TASK_INTERRUPTIBLE | freezable * TASK_FREEZABLE;
-	struct sk_buff *tail;
 	DEFINE_WAIT(wait);
 
 	unix_state_lock(sk);
@@ -2517,9 +2515,7 @@ static long unix_stream_data_wait(struct sock *sk, long timeo,
 	for (;;) {
 		prepare_to_wait(sk_sleep(sk), &wait, state);
 
-		tail = skb_peek_tail(&sk->sk_receive_queue);
-		if (tail != last ||
-		    (tail && tail->len != last_len) ||
+		if (skb_peek_tail(&sk->sk_receive_queue) != last ||
 		    sk->sk_err ||
 		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
 		    signal_pending(current) ||
@@ -2671,7 +2667,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 	long timeo;
 	int skip;
 	size_t size = state->size;
-	unsigned int last_len;
 
 	if (unlikely(sk->sk_state != TCP_ESTABLISHED)) {
 		err = -EINVAL;
@@ -2710,7 +2705,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 			goto unlock;
 		}
 		last = skb = skb_peek(&sk->sk_receive_queue);
-		last_len = last ? last->len : 0;
 
 again:
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
@@ -2744,8 +2738,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 			mutex_unlock(&u->iolock);
 
-			timeo = unix_stream_data_wait(sk, timeo, last,
-						      last_len, freezable);
+			timeo = unix_stream_data_wait(sk, timeo, last, freezable);
 
 			if (signal_pending(current)) {
 				err = sock_intr_errno(timeo);
@@ -2763,7 +2756,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 		while (skip >= unix_skb_len(skb)) {
 			skip -= unix_skb_len(skb);
 			last = skb;
-			last_len = skb->len;
+
 			skb = skb_peek_next(skb, &sk->sk_receive_queue);
 			if (!skb)
 				goto again;
@@ -2854,7 +2847,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 			skip = 0;
 			last = skb;
-			last_len = skb->len;
+
 			unix_state_lock(sk);
 			skb = skb_peek_next(skb, &sk->sk_receive_queue);
 			if (skb)
-- 
2.30.2


