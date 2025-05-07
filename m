Return-Path: <netdev+bounces-188547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5D5AAD481
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 06:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9317D1BC841D
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 04:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E251DDC1E;
	Wed,  7 May 2025 04:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxyBNUuX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FBC1DD88F
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 04:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746592584; cv=none; b=cXf1LFCRVyob7YSGOcvtT/jEHnslnho+L9PgmjQnA4e2m93yEHDxro6I50GuJHO4YyFMNqbqEE6ZEfAoJkVGlkEe54VUdxegq9tTCjDTYSBl91lCMYgMCl5PjJ5OReXg3OiaA4Iq40xMTFpPB9VW4lVmN46nvpwioIee6Ba/LGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746592584; c=relaxed/simple;
	bh=SUQJwDyDelSjBYDisagH/CamsupKCyZTgx0Y0otYo1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cHpOl7hGdQqfRdE6vetuj8fcHM5EDYVjNrR4QRp1bh+PX/UQdj9j9vBQYaaP4pNsJFVORWZESUiZgss6rpLbiio3Xf7L8gFZPQIYIppuCi4Q1UsA0chUsEee1CgNcqvRIKn36Lk6LYvptQx77/xCIkEpRSnNkVUyCnC2rZMzg2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxyBNUuX; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7403f3ece96so8520680b3a.0
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 21:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746592580; x=1747197380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwudsHfxychSdk/ic8x+LNI6PSyH0BBqCifn8QiznO4=;
        b=mxyBNUuXQlG1mLVWORom0Jui0jCwWcz+eY4FogHfx2mHAwBOYZqsElHvpmVkuzKZri
         L+OzuGIPFThEKKj1SDE1N73O1/mGGq7s57pE5E1gXT7mDWO4zu/C6d/XYPr+00wJORiG
         NWd2KgqP9mI1wNI3RXq68mVIUDMYC5V1SL4AvIf0/M3CfnhFMLIBT4c0JqZ3jttTg6p4
         dtsiZKFWGfmucfPqQ11wnYV1C974oVNrXqnCuUr51RdZZOG4tQH0z2A8eeYNHZh1Pk1G
         YmQ+q9W5JuTODo6dTXYrd9dybEHD+qxj6f6ODJ4nGmsw2Xfqk35wTg1YsyMGvnAelJmQ
         P3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746592580; x=1747197380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwudsHfxychSdk/ic8x+LNI6PSyH0BBqCifn8QiznO4=;
        b=MUdwgeeAbi50FzyOtBA6LI4GexlPXrYHdZUbUv5vnOMgInKWcDMsypxKSh3og5alon
         TNYJxVD/LSX04ZMJb6+Zrwe3UuIYszwy4gvs18AUtLZvJcHfXXuWPpKOTWbOHUX1g5Sp
         y+e+1KIL18IMynys7/uKyNwlMl/3hhigl5zmpjtgUcW4jMrYYWuYBUbgSzzF0JLipFrT
         J2WDFPPXxysw3OJO4rZ+jZyqwpRjg/OIRDntFytm99Fgn5o6enWCzgQ7y8iJNiDQ8s7Y
         VYE7O9okUjRGJI+TvNCTaS2DOHjCjfcAYz3k0oTho//VMYUE0ZOEU2fOSVxyWtyQUaKB
         QYcQ==
X-Gm-Message-State: AOJu0YybKIBMs2A6gQINQuiAZudfLOOxYJajbIHkbISOIC2wzmKE3NZf
	kNODCfDtwCB9oeBKqy7Utj1fQAzgaiGQd1v7aDX7ZwqMpRw9PYtVoVmwjN9Z
