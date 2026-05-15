Return-Path: <netdev+bounces-288426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF7UE+ZrB2rY2gIAu9opvQ
	(envelope-from <netdev+bounces-288426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:54:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4AF556845
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F2A530099B4
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB42337FF7F;
	Fri, 15 May 2026 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e5Cnek7F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC54C381C4
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778871265; cv=none; b=R0PLHUrXy0WCVXuQnAy8BoA6o1aRUOQKVO5hKml/7Fnun2Zb0zeSzwgMCuk05taOBtdLcKZt5lk8nKTbmJNpiC9QH1PUoTOwFN6sflRosOI5CyZFKCXfE2RTIhT6Sp1q/pjWWt8INwKNA/ZAkKSNIhy7qcv7/cIuz8Hlzt1A0hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778871265; c=relaxed/simple;
	bh=1ep5ZLVgq0P6ZOuRIHNhve6Q35NR/xV4JtQP4fUWqVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SjyviiukIE7jFBYdDnbAFI+mGDjqh6T0koHuVOq3m5mc6m8mlPFfZJiN7tLzBrnODhAEg1HFNEBLhjhiLL2elgO/WlIOvfyx/rIZN264rzKLYMmtde8ila0IpX4lzeL8Kxln8FV+piNWcSagW3E2UUviRCvNEr1qCBALzbcNZkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e5Cnek7F; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so2635e9.1
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 11:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778871262; x=1779476062; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SuHPlWmIOJ+p8xvCO2qGzAHb3LeLHxGU5jkoCFo5buk=;
        b=e5Cnek7FNN6wB4gRgZEqeaHt5Oi9Uz0dym7Vn4/rOHsyReunpz3VaS7I5UaZCOtEII
         Lb8gFFmw7i3jvifD7lfHnLXvxTl+pF6BqE4sJMXkg1gTQiNCVwiKg/rTQ8Zjn2r7lwlf
         pE1NcaFm5ycl1MJHrjnEiAbGLssOcteP2fxphlIMaVnkKAf+2lptTedpmD8ew1boUU7h
         rRoKD2CX4lyuCZj5P7/j8r/UtBalHpi44oHPLCeB1Ey/lRoM6ksLhF9OnVbSw7gjQT79
         7yZZLMzI0cb0Upc3dxEV7s5nWNUgrEruffQtWSd0mQnkqkPv9ZJARAkSskbS5hzU1hps
         sZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778871262; x=1779476062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SuHPlWmIOJ+p8xvCO2qGzAHb3LeLHxGU5jkoCFo5buk=;
        b=sg5rOhEpU109+XIx0a6D5xIofGJvryKBtDzBQOciMFo+Zpb8wXa9ZFoElJtx7o25R+
         sqhEg+d6yYSl7aFxxWg/1KKjJPYyh0vM0s/Vcbq2fdlTOmBx0L7k/r/SarcS3GDzGc5c
         k5dwCoEojyysw4MWgJH7TZhxNx+Wf/s/6A5Grv1M/VxO2xBa010g6WFWC9AFUYMvi+J1
         v3ePJbnm3b9DI/pIZseAwP+491bX6StubvDmrMGH9Uz/RP9XJZIoGzO9sx8TJWVvxKUs
         B3+S5CMQySxXk4vCwhJRv3kT8WqRYs2kBpkhtQwRDpHDV/3DH1TgRSKgQnxyuLjjvrsu
         559A==
X-Forwarded-Encrypted: i=1; AFNElJ/YNUxANlrKF8tPGV9GeZm3Ey43e2qXbReqaJlHJFWKWg+CoU8iHjyZFQlH4aZvxONYH0JbLu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ0Bcpkj1Cbe23/qNhx6/riTeCsyTVx7CmCGRsATcM1Q40yyC4
	hCwfbDSy0T9wFskJq8pdUKZ53/D6cqFopBY51//MMVPlk46RiLCYlrfQI6Pk+LxeRg==
X-Gm-Gg: Acq92OFB4Mstu0KrD9TeR3x0vauJO4GA2pDdGCgYcik+xckg9JVpldioCHmenVtmGmG
	2pN1uala/I4QKL2GjW05vIuukCQYAMktZVKwNex4vo4eN/b7Fz577IKN1yURo7vhKk0mdK45K0C
	5zj8GoXuPUckerd30+UE2CJNjLa9yX2Gzi+zctbhEtKNaSzy0Z4KjWh7+yBhJJZ5HlqFG2xCKNu
	Fpvt2tvXli2x5OjSxC7fyC7RHeF7q6Ub/sx3BpDSCblIsZFQ/2q+5vM7pPfoc6zHHhUYzh4S8gW
	lDHmVsBwhaorCXytjo2JDRJ91nETB3b/kjknvKyZpNkhoVsFjC+/ugwVGac5oH8nW+UdMqDmfZ8
	6NL7Gsq0BN/4+RLzwZSb3ShHbYSGLdUe1XTLmk//QLwHiIpkGfVgzZmCsvh8gnkQMuWyeO/nxY/
	SeuTEnBZhCQQJHMNnIWOW810BVvwSLlrZ3DhEfjYLDU1SoyJUjKshKCkMMGViAzg==
X-Received: by 2002:a05:600c:4ed3:b0:48f:de33:777a with SMTP id 5b1f17b1804b1-48ff4c84507mr85275e9.11.1778871261929;
        Fri, 15 May 2026 11:54:21 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:7481:4dac:8e80:6e9b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe57943b2sm79586725e9.8.2026.05.15.11.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 11:54:21 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 15 May 2026 20:54:08 +0200
Subject: [PATCH 1/3] af_unix: Fix UAF read of tail->len in
 unix_stream_data_wait()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-unix-recv-wait-v1-1-76adb5f063d5@google.com>
References: <20260515-unix-recv-wait-v1-0-76adb5f063d5@google.com>
In-Reply-To: <20260515-unix-recv-wait-v1-0-76adb5f063d5@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778871255; l=5214;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=1ep5ZLVgq0P6ZOuRIHNhve6Q35NR/xV4JtQP4fUWqVQ=;
 b=biFR0H5BnKM6bLseIWGzRNTfIvRlm/vD4ABNpEGL50UdomtRVOj4eqEfC+9PyYKMKMdKTjh0A
 rAlLz7dcLkAC2zvT+3nOa1m74jTU89NiW9kWrw5r0IALbjgMEdzGlgb
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=
X-Rspamd-Queue-Id: CE4AF556845
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_FROM(0.00)[bounces-288426-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

unix_stream_data_wait() does skb_peek_tail(&sk->sk_receive_queue) without
holding any lock that prevents SKBs on that queue from being dequeued and
freed.
This has been the case since commit 79f632c71bea ("unix/stream: fix
peeking with an offset larger than data in queue").
The first consequence of this is that the pointer comparison
`tail != last` can be false even if `last` semantically refers to an
already-freed SKB while `tail` is a new SKB allocated at the same address;
which can cause unix_stream_data_wait() to wrongly keep blocking after new
data has arrived, but only in a weird scenario where a peeking recv() and
a normal recv() on the same socket are racing, which is probably not a
real problem.

But since commit 2b514574f7e8 ("net: af_unix: implement splice for stream
af_unix sockets"), `tail` is actually dereferenced, which can cause UAF in
the following race scenario (where test_setup() runs single-threaded,
and afterwards, test_thread1() and test_thread2() run concurrently in
two threads:
```
static int socks[2];
void test_setup(void) {
  socketpair(AF_UNIX, SOCK_STREAM, 0, socks);
  send(socks[1], "A", 1, 0);
  int peekoff = 1;
  setsockopt(socks[0], SOL_SOCKET, SO_PEEK_OFF, &peekoff, sizeof(peekoff));
}
void test_thread1(void) {
  char dummy;
  recv(socks[0], &dummy, 1, MSG_PEEK);
}
void test_thread2(void) {
  char dummy;
  recv(socks[0], &dummy, 1, 0);
  shutdown(socks[1], SHUT_WR);
}
```

when racing like this:
```
thread1                       thread2
unix_stream_read_generic
  mutex_lock(&u->iolock)
  skb_peek(&sk->sk_receive_queue)
  skb_peek_next(skb, &sk->sk_receive_queue)
  mutex_unlock(&u->iolock)
                              unix_stream_read_generic
                                unix_state_lock(sk)
                                skb_peek(&sk->sk_receive_queue)
                                unix_state_unlock(sk)
  unix_stream_data_wait
    unix_state_lock(sk)
    tail = skb_peek_tail(&sk->sk_receive_queue)
                                spin_lock(&sk->sk_receive_queue.lock)
                                __skb_unlink(skb, &sk->sk_receive_queue)
                                spin_unlock(&sk->sk_receive_queue.lock)
                                consume_skb(skb) [frees the SKB]
    `tail != last`: false
    `tail`: true
    `tail->len != last_len` ***UAF***
```

Fix the UAF by removing the read of tail->len; checking tail->len would
only make sense if SKBs in the receive queue of a UNIX socket could grow,
which AFAIK is not supposed to happen.

Fixes: 2b514574f7e8 ("net: af_unix: implement splice for stream af_unix sockets")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 net/unix/af_unix.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 1cbf36ea043b..dc71ed79be4a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2711,8 +2711,7 @@ static int unix_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
  *	Sleep until more data has arrived. But check for races..
  */
 static long unix_stream_data_wait(struct sock *sk, long timeo,
-				  struct sk_buff *last, unsigned int last_len,
-				  bool freezable)
+				  struct sk_buff *last, bool freezable)
 {
 	unsigned int state = TASK_INTERRUPTIBLE | freezable * TASK_FREEZABLE;
 	struct sk_buff *tail;
@@ -2725,7 +2724,6 @@ static long unix_stream_data_wait(struct sock *sk, long timeo,
 
 		tail = skb_peek_tail(&sk->sk_receive_queue);
 		if (tail != last ||
-		    (tail && tail->len != last_len) ||
 		    sk->sk_err ||
 		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
 		    signal_pending(current) ||
@@ -2921,7 +2919,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 	int flags = state->flags;
 	bool check_creds = false;
 	struct scm_cookie scm;
-	unsigned int last_len;
 	struct unix_sock *u;
 	int copied = 0;
 	int err = 0;
@@ -2967,7 +2964,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 			goto unlock;
 		}
 		last = skb = skb_peek(&sk->sk_receive_queue);
-		last_len = last ? last->len : 0;
 
 again:
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
@@ -3001,8 +2997,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 			mutex_unlock(&u->iolock);
 
-			timeo = unix_stream_data_wait(sk, timeo, last,
-						      last_len, freezable);
+			timeo = unix_stream_data_wait(sk, timeo, last, freezable);
 
 			if (signal_pending(current)) {
 				err = sock_intr_errno(timeo);
@@ -3019,7 +3014,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 		while (skip >= unix_skb_len(skb)) {
 			skip -= unix_skb_len(skb);
 			last = skb;
-			last_len = skb->len;
 			skb = skb_peek_next(skb, &sk->sk_receive_queue);
 			if (!skb)
 				goto again;
@@ -3094,7 +3088,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 			skip = 0;
 			last = skb;
-			last_len = skb->len;
 			unix_state_lock(sk);
 			skb = skb_peek_next(skb, &sk->sk_receive_queue);
 			if (skb)

-- 
2.54.0.563.g4f69b47b94-goog


