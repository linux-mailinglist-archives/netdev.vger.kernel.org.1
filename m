Return-Path: <netdev+bounces-183227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D59A8B6C0
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E4C1905411
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9572472A9;
	Wed, 16 Apr 2025 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="sv1LjMX/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34732472A1
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744799094; cv=none; b=sgIY/RW0R4SnReYfQfKQII+QbZ99Z0qh9I47XqDMg/cBw2vm6HCMBk/B0gmeivyqNaIEffXoq4wtlw9YUkD3yjuxR7Inu6+7L9wsJkqoFwD4qiZm7ZkTz/miPffWugQvRTkZ/jL8Q9xwdaS/7B9Fw/bySwmgX7Txg7f5AohzS4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744799094; c=relaxed/simple;
	bh=+E36J11eo3q6nOWYLSCgnd/3onYAefZEA8u2Zt3r9WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmdqloytmePTyrBwDLZI3XdXO0ghSCQzVg2qWt+ASvgMuwnPWRzRc3U/YXmz6aA6qvyC89QTSkjXgwdDx4L0xdzehiQooveyE3mczb6pBP1Rqqm7XCce6P5XQmwlqzX3e7v41vRXdP45s0qUOerVylw4TrkLT2ON85+HHmh2qJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=sv1LjMX/; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af519c159a8so5961440a12.3
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 03:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744799092; x=1745403892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBmG+4jsKsOG1r3HYrYow15mhAZz6EQ6mqCjmaGPe1E=;
        b=sv1LjMX/ESUJQfd6Arzw9JAS57rIJ0SykZow6udozrxl8qw4Y/CdtjBuQHVRJyia6K
         33F6xMUygKZVd6pXgeWY1PkbVYwQKiP6+M9bWnexwLB9++7SGhADQkXXRxOpSUA/qeoq
         ZxyGnj/xwb+WNnNn5HkDOfRy5NNfXb5wz5qBXOve1DLbX+/WbHooK2kbVHASDlFlAl98
         yz/Wrkt3pHrh1TJpPbzE5ghcTAfkZElmQrAsHRs+vhDvFjGZ0YppnH+V5/yMUqiN9sel
         LCpWMGSLcmzFhRF1lzbHPqBwwhfjc70suHx1SQowmjQlP+IbGJKKlvThU0qAdCeFZqkb
         RJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744799092; x=1745403892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBmG+4jsKsOG1r3HYrYow15mhAZz6EQ6mqCjmaGPe1E=;
        b=CQHy4bQ8v9+4Vu9l90YBQoLEWcpiRGF2eyY651UBnVpQHgA65XhZm7sZATy7DgDwit
         6fkxYt3onBceFkJsw8PJ+5He+wG5MovssFsFNsIsVoeNUiHBB5GlAyVPWyFJjnOv1gob
         2zO83wrgebmTUpXCgbt3xlOidoiFHWD4m1wBpnXwor21NSxmF+X/qTwHiSx51I4P9gAf
         swOMDF9n0WBiit0ajLqEWyrAslgIdufVwnpAtme9L/IsyGr67u9zXUhwZ+bLmbdIMPCg
         whP6rZUMB9tvX8k6Xb6WzQlYMYbVZ1FCcGDi62CfAik5D2v8OZhwFJgOntJrieT2IZv/
         O1/Q==
X-Gm-Message-State: AOJu0Yzv8I6EI39UaeWVElIqfr7Wsz5cfIK/w3pS/bPEoHCaq7XZBLA+
	I4I6s9bOnzkuNbGkQ8mT/mb+JXZSk+c7Q9nUJPoupSIg32RqsTQC08EO/64QW35mF+xGLeQ8OGM
	=
X-Gm-Gg: ASbGncuNT88Y9i1/pE3jbw4rvC0TdNsXGl2SlXgvDaX8huav/B6+QAfTaZwgpebrQMC
	rCJhVB4ADiKciQC9Rf//tedSPztErHEFx1Iil4GEGAqSPMQKPlBtjHqWa/HYLdiBZWKLiXUJNO1
	M/bKLPXBgpL6I2RDt7u+om82iOPoESPHAHupFLUT/uRztQoMWK6BUId5/B4NVy1+dJqb4yRaaAd
	hhWuAAF34BxY+nXeHpQi6klSMRDSWiMT2HUmN0so5jUKYpJ6KKH0saTWjjy3HGmRdVjeYIj8Vf2
	5H9W8jVekKY6XNpuTZ7Hyxdmulx582RxKnX1a0icxuOM7ueARv0jUSHOHM1zF2x4LO6CR4ZOHc0
	=
X-Google-Smtp-Source: AGHT+IEZ3WA0x98eqhIsrs5xZIKwLa1sX6oiu+Ixvu90olV+1WuU3rYUsRDINX0aqKfSBN7iy//0yw==
X-Received: by 2002:a17:90a:e70b:b0:2fc:3264:3657 with SMTP id 98e67ed59e1d1-30863c54ae3mr2387793a91.0.1744799091679;
        Wed, 16 Apr 2025 03:24:51 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c3:dc7b:da12:1e53:d800:3508])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308613cb765sm1193075a91.43.2025.04.16.03.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 03:24:51 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	gerrard.tai@starlabs.sg,
	pctammela@mojatatu.com
