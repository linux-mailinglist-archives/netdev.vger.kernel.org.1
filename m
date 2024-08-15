Return-Path: <netdev+bounces-118766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A3B952B4C
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 11:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB98E1C215AD
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 09:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A132C1A7055;
	Thu, 15 Aug 2024 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzDstLql"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1DA3BB50;
	Thu, 15 Aug 2024 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723711764; cv=none; b=eTeGfPJ1OYTHJ/6uv4M9UenJlLA3eWwdP5pB8NI/KZ3KGtP0obOGSHSH69G960B+a97F/GTCwZNGAaWr+TfJXzpa781UHQlVZevxDdUd/Gb+3RNxn3IQWxHYqf/56mx9t6azaD2Av2h+z2P0t4Bgfllhc1KzvsD90MhprtrNS4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723711764; c=relaxed/simple;
	bh=x6cfrw9ewFrW04J6iIIWOhc96i5MivrOrqwoT0+eaKA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PVxeKGx3q1hQzYALeQPNjADJHYjK0z7hTmWpFq6s41rWwcIkrI7z7y3fZyrCW1P/WXQyVWrUV6bRYBnJNmDZKEOSRaQIr6rSjrBiL7CjKUn8NSR0kvClhdja1XVQkJ4QfhBUSZfrq7Wrfyv7buqjSSDr3AgsVhUB8QpN4Y3S+Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzDstLql; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-710ffaf921fso442624b3a.1;
        Thu, 15 Aug 2024 01:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723711762; x=1724316562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jjyfox3IpSNF5AWSvpkHCJum/G2S79cF/ZC7AwMB4DM=;
        b=KzDstLqlJCk+NVCch6iXc354MvaBPVgxy9sd5kP2mfBPhohvpAq2fEj/gsgrc4MXwT
         ftMWb7bmFoCwo8PUem68c1Yy0SpjEy6dGnG0J4EGEB7C7rLaZVzHmrayQf4szyQGd237
         HfDsu92Bia032naaEoC3ft2/mulFSzApuM3c7Z6+P6VRYU9RvJn4J+IeaOIblgkk4hxg
         OZLrR0pXadWfiaA6T+PVODlaBSqiGdW0YAvn1XiqzML7lrxXPyW2BAMP3r9jqtvpzxlM
         qiCpgSIEx8+Ir9pChkG/9ngSOBsN42IdzkTUdC8rXNLphaK5HPfFp/ajxPbLE7UvhwN2
         lvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723711762; x=1724316562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjyfox3IpSNF5AWSvpkHCJum/G2S79cF/ZC7AwMB4DM=;
        b=AxT77GonskBhH/iJacRKOL2iXGieIjMCjlX+Z7798sk/xf+mZSnb+UyY1WKOl4KoH6
         4LkQn9jATigvAi0zCfdjyy7ahGJn5u1weNWMnPkFwumx3ypDq/6ANdI12JcSHfKXUToY
         VsasaIsl6YKP+HwlHsLOKAU7RH/lnGL2ojnvE60fM7DKYYDmye7fU5Seoa/FQXaLLcut
         xPfCihiROt3ZP8HL5fpNgcVFfYXHDZLRYpL3UnQhNuXg5rLx3eX+xpVUV4aSqmIt+TKy
         hNSET0cVwVGFBC47/e1D/MaSf+YsAwanv/G0L8ZYTLJKHnjvRLSrIIGnEFeHAIbMFpiX
         MA0w==
X-Forwarded-Encrypted: i=1; AJvYcCVi+FhNJm/RASsiWOd42fg6V08YWzPyZtbN614UXQm5Cq7h0+IyPWj00yn6PPp+bGRbM9B5aPq7VW/1PZg+qJODhBLF0aHOEjYDZHe6
X-Gm-Message-State: AOJu0Ywf9V5+uEY39+15/n26J/PHD4D5dTRSO9PpDMQ09R/m+pC4OmrB
	Gn/aDtyoz4kayRZGVoN/YQlKiovWQqzOAcnmQAxTMYV/MEQtTQ4k
X-Google-Smtp-Source: AGHT+IH5lKjlQ6WEzCmdTE7qT7klyvb26T5QM5uAccP0HGD0M1fd73L0yeTCBuAZeuCG9FHRbl32Pw==
X-Received: by 2002:a05:6a00:9157:b0:705:d6ad:2495 with SMTP id d2e1a72fcca58-71277039617mr3671072b3a.12.1723711762351;
        Thu, 15 Aug 2024 01:49:22 -0700 (PDT)
Received: from localhost.localdomain ([49.0.197.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0e4c6sm658355b3a.76.2024.08.15.01.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 01:49:21 -0700 (PDT)
From: sunyiqi <sunyiqixm@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunyiqi <sunyiqixm@gmail.com>
Subject: [PATCH] net: do not release sk in sk_wait_event
Date: Thu, 15 Aug 2024 16:49:07 +0800
Message-Id: <20240815084907.167870-1-sunyiqixm@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When investigating the kcm socket UAF which is also found by syzbot,
I found that the root cause of this problem is actually in
sk_wait_event.

In sk_wait_event, sk is released and relocked and called by
sk_stream_wait_memory. Protocols like tcp, kcm, etc., called it in some
ops function like *sendmsg which will lock the sk at the beginning.
But sk_stream_wait_memory releases sk unexpectedly and destroy
the thread safety. Finally it causes the kcm sk UAF.

If at the time when a thread(thread A) calls sk_stream_wait_memory
and the other thread(thread B) is waiting for lock in lock_sock,
thread B will successfully get the sk lock as thread A release sk lock
in sk_wait_event.

The thread B may change the sk which is not thread A expecting.

As a result, it will lead kernel to the unexpected behavior. Just like
the kcm sk UAF, which is actually cause by sk_wait_event in
sk_stream_wait_memory.

Previous commit d9dc8b0f8b4e ("net: fix sleeping for sk_wait_event()")
in 2016 seems do not solved this problem. Is it necessary to release
sock in sk_wait_event? Or just delete it to make the protocol ops
thread-secure.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://syzkaller.appspot.com/bug?extid=b72d86aa5df17ce74c60
Signed-off-by: sunyiqi <sunyiqixm@gmail.com>
---
 include/net/sock.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index cce23ac4d514..08d3b204b019 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1145,7 +1145,6 @@ static inline void sock_rps_reset_rxhash(struct sock *sk)
 
 #define sk_wait_event(__sk, __timeo, __condition, __wait)		\
 	({	int __rc, __dis = __sk->sk_disconnects;			\
-		release_sock(__sk);					\
 		__rc = __condition;					\
 		if (!__rc) {						\
 			*(__timeo) = wait_woken(__wait,			\
@@ -1153,7 +1152,6 @@ static inline void sock_rps_reset_rxhash(struct sock *sk)
 						*(__timeo));		\
 		}							\
 		sched_annotate_sleep();					\
-		lock_sock(__sk);					\
 		__rc = __dis == __sk->sk_disconnects ? __condition : -EPIPE; \
 		__rc;							\
 	})
-- 
2.34.1


