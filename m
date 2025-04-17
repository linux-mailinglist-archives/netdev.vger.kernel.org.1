Return-Path: <netdev+bounces-183882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC029A92A37
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 20:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3196216EE8E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 18:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D283C2571B4;
	Thu, 17 Apr 2025 18:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoyzE2qz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450E71DB148
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 18:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915664; cv=none; b=m0wSjfIqABpR0wHYA6nhVq35izjdJGVBLQ4uG28OXhvbuXlso87wBHDCGtZDBRsC9cCUVv1VHiSDTD7J/zAb7nfYbu/ZgZwiZPTP0A1LMwGdU4gU+Y4j+EYFfPzeRE3W1P5znNvOPQC3Tx7RW2EEpYkHMuA2iy9izbn3XDLwAjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915664; c=relaxed/simple;
	bh=1IA9eohIA6Ya8UoPDbwVlRnIAOx95aSMP/t7FAxBlaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fHXBfCYqOzIvZdfqciOBnQ9RS9nP66SqtlZ0DY6K8KbCQog1bM4Ub21mFwjb0URmZr/0IEfIzVzgi/yFIN6gaCspGku5F+XozopAaKoLNYM9srZLZTrHe6lnpujU0IFc+r7vD3psPx2fTT5exZSQo1rO/HoceVCr7pZxbiLL5Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoyzE2qz; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-736b98acaadso1260691b3a.1
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 11:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744915662; x=1745520462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLfCrU3P4ywVVTFegvbgCIb9e1Z2mXWUitvPanSjEp0=;
        b=UoyzE2qzkAT/Up+aHrDyivLVi+Y1xXSlwhFSmN28mUBy106ah1paUULnv81IuJ/QNL
         5DdoiESrpWargR1GlSUCO0KBi9XQ2om9u7f7+5v3C4r0X80hXPSrj1XNeDAqvHFgQnvz
         qK4T4BPn2RTLsD5jZUGg7UVxbZp6kbNQ/mg+b2VbxNgsH/JCg/ZLA8Fiu3ilxXLQZT0T
         X+P4gsFuNMFoFb8PQFSyMBRKwXL3n7nsCp1LOPJaNRsoOjLJjV0YJ8ky81hOrbvZKo/5
         JPbvZogkwxmZ12i3TiZXhUmtmSPKkq9dlg/uwf0UsDPfUdzQiPjwWkgIhYKliaUhh7pR
         Ru9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744915662; x=1745520462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLfCrU3P4ywVVTFegvbgCIb9e1Z2mXWUitvPanSjEp0=;
        b=iNugyNIyfmd+25zZnOG7Q/dZB3UVXDnrHRZWO54+LkN/cmniffOD74XDZYOomAn+kl
         wnAG5rc6bvxjEMLagxErgDmPp5CA6dpP6BxVoLkHKGGfzC5vvjLumL9XNzdkP8QeMioI
         eEFGM7u2iodHnZjs6USg55o500gSFrv7y74CQaqYIQxlGINjqUMWRQYxlcDuIVmHYNn5
         gCWo0+zpoFN+SCXbU2DHLj8wgKN7VPLBlcWqTXvEwzdKWBJMuHV7LvTHNQUfxioDshp0
         hYCIDTHeokjVPM0Q/1Hrty+dqC3HbAFoyEnBDtxQ1r/0sX2A/GWjlqiPq6ULG8bneJec
         /CLg==
X-Gm-Message-State: AOJu0YyTJLWMCfShvDghsI4HuIuvZc3i9p6hTG9mml+grM1t7Qk15GO5
	daI9zAx2OexQoFi7gSEVQAu5PW/RSnYxQvOKw2X55qgX9LtlKucdSlKNx+55
