Return-Path: <netdev+bounces-260960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DJANqX9nmlAYgQAu9opvQ
	(envelope-from <netdev+bounces-260960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:48:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF531985A2
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9CE23119CB2
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7657A3C1969;
	Wed, 25 Feb 2026 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Gb7H2x8X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084013C199B
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772027052; cv=none; b=Plr7ChB+4pnZBaE7tU6fF0NhHnUrvbhCvjUgu/EamB/2qWRadWvkhImWqotKLFN+o/RopwuA5rl3JbmhbwhHd0Djite3uEW/ghSyU2n9rff5AWFre11KlC6BmmajJxGc+/IBDGfsoTKPb2S8lbbcEvnHimX73yhZU3XgnEEaTok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772027052; c=relaxed/simple;
	bh=Z3wETqtdY+99nIQi00tRq5Q8s30/sYNgwtM3aoAhZdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJDiLgcHpM2+FXT/KptjkHF5xC7HVccPSTIAwgTr4tFSBovk7ksKg3rDLwGrvd3kq9o276wEC/631es1+3IECSGR3oVtpOSiQ632BP+9Bt6uBcfgiuwwmoUohQCAw5xlQd/VAec1Xxwh/OE315F/J+8pOy8tJzW5lkAlUPUI8pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Gb7H2x8X; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56a857578a8so180492e0c.3
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 05:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772027050; x=1772631850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jm8FF3h6v51A2110njbtLbphOX6DPLuV8jnMfO76iwo=;
        b=Gb7H2x8Xkp+HM7VHxMrGf1g57xjx+2dRKwNrnbUs51/dPliSd2Tq+0yy3phIpjqEPK
         2H5VReMDEVFPukMLLpYEicSJSDpZN/U+7ZDSm6fHUQVUsKdHP4NBOdhYMWafJF3VKoPh
         mzpS2VUFapso/rptO1iHwSwyf4Ijh6opRPw939VY20U9nBbyWG0XCu8vf0vJFQliy3Ig
         rcQM6lV2+TvafG98MravFzDVieNmZ5L4k4VsvEQMh9p8Ui3XH6WHh6aHYqopv/BJki/I
         kPCayDwm4w7eCr9DIIEXvV+iwlvml5Vgw+e+CUcIwQbC3STyOHMPD7W1dC1FjfcP95u8
         0DBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772027050; x=1772631850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jm8FF3h6v51A2110njbtLbphOX6DPLuV8jnMfO76iwo=;
        b=A/00WvvAxWZQB9/FAJAt0dU3MTnMDvp1SAljJjddDzYHo5i4a+sJpfCMb3dMiagmxn
         sGza0iY6FI0HoV+3hdDVAN9DI3luxblR3ZcPyZEzch2bPAldavbYDqJ+OK2fj/nXe/sc
         JhurREf//0Fbs/Us/oHpprVGHoJnxPjGXEoZmTQ1OTpZ3Z6spY7TZiiH3SF/1Gw3Jkfo
         Bc+ytQnAJTSLKiPmhbxQEqB2ivjrnXk7Ff12DbRkhjABjg0bBHSqxTQh/qG3jqk/L0R+
         XWh3wShHK11ES9qQzHye8Ge9gSlRROb/fV+tptuXF6XlwUBh+laBa30QQKlnEidqzJpQ
         THuQ==
X-Gm-Message-State: AOJu0Yz3CL8eMbtrMgPDA18BbuI6nWSSNoYG+3UQxD88MpJqnmmCVaUT
	xy2zBg5XmNN8ySHGtqItcEcehQ54C5l/EDrvFOc8AruNSb3S6gXd2xwBsme27sUi+A==
X-Gm-Gg: ATEYQzzRW7Ty1AT0oZFxLdtkRaeQLWSRA92L/dueujsI0ybgMbAbHZWM4EIrBFcuLUb
	tSW3FGiQaxHuQggzLLghsf5Co6hxRjamtpKmR8jUmaxyC5OExFIiaLJL4LkikJWFs3IAXomo5fQ
	dl8d/JAoXUZWFr6WXoXQjJiKdzzA1YC3Uak3YTZpMqiaj0FYca9QOWzLacS/91gTKWi9lZfvB4A
	oGh/Qg0ey5HcjntyyzSxOBhbBdKJQac19/vYU7GCUr8v8N0RrfIHCxfT2bYBfz0xOdm03NUKxYh
	JXeyZJ6TiSLr3zyXMi0Eg38QiPFmLQEVjY+g55Hjk6ZoNEb0IKBqk3UEypii+oD07lbaecVj2Y+
	KEW0IJJEU4ZAJCFeuDWwEzgzSXSiWjwD0pssLquYjv+9lCYQdcaZbv9Qjv2w2Ev1gIRxidIHIhh
	wGjgWhNXQ=
X-Received: by 2002:a05:6122:468a:b0:55b:74ac:72cf with SMTP id 71dfb90a1353d-56a8bcb4e16mr238128e0c.17.1772027049852;
        Wed, 25 Feb 2026 05:44:09 -0800 (PST)
Received: from exu-caveira ([2804:14d:5c54:4efb::1c9d])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-568e57d42fbsm15971517e0c.6.2026.02.25.05.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:44:09 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	horms@kernel.org,
	taoliu828@163.com
Cc: netdev@vger.kernel.org,
	pctammela@mojatatu.com,
	km.kim1503@gmail.com
Subject: [PATCH net 2/2] selftests/tc-testing: Create tests to exercise act_ct binding restrictions
Date: Wed, 25 Feb 2026 10:43:49 -0300
Message-ID: <20260225134349.1287037-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225134349.1287037-1-victor@mojatatu.com>
References: <20260225134349.1287037-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260960-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us,163.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.988];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:mid,mojatatu.com:email]
X-Rspamd-Queue-Id: 3BF531985A2
X-Rspamd-Action: no action

