Return-Path: <netdev+bounces-157033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68261A08C13
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92EC77A38B2
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2EC20B1EE;
	Fri, 10 Jan 2025 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pQ0VOrFi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B137E20A5FD
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501439; cv=none; b=kMVBmq2FFveCFeE968c4RnoPqOlKcW98AS2RLxKa957UfXFDOVTzTq6VlBZCBf29HjXxSuxwM90bgVQpFUr34MGKmT6LD4OS1GGZ3i47LFGo380zWHvv1mz27j1Prt/gPC/XK84ZxRU71TVf11ZYrOn1i2jFVRxpLsLSNFoOong=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501439; c=relaxed/simple;
	bh=VDmivZ+wboA3DQxaMNav2Fu92+VG28LycmwI/CMxZjc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDafxEnw5ltNaDktC5pcJxybGV3/bM6h1Gv6MeVr3nHfvsjrujjZiIG0oWWiROnYOEFLq67xNmJ7S/nG36qFP/u+XONUqy+NeV1dAybmk7uRy4aRBUrrkyz6JrCrezrtrihD4ojI8pM3whvynXlMa2BdR2oxO6hmu4F8h8RUfwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=pQ0VOrFi; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736501438; x=1768037438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PAtZfotiwh0ZHqfa311ORPKXAGdnsz7bqubfYRwOQNU=;
  b=pQ0VOrFiMTriL6vj7atdCNpKyfJuw65/VQT+lxBMNnhmpZUCcLFcDmKY
   NPzV0GCEhe/BaRhf3ac3R93RLMWktZyOn/Spo3NeP77To5iLG2XSh95ak
   Fc/JUSdW9PJBgriVJ6xHDwmK2GDrRcP4vPhYcPvsBbyNc5Lj8xoClJlvi
   k=;
X-IronPort-AV: E=Sophos;i="6.12,303,1728950400"; 
   d="scan'208";a="485019655"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 09:30:32 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:47667]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.17:2525] with esmtp (Farcaster)
 id 57fc1d94-4316-481b-ba0c-4f9dbe4ee329; Fri, 10 Jan 2025 09:30:31 +0000 (UTC)
X-Farcaster-Flow-ID: 57fc1d94-4316-481b-ba0c-4f9dbe4ee329
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 09:30:31 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.252.101) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 09:30:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 08/12] af_unix: Set drop reason in queue_oob().
Date: Fri, 10 Jan 2025 18:26:37 +0900
Message-ID: <20250110092641.85905-9-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
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
index 17b9e9bce055..1dfe791e8991 100644
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


