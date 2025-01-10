Return-Path: <netdev+bounces-157026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A90A08C00
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1264188C373
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E4020ADF1;
	Fri, 10 Jan 2025 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jNgqdVhi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2F320ADE3
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501306; cv=none; b=cENPyfkuVP1nynN/2czDdWWmCIJd4+F8TtGtCIHOMSqstOCB6sqYliHzWIal1PE4wT6MY0JbeO5MEPlUA1XXcdrG/xf8NZhvnXNFdXXXD82SxUJ8PjP9dCi7THzMmTfFgALlRX8BnBvQCz3xNYaMOnh7t+G+jF2YDNA9VdaJ8W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501306; c=relaxed/simple;
	bh=YBFNC/z40WX/1GOmQ+b5h9+ml+NEtHp1K3eBSwvEhUM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F26Q6JzsDQNPiChU0X7Cs5beUcuP6jWof5Xv249tLMSSZL4fGwxrILRGBJaVVdUOrX2ki964QTg9XeQUYT5BEf2ntvVjOlX6v68z4kukCMNXNfvIyhvM5IN+nm9WXsSIrsnm2o4kxTybdOMhB3Yjt49wf9ZKsiGn/ZKqFXfmWI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jNgqdVhi; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736501305; x=1768037305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EEYrvzro4pXAy2ePhNFvASRwMz4gzEE3m8pZiNb4R4A=;
  b=jNgqdVhiD3wXVj28dCKjyAySyxooX+2QEN/oeRKdRTeOyYulHkl3pW3b
   tMLSsGY8HJDrp6ltFlZOh6hUf9369SyESvaTcWC+09bUACIRqsEZL6UXT
   n2axnqjvXs3U4jjXIkDeAOhl9kBR1I5/ZavikM3c8rbY/ODzsA4xMra2v
   s=;
X-IronPort-AV: E=Sophos;i="6.12,303,1728950400"; 
   d="scan'208";a="262089466"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 09:28:17 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:46917]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.114:2525] with esmtp (Farcaster)
 id d820f865-e127-42f2-8c40-b572352c0d3d; Fri, 10 Jan 2025 09:28:17 +0000 (UTC)
X-Farcaster-Flow-ID: d820f865-e127-42f2-8c40-b572352c0d3d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 09:28:16 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.252.101) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 09:28:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 03/12] af_unix: Set drop reason in unix_sock_destructor().
Date: Fri, 10 Jan 2025 18:26:32 +0900
Message-ID: <20250110092641.85905-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250110092641.85905-1-kuniyu@amazon.com>
References: <20250110092641.85905-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

unix_sock_destructor() is called as sk->sk_destruct just before
the socket is actually freed.

Let's use SKB_DROP_REASON_SOCKET_CLOSE for skb_queue_purge().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index a05d25cc5545..41b99984008a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -640,7 +640,7 @@ static void unix_sock_destructor(struct sock *sk)
 {
 	struct unix_sock *u = unix_sk(sk);
 
-	skb_queue_purge(&sk->sk_receive_queue);
+	skb_queue_purge_reason(&sk->sk_receive_queue, SKB_DROP_REASON_SOCKET_CLOSE);
 
 	DEBUG_NET_WARN_ON_ONCE(refcount_read(&sk->sk_wmem_alloc));
 	DEBUG_NET_WARN_ON_ONCE(!sk_unhashed(sk));
-- 
2.39.5 (Apple Git-154)


