Return-Path: <netdev+bounces-290525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SP+9IsM0D2rtHgYAu9opvQ
	(envelope-from <netdev+bounces-290525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:37:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CDD5A96A4
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98E0F358540A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B51A30148A;
	Thu, 21 May 2026 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="ruhfChTx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD8B33EF
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376111; cv=none; b=AFsixXepnqUYAt6UGIuqzJfh1mQYqOlpI/6/y4mjdGSOSPRTM5lOkgfGdxznF99YaIwwPROPqTa+Xef4T4bodXcVQBUymKMARjaYpAiQd+h9NN+UDSXjp2H0O0xdrY6Q68jvmjCwRswK6n9MI85I36hRBcFd33ykhwS6AvsKt0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376111; c=relaxed/simple;
	bh=MIEMnwZaaI8MzlytVI/SzwPnUTvl9nIqX7bLuUrzwE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJmuiRo+pY2Zm9HvZ1uuX6bvCQn1msB5C3gDNeDMSOuTJA7izyLq/ARX0AoP/8e+6dYqUFBHwzJbZLYx4fAZDbSfYCeetY4u4b805X6WAwhOuA5LPZEq+ZMJdqZDyjsPpWkwp41isqH8x06OikFjsk69suAWMRcJfgm9MDLN5tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=ruhfChTx; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-6314c3818baso4788657137.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 08:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779376108; x=1779980908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vP4DDMnmlizsQ9Dpg3n4UQuWai5cep+FUewvlTFey6o=;
        b=ruhfChTxAaIi3WtHXiVubRKFtxpDIhqjRHeR8ZRnq+m9rN9uT44RQ5kod0z8LiW/+e
         bzUSdt2v7eDCols5jv+iAuCvOzNunc5GJP/w2Z56x7NZ8smdHX1PrVzLNSbSTwX9QOXo
         YUbxu0PQe2oDo6ZElJm8TOLo+sgtFa6Tzl0yYoXCP/GCvdxjROCnNRtIvc4inEp2I6ok
         g2GqrxXStHVe7U8r4Z+qTuxokjbNku6ecQc8XBItci8rtt/Rucjigeu4tG8xiPRoIfba
         /DmOWEBduSncAYy58Oeh8eYpmIc1J+YfVrFWK+9qOpxEcgPo7oe5u3y+WTODFcDOhFOH
         gsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779376108; x=1779980908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vP4DDMnmlizsQ9Dpg3n4UQuWai5cep+FUewvlTFey6o=;
        b=PJenUkd1tunBjJAZOgEioo81vvrNu5vou13FhdeGwZvAziG6wvAiGsESYYPJJqepN1
         t8bdRaMB/vTSqEuH0gTV+U7Q3/eFsb97rrSfty6NZTcsUP5JZwQw6axYbtGWAFHzurXP
         vIsHE7IJhfUJpKelHyBLqfE6WNfuVWZA13G7HjltjZNTeGUo+vHMi0tx34Q/llLVMjDH
         9rpRwjDQLTDw08eiWbvBP2PkuW9SAsjOzVRqXA23eecu/c91+fthaidp1YTkkIEqaSE7
         KQIwhIlYQn6FltiGO5hvjkkDJh37zCJk2nVqYunm4mVliTolWcNn9u6UsN6i/a+9RVHc
         GvEg==
X-Gm-Message-State: AOJu0YzsyISf7/7BqkWp1zdUxj7H6S3EiBN6ckmsiSqiPSZe5KurNxE0
	AvovWBuAPC7RFRs65q64kdlFuQW7Lk2QrI1rhRH4zrdxXFSmfSFBgZdA2dPNVkinkw==
X-Gm-Gg: Acq92OHGVn+5tccZAYXbFfaJTY9itxOlortxuzUQq2ZkK5soCVbvGTNbBmJ/qN/QqxN
	AJ0RoJOoO/UAbkA+z1E1ZjCAZwsfFDQMBVoyNVVBYVRU7FtIZP5//PCB1/wA74ZRfBKpkztzgHL
	tl4oSDsRBg5fmgiv2xCSXYxenCS1mULKWRNW+oG7YohA4VT4c1XAA+E0TrEkZ9AvTBHSx8/k61Z
	OhQxP4zF8d2sYfIyTVY2Zu/J+/tSNY1uof9j7iolS9H/kBacxftG/ZbNUyyzEkJxp4G+279tsnU
	p+22WX9Es0inQrxk8F7E+1X5T//6Wa/0X3e/uefjkVZpRcWaTucWoEhr+6vd8hTu5UqWt7dKnA9
	pmVY2TZ2Dp1SzptaXAoIpJnnXywkqu2Xj69gOIEJ5nFTtzq7XWKPF1HQ2MXSktWfaKOZvAjBmL8
	YyRO2wHvVujpwHPLWp6PG3q5ppboBI/F/yuWIq2MYGrjDZGA==
X-Received: by 2002:a05:6102:952:b0:660:cba2:b6a5 with SMTP id ada2fe7eead31-6738d46a2c9mr2224143137.7.1779376108018;
        Thu, 21 May 2026 08:08:28 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:14d:5c54:4d67:f17:d82a:d5b8:20a])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-679fa70c8d7sm881114137.11.2026.05.21.08.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 08:08:26 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	pctammela@mojatatu.com
