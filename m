Return-Path: <netdev+bounces-204148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685B0AF932C
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 14:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04FDD3A3A07
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 12:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F392ED871;
	Fri,  4 Jul 2025 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZbASvjO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2742D8DC8;
	Fri,  4 Jul 2025 12:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751633564; cv=none; b=RKJUyQLBnie1aCWnHFGMfbs20QdLmf3VHCqaKssTi7diCVVVL3HKIGM/KUy1atLG6237jOQl0fakEQguNq7wCcAwzQ+M/vKgpnOPQLl6YOMN4QBTBxzdDFICD9/7ihHm5vWBM1rZUKaJP83TODljj3IG++e5ozSlrjO8gn/qs2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751633564; c=relaxed/simple;
	bh=w8HHn3qCwK5g8VjdfNT8V3suSdUzXvz9D3fSFzUPhCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDpXFKjmTmj6DzrKXi9CY7XaHFhQ3DEvFMohluyplxr3py94A0ZoRWmBcprblgzpnNblXwQviuqFXpdwGp9yN5LDHMc85nS5xAWgIBc2/vIzY4tSs8DzJOX4YXgaJfdT8mwfCdboVRJ2lYDwJ0Tf/1VnewVSTs5YfOZcKmr0CL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZbASvjO; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60c79bedc19so1514500a12.3;
        Fri, 04 Jul 2025 05:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751633560; x=1752238360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3acOodOMlvqIRCZ0D4Fdw+mgx0LeyMc4Z8w7hzsKg8=;
        b=EZbASvjOPcRi8IHiiYTHfGg2gSNw86u5VFmlFpMhvXqAW4Pp9w5Aps//RdMP7ic1aN
         u2fVwWomhnecS3qsRycwi0kkOZfacQXlCuFlvz2bFyLa5WqVRKI9NqR/4Ad23hJtR7tk
         n3nt+NbfBSyKIpiR1RDdh89+b69Q6lKyhUGOFYYrPnWAMPYzCZXb9KSp5cx8kGtLdLJf
         X3KyNxuF0FShUIs13iCQB3YxTkgYeVZOINY0oCRXnxAjtlf1xMBOxq8x9F5ibk5QvImG
         V8tn1urm30Ex2HGdZJoRmmwrpKXApuAKOl78/BrX8Gl7oo+BQecAFm1mefUEHCcSYnc4
         h97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751633560; x=1752238360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3acOodOMlvqIRCZ0D4Fdw+mgx0LeyMc4Z8w7hzsKg8=;
        b=w82Aj9PjdHWeIKpxqJcdIFGwyuIv5VZIKY01/mqzblc42SoYeK4Fx4XPRiAxxzgCdt
         XfigOdl6dpTkyLtMnz6qHzrDXzvHefyvIscfHOmKh6WnNRK87hjMaLTOE56WUqIEDJeA
         gjxzCQlmrrFY3GGPCXLzhdVo36L69zyrtZ2adcD5+8/+pvMFvW8HCJ3/N43ZuiU8tYEO
         5QIkT7Yqy5gRUiVOURbSPquAdB0u1RJTRzW8K3bnhMz+1o3egtigYRnkTZAGNtgmtg95
         pBSgddUdpTeTua8lCWOloZhxBaaM1hGuU9dhnTjOih1jpgPsDA5gT04DZNrOFUTe/Llb
         3jEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/g4LwaJJ7tAlO8XKVClCClRjsEYSY+f2WPIDRwcd/vZltUyC2mVJSJmmU6vIEk2Chc+eE3XdRpNUnYK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGGYlUK/f9GVyCXlSNUXQD/f9k2rt7d7/NJgMXJcs4BgFGDD6Y
	F7UdQzsh7+OLBSyK5x8wfBnCRdIzSO4fSgPvbGAw3MXzh6LgP1LRwVS7wZ1U9E17iQFXbg==
