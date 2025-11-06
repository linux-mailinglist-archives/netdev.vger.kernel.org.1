Return-Path: <netdev+bounces-236110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C99C387D2
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 01:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3871A235DB
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 00:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1297D52F88;
	Thu,  6 Nov 2025 00:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GP2FqKR6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4471459FA
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 00:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762389254; cv=none; b=mYGshlxR9qeXAp1KzBEfn6MWccACiAxkrF8OxPr9TYpEHqTd8/u+uGywr5ScrOjwL0MDohe5jDRD2CKFNIJ5P9avvYI3twA1sOI5YDWZo85hQ8OPKJbMQJMi2s7lBIO4QwKnBkvLfvt2lMUsf9gIbw7o9yXoSFwY4GtI14ilKn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762389254; c=relaxed/simple;
	bh=XTO68GlrFkON0OmGvOFQEPQdavjBjqSH8Wop8IzkOGY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=glsRyYALWscydzshU3Z5iGTtLbqKSppos0NlMq/3gbJc/bQXR0X5iElhHpzdK8+mXj9PTVbc61E39acIY2sWIFJFw8nfe75qGEorEwsIy2rFG52+hjwQ4vZw0YIAfR3Mm+9xWnK318UMSyfGhl9IMHCdNStc5tu2cTVQuRviAcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GP2FqKR6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-295592eb5dbso5468965ad.0
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 16:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762389252; x=1762994052; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=biLzSdvmDYMvEzCvThKUYn2d/xtylO8ah+54M4aXcnk=;
        b=GP2FqKR6Nc7rbU3sFqXev7bS9v3SXPVfVPFLDVtEFlnyrg6QKMrOBWQ8GGoAOEL7ZS
         T7xIuZmxoHAbSQK56WWxEqfNiqHPmnbVUgqImL5T32iz99LIi6V6SBNEV6OfxInxWPqU
         F6cDHQ2oGH/bTno6B5MeYFFSiJj6JTpcCzEgMAIbrTlcnnpSKP7A9TMpwtbuA8MuxzQ/
         yZntr/YKkoZUy0+lAnZzLVTVy4LXMw8yco3vdglAbHtqrrMNn1I0JOkZHZu4K2AsH2nF
         npeP+JCy9kDAqOREaB+X7RO8zjoaEGip/JpTFDa0ZzaIWTdJOt/4nJn8f3vgTopBOOl9
         S2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762389252; x=1762994052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=biLzSdvmDYMvEzCvThKUYn2d/xtylO8ah+54M4aXcnk=;
        b=w4vIM404pTf+D/85QWf4rzw4+IqfBRmrN1nP0m8s6v5zTH8tYGOnxXUU9l66VypiC6
         kB9cFj3HGgyuu44hk7PYTAkH539oWLybFiKg8jMlN4QY66gKFjvVQmE8ObN+djg086Be
         mqyj8St3L2/5Re+eAm1NZCS+a3RAnolcfQsl3RrHN8r5GsSCx5HB6Ta//KzsGS9YRXTD
         M2gmWjkbEi7kZwqrWHVrwTXR0amJBL10YP4duf1V0XDVikw3HZDt0T//9BlAUOJOic8s
         LRIdFraunosZg2R5gl3MDVcxX96rstINB2OTAwHGW4xvcfMo837RKJetw3i3WpiacuEh
         vr1A==
X-Forwarded-Encrypted: i=1; AJvYcCW1PhwWCVzIui7N+G2I6XuCuCvNRTnyWy6Dpgn9iedCY1nVVlX9u2GFQhxrGf+p9Hj9dRgRbaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa9QcHDzivO4FI7WLTW1p9UBZeGomSpmyRCtbCSLsex5Opr2XA
	9MPat/k1WiQpCIEJhmNETtrT9XXEahtQz0WGirkOtow2liCvr4EBh2+7ku2u1t3IN9mZTNFGRMJ
	2OZzfRg==
