Return-Path: <netdev+bounces-100696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3D58FB9A3
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 18:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F1C1C219C4
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83703149001;
	Tue,  4 Jun 2024 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ij9Fn4N5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E242AF16
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520172; cv=none; b=aww3lGkke7jGKlEntnsfvq2DDjKMpNlDQsNa3WrUFlJyi6/LHWi8/+NnIDdVQsQdB5c+uBcneQmBccx9U2xwdCFcPG6j53PYgUUlQ1TEVgC7O+AMK+hVgeFfNxa488Z9/cZ7mA5wFNrQ8AJc8etNyHrj7dT8KGWLh2iTdg+GyAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520172; c=relaxed/simple;
	bh=1JoR++kFFnEw5BzWaUSyvtoqA6m+wCfje28Y+xcutKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g4GLwO+h+qWlFTP7wGPLtjhHkEoH9Q/1BS3TYBuR+91B+aCCzqSeXzzlLcvbUf98wqXk1teJIbrwckqtoNHyhWLa2AdlEEsOrchIIlas4RNFCs/gXOLi7f96jtPiRqx6Hpb9U1Kp1AZ2avanJXHaoOgTq9zH1BPoSZTk7eyW9BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ij9Fn4N5; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717520172; x=1749056172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qs64HYU1HYnpKh4cUSPHsfuyIkN8My/ViozmWKS2G1I=;
  b=ij9Fn4N5mUT62vNoM6y6tttV47lHd5PvGuP8gKpoCNBxX6jxBZupttsG
   9jjLl9a0O19UP5eaLSxhL2/hkYjOd/f7eNZq3G+XXhcmFOIMs301nQIcI
   mJvdkTS+dD38MYRLlQED6V5JzqWDjKc1yhEVYsC0mc7r+7nnYgzpOkI1d
   Q=;
X-IronPort-AV: E=Sophos;i="6.08,214,1712620800"; 
   d="scan'208";a="300895397"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 16:56:08 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:31395]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.106:2525] with esmtp (Farcaster)
 id 70138a48-49b6-4c8d-a121-0b1df45d10a6; Tue, 4 Jun 2024 16:56:07 +0000 (UTC)
X-Farcaster-Flow-ID: 70138a48-49b6-4c8d-a121-0b1df45d10a6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 4 Jun 2024 16:56:07 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 4 Jun 2024 16:56:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 08/15] af_unix: Annotate data-race of sk->sk_state in unix_stream_read_skb().
Date: Tue, 4 Jun 2024 09:52:34 -0700
Message-ID: <20240604165241.44758-9-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240604165241.44758-1-kuniyu@amazon.com>
References: <20240604165241.44758-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA003.ant.amazon.com (10.13.139.37) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

unix_stream_read_skb() is called from sk->sk_data_ready() context
where unix_state_lock() is not held.

Let's use READ_ONCE() there.

Fixes: 77462de14a43 ("af_unix: Add read_sock for stream socket types")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 4ef9c21783a5..e7b74207aa3b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2659,7 +2659,7 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 
 static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
-	if (unlikely(sk->sk_state != TCP_ESTABLISHED))
+	if (unlikely(READ_ONCE(sk->sk_state) != TCP_ESTABLISHED))
 		return -ENOTCONN;
 
 	return unix_read_skb(sk, recv_actor);
-- 
2.30.2


