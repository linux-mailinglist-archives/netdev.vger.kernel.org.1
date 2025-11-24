Return-Path: <netdev+bounces-241293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437B3C82615
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 21:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF4B3AD2F0
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 20:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0635F32E156;
	Mon, 24 Nov 2025 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="nEvl05tB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430D632E12F
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 20:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764014929; cv=none; b=f8mRgC49iW3q7xPXB75B63uDnuTs0Bju0JZO+e/g3u8ckVV1bltbSn/8RRBAI+VGezDRSmf+Pjel9BX79sj8yBx6vnOea8PxH9pf5xQBCkf99QQiSUmqDCNOFj3nNyNfmGQph23K3T6OEyWUBUZvLkMLwSdZpl2VgWKvbGGcibQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764014929; c=relaxed/simple;
	bh=VI8VGK1e/q2I42k6jxF0jgWe+NIMZ+YiLyaDHhaP5EI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gJqqgI/jz4CvSFbimK5LhokTUqKSMBWTHQILGEru7dMtijjEJkDjOdhGWxP7PazJRyuHsASawP9r46gqo6vvIFrNdggXMIV+9Ptj+Hj052mPpMC2UsneA6Ubz9Xv4A1FIbN+7Yb7gaFsRZrQouN4z9kBp6rwJ96js+tvOn6X3xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=nEvl05tB; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ee0084fd98so39641271cf.3
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 12:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1764014927; x=1764619727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLaiDCq6yDuwTRLt5kfPPRKYdI27SWliFJEXJpdU4tc=;
        b=nEvl05tBCwhZRn9BzmOJyfnjuDSOM39AxccZSl7iIKI25IFKz9nA+r1K0BdgMXJgwh
         PFOjibKZ/UJyEJs3vdcKW8U1uY/L9TaLP3sKwl0ch4qKGNhyMRBnxUJk/i2CmgjDFTM7
         7j0A2agQwupYjW/pACxo1/vHZbTgilnVf8rYQVMX3t0zmVc+TBMsydHwVHrzHqMVT23T
         GhV28T3b2wjB03dG1OUBDN3ulBxyFmbG9lsaT7dqh+9glmK/5ruUkAlgx3A9luP1ql/H
         HB0+cbzP8ZTi+y+YfiaTjS6Ii6k1sqXSsnn5fif5ONquXHKy2Y8OMZEjP9f4WAZ2njGz
         oB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764014927; x=1764619727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hLaiDCq6yDuwTRLt5kfPPRKYdI27SWliFJEXJpdU4tc=;
        b=sXTRt4YSphsaG2cEEAL3f8lmXjzxjm3Ly24zpb2ThAop0Fvvuh+aKKLMoGUCPU2Ehb
         AmnkkHck4sf85/7mEjJHd6V9xAsCE51D9+vRXB9P0FveG+Oo2PfgFYVgaeqewxLSNWM+
         TNMwoCTb+mAAFMH1HQIqb3b90XQ/ktbbCi3d7yMitrve7kYH7sQ2uyWwF3rMZv9L1MiO
         M0a+Y7lSlTCwK8lYp5L9l0RO7IDUQzBl90vMp7VAQnKpuP0NPsIyv+FV0BHdhEoyErd2
         iOGSzXd7J5Xqm2oxACiqVI8asEuYnD6Fj195AZ2AWkdP4e2/pchviqKj6PDpWBKwEZKj
         9Pmw==
X-Forwarded-Encrypted: i=1; AJvYcCWlHQtvPfj8pV47BlL+7uUubDDvVEluiGyK/vs/oYKnJxlc0mrStmLWxDx7qHwZJfnRfWqgLPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoayNkGZPbU0aU+NA3OC4gATRoDZ490EQ1nlT2NBUuLgVtODKS
	0NXE4e4Ktgbh0RbJyYZWLqqwvW33x8euSM1HjdZ2SgeTrc+i4JkMWNUCD5hIQsMs4g==
X-Gm-Gg: ASbGncsg5X8udDr+kFYdaPsQd4sN167sgg/lg8Za5hLzb4h9/hTaj4A1TXG/0Nzwqqr
	jSPjjyuIeey24iLhcOaU79d5tUGg1mlIKi1jXE/tM6AKvf3tKz7mkPlhugtO7UsJ8JaNWkXeHGF
	O37A+MfodwvpHWrITlwS7uaqFoc19ZQiKc1r22L3e+J7oB2jMf8xMhJMQfDDTCiXEG9e6sgut/M
	WYuyOyOGUTUrM0QmIXnmwqtxzY00D3CMMh1qxR2vf5rW6/znIliVpBqcFUf3T8blxklOZ6bbqFH
	c/Emnbe5pD4Z5HW5o/e5ChSKdNlqYafW0ZJftTlIVOPYpBQ7pAu3nXGw9Yine/R0cgEr8GcYn2Q
	eCf1/645EKl2hHTr+wxKg+TxEzvahkbFtqWmZjw4jT7ZXBzz1dwvoFmj9V0ZRUzgwYTgQn/UJq5
	NIzYTYtfXepAA=
X-Google-Smtp-Source: AGHT+IFsKrxVSVDo4P6CQuVGQZeJNaTWZR6v6px3cERaJZ8zTehrJupyj0TxODHl1p71ncjQ4K0Feg==
X-Received: by 2002:a05:622a:ce:b0:4eb:9eaf:ab4d with SMTP id d75a77b69052e-4ee58b14616mr192155361cf.62.1764014927051;
        Mon, 24 Nov 2025 12:08:47 -0800 (PST)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee48e90b62sm93195231cf.34.2025.11.24.12.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 12:08:46 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com
Cc: jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org,
	dcaratti@redhat.com,
	Victor Nogueira <victor@mojatatu.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net-next 2/2] selftests/tc-testing: Add test cases exercising mirred redirects (with loops)
Date: Mon, 24 Nov 2025 15:08:25 -0500
Message-Id: <20251124200825.241037-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251124200825.241037-1-jhs@mojatatu.com>
References: <20251124200825.241037-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Nogueira <victor@mojatatu.com>

Add two tdc test cases for mirred which cause loops.
The first one does a redirect dev1 ingress -> dummy egress -> dev1 ingress
The second one does a redirect dummy egress -> dev1 ingress -> dummy egress

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-testing/tc-tests/actions/mirred.json   | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
index b73bd255ea36..97800f2e26f2 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
@@ -1052,5 +1052,108 @@
             "$TC qdisc del dev $DEV1 ingress_block 21 clsact",
             "$TC actions flush action mirred"
         ]
+    },
+    {
+        "id": "6941",
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
+        "scapy": {
+            "iface": "$DEV0",
+            "count": 1,
+            "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred egress redirect dev $DUMMY index 1",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY clsact",
+            "$TC filter add dev $DUMMY egress protocol ip prio 10 matchall action mirred ingress redirect dev $DEV1 index 2"
+        ],
+        "cmdUnderTest": "$TC -j -s actions get action mirred index 1",
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
+        "id": "ceb4",
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
+                            "packets": 2,
+                            "overlimits": 1
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
     }
 ]
-- 
2.34.1


