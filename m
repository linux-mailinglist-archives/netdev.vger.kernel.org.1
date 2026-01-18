Return-Path: <netdev+bounces-250810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64369D392FE
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 07:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 992603028F56
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 06:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6AF1F4CBB;
	Sun, 18 Jan 2026 06:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcS5mYEF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA7F213254
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768716965; cv=none; b=lHx8vO7EgAaA5+ri6LS/bwNWnUWnFwzWAiqWzZLx54EbCFazLulsrQmGLlozmPWdq8NYbGDRFH6h3lahRQ1M9grXk/nIr7RV0EyQsb8KJWWb/x0V+o9zni7uEm8iC711wpTMqI8ZfxnIC5WAZej+iiRz80og+x4wPFv2/48n4DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768716965; c=relaxed/simple;
	bh=Qwl85HvDxQe/a8kcnWvN0O2PXy6OlUXBrJZzAhjRaWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gqi0YaAYupBfiZvaA2tFVKRmUGpkxKtXyOgjJXL2gMocSwR+c/6cx+ofs007mI5Lc12z5Gn0s8RLXehg9SdbV10irJ/BOBEPiaOc4udIsi+UbGKXEMBS3pX3QlbjJiOCsjIOg9e3ajhHUYRBHyv1kVcqShiz0beEP3QmKfnFv5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcS5mYEF; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b6ae4c2012so2432778eec.0
        for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 22:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768716962; x=1769321762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOSBqIwlOUTuQQ2oavZzevh4mS3YmYeB4Bu0irJ5cxg=;
        b=CcS5mYEFRVZy4QU/2NeFRIK7rJIcv0hRHMUCf4ee/nLE1j0err8UWOhDVMds/TgBFV
         l9s+JyfZmRXSHfF5KBEOFwjy/tl89gJXztvluld78QqHLDYYvYg8GeRGL+WCTCFAesHs
         DNk4paaA0SXp0gsZc+3cq+n84kn+90A8CSdp7+H2NNG/s6g1MhsBGW140QM/Ooe7hpQy
         WEfF3BuT+vLyAJOvsIupQfkDal0WduCzKgz42zTgRsKdRQAe0pECphHO8l8YTqyG0dln
         Kc7k9NVe/mfwhUagM3wPpw/RETnj2vjygC4SK/VYPDMleed8sWhs3AhsnmFVqbMJdzCK
         szxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768716962; x=1769321762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IOSBqIwlOUTuQQ2oavZzevh4mS3YmYeB4Bu0irJ5cxg=;
        b=LVIzqWx92iT/1Uk1pCP55VLFpb3SxOztnS1r0IQ70R3CBjpHVlQUggaL79uXPyk94f
         mt9yQQ7GXX/OSQUm3Vb4oMlcFUNmYTj5TgrHYZB2bIUtFh4lwKnqFYozEWWPoyAKBOiu
         +YSl2/B5CekDNQTrXUuf0IqxYME9IvJ9VGi7XUBxLA+vbXUNHshQHmERNSg1yYu74i2M
         vUAUhy8bV0UER6yjDCQ8SkEFlXf0DTBKCbtbmmLqhzv8CJ65hQw2heomNAZBwAukpGhi
         xGgveR38jeI48OJ9rigxay099MhKsGbQUUUJ69OcdIZhBtqEqVI0JoS0bsZnl+5RjQWY
         qTcg==
X-Gm-Message-State: AOJu0Yz+K42g9cYb0FA8pPedREWjWCPIzxixJDKnhh1selYbGXPAWqG3
	UlTKZuy+CpOlnkXaDIffZWjDGxAHPRPZBfC4XmewuK3/nfh5i10fRolfGPV72w==
X-Gm-Gg: AY/fxX7yF7ahRx2oiCfUFKlIvMoM0u1t4vzMUV+SFHhM+fEMkYGIClloZCgxWioYzzc
	QmURDTjSOvIOblrYvH9ikiTOybEj1y1MyXfNUNZ1UNWsrcPE+9VTH4pnKe5Ic021h8WZpsILemA
	Hd8D7LHQdBfeiIbEJAegrw4r364aY2J7XFN8jqStglE5hshQxfBEI5rx0Hn42wHaBC+Zn358eGk
	PFCiLjEfglpUr+l35pSzyUhCsXgYCvCMlQjTanLCN9qAI1lNT3qXQr9gzrodtJrMmZ5pGHUYYoh
	O5PCIj/UkansrT7QHoX4KQNqLxzLBflCtu4RG4LWIDlSGlgewRa9GZrc8bLT7r+7Ti2eOqwtOu1
	iwj+5tLdImYUeMm9c1hhIX0zfQPGFGMpdU5pzObfYgYCm5gWr9s9JLzpBOAQwx+DbGwbqx9N6hx
	YkaXHpWABRdRfirV51mNf90nS60Vk=
X-Received: by 2002:a05:7301:2e87:b0:2ae:5f28:eafc with SMTP id 5a478bee46e88-2b6b40ca5b7mr5894169eec.27.1768716961993;
        Sat, 17 Jan 2026 22:16:01 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:8fdd:4695:1309:5b93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c65sm8163816eec.8.2026.01.17.22.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 22:16:00 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <cwang@multikernel.io>
Subject: [Patch net v8 3/9] Revert "selftests/tc-testing: Add tests for restrictions on netem duplication"
Date: Sat, 17 Jan 2026 22:15:09 -0800
Message-Id: <20260118061515.930322-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260118061515.930322-1-xiyou.wangcong@gmail.com>
References: <20260118061515.930322-1-xiyou.wangcong@gmail.com>
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


