Return-Path: <netdev+bounces-246152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32931CE0196
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 20:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B01EF302BD18
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 19:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486CE32862C;
	Sat, 27 Dec 2025 19:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRDVc4sg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CFB32862A
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 19:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766864511; cv=none; b=V2c5ZzB3qsY4s5t8EYvTSdfY/kpfPECzsWR4KD1QUOqn7VrSWrswmQkY47jlpjd5hki3gUShN3aZzIC+Znsz8fWImcYaoPAnF8dfKRo/A0jpLDGcODAolKzKhE7ve6fgCl2Xg7O+GYN0JfivJrrJR35LL5CnmgyNXHE8vdyaOCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766864511; c=relaxed/simple;
	bh=Qwl85HvDxQe/a8kcnWvN0O2PXy6OlUXBrJZzAhjRaWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RSIWRFZQfwv/TpBsbNf2M6jQjgVZdo1xiSgVifJq8d0LJLaiXzOpQqlYH03w3NazssuOGMyve8aMzbP0RZotdCaEft09LQ74Y40aXIKA4veRbgwwNWTFsAdoawND+LHFiBfyaqbWT8LZnNYBTzlHQeisRBi9XPsG32Xr3ZGwg9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRDVc4sg; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso5264596a12.3
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 11:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766864508; x=1767469308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOSBqIwlOUTuQQ2oavZzevh4mS3YmYeB4Bu0irJ5cxg=;
        b=XRDVc4sg5FevfpgVNt8AcsSsKRX3TDfYAZ1SX7Ehh0hSe37ftvQ9n68dtWmuGEu9j0
         c6m+UwXVFo1w+s2mzWrRY5uwuiLPtaSk4NwqDmhKr0TEJyoD0D7gIHdf/h+fX2CpFq9n
         j8KrIEkdFa+mHDSsdStv84k6ODPNwW9payKVM/oDi4sKymPGyFGLQ86AjtPXoJHn8ySw
         A/kKGgSeQVFrQDv/X72YYIrOqYEoj7c3dENn1Lt7iSe15IkHVNZCBfMRxc5jZbvRwgsk
         3Yv809zum+rN3l917512N/aDfyt+yCQc6tcZ2QplsWKCQOodGreS0/OFAkKC3CaoBjux
         dDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766864508; x=1767469308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IOSBqIwlOUTuQQ2oavZzevh4mS3YmYeB4Bu0irJ5cxg=;
        b=ksl2R/kQZ+3clTOcpvJFmJ93h6xWJ9TBg3LHLdAk0gkuwH1B/VJMZpFH0AYSupJJI7
         3eKbnNbgVIGDub2ioV3mh6IAO27+vJL4kFmEHIOgK0lyp+IMIvtsOcc4AB7n3xxRkt+H
         PZo6H5Zv+pQmndx7NvxpFmcKdv5JlnsZSoo2BkrOPWMBdZMoV7eE9rrnBOusDHtdWgG1
         r7++UC06dnNz2ZtzMB1hbJ81hujNn3QDmgsiXX5skMRNid00TWTl/Z6m6ZxFBInUg7rf
         AtuYMZ2YarQCTI3s6Bck4eg6p6hmWPzsagUChXHwa8vjJDRdPfYB2kIar2SVd0tAD6tb
         CI2Q==
X-Gm-Message-State: AOJu0YwnuzURWhUo0WbluBJvgK1wTRJ8C63jEMa4Smj8NMrBK0GjLnoO
	VOe7Qr9wIqz9n3n/VpShq4iE9JIwCXTy0IbptTX79cUC8Zo33sV1FuIBl3/gFA==
X-Gm-Gg: AY/fxX5oMhQWnBlbTSeRKXDHIkQm3Hmaequ1EH13larHrtRR0iNo9q9PqwPA3GpZsAF
	P8SU24v2LzoPvyZSKbHD6RDGsRHjMf0WuEZHODTJ7jygD7lG/1BF2AVc1lUKqeXkEqrrRYisJH9
	RNQwU2nqO6gi0PFkESIiYZ3BK+Mu4bgG9lNvrtmmR7mRJFTIfDJBzjPKvjSa4elAPIC5HhyEHje
	xOoJvz2c/6RnYbHlUYCiSKl+IogC/kB14KxYh3HuVEinvWa3qyzZrG8lR2kx4T4rg+X/IbPR2Cy
	a8r6HSC7OQNsmIuMMMhbFZ8dXIH4Yv6DdA9EdTpwc9riXBCRAmKs0kwUd5tDqcBm9nYeejykuw6
	FzSxDEUYP72pj1eDqji5n8SLOTR9prAlQPriYQI/W/MEPi8P56cqyqp6iz1eyRzFNzf1Ax9GWpN
	rkC5nztAGIKE0PnFxH5DPcNW0BTFA=
X-Google-Smtp-Source: AGHT+IHAx5zuZmj+SObUnXEAjLiW1Shf6ltX2BSg9OT3NGlvga4zRkwUbfHD5xtlVxkuLx7Ft0I1kw==
X-Received: by 2002:a05:7301:1f01:b0:2ae:53a5:8ed4 with SMTP id 5a478bee46e88-2b05ec48132mr23238225eec.30.1766864508487;
        Sat, 27 Dec 2025 11:41:48 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:de11:3cdc:eebf:e8cf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe5653esm59087584eec.1.2025.12.27.11.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 11:41:47 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <cwang@multikernel.io>
Subject: [Patch net v6 3/8] Revert "selftests/tc-testing: Add tests for restrictions on netem duplication"
Date: Sat, 27 Dec 2025 11:41:30 -0800
Message-Id: <20251227194135.1111972-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251227194135.1111972-1-xiyou.wangcong@gmail.com>
References: <20251227194135.1111972-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cwang@multikernel.io>

This reverts commit ecdec65ec78d67d3ebd17edc88b88312054abe0d.

Signed-off-by: Cong Wang <cwang@multikernel.io>
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


