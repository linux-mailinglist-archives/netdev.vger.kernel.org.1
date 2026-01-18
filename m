Return-Path: <netdev+bounces-250812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD995D392FF
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 07:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3439030313D1
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 06:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D36C25A655;
	Sun, 18 Jan 2026 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEstva3T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A396825782D
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 06:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768716969; cv=none; b=IIuDFQSAEK2M1Y7hh17Og95SSa8LeiVBakOOBiXoQx1I4G/upYRh0N+cyhv0yjiHQBoYUtrEc2VG6p5N0SgC7OHlmQ9YLkjmY+z+OjEWXodjiT0+rAWlkqhCf48rpJphDjV22f5Z1ET9op/YeLrSp6QdE8anoXLZuWqlYojQmxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768716969; c=relaxed/simple;
	bh=DBOq4L22sMfrOVztnDSGgV1hqG3ovoQlje/7XDt10Zk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qZRlPqpi4mzCwglbb0P4DwdA94s0KwoezpIf8TZygZpgL5JVVwFHaegR6sI3rs+QmSrF5s9yP55Vs+CErdZp9vYGmclUlp3ZPJ43fRcm6w8WlwCIIfn2xXVH6/IfX/2Rn5yGomlGwv9bGsEieK/qLi8+zEoSOlVl+g+Zt/Yca4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEstva3T; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-121a0bcd376so1333921c88.0
        for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 22:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768716967; x=1769321767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HWUCUWLvZ7C8IVhP2F6eYvFno3v/qDzqWhnBiwvgDY=;
        b=AEstva3T3aGvRkTACfB46PmOb8B2y6XE+b+5vE1a3eG3TeAxUv3z5a8wo/zQ6//i4q
         9GDh51PBpRfhkGnbLpmbns5tBvarfkpB4AH7T0xKCLY9bQzTCP+rftv9xqj6W5iK50IU
         y8VBq3xPjzmpjy8LD1FxOuxzSYLMSkYbJsyqXJ13lzZeqMdn7R/4qS9D7/xzJq8cRxb0
         FB3jK18kA2/ZhD/ADep4gGq1jausnhn5RzoyibNPGn6ptiDFNR5P9O3RV9np8j3g/b3n
         BhBAUKBAXlukFXPa2Lh0cG+5lGp1h70rWO+zDacZE1AnGkH2NCORrGAiuEli3fNkd8U8
         3k9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768716967; x=1769321767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6HWUCUWLvZ7C8IVhP2F6eYvFno3v/qDzqWhnBiwvgDY=;
        b=GOfjCt6ixKm5uGYODDZ4nIdk852VRxiGOk0U4ATruSheVXROQlZhhxUZgfF5FHq5c3
         JZoD0KRzFTzDPmnLfcWFQtmttFouQw9b7FE+qeGyAz5XLFfH5WT26UV4mrpoCEabcL4F
         Hmg3oNCNTDRv/woAazJ1as5cUxfs9O4o0+LoOPGZKZvKsv6wuyGkxnaKK1vLjJUYSyGl
         k/Z4DY1OOZqGmXFATgOqDRy4SnOwR0GanxTCRwJ+bthu0bdkaWWfDL11+VaP1ZAEnX6U
         7YTXppL6jWrowgTOpD6LoPCsghCzBcB4aq5WGY8IfZy7NIqorm7fDrdYCiBWGKjcCJem
         JMcA==
X-Gm-Message-State: AOJu0YwCDedv6eQ5xcqZfbqko52c2kobjHzADrRx9YZL3DmaMfGf46/3
	69jN+qCqqPkhDZwT1ouvNrbd/aKxc50Qlx6kRttNY/NylRDBEdZWFGA8AHlkuQ==
X-Gm-Gg: AY/fxX5amREXcobV0eSxHrvwZMjuM4iYWINf6PHGrdvLmPQs8ZV0p7SKrLQO1AWUhg9
	603bGrUiEdgvzkwPd3qHBpE1VNKPc2Fe/vg2gvTHwGs30OLFm9C1ek/JiNyfqp56a1SACI5cWIu
	X5OMEn2ba/E49FDauropImE3RXwBlNlxZP8q8RjfTmxtqfgxOyWhNlZOlhKdvibWYC8a/3tqDnL
	W+BOsVZ2P74pekcdbUHqCHjbnZfdsJykz2FToywxigKj/n0/74Ssk3KJBEFvKLC6HqDAupo1keb
	aJIxWAXbR409XArE5WxvbV230ccCZ2h9TDmeULvPG20CjifBa6NarHmUuSkXdvRyTCHfuo8QfQ8
	QWiqvJuxKdpxEe+68GgunUm2ojInt0DWi8GWpAJ9rKgj4IOdPAMtzyhGjq/gizl1lbKUCnWWDCv
	VpIhdHdas+/xiiN69c
X-Received: by 2002:a05:7301:678f:b0:2ae:4fd7:ba56 with SMTP id 5a478bee46e88-2b6b4114fe9mr5296271eec.23.1768716967226;
        Sat, 17 Jan 2026 22:16:07 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:8fdd:4695:1309:5b93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c65sm8163816eec.8.2026.01.17.22.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 22:16:06 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net v8 6/9] selftests/tc-testing: Add a test case for prio with netem duplicate
Date: Sat, 17 Jan 2026 22:15:12 -0800
Message-Id: <20260118061515.930322-7-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260118061515.930322-1-xiyou.wangcong@gmail.com>
References: <20260118061515.930322-1-xiyou.wangcong@gmail.com>
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
index ceb993ed04b2..b65fe669e00a 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -961,6 +961,35 @@
         "matchJSON": [],
         "teardown": [
             "$TC qdisc del dev $DUMMY root"
+	]
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
         ]
     },
     {
-- 
2.34.1


