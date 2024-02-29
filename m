Return-Path: <netdev+bounces-76197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B9086CBBA
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 15:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9FC51C20B59
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 14:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639CD137767;
	Thu, 29 Feb 2024 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="mYt5vXd1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B120E137742
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217527; cv=none; b=UTv/9Hyy+gq6QXe5yCZOsPr8EfsvcSQFhM/+Eh45O+L+AgtjwUjwWbBg3Gd3WPPjs4VtnoSmVzEYupHzin0HOarMlUBH4PC8fjVX9p0IlwxqbQvHWjM56EE2j7g7nYRpr5P7OVAtuwEOJGAnX8TPaR6n6/ap52unQZXEKdDUywU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217527; c=relaxed/simple;
	bh=Ih9xawQi49XQbDIpr/3pub8/701foOZuv4pQwUVsysA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dbUCGIDthnyCDfQ01sgU2pTxbIAFEPNlaBSIEV+WNiM/c/JRKam1yKjKdEve1OsntZuAjFAF7oOMI5i6NvsO3HB/NuxfnNzlwg/9B4ieJRKUQV5578K1yLDzj2NylhA5ZmJVncgKWP0dz6MwphGH+G6WEIqTzCPxEeCYUfEXzrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=mYt5vXd1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc0d11d1b7so8877885ad.2
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 06:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709217524; x=1709822324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ovH92alGJPjHMagml3lx70tu4OqX/bHmHdTqKi6ex+k=;
        b=mYt5vXd1T5Yj/uIMYhlhgYGTqDHWdnQH8W+lsRDtGAdQRcRJpnc7FU3M0wRDsOI9At
         Arn1IMysKRjAsSl/rxIj8IG3AP4I97RjpsmeDaqVx9exlPp+DGd0a8TcIMXbqek3AB5e
         ewkULoDczButUnx0O7mL7B5UfJIJ40/riba0HWI3rfRKoBAbnD3+2L+T6cj7J9mP52+J
         zVMqHNj8Z31G8/EL1qwHlRw4IN3kFRWzhAXDhpiz7j5i7lNC2QYE6yHt1FC/0AahKgRx
         oDR2TH9IdNVXg5zxJ7dpXI9vofFoMIneHIMve+fI0rO/eblFB3ZlSIfR1uvAMRaLZNix
         CnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709217524; x=1709822324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovH92alGJPjHMagml3lx70tu4OqX/bHmHdTqKi6ex+k=;
        b=aGzka6U+pi2iyjR19D4ia7HNAboS2B4kXxBG9kXY7OqGMYJLE1Vqo5D+xanH1sK5eu
         g1DPWKfERp2nS36zxkdFfXZB8yeYKRKvBTk/3vyu+0lAwBX9qxoecAqeaW0DAA/doDf+
         PUBXlXgo619E5ms4CGIBtRJ6QLsi71E2RCDrLOOfrFL5vfnAudswySQwe4fi/BswRksI
         qGzLAB5TtHZD6Tj2Yv3jTsr55o0VfonPCrwps4khSc0jnvn4Kw0HAgeJMyGrw6pWhfsP
         jcwe0RjMtJbZlA95PV8KJ25aFjxUn1nX0mIMpanxa46nKPdMSeMSD2DhWOC2I/ko5xN6
         Pe9g==
X-Gm-Message-State: AOJu0YwTwHa4T5MmuT4W8xMtfYC+lYbdnQHvWsBv4mbSCZilUNQW5qzk
	vC6aMFQrHCUIyX4y45fFGPT5BglCfJr1+e3odFKJxcNzBibt/Sc0p+tj4e6WqkdiorY0Jo0B35I
	=
X-Google-Smtp-Source: AGHT+IGZ1log36VMtE5h4eVg4BqFBZpMh6ssQ+jauSzwFcFX7v1a7ZYEKHkDGSDxxL1HqXMm7lHAOg==
X-Received: by 2002:a17:902:ed0c:b0:1dc:26a1:da26 with SMTP id b12-20020a170902ed0c00b001dc26a1da26mr1968539pld.30.1709217524532;
        Thu, 29 Feb 2024 06:38:44 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id l3-20020a170902e2c300b001db82fdc89asm1552912plc.305.2024.02.29.06.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 06:38:44 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	shuah@kernel.org,
	pctammela@mojatatu.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	victor@mojatatu.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH net-next] selftests/tc-testing: require an up to date iproute2 for blockcast tests
Date: Thu, 29 Feb 2024 11:38:25 -0300
Message-Id: <20240229143825.1373550-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the dependsOn test check for all the mirred blockcast tests.
It will prevent the issue reported by LKFT which happens when an older
iproute2 is used to run the current tdc.

Tests are skipped if the dependsOn check fails.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 .../selftests/tc-testing/tc-tests/actions/mirred.json      | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
index 795cf1ce8af0..b73bd255ea36 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
@@ -657,6 +657,7 @@
             "actions",
             "mirred"
         ],
+        "dependsOn": "$TC actions add action mirred help 2>&1 | grep -q blockid",
         "plugins": {
             "requires": "nsPlugin"
         },
@@ -711,6 +712,7 @@
             "actions",
             "mirred"
         ],
+        "dependsOn": "$TC actions add action mirred help 2>&1 | grep -q blockid",
         "plugins": {
             "requires": "nsPlugin"
         },
@@ -765,6 +767,7 @@
             "actions",
             "mirred"
         ],
+        "dependsOn": "$TC actions add action mirred help 2>&1 | grep -q blockid",
         "plugins": {
             "requires": "nsPlugin"
         },
@@ -819,6 +822,7 @@
             "actions",
             "mirred"
         ],
+        "dependsOn": "$TC actions add action mirred help 2>&1 | grep -q blockid",
         "plugins": {
             "requires": "nsPlugin"
         },
@@ -873,6 +877,7 @@
             "actions",
             "mirred"
         ],
+        "dependsOn": "$TC actions add action mirred help 2>&1 | grep -q blockid",
         "plugins": {
             "requires": "nsPlugin"
         },
@@ -937,6 +942,7 @@
             "actions",
             "mirred"
         ],
+        "dependsOn": "$TC actions add action mirred help 2>&1 | grep -q blockid",
         "plugins": {
             "requires": "nsPlugin"
         },
@@ -995,6 +1001,7 @@
             "actions",
             "mirred"
         ],
+        "dependsOn": "$TC actions add action mirred help 2>&1 | grep -q blockid",
         "plugins": {
             "requires": "nsPlugin"
         },
-- 
2.40.1


