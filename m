Return-Path: <netdev+bounces-100261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 205338D8540
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 16:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF7B28C7DB
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2575D12F596;
	Mon,  3 Jun 2024 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vpwb6D0H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715D2130499
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425496; cv=none; b=TmuEt1j9talaTLrAEx+bPIOpv8G9VHnyWybfra3lRjrEkCX6YLHBEVjHvlhK++Sx5aIwafAyIW+Qs6Q3no+cTri9r/ZZ+v+ZvDdC33nXNTZg7rjhtikFcrZeN7D5sAzrBfNd55cPLhYinSuL1eUfEvCtfzca6pZGSxsuAd+i1hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425496; c=relaxed/simple;
	bh=zCcZQny335eyC82Pw5fvUrk9Td5ZV7WMLLx/I3LpNog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ERF46PBRgee6NrThyp7SjLka7NhtXaD9J48Hp90yGA9Ri1r+HDSfb2xJcv1DqKZpGVV/BKb+4IAMELe5mXkYb8OEwW0yTWopYrHBrl5ZIKTpYVqGaVGXxx+mTeWSDQ0jpuG+5JJMixgMmA4c7Xy+qVxwr+cYppBJZEDzSchKfXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vpwb6D0H; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717425494; x=1748961494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0nNZJ4eH+3T6uV/CWkIdgKt3R4g8iP9XHcRUeTJtgIs=;
  b=vpwb6D0H/WbFgSHn9pq+SXieJz+WdOGqGnSpgl0zPj9cGsyk2SpMSD3E
   dx8r71JnbaMXB8nCQ3qGKjv0p9VveJ1nWgnkPHpHaASmx//ZZNtIDQ780
   Nzli56fS/dyKxDcT3xDhbAaPpE35qrnSrCWT6+fFywvYlRpMlUWSjoqFZ
   A=;
X-IronPort-AV: E=Sophos;i="6.08,211,1712620800"; 
   d="scan'208";a="410860614"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:38:11 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:4411]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.175:2525] with esmtp (Farcaster)
 id 1aa4cefc-ab8b-4ed5-8590-70ad423172db; Mon, 3 Jun 2024 14:38:11 +0000 (UTC)
X-Farcaster-Flow-ID: 1aa4cefc-ab8b-4ed5-8590-70ad423172db
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 3 Jun 2024 14:38:10 +0000
Received: from 88665a182662.ant.amazon.com (10.88.143.104) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 3 Jun 2024 14:38:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 13/15] af_unix: Use skb_queue_empty_lockless() in unix_release_sock().
Date: Mon, 3 Jun 2024 07:32:29 -0700
Message-ID: <20240603143231.62085-14-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240603143231.62085-1-kuniyu@amazon.com>
References: <20240603143231.62085-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

If the socket type is SOCK_STREAM or SOCK_SEQPACKET, unix_release_sock()
checks the length of the peer socket's recvq under unix_state_lock().

However, unix_stream_read_generic() calls skb_unlink() after releasing
the lock.  Also, for SOCK_SEQPACKET, __skb_try_recv_datagram() unlinks
skb without unix_state_lock().

Thues, unix_state_lock() does not protect qlen.

Let's use skb_queue_empty_lockless() in unix_release_sock().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 88cda8af30d4..0c49c34551e6 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -631,7 +631,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 			unix_state_lock(skpair);
 			/* No more writes */
 			WRITE_ONCE(skpair->sk_shutdown, SHUTDOWN_MASK);
-			if (!skb_queue_empty(&sk->sk_receive_queue) || embrion)
+			if (!skb_queue_empty_lockless(&sk->sk_receive_queue) || embrion)
 				WRITE_ONCE(skpair->sk_err, ECONNRESET);
 			unix_state_unlock(skpair);
 			skpair->sk_state_change(skpair);
-- 
2.30.2


