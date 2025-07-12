Return-Path: <netdev+bounces-206343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39436B02B84
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 16:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32743AD792
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 14:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D0527EFF7;
	Sat, 12 Jul 2025 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="hyDnnrsw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A33E1DACA7
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752331844; cv=none; b=DlUT/q0LBOdMgDYyXUrtwcsZwzyj1+Iz4yA8oSKP5POg/wvVKslGZnQcTPrjG0tCtmGOmf8ZAPs56j3KQ8VUYZkoZ2e+R6vu4PbiOM7GFZZlxqSQEYUYJxSNOd0pBNKCXwD0CT4zQp5wrBvuf5fDIMGkDsjmlaYIK0cf9/WqeSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752331844; c=relaxed/simple;
	bh=zP5NLEmLJCo+ZVIDfc1PnOQtGR6WLZei6ybdIcRPt2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tI7ZTK4WiHZoe0jFlo6OrbxiRRn3ebeZKd6ckj+ISQGgQCnGnhm5khJIpRT/7VrMSo/482txKSpxpsxin+TySaVm9KZ0O8T6YT6anfDBOB7t+4+KG1MIuSeKz+Uk4EkE9MNtEwrdcXyNjxXn4UtrLXqdVB8BVBJyoZrm10IoEJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=hyDnnrsw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2350fc2591dso29776715ad.1
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 07:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1752331842; x=1752936642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r8ZD2wqQ2MFObmE2ter/MLsk6WNa+XkZK2/I8F8necI=;
        b=hyDnnrswm1x37jvfH7G7dIAU4T6APrKOyekvC1ejGc1hKNMq/qvSEgqXRLiLTqtppd
         R+hUBCVvyQo6+bx6DrzpODjNr+egQcIuOOOomk6ph2yBpR8pw/em97pRM+48cUraJJzx
         lSkk8iPz2s7KOlK0yDjEbLR/tv8SwhT9vAF7VD6gvzcoJnjMMjSgBWWJ2FllR67M6IGW
         5Kkk6qbqvI9ixUigSWolqn1NtPAthnmvLv48RaBhNb2WoNkpV5SR2x26REEGsfU84jdS
         J1kBDozujwIWA40or/4YvCYB0aL4S+QhjBT8yrQzIcDYlUJte/jUVC+dcpP3IPJnUyT0
         GcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752331842; x=1752936642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8ZD2wqQ2MFObmE2ter/MLsk6WNa+XkZK2/I8F8necI=;
        b=BiEspScLbzSv6CHUO2xxr6PUcTshgSBafk2m4whwiajyzeviD93dS/uncM1quQkjny
         /nvvpuDcjitLVyiVNnCESgLza0zBnfEmYWT2q7heL10LOJ7TF8ezPgIXZVHzeElPurEi
         u4XAcipT0f5DqChra9x1SS6SKQ8ELU6DJATtvEoWTF2Mlvk3hu/sufgzzlib71+96BxK
         6YjoSoY5i10VwXL00V61fteGKfDvnBogknxU8MSyaQ6uvLHXhHi6u8mlWZ33TvpWbSWc
         5ixbumlXv8nUMV65GmHYeDrSFjqHONw2AKVSq6rFrMRGdXewiKSZdWcH28KqIT7XnyFn
         04vw==
X-Gm-Message-State: AOJu0YyUyLKxOG9JFevEpUmHZgyET7aw/gPZgDpdrmcy8aH2GEX5q2cK
	W66ULr6y/15S8FaME8EQjROYa3728D3jWNDjG01WncSTOZpf0CYVmKWURH/AOi5k2g==
