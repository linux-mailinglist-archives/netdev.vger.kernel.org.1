Return-Path: <netdev+bounces-244035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDAFCAE09D
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 20:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65AA5300A234
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 19:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E3C277CAF;
	Mon,  8 Dec 2025 19:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wI+A95sc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612763B8D5E
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 19:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765220497; cv=none; b=eIAO8wRRTIzB+2FL54FKmx5MxSlwmSvviUCETR8UZF5qiJM3n5NkVIiKizs19+6IJ6+8b1qHS9sWEyKx07eUdZUJm5Zl1gSoNABF8T5OQF36MwuuKshYiKhdzUWZow3i1sJSaaWfIPtXpy+QXME7qJTe4rbMAbAriE4ssB62qqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765220497; c=relaxed/simple;
	bh=a6nzRtCMUjuaw5RGD4iOoZDJjfrY1A1PTx5kphyeNzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvY01fzIXBgLnOajuMOkkEZrmKOX7rOis4SbhkhTbscSmGOdvuUKrW9hKbTc1dIbHYHgNsgMXzHCWAexgccocOL2uF2OQbWb+jfjxRiAse1CWwlMtZtHq7eG8/OZji2adDS4BNrbQ28LxnWgtaPcCg3KcqD0jKO9XhTlB1mjlx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=wI+A95sc; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2956d816c10so56030565ad.1
        for <netdev@vger.kernel.org>; Mon, 08 Dec 2025 11:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1765220495; x=1765825295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yv1JBwoE1AfnUzGbtIQyWoso1rUJrwClSYtrJ4U2I4g=;
        b=wI+A95scE3aNcZSHC15Axeae6iGcqGG3AZkd3WqqpkoRRRgCua/2/hDRY4RizgLdOU
         d2O0ycX0YAlelnXBxHcb7fYBBOK3s0PRfv2wjBulVh5ayUfZRvqeHbDpkVj9f7WQv+7y
         03d9u2dvTuuZe3SPmsr4ba1DfGUb2qfNqotWOTcmSAeBLxpeL3+r9mxpjm/drPBYrVXw
         AGpHkACLzT56yuzKJx3OLGg0CkvTlfOhcq23VNy8sZXhGkTZ6RlM4nerTTjm15JY/CqW
         1pHmTAkClj2K4eySdGBLxZCG7XNK0wco1IVA9plqyQ3G4bbNfjxH4zhHy09e9fVkqIvs
         zVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765220495; x=1765825295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yv1JBwoE1AfnUzGbtIQyWoso1rUJrwClSYtrJ4U2I4g=;
        b=pGLfCTqYm68mTzO/H2uqHu6DS98fv8q1OVjcc67mTuQzfgWACNdFlw6ALio5l4OEdf
         eOX3jBuWdkLLAwsN1F7Lt1Gx3DJfOmZXX3BhGU/i9o1u3/QPP2haXIH3/9G6d1T1Uc5b
         mbnVYSJpbp4LB4rtmu+yn+DijWoeszU01/BIUinyAiGz8kleQ/O4hru8jMzrrITjco3b
         ymMCvkvX5eRTwGq2BlxO/eaJ8t7X+w/uAXSSuvhT7bV/EIOsgyPDFuya8UFKqE7YVPW+
         XkX/gqKK6y7an4uo1ll5U+SMgsYio0pgLjVYEQBU7bfiQm18OgnnLN7AtbbitAVh2gWC
         kJEA==
X-Forwarded-Encrypted: i=1; AJvYcCVf6Y3jafYip6i87PMXtkmUieBCWn3I5pC2SYkFxlk7jaZHn/pHt57+5WAI8nG1/GjAYG5ml5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YylKhldSuPe6luz9PPcB4a27PzbjtQujlygic16AnBxKsTQRNGM
	AsE0j0N02fl9/Nwg9gFL3XgiZKKnCdfG30HM6fmlK4Ei5wqFoAuGcL+Z0yAnlcqErQ==
