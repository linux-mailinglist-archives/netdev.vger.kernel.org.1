Return-Path: <netdev+bounces-297811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kEkNBF67KWrwcQMAu9opvQ
	(envelope-from <netdev+bounces-297811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:30:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 638CD66C838
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:30:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=LQd2zPl2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297811-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297811-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA5AF318D780
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BDF369996;
	Wed, 10 Jun 2026 19:29:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ED73148DD
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 19:29:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119762; cv=none; b=RM3U5u6f66JEripNhm8htLAiVSfchqt2Y+LuZc9KAIvn2VQndEfk3APgSffeF3qLQ7oKvjn+fZA3TCtFX9Ze5Ii8lYaJwdOPqdmrewJVrXInkxPfioV9hVGYtX8dw8debYZkQG8a1VwKnfKYA69dX2wneh/eAvwSjgqrJMw1LTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119762; c=relaxed/simple;
	bh=ZrsKdC25F8Ywi62ZGuUnhTQNf5Be9AUSklXsbBQ6W94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1adDZTvXrP7utP6wvBTiwLtzm/eysOqI2WnPxslftDth21OcwJ8ZJnexsFs/kHekglDsffSjM5Yu8vRZCV/YE0J2G2TKurrb8w9zRa3ekzRioat/IHZOlHtmi9OmMT5yAvreCh1fRcbyp1UzHG9PEOyVXLKoC65jqkjGnq4CmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=LQd2zPl2; arc=none smtp.client-ip=209.85.221.169
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-59bbe027424so5811502e0c.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 12:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781119760; x=1781724560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAr+fmv7IJ5iUmUV2gJYWMun5bbtiKssq5iQBTveoVM=;
        b=LQd2zPl2tXLLp3GWl2H6hwVcKx9Ay+K7gqe4sCJCnUM53bncTPftbSdw7PJo37WCBY
         JPznaqboFLgoHFQ7uaS+bkSsRguym/0kSFsAA6ffc/Ai41MEdtVQGmJ3hXTTwy9JJO9W
         W3HnOR421s7//ihkqFk33YqqB4khd0XfhaqtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781119760; x=1781724560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wAr+fmv7IJ5iUmUV2gJYWMun5bbtiKssq5iQBTveoVM=;
        b=tGIi2jcjlYWj0dIrR7dQ1pBsclUhvt6n/3ju+iZ70WfL6I914Y1FyViHOdmrS5bcmR
         49wkgrN9S7FZB1xZSC56IGEs91Sj4eltFhx7K6oGwU2iCXo+t7mlauYtxUbuozb8cYw1
         Mf5KBZQaVCGVtvBtWUTo6GlHRBUV8HTl5BK8iyWOiytiz7rpMjvRAgqjSLki4Tfwx8Kl
         sUdg9NPYxI1dYIyCdtIjpbk3yrMM06DRKuBo/Ut7ARfakJfUGZLCHf0yGWFhv+cYz/wi
         Hy6wIBJD0HLadhFOsZHp2QFf0oRS7fDQmJ+2pbY0bF0e4xeenX00Gdpsjn93vosCF4Vj
         /emQ==
X-Gm-Message-State: AOJu0YySLrTzENVjn/mdMLAs5eGBMc+yaAnVuDk+3k5dHkB8UZXB0JxV
	/actB5o2LxiiCT7+JWC2y7ByHwvfDL4Cpp6EjNf8r01R6Eu+D3h7mWsngX/PYidmvjgeo2X8TCg
	n9JMl9Q==
X-Gm-Gg: Acq92OHX9rSvUut/SkpddLx37JE3COCC8agQ2GBoaFyj5BLn2HqjpAHk0QmUAd/viFM
	R+y7NsUSncQEyXL4sUmoLKacqziVUv/B0G3Ha84Oq3iVCXH3PlTphPoo4X/SRdpYmQ57vHEFCEL
	Go2B4K50zMYOVXgcKiNeGxSTsmIYggyRe96I8XMjDwufLj7XmEu1CJYiI6VKg3h3RTL/zrwQ/tm
	MrS9UIAKqNJ+HtzIAkOrojg3FktDaW3ShK+0rWKcgY7g+QYANqgbC5lvFFZgo4tgbiBC9ZtqwL/
	+4hAa2H9jpkqLjRS9GeAtXWDOLmYwZ4YwHGwhXSYvOsmOKeTfR1TbhHuIV5BU83HtnWpyiPCzqz
	aYDJqzIWCnxcmdnNLY8QZa+XF15oP1Nt0Rjj4xXK21gDW5v5RzfIM2AotffJG58WuEks+zUYNG1
	YnvrkI2o12ZGPZKIUTvrk64fazkFVN/w9mesCKapEPLqCB
X-Received: by 2002:a05:6122:6e0e:b0:575:2072:54d1 with SMTP id 71dfb90a1353d-5ac50ccc252mr15883903e0c.8.1781119759652;
        Wed, 10 Jun 2026 12:29:19 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67:f17:d82a:d5b8:20a])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d6dc3d3fsm21848563e0c.5.2026.06.10.12.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 12:29:19 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	anirudhrudr@gmail.com,
	pctammela@mojatatu.com,
	ij@kernel.org,
	henrist@henrist.net,
	chia-yu.chang@nokia-bell-labs.com
