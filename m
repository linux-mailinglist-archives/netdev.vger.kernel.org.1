Return-Path: <netdev+bounces-208363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8AFB0B235
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 00:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF8AAA19B1
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 22:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2480238C25;
	Sat, 19 Jul 2025 22:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGsYAukT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAFE243374
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752962657; cv=none; b=VuwyR5qfQ2zeW/bgye/LTh35wCbc121Y8oTzkxaGqPQc9FMCB++3MJ8BQ7aMTxrvxEj+apbuSp16ao7GsHfYwBYmyK6EZ3gAJlc1jhRd7yBEGDwUTCM5gJbFR81GYUfsdVmW8VYTGUpeEob1iyTgyOPKmVLTCP8L/IvPX6pwWh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752962657; c=relaxed/simple;
	bh=23HdRBqmZA+W7zYLHnd5apmzKq36sD/8XoJv2Y9g/+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WlPyQa6WHlbenYf2HNGKMi3vkuhnIIGa4VvFutfc3qfLcRLzZrrZDkyFTFuRq8gVKE4dz+zmpUBcis2ooW5sorEW2nZLMlJ4AcDC7gVjKVKor2ImCBtC++cYAven7iozBAQgdWCHSC/1GIBwxhtrUNF9WpeQv9BmKzAPiYT0A20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGsYAukT; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso2366554a12.2
        for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 15:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752962655; x=1753567455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBtjXwFBCLiEuV1nHJDFr4l7TtlCPIsINxL2XblHuMw=;
        b=FGsYAukTxyM7l0u7vTxuMgQy2e/PN2NJpbeP4JIRvVH4c02FOI1wezIF7Fc7GJ6kaB
         uZLMHnsiOg2Gtda68Pux+jY/i+9ZFIIghoWeXoeyQHMZaHLpPZeYMSvjOP2hO/41Fsam
         /StVUkmanJKz16xNRn0OKmHsvw7mn8hQ1jpiZBe8+mWqVmDywIH6pfRSZJ1ijKPRVDCf
         fys33PW8a9gbSIQiDOmQ6jrocX2knYVtB2B5qr91ttQFrvvragXZU/8dBBd0SBa2IVzj
         CbmkwT+PNkx6jolgFuRklq40/KzN5db5VT9kOf9/R/CTpjc2FdgfxapYbhIL0bpPy1QJ
         Ut3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752962655; x=1753567455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBtjXwFBCLiEuV1nHJDFr4l7TtlCPIsINxL2XblHuMw=;
        b=UllWdArSUIFoZ8NEx/e2HXz7o4Wuf5J5eM40BCCeVIbL4R9RGTTXcPZyYkpMTSISnQ
         KC9TPzzenengzFgpmhCMdmxUrjBcoO1IlmgD7FevqGPC4QcUuqwMphy/Qh0WbIsKj4Hz
         UR7OWCyQ0VGmNc5UCTxKjVXfJqKgXPQdaOqaDil4HAjJUB19Kf34IRBg+vLOYcj5FhPt
         tuFXn4Qai9T631tnUFLxi6C+hK2qb8Ds4RPRwJfHuYNpy5KkQdgjP0OOe24El4wZtuUS
         tmGPt871JxpI8xVey+MhVfKuuSkSZPnTSsvDkykw/JI0K8GROSxeNxPScEG40Mklstan
         QLJw==
X-Gm-Message-State: AOJu0YzyyKIeiGXKNqG2tUyvLKFwnEBFzNsId7Z+TfGaJhqP+E1xg1oJ
	w1DRpQjha3lTxVp1kRTP8K9Fp9Vir9/18cnmGg+7xAQFcFoLuaMQ0/qgrKj+QA==
X-Gm-Gg: ASbGncumtC3GkcENaFSIQ4yMRKt9H2bMzOWbyQdFaPgWuxTYS4T5cbGESvHEdlN80aU
	jnv3XUV80J75skir6If1atFzifGsrsULP2t1e2oztCzqnz/MTmJiqLWT/VTWdBw/Jk8pVzpp+Rd
	c/mObH51actUjbWjNV6lWl5RI/tMAEqt3jUU9yslQ61NCeS1+yG9RjhqEU/reoL+SJ2Gi0Hhbx2
	yuufln49Zu3y7BCIRNhTXN3M90Vbr+sz2JPOAYQFz5l7x0fVOAo2angI5T0f51lgoFhQCAtXYLc
	sZ8guR2y8PjHAEc1jGuMnISeSFCdwVxZO8b9V0x6L1avdNJPL+x6tIi+QAYMHQQ8126aI+BItHI
	yAHW6bzUpqPzgwroc0IsbfJzXmGE=
X-Google-Smtp-Source: AGHT+IGv33mJwgHu9/CKtweJJRp05feE5w9PFeDIeGLvrQ6/EWFGLpAH9ILzZxAZyhxJFuKXUt34mw==
X-Received: by 2002:a17:90b:58ec:b0:311:c5d9:2c79 with SMTP id 98e67ed59e1d1-31c9f42e84dmr22202908a91.21.1752962655078;
        Sat, 19 Jul 2025 15:04:15 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:b3bf:9327:8494:eee4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe6a09bsm3084040a12.3.2025.07.19.15.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:04:14 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	will@willsroot.io,
	stephen@networkplumber.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch v4 net 4/6] selftests/tc-testing: Add a test case for piro with netem duplicate
Date: Sat, 19 Jul 2025 15:03:39 -0700
Message-Id: <20250719220341.1615951-5-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250719220341.1615951-1-xiyou.wangcong@gmail.com>
References: <20250719220341.1615951-1-xiyou.wangcong@gmail.com>
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
index c6db7fa94f55..605a478032d8 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -763,6 +763,35 @@
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
     }
 ]
-- 
2.34.1


