Return-Path: <netdev+bounces-258960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4P7/Kk+xk2kK7wEAu9opvQ
	(envelope-from <netdev+bounces-258960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 01:07:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFC4148302
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 01:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FF753026583
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 00:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B79288D6;
	Tue, 17 Feb 2026 00:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TcWuoSyJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505901AAE28
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 00:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771286829; cv=none; b=grBdG3PmSfL2gMaMeXzts3dqVaNuzbbVx0NaQXrMoxr2vg0e2+SmA1CZPJkS34duzQPo+QSL+WIqA7jIy0UhCQLfgZnNiYUrDXIS0PoIXeXWcqKa7ZeMuSl4pqlqNnI0YJvM08uuuy+B7a49NTkOZWESTbbRs40Y9f+Zg6xYADo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771286829; c=relaxed/simple;
	bh=fXTR6x5eUroimUQBomddgE/3LVW7RGwbWy3GPmAvBdc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KMtfiEt2PKAYabWGkowU4oMB1DYbF2d1fyM1AaSGWDSSmJ0f3zoO7Yu/hbNvOVfIhPA4AZxVtPce2Ji3Qv8dybnUATROgXNOIyOBi+PBJrtNK+IhfvR/hAGU7QO5+pTv8pfmqurXOZthrqRBmHPXVBYOtD2E7D1SRzrQhKj5q6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TcWuoSyJ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-824af3c6c0cso1743126b3a.3
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 16:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771286828; x=1771891628; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mkfVzCVTZnvHD8hLgyrAKSJhuenzVoEE09W4TgLMOkc=;
        b=TcWuoSyJprq1MujFKLMJBvdL5as0sUzKooUjYxxomP1n78QLKwM0QNtIZ3Uia9k93s
         RF8I9WeBYE1A2yLyB8Jtan+QGTWEOaVUo+Z9UnGYuvEdIsF4dkCRTEcx2ZWsWidwbWMS
         mFLJ6ZkVDrtpRQ3ikVECvhECVE0u3pBgn2VcXN5g50A1hWhqPkE3BgMBVV7BiE4m8SkI
         gNFd9yYEZ2IPTlI++QQKMWoZmS6f7xvWdy05swofGaBoksNwYv/qsB5+PnrT+sFmP35e
         FysPE1ksKrztU13oimIXzJbzU0epFEDqcePd9/xWd7Ldhe+Ryg8I0Wh6JHZXm6y/NLMr
         GQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771286828; x=1771891628;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkfVzCVTZnvHD8hLgyrAKSJhuenzVoEE09W4TgLMOkc=;
        b=p4LRi3Yaa6bACBcuyQyksTmWItB6IuSZEjVHdB9wAAPapBKI0kObyJCsR8P085EIov
         Q6Ecy6T/7LDyLpSq4BMMjNNge6ofg6mUhF6894rk5RkjZuRDvk0uyVWJig2CLIFksWSD
         UTaUalSd0eGEDlJkQMFb2PzG2traDoo8WszHaQY7ACiQEfw1QLRLu5y0L+HeWdlsPlUo
         i45dY4o0G5NjzO3g3g93H/QJCArowjn1L5fgfiEpbf/RmU38GP52u4FR4oSRbYWAEPND
         E8matLYSwr7W5zw8gg3Br5vD9lxYfQLs31m+WktVTLZhz67fwS3q6IXW2JiwwNArOBAo
         0wHg==
X-Forwarded-Encrypted: i=1; AJvYcCVpyXCgNP0d9cctoDfvbvA9mxmRS7Bg7t0bKFRuiIoKuyNngs8NLG3gjukTC3dCgGe4zsGXbLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnPp1yPeJ5ctpAk/6Dzm1pawgnqGDToTyzr/ZYQDNlWl0Beik0
	8KLVZHHzFgIBd2wsg7GaiPZ0osKlzAtqiGlel6u7A9gQWm/soEWuY4uMBEvh2UGE4Pqs1+ddA4G
	Y05HXbg==
X-Received: from pfiu8.prod.google.com ([2002:a05:6a00:1248:b0:824:c9a6:b9a5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1bc7:b0:823:3078:f684
 with SMTP id d2e1a72fcca58-824c963e378mr10382357b3a.32.1771286827380; Mon, 16
 Feb 2026 16:07:07 -0800 (PST)
Date: Tue, 17 Feb 2026 00:05:14 +0000
In-Reply-To: <20260217000701.791189-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260217000701.791189-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260217000701.791189-3-kuniyu@google.com>
Subject: [PATCH v2 bpf/net 2/6] sockmap: Annotate sk->sk_write_space() for UDP.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258960-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4DFC4148302
X-Rspamd-Action: no action

UDP TX skb->destructor() is sock_wfree(), and UDP only
holds lock_sock() for UDP_CORK / MSG_MORE sendmsg().

Otherwise, sk->sk_write_space() is read locklessly.

Let's use WRITE_ONCE() and READ_ONCE() for sk->sk_write_space().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Cache sk->sk_write_space in sock_wfree()
---
 net/core/skmsg.c | 2 +-
 net/core/sock.c  | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

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
index 693e6d80f501..710f57ff3768 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2673,8 +2673,12 @@ void sock_wfree(struct sk_buff *skb)
 	int old;
 
 	if (!sock_flag(sk, SOCK_USE_WRITE_QUEUE)) {
+		void (*sk_write_space)(struct sock *sk);
+
+		sk_write_space = READ_ONCE(sk->sk_write_space);
+
 		if (sock_flag(sk, SOCK_RCU_FREE) &&
-		    sk->sk_write_space == sock_def_write_space) {
+		    sk_write_space == sock_def_write_space) {
 			rcu_read_lock();
 			free = __refcount_sub_and_test(len, &sk->sk_wmem_alloc,
 						       &old);
@@ -2690,7 +2694,7 @@ void sock_wfree(struct sk_buff *skb)
 		 * after sk_write_space() call
 		 */
 		WARN_ON(refcount_sub_and_test(len - 1, &sk->sk_wmem_alloc));
-		sk->sk_write_space(sk);
+		sk_write_space(sk);
 		len = 1;
 	}
 	/*
-- 
2.53.0.310.g728cabbaf7-goog


