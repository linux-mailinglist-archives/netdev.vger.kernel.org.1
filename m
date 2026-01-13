Return-Path: <netdev+bounces-249557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3922ED1AF13
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 20:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F6903011452
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8B23587AD;
	Tue, 13 Jan 2026 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOmuOLFM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA433590CD
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331218; cv=none; b=a/7ThbluqaeN2GCOcUos1+rLI+spQl2liXXKU/FoRO/cSc7mhDWlrqgcsCI9+m0JMBHLoUqOTYMQDqTjY/cRLwt6N4qCpFy7ngoT5hsSGddN+Dm76uICfw/w+IfwS0r/xNMPneZHpcRShelxx9g04qzBeCOJ3fkp/7fszRltupc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331218; c=relaxed/simple;
	bh=Qwl85HvDxQe/a8kcnWvN0O2PXy6OlUXBrJZzAhjRaWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KxmIGElxcIQzstPh1OB1q0TCDCQwvZDi7W+IZym5inNB8Rsc0ByRT467ZGBvvCga5m4TU4ZQiwAfmATf1QupR654iCF1YyxXi32GhRxsaLbvS0fv+fabFmmOtWpRKdmDmcVNB7FLWBf6ljH78xb0GE/Bh2ecxi0OjRXq0Mg8STY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOmuOLFM; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-81f4ba336b4so2409202b3a.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 11:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768331216; x=1768936016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOSBqIwlOUTuQQ2oavZzevh4mS3YmYeB4Bu0irJ5cxg=;
        b=nOmuOLFMca9c6wPR/T8xu10Qft91dteFf7gHYNbAJgOOD7+93bLF8LpdTZuFq8Qkt7
         3axJSXCHMNiNe9kAFKlKchb8Ncxzn2RrxMBIixr8KIv0kB/X+7I+pfbTnHvwbcN7/q5K
         noXkAEIFgsQR/ckvsVd+sThfjGTT5ez4ePAg+UAGrKTMln7Gbs/Tte7Ede3iz0PwhSRi
         Iz1UqztwDwGyajGUNHsm/J69So4AJCTK9XWf/CQMlykOj1yg83EMDZV9bDVxgbtZYsAB
         yXJIN+SjoMdJU0X0o1erc5A1nlYi3/cdPpSqRd+8GVYmroC224RduIkl+jhHNAwHYIU5
         8R+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768331216; x=1768936016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IOSBqIwlOUTuQQ2oavZzevh4mS3YmYeB4Bu0irJ5cxg=;
        b=PzlqR0zE3tEB8zchb7xpjP22Koju1DfWll9TKvzhCQv8RrhUuYCmVJn9G9Itsw8+Ni
         KuDUSQ/WOBHth4mUt/lzI7q9wthJ1tyEXnYi7ZTdXWOonL/2lM9B6ulVr+8r/1jIjjSA
         S9c52tAfwkGFmqSTirjIUK52Eyqk8esWBPrKoztOk0a4m0PSpnB00YWbcl3VAqu9q2cY
         bR9pCa+XZ9NccLkYsy9pYTbkR7CaS8Oyo5581VXpzq4QP3ge1cc7T1XIE6XAs+a5Hl2T
         tE4VyeDPSD8+dqmn6F2HWwcGBExzikK72XKAe7yHzSs7/FvfRmVI3/8vaznbwRb+simq
         jbNQ==
X-Gm-Message-State: AOJu0YyYDgRdSANkK6HGin8KAkXZBtAYR90vPv9PJ4bMKfUJg0sL2OvR
	j2synHd8IS0z0o1KA8d9CU6Xqcs5LcDcEktG0kT4/EMkYLbbcD+hU4l3E/vnLA==
X-Gm-Gg: AY/fxX4Qt3pPizFvcMH687N7ZuCF8C7xQZaVkJxqoQ335ZPZxaCY7ZvDFUn3mN8gMxg
	a0eUnEkdGzLsEhTNPTYbfRPJB76HIhjZ9RAJKr5gPN5JIN34h/Tj2Zj94/xKWsAmiaWmZuXm9Ge
	RtvgNyg4ZWhWp0FIbvjAb+X9uay3u8PnMJtvMPsp2LTXsIM/Z6N0ACU/wBA7Z0fHpH9gr0sysXE
	eD7RPC6BLjY1TiuNjuM0uimlysZdO22X1v23B999FmExveGJ3jmHGEXVm5XIkRlJVkiOhe8Th2T
	ZXrrRY3/DcFrb9Gbyn/rMLTKOtBq5l/BFWKjpFmM8PDKYlrDe/bZD/DNXNb3LqDnmjny3/AdkSU
	D3Jj/4SPpqZQ7Bg6MdGOXvPbs/Tbmfl8GZwsxjxi4bmh5AiSNb1fOCPJp8VCvImEWynViogZteN
	KGOM5kpUWRi22chpXZ
