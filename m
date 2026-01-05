Return-Path: <netdev+bounces-247042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB43CF3AB4
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 14:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EACD30A50F8
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 12:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF59E253340;
	Mon,  5 Jan 2026 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjVEpqch";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxsMzYOD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A9E1519AC
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767617504; cv=none; b=mygS09sqkYjKMahNqe8eR3AjkyqKygP8r/jQZqSeECBYNja6FQMUrHJEDB5STbeLXc37/Djo3vlf/iRummjSOpRuLiSXxWPVR3veTUJz6kIICr8GTh8r0Xo5ZgokTLMP4SorSlBjrhvfBLchksVPFJ/YxLkKRHamyGorYRHj+pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767617504; c=relaxed/simple;
	bh=gA4C4HcPB+ApfzttGjg3j0yc2/zKnxPZ55cy9bQqpLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G3dkZ/UMkbggy3pHtQvkqnZYwgjc6CG4YymaxzECfaa7DASISDlDr+LkSzEn5lHXNhOsl81GCTEg7pU+9ByAz0bfkSF/cRinrDBRkR/K22vCaXgQbRADIUprxYUrzaaIrk3EXgGuqxFyaZSCmnLDP85X9t8AhBvliKBx3jI0hLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RjVEpqch; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BxsMzYOD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767617500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/YK/fR2x3Z/A9GBxULtt79nRv09DYBBn2Usif/W6g8=;
	b=RjVEpqchTQ41L07aUHHYJuEOD9vOLNAWFnWdl8zPDjvmWNpmcKPkHzb6dE0fkaXyOcdES0
	OiSPm+9eVVWXKrmTPiz5dU/DT4ClAw0+2RlcgkC85plrAlpTaT1ae2uRi9/qS6ogrfTDuV
	psZyXE8kzHHSGYrB/bgu99vD8GTfbn4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-rNGik-BsMkOAaE3Jwk40zg-1; Mon, 05 Jan 2026 07:51:39 -0500
X-MC-Unique: rNGik-BsMkOAaE3Jwk40zg-1
X-Mimecast-MFC-AGG-ID: rNGik-BsMkOAaE3Jwk40zg_1767617498
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b831e10ba03so914960466b.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 04:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767617498; x=1768222298; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/YK/fR2x3Z/A9GBxULtt79nRv09DYBBn2Usif/W6g8=;
        b=BxsMzYODSKXotZ4O0PyGoyU3dpgvQ3eKBK8lmSD5uiwXt212mFrfAtrYq9gOXOXqkT
         ZB4cxx9mqhU1z/om+k6Pu4pi3igap24lYw7pW3fSTiE4Pnyb79s480mEX2r+YYrfoeuK
         XqYRmwL5bFxYU2LEKtuqiOCaUuf45esDJqNCyWeShICZPXoyZr8nAPykKgYthKM/GWyL
         pTDE0wFCGgaoe8VWWHVAQmAGfjq49sV+SQIeL8CfaK4fPpHmUbSZdLh/X33WyWLMVsdf
         64PA0WiAf8Meb7UJ07FBWglEE9lrAIvHK4whlCMWvTUpfX7nFJyhZZrh/4va3IgaLGgm
         L+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767617498; x=1768222298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5/YK/fR2x3Z/A9GBxULtt79nRv09DYBBn2Usif/W6g8=;
        b=bbjpeC+Tkkt7IqSLQ6ONe7P2jFasbqYsPY4j9F6euQWV8Ub5kaZ2hsLjs8ypozKqpW
         FqD9CGJKuB0CiJc5nqsh9+5HLchqHvtaQZF/rxjT6c1HUOWjPFh74hLWtBTH+2jeEfIc
         8ld8fTh+5yZtbRjesv118OSk1BhjpWwykaLaDF3PdKHGygXHjuK1oeZUG++Se6ZbmJnr
         ubO4P5tt3OWk1JTRZQBzATmGAmj4+kzlYPreFsxZEIrrtMOBN2rlc7V2AbO5R+0/Ee1u
         A5I48qXLx/0D9KnN3NS9qahiAFLMOJBR8KgmyX+2T6Ce2gxjPhl2hU3LkiZlXjv87GSS
         Y8DQ==
