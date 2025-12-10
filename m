Return-Path: <netdev+bounces-244272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BDFCB376C
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 17:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FF88300EF38
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 16:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210BB29617D;
	Wed, 10 Dec 2025 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="eQqpFfh5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E5D296BBE
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765383801; cv=none; b=rbknEWQFAyFoxF230VpKJsZ2RqGX5AACQQ+57ukqaFTCOs0gJ48SaM/Ox9uKCJoaC1EBBSammyoWxBSIr3k1RlsuzyG6LxydLwIqiGVknVKpiMWZuJwqTMyTcX/acA0ftPdn5XfkahK+jjELdFgNsGEKs55ifBq7O8Dop3B5GB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765383801; c=relaxed/simple;
	bh=zsaZqRo6+OBqJyZ7bcQ/kkWpiFYICWnzAx4flmPXcPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rKIOJgHtOPVw21BLrAqkya8OedSvk0pOrtD44Bxwdkyn1tLlpd+0dJHFx1F4tLugGFLXOcGW4CxDQVoiq3ynbSkCux/dEVf+9Bo9fDWc/+58z42/8oqSqaCsVXLk6R94etgBsXGK+uhJ1xbZQhqs+aub1GNzD6kLCNJhDLTv9CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=eQqpFfh5; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-880576ebe38so48816d6.2
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 08:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1765383797; x=1765988597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEWKlu78QRgtnGp8S7jauDYzDBKLBE3uQ+0ULpCzYEw=;
        b=eQqpFfh5rxaKyz1Cz5rcDQ/9IsDryERI9XG5WXCZZTBYqIsgQvjg/YSRAT5ORGNmiS
         pN1Thvdrd9A0nNQesOS/W4A2aJIj2cICRcbJ2qZXXc8q26eRR1w7hH6x+BbBIMWKWTVj
         /grjnwUWKCeWF5fXdpcf80CguC+0QGadP6jdfh/cpGDDj4vwjcGTeDNbpWPVTqMA+xOh
         G8CmfiC+705ESE9ZgiyXPqYSiSHXy57RxtFrqbLhSjerzAhRcwk68OtW8in29PbWMmz8
         oaVuTYI7oyHvfZ4Zg3vcAl6pNq8pBCLf78MCePsypWuF/cvcWkcR03j3OM4wIojK+0rs
         SaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765383797; x=1765988597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xEWKlu78QRgtnGp8S7jauDYzDBKLBE3uQ+0ULpCzYEw=;
        b=JQjHXmT7NAds7FTneyBQdpufsWliRA9ziHhDyNIo9KK9AbhvRnWLP0FiM881cYyyf9
         GM7rBmuWDfedzIk5pK88Qgc6qGO7z2NQdjCvsxFB5WTKsW66d+j5L7odobxvL4UWOqI3
         Imbtw+EfVtop+WW9+9NLlN6Gl81S86iRf+KKsm2kv9sAaCruGZU/IUH7DyfEbsq77+sE
         CgXKiD8cVOYBYKJ4iCSCXHipENL9c55roFXxM9lUh2InWOh1rnQhfevKB5iyTrwDtpJO
         nShv2T4HTAwV52irUHe6kesvoHh7z/ZDwdJBZTZIWnyLnZ9vpXThbiavZCe4eEkdN4BW
         md3w==
X-Gm-Message-State: AOJu0Yw5U4ahRR50gWGhaTIb8X98tgZGHhpyGxtlqSBtQhBg69gm9jvy
	SMnB5zYMDy2vbSMwtei24wgoRP0XeRD33hy21Fk7vbXwBgOcrItN6i1SYjVdFpltYA==
X-Gm-Gg: AY/fxX4T5Ie8ndtJLdDugN+t9L4vx5cCCmISQvvGJfPrzFhXqSzjlTc8H8tJrtHSCeA
	VqtTWDVDOJV+DyDcBZf3gmQCXHDM9oQET7Q+uYBur0ZWRAWq9oeVpwJEy4Tfe0mO7Um003VuIWx
	fDgm2/uYfVa2x3hnasSrGpnGlIFU327hccS/lzgMFlOSM+71jb0NbELLV8WJtsDre0SbiFkhtuL
	yiiR2JyjM9DsErQRC8cwr2Ge3HXYKeFUabVg2BhOsbaGHttu78o/TWB9NXyMfoVe+3CoM/4ZIXt
	L10ezyAMymn2DCQQYOLDPo8OBLiIpidEqwya4Wc1/2ZLHzVwp3nw33WqXyxjoF48tE2RjrMshBy
	+QLS5QlKRgF+KAChJ1vcAvtCiYMEJrntmLFaARnY3xZhommOGvopTwSF6iiB9PcfRsOUXtT8wDW
	sdvg2yrpg8NKc=
X-Google-Smtp-Source: AGHT+IGG952If7Ivo08O6eJrjF1Nc4op0DeuZHFp6EUzKU+yAsP4x18QE6XjKw5F0N/S+HPCiE2Pmg==
X-Received: by 2002:a05:6214:b6a:b0:81c:96cc:f7ec with SMTP id 6a1803df08f44-88863a64954mr45566506d6.12.1765383796810;
        Wed, 10 Dec 2025 08:23:16 -0800 (PST)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8886eb1d624sm1044506d6.0.2025.12.10.08.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 08:23:16 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	dcaratti@redhat.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 2/2] selftests/tc-testing: Test case exercising potential mirred redirect deadlock
Date: Wed, 10 Dec 2025 11:22:55 -0500
Message-Id: <20251210162255.1057663-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251210162255.1057663-1-jhs@mojatatu.com>
References: <20251210162255.1057663-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Nogueira <victor@mojatatu.com>

Add a test case that reproduces deadlock scenario where the user has
a drr qdisc attached to root and has a mirred action that redirects to
self on egress

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-testing/tc-tests/actions/mirred.json   | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
index b73bd255ea36..da156feabcbf 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
@@ -1052,5 +1052,51 @@
             "$TC qdisc del dev $DEV1 ingress_block 21 clsact",
             "$TC actions flush action mirred"
         ]
+    },
+    {
+        "id": "7eba",
+        "name": "Redirect multiport: dummy egress ->  dummy egress (Loop)",
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
+            "$TC qdisc add dev $DUMMY handle 1: root drr",
+            "$TC filter add dev $DUMMY parent 1: protocol ip prio 10 matchall action mirred egress redirect dev $DUMMY index 1"
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
+            "$TC qdisc del dev $DUMMY root"
+        ]
     }
 ]
-- 
2.34.1


