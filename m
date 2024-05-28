Return-Path: <netdev+bounces-98542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C78E08D1BAD
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D8B283EC9
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF1816DEAA;
	Tue, 28 May 2024 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="glx0VssF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB0916D4F3
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900786; cv=none; b=XyjcvbaZSiyglHKPHgLX4fepzroDKT7m9B2QimiVGAHxwmTnZgZr4bu2+A8d0YY1KNyMAi6fgb+IkgM3zZS6sI8RqPOi0x8n+Tf7GTkxkKuInAPrJYzkT+VwJ7bFxD/8081GgRRCH2r6rk44bCUl5t0Z1/peugIxw14T2UnGmoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900786; c=relaxed/simple;
	bh=pYrpnj9qEJNrzPZs5QvSoB9k+98J83la6B/Kzh7YfGM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mr2GcxZsMYDgxZo2M6NnozPXNTIBlBrQz28ZHGKoBUU70SFXsyZj3hrDQxDpavJUDHUTJzBBtQCYd3IR+6wdxrc7x5SPfDIj8PfjyHbogUSNEGwo8IY6hKQHevWYRrlN2+l0Xz39n/hgwXbGmyDoHGuHBLykXH/2AvIwNHeZs48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=glx0VssF; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df789a425d3so1262578276.2
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 05:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716900784; x=1717505584; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fx1W689gp3VBSmd/ZEx43mJ41Ke2ptpCRI0QsLbql2c=;
        b=glx0VssF/HImCdoiAetRxRkIFraNLg6vqV6jceDXboHeg7uYwPLqy0/AOGrMf12Ro2
         2rSl1/sgsinj+8deEEnTOByjavyWdzeLNqiStmEACxsS7QRP1DR7spux0U4jWX0IVUVt
         W3DVD0Zu1XJeHGSceENQDAIlXKaNlMuxEJ5WI1ix4SLfkoAG5BbRUbyz8Tdy0K5TmaQS
         NqpYaG+2LLlTW33NZzOBHOLxB3jVfHPpYjBCSsT+IAGYzHkZqgh1MEsHBKNL3y91f08w
         iT8IsxRTL/Us8sYOIRbh97Kgs7ED85tHUmkzKQUhX2SN01tmb6FEIDXFmjJa7Iql4XyE
         YvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716900784; x=1717505584;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fx1W689gp3VBSmd/ZEx43mJ41Ke2ptpCRI0QsLbql2c=;
        b=uO+vRXkFRvg+xYAmdeBP3mRcrrVpMctEJjgziyzVNiEm3vwOFjScvo+vUZ2XFAF21t
         DzL7oZ/Y9cXzXZeCgB9r6J+noV4f0v0zn0i07A8KH0nNIqS/WVEY3lU7h772snmWab2s
         IPCkM2txyxDg1r0vXhzMhL/bRHxS9xer1dYXmfXQ+GlNZKBd0peRWn7IbN+pOeZU6pFF
         N+1aPC9elmZAXI2gGBeNlmdmr0YKuRxJTVzAnMGLuuvvb3RwgVE1kthiQhzQyP9IMuVK
         Y9gm6B3wDprLO336p+7+FTZHqJ1OtEf8EbAeZs4cDuIqT8Hy9qhq2Q/Uk/akQ0xtSX8B
         I8BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGTAvR7nxDAMiCUzI1DiBge9Et8TOxr5EPzWwmgVyvDuThw8sPh3Uet9sP88qa/NuU3uSP4hcM2sAYSAwME2x1HzJWlsPA
X-Gm-Message-State: AOJu0YxPTn3XwZsCGAXEdv1E5mRZ35tgl30efPrRBdadyKQyvT/VVn07
	Zps+inI2Vy8E3/K90U9mPhyro11mgZ7LLnfhQ5Y+yHc9obA0LHBqC6XeW6nJcJP7vXnPU3kIeiT
	gNhTpaTq90g==
X-Google-Smtp-Source: AGHT+IGb4UztoKRBDvTfhBRs1hgXQHdUpsqBw1d/oWFbDxP33sd+IOeyYh5Qdwfci/90gtyk9cj1NCI76WCpSg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2b92:b0:de5:bc2f:72bb with SMTP
 id 3f1490d57ef6-df77223c965mr1121270276.12.1716900783997; Tue, 28 May 2024
 05:53:03 -0700 (PDT)
Date: Tue, 28 May 2024 12:52:52 +0000
In-Reply-To: <20240528125253.1966136-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240528125253.1966136-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240528125253.1966136-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/4] tcp: fix races in tcp_abort()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, David Laight <David.Laight@aculab.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_abort() has the same issue than the one fixed in the prior patch
in tcp_write_err().

In order to get consistent results from tcp_poll(), we must call
sk_error_report() after tcp_done().

We can use tcp_done_with_error() to centralize this logic.

Fixes: c1e64e298b8c ("net: diag: Support destroying TCP sockets.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 2a8f8d8676ff1d30ea9f8cd47ccf9236940eb299..5fa68e7f6ddbfd325523365cb41de07d5b938e47 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4576,14 +4576,10 @@ int tcp_abort(struct sock *sk, int err)
 	bh_lock_sock(sk);
 
 	if (!sock_flag(sk, SOCK_DEAD)) {
-		WRITE_ONCE(sk->sk_err, err);
-		/* This barrier is coupled with smp_rmb() in tcp_poll() */
-		smp_wmb();
-		sk_error_report(sk);
 		if (tcp_need_reset(sk->sk_state))
 			tcp_send_active_reset(sk, GFP_ATOMIC,
 					      SK_RST_REASON_NOT_SPECIFIED);
-		tcp_done(sk);
+		tcp_done_with_error(sk, err);
 	}
 
 	bh_unlock_sock(sk);
-- 
2.45.1.288.g0e0cd299f1-goog


