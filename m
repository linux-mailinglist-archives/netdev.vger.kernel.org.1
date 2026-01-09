Return-Path: <netdev+bounces-248502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 54471D0A52A
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 14:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5A9830291D2
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 13:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201B735C199;
	Fri,  9 Jan 2026 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1kUjJY8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyPTLcBm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB491EA7DB
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 13:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767964550; cv=none; b=UboQjv7EYYCduayAi1jWsy7PgWt4NkdHr+HvBgQuypUMK4cPrf5wpt76FmEp9wQXK/2CfxnqT8yiitPtAsCsxairKIvjT9b9kfkzPhm/yuTF41qB9hK/dRqZX4zh2lFpthzutkvgPth+521O+UN2uifRVOaf4cqzmFfey9u67EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767964550; c=relaxed/simple;
	bh=Dez9V004RqsLaGpEYBVQFmv3d3qxXY4twEruRZGGTNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fUoiHvPoo93TXydv7/CDdd+8jiDbZr7GG43CkO5NAAOGN9Q8pLN+hY9uLa5lvtCqJs6kk9INJE2QV2Hz5uIjfNcOEJ7t9cagBe87VqAWDQOii8FqVIZFCmHsQKT6zuAga9SzUwrrUQED4Hx2AJaeacf1A3u5l43T4dsydXZIius=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A1kUjJY8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MyPTLcBm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767964548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GT7mN+7KVGActvdAZOBkafMg8y6aw5SRyHijs56WQuU=;
	b=A1kUjJY8fDcznSRYfsJ7RQ35ZXNEbxPHkNDRikRfGUrbcGG6GcQG17HecKCDZWssCqw63k
	xoew0zh3MozqRCbNiFz2yiQiPz4BPvH0/dRY3cX37F4B6BqhlKYZ5Jb/qt+Bb+RyKdo6Ap
	qr10HSwEAD6CdEPmq3qcm8gNqA/LJkg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-xDrnP44xM7qTlVAKkzrzAQ-1; Fri, 09 Jan 2026 08:15:44 -0500
X-MC-Unique: xDrnP44xM7qTlVAKkzrzAQ-1
X-Mimecast-MFC-AGG-ID: xDrnP44xM7qTlVAKkzrzAQ_1767964543
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b841fc79f3eso401058266b.2
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 05:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767964543; x=1768569343; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GT7mN+7KVGActvdAZOBkafMg8y6aw5SRyHijs56WQuU=;
        b=MyPTLcBm4eDAfummDU1WVOYGjNK9ZiuGw3+dU+noCX2HUsmVugxDED2ZnfeBUyt3GJ
         lzhgOXFnxb6dUCWf6DyHeDXTVyBXMlhmgo3UtZofkZ1Ues/dTBzlnjWENEk6fxjycPA3
         pDfyqWRasXokHNhJwf/rH2x1OPHkaWY44+iXY5S4iMln0Gq+RYkGIDV6Sd+Sa/owegNR
         jbWhUl1Qms7qjYVK3oONmPi34WCCBnJmUo2/kwaYLNRfqI5RolSHQGkg2sS6AdYJxD17
         G4LkjRZYcW57ImtSHzlet+1F0OrCkMoE/d9f2U3s3AuJlccd6rGE8VWIbg2ebOIRkIHf
         M7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767964543; x=1768569343;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GT7mN+7KVGActvdAZOBkafMg8y6aw5SRyHijs56WQuU=;
        b=E4eR02NpDqnb98DfbowpSyvzsVOwnNvZy5opudWPXxNvA3j7pOYZZZT/SzDpOqaG5C
         OHOz8nhMovXJ8XHYMwM07RT9ZagLeHurf+em/7wN6bWW+7ng/D77PL+VkTTjZGwLjqH6
         FmhFp8yEdjaFV6kpjgAz9uOSWSgxNLM6XDYKwGzvnUM6gDG8cFYL4uRp56JpcdHUN+by
         ECAN+y81PH3MEn7+YpXxfjvWkJJJQkX0G21hcHmAKx6fjfdM379EozW7q0Tj0dn8rB0p
         mmxBcZwHZfQW0bE0glipTbPFYs6W1yeDCgcR2Pj8aegHjk3gLxoGfpacNWNV1Wzk9dTq
         9g0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxYRG6wifzCmf4DwT2r4u32SoZX+oQ1zGrxLLmHtpGtchlkGP9dq/uIazbYoyyI1J0GjOHgnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ooOg9QCu5NTupd0xu+eRLIFd8OD427mla/nG53baCvISE2to
	VupN5Z1IpM6FIkHvF/yvMEbRcBoAWgUfka+qZE+UKpcBL794ZZu1Vt3XWyLI7ZKxACxXX/ByFhd
	rNUZOJNM/9jvfxxm0G0NVVbH6+TlFv4Ef8hkehBcH8HbMY2e1fkBd3xYd+g==
X-Gm-Gg: AY/fxX6SZNM/UpXwWpZHs+aYIL2zQ2SQA6gWwZm0UX3TVWVtc3JSpc0pUfCrSv6gFYv
	NR4m/wdmqZO5GDTG3O41aV3fmkoMD2zXNrqEFQMM3B9Jbu3SX0JiOTwrH3lo2Rz+Pw+E8C426fO
	wutiZ9gB3gJpMwPBfQOib1kg2r9190eRz8RIvVumTiyyrP5Bu0fm4+gC7FDFv2BR3UENlSmf5Hm
	X78Tqojmap2FCEGjTE/rRDAtrx0kaqyNz+ctC4SGj+i5vdbdwO1We8EqfxOVOFOReF5dl6rYVuH
	OcXJhl64OZv8Z+kPlvqzpjB3HK0odbC37hErBlWR6816hIVLv1XkPsnrZAbIMKIqRL3bvN/KDMP
	89lOvrE49S6OqM/3qvskLJIRNHHJfox2GrCCr
X-Received: by 2002:a17:907:1b21:b0:b73:6f8c:6127 with SMTP id a640c23a62f3a-b8445031bf9mr995946166b.12.1767964542686;
        Fri, 09 Jan 2026 05:15:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERl7vHkglKY63WFh1nVh682MKzUqjwHHvVL0mmp3qhoiHao80RV7kxJaklUZR1HqC2ZNJEVQ==
X-Received: by 2002:a17:907:1b21:b0:b73:6f8c:6127 with SMTP id a640c23a62f3a-b8445031bf9mr995942766b.12.1767964542166;
        Fri, 09 Jan 2026 05:15:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4d31e7sm1144571466b.42.2026.01.09.05.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:15:41 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 33154408637; Fri, 09 Jan 2026 14:15:38 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Fri, 09 Jan 2026 14:15:35 +0100
Subject: [PATCH net-next v8 6/6] selftests/tc-testing: add selftests for
 cake_mq qdisc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260109-mq-cake-sub-qdisc-v8-6-8d613fece5d8@redhat.com>
References: <20260109-mq-cake-sub-qdisc-v8-0-8d613fece5d8@redhat.com>
In-Reply-To: <20260109-mq-cake-sub-qdisc-v8-0-8d613fece5d8@redhat.com>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: =?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, netdev@vger.kernel.org, 
 Victor Nogueira <victor@mojatatu.com>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
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

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 .../tc-testing/tc-tests/qdiscs/cake_mq.json        | 559 +++++++++++++++++++++
 1 file changed, 559 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/cake_mq.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/cake_mq.json
new file mode 100644
index 000000000000..0efe229fb86e
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/cake_mq.json
@@ -0,0 +1,559 @@
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
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    }
+]

-- 
2.52.0


