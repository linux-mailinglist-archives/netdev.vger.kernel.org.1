Return-Path: <netdev+bounces-243853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9092ACA884C
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 18:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A93403025601
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 17:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB05A34C80C;
	Fri,  5 Dec 2025 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltgsSjVp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C026D3469E7
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954756; cv=none; b=tXZvvGP7AEjVfC5Gp27VxqvZLZz+rKgQdwM2bVJLzEjhQHIoMZiwDos2LQz6iLQ6IO2j/Qg1OjUG5QXZygP4ys3+SNO6Xwachyq/44YgZBItHypA/koEknxB3F1LHql0ysw984bijeW8ATTbZ6EknUQvAl0+Vf6dFx3rLp8x70w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954756; c=relaxed/simple;
	bh=YtYoTmiGxnOh5dtDECL3sKhDmcIdC9O9DzDnMbMxrZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BhV1RvLpl2p9Uvbtqx+gW0MthgNWm9v1Nr2ALwkWUGex6SlnknXfQOv7WIbDSoBoCr7aIvzksHjc8lOlD/WhDAHXsyf/ETA1Tlx8QU3oEPSoImpJ//e6v8UEmNBXLKiRLptGSWT8WL/l7MwSKekcFSJwlYu+cZQAwm5P1xjMJqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltgsSjVp; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b98983bae80so2178396a12.0
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 09:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954742; x=1765559542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47vuMKXmBnhdjf53+B1B8/LaD2EktMN0NOXdUnTfNOk=;
        b=ltgsSjVp9ysDRlyKerXQDlumgJHsv8QOUwqmqbFHUJlFY9PFQQl4RxJVkc7D4TdXrP
         NgNT3zJVmv+y//SUoCdaVemBWaTX0RZnfb2NlMh9fmRr6NVT0D7zQU20jncF+jGv8ir2
         5yoM5I0A70Zcp1B7XkjOHGbfFDyvULGsFBzM8vwk07XRU+vZutb2XyQO5eFNqywQ0NlG
         MJGuhjDbjzoRbROY7l0sCYU2CAS+62wIuDKT0UHR03Dc5Lbx+jRUSiPGpSI61swp5ole
         lW7jDxxotS2fO6dj761HvoifHLNZdeWS7OwEBO7FDMMuKquEqtvCRkmOry8LQ8i3WYGc
         Hw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954742; x=1765559542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47vuMKXmBnhdjf53+B1B8/LaD2EktMN0NOXdUnTfNOk=;
        b=E2P4jp5vK/Q1ttx/u9yuTwoN69CbKeIu/VrfqnecCwbGiZR4O1hrXYEMy8DxR/wVcY
         x7X5ax1i36hSVdZ+uYlnukNmqR/N/hIl7nBFPLXhR6azxVQwwcftI3WNzndacguKEiSl
         o5Rbfk2XeLvN+0bEIQM0To0ny2NqFNXL41S+0FcgcZUVGtWf4VF0tillMIweIKMq1mA1
         MsF5bvU9T/PlL1we1EvJXsTTU7D3Fhu3bmuc9WQbd4Ny50BsbrDRE9xM7oinMNSfKCjk
         Lauls4ggvVJE4vgfBfLdccUAf44WSpbhWqokE2xc+CHTbtqjAgBCgrhiOErgxebMSohW
         78pg==
X-Forwarded-Encrypted: i=1; AJvYcCVhgzVc0Agg9knRQev3224Mpb9OQIBS91lMioKrTfOMjqocX4SoJwXphAQgZ15y2u1xilGpgp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztJSgIXLVsxeAfsnOMG6fdrxLpVxdFRaBrPLt1NQUS+gPgMPeC
	9sangOF+3mxyTVl9wDv+Mu2xiEaJRSCOixPR7A84w0rrW8lzucMKieZq
X-Gm-Gg: ASbGncttK4XEYn3vl4j3U0Bcsgz4sfP/6D3OmMQlDnyfzdVDmNTNEqWldpVJLTtI4xN
	NNB7HftefH/61o5HnEpzmSk2e8DdxhnaGikTN+6KJKyOshaCxbqgYL0R3DcLsR1w/eFUyKe1osq
	bWehoVA27flcWTyTygN5oMmYXask/Dmx0vkwJ3knBbnQAj0ZASCvjCwY60XpiAeXGTiUTrRq5u4
	hKXUdOauB4V4R8ykzDQo7J0VtNW2UHKpTxWA78i8KlirXNSzb0THpZAcujfwgC/M49WGGpjy0G6
	FdLIItN+/5Z4vVGfRmKtNo0VBlqND17TBMYrXVm2NRlGsXSRERas9jVvFut+hX0zatffvJaNoV2
	FjbUQaz193p6rWpEom87K/wT+zCmjiF6NhkVaougC1MdI2JZDKC6lLcW0KP95Ord6wxLN53zeMU
	u8NrbCiC7+qbvQawOHfpAcg5A=
X-Google-Smtp-Source: AGHT+IEk22OUEE7gdeZwhTjpvbdAQz+kolwi6WKygGxoM1AqKfc3siF5IPSsP8KEFJASWzEJYAwOyg==
X-Received: by 2002:a05:693c:2d86:b0:2a4:664e:a5af with SMTP id 5a478bee46e88-2ab92e88ab7mr9468546eec.28.1764954742216;
        Fri, 05 Dec 2025 09:12:22 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba8816ae9sm15102636eec.5.2025.12.05.09.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:21 -0800 (PST)
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
	Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 09/13] selftests/seccomp: Fix build warning
Date: Fri,  5 Dec 2025 09:10:03 -0800
Message-ID: <20251205171010.515236-10-linux@roeck-us.net>
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

Fix:

seccomp_bpf.c: In function ‘UPROBE_setup’:
seccomp_bpf.c:5175:74: warning: pointer type mismatch in conditional expression

by type casting the argument to get_uprobe_offset().

Fixes: 9ffc7a635c35a ("selftests/seccomp: validate uprobe syscall passes through seccomp")
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes a build
    warning. 

 tools/testing/selftests/seccomp/seccomp_bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 874f17763536..2584f4f5c062 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -5172,7 +5172,8 @@ FIXTURE_SETUP(UPROBE)
 		ASSERT_GE(bit, 0);
 	}
 
-	offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
+	offset = get_uprobe_offset(variant->uretprobe ?
+				   (void *)probed_uretprobe : (void *)probed_uprobe);
 	ASSERT_GE(offset, 0);
 
 	if (variant->uretprobe)
-- 
2.45.2


