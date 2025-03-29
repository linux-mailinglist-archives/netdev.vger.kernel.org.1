Return-Path: <netdev+bounces-178215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E0CA75800
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 23:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A053AC32F
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 22:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082361DFDA5;
	Sat, 29 Mar 2025 22:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHTD3pJ8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BB21DF749
	for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 22:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743287254; cv=none; b=ucFlw1M4WOvMwPggBXq7ANpotu0PGrQ2o6qWelxGNWBcdn1SL6eHR6mDLnJ5E4ZVikGuGiSYfiE6TLBHleieIIt/mmehQwJwaB/l5CfqGQuNZUF2YbUGHahgA5AUahSLwN81xVWzXDShKfxB9ywVvfO5hSjJE9fi7AEdsrP95G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743287254; c=relaxed/simple;
	bh=kj5u05uCcsYXw0YJP/2+1VQAoS3iA0L4dP2ClFL6DK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fvuBCikYdd/4zCHkpqblMVyowYMm7BtS3NYbtqRDb3IKJGZK+FdkkTFBXFcIf1MTaAg7lkJuZlozgavkjiJWrok8P28IOMJt7OV1ktFOguAnLS0YC8hV5JIgycddnbM6KCVNkRbqPfKhHHKTwSShyRoJzsA9s88guxedV3RDtWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHTD3pJ8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22435603572so65133215ad.1
        for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 15:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743287252; x=1743892052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zhw8hMgI/UqeVQjAmaCdXFaYtCBnsMtHTLV+dzQQHU=;
        b=iHTD3pJ85Qv/Bw2l9EAABxGmuQH9oevCPRKxIqKjxEado5J4PI57hhzJWg9Zko01Er
         hkya75399pq/e75S6S8l/cztMRnzqBJ/KSQ+Cu4r6PxMyqAb6jOXuhfduvid1va0TODk
         KPlC+U0Kr/s+pKBR0TbdVUmudV0In04d9TSwfVjTpGpMEZZpy6+fttz/FBynMGGXlym/
         lMrQWAxyzF3WUITBQxRqroBYxBdnH2nwr2DJ9T+akKdkfcKFloaJt+q/L+EMDXEIkfjs
         kf85JyNr5A3ePPxXZ1OWOp5Le54+ZEhZuV4QPlS9UAb91HnP9Wa+6vTvilqSyo3vAw69
         YYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743287252; x=1743892052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zhw8hMgI/UqeVQjAmaCdXFaYtCBnsMtHTLV+dzQQHU=;
        b=B0SK3tqAmc1738YpZhA6FQvJsEXC8AyhQG1UEV/cZEYIEGM+tcT1KLfIdPpHXnzgUj
         38s5Vf66cDEl8EMH4ZHXUMLSeLUG4HDlZGwNROWARHxAs3B/lZl9MMMa8P4TZ0w0ZN4T
         9EjOwhZG/1AiJxZ2gLfH+c+9LF7hqCNS1Pt2tj+RVwk2E7PdGsb8ode+124Byqxwb9AD
         UvmRtQxYupSJhtOkUji9dDhF1KLXBFR0ri1PeiYIxBW6BpOt/wKFdVsAkCkoMNXkqGrR
         lK8T6+1+iW47xA6hUk1jCcqUjYeqT3M1PWHFnjN6vhzh3bJCWSVXV4X79nvmAfUWwhRW
         1xfQ==
X-Gm-Message-State: AOJu0Yxvmfw87EmTA3gXY7JNvWrzinjap3702eUuqOyw5IEF//Wg8zdw
	BqXG5GpZkYCfnX3cN8MnKbPjRDQrYyHXAGuTr+3hA053/AulgxrpJ8wiTw==
X-Gm-Gg: ASbGncvfYZkl4G4XWRXdaB3G30tVihoCrRhCPY/9y0El8EE6UqKRsNbLI+Q3Ta1NF+o
	iUg0ukkIh+4lIn9/5ZN7I69iTllgmzdxfRUexzsNCeUnaeHAi4C3F49PBVaDfv8GuX3MkACcb+0
	UIZhS2tnz/mp+vzxmrd4NXxXoEVzbJVc9n/R2Zev60I+QOW0dnofKDsvYTjqtXbdrBfYsmccmUh
	GZm4g0XOwjQ+znhYjgjQX3yUJYQouAQ3v/ymDrEEXN6khIraas3ilAnQOZcX3v4kghERsX59DG/
	1kRvrkeXc2rmjirZDw+giHeruBurWa9pNyuik+uqenK0YXE17Q==
X-Google-Smtp-Source: AGHT+IGhha73ydeVPq1USX7VGAiKjUCwCrtC026VpZdArqxpZnO6LwKJTC/tiDtk1BwTRzlRU6TBMQ==
X-Received: by 2002:a17:902:f709:b0:223:3b76:4e22 with SMTP id d9443c01a7336-2292f949db4mr53626085ad.6.1743287252417;
        Sat, 29 Mar 2025 15:27:32 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:c022:127e:b74a:2420])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1ecbc9sm41477335ad.215.2025.03.29.15.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 15:27:31 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [Patch net 2/2] selftests: tc-testing: Add TBF with SKBPRIO queue length corner case test
Date: Sat, 29 Mar 2025 15:25:36 -0700
Message-Id: <20250329222536.696204-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250329222536.696204-1-xiyou.wangcong@gmail.com>
References: <20250329222536.696204-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case to validate the interaction between TBF and SKBPRIO queueing
disciplines, specifically targeting queue length accounting corner cases.

This test complements the fix for the queue length accounting issue in the
SKBPRIO qdisc. This is still best-effort, as timing and manipulating enqueue
and dequeue from user-space is very hard.

Cc: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 9044ac054167..25454fd95537 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -126,5 +126,37 @@
             "$TC qdisc del dev $DUMMY root handle 1: drr",
             "$IP addr del 10.10.10.10/24 dev $DUMMY"
         ]
-   }
+    },
+    {
+        "id": "c024",
+        "name": "Test TBF with SKBPRIO - catch qlen corner cases",
+        "category": [
+            "qdisc",
+            "tbf",
+            "skbprio"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY handle 1: root tbf rate 100bit burst 2000 limit 1000",
+            "$TC qdisc add dev $DUMMY parent 1: handle 10: skbprio limit 1",
+            "ping -c 1 -W 0.1 -Q 0x00 -s 1400 -I $DUMMY 10.10.10.1 > /dev/null || true",
+            "ping -c 1 -W 0.1 -Q 0x1c -s 1400 -I $DUMMY 10.10.10.1 > /dev/null || true",
+            "ping -c 1 -W 0.1 -Q 0x00 -s 1400 -I $DUMMY 10.10.10.1 > /dev/null || true",
+            "ping -c 1 -W 0.1 -Q 0x1c -s 1400 -I $DUMMY 10.10.10.1 > /dev/null || true",
+            "sleep 0.5"
+        ],
+        "cmdUnderTest": "$TC -s qdisc show dev $DUMMY",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY | grep -A 5 'qdisc skbprio'",
+        "matchPattern": "dropped [1-9][0-9]*",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
+        ]
+    }
 ]
-- 
2.34.1


