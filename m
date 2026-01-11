Return-Path: <netdev+bounces-248832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64934D0F75B
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 17:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7CAE304DD8D
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 16:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA8834CFD8;
	Sun, 11 Jan 2026 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="rWSTekkk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C612234CFB3
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768149614; cv=none; b=AkeZvGkSz9nIdIHAmccpUItIZoPsCrvroYk+ccsXmlr1xG2ZTyoHO3+aFmbZ5pTpVIPSFrjCuB35rVlDCXf6S3rjvpWyKjQQmJgq1RpL/1po4DWwtZtl7Z1mE6mAYlK4CY8yvMaGuvO/9FhUZ/nkqB0/nIZlXAHssHBhbvTDshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768149614; c=relaxed/simple;
	bh=qx55ooV+6T11EKr8LbEY4/9pXwPSeq3Qn7aMejeFIXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VZt6QCAT4X+JTtUQYk8DX0tE2/3kqy8mWXUCI7KZr3Gt62JP1PmpDRYIK63IzyfifMW3O6f2VjMxz9yHFFFJ8QQ6COOV0fFxMmzTl1mnHoeM+39Pv8sbJmAsj1P9l+IplBT3HJPTlP5eTxLeHpPO2aGo72xHTs3s/mryG0DOZo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=rWSTekkk; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b220ddc189so781838185a.0
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 08:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1768149612; x=1768754412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBtIV/EG4mn9wrmEQoCttsPhqLjU58BaxF1sqnJtk6U=;
        b=rWSTekkkwErRWnd0R/TglB2dusn0PwCitMmiW3c2CDNK/6bCDzhzdY5xzeYeFvdCOe
         xofMPQX4k+QSgS3C1+G9E/SialECEUn3LHxXCx+/51UirO3GKwmxVqlRKd6fllDLoLzy
         EB2XrUZ7LFY4ELzELY0f+D3JAcwyyWet7IuJV4XeRTQH3H9xNDHkBz5XyHVHuUOG8Ez9
         nc5fgnPUvB8sT3Eol0n0zhwv7D/nED352fXrovc1ZcLXlWtJsV1YEtJvxoBOv+JfcVQ+
         826IcW1vPEuJ0qD9zzO3PdppDVy+/mc4rCfdR82TZ1VGA/cBsLHCgd5tSGwuzBjNaU6D
         ajSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768149612; x=1768754412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NBtIV/EG4mn9wrmEQoCttsPhqLjU58BaxF1sqnJtk6U=;
        b=lhEwBAkL7c/l07BStyEqKIRjxaETPXe7/fe+s8gHOmXOa2CCmYFIo4DjpguoOGAV/a
         3VZKEG6iCcIqs3jDe20+2XWtlZrmuLnMDfTh+DhIZhfRhjAwM48kS8Lv99jnlyngOTAx
         P6qEA2ILDPp/HqGqAzFblvvabktrbxqbCdmWpcUIe5Seck6K2R3LNS4RhvNuk25fiFnw
         XArwxkFwTozErKFaG28VMox2NcEJq3LN7D9Qwb2hAslQJMPWuwk5G8a51jKICNV9kVGQ
         UWxOFJjeEoazRITbtSx39YIpjyAYXbw3oUHz6JGSKjDhzkJbA/M0pozvH/4DR2ec7zoc
         Qycg==
X-Gm-Message-State: AOJu0YwCvE/NwAJ+VBWcYS6xx+2xqYM86sAYnD1vcXk/n7hj9RytGhMn
	y1XhWUN8f8NmWr0UWm3CKB6wYLM/TJoaRmp7y+S9SpGD+g3O7gG8w/9BlnJwmmmDXg==
X-Gm-Gg: AY/fxX5wRt6l3pUQqp/8BUrsTFHSv2kKZ64k+qnYf2ASbW6wabdjoObdDjHIUumQnCt
	FFmBmcVXX1XrAGrPICF9yG1jQVDZTZZCRIAiDEYxQJpHAD9u2NtAs7hk25m1QBC2ZBvbmIberSc
	qQEjOg1aTHpvzR3MV1wyQKrk+hSUov3xSsEUH4Fc6I+SFtEJImdgdoT5wv7o/YNdC60Fn9E8P4d
	2BUn6zxjAYJ+gPzMMPJ9NsGO8WZOf7uqVd9fX9qks+l65jqpk9pTrV3mpVgCb0ck1C9f5q50CIh
	2c3NQrCVFSv2kEU6IPsXKRYgF+PEta+0giAQx/V7sWDQEABOh89qDv/6F/+Bb6vDVwECLINDHGb
	Fq9e5hxEetUfQJuGFh2K4DBDMtH7PsB3hIYgZPN/IHvdzHiWKpZWrkslCSoIVN7fubwvEU9LZLz
	52+Hiuxb101Kg=