Subject: [PATCH net-next 2/2] selftests/tc-testing: Adapt idempotent qdisc notify callback tests to recent fq_codel changes
Date: Thu, 21 May 2026 12:08:11 -0300
Message-ID: <20260521150811.1896373-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521150811.1896373-1-victor@mojatatu.com>
References: <20260521150811.1896373-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-290525-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu-com.20251104.gappssmtp.com:dkim,mojatatu.com:mid,mojatatu.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F0CDD5A96A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 150061a20651 ("net/sched: fq_codel: local packets no longer count against memory limit")
made fq_codel not account for local packets in the
memory limit. Since tests a4bb, a4be, a4bf, a4c0, a4c1 were relying on
these packets being accounted so that parent's qlen notify callback was
executed, they broke.

Fix the tests by adding the qdiscs to ifb instead and making it see
mirred packets that came from scapy. That way the packets are accounted
in the memory limit and the parent's qlen notify callback is still
executed.

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 160 +++++++++++-------
 1 file changed, 95 insertions(+), 65 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 848696c373fc..3da9936e115d 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -392,26 +392,32 @@
             "htb"
         ],
         "plugins": {
-            "requires": "nsPlugin"
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
         },
         "setup": [
-            "$IP link set dev $DUMMY up || true",
-            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
-            "$TC qdisc add dev $DUMMY handle 1: root htb default 10",
-            "$TC class add dev $DUMMY parent 1: classid 1:10 htb rate 1kbit",
-            "$TC qdisc add dev $DUMMY parent 1:10 handle 10: fq_codel memory_limit 1 flows 1 target 0.1ms interval 1ms",
-            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match ip protocol 1 0xff flowid 1:10",
-            "ping -c 5 -f -I $DUMMY 10.10.10.1 > /dev/null || true",
-            "sleep 0.1"
+            "$TC qdisc add dev $IFB handle 1: root htb default 10",
+            "$TC class add dev $IFB parent 1: classid 1:10 htb rate 1kbit",
+            "$TC qdisc add dev $IFB parent 1:10 handle 10: fq_codel memory_limit 1 flows 1 target 0.1ms interval 1ms",
+            "$TC filter add dev $IFB parent 1: protocol ip prio 1 u32 match ip protocol 1 0xff flowid 1:10",
+            "$TC qdisc add dev $DEV1 ingress",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 1 u32 match ip protocol 1 0xff action mirred egress mirror dev $IFB"
         ],
