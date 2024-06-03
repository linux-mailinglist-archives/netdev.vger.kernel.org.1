Return-Path: <netdev+bounces-100255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C4D8D8531
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 16:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FBE1C21175
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB17712EBF2;
	Mon,  3 Jun 2024 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PNhxDhWx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD3712EBE6
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425349; cv=none; b=iap+Rs7glffWRgkyiKSmQaaxJGMMWUEV8MuuptjrBGJ5rNm7QKW/WhaOE9M8lt778yhnMfVybWVS1oimmidRQ1AXwUXyi7KnNdDBk6ohpUyd5FDSsU24FNXiTorqMWN6WVSUcbk9UG0bwWdxeIKLDTgp37181x10kR+L5NUxNak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425349; c=relaxed/simple;
	bh=B76CKU1lQ5Czd4UI1SqB7FGR9kGPA2gU7mEDnMblhkE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChqBHqsh4sY96LHQhkM9MlJ07mDom8O6Lu5zPVftVk0BzIk8wZy9TO+6LbsS+y0qr8YGmnLCS1Lbw3IZMQ8M78EEdc6jXo5JY08yefFMjdeAOOylIDiIYNlbCKuo37WVbcHEKwYFFbFa/tMq7QiAuqaRbeqCg8OztIjilxV+hlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PNhxDhWx; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717425349; x=1748961349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D65kuSr3YvrK7OX1LTahqYqjFgo4a9LG0qpz+A/RhYw=;
  b=PNhxDhWxpj2UGR0ffV3RT7Ccxt8QV/dm8bt48ATdjEep7mpn6y8DgOCN
   wYBHkdW484UA75x+H8uWuGmDPxt2SxvBfBp/BVXrUVGwKfYVBUv1L48Hm
   97sxewcckm+npwfjPngM/wxZ1InZdgJzB/7bJQFcqPV4oJX4Z4JFaG4gB
   M=;
X-IronPort-AV: E=Sophos;i="6.08,211,1712620800"; 
   d="scan'208";a="209223327"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:35:46 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:13248]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.28:2525] with esmtp (Farcaster)
 id 241909f8-17c9-4751-90d9-8626adfc8a59; Mon, 3 Jun 2024 14:35:44 +0000 (UTC)
X-Farcaster-Flow-ID: 241909f8-17c9-4751-90d9-8626adfc8a59
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 3 Jun 2024 14:35:44 +0000
Received: from 88665a182662.ant.amazon.com (10.88.143.104) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 3 Jun 2024 14:35:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 07/15] af_unix: Annotate data-races around sk->sk_state in sendmsg() and recvmsg().
Date: Mon, 3 Jun 2024 07:32:23 -0700
Message-ID: <20240603143231.62085-8-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D043UWC002.ant.amazon.com (10.13.139.222) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The following functions read sk->sk_state locklessly and proceed only if
the state is TCP_ESTABLISHED.

  * unix_stream_sendmsg
  * unix_stream_read_generic
  * unix_seqpacket_sendmsg
  * unix_seqpacket_recvmsg

Let's use READ_ONCE() there.

Fixes: a05d2ad1c1f3 ("af_unix: Only allow recv on connected seqpacket sockets.")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index a97f4305b74f..43605bed0ef7 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2226,7 +2226,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 	}
 
 	if (msg->msg_namelen) {
-		err = sk->sk_state == TCP_ESTABLISHED ? -EISCONN : -EOPNOTSUPP;
+		err = READ_ONCE(sk->sk_state) == TCP_ESTABLISHED ? -EISCONN : -EOPNOTSUPP;
 		goto out_err;
 	} else {
 		err = -ENOTCONN;
@@ -2340,7 +2340,7 @@ static int unix_seqpacket_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (err)
 		return err;
 
-	if (sk->sk_state != TCP_ESTABLISHED)
+	if (READ_ONCE(sk->sk_state) != TCP_ESTABLISHED)
 		return -ENOTCONN;
 
 	if (msg->msg_namelen)
@@ -2354,7 +2354,7 @@ static int unix_seqpacket_recvmsg(struct socket *sock, struct msghdr *msg,
 {
 	struct sock *sk = sock->sk;
 
-	if (sk->sk_state != TCP_ESTABLISHED)
+	if (READ_ONCE(sk->sk_state) != TCP_ESTABLISHED)
 		return -ENOTCONN;
 
 	return unix_dgram_recvmsg(sock, msg, size, flags);
@@ -2683,7 +2683,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 	size_t size = state->size;
 	unsigned int last_len;
 
-	if (unlikely(sk->sk_state != TCP_ESTABLISHED)) {
+	if (unlikely(READ_ONCE(sk->sk_state) != TCP_ESTABLISHED)) {
 		err = -EINVAL;
 		goto out;
 	}
-- 
2.30.2


