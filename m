Return-Path: <netdev+bounces-70798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8B585078D
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 02:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331D22853DF
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 01:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C851ED0;
	Sun, 11 Feb 2024 01:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="1dAO0YzQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5C1367
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707613493; cv=none; b=oYoUTsg40yhuoqie+fAxQZSba77UWrIEeERuhtkHkFYOA+DzW/hdpQFgpJgMxDuRQ64o2u52GP2NlOU5tzaTzFSnf2QV4w7Znjg0znLL5LL8C4Q2FSMwdRIp1q0JXB6kh5qAVSqMKsLmLM7isQ3qR/CBuls2AkyTEzbMvzHSUgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707613493; c=relaxed/simple;
	bh=I39JouFGwvjM9nHvg13S43M8S3nBmZOGb1WRAVIILrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T/j+jlfV/9SgmcZvjX7fdOsaZP/WPYKH5slvaXRW9RBo+YIu0i/HKrFaXBGAc0rsybL+BqypUiW8wDPzDnxbKze62e1tzDVZkEj9iUB/KDhSXE+gno9JXxOiGjybZVMGc15d6YWKkPOi9+1Gu+R0s3MPqMCNO6KQMoTIbmBZMmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=1dAO0YzQ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e0a608a36bso445572b3a.2
        for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 17:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707613491; x=1708218291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nIRPBe0etEXAM/5m5KKabWXUJdh2/ZZxsRqULvyYy/Y=;
        b=1dAO0YzQuPMLfNaU/tbFPHqLa1ZzIYqcm1JmZMAPg/QRdWe9RGKyUKhA/nzBmL2B5r
         KnCVXcYPDVVo42ZGXbHF4ZnRJ7UMPHLpEECzo7FeJiFP5OM5KRFi3wPfepySZvz3mhBG
         DW3rjeWpZU1WAVihbZb7SvmZR+5dF5Zp6gaeQoZzzSF6RxCsx7oodBclkgHJM9LzxbI6
         HOLrWrsHYJUOZ8LYJQbYfhnQmV4Q4C+avLRWDkbRAqsUe28JwxG+/m2z4yw9N5UNdxLu
         zTWUhAvMIMiInrKz0C8W8jKxSy+U5lYQyMrjJmTZd6j4VfifChjQ07V+SY1z/uwUptKl
         GF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707613491; x=1708218291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIRPBe0etEXAM/5m5KKabWXUJdh2/ZZxsRqULvyYy/Y=;
        b=b4h0gwprRrIMS0EljVsyeSnoLdsxN/H29OEKd6Mt05CJ+wuVHV+1+xfJkd4nhuCdD9
         0VZVEZQtZ4+2Vp4Sljflh/tAbCvcZy1ezhy3lMjbWhw+feDqH5JX3K7EMf9zjzLWZkKS
         wJ4wQ2+UoT1KtWdeiYP8bTzL5qYrru2rOkr9yRaKc8UsYb7jSkFDf3AVi90psMAGZrVp
         dN+eHxLFRO9N3YdSq8n+bqqJ2fVu1WomglpNbzHeZI9QZNS3fADx8Y/ZZCtsAflxqK/0
         9RYlFCvyfO1CZn4NWIJZMhRXN3a/sslpjhRCtvmZgOYMWYqh1Xfnv14QJDqU6SdZ4S9s
         bjyQ==
X-Gm-Message-State: AOJu0YzAJZsATp9TBCI04y6hU9vfceIL16ETMjeKwG8iGeJ/aN3bWpsj
	GtarI64vrh5sBr5S6GqtL4v7bl6qTAyT9q3E9sTXbzQv0yvj13dj+jgigwA4rwZR6SsMkQ2PiRp
	s
X-Google-Smtp-Source: AGHT+IE2W8p6RB/Cb7g6v8KJ/d2HU6IopWPgwWB0Y7w3drP3FLtyg4bYI56osdIvWVFyjhbYc2Zxmg==
X-Received: by 2002:a62:e716:0:b0:6e0:99e5:a8fb with SMTP id s22-20020a62e716000000b006e099e5a8fbmr3412531pfh.17.1707613490987;
        Sat, 10 Feb 2024 17:04:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX88qQKjv++7fDE9c0drL1HupeevPJLkBVbZdB9hALrSnuGJLC5yaVZUq0ArkgRsddUG04q30McKSkEtmhgVw14pvFPx2KdFuIwpXM0asFoDiT6D8JQiEI061inKA==
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id b18-20020aa78712000000b006db9604bf8csm2867856pfo.131.2024.02.10.17.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 17:04:50 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: liuhangbin@gmail.com,
	jhs@mojatatu.com,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] tc: u32: check return value from snprintf
Date: Sat, 10 Feb 2024 17:04:23 -0800
Message-ID: <20240211010441.8262-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add assertion to check for case of snprintf failing (bad format?)
or buffer getting full.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/f_u32.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tc/f_u32.c b/tc/f_u32.c
index 913ec1de435d..8a2413103906 100644
--- a/tc/f_u32.c
+++ b/tc/f_u32.c
@@ -7,6 +7,7 @@
  *
  */
 
+#include <assert.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -87,6 +88,7 @@ static char *sprint_u32_handle(__u32 handle, char *buf)
 	if (htid) {
 		int l = snprintf(b, bsize, "%x:", htid>>20);
 
+		assert(l > 0 && l < bsize);
 		bsize -= l;
 		b += l;
 	}
@@ -94,12 +96,14 @@ static char *sprint_u32_handle(__u32 handle, char *buf)
 		if (hash) {
 			int l = snprintf(b, bsize, "%x", hash);
 
+			assert(l > 0 && l < bsize);
 			bsize -= l;
 			b += l;
 		}
 		if (nodeid) {
 			int l = snprintf(b, bsize, ":%x", nodeid);
 
+			assert(l > 0 && l < bsize);
 			bsize -= l;
 			b += l;
 		}
-- 
2.43.0


