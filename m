Return-Path: <netdev+bounces-248187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5360ED049A1
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBE75300C34D
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A5A2ED873;
	Thu,  8 Jan 2026 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsslVlev";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5YrQWdS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479E12DE6E6
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891487; cv=none; b=OchROqCsWRmyDH0pUlEvaLUB2swRMkzGyGshoMttRtmvSXPQBgSu+IOH+M5UrkVbtfCiZPrLDt8T9dOcHvuWf/Nzz3trTH5yHBoIxaow/k6GB3piP8RbbUqUtM0byU6cBPOLAcOrbXO6wL2uYVuKGCnM1XhQ45RfVbbEfEsioqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891487; c=relaxed/simple;
	bh=Dez9V004RqsLaGpEYBVQFmv3d3qxXY4twEruRZGGTNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OREmCetrCBjnipHo0dOdGUysUghduFrPp8t/URMVG0v69vOskuRXmcNoKy9y7EEyDinfyS59GwN/JgyynpsCNUjpDOt77Xd253eEPFJdydzAuxtmZIK/+qAl1e63PbMZUdHDfz8BwtJec5F6Dz7RU7cPUgaCIm8jSH0OwHOAMpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GsslVlev; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a5YrQWdS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767891481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GT7mN+7KVGActvdAZOBkafMg8y6aw5SRyHijs56WQuU=;
	b=GsslVlevTaPTsaOlsTQ0bdbYoz1G4pOtMCNvnwmvt6dcH7+2Q+RHjN/PbAgj6OtKY/7dpY
	JVV8XINRhEkn6EaKa1G1ScaxLaWFz2WNbXaMiGc1QvtdkfStNwJJwr8P1980vqoSlqodAK
	z60tnaz2O1cGT4rRviPwJ1Zq+KPl3gc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-egNvscmLOd2JXquC3muWtw-1; Thu, 08 Jan 2026 11:57:59 -0500
X-MC-Unique: egNvscmLOd2JXquC3muWtw-1
X-Mimecast-MFC-AGG-ID: egNvscmLOd2JXquC3muWtw_1767891478
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b7ce2f26824so363877466b.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 08:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767891478; x=1768496278; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GT7mN+7KVGActvdAZOBkafMg8y6aw5SRyHijs56WQuU=;
        b=a5YrQWdSid7rqntLjfEhTTSelZCnyqwCBvpEjtCI5pJVzK0h5bF45D9MhZO5l6C/bc
         iDL8AXja32FNB3ylUXraWvDiBlQSOgr/Oup8uOVTZFKvr8+GHg7bJpz3Z3KaU/9x7nw5
         Z0Jm2CT3DCPgL1x85h4IaL4FUIbKLVjTnjFZZvMHvJ62bDxK4yiQU2EoN/fBkxRN66ly
         2EUfrG8Ewz92qK/h7wbWwZnKAbnPwdxLp3hdEd7WG3CYQgvLO2Z6BBrYdUS2L2dhJQy7
         TAxH27v7Tr7r/wd1EJRpKJLWzyTepcNAdfJM7mi8+selPjIIcajoSxKl9I5hlztC2jxs
         RAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767891478; x=1768496278;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GT7mN+7KVGActvdAZOBkafMg8y6aw5SRyHijs56WQuU=;
        b=RgkNKjkXyjATfQHlXuB2dOpiUMf4gTcSNP4HggFaYyuWQtqMP9nod1UdJgbsejnu0r
         KQgxTMtSEBEo+YLjRX/8hUKxRopAdGgFxhJTB1iq1JPKV9epIirks4984QPMgm+Lf8/I
         bzBE29dVHbg5FegwDQgzll5YNJHMPaRX8whmO4CapGI03Nz2cSYQNs8r4u9Aiia+QZP9
         b1GaIsO4R/OPxOvykH8v7r/QleyWV+0wy1ppFFk3k9Zr1lZbEMpvmHKugfkzbNBontlN
         fAP4QK97eHXWX4yqyAcllR3J7t9andYbEouDFIq+BmYFIxcjd4MBYIPQcD7rKkoNyIls
         6GJg==
X-Forwarded-Encrypted: i=1; AJvYcCVHPzqk3glZ2h4sw3I0goQqRzKJI8edgPjbEdkOKb10r+kRA2bKcrtC7mM2M3OIB0x00SqBWj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcrhJ5ROw6hXTrLMLAe4ozDR2aWH0cfeloZy+VIGQ7te7d2YzI
	27QZJ4yAGjkAAdSGoK3ptCRMpoXonSCDaX1PDsVHMRC34bfpLx4W7/gHWmjhqS6z4zYjrs2by4t
	TbGE2/ZYgzB8M2GmC7wXVTp3eWCjrMSiEvmc9y8ZM7gfVeXht+bRviVpe9w==
X-Gm-Gg: AY/fxX6bJHvj6BoIHhq8jBcz2WlP+gJk/m1fpVzNd8kSIQw13KP/AV6EhEuPx5FqiHz
	iGpPTV7Y0jzDEAAOeWhJSvGJkPiZ6GIdodWS9QBj+VJziUXRcO5ZCZaDb/2OHTP0dNDvwD5UeKv
	AI1Tmrhu7ZNi2hK3m6tGHOKAK5yTbOh1S2vYuIG38mghqfV8k2iMHlkq9CyQm/vQlSQ4VWEwVfu
	L/C8QYgBjEXkHGTmk4sSlLOJTbywXgCG6F/5J7eWb9Dg1NMGoWrEb7w2pQrXiZuqxudj6mEF5Tg
	unAbICYMqTNQls4Q06gkrIMl3tai21c5b+eUANL11SqIz6kpH43cD6xIScvmz2jfBZhlKzbJYWJ
	qp49WnHJ4y6reDDoaf2fd8J7T16Vqe/A8es7e
X-Received: by 2002:a17:906:f582:b0:b83:8fc:c64b with SMTP id a640c23a62f3a-b84453a1868mr691277566b.38.1767891477998;
        Thu, 08 Jan 2026 08:57:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyCcbTaz3WM8h6k5wWHSlzh8KQXMFyUoi+JTohnsi9QMBt6I9uFBCxiHUq4OYhJNAQHkOMiA==
X-Received: by 2002:a17:906:f582:b0:b83:8fc:c64b with SMTP id a640c23a62f3a-b84453a1868mr691274266b.38.1767891477356;
        Thu, 08 Jan 2026 08:57:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a563f73sm891182866b.61.2026.01.08.08.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 08:57:55 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D76D34083C5; Thu, 08 Jan 2026 17:57:52 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Thu, 08 Jan 2026 17:56:08 +0100
Subject: [PATCH net-next v7 6/6] selftests/tc-testing: add selftests for
 cake_mq qdisc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260108-mq-cake-sub-qdisc-v7-6-4eb645f0419c@redhat.com>
References: <20260108-mq-cake-sub-qdisc-v7-0-4eb645f0419c@redhat.com>
In-Reply-To: <20260108-mq-cake-sub-qdisc-v7-0-4eb645f0419c@redhat.com>
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


