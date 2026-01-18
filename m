Return-Path: <netdev+bounces-250816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EACB2D39303
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 07:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C42ED303D158
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 06:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34B625782D;
	Sun, 18 Jan 2026 06:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtQeS3OR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E85267AF2
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 06:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768716978; cv=none; b=qTv1vzx7opMeK/iUihrtc0saNPOvP01G9NN2n2Ipg45fYt2Dhw1byiXSeO1THOMvgYVJSyhvzxJ+oE1So9HLeNbwJW2FvcgV7/fLsw3tEvQ6PvmZjMHD/XPQGNeSqLMrApv5hSN/gxAjofbt8zWyGfkXPJgcXSNekIQ1wgNgn9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768716978; c=relaxed/simple;
	bh=vJKUC0dD44/ed1XaD6o58p/Lzhtf0MdqJh5epK9cBCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hwiVfbgLitq1fPz60pI3LWOfmreq0Z2qCiV3w9dwWpnYmKawI5a1Rbk5NqOEDI77KlgT6ZewAaTz9cAp0GnvYYN8mdRaOw67OlCSSe3UbJIebOzHr449R4aEezFo7r5YpS0qpW37/qnt8I2mRmVroZ3uDhTusg7rV0UAvLdf9CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtQeS3OR; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ac3d5ab81bso3571094eec.1
        for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 22:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768716973; x=1769321773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRomxEN3kaHgpy9a+UkSkvpmrxwK2woNsc+VVRtwSoM=;
        b=VtQeS3ORziz3OuVAQ8zIhzUQX02MdW1PbHO2c3HIoiQ0GSr2DXgntyC0B7SzvngqYX
         h/XfvCPEXLZHhNBlLM/0cVySVWFFGU6DNMGnUMUVPD4297ox2+6CsJ32K9o2lxmKGl0n
         1oZhmgalCwjwhhHnNnHCAZiKg3F9GnNvqb3If2nG2aXSsFiJVEhkt65EAbBcPjSDh59c
         QHEk4gtQYLYrSwYBUSAZx2RlLDtE116l5xmb5WmNnLJ2sQchb9kdzD43RnReO7pnKX6x
         mBo6yRduZ+NsalW5aW7RwV9SEj1yhJjNU1nXnw55s1aU3E7nuj+EGj3FyW/pBWH5WCAf
         9gvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768716973; x=1769321773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dRomxEN3kaHgpy9a+UkSkvpmrxwK2woNsc+VVRtwSoM=;
        b=Nisfcy6XLCTUu6g8FAlE+4Z9uOt828Yow2IKDiwzE+TzOz2Ly1Ni6qXX5c/45LEi1h
         Kyt2K21pNikDs1s5IAcx3amFa3BU/8rmiPr7rQM0aJtU5Lx7lCNq3wAvb7eqVKJStcDs
         AG/QAJV4OWGg/DbnxGoZnEQkWqC/COgCGSAuZmtxdlsTzjHEbUf/Nmvz7aBSK7PJriBF
         2w3Lf/DGP4ds/CijVp9YF6oHOAp21nTnx6AjPWDnnhjS8IzWE5zHkF2r1+lqp5TARr7b
         hNYyyR7KrJ43TgblsfvdVqVtMuIYV3Ez/d2BEVHhXDdjQZ+HUx/Wfhm+LyqYqAudqjuJ
         U1lA==
X-Gm-Message-State: AOJu0YzISXBXndLqQDnaXgpyy6Wfu5CSvs88wNycTUijY+ruxsDTSmxh
	aOJKToSvW3dZV4EIZZNdYy+6S4QPoJAMsCGnBnBLb/FgCVZhtTDDatG7LtnH9w==
X-Gm-Gg: AY/fxX6zpTz6LMohMoqoouGDb0tASor6vEvg/tSUlABnIdcHr5llFxtVXDPt7SnO5Z1
	BTD4MzgOfAtXkd0ateJgUwIdu1+ZtosXTIP46ug0upUD/rlWYE02vZ6bqiil2DqbBQYQRxZDdJt
	nTMSFBoEKVu7Ye/w8ni50WMAFwD2MAE+Q1qQ4bKr1CBPrYL0E1c1g5L8sTSdo9nuaDP9h7bMf4z
	hfNpRSGAl4XZCFY1OEBnmQR20YzyLAtTm8AQ2M73ucaFpeMDn2Hcs3tk83P1ukQeR/4ijYAhJbH
	pp7MPnv91e4YYlzY6onq7eJrF2C/hdf0B7Fay1OhoTewSag4sasYtUHArH7WSO/OFBYokzDr5w1
	1eiKQsj8nNpmWTsGmGxoVRTWH7pxBmM5tgcmTZEnvrMiFMLz4LesXUVRQMZ8bOH1kAQIg39AGUy
	3IHAJjy8UWhzzzIhjQ
X-Received: by 2002:a05:7300:f10c:b0:2ae:6024:7a49 with SMTP id 5a478bee46e88-2b6b4e9793amr4322859eec.30.1768716972739;
        Sat, 17 Jan 2026 22:16:12 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:8fdd:4695:1309:5b93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c65sm8163816eec.8.2026.01.17.22.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 22:16:11 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [Patch net v8 9/9] selftests/tc-testing: Add a test case for HTB with netem
Date: Sat, 17 Jan 2026 22:15:15 -0800
Message-Id: <20260118061515.930322-10-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260118061515.930322-1-xiyou.wangcong@gmail.com>
References: <20260118061515.930322-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test is requested by Stephen and Jakub during review,
it is for validating backlog.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 6cecea3f25ee..2c2ffb146a64 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -988,6 +988,39 @@
             "$TC qdisc del dev $DUMMY root handle 1: prio"
         ]
     },
+    {
+        "id": "3c5d",
+        "name": "Test HTB with NETEM duplication Backlog Accounting",
+        "category": [
+            "qdisc",
+            "htb",
+            "netem"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin"
+            ]
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: htb default 1",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 htb rate 100mbit",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 10: netem limit 4 duplicate 100%",
+            [
+                "ping -c1 -W0.01 -I $DUMMY 10.10.11.11",
+                1
+            ]
+        ],
+        "cmdUnderTest": "$TC qdisc del dev $DUMMY handle 10: parent 1:1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
+        "matchPattern": "backlog 0b 0p",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root handle 1: htb"
+        ]
+    },
     {
         "id": "4989",
         "name": "Try to add an fq child to an ingress qdisc",
-- 
2.34.1