Subject: [PATCH net 4/4] selftests/tc-testing: Verify child qdisc will not mistakenly deactivate QFQ parent
Date: Wed, 10 Jun 2026 16:28:55 -0300
Message-ID: <20260610192855.3121513-5-victor@mojatatu.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610192855.3121513-1-victor@mojatatu.com>
References: <20260610192855.3121513-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:anirudhrudr@gmail.com,m:pctammela@mojatatu.com,m:ij@kernel.org,m:henrist@henrist.net,m:chia-yu.chang@nokia-bell-labs.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297811-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,mojatatu.com,kernel.org,henrist.net,nokia-bell-labs.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:mid,mojatatu.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 638CD66C838

Create 3 test cases:
- Verify fq_codel won't mistakenly deactivate QFQ parent class during peek
- Verify codel won't mistakenly deactivate QFQ parent class during peek
- Verify dualpi2 won't mistakenly deactivate QFQ parent class during peek

Verify that these 3 qdiscs (fq_codel, codel, dualpi2) will not call
qdisc_tree_reduce_backlog with an incorrect qlen (0) during peek and
mistakenly deactivate a parent class.

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 184 ++++++++++++++++++
 1 file changed, 184 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 82c38a13dfbf..e83e31b932dc 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -1326,5 +1326,189 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+        "id": "c797",
