Return-Path: <netdev+bounces-144350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A679C6C51
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60B31F2148B
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 10:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753FE1FAC48;
	Wed, 13 Nov 2024 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYvVN+2r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FA11FB88B
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492275; cv=none; b=IIdNpi7b6PJcuM/pl/eaOi0Vg8vobJcyfPGoiBrebQIbEKfHU0R/IvmV8z92E7NEv3zzrY8uMgTe3undNhG7D60Z2YW76m+8GJY6ozSiEG+hwrlzUofzi3VXENJYRwoa1iK+MJbAupGeJ7ugqzVbQ7Ut5aHKE/yfbF8nt9ujV+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492275; c=relaxed/simple;
	bh=jj5qzFWgjRkTAFAG7zo2M1elbxj4e/tSqHZzY7envdU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CFi84Hj7aMevzV3w0iy7Ru+2y28t4qq/alXP5aEWANEhFJxEPzjjU07mU8JhGOZ8XlfCWcluM98yI4txdqfH69ygk5zHCE7zqGL7y6iYW75iBCbt89KQ/SLJ/pvYW80KeUrJbji99vqgyPQx9X6HuYIMlCR/6nsjreKQF90PLV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYvVN+2r; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99e3b3a411so102469866b.0
        for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 02:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731492272; x=1732097072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9bhfdSqWHg0gTVu9nXnXjpZqPaGK+R11n4sItQEEJN4=;
        b=VYvVN+2ry+joS4JVIo8c3dkGUycte7PgCeYPNbStX4OjbpCLQYyBHMBFdpQTwMSz1k
         ZXUPJCjuC6tZxK1xlmwwjUg8PM9hEJvUipxw090g/FYHGvI37jiSL4ije5jOYzHpygtf
         5q+VxhXB6arP62Z1hmMb262zli6T1Gwzrt9kcHRKMHFkcUZ8uHevX2ucvxDonuVS/DT3
         0AZOE0zTUJSNtSlzPPD4/T2h6X0SjOBDUZI1NUJakf9tpIuugyjMbZmQZGvYTqhgjYLV
         lrwWgP4QrOV9zH+86hewj0Cbr4nDerb0vYpindFAlHKHw59h7/V8r/qsF99UYpRDJBVx
         RvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731492272; x=1732097072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bhfdSqWHg0gTVu9nXnXjpZqPaGK+R11n4sItQEEJN4=;
        b=Qka0PoTU2ltYyfl8fH4oRI4WR7iEQDGKusfNQFeD6bhfOpUio2c6gWBNW1RAmPSBDg
         Ax342DaYPLXREUZMBO2e6pLaYBqhTojVdPb+1Ok6koVCw4BRAZXruXEV+MBUYY0stRi3
         yVAlQ2f5i7cTtZrzRXBvs/bPAKbP8LZeZ0L4ceF76OdKP3QiaiVus6pc6lfrErBNYfOA
         crxyymVBEGt36275QeoJc58pdA1uijaZHo2r9UmB92LWRAdMuICo95y2ha1eRXesdx+e
         Adfe9m+DGsrjJy8aqSnYFop5jOy5ulEN64sGQWb4qYu/MRsVI1jSUU10MfKRP5oDgduL
         ICSw==
X-Forwarded-Encrypted: i=1; AJvYcCUdb/09BCJsWxK/GILYfPaahVzhIuhsuDfuRUvw/01Phq5pFKcGDTNoW5w0RrzC6GwUL6FN32s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz73kbFH9/eefLIUmKxlkUoVbLmNCjuZNNZSA7wJVYKbzK2lqSH
	7ZnM2dDIAC726HfM+K9Eas/ZvJWYpiqfl58k0GRDBS9+aAsW3krn
X-Google-Smtp-Source: AGHT+IFNuWVa0n3GJQ0QS7twii4O6tVw4xKc8ZluxZaNYxyJi2sJ2dns5+DXxWttrBSp1fz8cLyWuw==
X-Received: by 2002:a17:907:5cd:b0:a9a:6c41:50c0 with SMTP id a640c23a62f3a-a9eeff982a2mr2003105966b.26.1731492271565;
        Wed, 13 Nov 2024 02:04:31 -0800 (PST)
Received: from getafix.rd.francetelecom.fr ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee06b9d62sm836291466b.0.2024.11.13.02.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 02:04:31 -0800 (PST)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
To: edumazet@google.com
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	horms@kernel.org,
	alexandre.ferrieux@orange.com,
	netdev@vger.kernel.org
Subject: [PATCH net] net: sched: u32: Add test case for systematic hnode IDR leaks
Date: Wed, 13 Nov 2024 11:04:28 +0100
Message-Id: <20241113100428.360460-1-alexandre.ferrieux@orange.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a tdc test case to exercise the just-fixed systematic leak of
IDR entries in u32 hnode disposal. Given the IDR in question is
confined to the range [1..0x7FF], it is sufficient to create/delete
the same filter 2048 times to fill it up and get a nonzero exit
status from "tc filter add".

Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
---
 .../tc-testing/tc-tests/filters/u32.json      | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
index 24bd0c2a3014..b2ca9d4e991b 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
@@ -329,5 +329,29 @@
         "teardown": [
             "$TC qdisc del dev $DEV1 parent root drr"
         ]
+    },
+    {
+        "id": "1234",
+        "name": "Exercise IDR leaks by creating/deleting a filter many (2048) times",
+        "category": [
+            "filter",
+            "u32"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 parent root handle 10: drr",
+            "$TC filter add dev $DEV1 parent 10:0 protocol ip prio 2 u32 match ip src 0.0.0.2/32 action drop",
+            "$TC filter add dev $DEV1 parent 10:0 protocol ip prio 3 u32 match ip src 0.0.0.3/32 action drop"
+        ],
+        "cmdUnderTest": "bash -c 'for i in {1..2048} ;do echo filter delete dev $DEV1 pref 3;echo filter add dev $DEV1 parent 10:0 protocol ip prio 3 u32 match ip src 0.0.0.3/32 action drop;done | $TC -b -'",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter show dev $DEV1",
+        "matchPattern": "protocol ip pref 3 u32",
+        "matchCount": "3",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 parent root drr"
+        ]
     }
 ]
-- 
2.30.2


