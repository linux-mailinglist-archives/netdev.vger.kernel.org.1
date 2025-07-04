Return-Path: <netdev+bounces-204149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA8CAF932D
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 14:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7DC172877
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 12:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DA22EE96F;
	Fri,  4 Jul 2025 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMwsXTMt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDE02D94BD;
	Fri,  4 Jul 2025 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751633564; cv=none; b=YTovVlKXw27Zp3oW3HbLdEEodH9+sS2fnDe34mxRyiZd9jlscvnTDtG32uDV3o5akjWphuS1mzp8Ik7FTAEMqipBD2JWPAnX+2s+5sfbZkDRFa2pLBnOiUNCRdBr8rE55s0klssfdUoGBeh4kj5vwUO/0szIMxT0zTlqYT2WejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751633564; c=relaxed/simple;
	bh=u/WvBmmNg2jkDi7MkfdVS4k08BsPma+U0Rw36YzvuLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9ffpOeHQLlv0n0sp1JfAToOax5vQaX4y3PS7zpj1l8uWboJxg3yBvN3wAYawDDeFN6gztRcCbCnl6xGSUe1fofMxp8hRyFttokd68+KsFngE3eq0dX+IekVmlzVjWty163vnyGG9l/YuQLtZbvMORQiVmFAGBJnn13rSePnKuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMwsXTMt; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0d7b32322so134536066b.2;
        Fri, 04 Jul 2025 05:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751633561; x=1752238361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eH0TrjB6gEUsCKkL3O1IfJU1WEkIKTIsQrhxUkFUHdQ=;
        b=jMwsXTMtDyLuyZxxVhoXrc1OChGRPbattQ0wfABrVsUuC4XwkKjWsZv6CmAicNjAjB
         nwUxR5FJ1HPC8MXpdCT6Xztz5KV76siHnPKuBxiWxKYIsG2z9A/QLGOovsK8Z/S79kCn
         Lm4M+ktttdUnzaxW6PiEDGtVazcZ2wlidzym7gS+UC1BsVbjhrFxhm4XNhwMaWYV9TCo
         oKDls/KqGXFspXiimiUgoK7MeJe2hnsTJVcwT/JCBgeiaNrU0fgR863c2gi9fLItqV1z
         6Ejjj9qePjzZu2U3v1XXC+3Wlz/kByEtpvlRNXthP8SeNtBrkLulN6ZcwzQ7V0ANdf2I
         JuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751633561; x=1752238361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eH0TrjB6gEUsCKkL3O1IfJU1WEkIKTIsQrhxUkFUHdQ=;
        b=GVYheA+b7HvJT5E6l7QT2GoaiWPnZhCeIt5VG7gExvralEyQiJl7E8aBvuQ34sEgus
         YzDrS0fnm6yMX0yoJIXkdJ2gbj2w4pDv5uNO0PrpW1JD+3F/l+lThHK1PYTqVNmg1OBL
         XcZch4JgkuiUUdg5I7NQAHn2ZXGnQT74KBYFSHVyFVXoTLse+9HP7eNQjQvIctimVCWt
         U+9r81cP/eEAie5ll/Rkyt6E/7oIngKiTMtijvDYUqTqqEYAcUjLHV8I7GFLxncK8+uj
         kuz30GL3BU9JY4xMFXO5PEhaIesNRqzmi1wGBzkx7LY65cU+JfqmzxojxT8fO/U47MWY
         XmEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPi0gGyDBd2g7PBjTanMfkUoqRCpynXv8ktQ/C9nNmRRIk+H2DRi4rHYoSlr3mg5u+QnNNZvEGMjuv5HU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW3UIsZ6fVlYlNaFyGAHCXwyTeoviEOFdXjtBdiX83NOmHFdgN
	bD1kZnRkvVJccS1ZrYBYQ86Kv5q7twFScSTU1iwTi6Zrg5ZK365w+7PM8pjRqgeZGRjbGw==
X-Gm-Gg: ASbGncvrV598rTfSfhL9OXcneew1vVPyR0N28sMe4eIMuuoz2MsXnE+GJ2TbfqLw0bw
	q8WSIT2cyg8CtJUZ1oi7csnFf0zneHsYfIZFwnrEmcNDve9qMMhtL45kd7hGG0OmeOqaC1+puMV
	YxBc43VGUYsyNX0WtKQDdkdhCc49E1qSk7sozbWmfYDaNsxIQkStKncqKFOU5DXTdK6pDwCPukB
	1egug7wZrPvy1pZ22VJPdFB72izbSqNVMjsIw0apLcSHg7hFQEDzKJFRnW0EeyPTcBQuKlTe6GY
	qLaU1hIB/3u1NRarURn7C74ST/u+t2TjZ0TWznemeKozHgqr71J+cgI/86Qy5x2WspGhJ6DzlAX
	IN8wQskVTAEAaHnmKgQbjpcwYcGhUYYwJcQF26UFssd4fqP3EJJAR1HvL4BPdl1gPo+8/isOc
