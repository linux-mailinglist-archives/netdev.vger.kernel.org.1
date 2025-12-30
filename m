Return-Path: <netdev+bounces-246385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32057CEA87E
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 20:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ADCA301B81E
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 19:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8EC2DC767;
	Tue, 30 Dec 2025 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="zuzb+alh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F427145F
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767122301; cv=none; b=gLTJTdqCn9aZS1+mBrJv5+Or99BMxo4XK7sew276VPG++hF7dGx5zbQSKwNFdVAM+YUjUaYn/Hyj3t/fnrfRSsQyUI72MCC4hsjDOZgjxWagZEv3NXzKBLw3UeyZJ9sG9DOpTlsIQ45rWmyOt9EWpUX2gfmKrr9Sv8KKCJCjftc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767122301; c=relaxed/simple;
	bh=z9omgvc12kkRDC5d1qizZewxjVlwGlpOy3feVmGOZyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u+HeZShU+HoqKjVyXYpunDTfusUvc0ZlQFbzSp7YSejizQLs23atym62DoeS53kDpoooGxX+7GYKyQGOCPo/zyneRitz6uDqkRyQVz6VLgdYrc2Np9Rg47WBef/IOBoh2y+oQ19+09LUw6w1PCneTd7qYYFqOJUPg7P1fvvbUBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=zuzb+alh; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4eda77e2358so90592811cf.1
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 11:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1767122298; x=1767727098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajYuhtWL5PAsZb+FBfTZPURM15KG50rUqf/7o+1z0U0=;
        b=zuzb+alhtgSIGMvUgO6FpBk6uno/fvkdsrxNb9PdSev1CJ2hHoAl1642JyeXVMfjF7
         FbtkfwRnbZq1LwOUVLNVxCW1i3KWUmh8j/CGbz4UPL1rxmpqXiEw4b1IU7jyW7AeJRnZ
         KVHLReGOiaQixkDw6TSnWn8LUGzKEaiU1F/ZTVYg05HmcEZczJ5beUpHT89ZO/sbcmrt
         Ejr1RgWe/LezcMgMdgIdBruyAXrbBl7Fj+HejVw9v6m5WC2jEz9hoavM8T8dX8tipvIg
         h/wkhz2rGH+WAkpnGUguqEjiReCCwPuZIdNQPi1okVwW2uUm0DBMTpGM9YH8bT3kG/9h
         ykXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767122298; x=1767727098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ajYuhtWL5PAsZb+FBfTZPURM15KG50rUqf/7o+1z0U0=;
        b=gVFOcYJ0ubaKA9ZM4+G61ceuI40VcfmEH9ji5EeZuZHJUhWM29iDxnW4gr6XgsR/AB
         hS0G3LRV/Od3PRvYn8DrCJclNUuAxC1bsuoxaNrR4rHJ01POFo9MHoG7DUmye1r/kJ0S
         OzjFZJ2QTxd1J4cMf+G6LKJnwc6L1qbVnqC7wOOCq+Pxn8ySPo7FxZUcSAfcV1YXnKyK
         5J0a05e03FlyQtnjZD4JYIX9WwBWMmmGMTQUYsD4k6OmqFpSsRhc+VSY/62CgBkwlF+i
         BNteHTwHSCPoMYAkFnNP/oI/g4QABeOXSNv9Luuwc/VDAQWBOQGCO67MwVfl80ybdSy5
         1IVw==
X-Gm-Message-State: AOJu0YyB+O/MP8qVDlT6q18kJQgPM77Mh8JYsdOKYzk+2Svm4Vtdoz6Q
	Ik3G5G5RlDMhMVnNwtGKYdd/6t+YsKQkHdDN0rU33Nsi6RSPxm7rhWanzIe3hUn4ow==
X-Gm-Gg: AY/fxX47LVj0MFvkYbf7RvgGRfIBhqzF7yQvr6meusvuDS2QSdJ1WMT3Ao1LdYmEiv6
	KgwJFLS1EGYY486wUyCB+i5QiX9UFjeEq8oM+RImHAYbE4j5WTGim0amDwcw9JvTK8MbUciSfGH
	RamVDhWZ2u6Ml/Zt47bEND1GSdUk/wyeAPBfc2Jfg6bGfrYveg9k08plGjo6v0GYieXnhPflyPc
	nTneAWCd/4vLVTuzNfUvQ8qYHFu3whCyn8ereBahiyr7CN6d3Etm/YlCFXm65jyAKKYu7BdcEKc
	sfGsZBQ3xorPjgisU6DFZ5h4vmiaCG+qCnoSUnQ88CiNsZtrjHOn1Jt1BY+oa6RvUkAG+aZ9D6v
	wv7v6xixCHkBPm8yFBWVZBcfKUyRWXr3Krj2WU0OB5SZWAnRtgixbydEnDng+UGIuv/Y/8f0ZAA
	0QvrTzc1sQz+ifXIYwzkVlce6cexQ3BcfzH3Y87h9HeuW6yxnyMrUtHHbtnXSNHYlzYajOO26PV
	rTn20t/aEU=
X-Google-Smtp-Source: AGHT+IHuCvss04Ol4FSWFsjOyHKEZa4lE5DjuKiVnEC4MqTsmbVW9JxerFEBIPPnoyAOy4WhuoyWAA==
X-Received: by 2002:a05:622a:4209:b0:4f1:b947:aa04 with SMTP id d75a77b69052e-4f4abcef4c3mr536060971cf.18.1767122298488;
        Tue, 30 Dec 2025 11:18:18 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1621w-grc-18-70-50-89-69.dsl.bell.ca. [70.50.89.69])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac62f973sm256121391cf.18.2025.12.30.11.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 11:18:17 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	victor@mojatatu.com
Subject: [PATCH net 2/2] selftests/tc-testing: Add test case redirecting to self on egress
Date: Tue, 30 Dec 2025 14:18:14 -0500
Message-Id: <20251230191814.213789-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251230191814.213789-1-jhs@mojatatu.com>
References: <20251230191814.213789-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Nogueira <victor@mojatatu.com>

Add single mirred test case that attempts to redirect to self on egress
using clsact

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 .../tc-testing/tc-tests/actions/mirred.json   | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
index da156feabcbf..b056eb966871 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
@@ -1098,5 +1098,52 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY root"
         ]
+    },
+    {
+        "id": "4ed9",
+        "name": "Try to redirect to self on egress with clsact",
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
+            "$TC filter add dev $DUMMY egress protocol ip prio 10 matchall action mirred egress redirect dev $DUMMY index 1"
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
+                        "direction": "egress",
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
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
     }
+
 ]
-- 
2.52.0


