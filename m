Return-Path: <netdev+bounces-207511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86831B079F1
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 17:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA766567532
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 15:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05CC24293F;
	Wed, 16 Jul 2025 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfufTYAV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C341F4717;
	Wed, 16 Jul 2025 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680055; cv=none; b=CcDPlU4xofXlAAkjtkqv3PQaLm0AL5JqFXqsYgCe93EJAdFtXqoCHjQYbJBpOyQOwBPrk4nY41T1HK9tBXASbjT5jSl1ni/D1CGbScA5+vsO3xtPvNosAiVgC90/wT45LPRVkgVK01d8JkJ9Ob4ncNpKcGM4fXBssjydJZktSeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680055; c=relaxed/simple;
	bh=wyisApwR2KJgRL+YpRHialeVAdbXt2SPFnPpApHzX6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K98I0x3CWXwAVBsLf4DqCUPi3THvgMSaieWq4F4fSxOgvyRHJWQ1wv1FzADAOwvTKU1JtD3xs4ej717BZj0eSp8XhE5xHKHJVNg5Sa+kmCJtxREuGUjGdvUuvHPfEsRcnZkVwWyEpbVosbaiwiIg+mhXoDFdyQciCd03ON1+Ces=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfufTYAV; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-313154270bbso48538a91.2;
        Wed, 16 Jul 2025 08:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752680053; x=1753284853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kK2GS5jiIyNR2fbDCWhr6RAWmH8MnpgTjQZo6BcexN8=;
        b=gfufTYAVghV7Y2LeGWR7tRSJfqn3PQUo/X9Je1oPQCE1Qgzi/zF6C3HmU7DdKnDAof
         xxUA5KW0kE0VfFzFR5TJLF5+5CG6wK6DtCLuhslKKzEWu7FHsCuKU3OcZfUjLXaMpSwb
         f5nbRvbjvlY5zcHvdXmTatwsxXmDScXWQsmDaY9lItsg60eLqppfysQP0sgPl3b3Cz2C
         CzDuJJ/3SaQikdTLxv+Ugx0CLGOtjk9Ko5Hz0qgtD5MNDEpoZwIXjGhfxknnxBuQNT64
         etUGkUJl+tAQgd6mMQ4N/flpMAqk65WUi44UZ/kDYYZcC2VFMnLTyGXh8Y45F9oLCMXV
         5X+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752680053; x=1753284853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kK2GS5jiIyNR2fbDCWhr6RAWmH8MnpgTjQZo6BcexN8=;
        b=rNg9HJNhEBfZRFOyn3i7jiQGuyGpgWZWaZ1EZszwmVQHhsLQVwUhFa8/RhDPWH1kRK
         e5S5B/9LzZaJ73BGOza2M+IqEs5Isvg2YjuTAHKNTadRYbnXNPYwyTHqlYEDwYK0PBB1
         PGoAQRZL4t89Tm/MyF9LMSVTI+onraG3KIGuYNytu/Gwx57q6QHoUqOXPXxc0XsjOOZ9
         2yKxyOTbMb9B/+FB/b1C+TPEz/uLUFf8AF3vlBA1HxZubb4XkgAbAX7JkWi2QfLaqRG/
         VkazM2bT1ECXM3oDnU/PUURbMANoSHjjEUY7KZsVWGvFgc7wAUATuN7Rk7kbBS/u9xeE
         LJtw==
X-Forwarded-Encrypted: i=1; AJvYcCVxR+jeeJ2P1zNqi7A5VJKeybctQjffJMdx5bDRfTZ9xCA6IzvARUFpS6yWhmKrvLCi7/fp4oyiaqHOEZk=@vger.kernel.org, AJvYcCW1HPZ2jr23aBEoEdjOLwsaeZGSMyGj5YOHb3o8/zR/OtORHH8eqcBLvvMUcRLhGhspIMm+prYB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4mSticFhUm8PhO5fMEAvnrrtjn+V2qHarzLBQjBonKeKgIU9I
	x0OMXkqmEkR+4DzZSUNGM0nyJl0mIAOV/2R1UbTr497+jYiA7eKs2CyV
X-Gm-Gg: ASbGncv7+YwQU31jCf0mYrHVUYfGFJvtT6aLG+yuBIIxF6bSSVhVM0Opg/EL0ZqD4zG
	dLv4Yj4/HQkM0WCx0klQ0lrW2fN4uDd4Qijdg2nTFTDOnZEsK8ogbn9cqtqsKI/zV48/FFCchWL
	CENpgochXzpnoSzcM+HZyi2mjsTX8C5X7mZg8IvaOXmgYEjmR8nePA9z1DdCGIVtxSH0/gbmk2b
	kYTzTfXJNd+7QbFbZU5h9Dw9kTdYW9CWiiAp8aADCe5L0L+q9bD0x9Y8f4rG68pOjdO952MMn8V
	YkejdPpx5I4SMNz4bqrpfNVO0/SIotJHZRhUHlOGmMEyqood6VBSRyscXMNIi9n1faTC/bcDTJQ
	7Cv7+kBOBJfegCKKdICqjg8EVlP+s
X-Google-Smtp-Source: AGHT+IHsbkBGxL3bE2S2Qc8SHdyb9jAvmdsH+jD4WnQfn8GqhiaRwM4rdCJ+rOhuCkjDq25eMkJKGQ==
X-Received: by 2002:a17:90b:3b4d:b0:311:f99e:7f4a with SMTP id 98e67ed59e1d1-31c9f47ce96mr4419797a91.26.1752680053190;
        Wed, 16 Jul 2025 08:34:13 -0700 (PDT)
Received: from archlinux ([205.254.163.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4283b67sm127946245ad.3.2025.07.16.08.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:34:12 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] net: stream: add description for sk_stream_write_space()
Date: Wed, 16 Jul 2025 21:04:04 +0530
Message-ID: <20250716153404.7385-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a proper description for the sk_stream_write_space() function as
previously marked by a FIXME comment.
No functional changes.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 net/core/stream.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/core/stream.c b/net/core/stream.c
index b16dfa568a2d..7a37e7dd2c43 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -23,9 +23,13 @@
 
 /**
  * sk_stream_write_space - stream socket write_space callback.
- * @sk: socket
+ * @sk: pointer to the socket structure
  *
- * FIXME: write proper description
+ * This function is invoked when there's space available in the socket's
+ * send buffer for writing. It first checks if the socket is writable,
+ * clears the SOCK_NOSPACE flag indicating that memory for writing
+ * is now available, wakes up any processes waiting for write operations
+ * and sends asynchronous notifications if needed.
  */
 void sk_stream_write_space(struct sock *sk)
 {
-- 
2.50.1


