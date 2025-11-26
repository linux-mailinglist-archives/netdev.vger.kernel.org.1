Return-Path: <netdev+bounces-242036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015B0C8BBB7
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A993BC8F1
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A465344039;
	Wed, 26 Nov 2025 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJbYFolc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC84C343D88
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186787; cv=none; b=ayFchg7XKiDCD6sBXcnFtx1oDwzDVm5Lq9Pj1amCAGdAeWs8uW9SUIvGU0HWTwGVDxpiO2u8ngxIXyRdMcQ4G7Yssw/7RrHCvEikR3sShzjYv1Tpux2vfl1RkWbDoFtSYA9CEd6Ic4ZpvEuCQBSyUzwX7Lt6GNGYFUsyXAuUFdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186787; c=relaxed/simple;
	bh=DKEfb4vD3EsXRfYEAM3OsXRlKVzJPyfZcm+2gKk+MbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZBRDAP3hqj1qFSD88radujLwvbnkmR66h0gtR4FJMeem9Ir9v8GBY1JiH7r3eyPKrS//eOLv+TX6196U0yoKZcUzTk4LNjDZzre1xfxt1xSaQ27eIqx3sfDKuFffH1BP0GtYEr/YG7BQuobo7J7lT2BHe085WTCl7EotDEqfVJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJbYFolc; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3438231df5fso140373a91.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764186785; x=1764791585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTkVpjlqqmCc/sT5YtWT8X2vHDN8iPSPFtFz3Awz32E=;
        b=QJbYFolctc/lrww4ZKxzv+uhClvQFeL/Ov2XhN+ZI3WK/N3Z0qUU2k5hs78E2xWrZD
         SPw9zMPmNEdDDcv9PbalFtDIp/R/dk6WdngCOnppbrITX6cW5jwI0om+c2HqACCtFSTm
         d7tTWL42agQ75Qe4Sg/0Sub5ZF/CqGXURLnuk3cYJ6AHsSwVg2tGz7IS4Z5gm5uZku0U
         RQRw+dSytk4QrdLQPyvCSF2KtInF3FnQzTJRtnX6lBXrTscx+34+W8qRNjZ0F9mxhKem
         9mos2H1M/FRhpiKIOwfqx8h5iHQTUtxLME3tJaAW+OhuTdvszMji0E0iplDH/0mwLq+k
         +WeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186785; x=1764791585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bTkVpjlqqmCc/sT5YtWT8X2vHDN8iPSPFtFz3Awz32E=;
        b=CY53J6rMv1rc7At1zeHNbAwJNKeMW+84U8l0XyzKMUPEf1ECeXzY5ZzwfAeTNGr0HL
         uTlv5EZHlefbfgHhXy4Qo0hj+5nk5GEgegz31HsKn0wLEd84jyoYNYzfnAPzrtvM6Qb+
         S8Bq2zJiy5zCTBbF1AhcxCtj0PogYbF8KLb59/3oaKqjq1TsXhOF6j2kSsED8gGaPiK5
         bAAX512XgotX29O7o4nDchJXQff9A+ttUWwPFIIdk9u0I0MGNz2212cWSUP+PDvjfMbK
         3djZOufXvMwjnszj1QVNlvr/3ouf0n0ze4yScLLtC2bgNLwdt2fnWXV01SJvGcHdrepA
         x/sA==
X-Gm-Message-State: AOJu0YzbI0IlbHB0DS7Iox62HbDXi1voT/ndDJeVrTRxNgrZN95CHJTN
	BKvQhZLyksc07flDOovmod3u71aNdLS/r4YTH8m6ZMU/rv1PBs9S0fawCopnXW6D
X-Gm-Gg: ASbGnct7TyxR55zpa++IQJmDWXMGMDy68t5lGze0nXfQAesxgdlZRz00pmMwZYfKxgJ
	EFXBRbO2yvTmyKChSz1IimBodigv5Pd2lLyFS8A6CGP1WdY5pvHLXoUYGS4zBxMoTmseetDATli
	1il38cMdJ7mJvCWDgD8d3n2BdUnWfhheyJnh0piOO/hHC49pi4ydtfhnCc4KX5R7LfxxKQUMrK8
	fWmzyu1SGTVtfGH0Nn8N4FtDwZhzHRqxIfonMqZCpb7IJvayT0MitAeCz9pxvNJDA9iuw+vbZFk
	ewZyEK1XrQNw4iIu8ZkJsabN6JjCuua3EuKUiWCv3ypaC5lIRTN0Va3umwm86WvpVoCh7RydJOV
	izBXYq8ptD2oLmh+3vW8OsFvDfjAwPZBUNeZRpS5GKCk+/wfosla3KVWpMBMJyBltOnCAX9DQPP
	RDyiBtNK+/h6gxiG7lsN4l0Q==
X-Google-Smtp-Source: AGHT+IH1unVa6HWF0AZX1EQmtln9wrmf7L3Zcd7dXuioaixPWPoTWeNJs1Fi7/1FeTXrBBU677TMkg==
X-Received: by 2002:a05:7022:41a3:b0:119:e56b:c755 with SMTP id a92af1059eb24-11cb6835c7bmr6390160c88.26.1764186784635;
        Wed, 26 Nov 2025 11:53:04 -0800 (PST)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93db4a23sm101508235c88.2.2025.11.26.11.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 11:53:03 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	kuba@kernel.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net v5 7/9] selftests/tc-testing: Add a test case for piro with netem duplicate
Date: Wed, 26 Nov 2025 11:52:42 -0800
Message-Id: <20251126195244.88124-8-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
References: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Integrate the test case from Jamal into tc-testing:

Test 94a7: Test PRIO with NETEM duplication

All test results:

1..1
ok 1 94a7 - Test PRIO with NETEM duplication

Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index b5f367fcc150..1f342173e8fe 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -961,6 +961,35 @@
         "matchJSON": [],
         "teardown": [
             "$TC qdisc del dev $DUMMY root"
+	]
+    },
+    {
+        "id": "94a7",
+        "name": "Test PRIO with NETEM duplication",
+        "category": [
+            "qdisc",
+            "prio",
+            "netem"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin"
+            ]
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: prio bands 3 priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0",
+            "$TC filter add dev $DUMMY parent 1:0 protocol ip matchall classid 1:1",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 10: netem limit 4 duplicate 100%"
+        ],
+        "cmdUnderTest": "ping -c1 -W0.01 -I $DUMMY 10.10.11.11",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY | grep -A 5 'qdisc netem' | grep -E 'Sent [0-9]+ bytes [0-9]+ pkt'",
+        "matchPattern": "Sent \\d+ bytes (\\d+) pkt",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root handle 1: prio"
         ]
     },
     {
-- 
2.34.1


