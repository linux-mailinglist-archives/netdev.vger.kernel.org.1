Return-Path: <netdev+bounces-204147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7733CAF932A
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 14:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B3997AB435
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 12:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925392DFA24;
	Fri,  4 Jul 2025 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNpak+Xv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05752D94A5;
	Fri,  4 Jul 2025 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751633563; cv=none; b=UaJ09b7f+gdSVtx2aOXO8jiKUREQ01nQ3GDYWqeQwHmFbOAn2OHcE+Sbn/gorhCJkXeU0IgXtegOLa71dvXtwVXEXSXfyBgBgDyP4uOg6i9nEsbuOmGPvKUescPczrY+9Qu1QPHxb5CkQFcuXdLvVyInWSWvzUlqAhy7h34zwyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751633563; c=relaxed/simple;
	bh=Lv77ncIZaSXhxMERgrh5OeHFTO3hg5Vgpt53QyAMAhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LbGm8cosS+hexlNuGdb6V4wvV68reZUQaJJH9VFuXSfySng1RF7HVAjCoprmtRw01NLZype/OT0NDbvOJgb5u5Np66moGg7VGJ5gqn3WxVjbPdV+/7XLO+63E3HkbF7ZiS0R4DGzzrDmSg7elaA+aw3TJzh0/njyaPNHZFgUnjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNpak+Xv; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0a0cd709bso426174366b.0;
        Fri, 04 Jul 2025 05:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751633558; x=1752238358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U6agZDXg3JLzaN2OCV+FcnM7kSozPXczImXEBeFbSpI=;
        b=HNpak+XvYdw8A6qZi1PigFfjQ4GjEoB53RNBa3p+xTf9Wc3S3CEFfLQOBKaxqE0qOf
         QX99Nu/f9i9ZFRLAaZFErNix2H2CbIqoZpqBRFT7DQrm/U0toah8I3Gjv1LUelxgAANK
         fEG2gqCIh14faNTrqzh7wSRu9SpOEBChc2rMqDbP8MZrk6ke10T9m1w4qMZ8LrV/i+Js
         XODsPfYVCsdmI464FyacBJSMIqKE+6h6JzNc1UUi/HLjqJTxpr/MhsP5UQUXiAuHJeTK
         VaMJDGFcZ5U1WOk15ozITxEy6wM8287XDwkpLzmtU2WagMilDVbCkDJH01N+TkXrynC6
         6fsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751633558; x=1752238358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6agZDXg3JLzaN2OCV+FcnM7kSozPXczImXEBeFbSpI=;
        b=OFuVhpWl5ziXWXAlDv0rZ0c59pjhRHKVPHBuDAFFGb0retjnEoddnBCXTO48D2lx+v
         O7As3eohis5wXSxjX1el7JxV2ZL+qzJm0YsUkjIUpm2Xg3VPJJ6bGmIQ/IbdnvbSmt0S
         G0f3PWEDA0i62/17O45+PoJW5QpQDN0CKRmIlW6BMwQMqbI2v32d0l9rWCcnlhSwmMTE
         58tzYPzbFwfTL4BboGQjYqb5kjTjKIDQnJpSsJN3Q5X44d74uPnv+hyuQPwRZQUn0I7i
         VLv4+qZpVDTRp2Ab6oFjQ9BUTQ4LcS9JzQ8FpngWPwZK8qLrjjiZdxKtgHzlQaVvkXq3
         pz6g==
X-Forwarded-Encrypted: i=1; AJvYcCWJHRe4x12pD6peQuIL4BGM/IRtxNFOY8EelPkykA+4jz8melzjxBSQGY/JLU5YBF5/HLImXdWxAtz/L/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw03jKllVwYsXtN5jDNh5N4Mf/voXI5dXDw9yAC9mFYOaZ5KbM
	cApY8g3lt1Bu7zSyCLChCyj+NYrYjhmIhqzRjEHz4HipN42O2IJ6MiklMS2l+96hyHfVAw==
X-Gm-Gg: ASbGncvX8tbYYzpGVxcky1jI/PSmMErM0XstVA0RTYW/2FnepUGgcLcHdw7iKxTYI7t
	1k451PVPXifBYHScjxWfAD+bt8aaA4i55EdNSXFK4m9wVEJl+u3bTTiXAnF3k/ktg+o1K0cvos2
	AesS1OAJ1CY6FDdCjKEwJ1qGPODk2gwg8pmsTI+udMjfqJhvofIBEaQixZDn4xHLjZnSUr4hLYT
	JxFEcKAOGQemDHG8R4HGmTE+QxRGU2i/P6iGcPj8PmUuuxTgW0pVDWD8EwZqcAAgf5mfnZDeEkv
	lDTbvQJKNOLgUzxeOCxQ01pvcLNwbsUMNFrPgk3ySOQnel3S6N24MFc2ILS81gMqBCdIYycAdTB
	J0h9GLeSoBBqqL0BHBTKmqTRZ/bpV4y7wSs+87G2Q8M890FlGjvS3LuTeGQ+6ew==
X-Google-Smtp-Source: AGHT+IFpCEztIGoFzfrmV+vqdIEGfp/nTh6AxOzZLT2hvsf0an1a/VUt6ax6LIeqDZwMXaAilODeiw==
X-Received: by 2002:a17:907:9711:b0:ad8:adf3:7d6d with SMTP id a640c23a62f3a-ae3f9cecbadmr258052966b.21.1751633557801;
        Fri, 04 Jul 2025 05:52:37 -0700 (PDT)
Received: from legolas.fritz.box (p200300d0af416e00eb84418c678abf7e.dip0.t-ipconnect.de. [2003:d0:af41:6e00:eb84:418c:678a:bf7e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b64f5asm166346066b.162.2025.07.04.05.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 05:52:37 -0700 (PDT)
From: Markus Theil <theil.markus@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	akpm@linux-foundation.org,
	Jason@zx2c4.com,
	Markus Theil <theil.markus@gmail.com>
Subject: [PATCH v2 0/4] add usage hints to prandom and switch to Xoshiro
Date: Fri,  4 Jul 2025 14:52:29 +0200
Message-ID: <20250704125233.2653779-1-theil.markus@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series builds on top of the crng/master repository, as other
prandom commits are already queued there.

v2:
  - fix indentation
  - add better checks against invalid state
  - rebase

With the current cryptographically safe PRNG in drivers/char/random.c
fast enough for most purposes, make annoyingly clear, that no one should
use the prandom PRNG for cryptographic purposes without known about
this.

While looking at the prandom/random32 code, I informed myself about
PRNGs and saw that currently fast PRNGs with better statistical
properties than LFSR113, which is currently used, are available.

Recent alternatives to consider are in my opinion:
* PCG: https://www.pcg-random.org
* Xoshiro: https://prng.di.unimi.it

While both seem to have good statistical properties, I recommend
to chose Xoshiro256++ here, because it seems to be even faster than
RNGs from the PCG series.

Furthermore, the authors of Xoshiro provide a small RNG named SplitMix64
for generating high quality seeds for the Xoshiro RNG. By using this in
the default way, no further seed checks or state warmup are necessary.
This simplifies the PRNG code IMHO.

Markus Theil (4):
  prandom: add usage comments for cryptography
  prandom/random32: switch to Xoshiro256++
  prandom/random32: add checks against invalid state
  test_hash.c: replace custom PRNG by prandom

 include/linux/prandom.h |  30 +---
 lib/random32.c          | 378 +++++++++++++++++++++-------------------
 lib/tests/test_hash.c   |  40 ++---
 3 files changed, 220 insertions(+), 228 deletions(-)

-- 
2.49.0