X-Gm-Gg: ASbGncsy+O6dHeh3hxIuZKvU355RU0VziYk4OpS+VgxawsvoNI10BUgg+9UHnIL65mT
	1mjLYes62wrXpeMMJd8PhKD3MyGEFK4QL9X+W54LQv0nJtcIJMRemud9WP2wxve/G4CEXEHirhS
	kvHjIYsWgA+WNXd8O1NCLX2TDDkO6RdaC4ZVk0uoDMDtaBGywbotRxlm+3SBMgE9Xbmji+XtAm8
	78BQ6aOBQH60JFpr+1VIH5YjHssQKGPCga5kITjnimez9/zyyhQzdqkgG7soDFtAh4CY6mlnbSW
	n7lppqs6NBZ5Ni3rAQj3YUSp7gCQqSFpVqDPrRmiAQcZUg==
X-Google-Smtp-Source: AGHT+IENPnYqpguor7mmuzWNefL4zrVxtHBLtsPA+6k9Nr74p09xNaYCtoGIz39qGPNv1UxgVZF4ZA==
X-Received: by 2002:a05:6a00:aa8d:b0:740:9a42:a356 with SMTP id d2e1a72fcca58-7409cf1b565mr2249031b3a.11.1746592579944;
        Tue, 06 May 2025 21:36:19 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:734b:a7b9:d649:5d9e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902109dsm10350720b3a.106.2025.05.06.21.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 21:36:19 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	willsroot@protonmail.com,
	savy@syst3mfailure.io,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net v2 2/2] selftests/tc-testing: Add qdisc limit trimming tests
Date: Tue,  6 May 2025 21:35:59 -0700
Message-Id: <20250507043559.130022-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507043559.130022-1-xiyou.wangcong@gmail.com>
References: <20250507043559.130022-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added new test cases for FQ, FQ_CODEL, FQ_PIE, and HHF qdiscs to verify queue
trimming behavior when the qdisc limit is dynamically reduced.

Each test injects packets, reduces the qdisc limit, and checks that the new
limit is enforced. This is still best effort since timing qdisc backlog
is not easy.

Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/qdiscs/codel.json     | 24 +++++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/fq.json        | 22 +++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/fq_codel.json  | 22 +++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/fq_pie.json    | 22 +++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/hhf.json       | 22 +++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/pie.json       | 24 +++++++++++++++++++
 6 files changed, 136 insertions(+)
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/pie.json

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/codel.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/codel.json
index e9469ee71e6f..6d515d0e5ed6 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/codel.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/codel.json
@@ -189,5 +189,29 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+        "id": "deb1",
+        "name": "CODEL test qdisc limit trimming",
+        "category": ["qdisc", "codel"],
+        "plugins": {
+            "requires": ["nsPlugin", "scapyPlugin"]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 handle 1: root codel limit 10"
+        ],
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 10,
+                "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='10.0.0.20')/TCP(sport=5000,dport=10)"
+            }
+        ],
+        "cmdUnderTest": "$TC qdisc change dev $DEV1 handle 1: root codel limit 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DEV1",
+        "matchPattern": "qdisc codel 1: root refcnt [0-9]+ limit 1p target 5ms interval 100ms",
+        "matchCount": "1",
+        "teardown": ["$TC qdisc del dev $DEV1 handle 1: root"]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json
index 3a537b2ec4c9..24faf4e12dfa 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json
@@ -377,5 +377,27 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+        "id": "9479",
+        "name": "FQ test qdisc limit trimming",
+        "category": ["qdisc", "fq"],
+        "plugins": {"requires": ["nsPlugin", "scapyPlugin"]},
+        "setup": [
+            "$TC qdisc add dev $DEV1 handle 1: root fq limit 10"
+        ],
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 10,
+                "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='10.0.0.20')/TCP(sport=5000,dport=10)"
+            }
+        ],
+        "cmdUnderTest": "$TC qdisc change dev $DEV1 handle 1: root fq limit 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DEV1",
+        "matchPattern": "qdisc fq 1: root refcnt [0-9]+ limit 1p",
+        "matchCount": "1",
+        "teardown": ["$TC qdisc del dev $DEV1 handle 1: root"]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_codel.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_codel.json
index 9774b1e8801b..4ce62b857fd7 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_codel.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_codel.json
@@ -294,5 +294,27 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+        "id": "0436",
+        "name": "FQ_CODEL test qdisc limit trimming",
+        "category": ["qdisc", "fq_codel"],
+        "plugins": {"requires": ["nsPlugin", "scapyPlugin"]},
+        "setup": [
+            "$TC qdisc add dev $DEV1 handle 1: root fq_codel limit 10"
+        ],
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 10,
+                "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='10.0.0.20')/TCP(sport=5000,dport=10)"
+            }
+        ],
+        "cmdUnderTest": "$TC qdisc change dev $DEV1 handle 1: root fq_codel limit 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DEV1",
+        "matchPattern": "qdisc fq_codel 1: root refcnt [0-9]+ limit 1p flows 1024 quantum.*target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64",
+        "matchCount": "1",
+        "teardown": ["$TC qdisc del dev $DEV1 handle 1: root"]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_pie.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_pie.json
index d012d88d67fe..229fe1bf4a90 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_pie.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_pie.json
@@ -18,5 +18,27 @@
         "matchCount": "1",
         "teardown": [
         ]