X-Gm-Gg: ASbGnculSC8KLlT5DcxQh8b8Lk07mIIbnZXSGZbtyZXhRm7fZtfvYsyaYNWjW9XSCqq
	zxEcylgzIkTzVtzMyRyuel3bNl0l3zZZqHEWYIuJp/XsU1jHhpSklzQMxpU2UclhMeaUNELsxJy
	FCWbGen8n0lAsmyZRNZRT29Wy1soAU/lqGCdhIL/rvOd5DGV+Eqhkamggvrqh1CcOGlK2ftEYzF
	ML05TzfDiRcSjnGw6eg0eHJtpFs+BTfXgdu1uwDpxWTvt8/jheMSrY6/WaepbDiJHEP3dX8EgpP
	ceYFCRq9romOez3HWLm3sv7Djz0g6t0MH0+L8pM4MT7nZQfVw5MGsaVm6NIyUXX1Vya09fRBngJ
	6vKcDcPhOuls78oNjbuLUDhizdEnB4ZjYXQVY5HHCI8YXwDFMe5A399Pi4lHE/Q==
X-Google-Smtp-Source: AGHT+IGww7At9rWYNtBlkWhDs9tNW+qiBK8/hFGbLIXvQkL5dAAqC0T8blILRr54NxXmj0p03SNm3g==
X-Received: by 2002:a17:907:3e9f:b0:ade:4339:9358 with SMTP id a640c23a62f3a-ae3fbc5bcc1mr243761166b.22.1751633559494;
        Fri, 04 Jul 2025 05:52:39 -0700 (PDT)
