Return-Path: <netdev+bounces-186162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC4FA9D51B
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 00:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278CA468681
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C14922CBD5;
	Fri, 25 Apr 2025 22:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="0AMBiujb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C122AE41
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 22:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745618857; cv=none; b=T8z6M5FPBvyUUyob09/w0J0eeSPr7nXjS+agJn5HvE2T6dASL731v+4h1k9uRyISwQ0j9xIgCpwlM0wrNd82c1HAl2873USa2gLgjvAhc3p7iXkPJtxbLaT7yvz9xJhJdiBzTIXms3YQNhbN1H9LrDLH92i7LNQLcUeZtaCDdV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745618857; c=relaxed/simple;
	bh=4UjinqqUtFPXkuKScOA4do8yg9JYBOF4ZUdBOChyKkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8ZCI0QBmFG7p4i0av1qlvde4eylwnCoq+2xCKkLhOarFeopVxtknPqynP1cWFqL+MQatttZMDODBERYfVdTOdg2vpyvYU72phs+zxbr+Facr16Pe5OaezZpWIvqincQBk6KZw4YI44oOipHBrDY1+sOEbXteg0EK/ySkJHCodQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=0AMBiujb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-225df540edcso40669635ad.0
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 15:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1745618855; x=1746223655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hxFlYm1JAqmY1eYNIRMvf2Bg/6n19Pgqqe+7dND2sU=;
        b=0AMBiujbYnZqThGVDe/viRZhu8hRz64AWQtoKiXyBRndsxIfbkM2/oLFbwlu8t72aR
         fNucd7ymuOzZDvKDVQaeqC5dfpPbMpSppd2UpXYfHLAMi+mWaMf3AHeu/jL9CNtgHfHH
         fHaid6jzSd/65KSB+imIC3Sab+jFvDH1hoaEc8W6VRVaS0Y0+Z9f8fFKHznOg4LD5Ftk
         8x586TdLPvqmCfYXynr9oypNXCBdLnWRRVSVo6NR7JfUwD6+3YfrTLKUNmorhsrzIt1w
         SxHLeayotbIka0DJMOkjryRMocTMB2ohvQJW+oFNMF/uVtho0Kn72bPOgTjfiP+fSXff
         2AXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745618855; x=1746223655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hxFlYm1JAqmY1eYNIRMvf2Bg/6n19Pgqqe+7dND2sU=;
        b=xLzDsbrd/Wv3mEIJqcZqz7+ey1rPUPxKrs1sFJDas0MA0oR2dCTHLRcre7l0tHAQMY
         JtiswGovmvjWJ1Idj/x/7LOy1qBVQdpOLIEwV9IXdezYkschULiyWb9OhzB2yqcAj9Wt
         7PIrBRG2AJ8U3YFuJ+2dDQhpprrip0z41qXHSsp6LVj7tPFnw9HQ8D+rf1qYFcrP0vCZ
         OxXOeXuMNophgf8q0Z+Z0qWAboUFrG+X8rIlggKi7/qs/9BY3DcsCSEA1U89y1XATyXa
         OQLvyvchL4W5WuwNxxd1ESYKucNQ3H2ZB8O2RXarDeYjTCFQWsJ7N8CPL1+Y5TxzlQr/
         yU1Q==
X-Gm-Message-State: AOJu0Yw63rZQ7U7BJYyOcuMyVITY3sUAEB6gbwPj62SLx/LPJTfDMwdq
	wFmEnrFL1Khec98+CaAGLCqnOykRFgEOEN+o+Nf69newKIsAlRARTtyRvRQErTluY+zQF0mXeyQ
	=
X-Gm-Gg: ASbGnctmZvFvt423hqguC0DdgKRcY3SPkziP80PVFl1fKk0kpVRVGxkEHYHxImR4b07
	v6uuOokwHRdPXH78o3OUdLjjhUQIC7nmlfYSWFhEal8isSeKHZTbaeUaz0egEj0qNSIuq+feocJ
	NE+2oL0IfpWC2K8bVMWo61FTlQhXfKD5nP2nqC5TtL8gM9XFpQPSQwQT+4WCLr3W/kc6mI6GGcM
	U7lcQLi0O0t5xCAiPYQIaYoAA1+oedSg+noNEFAPTv0BrexNQrubuNukzOYul/jRc4IwF886tl3
	tjsEod1e6/WFPZ5edA11KLH6tsOUbpUOuMN43vOeHtSQj2NZNW9zRw==
X-Google-Smtp-Source: AGHT+IHiWDWXBG34bKcTslX/qNxbJv96oEI7aCa4a2qkvAMA1M93BLvyN6w0yEp+V4xLqkASxgCi6g==
X-Received: by 2002:a17:902:cec7:b0:215:58be:334e with SMTP id d9443c01a7336-22dbf8edc73mr47543915ad.10.1745618854606;
        Fri, 25 Apr 2025 15:07:34 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c0:73b:9a6c:c614:cc79:b1ba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dc3b7bsm37753185ad.100.2025.04.25.15.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 15:07:34 -0700 (PDT)
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
	pctammela@mojatatu.com,
	stephen@networkplumber.org
Subject: [PATCH net v3 5/5] selftests: tc-testing: Add TDC tests that exercise reentrant enqueue behaviour
Date: Fri, 25 Apr 2025 19:07:09 -0300
Message-ID: <20250425220710.3964791-6-victor@mojatatu.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425220710.3964791-1-victor@mojatatu.com>
References: <20250425220710.3964791-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 5 TDC tests that exercise the reentrant enqueue behaviour in drr,
ets, qfq, and hfsc:

- Test DRR's enqueue reentrant behaviour with netem (which caused a
  double list add)
- Test ETS's enqueue reentrant behaviour with netem (which caused a double
  list add)
- Test QFQ's enqueue reentrant behaviour with netem (which caused a double
  list add)
- Test HFSC's enqueue reentrant behaviour with netem (which caused a UAF)
- Test nested DRR's enqueue reentrant behaviour with netem (which caused a
  double list add)

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 186 ++++++++++++++++++
 1 file changed, 186 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index e26bbc169783..0843f6d37e9c 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -352,5 +352,191 @@
             "$TC qdisc del dev $DUMMY handle 1:0 root",
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
+    },
+    {
+        "id": "7c3b",
+        "name": "Test nested DRR's enqueue reentrant behaviour with netem",
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
+            "$TC class add dev $DUMMY parent 1:0 classid 1:1 drr",
+            "$TC filter add dev $DUMMY parent 1:0 protocol ip prio 1 u32 match ip protocol 1 0xff flowid 1:1",
+            "$TC qdisc add dev $DUMMY handle 2:0 parent 1:1 drr",
+            "$TC class add dev $DUMMY classid 2:1 parent 2:0 drr",
+            "$TC filter add dev $DUMMY parent 2:0 protocol ip prio 1 u32 match ip protocol 1 0xff flowid 2:1",
+            "$TC qdisc add dev $DUMMY parent 2:1 handle 3:0 netem duplicate 100%"
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
     }
 ]
-- 
2.34.1


