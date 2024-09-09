Return-Path: <netdev+bounces-126455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9B397131A
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 11:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9BC1F24456
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C320854673;
	Mon,  9 Sep 2024 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajzMgjU6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED1C42AAB
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873400; cv=none; b=u9O2COBo9XLpCqH/6OB7nAiKisMc1jiZYAIf9SnqPHmV7iSzJvT7p0CP4ICF5kNsj4L07UzWzp5gndpcAWdap/udecRIXZmFdWWcK+lVKcIkm3tzAwNuSrWpxx7dCBYdYQUK7WqVVYxt/3dnXW9yQ8yZaRZDrKVMobqt+qSV+04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873400; c=relaxed/simple;
	bh=v8zrigSSHrB095AOrTu4GkbqsrbmEffIV6J+7irWSug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t76Gpfo92OcLVxqUIDy/zun1rrPBcJa5TreHGobe5vx/tehnyLydiCxCA60kCts+IkXplWBctHb/56hcdtPX4BsbtI/y8lgb3lozzHqlH1vbrHDMtcsKtJhVQbIprntwTsSpLzNol802v8jY40FHmBTsFjZl0iW+tPz74oRx25w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajzMgjU6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725873397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hOgHx6oXUHCksOPdNO9GkwDeu+mkCXvvvLuR8v0qTU4=;
	b=ajzMgjU6SSbu+DTJHkRpm6VaxU9uLwzvT3rAQcRaRXgbfGVzXgRzao5H+HI5IEV5wVGATv
	vOaRJr2srxf186Jj5dynUnlZrkRfEWtquSEu25dgQCoovjqmRlF9b/mRrs3mtT8Ycc7n9h
	WFt/PmiYWne5dZLu+zQtOUYQqAT1v4M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-zpY5RcdiMJyfDuwD1BB8Kw-1; Mon, 09 Sep 2024 05:16:35 -0400
X-MC-Unique: zpY5RcdiMJyfDuwD1BB8Kw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8a6fee3ab1so328614866b.3
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 02:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725873394; x=1726478194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOgHx6oXUHCksOPdNO9GkwDeu+mkCXvvvLuR8v0qTU4=;
        b=JWHcEDWQRvM6j9/goyfqPdOTi1gOK3/9jL8t+UjOCkIWsXRKCcRQOSeLGqRtI+kDzT
         DHfXVdESS5R5cVgc1p9K2iSzxG2WmQxWg4sRFOFOUwI1AepWE36Hz1uf6qMD6IO4V5BK
         XhHxiBpoLSyxCd+UJ8bcwhtmqPsts3Z8usWh/90zkxzpzNNBwL8m22wXhs8oDyLxfkKi
         9z9/B8xmFsMPzi96NIvYUdQUo/bS6XLVz43E7Fb9XQRbXCMyReVSGR4dMN70EhDsoNNW
         pftdgFun1bGK7nsvXBQJ0bEdTrJd6x9O4eUgX3CmfogBPWE2nkqgDI2Gqbfe1KrDjXn4
         WX9w==
X-Forwarded-Encrypted: i=1; AJvYcCXx2+u2ns3ZYo++62XSskRon4mCiHxiWjPwp3RmVeyL1Ppl8dUf9sj++BGfLJk4P52t43EKTX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD4hAj+q4vqJdoGKzTTEAikl4HhRn2WPY9QhpibhIb/PHW4tSL
	vAU4qfq/n50Y1o9/pRIFXijapbZpPPcbMM141UnLN5/xIcVFm3BVCaMh4JHqygNg7TWeLF7MnLc
	HWUXTzkbyK2zLGaLqKdZj6dFahUM617ESesqG0ZJCSTkwp4WLnqbKFg==
X-Received: by 2002:a17:907:368a:b0:a86:8953:e1fe with SMTP id a640c23a62f3a-a8a8884be2cmr834442666b.47.1725873393564;
        Mon, 09 Sep 2024 02:16:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNi4CPHkWulQf8Un7wTFpsfY+PTRR0uA19tgeQRrcwdcay9z5l6W2TFxorq811BaKwya9DjA==
X-Received: by 2002:a17:907:368a:b0:a86:8953:e1fe with SMTP id a640c23a62f3a-a8a8884be2cmr834438266b.47.1725873392705;
        Mon, 09 Sep 2024 02:16:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d65cf6sm310680766b.222.2024.09.09.02.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 02:16:32 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E007714AEA8B; Mon, 09 Sep 2024 11:16:30 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: Dave Taht <dave.taht@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	cake@lists.bufferbloat.net,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2] sch_cake: constify inverse square root cache