X-Forwarded-Encrypted: i=1; AJvYcCULKd0TuVNEgT1MM+e+yc11yACZB2f8hbP+8ASsdsjL6zxxtvt3+btKGZSqUuz87VBsJ/C+0qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXvZkJ7DDo3Adozdv4x2F6ZsFsgV0dg/1FFCmvSc9wZFQDkbgK
	ydsdx7B0lbL4WomH+Yxc7oA0wOlMPCXSBzzkOAjBpY/9HoVwiZHJ06mkPt4SzpERm6LDVSvyOXI
	v7Vb7W7aAsjQLznN14xjTZal1H13jf0LMfaJbJkZEc5poZstMdA2vtS+sWmQrY8PnXg==
X-Gm-Gg: AY/fxX7BpKDwWLA6/YWZHVYS95wa2Fmeltt1sErrfncwhbqKR2/zGtPvN6QtNPtCyCw
	9u6upsWs2Cfvu/G7KO4fRTlOZaeeRC2JkGIzlsoA5feyN2QadJ5Xk/1Tgt/NTIzaXadFOBYc5Z5
	rqQWslefFcnrs/5l8lXOd7P8FeXAgtU1uAmTlO7jql/RyUFaUmPw0FeOE7yhH06/GOkWbMKHkD3
	wfJa75dpI2rabWmjWaj1b5Wncw+PqanDtmTc5jPv5SR5m10pzAFjywLtZDoG1+0OIOfrB+WkfwC
	ECn3dyEk+iXNL/RNY5xGuZYTWQvKjK4PtNIT0U6pKnFWAEVcvhlNz4ej5TI08lkHkbvLcTUf584
	HkZsU7Pel87uSjOOb/+b7d+M1arK+QeZ4AQ==
X-Received: by 2002:a17:907:7f20:b0:b6d:6c1a:31ae with SMTP id a640c23a62f3a-b80371d4ff4mr4754631466b.49.1767617497685;
        Mon, 05 Jan 2026 04:51:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhPgzlVGG9T3H9H+Kfn3PjznR0Ln3aY3zgo6M4Ae32JxQrYbZmzy5OAMjVnfga1CkVBASmag==
X-Received: by 2002:a17:907:7f20:b0:b6d:6c1a:31ae with SMTP id a640c23a62f3a-b80371d4ff4mr4754629566b.49.1767617497163;
        Mon, 05 Jan 2026 04:51:37 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f511fesm5597635866b.65.2026.01.05.04.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:51:36 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 58341407E99; Mon, 05 Jan 2026 13:51:32 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Mon, 05 Jan 2026 13:50:31 +0100
Subject: [PATCH net-next v5 6/6] selftests/tc-testing: add selftests for
 cake_mq qdisc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260105-mq-cake-sub-qdisc-v5-6-8a99b9db05e6@redhat.com>
References: <20260105-mq-cake-sub-qdisc-v5-0-8a99b9db05e6@redhat.com>
In-Reply-To: <20260105-mq-cake-sub-qdisc-v5-0-8a99b9db05e6@redhat.com>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: =?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, netdev@vger.kernel.org
X-Mailer: b4 0.14.3

From: Jonas Köppeler <j.koeppeler@tu-berlin.de>

Test 684b: Create CAKE_MQ with default setting (4 queues)
Test 7ee8: Create CAKE_MQ with bandwidth limit (4 queues)
Test 1f87: Create CAKE_MQ with rtt time (4 queues)
Test e9cf: Create CAKE_MQ with besteffort flag (4 queues)
Test 7c05: Create CAKE_MQ with diffserv8 flag (4 queues)
Test 5a77: Create CAKE_MQ with diffserv4 flag (4 queues)
Test 8f7a: Create CAKE_MQ with flowblind flag (4 queues)
Test 7ef7: Create CAKE_MQ with dsthost and nat flag (4 queues)
Test 2e4d: Create CAKE_MQ with wash flag (4 queues)
Test b3e6: Create CAKE_MQ with flowblind and no-split-gso flag (4 queues)
Test 62cd: Create CAKE_MQ with dual-srchost and ack-filter flag (4 queues)
Test 0df3: Create CAKE_MQ with dual-dsthost and ack-filter-aggressive flag (4 queues)
Test 9a75: Create CAKE_MQ with memlimit and ptm flag (4 queues)
Test cdef: Create CAKE_MQ with fwmark and atm flag (4 queues)
Test 93dd: Create CAKE_MQ with overhead 0 and mpu (4 queues)
Test 1475: Create CAKE_MQ with conservative and ingress flag (4 queues)
Test 7bf1: Delete CAKE_MQ with conservative and ingress flag (4 queues)
Test ee55: Replace CAKE_MQ with mpu (4 queues)
Test 6df9: Change CAKE_MQ with mpu (4 queues)
Test 67e2: Show CAKE_MQ class (4 queues)
Test 2de4: Change bandwidth of CAKE_MQ (4 queues)
Test 5f62: Fail to create CAKE_MQ with autorate-ingress flag (4 queues)
Test 038e: Fail to change setting of sub-qdisc under CAKE_MQ
Test 7bdc: Fail to replace sub-qdisc under CAKE_MQ
Test 18e0: Fail to install CAKE_MQ on single queue device

Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
---
 .../tc-testing/tc-tests/qdiscs/cake_mq.json        | 557 +++++++++++++++++++++
 1 file changed, 557 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/cake_mq.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/cake_mq.json
