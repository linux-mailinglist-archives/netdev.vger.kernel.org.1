Return-Path: <netdev+bounces-243614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DADCA47D4
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 17:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE4EB3048999
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 16:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77E7343D79;
	Thu,  4 Dec 2025 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDeuL0LN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BCA34104B
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865066; cv=none; b=Q4s4IFM29v6hfPgaWt2Wnz5DFTytGBRblWweTODwMdvp+1HH5mtZj1Y0LCQWa+INC4cZkd/xQ4jbPnXAuzr902s/JUzXJ01l95mDlzOQ3qswPqnJ0Ft8SBsTeQ8hHEezUWcUxnLEj/FaMBqk2w1QE75P4hgyV6OicAQVsOTTLtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865066; c=relaxed/simple;
	bh=3ygh4I0glRNwV35GaBKvlTRslUW//cHz3CUI6TSCtZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdE/Gpyz3D3mYcg9rlIVHtEhdp3v2e9ROoFmf2yd1CMYnwHIbBR8ZW3ZA9g0W7GNo4J7+OOUr6dlTFLzCuGjzUMzaJzQqznx0JBij4DTPvO7Ev6UOSmvErxqTXqVNJu8XwmmAwvCDhvlmdJtE8WSRTfP2MpeLRszud4lEaH42Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDeuL0LN; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so1281759b3a.2
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 08:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865064; x=1765469864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkZnCgx9bxJPZq7l/gRW6dYxX2rEKzxVPCSQ60u6+7c=;
        b=YDeuL0LNnKv6Skf8JFXDETnbrmN4u8CazX+kdfLXew/nNZ7V6ZNP/PIB7UjlMR0EPL
         Uido8y8q61vndAul9btZRNmAk7zZtIiiWZ5KMkzZuFnRq49e2ftmfzPEBFFqHOcFt3CD
         DVmRgZCngvCNXzcxB4cSWYQiFf71iBV0WJKQbZ4VxFVbJyWIbFLWELN1mG3lcRVwJld4
         JPbPsApQDRM/EjWohExjcFaZLJvUJBdOoqrm1ehm94FbdJiiyoz/JuiWMJSFrdlOOKvB
         6wkij27fCrWtbq+gAGi9pJwjtjsKE9ZDF8ecm+EckA2kzeAhZws1hC1d0voeZ+4/+jS8
         A9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865064; x=1765469864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkZnCgx9bxJPZq7l/gRW6dYxX2rEKzxVPCSQ60u6+7c=;
        b=dSY1i6eqqzqLyjZIKMXmoLoNNHnoiAJ4Ws0tgKRbqet8DsKsl1qlyY2cMM/kjgJ2/0
         BbhFBIpz+AlV1MbDFc4s0NzucS52Gmum6VA5aXrUZxL2y0e4/OLXLt681HZD3UZTG9HB
         L6QmvFLbVGx6kpfJ09ZYqmSWMZgrQrxnGMSLdGo+RVLi77v3BTAGZbaLERclKPhHrVdv
         c636MwymlUm74EYADko7lOYyC4yBNiHTojYAstSEmkneD8APiuuEWzqCAx9Hemw+OYoH
         3Ao2z8uQuwyLN46gDDxH25uGeQu+Jt7rvzQjHJHXmBIhOzAFPCAq/RjGpoadng/bPzNP
         yvaw==
X-Forwarded-Encrypted: i=1; AJvYcCU4JrVNgLcIyQ0buQKEMBO8Awb64LaINZ84j2PJe43VjKHQh4ArjXNnle0B77JPooIBsmvUZIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHIwPZ7FujBYeu9Jpxw6EkxmueUntOzYDC5PyigGNw7zxFoU4r
	avEEcVTI9opJ66wyYfTBZArFo42/3EC5hN4Il4eUQXtTkTy99I2T7XHX
X-Gm-Gg: ASbGnctbeDMHDlWefLCMiy1KL1lVEAin/lfn3ajhiS2IxXmyENTkdyOrFGzuSj779h2
	Ag6d4XhKJt2eR0q9VRar6SCkJaGgqejiGszSYR+AMjLvaF5sm7iIU57Um+jL1RYo20W6AK6xbx2
	WTtF9G+EibBLwQlwYUNEDKaiPjrzCUBBDqLXFlhOsO0IEfof5YfpIw4CaKycw4hTnLC1Ia//q2h
	5wqQETA6StIEKl2Izsnh6rB9x7tjgVHxUqaFdIhkUke1Hvd5dIwPGymGxVuU7tkAS93nCmkBvjX
	LbqrF0FvpDL5wxr9vXXMiGqAGUQHO1UIky0ofxknHhmKUhJhPZ/im/TUPE17L++tJf3M5Q3ycmA
	y5X5eSBUoZZ2PNlH12Y/wnJitaaL2Tsqa9+xWJyPfbe0tN4l8qW7S1buTs01Q96QAiylOvWP//A
	OuIifUDn/RVNm0rtXlnYOk7eM=
X-Google-Smtp-Source: AGHT+IGvOyPD8rdOIos5LYcmChpa04+Wfxdyx/PwskRd3KR37HKV0AFf3UHo1YnF29GTR+qBDwW4gA==
X-Received: by 2002:a05:7022:996:b0:11b:89f3:aaf8 with SMTP id a92af1059eb24-11df0bd181emr6324640c88.4.1764865064446;
        Thu, 04 Dec 2025 08:17:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm8931800c88.6.2025.12.04.08.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:43 -0800 (PST)
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
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 08/13] selftests: net: netlink-dumps: Avoid uninitialized variable error
Date: Thu,  4 Dec 2025 08:17:22 -0800
Message-ID: <20251204161729.2448052-9-linux@roeck-us.net>
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

Building netlink-dumps with -Werror results in

netlink-dumps.c: In function ‘dump_extack’:
../kselftest_harness.h:788:35: error: ‘ret’ may be used uninitialized

Problem is that the loop which initializes 'ret' may exit early without
initializing the variable if recv() returns an error. Always initialize
'ret' to solve the problem.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 tools/testing/selftests/net/netlink-dumps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netlink-dumps.c b/tools/testing/selftests/net/netlink-dumps.c
index 7618ebe528a4..f4fc0c9910f2 100644
--- a/tools/testing/selftests/net/netlink-dumps.c
+++ b/tools/testing/selftests/net/netlink-dumps.c
@@ -112,7 +112,7 @@ static const struct {
 TEST(dump_extack)
 {
 	int netlink_sock;
-	int i, cnt, ret;
+	int i, cnt, ret = FOUND_ERR;
 	char buf[8192];
 	int one = 1;
 	ssize_t n;
-- 
2.43.0


