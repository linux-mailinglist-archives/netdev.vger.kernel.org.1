Return-Path: <netdev+bounces-228817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB25FBD4F12
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84C114F7C12
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08DB30FC20;
	Mon, 13 Oct 2025 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RWDRL0Ix"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6FC30FC10
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368963; cv=none; b=ryIoidpx/ncYVEGRv5S7ugga84tp6q2nmVyxgisZWVJUNxgDCntfCg4LpDeEVFlYAhRTG+ZkYzi/lUMqZG2vOvVyFGzMTG/wiu6j4JZiQLd1MEhv+Y3x+KDsHFCf44V9KBQ+yRn7TXJF0HbAzZDTg9rvexTd6UVbfeeAj8Dv1CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368963; c=relaxed/simple;
	bh=3PKT5F5Wu6Ai67ZeyOe3ty9uHQ3wmdloW6fOxBrZ0g0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fhwTDqTyyiOVcVgx+oyS7eGFf00AcRPDFnc9b8c90pRh/RDaEAVFGl1GihqfYO/2b3P7JrVF7lMM45I88LvW9z63KGSKlayO9bjYLgNmaRsnTwIdZyE696ouE3rX8f7ZphBK5jR12QlogxCpUoksqSqcIVEmZLlhBNAvwvMl+yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RWDRL0Ix; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-857003e911fso2378500885a.3
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 08:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760368961; x=1760973761; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aXcXLtIs4pgi4OktKnuw1LX3MXBscDyEYwVUphhECoQ=;
        b=RWDRL0IxicWvLFxVghZ+B+6FSwFyxcob3ksqBSxRgjFsskywBRhcOgaHDrLJ2FjmIc
         OyyWMIr4j+bdFidMV0UBlD4xHRwkrBXNbDXGNWVPl4whxNx8cySmG60ArUuIfqtDk3fk
         zapkuz9fpluYNNHMgYiwhzXkco+atVHRbumFYzYZe3aoyk9DSN9P2msKuZVZePVWBv9A
         BJKHU1X5XknnyidwzDq06R0Zj9M1FfxW27l9AbS5pB3CxjeTwqMMXV69Tsk5f3J66EOU
         EyKig01DLNnu3SryB4B9feRxoUmTuw3Ww3/R8jgrNy4rw308WAqCkwJEFMXFuTYzsQs7
         k8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760368961; x=1760973761;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXcXLtIs4pgi4OktKnuw1LX3MXBscDyEYwVUphhECoQ=;
        b=SBEoePcQqfq4sqXrnk8pHuTnCWc/+ffMAKU1aq2WHUJxU0patOsotUhTH1RmTbcXHb
         yAjVrU9rxE5XuG5wNlqU9wnQeVKz09v/TUcLnZHOdQHwH7a2hBpQsDOda33xzQPjImyT
         iBmHB5FBb1yYE/Vqt+HyApNRd2fChPLu4QkmhokDqFHcX5QU7EWx4i+xttPWxsWbbue9
         sNZb6EXc6zKALkhKdIN83gV3BiAbmvBiMVDDLa+WRkEuEbMtAuhMPWYUAsDFFe7tLyT/
         uTUDdyaPnTkRdU5cbeIeFNKrNZUhgCMMQEpR+eP6PbrDw+f8pIaPOyt4dGj/qUzHN7FQ
         xepw==
X-Forwarded-Encrypted: i=1; AJvYcCX2XdX2y3n7QhUMtfmMUlSu+TRPLop7YxGI/8mvaNWsR82rbELkIY5uFbROu3POad+DraFeuF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJVS9jOe2Kqd6E2DU1ljYjad5loTflZQ7p6d9mLvyKF+IqeGu/
	M06Ok1GTbJyypd6oyfcS27C27b6MeoMU2JrpG2uDKcAuQehOlQAIKVPV9+WCx0z7esPg2H60jQk
	Lt4zYhBYhyGH1Kw==
