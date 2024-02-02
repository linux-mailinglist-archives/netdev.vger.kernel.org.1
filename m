Return-Path: <netdev+bounces-68268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 349118465A2
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 03:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5681C217EC
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 02:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4836AAB;
	Fri,  2 Feb 2024 02:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Ab2NncDN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB67B67C
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 02:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706839667; cv=none; b=kDWOas2UMMKZqlJo/Ya5BvOXnkKA6J/U1e1pp1yBLeZUnRFJU94seQDIrniLvqUqGcDIJ1hr2sPi1NCdYwXXGRZVh1mxUGJqzqIcRsmOJjDcrKPpiYmCe97h302HzKzKB9GbCaST8t0rFZyxokIk4VjihX7SfJN8V5YynJLQ9uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706839667; c=relaxed/simple;
	bh=hEz10lfWeKbzbqehHpw1NYF9alhMYNGRZ4sAYik+l4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UsZcdGvNW3PwQxoov6U4gIMpOdbnz+nwWv/Zt+zVTlLIKjnWmRflJfaL0zTWiy7S3ZWbHYa8qXm2H+AzL53haNe90lSNK4xaIzyXRgPFtlkzhAC/Lp5CL4DlZ5zhRW7AqbXLMDC+IcMyHZZyDAy/Aic2T8zD6SrELrFGeU9vTlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Ab2NncDN; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d780a392fdso13684365ad.3
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 18:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706839664; x=1707444464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PxiFKl6taBsIGrO9TTbZUygHy8dPKLBS1ElW7zjOSa0=;
        b=Ab2NncDNN/SVZT9ube3AfKX1/kvSDwdnx3dYUIehgOshtjUI5W+Mbpw7s3mGr7V0VC
         VqM1Z9NoN7zAXfJcsoW2CMCs6oFbDKUe4rJR27KYFSwEE+WJd1dzyYbwpZYZv5s+8GJP
         tYKT/7q/u6uEvjug76TjZyjSI9SwptnilAIm0Aatun6nyjgGHIcmzspiMlvRJaRpQcZv
         HqNbseavyTAu4lVuTwHCCr599CX7pUWwB1GQUG/1LWIF1efsEaozlnQW9pDsgGWp0pph
         YwtTQAsmuDBe+/kgYYi0OOp9hM4aTfXZGyZW+74WF+/aGRQLoRumPOm8ggVr5QgqQpZ4
         2GYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706839664; x=1707444464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxiFKl6taBsIGrO9TTbZUygHy8dPKLBS1ElW7zjOSa0=;
        b=u79o6+dqReSAqHVnob3NRpPYv3mmOjKgpt1iRd7Uia51LlAc0TKsZzvQH1z6ucFs93
         tFT1zAQMk+yO97v47DnFUsPZ5TSnT1x1/G5aRPfoxvJXcMWT9o4jQD2aB7b49/P2Y47K
         d4UzOPGnQDoEmMUp5e1Y7XC2fPUzxZeAH99SRreCo2MBsnOp2UvrsAN5NxSgCWINTRuV
         m3y4bObGPAt/w596Rov2PYhKukTMnMVczw5hRiB4aVLpcHqbsi+ZnWgSykoUar7dn+Q2
         3YIQ6kNewkjOj/1MUuR7TE4T+lyYQ3u90hvZ3Iz7E4QNMBVM4OBSyC9plAHTFxUgpPd0
         xJRQ==
X-Gm-Message-State: AOJu0YwpRcwyhyJzyNeecBt7ofeZTkZEqdrn8+sLSdMY+ryZ3o8kUun5
	isNaIrEkhQxk/OoHLJwwTa6Er9jcXnXSR7vYjZXmQ3j+2LQNcPIGq4oPbzOuOA==
X-Google-Smtp-Source: AGHT+IEIS2BycnI6QDfnmu+I9A3B4NFttZklLUx4ZMEh/nbc5BGYEDvS/8Xbr/+uGgoDBBl6fMC9gg==
X-Received: by 2002:a17:902:a981:b0:1d7:310e:1e0d with SMTP id bh1-20020a170902a98100b001d7310e1e0dmr3808079plb.32.1706839664113;
        Thu, 01 Feb 2024 18:07:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUm1IhpQcGWpGU4fkiddZpTqlKOuqvTGaHRuPvBZ4+B3ynOhQdeY7fZJeM8qdT8+5CDohHd4ruoki4KtRC1MecaU73UEp5nuGVrKG2hM9H3HUTiFparrEMavRUkHrNkVyMpd3MT5QLAxfA1ch21Jfa94aIUYIkKeSrztRlBikgcmZlTfZvTpfH2op7VS3SdHEPgq5x0s4WtBDnVM3V8CDzNb8czKNq2twgbR7zxg9MVqx77SUQ+IEPleePAfTiSssRguW40Hi4=
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c1:815f:8b02:176b:bed6:69ec])
        by smtp.gmail.com with ESMTPSA id kc12-20020a17090333cc00b001d94a245f3fsm495688plb.16.2024.02.01.18.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 18:07:43 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: kernel@mojatatu.com,
	pctammela@mojatatu.com
Subject: [PATCH net-next] selftests: tc-testing: add mirred to block tdc tests
Date: Thu,  1 Feb 2024 23:07:26 -0300
Message-ID: <20240202020726.529170-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 8 new mirred tdc tests that target mirred to block:

- Add mirred mirror to egress block action
- Add mirred mirror to ingress block action
- Add mirred redirect to egress block action
- Add mirred redirect to ingress block action
- Try to add mirred action with both dev and block
- Try to add mirred action without specifying neither dev nor block
- Replace mirred redirect to dev action with redirect to block
- Replace mirred redirect to block action with mirror to dev

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-testing/tc-tests/actions/mirred.json   | 396 ++++++++++++++++++
 1 file changed, 396 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
index b53d12909962..795cf1ce8af0 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
@@ -649,5 +649,401 @@
         "teardown": [
             "$TC actions flush action mirred"
         ]
+    },
+    {
+        "id": "456d",
+        "name": "Add mirred mirror to egress block action",
+        "category": [
+            "actions",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            [
+                "$TC actions flush action mirred",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC qdisc add dev $DEV1 egress_block 21 clsact",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC actions add action mirred egress mirror index 1 blockid 21",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "mirror",
+                        "direction": "egress",
+                        "to_blockid": 21,
+                        "control_action": {
+                            "type": "pipe"
+                        },
+                        "index": 1,
+                        "ref": 1,
+                        "bind": 0,
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 egress_block 21 clsact",
+            "$TC actions flush action mirred"
+        ]
+    },
+    {
+        "id": "2358",
+        "name": "Add mirred mirror to ingress block action",
+        "category": [
+            "actions",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            [
+                "$TC actions flush action mirred",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC qdisc add dev $DEV1 ingress_block 21 clsact",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC actions add action mirred ingress mirror index 1 blockid 21",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "mirror",
+                        "direction": "ingress",
+                        "to_blockid": 21,
+                        "control_action": {
+                            "type": "pipe"
+                        },
+                        "index": 1,
+                        "ref": 1,
+                        "bind": 0,
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress_block 21 clsact",
+            "$TC actions flush action mirred"
+        ]
+    },
+    {
+        "id": "fdb1",
+        "name": "Add mirred redirect to egress block action",
+        "category": [
+            "actions",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            [
+                "$TC actions flush action mirred",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC qdisc add dev $DEV1 ingress_block 21 clsact",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC actions add action mirred egress redirect index 1 blockid 21",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "egress",
+                        "to_blockid": 21,
+                        "control_action": {
+                            "type": "stolen"
+                        },
+                        "index": 1,
+                        "ref": 1,
+                        "bind": 0,
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress_block 21 clsact",
+            "$TC actions flush action mirred"
+        ]
+    },
+    {
+        "id": "20cc",
+        "name": "Add mirred redirect to ingress block action",
+        "category": [
+            "actions",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            [
+                "$TC actions flush action mirred",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC qdisc add dev $DEV1 ingress_block 21 clsact",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC actions add action mirred ingress redirect index 1 blockid 21",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "to_blockid": 21,
+                        "control_action": {
+                            "type": "stolen"
+                        },
+                        "index": 1,
+                        "ref": 1,
+                        "bind": 0,
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress_block 21 clsact",
+            "$TC actions flush action mirred"
+        ]
+    },
+    {
+        "id": "e739",
+        "name": "Try to add mirred action with both dev and block",
+        "category": [
+            "actions",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            [
+                "$TC actions flush action mirred",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC qdisc add dev $DEV1 ingress_block 21 clsact",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC actions add action mirred ingress redirect index 1 blockid 21 dev $DEV1",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j actions list action mirred",
+        "matchJSON": [],
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress_block 21 clsact",
+            "$TC actions flush action mirred"
+        ]
+    },
+    {
+        "id": "2f47",
+        "name": "Try to add mirred action without specifying neither dev nor block",
+        "category": [
+            "actions",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            [
+                "$TC actions flush action mirred",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC qdisc add dev $DEV1 ingress_block 21 clsact",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC actions add action mirred ingress redirect index 1",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j actions list action mirred",
+        "matchJSON": [],
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress_block 21 clsact",
+            "$TC actions flush action mirred"
+        ]
+    },
+    {
+        "id": "3188",
+        "name": "Replace mirred redirect to dev action with redirect to block",
+        "category": [
+            "actions",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            [
+                "$TC actions flush action mirred",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC qdisc add dev $DEV1 ingress_block 21 clsact",
+                0
+            ],
+            [
+                "$TC actions add action mirred ingress redirect index 1 dev $DEV1",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC actions replace action mirred egress redirect index 1 blockid 21",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "egress",
+                        "to_blockid": 21,
+                        "control_action": {
+                            "type": "stolen"
+                        },
+                        "index": 1,
+                        "ref": 1,
+                        "bind": 0,
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress_block 21 clsact",
+            "$TC actions flush action mirred"
+        ]
+    },
+    {
+        "id": "83cc",
+        "name": "Replace mirred redirect to block action with mirror to dev",
+        "category": [
+            "actions",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            [
+                "$TC actions flush action mirred",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC qdisc add dev $DEV1 ingress_block 21 clsact",
+                0
+            ],
+            [
+                "$TC actions add action mirred egress redirect index 1 blockid 21",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC actions replace action mirred ingress mirror index 1 dev lo",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "mirror",
+                        "direction": "ingress",
+                        "to_dev": "lo",
+                        "control_action": {
+                            "type": "pipe"
+                        },
+                        "index": 1,
+                        "ref": 1,
+                        "bind": 0,
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress_block 21 clsact",
+            "$TC actions flush action mirred"
+        ]
     }
 ]
-- 
2.25.1