+    },
+    {
+        "id": "83bf",
+        "name": "FQ_PIE test qdisc limit trimming",
+        "category": ["qdisc", "fq_pie"],
+        "plugins": {"requires": ["nsPlugin", "scapyPlugin"]},
+        "setup": [
+            "$TC qdisc add dev $DEV1 handle 1: root fq_pie limit 10"
+        ],
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 10,
+                "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='10.0.0.20')/TCP(sport=5000,dport=10)"
+            }
+        ],
+        "cmdUnderTest": "$TC qdisc change dev $DEV1 handle 1: root fq_pie limit 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DEV1",
+        "matchPattern": "qdisc fq_pie 1: root refcnt [0-9]+ limit 1p",
+        "matchCount": "1",
+        "teardown": ["$TC qdisc del dev $DEV1 handle 1: root"]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hhf.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hhf.json
index dbef5474b26b..0ca19fac54a5 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hhf.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hhf.json
@@ -188,5 +188,27 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+        "id": "385f",
+        "name": "HHF test qdisc limit trimming",
+        "category": ["qdisc", "hhf"],
+        "plugins": {"requires": ["nsPlugin", "scapyPlugin"]},
+        "setup": [
+            "$TC qdisc add dev $DEV1 handle 1: root hhf limit 10"
+        ],
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 10,
+                "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='10.0.0.20')/TCP(sport=5000,dport=10)"
+            }
+        ],
+        "cmdUnderTest": "$TC qdisc change dev $DEV1 handle 1: root hhf limit 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DEV1",
+        "matchPattern": "qdisc hhf 1: root refcnt [0-9]+ limit 1p.*hh_limit 2048 reset_timeout 40ms admit_bytes 128Kb evict_timeout 1s non_hh_weight 2",
+        "matchCount": "1",
+        "teardown": ["$TC qdisc del dev $DEV1 handle 1: root"]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pie.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pie.json
new file mode 100644
index 000000000000..1a98b66e8030
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pie.json
@@ -0,0 +1,24 @@
+[
+    {
+        "id": "6158",
+        "name": "PIE test qdisc limit trimming",
+        "category": ["qdisc", "pie"],
+        "plugins": {"requires": ["nsPlugin", "scapyPlugin"]},
+        "setup": [
+            "$TC qdisc add dev $DEV1 handle 1: root pie limit 10"
+        ],
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 10,
+                "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='10.0.0.20')/TCP(sport=5000,dport=10)"
+            }
+        ],
+        "cmdUnderTest": "$TC qdisc change dev $DEV1 handle 1: root pie limit 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DEV1",
+        "matchPattern": "qdisc pie 1: root refcnt [0-9]+ limit 1p",
+        "matchCount": "1",
+        "teardown": ["$TC qdisc del dev $DEV1 handle 1: root"]
+    }
+]
-- 
2.34.1


