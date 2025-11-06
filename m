Return-Path: <netdev+bounces-236111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D31F0C387D8
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 01:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703D0189C3FF
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 00:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987B01D54FA;
	Thu,  6 Nov 2025 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oZAnHit2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140E21C5D6A
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 00:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762389255; cv=none; b=tk7yLJriOiBFvVllzSBjXo4fbKCPKjRcK0XrZ46q+L6UzIvhPSS3jr1R4tVOX6RveymGJVsZsrjlDqkqp22A3fu16aQOlGseNwJXBd135u00X4wjMq/7zQup77cGfAgoz1/cC5XOQS+DgmJz+kOB/cTkYWO3i4wZnTgT15YSAbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762389255; c=relaxed/simple;
	bh=XsMlWlL42KshOCVkQmJBe6h06XBVFDx4G+yex0r7tQM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dbvvyu924A6VEKDOvS/ulGiRyQTxn7uhf5q7JX3ZAh1sxPkMkQ3zE0A1+C4nMPNOBYnq71clpAkAiaTaVdkLnOrAFSlsSNagVWv8HYnPXyPbcs7QzMAl5iWwWd4f8dqisv6xHw4qDmJGgwn+X2rSV1t6ByuKaCIqczqeMVLqRfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oZAnHit2; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b9a72a43e42so299268a12.2
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 16:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762389253; x=1762994053; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7qE+fh2IhYd3U/r3+9WB8p4BH1+/cWXjKTgFcRjOtV0=;
        b=oZAnHit23dWoVl94vmbSBsSx6VLr2XmMEVPu+oOEaM8jh7cIgvNYf/gWRwu6dhrHRo
         nc7SXvj4IUQsAIjCzuHpdF4I7v6UIeKv3K8U3EMMxOCRhLyJDG50mFuG/+6kchVbV38v
         a3ci4YzHbvosEcU22NSoquBHjdHgH6P/bExpKs/jpK7J0TnwT5gVBalzsGS0vWVc6LJP
         J49EMW1VygLLt2HwvaW62/CaPtvdVGeTYxAJ839lB72sV2BdlJUdQ2yIXVGmXY/RUWLB
         pOMRkfTiapg4RboRNUa89ch9vKIIt602zy90r8t9Cjjmmnis/5qV1lAOFFDHHN+e0mSI
         vj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762389253; x=1762994053;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7qE+fh2IhYd3U/r3+9WB8p4BH1+/cWXjKTgFcRjOtV0=;
        b=fkuv9y0M2OgS5FP4iHr5ChZLJmSPjgp+OcnZIA9nKikNB5fP9BkrhRhClF7ir7tEW7
         sSIExzTEd4JmBt0ZnKtUhDC3VwFKUFWZOWDUqHmZG23A+etMRU2XmBJacAQUA51YeBLQ
         p3saiHbAgt1PqFx0L+Yo8mu3EqzojAxukt7sDIfEEYO+f6/RzdlRsfNIjlY2T+eBjY6U
         7tCuD1CYnQING2xAgB+RZykc6GlTXR9TjxcAX6/Q4YxZmL6Yq8zH1Rtc9WumwUqW+vEr
         1/cyQ5xVVUSw4CCQVj6d+Slu1SML0JbR00ITmJfYb3KVcKdwVILkJlr/qQPiwujH5aor
         SIwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4b6QeVjv9k8T7z5IjEJbK3KrCMW6NEDe/O/oPgs8JkiYhaISEgW5W2iaGIuPyz+3LRT0vu4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW4io2rRpjDehoNDEMB/Uy7mvzAL+H0dY2gKUsRDM7p8jLmaoJ
	kBd03Dfb22ol+gTuqEBkPaYWygle8WjAxwHh7PgRbmqMSylu8uujhrJCqdaJxiI8bt4YBbB+zSe
	HioRvmQ==
X-Google-Smtp-Source: AGHT+IEQCshI5R5zHDpwuQvxFBjqdYMAeZ/cSjq7G50Ra7VdntnMb7nFWfOxA1IY00qyo7Fi70jyF7RnB6c=
X-Received: from plrd23.prod.google.com ([2002:a17:902:aa97:b0:295:445a:2a75])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dac5:b0:252:a80c:3cc5
 with SMTP id d9443c01a7336-2962ad1c9e2mr65884665ad.22.1762389253271; Wed, 05
 Nov 2025 16:34:13 -0800 (PST)
Date: Thu,  6 Nov 2025 00:32:44 +0000
In-Reply-To: <20251106003357.273403-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106003357.273403-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251106003357.273403-6-kuniyu@google.com>
Subject: [PATCH v1 net-next 5/6] tcp: Apply max RTO to non-TFO SYN+ACK.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Yuchung Cheng <ycheng@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since commit 54a378f43425 ("tcp: add the ability to control
max RTO"), TFO SYN+ACK RTO is capped by the TFO full sk's
inet_csk(sk)->icsk_rto_max.

The value is inherited from the parent listener.

Let's apply the same cap to non-TFO SYN+ACK.

Note that req->rsk_listener is always non-NULL when we call
tcp_reqsk_timeout() in reqsk_timer_handler() or tcp_check_req().

It could be NULL for SYN cookie req, but we do not use
req->timeout then.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/tcp.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index b538fff1a061..93680ff30f0f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -845,7 +845,8 @@ static inline unsigned long tcp_reqsk_timeout(struct request_sock *req)
 {
 	u64 timeout = (u64)req->timeout << req->num_timeout;
 
-	return (unsigned long)min_t(u64, timeout, TCP_RTO_MAX);
+	return (unsigned long)min_t(u64, timeout,
+				    tcp_rto_max(req->rsk_listener));
 }
 
 u32 tcp_delack_max(const struct sock *sk);
-- 
2.51.2.1026.g39e6a42477-goog


