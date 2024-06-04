Return-Path: <netdev+bounces-100701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EDD8FB9AD
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 18:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5E71F22456
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CEF1494A4;
	Tue,  4 Jun 2024 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HylqUs3w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E24C2AF16
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520290; cv=none; b=MwqEjmIZWOdOK38hmkf38awUeICnTboiLX1DxL/+Gspr1l9jKupm8PoetIziyL+hZ3jzrqgF2wMXvbXkofyPXo6y4PTOerAKhzySeNwUPgaBwCBcpOZsCW46n/x4BYYf4d0LRt5eSzOrYBCUc6SyP60lkuqmDvb3yYtNFNDAMOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520290; c=relaxed/simple;
	bh=4KWbyu4XWySsycT7NwWuPqAig6qXzaWuni2pmmvvPPg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cki5JIAOWTIfDGxX7w6Xbxb3a4thybw8FE1S0JEWgTbw+/RLqKkyQiHShU8+gqJjq6vmu8veNKfytt7mn1gxCCy7T6/eNA51DXeksBjREwCwKqqoPko7O2hzPAOLAjawUlavgNBJGF322Ve3+PhzIMStVdyovUQd+KvbEZxH8mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HylqUs3w; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717520289; x=1749056289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hoILfu+fUXVfSIT2sJ+jaydXQsxXBzOJVYT3CQNtD94=;
  b=HylqUs3wo689G2QxXHLIDL6bO3Eq+HcAFH3X8glbxW8goB1JkpFCxqTp
   1YND5j8542IX4s0NCxv9KE8DitVZr4CNpGHPhYnLZYzwMEZZcSviiH29a
   VtjFsrOj+IAL1aagPKfqWpIq9hPN/52VaBZ0//CgS81b77zTTua95qu1C
   o=;
X-IronPort-AV: E=Sophos;i="6.08,214,1712620800"; 
   d="scan'208";a="299735179"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 16:58:08 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:39971]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.63:2525] with esmtp (Farcaster)
 id ed03b99e-ac45-472e-8710-a7e8438d569b; Tue, 4 Jun 2024 16:58:07 +0000 (UTC)
X-Farcaster-Flow-ID: ed03b99e-ac45-472e-8710-a7e8438d569b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 4 Jun 2024 16:58:07 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 4 Jun 2024 16:58:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 13/15] af_unix: Use skb_queue_empty_lockless() in unix_release_sock().
Date: Tue, 4 Jun 2024 09:52:39 -0700
Message-ID: <20240604165241.44758-14-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
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
index eb3ba3448ed3..80846279de9f 100644
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


