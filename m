Return-Path: <netdev+bounces-160950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D8FA1C649
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 05:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6853A7249
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 04:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C7319E994;
	Sun, 26 Jan 2025 04:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbAZ/S52"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7D119DFA7
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 04:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737864804; cv=none; b=X/5zqA5SgqM5kF+vkIe44nAakjJ//AgJVYjgGbMXRJX4HAoDKa2syC4Zn62VEyEIn4Qy/UyrkoSnd6cQsVdAGp+IH6JYzLVTJMPvoeNSfPsBLsP5ojuLTv3uW8zUT72QvcxoxrDiCQAN0r54R4+uOnlvw/xtvAy5dz1Yiiv1m4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737864804; c=relaxed/simple;
	bh=LWgxvj/KN59RqGC2OzK72Rk7dSY8bsknwV4JHD+nX5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FaucscUYbxQ333h8zaMADHzbHw9QLZusMX8ZG/HOhRZt67K5XWtK+1GhWW6uGmC8QKnT1lXw59cwImDAxr2Sx0kv29x+KlKotQZ8ZwhyOnWmeRWYZv/QggUHYSFP2BpccMwNQ8kmtmLlHjgNb9gPEE3lJB+36Vay7PUDwoTbl1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbAZ/S52; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2162c0f6a39so81165935ad.0
        for <netdev@vger.kernel.org>; Sat, 25 Jan 2025 20:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737864802; x=1738469602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odZxDNANPjw9aQ1OR267U96V34DuukeaJXbQIgo9WJg=;
        b=GbAZ/S52WUl3NeU4ipdrzyO6QhfmA9Rmd0jGTFDV1/BWiKEsURFhXpzmlL1lPOAj04
         Cmo+pIQl5QquAl+cf0FVeDpqErbmO2wyvpPmqTD8JY388CUk/+CpAO/+RJlgt066ut2H
         olmmqhmwsKcRyit7jBR0Na4USNt3MbTQG56juJ0jjDLY1aPT373qqUEpJnlT61wLNujv
         klJIoXOxyWR8J3nw9RTmqKWqVNPcZkmYfOmT/ne2J4G1HkxKGxkvTvCqUscilmW6Uvmr
         Mtx9nCmDMPQts4Y+IUkyBbb4S5y93jluw4vfehDuAlILhNGX+BJbJbNI/kgZBCnJnRFO
         IgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737864802; x=1738469602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odZxDNANPjw9aQ1OR267U96V34DuukeaJXbQIgo9WJg=;
        b=mrNp5g2taWnY+WjKVh8IL1ejicy0kmXENem6oDE4MzHI8Z8TOuVUmQtzRq20jPcnaB
         Va5lXfZg/n16esMfdSPyQtHG21pNgEpctHS44v+Ipte6RBoDvmjmVRS3aYq5OvvJHSLz
         U9DVqW7oCLl6WWygiheJY/wnbwOEjGs5DERudtuTJODs7E+WAkJKpK2z/khiojBKxpWT
         Mb8N3CUxACdSD2XT5JDTqYmUe0BWNUfNH56B5uZW5VNb0m4dUNbP4QjgN9dnQtGUGYTN
         YPnYs7DoxGHuTqHL8DZUMkLSHnlSrbN67tUCUASbBNMdiuNwBRBXRC9EpL373KZuKs0I
         258A==
X-Gm-Message-State: AOJu0YwohLXeEqbG0Qa4pOzUjB3UdWSc91xO9jbjDwEerKcx9rvqQPE3
	P8uqfp1IKWykKxatwZ4t4nCAiXemBz6rBzjG9J/Su9scJxcMwVT2xuBlfA==
X-Gm-Gg: ASbGnctEScfoQm/mr1/VsHMgbzJkRdkqCzl1FwMPJU0vwUS+ng9Btbjzup0PAYdkQ8a
	WGLSwUvTzG0OZNihJzDRX5uv/6GYEdTwPwgpAk9b7TGGJMUZ8zu5T10dLuh+3qB45MR4qPN3UI0
	3/Q7S6yAKXh1XtM1zLh8HAyTrgzciaWm8rohRh0FQh1TOi0C5L1aAKD8kCzKgJpgLvD4Sxa923T
	N9CS6X4smGKbyHBj2Hyr34cfvdAR0nC7z9gsDEDyr3pqxajR3J2P8naq03DfKhOnFRQyhh7S3S8
	AhptZRP8O3WQ3Cjvrd4aanGBVuzJw91qZA==
X-Google-Smtp-Source: AGHT+IEfvIo8rIfrQrNzUsgVicOokvBY1Ety/4y4nJEkHA2/LGKnmy4P1QLQ4dAPPNFEnakoEdP6gw==
X-Received: by 2002:a05:6a00:2719:b0:72a:83ec:b1cb with SMTP id d2e1a72fcca58-72f8adf4091mr12559933b3a.0.1737864802201;
        Sat, 25 Jan 2025 20:13:22 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:86c9:5de5:8784:6d0b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a69fd40sm4514213b3a.3.2025.01.25.20.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 20:13:21 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	quanglex97@gmail.com,
	mincho@theori.io,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch net v2 4/4] selftests/tc-testing: add a test case for qdisc_tree_reduce_backlog()
Date: Sat, 25 Jan 2025 20:12:24 -0800
Message-Id: <20250126041224.366350-5-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250126041224.366350-1-xiyou.wangcong@gmail.com>
References: <20250126041224.366350-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

Integrate the test case provided by Mingi Cho into TDC.

All test results:

1..4
ok 1 ca5e - Check class delete notification for ffff:
ok 2 e4b7 - Check class delete notification for root ffff:
ok 3 33a9 - Check ingress is not searchable on backlog update
ok 4 a4b9 - Test class qlen notification

Cc: Mingi Cho <mincho@theori.io>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index d3dd65b05b5f..9044ac054167 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -94,5 +94,37 @@
             "$TC qdisc del dev $DUMMY ingress",
             "$IP addr del 10.10.10.10/24 dev $DUMMY"
         ]
-    }
+    },
+    {
+	"id": "a4b9",
+	"name": "Test class qlen notification",
+	"category": [
+	    "qdisc"
+	],
+	"plugins": {
+	    "requires": "nsPlugin"
+	},
+	"setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: drr",
+            "$TC filter add dev $DUMMY parent 1: basic classid 1:1",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 drr",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 2: netem",
+            "$TC qdisc add dev $DUMMY parent 2: handle 3: drr",
+            "$TC filter add dev $DUMMY parent 3: basic action drop",
+            "$TC class add dev $DUMMY parent 3: classid 3:1 drr",
+            "$TC class del dev $DUMMY classid 1:1",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 drr"
+        ],
+        "cmdUnderTest": "ping -c1 -W0.01 -I $DUMMY 10.10.10.1",
+        "expExitCode": "1",
+        "verifyCmd": "$TC qdisc ls dev $DUMMY",
+        "matchPattern": "drr 1: root",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root handle 1: drr",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY"
+        ]
+   }
 ]
-- 
2.34.1


