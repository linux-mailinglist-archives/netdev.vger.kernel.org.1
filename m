Return-Path: <netdev+bounces-242031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBF2C8BB99
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C65AC4EE8AB
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6993E342C9E;
	Wed, 26 Nov 2025 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP3dW4uG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D43341AC5
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186781; cv=none; b=hu6SyOiq0F9sBYSgU6tkihRgxAu64jOpKkbSsmkEcauVroAsVeBLKqGCSOlmjt9lMmuMYrJuVuajbd0uvIfQwsXCERRUyqZrbg6edjVvxKPQuuTZXVj/KnbPonEMM8LQvCjAY+cU+PmuBAGQZgTX1l5Kfhlia59GA79ebbloLZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186781; c=relaxed/simple;
	bh=V/7f2NXCAhFCMEYLNXc4F+cyQ+JQUhcvWiDP5i/mm3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sa8jpLBbWRmjRrBpx0Jaxrn5HMJ0a+xItSpYILfBJBcazaHpkcbo3NYSUU1AlvxHv9u17Tka+FqpUaDss0DeGgh0u9imuL2okBZ27katHueqbyAcIYcIM4utIoWEcNGjmYD8cUI0u8m+QqTY8psxZDmNHFxIf31aVuSmjn8a7r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OP3dW4uG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2980d9b7df5so1513725ad.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764186778; x=1764791578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHWNHIPaJCrpLPbjULWTUXdbOO6TVkCdumAFOOrx7X0=;
        b=OP3dW4uG5qVor+rnvmzjhPKtgx+pgbONCkuMXpKQXxRNLPZTDCG9O9FdOH3wRFDfZy
         7s5rsrbKY/iWk0XzOZFH8OL2MxP8LMDYBveuDoIgGF3A4QuLDOS43lFC5rDQfiaW6hJf
         WxoXATtBuKCUYuHjnliRbOAt/pSp8IDuJODEj6qhLhbsEiBKg4piPt+VhLl92oxf66Ih
         Ppro2PKGtojb/LtPfBrw9xdRSx6D1Z4apvko7pippU+M8sIiHkfbPW/T9B/xc1498PEL
         WbPWjb15jb9juywJdGVn7ivR0we0MDWllXbV96RmUFGQpIqnyNc2JVTTG26AmU4vlFAZ
         8T4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186778; x=1764791578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VHWNHIPaJCrpLPbjULWTUXdbOO6TVkCdumAFOOrx7X0=;
        b=WnlDSygcyRBgPo1lohqfd8A2NmMfWd5/xs6DQTbNb/DzZRfHLtvZ9mkDwRyh6M3eCe
         kJ8xqCt8kaGyKfAhsIH/LXiplQyvOli8/k1N4x+9bJUJjJb/hYy9M3AwSzJQ4iUbCirx
         fxglifwDB9zfxrmTkx45plQs0Eu8XKVs1KVXD0O72WbIq48rOKR3mTXROars0wsBfmlN
         YdWyHbsppuL27YYwPtAPfdEghy3hPxtJi3LY2aNN1MmdIS7i0BDnxkRYUcR2RP/P80lF
         qdBCH7oSWN8wsWOuNPthgABkgdImpTaEmneKfNUfZ85hVDw+41BqDul4dCwUHGivf3/p
         3tmw==
X-Gm-Message-State: AOJu0YxaTJMbjkFb0o4j/vv/8AK7uuvNyPTsQZR59Lvi+fzqMiNjMNNl
	5NtEvF/OEoD3M+MAEMUC4R9pUytWBLG6WpodQKOho21gNboQERIBbrOBbF8sHA==
X-Gm-Gg: ASbGncuKzdiUGiiyePUp4erxSCIlYDJEEnqB563nxo8pKYDBL2M5HlLkFkA6/BlMuT0
	Jtw5CrECE4hnxnxZwBwys44NhwfFYaWeDEAL9+cNj3YasGvuZUzPslT00hSj6VjmXsbewiHTd3m
	o7r6gwVrNIKKJr9Mvgyao46pl71Ej3c9dG2chSh0PeZxaFiJuVC5KH2KIp4hqmauUn9qoFwMdyA
	hodeN6QgpmAojOyIg7fKSJYcKmQ+Y4depHOjQWF16pjrOZQOmPx1pC9n15MKzeZT6GnQcvsBGtg
	50VDSTnWqtNZoy4ivCv8u/8H6S+xTVpUgnl4f2+vrM7yVCm5f1nzuUnVL1vq1DiuR1bCXfZJRxV
	vKIqqjdF1dM/UCPUZ1c1yvgiDW919cD/QmWyR8KTRy4aRfsKDFAJwt8t9fPVXc/qZOjjGwIo3qW
	m+3PwbEr/zHRpw7b2iVIkB/UdCpNgHAFH+
X-Google-Smtp-Source: AGHT+IE0XRqq+Gf79T2ynAPQQrAJUTlaTqKJklnT/Hmgn6p2WkeUEXkBt9I3LVhOn+/vSi0bKO9qmA==
X-Received: by 2002:a05:7022:5f18:b0:11b:7a55:e381 with SMTP id a92af1059eb24-11c9d714f38mr9939617c88.12.1764186778398;
        Wed, 26 Nov 2025 11:52:58 -0800 (PST)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93db4a23sm101508235c88.2.2025.11.26.11.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 11:52:57 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	kuba@kernel.org,
	Cong Wang <cwang@multikernel.io>
Subject: [Patch net v5 2/9] Revert "selftests/tc-testing: Add tests for restrictions on netem duplication"
Date: Wed, 26 Nov 2025 11:52:37 -0800
Message-Id: <20251126195244.88124-3-xiyou.wangcong@gmail.com>
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

From: Cong Wang <cwang@multikernel.io>

This reverts commit ecdec65ec78d67d3ebd17edc88b88312054abe0d.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     |  5 +-
 .../tc-testing/tc-tests/qdiscs/netem.json     | 81 -------------------
 2 files changed, 3 insertions(+), 83 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 0091bcd91c2c..b5f367fcc150 100644
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


