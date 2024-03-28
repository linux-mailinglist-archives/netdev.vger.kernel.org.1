Return-Path: <netdev+bounces-82901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B0E89021B
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 15:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361801F2773B
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 14:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2E212E1C8;
	Thu, 28 Mar 2024 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cr0PRFoE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED6A82D7F
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636841; cv=none; b=a9L5v7xAbZw5tPR2k76sMiszNSIRfJodP6xErtgLIosiNGVyYFdQGOSdVnmW6GVo6uyi+5+e1ALtBqNDS5tRaTdElpXNYspurr8j6yCIVKapKzsgY7IokSchEgj+s4Dt80J8K6ZEupZvgxZ7QUJBeehT+vTDT2C2S9zJn3Royyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636841; c=relaxed/simple;
	bh=vXeEMX03o4zDxJWBnlqazfGrTS0sbNL3vB3FVfzOgWc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XfMY7mHBOrhVKXsa6nO/7vDtb83+rk6Hv4LpdewXvcqjU6NVarOHifsZoT0jEC+MSnNq4KdoefgEo/tNJGebTE39nEFS10oMmWXYsYsQWyBKPBA4vpR+3XtOlFFhcd0Mcue1PQDVGkFeH/rZit2HPmBeDHVurFst7b4EGtL7OaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cr0PRFoE; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cd62fa20fso19935577b3.3
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 07:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711636839; x=1712241639; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7yB6XxADH9yBrLmsEyQeqdJSGK3HyQrcUzUUKRfsk0E=;
        b=cr0PRFoEwtflTU1MsAT+Z/qbkj1rK9kwxB9L1SzQynG0N7BXQjgMkqwvbD77XdXiR/
         504OsIxUltXyR+UZikb6rrGQLQ7Zj/J4cpQPQuJSPXGweNmLP+J6HsrIQ9oTzZLRazM4
         gQ5OM1SUK3ZbupA4ejcBwHdoYYpWSKRmCln4+d4x6nwQDmfRoPew668H7BxXrWvGAAdH
         fDjjMe4QXi0v6Si6WEmiWtDqRUW4pf8bMKGt1elaPaYdPTzpypDURxj9GlY2Yewgw0du
         mtoCzbMd/DjYJKbiTzN8dI+YrHw7OkCvTyyhGJi7o0rO1DnW9VdUDcFNm5D3PMFYRChX
         CCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711636839; x=1712241639;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7yB6XxADH9yBrLmsEyQeqdJSGK3HyQrcUzUUKRfsk0E=;
        b=SXkd4To/dwc6Xr2VsihcqdwtSYJq1RlixRRRC5M9d9rDEaKyxVzsokEcRP5O4kS6A0
         sP8JISOWvpYZAfWKCtOH7MnLTZLBN+ItAgWwTGBDox5AO1BRsYy6b7DrAdHgQagfJg4j
         pa5dqb9YNgvg4OLUmFQY4gPwXQY/KnBOdnPP5lDQS1uH6G3Fj4yGeHxTMjxnG+M2gyE/
         HpOF6Y392sfOfk2bGFtYkRkY8nHZ6ZbsqO0m93S8hGNAlFbfNBqOkME9qa4awIvBTQgd
         0Aadhqhs7sT74Dyw//w8x+wa9j83v6CUkm9DICy5PwctOjiSuyOY02jHA3tNjzg1c45Q
         XS4A==
X-Forwarded-Encrypted: i=1; AJvYcCW539E/l7FF61oV12R8KqGtKgWzVsm3zj3d7uNWEm3LcJ+47IOl7KgSaiiro7zAdbXX4ZPmMV91tqVSZ/OVnlOTO/RN/Rax
X-Gm-Message-State: AOJu0YytZj5xOnGO1WHotA74lAt3nGbnJTqMPjAr6dQvEZO+yZcQTuTs
	WKbksH476rvzrx2cs9IJyJcLhlu/o2NCOxgoZBqgBZE4bQywTOz7hUkARhEZOTBYoHw0bsg5Qx/
	n6PYaB7b9Kg==
X-Google-Smtp-Source: AGHT+IGfc+H0PdROU66qf1lhWBtM6Hj8BEMrzxSzSRc/IVUwVcGXDN9U7456u125VAxm5MKjAvvsSC/UV+s0LQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1b0f:b0:dc2:2ace:860 with SMTP
 id eh15-20020a0569021b0f00b00dc22ace0860mr173088ybb.2.1711636839084; Thu, 28
 Mar 2024 07:40:39 -0700 (PDT)
Date: Thu, 28 Mar 2024 14:40:31 +0000
In-Reply-To: <20240328144032.1864988-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240328144032.1864988-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240328144032.1864988-4-edumazet@google.com>
Subject: [PATCH net-next 3/4] udp: avoid calling sock_def_readable() if possible
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

sock_def_readable() is quite expensive (particularly
when ep_poll_callback() is in the picture).

We must call sk->sk_data_ready() when :

- receive queue was empty, or
- SO_PEEK_OFF is enabled on the socket, or
- sk->sk_data_ready is not sock_def_readable.

We still need to call sk_wake_async().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/udp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index d2fa9755727ce034c2b4bca82bd9e72130d588e6..5dfbe4499c0f89f94af9ee1fb64559dd672c1439 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1492,6 +1492,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	struct sk_buff_head *list = &sk->sk_receive_queue;
 	int rmem, err = -ENOMEM;
 	spinlock_t *busy = NULL;
+	bool becomes_readable;
 	int size, rcvbuf;
 
 	/* Immediately drop when the receive queue is full.
@@ -1532,12 +1533,19 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	 */
 	sock_skb_set_dropcount(sk, skb);
 
+	becomes_readable = skb_queue_empty(list);
 	__skb_queue_tail(list, skb);
 	spin_unlock(&list->lock);
 
-	if (!sock_flag(sk, SOCK_DEAD))
-		INDIRECT_CALL_1(sk->sk_data_ready, sock_def_readable, sk);
-
+	if (!sock_flag(sk, SOCK_DEAD)) {
+		if (becomes_readable ||
+		    sk->sk_data_ready != sock_def_readable ||
+		    READ_ONCE(sk->sk_peek_off) >= 0)
+			INDIRECT_CALL_1(sk->sk_data_ready,
+					sock_def_readable, sk);
+		else
+			sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
+	}
 	busylock_release(busy);
 	return 0;
 
-- 
2.44.0.396.g6e790dbe36-goog


