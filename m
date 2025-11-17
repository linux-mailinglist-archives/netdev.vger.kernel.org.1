Return-Path: <netdev+bounces-239209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E889C65990
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 18:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B28AD4E4039
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 17:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000A23093C8;
	Mon, 17 Nov 2025 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TdPpt0og"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F352D4B77
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763401666; cv=none; b=I1rXt0cY/n388A20OIZEzFXgCQOVE8a9B5zsHpWruLpNULIOIPhFGsJd28zH6r/0UA5YTpm699LotEyWsnUpQe6tD8GtArSWtWB/SDcD5JMGm6nKFUmhkk8YZgFBb8MpFTIfZ8sAcxObTyi+L+RUmrGKacoq5krRkUPKscgFRW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763401666; c=relaxed/simple;
	bh=sVoWh5jdBksFl1KPpW8GWZURoNcE/oJEEV6c1mHZro8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aS/zQFl9pE2KUxhvKwHg+9JAuTj8C7hIs5sKnDNmsjF9hipDfIABlBI2DQfgmI36f/Z5d0yhJ3on9gDKIp+Pp3cZbbi8dGaP+weIQxhM7QhU4yirkEJ06XbMeJXtXm9kYT7BOd+RWjuRqNC9RJRLlktJtXCCR27lTc+w+a3rtcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TdPpt0og; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297fbfb4e53so81855265ad.1
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 09:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763401664; x=1764006464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Lf2Aqnm2w9/0dDJd0MmdaYwDirPJcDs7LiiQB0RoY0=;
        b=TdPpt0og6HP+ldCNrrsf3VUDK8tjG6f5bvX2+meYnE+UBfHjszmS4cIGYzQJfdLtGo
         8DDxWZr4FpQv9X9RdiIDBQhFx4mlCKfvpvo6oL5bFprzt0atOGiPYV7jMhFSnEkXB9JC
         HyZ0qRQ7iE8pUUapN8Gzt9gijzEytkkjwlwdT91mkidLY2R0PtPtczH9zxMO20ZI5O9m
         kklnHgNf3MZWFzK7qTeL2QD2tCbaw3ZU4q63VCrmrP89Xmp32/n07lHuW8X0y+AiluK4
         9w9rLI1nCggny82k/T/WtUqhiZNFHioXkTutiwjQ/tUtXtojizmZmrvS6i86Jj6TY73l
         5b4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763401664; x=1764006464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Lf2Aqnm2w9/0dDJd0MmdaYwDirPJcDs7LiiQB0RoY0=;
        b=LNS6RItDDcb69uAH+ArfD5Gswga9IuIbTJucm7nXBmRn/n4phUkk0uv//3LOkhAjwN
         epCw8lj2QPXyBdcN4Yxqr/tOSLF8ul/j3usn3y4dHHHDWqUlmWwMTHUmZE+j2auVZbrC
         QED0pNecxMAveSvOld64jzwOBdB6VphiAMMKC0LzIxl7HOFqsT4xtC5djKH9kraQhOU0
         M92F1fwECKjeN6N7cvcAQk6yCpCy5pq8zzkEXvPyHgsVI2ukzGJMMC/OTJvy8pJKVEfY
         M1OuYMiZMHQejBj9lVHrC9+SFjtdZbJaHuhn2QaVyolNVUXXTfztnRuikn/ZchC1zeAa
         jKtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZg1b6PcrSjzapUmXB1QlyDYyOpHHl7N/piH+Cm7NJvArO5UJ+5zcmcFuye8zwlzYPUW4O7cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNPM/3EIsx3mL3Oza58af2XnQ/hxbNKgeYXv4THBfNGlqM3BzA
	lY21+DwkPvl1SxyJGBRZt1PRa1MDMZTurgDx3zYdHjVHcVi1jV7uxxk+0WOJIrTTeyLUUzkNcXM
	fumkP6A==
X-Google-Smtp-Source: AGHT+IEaMLDSi/qPf2OxllUSg0vuvjUXQImkLvJb52fIkuiksvyfJ0QEEm5BKcKTLw0IlnjZIl2RD++gyMI=
X-Received: from plpw11.prod.google.com ([2002:a17:902:9a8b:b0:273:8fca:6e12])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:a8f:b0:295:7453:b58b
 with SMTP id d9443c01a7336-2986a6b56b4mr153591035ad.4.1763401664570; Mon, 17
 Nov 2025 09:47:44 -0800 (PST)
Date: Mon, 17 Nov 2025 17:47:10 +0000
In-Reply-To: <20251117174740.3684604-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251117174740.3684604-1-kuniyu@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117174740.3684604-2-kuniyu@google.com>
Subject: [PATCH v1 net 1/2] af_unix: Read sk_peek_offset() again after
 sleeping in unix_stream_read_generic().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Aaron Conole <aconole@bytheb.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Miao Wang <shankerwangmiao@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Miao Wang reported a bug of SO_PEEK_OFF on AF_UNIX SOCK_STREAM
socket.

The unexpected behaviour is triggered when the peek offset is
larger than the recv queue and the thread is unblocked by new
data.

Let's assume a socket which has "aaaa" in the recv queue and
the peek offset is 4.

First, unix_stream_read_generic() reads the offset 4 and skips
the skb(s) of "aaaa" with the code below:

	skip = max(sk_peek_offset(sk, flags), 0);	/* @skip is 4. */

	do {
	...
		while (skip >= unix_skb_len(skb)) {
			skip -= unix_skb_len(skb);
		...
			skb = skb_peek_next(skb, &sk->sk_receive_queue);
			if (!skb)
				goto again;		/* @skip is 0. */
		}

The thread jumps to the 'again' label and goes to sleep since
new data has not arrived yet.

Later, new data "bbbb" unblocks the thread, and the thread jumps
to the 'redo:' label to restart the entire process from the first
skb in the recv queue.

	do {
		...
redo:
		...
		last = skb = skb_peek(&sk->sk_receive_queue);
		...
again:
		if (skb == NULL) {
			...
			timeo = unix_stream_data_wait(sk, timeo, last,
						      last_len, freezable);
			...
			goto redo;			/* @skip is 0 !! */

However, the peek offset is not reset in the path.

If the buffer size is 8, recv() will return "aaaabbbb" without
skipping any data, and the final offset will be 12 (the original
offset 4 + peeked skbs' length 8).

After sleeping in unix_stream_read_generic(), we have to fetch the
peek offset again.

Let's move the redo label before mutex_lock(&u->iolock).

Fixes: 9f389e35674f ("af_unix: return data from multiple SKBs on recv() with MSG_PEEK flag")
Reported-by: Miao Wang <shankerwangmiao@gmail.com>
Closes: https://lore.kernel.org/netdev/3B969F90-F51F-4B9D-AB1A-994D9A54D460@gmail.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/af_unix.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 4124f472a02b..fa21519fce43 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2960,6 +2960,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 	u = unix_sk(sk);
 
+redo:
 	/* Lock the socket to prevent queue disordering
 	 * while sleeps in memcpy_tomsg
 	 */
@@ -2971,7 +2972,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 		struct sk_buff *skb, *last;
 		int chunk;
 
-redo:
 		unix_state_lock(sk);
 		if (sock_flag(sk, SOCK_DEAD)) {
 			err = -ECONNRESET;
@@ -3021,7 +3021,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 				goto out;
 			}
 
-			mutex_lock(&u->iolock);
 			goto redo;
 unlock:
 			unix_state_unlock(sk);
-- 
2.52.0.rc1.455.g30608eb744-goog


