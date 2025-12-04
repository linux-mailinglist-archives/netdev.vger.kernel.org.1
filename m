Return-Path: <netdev+bounces-243615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E543CA47AA
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 17:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 121B8301E212
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 16:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4943A345731;
	Thu,  4 Dec 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG4jP9V+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6235834252C
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865068; cv=none; b=g9N6oGGd5VPastKWFVJNwZFvfvgtAbTHcjR/kvqvxnz1U4Xb+HUdY2q/8YD8RxmoOHTH2h6E4kVtXvXtmkd4ui5sNYMko4suFBfssOuyyiAwyOxp50f4w8wkDyXt5lyfwZrU52Ydkjz25AU3qr78nPv7xYylJomVgAbsw3lb6Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865068; c=relaxed/simple;
	bh=rC6PkpD7emEtrML1l1CqlyTuhgy05GVPUoqahSfW7eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyW374PeU51aipJQGUvEG/ERDtLfKNEUSVA3TWkLRXCFS+a05Q8opPdlEIn4ZtiBisbl/NWeusvJedFGjYZMEKAYzxtcvgtEoqlrEwsxvC6Eu31Gb+Jo4IIihCQkn3vJ4GkY0eQccT0hbrd9XvvmK8gQeK14uw9crmdCvPtD5lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eG4jP9V+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so1287253b3a.3
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 08:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865066; x=1765469866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkgkxOw4wH/gm8uUTlYYEApf3+4O7rh6ARTRXeD1ZL4=;
        b=eG4jP9V+/8Dl39uuJbvFft2WpoPwRW+aaDCtASqLaZzPQrZTR/IB7I6lvLdqMIHZ6O
         OoPYVLyf+KOJzSARA06C51luvwl0/Uj/t56rfCWXlY8DyKSCLETEY8nwHGGOhsylbbes
         RhbkNczl/H5e/Cu1qyuF0foIY0iFKa8WaqWzAp6eTDlA5FCuOYqiIfnGgSNvzY/2NW/H
         mniMAEwroVoIF/5++AHcVne2iH8uGFLVF4q+ir86PadLxv1IB5gxphfUbnojh1J6bZ5x
         4ylaM5lKF3Eap3E6YnzY4JAqcpWJgY9Frt8BZlAOQUbbJd7iW+W02y1nIzpgyvOGTfqn
         FHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865066; x=1765469866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkgkxOw4wH/gm8uUTlYYEApf3+4O7rh6ARTRXeD1ZL4=;
        b=FwCpnY/jEy1IIN+/xSuSAjh65HqJSSHhb4P8/BnlkUR9l64teShndK4YhxIzuXpQz0
         7dbHUatIJ3p9aoytRLksa8R7TrsLL2VfJJgu4g/nYsRjHP8iMW2ImfPIjO3N/hFbj9Is
         qamFpFnff6OfT0DuThTwMTodMgMmzzTgg2CEokZPjLrMxxGPORYAvpX8cRjNAcoVO4r7
         cqN/Sad43KWUiojiJEFI/6vD7QGpVymN3+8fZIE0xuzw+yiwKBaKaFHeE6n6+Fra2Gtv
         82P+OH7nHBBX95nqz+4bTSPd4xMnUSUkaYOIx0B0m6WEp2IIHK1j+BZxxq7oJ8d8jVvJ
         vvjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKldt8EKwc5ybwgIMgaTAozMq/b7krDSCDesEQIF/80ZEvJKM04wdQtPZtUE8deEXfrCiMiqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSH2jsj50/l2zRTeQoicM71YKDLlFu0/ibv7TyPscgWWC71och
	4BJLcY0chtjTSqv/24dI9qkNIaj/pKd6txbipCwcAq7deiARloHf8J0v
X-Gm-Gg: ASbGncsUSjkF4vXJlpdfmriTfjSoK+xF7s/NiEB/wbMeixuYJ4rUKq6fn78JjrgYb+P
	yNhPAX4BFfHbA9G5srDwg9RkZMVSVfltrMqb03f7ZqX0CFukLcl8BEKd+ZX1WnSbODJbrYnL1Wl
	ijbd0GJ5lIDgRFt+fnFy7HgUexTfwhIuy7MTn5OJKirDZgeqapFxNG9YSKvFOj7WrkdMiqMdDOw
	HXcFtOn3oYaAsuT7b/2VHywkJEx7Wxl7/kY2e+9kyRJyw6MtYdE4woGB4FMvPY+YwNup+TNp+S9
	TNovZhdI15CG8dZ6/nLeUk41QrQV909LWTS2PkL3ZPG+kFZHWL1/YGBj5wzRypG2tscoGBCgOfS
	/FKp6SqUpsMTYuzBNxLPJ3ktO0ifer4IctDopkT1RfP9cr3tTJIJN8UXCk53+MaOrNM1ALJUVQM
	Ko2Rkcdim6lgw8eRuosOktQ2U=
X-Google-Smtp-Source: AGHT+IF/9euea5Rw23ICGAMIBIpDo3F2tehs2oMFO8F/8uA1LeEDf2vswoBxd4onc0Luva/rqs2D6Q==
X-Received: by 2002:a05:6a00:14c2:b0:7b9:9232:2124 with SMTP id d2e1a72fcca58-7e00ad73ca3mr8702158b3a.14.1764865065736;
        Thu, 04 Dec 2025 08:17:45 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2ae6fcc87sm2635111b3a.49.2025.12.04.08.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:45 -0800 (PST)
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
	Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 09/13] selftests/seccomp: Fix build error seen with -Werror
Date: Thu,  4 Dec 2025 08:17:23 -0800
Message-ID: <20251204161729.2448052-10-linux@roeck-us.net>
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

Fix:

seccomp_bpf.c: In function ‘UPROBE_setup’:
seccomp_bpf.c:5175:74: error: pointer type mismatch in conditional expression

by type casting the argument to get_uprobe_offset().

Fixes: 9ffc7a635c35a ("selftests/seccomp: validate uprobe syscall passes through seccomp")
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
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
2.43.0


