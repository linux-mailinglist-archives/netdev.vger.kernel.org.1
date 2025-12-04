Return-Path: <netdev+bounces-243613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 016F2CA488B
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 17:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9CB33082785
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 16:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F5234106E;
	Thu,  4 Dec 2025 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7XFvaj9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF9233B6F7
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865065; cv=none; b=BC9YEhmvER2mNPbewenzPOvNqT2K+rQrMTWZDsiEAly0QRdNbbvkxoti28irBF9mmyFrKLukm0MnHkp24CSZzTyg53E4ACSy4MKYeoy1Y1QG0IbCWBEVhtbKXXR3HXt0g69AJFfAkS2lRtMzS97Gvpi1goKzsAIhKYvJMJHaOfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865065; c=relaxed/simple;
	bh=5B0PgOWPShXER40nv9onVYknLk01f2ENlcdo44PN6+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmGZA1GMFQpoAO/Ymu1UFGyd/cvfQTSGokCC1WkMLswZsZK88Dv9ZqYYv7iVNoSHMQ9A0XSdQy83lQkSoz3D7EHdCjMee2AmFAWymfBvO2RU8MeWdVGEnGayQBnXOkT8rWhvbve8NVDPD267uKVORzkBA3BL3rFEmbSO0U8WjlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7XFvaj9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-298287a26c3so14395915ad.0
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 08:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865063; x=1765469863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJUImmdQDjeHGtaLXSfCuWLTyPTXVTEGrMh8pUqqH00=;
        b=C7XFvaj9zQybUoQIo86zSH5P3sN8Cs5+ebYnZ25odOOe4mfe2vAGU/16+r+vPtpLUw
         wCGGRbkdghTn2eFat7lCQXxWXkg3FYn+Dlkn+rzrWpDV3gPkAAZTJDlIbCqYNyas1say
         OXAof19DqGtf+qtjWbjmhmlU65I1Oa6wASqXq7huWjMm4pt0JbCLTNCsiUZwRHzvj3v1
         NrwaHb6Wuy8CNo7fQ2l1HxK50F1BktRNB49WEJAa+j1j6RmOFUwFfyW2HCYZS2kkcP49
         Udi+MhOmQpglctWszcLZrrM364rCwji1GRrhYezxDIFJPlb+C+TgxdVbF5plpRDx1yL3
         Toeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865063; x=1765469863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJUImmdQDjeHGtaLXSfCuWLTyPTXVTEGrMh8pUqqH00=;
        b=MFofxY6640+quhzYrWywIJtWxphyFurGlfI9V4L836ZdSKGnYGCrCcfm47NB9/i2Yr
         OWESKFi8LcR30poEc6Bxp+jx3Po0/7IH76R1yE/ycd25oUIIckKu02myiLn/wBUhq3tm
         jRw50M8g5gJy3dkJJHKQbEjANWoaAFIB/5Ntfjqty2uMFU+nxffGaZNPDal++yTiRQyJ
         ZvNqYGEKSP8lV5URKmM4Aqfjms6W6+i2Fh4P/O/YrqZxc18Iekub2tAo3qFHfE28Z+KH
         xIkQaWAgxYaylknXCoj3/cmvlBgG+1MiX0y4W7+VTNlSd7x+0Zih1hV3/kARL9Sckq7g
         4fTg==
X-Forwarded-Encrypted: i=1; AJvYcCX4KDhyPLBGBldbDVDhbaD/CIEzpXkrZr91W8JKI9p7ncrMzmfLCQprxsMhxNdupbe6v2YUPs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0gJu942q+2EIYoiV5YRkSR7cCgl4/yMmKQr4Ol9UngxAxSNCh
	+iYfUH1qgumFuE7ymGLz0G76iR6KHTnnWL1xwcaaESmnKOccDYV2ha9a
X-Gm-Gg: ASbGncv4YDEtX29jQG13GxOS0W98GaGEiZESJc9CYAt56eTBdxysoXfnNVjEE7cP12e
	s90e+GYw4ajewaifRE8LCfdK9uN+6Yn0LQx2mxyS2wysYdcC2zt7p4V+BP8FPIqJ/9TnKjhwreX
	CMaHaP0NtWvifR1MDZrighlfWtYZXOaHgMMJvnY+t0dmgre1BJFfnipBcKBsEDv/ekcd1/VFaHE
	llK8U1Ck50+t45gjKuYNmXSsrL5pWP5ghs5HXmyAgPtCc9yd25ZyHQUzvFhz9uReK1lcOICoSK8
	ZbUUKEGAQJNvHy67DgEBh4qV24qONZ6TAu831DA1wakKSgthPcHXKWXq0/3fqyGmWXetFw0fUjk
	13AMWOJEFsdNta9PwkYhk0DAmIfGSEMhFd/6B+UEhPrPVbJG1M9voMoigIR/Nmss7gWL5NYWiab
	lHCih/TFAReMT/eU67G0a4Fo8=
X-Google-Smtp-Source: AGHT+IEp65adRZJkHxaNOxWvtN+myggtoxv0yjR0IEwKZeW5OawGZmYTcub9/vSJLWwxb9bL+b8PmQ==
X-Received: by 2002:a17:902:ccce:b0:29d:9b3c:4fc8 with SMTP id d9443c01a7336-29d9b3c5ac9mr52907945ad.61.1764865062930;
        Thu, 04 Dec 2025 08:17:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4cf9c3sm23939485ad.26.2025.12.04.08.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 07/13] selftest/futex: Comment out test_futex_mpol
Date: Thu,  4 Dec 2025 08:17:21 -0800
Message-ID: <20251204161729.2448052-8-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251204161729.2448052-1-linux@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

test_futex_mpol() is not called, resulting in

futex_numa_mpol.c:134:13: error: ‘test_futex_mpol’ defined but not used

if built with -Werror. Disable the function but keep it in case it was
supposed to be used.

Fixes: d35ca2f64272 ("selftests/futex: Refactor futex_numa_mpol with kselftest_harness.h")
Cc: André Almeida <andrealmeid@igalia.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 tools/testing/selftests/futex/functional/futex_numa_mpol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
index d037a3f10ee8..8e3d17d66684 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -131,10 +131,12 @@ static void test_futex(void *futex_ptr, int err_value)
 	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA);
 }
 
+#ifdef NOTUSED
 static void test_futex_mpol(void *futex_ptr, int err_value)
 {
 	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA | FUTEX2_MPOL);
 }
+#endif
 
 TEST(futex_numa_mpol)
 {
-- 
2.43.0


