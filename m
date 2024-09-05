Return-Path: <netdev+bounces-125663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2AB96E343
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8DD71C23DFA
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 19:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEFC18D624;
	Thu,  5 Sep 2024 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Tw/lwHlm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23D14400
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725564809; cv=none; b=AIQqusF9rDxAZ3DP1axqRS2tQJxjTopgC3Uayh8prG19WDRbGJao+Xi1tOY5OQHR3zbWQgk1NcHGrsPlexYHI3nVrgnbLVbKUQr1KSfVIlyJeTfm/INs4prcBR9AmM3sfmTnxuDbEP3ixDqIlpokjqpM55wx+lXoHSj7LfYBCqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725564809; c=relaxed/simple;
	bh=zQZYY2WTi53SGHW3TQsIolzsvDovwwwrnpQ3P649sTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7p1S4Ux4Pxa+69wmM5Qi6tns2nNQD6GUuZF/gDuft8F7UexhTfsYAuUuIydfELD4KyzpsWZ80oTGuBuHt9CXgCx9jvmTuAmVHfT9XUMDbknT9MSBSO/+5LfSL4JeSZm904ZPN6b4XJcRvi6hkZEZ/3mRnTprbgE+gknGH/XsAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Tw/lwHlm; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725564808; x=1757100808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K7FJezi1N/fMoHD8ksbh6FhRTQbVZcwUxEc6HWTL3W0=;
  b=Tw/lwHlmRr+X5ngRAGHbgyky6E/DSWiADXACBOOZeDr6AhvF9iT+7YfJ
   XONbJKlzqWVmqnlD/UewC6WYoNVixPI6ssxU5CwFVxbGm9Je51jJExhXu
   koxWvPG9Pq+fzI+sTB/vkCaRHtvfwIy7+rGRdkNeUzmumyFDNAUc/xqWt
   M=;
X-IronPort-AV: E=Sophos;i="6.10,205,1719878400"; 
   d="scan'208";a="757043461"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 19:33:22 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:37501]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.191:2525] with esmtp (Farcaster)
 id e9d2f845-a03b-4251-920e-23da1d6139a6; Thu, 5 Sep 2024 19:33:21 +0000 (UTC)
X-Farcaster-Flow-ID: e9d2f845-a03b-4251-920e-23da1d6139a6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 5 Sep 2024 19:33:20 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 5 Sep 2024 19:33:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 1/4] af_unix: Remove single nest in manage_oob().
Date: Thu, 5 Sep 2024 12:32:37 -0700
Message-ID: <20240905193240.17565-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240905193240.17565-1-kuniyu@amazon.com>
References: <20240905193240.17565-1-kuniyu@amazon.com>
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

This is a prep for the later fix.

No functional change intended.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index a1894019ebd5..03820454bc72 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2654,11 +2654,10 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 				  int flags, int copied)
 {
+	struct sk_buff *unlinked_skb = NULL;
 	struct unix_sock *u = unix_sk(sk);
 
 	if (!unix_skb_len(skb)) {
-		struct sk_buff *unlinked_skb = NULL;
-
 		spin_lock(&sk->sk_receive_queue.lock);
 
 		if (copied && (!u->oob_skb || skb == u->oob_skb)) {
@@ -2674,31 +2673,33 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 		spin_unlock(&sk->sk_receive_queue.lock);
 
 		consume_skb(unlinked_skb);
-	} else {
-		struct sk_buff *unlinked_skb = NULL;
+		return skb;
+	}
 
-		spin_lock(&sk->sk_receive_queue.lock);
+	spin_lock(&sk->sk_receive_queue.lock);
 
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
-			}
-		}
+	if (skb != u->oob_skb)
+		goto unlock;
 
-		spin_unlock(&sk->sk_receive_queue.lock);
+	if (copied) {
+		skb = NULL;
+	} else if (!(flags & MSG_PEEK)) {
+		WRITE_ONCE(u->oob_skb, NULL);
 
-		kfree_skb(unlinked_skb);
+		if (!sock_flag(sk, SOCK_URGINLINE)) {
+			__skb_unlink(skb, &sk->sk_receive_queue);
+			unlinked_skb = skb;
+			skb = skb_peek(&sk->sk_receive_queue);
+		}
+	} else if (!sock_flag(sk, SOCK_URGINLINE)) {
+		skb = skb_peek_next(skb, &sk->sk_receive_queue);
 	}
+
+unlock:
+	spin_unlock(&sk->sk_receive_queue.lock);
+
+	kfree_skb(unlinked_skb);
+
 	return skb;
 }
 #endif
-- 
2.30.2


