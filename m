Return-Path: <netdev+bounces-192814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77786AC131F
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 20:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C407F7B0714
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 18:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBD9157A67;
	Thu, 22 May 2025 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="RRvlHbOB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40341A4F12
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747937714; cv=none; b=ZuT/cXFWIHoNcUoFwtCNkyV1C4H6uQn8jye0hhsP2e+nY7mD/oVP8TxdlKh1GYTLaQwmc2bg6Pl98TNso58zC+AVo8xHqnxd9d6Br8TlMi+mx2RMFCOBwq/7XOOMFgpy3cXUd+SePsIJAd0IVDZc0Z7XQOdlC1IZDplHa4q7VEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747937714; c=relaxed/simple;
	bh=+wiHdMjuWSOsGPXWXel6vMxPKUm102FRRXgkozkfUWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+Bm0zYPM/ii9zlUHXaCBCgqUhMAfgw86LxJkI9sxbh++KeXVhYyYllmiGJ/b1L19s0+RZMSYzPPSIn78y3zA06LgLq5drjmXZ4cjfcEvfdAzsbOXhNlVnWV3EOuKW2ZG/z51H6y+eylpvCBEdsDj8xiTzkASrMmvAxMiE4oknA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=RRvlHbOB; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-86feb84877aso2013481241.3
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 11:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1747937711; x=1748542511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdVkoSK9a3kZJZpWboUpE3pkD4ba57U7CiLC/AWaO4w=;
        b=RRvlHbOB7EZ55VduWuWF3ZhQ37rUHqKMgWT6Cqi/FcgCCXTsHaEHnWCi+XG9z3i+Kl
         efin2S/EeHk17G+Eck2vhLUoVMaQCVWkVUo6nazV0Js+R4PfYfDnJeoQzeNtH8hVMZWp
         U7bRKX4Yr7bVOjCRQ6xe0QN+cvoPcDDacLI1o5BzvWNR5aeA+Qlla557FIuVRq9pgJ6n
         oKdh1jBUEiNMCLhM3LQ57uiJCc9vnGiKIdtmxxKK3sN62J9n7voj8ZS+T2GCFTVRnfVn
         WYpF192FUQmpUxEzNPuXnR1Q2jJVW7bKSQx96veKGGR/1t9NLAsV0fFlioXgsFs23dSN
         LIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747937711; x=1748542511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdVkoSK9a3kZJZpWboUpE3pkD4ba57U7CiLC/AWaO4w=;
        b=tabceTiWdUAXcyu9GrSjsVfH6YkheekmTcrR8PcWPB0FqgmuyOA+uz+yfR2wdIbUUF
         cMG8jtTKJfjGuA0bhipSjaeL2o4S3hCMGlm4MeP7+Bj5c3fnHxVL8YwVys2kZYOTy1fj
         +QEa7mMl/kHNvaMD0bD6aTEKUNJbDY6ZQqr7ENmjExLETgbVVsyQMlb1KGpknbvaOk6W
         Q4jC5pPUUwv9Z3dDaOU5pAfSQ9j6VbAa8MmW4em6HUgRA7JI/OuFhveUCbjnzx8tSnjA
         o1hPxMeePmqcst0OzjyN/EGVcqwV0byXamgPr0Q35fIavtCC16h6fq0vZejX6wlb03VS
         WK0g==
X-Gm-Message-State: AOJu0YxZgSO7uMNF9ZqXhwmGfGBijGZxcPNNlne/n0g2qTqa74GDckGA
	UGEWrSfLIIeK9WFBqKzAu1avPeBAp9uIOsEQg7wnnvrwgjIVUsr5J6sS9RjXkhtjiCdWZ05vsyk
	LZf1d2A==
X-Gm-Gg: ASbGncsDkq8HHe1IP4UNI6LF5s6xSKMktWSPr1xrgMkmMEnd5RDJAdvqtKAnXRHQuS0
	V81etB5bzHj6aamlg/eElw9gPPOdk/0i4yAZlLmQ8hr/hi3nm62LCtSCICS/uhTAw1aNeuMC35k
	2gvS1lYh7QEriZzKgy/LgnaBJIdlfzhudzK9PQh99LRnzSrbiBIHTl901M/Pq5+QIDd8hbk+aQE
	M3F6oZsSPkrniGUqdoLpEAxuo0zka8QRP4UUdWbVHIEmFv5m0Ci24c3mEq2J1nSOCi4eYSRKOJV
	rSMpvXBVs2SM4D8v61x1oyMpoGT7GjgWUDsG+FTeE61/26qcRRr94ejTHQDA1AAARyZYAb7A97Y
	=
X-Google-Smtp-Source: AGHT+IFSio2xg8ViCR/rnpR5UVkFv2SiU/8wOWYRFTT6xS8Q9ItlVopvaalwQX5DnU/OBQ2qhUcAdQ==
X-Received: by 2002:a05:6102:b0f:b0:4e2:a132:c50c with SMTP id ada2fe7eead31-4e2a132c627mr14706700137.2.1747937711342;
        Thu, 22 May 2025 11:15:11 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e125de337bsm10573695137.17.2025.05.22.11.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 11:15:11 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Pedro Tammela <pctammela@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v2 2/2] selftests/tc-testing: Add a test for HFSC eltree double add with reentrant enqueue behaviour on netem
Date: Thu, 22 May 2025 15:14:48 -0300
Message-ID: <20250522181448.1439717-3-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250522181448.1439717-1-pctammela@mojatatu.com>
References: <20250522181448.1439717-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reproduce the UAF scenario where netem is a child of HFSC and HFSC
is configured to use the eltree. In such case, this TDC test would
cause the HFSC class to be added to the eltree twice resulting
in a UAF.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index ddc97ecd8..9aa44d817 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -600,5 +600,40 @@
         "matchPattern": "qdisc hfsc",
         "matchCount": "1",
         "teardown": ["$TC qdisc del dev $DEV1 root handle 1: drr"]
+    },
+    {
+        "id": "309e",
+        "name": "Test HFSC eltree double add with reentrant enqueue behaviour on netem",
+        "category": [
+            "qdisc",
+            "hfsc"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: tbf rate 8bit burst 100b latency 1s",
+            "$TC qdisc add dev $DUMMY parent 1:0 handle 2:0 hfsc",
+            "ping -I $DUMMY -f -c10 -s48 -W0.001 10.10.11.1 || true",
+            "$TC class add dev $DUMMY parent 2:0 classid 2:1 hfsc rt m2 20Kbit",
+            "$TC qdisc add dev $DUMMY parent 2:1 handle 3:0 netem duplicate 100%",
+            "$TC class add dev $DUMMY parent 2:0 classid 2:2 hfsc rt m2 20Kbit",
+            "$TC filter add dev $DUMMY parent 2:0 protocol ip prio 1 u32 match ip dst 10.10.11.2/32 flowid 2:1",
+            "$TC filter add dev $DUMMY parent 2:0 protocol ip prio 2 u32 match ip dst 10.10.11.3/32 flowid 2:2",
+            "ping -c 1 10.10.11.2 -I$DUMMY > /dev/null || true",
+            "$TC filter del dev $DUMMY parent 2:0 protocol ip prio 1",
+            "$TC class del dev $DUMMY classid 2:1",
+            "ping -c 1 10.10.11.3 -I$DUMMY > /dev/null || true"
+        ],
+        "cmdUnderTest": "$TC class change dev $DUMMY parent 2:0 classid 2:2 hfsc sc m2 20Kbit",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j class ls dev $DUMMY classid 2:1",
+        "matchJSON": [],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1:0 root",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
+        ]
     }
 ]
-- 
2.43.0


