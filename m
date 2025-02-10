Return-Path: <netdev+bounces-164738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20150A2EE83
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 14:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74A713A2CA1
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 13:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E639230995;
	Mon, 10 Feb 2025 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzwNQpi+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6422FE1C;
	Mon, 10 Feb 2025 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194611; cv=none; b=MR7MtqFmtq+sUB0zgstjEqi2TYqcFEyaDvn1NrRhKabuF7CKrRiTnMmWZ32P4xOpeyY2TIO1aH1Q3JpllXjs6EY4ldOJKVgO2wMjjCRohPx9d+gu0JYVUyLmfglRHYgC516NXyBR1GwrdiCh9ai08ri6LzumCV1g+2fTrnK5spo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194611; c=relaxed/simple;
	bh=5KY7oOCcW8WYBB+iib5+yNJDJVeku2ql6Aa6lDnd+M8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kYYBMJhkWsMhDCobXWzb7vp3dM4m9jawuLI12B7MaM0THviRkNEtuXKC8Z/8Mpt7yTJcK4W8SUPcx1xFfvrYjRqW6vymU0zb9mgiFQtIuH21d58pZj8TTn1/PPdoT295/YFf5Tsjq3HEA3ByA0NSel3MoF6ydGgfo1E9mhRPWKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzwNQpi+; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38dc5b8ed86so1800966f8f.1;
        Mon, 10 Feb 2025 05:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194608; x=1739799408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=223MxAxNXztbp67ZxJdOt7tmG0A7uxSl64PKr7bnTT8=;
        b=RzwNQpi+DizaQu6TevsCLW/WK7c9PFQL8PBO/qetpInkfQsiVj7YabuqW6regtgPM0
         MThKtXPMocl+qDpNH5tpxnyu/rhL+lFD6NenjeeBXrBVkKJpxdGUkfbPsxHt0RhRydNB
         pyWDyoRdmt0pv/cv78mtt/kfsCwNtNjVlRp2NVKfR/txfT6QJSjJUfB9RkaDdrye1as7
         vayCLBTdC1lXgPnysdUDUAx3kfI8bFZSz8FFzrpZ4YrQaSNfz4OThIPMlon/G9YQu+cL
         J3PUd7IrmusT4nVdRVTPOFLP0ZOWYOr/aF0uawdZNpGUD9DdwvX4gJsL9l3arXCou2C4
         qDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194608; x=1739799408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=223MxAxNXztbp67ZxJdOt7tmG0A7uxSl64PKr7bnTT8=;
        b=k+dsS65m+Unzb0I9EPJIaHNjdr4FL18PKNEt5Rd+6j8Dlm1NqCUB0mNJprGXiKCk+V
         12uo3tAX+BqyoKSog2KO9tGDeYp4U9Dm1K5MuLYIsug24FLXbdPrI/oci97iyQobl0WS
         i/ysAsq0KICQgMX+mplUg3wz3+pS4OUyibJ+hcSX5VBV7b78dZSe0AKBESuQxGQYKWKV
         /5u+R+GwaPudXTY9jGXg/23jvk7fSQaVZgzJYba6edXbwroiY4ZdxhfKXmsJumI/rCMi
         RB/AxS2y0hAyij1gOY6n232qIKuYARXshK5ox15Fppyf0UOkvIv3XowjlLJZh1SAE/mQ
         +jBg==
X-Forwarded-Encrypted: i=1; AJvYcCXIeHZjhcRDVrt3rTc3c179dKqU0f1K9uNawtQYd42qTqfGD9XzbqNvdlhC8URcdJUwF9sSddE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWFJ3E4rQ9CKpN1W9arKt+MzXcElgZ1YvSaHeKU4Z0TXk9QxgN
	2Zff9suE+YqK2V6jpDQ8qkluU7gVpE+3ZPiPnr55YgvGTKpKan0iozc/fBXu41/mNw==
X-Gm-Gg: ASbGnctpjDju5tV9DxZ0EiEj4mFjEQrNXIq1kvJV19PiUOgxYmnzrX01x4YmaY+uIab
	zcbSC97e/VWORHhg5B6EYa9LdWhplwg08QJw3WqhpWBUxDw0IqZVA9ZzAYr/9l+3H2Twn/+oBhI
	nZpnUui3D0/rSwxSYB1tvIGXY9hQCJv2WUu6nINMB0BtqOSopAsi8kNFOhcbNFW3f8pjBbozAB1
	5wYDRInxCRWAz+PYgW8IHPDTZIZrDY9Q1lJHeaY4MWJe7aVQXZ5bNJ3Ps+/p+0gcuVFzV/vXuZW
	0CUG8mvzPWQbLZzylfZwlhBEoCVAZxvjLvH5BL6+/BMqIl2We6U5fQQm3g4qEfMOrmfNb6vqcpa
	e0go13D2YR4OC4ZU=
