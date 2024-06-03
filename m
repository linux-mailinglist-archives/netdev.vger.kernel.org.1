Return-Path: <netdev+bounces-100253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 104618D8527
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 16:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C607B20C61
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B402512E1ED;
	Mon,  3 Jun 2024 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="upGNho6Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412E412BF34
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425305; cv=none; b=mhUgPQcbmdgGDWWqTNEatfIMBMWawLy3U+9ONILPFIGLBSaHn3UhVxnxrdjYdDhAlTqmP8AudZNvPZ8BJt3zNT0zKrgO5uaFkAIUvPamTnLYS7REJginT6xuCzZG80giwXVs9JlejGtINVxfF6gEs/6M+v99ryye2kM2PslEEPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425305; c=relaxed/simple;
	bh=2tFy3C699sKAa+9ZHwDsZTWxinhQNFcBT4f1/rY7vtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6jxva/dnzhhBEiJGT/Pss1+9B32JPMkFXwNDa1wQNWgM9ZfZEmTMOyc8TJ2ZAiVSQBtFjJNZ7fJ6SiknWgtgJbojiExNvziV4UCoDbnMFYR39/af3iN6V70oV4Hdtqw77L8Nn6DLkUgpWileY/MHeZ2ayRuLGw1mnZgwH0Jb6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=upGNho6Q; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717425305; x=1748961305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OqN8vlegB38hUDsFuCQZwUJx2A3nwIn+YNZR7eJYMnI=;
  b=upGNho6QlYMXLVTohVq460whM/T7l/Zt2GBBYSLY/ivxj1/PfUo77tjX
   gb73hyTw09Lh0ykhLc6zC5FH9NB7i164Nj2D3UjSu23d5K+D8OmWyh+h2
   fbAx8OeG5hNH5iuxpJlKk5xYJ/20hdKDWpg6LKR6yy8MROu/K2LpCgREI
   I=;
X-IronPort-AV: E=Sophos;i="6.08,211,1712620800"; 
   d="scan'208";a="730093544"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:34:58 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:22470]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.254:2525] with esmtp (Farcaster)
 id 1ce82f12-7c09-4de4-8e54-463faf642c04; Mon, 3 Jun 2024 14:34:57 +0000 (UTC)
X-Farcaster-Flow-ID: 1ce82f12-7c09-4de4-8e54-463faf642c04
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 3 Jun 2024 14:34:56 +0000
Received: from 88665a182662.ant.amazon.com (10.88.143.104) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 3 Jun 2024 14:34:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 05/15] af_unix: Annotate data-race of sk->sk_state in unix_stream_connect().
Date: Mon, 3 Jun 2024 07:32:21 -0700
Message-ID: <20240603143231.62085-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

As small optimisation, unix_stream_connect() prefetches the client's
sk->sk_state without unix_state_lock() and checks if it's TCP_CLOSE.

Later, sk->sk_state is checked again under unix_state_lock().

Let's use READ_ONCE() for the first check and TCP_CLOSE directly for
the second check.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e7a756e8711d..c01ca584a014 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1481,7 +1481,6 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	struct sk_buff *skb = NULL;
 	long timeo;
 	int err;
-	int st;
 
 	err = unix_validate_addr(sunaddr, addr_len);
 	if (err)
@@ -1571,9 +1570,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 
 	   Well, and we have to recheck the state after socket locked.
 	 */
-	st = sk->sk_state;
-
-	switch (st) {
+	switch (READ_ONCE(sk->sk_state)) {
 	case TCP_CLOSE:
 		/* This is ok... continue with connect */
 		break;
@@ -1588,7 +1585,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 
 	unix_state_lock_nested(sk, U_LOCK_SECOND);
 
-	if (sk->sk_state != st) {
+	if (sk->sk_state != TCP_CLOSE) {
 		unix_state_unlock(sk);
 		unix_state_unlock(other);
 		sock_put(other);
-- 
2.30.2


