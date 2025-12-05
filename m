Return-Path: <netdev+bounces-243846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 468A1CA87FE
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 18:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33B573003FB9
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 17:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F27346E4F;
	Fri,  5 Dec 2025 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShpiucD5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDB7345CC5
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954742; cv=none; b=OT84JXovUfUsHprrsh4SoygF60x2POc8osJAPWliXrliXrpo/dgQTK08z+wnxRXnO1/aTdB8Bst8PUSCXU1bDRlVxFNhW0GAI7zqQEpxvA+7zbg0GMGyQUwOLZui/85D0etxsWt7SapEe5inqFxI6jYxDg4edSOvXOv2Rld2p4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954742; c=relaxed/simple;
	bh=zQXdANrAyobWWcUFn+j7Tv5/akEdbk709MOA4NwiFNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFmmgQOJbOZrg0YP0imUg7JjFk10YPFHKFiropkpWcxWEgG/IfsmH3Mkzm6I0Uv1Crr/a+SMpJ51ELYfbLz3reR1pG72gqbSfShXrnfZFN66FGuiLjzBUS7YryDBLM0hQfpwpPeQkgjlLhXa/hEUkllN6kl3Pm89x24tebFixNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShpiucD5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7aab7623f42so2792629b3a.2
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 09:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954732; x=1765559532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGP855q8P483/tvMYnKD3q8c0QVPBAHakO/1UvcTEb8=;
        b=ShpiucD5CfH6RxTe1uOiHmjhJxOqvhW2w1po4HFvFUfjGI/pAp6RVV3JA5fOIig3C+
         agqJZ4DMGXun3iJpTMtrmfX9w5ohDBDvrOuThC4NKa/E5OlbkEI8tu+6Gnl5byhCNLHP
         bWD4KFNvutkrwaaXaCkSGxgH6uLWtiKOvj/3Qp3IGL/jk6+LFJDDKJFm9oaClJe0YgjB
         UGVj3I/kkh8krwY/v9yTYcZNOzWQdFXJyTOUvoOGjQYhvDawnVO+/J+qORctn7HWXxrP
         RANvACI+0+CUGHodyK3CWSL2/CvDWnRoL0oq7sdvW6zwOmilrpXdf7IMMQUdDCVsUMJ7
         qlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954732; x=1765559532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pGP855q8P483/tvMYnKD3q8c0QVPBAHakO/1UvcTEb8=;
        b=hmKSMSCxBbGgJnu9EH9dskEeARjXDBdpgyQYGP+2AZXmKd+J0XCRr2m/TlKfjLC56x
         OH2/7DBemxKP1iGHO7ThErwcBOkO1H7+PtMze9mP7mbpsxFE1nCmHEaIMpnip5vahTjY
         pIrfBblO2VZwbTUKzswfOe25OWp69dDNHDAJc6aLF/mOZqA5H9HTdu7QlSsx6PoEw2wu
         gnM9D9XHPPmFnKzr7m0VoRW/4ZAK26XO1Lmc4RwxBoXJ6KbEapm3iUJ/NztWVJ+BP8nV
         Be1OZz8hQUuuoNddBPzEs6pPfrBHiscCM5pWsVAFfutUSsgsR0W1C4lRJNxZxdfBqpDp
         vBTA==
X-Forwarded-Encrypted: i=1; AJvYcCWX7cWRUjBjUjXfQ9E6dK8lcan5MUXU3oqdg/a8Fb3CNHNrtNbIN/sTc92Au15vSx0BDe3Tb7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWSCs8Kw3ldNi4TE3ZilROFUi9gpvPB1Qr7ap7IB6c9lw0U/lB
	GrVxgIvnc+ZRuzwmWL2wNevfgkGnjr9iyre0Yango2KU3T8K7QlY09La
X-Gm-Gg: ASbGncv4sC4QHF/5+FFE4iQg729LBGzy1aO+u2iQ2mTKnLODim8zILpzV60l0cCjv5g
	CE0+eyj+CbSF4LVK4EQRP8gnFzl8iG3UjKE+m9cQ3S1+JbrdJqb0DqDhCjU/tMO2gPCrjKuSYzF
	piFCZvhd8RauNbXuPNMLgEAxFI38LJ8w8mcMDfZ9Tt4MFHJaa2xB9cg96SryrEC2RFhpJq7gWKX
	t5PTtHR1koLtonl/3E7ytInn/+qEwNDNg8u4paqPoNQnVsubFvPvn1l7dvIz9RFNc583k2ROZej
	ZDwmX6Ec9Vb0Mew+E7SOLEPvrpX9ZDfQZqtoLO9S49K6+rY1SqrDvENo61D9Qmz2t10Cic6huKt
	uqWsZ2P03Fa/QJdtuQYiYqN58YMcqu5p3K8BCWI+/bce0QclGmbk+yWomq2EsrLXk5JRt72KkkO
	6KNE6dgp5fJ/jcoV/J5EmqVD0=
X-Google-Smtp-Source: AGHT+IHdTvay/STs3LNZkpmmMt8IstasmpTYD+N4EpMd1XG2nuq4zcxaDuN9vSlvYoOBreCnQRf4EQ==
X-Received: by 2002:a05:7022:258b:b0:119:e56c:189f with SMTP id a92af1059eb24-11df0c3bbe6mr8274625c88.7.1764954732270;
        Fri, 05 Dec 2025 09:12:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76ff44asm20697582c88.9.2025.12.05.09.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:11 -0800 (PST)
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
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH v2 02/13] selftests: ntsync: Fix build warnings
Date: Fri,  5 Dec 2025 09:09:56 -0800
Message-ID: <20251205171010.515236-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251205171010.515236-1-linux@roeck-us.net>
References: <20251205171010.515236-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix

ntsync.c:1286:20: warning: call to undeclared function 'gettid';
	ISO C99 and later do not support implicit function declarations
 1286 |         wait_args.owner = gettid();
      |                           ^
ntsync.c:1280:8: warning: unused variable 'index'
 1280 |         __u32 index, count, i;
      |               ^~~~~
ntsync.c:1281:6: warning: unused variable 'ret'
 1281 |         int ret;

by adding the missing include file and removing the unused variables.

Fixes: a22860e57b54 ("selftests: ntsync: Add a stress test for contended waits.")
Cc: Elizabeth Figura <zfigura@codeweavers.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes build
    warnings 

 tools/testing/selftests/drivers/ntsync/ntsync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 3aad311574c4..d3df94047e4d 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -11,6 +11,7 @@
 #include <fcntl.h>
 #include <time.h>
 #include <pthread.h>
+#include <unistd.h>
 #include <linux/ntsync.h>
 #include "../../kselftest_harness.h"
 
@@ -1277,8 +1278,7 @@ static int stress_device, stress_start_event, stress_mutex;
 static void *stress_thread(void *arg)
 {
 	struct ntsync_wait_args wait_args = {0};
-	__u32 index, count, i;
-	int ret;
+	__u32 count, i;
 
 	wait_args.timeout = UINT64_MAX;
 	wait_args.count = 1;
-- 
2.45.2


