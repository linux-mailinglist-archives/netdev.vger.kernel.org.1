Return-Path: <netdev+bounces-130182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF59988ECA
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 11:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC291B2155A
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 09:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FBC19F106;
	Sat, 28 Sep 2024 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hx8TB12t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7C819E965
	for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727515453; cv=none; b=QTIvdueg/tT4BkhFLaIMdxPpClGReTr1Jd82KUDr0eb4N3cH5oxsly8tlEaab/U+k5101vmi+zVE91Mafap0OErw+2MsvBX2MVoW8CWLfM237bORiKjeH47VIFLY1u9jrISvlURIqUhqaEa8jJY84+gwFeQwURddY4CyzdXzvsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727515453; c=relaxed/simple;
	bh=e4EOZ2HPxYQRtVI+xGqPOTIx6s2W5eP8aAW5ekT0Kew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQe3XBGx7Wk8ha8cvAXLT/Ng4VIm/ANsZl3Fj6RwbBzPxXg4vjYxXQxmonhqvtrDgTyvEmj1cEE2b/t975ir3LjnhR/iPdE0X6xGF1Stq45Jhw6gIc/8srsz1w8fx5L+QAlWi5GhO9d0/BTWwAHMlt/foiU5gaKv4E5cZw+8Jo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=hx8TB12t; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c4146c7b28so3298446a12.2
        for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 02:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1727515450; x=1728120250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjIc1J/QOg1BolbQLwdYwIZ4pu/ITooUKCVTfwuJFjo=;
        b=hx8TB12tiWFr8YFpmiGdi/zjXwTkb2sAPaGmEks1baoGUGlz8pOzdu4iEnmYbLHP45
         Xo8uMvwB9SSaJyTJzmphNJQ0M9bu0zPTzUfFYB57gfuKEzU2hUURnBDxWxTE4FVCLN4u
         xuyxl6xq7AUeZg4wKj+dz0VJEpBkJWiZjBzhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727515450; x=1728120250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjIc1J/QOg1BolbQLwdYwIZ4pu/ITooUKCVTfwuJFjo=;
        b=CYYVKGqmtgWkvryQ0Gm0zWhYCkU7YZYZTQkHizELNInax8slN85xVmKgQBE8JL5awC
         TzNVLmwxIEZEpwOJgUQ2UofI4ht/7qvOJjmK6KaHzppRoZe1D4oulDfkIStWwrB9YenG
         uUbqXfxXBZh/jMXVh70oVMpdCtrCu/dDpUgzap9r1BeiRPu90Fh4Vf0Jw3xh958izwKF
         c0fQKOaJGDVu46wIoYbABIuoBP2NuLdcKDhoL3qHyvbhOXRnq6g+0nXY1m9l/xFsUih3
         QGYB//T3LTwbhdfm+e3L8C/vx8c5w3JkfAIP24Edoo6CMJ8hHocNFzaA2VD1ccwFVnK/
         GDZg==
X-Gm-Message-State: AOJu0Yyauuymk653FWoTF6zVDR0pSVwnrwhtlVuKBQGSBTK2zbziJ9Bh
	jAofY/Rnl5we3jEZwgbF2ZuA5puwDGyyis5wS55VgXVUp09IySBFzdAO2s6to/jguFCeTlrZLMp
	6Cuo=
X-Google-Smtp-Source: AGHT+IHt1LO35jWV7Gm2BcyboZ5q2IJZZ7LlKA8hp/yt3ivgfnrd0drwDSPPXAVrFoAciaOu7c2U6g==
X-Received: by 2002:a05:6402:354c:b0:5c6:b7e0:a363 with SMTP id 4fb4d7f45d1cf-5c882601ba6mr4620373a12.23.1727515449672;
        Sat, 28 Sep 2024 02:24:09 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-54-102-102.retail.telecomitalia.it. [79.54.102.102])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88248c672sm2104213a12.60.2024.09.28.02.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 02:24:08 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: [iproute2, PATCH v2 2/2] arpd: drop useless initializers
Date: Sat, 28 Sep 2024 11:03:12 +0200
Message-ID: <20240928090312.1079952-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240928090312.1079952-1-dario.binacchi@amarulasolutions.com>
References: <20240928090312.1079952-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is useless to initialize the fields of a structure to their default
values. This patch keeps the initialization only for those fields that
are not set to their default values.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---
Changes v1 -> v2:
 - rework the changes based on the changes of v2 of PATCH 1/2.

 misc/arpd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/misc/arpd.c b/misc/arpd.c
index 91f0006a60aa..a42603f60e70 100644
--- a/misc/arpd.c
+++ b/misc/arpd.c
@@ -441,9 +441,6 @@ static void get_kern_msg(void)
 		.msg_namelen = sizeof(nladdr),
 		.msg_iov = &iov,
 		.msg_iovlen = 1,
-		.msg_control = NULL,
-		.msg_controllen = 0,
-		.msg_flags = 0
 	};
 
 	iov.iov_base = buf;
-- 
2.43.0


