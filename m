Return-Path: <netdev+bounces-178742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B09A78A78
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 11:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B023AA79B
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 08:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FD2230BEB;
	Wed,  2 Apr 2025 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaHdtBci"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A51E2101AE;
	Wed,  2 Apr 2025 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743584352; cv=none; b=OA4VAoskO6ch8uWFLqBBuyBTiSDtjf6S20W9/T1qzE1aESbZ9AAd68u/g1+wXOZxYPvCLS/D8mSIAL67sZtP+QYTmi1luooMtP+dIwXGM25fuvhB0V2eIOEFlGmrq+0fftJWJY7IRqzkUKQ2W0/b5XUkX1er3nVnrDPklHxw6bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743584352; c=relaxed/simple;
	bh=FImPpNmyJS5Unwz1IzdBjZhRiBRNZqR4MSg4lmTUX5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D9Fczdyylqf1mbZA7WS4R9m3xRFBhxNXuF8hqwuS2thSZCu3D/ZEoOf0rS+989uESyUgSTlIj2CmeV3ZWD6qik17oqbdcLxFn5Qid/OSHFFQcBxU8f90/OnGPttJVZeRa798SJ/5BxxeqcGosV3lF5YRJy+b9IOCoQ1ceu5yaeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaHdtBci; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223f4c06e9fso12765545ad.1;
        Wed, 02 Apr 2025 01:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743584349; x=1744189149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ve0W8Sp53gZQY9zpfnHE+Bd23zrDJDsNySDJaZMcLUk=;
        b=BaHdtBci3eZqgzE15qw4rX60w1IpHNI+QxlAldX3OHPZckmuPupu9LZ7OULBYCuu9F
         YEeMIisPXC75La3gGIcGEaMJ16du6GnFlyQa3DGfp46dFy/VKPJXLCIwKgqu3rUiyWjK
         B+ZVYZrfH3IEVGnAIS0aq+o60KE18WkwPmkavNoz1cDgXeU7uC1NH0u+FfGwv+ilnzjY
         kGYraqiJpLFfZJJ+T2oYQnLMMeOkJ2xIw2gzqBP3IwFioTFPf0aFxLlFEstJcNrwZaxI
         xCbsxumpj2/p5gtQGhspZQI+NvyQB/PcZANnlA42QDDcLmT9fI3iG+9fbMs8MRpS6vhU
         /q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743584349; x=1744189149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ve0W8Sp53gZQY9zpfnHE+Bd23zrDJDsNySDJaZMcLUk=;
        b=YiC/Jw+GcXdHEUDspqKL9hFTDfpZx92JxP3MR0+IequkvTDIiJ47GYboKFsQptAa9z
         hA8traMTW/oIkB309puCJH1GqXjzo4qq7tj9CyI3iDwXP9jCWI6YAMgUA5A8VnuaEYBS
         VpvUwiBL2JxCE5whx9pquVKb+SJY8WZusRZLQIydumvDjeCu+trNj1L80hb88d+/mgoT
         aj1MlC/geSnmVtTwerCFKBT5jfjb2+3cS6g8eSM3FYMvsT8HJhsCZvcTAV6P8Wxj9oRU
         P9ajYEoINeLbl3KZUw8Wimbri+wrz1sxEdNeNwXKVgOjM4NfDvlnPX+yqEmW8UTY60SJ
         ZwZg==
X-Forwarded-Encrypted: i=1; AJvYcCVbBONxZFvhBKjlu2fYNaC4t+nTO7xB3ku07FB/KjzgC/hGWL8GHeO53vGNEfIUue0oP4cABrPgJG1d@vger.kernel.org, AJvYcCXP65Zf2zam1TGKgCm1mIOjWkRP4vL+CmRF3GFQAk2DeWxC5bKcXaokExJJeHJttz/p0t4olGKCKq8zLF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoy0PQKr17fh0RB44nZ6t+jvvcyM4j9/QkPlSc7p60kAXfZ1R4
	v5v+HBtox4yGmcr1EnBi/6wKItNLyoj+MzS3o9hbZ8Ls91OPQsTi
X-Gm-Gg: ASbGncsIUV8/Ar94hBV9vxxLHXn/+MW7F+Nx9Fcqyw7hcHe7nhlunIXA0RkK8Q/F0hs
	eGAaxUVYaHxQ2Yb6mF23DHezNhuGtBAcThAFwGnF1tmoqu4zhx3nD/NJvyiYl2f63GWG2/RLiWB
	3A8rZMN2YizXInNWMPxCvnvriFMAkeUDWZW/mxlDwbl4cDjZH5hTuNJM2vR6AlRhIYwAKI/rvij
	nc3mmfdjB2ynqSQ1D/iyRMy4TAYzCk0LjdPrvJNBbx/ywzPk/8JG9ZgZA0dEtuI7Ms66yycgGf9
	3nDZIju8vbyqT5S7HEIX79Hw48jHRnfi7hash5YUbBO9Hnw4tl6b6wc4iGJS8D2E6/8/
X-Google-Smtp-Source: AGHT+IFa3BpE//zwvFShApKvt+3e1p+ONEbWXM06PMfvHx2G5By1UCRT6z5CIwzVQTE8XmebbhJzDQ==
X-Received: by 2002:a17:902:ced0:b0:215:6c5f:d142 with SMTP id d9443c01a7336-2296e396d8amr17787695ad.20.1743584348823;
        Wed, 02 Apr 2025 01:59:08 -0700 (PDT)
Received: from mi-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cf6dcsm102249465ad.113.2025.04.02.01.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 01:59:08 -0700 (PDT)
From: Ying Lu <luying526@gmail.com>
To: oneukum@suse.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Ying Lu <luying1@xiaomi.com>
Subject: [PATCH v4 0/1] usbnet:fix NPE during rx_complete
Date: Wed,  2 Apr 2025 16:58:58 +0800
Message-ID: <cover.1743584159.git.luying1@xiaomi.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ying Lu <luying1@xiaomi.com>

The patchset fix the issue caused by the following modifications:
commit 04e906839a053f092ef53f4fb2d610983412b904
(usbnet: fix cyclical race on disconnect with work queue)

The issue:
The usb_submit_urb function lacks a usbnet_going_away validation,
whereas __usbnet_queue_skb includes this check. This inconsistency
creates a race condition where: A URB request may succeed, but
the corresponding SKB data fails to be queued.

Subsequent processes (e.g., rx_complete → defer_bh → __skb_unlink(skb, list))
attempt to access skb->next, triggering a NULL pointer dereference (Kernel Panic).

Fix issue:
adding the usbnet_going_away check in usb_submit_urb to synchronize the validation logic.

Changes in v4
-use the correct "Cc:" tag format.

Changes in v3
-use the correct "Fixes:" tag format.

Changes in v2
-Use the formal name instead of an email alias.

Ying Lu (1):
  usbnet:fix NPE during rx_complete

 drivers/net/usb/usbnet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.49.0