Subject: [PATCH net v2 5/5] selftests: tc-testing: Add TDC tests that exercise reentrant enqueue behaviour
Date: Wed, 16 Apr 2025 07:24:27 -0300
Message-ID: <20250416102427.3219655-6-victor@mojatatu.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416102427.3219655-1-victor@mojatatu.com>
References: <20250416102427.3219655-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 4 TDC tests that exercise the reentrant enqueue behaviour in drr,
ets, qfq, and hfsc:

- Test DRR's enqueue reentrant behaviour with netem (which caused a
  double list add)
- Test ETS's enqueue reentrant behaviour with netem (which caused a double
  list add)
- Test QFQ's enqueue reentrant behaviour with netem (which caused a double
  list add)
- Test HFSC's enqueue reentrant behaviour with netem (which caused a UAF)

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 148 ++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index d4ea9cd845a3..19037059e9e4 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -313,5 +313,153 @@
             "$TC qdisc del dev $DUMMY handle 1: root",
             "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
         ]
+    },
+    {
+        "id": "90ec",
+        "name": "Test DRR's enqueue reentrant behaviour with netem",
+        "category": [
+            "qdisc",
+            "drr"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY handle 1:0 root drr",
+            "$TC class replace dev $DUMMY parent 1:0 classid 1:1 drr",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 2:0 netem duplicate 100%",
+            "$TC filter add dev $DUMMY parent 1:0 protocol ip prio 1 u32 match ip protocol 1 0xff flowid 1:1"
+        ],
+        "cmdUnderTest": "ping -c 1 -I $DUMMY 10.10.10.1 > /dev/null || true",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s qdisc ls dev $DUMMY handle 1:0",
+        "matchJSON": [
+            {
+                "kind": "drr",
+                "handle": "1:",
+                "bytes": 196,
+                "packets": 2
+            }
+        ],
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1:0 root",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
+        ]
+    },
+    {
+        "id": "1f1f",
+        "name": "Test ETS's enqueue reentrant behaviour with netem",
+        "category": [
+            "qdisc",
+            "ets"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY handle 1:0 root ets bands 2",
+            "$TC class replace dev $DUMMY parent 1:0 classid 1:1 ets quantum 1500",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 2:0 netem duplicate 100%",
+            "$TC filter add dev $DUMMY parent 1:0 protocol ip prio 1 u32 match ip protocol 1 0xff flowid 1:1"
+        ],
+        "cmdUnderTest": "ping -c 1 -I $DUMMY 10.10.10.1 > /dev/null || true",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s class show dev $DUMMY",
+        "matchJSON": [
+            {
+                "class": "ets",
+                "handle": "1:1",
+                "stats": {
+                    "bytes": 196,
+                    "packets": 2
+                }
+            }
+        ],
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1:0 root",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
+        ]
+    },
+    {
+        "id": "5e6d",
+        "name": "Test QFQ's enqueue reentrant behaviour with netem",
+        "category": [
+            "qdisc",
+            "qfq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY handle 1:0 root qfq",
+            "$TC class replace dev $DUMMY parent 1:0 classid 1:1 qfq weight 100 maxpkt 1500",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 2:0 netem duplicate 100%",
+            "$TC filter add dev $DUMMY parent 1:0 protocol ip prio 1 u32 match ip protocol 1 0xff flowid 1:1"
+        ],
+        "cmdUnderTest": "ping -c 1 -I $DUMMY 10.10.10.1 > /dev/null || true",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s qdisc ls dev $DUMMY handle 1:0",
+        "matchJSON": [
+            {
+                "kind": "qfq",
+                "handle": "1:",
+                "bytes": 196,
+                "packets": 2
+            }
+        ],
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1:0 root",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
+        ]
+    },
+    {
+        "id": "bf1d",
+        "name": "Test HFSC's enqueue reentrant behaviour with netem",
+        "category": [
+            "qdisc",
+            "hfsc"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY handle 1:0 root hfsc",
+            "$TC class add dev $DUMMY parent 1:0 classid 1:1 hfsc ls m2 10Mbit",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 2:0 netem duplicate 100%",
+            "$TC filter add dev $DUMMY parent 1:0 protocol ip prio 1 u32 match ip dst 10.10.10.1/32 flowid 1:1",
+            "$TC class add dev $DUMMY parent 1:0 classid 1:2 hfsc ls m2 10Mbit",
+            "$TC qdisc add dev $DUMMY parent 1:2 handle 3:0 netem duplicate 100%",
+            "$TC filter add dev $DUMMY parent 1:0 protocol ip prio 2 u32 match ip dst 10.10.10.2/32 flowid 1:2",
+            "ping -c 1 10.10.10.1 -I$DUMMY > /dev/null || true",
+            "$TC filter del dev $DUMMY parent 1:0 protocol ip prio 1",
+            "$TC class del dev $DUMMY classid 1:1"
+        ],
+        "cmdUnderTest": "ping -c 1 10.10.10.2 -I$DUMMY > /dev/null || true",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s qdisc ls dev $DUMMY handle 1:0",
+        "matchJSON": [
+            {
+                "kind": "hfsc",
+                "handle": "1:",
+                "bytes": 392,
+                "packets": 4
+            }
+        ],
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1:0 root",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
+        ]
     }
 ]
-- 
2.34.1


