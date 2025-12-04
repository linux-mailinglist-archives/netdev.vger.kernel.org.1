Return-Path: <netdev+bounces-243617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1380CA4717
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 17:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C86930836DE
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 16:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF7B346E4F;
	Thu,  4 Dec 2025 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpNaN9N/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3BB346780
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865071; cv=none; b=GRhVJEaTKk/X0o5PhQmsl8J8PSGqnbrKFXHvz3eV1pXO+aEhpc7qtA+IxuCQM2xlGNTfmauzNLLTmeOiwTEj21XvPLi9HPBKBxXf4jCrRSBNgS7R69BAtXpwLPNXrDzv0mPP87ztVleNFJZhTQKNxCs5/95VDoAndBPp+YA3pX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865071; c=relaxed/simple;
	bh=W/OQe5SBE/hGcbbtQ1DcT8TO1Zhva6jnYh6vp52AP/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aowSF6uVnGP4tlIYMFNfpiv00XVLX/H15eSaxtLQdk8B+LR0Ji7L7HaAvAUSt63wiMeKwXdMCWHkCpBVRWMxMsIfFtQ3+C766RZohC2XqM+6EyAvMKCEPn70N8/Ty+Z7yLvngPTw/LEI1MjG0EnnYHUFJAB232cqDcx9mgz91Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpNaN9N/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo1283850b3a.2
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 08:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865068; x=1765469868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqotmNbVaSZDa6RHeR/dZGNbL7atfR/Dwuv0KZcoFLg=;
        b=kpNaN9N/eED3awn5YgAFGIbIBjH6BCEe1ugH6xbjeGnxYPWFTeGm3F/l0EEiL7LRhf
         TkqrvGjrzeAyES8YAIn1YZ7TWcsdD2APybxkrjRUOzG21VrbTHlP0+LuHNPuJnAT7XbN
         d0urJX3LiRN+K4JvOGmr6NwQQLlFf5tHZ/5YwszAlb/261tH9D+Zg+tw93YiMBc43XEv
         ViwDQSJNryP46AJpply7vowXa5KqIWNxnzoHC4LCfGcpb4qMUcnsQRFT2OqdhEp+aP3W
         gHV0Op5fn+tf3xVkrjefB01CWEJ324QGKzrBXILs9/Vdan1a8jLWznDUvbll0sG1xPYZ
         kzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865068; x=1765469868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vqotmNbVaSZDa6RHeR/dZGNbL7atfR/Dwuv0KZcoFLg=;
        b=WHYA5VEB9Dp95rj2PcqU3RumLc/qgkLbNKZbeDD48Ep73dQKa6qJj3H1ygOfNyliSy
         AwFstHmnnBXfBmgwSDsjPAhccjXvV6lVUsNRn7SaeQYwBAj86ahow2//mTsgZj8BdAUw
         Uup+fMtkoj7eREfGZA0J+56ZJE3PiHCc5zE+Xu1HA211tTHL5WGrl6mjMk4RtjL30JOm
         3/xXa7OVnPvgimdMPHDW+rWYW4wACSYhZ0+qJn7drjF76IXox76eSWreB5yb+REv+oQK
         fJfgiP6RQptOgbYY8/5xsQ4+1wzZWQd5I5Kc7yndGsuNwzB3uZHZpcG90AdGUn9NJHFq
         kf/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuXRuv8wM3RHqVaQ1a9FjoqCAYEu+qLxuanzeGo1DmpdJSD/abTy3bjiwAiUc9cFs8eZ9GOXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0KusW9uGBaCaY5kOuIlv9+vo+2ZPaDvtxeWLGaWRfaHRXdpxO
	kDfu+JlaMPqWCkuLGswzeWXARuUrwmsFNiacPK7NnwXDJ97p0c9TNyvu
X-Gm-Gg: ASbGncthe84oQBw01uik0P3XhbFZgOZ5JPKML+zK/AvKtK1w6BJ1KWM8JIWe81GzLYq
	RbR0EE4EMxo7yIIvsUf3OiFEcv3FPjnPFgslidbBDZzpP0Ve9nSziyM0U+odCqEfPtZMhu4IGTi
	+FM1So9eTu2TRNtNIuQ1l8nemNrwsv0NCzdlq0c56tJvm2PN+WWKQnQx5B5AqKx3UXicwqQZJDu
	eCeABE8DJse2d17szrR11jD8jWG/zAqWwtRYcmCOtYmSewPvkts2PKO2BnTYxjKTsrM4kP4oP56
	ft5TlrGX8vLNZwq1T/SabiHooFQvsaRSVUhnh9nr/ikZee+e3WpILJLX1GHJYf+FTZP8fmfEJSZ
	zJfAVOQwZ5xMLYMOMSbTJEm0+StQpa98zBz5xpv6lZrqABxfAjxBtjN5v4eWs8FSC55dLhZ1+uz
	/jDvnm84pvj2nFkJtDD+lD9As=
X-Google-Smtp-Source: AGHT+IHVpqKaMcm1FDJ5yjab03bifOuUjE2BJB72SixSC6x+ndj2E9PzKZDdx0HSGekHKIlUwqYNWg==
X-Received: by 2002:a05:6a21:33a3:b0:350:fa56:3f45 with SMTP id adf61e73a8af0-363f5e029bdmr7709680637.35.1764865068434;
        Thu, 04 Dec 2025 08:17:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e29f2ed2fesm2637768b3a.14.2025.12.04.08.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:47 -0800 (PST)
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
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 11/13] selftests/fs/mount-notify: Fix build failure seen with -Werror
Date: Thu,  4 Dec 2025 08:17:25 -0800
Message-ID: <20251204161729.2448052-12-linux@roeck-us.net>
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

mount-notify_test.c: In function ‘fanotify_rmdir’:
mount-notify_test.c:467:17: error:
	ignoring return value of ‘chdir’ declared with attribute ‘warn_unused_result’

by checking and then ignoring the return value of chdir().

Fixes: e1c24b52adb22 ("selftests: add tests for mount notification")
Cc: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 .../selftests/filesystems/mount-notify/mount-notify_test.c     | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index e4b7c2b457ee..c53383d4167c 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -464,7 +464,8 @@ TEST_F(fanotify, rmdir)
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


