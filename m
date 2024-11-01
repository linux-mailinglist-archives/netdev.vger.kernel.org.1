Return-Path: <netdev+bounces-141041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 799E99B9345
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 15:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F166E1F23084
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 14:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCC71A0721;
	Fri,  1 Nov 2024 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="QMUjBLIZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0FE49620
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471547; cv=none; b=uAP54niPfmd6gn3iJ7yGexTUD1UQ1kgVY1DFScfw3HeIcj5i0iyoc7wOtTx32zLT/ZWHW1r4AZ5XHRK9y32ezBP7MQO7pxrFBzyyshSWnEIP9ug/RCOx7l9a/FUDH86OS12cWTCcxZTrF5I1NojuDk4VRi3pt2hY1BRQuNDgOas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471547; c=relaxed/simple;
	bh=zRufYQTM2AyaUG/3MkZBNIjcR4kJ1MSCKM92Jc2SsTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gLwo0i5iUvAwq8Eawi6GKN5WwmH3Ji7oL5JIdMUrFVyw+uo/nTUmfAEX4fkVwaLYC8NuW4XfkTshKhpps89aQUdJIKVSwmgnSPOc63relH4QGVKC01E+ApSj1/qgF2EZXoiwIjcdjjcFH67ewdKsCpQufC5ngRuOe1M917dr0dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=QMUjBLIZ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cbcd71012so23930415ad.3
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 07:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1730471544; x=1731076344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gruszeIpxYM6GpwIDsKD9euVO3Z3vPd1Uc086E1jl5g=;
        b=QMUjBLIZ6Aked778FkpRgf5IglINFkqxiEqYAKA7OaT4lV4oUPFjNEV3zTYYXmZ7J+
         Mz33RM69FHIifQp8weOOVrlwC4OCmbUL9y9WbzJxZBCX1OgYuP2wpIEJICNmYgsG0Ia4
         oWFqycOJkHS9j9GdA7Purhtm9YtARMmufLf9vxiMYkcmqlPtvGxEI5YU5RvdzWv63q0y
         xPJ49F0Za2TDS/nSvt5ty3v1ANQECt3yjt1vivAE1QhUs+SUs0FHCCV3BAact9PbihAy
         7PVSROpyL2u+Cy2oNml3pyiWP0DjNZAb54YExu/VbNh/c4tRmT7yxFsAuDI9viGqiL94
         nvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730471544; x=1731076344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gruszeIpxYM6GpwIDsKD9euVO3Z3vPd1Uc086E1jl5g=;
        b=ieEL+n9w4v2o5cDcn5OrVrz14Ck7cYqwNonYwLHpdOEdgPJOGW0VVqFJi77TckHJqT
         t09fba8/R/3Top4BIrm6SLZaakkRSa5xTHwmJn34OcBdkMd8bRAyOrFN9oC9MdnJ3Vml
         22ooCOlFbNPEpBy+sxBcKs+sLRgr6K38NSH2XuS3nfhtV6YQFvN8uPVkhUNu50n7clOc
         SZazLdpJgS0tI2UZH1VeMtfTpBbYGeYgOYYSQ7ky/Jv6uZKM65xa2UzqvuayZ056HR7g
         LNnvYDpf1q/RWklXiFbFDoRIfxHGLYhoTClr2zEGHCUvOsqAMa4uaJYMxRAKNw7zFMpU
         QpqQ==
X-Gm-Message-State: AOJu0Yyli9A8r3WjZXn6zInsLpUaCNd0ouMZwXtYL/O/hagK6wXRhVaa
	Nyx2UTsFt4JYxW72EQ2/nYIgtsA0GqzX6sksZP+Pp2ob1Qj6kc+PxrwUDdq9A4UeO0k0+Lf3oqE
	NTQ==
