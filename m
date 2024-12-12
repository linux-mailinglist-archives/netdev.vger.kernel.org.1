Return-Path: <netdev+bounces-151545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 288AC9EFF47
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 23:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B8A286F6F
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 22:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC37C1DE3BA;
	Thu, 12 Dec 2024 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="E1Vzf4Ik"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98C01DE2B8
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 22:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042369; cv=none; b=r9EpuPPZgyo+nCEGAIy6/PPKrRxIhi8W3MwCM6Mtv+k+HdO/+Zuwyxg6DjvmZWDBqkfkiIYC46z+DzKVjStocU12MurLcLcOoaJvF97LT/QSA/REMSsDHwuLc+l/oMXoa5UB0LFrjnDC1uzl8jFIHF0odfT/0Z6XDPvnTpFUgBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042369; c=relaxed/simple;
	bh=4pB5oOG/al/+veIVNf3erQM8CjNyPQ/J63c0AhLtShg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ke92qnTdFhIdmNgdQXBm/D7E7VGih+yzFxH9cIirmqPQR/IsIpapbAVfYg0Kl2BLELaerhAu/mFni4ydpZLF1kdWX0Bvk3Zj8672NLRDZ6MDt1YD8JcHREaH0TNihmdBW40GUVXbIxp5ePHcN8hyULMJyEbGJCqwtSCQGYoDFTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=E1Vzf4Ik; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fc88476a02so932253a12.2
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 14:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1734042364; x=1734647164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkdI0v71YIIMW/h2nJtvCUZS2CV2DbhWrwQdxX337ug=;
        b=E1Vzf4IkkujA4EiT2lgDXvzK0hygmm5GlcIiKgCH/eTxnUmO7U1RnI4r4rntCABH5F
         7JHRjkSlTzFchQZcNGsRMnixgqz1qAPvNNdkeE7ACgR9afZmir6gBClxBhhoAQ4EY8T3
         t2/ju6U1z0T2zJH7J03m4QmfJ0HcrsKb7DQlDMnRvZbcqknSNkXoBWK600lZ5m7nspmY
         WW1oU7vo6HgeFcRaPqYkxwF3swDpAF4qvfka5GsSkT6zQTcEO90uWBsNHACYmgq1rXAq
         k12n2aHhwBClNmA2zGTrivRZvq4jHesnrv/Obz7NICFhxDqcrhTpeAik/xjs1bM6e+8z
         X2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734042364; x=1734647164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkdI0v71YIIMW/h2nJtvCUZS2CV2DbhWrwQdxX337ug=;
        b=wujHEgidb9EYwMUTo1TW4VyJj0iL6kf2bHQtR7ykdsTQYRC9OsyjJW8qf2RmGQAcgT
         1Eps9BIVVZTU4L5UXfUVxMq1c4QM+a0J3HWE53YzRUXwcQmK187s4MB3Y3Y7O6B8DF5z
         MItfbDUzOEhUeamf+q9z8WDvQQSkwDAOvw3+EH7U+PF99iF/+qY1Xdoj4wWa5nuShp/J
         6veBghwcXtNkWY5iul+IuHYOOO4h+ei/Ltm4z7/SbkCuLpszs+0VL7KnCoeEh3O2rxmu
         6TWHvun6NOJ3LwbS7wXT/dwCh1VQXWvu/IoNi8leiSkyTK5C5UMM1pORVA+AHow0nTu8
         P04Q==
X-Gm-Message-State: AOJu0Yy5ez1CEZByyGMC0L5PPMcQ+w8XVwXhK1wPN/E8PDdX0w4aHsR8
	iqreIfGtkZRotdIOjXuGuYPn8+y0h+usWqhxLdxOGhfB9DCSlEq16pmE3GouVAlDTzBtpAPl7Kw
	c
X-Gm-Gg: ASbGncvMFzyiivahA9DJgYQfvK8+dVxzelne68lDPzg3LDYnJPEwtCbT7D2E+wfnylj
	DbOSSe/d5zTxZs5GUbjXFt1paD7jxDf+/y4iUb3WHxg2OGatpRJpfYCkaY6DKh9NSpk9ecYdBfb
	Q0psNvfni3BezpPfxwIFruDfK1xw5RLZ8zyhtbRwH7ZVLHvr5REY0mU6o+WrzX/+XtxYSPmWdzK
	3cSc/LhJb6RtDvok/y1VorJrgqAmmeZ1aHmKqwNgOGHBre/J0lVVJA4WCYe+c2Ikac1ETjBYv5V
	nchYJMC4/S1rpWE0mIg2tIkzxvZw7iWjMA==
X-Google-Smtp-Source: AGHT+IEF3cK9/mIS3qglYbNQSOh3TM7BWal9zt9c9o68Dmlh/D2NlA7ggmvmIwkqbcNKtI0SOFHeAw==
X-Received: by 2002:a17:90b:4a0a:b0:2ee:bc1d:f98b with SMTP id 98e67ed59e1d1-2f2901b7dbfmr528459a91.31.1734042364017;
        Thu, 12 Dec 2024 14:26:04 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142daeb5asm1830071a91.12.2024.12.12.14.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 14:26:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 6/6] uapi: remove no longer used linux/limits.h
Date: Thu, 12 Dec 2024 14:24:31 -0800
Message-ID: <20241212222549.43749-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212222549.43749-1-stephen@networkplumber.org>
References: <20241212222549.43749-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Code is now using limits.h instead.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 include/uapi/linux/limits.h | 21 ---------------------
 1 file changed, 21 deletions(-)
 delete mode 100644 include/uapi/linux/limits.h

diff --git a/include/uapi/linux/limits.h b/include/uapi/linux/limits.h
deleted file mode 100644
index c3547f07..00000000
--- a/include/uapi/linux/limits.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _LINUX_LIMITS_H
-#define _LINUX_LIMITS_H
-
-#define NR_OPEN	        1024
-
-#define NGROUPS_MAX    65536	/* supplemental group IDs are available */
-#define ARG_MAX       131072	/* # bytes of args + environ for exec() */
-#define LINK_MAX         127	/* # links a file may have */
-#define MAX_CANON        255	/* size of the canonical input queue */
-#define MAX_INPUT        255	/* size of the type-ahead buffer */
-#define NAME_MAX         255	/* # chars in a file name */
-#define PATH_MAX        4096	/* # chars in a path name including nul */
-#define PIPE_BUF        4096	/* # bytes in atomic write to a pipe */
-#define XATTR_NAME_MAX   255	/* # chars in an extended attribute name */
-#define XATTR_SIZE_MAX 65536	/* size of an extended attribute value (64k) */
-#define XATTR_LIST_MAX 65536	/* size of extended attribute namelist (64k) */
-
-#define RTSIG_MAX	  32
-
-#endif
-- 
2.45.2