X-Google-Smtp-Source: AGHT+IH5FHyyly2fIZD80mDb2Cfo7OPwJ1/drOTAD+uMFvcN0kKMoIhGYdz3/nvbXDcSWzRuL61OX8h05tk=
X-Received: from plei1.prod.google.com ([2002:a17:902:e481:b0:26a:23c7:68d3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce0a:b0:295:5dbe:f629
 with SMTP id d9443c01a7336-2962ad069acmr55580445ad.8.1762389251824; Wed, 05
 Nov 2025 16:34:11 -0800 (PST)
Date: Thu,  6 Nov 2025 00:32:43 +0000
In-Reply-To: <20251106003357.273403-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106003357.273403-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251106003357.273403-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 4/6] tcp: Remove timeout arg from reqsk_timeout().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Yuchung Cheng <ycheng@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

reqsk_timeout() is always called with @timeout being TCP_RTO_MAX.

Let's remove the arg.

As a prep for the next patch, reqsk_timeout() is moved to tcp.h
and renamed to tcp_reqsk_timeout().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/inet_connection_sock.h | 8 --------
 include/net/tcp.h                  | 7 +++++++
 net/ipv4/inet_connection_sock.c    | 2 +-
 net/ipv4/tcp_minisocks.c           | 5 +++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 90a99a2fc804..fd40af2221b9 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -290,14 +290,6 @@ static inline int inet_csk_reqsk_queue_is_full(const struct sock *sk)
 bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req);
 void inet_csk_reqsk_queue_drop_and_put(struct sock *sk, struct request_sock *req);
 
-static inline unsigned long
-reqsk_timeout(struct request_sock *req, unsigned long max_timeout)
-{
-	u64 timeout = (u64)req->timeout << req->num_timeout;
-
-	return (unsigned long)min_t(u64, timeout, max_timeout);
-}
-
 void inet_csk_destroy_sock(struct sock *sk);
 void inet_csk_prepare_for_destroy_sock(struct sock *sk);
 void inet_csk_prepare_forced_close(struct sock *sk);
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4fd6d8d1230d..b538fff1a061 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -841,6 +841,13 @@ static inline u32 __tcp_set_rto(const struct tcp_sock *tp)
 	return usecs_to_jiffies((tp->srtt_us >> 3) + tp->rttvar_us);
 }
 
+static inline unsigned long tcp_reqsk_timeout(struct request_sock *req)
+{
+	u64 timeout = (u64)req->timeout << req->num_timeout;
+
+	return (unsigned long)min_t(u64, timeout, TCP_RTO_MAX);
+}
+
 u32 tcp_delack_max(const struct sock *sk);
 
 /* Compute the actual rto_min value */
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 2bfe7af51bbb..b4eae731c9ba 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1105,7 +1105,7 @@ static void reqsk_timer_handler(struct timer_list *t)
 	     inet_rsk(req)->acked)) {
 		if (req->num_timeout++ == 0)
 			atomic_dec(&queue->young);
-		mod_timer(&req->rsk_timer, jiffies + reqsk_timeout(req, TCP_RTO_MAX));
+		mod_timer(&req->rsk_timer, jiffies + tcp_reqsk_timeout(req));
 
 		if (!nreq)
 			return;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index ded2cf1f6006..d8f4d813e8dd 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -714,7 +714,8 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 			 * it can be estimated (approximately)
 			 * from another data.
 			 */
-			tmp_opt.ts_recent_stamp = ktime_get_seconds() - reqsk_timeout(req, TCP_RTO_MAX) / HZ;
+			tmp_opt.ts_recent_stamp = ktime_get_seconds() -
+				tcp_reqsk_timeout(req) / HZ;
 			paws_reject = tcp_paws_reject(&tmp_opt, th->rst);
 		}
 	}
@@ -753,7 +754,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		    !tcp_rtx_synack(sk, req)) {
 			unsigned long expires = jiffies;
 
-			expires += reqsk_timeout(req, TCP_RTO_MAX);
+			expires += tcp_reqsk_timeout(req);
 			if (!fastopen)
 				mod_timer_pending(&req->rsk_timer, expires);
 			else
-- 
2.51.2.1026.g39e6a42477-goog