X-Google-Smtp-Source: AGHT+IGDqNb3NahWywwQdRkRuPYhE2RD+hcRC/vcvexYRUTidf/458a8FA7EixcA0lJQ59K4ToJUmA==
X-Received: by 2002:a05:620a:2807:b0:8b5:5a03:36e3 with SMTP id af79cd13be357-8c38936c4e7mr2312246785a.16.1768149611741;
        Sun, 11 Jan 2026 08:40:11 -0800 (PST)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a8956sm1276589085a.10.2026.01.11.08.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 08:40:11 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	dcaratti@redhat.com,
	lariel@nvidia.com,
	daniel@iogearbox.net,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	zyc199902@zohomail.cn,
	lrGerlinde@mailfence.com,
	jschung2@proton.me,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 4/6] Revert "selftests/tc-testing: Add tests for restrictions on netem duplication"
Date: Sun, 11 Jan 2026 11:39:45 -0500
Message-Id: <20260111163947.811248-5-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260111163947.811248-1-jhs@mojatatu.com>
References: <20260111163947.811248-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit ecdec65ec78d67d3ebd17edc88b88312054abe0d.

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     |  5 +-
 .../tc-testing/tc-tests/qdiscs/netem.json     | 81 -------------------
 2 files changed, 3 insertions(+), 83 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 6a39640aa2a8..ceb993ed04b2 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -702,6 +702,7 @@
             "$TC qdisc add dev $DUMMY parent 1:1 handle 2:0 netem duplicate 100%",
             "$TC filter add dev $DUMMY parent 1:0 protocol ip prio 1 u32 match ip dst 10.10.10.1/32 flowid 1:1",
             "$TC class add dev $DUMMY parent 1:0 classid 1:2 hfsc ls m2 10Mbit",
+            "$TC qdisc add dev $DUMMY parent 1:2 handle 3:0 netem duplicate 100%",
             "$TC filter add dev $DUMMY parent 1:0 protocol ip prio 2 u32 match ip dst 10.10.10.2/32 flowid 1:2",
             "ping -c 1 10.10.10.1 -I$DUMMY > /dev/null || true",
             "$TC filter del dev $DUMMY parent 1:0 protocol ip prio 1",
@@ -714,8 +715,8 @@
             {
                 "kind": "hfsc",
                 "handle": "1:",
-                "bytes": 294,
-                "packets": 3
+                "bytes": 392,
+                "packets": 4
             }
         ],
         "matchCount": "1",
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
index 718d2df2aafa..3c4444961488 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
@@ -336,86 +336,5 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
-    },
-    {
-        "id": "d34d",
-        "name": "NETEM test qdisc duplication restriction in qdisc tree in netem_change root",
-        "category": ["qdisc", "netem"],
-        "plugins": {
-            "requires": "nsPlugin"
-        },
-        "setup": [
-            "$TC qdisc add dev $DUMMY root handle 1: netem limit 1",
-            "$TC qdisc add dev $DUMMY parent 1: handle 2: netem limit 1"
-        ],
-        "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 1: netem duplicate 50%",
-        "expExitCode": "2",
-        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
-        "matchPattern": "qdisc netem",
-        "matchCount": "2",
-        "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1:0 root"
-        ]
-    },
-    {
-        "id": "b33f",
-        "name": "NETEM test qdisc duplication restriction in qdisc tree in netem_change non-root",
-        "category": ["qdisc", "netem"],
-        "plugins": {
-            "requires": "nsPlugin"
-        },
-        "setup": [
-            "$TC qdisc add dev $DUMMY root handle 1: netem limit 1",
-            "$TC qdisc add dev $DUMMY parent 1: handle 2: netem limit 1"
-        ],
-        "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 2: netem duplicate 50%",
-        "expExitCode": "2",
-        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
-        "matchPattern": "qdisc netem",
-        "matchCount": "2",
-        "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1:0 root"
-        ]
-    },
-    {
-        "id": "cafe",
-        "name": "NETEM test qdisc duplication restriction in qdisc tree",
-        "category": ["qdisc", "netem"],
-        "plugins": {
-            "requires": "nsPlugin"
-        },
-        "setup": [
-            "$TC qdisc add dev $DUMMY root handle 1: netem limit 1 duplicate 100%"
-        ],
-        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1: handle 2: netem duplicate 100%",
-        "expExitCode": "2",
-        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
-        "matchPattern": "qdisc netem",
-        "matchCount": "1",
-        "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1:0 root"
-        ]
-    },
-    {
-        "id": "1337",
-        "name": "NETEM test qdisc duplication restriction in qdisc tree across branches",
-        "category": ["qdisc", "netem"],
-        "plugins": {
-            "requires": "nsPlugin"
-        },
-        "setup": [
-            "$TC qdisc add dev $DUMMY parent root handle 1:0 hfsc",
-            "$TC class add dev $DUMMY parent 1:0 classid 1:1 hfsc rt m2 10Mbit",
-            "$TC qdisc add dev $DUMMY parent 1:1 handle 2:0 netem",
-            "$TC class add dev $DUMMY parent 1:0 classid 1:2 hfsc rt m2 10Mbit"
-        ],
-        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1:2 handle 3:0 netem duplicate 100%",
-        "expExitCode": "2",
-        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
-        "matchPattern": "qdisc netem",
-        "matchCount": "1",
-        "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1:0 root"
-        ]
     }
 ]
-- 
2.34.1


