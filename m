Return-Path: <netdev+bounces-50900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0377F7800
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 16:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C471C20B64
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 15:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E00631726;
	Fri, 24 Nov 2023 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="XFIDj+F9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5043C1992
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 07:43:44 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cf8b35a6dbso14075875ad.0
        for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 07:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700840623; x=1701445423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ccxLVdh5QHe0sHWS5YZYhy7xD8GTlMefO9eHp9CVDBo=;
        b=XFIDj+F9FsiLJiLNr5eOQWe8IDC/9hIiGwzMNGJJbzAsT2hzTMoaFHlHlGwHuGTsgP
         t+QussgiTl88n7KD58P25qu2STL2i875M/YIaDTHeStHansob13/VFiwPQ3mUViqXONg
         4Sw4SmRhtbqhWEky9IV37z3Vh42QkMWe6a0fbjmNuqPHZIKwPVd9y8j69GOdNA5/sFW1
         6fW7PG22ak3BmP4/IKvlFcdfGwjgvfk4JtcTwBLZ20eqDGAhV/pss7kniHaWXqpRnsl5
         uNaNMRmlHG4FuVC3EFyW6ENyDXV2KS/YOZkAazBYhmXzPylbbYkGoW/qRzOBWN9uz2O2
         m2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700840623; x=1701445423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccxLVdh5QHe0sHWS5YZYhy7xD8GTlMefO9eHp9CVDBo=;
        b=TLGYPmypANmpWj9rNnq+Lv9eXECzPQlXfqHIVR6iUXHgAA9kL6GxC8mj/XADlYTecu
         g3C05l/e8zA0MJ5x32EgkdbHRTap1g+OgMAyMq4sEH6Liemaz//D5K2Ry2s/AgXcHrHB
         CblBxssOssWACP5G97QH0UgFH7uNUFxqXUtJq53Px4+xrCOPNawvwSOV3myAVEsbGT4U
         luqYM81/eG/FhH21RD5mjOA4NeR5xAwXbLdHowoH4hgZWiPPYVj9eJnYNoR6LLygJr2X
         YPks8RfyjIsRlAhalXblliYZP7p966AsW/wFiL/EOOFLohme8T9pzUwQkeMPIlFdTEk6
         59Ng==
X-Gm-Message-State: AOJu0YzBYd+8ccc8DKBQiP285AyuxJ1LdfWRRMYFNmNCJgIGVSD3OTyY
	R4CEFx0YDubSsk+NNkvFkmzdH20HaDpstE80W9A=
X-Google-Smtp-Source: AGHT+IH+F0/Tog/V3FPqwi/5b1xKQK3dDLRA2Wcasoy71mHr8RXKzKbvMnbhRmUo3wvfIHhrPbPX7g==
X-Received: by 2002:a17:902:c945:b0:1cf:a2aa:2360 with SMTP id i5-20020a170902c94500b001cfa2aa2360mr2442643pla.28.1700840623514;
        Fri, 24 Nov 2023 07:43:43 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902740600b001cf9eac2d3asm1919743pll.118.2023.11.24.07.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 07:43:43 -0800 (PST)
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
Subject: [PATCH net-next 0/5] selftests: tc-testing: updates and cleanups for tdc
Date: Fri, 24 Nov 2023 12:42:43 -0300
Message-Id: <20231124154248.315470-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Address the recommendations from the previous series and cleanup some
leftovers.

Pedro Tammela (5):
  selftests: tc-testing: remove buildebpf plugin
  selftests: tc-testing: remove unnecessary time.sleep
  selftests: tc-testing: prefix iproute2 functions with "ipr2"
  selftests: tc-testing: cleanup on Ctrl-C
  selftests: tc-testing: remove unused import

 tools/testing/selftests/tc-testing/Makefile   |  29 +-------
 tools/testing/selftests/tc-testing/README     |   2 -
 .../testing/selftests/tc-testing/action-ebpf  | Bin 0 -> 856 bytes
 .../tc-testing/plugin-lib/buildebpfPlugin.py  |  67 ------------------
 .../tc-testing/plugin-lib/nsPlugin.py         |  20 +++---
 .../tc-testing/tc-tests/actions/bpf.json      |  14 ++--
 .../tc-testing/tc-tests/filters/bpf.json      |  10 ++-
 tools/testing/selftests/tc-testing/tdc.py     |  11 ++-
 tools/testing/selftests/tc-testing/tdc.sh     |   2 +-
 9 files changed, 25 insertions(+), 130 deletions(-)
 create mode 100644 tools/testing/selftests/tc-testing/action-ebpf
 delete mode 100644 tools/testing/selftests/tc-testing/plugin-lib/buildebpfPlugin.py

-- 
2.40.1


