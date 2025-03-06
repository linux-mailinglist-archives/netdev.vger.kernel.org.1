Return-Path: <netdev+bounces-172674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223B4A55AE1
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943B53AB60B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A2A27D79A;
	Thu,  6 Mar 2025 23:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aK8atd/B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F0A27D767
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 23:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741303456; cv=none; b=rMQzBnl+SgfzZXO/zoTr18ma2gt9cNAh9VVysp9a4w3vkbc4NJmjE0kXNXa0t1LOCQQsUM1qr07ggqJ8EdG6B55SNo2Cv1/TtDYkr6pHBnptm88jcq0kqP6zGC8gfeyOFKRead5LNTAr5sW5sXyX4yfz3vXp9O0ejijMZGNKUh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741303456; c=relaxed/simple;
	bh=h7zsWmPw/ZAp7ZE6PcgGAaUrxV9yuqKpQ627UYPDPLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sM+xl0GSKOTzcczQl7OE2w9rnS6sxApFWHpiGBq1NL0q59LvM3rCYuLertoI/d+mc88o8YzPbwIejttVydhrpR5FDeFu+oKdEqn08t+K0+e5V3MgEE+m8JE8mJrPcx+N+WbFqwiu7+ckEWtyB0kogKQxT6ijvMQlsBn6x3n644g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aK8atd/B; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22398e09e39so22533795ad.3
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 15:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741303454; x=1741908254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Du2bf7iLccP8Q66qCe4LabRrZJTCPf4bRAGzHPjVU8U=;
        b=aK8atd/BNVFu5GtG+ompxK6AC4dwWqt8xhh/0nPMMs/nIYRZj9ry39QhYUGAhUj+Cy
         UguAyxcnaMVRPFVTqhnXfRhpQCwKaj/YtG3UWBNLIeU6GwfyYKSpz/Nuj2ubi5dIqDEx
         Cdqsn4lAkPAN9XXLVA/RXfB5fNc5O9Z/UJY32AYShStkFognTGZu953QB9IrcT2qL/LH
         OEGMKGCr48iGuqsBUjWsjMJOWVVJwSoR6oZcXGwvNGKR/GJ6s0cqmN0PyzIa85PcTKps
         DtSLAA8LDa9QZI+b4C6APLK+KpL+6xUN+Le+wD6j5dmB0fovBkZqCx0luNL8tmW+heLr
         eIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741303454; x=1741908254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Du2bf7iLccP8Q66qCe4LabRrZJTCPf4bRAGzHPjVU8U=;
        b=TEIPTWo44MxTJj37HoqOh9M8PN0TlNnXgmkI+nRdHExHvBatg/SG3xSEn2SCtu3RCN
         GfqAZa2QXTbqLYKwec7e7q86PUsKm9H+y83d0wZ3JIc1Wt+yAzPPpRQP6vNYMI0p25dt
         GwESWQGT2Ta9UEO9ckGyLxwedegJDYxo41PHWTVpu11Wcie1GydP87as6An6goNKFe38
         MXVHILx0SK+QXwuP2ECrl+40jClOddqvxRTdHTwgOsMKr5FLG+rl5aKYYI741Jnr4fAb
         TAVtKtdMlp19MVkk2hEKR9or+TQKNUv2E6TAx5s5bEzulKkW3Nj4E46EkVd9lpse9WU5
         zVZQ==
X-Gm-Message-State: AOJu0YzezGlxM1/1eUqCHAkNAz8aUJZpKKwuTtJuPlAkaxeC2ufDqOGZ
	+uHLlclyUhg4iWQqnyYK93Zf9WYcSsOvTG1YHDjtkIrbBA3TJi5T6z1rGQ==
X-Gm-Gg: ASbGnctTiOz4kV4njAuCyaOPx4QFHUhKVnsMrIeE3HGt8CZq6XdkQLOaE88LawmowFX
	EWVocUU+nQqs5+Bi5e7leS0EjwxzpaXAwi6q06Qm7xH/k1T/apm2d5Wv3ARcOMfOTJLGtq4YTWO
	07DaeE527lLvmpB5L9W0oFchZSqZ+ukaE2LW5LLv1DYJIn14T4xX8hDsEP9QkmfeiY4+93LEl8O
	493OkeI1oA1rratHu5WkGsXZeUpJEZoPDdKmL8CH3TsBUFVWQTzyTXnUKgDaq988GzRQQr5QvlK
	2I/9dsT/yP3FXjEVXHk2dXFTx2Yw5zqsHSISJkaBkVJxZ3g/c+GqpCU=
X-Google-Smtp-Source: AGHT+IFfCOA9DF0D7Zkw8D6RI31t3kCTUGxb9d2pYmYUiAKDzHxSWu8b5JQHFAaF7cd/qMF7O/WdgA==
X-Received: by 2002:a17:902:e5d2:b0:223:3b76:4e22 with SMTP id d9443c01a7336-22428886738mr15824425ad.6.1741303453949;
        Thu, 06 Mar 2025 15:24:13 -0800 (PST)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109dddd8sm18006285ad.12.2025.03.06.15.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:24:13 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	mincho@theori.io,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net 2/2] selftests/tc-testing: Add a test case for DRR class with TC_H_ROOT
Date: Thu,  6 Mar 2025 15:23:55 -0800
Message-Id: <20250306232355.93864-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306232355.93864-1-xiyou.wangcong@gmail.com>
References: <20250306232355.93864-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Integrate the reproduer from Mingi to TDC.

All test results:

1..4
ok 1 0385 - Create DRR with default setting
ok 2 2375 - Delete DRR with handle
ok 3 3092 - Show DRR class
ok 4 4009 - Reject creation of DRR class with classid TC_H_ROOT

Cc: Mingi Cho <mincho@theori.io>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/qdiscs/drr.json       | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json
index 7126ec3485cb..2b61d8d79bde 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json
@@ -61,5 +61,30 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+        "id": "4009",
+        "name": "Reject creation of DRR class with classid TC_H_ROOT",
+        "category": [
+            "qdisc",
+            "drr"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY root handle ffff: drr",
+            "$TC filter add dev $DUMMY parent ffff: basic classid ffff:1",
+            "$TC class add dev $DUMMY parent ffff: classid ffff:1 drr",
+            "$TC filter add dev $DUMMY parent ffff: prio 1 u32 match u16 0x0000 0xfe00 at 2 flowid ffff:ffff"
+        ],
+        "cmdUnderTest": "$TC class add dev $DUMMY parent ffff: classid ffff:ffff drr",
+        "expExitCode": "2",
+        "verifyCmd": "$TC class show dev $DUMMY",
+        "matchPattern": "class drr ffff:ffff",
+        "matchCount": "0",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root"
+        ]
     }
 ]
-- 
2.34.1


