Return-Path: <netdev+bounces-243612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B38CA47B9
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 17:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94540302F6AE
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 16:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC8733C18F;
	Thu,  4 Dec 2025 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNR+XevY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D94F32A3E1
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865063; cv=none; b=YCBsASFKZ66uuO00crYPiHs8+CTwBm/Z22//3QUc3/q9aTXqtbkmk6msogVmkJ2L/qojQ5kjfzNRHVCm37J3iW4RUuQZwgxrCCiI1v45m8yAz2JqIlh4JCx7RdOk/de7aqLMrrv6Rxl0n1oa4hfxOMy443rKt27q7UmZTs5X31U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865063; c=relaxed/simple;
	bh=B6G0T8NkYhcNuCD7QyN8/7gTOKXjs8C98fVo3MBQSMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKOBtJAxFoQGo4QXfD1dwTf03FezmuATJ0Ik9bIqva46mbcQzABYsjLApQLe3JlzLl9oq2tbhMQYDa2fiCS6QGJIqjiqOLu2Jd0NKO15vkQnoNTiBbHh9JWgDO3L7acftcAgUilOBqP122BWh4GC9ILjz4jjkt7G5DsyGKkLRCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNR+XevY; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso902706b3a.2
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 08:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865061; x=1765469861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRkSyL5drvX0oO3m3t25GTllj+dW5z9HXAo2tXvN6FU=;
        b=PNR+XevYIOjkpozR06nB6Au2pT/VG8FvCBkQfpreOrmDVleWwb+VOlCDcdMHvxepBt
         l+s2jt6eOJNDIVPv9Qbi04by3VaPKgWvtDUYgzBbs1UUff7w1tSxGC0ZJkeJdD3/CLRd
         B/tAGTIrjaHGQ2dI5utAtuqDPgkRiWXjoje84fvQ4W8f1/Jz+/mPiuCAlJAPfR1X0ntU
         N4PDDvtm7yVgEkrrwvGwnRah0liNOjtbeZNGQQ634oTNnF5SIh/mfz6KM+4Dgq5BDamW
         dL6TM0LOqmg7WInWnhyvysc2taAu6gfyMpXJq+K6ZWJyStQMzYyjO+A3IhTEVIdYhWIP
         7LkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865061; x=1765469861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bRkSyL5drvX0oO3m3t25GTllj+dW5z9HXAo2tXvN6FU=;
        b=ZKhUpmj0J2n/+ylpGDrw5xJw8kgzZV7L0NCvKU3UE8DwyVJdjOoFtoFH8hD3A67HRR
         4Av2HSMrsOJd+3iJAy5hqKqFD/gk70CVK+DCuhqoz3xMNh+ZiOF+UrFD75w9OBTnsBuR
         YUWoy4ApPSadrqFMlesi3crVZjF4hP/Vd+efQzYyTFnsxwmTae401xqTIo4pyLDNsElm
         pFbM/bKoTQpx6BG2r45688IHFUGVfj2aae1b8o7LAJdTb1LNFFIQRxFoOn9VSIAWoT/q
         1vbSowfBzAnm7Dsi+wbnSlvnJXgoa4TMivWSoK+LzAB+NWU3sXfmRB8uKn2nXhChwodw
         zQww==
X-Forwarded-Encrypted: i=1; AJvYcCWcDW+Qr95gMqv411LTYMJI2YFRHwWSYVcLnaLm+0Y+qbnJqmf2ZHRZDj1RuoWrMGhlDWChn8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM2oeYvGC86ZtGMqEJhhLgdtyJ4EfeEncPJO4Lt1SMVM23s7Sn
	SQWZZiN/nSu3d6y9BuiOlOYbfJB/OJ2EhApaHi3lcY92sRp04zlDONUH
X-Gm-Gg: ASbGnctDUYXRlJtRqMnfL1tSDHmN0XUxkI/biKZhz8T1/S/bMDQNqzpPHg++AWc/L2z
	lySJ5x0USaqQaCUXQLjDfUL+BGqFBD1qPK+F/G6am52IYByUJAlAfm1hJ6vrU0MpV+pa1Jg0hWd
	nFKrLD0wFz1dJfoENLqiF5wNXAxHkT319GeS255Q8LUewFtTNg6XJaWcfZWthGhqO2kIdLseAqS
	Cb3Z+rtGQuwbVo/J1Az1cezeMKQ4NqWhnYgbAbDG2SbhJOBzioXpSV4rbXtRPt6aYSmNurmw7BC
	gk3jnv8KbRWsS9Dffto0nqGcbEIQIn0iP4VKOsoHzY7PkMXP3W0vsSH10rmIR9U5W0EcUI6edkP
	zw47Am0eLvc9aSJWrN8CCDtHAofkPu2ahgVyjjxuEWbvE3GYsOYj+9Lah4DBx5WsGWkYGuxq1Q5
	CrAd5028ywXzhoIREu7/3nOMuYhU226hoc9w==
X-Google-Smtp-Source: AGHT+IHDLLCXyd3NnPostz8f7KrgwicqmyuURH58glMvTXVVktyKcW82yJTvvOqpWuC/DUzj2fEA4A==
X-Received: by 2002:a05:6a21:33a0:b0:342:9cb7:64a3 with SMTP id adf61e73a8af0-363f5e27630mr8448573637.34.1764865061486;
        Thu, 04 Dec 2025 08:17:41 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e4ec3c32cbsm1541785b3a.46.2025.12.04.08.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:41 -0800 (PST)
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
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH 06/13] selftest: af_unix: Support compilers without flex-array-member-not-at-end support
Date: Thu,  4 Dec 2025 08:17:20 -0800
Message-ID: <20251204161729.2448052-7-linux@roeck-us.net>
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

gcc: error: unrecognized command-line option ‘-Wflex-array-member-not-at-end’

by making the compiler option dependent on its support.

Fixes: 1838731f1072c ("selftest: af_unix: Add -Wall and -Wflex-array-member-not-at-end to CFLAGS.")
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 tools/testing/selftests/net/af_unix/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
index 528d14c598bb..04e82a8d21db 100644
--- a/tools/testing/selftests/net/af_unix/Makefile
+++ b/tools/testing/selftests/net/af_unix/Makefile
@@ -1,4 +1,4 @@
-CFLAGS += $(KHDR_INCLUDES) -Wall -Wflex-array-member-not-at-end
+CFLAGS += $(KHDR_INCLUDES) -Wall $(call cc-option,-Wflex-array-member-not-at-end)
 
 TEST_GEN_PROGS := \
 	diag_uid \
-- 
2.43.0