X-Gm-Gg: ASbGnctCWOi+5/cCb0sFxD24GKp5yGGo9Qkuqctl1Ox1MwIlWJpYZ2Ui2V7Zztjx/EH
	VIb0q/tOWf4JTMi6EJNEF6g56eTWGYuyjdNrtiowXU2+EXgff9gYMsfAL481hgQHfWWRi0qN/de
	dW1ALTqHFg0rJTI28XFxqutI9fn4JCfEIWdwc8bcxu0eVG56HxWx6nv+e6VufZYI/ACSEdPN6Nb
	tfELZA7jKLW/t1t04Gd3MwpBa026mEd9vZ6AI9HzzxjLRLfMfZp57Bv3MZzZdd28yzXVwjbovJX
	7WHLNnLI5Nng9UflrhlhzQmj2gFyYsHMy4QVRJaTMDeEsjlD0wVXFW7QYdp5gs9GcMu6CsKz1cX
	RGQzeIjUji6gDpTWsBiLXIVbSiZp8KKULse2tiuV1XKuaeFComwEC2tfhqVBBAvICizjRkvc=
X-Google-Smtp-Source: AGHT+IFC991qIAU1xw9boSGfvexlowvXQyCdqUjtTdcsTUxSZRnkIJF5ycmbofySiy1JYpui79ZYOg==
X-Received: by 2002:a17:903:11cf:b0:298:90f:5b01 with SMTP id d9443c01a7336-29df5f1bda3mr86637095ad.52.1765220495645;
        Mon, 08 Dec 2025 11:01:35 -0800 (PST)
Received: from exu-caveira ([2804:14d:5c54:4efb::2000])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4cf52fsm133666565ad.39.2025.12.08.11.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 11:01:35 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com
Cc: horms@kernel.org,
	dcaratti@redhat.com,
	petrm@nvidia.com,
	netdev@vger.kernel.org
Subject: [PATCH net 2/2] selftests/tc-testing: Create tests to exercise ets classes active list misplacements
Date: Mon,  8 Dec 2025 16:01:25 -0300
Message-ID: <20251208190125.1868423-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208190125.1868423-1-victor@mojatatu.com>
References: <20251208190125.1868423-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case for a bug fixed by Jamal [1] and for scenario where an
ets drr class is inserted into the active list twice.

- Try to delete ets drr class' qdisc while still keeping it in the
  active list
- Try to add ets class to the active list twice

[1] https://lore.kernel.org/netdev/20251128151919.576920-1-jhs@mojatatu.com/

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 47de27fd4f90..6a39640aa2a8 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -1033,5 +1033,83 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+        "id": "6e4f",
+        "name": "Try to delete ets drr class' qdisc while still keeping it in the active list",
+        "category": [
+            "qdisc",
+            "ets",
+            "tbf"
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
+            "$TC qdisc add dev $DUMMY root handle 1: ets bands 2 strict 1",
+            "$TC qdisc add dev $DUMMY parent 1:2 handle 20: tbf rate 8bit burst 100b latency 1s",
+            "$TC filter add dev $DUMMY parent 1: basic classid 1:2",
+            "ping -c2 -W0.01 -s 56 -I $DUMMY 10.10.11.11 || true",
+            "$TC qdisc change dev $DUMMY root handle 1: ets bands 2 strict 2",
+            "$TC qdisc change dev $DUMMY root handle 1: ets bands 1 strict 1"
+        ],
+        "cmdUnderTest": "ping -c1 -W0.01 -s 56 -I $DUMMY 10.10.11.11",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -s -j qdisc ls dev $DUMMY root",
+        "matchJSON": [
+            {
+                "kind": "ets",
+                "handle": "1:",
+                "bytes": 196,
+                "packets": 2
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root handle 1:"
+        ]
+    },
+    {
+        "id": "0b8f",
+        "name": "Try to add ets class to the active list twice",
+        "category": [
+            "qdisc",
+            "ets",
+            "tbf"
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
+            "$TC qdisc add dev $DUMMY root handle 1: ets bands 2 strict 1",
+            "$TC qdisc add dev $DUMMY parent 1:2 handle 20: tbf rate 8bit burst 100b latency 1s",
+            "$TC filter add dev $DUMMY parent 1: basic classid 1:2",
+            "ping -c2 -W0.01 -s 56 -I $DUMMY 10.10.11.11 || true",
+            "$TC qdisc change dev $DUMMY root handle 1: ets bands 2 strict 2",
+            "$TC qdisc change dev $DUMMY root handle 1: ets bands 2 strict 1"
+        ],
+        "cmdUnderTest": "ping -c1 -W0.01 -s 56 -I $DUMMY 10.10.11.11",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -s -j qdisc ls dev $DUMMY root",
+        "matchJSON": [
+            {
+                "kind": "ets",
+                "handle": "1:",
+                "bytes": 98,
+                "packets": 1
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root handle 1:"
+        ]
     }
 ]
-- 
2.51.0


