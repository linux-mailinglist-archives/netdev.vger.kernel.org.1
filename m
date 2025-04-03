Return-Path: <netdev+bounces-179185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0110A7B10A
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7D43B9963
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E73D19EED2;
	Thu,  3 Apr 2025 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbyYB8tf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB4A1F6699
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 21:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743715018; cv=none; b=tlRkC3SEuSqVVLSp9xeuytijGKsdVN6q/Hf8piHe4Tee0R56PmG7EX6ih3DYMbj7Ev9GLw0gwoARp5kW4X51HhrC1nYMycDQyXgGLcyxZC5BQR3mUgfdmcgtZKsRLRktX/aHtcykIm+dn0+nrvWClhaYUFVwNtyiYxfBrFNzixU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743715018; c=relaxed/simple;
	bh=LGjeBM0lp+r8uucmD69yoYSz8ozS3AIUPP9Uzea7nZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rb/M3fjUSkRWCirjYX5cIYA1JGwTBCDQIrowU1jKiikZbqQ/80XlCKyKwk5cnYiun2W5nk8VaIwU/BhzB7eHCW0MkdPJAncymGc/Szs+y5/+pmq9KIOm8W+HhWrkQUVlcYan1lS2QfPVsiN71Rf0kaA5ldLeZtxa8eIaewkAh1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbyYB8tf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2260c91576aso12088845ad.3
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 14:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743715015; x=1744319815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNOc8va7wTxII5LNMOLlfeqMVireqcYd4i2TSLflfdU=;
        b=cbyYB8tfDE1KAm0doG1J6aLklstrLom8h6fnzTrgBinfpE+e91KcO2AZX/TVCBcDBe
         ODiNmPmIIZfJfr5jPt46W1lPjFG3S6Uykbk5+03RSD9TEjQodQikHHvdB4Ai++p/SsCe
         3/JHCngyFh14AKMT7Wlt12zfpgQGLK7obKYkQv5M1wXcU0zRuMdjtEAfK/P14SPdyf76
         pbj3KA1TDtFoTTK5NEfdyS2B7aiTt6AwU1rHXGJSkVEiLRmut0qpsL3SDDXO+Tfecucq
         2LnVgRJFNUK8x+Cnpi6HFPTEFPXZJwh+QZKH4ZqKplXZkRx6287xBKFpkXnD54j1tZQx
         VfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743715015; x=1744319815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNOc8va7wTxII5LNMOLlfeqMVireqcYd4i2TSLflfdU=;
        b=RWhJrT7G5eFWug57iEULWOddAzmtOqO3iIp8+/0KQHd/8t28TODbhjKwzsYZZUViDb
         0EJYfSIQHn4zD68OwoieV0MvVsLYlGfthujQmRS0Q5kDh03qwtT8Jhv7QCVuyyaqIleP
         oes78SC3E7OR40dSp++R3sF2yPSEH1ghZUr1kf+bgmRajtwqvAE5YnKjBoj8cw+TrY13
         Qd4cYTrHKfwEpBPKLsMcFVhr9fEViZ00a/zseViN3/ef/DGTgOZPUCCF+KMjfObB0TNB
         vuqXVml74Bw2la9dLfMkdTmroDIFXE7Z5FtFgCQTzyveh6WEUwZ+725Kb8DZYLY7yASC
         ZRDA==
X-Gm-Message-State: AOJu0YyWXTspdB78F/7Q6M1hxD/DQMDT8cdWDNRIjeDSANlkxMc2crLd
	TKrp4SomH/n94fp0mP5xWCQ4xp60k1FiNizryvT4rIXviSDyKsni9oK+NQ==
X-Gm-Gg: ASbGncvqONkohMCaPs6v+acAO+iadvBSkhJ48NDec7XN8CADScZG9runM1H5xN9sbOE
	EjrxsS4g39dXfdtet9o0Ka11xP3AqWvExCJeI/M9+vNCmaXNLDZJ+tH66tzykEsId3ecoTB1Tp9
	SECo45fA881d2DlDvtxfn+J6w5UQ+m4BwGH9Y5oWt1XVu0kQunWqoZymHx29GMWtpJzMzn+oX/R
	m+S6ZdywY3xcCelZeT8H3R4XtLr0s4BC8Gt4QkQXibU4Jk01KTmF7MxeQWYMpYjpNpNfn2XkBKE
	z5psR542dE1p7WgEEawzECFfq+rSxjps/NLgexJIfLG0pLB44s2muBxVA+37UAEq4w==
X-Google-Smtp-Source: AGHT+IH0oZDP+LM3uRn/ZcxwbtPZYmv6jg2F9BMRZJFgXV8dYSq8KO6LT/TXHb9pPiljm5RgQrDiEg==
X-Received: by 2002:a17:902:ebc9:b0:21f:ba77:c45e with SMTP id d9443c01a7336-22a8a1d230bmr8068325ad.45.1743715014834;
        Thu, 03 Apr 2025 14:16:54 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e1b4sm19332145ad.181.2025.04.03.14.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 14:16:54 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [Patch net v2 09/11] selftests/tc-testing: Add a test case for FQ_CODEL with HFSC parent
Date: Thu,  3 Apr 2025 14:16:34 -0700
Message-Id: <20250403211636.166257-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403211636.166257-1-xiyou.wangcong@gmail.com>
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
 <20250403211636.166257-1-xiyou.wangcong@gmail.com>
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
index 695522b00a3c..0347b207fe6d 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -220,5 +220,36 @@
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


