Return-Path: <netdev+bounces-243618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DC3CA4732
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 17:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F64730A7A61
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 16:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17C7347BA1;
	Thu,  4 Dec 2025 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlHZozYa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A1A346E41
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865072; cv=none; b=Gg8B91f4t4WYr6DylCxqo3kM7ZXWJuKv66TkZE1Yj4QQb9kZsfCXITG9FTGr8QKyd9URFMQz1CEFk5jABrdaN2iVmIEJMCNigj3aIMfJQtZElX2HlwrNSvYlDUYTcABZcPlir/B31FXTioZWB9YtNHzI8FvRrjW6d6RXaZupZvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865072; c=relaxed/simple;
	bh=Hqm19qhEtyyB+awO2JFc4zCVn6kCUyIwQGxa8Cui5Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7etMWRH8J5a4hLi8WlLIQ/kt71xw+4QNNHO2c3pupbHVMea5LxjTQ4wtDv9C6J6TURuFhMQjrKzKmRbALPzcfqXwQ04mnvTGSiQTTo8LNw/BXlACsdh30rHGFxrXOhjaN3nH3I2Xwm0lMfR1ue6Uxy4QKdTNWOrBOP+hUhGy3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlHZozYa; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so1235384b3a.1
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 08:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865070; x=1765469870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJNy8994Pot6m22uiY8XadZYdXX9qQFe2i2P88ejpmQ=;
        b=IlHZozYaQzIXfAT4fe4NAmbMeMxptjewtfv9zT5w5petHD1ZrLYnCDMoqGtYgThCK5
         sx1nBvUEemy6Z6XPw4RZXUiX0lhbIfxb0uQlivuW8AVNmTBNBx4odDMhc98ejrFbDvPp
         eyKqney08aEEVr7CuXV/mjgP9VDrGWw0+XucjH4v5tkraHIMnQRlX2Rc66rTDXxZhNOw
         tyJWk+7A4buA8RuKjVkzYL277tWJIqn3qbx+U03764hhj9bX5WSB+OQASrYR6CBbaXnB
         2Irl/EfviE+ACia9RqQKLVbjsIjehzOWT5hgI7b3DEa+8LzW/dpAG/P5OYGdPWKLYxDD
         Ziig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865070; x=1765469870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJNy8994Pot6m22uiY8XadZYdXX9qQFe2i2P88ejpmQ=;
        b=CrnZ2Wb2ryhVieVF7D2cijuwHNX/Nj5l7rdy/m5Dowyr1KJUeMcosPQX/wixWFWIH0
         /w80YomvUwGU0FybsPJIZfmRbBgAhO3zFBPv3u9ItGLij5kJUvL/535SJhguAeEeG1/M
         suwT3eVYAUGtH8TEhM60Ru3v3eBJyDoZ9U4/LPBXAlANFiccyVnd2AuS4NgKibVRH3rl
         40zF87bLF7dt9LR+Pb4XjfF+I5VDmiDIIkZ1/xmJfzeuvklS1KvmXrAlAf4tE0H4sT4s
         IrVYQUyd6XmknkP9CcBXzUibpAmpdHTG0aXTFFrevq5fNRj8Db85NPrXV/RMiYQeRM/b
         xcgg==
X-Forwarded-Encrypted: i=1; AJvYcCVvZMcn0J4SA47bqZ8nzQIgkRYWY0LkWngJvj+S5iZ1VQTuNCCRQNY/M1IKjuLIC/2eWsI+oGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyl0plgZcdIPd9a2b7cdYtmImyoimdTYa1ZzEs1gWCScHvOUmt
	uYJLaLbr+snbHXhu3xIk4e6KWnomiRCEvZCIt5iPiHCstfuYfEF1e2HZ
X-Gm-Gg: ASbGncuNpWGZ20EqdvmqGc37QkcfMl3ki94BGpPIaL9ZdUhF0ks2RC5Eyvll32gH2RX
	7zDmNIgXOjobAfPNcKFl/PKpMnLHqhMOPuHVIrrmphmUNozhJ4W5kqoveegf0L9XsmEeD7X0Hsb
	ck4efEYac+Q9N7dcxRHFrv7TcytWnOhdJot2SvaZYgM8wPDFrlNJBTaVp/0T7rHPUF5JyX2I7Fo
	GxzSeiIxdHa906bQ9Us1N/WNmmnk3aaZk7ZHpkatddnOmdZCY7Bk57wQZq9p9eS4BN/YRwApRWs
	orMWhe10ujKjapuiCkiljullFGXhNPXS+Q/x4RBObkIw1gI+P5ikYQ6ZXjyltl+ZF0Uy6vuVbMp
	UI0D+eGKaSjBREp+PMalj5v0k331NBEyt7beAlOTlMWOns/FN5lx1teTBnIbKgbEFZXwfD75QMc
	5pXoQ5rQX+tQ8UK6aJxbFaujfptVRvgoLzKQ==
X-Google-Smtp-Source: AGHT+IFWkduyk9szNluelpZfGaJjNW90s6UE/NY8hC2k8APw+laM8wvICtCdvTbCpRk3ULmedtT53Q==
X-Received: by 2002:a05:6a20:939f:b0:35e:1a80:464 with SMTP id adf61e73a8af0-363f5e9dd6bmr8075142637.46.1764865069640;
        Thu, 04 Dec 2025 08:17:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf681550446sm2310053a12.2.2025.12.04.08.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:49 -0800 (PST)
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
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 12/13] selftests/fs/mount-notify-ns: Fix build failures seen with -Werror
Date: Thu,  4 Dec 2025 08:17:26 -0800
Message-ID: <20251204161729.2448052-13-linux@roeck-us.net>
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

Fix

mount-notify_test_ns.c: In function ‘fanotify_rmdir’:
mount-notify_test_ns.c:494:17: error:
	ignoring return value of ‘chdir’ declared with attribute ‘warn_unused_result’

by checking and then ignoring the return value of chdir().

Fixes: 781091f3f5945 ("selftests/fs/mount-notify: add a test variant running inside userns")
Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 .../selftests/filesystems/mount-notify/mount-notify_test_ns.c  | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
index 9f57ca46e3af..949c76797f92 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
@@ -491,7 +491,8 @@ TEST_F(fanotify, rmdir)
 	ASSERT_GE(ret, 0);
 
 	if (ret == 0) {
-		chdir("/");
+		if (chdir("/"))
+			;
 		unshare(CLONE_NEWNS);
 		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
 		umount2("/a", MNT_DETACH);
-- 
2.43.0


