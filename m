Return-Path: <netdev+bounces-118765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C30F7952B48
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 11:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344E42828A9
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 09:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73AB1A08C6;
	Thu, 15 Aug 2024 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dESvSrli"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EFB19D09F;
	Thu, 15 Aug 2024 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723711437; cv=none; b=S9B+I+DfVqLO0Nszhca08wOz3rbnzf7gIr2ZreH3BJt3ZAGEXr2gnDTzUqOFj9VWZJr9npIln7Ersu6Ojg7C9vc0sp4nGV/sUqtZHBrmBunje4dKzmMeoqcy18gkUP3mjgLBhDv6DtvMVI9w8gBGTq2FsFOo6lNy3+y56XPFqEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723711437; c=relaxed/simple;
	bh=FO7AnkhwQyc9LhN8JC/o1Qjan4QTR/ZpW+sH5LA0iWs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t+3TeqzZSn80F/SlaPB3hKfbAB1ArtYtfFdqv/k9PLSzW6EbRpgpAVG4s4iJ2/eyxkmEcgq5SmDTDg6uKBx6eA9EozH0iumsuC75oGl7imvPmDhRRA81bP2uJuTTLIg2KjqDdV3CTDLDOs4OWDOzEA2r/y0eKyIipmStHx8Ixig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dESvSrli; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-201f44ad998so1348985ad.0;
        Thu, 15 Aug 2024 01:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723711435; x=1724316235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lPX9A1uvCQ4gNMQHnZ6Jg67ZdZgU4Gk19HgaovouPWw=;
        b=dESvSrliPxXPgu991cxBFNP4uOKdJSK4+Dez4jrt7wK/mMTp+cxrDVB/SKQe+X+v+p
         l5lU8WG/JcK0AZpG1Rcwz2Lia+oo/dmjKmQfQSoudzjdiVK+eHu/4yDjhO8tsCAwFkcB
         zQjuSutPR8Ox2gtAA4Z6Fp3YUnqlgddcw8NxfW8+Bwf+Col7PPu3H8TMp46hdYTe8P0w
         oA4T+WHozfBitiYuS5FGwUqRguqD1lp25IxoOaLTvrAPt4bZGhivSrjFH7a20GpYjF10
         9KLdoFF/GewS1ANWD7/ug0y1pPnIjTuwktnVKsMN45fHmu0JhuhmhEweMjt9rWHwUVl5
         p7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723711435; x=1724316235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lPX9A1uvCQ4gNMQHnZ6Jg67ZdZgU4Gk19HgaovouPWw=;
        b=HXwaJiNPqOGDlTnshOrG52CljwmtmML6aGyPUAqJlydCtRdY14SN+1Dyys+6NwU3qn
         GOPOhtaqP3Yx0dDzmlU3gugH0CyfJmyA1r8c6+ILYA8X2M6YgIZ2HGP8QE87r4B0ouaK
         GWLzAUXG0MKnh0zSGIH2KiwurAYaP/KNnKCjOXIeeJKD5JzZm7AA32aa7zi/AK/gYZOA
         v1zAj7s7oAOwSr7IdTv/3/o2MACBgkEPe2O2dGzFNjLR4DD3Z0vAeEDyP23HM/lEKi9E
         AVDIlcsxbSL6ZUf00Ufec65TH0wFUayv1aqJFlMgGue/VGzy8Eu9OXfuvOMRWFNi8lW5
         0uSA==
X-Forwarded-Encrypted: i=1; AJvYcCWiKqIAmCJb9Anr/OWkkGjtORhFd4V0pK91JNvHjreccYlAVYHfqKcSKpYclt5/uF+BvS0jY7shvGeR9QrlRFxysU9RJCT96pLEYo9Z
X-Gm-Message-State: AOJu0YzGTzBM4XkMncoXFNnd9rB3Igo3BnL2z/vEbtlt7DsbG3l5Doe8
	32V2vnKO+VB9I1qk20Af2PAgOwWnpLURYwJNL03qht0NrqbsqQ6As5/0yRgh/93OtQ==
X-Google-Smtp-Source: AGHT+IFG5IUzajGO8WTnXHCc/L6HrLRQovNVOWulK/PTn9tc6hwuJYOydAxLLcEQZtHaGhinVaFaEw==
X-Received: by 2002:a17:902:ce83:b0:1fd:6ca4:f987 with SMTP id d9443c01a7336-201ee4bc32cmr42639545ad.15.1723711435400;
        Thu, 15 Aug 2024 01:43:55 -0700 (PDT)
Received: from localhost.localdomain ([49.0.197.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02fb4f1sm6814175ad.1.2024.08.15.01.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 01:43:55 -0700 (PDT)
From: sunyiqi <sunyiqixm@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunyiqi <sunyiqixm@gmail.com>
Subject: [PATCH] net: remove release/lock_sock in tcp_splice_read
Date: Thu, 15 Aug 2024 16:43:30 +0800
Message-Id: <20240815084330.166987-1-sunyiqixm@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When enters tcp_splice_read, tcp_splice_read will call lock_sock
for sk in order to prevent other threads acquiring sk and release it
before return.

But in while(tss.len) loop, it releases and re-locks sk, give the other
thread a small window to lock the sk.

As a result, release/lock_sock in the while loop in tcp_splice_read may
cause race condition.

Fixes: 9c55e01c0cc8 ("[TCP]: Splice receive support.")
Signed-off-by: sunyiqi <sunyiqixm@gmail.com>
---
 net/ipv4/tcp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e03a342c9162..7a2ce0e2e5be 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -856,8 +856,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 
 		if (!tss.len || !timeo)
 			break;
-		release_sock(sk);
-		lock_sock(sk);
 
 		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
 		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-- 
2.34.1