X-Gm-Gg: ASbGncvI9LaWYdqQeqWvd0KHYX2+fqoPj0HWmFgl6sry9jVU7H4G8EX9ABgfpLw/iMZ
	7OBrJrz3tvidMNfPIcHQuzAssNYvLjaLsifiB3dfqs+49GANH7hGm4SD7g1gcNaePftiPMLyoU1
	Y//xU0SeiN2MUKYkDfUIFdVqzuwnH9rxkBCNGdBu3cnEph5LIl0Kli5n/MX/oVKKLxe0+vP9XVb
	hBFyjg36757s1zCUZUVDfRlviTsC3GOPK0+MiYEX2vtnh2wlobDlpxl8jdRkhGnL48HJm7bIrcU
	XkAsz+sW288J2v8CJos5UDcuVzo34YZOe3x6pLkW5so8kmA36Rm6ZNl4YeJvD2zIf1vsLqVpO02
	/1no1CFYnwIKQcu29qK350+BxwKr+MMVCqQ24UuRprto=
X-Google-Smtp-Source: AGHT+IEFk/VaNJq8qgF/dcFDLR8oEl2KIKmlHFNzH3+OWYoQc5jcu9p9tZJ0S5e1TcPQ+Dqh4/rTPQ==
X-Received: by 2002:a17:903:64d:b0:233:d3e7:6fd6 with SMTP id d9443c01a7336-23de2fe4e88mr127828165ad.19.1752331842281;
        Sat, 12 Jul 2025 07:50:42 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c2:381b:47:222f:5788:dacb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4335306sm62856595ad.166.2025.07.12.07.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 07:50:41 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	pctammela@mojatatu.com
Subject: [PATCH net] selftests/tc-testing: Create test cases for adding qdiscs to invalid qdisc parents
Date: Sat, 12 Jul 2025 11:50:35 -0300
Message-ID: <20250712145035.705156-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in a previous commit [1], Lion's patch [2] revealed an ancient
bug in the qdisc API. Whenever a user tries to add a qdisc to an
invalid parent (not a class, root, or ingress qdisc), the qdisc API will
detect this after qdisc_create is called. Some qdiscs (like fq_codel, pie,
and sfq) call functions (on their init callback) which assume the parent is
valid, so qdisc_create itself may have caused a NULL pointer dereference in
such cases.

This commit creates 3 TDC tests that attempt to add fq_codel, pie and sfq
qdiscs to invalid parents

- Attempts to add an fq_codel qdisc to an hhf qdisc parent
- Attempts to add a pie qdisc to a drr qdisc parent
- Attempts to add an sfq qdisc to an inexistent hfsc classid (which would
  belong to a valid hfsc qdisc)

[1] https://lore.kernel.org/all/20250707210801.372995-1-victor@mojatatu.com/
[2] https://lore.kernel.org/netdev/d912cbd7-193b-4269-9857-525bee8bbb6a@gmail.com/

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 5c6851e8d311..b344570e7f40 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -672,5 +672,71 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY root handle 1: drr"
         ]
+    },
+    {
+        "id": "be28",
+        "name": "Try to add fq_codel qdisc as a child of an hhf qdisc",
+        "category": [
+            "qdisc",
+            "fq_codel",
+            "hhf"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY root handle a: hhf"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent a: handle b: fq_codel",
+        "expExitCode": "2",
+        "verifyCmd": "$TC -j qdisc ls dev $DUMMY handle b:",
+        "matchJSON": [],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root"
+        ]
+    },
+    {
+        "id": "fcb5",
+        "name": "Try to add pie qdisc as a child of a drr qdisc",
+        "category": [
+            "qdisc",
+            "pie",
+            "drr"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY root handle a: drr"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent a: handle b: pie",
+        "expExitCode": "2",
+        "verifyCmd": "$TC -j qdisc ls dev $DUMMY handle b:",
+        "matchJSON": [],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root"
+        ]
+    },
+    {
+        "id": "7801",
+        "name": "Try to add fq qdisc as a child of an inexistent hfsc class",
+        "category": [
+            "qdisc",
+            "sfq",
+            "hfsc"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY root handle a: hfsc"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent a:fff2 sfq limit 4",
+        "expExitCode": "2",
+        "verifyCmd": "$TC -j qdisc ls dev $DUMMY handle b:",
+        "matchJSON": [],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root"
+        ]
     }
 ]
-- 
2.34.1


