Return-Path: <netdev+bounces-157495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EC1A0A725
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 05:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BA81885F5C
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 04:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF3020322;
	Sun, 12 Jan 2025 04:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FOl16amd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408E31E517
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 04:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736655093; cv=none; b=p2pevkd69dxRpNPiSQp4hXf1KyJ473xhnEJCAiG/Euobj1EX0nRWOU7M3FFDGuni1psr+moJo21vdQQGfjPBe4sSz3BSw400ghJzIWkhlOq0Jpb3ZVxBLWYCDin9BVlibFtQqcGydBOoHOTMELv9xOp7nvjYX48HYYjGYzJbFUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736655093; c=relaxed/simple;
	bh=2SuYl/RkIG9m7kBqVOcg1il7berthmOidtFyNdy2WD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eEl4ehqbwYYAUVb3RS+Wyhlf3bPBIQwc5Y69j655ohGcexjfvM6B11xTZHiw3I+g/LOjy2vyjWnJX5p3KbDGzfdlHWNIJIdc8ga9MmuoOcW1WO48/HHfNKiK9qaaG1ixIHpE6pV1xqg1Qznfny3vORyz6yViYCOW/ss8BHyKVCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FOl16amd; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736655093; x=1768191093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gxm8kJ8emMVLkb2JWLuQNUyltOYqXwlla4FGOtfGA2A=;
  b=FOl16amdEWnIKIPf3e59Mp/NVoTlyieO9R57ecgZa99sqkp3kamr65Bm
   SoegFHHubeBeXywqHiimm5ETTBhgynVDEJsv7jOJHWkgJktdX7XfNZWRS
   p6V9kgr7rs5+6c/vNamuEwAA9gARc9sI75kHSZ4uXgEq7TrIHMLrVd10E
   s=;
X-IronPort-AV: E=Sophos;i="6.12,308,1728950400"; 
   d="scan'208";a="790432459"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 04:11:32 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:49157]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.114:2525] with esmtp (Farcaster)
 id 199b919c-2447-47dd-bedd-619ec1c9acd1; Sun, 12 Jan 2025 04:11:31 +0000 (UTC)
X-Farcaster-Flow-ID: 199b919c-2447-47dd-bedd-619ec1c9acd1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 12 Jan 2025 04:11:31 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.156) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 12 Jan 2025 04:11:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 07/11] af_unix: Set drop reason in queue_oob().
Date: Sun, 12 Jan 2025 13:08:06 +0900
Message-ID: <20250112040810.14145-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250112040810.14145-1-kuniyu@amazon.com>
References: <20250112040810.14145-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

sendmsg(MSG_OOB) to a SOCK_STREAM socket could fail for various
reasons.

Let's set drop reasons respectively.

The drop reasons are exactly the same as in the previous patch.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 8c8d8fc3cb94..8623e3368c45 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2216,34 +2216,37 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
 		     struct scm_cookie *scm, bool fds_sent)
 {
 	struct unix_sock *ousk = unix_sk(other);
+	enum skb_drop_reason reason;
 	struct sk_buff *skb;
-	int err = 0;
+	int err;
 
 	skb = sock_alloc_send_skb(sock->sk, 1, msg->msg_flags & MSG_DONTWAIT, &err);
-
 	if (!skb)
-		return err;
+		goto out;
 
 	err = unix_scm_to_skb(scm, skb, !fds_sent);
 	if (err < 0) {
-		kfree_skb(skb);
-		return err;
+		reason = unix_scm_err_to_reason(err);
+		goto out_free;
 	}
+
 	skb_put(skb, 1);
 	err = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, 1);
-
 	if (err) {
-		kfree_skb(skb);
-		return err;
+		reason = SKB_DROP_REASON_SKB_UCOPY_FAULT;
+		goto out_free;
 	}
 
 	unix_state_lock(other);
 
-	if (sock_flag(other, SOCK_DEAD) ||
-	    (other->sk_shutdown & RCV_SHUTDOWN)) {
-		unix_state_unlock(other);
-		kfree_skb(skb);
-		return -EPIPE;
+	if (sock_flag(other, SOCK_DEAD)) {
+		reason = SKB_DROP_REASON_SOCKET_CLOSE;
+		goto out_unlock;
+	}
+
+	if (other->sk_shutdown & RCV_SHUTDOWN) {
+		reason = SKB_DROP_REASON_SOCKET_RCV_SHUTDOWN;
+		goto out_unlock;
 	}
 
 	maybe_add_creds(skb, sock, other);
@@ -2258,6 +2261,14 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
 	unix_state_unlock(other);
 	other->sk_data_ready(other);
 
+	return 0;
+
+out_unlock:
+	unix_state_unlock(other);
+	err = -EPIPE;
+out_free:
+	kfree_skb_reason(skb, reason);
+out:
 	return err;
 }
 #endif
-- 
2.39.5 (Apple Git-154)