new file mode 100644
index 000000000000..f0245bceb9d8
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/cake_mq.json
@@ -0,0 +1,557 @@
+[
+    {
+        "id": "684b",
+        "name": "Create CAKE_MQ with default setting (4 queues)",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device || true",
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH handle 1: root cake_mq",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth unlimited diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw overhead 0 ",
+        "matchCount": "5",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "7ee8",
+        "name": "Create CAKE_MQ with bandwidth limit (4 queues)",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH handle 1: root cake_mq bandwidth 1000",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth 1Kbit diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw overhead 0 ",
+        "matchCount": "5",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "1f87",
+        "name": "Create CAKE_MQ with rtt time (4 queues)",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH handle 1: root cake_mq rtt 200",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth unlimited diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 200us raw overhead 0 ",
+        "matchCount": "5",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "e9cf",
+        "name": "Create CAKE_MQ with besteffort flag (4 queues)",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH handle 1: root cake_mq besteffort",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth unlimited besteffort triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw overhead 0 ",
+        "matchCount": "5",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "7c05",
+        "name": "Create CAKE_MQ with diffserv8 flag (4 queues)",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH handle 1: root cake_mq diffserv8",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth unlimited diffserv8 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw overhead 0 ",
+        "matchCount": "5",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "5a77",
+        "name": "Create CAKE_MQ with diffserv4 flag (4 queues)",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH handle 1: root cake_mq diffserv4",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth unlimited diffserv4 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw overhead 0 ",
+        "matchCount": "5",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "8f7a",
+        "name": "Create CAKE_MQ with flowblind flag (4 queues)",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH handle 1: root cake_mq flowblind",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth unlimited diffserv3 flowblind nonat nowash no-ack-filter split-gso rtt 100ms raw overhead 0 ",
+        "matchCount": "5",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "7ef7",
+        "name": "Create CAKE_MQ with dsthost and nat flag (4 queues)",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH handle 1: root cake_mq dsthost nat",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth unlimited diffserv3 dsthost nat nowash no-ack-filter split-gso rtt 100ms raw overhead 0 ",
+        "matchCount": "5",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "2e4d",
+        "name": "Create CAKE_MQ with wash flag (4 queues)",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH handle 1: root cake_mq hosts wash",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth unlimited diffserv3 hosts nonat wash no-ack-filter split-gso rtt 100ms raw overhead 0 ",
+        "matchCount": "5",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "b3e6",
+        "name": "Create CAKE_MQ with flowblind and no-split-gso flag (4 queues)",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH handle 1: root cake_mq flowblind no-split-gso",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth unlimited diffserv3 flowblind nonat nowash no-ack-filter no-split-gso rtt 100ms raw overhead 0 ",
+        "matchCount": "5",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "62cd",
+        "name": "Create CAKE_MQ with dual-srchost and ack-filter flag (4 queues)",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH handle 1: root cake_mq dual-srchost ack-filter",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth unlimited diffserv3 dual-srchost nonat nowash ack-filter split-gso rtt 100ms raw overhead 0 ",
+        "matchCount": "5",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "0df3",
+        "name": "Create CAKE_MQ with dual-dsthost and ack-filter-aggressive flag (4 queues)",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH handle 1: root cake_mq dual-dsthost ack-filter-aggressive",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth unlimited diffserv3 dual-dsthost nonat nowash ack-filter-aggressive split-gso rtt 100ms raw overhead 0 ",
+        "matchCount": "5",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "9a75",
+        "name": "Create CAKE_MQ with memlimit and ptm flag (4 queues)",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH handle 1: root cake_mq memlimit 10000 ptm",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth unlimited diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw ptm overhead 0 memlimit 10000b ",
+        "matchCount": "5",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "cdef",
+        "name": "Create CAKE_MQ with fwmark and atm flag (4 queues)",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH handle 1: root cake_mq fwmark 8 atm",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth unlimited diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw atm overhead 0 fwmark 0x8 ",
+        "matchCount": "5",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "93dd",
+        "name": "Create CAKE_MQ with overhead 0 and mpu (4 queues)",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH handle 1: root cake_mq overhead 128 mpu 256",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth unlimited diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms noatm overhead 128 mpu 256 ",
+        "matchCount": "5",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "1475",
+        "name": "Create CAKE_MQ with conservative and ingress flag (4 queues)",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH handle 1: root cake_mq conservative ingress",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth unlimited diffserv3 triple-isolate nonat nowash ingress no-ack-filter split-gso rtt 100ms atm overhead 48 ",
+        "matchCount": "5",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "7bf1",
+        "name": "Delete CAKE_MQ with conservative and ingress flag (4 queues)",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device",
+            "$TC qdisc add dev $ETH handle 1: root cake_mq conservative ingress"
+        ],
+        "cmdUnderTest": "$TC qdisc del dev $ETH handle 1: root",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth unlimited diffserv3 triple-isolate nonat nowash ingress no-ack-filter split-gso rtt 100ms atm overhead 48 ",
+        "matchCount": "0",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "ee55",
+        "name": "Replace CAKE_MQ with mpu (4 queues)",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device",
+            "$TC qdisc add dev $ETH handle 1: root cake_mq overhead 128 mpu 256"
+        ],
+        "cmdUnderTest": "$TC qdisc replace dev $ETH handle 1: root cake_mq mpu 128",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth unlimited diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms noatm overhead 128 mpu 128 ",
+        "matchCount": "5",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "6df9",
+        "name": "Change CAKE_MQ with mpu (4 queues)",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device",
+            "$TC qdisc add dev $ETH handle 1: root cake_mq overhead 128 mpu 256"
+        ],
+        "cmdUnderTest": "$TC qdisc change dev $ETH handle 1: root cake_mq mpu 128",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth unlimited diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms noatm overhead 128 mpu 128 ",
+        "matchCount": "5",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "67e2",
+        "name": "Show CAKE_MQ class (4 queues)",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH handle 1: root cake_mq",
+        "expExitCode": "0",
+        "verifyCmd": "$TC class show dev $ETH",
+        "matchPattern": "class cake_mq",
+        "matchCount": "4",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "2de4",
+        "name": "Change bandwidth of CAKE_MQ (4 queues)",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device",
+            "$TC qdisc add dev $ETH handle 1: root cake_mq"
+        ],
+        "cmdUnderTest": "$TC qdisc replace dev $ETH handle 1: root cake_mq bandwidth 1000",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth 1Kbit diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw overhead 0 ",
+        "matchCount": "5",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "5f62",
+        "name": "Fail to create CAKE_MQ with autorate-ingress flag (4 queues)",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH handle 1: root cake_mq autorate-ingress",
+        "expExitCode": "2",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth unlimited autorate-ingress diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw overhead 0 ",
+        "matchCount": "0",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "038e",
+        "name": "Fail to change setting of sub-qdisc under CAKE_MQ",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device",
+            "$TC qdisc add dev $ETH handle 1: root cake_mq"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH parent 1:1 cake besteffort flows",
+        "expExitCode": "2",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth unlimited diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw overhead 0 ",
+        "matchCount": "5",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "7bdc",
+        "name": "Fail to replace sub-qdisc under CAKE_MQ",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device",
+            "$TC qdisc add dev $ETH handle 1: root cake_mq"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH parent 1:1 fq",
+        "expExitCode": "2",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth unlimited diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw overhead 0 ",
+        "matchCount": "5",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "18e0",
+        "name": "Fail to install CAKE_MQ on single queue device",
+        "category": [
+            "qdisc",
+            "cake_mq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 1\" > /sys/bus/netdevsim/new_device"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH handle 1: root cake_mq",
+        "expExitCode": "2",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth unlimited diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw overhead 0 ",
+        "matchCount": "0",
+        "teardown": []
+    }
+]

-- 
2.52.0


