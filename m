Return-Path: <netdev+bounces-268285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCcBJwxyuGn5dgEAu9opvQ
	(envelope-from <netdev+bounces-268285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:11:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A157A2A08ED
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 221F7302607C
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 21:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF3D35B637;
	Mon, 16 Mar 2026 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="jLtoINjd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17FA364022
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 21:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773695483; cv=none; b=ab65smx1Hol/DIOVXw5oNkbhn5pczGUMubpt5t8M8p1uMS9ITGxqy7hiLPhF22jzI9xozVuYURIWUXQf0o8WpLorWz3swDNqCIAIIQOW8rFqSdLQNv+UKNjD7tXyxPajQxVqHLIA6mLtV3JJZjl3lv1J1eh0Uv4djlN6wqGtT1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773695483; c=relaxed/simple;
	bh=PfQuUtyBeAJe+pofE4Hha9Bv47Gpih/GI5MxsWmeONI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U1ZyI13/8hXmSQzBeoonTzzx8ZDuQYTLWTiBHDMG4a9Y6EdNRkHfktEL1WbGbSSsPpKuOwsYwJlbq8qnPzb871ZyGbfOx0pl3goktZA1R6iAmBAdXrEQTnS5durT2uRFFrSTfxhdM8BHQL8zmorbOOC8wc2AoFOuVAxnMMqSYXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=jLtoINjd; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-89c4468686dso26964416d6.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 14:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773695480; x=1774300280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJyehmBvW9DPuVDZsw3GruKuvCyFCwdzD3V1PqXRjY4=;
        b=jLtoINjdvlr5stZWhfYL/fsbTOUZhSzkJcIRD1y2UGs9HgMEHirFOHRJNKNT0Xl8ed
         KL2CzO37/r0uQl2wn9h3wlyKSyO6dmfNIRV4arAblT7fLVRdm3v1TTmMn/ydlv/hF9+Z
         gA4pC71SlJmfYYl1S2cOFlVFp2ZvnwWZmfxdlYRlptVvOM4w9YTrrVMcpJJ+cjvB4HqH
         r4AgLGgfHp4xAPufCWoy2uF//7jMnDFd28w7DINwyspdukQ9etJoMIUb8ppxGiAIxcoe
         MEdPYd+oiE63dSDCHNaruCt/P+pFiBrFLtpVPwFAqKY3yzZLmAwe1ZmLBi6MQetZKccB
         JIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773695480; x=1774300280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CJyehmBvW9DPuVDZsw3GruKuvCyFCwdzD3V1PqXRjY4=;
        b=QgHLNR35HqtS3EnOZSqZAOBPg8WaF8gn8gDMCs1P3o2OjaChNZF/4fETJ+vZanlEIi
         Tv1zBADUtYcZISegf2bGb9saefLQfBdgG+Kboj/8tiiC6WYr+/+YYbpoG+i9HPT8keZt
         ajZfmlcJPfmFZYhGzChmcRFmVkzpjrH3epNYRQoDWZccwBswVEyNYIim7ZXvslqhQUUy
         qXtOG03FbfP6MBydPHst7AxeEulAS3rXFwP4QZk7d7UInuZLg4aHIl4EZPUDSuXzVAdS
         cl6MUqkWG7ZFdKqHorlaw2AbOKFql0wRFvkY1/1TaWLToMgROwML6XTEoqG7dxVUsMz/
         s89Q==
X-Gm-Message-State: AOJu0Yw7Utnqd9OdkynLpx8nVMrhjs6Tx7/oPuKRjqJ0m8OX8yM3kYx1
	poGZVrYmB8AkCv4rSgW1CY9KVHLH4PtpTHwj3sMGJ2Whdac7lEzYL/54OeuXpNg6/DfLod1NT7Y
	5qIg=
X-Gm-Gg: ATEYQzy7pfntaK+ibjOKlpSxkDM6P4kl9VSmC8I33m3ZZKjb8yW1qVfXMKWC7x/DWMR
	rrgAPPoXpSekTYlRuHPxIcQS5lKBtyhn5X80WQeCAUc0zWapdQO/MwUaFgSL0G5j1TpyWd+9rRL
	WaTm85ZEj8lncXCODTwSIXqJy6FVp3xIRbufBWFjQbz5jA7SqHxwxu5dRFhDDZgq27gWi6H2hu3
	/p2Ss9eZmF+G/z6wwbiGcgTMOlhw9XdF9rOvzpkWtdkz1690OQjgooJ7xtlIqkllU3a2DcHCleM
	mIrZ2jaXm2+BpaCEQhRpUlugzXPxyHlpk8d3sX2Iy9W81TtEe2eQABMRhmSD4vpD8Xe1/Mvpx1o
	S5aIvMWbtWswTDVn2p32DcaS2ZQZFMEO39i8rqzW23eJ9pxefCmVFkIRgG0I2jDSCVundfz0rlI
	xBKgKXixvAe+JfIrFK0gJ3e8M=
X-Received: by 2002:a05:6214:d08:b0:89c:5a3f:15a1 with SMTP id 6a1803df08f44-89c5a3f2267mr41428516d6.58.1773695480231;
        Mon, 16 Mar 2026 14:11:20 -0700 (PDT)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c53374573sm27356266d6.7.2026.03.16.14.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:11:19 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	stephen@networkplumber.org,
	victor@mojatatu.com,
	will@willsroot.io,
	xmei5@asu.edu,
	pctammela@mojatatu.com,
	savy@syst3mfailure.io,
	kuniyu@google.com,
	toke@toke.dk,
	willemdebruijnkernel@gmail.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v2 6/6] selftests/tc-testing: Add netem/mirred test cases exercising loops
