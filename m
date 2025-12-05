Return-Path: <netdev+bounces-243851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4165ECA8925
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 18:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8928231E661D
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 17:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3C734B1B8;
	Fri,  5 Dec 2025 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuK7fuQN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A615932E738
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954753; cv=none; b=cT92ybQ3RVG1sn/7r3zg7yZzzrUi1vqC3LdKULrxnNb1aXuMOgEH9DlfYdV2YHF+33j+YF5cGUWxRISeTunJt2P74wZO2NtCLro0bcMqEu9vhlQ66XUI2C2YaHvAGhenTQJrpN/8d3jjNYIF7FlO7QSVyO0FgRrCMjcwaQ5QnYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954753; c=relaxed/simple;
	bh=TVRX6OVXaN6/F8l3SopsYHbh+ST+dk2HGsZrDg1QD84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bi1rG2+n5CD3wElQivICcMRxkaeue8DD6GCOqHMWrRVoRqP4bAoM3PWupNxVK15AAZn/YYWnvtHHMQRrzlLnBF0eTqtMb6sAADDl6KZIsvzFODNTT5iPdXTcctnBFlp05fbkw2EST9nZgtHllaLuHkMELB0mG+l+cvoBZDOZZaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuK7fuQN; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bd1ce1b35e7so1611259a12.0
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 09:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954740; x=1765559540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIl/aawA4xeGwYCaPG7Uh3j0tRW+jDxmmUaf9p3hcUE=;
        b=UuK7fuQNuI0rtnsf7Nc33GBdx6dzAfSUeKBvuz7tojI5LL5uZh4PrtvpuiYSBRBeSM
         ALQc4EF1zFTgEOJdSA9/Azvs02cgC57UADu8nM8X/hUYv8e5LBzzofRDfuScv1lfbmqU
         ZZaUKJQBjM5BcLmAbfVdaofY6/tVaNo3OhT+Qk2VokG9/i0l/pBjCPFxlX+yz5lJxMvu
         uGlJDWWBFhfLoUj5DLdlaMMwW48YvUmSAgySVa3+mFNnnWqQl0cpQgFRxLN3aVeJPF7a
         wHwwCt/+MFb8XFzLUn73PPQHYSIPOSIQna7daHzGmE4udWc9O8LjdtN9ZcKkXEEtEg8U
         u7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954740; x=1765559540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BIl/aawA4xeGwYCaPG7Uh3j0tRW+jDxmmUaf9p3hcUE=;
        b=fhyuqmYvAKI3FGbtzuKg3XSgrjTmp3IaZt+xXHwcLBMkNrbkYVXo164CGjy9rDFaQd
         oTYz2qEsmJINLcHflHmC75hUXZG60gdljO4xzVCOXNvIgOKOcdKjdSsQOXV8ZeXSiozK
         hupTBHEOr3ulazI23eUmuBnhzCSqc7Sd0SRc7iIPWidSypA88W5TDc/V5X11P1Nn7JTY
         cjU2WoC9fppUx0DWUKh4v4DEvTtRue+RzNRCLyoSXlVUXRAPWHxyP/Z5ZnFalxjLvUvW
         /jF1DjLtDVbRwG/UtFuRSVMHJXbfpL2aDo5t0sDRudQNZ+Dyue+cq4Ib3usXDGjg9sVU
         Loug==
X-Forwarded-Encrypted: i=1; AJvYcCWYH8ttY0H3PNPL2uksos0WKtGlfUge9lUlaPxtarb5VlQdqV3ug2y6CFAP6Fp+g5mF5CUFKNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2GvJVpAzInT/SLfqFOzUHLR3lRCTyOaaWzV4MleM6dCseX5+d
	DoN4n84gm885/fR0Ne68/DZnJQ5VavsLTZW4RanFYwq4PIXr/J/Sm7qD
X-Gm-Gg: ASbGncvljTLjVWSKgzaBb79GWcZEqyqtGxA6EJFgVlrjen9K1JLMC3DJCR6Ap/RRWNd
	jJh+f9BmOGCPoaJW7v0xPbpFK7bU4OVg0FyF4xcVVWewMMGg/sIuljWyqE6LPsNHqV7WnV0M3x4
	VKgxgamnHmKZE9W19X6xPXBgfqBYX3rk6qxcPAMLJNqDlyuc7qTvKY9dh164ageRdPHdg6G5hNq
	PAbtlsaiCFa0MnAnigW2aruR8rOo0054orJV53vt1GKDEABX7Sb7lzR9uqP/iM6yOayjFGOKp9H
	8xNHbYhM99bvIeRUTZQmUeXll2m8kZ1Tfnrp13oiRufVDvjeffIe3QUJhWiUJq+JqC/sHq7zOF8
	FngSy2wCkuOz0Vkqz7W/qfcSR60pfFnBCnbORZrQv4VnkGNYxIK1fjoPvemjJMxadXGI1e9Ahvp
	wgKxQ/X6SFv8UaAiUmX8kjvjc=
X-Google-Smtp-Source: AGHT+IGLmu//P31DCy/RNC7sTNOq4cvelmghY7u/vM6nTRJiFEDfwjbdinP/0y5Z7o1g/QEtoGFjOg==
X-Received: by 2002:a05:7301:4616:b0:2a4:3594:72e7 with SMTP id 5a478bee46e88-2ab92e2da45mr5744996eec.22.1764954739092;
        Fri, 05 Dec 2025 09:12:19 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba87d7b9dsm20594306eec.4.2025.12.05.09.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 07/13] selftest/futex: Comment out test_futex_mpol
Date: Fri,  5 Dec 2025 09:10:01 -0800
Message-ID: <20251205171010.515236-8-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251205171010.515236-1-linux@roeck-us.net>
References: <20251205171010.515236-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

test_futex_mpol() is not called, resulting in the following build warning.

futex_numa_mpol.c:134:13: warning: ‘test_futex_mpol’ defined but not used

Disable the function but keep it in case it was supposed to be used.

Fixes: d35ca2f64272 ("selftests/futex: Refactor futex_numa_mpol with kselftest_harness.h")
Cc: André Almeida <andrealmeid@igalia.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes a build
    warning. 

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
2.45.2


