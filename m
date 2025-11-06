Return-Path: <netdev+bounces-236109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546C5C387D5
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 01:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1163ACE68
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 00:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D4A1ACEAF;
	Thu,  6 Nov 2025 00:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="00wxX25D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159242EB10
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 00:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762389252; cv=none; b=po6q1OV/zUdl8AlhTAfXcjZXAH7w8TlEjGH9m790eY0rvOrgG6oqGVvXzMWOKK1lfHN4dxWkx5C/0zW6xMCk96hEP0QjN1uSt8Nmwel5c//PZcHueOPHYyZY6kEhKA+Zoen9EsO5+2TaOWeaRRllDmbehZ07pKlxfo/sqHb4A+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762389252; c=relaxed/simple;
	bh=RgcaJnRXKEXlRjRPS3srNqd30tRW8kLdM/j/ebcJpNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LCUF2h8iWNV0yVbgtBsmpDZVDDW20+3H8dNHsHIdjqcWuHZkZ3L7NCzZaYHpQbKR1p164G2dBIkA4RvRYLlQJsj417hM5q8+auPM3iLLSzqEj1oGlHhV/PwlfG7Ft5ftiIBBZf6lyQwO4wMnREAl07SwAADopUG2RSPpbGPFtOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=00wxX25D; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-ba265ee0e34so312778a12.2
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 16:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762389250; x=1762994050; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LVeb1iyrZmoOn78cOUzlwyvZtMfZHRIL2LpJvJBI5jg=;
        b=00wxX25DL2xvGBNhDCWaZzrI3mEFrWuGxDDGIiafIH2hdi6Wj6EQBmqjxtNvmV38VD
         LG0WJyZs5io6CAOxR73tUHiA0jhapNLks3tnDjb37Fi/cGBsWH4PTs2rfBbyZQJoOXQs
         Mesc3EEtBU1F8jhknPW1wumbxfOOTis4X7a5ryeU9M0kQ8nf+vBwOP1m05KMtHCv8zf5
         gDuLtLfAn10hJ5/tQGhv29YUz567XH8o10d9hzX6nInSbxFBwCnhx0ocLwQc6LJD60j4
         CbbQeOqfXXAY3POw1Pq1r4PIfxkieCSyWtDFLjKDtAFnTwf9biO05roxRHiQ78E1o7zJ
         sLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762389250; x=1762994050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVeb1iyrZmoOn78cOUzlwyvZtMfZHRIL2LpJvJBI5jg=;
        b=ZunjthFmLerxYRyRnQAGu9i4iGzxxehxHKzKKn0R9h4m5rsViEv1mXWDzD9NPPUiWW
         FBr2VKRs6JcEu3MIcoi0foZhxrvEoebpsHnZa7k6bG/FeK5vNDIkUfYEKK58yF4Dhe5T
         SyEKfptMZ34laNs2EU00rRg/85uuaSias0XqL2NAqv7CYOV+Vd/4wlk8/NBJt5vI6gmU
         p5rJkzqYqIWHFCvAhk6yXW6YCLXSovQLaRdpAykw4b3YI7G8d2jcTcYtKRVGVpLSF9ER
         6HRya/eMrU9dk7yN16dsvnv37D2OEP7ukk71see3XNPPdNRlfzNZCHrsbxn+jLYneF4R
         VrxA==
X-Forwarded-Encrypted: i=1; AJvYcCUkk34/O0mL0GdEDNU+rNN4SW3Sh4juhYglR6Mi0uS7FUPha4NiSg7fM9DbGVyPduvxbm+Q+Io=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPbP92VXmZqE4F6aFdlIZ77z6BoEogz5Yb+4bul7g3Xu91g/SK
	bS6uv/uqtfe5QpcpQJkEyRUhsxu0gj8xIaBkocqP/u+QzdxbxqdpJsIEyEGYbNPfYWxP+WQvQms
	PQGQrew==
X-Google-Smtp-Source: AGHT+IFcxl+kjHOGS/nBXCN0NLe4u/87K6BJXliGaCRn80SWPlg5pVaX5IEoE/dYZUJQiQ95jLOFyEkscPY=
X-Received: from pjbqe1.prod.google.com ([2002:a17:90b:4f81:b0:33b:dce0:c8ba])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7348:b0:34f:2070:89d5
 with SMTP id adf61e73a8af0-34f837ed94fmr6558876637.11.1762389250212; Wed, 05
 Nov 2025 16:34:10 -0800 (PST)
Date: Thu,  6 Nov 2025 00:32:42 +0000
In-Reply-To: <20251106003357.273403-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106003357.273403-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251106003357.273403-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 3/6] tcp: Remove redundant init for req->num_timeout.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Yuchung Cheng <ycheng@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 5903123f662e ("tcp: Use BPF timeout setting for SYN ACK
RTO") introduced req->timeout and initialised it in 3 places:

  1. reqsk_alloc() sets 0
  2. inet_reqsk_alloc() sets TCP_TIMEOUT_INIT
  3. tcp_conn_request() sets tcp_timeout_init()

1. has been always redundant as 2. overwrites it immediately.

2. was necessary for TFO SYN+ACK but is no longer needed after
commit 8ea731d4c2ce ("tcp: Make SYN ACK RTO tunable by BPF
programs with TFO").

3. was moved to reqsk_queue_hash_req() in the previous patch.

Now, we always initialise req->timeout just before scheduling
the SYN+ACK timer:

  * For non-TFO SYN+ACK : reqsk_queue_hash_req()
  * For TFO SYN+ACK     : tcp_fastopen_create_child()

Let's remove the redundant initialisation of req->timeout in
reqsk_alloc() and inet_reqsk_alloc().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/inet_connection_sock.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index d9c674403eb0..2bfe7af51bbb 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -885,7 +885,6 @@ reqsk_alloc_noprof(const struct request_sock_ops *ops, struct sock *sk_listener,
 	sk_tx_queue_clear(req_to_sk(req));
 	req->saved_syn = NULL;
 	req->syncookie = 0;
-	req->timeout = 0;
 	req->num_timeout = 0;
 	req->num_retrans = 0;
 	req->sk = NULL;
@@ -913,7 +912,6 @@ struct request_sock *inet_reqsk_alloc(const struct request_sock_ops *ops,
 		ireq->ireq_state = TCP_NEW_SYN_RECV;
 		write_pnet(&ireq->ireq_net, sock_net(sk_listener));
 		ireq->ireq_family = sk_listener->sk_family;
-		req->timeout = TCP_TIMEOUT_INIT;
 	}
 
 	return req;
-- 
2.51.2.1026.g39e6a42477-goog