-        "cmdUnderTest": "$TC -s qdisc show dev $DUMMY",
+        "scapy": {
+            "iface": "$DEV0",
+            "count": 5,
+            "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+        },
+        "cmdUnderTest": "$TC -s qdisc show dev $IFB",
         "expExitCode": "0",
-        "verifyCmd": "$TC -s qdisc show dev $DUMMY | grep -A 5 'qdisc fq_codel'",
+        "verifyCmd": "$TC -s qdisc show dev $IFB | grep -A 5 'qdisc fq_codel'",
         "matchPattern": "dropped [1-9][0-9]*",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
+            "$TC qdisc del dev $IFB root",
+            "$TC qdisc del dev $DEV1 ingress"
         ]
     },
     {
@@ -423,26 +429,32 @@
             "qfq"
         ],
         "plugins": {
-            "requires": "nsPlugin"
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
         },
         "setup": [
-            "$IP link set dev $DUMMY up || true",
-            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
-            "$TC qdisc add dev $DUMMY handle 1: root qfq",
-            "$TC class add dev $DUMMY parent 1: classid 1:10 qfq weight 1 maxpkt 1000",
-            "$TC qdisc add dev $DUMMY parent 1:10 handle 10: fq_codel memory_limit 1 flows 1 target 0.1ms interval 1ms",
-            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match ip protocol 1 0xff flowid 1:10",
-            "ping -c 10 -s 1000 -f -I $DUMMY 10.10.10.1 > /dev/null || true",
-            "sleep 0.1"
+            "$TC qdisc add dev $IFB handle 1: root qfq",
+            "$TC class add dev $IFB parent 1: classid 1:10 qfq weight 1 maxpkt 1000",
+            "$TC qdisc add dev $IFB parent 1:10 handle 10: fq_codel memory_limit 1 flows 1 target 0.1ms interval 1ms",
+            "$TC filter add dev $IFB parent 1: protocol ip prio 1 u32 match ip protocol 1 0xff flowid 1:10",
+            "$TC qdisc add dev $DEV1 ingress",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 1 u32 match ip protocol 1 0xff action mirred egress mirror dev $IFB"
         ],
-        "cmdUnderTest": "$TC -s qdisc show dev $DUMMY",
+        "scapy": {
+            "iface": "$DEV0",
+            "count": 10,
+            "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+        },
+        "cmdUnderTest": "$TC -s qdisc show dev $IFB",
         "expExitCode": "0",
-        "verifyCmd": "$TC -s qdisc show dev $DUMMY | grep -A 5 'qdisc fq_codel'",
+        "verifyCmd": "$TC -s qdisc show dev $IFB | grep -A 5 'qdisc fq_codel'",
         "matchPattern": "dropped [1-9][0-9]*",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
+            "$TC qdisc del dev $IFB root",
+            "$TC qdisc del dev $DEV1 ingress"
         ]
     },
     {
@@ -454,26 +466,32 @@
             "hfsc"
         ],
         "plugins": {
-            "requires": "nsPlugin"
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
         },
         "setup": [
-            "$IP link set dev $DUMMY up || true",
-            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
-            "$TC qdisc add dev $DUMMY handle 1: root hfsc default 10",
-            "$TC class add dev $DUMMY parent 1: classid 1:10 hfsc sc rate 1kbit ul rate 1kbit",
-            "$TC qdisc add dev $DUMMY parent 1:10 handle 10: fq_codel memory_limit 1 flows 1 target 0.1ms interval 1ms",
-            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match ip protocol 1 0xff flowid 1:10",
-            "ping -c 5 -f -I $DUMMY 10.10.10.1 > /dev/null || true",
-            "sleep 0.1"
+            "$TC qdisc add dev $IFB handle 1: root hfsc default 10",
+            "$TC class add dev $IFB parent 1: classid 1:10 hfsc sc rate 1kbit ul rate 1kbit",
+            "$TC qdisc add dev $IFB parent 1:10 handle 10: fq_codel memory_limit 1 flows 1 target 0.1ms interval 1ms",
+            "$TC filter add dev $IFB parent 1: protocol ip prio 1 u32 match ip protocol 1 0xff flowid 1:10",
+            "$TC qdisc add dev $DEV1 ingress",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 1 u32 match ip protocol 1 0xff action mirred egress mirror dev $IFB"
         ],
