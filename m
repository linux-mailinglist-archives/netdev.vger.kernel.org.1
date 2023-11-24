Return-Path: <netdev+bounces-50906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8EC7F7813
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 16:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A151C20F1E
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 15:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D0733072;
	Fri, 24 Nov 2023 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="EvJvufEG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B213199A
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 07:44:04 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cfae5ca719so1708745ad.0
        for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 07:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700840644; x=1701445444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxH4h/fUgyjGMKXsAUdrvTbwQh/c4Jyei7tUpRPE518=;
        b=EvJvufEGOk2ljoM/xXOhxSCw9Ssx7QlYUP4qjwlIzigo8y3MO6y/ipzVHg6zfDd8Wj
         WtIe8+0NEeczc/8T9VzzpHZSRibjuvgLoYxONFJzloZWWeap0dp9Q/8g3HhczLPjIqIE
         VF51yzwv9MhRBOc0IZcCOY8rACxuctZqnLUmXeUp2aHKZ3NmInpCLFM4qgUkmQUN+lLk
         crcSR5GiIfv+1TX4u1tZ9f/aN9MkznY8g/pHbjvB9vBIiiooJPxGYMHPb/Vg1SJ/MSMT
         ltZdz18AJlF41sI0qEYZrtNgcGalP8LUu0VoRuSqtOb5RPiyaipSu+mDzgRh1z8x8QWJ
         W/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700840644; x=1701445444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxH4h/fUgyjGMKXsAUdrvTbwQh/c4Jyei7tUpRPE518=;
        b=wUEcU8oYUXDJ7KRz5U5fv9LMVQorR7Vl0TN0PeEIpOJ4izHo8CXYozsTbPsaoDcY3Y
         mzB73AL7Ux8aB8DjxuQrXXcvqGuHOFX0RKSixQjJpJV/ygU4LyAZBvnGsBYcWGHreCHd
         wQ6fqlElEq6WDYXgOimrKwivyEKqiY20xAU209sr/yd5APwkbdTlcShhmu4DCIJj50ot
         nHD8bOooE+whOkba+ih50yTPX9x9/ofIhTeXeBRcjanxv9bky5V6rFLbH0hIdqp5i9Uy
         ug5hdRzFCSZJZRjQ+Y2k5fpKZHusogcYaCQfgNDpD9maQ1ymk6HxrwGClFHEFMUzmna9
         mscg==
X-Gm-Message-State: AOJu0Yw4P9Hpt7rUxH611exFN8MxwzBUHIwNP6FWqHO0OhwdtIS6GMnz
	hqUVV3AqcC/4K7/8ab2/FKo0y/YqEfwAWIAgT/Y=
X-Google-Smtp-Source: AGHT+IESTfwIV1Y4e9dxiuOb6Fx6zh8dfzPm+t7NgGLnsuKfIve4gS4FKHwaEbYY0Jg2cMPODWHT/A==
X-Received: by 2002:a17:902:7d8a:b0:1c9:ca02:645c with SMTP id a10-20020a1709027d8a00b001c9ca02645cmr2977675plm.36.1700840643802;
        Fri, 24 Nov 2023 07:44:03 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902740600b001cf9eac2d3asm1919743pll.118.2023.11.24.07.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 07:44:03 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 5/5] selftests: tc-testing: remove unused import
Date: Fri, 24 Nov 2023 12:42:48 -0300
Message-Id: <20231124154248.315470-6-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124154248.315470-1-pctammela@mojatatu.com>
References: <20231124154248.315470-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove this leftover from the times we pre-allocated everything

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
index 77b1106b8388..bb19b8b76d3b 100644
--- a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
+++ b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
@@ -23,8 +23,6 @@ class SubPlugin(TdcPlugin):
         super().__init__()
 
     def pre_suite(self, testcount, testlist):
-        from itertools import cycle
-
         super().pre_suite(testcount, testlist)
 
     def prepare_test(self, test):
-- 
2.40.1