X-Google-Smtp-Source: AGHT+IEi91BGSYBG/rPMUUyyAXc7pAOvyG1U6x8+GyhLvazrulBdxlOGgCKnQc/LqMOU780+TFsbyMGsYXHMsg==
X-Received: from qkbee9.prod.google.com ([2002:a05:620a:8009:b0:82b:426f:1315])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3909:b0:7e8:46ff:baac with SMTP id af79cd13be357-883502b5152mr2962019885a.1.1760368960991;
 Mon, 13 Oct 2025 08:22:40 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:22:31 +0000
In-Reply-To: <20251013152234.842065-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013152234.842065-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013152234.842065-2-edumazet@google.com>
Subject: [PATCH v1 net-next 1/4] net: add SK_WMEM_ALLOC_BIAS constant
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

sk->sk_wmem_alloc is initialized to 1, and sk_wmem_alloc_get()
takes care of this initial value.

Add SK_WMEM_ALLOC_BIAS define to not spread this magic value.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Neal Cardwell <ncardwell@google.com>
---
 include/net/sock.h | 3 ++-
 net/atm/common.c   | 2 +-
 net/core/sock.c    | 5 ++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 60bcb13f045c3144609908a36960528b33e4f71c..2794bc5c565424491a064049d3d76c3fb7ba1ed8 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2303,6 +2303,7 @@ static inline int skb_copy_to_page_nocache(struct sock *sk, struct iov_iter *fro
 	return 0;
 }
 
+#define SK_WMEM_ALLOC_BIAS 1
 /**
  * sk_wmem_alloc_get - returns write allocations
  * @sk: socket
@@ -2311,7 +2312,7 @@ static inline int skb_copy_to_page_nocache(struct sock *sk, struct iov_iter *fro
  */
 static inline int sk_wmem_alloc_get(const struct sock *sk)
 {
-	return refcount_read(&sk->sk_wmem_alloc) - 1;
+	return refcount_read(&sk->sk_wmem_alloc) - SK_WMEM_ALLOC_BIAS;
 }
 
 /**
diff --git a/net/atm/common.c b/net/atm/common.c
index 881c7f259dbd46be35d71e558a73eb2f26223963..cecc71a8bee1176518a2d63b4613dbd243543695 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -157,7 +157,7 @@ int vcc_create(struct net *net, struct socket *sock, int protocol, int family, i
 	memset(&vcc->local, 0, sizeof(struct sockaddr_atmsvc));
 	memset(&vcc->remote, 0, sizeof(struct sockaddr_atmsvc));
 	vcc->qos.txtp.max_sdu = 1 << 16; /* for meta VCs */
-	refcount_set(&sk->sk_wmem_alloc, 1);
+	refcount_set(&sk->sk_wmem_alloc, SK_WMEM_ALLOC_BIAS);
 	atomic_set(&sk->sk_rmem_alloc, 0);
 	vcc->push = NULL;
 	vcc->pop = NULL;
diff --git a/net/core/sock.c b/net/core/sock.c
index dc03d4b5909a2a68aee84eb9a153b2c3970f6b32..542cfa16ee125f6c8487237c9040695d42794087 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2313,7 +2313,7 @@ struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
 		}
 
 		sock_net_set(sk, net);
-		refcount_set(&sk->sk_wmem_alloc, 1);
+		refcount_set(&sk->sk_wmem_alloc, SK_WMEM_ALLOC_BIAS);
 
 		mem_cgroup_sk_alloc(sk);
 		cgroup_sk_alloc(&sk->sk_cgrp_data);
@@ -2494,8 +2494,7 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 
 	atomic_set(&newsk->sk_rmem_alloc, 0);
 
-	/* sk_wmem_alloc set to one (see sk_free() and sock_wfree()) */
-	refcount_set(&newsk->sk_wmem_alloc, 1);
+	refcount_set(&newsk->sk_wmem_alloc, SK_WMEM_ALLOC_BIAS);
 
 	atomic_set(&newsk->sk_omem_alloc, 0);
 	sk_init_common(newsk);
-- 
2.51.0.740.g6adb054d12-goog


