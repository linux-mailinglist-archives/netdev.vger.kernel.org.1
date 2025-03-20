Return-Path: <netdev+bounces-176621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBC2A6B1A1
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 00:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7966884860
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 23:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268F622C322;
	Thu, 20 Mar 2025 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/tizkAk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927BE22A80A
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 23:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513163; cv=none; b=ZhYMX6QhtchFa50TShBVX2sf/bTCS0InN4fFImBLSG3gjOZi2dy2/x7wqiXG6+4ugUV4COiGNC+eadMk4otU+ByVPjHhuM7QqKWbpal0TIkt4L57ue7HI0InmCYNrlYsptpAMHFMi/0NsSranuebWAxMi4UxP+168X//0bT8QtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513163; c=relaxed/simple;
	bh=N3gwU2aYFgLjz4sJd3sme4Kcax+yzrXCg3WN5uhLEVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=crscLeQ9iyI3P/aR+YbkP3TYz7hDWBN7YNuSE1NzL5MXPHfTCldKWU6tVqoE4DAnA68oaw11b6HcE4dHFrzDxWa/WodqCoN5dFmYVmu+rzzOn1x8cp8oAE2Mdue+Kcvs0pwUyRaQnkymMZahs55RTjnwenIp489Ehe2HmzMJjVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/tizkAk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2235189adaeso26374845ad.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 16:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742513159; x=1743117959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHCFWdnmwqvUHW4PbNGpgV9QRjiKmpmsUuGO9NWPrKg=;
        b=R/tizkAkkf4VEsHpoVqLZxaJeJNHK+Uphbl5qfSxiRjO4WWQN7Va3z+5pp+A0o2xIk
         /UeiEBqgRg7oeQQKDUfcoADi+72JztP7027TxEZeQg8x+TIvlhJ8SqWUpn93NAN8nTXo
         xqMul9wGYdXG50muqwiMCClNj+KZUVq+eeh0642clK+CLxDjNGAuMIMI0xNG6YtdFGzB
         vfUJWDMDcu9Eq9zhwCmwjzx45bQSnhQPo0uGGc39ZeFDgkrgUewxNoSqTw5C2E6fJN/O
         lDBZ84lrGERLVAsDUCfcHb6RJCusIftbsvfWGua3zOgjVAgpWlZBSoAM1X4SbiB/Mo3D
         GJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742513159; x=1743117959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHCFWdnmwqvUHW4PbNGpgV9QRjiKmpmsUuGO9NWPrKg=;
        b=o6RToHVoxSRvNUBXxRoTcuYU2H9i9m4jtFk/RWGRPoE2y7RoX6v9IKcm6HtM0qY8sY
         isFgYNsnFwCnntDLJ/vFinQ4BiP9DED+whZXCnoU2R1SyOfELI/6H2QrfA6V5hk9g4RD
         aDR02hHnUdjD0ZxsTAFdUMpDPK7eqUFL0m4nK/68hy9khMIUIJwguk+k22Boi3Kbts+p
         aHRTbgrpT0TH8DNX3+PG9k6/14JwvvCq4zgt464k+HoSBTxJiL4WgJLUGnJcJMbq9WyJ
         SOPNoeop6yarFsrQg8jsJI6XYhlYx6JWC9CQVWiV9IYaYKu+VtGwWc7vqzBZJiQ1kFW2
         DliQ==
X-Gm-Message-State: AOJu0Yzo1eK8KWfCW+ruz8R+jkareLOY0/kyxXbw9a1Y1jeL+HyHXaVB
	ij495XdgiyK+NbbFXHmlCoRjcvxBMn8p5dyamkrYFbqeSe1k3fSViAONeEMA
X-Gm-Gg: ASbGncsHgkD2N5Ac+kbbIuM4T0SOtePzQwS3X/8My+mKpAfa6ZaOFiZKJQUKSpQV4Zt
	wGce4seLCrd9+MmWzV+8svJZ9iK9iTPIeWHG09bjG4Qp/c1qYkeU/g3wPkZ+VoUUQJtl6b3d7Sd
	DJ8tmzNZncDjxy6EI0/YonNR10urMIj8pRz3XiHBi1DNyv6DoKHmSCLqnUxoHFjxr1A/iGAaOMa
	ItB8dJqwv3Y7P4PVD6Wa5mxzZ3h0pBkLx7/l741F6I3MtE1LS+IHQFLOthaVqD3hZnPoRgsut+F
	n5Rz+X5aLkhFmncEv0hu8bs/LxWeYJ4NpcebgZrBx2WVcHeUqvsrNO+FygcVr8hduQ==
X-Google-Smtp-Source: AGHT+IFHdQhvS1Rq1/sOY9zqhitAiwBZ8dRD9GN1xjxyWAGqCfZeeysDkA6bzQli/pVyR/0jL/jLnw==
X-Received: by 2002:a17:902:ce84:b0:223:fb95:b019 with SMTP id d9443c01a7336-2265e7a1b2emr87029745ad.24.1742513159421;
        Thu, 20 Mar 2025 16:25:59 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611ccf8sm416306b3a.120.2025.03.20.16.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 16:25:58 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	edumazet@google.com,
	gerrard.tai@starlabs.sg,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [Patch net 09/12] selftests/tc-testing: Add a test case for FQ_CODEL with QFQ parent
Date: Thu, 20 Mar 2025 16:25:36 -0700
Message-Id: <20250320232539.486091-9-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320232539.486091-1-xiyou.wangcong@gmail.com>
References: <20250320232211.485785-1-xiyou.wangcong@gmail.com>
 <20250320232539.486091-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case for FQ_CODEL with QFQ parent to verify packet drop
behavior when the queue becomes empty. This helps ensure proper
notification mechanisms between qdiscs.

Note this is best-effort, it is hard to play with those parameters
perfectly to always trigger ->qlen_notify().

Cc: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 3ee3197ec7d9..d69d2fde1c1c 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -188,5 +188,36 @@
             "$TC qdisc del dev $DUMMY handle 1: root",
             "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
         ]
+    },
+    {
+        "id": "a4be",
+        "name": "Test FQ_CODEL with QFQ parent - force packet drop with empty queue",
+        "category": [
+            "qdisc",
+            "fq_codel",
+            "qfq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY handle 1: root qfq",
+            "$TC class add dev $DUMMY parent 1: classid 1:10 qfq weight 1 maxpkt 1000",
+            "$TC qdisc add dev $DUMMY parent 1:10 handle 10: fq_codel memory_limit 1 flows 1 target 0.1ms interval 1ms",
+            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match ip protocol 1 0xff flowid 1:10",
+            "ping -c 10 -s 1000 -f -I $DUMMY 10.10.10.1 > /dev/null || true",
+            "sleep 0.1"
+        ],
+        "cmdUnderTest": "$TC -s qdisc show dev $DUMMY",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY | grep -A 5 'qdisc fq_codel'",
+        "matchPattern": "dropped [1-9][0-9]*",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
+        ]
     }
 ]
-- 
2.34.1


