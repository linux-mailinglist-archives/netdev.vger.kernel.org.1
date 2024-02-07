Return-Path: <netdev+bounces-69835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DF784CCA0
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27F24B22F98
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631807CF23;
	Wed,  7 Feb 2024 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D76YsEFn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E90E7C6C1
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315926; cv=none; b=DmkvbQeTB04hd42IZjp4UpRA+nr9bltZ7xCEnK/RLRUisNHheiYYhvcq0C5Y9LPU/2aDOl4TPhRK0jqZKyMDeGHYdGS5ptmDMCeFM+aLBsUTyb2QDnjdBqh4UX6QXLRxzxFph8hAEGSLxFYniMBg9PMo0T9Dcu5/zcXCQZRgrJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315926; c=relaxed/simple;
	bh=HCyYrngSrZvrV1SzxJ5+z4z/cd/JbrU/tC5B1LZbXtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRFRfaxPbcn8pNRcddY+sLfowT0vO41co89QIOxw5XrEH5PVY2JBHGZ4WZECSSQutdRD91MDBYXAZyhUT+pqdOKkT0a/9M00BRxDRojqW/r+6FarTyfx6/h097aTpxnUMiYBDZxnjDKA79cmcyCB5ThcbVPI6sf31lzv47oRoms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D76YsEFn; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a370e63835cso86847766b.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 06:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707315921; x=1707920721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVq2ICnq33w1x0k8fID+i/BmIWX6VXGJvRBeZTrxg9s=;
        b=D76YsEFni1+1CCGotRktqhWks9hKUkAETBcnHY3mCwz9d9/9ccw99Pxn4K8wha/gic
         IHq9V7ypY3XD5VpEfL1in9qrWNozFJdF2V2oStNjNRrPKRih9/DCwgCdAlSImUpnFTxu
         NaW893S5exCG+fmmfLhRTXh+KedJCh5dg+tvYkQaOuTNfbPpy+MZs9uUpcSpwlOOhRac
         UE6Ef0C4v6vlfMsaBhQnYqTckSpWb9FIxQO9bfQ9Qpl/LoEiLrajFyelrZt8ffAKG6gG
         l56NVv7p7T0BngI+6IH4Q0IiqInSfE04ogxNQK2cRuZZcEYlq39T5obx6Ab+JDQn4ftb
         WEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707315921; x=1707920721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVq2ICnq33w1x0k8fID+i/BmIWX6VXGJvRBeZTrxg9s=;
        b=bKQdX8DXAM/vyn3J3FbjQR6sxMF3v+4+9okwGuAhfqyHX4WiqmJ/sk4k4xqHF2bxL8
         Q7UB+N7h09oV2831LuMwx5DyiOC05/KCu4XcGSVA8DUeeb0OOblwRzgq89vkDZpK+SYE
         ZwhYkAkMfP3hRCrYRaow9gtoavyHcNgSUc2PXaCG34GbSbR3REv7Z2baedBTZLU2R0VT
         h6kGW85AsvnDxyJnUT0O812Cysckbyjz7pendOod/+bFaKP5KSGH/cxA8Jp3mJ5TTe17
         07uI9U7C2UtwqsMuYs3yAMP+Iuuic+mqQ4+PaN7X6yWLb0V/Zjz4XhTXXJx21dHWA0Od
         N3Kw==
X-Gm-Message-State: AOJu0Yx5/c8TGALw8SMFsiEse5X1hSau4Qk6tF1mfwZLOjrYNLtAd5BD
	U2yHQigvTOzGWTKL7pJLy4Re+vgfty87HllRWCIS4AL7Vy7GPMLd7/y2eql5
X-Google-Smtp-Source: AGHT+IGLJZM/UJXufXVqIjPJKn9b2tUFielcAjrQVyaQ2ldX+7ZCvIaFHAjurb91XrvDCqkwApIGsQ==
X-Received: by 2002:a17:906:1c7:b0:a38:578b:d73 with SMTP id 7-20020a17090601c700b00a38578b0d73mr1849463ejj.0.1707315921083;
        Wed, 07 Feb 2024 06:25:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUsvrfiaP10sNFBPmtwZQLAIGt0Fw4S/VY0JrBAxkd5AyiJJFcvb3/jBfcrHQ7mMiEfBEpQo9ELp+37MMkqlV9FtQ2qUCKjXWC77MQKYkNCr6zViyGBOTZSxOs+8kn/g22+amAUJKm0OuKNwVm7QakAGC94LolU5NciqDHG7NZzJkOXCb1KlspL0NnbTmDL9wM=
Received: from 127.com ([2620:10d:c092:600::1:283])
        by smtp.gmail.com with ESMTPSA id vg8-20020a170907d30800b00a3807aa93e1sm808913ejc.222.2024.02.07.06.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:25:20 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC 2/2] udp: optimise write wakeups with SOCK_NOSPACE
Date: Wed,  7 Feb 2024 14:23:42 +0000
Message-ID: <fc4fb618b3c3760dd10e2cbcee0d0050be8cdac9.1707138546.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707138546.git.asml.silence@gmail.com>
References: <cover.1707138546.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Often the write queue is never filled full, however every send skb would
still try to unnecessary wake the pollers via sock_wfree(). That holds
even if we don't have any write/POLLIN pollers as the socket's waitqueue
is rw mixed.

Optimise it with SOCK_NOSPACE, which avoids waking up unless there are
waiters that were starved of space. With a dummy device io_uring
benchmark pushing as much as it can, I've got +5% to CPU bound
throughput (2268 Krps -> 2380). Profiles showed ~3-4% total reduction
due to the change in the CPU share of destructors.

As noted in the previous patch, we introduced udp_wfree and it's not
based on sock_wfree() because SOCK_NOSPACE requires support from
the poll callback, and there seems to be a bunch of custom ones in the
tree.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/ipv4/udp.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 90ff77ab78f9..cacfbee71437 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -803,9 +803,13 @@ static inline bool __udp_wfree(struct sk_buff *skb)
 	bool free;
 
 	free = refcount_sub_and_test(skb->truesize, &sk->sk_wmem_alloc);
-	/* a full barrier is required before waitqueue_active() */
+	/* a full barrier is required before waitqueue_active() and the
+	 * SOCK_NOSPACE test below.
+	 */
 	smp_mb__after_atomic();
 
+	if (sk->sk_socket && !test_bit(SOCK_NOSPACE, &sk->sk_socket->flags))
+		goto out;
 	if (!sock_writeable(sk))
 		goto out;
 
@@ -2925,8 +2929,19 @@ __poll_t udp_poll(struct file *file, struct socket *sock, poll_table *wait)
 	/* psock ingress_msg queue should not contain any bad checksum frames */
 	if (sk_is_readable(sk))
 		mask |= EPOLLIN | EPOLLRDNORM;
-	return mask;
 
+	if (!sock_writeable(sk)) {
+		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		/* Order with the wspace read so either we observe it
+		 * writeable or udp_sock_wfree() would find SOCK_NOSPACE and
+		 * wake us up.
+		 */
+		smp_mb__after_atomic();
+
+		if (sock_writeable(sk))
+			mask |= EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND;
+	}
+	return mask;
 }
 EXPORT_SYMBOL(udp_poll);
 
-- 
2.43.0


