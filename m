Return-Path: <netdev+bounces-124978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B1F96B7C9
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9314B25115
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A690E1CF7CB;
	Wed,  4 Sep 2024 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsdWbode"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A1B1CF7AD
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444335; cv=none; b=dLZlmKLeHP9xWofTgwh42Rg3+rvaVqTs78jIDOWbY0eHdeSslypCKuVRf/RjXetwZeKts2MXwVOpLpZyN71tUWJTXbD3DSFcMJ/+T548Quw+1RTtYBEBhXnTDSHMmexehFsLBQx3QSuew3WGQS7vfTx0kiuXQ8KH3nztztnCigs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444335; c=relaxed/simple;
	bh=LETqrb4G8SYz7hlDbCsVG1dpDsg2aFrbLrzRFrFV87k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u7Ws9q6wuoZL9WkhDCBiL3CqWVsm1cq3y7sd2E6xqLq9p7UM2iLl4OE8Iz79cmlHJ26xAFxCTlvwIY7pyjl2NTVESGhpqmikWDMHAjo1IzDeFVSqe25+f5Dk7Elq7r4P/r3oxQsgcH9DVKhzITe6D6CFMHFiwOXI8N1HsQvHzZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QsdWbode; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725444333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7SgMWqwfRAemJXpyVUWXtmjgoS7M6mnA9OsZpEX3Nsc=;
	b=QsdWbodeBd3amgWl3B0avrqOgwEcLG5zuKG0PeP30LxT3rKIgpSC2N32wu6S0EUl945FNh
	lyEYkCTdTt0FWYFjXp+8GTIxJVDWEhx11HIKKrX/vVuX8FRhKEpLS1dUJ/dYTIRYPrp4k0
	fE4bdci20ZEoOUofsiYSA8jiseUxe4I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-7Gw8AsRYPVmvd-jwMQDWmw-1; Wed, 04 Sep 2024 06:05:32 -0400
X-MC-Unique: 7Gw8AsRYPVmvd-jwMQDWmw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374c9b0daf3so1893840f8f.1
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 03:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725444329; x=1726049129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7SgMWqwfRAemJXpyVUWXtmjgoS7M6mnA9OsZpEX3Nsc=;
        b=hyNJzVtmo2KdmC0+ZYV4c3xgK4x9XVh3rGHouQzZkPOT3tZ4jgu+CS4YgMZ+XqjIEX
         A16p1DrAvF9HU9ZOdYZ9AQJ81fAlejxaSK1klB/XpuhKVjbo3Vv5Ps3VY0BYvI60IlCb
         wqHgGLpInJCpAkpdWub95q9V/GCPQXWR6AtDFZUCe1X3ksdEiVvS6vEmQ2fZUZzRPKOI
         Z8pfj5Bf/BrfAp+qx4z38LuD+GxJblY9Cy4rw3va2s883lJqZegtm3zvKSxyAk+H8jS/
         VUu8S5kdqPQ0y4AlUqf5Ud0coq8PZKFdzKDpOMbsNhLoyUHl3XS6mQr3q8tSl/Un1ezl
         +lYg==
X-Forwarded-Encrypted: i=1; AJvYcCW5I1SV1+/jIrfwg+0DrRH3Zhf3mNEpCLA667SZ/TnJto0BHWLLmXJndcPwgqIo8AU2d4NZG+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTz0MrcPSGy5fh7c6gbomA5H8Lc8nhkVSFU7/ZejB/r+kjViDQ
	kt/BUebPAF87UwrhI0REUIpjpgWqcc91oxf1pew+GzmSil36qR1aba/aVgB6OPYxSmA4D/oPwva
	cRRD1jShNGLUDfA3OQdDwsxPvKqnLCBj7MkY/N8l9A0g7l6w78qietQ==
X-Received: by 2002:adf:e5ce:0:b0:374:c712:507a with SMTP id ffacd0b85a97d-374c71250b6mr6136145f8f.32.1725444329461;
        Wed, 04 Sep 2024 03:05:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeRTWuKvLCbwapCMh7yQPpztr87Al5rISbB93gh6CJwlRrsshXjrGddYXAlYkLaqWSK1GQPQ==
X-Received: by 2002:adf:e5ce:0:b0:374:c712:507a with SMTP id ffacd0b85a97d-374c71250b6mr6136133f8f.32.1725444328978;
        Wed, 04 Sep 2024 03:05:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c0f6f4c4sm11128642f8f.44.2024.09.04.03.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 03:05:28 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5A22F14AE6D7; Wed, 04 Sep 2024 12:05:27 +0200 (CEST)
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
Subject: [PATCH net-next] sch_cake: constify inverse square root cache
Date: Wed,  4 Sep 2024 12:05:16 +0200
Message-ID: <20240904100516.16926-1-toke@redhat.com>
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
 net/sched/sch_cake.c | 53 +++++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 9602dafe32e6..a51c43bde0de 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -361,8 +361,24 @@ static const u8 besteffort[] = {
 static const u8 normal_order[] = {0, 1, 2, 3, 4, 5, 6, 7};
 static const u8 bulk_order[] = {1, 0, 2, 3};
 
+/* There is a big difference in timing between the accurate values placed in the
+ * cache and the approximations given by a single Newton step for small count
+ * values, particularly when stepping from count 1 to 2 or vice versa. Hence,
+ * these values are calculated using eight Newton steps, using the implementation
+ * below. Above 16, a single Newton step gives sufficient accuracy in either
+ * direction, given the precision stored.
+ *
+ * The magnitude of the error when stepping up to count 2 is such as to give
+ * the value that *should* have been produced at count 4.
+ */
+
 #define REC_INV_SQRT_CACHE (16)
-static u32 cobalt_rec_inv_sqrt_cache[REC_INV_SQRT_CACHE] = {0};
+static const u32 inv_sqrt_cache[REC_INV_SQRT_CACHE] = {
+	        ~0,         ~0, 3037000500, 2479700525,
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


