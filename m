Return-Path: <netdev+bounces-206463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E566DB03324
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 23:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1361897A51
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 21:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4B41F9406;
	Sun, 13 Jul 2025 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFgXGH/1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D111F91F6
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 21:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752443293; cv=none; b=QVdwR/hVQjxBwu+vEFoi+Cm1q6CDnom0FGrlVMwiPaew3DDq1VkL6Z9nOHcAyMqif/dK/ppbX3e4qdH6gEpAy0Pl7GZCaHh211iVULlstt7YK31KPj/gYDEDuXeWbm/+/TC15Qqeldgt43qCFWjekepvA23j1WCIWuorpJShQ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752443293; c=relaxed/simple;
	bh=Ntmjkos0CIcdvkurcd5vAFcyjG/Fz+9c9mzNhxrKtdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p59wXQVzi+dO4/4epgX+MPXlKQHG8Ruyip/c+GLzHwvc2wEnECGDUqsDnaH4HMuA9uQ/4GlO3ppWprFBUV/fesyKlz2CJ7xLoU44vEP9qp36kft5pc3kO6cBrQDK9fYQPpse8Q4rj8Q4TATvrycTft3JUsDzUmChjc/EbMNT+4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFgXGH/1; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7490acf57b9so2561976b3a.2
        for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 14:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752443291; x=1753048091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cYKKZ5RX64v+jEJMguFWdNuRYEYo2gaYlQ5sQi4ibA=;
        b=dFgXGH/1XbyZDT3P9f9js500EjEl/5InV8fMNZ7je9Z2PiBNkbeD0fR08h8z8Z2QL4
         uX479Ru/SUP55jMd4RO772Lh/+PTBrYs2NpkjDqPiJ2JDBbpzbUk+f+tAt/yg2uTpEVj
         MS13BEZF4Ag8ZLF7qBBJqpTzSVeSJr8r2ldAyOyuFutMGvZ5i7orf8Q5dGlNSmoT9bmc
         p4jljCPzEPlzCopLNWYMucx4ln5X7H4bgN9opppBcWLRpkwjjlasJJ6vbjm4H3KqU6SA
         B2718UlZZXxsc/vHPrivNI1iqi0wQIg7QkkRoWwOEI5gkQw8qiwF43uJ2UZ1JepaJt+y
         7zuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752443291; x=1753048091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cYKKZ5RX64v+jEJMguFWdNuRYEYo2gaYlQ5sQi4ibA=;
        b=gZqrMNWIzxWJgceYqTCT9NDJy1Xxq0fsQHY7wpRJHqYncKZVee6L+uek3bapQSztfs
         n0Cq+pq5mgkSB+qDvkTjaOLkGZKryxNHEZ/QESwBY2Q1/FEKiYlDnckZb/M0Fl1NpLNk
         gM0MumBRdWaQdrIZBkWzxQV6VDONyRe/yjDsX6OUC2gtyz3/Juq0+ZhBddUpMxE6csRu
         w6E7L98g+vKJhPyjOJrjuYhi7KdSjRvtde7BACQw5pQo3av/dCNaXe8RZ9JgVacK6P5z
         aFNb/LSzbyb1N/xxoIlTKFvkXHnUrBS/d5bVMWm11Cf+2hzJLQ0Iqhk0xxvXn2W0VKTG
         7UOw==
X-Gm-Message-State: AOJu0Yzxsn/sOiZhNCRpmPdUj3WEZxGmqKqKrJ6KhB8m6hhVG6/PpLCB
	Ir1w4iXKou8hlDJi+ia93GbPLaMcXM8gXeSwRbLazJ0yBl0PAOD7xs/vTt3sbA==
X-Gm-Gg: ASbGncvBudJt4Aik3V9mF6Jc0erjRjMxgUC+wFo38MGrqUVi/8cs4RG9JQoZrX074L1
	0tvrbDnY0Oq2jjmRbVJVMyY1zbP2mfWJbByoiLQk7eHKxa6PdoT5IpE6EqA/ziLySwGexLd+B7b
	h/8IbKrVpLdlTQKZjy3YjBQLiT/rFlPIjLTcVa4h3nw9nxTqtHqKsCRKmktbIK1RteoSH4IrLfz
	XoUy03RXcIMOvvasyXe/xlA0yb4EtbWlOsyaTAG5ZeiJ/zRXokxi9R7j9VelxRdIQsrc42ZkdmW
	Gooht+27QziF1625pEESNBL9aAf90FMVD6MOJBQEx3B5YXC2DUk0Bp18oNfKK4zzgWbkt3ne/Xa
	PZIMdhhqyEj2zXSURDFtUxDabyc0=
X-Google-Smtp-Source: AGHT+IHH0Q8oM7AX/ncK4zAbz45QJkGrjwkxE2CtCm5B/yYMjr+fd+mAYk9ns4+e7y2yGDj71yZTyg==
X-Received: by 2002:a05:6a20:7491:b0:21e:eb3a:dc04 with SMTP id adf61e73a8af0-2311e04b252mr18813302637.3.1752443290726;
        Sun, 13 Jul 2025 14:48:10 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:b9d2:1ae4:8a66:82b2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6f1fd0sm8628370a12.53.2025.07.13.14.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 14:48:09 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	will@willsroot.io,
	stephen@networkplumber.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch v3 net 4/4] selftests/tc-testing: Add a test case for mq with netem duplicate
Date: Sun, 13 Jul 2025 14:47:48 -0700
Message-Id: <20250713214748.1377876-5-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250713214748.1377876-1-xiyou.wangcong@gmail.com>
References: <20250713214748.1377876-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a very reasonable use case for multiqueue NIC, add it to
tc-testing to ensure no one should break it.

Test 94a8: Test MQ with NETEM duplication
[  753.877611] v0p0id94a8: entered promiscuous mode
[  753.909783] virtio_net virtio0 enp1s0: entered promiscuous mode
[  753.936686] virtio_net virtio0 enp1s0: left promiscuous mode
.
Sent 1 packets.
[  753.984974] v0p0id94a8: left promiscuous mode
[  754.010725] v0p0id94a8: entered promiscuous mode
.
Sent 1 packets.
[  754.030879] v0p0id94a8: left promiscuous mode
[  754.067966] v0p0id94a8: entered promiscuous mode
.
Sent 1 packets.
[  754.096516] v0p0id94a8: left promiscuous mode
[  754.129166] v0p0id94a8: entered promiscuous mode
.
Sent 1 packets.
[  754.156371] v0p0id94a8: left promiscuous mode
[  754.187278] v0p0id94a8: entered promiscuous mode
.
Sent 1 packets.
[  754.212102] v0p0id94a8: left promiscuous mode

All test results:

1..1
ok 1 94a8 - Test MQ with NETEM duplication

Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index bfa6de751270..8e206260fa79 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -701,5 +701,35 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY root handle 1: prio"
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
+            "$TC qdisc add dev $DEV1 parent 1:1 handle 10: netem duplicate 100%"
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
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 root handle 1: mq"
+        ]
     }
 ]
-- 
2.34.1


