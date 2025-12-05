Return-Path: <netdev+bounces-243854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6040CA892B
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 18:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E99183212277
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 17:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA47C34A77E;
	Fri,  5 Dec 2025 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP3cAG4e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A1534574D
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954758; cv=none; b=JYZLZnLnl7S37Q3kfPH5QBeOK8b9QBnIln0DuQtPCGXrRcTtwFrnTVm/RQF+LqFnEC/13MOoyaO61oZYplLB7qRR0ADxQI3oj2YnoAUOZTVY2gWG98EOjZQv8HNnd+CvzUF4aP9cDzl/y8+ClCAMnpXHx1dVn4UJ7a5Q9F28Bs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954758; c=relaxed/simple;
	bh=ThCJjVG5RVMfr+zdrGxXazrxZX2CekhpjLmMxCxTOIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YaquuXD3cCd9exn/8pVsIb656kwqikI6wgyIWUoSzgNnGYFkKeRA0WyAqhAysLYC2dI8rRjBGDVgHMx5EEsPWZuYhR7nelhNGQVE+yk5cIpILCQaHUulk+lrA03r7huBqyXf64jydj7eEV624zB00OPOVZQwEM09C89+vYPPdTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eP3cAG4e; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29853ec5b8cso30254295ad.3
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 09:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954746; x=1765559546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KthOHDXIygNvoKbYqyGnez1cqEGX3CMF/hwkpTkQzU=;
        b=eP3cAG4ezK1TsESvpI45ZoOcnw7xSCR3V/ZH08uto4kj8uVfS6myIq6k4a+yWYITwV
         MpKBhj2XDnKKPUUo0397EHk2lN/jaKzwXyo5QNb3A25HSpyS2vbHSA0Y7aJfDq0AEsEX
         YkRGBmih/vz/fghrwW+OJ3JFRCyv8A7WKlArZg3G9hSxMeQaZwzXxssG0b5xf3swXBKg
         wSpJ8m6KDusuVt3CN2T5MWwm8BJt95BPq1ra25XqrTHm7/2WfEubQaIBsz5V7hnKpOEz
         b9vsgmI7uBjDM6e84Bd7JgZHixFTHceBd3F9sI+c4zq9yZnQxNe7pEwL//jt7sPzQIFN
         ttdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954746; x=1765559546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8KthOHDXIygNvoKbYqyGnez1cqEGX3CMF/hwkpTkQzU=;
        b=LbZ1YMLo3EM316T7EP+Kfa7B2K1wDeXmybqJlqjh9dGlc1+DGPCnQt1idcLiXl2I6J
         a+EyZSC3q8dmvhad+H61edbgcYWM9qTvZiATtrqAy1K3u/GMwpWH1wEYU6dPRVDBUdJG
         8uoFwX9ndqHpF7to/YYucP9hjwFAucn7PUkksBdseThyhS/AlNw7aosyb0zOzXFXTfcA
         wYDWsf3GRxdBkpW694u6o9ItQTRFvzQ2vx9qR+dRTkRpd7UhMOSgp6jwn7DnvdTbKnLR
         3mydUU9JXwUHlKgC0J0+EJidfVprK+MxgiSd3hAX6/2TqJxGw5arxT7PEaXDrwRJMVas
         8tqg==
X-Forwarded-Encrypted: i=1; AJvYcCU3dcA7NpPf2KY1M+nZhnyK9/WPgTjvJngL4tWglwafDXwmft8V8SwkuT+kK4S3WZg+sAcusGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMV9o0GmujHzGq0TqE1hMtM9HKHTHzMCOAGw6BxDJtes69Pc7n
	WGDW173iIL9QV0vmzhy3OLEOF5tRM1W3/UKE+2w3xm5b1Vq7rJisIjlr
X-Gm-Gg: ASbGncsdCV3ppl3LT17Gc6HPR0IH10xHT9J5FgzGQF5ehhYMbZ3wuPtmmrqnV+l8hom
	31u1cJfcSXgn55JGyrtQyU4jcuRWzpu+E7HkEJcFQZ9hNhngz1aUEXTBX4bLKQBFL35zPp6J02z
	u8ZgkhOuwZ1wgXj1gDWWqTTte/hjg7B0Tz0YXzCcayuZt7dX1BbJQur0RqziQ109KqqeMgRAvb8
	Iyj8ej8f8X2KQWSuKDXpujdLMav/eWgsVlc4/yfbhOGUmwKF8hIkcsCH/RCXPkYdi4qXV+7DOgZ
	l7ft2Dqm+SHJoLhk7EOe9czrKdCGhWf/0omqItOhMB+vKygf1zXpJJR7+HDIJtqQJf/o/n16jAS
	XqNz2Q2q43TomVaCJHMSHj0yf8nREP0NMta7UH6Ps0v8XL+jIs3LkGG7OdGQhDb0gWlNMxfzmwm
	l/MXsX46NuJvm1HAgCIFovDrk=
X-Google-Smtp-Source: AGHT+IFGP5H8TS9l/ZWNTkIDFkoqd//BYSN576PH3VvQ3NUTIBZhXN9o4FjDBwMKRZAasheLBNdWLg==
X-Received: by 2002:a05:7022:ebc9:b0:11a:2f10:fa46 with SMTP id a92af1059eb24-11df0b44724mr9060052c88.0.1764954746240;
        Fri, 05 Dec 2025 09:12:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7552defsm20339483c88.2.2025.12.05.09.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:25 -0800 (PST)
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
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 12/13] selftests/fs/mount-notify-ns: Fix build warning
Date: Fri,  5 Dec 2025 09:10:06 -0800
Message-ID: <20251205171010.515236-13-linux@roeck-us.net>
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

Fix

mount-notify_test_ns.c: In function ‘fanotify_rmdir’:
mount-notify_test_ns.c:494:17: warning:
	ignoring return value of ‘chdir’ declared with attribute ‘warn_unused_result’

by checking the return value of chdir() and displaying an error message
if it returns an error.

Fixes: 781091f3f5945 ("selftests/fs/mount-notify: add a test variant running inside userns")
Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes a build
    warning.
    Use perror() to display an error message if chdir() returns an error.

 .../selftests/filesystems/mount-notify/mount-notify_test_ns.c  | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
index 9f57ca46e3af..90bec6faf64e 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
@@ -491,7 +491,8 @@ TEST_F(fanotify, rmdir)
 	ASSERT_GE(ret, 0);
 
 	if (ret == 0) {
-		chdir("/");
+		if (chdir("/"))
+			perror("chdir()");
 		unshare(CLONE_NEWNS);
 		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
 		umount2("/a", MNT_DETACH);
-- 
2.45.2


