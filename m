Return-Path: <netdev+bounces-206462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E853B03325
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 23:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E7016F4C0
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 21:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235401E7C38;
	Sun, 13 Jul 2025 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIyXvteB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948CF7DA6C
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 21:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752443293; cv=none; b=AzYxnz/5T5KB+xeiU+UXmHRNgBjlFcwnafSMcegrjvqkK/fimZ5in12tXrRu23OQiQGwwR43upDIPoT0pa9MyUwp3KCxJCEuj5yGjllYOCT29Rnr+9O52fE+bG84QMsY6gRc/EVz9yl8dvn57BsUvzwtW4yP6JsIfB8hEzaKnBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752443293; c=relaxed/simple;
	bh=OEBkpM+3ZTLSNYSrQN/uNlvIweIJ1jNUpKIsoe4o5Rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JQC17zTZg1htsw2DLo7q0C2iAtRZhLG0isj2ROYDxId70vwXfU+6u282LZTvCCNMyofBqNe3Oh288P09p7htw8sZ7+wewLLpxXPi07uh/OATiIAA9rfw/cZumNMNFzXjD8aMXP3tAqx2+PyZnGOtwHT9Cbvkt/b8vJeWfWSNy0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIyXvteB; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74b52bf417cso2324151b3a.0
        for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 14:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752443289; x=1753048089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJGbRnejhIRcsQWbq3T7kI+xG8r532bfdAYXX+F13jk=;
        b=cIyXvteBEU//Ty+LMsDv+Fkzk/Gb9WveGSpxmp94t+ZYWS5JE83DdAZ4hriFLRXoyx
         1tAY06cBP08kufxHXkSSxcokEQvVjU5BVucsTM8stXS2CofXx3eQ+QwRUr7H+h5+nRUL
         clqpMAmMdgEy7HWmOqsx7mPAnjRFZzNldBwjX9dIDdjHcn2FV8myHb8b10F+8O11M7ME
         g3sa1hekS5Sj8U0PUJEo64sd/U0BDLL1OpJoB0pA2hvnaKGc1YD3vuL1nNozJ3KNCBjk
         NrH3+WuZ4SqZXI+pwuqf96rY1M+GvIQ3RQRn9cvVXRnpLfjd/bwqJUDJwnxyY9TlOoph
         JtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752443289; x=1753048089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJGbRnejhIRcsQWbq3T7kI+xG8r532bfdAYXX+F13jk=;
        b=YHIVHm769prrdFwnJJKP01rCTQk8w4v2yc++01mnqMQZm99IAronXD1Tp2r8zf/snb
         CaaHw0+xBqX1/LJGuLQXyTUKm7VU/D/yY7H6UL2inLBsyoNdqpC2aIMKjK7ZjkK/7/MF
         hOQ+pQ83mimScxjSWbUFNvXvLUzGhpBezG+eRz8De2wQSTO3FWYXBfFtXBk+XoYTEECw
         JPsMLXIH3QPm0tMXT/HfqwdY9k7CWkxTHmlpqYwphc7daCdJIfk4dVZ4leblLFOOQMIk
         SgnDyXkPZkelcLdjySDs62lwMcA9zcEQjGBVKdCsOUtYleQOSE8nwN7NcG27Bt7a7xLD
         XLCQ==
X-Gm-Message-State: AOJu0Yzb6A63YFE75vrPDk4QezVBMpxb24w3+OdPmR4lU0krL0uqU6xE
	ZcNO6V8lPtVCA0VCIAgTijIP6Rz2vVuerOx/NHNDD0j53thJ0jqTiPJLlc48Gg==
X-Gm-Gg: ASbGncukDDbMfRphVhwTxzK/gO/+rPIEhf97NvbumOY3Tm3RcUG3NgaFwwTStYEd/ev
	BYcLX9PGsfd7tVxdUDMSAadGZttjxBkn6sXFS9ZxeTgfiboflf4gWX2isandCZf1wopfW0MttJm
	oCy0136MzE3/Tk41jefBBLhRYPQ0Zlb4odxaDRpPiFNrgiIaghbG3QLFtWk5E6LuQHsudaiNhza
	Sa0nfvJgrfVYWcTJWlQgN9ba9JkWiaHkyZWDT+wNYvXycgVj4chw/Uc4I9xy3g3PvEPUDuVyCkN
	S6279WK2/4+7HhiWcXsqih2GnjL3cL8kKQcJ56wauueFQXYqQ14CjVrOkvBzumV6JGeoA+buUKx
	Iy/7hjg3YJde8rtgtT4HG6sO90xo1/Z9IT9McQQ==
X-Google-Smtp-Source: AGHT+IE0J6E4/6jsTJaxldK0rkGAoHLTzC76QzuUDTWVPtCf6MFFSVoCeVLNhRf26LIqbytwIulzSQ==
X-Received: by 2002:a05:6a20:3d21:b0:220:96:11f6 with SMTP id adf61e73a8af0-23121107488mr15902144637.37.1752443289245;
        Sun, 13 Jul 2025 14:48:09 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:b9d2:1ae4:8a66:82b2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6f1fd0sm8628370a12.53.2025.07.13.14.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 14:48:08 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	will@willsroot.io,
	stephen@networkplumber.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch v3 net 3/4] selftests/tc-testing: Add a test case for piro with netem duplicate
Date: Sun, 13 Jul 2025 14:47:47 -0700
Message-Id: <20250713214748.1377876-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250713214748.1377876-1-xiyou.wangcong@gmail.com>
References: <20250713214748.1377876-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Integrate the test case from Jamal into tc-testing:

Test 94a7: Test PRIO with NETEM duplication

All test results:

1..1
ok 1 94a7 - Test PRIO with NETEM duplication

Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 5c6851e8d311..bfa6de751270 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -672,5 +672,34 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY root handle 1: drr"
         ]
+    },
+    {
+        "id": "94a7",
+        "name": "Test PRIO with NETEM duplication",
+        "category": [
+            "qdisc",
+            "prio",
+            "netem"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin"
+            ]
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: prio bands 3 priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0",
+            "$TC filter add dev $DUMMY parent 1:0 protocol ip matchall classid 1:1",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 10: netem limit 4 duplicate 100%"
+        ],
+        "cmdUnderTest": "ping -c1 -W0.01 -I $DUMMY 10.10.11.11",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY | grep -A 5 'qdisc netem' | grep -E 'Sent [0-9]+ bytes [0-9]+ pkt'",
+        "matchPattern": "Sent \\d+ bytes (\\d+) pkt",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root handle 1: prio"
+        ]
     }
 ]
-- 
2.34.1