X-Google-Smtp-Source: AGHT+IGYG/CjQTd/88fTB+ra3zBsMf6idl2r0TrIbx5Szxcm74fOnHKMnX6MuDz+48VanBdwqzsTlQ==
X-Received: by 2002:a05:6a00:35c4:b0:81f:4063:f1ef with SMTP id d2e1a72fcca58-81f4063f455mr10549958b3a.54.1768331215873;
        Tue, 13 Jan 2026 11:06:55 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:7269:2bf1:da7f:a929])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8058d144sm187780b3a.51.2026.01.13.11.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 11:06:54 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <cwang@multikernel.io>
Subject: [Patch net v7 3/9] Revert "selftests/tc-testing: Add tests for restrictions on netem duplication"
Date: Tue, 13 Jan 2026 11:06:28 -0800
Message-Id: <20260113190634.681734-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113190634.681734-1-xiyou.wangcong@gmail.com>
References: <20260113190634.681734-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cwang@multikernel.io>

This reverts commit ecdec65ec78d67d3ebd17edc88b88312054abe0d.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     |  5 +-
 .../tc-testing/tc-tests/qdiscs/netem.json     | 81 -------------------
 2 files changed, 3 insertions(+), 83 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 6a39640aa2a8..ceb993ed04b2 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -702,6 +702,7 @@
             "$TC qdisc add dev $DUMMY parent 1:1 handle 2:0 netem duplicate 100%",
             "$TC filter add dev $DUMMY parent 1:0 protocol ip prio 1 u32 match ip dst 10.10.10.1/32 flowid 1:1",
             "$TC class add dev $DUMMY parent 1:0 classid 1:2 hfsc ls m2 10Mbit",
+            "$TC qdisc add dev $DUMMY parent 1:2 handle 3:0 netem duplicate 100%",
             "$TC filter add dev $DUMMY parent 1:0 protocol ip prio 2 u32 match ip dst 10.10.10.2/32 flowid 1:2",
             "ping -c 1 10.10.10.1 -I$DUMMY > /dev/null || true",
             "$TC filter del dev $DUMMY parent 1:0 protocol ip prio 1",
@@ -714,8 +715,8 @@
             {
                 "kind": "hfsc",
                 "handle": "1:",
-                "bytes": 294,
-                "packets": 3
+                "bytes": 392,
+                "packets": 4
             }
         ],
         "matchCount": "1",
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
index 718d2df2aafa..3c4444961488 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
@@ -336,86 +336,5 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
-    },
-    {
-        "id": "d34d",
-        "name": "NETEM test qdisc duplication restriction in qdisc tree in netem_change root",
-        "category": ["qdisc", "netem"],
-        "plugins": {
-            "requires": "nsPlugin"
-        },
-        "setup": [
-            "$TC qdisc add dev $DUMMY root handle 1: netem limit 1",
-            "$TC qdisc add dev $DUMMY parent 1: handle 2: netem limit 1"
-        ],
-        "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 1: netem duplicate 50%",
-        "expExitCode": "2",
-        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
-        "matchPattern": "qdisc netem",
-        "matchCount": "2",
-        "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1:0 root"
-        ]
-    },
-    {
-        "id": "b33f",
-        "name": "NETEM test qdisc duplication restriction in qdisc tree in netem_change non-root",
-        "category": ["qdisc", "netem"],
-        "plugins": {
-            "requires": "nsPlugin"
-        },
-        "setup": [
-            "$TC qdisc add dev $DUMMY root handle 1: netem limit 1",
-            "$TC qdisc add dev $DUMMY parent 1: handle 2: netem limit 1"
-        ],
-        "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 2: netem duplicate 50%",
-        "expExitCode": "2",
-        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
-        "matchPattern": "qdisc netem",
-        "matchCount": "2",
-        "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1:0 root"
-        ]
-    },
-    {
-        "id": "cafe",
-        "name": "NETEM test qdisc duplication restriction in qdisc tree",
-        "category": ["qdisc", "netem"],
-        "plugins": {
-            "requires": "nsPlugin"
-        },
-        "setup": [
-            "$TC qdisc add dev $DUMMY root handle 1: netem limit 1 duplicate 100%"
-        ],
-        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1: handle 2: netem duplicate 100%",
-        "expExitCode": "2",
-        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
-        "matchPattern": "qdisc netem",
-        "matchCount": "1",
-        "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1:0 root"
-        ]
-    },
-    {
-        "id": "1337",
-        "name": "NETEM test qdisc duplication restriction in qdisc tree across branches",
-        "category": ["qdisc", "netem"],
-        "plugins": {
-            "requires": "nsPlugin"
-        },
-        "setup": [
-            "$TC qdisc add dev $DUMMY parent root handle 1:0 hfsc",
-            "$TC class add dev $DUMMY parent 1:0 classid 1:1 hfsc rt m2 10Mbit",
-            "$TC qdisc add dev $DUMMY parent 1:1 handle 2:0 netem",
-            "$TC class add dev $DUMMY parent 1:0 classid 1:2 hfsc rt m2 10Mbit"
-        ],
-        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1:2 handle 3:0 netem duplicate 100%",
-        "expExitCode": "2",
-        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
-        "matchPattern": "qdisc netem",
-        "matchCount": "1",
-        "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1:0 root"
-        ]
     }
 ]
-- 
2.34.1


