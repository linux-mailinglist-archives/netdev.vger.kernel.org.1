Return-Path: <netdev+bounces-303281-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b3MuEdfjQ2pjlAoAu9opvQ
	(envelope-from <netdev+bounces-303281-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:42:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF6F6E6093
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:42:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=rK2LbYjc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303281-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303281-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADC363031125
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EBD449EC2;
	Tue, 30 Jun 2026 15:37:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AAE4048BB
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:37:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833821; cv=none; b=oRP4E9GAoGKYIk0jbh14/RX+VVbeaIjrPfEqB4BiX3LKs45lv2tCjTTMyHUkStClA64UpzV20ZyZCvGKsqfQALSHNtzQtM3Mx41ShWJKoKMWnDC9PwGhNr+CTcDytB+2G9eKZtW2tU8YUpPT9z0y3gMEhiI6ztaNNA4xlR3+FXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833821; c=relaxed/simple;
	bh=/HHA73eb3XSlyGAILsGJwy2p/y/r7JCgeQ2+EYu+VJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RJs9fWHAcb2snGYl0y33zWWj1pQ7LtGJNnPNwVkGBrQVuu9IwZiThqeZjtNwDHvuxyUZGm0h+dASUBt6K5/8b0rb0WbUCuuDQNWReD4qb8w1PDpzfB+qSadvXQDPYL+6Q4YWxcNDMbk4sCUnZ1h9pv77m2Ur+dQ7FH1GOstVfzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=rK2LbYjc; arc=none smtp.client-ip=74.125.82.43
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-13a97ffb312so3477456c88.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 08:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782833819; x=1783438619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=02wc41T6DWOXZJ4TY7zH1GCdBUbd2Je3Glv9F89OTUs=;
        b=rK2LbYjcghoJdoYBMFcbDUKlW/4e30yTH/0TWSmkk4SSHAiufYdVptDqlpeAeNAxOp
         9q77JVMuE42aUQfozEtEG5pojBbtZFVEiBCCc8KZDN9V2l14cMM4tyuJz2cfrX3tfHjD
         Tm845o3plwXD7sDOMhQlNZyouEO1qYTnHjLzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833819; x=1783438619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02wc41T6DWOXZJ4TY7zH1GCdBUbd2Je3Glv9F89OTUs=;
        b=CE/5pTbKUzwYt4OiIoytWb0BandvB1wBmHc3X+AG+j+MKmV+vNKflpWPxFNFxN18Dy
         zIsIab7nTq588DyNpaZh8ZAX+d6trVDuTIONcSHW+1lwimw5WmZ09yeqd9V9DOMMacMX
         FNnGxWNzX41Esu7vk8CwTSVfgfJbMzbAbmzGGd23OlXjhQz2FJpExZgiiZUvlHvHVyHP
         Q9EJ6mjIa1+aDHPeepV3lgvPjljQgsTYjTtEV6Juxnb7onsS9+rYBkyv6/gRNjvJ+8hw
         /dl/XGAnoMLZ2Cx5VVp//nODn20bjf+FyP9b50/ltSyGl07WBwFZ2UBkpzEcqnga2OnI
         uelA==
X-Gm-Message-State: AOJu0YxjjGAosZIQDstSOHJiNq+1kqn0iAPwqRm+L1zl8i6jf+N11nSz
	KU7/HJTr3XNaBShGYGqXKns+TeGicJPABJ9LyHWc++51wHMPjpIT5Tdlno0v+IJE1w==
X-Gm-Gg: AfdE7ck/it1ptOi0QYyQyQjS8rJ21Uk9QVNMuY3j+Vg8FXOhweLgpYJQs+MpeajEV5c
	tVvHIsSIvc6PpuOuXfSwhvU/Ku+DYmnqHYtPHttbTkwz19fwV824CxjBAomvzAFXf0d1LzEiOsA
	MfWbYJ43hJzj8M4xA79vWHI1praUNuO8PIiOAiywQ5HW/nL5gMp12/yqyttrsql0hfFgIkkVdIQ
	X7Q70ik7+pEo4mrGMG45FMcMLG+h4Km8Xf6zKJmKNxUkGYM6vUdKxESkmmV6XjZv4g1WmhzrRFQ
	zt2k3tIKIgwNfBixF44pRSo9KNV7PInfYBFL8tQd3YG7MwjxHAf03f0YCkreleryKInJy98+Krl
	sD6IcN07rxZ1V4AT/t3CBVLRH+pl54IwNldZSXEUHSL5nSDoUm4PnOe/APF6DYzU/pLkjH2bt
X-Received: by 2002:a05:7022:fa5:b0:135:608a:2864 with SMTP id a92af1059eb24-13b2a1dbb23mr2989645c88.33.1782833819052;
        Tue, 30 Jun 2026 08:36:59 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67::1c9d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2ab2dc1fsm8131309c88.6.2026.06.30.08.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:36:57 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	hexlabsecurity@proton.me,
	pctammela@mojatatu.com
Subject: [PATCH net] selftests/tc-testing: Add tests that force multiq and taprio to enqueue to child's gso_skb
Date: Tue, 30 Jun 2026 12:36:51 -0300
Message-ID: <20260630153651.249752-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:hexlabsecurity@proton.me,m:pctammela@mojatatu.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303281-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:mid,mojatatu.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EF6F6E6093

Add test cases to reproduce scenarios fixed recently [1] where
multiqueue and taprio forced their children into enqueueing an skb to
gso_skb (during peek), but failed to dequeue from gso_skb because they
called the child's dequeue callback directly. This causes a desync in the
child's qlen/backlog and results in an eventual null-ptr-deref (with a
qfq or dualpi2 child).

