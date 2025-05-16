Return-Path: <netdev+bounces-191199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C39ABA617
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F543AB49F
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 22:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4535323D28B;
	Fri, 16 May 2025 22:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Grm5bnh9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A861E521E;
	Fri, 16 May 2025 22:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747436087; cv=none; b=bznqHhkRs7TP0EzC1uhWLdWyzBip1OalZmeXyBbqW+rVzW5TGfWOd6IZAbocqW8KxlN+KSPL1Bx+Fp3v4B471wsBHKy01oNanM+nokJUoWQe5F6yefFgN62jUWRc7mYnI1YPdm5NonQmYKVbRu6sjojpb+iZE2LtEn+gircGX+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747436087; c=relaxed/simple;
	bh=v3cWhd1vNtvrHfrS+i3M7IgPa71DzHKp/2mIEawNdkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IaSK8VkjjEiWPRZbUKqI8rUsbuywG0hblUNAhp4hZaTfr+TPWmF24RZK9g9mbY5jf8PzazZiJw7ZsSDlCIYOPNL8gG8z71KLi3F5wuLs4CGJNmukpD44k/I/e8Gnx+H34d0KzK1XRIsplXeoc5+eLiQivHRs/eld7x9nnKSxqmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Grm5bnh9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-231fc83a33aso4288175ad.0;
        Fri, 16 May 2025 15:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747436083; x=1748040883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=COidKuiMACdMYxeiMKg4TC5hlLkrFR4VA4D6n0AnHxc=;
        b=Grm5bnh9oeh5vgAE52iFUvZ8UhIQg4R+dXsOGnz8103g86VizttrwfeEjU77XMgl00
         mASq8Bhn5IHFRSMHISv6fbCBefrxJSMr7pHLVs0vbomw8O2njUg682fmugAPIGJyNDJ1
         HL1BgTNupHJxgU77A0ZMm7OydPwWU2SljXOAGFivAkLYxvLp/zk0NT9p7mkbzep7tFx5
         rGo5DoJAL5tW8k7Y7D8GyAVi/EM3doVIwwQ0VGgrNNa8Kol3WD3GGiufvSiBHD4/BJON
         t5Tmy1zKVqSSZnG/yI31NIJPp213EOV58Go2Sw4Dm4mrtp/PZWJRdMDh2x3dgTzLncY/
         +DBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747436083; x=1748040883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COidKuiMACdMYxeiMKg4TC5hlLkrFR4VA4D6n0AnHxc=;
        b=jGws+F7InXRXcOsdbIzGjnM8CMra8JW2m2/j2jY1syPdHX4hAUomGCsHKuZNvLXTzr
         m8hFCObpmN3pfvKPj9Kut6+y88+eBNWx/0FZfDUDuST0rAxof9zxr3/9i+yMO5v2Y6Dy
         BX9u4whKIJRje2Z8f2aJBAPx/Qe9hig2jx3Hd2krwoiGUsL+lkrjEnbKcxxALY4Hkeh8
         psy0FeJy12Sk2wEQvCR2GqlGNlru5a5s5Lo/gxFCY1wm0s5EkUKOlgfYNSSUgy4ke5/1
         oLvec40xlE0kaUP1+IfqWELOduxMPfqo6DffP8hydvcWuXcjxXrvlfCRI6pR30mrtwTa
         17Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUtjBOcYioOpXiJigElhNcNolz+3ORakIROya54es1z9LDLjLDgEWEtKXhEArAz2ccyf8/j36djFdfb+r4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdbFilKH0D1uXrHmUbXJvD1Jh0poLG28tcMMhEQ5rPxhviKm49
	CzO4fJabpP7HyPUHGtKjl6FAU2M2bpnjhmU+qaSYyQbZBtXCg57S05HM8hn0ED4=
X-Gm-Gg: ASbGncuxsI3X7L2xLveR1a+WF8ktJiYFd0ILVOPz709PSpm0rb+N8fPMtGz5y7ZvSqY
	fwiM7GNl5EdMZ3hug//PlKwRpGMylLL7VtxzmfOvqdmADJAt8AmJdHZnFFDlWjsx51vpvmj65OH
	zemkCUyr+C3cEvdjFZJw+wzJOz3DH/OoF7xajjYf+7SM3EffpZ8x3/2BNwZUivB2doyHwtRffZD
	rguzyFX4fSbtAjZhVNKOk6AhKktaEcrEJ5YLW0Z3Ps3P63U6bdaNEA8aAhNNCZI/jJAtMghMoAa
	9W8w5x7blV1PhdfWzvytOFj+dAlXfsvZle0rO6OvrNi0YqvGpCNQbpqbz0GtTx62EoEycEYzrJN
	vaOtgh6EJ6Uxe
X-Google-Smtp-Source: AGHT+IGCgQ00+3wiGPb1pop+iKe/OzPDLR8EViYz8zS4HtBxYDywNNXHkuEGd6tpKI5DN75Vq+PzBA==
X-Received: by 2002:a17:902:e78b:b0:231:c992:3722 with SMTP id d9443c01a7336-231de35fea0mr50981155ad.16.1747436083141;
        Fri, 16 May 2025 15:54:43 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4e97db8sm19455585ad.110.2025.05.16.15.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 15:54:42 -0700 (PDT)
From: Stanislav Fomichev <stfomichev@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sagi@grimberg.me,
	willemb@google.com,
	asml.silence@gmail.com,
	almasrymina@google.com,
	stfomichev@gmail.com,
	kaiyuanz@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: devmem: drop iterator type check
Date: Fri, 16 May 2025 15:54:41 -0700
Message-ID: <20250516225441.527020-1-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sendmsg() with a single iov becomes ITER_UBUF, sendmsg() with multiple
iovs becomes ITER_IOVEC. Instead of adjusting the check to include
ITER_UBUF, drop the check completely. The callers are guaranteed
to happen from system call side and we don't need to pay runtime
cost to verify it.

Fixes: bd61848900bf ("net: devmem: Implement TX path")
Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
 net/core/datagram.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index 9ef5442536f5..e04908276a32 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -702,13 +702,6 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
 	size_t virt_addr, size, off;
 	struct net_iov *niov;
 
-	/* Devmem filling works by taking an IOVEC from the user where the
-	 * iov_addrs are interpreted as an offset in bytes into the dma-buf to
-	 * send from. We do not support other iter types.
-	 */
-	if (iov_iter_type(from) != ITER_IOVEC)
-		return -EFAULT;
-
 	while (length && iov_iter_count(from)) {
 		if (i == MAX_SKB_FRAGS)
 			return -EMSGSIZE;
-- 
2.49.0