-        "cmdUnderTest": "$TC -s qdisc show dev $DUMMY",
+        "scapy": {
+            "iface": "$DEV0",
+            "count": 5,
+            "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+        },
+        "cmdUnderTest": "$TC -s qdisc show dev $IFB",
         "expExitCode": "0",
-        "verifyCmd": "$TC -s qdisc show dev $DUMMY | grep -A 5 'qdisc fq_codel'",
+        "verifyCmd": "$TC -s qdisc show dev $IFB | grep -A 5 'qdisc fq_codel'",
         "matchPattern": "dropped [1-9][0-9]*",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
+            "$TC qdisc del dev $IFB root",
+            "$TC qdisc del dev $DEV1 ingress"
         ]
     },
     {
@@ -485,26 +503,32 @@
             "drr"
         ],
         "plugins": {
-            "requires": "nsPlugin"
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
         },
         "setup": [
-            "$IP link set dev $DUMMY up || true",
-            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
-            "$TC qdisc add dev $DUMMY handle 1: root drr",
-            "$TC class add dev $DUMMY parent 1: classid 1:10 drr quantum 1500",
-            "$TC qdisc add dev $DUMMY parent 1:10 handle 10: fq_codel memory_limit 1 flows 1 target 0.1ms interval 1ms",
-            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match ip protocol 1 0xff flowid 1:10",
-            "ping -c 5 -f -I $DUMMY 10.10.10.1 > /dev/null || true",
-            "sleep 0.1"
+            "$TC qdisc add dev $IFB handle 1: root drr",
+            "$TC class add dev $IFB parent 1: classid 1:10 drr quantum 1500",
+            "$TC qdisc add dev $IFB parent 1:10 handle 10: fq_codel memory_limit 1 flows 1 target 0.1ms interval 1ms",
+            "$TC filter add dev $IFB parent 1: protocol ip prio 1 u32 match ip protocol 1 0xff flowid 1:10",
+            "$TC qdisc add dev $DEV1 ingress",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 1 u32 match ip protocol 1 0xff action mirred egress mirror dev $IFB"
         ],
-        "cmdUnderTest": "$TC -s qdisc show dev $DUMMY",
+        "scapy": {
+            "iface": "$DEV0",
+            "count": 5,
+            "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+        },
+        "cmdUnderTest": "$TC -s qdisc show dev $IFB",
         "expExitCode": "0",
-        "verifyCmd": "$TC -s qdisc show dev $DUMMY | grep -A 5 'qdisc fq_codel'",
+        "verifyCmd": "$TC -s qdisc show dev $IFB | grep -A 5 'qdisc fq_codel'",
         "matchPattern": "dropped [1-9][0-9]*",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
+            "$TC qdisc del dev $IFB root",
+            "$TC qdisc del dev $DEV1 ingress"
         ]
     },
     {
@@ -516,26 +540,32 @@
             "ets"
         ],
         "plugins": {
-            "requires": "nsPlugin"
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
         },
         "setup": [
-            "$IP link set dev $DUMMY up || true",
-            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
-            "$TC qdisc add dev $DUMMY handle 1: root ets bands 2 strict 1",
-            "$TC class change dev $DUMMY parent 1: classid 1:1 ets",
-            "$TC qdisc add dev $DUMMY parent 1:1 handle 10: fq_codel memory_limit 1 flows 1 target 0.1ms interval 1ms",
-            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match ip protocol 1 0xff flowid 1:1",
-            "ping -c 5 -f -I $DUMMY 10.10.10.1 > /dev/null || true",
-            "sleep 0.1"
+            "$TC qdisc add dev $IFB handle 1: root ets bands 2 strict 1",
+            "$TC class change dev $IFB parent 1: classid 1:1 ets",
+            "$TC qdisc add dev $IFB parent 1:1 handle 10: fq_codel memory_limit 1 flows 1 target 0.1ms interval 1ms",
+            "$TC filter add dev $IFB parent 1: protocol ip prio 1 u32 match ip protocol 1 0xff flowid 1:1",
+            "$TC qdisc add dev $DEV1 ingress",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 1 u32 match ip protocol 1 0xff action mirred egress mirror dev $IFB"
         ],
-        "cmdUnderTest": "$TC -s qdisc show dev $DUMMY",
+        "scapy": {
+            "iface": "$DEV0",
+            "count": 5,
+            "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+        },
+        "cmdUnderTest": "$TC -s qdisc show dev $IFB",
         "expExitCode": "0",
-        "verifyCmd": "$TC -s qdisc show dev $DUMMY | grep -A 5 'qdisc fq_codel'",
+        "verifyCmd": "$TC -s qdisc show dev $IFB | grep -A 5 'qdisc fq_codel'",
         "matchPattern": "dropped [1-9][0-9]*",
         "matchCount": "1",
         "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
+            "$TC qdisc del dev $IFB root",
+            "$TC qdisc del dev $DEV1 ingress"
         ]
     },
     {
-- 
2.54.0


