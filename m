Return-Path: <netdev+bounces-105471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5355D911530
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 23:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6617B20AF1
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 21:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029327E107;
	Thu, 20 Jun 2024 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BG9nirxj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C7E59148
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718920591; cv=none; b=tNyJ6/jTOPpGKzDfJazhGj+IXAKjvy9ERsOMLFEVpJ8bdjGEaxuHSDWeg5JBmYtXLk8jhJsCj+aObE4WVACmjIvF8RL819i/am0TH06IVjvOIxcpZp4xH01nqBesaid+Dc1JUqLTeu/+58cvfhvvoODdObcswhv4Ts5+6thZmCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718920591; c=relaxed/simple;
	bh=qKhJBX/BtRyi65D2ZuVq8rZkDyU22r8/pcXDJNxGpkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzSIP/KRk5PfVI09Jsdm7p8Gp6JGoUBgxsvsamFZF0hsnzlFcSzZanW78JM8bKf9g1PxLeLV2iGGB9owYLH68FX7uwhqDxrBdaffoDAUFV6Z1Kh9Tk8girjPIbpGw4am/FBpWGeoq6/WqVD/7RqLGEoFaNDWBZQ2qog7Iju+CbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BG9nirxj; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718920591; x=1750456591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y6z0qCNYxhDWMtwZY6M3tKIAReDAKXeMyRgKTgq/p+s=;
  b=BG9nirxjQo0ttih2VNq+diE+BIrtnY44QrIkoHdXdbdvgbFd/QrLlzHa
   dKhhLcSOtGsDT0hzkyO3ZpDVR8eqKO0Wi5LULMxM5wBsZUl52BryQsWJs
   9VzoE0vM4LBg/rioPnvOXcFapndEhz839MQnhf/1QDqz4tTuUKNWFGnaV
   o=;
X-IronPort-AV: E=Sophos;i="6.08,252,1712620800"; 
   d="scan'208";a="303646017"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 21:56:28 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:48043]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.208:2525] with esmtp (Farcaster)
 id b13ad04a-4411-4022-bb5d-57d8d1a77309; Thu, 20 Jun 2024 21:56:28 +0000 (UTC)
X-Farcaster-Flow-ID: b13ad04a-4411-4022-bb5d-57d8d1a77309
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 21:56:27 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 21:56:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <cong.wang@bytedance.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net 01/15] af_unix: Set sk->sk_state under unix_state_lock() for truly disconencted peer.
Date: Thu, 20 Jun 2024 14:56:16 -0700
Message-ID: <20240620215616.64048-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <b29d7ead-6e2c-4a52-9a0a-56892e0015b6@rbox.co>
References: <b29d7ead-6e2c-4a52-9a0a-56892e0015b6@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 20 Jun 2024 22:35:55 +0200
> In fact, should I try to document those not-so-obvious OOB/sockmap
> interaction? And speaking of documentation, an astute reader noted that
> `man unix` is lying:

At least I wouldn't update man until we can say AF_UNIX MSG_OOB handling
is stable enough; the behaviour is not compliant with TCP now.

While rewriting the oob test thoroughly, I found few more weird behaviours,
and patches will follow.

For example:

  >>> from socket import *
  >>> c1, c2 = socketpair(AF_UNIX)
  >>> c1.send(b'hello', MSG_OOB)
  5
  >>> c1.send(b'world')
  5
  >>> c2.recv(10)
  b'hell'
  >>> c2.recv(1, MSG_OOB)
  b'o'
  >>> c2.setblocking(False)  # This causes -EAGAIN even with available data
  >>> c2.recv(5)
  Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
  BlockingIOError: [Errno 11] Resource temporarily unavailable
  >>> c2.recv(5)
  b'world'


And we need

---8<---
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 5e695a9a609c..2875a7ce1887 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2614,9 +2614,20 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 	struct unix_sock *u = unix_sk(sk);
 
 	if (!unix_skb_len(skb) && !(flags & MSG_PEEK)) {
-		skb_unlink(skb, &sk->sk_receive_queue);
-		consume_skb(skb);
-		skb = NULL;
+		struct sk_buff *unlinked_skb = skb;
+
+		spin_lock(&sk->sk_receive_queue.lock);
+
+		__skb_unlink(skb, &sk->sk_receive_queue);
+
+		if (copied)
+			skb = NULL;
+		else
+			skb = skb_peek(&sk->sk_receive_queue);
+
+		spin_unlock(&sk->sk_receive_queue.lock);
+
+		consume_skb(unlinked_skb);
 	} else {
 		struct sk_buff *unlinked_skb = NULL;
 
---8<---