Date: Mon,  9 Sep 2024 11:16:28 +0200
Message-ID: <20240909091630.22177-1-toke@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Dave Taht <dave.taht@gmail.com>

sch_cake uses a cache of the first 16 values of the inverse square root
calculation for the Cobalt AQM to save some cycles on the fast path.
This cache is populated when the qdisc is first loaded, but there's
really no reason why it can't just be pre-populated. So change it to be
pre-populated with constants, which also makes it possible to constify
it.

This gives a modest space saving for the module (not counting debug data):
.text:  -224 bytes
.rodata: +80 bytes
.bss:    -64 bytes
Total:  -192 bytes

Signed-off-by: Dave Taht <dave.taht@gmail.com>
[ fixed up comment, rewrote commit message ]
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
v2:
- Fix indentation and line length issues

 net/sched/sch_cake.c | 53 +++++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index d2f49db70523..f2f9b75008bb 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -361,8 +361,24 @@ static const u8 besteffort[] = {
 static const u8 normal_order[] = {0, 1, 2, 3, 4, 5, 6, 7};
 static const u8 bulk_order[] = {1, 0, 2, 3};
 
+/* There is a big difference in timing between the accurate values placed in the
+ * cache and the approximations given by a single Newton step for small count
+ * values, particularly when stepping from count 1 to 2 or vice versa. Hence,
+ * these values are calculated using eight Newton steps, using the
+ * implementation below. Above 16, a single Newton step gives sufficient
+ * accuracy in either direction, given the precision stored.
+ *
+ * The magnitude of the error when stepping up to count 2 is such as to give the
+ * value that *should* have been produced at count 4.
+ */
+
 #define REC_INV_SQRT_CACHE (16)
-static u32 cobalt_rec_inv_sqrt_cache[REC_INV_SQRT_CACHE] = {0};
+static const u32 inv_sqrt_cache[REC_INV_SQRT_CACHE] = {
+		~0,         ~0, 3037000500, 2479700525,
+	2147483647, 1920767767, 1753413056, 1623345051,
+	1518500250, 1431655765, 1358187914, 1294981364,
+	1239850263, 1191209601, 1147878294, 1108955788
+};
 
 /* http://en.wikipedia.org/wiki/Methods_of_computing_square_roots
  * new_invsqrt = (invsqrt / 2) * (3 - count * invsqrt^2)
@@ -388,47 +404,14 @@ static void cobalt_newton_step(struct cobalt_vars *vars)
 static void cobalt_invsqrt(struct cobalt_vars *vars)
 {
 	if (vars->count < REC_INV_SQRT_CACHE)
-		vars->rec_inv_sqrt = cobalt_rec_inv_sqrt_cache[vars->count];
+		vars->rec_inv_sqrt = inv_sqrt_cache[vars->count];
 	else
 		cobalt_newton_step(vars);
 }
 
-/* There is a big difference in timing between the accurate values placed in
- * the cache and the approximations given by a single Newton step for small
- * count values, particularly when stepping from count 1 to 2 or vice versa.
- * Above 16, a single Newton step gives sufficient accuracy in either
- * direction, given the precision stored.
- *
- * The magnitude of the error when stepping up to count 2 is such as to give
- * the value that *should* have been produced at count 4.
- */
-
-static void cobalt_cache_init(void)
-{
-	struct cobalt_vars v;
-
-	memset(&v, 0, sizeof(v));
-	v.rec_inv_sqrt = ~0U;
-	cobalt_rec_inv_sqrt_cache[0] = v.rec_inv_sqrt;
-
-	for (v.count = 1; v.count < REC_INV_SQRT_CACHE; v.count++) {
-		cobalt_newton_step(&v);
-		cobalt_newton_step(&v);
-		cobalt_newton_step(&v);
-		cobalt_newton_step(&v);
-
-		cobalt_rec_inv_sqrt_cache[v.count] = v.rec_inv_sqrt;
-	}
-}
-
 static void cobalt_vars_init(struct cobalt_vars *vars)
 {
 	memset(vars, 0, sizeof(*vars));
-
-	if (!cobalt_rec_inv_sqrt_cache[0]) {
-		cobalt_cache_init();
-		cobalt_rec_inv_sqrt_cache[0] = ~0;
-	}
 }
 
 /* CoDel control_law is t + interval/sqrt(count)
-- 
2.46.0


