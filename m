Return-Path: <netdev+bounces-197350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCCAAD834A
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 08:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E27317DC6F
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 06:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDE8257459;
	Fri, 13 Jun 2025 06:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yZh/24EN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223F121B19D
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 06:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749796901; cv=none; b=mbV0FZLXeLohzPFXTPEs58Dc8fnuHbZ0/UYmb0RlKmd6NFmQHP1qgorMKXhpI+kiRez9qkB118yk9aHQ0hrql+a3RRbI+XE6YkqH3b133hqo5rmy2Vq4XXD/8yB2iorBuIh0ecQAY03oLAbrCFn8SwmeWdUx/KV2vIuvkP5q63M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749796901; c=relaxed/simple;
	bh=3P/NYf2WI7FdrDQUPOOi8vsRtbn7cOnnExx4IrAdWrM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fov//KM4/djx8v9/334SU4FpEnKMU4An27RbHvZkCXLeDP4TcsxvUpz4p7DBnjHIz5UQSo4I05aQ3SQdjJ9OvJB2tj4rCQAOY0WfMp1qGPG7564NQOri2wcCs7xNwwzHibArKRwlS+9EJE+uuYChR/0nFOyejxTUCw5yhwTocYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yZh/24EN; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6fb0e344e3eso15851046d6.1
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 23:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749796898; x=1750401698; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hrdUsUM1iw9GnC3v4pYnzKv6hj283cjAdmDsiReThPw=;
        b=yZh/24ENkhjyxowfMp/eca+rwExbNOZOEaE8/R6+T5kZS49WyUh8zFiZ/IipovWZdj
         1v5emc4RV6Eg2iSDzqsXPHZ8hkzZdxj1E0uNn1mt2JSekJl3zfjiQYDqqxsYPytS63yp
         Sk/MB0d4SmiYO4LU5MvoiOolMEFdTKj+5xNC4A8etrWYbVEoslrYlDMRr/8ppsABIN9W
         qm9IWzYn+WA3BRRYbrPDK92mcXk4e73lONzXgOjzOtkFGr/aHn1X3LxlOtUg/0xgcko6
         jtwsZcHp/u8BuXa7PhlCHYCP5BGqm4bBdx2STAWwVijpXas8xjVlw40uzjZJDYIQCUDr
         KrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749796898; x=1750401698;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hrdUsUM1iw9GnC3v4pYnzKv6hj283cjAdmDsiReThPw=;
        b=rocVvyq5qCVTog6HadvivmzFit0RVtL7oDf4CJMLs+6YWWv/MwKnTKyfypsILqHgeF
         01QEWao1YcAYgUX5TKuzFW/Vm2zw+qbk4t9EZrQjv6S0E1c5yGqOBKjPDZIsrd6LRKuN
         oyGvyxcOtdYq0/6PBuB5fxOyaFDzfxq9ZVFFN18m2H85G8T7GvBlQ8Mo2ZRDavXNbAoh
         uyLDTvp054cTlU+3iQLmN70vUUqY8tcUJKZD2lRT7dyoddHvg4kf3H43v+CFQ/Vs1wfi
         5K92ef9H5sQ1LC4RDENq+aciabc3DIaIy50PxMOqXtbiuXgcwS8LDHPH87IO02oGbJgG
         FaNg==
X-Forwarded-Encrypted: i=1; AJvYcCUU4bCgcDlFNvKnCvQqqe6P2ZFNsf8RizKTDWARut5aNsg9muIjtnJQ55zUTLx7ME6qk4RH+Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfBGQzn+GlpVWNG6YDTdzVutYVyckG5u/UJBX9WdrTRo7/ICuX
	HU82imBHn/gTt0rHx+u8VClzfFCoBH2BnZA05wG3fun4tjHFZY5Vnoybt5NKjHj2QPBTa54qJY3
	Wesj+CFxndkQIvw==
X-Google-Smtp-Source: AGHT+IEeLQByYmulnMuCVJmzsOHm8RRxtzMscN2skySjUKLHJDovBKB3RFQQyfDn6YHe/5EOmC6uL8hB1xNAqA==
X-Received: from qtbey18.prod.google.com ([2002:a05:622a:4c12:b0:4a4:3edf:7931])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5b83:0:b0:6fa:cb05:b44c with SMTP id 6a1803df08f44-6fb3e6227b1mr27287446d6.3.1749796897817;
 Thu, 12 Jun 2025 23:41:37 -0700 (PDT)
Date: Fri, 13 Jun 2025 06:41:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250613064136.3911944-1-edumazet@google.com>
Subject: [PATCH net-next] selftests/tc-testing: sfq: check perturb timer values
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add one test to check that the kernel rejects a negative perturb timer.

Add a second test checking that the kernel rejects
a too big perturb timer.

All test results:

1..2
ok 1 cdc1 - Check that a negative perturb timer is rejected
ok 2 a9f0 - Check that a too big perturb timer is rejected

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../tc-testing/tc-tests/qdiscs/sfq.json       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfq.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfq.json
index 28c6ce6da7dbb829765517f989d5441aab98f901..531a2f6e49001e9390eabaef1b545d6836cecb58 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfq.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfq.json
@@ -264,5 +264,41 @@
         "matchPattern": "sfq",
         "matchCount": "0",
         "teardown": []
+    },
+    {
+        "id": "cdc1",
+        "name": "Check that a negative perturb timer is rejected",
+        "category": [
+            "qdisc",
+            "sfq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfq perturb -10",
+        "expExitCode": "2",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "sfq",
+        "matchCount": "0",
+        "teardown": []
+    },
+    {
+        "id": "a9f0",
+        "name": "Check that a too big perturb timer is rejected",
+        "category": [
+            "qdisc",
+            "sfq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfq perturb 1000000000",
+        "expExitCode": "2",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "sfq",
+        "matchCount": "0",
+        "teardown": []
     }
 ]
-- 
2.50.0.rc1.591.g9c95f17f64-goog


