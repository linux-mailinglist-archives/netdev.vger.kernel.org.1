Return-Path: <netdev+bounces-250814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C27BD39301
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 07:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A5D73037CF2
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 06:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AD325FA10;
	Sun, 18 Jan 2026 06:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwLt95ib"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8002309AB
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768716973; cv=none; b=KqYf+P1xsGWDXYOrHSiAwi512HOLt7M7ebohNeK333quQNsI/6sNtWIsU9dJfGhtcB+7njVTrQk2K8DCPIL31RQQAC/j0MkrfNPWmovj2sUWIsDcZm/lyoCtoo1CA6D+116dh5aEapDXX5qRq1ybIUD7zX+cEBQ0o8NwlhEgZnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768716973; c=relaxed/simple;
	bh=wHfxkzR0h3438LhGsyDy1mEIBWYx732C2BPFv47SFac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SLHujC7ngPMwkOWq3L+tb4C17a9pNEWWSV/TBTHK2wo+eg7LOCX9E+qS34N9XyfTyeJDd0zQlLfw4+3Zf8UJztljuAtguNrx9hMhZpMt8QtPwtoxczR9HoJH6Uze4v/QQviBjkFlS+j3DAdYHFlyd69nW+UAJDDH8IlsoU8geJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwLt95ib; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12336c0a8b6so7214365c88.1
        for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 22:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768716969; x=1769321769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+v3zRljF9F0bGLuoenrkyjbvLMjC//WhzqSKh4DF+88=;
        b=YwLt95ibvKHV1gFW0CmOk3crNoueO75x1HKfARiTF09smsM5ZHI/+7F9EsTgk6achV
         QWyiP0245HTkeD95uxmDIiMRsQh4+f560z4/KE2Dwi3cUvZePvvOCX/k4wmrIWmWh2eU
         xm/9C7OAq1HN1f4C6E1tZxUqqljCbeIOwV1joKO0sv+TP+odosu2Bcg65HT/UASDUKlV
         udfZkm1GricOoZ2u1MdfYpUCC/1WiEkpKaDdpxFZ0+K8t5zVwn+2/QG2PX9wVO6aVSv9
         x6Lepre4//LDoVuxxJ/r4DGs2mmot+wGIMJ0ogg5mdRoqy1v0DV1T91Z5xXZPY3HpGFG
         adkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768716969; x=1769321769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+v3zRljF9F0bGLuoenrkyjbvLMjC//WhzqSKh4DF+88=;
        b=tSr/nS+e3EekyINr+So4KOHPhw3P3bkQEjQ/GT5jItlurhZ294ATuznDiemO7TXe7o
         ctXmLxM/6GG1mWPgwVdSNRRSSkMp9mim6g6ttRnuiupW5p7zgfjGFrEsdR+iH5+TOGqB
         OVKbWlR0WCMDgPkSsbZ8Tyt/d2RrItYWKhr4yl8dk+fE4yv8kMiIX4L5M7jVRvIVLCwa
         qQFo7ilE7XdmpWRLGp3kpAMqMDESS8IHWN1D/hh+JAsSw2zAMIwFRXHep3SvexJbRQcy
         jPD4mMeZX1h6ykd4YVXGBDfNiXi42el3/nV/O+PWPywXzGZ73t3VqyrOLiE1xozLc9ck
         9Xpg==
X-Gm-Message-State: AOJu0YxZokV1LfYvDrCySdju4uRA3hi/PJlUveFzQDLTyjCuXKszcRBt
	BVA0wK/ugB8qkdsCKaW4a5dCZ6Qsl7IrQSADzEK+wnUD1vrC9msznyWQ8zGGNA==
X-Gm-Gg: AY/fxX6Aol/yAsgo1n4477P+guP/hK3z6JG3D78x1YyWukFBfxuxSUPXdFg70ScAkPg
	TzpZtQAm5WNzF0NIjPrOMb1yCwRn7oNr4/5dfvjKv0GUfWoTK0elAqC1btbpRpwx39TTn05EqWM
	ti7VACYY5swh+8eZ8XFlmOZ0b0ISQlLsEP7cv+/XiBbb2gkmFhiLar+05fJRRVGfyopLXcBUCY4
	OSH0yeFaUg1QLjmIoTMpNe2n30kLM4gI2xnCbnwOqkNCNcO+EVoJhm3aswRwx1i3oEbV968zNxY
	3IXoIVBuyFRgVAt97AbeErlZpeNpFNJ4xFOAqvX2ZKaHxqq+SSSF85TPHVl6cBakMO/mlWA30Tj
	1dfTnv+L2MD84FS9jBfdpxlLcE85V5ML/6svIIRprgf53HHI1CUDe6IkWnXV6gQBJFmaOBmJFeO
	2+5U+EzXfJeepIbbvC
X-Received: by 2002:a05:7022:225:b0:11b:9386:a3cf with SMTP id a92af1059eb24-1244a782252mr6842827c88.48.1768716968998;
        Sat, 17 Jan 2026 22:16:08 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:8fdd:4695:1309:5b93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c65sm8163816eec.8.2026.01.17.22.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 22:16:07 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net v8 7/9] selftests/tc-testing: Add a test case for mq with netem duplicate
Date: Sat, 17 Jan 2026 22:15:13 -0800
Message-Id: <20260118061515.930322-8-xiyou.wangcong@gmail.com>
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

Given that multi-queue NICs are prevalent and the global spinlock issue with
single netem instances is a known performance limitation, the setup using
mq as a parent for netem is an excellent and highly reasonable pattern for
applying netem effects like 100% duplication efficiently on modern Linux
systems.

Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index b65fe669e00a..57e6b5f35070 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -1141,5 +1141,36 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY root handle 1:"
         ]
+    },
+    {
+        "id": "94a8",
+        "name": "Test MQ with NETEM duplication",
+        "category": [
+            "qdisc",
+            "mq",
+            "netem"
+        ],
+        "plugins": {
+            "requires": ["nsPlugin", "scapyPlugin"]
+        },
+        "setup": [
+            "$IP link set dev $DEV1 up",
+            "$TC qdisc add dev $DEV1 root handle 1: mq",
+            "$TC qdisc add dev $DEV1 parent 1:1 handle 10: netem duplicate 100%",
+            "$TC qdisc add dev $DEV1 parent 1:2 handle 20: netem duplicate 100%"
+        ],
+        "scapy": {
+            "iface": "$DEV0",
+            "count": 5,
+            "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+        },
+        "cmdUnderTest": "$TC -s qdisc show dev $DEV1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DEV1 | grep -A 5 'qdisc netem' | grep -E 'Sent [0-9]+ bytes [0-9]+ pkt'",
+        "matchPattern": "Sent \\d+ bytes (\\d+) pkt",
+        "matchCount": "2",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 root handle 1: mq"
+        ]
     }
 ]
-- 
2.34.1