Received: from legolas.fritz.box (p200300d0af416e00eb84418c678abf7e.dip0.t-ipconnect.de. [2003:d0:af41:6e00:eb84:418c:678a:bf7e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b64f5asm166346066b.162.2025.07.04.05.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 05:52:39 -0700 (PDT)
From: Markus Theil <theil.markus@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	akpm@linux-foundation.org,
	Jason@zx2c4.com,
	Markus Theil <theil.markus@gmail.com>
Subject: [PATCH v2 2/4] prandom/random32: switch to Xoshiro256++
Date: Fri,  4 Jul 2025 14:52:31 +0200
Message-ID: <20250704125233.2653779-3-theil.markus@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704125233.2653779-1-theil.markus@gmail.com>
References: <20250704125233.2653779-1-theil.markus@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The current Linux PRNG is based on LFSR113, which means:
- needs some warmup rounds to yield better statistical properties
- seeds/initial states must be of certain structure
- does not pass L’Ecuyer's BigCrush in TestU01

While of course, there is no clear "best" PRNG, replace with
Xoshiro256++, which seams to be a sensible replacement, from
todays point of view:
- only needs one bit set to 1 in the seed, needs no warmup, when
  seeded with splitmix64.
- Also has statistical evaluation, like LFSR113.
- Passes BigCrush in TestU01.

The code got smaller, because some edge cases are ruled out now.
I kept the test vectors and adapted them to this RNG.

Signed-off-by: Markus Theil <theil.markus@gmail.com>
---
 include/linux/prandom.h |  28 +---
 lib/random32.c          | 351 ++++++++++++++++++++--------------------
 2 files changed, 177 insertions(+), 202 deletions(-)

diff --git a/include/linux/prandom.h b/include/linux/prandom.h
index 63d1fe4b30c8..0277c00ae830 100644
--- a/include/linux/prandom.h
+++ b/include/linux/prandom.h
@@ -14,39 +14,19 @@
 #include <linux/random.h>
 
 struct rnd_state {
-	__u32 s1, s2, s3, s4;
+	__u64 s[4];
 };
 
+/* WARNING: this API MUST NOT be used for cryptographic purposes! */
+u64 prandom_u64_state(struct rnd_state *state);
 /* WARNING: this API MUST NOT be used for cryptographic purposes! */
 u32 prandom_u32_state(struct rnd_state *state);
 /* WARNING: this API MUST NOT be used for cryptographic purposes! */
 void prandom_bytes_state(struct rnd_state *state, void *buf, size_t nbytes);
 void prandom_seed_full_state(struct rnd_state __percpu *pcpu_state);
+void prandom_seed_state(struct rnd_state *state, u64 seed);
 
 #define prandom_init_once(pcpu_state)			\
 	DO_ONCE(prandom_seed_full_state, (pcpu_state))
 
-/*
- * Handle minimum values for seeds
- */
-static inline u32 __seed(u32 x, u32 m)
-{
-	return (x < m) ? x + m : x;
-}
-
-/**
- * prandom_seed_state - set seed for prandom_u32_state().
- * @state: pointer to state structure to receive the seed.
- * @seed: arbitrary 64-bit value to use as a seed.
- */
-static inline void prandom_seed_state(struct rnd_state *state, u64 seed)
-{
-	u32 i = ((seed >> 32) ^ (seed << 10) ^ seed) & 0xffffffffUL;
-
-	state->s1 = __seed(i,   2U);
-	state->s2 = __seed(i,   8U);
-	state->s3 = __seed(i,  16U);
-	state->s4 = __seed(i, 128U);
-}
-
 #endif
diff --git a/lib/random32.c b/lib/random32.c
index c808745a4b53..64fccfd64717 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -2,36 +2,18 @@
 /*
  * WARNING: this API MUST NOT be used for cryptographic purposes!
  *
- * This is a maximally equidistributed combined Tausworthe generator
- * based on code from GNU Scientific Library 1.5 (30 Jun 2004)
+ * xoshiro256++ is a high-quality non-cryptographic
+ * pseudorandom number generator (PRNG).
  *
- * lfsr113 version:
+ * For a more detailed description, see:
+ * https://vigna.di.unimi.it/ftp/papers/ScrambledLinear.pdf
  *
- * x_n = (s1_n ^ s2_n ^ s3_n ^ s4_n)
+ * Usage Advice: As the cryptographic random subsystem is really fast these days,
+ * you should come up with a good reason, to introduce PRNG usage into new code.
+ * Consider its usage, when a predictable/repeatable sequence is needed for
+ * testing purposes. Prefer to use get_random_32(), when possible.
  *
- * s1_{n+1} = (((s1_n & 4294967294) << 18) ^ (((s1_n <<  6) ^ s1_n) >> 13))
- * s2_{n+1} = (((s2_n & 4294967288) <<  2) ^ (((s2_n <<  2) ^ s2_n) >> 27))
- * s3_{n+1} = (((s3_n & 4294967280) <<  7) ^ (((s3_n << 13) ^ s3_n) >> 21))
- * s4_{n+1} = (((s4_n & 4294967168) << 13) ^ (((s4_n <<  3) ^ s4_n) >> 12))
- *
- * The period of this generator is about 2^113 (see erratum paper).
- *
- * From: P. L'Ecuyer, "Maximally Equidistributed Combined Tausworthe
- * Generators", Mathematics of Computation, 65, 213 (1996), 203--213:
- * http://www.iro.umontreal.ca/~lecuyer/myftp/papers/tausme.ps
- * ftp://ftp.iro.umontreal.ca/pub/simulation/lecuyer/papers/tausme.ps
- *
- * There is an erratum in the paper "Tables of Maximally Equidistributed
- * Combined LFSR Generators", Mathematics of Computation, 68, 225 (1999),
- * 261--269: http://www.iro.umontreal.ca/~lecuyer/myftp/papers/tausme2.ps
- *
- *      ... the k_j most significant bits of z_j must be non-zero,
- *      for each j. (Note: this restriction also applies to the
- *      computer code given in [4], but was mistakenly not mentioned
- *      in that paper.)
- *
- * This affects the seeding procedure by imposing the requirement
- * s1 > 1, s2 > 7, s3 > 15, s4 > 127.
+ * Based on: https://prng.di.unimi.it/xoshiro256plusplus.c
  */
 
 #include <linux/types.h>
@@ -44,6 +26,33 @@
 #include <linux/slab.h>
 #include <linux/unaligned.h>
 
+/**
+ *	prandom_u64_state - seeded pseudo-random number generator.
+ *	@state: pointer to state structure holding seeded state.
+ *
+ *	This is used for pseudo-randomness with no outside seeding.
+ *	For more random results, use get_random_u64().
+ *
+ *	WARNING: this API MUST NOT be used for cryptographic purposes!
+ */
+u64 prandom_u64_state(struct rnd_state *state)
+{
+	const u64 result = rol64(state->s[0] + state->s[3], 23) + state->s[0];
+	const u64 t = state->s[1] << 17;
+
+	state->s[2] ^= state->s[0];
+	state->s[3] ^= state->s[1];
+	state->s[1] ^= state->s[2];
+	state->s[0] ^= state->s[3];
+
+	state->s[2] ^= t;
+
+	state->s[3] = rol64(state->s[3], 45);
+
+	return result;
+}
+EXPORT_SYMBOL(prandom_u64_state);
+
 /**
  *	prandom_u32_state - seeded pseudo-random number generator.
  *	@state: pointer to state structure holding seeded state.
@@ -55,13 +64,7 @@
  */
 u32 prandom_u32_state(struct rnd_state *state)
 {
-#define TAUSWORTHE(s, a, b, c, d) ((s & c) << d) ^ (((s << a) ^ s) >> b)
-	state->s1 = TAUSWORTHE(state->s1,  6U, 13U, 4294967294U, 18U);
-	state->s2 = TAUSWORTHE(state->s2,  2U, 27U, 4294967288U,  2U);
-	state->s3 = TAUSWORTHE(state->s3, 13U, 21U, 4294967280U,  7U);
-	state->s4 = TAUSWORTHE(state->s4,  3U, 12U, 4294967168U, 13U);
-
-	return (state->s1 ^ state->s2 ^ state->s3 ^ state->s4);
+	return (u32) prandom_u64_state(state);
 }
 EXPORT_SYMBOL(prandom_u32_state);
 
@@ -81,14 +84,14 @@ void prandom_bytes_state(struct rnd_state *state, void *buf, size_t bytes)
 {
 	u8 *ptr = buf;
 
-	while (bytes >= sizeof(u32)) {
-		put_unaligned(prandom_u32_state(state), (u32 *) ptr);
-		ptr += sizeof(u32);
-		bytes -= sizeof(u32);
+	while (bytes >= sizeof(u64)) {
+		put_unaligned(prandom_u64_state(state), (u64 *) ptr);
+		ptr += sizeof(u64);
+		bytes -= sizeof(u64);
 	}
 
 	if (bytes > 0) {
-		u32 rem = prandom_u32_state(state);
+		u64 rem = prandom_u64_state(state);
 		do {
 			*ptr++ = (u8) rem;
 			bytes--;
@@ -98,36 +101,39 @@ void prandom_bytes_state(struct rnd_state *state, void *buf, size_t bytes)
 }
 EXPORT_SYMBOL(prandom_bytes_state);
 
-static void prandom_warmup(struct rnd_state *state)
+/**
+ * prandom_seed_state - set seed for prandom_u32_state().
+ * @state: pointer to state structure to receive the seed.
+ * @seed: arbitrary 64-bit value to use as a seed.
+ *
+ * splitmix64 init as suggested for xoshiro256++
+ * See: https://prng.di.unimi.it/splitmix64.c
+ */
+void prandom_seed_state(struct rnd_state *state, u64 seed)
 {
-	/* Calling RNG ten times to satisfy recurrence condition */
-	prandom_u32_state(state);
-	prandom_u32_state(state);
-	prandom_u32_state(state);
-	prandom_u32_state(state);
-	prandom_u32_state(state);
-	prandom_u32_state(state);
-	prandom_u32_state(state);
-	prandom_u32_state(state);
-	prandom_u32_state(state);
-	prandom_u32_state(state);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(state->s); ++i) {
+		seed += 0x9e3779b97f4a7c15;
+		u64 z = seed;
+		z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9;
+		z = (z ^ (z >> 27)) * 0x94d049bb133111eb;
+		state->s[i] = z ^ (z >> 31);
+	}
 }
+EXPORT_SYMBOL(prandom_seed_state);
 
+/**
+ * prandom_seed_full_state - seed all related per-cpu states in pcpu_state.
+ * @pcpu_state: pointer to states on all CPUs.
+ */
 void prandom_seed_full_state(struct rnd_state __percpu *pcpu_state)
 {
 	int i;
 
 	for_each_possible_cpu(i) {
 		struct rnd_state *state = per_cpu_ptr(pcpu_state, i);
-		u32 seeds[4];
-
-		get_random_bytes(&seeds, sizeof(seeds));
-		state->s1 = __seed(seeds[0],   2U);
-		state->s2 = __seed(seeds[1],   8U);
-		state->s3 = __seed(seeds[2],  16U);
-		state->s4 = __seed(seeds[3], 128U);
-
-		prandom_warmup(state);
+		get_random_bytes(&state->s, sizeof(state->s));
 	}
 }
 EXPORT_SYMBOL(prandom_seed_full_state);
@@ -137,10 +143,10 @@ static struct prandom_test1 {
 	u32 seed;
 	u32 result;
 } test1[] = {
-	{ 1U, 3484351685U },
-	{ 2U, 2623130059U },
-	{ 3U, 3125133893U },
-	{ 4U,  984847254U },
+	{ 1U, 1862517403U },
+	{ 2U, 3049585706U },
+	{ 3U, 3105450281U },
+	{ 4U, 2527704881U },
 };
 
 static struct prandom_test2 {
@@ -148,118 +154,109 @@ static struct prandom_test2 {
 	u32 iteration;
 	u32 result;
 } test2[] = {
-	/* Test cases against taus113 from GSL library. */
-	{  931557656U, 959U, 2975593782U },
-	{ 1339693295U, 876U, 3887776532U },
-	{ 1545556285U, 961U, 1615538833U },
-	{  601730776U, 723U, 1776162651U },
-	{ 1027516047U, 687U,  511983079U },
-	{  416526298U, 700U,  916156552U },
-	{ 1395522032U, 652U, 2222063676U },
-	{  366221443U, 617U, 2992857763U },
-	{ 1539836965U, 714U, 3783265725U },
-	{  556206671U, 994U,  799626459U },
-	{  684907218U, 799U,  367789491U },
-	{ 2121230701U, 931U, 2115467001U },
-	{ 1668516451U, 644U, 3620590685U },
-	{  768046066U, 883U, 2034077390U },
-	{ 1989159136U, 833U, 1195767305U },
-	{  536585145U, 996U, 3577259204U },
-	{ 1008129373U, 642U, 1478080776U },
-	{ 1740775604U, 939U, 1264980372U },
-	{ 1967883163U, 508U,   10734624U },
-	{ 1923019697U, 730U, 3821419629U },
-	{  442079932U, 560U, 3440032343U },
-	{ 1961302714U, 845U,  841962572U },
-	{ 2030205964U, 962U, 1325144227U },
-	{ 1160407529U, 507U,  240940858U },
-	{  635482502U, 779U, 4200489746U },
-	{ 1252788931U, 699U,  867195434U },
-	{ 1961817131U, 719U,  668237657U },
-	{ 1071468216U, 983U,  917876630U },
-	{ 1281848367U, 932U, 1003100039U },
-	{  582537119U, 780U, 1127273778U },
-	{ 1973672777U, 853U, 1071368872U },
-	{ 1896756996U, 762U, 1127851055U },
-	{  847917054U, 500U, 1717499075U },
-	{ 1240520510U, 951U, 2849576657U },
-	{ 1685071682U, 567U, 1961810396U },
-	{ 1516232129U, 557U,    3173877U },
-	{ 1208118903U, 612U, 1613145022U },
-	{ 1817269927U, 693U, 4279122573U },
-	{ 1510091701U, 717U,  638191229U },
-	{  365916850U, 807U,  600424314U },
-	{  399324359U, 702U, 1803598116U },
-	{ 1318480274U, 779U, 2074237022U },
-	{  697758115U, 840U, 1483639402U },
-	{ 1696507773U, 840U,  577415447U },
-	{ 2081979121U, 981U, 3041486449U },
-	{  955646687U, 742U, 3846494357U },
-	{ 1250683506U, 749U,  836419859U },
-	{  595003102U, 534U,  366794109U },
-	{   47485338U, 558U, 3521120834U },
-	{  619433479U, 610U, 3991783875U },
-	{  704096520U, 518U, 4139493852U },
-	{ 1712224984U, 606U, 2393312003U },
-	{ 1318233152U, 922U, 3880361134U },
-	{  855572992U, 761U, 1472974787U },
-	{   64721421U, 703U,  683860550U },
-	{  678931758U, 840U,  380616043U },
-	{  692711973U, 778U, 1382361947U },
-	{  677703619U, 530U, 2826914161U },
-	{   92393223U, 586U, 1522128471U },
-	{ 1222592920U, 743U, 3466726667U },
-	{  358288986U, 695U, 1091956998U },
-	{ 1935056945U, 958U,  514864477U },
-	{  735675993U, 990U, 1294239989U },
-	{ 1560089402U, 897U, 2238551287U },
-	{   70616361U, 829U,   22483098U },
-	{  368234700U, 731U, 2913875084U },
-	{   20221190U, 879U, 1564152970U },
-	{  539444654U, 682U, 1835141259U },
-	{ 1314987297U, 840U, 1801114136U },
-	{ 2019295544U, 645U, 3286438930U },
-	{  469023838U, 716U, 1637918202U },
-	{ 1843754496U, 653U, 2562092152U },
-	{  400672036U, 809U, 4264212785U },
-	{  404722249U, 965U, 2704116999U },
-	{  600702209U, 758U,  584979986U },
-	{  519953954U, 667U, 2574436237U },
-	{ 1658071126U, 694U, 2214569490U },
-	{  420480037U, 749U, 3430010866U },
-	{  690103647U, 969U, 3700758083U },
-	{ 1029424799U, 937U, 3787746841U },
-	{ 2012608669U, 506U, 3362628973U },
-	{ 1535432887U, 998U,   42610943U },
-	{ 1330635533U, 857U, 3040806504U },
-	{ 1223800550U, 539U, 3954229517U },
-	{ 1322411537U, 680U, 3223250324U },
-	{ 1877847898U, 945U, 2915147143U },
-	{ 1646356099U, 874U,  965988280U },
-	{  805687536U, 744U, 4032277920U },
-	{ 1948093210U, 633U, 1346597684U },
-	{  392609744U, 783U, 1636083295U },
-	{  690241304U, 770U, 1201031298U },
-	{ 1360302965U, 696U, 1665394461U },
-	{ 1220090946U, 780U, 1316922812U },
-	{  447092251U, 500U, 3438743375U },
-	{ 1613868791U, 592U,  828546883U },
-	{  523430951U, 548U, 2552392304U },
-	{  726692899U, 810U, 1656872867U },
-	{ 1364340021U, 836U, 3710513486U },
-	{ 1986257729U, 931U,  935013962U },
-	{  407983964U, 921U,  728767059U },
+	/* Test cases against Xoshiro256++, generated with reference impl. */
+	{  931557656U, 959U, 2221272722U },
+	{ 1339693295U, 876U,   12322103U },
+	{ 1545556285U, 961U, 2793306339U },
+	{  601730776U, 723U,  186699327U },
+	{ 1027516047U, 687U, 3385354088U },
+	{  416526298U, 700U, 3047662436U },
+	{ 1395522032U, 652U,  370169503U },
+	{  366221443U, 617U, 2468792816U },
+	{ 1539836965U, 714U, 4178175423U },
+	{  556206671U, 994U, 1935910425U },
+	{  684907218U, 799U, 2892366361U },
+	{ 2121230701U, 931U, 2395880533U },
+	{ 1668516451U, 644U,  659315062U },
+	{  768046066U, 883U,  729262650U },
+	{ 1989159136U, 833U,   44268867U },
+	{  536585145U, 996U, 3734292685U },
+	{ 1008129373U, 642U, 3779097844U },
+	{ 1740775604U, 939U,  958440770U },
+	{ 1967883163U, 508U, 2766790334U },
+	{ 1923019697U, 730U, 4188718967U },
+	{  442079932U, 560U, 2658351430U },
+	{ 1961302714U, 845U,  418725413U },
+	{ 2030205964U, 962U, 3541720353U },
+	{ 1160407529U, 507U,  155686916U },
+	{  635482502U, 779U, 2954399934U },
+	{ 1252788931U, 699U, 3195364074U },
+	{ 1961817131U, 719U, 3860285454U },
+	{ 1071468216U, 983U, 2558711391U },
+	{ 1281848367U, 932U, 2429019683U },
+	{  582537119U, 780U, 2251637575U },
+	{ 1973672777U, 853U, 2686341687U },
+	{ 1896756996U, 762U, 3853948474U },
+	{  847917054U, 500U, 1352384361U },
+	{ 1240520510U, 951U,  424294678U },
+	{ 1685071682U, 567U, 1127358663U },
+	{ 1516232129U, 557U, 2438163725U },
+	{ 1208118903U, 612U,  494560814U },
+	{ 1817269927U, 693U, 2296243096U },
+	{ 1510091701U, 717U, 2522390997U },
+	{  365916850U, 807U, 1704622356U },
+	{  399324359U, 702U, 1692076319U },
+	{ 1318480274U, 779U, 3132074148U },
+	{  697758115U, 840U, 2298934293U },
+	{ 1696507773U, 840U,  460426950U },
+	{ 2081979121U, 981U, 2030259222U },
+	{  955646687U, 742U,  849374769U },
+	{ 1250683506U, 749U, 3793648395U },
+	{  595003102U, 534U,  312261219U },
+	{   47485338U, 558U, 1498074521U },
+	{  619433479U, 610U, 3298978919U },
+	{  704096520U, 518U, 1859635041U },
+	{ 1712224984U, 606U, 2636341373U },
+	{ 1318233152U, 922U, 4294083073U },
+	{  855572992U, 761U, 1398432208U },
+	{   64721421U, 703U, 2917659579U },
+	{  678931758U, 840U, 2610263429U },
+	{  692711973U, 778U, 2364471195U },
+	{  677703619U, 530U, 4293322414U },
+	{   92393223U, 586U, 2200038234U },
+	{ 1222592920U, 743U, 3902404436U },
+	{  358288986U, 695U, 4187968216U },
+	{ 1935056945U, 958U, 2216763617U },
+	{  735675993U, 990U, 3851267177U },
+	{ 1560089402U, 897U, 3110095036U },
+	{   70616361U, 829U, 2727884311U },
+	{  368234700U, 731U, 1394533121U },
+	{   20221190U, 879U, 2426527948U },
+	{  539444654U, 682U, 3323050847U },
+	{ 1314987297U, 840U, 1532766257U },
+	{ 2019295544U, 645U, 2824742190U },
+	{  469023838U, 716U, 2626662944U },
+	{ 1843754496U, 653U, 3912965452U },
+	{  400672036U, 809U,  794673667U },
+	{  404722249U, 965U, 2590267245U },
+	{  600702209U, 758U, 3742697327U },
+	{  519953954U, 667U,  909153960U },
+	{ 1658071126U, 694U, 1016441204U },
+	{  420480037U, 749U, 4007274669U },
+	{  690103647U, 969U, 2262636339U },
+	{ 1029424799U, 937U, 1940659603U },
+	{ 2012608669U, 506U,  239338087U },
+	{ 1535432887U, 998U, 1889887018U },
+	{ 1330635533U, 857U, 4029849650U },
+	{ 1223800550U, 539U,  678829248U },
+	{ 1322411537U, 680U, 2745139632U },
+	{ 1877847898U, 945U,  153715577U },
+	{ 1646356099U, 874U,  525516737U },
+	{  805687536U, 744U, 1564399105U },
+	{ 1948093210U, 633U,  507042967U },
+	{  392609744U, 783U,   33573161U },
+	{  690241304U, 770U, 1551691277U },
+	{ 1360302965U, 696U,  391079011U },
+	{ 1220090946U, 780U, 2587343386U },
+	{  447092251U, 500U, 3335665101U },
+	{ 1613868791U, 592U,  131974931U },
+	{  523430951U, 548U, 3871675719U },
+	{  726692899U, 810U, 2919536533U },
+	{ 1364340021U, 836U, 1695810824U },
+	{ 1986257729U, 931U,  550308813U },
+	{  407983964U, 921U,  360202562U }
 };
 
-static void prandom_state_selftest_seed(struct rnd_state *state, u32 seed)
-{
-#define LCG(x)	 ((x) * 69069U)	/* super-duper LCG */
-	state->s1 = __seed(LCG(seed),        2U);
-	state->s2 = __seed(LCG(state->s1),   8U);
-	state->s3 = __seed(LCG(state->s2),  16U);
-	state->s4 = __seed(LCG(state->s3), 128U);
-}
-
 static int __init prandom_state_selftest(void)
 {
 	int i, j, errors = 0, runs = 0;
@@ -268,8 +265,7 @@ static int __init prandom_state_selftest(void)
 	for (i = 0; i < ARRAY_SIZE(test1); i++) {
 		struct rnd_state state;
 
-		prandom_state_selftest_seed(&state, test1[i].seed);
-		prandom_warmup(&state);
+		prandom_seed_state(&state, test1[i].seed);
 
 		if (test1[i].result != prandom_u32_state(&state))
 			error = true;
@@ -283,8 +279,7 @@ static int __init prandom_state_selftest(void)
 	for (i = 0; i < ARRAY_SIZE(test2); i++) {
 		struct rnd_state state;
 
-		prandom_state_selftest_seed(&state, test2[i].seed);
-		prandom_warmup(&state);
+		prandom_seed_state(&state, test2[i].seed);
 
 		for (j = 0; j < test2[i].iteration - 1; j++)
 			prandom_u32_state(&state);
-- 
2.49.0


