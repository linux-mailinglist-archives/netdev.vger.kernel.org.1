Return-Path: <netdev+bounces-165054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCB5A303A1
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 07:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F583A5A1A
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 06:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E111EB9E3;
	Tue, 11 Feb 2025 06:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMO/t0CG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CD01E9B14;
	Tue, 11 Feb 2025 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739255661; cv=none; b=SL6BZb6FYICo0NCaPfeYlqPnY2B+zEQd36dVovZEMqi54GY7KypbZQYNdLMR3emzcxHKjSDbuBram8TqJgJDUzHxwnDJpinQ8uy+39XcGtOJ9D2hX3e3QfnOxJYrRKnwuL6+EdgaV/dJTmD4lsG8Dc14aF3r8uiPxe0Q2XlIyUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739255661; c=relaxed/simple;
	bh=y1d0HdihzwRAq78geV6/YV6BAMuj1/o7Yc04IREmw3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsXh4LDAdYm3UtOTaPjfhekSzTdWlNhL3bnGD2l0hqzyR6HJKI08JKJ3guYNMvxz9OiN/7QQvvOEgMrHe7jKqJsjaHUlDTgIxEeBO+yxa0T5472Of90liVvvY/8xFv36jLYQdo1N18/UKWYBN780/IxixattzqEPl78OuQuaqog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMO/t0CG; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab7c81b8681so249841266b.0;
        Mon, 10 Feb 2025 22:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739255657; x=1739860457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VPaO82oa+ToJAvE8KK14A7HRHYdSJZmkn8z9n0Ed6E=;
        b=OMO/t0CG7GvDQ1/e+xCFiyRVtrJC/bSqLcvxyhVVpLdPV0BudclwLEFh6XdUQol8Df
         9bl0b7HYnmAQFYx7ozW/OwN5rWa1+hkHPJHiFx5wlXkLX2C0V+8Df0ByBzytTIL8iQAp
         Oo/NF6WoihTYSePwzTVD2dJ7PE3qpOJ34YJEMLNEU8U2Ym6cFpthORclJ3UA6VHIBGGK
         XmXXUmUT79DpImIWdbvxaq3xnnHCsp5ZccChqKEmxrjK1Uh4tFk9aU6vh0z9kDbYg7Mk
         OOyCr3bOqZ12R00htn5RLUbSvGWURMHk5JZ8pSfezwnBSyKwarr78f7as9dXtO7qR3VV
         XZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739255657; x=1739860457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VPaO82oa+ToJAvE8KK14A7HRHYdSJZmkn8z9n0Ed6E=;
        b=rrkeAjD8tSSkcNXUPeEfRYSVl2GZRuXA612q1QUpimOKcuhtSjfXmPkOtvrQlQC4tk
         BGMB2gDKWl6MkXLUVRbYpcFfdZ9JEpOxamWjHb//4JdJo25zuh+lIVrLhPddQdi3Vg4e
         Lhdd/OOVVPdHYqzvKgmX5X9LWqcdCRJnq+0Jpr02sj6Phkhh0uTJW8X7qWsd6Ht0qF4e
         A9gRbSGdqbcGfyZyjTVRbr8qivQRV6sMnm2lplYCbnJrVsej+6Pgtj9BaeqQ/s5UEUGL
         2d6RA7dVendeGeC86JGqEHvW2/ANYIYuVWxZG5X/0zUxg6lU5jAYo6SMkcuPwrZfBR1o
         TrzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj25imhcoC68d0JTDV8VrXlIcLjpa5xzak5Nmbo01UqscAJHanhKkcKC14TFj90xs3RL6oaOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXfxupKAqlR/I/xddhmfuDJ7LIP/IzycGigXVtHvWmFhTfebep
	TYWQJ89ZsESX85CaWjSS05vQEQ+gpcpbI34E9wToFj8WAlVVKpYw8veQIIvocWVu1Q==
X-Gm-Gg: ASbGnct3x27Q7aneqSDlGLpMsSiRMolAcJ2tpi8BbumtiKMcJmJlrQy1GZOqa8e36KA
	ekqlgGAOUPKsyEmp9eE72SRBNthOt/P+fh8YQefHXR/V06XbpobALIgw5qB95UqKXyda51qhSw8
	1tfdHxyXOgtURaAbGhXDOQ6KQfeR+GeR8dVI8fKZO3oniKSmx89oQP/X7hDhUn5T7SvYKgoReyU
	EteAGIOCDtCnSqFldaAvtGSsAFw9cKjjfkNVRT3UlaaUWur1KiE4NFyw6H4an2Fd70LLAZNaK7m
	UTznFDZo2RGoQTa/cbkw5NFrVNTOlOiQPIB7XDxv8cwJiLq7u60QdnLsX+FkqcdqlZlD2q3dnCz
	MpEbmUpEmmTJePus=
X-Google-Smtp-Source: AGHT+IH+h/EDzBlXmY1icTRjXeK+Ak7KcNlqt+EmP5Cd9qKrtjUxCKio7N1P1GRT2oqbk9e4+uCvIg==
X-Received: by 2002:a17:906:6a1a:b0:ab6:d0b9:8fd1 with SMTP id a640c23a62f3a-ab7da3ad5c1mr184746966b.34.1739255656735;
        Mon, 10 Feb 2025 22:34:16 -0800 (PST)
Received: from legolas.fritz.box (p200300d0af0cd200603313d7beea72d6.dip0.t-ipconnect.de. [2003:d0:af0c:d200:6033:13d7:beea:72d6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7c62c464dsm300440466b.28.2025.02.10.22.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 22:34:16 -0800 (PST)
From: Markus Theil <theil.markus@gmail.com>
To: linux-kernel@vger.kernel.org,
	andi.shyti@linux.intel.com
Cc: intel-gfx@lists.freedesktop.org,
	netdev@vger.kernel.org,
	Jason@zx2c4.com,
	tytso@mit.edu,
	Markus Theil <theil.markus@gmail.com>
Subject: [PATCH v2 2/3] media: vivid: use prandom
Date: Tue, 11 Feb 2025 07:33:31 +0100
Message-ID: <20250211063332.16542-3-theil.markus@gmail.com>
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
 drivers/media/test-drivers/vivid/vivid-vid-cap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

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
-- 
2.47.2


