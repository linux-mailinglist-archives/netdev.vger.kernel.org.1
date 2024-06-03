Return-Path: <netdev+bounces-100258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A4E8D853A
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 16:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4AF1C209CC
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079F112E1F9;
	Mon,  3 Jun 2024 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="p6T+0jgQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E12212BEBE
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425425; cv=none; b=CHQrXEu5SnbPZ4sugvBydjkSVgHgMxa3u+LM30LA976Zv5pVjdd+aTQn9QA4xF3f88+e7ShYDyvrHjytpI2WaCGSosFS1u0/oov6HjmtmWfQ9I1eE4nzJdmJGhhltbF2ZdGfGD2okaJ1AppYMhQgAb0rCix1QT1c//fpN8Vn+0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425425; c=relaxed/simple;
	bh=m5hoaRD9SeemXu6z3PYx9cgmpGzUpVQcNgCp7HD2uFo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=reRQp9SaM/R1cyVQIz3EDJcZmoqQWNCgFenRbG6GD26POlR9DYnH2ie8UyqTPoaPgg2EsC3zOsR+ZffHB5aqrGCLXa1TYdsvV8daCuB6o00Kzml6YK0Nl8eP182wo+NUhSLDGB/ykovmLGHKrQGML9yfD4YcKdr6m7Ktb4aGbCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=p6T+0jgQ; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717425424; x=1748961424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gOi6CzV1XRAoeFQ5kJ/ohtQ3Kn/EIt+Y7gk/Ut1ZYZ8=;
  b=p6T+0jgQKHUzxcbwFrPKq/HbDRiIhzHMlEwyUPf8Ovc9ixtJHig10b69
   pzQ83h67EWTXUEa2hXQZm3tg44hN3eOf2fp92OF5hkl8MR4t0O6dtuiip
   77sMzsOWPjyhRZzqjXeg4pqtBdcCuZgZ798Orf0+VOIiiIREAtc7cnWqi
   g=;
X-IronPort-AV: E=Sophos;i="6.08,211,1712620800"; 
   d="scan'208";a="423410085"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:36:57 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:20957]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.179:2525] with esmtp (Farcaster)
 id 38b162f4-5f8b-4d58-9dfe-74f39e4ef320; Mon, 3 Jun 2024 14:36:57 +0000 (UTC)
X-Farcaster-Flow-ID: 38b162f4-5f8b-4d58-9dfe-74f39e4ef320
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 3 Jun 2024 14:36:57 +0000
Received: from 88665a182662.ant.amazon.com (10.88.143.104) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 3 Jun 2024 14:36:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 10/15] af_unix: Annotate data-races around sk->sk_sndbuf.
Date: Mon, 3 Jun 2024 07:32:26 -0700
Message-ID: <20240603143231.62085-11-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

sk_setsockopt() changes sk->sk_sndbuf under lock_sock(), but it's
not used in af_unix.c.

Let's use READ_ONCE() to read sk->sk_sndbuf in unix_writable(),
unix_dgram_sendmsg(), and unix_stream_sendmsg().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 8eadc6464301..e99b94fc80b3 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -533,7 +533,7 @@ static int unix_dgram_peer_wake_me(struct sock *sk, struct sock *other)
 static int unix_writable(const struct sock *sk, unsigned char state)
 {
 	return state != TCP_LISTEN &&
-	       (refcount_read(&sk->sk_wmem_alloc) << 2) <= sk->sk_sndbuf;
+		(refcount_read(&sk->sk_wmem_alloc) << 2) <= READ_ONCE(sk->sk_sndbuf);
 }
 
 static void unix_write_space(struct sock *sk)
@@ -1967,7 +1967,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	}
 
 	err = -EMSGSIZE;
-	if (len > sk->sk_sndbuf - 32)
+	if (len > READ_ONCE(sk->sk_sndbuf) - 32)
 		goto out;
 
 	if (len > SKB_MAX_ALLOC) {
@@ -2247,7 +2247,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 						   &err, 0);
 		} else {
 			/* Keep two messages in the pipe so it schedules better */
-			size = min_t(int, size, (sk->sk_sndbuf >> 1) - 64);
+			size = min_t(int, size, (READ_ONCE(sk->sk_sndbuf) >> 1) - 64);
 
 			/* allow fallback to order-0 allocations */
 			size = min_t(int, size, SKB_MAX_HEAD(0) + UNIX_SKB_FRAGS_SZ);
-- 
2.30.2