X-Google-Smtp-Source: AGHT+IFGL3fZ/lPH11cxFwkYGYMUXNBs6sFbjX1tv6qGhqchD33KIQL3mimJ7278mh0sqWgWppUv9w==
X-Received: by 2002:a17:907:7f8d:b0:ae0:dd95:1991 with SMTP id a640c23a62f3a-ae3fe5ce1a0mr180550066b.51.1751633560435;
        Fri, 04 Jul 2025 05:52:40 -0700 (PDT)
Received: from legolas.fritz.box (p200300d0af416e00eb84418c678abf7e.dip0.t-ipconnect.de. [2003:d0:af41:6e00:eb84:418c:678a:bf7e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b64f5asm166346066b.162.2025.07.04.05.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 05:52:40 -0700 (PDT)
From: Markus Theil <theil.markus@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	akpm@linux-foundation.org,
	Jason@zx2c4.com,
	Markus Theil <theil.markus@gmail.com>
Subject: [PATCH v2 3/4] prandom/random32: add checks against invalid state
Date: Fri,  4 Jul 2025 14:52:32 +0200
Message-ID: <20250704125233.2653779-4-theil.markus@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704125233.2653779-1-theil.markus@gmail.com>
References: <20250704125233.2653779-1-theil.markus@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Xoshiro256++ will not work in the very unlikely case,
that it is used with an all zeroes state. Add checks against
this in all necessary places.

Signed-off-by: Markus Theil <theil.markus@gmail.com>
---
 lib/random32.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/lib/random32.c b/lib/random32.c
index 64fccfd64717..c01b763a7d40 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -26,6 +26,8 @@
 #include <linux/slab.h>
 #include <linux/unaligned.h>
 
+#define IS_ALL_ZERO_STATE(state) (!state->s[0] && !state->s[1] && !state->s[2] && !state->s[3])
+
 /**
  *	prandom_u64_state - seeded pseudo-random number generator.
  *	@state: pointer to state structure holding seeded state.
@@ -40,6 +42,9 @@ u64 prandom_u64_state(struct rnd_state *state)
 	const u64 result = rol64(state->s[0] + state->s[3], 23) + state->s[0];
 	const u64 t = state->s[1] << 17;
 
+	/* defensive check, as this fn returns always zero otherwise */
+	BUG_ON(IS_ALL_ZERO_STATE(state));
+
 	state->s[2] ^= state->s[0];
 	state->s[3] ^= state->s[1];
 	state->s[1] ^= state->s[2];
@@ -108,6 +113,12 @@ EXPORT_SYMBOL(prandom_bytes_state);
  *
  * splitmix64 init as suggested for xoshiro256++
  * See: https://prng.di.unimi.it/splitmix64.c
+ *
+ * Seeding with this routine cannot result in an
+ * all zeroes state due to the addition operation
+ * with the fixed constant 0x9e3779b97f4a7c15!
+ * Nevertheless check early for such a state
+ * as a defensive mechanism.
  */
 void prandom_seed_state(struct rnd_state *state, u64 seed)
 {
@@ -120,6 +131,9 @@ void prandom_seed_state(struct rnd_state *state, u64 seed)
 		z = (z ^ (z >> 27)) * 0x94d049bb133111eb;
 		state->s[i] = z ^ (z >> 31);
 	}
+
+	/* shall never happen */
+	BUG_ON(IS_ALL_ZERO_STATE(state));
 }
 EXPORT_SYMBOL(prandom_seed_state);
 
@@ -133,7 +147,16 @@ void prandom_seed_full_state(struct rnd_state __percpu *pcpu_state)
 
 	for_each_possible_cpu(i) {
 		struct rnd_state *state = per_cpu_ptr(pcpu_state, i);
-		get_random_bytes(&state->s, sizeof(state->s));
+		memset(state, 0, sizeof(struct rnd_state));
+		/*
+		 * Internal state MUST not be all zeroes. Check and repeat if necessary.
+		 *
+		 * Highly unlikely, that we ever need more than one round. Just defensive
+		 * coding, as this could happen in theory.
+		 */
+		while (IS_ALL_ZERO_STATE(state)) {
+			get_random_bytes(&state->s, sizeof(state->s));
+		}
 	}
 }
 EXPORT_SYMBOL(prandom_seed_full_state);
-- 
2.49.0


