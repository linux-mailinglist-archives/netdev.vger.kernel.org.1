Return-Path: <netdev+bounces-186606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CA6A9FDBC
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 01:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3CF465D36
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 23:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABB61F872A;
	Mon, 28 Apr 2025 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKWEuNx/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416302144DD
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745883005; cv=none; b=ZG5Gmfji+mvS0j/QC7tkBGNLwp59uWyo54frXUbRo8KyYX4hPH0n19NLKxwLZscNT+LHpe1CeS8WANUcZ8LJ/gLKG6ZSGtHmOmWE4poFimT8l7NlhjbpIZPPV2fEZziqtJChWIROFoXm6G51ltS0os0/axNYtK3Y3cX4Q9n7Tbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745883005; c=relaxed/simple;
	bh=vPX/9G7rGUdixVWH6XEgU5nXw80wp0iVXQEKff6VvOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OwFmHqsbfzEa6AcHR1ljcmptS29WzSvQtyVJWv/S77rEPYcFRgvkFoIBVrrAjNJ6zRl6OUtpgN2aMFJlnXlOQpPz0azDt4EOl7rutUPM8ZKvwapIQbgU/IRGOJlSTpmJCjdZzcDFyw4sW7IORbCJbYqqIJvS/7NKE/7Ahg4b/mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKWEuNx/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2254e0b4b79so80857995ad.2
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 16:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745883003; x=1746487803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGPEKxRe6SATBC+FewuQTdDmNk1fupKOTGShzVD+Mek=;
        b=CKWEuNx/6PBw80bITud9Xjxe+ngMafQuHDg2EKOvjFOcVquS4E/LwdCLWmqC87dreJ
         suQD1M1+1aBUKjie7OFViYfe58wyrZzLCcY4cDbUGYMLkIFe9oNLx5QS5tXIdKj1IWiN
         tHHWvZKCLQEzelHDtoGSe9e+drCW2se3SQquWXtKQk3yvDl+tQ/Ovvtj/LXSAqP217at
         doO2DotgtLvBHPZ9GgsQ8n38u2rUryHCgxOYSnNNM3BSYvV+POp5eLtDOly8MB01lVYX
         uDeqy5IUD61sZuus7Rrgq+W73CKeLDNNMNTJP0a9LoAWzr04rVNXDO1qayqvFVENfdw8
         BYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745883003; x=1746487803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGPEKxRe6SATBC+FewuQTdDmNk1fupKOTGShzVD+Mek=;
        b=cZ+Zdbi07OlnaiKyNl/WJrBBMHUrjkGO2db02xDjvXSIT5WUiYUjlooR82Lxn5CW53
         uFCeXjtqVtaLm486R9aj3SRXI0PdWQ6W9pkxP9cS6aTsMmYto/VdYaG6KLgkfyUBJSiO
         /PsQnTT+MYT5jDfAg168mMAigOPCNi+JUpQdKmeTZ4CbJ2Oriw/U1DJPw55TPRwnLphi
         a7ebyhVgikZTn9ajXSo/fUeoqc7ROr2nYkhGxGVnh4D827zXv9nkTbQ15C4ZOSB1X2T4
         g31JZE/qYnMIR6aTkXALbB/jJ9oeUPmh2Y+b8s5mT8/RBFJ2UZVM/fhhCU1Q5cgcmEjT
         111g==
X-Gm-Message-State: AOJu0YypfF4cOLMHS2YrFZjDsXz+H6TUdSDfvWGVyxXGCr/jOoI2EYBv
	trqWOxsCK9Clt88uBRNubzdbEzPkDLoQtps0Xyqn5+IPN+jIQfEhUCB+Bj9K
X-Gm-Gg: ASbGnctUe8pQ9eZkFjAK7TExkR+74puUg+Ho50EbL1WLRA2DmAxzgTTSMQe5egwdUg3
	4DolZBMLBZt4COZy30RM0LbWzICUbDmwkGhm/D+QfXiGRFcTYipGXt0p2odN6k65ud9cVSkq+iR
	MIq+Su7L6nx2SSTiIowfB+r1068CEGesIK5jYLtx6t4P//88H3zSDMJ/vNWAFsBXvsbe9AS9KuW
	j9pQmILm2cMmuVLqvJCJkx6ZNuM6cAFHvcmNlul8RFDp9efQ7Bl2DILWk2bQQFEzBInu+8I+pDB
	LPhmSjF23YbObqK0uoJTQI6DxskAEGEUkUoDCPQ5gt0zMIknSr8=
X-Google-Smtp-Source: AGHT+IEnBaH20mQ0xo51RaYGiZCUJvsdV9LiS4aCl/M9KFcFTagqxctF3c2oyBizX5aZV5ntbVpL8A==
X-Received: by 2002:a17:903:2b10:b0:223:668d:eba9 with SMTP id d9443c01a7336-22de5ebb11amr22827535ad.10.1745883003227;
        Mon, 28 Apr 2025 16:30:03 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4db97b3sm89248235ad.55.2025.04.28.16.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 16:30:02 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	alan@wylie.me.uk,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net 2/2] selftests/tc-testing: Add a test case to cover basic HTB+FQ_CODEL case
Date: Mon, 28 Apr 2025 16:29:55 -0700
Message-Id: <20250428232955.1740419-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428232955.1740419-1-xiyou.wangcong@gmail.com>
References: <20250428232955.1740419-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Integrate the reproducer from Alan into TC selftests and use scapy to
generate TCP traffic instead of relying on ping command.

Cc: Alan J. Wylie <alan@wylie.me.uk>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index e26bbc169783..5a8c21735b3a 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -352,5 +352,40 @@
             "$TC qdisc del dev $DUMMY handle 1:0 root",
             "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
         ]
+    },
+    {
+        "id": "62c4",
+        "name": "Test HTB with FQ_CODEL - basic functionality",
+        "category": [
+            "qdisc",
+            "htb",
+            "fq_codel"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 root handle 1: htb default 11",
+            "$TC class add dev $DEV1 parent 1: classid 1:1 htb rate 10kbit",
+            "$TC class add dev $DEV1 parent 1:1 classid 1:11 htb rate 10kbit prio 0 quantum 1486",
+            "$TC qdisc add dev $DEV1 parent 1:11 fq_codel quantum 300 noecn",
+            "sleep 0.5"
+        ],
+        "scapy": {
+            "iface": "$DEV0",
+            "count": 5,
+            "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/TCP(sport=12345, dport=80)"
+        },
+        "cmdUnderTest": "$TC -s qdisc show dev $DEV1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DEV1 | grep -A 5 'qdisc fq_codel'",
+        "matchPattern": "Sent [0-9]+ bytes [0-9]+ pkt",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 handle 1: root"
+        ]
     }
 ]
-- 
2.34.1