X-Google-Smtp-Source: AGHT+IF+EQhLe8h5irMRb0V2F2mpADb4UbCqz7ZIeTUohTSxgMsPVxH017EN4mAXu3VNPEgdy5ZhvQ==
X-Received: by 2002:adf:f10f:0:b0:38d:bd41:2f8b with SMTP id ffacd0b85a97d-38dc959e1a7mr8545211f8f.44.1739194607354;
        Mon, 10 Feb 2025 05:36:47 -0800 (PST)
Received: from legolas.fritz.box (p200300d0af0cd2008ab2e79e9971853b.dip0.t-ipconnect.de. [2003:d0:af0c:d200:8ab2:e79e:9971:853b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439452533ecsm18136765e9.0.2025.02.10.05.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:36:46 -0800 (PST)
From: Markus Theil <theil.markus@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org,
	netdev@vger.kernel.org,
	Jason@zx2c4.com,
	tytso@mit.edu,
	Markus Theil <theil.markus@gmail.com>
Subject: [PATCH] prandom: remove next_pseudo_random32
Date: Mon, 10 Feb 2025 14:35:56 +0100
Message-ID: <20250210133556.66431-1-theil.markus@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

next_pseudo_random32 implements a LCG with known bad
statistical properties and is only used in two pieces
of testing code. Remove and convert users to the remaining
single PRNG interface in prandom/random32.

This removes another option of using an insecure PRNG.

This is a preliminary patch for further prandom cleanup:
- In another upcoming patch, I'd like to add more warnings,
  that prandom must not be used for cryptographic purposes.
- Replace the LFSR113 generator with Xoshiro256++, which is
  known to have better statistical properties and does not
  need warmup, when seeded properly.

Signed-off-by: Markus Theil <theil.markus@gmail.com>
---
 drivers/gpu/drm/i915/selftests/i915_gem.c        | 7 ++++---
 drivers/media/test-drivers/vivid/vivid-vid-cap.c | 4 +++-
 include/linux/prandom.h                          | 6 ------
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_gem.c b/drivers/gpu/drm/i915/selftests/i915_gem.c
index 0727492576be..14efa6edd9e6 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem.c
@@ -45,13 +45,15 @@ static void trash_stolen(struct drm_i915_private *i915)
 	struct i915_ggtt *ggtt = to_gt(i915)->ggtt;
 	const u64 slot = ggtt->error_capture.start;
 	const resource_size_t size = resource_size(&i915->dsm.stolen);
+	struct rnd_state prng;
 	unsigned long page;
-	u32 prng = 0x12345678;
 
 	/* XXX: fsck. needs some more thought... */
 	if (!i915_ggtt_has_aperture(ggtt))
 		return;
 
+	prandom_seed_state(&prng, 0x12345678);
+
 	for (page = 0; page < size; page += PAGE_SIZE) {
 		const dma_addr_t dma = i915->dsm.stolen.start + page;
 		u32 __iomem *s;
@@ -64,8 +66,7 @@ static void trash_stolen(struct drm_i915_private *i915)
 
 		s = io_mapping_map_atomic_wc(&ggtt->iomap, slot);
 		for (x = 0; x < PAGE_SIZE / sizeof(u32); x++) {
-			prng = next_pseudo_random32(prng);
-			iowrite32(prng, &s[x]);
+			iowrite32(prandom_u32_state(&prng), &s[x]);
 		}
 		io_mapping_unmap_atomic(s);
 	}
diff --git a/drivers/media/test-drivers/vivid/vivid-vid-cap.c b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
index b166d90177c6..166372d5f927 100644
--- a/drivers/media/test-drivers/vivid/vivid-vid-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
@@ -300,8 +300,10 @@ void vivid_update_quality(struct vivid_dev *dev)
 	 */
 	freq_modulus = (dev->tv_freq - 676 /* (43.25-1) * 16 */) % (6 * 16);
 	if (freq_modulus > 2 * 16) {
+		struct rnd_state prng;
+		prandom_seed_state(&prng, dev->tv_freq ^ 0x55);
 		tpg_s_quality(&dev->tpg, TPG_QUAL_NOISE,
-			next_pseudo_random32(dev->tv_freq ^ 0x55) & 0x3f);
+			prandom_u32_state(&prng) & 0x3f);
 		return;
 	}
 	if (freq_modulus < 12 /*0.75 * 16*/ || freq_modulus > 20 /*1.25 * 16*/)
diff --git a/include/linux/prandom.h b/include/linux/prandom.h
index f2ed5b72b3d6..ff7dcc3fa105 100644
--- a/include/linux/prandom.h
+++ b/include/linux/prandom.h
@@ -47,10 +47,4 @@ static inline void prandom_seed_state(struct rnd_state *state, u64 seed)
 	state->s4 = __seed(i, 128U);
 }
 
-/* Pseudo random number generator from numerical recipes. */
-static inline u32 next_pseudo_random32(u32 seed)
-{
-	return seed * 1664525 + 1013904223;
-}
-
 #endif
-- 
2.47.2


