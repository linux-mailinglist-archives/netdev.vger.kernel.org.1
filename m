Return-Path: <netdev+bounces-204341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C424AAFA1D1
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 22:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1382E3AD1EC
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 20:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F695211A3F;
	Sat,  5 Jul 2025 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="2FFFR1gQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272F4136349
	for <netdev@vger.kernel.org>; Sat,  5 Jul 2025 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751747807; cv=none; b=AL8/2A1TJ2ljeigAEvqq0K/tSmW8Z4a6ZOwTa4/flHOjLbxmIWrRifgenPRiQ/M8s/3tVCJF5ewyUigfW8Ndx/meJh81Vy52dRD3OhXQ5ei+vgjbsRVH2bCIBsNB9OK1DjyvaceLBZ62oteseKIcv8jSMd3GkfSFafKaWYUPBS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751747807; c=relaxed/simple;
	bh=tXMqIKuUe0uKY/9HuIf0qKCLodAOKfd9aBiVCBLrYOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gvod32PSFcWZB/VrQg+DCqgBY9BcPfDka93kL+y5Mo4MVlRpefvSIoGr2MT90hD9fuPPuPbwgVrByT9duwvu/T0CCAmLNbIWSU8N/R+J8iil/fUX3LZzxDDpgKQvKQyG/2N38KapcSM2eQ8KujJIA+iDFGhjPj3xM/wsBed9T88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=2FFFR1gQ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d3e7503333so317879785a.3
        for <netdev@vger.kernel.org>; Sat, 05 Jul 2025 13:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751747804; x=1752352604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fEiidtMHAZbRPFz2UVHC9Ze/J3UxcrJGtAfc0yXLY9Q=;
        b=2FFFR1gQ6ntG8wkXWRRlM6k3mDqFOugrNFSaQLTgN4f4iOuAv1DPtO9M2mDBG63Rdm
         T9VZLDTcHMLSm/ClRvYTjyVKdKBnnvUhcliNhFq+4A75xPREmRvAjPcD+bBCgQOEjqx5
         25tv7i4/aRGDzQVZU5xb++b6cnn5ALoxV+tLXUGcH7rIHDYRZD/dsI2rBrp3LimdbbZX
         pwmTdnBvKnFuqupWwcgYv7uRh7A7hrynINnRn/bxTqHE3MoyyUWwB978iFFM8zdVM2Sq
         I3245MXR1xMgj/uAFyrM7py3jO59bWhuzKr9+QzK3OpC/j99Fu/FSk87sTSCNGNe0UyQ
         CzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751747804; x=1752352604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fEiidtMHAZbRPFz2UVHC9Ze/J3UxcrJGtAfc0yXLY9Q=;
        b=T1CLtPkOGw2jTJBaS1cTR+95Wv/G08KeYBNw11IttD+qFscuGbbqAytvSRAtsa9Awj
         msqbdiKUltgUPhHrAsIjz6hz5lnBGZwPjj6c+KzS9tbwn+MyOw6tFsxqWoT5kZtPVk6F
         69zy6ZVCX4lkegrQrG0laV/1g1hUfCH7906Wa1ocXUs7O4ouSH0jdXKLSQHmT4Q4D1/w
         jrlhvN1zkvjBVxw/lRis6GKej/vG95oHOqZVi9wGsdwCcOWzvAQ4AXvzuLrwTl9oPqXT
         M3lMJw32LO2rcJpJlH0Q8K7UzvmN1Jp3G1L7/IfDupZu/fz1NT6Y8YIX8aUeTSIAKz1f
         WBYg==
X-Gm-Message-State: AOJu0YzHOdN9mX+jemvC33fyCOB+m5vEJI8C1BFZj8rEe1kXppkk0PIZ
	LZhUrlRzx+IhpWQaCiw/1O/JuyO9j2fSRu06PFc2nVOjYQon9XRv+V2oQYjkOR81aUQQbGoZlLK
	2BWY=
X-Gm-Gg: ASbGncto1jT9cTybo6tONDaimhQmVCjdCxaenUdWxCZ2KcvU3eZiq/cxwj+MQJ0xzb5
	7iTN3z88Ws4SSJWrAYCJ63si8j3bGkRVU9BEqSjgMh8nvKnXOnLyqC+ewQZeeHLMlae6VHrgwHr
	WxKvh5WeU+/GiFRIE8LqOKXUNWZbpmCXJWuhgWjbe3fJCRd5I/T42Oy0bEOJV7Sx7YePYI6necp
	jDf2ckTkSKJvUcDAIzh6hc+oFNUGlfEo4AOblPCa4ppHjj+PEX4ix4kxzin7y5yldkGWx7s8zqC
	gSZyXxK6w6ESKIjsYWdvsWgfRnE6dDirIU894SQ+kqZUgJ8idSWp2AGgNaIZ7WFyCMQs6+tV20G
	QxPz6bnFR
X-Google-Smtp-Source: AGHT+IFPHP9izj0Mokw2zFw57l8uOaaLK0jZnOiaIviLnAe3XkawlMxhzgVtwGvhUST8QfNldM26+g==
X-Received: by 2002:a05:620a:2b89:b0:7d4:4b92:85e4 with SMTP id af79cd13be357-7d5dcc5e457mr990604385a.14.1751747803886;
        Sat, 05 Jul 2025 13:36:43 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c1:ca4a:289:b941:38b9:cf01])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d5111csm34193296d6.67.2025.07.05.13.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 13:36:43 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	pctammela@mojatatu.com,
	nnamrec@gmail.com
Subject: [PATCH net] selftests/tc-testing: Create test case for UAF scenario with DRR/NETEM/BLACKHOLE chain
Date: Sat,  5 Jul 2025 17:36:38 -0300
Message-ID: <20250705203638.246350-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a tdc test for the UAF scenario with DRR/NETEM/BLACKHOLE chain
shared by Lion on his report [1].

[1] https://lore.kernel.org/netdev/45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com/

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 9aa44d8176d9..5c6851e8d311 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -635,5 +635,42 @@
             "$TC qdisc del dev $DUMMY handle 1:0 root",
             "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
         ]
+    },
+    {
+        "id": "d74b",
+        "name": "Test use-after-free with DRR/NETEM/BLACKHOLE chain",
+        "category": [
+            "qdisc",
+            "hfsc",
+            "drr",
+            "netem",
+            "blackhole"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: drr",
+            "$TC filter add dev $DUMMY parent 1: basic classid 1:1",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 drr",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 2: hfsc def 1",
+            "$TC class add dev $DUMMY parent 2: classid 2:1 hfsc rt m1 8 d 1 m2 0",
+            "$TC qdisc add dev $DUMMY parent 2:1 handle 3: netem",
+            "$TC qdisc add dev $DUMMY parent 3:1 handle 4: blackhole",
+            "ping -c1 -W0.01 -I $DUMMY 10.10.11.11 || true",
+            "$TC class del dev $DUMMY classid 1:1"
+        ],
+        "cmdUnderTest": "ping -c1 -W0.01 -I $DUMMY 10.10.11.11",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -j class ls dev $DUMMY classid 1:1",
+        "matchJSON": [],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root handle 1: drr"
+        ]
     }
 ]
-- 
2.34.1


