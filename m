Return-Path: <netdev+bounces-236512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14133C3D6F4
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 21:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618111888354
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 20:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA96130100F;
	Thu,  6 Nov 2025 20:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="QlVuBMyt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459F52FBE1C
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 20:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762462599; cv=none; b=a27+Yc1RkkS2/ee9LOMf+iXQc/uUQ20Ism32kq50zbVdOjlh0W9R7aovCS8UlD4o4lc1Om/XcVlcDABv7YfDaAUIHRWwlkMrJJETlHz/DI/8d/DOvD3sNDYY/ik5OAyz/hmLObyjwRHXTEznPbfJYTfEV9uU+nUBFGmYJ4KXndU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762462599; c=relaxed/simple;
	bh=dEN23CuwFqIVItCyvEPcmeihvsj46UYx6wjvs6HGQLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anVsZ9yknDCeCH+4ddJPJRXJwkKdv0jrmyuauZfhSNz0vTeZXEPVdWsg0uDNXzE7P/yuGS0JPHi7FaSKPLNQLVF9Xxd68IRDU1ZjomNbp5RHIOHBUOahcaZjBiBiGSEBhFmJDmuxIfTsE2yY9+GRJWBe2CL57D8Wv0nG26DPf8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=QlVuBMyt; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso71193b3a.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 12:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1762462597; x=1763067397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiQMEv7FCQ+vDfen8wc21BKbC3K6agNtxTBynpXLD1A=;
        b=QlVuBMytJAq1Clw/IovjuCvZzXzopOVkBh44pXPyDLckNsni7bsTg9ovgsjRwHfTR9
         kIa/JVtU24BVE2oI+OVbY5U4X2lIr9q8ffIgUv3gAGPt3ulX0WzPZOfXJ3pryVcMtH/q
         PhV3W3+NOCsbmSLow41wqtuCUsj6lR1Gt3I4MRu95hyT7l1dh+W0ZJUHfQ3OyOhfUe9G
         gxoTdToYsApAo45h3qXGUEA5Csaq3gcY62cDIRm0nQUyoPn5R8LJIgaPGxQsY4aFBeiS
         m7FeYaMvwoov1cnSzJfmlAHu/6wE5ibcJipMiqHbm2uolDpWNRHTwNdA7xAYfISbUdzb
         Uaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762462597; x=1763067397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GiQMEv7FCQ+vDfen8wc21BKbC3K6agNtxTBynpXLD1A=;
        b=LVdE9JWaDS2esTFLTiLITKQOMNPZ2gFo/8iME0Hlodfbyu147jRLLHOMn4S8Z2N6cL
         MSWLroWmO/6bNRAxpdtgifwjuhQ3zPx8tASY4oUYrV2YcLNhIZhwnVms03T3MxzsqrIR
         C1CqnavuEiw6zHXOgMNvVZEWWC6p7W/NrIJnJn+bviOKOAQHsIvDvUASLa1sHjws5ABo
         SCUbJeMqO/I7bBVE2KK0TL/FIoMQw5XMcTBmtOCOWVTiSe0gTXugE2dMa1UM1Fmd2osS
         XQDJa0J+BSfZyWSe8vCQQJb9hrRhHAsZLd9vYcwCTK2UDhN3kL0oD4yQvFOVQbUY06JT
         Wryg==
X-Gm-Message-State: AOJu0YyDreIYMnnHxOTQkANF3rWRvd7oVNwTdWjTgktZymGVH30nptD0
	oaMiMFkBCZX0ZrPbjhuoA3SLui28cQ8qgV+r5K0LlDfe5qa6URIKj47zfxbClwVmLw==
X-Gm-Gg: ASbGncto6OwN02z9/LrCJSzYglcZH0UKJvl2X+Gp9IRGCzxx50NzKtloyZywpfI0GsR
	M+kjJEHSsJfnmUt6UKYqWz7ayn4PnRX8CPcn4gW+GTW809Xg9gSc0qPwnEvSatDo+XoijfADtT1
	6nqI0+3hY/fXge6+Y8/nUVqVzxNO1oKEbSXJdIGHPmLPvO3FWMeFY/gIXSQvxF1Ech5ZSDt57nx
	kEDJyyqIVm2b8ywkoTAcxthewosUldKjLoO5WKpcSA/dQLquIOFOnNZYVKj9KUyzEStEt11TPCQ
	B1SXJIS0V0mJ39x0c/pnMkmCyEfg8Ta3YTx7ljqSMN6pYHTTSIwmzT58fKe6x5e/HBNE3R4Twbr
	zvljfpP48a2aZcJPjm6LLg4P72wLkvS0gRyTgJn6Wx5UL9Ditx24u3+xNbq3/CXOh+d58zjmkOG
	9s2OqnxYxC6gQlTyujHw==
X-Google-Smtp-Source: AGHT+IHR9JQ6Fm9D0iqBL5/W/u0cA1i0U+FmCRjoafHtv36Wg9kKVCMH6x02Ezb80Fzf04vXReh6Fg==
X-Received: by 2002:a05:6a20:2447:b0:347:8414:da90 with SMTP id adf61e73a8af0-3522556f055mr1189321637.0.1762462597511;
        Thu, 06 Nov 2025 12:56:37 -0800 (PST)
Received: from exu-caveira.tail33bf8.ts.net ([2804:14d:5c54:4efb::1c9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953cf79sm490735b3a.3.2025.11.06.12.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 12:56:36 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	wangliang74@huawei.com,
	pctammela@mojatatu.ai
Subject: [PATCH net 2/2] selftests/tc-testing: Create tests trying to add children to clsact/ingress qdiscs
Date: Thu,  6 Nov 2025 17:56:21 -0300
Message-ID: <20251106205621.3307639-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106205621.3307639-1-victor@mojatatu.com>
References: <20251106205621.3307639-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In response to Wang's bug report [1], add the following test cases:

- Try and fail to add an fq child to an ingress qdisc
- Try and fail to add an fq child to a clsact qdisc

[1] https://lore.kernel.org/netdev/20251105022213.1981982-1-wangliang74@huawei.com/

Reviewed-by: Pedro Tammela <pctammela@mojatatu.ai>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 998e5a2f4579..0091bcd91c2c 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -961,5 +961,49 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY root"
         ]
+    },
+    {
+        "id": "4989",
+        "name": "Try to add an fq child to an ingress qdisc",
+        "category": [
+            "qdisc",
+            "ingress"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY handle ffff:0 ingress"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent ffff:0 handle ffe0:0 fq",
+        "expExitCode": "2",
+        "verifyCmd": "$TC -j qdisc ls dev $DUMMY handle ffe0:",
+        "matchJSON": [],
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY ingress"
+        ]
+    },
+    {
+        "id": "c2b0",
+        "name": "Try to add an fq child to a clsact qdisc",
+        "category": [
+            "qdisc",
+            "ingress"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY handle ffff:0 clsact"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent ffff:0 handle ffe0:0 fq",
+        "expExitCode": "2",
+        "verifyCmd": "$TC -j qdisc ls dev $DUMMY handle ffe0:",
+        "matchJSON": [],
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
     }
 ]
-- 
2.51.0