+        "name": "Verify fq_codel won't mistakenly deactivate QFQ parent class during peek",
+        "category": [
+            "qdisc",
+            "qfq",
+            "fq_codel"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: qfq",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 qfq weight 1 maxpkt 1000",
+            "$TC class add dev $DUMMY parent 1: classid 1:2 qfq weight 1 maxpkt 1000",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 2:0 plug limit 1024",
+            "$IP l set dev $DUMMY mtu 1500",
+            "$TC qdisc add dev $DUMMY parent 1:2 handle 10: fq_codel target 1 interval 1 flows 1",
+            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match ip dst 10.10.10.1/32 flowid 1:1",
+            "$TC filter add dev $DUMMY parent 1: protocol ip prio 2 u32 match ip dst 10.10.10.2/32 flowid 1:2",
+            "$IP l set dev $DUMMY mtu 65336",
+            "ping -c 1 -I $DUMMY 10.10.10.1 -W0.01 > /dev/null || true",
+            "ping -c 3 -s 2000 -I $DUMMY 10.10.10.2 -W0.01 > /dev/null || true",
+            "sleep 0.1"
+        ],
+        "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 2:0 plug release_indefinite",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s -j qdisc show dev $DUMMY",
+        "matchJSON": [
+            {
+                "kind": "qfq",
+                "handle": "1:",
+                "packets": 3,
+                "drops": 1,
+                "backlog": 0,
+                "qlen": 0
+            },
+            {
+                "kind": "plug",
+                "handle": "2:",
+                "packets": 1,
+                "drops": 0,
+                "backlog": 0,
+                "qlen": 0
+            },
+            {
+                "kind": "fq_codel",
+                "handle": "10:",
+                "packets": 2,
+                "drops": 1,
+                "backlog": 0,
+                "qlen": 0
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
+        ]
+    },
+    {
+        "id": "82d9",
+        "name": "Verify codel won't mistakenly deactivate QFQ parent class during peek",
+        "category": [
+            "qdisc",
+            "qfq",
+            "codel"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: qfq",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 qfq weight 1 maxpkt 1000",
+            "$TC class add dev $DUMMY parent 1: classid 1:2 qfq weight 1 maxpkt 1000",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 2:0 plug limit 1024",
+            "$IP l set dev $DUMMY mtu 1500",
+            "$TC qdisc add dev $DUMMY parent 1:2 handle 10: codel target 1ms interval 1ms",
+            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match ip dst 10.10.10.1/32 flowid 1:1",
+            "$TC filter add dev $DUMMY parent 1: protocol ip prio 2 u32 match ip dst 10.10.10.2/32 flowid 1:2",
+            "$IP l set dev $DUMMY mtu 65336",
+            "ping -c 1 -I $DUMMY 10.10.10.1 -W0.01 > /dev/null || true",
+            "ping -c 3 -s 2000 -I $DUMMY 10.10.10.2 -W0.01 > /dev/null || true",
+            "sleep 0.1"
+        ],
+        "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 2:0 plug release_indefinite",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s -j qdisc show dev $DUMMY",
+        "matchJSON": [
+            {
+                "kind": "qfq",
+                "handle": "1:",
+                "packets": 3,
+                "drops": 1,
+                "backlog": 0,
+                "qlen": 0
+            },
+            {
+                "kind": "plug",
+                "handle": "2:",
+                "packets": 1,
+                "drops": 0,
+                "backlog": 0,
+                "qlen": 0
+            },
+            {
+                "kind": "codel",
+                "handle": "10:",
+                "packets": 2,
+                "drops": 1,
+                "backlog": 0,
+                "qlen": 0
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
+        ]
+    },
+    {
+        "id": "d3da",
+        "name": "Verify dualpi2 won't mistakenly deactivate QFQ parent class during peek",
+        "category": [
+            "qdisc",
+            "qfq",
+            "dualpi2"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true" ,
+            "$TC qdisc add dev $DUMMY root handle 1: qfq",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 qfq weight 1 maxpkt 1000",
+            "$TC class add dev $DUMMY parent 1: classid 1:2 qfq weight 1 maxpkt 1000",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 2:0 plug limit 1024",
+            "$TC qdisc add dev $DUMMY parent 1:2 handle 10: dualpi2 step_thresh 500ms",
+            "$TC filter add dev $DUMMY parent 10: protocol ip prio 1 matchall classid 10:1 action ok",
+            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match ip dst 10.10.10.1/32 flowid 1:1",
+            "$TC filter add dev $DUMMY parent 1: protocol ip prio 2 u32 match ip dst 10.10.10.2/32 flowid 1:2",
+            "ping -c 1 -I $DUMMY 10.10.10.1 -W0.01 || true",
+            "ping -c 3 -i 0.1 -I $DUMMY 10.10.10.2 -W0.01 || true",
+            "sleep 0.7",
+            "ping -c 1 -I $DUMMY 10.10.10.2 -W0.01 || true",
+            "$TC qdisc change dev $DUMMY handle 2:0 plug release_indefinite"
+        ],
+        "cmdUnderTest": "ping -c 1 -I $DUMMY 10.10.10.1 -W0.01",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -s -j qdisc show dev $DUMMY",
+        "matchJSON": [
+            {
+                "kind": "qfq",
+                "handle": "1:",
+                "packets": 4,
+                "drops": 2,
+                "backlog": 0,
+                "qlen": 0
+            },
+            {
+                "kind": "plug",
+                "handle": "2:",
+                "packets": 2,
+                "drops": 0,
+                "backlog": 0,
+                "qlen": 0
+            },
+            {
+                "kind": "dualpi2",
+                "handle": "10:",
+                "packets": 2,
+                "drops": 2,
+                "backlog": 0,
+                "qlen": 0
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
+        ]
     }
 ]
-- 
2.54.0


