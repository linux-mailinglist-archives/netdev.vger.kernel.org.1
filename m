Return-Path: <netdev+bounces-231358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 966B2BF7CB6
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 18:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646AB19A59D1
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B2034A777;
	Tue, 21 Oct 2025 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNRc5cnX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464DB348899
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065709; cv=none; b=HVkJJjBfWWmar0p08hlF35GhmTE4rJVdOcWM85MzGxiqytYDEVxSzp/5JjayV7Tfks1IUNlAfRxSuasYEXAnIfM40l+Qv95GhNXP7IAHCno0HTXI+Cc6l3f1uvXEaMUk7NL5Gr3pbST5khUnAt7V+gSA2EJjmufo3jiX4ZFjSQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065709; c=relaxed/simple;
	bh=MD15u5LqqmayWloxdzFGq0sNLTBc1b1Ii0ATLOQcv8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y0S541404Tk4dMSaLiQB+YJvWwZLRecw3hfO8u+qK1nxEx4YH/svXER1eHp6USJeD+4b7viDShKj1RP155gM7m7BtBcY0k2Ih7XiKZPyYR8EvC48E92je4DZfzHa6FO9EYJZ28gLMIoC2nX0uB1CT/qUXq0Y9p+niaVvSZdKKZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNRc5cnX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42701b29a7eso55172f8f.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 09:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761065704; x=1761670504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qn9OLNMyl8gChDp28IqA1MLvsXpL32JwaHFC00xTtCc=;
        b=NNRc5cnXLfbWheS5JvW+1vO5mWwePGxYnLtn01PAfA8vOtmQgEH3BXpgbYE8SclLYk
         8a4pbZfjxmSgujPZLxwhP4zb96V/v8PsjkxYq1YdTF7DUAnudpRCWr0wK4tJOu59Hc0G
         09WR0FfLVoRl0GkpwNk+vbcDMiSEGpRwRZ84fgxqepsGR4WGySjqrbof4L8qqRsutft4
         ndac/Fn9/YZEYqqiLSXOskn3N0ca1MHiHvZOZQMHxqqE+zgiIlcm5aQMd4QGEx7qktQH
         g1opwS5cWzwg2yrN7pyEQq5CR+69rPX0HDQBjYnXAISKd8JS4rrhIh0DjmEPMDfGXccI
         dy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761065704; x=1761670504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qn9OLNMyl8gChDp28IqA1MLvsXpL32JwaHFC00xTtCc=;
        b=GKPE+cBKAkxKcx8c6B47vCuzv2cJWxJRnvmsrPhMVTv8n7lyFmyQORV8MYD8njbotS
         7I4SflVvBmVA088iNsAgYXhgA3GorMeWnVt78KwuEMjunYX6K5t+bh1PoWLTNGGT+k4t
         JU2DVnHqky2xdaX4uvEut3UKHJLavz8QckzWOsIAZvpawnuyXBtsuIqommxeXhjlQgBB
         NedZ++0bTKnhoyJh+FfPNxkVnlad/J9ycclOEsY/jbfY23kqBtwRbTVPUultSPNMm24Z
         vHyyTosk7brKhdIBJhVU/Bjh+iFaSO1XtGV69jTtEAFaDShGMnHxJFonfgbngzOsZXtR
         SDQg==
X-Forwarded-Encrypted: i=1; AJvYcCVGVSq/UtIZf5jT5JToODI2vRLBqAMZrN/2rvsa9PnWcbOEx5FXuaqFeWnEx1CyBD258rpoGvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHGV3wnJLJTsx/RyCA5JJzCUm+zi+lggh4jY/ZGBOigo7dl71u
	89lDtzRTfioRyodtVZifXAwRoTk250Wov4RGPZe+6lPxYW3iV37w3Dbj
X-Gm-Gg: ASbGncsy9jLM36+Ora2cP+cGnGI95sEHhKHGkvAST7QzCc6LsKuNsIceMY3LmE1EHP5
	IR/m7gIIasD8aG3TL8i6aWUbbEEzxhJDy3SQxwr2P7FUEWhDF9MSFAzzi/l0NiliWRhtp9E/y5+
	Z//3CWD3n+gCWF/L4FGv+VjD2CyzgM144yNcWuoPei+IdiGZfJyXYulhOvxa2rsLUXi33nrCUp7
	I8oIxU9hqsAL/NlvANI++PT0zhkrRKAYvjgeqiC05czHoRzLk70QMuCxP0vZ8oIqX80Lzr5y/+o
	9Vt5+w6mmbZf76sqiEBKQA37c1xKgLtv3BA9KuYzv7mufb8vVmLD6INB1exEcbj9yFCC1SUUgir
	PnKvZLSoojdaNInk8XnZrzNoA1fxs7C0wcN+D8eKLuLgRWKXW/yiJHdDxOFY0kiytakyPgoqHrb
	p0pcW8eoNioZ22E0uOAx4fCTKIqkLBsh9VQa/1dOkfs38e1BG/kGj4UIZi5QpO6WYl6k5alw==
X-Google-Smtp-Source: AGHT+IFB8n84f69J64AkWR9VGuZDwOZaYOeLxR1PP9RJZ4VLcpx4xH2b3szKu1AMRcrRkxak/JLlHg==
X-Received: by 2002:a5d:5847:0:b0:3dc:1473:17fb with SMTP id ffacd0b85a97d-428531c8828mr255369f8f.20.1761065704306;
        Tue, 21 Oct 2025 09:55:04 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm1649005e9.3.2025.10.21.09.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 09:55:04 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftest: net: prevent use of uninitialized variable
Date: Tue, 21 Oct 2025 18:54:33 +0200
Message-ID: <20251021165451.32984-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix to avoid the usage of the `ret` variable uninitialized in the
following macro expansions.

It solves the following warning:

In file included from netlink-dumps.c:21:
netlink-dumps.c: In function ‘dump_extack’:
../kselftest_harness.h:788:35: warning: ‘ret’ may be used uninitialized [-Wmaybe-uninitialized]
  788 |                         intmax_t  __exp_print = (intmax_t)__exp; \
      |                                   ^~~~~~~~~~~
../kselftest_harness.h:631:9: note: in expansion of macro ‘__EXPECT’
  631 |         __EXPECT(expected, #expected, seen, #seen, ==, 0)
      |         ^~~~~~~~
netlink-dumps.c:169:9: note: in expansion of macro ‘EXPECT_EQ’
  169 |         EXPECT_EQ(ret, FOUND_EXTACK);
      |         ^~~~~~~~~

The issue can be reproduced, building the tests, with the command:
make -C tools/testing/selftests TARGETS=net

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 tools/testing/selftests/net/netlink-dumps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netlink-dumps.c b/tools/testing/selftests/net/netlink-dumps.c
index 7618ebe528a4..8ebb8b1b9c5c 100644
--- a/tools/testing/selftests/net/netlink-dumps.c
+++ b/tools/testing/selftests/net/netlink-dumps.c
@@ -112,7 +112,7 @@ static const struct {
 TEST(dump_extack)
 {
 	int netlink_sock;
-	int i, cnt, ret;
+	int i, cnt, ret = 0;
 	char buf[8192];
 	int one = 1;
 	ssize_t n;
-- 
2.43.0