Date: Mon, 16 Mar 2026 17:10:52 -0400
Message-Id: <20260316211052.332383-7-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316211052.332383-1-jhs@mojatatu.com>
References: <20260316211052.332383-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268285-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,mojatatu.com,willsroot.io,asu.edu,syst3mfailure.io,toke.dk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mojatatu.com:email,mojatatu.com:mid]
X-Rspamd-Queue-Id: A157A2A08ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Victor Nogueira <victor@mojatatu.com>

Add mirred loop test cases to validate that those will be caught and other
test cases that were previously misinterpreted as loops by mirred.
Also add a netem nested duplicate test case to validate that it won't
cause an infinite loop

This commit adds 14 test cases:

- Redirect multiport: dummy egress -> dev1 ingress -> dummy egress (Loop)
- Redirect multiport: dev1 ingress -> dev1 egress -> dev1 ingress (Loop)
- Redirect multiport: dev1 ingress -> dummy ingress -> dev1 egress (No Loop)
- Redirect multiport: dev1 ingress -> dummy ingress -> dev1 ingress (Loop)
- Redirect multiport: dev1 ingress -> dummy egress -> dev1 ingress (Loop)
- Redirect multiport: dummy egress -> dev1 ingress -> dummy egress (Loop)
- Redirect multiport: dev1 ingress -> dummy ingress -> dummy egress -> dev1 egress (No Loop)
- Redirect multiport: dev1 ingress -> dummy egress -> dev1 egress (No Loop)
- Redirect multiport: dev1 ingress -> dummy egress -> dev1 egress (No Loop)
- Redirect multiport: dev1 ingress -> dummy egress -> dummy ingress (No Loop)
- Redirect singleport: dev1 ingress -> dev1 ingress (Loop)
- Redirect singleport: dummy egress -> dummy ingress (No Loop)
- Redirect multiport: dev1 ingress -> dummy ingress -> dummy egress (No Loop)
- Test netem's recursive duplicate

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 .../tc-testing/tc-tests/actions/mirred.json   | 616 +++++++++++++++++-
 .../tc-testing/tc-tests/qdiscs/netem.json     |  33 +-
 2 files changed, 647 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
index b056eb966871..9eb32cdf1ed3 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
@@ -1144,6 +1144,620 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY clsact"
         ]
