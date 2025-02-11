Return-Path: <netdev+bounces-165053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB678A3039F
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 07:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A1B163BEF
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 06:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4A81E9B1F;
	Tue, 11 Feb 2025 06:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqe6iAoa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA461D5AD4;
	Tue, 11 Feb 2025 06:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739255659; cv=none; b=WysVzsLxouw6kopHXUI7EyDhSa19jj+YQg9otR25iGKcb5iSjiEjZW9QcMx4KpNXCsp28ZEjTOOcaI30pQPoOdMi4P+IJdyqfOE/kxiKtHrhLV3f5/peOf47cuLejU4MjzecwXWHRS75sR2mh7XwT83d/bBiCLCLWiza3N8x4HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739255659; c=relaxed/simple;
	bh=gI2yotS/f8qn1Ua7Umt+ztRtJ0eQB5/s2R4iNPmkJdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ov1Wf4WbcVHMK9PE/TDPUY9c/xFS+9Bjq1l83fv6nzhHPv8YPVEhjisiWStIcmNKpTv5Lt/LkoqO8PJwfTC/dFNnKuDzHdHeLB8PfUGBZADJKcSI7NW3OsShC3cUGznSmx30keltFkq3hIuj5rk4U/+FDjFJmX82UIknWNWlhYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqe6iAoa; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaec111762bso1244671666b.2;
        Mon, 10 Feb 2025 22:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739255656; x=1739860456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83Kr1XJvuE8Nibv15SsvxQl/PkbmF5XblUMSI/u8zh4=;
        b=lqe6iAoa60y8Btvy2BXvXmZmty7EBFtB04O2K/ZKh/UIbr1PmT+DNmEygqQnmm1QQj
         IjG1xc8Gp07JW9OL0IChcNB6Kpile+jYWlal0VtXFDmfyfZDshQXWeE62p6pGuiEgThN
         j8kSTkR/tzTbOHPM0DXXOMR24LGIeV1WSxZqbKCVKtfQ8vUykl/U4P3wTF7Vn+GYzRvJ
         FZb2TQFr4vqro7D3urneIRPSPHipUBqor0FiMs0HZnycI13DoFLO2ZsiNfzM134iA/Q8
         Gzp1Ncx3lzqomRCVqlcKcv2XSzjI8PBGqC3t0PqZjFh7zvCeL99zAjfwfB1gelF8EhRi
         UtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739255656; x=1739860456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83Kr1XJvuE8Nibv15SsvxQl/PkbmF5XblUMSI/u8zh4=;
        b=MqV/Gs7Z02mzW3KZ7wcUvP5G4hOpYmqeHL91fsoUV90oGn1Xfpidy59LIiG/lhH8KO
         42kMGVuA+1BnsR5t12qPFpM9qBY4Mc+QZM8yArWZDwgHywqvCXq+zYMzU6hrrjvrqbzX
         xRtlD1K5YeNsbfKtOmXJiGu5NTu6ijUKozFFkxH88EWX1HT/NY4ToNnkea27F5Kw75km
         ZQQnD7pUqJyu5UiK4K6xjlCHmngc/JaHH+EEEhMQr50wf2skEEjndc5yplXMmKXaM/G7
         hQJCFcaMl3EWyKBHk2wlpv1ILCjAqvFN6bRnZfbxO20DLPztuzSTDnHhS4lhNyGHlkpQ
         9hFw==
X-Forwarded-Encrypted: i=1; AJvYcCVGrhICGXv8sTlD4idRJgTMtxGbv2jcFka2Cpo6LbRDeyLAH6pFhZ5ohCjkAVtSjn2bDHFOE8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEPCgFEskw0dw0BhfM1MdIDv/pA5uRyKGZgh8sKl6gysA9f6Ec
	J5u82dpxxHxdtsjtR5kw8vItWrf6SI5c/NLuRPBuaSjMqPpK6Pq4vy0rwKRnRRFB8g==
X-Gm-Gg: ASbGncuccINlgeGAFyeQfYH526Az43iN20mR/58Fi4KONzubmv6GG3MDg7qKoblVnF2
	rjOdaiyFBbv4rnm2YJQawq9fChxG0yw65DJoe6Dpu51AHBiiEyWoippdf+bH2o/ab2GiZ8fdVac
	0QZE46LfsTHiAkOyrV1CoZupgxFIlM9sJsdAvj27leMcHoEXqT+9APfg1lE+bioyIlSqKZgozmh
	rOy6pFonq4E2uxsRWpP8xLGkjuJflPd023v3ODpfgpSLGoWv3kUaVkKcQn/sSzh2ZSVZA/MkuPP
	8g4iVcW3RPTkOtPuC9jVxwrowYFZj1JuiBUS/gxHTy3J3ttrSoYwCG7jxDY8rBD8Hy8GspTxHpu
	kt/Z6sWaMhE/8z9s=
X-Google-Smtp-Source: AGHT+IHsRixgYX74cjRITFO7Dzi7RuKZ0l8c1d/vpy7ESsNCqcmtKgflrfKndElewU1nswOLlZhidg==
X-Received: by 2002:a17:906:564e:b0:ab7:c893:fc80 with SMTP id a640c23a62f3a-ab7c893fda1mr524868966b.24.1739255655913;
        Mon, 10 Feb 2025 22:34:15 -0800 (PST)
Received: from legolas.fritz.box (p200300d0af0cd200603313d7beea72d6.dip0.t-ipconnect.de. [2003:d0:af0c:d200:6033:13d7:beea:72d6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7c62c464dsm300440466b.28.2025.02.10.22.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 22:34:15 -0800 (PST)
From: Markus Theil <theil.markus@gmail.com>
To: linux-kernel@vger.kernel.org,
	andi.shyti@linux.intel.com
Cc: intel-gfx@lists.freedesktop.org,
	netdev@vger.kernel.org,
	Jason@zx2c4.com,
	tytso@mit.edu,
	Markus Theil <theil.markus@gmail.com>
Subject: [PATCH v2 1/3] drm/i915/selftests: use prandom in selftest
Date: Tue, 11 Feb 2025 07:33:30 +0100
Message-ID: <20250211063332.16542-2-theil.markus@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211063332.16542-1-theil.markus@gmail.com>
References: <CAHmME9oqvWp_Nd1Gwgyw52qy8wxztMyCpNsjByH=VnRaXqczww@mail.gmail.com>
 <20250211063332.16542-1-theil.markus@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is part of a prandom cleanup, which removes
next_pseudo_random32 and replaces it with the standard PRNG.

Signed-off-by: Markus Theil <theil.markus@gmail.com>
---
 drivers/gpu/drm/i915/selftests/i915_gem.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

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
-- 
2.47.2


