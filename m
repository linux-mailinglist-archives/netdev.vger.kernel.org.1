Return-Path: <netdev+bounces-176622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 085FEA6B1A4
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 00:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290D7188E39F
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 23:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BC522AE4E;
	Thu, 20 Mar 2025 23:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4Y0Mequ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AEA22ACDB
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 23:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513166; cv=none; b=nh0obCGbUmjp+tl18GRVHSLYrocfEBT0ItdZLuFKN/dl0JcSIUeDoGK88Nsf+OoNJ0iMZOoSqqglJyO+34sorDc8Kj0HiCySoRLgHCFbmoeCqBz1BzPMtbS8Qvkt99lG144tINF3MHnugSv3A7nJAkxFtuEJLQ3exai6snukjAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513166; c=relaxed/simple;
	bh=rgJPGn84lYiwSPcaPyC4SWzFJw/MmALLLI+mnAzKjuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jk5ArR22ixCJh9Nsfqid66AUdHffr7YC3jAUqDQl3bXVCT486r9A+obZYkJOYTIX80L5OS8eKBh8xBJrUNxCeepa09JFgk8WgDDLP95UcPW8P6iSx6Fg/r8lT7Tpbk6zsYdmVUYNWqvywvibT0K+5v2YjebAE4TOFuH1XT1ySb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4Y0Mequ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22423adf751so28397615ad.2
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 16:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742513161; x=1743117961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eemftbTX5vousJBOkcEl8+WVcNUJnBC2kGgX5gtyLzE=;
        b=A4Y0MequSxyg+7mhmgiMkicb63CzPdkjmeBKF8qblHIHuLSmQ6dvrPX89Ln1XEU5nh
         EYMkw+xGulejVcDeJbauVKUmYe7HnkxcGLtt7WehmjJ/hh9InzZIa/IOXuS49UDldg09
         9p79wWTi7gv9JXMHjE47w0kARYrUZTN7FJ7QLOoU+eEiUD7Z1OUM/exncHhZg479DP2n
         8i377POnyFSbbQVVG+m+CgXQioaHpAD59cQ2s5CYATMU2OA9Rz79YrTiAgDgP6VEUV5D
         ZObgYu6GmKf96CgFn5fZ1jCGvke7xSR9XgwYgIQs8+pqQx/wTyZPPoqDI0A+/UpCKIaN
         2TLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742513161; x=1743117961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eemftbTX5vousJBOkcEl8+WVcNUJnBC2kGgX5gtyLzE=;
        b=V23o7+nIKdaglM5p7kSo7WupeGNe5nY6DvCa3HnR/8G78if/kCcsLs33Uvx7YjxaEZ
         ktw8Om7YFh0Ca0viePfCJCUMrcWIk2OnT90ggZXThSfNngBwNuE0YiqITT4TYad7/Kix
         3A/QnVfGXNgJBVZwz4MnHc6U0QvIXeAhGLqOgztLev4oiEX+ln64b96ihwB5MiDPJd02
         xj4emlezq7/W3UbLCz86f6hpVcFhZs8CEUxU/2NECmWjPfsNwE/B+1Oum/wAEJwxcAGG
         UUva8Zv3MJbC3qvp6uOeQ0Ej98RH+IVtnUzRwrorCZZ1Xw8f7FB0P2HSY8zNaHAKkW5j
         8OEQ==
X-Gm-Message-State: AOJu0YyjvmY5PTsTkIjqByDL/JTh+jweei0ke8qiQFJAZoTHNNckwkdK
	vJaLCrAndpKuiyG2zsvUxIgS4QZKda+r+Bpya77S3WQjpBq7Uat3GQaquqmr
X-Gm-Gg: ASbGncuiA4otuQdf2SeNJrUlsRqxDQIzxhQaEx7UoT2L2aOGZMChzUEx4SkRB2oPbbF
	ACs1HhupPZJzk+L6xJTAhmHlzE91WzQuZsYfI8aBEayoRmXgGG0f1dAJn//H+CXuJwFo+pNpn3B
	XjMNa+G6mdgJ2cxSdTwNEDppxNy20o1l3tllkwFqmn0yNOwnj7IR3qw3s4fIXe/2Q2zr/CdEPJ3
	nWsvNrQxhiHYsq86OPBLJfvetNU6idsuYvcy2Kbycsvp51tyfW8qpg2wchooi58dYJTAuftuIgB
	nJo6EDoo9FEu4pSFcw19kQwM80P3VpOEe6F8XOtkzC98eL+4dyU6B4trOtDv6Fq3UA==
X-Google-Smtp-Source: AGHT+IGbJcpwEi1hSt1IiR52ag9cLCasqTWskBh441VWjmpnoefaRqJJNKKVCFudJFYb30YFm4POEA==
X-Received: by 2002:a05:6a00:a8b:b0:736:57cb:f2aa with SMTP id d2e1a72fcca58-7390599d5a7mr1997905b3a.13.1742513160780;
        Thu, 20 Mar 2025 16:26:00 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611ccf8sm416306b3a.120.2025.03.20.16.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 16:26:00 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	edumazet@google.com,
	gerrard.tai@starlabs.sg,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [Patch net 10/12] selftests/tc-testing: Add a test case for FQ_CODEL with HFSC parent
Date: Thu, 20 Mar 2025 16:25:37 -0700
Message-Id: <20250320232539.486091-10-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320232539.486091-1-xiyou.wangcong@gmail.com>
References: <20250320232211.485785-1-xiyou.wangcong@gmail.com>
 <20250320232539.486091-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case for FQ_CODEL with HFSC parent to verify packet drop
behavior when the queue becomes empty. This helps ensure proper
notification mechanisms between qdiscs.

Note this is best-effort, it is hard to play with those parameters
perfectly to always trigger ->qlen_notify().

Cc: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index d69d2fde1c1c..4fda4007e520 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -219,5 +219,36 @@
             "$TC qdisc del dev $DUMMY handle 1: root",
             "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
         ]
+    },
+    {
+        "id": "a4bf",
+        "name": "Test FQ_CODEL with HFSC parent - force packet drop with empty queue",
+        "category": [
+            "qdisc",
+            "fq_codel",
+            "hfsc"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY handle 1: root hfsc default 10",
+            "$TC class add dev $DUMMY parent 1: classid 1:10 hfsc sc rate 1kbit ul rate 1kbit",
+            "$TC qdisc add dev $DUMMY parent 1:10 handle 10: fq_codel memory_limit 1 flows 1 target 0.1ms interval 1ms",
+            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match ip protocol 1 0xff flowid 1:10",
+            "ping -c 5 -f -I $DUMMY 10.10.10.1 > /dev/null || true",
+            "sleep 0.1"
+        ],
+        "cmdUnderTest": "$TC -s qdisc show dev $DUMMY",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY | grep -A 5 'qdisc fq_codel'",
+        "matchPattern": "dropped [1-9][0-9]*",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
+        ]
     }
 ]
-- 
2.34.1


