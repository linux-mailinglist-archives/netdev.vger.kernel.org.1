Return-Path: <netdev+bounces-258794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK7OJVkwkmk8rwEAu9opvQ
	(envelope-from <netdev+bounces-258794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 21:45:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3866013FAE0
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 21:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC2A63036D5D
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 20:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3732C027B;
	Sun, 15 Feb 2026 20:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NmgH5gZT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0307E304BB4
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771188242; cv=none; b=GfFGLjR+itpaF9yjqHA4AnQ1Npd8QphATscWBy8bRPCDtfZTJBxOs1S4Y900ooOts/Wi/c0uIvcBf8Bh7w+bdu8qKKK1OL7WoKVxE+Q4rxfAhYIG92v+ggw83rTxphuikcP+rPeTNoa8XTh/1Uts9IXkk70GvFngsTa+/bqzYRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771188242; c=relaxed/simple;
	bh=j6HlvglSK/TSepIs8gUhrttyCe5YByeMo6FOdqtnSWs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tdOZO13JvHnaTjAjRY7gjuqtH6g41tldiA37FAdKCPHPWtsdPPtLofUkuc2znq1y8h1motlipwWVxYIbd/xrxIpCBSfgyqRtd/LklHTyZTu12ucdQZK7mbPLL5Bd+BLZRxaLZxK+6XJEsGiFGmTxaZDGzPTawLKsWVXrAnIYqmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NmgH5gZT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3545dbb7ee6so1983972a91.3
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 12:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771188239; x=1771793039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3hFapZBeUENdF611STozZJXhlIrkmUJy1sWUR+b5QcI=;
        b=NmgH5gZTjlcH8InLkr7nd8byOkj8rrwNHL60dqVd/mYnkOY7I7O65ExyErbwMwT+5U
         zwIAIUHJpzA+2eQhbyiybpcaVB1+mTF/edowVqQmJTNp9fWXalEsmMn5fnZS5p4TpEK0
         Qs3fqxx9RjZv2jsEIXAlGtnhR5bbHEjWDuB19hOmAV7nhqvptprWxXNW0G6hxd+1k51R
         ORrMar186YDlkH+DKcVzyARUnGf28JTNmG4OQJN5FL67n2FGkECD8kpKUBjTwrMQE5QY
         gVmgy7gWCIVlKhdTkV/2Smd4YbsXWxovKWmlF4CEN2sElWw1hk2+QnBw+lGgDqHt+WKx
         pkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771188239; x=1771793039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3hFapZBeUENdF611STozZJXhlIrkmUJy1sWUR+b5QcI=;
        b=liXmYIx2uyUyGtCSJhj5HrejRng0RlcTCxJvGcC510x+DnRdBbJFmtjEshtmOVxLVJ
         3aceMi1b1KSqhGHDVWTj9Cvpo+H2Iq+KYVWMC8hbWRj6Vw1JeozN6wjgc1hLZ4FrVRX6
         FJNB02knYASS23tOQCSyWuw90UvIXkVSqrgcBk8906IJkYG7rCKTkfoo1QYvHpySRfAk
         QfJoBxOyg6r+Ny9enm9pUTJRTjMvzqbdr96Hh7wWI709J0ycZbSlZp+h8fti2fhMs5dZ
         fVx8rupAv7ChM+fhMGueFp0Ep55pwK17vPFCiAwi9X1Jh67dhxF29pb+6rOY747huYV5
         yMmA==
X-Forwarded-Encrypted: i=1; AJvYcCXlos44sEHmpq7a5worCCflOOBnuoi4v4nD8ubH22Ny6u7iTlMOJ4Wapz6sM/sBwyVukPdnYyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfW1RDjygQgF5pnKD2tq1KzvQj0/3AA7Od6Ydm+xQSNNFylz+r
	d8s5QM8GVa0O7A6KSbWfAWvyDZRJlBUh4fthFwzrtZ0UK6cRv/ibPFd4HRmws9y+5dT8arXJ9w4
	Xn2CJ1w==
X-Received: from pjbgl20.prod.google.com ([2002:a17:90b:1214:b0:354:c7ac:b03b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f8e:b0:343:7714:4caa
 with SMTP id 98e67ed59e1d1-356aaa98c0emr6167202a91.3.1771188239220; Sun, 15
 Feb 2026 12:43:59 -0800 (PST)
Date: Sun, 15 Feb 2026 20:41:37 +0000
In-Reply-To: <20260215204353.3645744-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260215204353.3645744-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260215204353.3645744-3-kuniyu@google.com>
Subject: [PATCH v1 bpf/net 2/6] sockmap: Annotate sk->sk_write_space() for UDP.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Cong Wang <cong.wang@bytedance.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258794-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,bytedance.com,google.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3866013FAE0
X-Rspamd-Action: no action

UDP TX skb->destructor() is sock_wfree(), and UDP only
holds lock_sock() for UDP_CORK / MSG_MORE sendmsg().

Otherwise, sk->sk_write_space() is read locklessly.

Let's use WRITE_ONCE() and READ_ONCE() for sk->sk_write_space().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/skmsg.c | 2 +-
 net/core/sock.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 75fa94217e1e..3d7eb2f4ac98 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1297,7 +1297,7 @@ void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock)
 
 	psock->saved_data_ready = sk->sk_data_ready;
 	WRITE_ONCE(sk->sk_data_ready, sk_psock_verdict_data_ready);
-	sk->sk_write_space = sk_psock_write_space;
+	WRITE_ONCE(sk->sk_write_space, sk_psock_write_space);
 }
 
 void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
diff --git a/net/core/sock.c b/net/core/sock.c
index 693e6d80f501..d828f91be4e9 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2690,7 +2690,7 @@ void sock_wfree(struct sk_buff *skb)
 		 * after sk_write_space() call
 		 */
 		WARN_ON(refcount_sub_and_test(len - 1, &sk->sk_wmem_alloc));
-		sk->sk_write_space(sk);
+		READ_ONCE(sk->sk_write_space)(sk);
 		len = 1;
 	}
 	/*
-- 
2.53.0.310.g728cabbaf7-goog


