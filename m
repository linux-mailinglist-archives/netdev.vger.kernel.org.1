Return-Path: <netdev+bounces-179184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B719CA7B0CC
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B76018831DC
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497711F6664;
	Thu,  3 Apr 2025 21:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERnGtS98"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59401C861E
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743715016; cv=none; b=mODX5hJJecdn6GKUZpdrw25UUN3EY9fMT6slsuxT+YTmZ6W/NuQmJ1m60Ui8knnSge2HKHrKknoFicaJFfilhqgb0Lu1QyQtia+BixvCnPVcvHsqOFE4+hhSHeLL/amY4JgzXK2gsuyb2d8hvi0G0pBETF0dx2j6hw5BBdRXkkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743715016; c=relaxed/simple;
	bh=fTBYVnx6Li7nygbAximIqXeQ7rXpeg2cajolWat3350=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K4ZFtZkRs8V79L+zxt8q7LRef79AxTBlZgoLA0kCVVFikZicEAf6wQS6oSGPVT2Uk4dPa1EjjAX60dFNzC4nEYeS1QfQGs4yGdvJv5Nvy4fBL7hje77+cLJcgAHvsVzllx+z1V0jSPlL4myGbtzyIPLm7AO0ggMpy4oYz/54UBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERnGtS98; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22928d629faso14925005ad.3
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 14:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743715013; x=1744319813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY9jykK8zgH9KflXIKMEbJH2Pg7GebVRfiiEHZ9El20=;
        b=ERnGtS9842bBxkWZFliYU6R5ZKyF+QGdGDswfnxsoV0wyqBqw4ZBUio+71jcdL+vqT
         HD9/6GdFV0xiccx/AtqLMVlhZD+DU94KaEL48vdkzVUSaRs32QQRbB5d9mpfDJk2kRjB
         0tgn6hQE8jnQnPxt1FIw1hbJgq42P/JL5X2pPVZ8Rarx9SWp4kKQZ0tUl298UuKzU3fl
         PQBJbl3Zfv0yWN3RzKLmbTktCj7wvAzokmoyvgeOzAn0kQHWqDgm9fjXpr5F4tP+cANx
         7927oLnif8TTKK/9lxzJ5hzyP081XBjWvR0YjRAf8WLUct6OIOOFNtDBPMgJX803NIpc
         oU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743715013; x=1744319813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY9jykK8zgH9KflXIKMEbJH2Pg7GebVRfiiEHZ9El20=;
        b=nGtbJ4L7/h2MvFXmMi7NLRtbdNYMa6FldvxAK9i86xkc3kefXCqckrnON/TmLUQXPq
         YHwkG7pXFlBLEY2DkZxCOiG4w03kE9F8f+57wcYohnVogzlbGGUWUTcJ3Cb2mIubAYG4
         tkluZPaQ3gLNCCDY/ulJq96NH4Vdd+Ksua/+nV5rw1CY9AUzX2wJwh0lBiLLhojLW2SN
         AU37eKLWGusPj4Jwnb239u8VqAPOd3ESPxijYunauEuqc1bv2Cx8O5uCKJ6HZHbXcShr
         gBLekooFC/QexTEFAQFX4/AO74m/lNa3iWa7MA1JX2ZX5tbfZ2d6GfaNDGqInYgiZ/EN
         xwqg==
X-Gm-Message-State: AOJu0YwhDWheWzvfdj2cktfr4hn11EiuP/WZp4KIXKxfReNllw2ziINo
	Jy0Iv8p8pfsx2Le3cUlEshXZrfgLvSEnro90ighScx/4JTOO6rJsW4H2kg==
X-Gm-Gg: ASbGnctlmfWXn9ASpWJuNN44Asw4LxyIax8YNDtoTw5NiWidFTRQ+7GY6olA77R87lk
	siDtkoKM4Ke58qJehpySgDTArtPdCf1ymTsD92EIA3VkKzNE4hFRkpAb3IJRnZSNc/cp+vxg6a8
	PCG2yLXdQZhaXcyAHxSNsRk1gc6tM7H2KV+fUng4LS7yoyazSt9W58QjRLLDGeMFdOuB8C25mKo
	J0AZIuz+gaL9aMpJBPQdz2/5jrQAX4HSSHqvY3Cp6y8wkwvr0g/tAhSZTFcovGtWZ0MQOBGK85A
	IVwV7Ylz7YlCwM2CqSir6tExD1GyfHbCBdN4pisZD2wCbIpvaQ5ygDg=
X-Google-Smtp-Source: AGHT+IHITHENy7Fhf0xA0OUBN0kVlts5v3efPSPPhA/lhOLVhWjI+/tOCNdRTlxsH1eCIsz8nTk0lg==
X-Received: by 2002:a17:902:d507:b0:220:da88:2009 with SMTP id d9443c01a7336-22a8a8e400cmr5408565ad.45.1743715013550;
        Thu, 03 Apr 2025 14:16:53 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e1b4sm19332145ad.181.2025.04.03.14.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 14:16:53 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [Patch net v2 08/11] selftests/tc-testing: Add a test case for FQ_CODEL with QFQ parent
Date: Thu,  3 Apr 2025 14:16:33 -0700
Message-Id: <20250403211636.166257-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403211636.166257-1-xiyou.wangcong@gmail.com>
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
 <20250403211636.166257-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case for FQ_CODEL with QFQ parent to verify packet drop
behavior when the queue becomes empty. This helps ensure proper
notification mechanisms between qdiscs.

Note this is best-effort, it is hard to play with those parameters
perfectly to always trigger ->qlen_notify().

Cc: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 545966b6adc6..695522b00a3c 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -189,5 +189,36 @@
             "$TC qdisc del dev $DUMMY handle 1: root",
             "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
         ]
+    },
+    {
+        "id": "a4be",
+        "name": "Test FQ_CODEL with QFQ parent - force packet drop with empty queue",
+        "category": [
+            "qdisc",
+            "fq_codel",
+            "qfq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY handle 1: root qfq",
+            "$TC class add dev $DUMMY parent 1: classid 1:10 qfq weight 1 maxpkt 1000",
+            "$TC qdisc add dev $DUMMY parent 1:10 handle 10: fq_codel memory_limit 1 flows 1 target 0.1ms interval 1ms",
+            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match ip protocol 1 0xff flowid 1:10",
+            "ping -c 10 -s 1000 -f -I $DUMMY 10.10.10.1 > /dev/null || true",
+            "sleep 0.1"
+        ],
+        "cmdUnderTest": "$TC -s qdisc show dev $DUMMY",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY | grep -A 5 'qdisc fq_codel'",
+        "matchPattern": "dropped [1-9][0-9]*",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
+        ]
     }
 ]
-- 
2.34.1


