Return-Path: <netdev+bounces-188199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A6BAAB828
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78E8F4A19AF
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 06:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E6328E60F;
	Tue,  6 May 2025 01:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRqHpihh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A130430200A
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 00:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746490560; cv=none; b=tC8VWVNr8Z3rb0sCAIC5GU64L7js5S2cMVlTeH2hCD4gQ4NTE/sU7MjpXULajJo4zWamBx697MluVGQAfB+QrgLR7t/9sUf/Ud5Nipq+5VvboHmDYkL94AySdhSQOs7jjPsY+1jfv1Ba5O8MCag7vkSKLRvfLVQugFO2/V3B5XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746490560; c=relaxed/simple;
	bh=SUQJwDyDelSjBYDisagH/CamsupKCyZTgx0Y0otYo1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u/Os2hNpajBiULPYY4QWwA9LhcrHqLyYxX/noGXu3wuSRqudV6wrv3mn5EpmYLyr4Y1OAx1JiPif/k3yyc988TFMNtpHZWF/bQLp6KgREDe++hTT8AKwnl5G5ZqUXRGRbUNSyddC+nGBMsyB/9J8MP9OkaA7HkCH+XBkFlX2gow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRqHpihh; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso5352053b3a.2
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 17:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746490556; x=1747095356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwudsHfxychSdk/ic8x+LNI6PSyH0BBqCifn8QiznO4=;
        b=eRqHpihhU3jXgm830K3qAbSM7nAjRnLf79gonPfp8+e1z8dx7uco7c9qmxR6523akM
         ZBm+W91gr+0fDFLMW9OBtztTAsuLfzlHv8AXW3Jy1LX8upfkC/G8y36NKLMrR+IkTrFL
         5Qn1d8dwfoONDwDh29e4VEFjH4ABEmkn+acDLcKQdcxGSEN7Dn3N2VWjMRaU8uOx1TSS
         AOPS5QRzRKmAD7Lr0O2Q3fBU0X71ptillX33U5IGqP9U6+VWk8ZWBqiflI5V7NQR0nQq
         Bjoi/XzZrCCrzW//PBoQu2MiaRh1AJfZlOIMkea2g/n7VtMVWoznkXITXHF1nyZQtjoj
         0vQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746490556; x=1747095356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwudsHfxychSdk/ic8x+LNI6PSyH0BBqCifn8QiznO4=;
        b=US0sUns25O6RSEeFYdPqvybh+U3r7EtJi6cChyw0Rh4YN4l2N2MRrJbgWcI5LM8/4A
         W6jf2SZTWd/HrzP0Wm7cJhwYbxS/MTcBIjwdRbz1KBdIGuUSX349jkmkeHw81fJ03CbY
         8BxseTW/3ujMEglH6fUvu27p3zY7lEMh8SttsDc3o4/AVFKzKhAiW0K5e8occ28ICmF8
         cgeQKDg9pL+hUZCH5ca+B8TK42oy7Oj0UIoJFV9sgfg5ZiIDJuXJkpVSDC/bZBZnSktz
         5i/lR32gSKKkY0Is+8j97PM4TBTiFy3ws2LOiOO0r+nd1XCANR2/vcaiepwSXXP8nfw9
         hKFA==
X-Gm-Message-State: AOJu0YwTKzXgVScBPdsAnLPOAW9eNXitDBiCC8we+m4B8ti7WriRljb1
	qx+YmCiakS0F8iq0uKgo0CNfJ74c4hvx7ehWGVbbHtoR588G9tKRE7DziLwX
X-Gm-Gg: ASbGncsg6NOoC0K/OiZO5YmNF9g5deWUBooH67E2Bwxw//m/4X7hTXf0R9CUIEoFIPk
	qgp2XfuQXYVjfF8eGPH5BzrucrYUGOn+xU+tUHvX5VrQptLnaQYtIwODqMzFvAM3HkWXU37kKfR
	AoDZTz3KhNWEUDwl3wgDxrgt+LkJg4aiJshMOubr/cIWCFql2efY01QoHueWGTsd3xdPNDxAZQQ
	GD2NUbh/sMCBK7yrd56l6pwZ/QJA/p9MBVtXoRmJGisimXxjU8n0eEiigtai1640Brt3Sd1GMmj
	wHck74+NaHRumV4/DFDvCorm78mo5FdHg1KRTvqFoKgXnjjgYF0=
X-Google-Smtp-Source: AGHT+IFzh51yIjRcfKiLxVVqyo1TXdk2pl3g/EZY6H3IHBVvvRRbHGLlWjCilxteIEbv69y4LSlfTg==
X-Received: by 2002:a05:6a00:35ca:b0:736:34a2:8a20 with SMTP id d2e1a72fcca58-74091a915d8mr1430717b3a.21.1746490556330;
        Mon, 05 May 2025 17:15:56 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405c2e7596sm7496824b3a.147.2025.05.05.17.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 17:15:55 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	willsroot@protonmail.com,
	savy@syst3mfailure.io,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net 2/2] selftests/tc-testing: Add qdisc limit trimming tests
Date: Mon,  5 May 2025 17:15:49 -0700
Message-Id: <20250506001549.65391-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506001549.65391-1-xiyou.wangcong@gmail.com>
References: <20250506001549.65391-1-xiyou.wangcong@gmail.com>
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