+    },
+    {
+        "id": "531c",
+        "name": "Redirect multiport: dummy egress -> dev1 ingress -> dummy egress (Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin"
+            ]
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY clsact",
+            "$TC filter add dev $DUMMY egress protocol ip prio 10 matchall action mirred ingress redirect dev $DEV1 index 1",
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred egress redirect dev $DUMMY index 2"
+        ],
+        "cmdUnderTest": "ping -c1 -W0.01 -I $DUMMY 10.10.10.1",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 3
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY clsact",
+            "$TC qdisc del dev $DEV1 clsact"
+        ]
+    },
+    {
+        "id": "b1d7",
+        "name": "Redirect multiport: dev1 ingress -> dev1 egress -> dev1 ingress (Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred egress redirect dev $DEV1 index 1"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 egress protocol ip prio 11 matchall action mirred ingress redirect dev $DEV1 index 2",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "egress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 3
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact"
+        ]
+    },
+    {
+        "id": "c66d",
+        "name": "Redirect multiport: dev1 ingress -> dummy ingress -> dev1 egress (No Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred ingress redirect dev $DUMMY index 1",
+            "$TC qdisc add dev $DUMMY clsact"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY ingress protocol ip prio 11 matchall action mirred egress redirect dev $DEV1 index 2",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact",
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
+    },
+    {
+        "id": "aa99",
+        "name": "Redirect multiport: dev1 ingress -> dummy ingress -> dev1 ingress (Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred ingress redirect dev $DUMMY index 1",
+            "$TC qdisc add dev $DUMMY clsact"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY ingress protocol ip prio 11 matchall action mirred ingress redirect dev $DEV1 index 2",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 2,
+                            "overlimits": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact",
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
+    },
+    {
+        "id": "37d7",
+        "name": "Redirect multiport: dev1 ingress -> dummy egress -> dev1 ingress (Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred egress redirect dev $DUMMY index 1",
+            "$TC qdisc add dev $DUMMY clsact"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY egress protocol ip prio 11 matchall action mirred ingress redirect dev $DEV1 index 2",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "egress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 3
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact",
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
+    },
+    {
+        "id": "6d02",
+        "name": "Redirect multiport: dummy egress -> dev1 ingress -> dummy egress (Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin"
+            ]
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY clsact",
+            "$TC filter add dev $DUMMY egress protocol ip prio 10 matchall action mirred ingress redirect dev $DEV1 index 1",
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 11 matchall action mirred egress redirect dev $DUMMY index 2"
+        ],
+        "cmdUnderTest": "ping -c1 -W0.01 -I $DUMMY 10.10.10.1",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 3
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY clsact",
+            "$TC qdisc del dev $DEV1 clsact"
+        ]
+    },
+    {
+        "id": "8115",
+        "name": "Redirect multiport: dev1 ingress -> dummy ingress -> dummy egress -> dev1 egress (No Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred ingress redirect dev $DUMMY index 1",
+            "$TC qdisc add dev $DUMMY clsact",
+            "$TC filter add dev $DUMMY ingress protocol ip prio 11 matchall action mirred egress redirect dev $DUMMY index 2"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY egress protocol ip prio 12 matchall action mirred egress redirect dev $DEV1 index 3",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact",
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
+    },
+    {
+        "id": "9eb3",
+        "name": "Redirect multiport: dev1 ingress -> dummy egress -> dev1 egress (No Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred egress redirect dev $DUMMY index 1",
+            "$TC qdisc add dev $DUMMY clsact"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY egress protocol ip prio 11 matchall action mirred egress redirect dev $DEV1 index 2",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "egress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact",
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
+    },
+    {
+        "id": "d837",
+        "name": "Redirect multiport: dev1 ingress -> dummy egress -> dummy ingress (No Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred egress redirect dev $DUMMY index 1",
+            "$TC qdisc add dev $DUMMY clsact"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY egress protocol ip prio 11 matchall action mirred ingress redirect dev $DUMMY index 2",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "egress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact",
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
+    },
+    {
+        "id": "2071",
+        "name": "Redirect multiport: dev1 ingress -> dev1 ingress (Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred ingress redirect dev $DEV1 index 1",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 1,
+                            "overlimits": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact"
+        ]
+    },
+    {
+        "id": "0101",
+        "name": "Redirect singleport: dummy egress -> dummy ingress (No Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin"
+            ]
+        },
+        "setup": [
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY clsact",
+            "$TC filter add dev $DUMMY egress protocol ip prio 11 matchall action mirred ingress redirect dev $DUMMY index 1"
+        ],
+        "cmdUnderTest": "ping -c1 -W0.01 -I $DUMMY 10.10.10.1",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
+    },
+    {
+        "id": "cf97",
+        "name": "Redirect multiport: dev1 ingress -> dummy ingress -> dummy egress (No Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred ingress redirect dev $DUMMY index 1",
+            "$TC qdisc add dev $DUMMY clsact"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY ingress protocol ip prio 11 matchall action mirred egress redirect dev $DUMMY index 2",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact",
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
     }
-
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
index 3c4444961488..7c954989069d 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
@@ -336,5 +336,36 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
-    }
+    },
+    {
+        "id": "8c17",
+        "name": "Test netem's recursive duplicate",
+        "category": [
+            "qdisc",
+            "netem"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: netem limit 1 duplicate 100%",
+            "$TC qdisc add dev $DUMMY parent 1: handle 2: netem duplicate 100%"
+        ],
+        "cmdUnderTest": "ping -c 1 10.10.11.11 -W 0.01",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -s -j qdisc ls dev $DUMMY root",
+        "matchJSON": [
+            {
+                "kind": "netem",
+                "handle": "1:",
+                "bytes": 294,
+                "packets": 3
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+     }
 ]
-- 
2.34.1


