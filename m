Return-Path: <netdev+bounces-247348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB50CF8217
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 12:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 301013109715
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 11:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEA2334368;
	Tue,  6 Jan 2026 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRbCAOcr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E11kYKlf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFB5333420
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 11:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767699668; cv=none; b=cdVV99fZQZ2/uQ5wKiGOKN0f/ZaGV6+36ZhTQh71AlqZVZAG8UYVn9HKfsCjcR5Ko/+apUXjTOOtXor23ibv+SRQEqdHqSdSmUZ2iinx2V3qNw8pTL7dLHWPjIZfP+wnmc9ub/JZYzs3N0TE1xNHqdhz1ibsxcta0vqE/aNbJFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767699668; c=relaxed/simple;
	bh=Ytx2uNbX/n8Sxke7YXUkHkzLvAkjwMv2nz+61F/Mqtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NkXbCJd+unyJlTP/C7bBCIywbRzGsWkVDA91KyJjVtD2QJ7LSWy34WqM9p4SHYClgELIC5vnfLzwgzrK/BIn3kqz1xXqf9ZwLH4spS3F/mllvfZg9+oV/SEuvjlO6UWpTt9UwihNoRqTRCXhncVIyewggP4FZChIfEMwncdRjOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VRbCAOcr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E11kYKlf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767699664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfnhQV6vwVpf0rIiIa9kzs3HlB7Hl1pI3oqXyrBcU1E=;
	b=VRbCAOcr/9Y3KXbSheV4ZFr/PJy9Atn3WuOKOnMZZhokE4BTHrJ+bYbQDUMyGVkQaSmQYd
	Y2dEaWFFRBSuMGaRvVCZ310x9GBsNpH3cd3C8XqrOt+J5kVFkPUgzul9ZN/dgaBu/DTm9A
	v1FgcZJdoORcG00k2X3RgS5mhnfoSjU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-BXRUSqCdPAuVsmgmUw3sdA-1; Tue, 06 Jan 2026 06:41:03 -0500
X-MC-Unique: BXRUSqCdPAuVsmgmUw3sdA-1
X-Mimecast-MFC-AGG-ID: BXRUSqCdPAuVsmgmUw3sdA_1767699662
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b7a29e6f9a0so71429566b.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 03:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767699662; x=1768304462; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfnhQV6vwVpf0rIiIa9kzs3HlB7Hl1pI3oqXyrBcU1E=;
        b=E11kYKlf4QNwHLbXd8IJ/Ua5Ufhx6wKiTjvtihcfpJ+fuz7ruISYTt3IMUkmE8Y0rU
         WbtrmaQ4yxBjNnhOPf6bMth4YHFZ1sWcBhKq89DXRiTEkP+lBvXZTW0FgCjj7yw4Gv2C
         m287378G9zrJzecHCAoSdXOLpTbe2zL8w7PyX4SrZkxRJG7VwWOHlTJ8c/YbCf6akfJy
         86fmU+MfnqvWw1YLrBRdJPv3g08Y/FCCvjpCMH0GqyfK00hQfu0VMILUtKX0n8ogZfZl
         K+1HdoKJazsqAH1F059n6YQ8Z4u6WD/U0brdlYEbjjGzumURBXjooXR7XWgneiC7tBSE
         A+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699662; x=1768304462;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NfnhQV6vwVpf0rIiIa9kzs3HlB7Hl1pI3oqXyrBcU1E=;
        b=HSgqXUCFvvt+tXwFpanlLiOYpUQeM7hRz0Rx99h7eVvyEdQE1k3tAs/kp1d+AFkIEk
         ftqQZ/dmg9iLBVb6B9v7KYQmSXQa5rtlaaMZdKURbMx1Tr49HM+0PcIVUoeT9QKqU1/l
         mdPGisxZ2XvMg3wKE0siiWWGyaV8j8ncHl7m+vnlUhmIYdCmOcUuzowKzoiLmt7SJDXX
         aMFzDPxKRVF8LLwSKIML2KCAt3EhIhqGDyj8CFzU8czC4mhLJ04G5XQSRa5+y1W+igw6
         AXyZZDoVL3OxIWRXIwEWSg6OFvAXUZj4t9Zf02deaB8MvRF6IW9EusMSEW6d9jrCV8Io
         eUaA==
X-Forwarded-Encrypted: i=1; AJvYcCV1VUFtaCvJU4Zqw1MRUfN8RknfH2255j0Vvq29bGt71M8nFMooNbFYKG1bhGBlllvlw+eoNgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFsefJPkT73YZ16Ltw2j0LPCHjXIqKZVxUbX3EMdwlbzY0uF2q
	6XT76Q5va5cTqZiIj7QpdArqmgeUInO1wgIqaUetKJeVv0xsfNRiC+gXkbqjfNrVCkmadOavkMJ
	ccFwhzXIw+tmLMVjtUpqg2313ypkeIgF9Y3U3/786kNHPz7eQsWFucp3B1Q==
X-Gm-Gg: AY/fxX5cVlOz+EqvwmslEiRHW+X7rprWYtLiAjFFdZ1os/qRhebGdfXdLLpaMdRoUUo
	+D1/fJkpnz35CTkE3uAM6HyC6LqimOoMXDYrOJTeNmyQNS5FZL8d/MQnk9D6GMA1OxiE58HMiZU
	8vKmx+6NKl8KSiA+zMmhPNnKet5EJAr6qtL12epgoi/SwISzPeXJ/nE7D8HpA9Y+sLglekCXJqV
	tIhCNpmRgSeGxFOiF7Fts8tnXHzPN+0ukrR3IEmCS3o/TWD0GLCxpqV45j7xEUpBUtC/9QyS01Z
	n8UOzJE5KiFl9lP2U3PnqUla4a6jULRO8gzie9DepRM3CvXEGykLAwLkA4KBCEg/TFOCmlD+W9H
	i5pMG4DqqisDyTbhbOqVBLDvz3fBFVFs0fQ==
X-Received: by 2002:a17:907:3ea1:b0:b83:1326:a56a with SMTP id a640c23a62f3a-b8426c68092mr287966566b.58.1767699661746;
        Tue, 06 Jan 2026 03:41:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1LI3quLr/onELWV0ZWRZgeODfvjbKq8mikBBS6sklaMfzG4qR7vnaHOu9pAxk5Q69/X4p/w==
X-Received: by 2002:a17:907:3ea1:b0:b83:1326:a56a with SMTP id a640c23a62f3a-b8426c68092mr287964066b.58.1767699661170;
        Tue, 06 Jan 2026 03:41:01 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a564e05sm212903066b.65.2026.01.06.03.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:41:00 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id BBE25407FD8; Tue, 06 Jan 2026 12:40:58 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Tue, 06 Jan 2026 12:40:57 +0100
Subject: [PATCH net-next v6 6/6] selftests/tc-testing: add selftests for
 cake_mq qdisc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260106-mq-cake-sub-qdisc-v6-6-ee2e06b1eb1a@redhat.com>
References: <20260106-mq-cake-sub-qdisc-v6-0-ee2e06b1eb1a@redhat.com>
In-Reply-To: <20260106-mq-cake-sub-qdisc-v6-0-ee2e06b1eb1a@redhat.com>
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