X-Google-Smtp-Source: AGHT+IEJf1H/GvLhyEhHmZm/gVhBTi+P/f977a9UB1J2PxbHQ1I2inYwcwuyo3yIHhvEk7trWKFpUw==
X-Received: by 2002:a17:902:d481:b0:20b:6918:30b5 with SMTP id d9443c01a7336-2111af5a6bcmr42574355ad.41.1730471544449;
        Fri, 01 Nov 2024 07:32:24 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2110570bfe6sm21926665ad.109.2024.11.01.07.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 07:32:24 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next] selftests/tc-testing: add tests for qdisc_tree_reduce_backlog
Date: Fri,  1 Nov 2024 11:31:48 -0300
Message-ID: <20241101143148.1218890-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 3 tests to check for the expected behaviour of
qdisc_tree_reduce_backlog in special scenarios.

- The first test checks if the qdisc class is notified of deletion for
major handle 'ffff:'.
- The second test checks the same as the first test but with 'ffff:' as the root
qdisc.
- The third test checks if everything works if ingress is active.

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
new file mode 100644
index 000000000000..d3dd65b05b5f
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -0,0 +1,98 @@
+[
+    {
+        "id": "ca5e",
+        "name": "Check class delete notification for ffff:",
+        "category": [
+            "qdisc"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: drr",
+            "$TC filter add dev $DUMMY parent 1: basic classid 1:1",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 drr",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle ffff: drr",
+            "$TC filter add dev $DUMMY parent ffff: basic classid ffff:1",
+            "$TC class add dev $DUMMY parent ffff: classid ffff:1 drr",
+            "$TC qdisc add dev $DUMMY parent ffff:1 netem delay 1s",
+            "ping -c1 -W0.01 -I $DUMMY 10.10.10.1 || true",
+            "$TC class del dev $DUMMY classid ffff:1",
+            "$TC class add dev $DUMMY parent ffff: classid ffff:1 drr"
+        ],
+        "cmdUnderTest": "ping -c1 -W0.01 -I $DUMMY 10.10.10.1",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -s qdisc ls dev $DUMMY",
+        "matchPattern": "drr 1: root",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root handle 1: drr",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY"
+        ]
+    },
+    {
+        "id": "e4b7",
+        "name": "Check class delete notification for root ffff:",
+        "category": [
+            "qdisc"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle ffff: drr",
+            "$TC filter add dev $DUMMY parent ffff: basic classid ffff:1",
+            "$TC class add dev $DUMMY parent ffff: classid ffff:1 drr",
+            "$TC qdisc add dev $DUMMY parent ffff:1 netem delay 1s",
+            "ping -c1 -W0.01 -I $DUMMY 10.10.10.1 || true",
+            "$TC class del dev $DUMMY classid ffff:1",
+            "$TC class add dev $DUMMY parent ffff: classid ffff:1 drr"
+        ],
+        "cmdUnderTest": "ping -c1 -W0.01 -I $DUMMY 10.10.10.1",
+        "expExitCode": "1",
+        "verifyCmd": "$TC qdisc ls dev $DUMMY",
+        "matchPattern": "drr ffff: root",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root handle ffff: drr",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY"
+        ]
+    },
+    {
+        "id": "33a9",
+        "name": "Check ingress is not searchable on backlog update",
+        "category": [
+            "qdisc"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY ingress",
+            "$TC qdisc add dev $DUMMY root handle 1: drr",
+            "$TC filter add dev $DUMMY parent 1: basic classid 1:1",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 drr",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 2: drr",
+            "$TC filter add dev $DUMMY parent 2: basic classid 2:1",
+            "$TC class add dev $DUMMY parent 2: classid 2:1 drr",
+            "$TC qdisc add dev $DUMMY parent 2:1 netem delay 1s",
+            "ping -c1 -W0.01 -I $DUMMY 10.10.10.1 || true"
+        ],
+        "cmdUnderTest": "$TC class del dev $DUMMY classid 2:1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc ls dev $DUMMY",
+        "matchPattern": "drr 1: root",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root handle 1: drr",
+            "$TC qdisc del dev $DUMMY ingress",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY"
+        ]
+    }
+]
-- 
2.43.0