Test cases are the following:

- Force multiq to dequeue from its child's gso_skb with qfq leaf (fb6c)
- Force multiq to dequeue from its child's gso_skb with dualpi2 leaf (1922)
- Force taprio to dequeue from its child's gso_skb with qfq leaf (476f)
- Force taprio to dequeue from its child's gso_skb with dualpi2 leaf (0235)

[1] https://lore.kernel.org/netdev/20260625-b4-disp-31bcb279-v1-0-85c40b83c529@proton.me/

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 164 ++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index a1f97a4b606e..0cf12c50fb74 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -1540,5 +1540,169 @@
             "$TC qdisc del dev $DUMMY root",
             "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
         ]
+    },
+    {
+        "id": "fb6c",
+        "name": "Force multiq to dequeue from its child's gso_skb with qfq leaf",
+        "category": [
+            "qdisc",
+            "tbf",
+            "multiq",
+            "qfq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device",
+            "$IP link set dev $ETH up || true",
+            "$IP l set addr 01:02:03:04:05:06 dev $ETH || true",
+            "$IP n add dev $ETH 10.10.11.1 lladdr 01:02:03:04:05:06 dev $ETH || true",
+            "$IP addr add 10.10.11.10/24 dev $ETH || true",
+            "$TC qdisc add dev $ETH root handle 1: tbf rate 88bit burst 1661b peakrate 2257333 minburst 1024 limit 7b",
+            "$TC qdisc add dev $ETH parent 1: handle 2: multiq",
+            "$TC qdisc add dev $ETH parent 2:1 handle 3: qfq",
+            "$TC class add dev $ETH classid 3:1 parent 3: qfq maxpkt 512 weight 1",
+            "$TC filter add dev $ETH parent 2: protocol all prio 1 matchall action skbedit queue_mapping 0",
+            "$TC filter add dev $ETH parent 3: protocol all prio 1 matchall classid 3:1 action ok"
+        ],
+        "cmdUnderTest": "ping -c 1 10.10.11.1 -W0.01 -I$ETH || true",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s -j qdisc ls dev $ETH parent 1:",
+        "matchJSON": [
+            {
+                "kind": "multiq",
+                "handle": "2:",
+                "bytes": 98,
+                "packets": 1,
+                "backlog": 0,
+                "qlen": 0
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $ETH handle 1: root",
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "1922",
+        "name": "Force multiq to dequeue from its child's gso_skb with dualpi2 leaf",
+        "category": [
+            "qdisc",
+            "tbf",
+            "multiq",
+            "dualpi2"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device",
+            "$IP link set dev $ETH up || true",
+            "$IP l set addr 01:02:03:04:05:06 dev $ETH || true",
+            "$IP n add dev $ETH 10.10.11.1 lladdr 01:02:03:04:05:06 dev $ETH || true",
+            "$IP addr add 10.10.11.10/24 dev $ETH || true",
+            "$TC qdisc add dev $ETH root handle 1: tbf rate 88bit burst 1661b peakrate 2257333 minburst 1024 limit 7b",
+            "$TC qdisc add dev $ETH parent 1: handle 2: multiq",
+            "$TC qdisc add dev $ETH parent 2:1 handle 3: dualpi2",
+            "$TC filter add dev $ETH parent 2: protocol ip prio 1 u32 match ip dst 10.10.11.1 action skbedit queue_mapping 0",
+            "$TC filter add dev $ETH parent 3: protocol ip prio 1 u32 match ip dst 10.10.11.1 classid 3:1 action ok"
+        ],
+        "cmdUnderTest": "ping -c 1 10.10.11.1 -W0.01 -I$ETH || true",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s qdisc ls dev $ETH handle 3:",
+        "matchJSON": [
+            {
+                "kind": "dualpi2",
+                "handle": "3:",
+                "bytes": 98,
+                "packets": 1,
+                "backlog": 0,
+                "qlen": 0
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $ETH handle 1: root",
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "476f",
+        "name": "Force taprio to dequeue from its child's gso_skb with qfq leaf",
+        "category": [
+            "qdisc",
+            "tbf",
+            "multiq",
+            "qfq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device",
+            "$IP link set dev $ETH up || true",
+            "$IP l set addr 01:02:03:04:05:06 dev $ETH || true",
+            "$IP n add dev $ETH 10.10.11.1 lladdr 01:02:03:04:05:06 dev $ETH || true",
+            "$TC qdisc add dev $ETH root handle 1: taprio num_tc 2 map 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 queues 1@0 1@1 base-time 9000000000000000000 sched-entry S 03 200000 flags 0x0 clockid CLOCK_TAI",
+            "$TC qdisc add dev $ETH parent 1:1 handle 3: qfq",
+            "$TC class add dev $ETH classid 3:1 parent 3: qfq maxpkt 512 weight 1",
+            "$TC filter add dev $ETH parent 3: protocol all prio 1 matchall classid 3:1 action ok"
+        ],
+        "cmdUnderTest": "ping -c 1 10.10.11.1 -W0.01 -I$ETH || true",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s -j qdisc ls dev $ETH",
+        "matchJSON": [
+            {
+                "kind": "taprio",
+                "handle": "1:",
+                "bytes": 98,
+                "packets": 1,
+                "backlog": 0,
+                "qlen": 0
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $ETH handle 1: root",
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "0235",
+        "name": "Force taprio to dequeue from its child's gso_skb with dualpi2 leaf",
+        "category": [
+            "qdisc",
+            "tbf",
+            "taprio",
+            "dualpi2"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device",
+            "$IP link set dev $ETH up || true",
+            "$IP l set addr 01:02:03:04:05:06 dev $ETH || true",
+            "$IP n add dev $ETH 10.10.11.1 lladdr 01:02:03:04:05:06 dev $ETH || true",
+            "$TC qdisc add dev $ETH root handle 1: taprio num_tc 2 map 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 queues 1@0 1@1 base-time 9000000000000000000 sched-entry S 03 200000 flags 0x0 clockid CLOCK_TAI",
+            "$TC qdisc replace dev $ETH parent 1:1 handle 3: dualpi2",
+            "$TC filter add dev $ETH parent 3: protocol ip prio 1 u32 match ip dst 10.10.11.1 classid 3:1 action ok"
+        ],
+        "cmdUnderTest": "ping -c 1 10.10.11.1 -W0.01 -I$ETH || true",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s qdisc ls dev $ETH handle 3:",
+        "matchJSON": [
+            {
+                "kind": "dualpi2",
+                "handle": "3:",
+                "bytes": 98,
+                "packets": 1,
+                "backlog": 0,
+                "qlen": 0
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $ETH handle 1: root",
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
     }
 ]
-- 
2.54.0


