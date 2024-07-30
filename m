Return-Path: <netdev+bounces-114156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC37941342
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A583C1F25389
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8D81A01AB;
	Tue, 30 Jul 2024 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1/8Obk6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D3D1A0720
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346548; cv=none; b=jBGjh+zm0vv+bNp83IBNsszT/fliFyazjKSh1SIN5sa+MoQuiIW99wsuWmJCkfuB7KEDz4TNHMlY8DDXHTnXG9xPjkMzHZKYVfImizZJLtqlDXDry1bEKNTCn3Pk6BPKOum1FumSxxhQEOAcOSuqrGNyJG/pddEzuBeWrOq4mbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346548; c=relaxed/simple;
	bh=TJhLBE/1dDFmQcXMCrFDSflxqCoEQKoFBZolCz3PYeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f2cx58CxYh4OMpyFhztmjKwUx2Ej2K7DFwWvXtM+ofo1xSKmw2GN6MJegGZG8pOnZG1bYfGiDI/+WYpBxcqnMMeFWEzgArOYBP2IeSR39ZPOjwXoAquop8fG1rZRSpCTWtUBfSy488oYChM71mwPGs297NB+QkDtQQSMsbFlJPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1/8Obk6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc65329979so35901515ad.0
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722346546; x=1722951346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lFhtVGvFg8VrMx6un0IDEAfYudNTjtIlz6cdmYL4D8=;
        b=c1/8Obk6ZJ/JJHrC5ORsbCTwdJ1DF6YJ7lGiZ6XHj9/yX+dZ7atHsFWl3iJycqnzn0
         ya7pPj/lOOo0R/WzGAkblzDlZ01cvgP9aECl5Vk/iO9UJzOOu+9tWTJYo49kCngcPnoz
         o68pC/aYLRLEChDz5OK3edrdk/pq+VxJ/ZRs7uU0qvGQExHD6eJ2W/uUj9ZDEdoJlP0T
         +viTBOsvRhbvVgUvHmFv7h0FhpRCUlz6mXD+ql21GMaOrIxOiARYs/Z5CgjI6XU6SVsl
         +lAb4gCVVH3lMOCXem5gMnqbg8NsE1HFrHOrZsPWnqqpywG7eVGuqzq9Z4nKDOWgy/cM
         Ds6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722346546; x=1722951346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lFhtVGvFg8VrMx6un0IDEAfYudNTjtIlz6cdmYL4D8=;
        b=I74+KReS15QrKCKnbCT12VxRkG3Al5wJr1x823R2qGCx6en7lJoh2JUdztZ2Uu1iKV
         6CxBuDk87B7ZNIOiUrv5dqymQ1X7jIGtAOMt4sLuQ6D+7OnZfdK64sXdU8lBvGuOyVPB
         qEUZxNDkjwv1m3Q+nLE5+YXo6i26hNpJswfKORPGzwKrfKt5eGIvyiHmg/A0HHGawQTm
         uTsZdhZDmL0AF5XkWqiuVwU+kbgN3/pgxIr7Of4vHhT2YF/Tf4nF0NEfBwsFE8gZTIig
         Bz7ZiAkqGLhdGPjpqNfIErB/3jXsJiEdTrMbCsAojNbmVw3IQNQhWXt4bJFHQtN8W5ah
         jOLw==
X-Gm-Message-State: AOJu0Yys6I8c7asvZIlJ6S+SxKJHlu2wCj4+hmv62onA+heWh9Rcloym
	GdRZHvTdnYpTKn9+8Dc4MNfHH7NI7CgGs7eUG98zmlLtKOSxHsOP
X-Google-Smtp-Source: AGHT+IFGRSj1xTQLos2xhBwPDep/WWZJwNEQ8UUgyLSGhW+6edpBqJV4isvR3KHgWcL6TLC8YOj5VQ==
X-Received: by 2002:a17:903:2352:b0:1fd:5fa0:e98f with SMTP id d9443c01a7336-1ff048d4d3amr126359945ad.44.1722346545692;
        Tue, 30 Jul 2024 06:35:45 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f9f279sm101562515ad.256.2024.07.30.06.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 06:35:45 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 6/6] tcp: rstreason: let it work finally in tcp_send_active_reset()
Date: Tue, 30 Jul 2024 21:35:13 +0800
Message-Id: <20240730133513.99986-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240730133513.99986-1-kerneljasonxing@gmail.com>
References: <20240730133513.99986-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Now it's time to let it work by using the 'reason' parameter in
the trace world :)

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 16c48df8df4c..cdd0def14427 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3649,7 +3649,7 @@ void tcp_send_active_reset(struct sock *sk, gfp_t priority,
 	/* skb of trace_tcp_send_reset() keeps the skb that caused RST,
 	 * skb here is different to the troublesome skb, so use NULL
 	 */
-	trace_tcp_send_reset(sk, NULL, SK_RST_REASON_NOT_SPECIFIED);
+	trace_tcp_send_reset(sk, NULL, reason);
 }
 
 /* Send a crossed SYN-ACK during socket establishment.
-- 
2.37.3