X-Gm-Gg: ASbGncvdU3+YcwERI65JKOGSYa3arhZJMVvV136VxBHoNsfFc+yia5/eZU8w1oUnCEO
	0LPon48yvcNbmOafyaGyhhEsyL31X1OX0YbTZWoHtHtM+6l41f/tZY004eUybey1g/9XgFc14Wu
	bJzZeDqezcvWm0VhsQiPa1C088rKreSL9p8GaRRqNVGS9HzPBsaRIVuzWV7MNxIYqBVJgxN0JXj
	rsxSqtYdoLIcd1arQwJE0sbRUgByM7stDeqizbv4goDdfZeCWSflLKntqJbCJzxEKmkcoiJXbGR
	EPpRasPnJCe7Zwc/7QC6YDP1HsbbISGph03ieuLKQVQSHeWX2sc=
X-Google-Smtp-Source: AGHT+IGhbu+vDKjSJTGdQN1c1bIxkIpmtoalTHruw5qVWBDruq3bZzA8DTVsdhkOI4dLKfod6AfypA==
X-Received: by 2002:aa7:9a84:0:b0:736:46b4:beef with SMTP id d2e1a72fcca58-73c266b9c4amr11149328b3a.3.1744915662086;
        Thu, 17 Apr 2025 11:47:42 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaad645sm187773b3a.150.2025.04.17.11.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 11:47:41 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	gerrard.tai@starlabs.sg,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [Patch net v2 3/3] selftests/tc-testing: Add test for HFSC queue emptying during peek operation
Date: Thu, 17 Apr 2025 11:47:32 -0700
Message-Id: <20250417184732.943057-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417184732.943057-1-xiyou.wangcong@gmail.com>
References: <20250417184732.943057-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest to exercise the condition where qdisc implementations
like netem or codel might empty the queue during a peek operation.
This tests the defensive code path in HFSC that checks the queue length
again after peeking to handle this case.

Based on the reproducer from Gerrard, improved by Jamal.

Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Cc: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index d4ea9cd845a3..e26bbc169783 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -313,5 +313,44 @@
             "$TC qdisc del dev $DUMMY handle 1: root",
             "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
         ]
+    },
+    {
+        "id": "a4c3",
+        "name": "Test HFSC with netem/blackhole - queue emptying during peek operation",
+        "category": [
+            "qdisc",
+            "hfsc",
+            "netem",
+            "blackhole"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY handle 1:0 root drr",
+            "$TC class add dev $DUMMY parent 1:0 classid 1:1 drr",
+            "$TC class add dev $DUMMY parent 1:0 classid 1:2 drr",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 2:0 plug limit 1024",
+            "$TC qdisc add dev $DUMMY parent 1:2 handle 3:0 hfsc default 1",
+            "$TC class add dev $DUMMY parent 3:0 classid 3:1 hfsc rt m1 5Mbit d 10ms m2 10Mbit",
+            "$TC qdisc add dev $DUMMY parent 3:1 handle 4:0 netem delay 1ms",
+            "$TC qdisc add dev $DUMMY parent 4:1 handle 5:0 blackhole",
+            "ping -c 3 -W 0.01 -i 0.001 -s 1 10.10.10.10 -I $DUMMY > /dev/null 2>&1 || true",
+            "$TC class change dev $DUMMY parent 3:0 classid 3:1 hfsc sc m1 5Mbit d 10ms m2 10Mbit",
+            "$TC class del dev $DUMMY parent 3:0 classid 3:1",
+            "$TC class add dev $DUMMY parent 3:0 classid 3:1 hfsc rt m1 5Mbit d 10ms m2 10Mbit",
+            "ping -c 3 -W 0.01 -i 0.001 -s 1 10.10.10.10 -I $DUMMY > /dev/null 2>&1 || true"
+        ],
+        "cmdUnderTest": "$TC class change dev $DUMMY parent 3:0 classid 3:1 hfsc sc m1 5Mbit d 10ms m2 10Mbit",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
+        "matchPattern": "qdisc hfsc 3:.*parent 1:2.*default 1",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1:0 root",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
+        ]
     }
 ]
-- 
2.34.1