Add 4 test cases to exercise new act_ct binding restrictions:

- Try to attach act_ct to an ets qdisc
- Attach act_ct to an ingress qdisc
- Attach act_ct to a clsact/egress qdisc
- Attach act_ct to a shared block

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 .../tc-testing/tc-tests/actions/ct.json       | 159 ++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/ct.json b/tools/testing/selftests/tc-testing/tc-tests/actions/ct.json
index 7d07c55bb668..33bb8f3ff8ed 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/ct.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/ct.json
@@ -505,5 +505,164 @@
         "teardown": [
             "$TC qdisc del dev $DEV1 ingress"
         ]
+    },
+    {
+        "id": "8883",
+        "name": "Try to attach act_ct to an ets qdisc",
+        "category": [
+            "actions",
+            "ct"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            [
+                "$TC actions flush action ct",
+                0,
+                1,
+                255
+            ],
+            "$TC qdisc add dev $DEV1 root handle 1: ets bands 2"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 parent 1: prio 1 protocol ip matchall action ct index 42",
+        "expExitCode": "2",
+        "verifyCmd": "$TC -j filter ls dev $DEV1 parent 1: prio 1 protocol ip",
+        "matchJSON": [],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 root"
+        ]
+    },
+    {
+        "id": "3b10",
+        "name": "Attach act_ct to an ingress qdisc",
+        "category": [
+            "actions",
+            "ct"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            [
+                "$TC actions flush action ct",
+                0,
+                1,
+                255
+            ],
+            "$TC qdisc add dev $DEV1 ingress"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 ingress prio 1 protocol ip matchall action ct index 42",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j filter ls dev $DEV1 ingress prio 1 protocol ip",
+        "matchJSON": [
+            {
+                "kind": "matchall"
+            },
+            {
+                "options": {
+                    "actions": [
+                        {
+                            "order": 1,
+                            "kind": "ct",
+                            "index": 42,
+                            "ref": 1,
+                            "bind": 1
+                        }
+                    ]
+                }
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    },
+    {
+        "id": "0337",
+        "name": "Attach act_ct to a clsact/egress qdisc",
+        "category": [
+            "actions",
+            "ct"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            [
+                "$TC actions flush action ct",
+                0,
+                1,
+                255
+            ],
+            "$TC qdisc add dev $DEV1 clsact"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 egress prio 1 protocol ip matchall action ct index 42",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j filter ls dev $DEV1 egress prio 1 protocol ip",
+        "matchJSON": [
+            {
+                "kind": "matchall"
+            },
+            {
+                "options": {
+                    "actions": [
+                        {
+                            "order": 1,
+                            "kind": "ct",
+                            "index": 42,
+                            "ref": 1,
+                            "bind": 1
+                        }
+                    ]
+                }
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact"
+        ]
+    },
+    {
+        "id": "4f60",
+        "name": "Attach act_ct to a shared block",
+        "category": [
+            "actions",
+            "ct"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            [
+                "$TC actions flush action ct",
+                0,
+                1,
+                255
+            ],
+            "$TC qdisc add dev $DEV1 ingress_block 21 clsact"
+        ],
+        "cmdUnderTest": "$TC filter add block 21 prio 1 protocol ip matchall action ct index 42",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j filter ls block 21 prio 1 protocol ip",
+        "matchJSON": [
+            {
+                "kind": "matchall"
+            },
+            {
+                "options": {
+                    "actions": [
+                        {
+                            "order": 1,
+                            "kind": "ct",
+                            "index": 42,
+                            "ref": 1,
+                            "bind": 1
+                        }
+                    ]
+                }
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress_block 21 clsact"
+        ]
     }
 ]
-- 
2.52.0


