Return-Path: <netdev+bounces-249563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C15BAD1AF49
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 20:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 487B93064023
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606CE359FA1;
	Tue, 13 Jan 2026 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmjJu24x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14035359715
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331226; cv=none; b=CKsvtHVFmh4uQPdq7FVYl+pIpxUGD/3lGcbhP3fS5UmzdXM3ff6r6O6shdQWEnVh1JVDDc3X8D/YFXUjxReqdgM/kLG0F6Rr+xWvLnKsunhh5lQwEeu4fJW22Ty68gn2qkPg4DbwNwTAVlouR1mpUxIuULjBjuS8n9jMljZsacs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331226; c=relaxed/simple;
	bh=9/XafOtiZsEtp4m9gBKQyd5XkW3SNXLw7a3YwkTa038=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iH1IqIWrtXgpitFI0AMB5fQz3FicWyONePeaLV6NfktRMLxkmc8gw4ksrTvCwkx8+BcZI2/Q8xutnz6YVWXDHsKQp3+AGxzyuASxtvgqFr9iYJSZWoY9QARo5iiD3NhmdjfC4V62gY6w14IYMcDe4KNrKU9qjxsrNU74jC0nVxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmjJu24x; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81f3c14027cso66658b3a.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 11:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768331224; x=1768936024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPkMMkNoJ0CCHSIVgDAkoCL/m9NoAJXXzmyc8NRUbBM=;
        b=GmjJu24x7C0XNk25cZXq8Dug46F+Dfs5yoOCdszthXDVgpWzj55Z5V39ajen1OHALW
         yGINBsfa4ZUYcfp+/GaZA888bUV1dyzDUa+OlGno3ZjyHCtxCk67njKh0R+CirS235sA
         wqNSu83pfdwMOuSuTEQU0VJCBS6JPukriHDO6OUfg/ox/rcVAeAUGulgVla8k2fp28LO
         Cfn/JUG5S9G+42/xsl4wTdshwwXjTmfqNazq/8CUnH9eQEH2klqET+UvAQwkoaMbRbOq
         d9AVL6n+YUF2zjzGSdKPjfJCduHNoVPZB/jncU8+9fAetmoemJDxa1bjXmJM7YywVRCd
         BS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768331224; x=1768936024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xPkMMkNoJ0CCHSIVgDAkoCL/m9NoAJXXzmyc8NRUbBM=;
        b=hiw3Qx3/0+ol4mHEoHPco/kXNgceCRvWJVWw82E21GY/43IaqYpp8Ju1Eade3JsnBd
         W8xw07nR/nCQjOP8g1lDLQ3tLSWDij2M6vVfe4J3ndW1VYbPtl5jNSVlRhFMyTJCDMnk
         XiX+FSJTk7cFkTZmhcyFsPGrzsuWgRZ+hCajr30UHHCvdla+DJwpL144G4bHONoCdgkx
         Hxpg219k6TiJHgB36V4xk9sk/yxS7LqEktuUQkrAm5nNxmC98mgss5ZsNzN1buyGvFD1
         YjtVZkFpL/v9iru/DS+QQ77VAucel3Mr62+XBfkx3X2QwzBQSMr47bfuSIb9k9UQ9wGT
         UdQQ==
X-Gm-Message-State: AOJu0Yzfh+pp1UNVzYHrEp5jXHKKTxo57UUvUi6BYafUHI/+P3uEFlV4
	CEywaSXyuNH/K21kGCZI5Y7WiiFQ02w68OpWKpgkOrRmtKuDLvnIpuk7sofNYQ==
X-Gm-Gg: AY/fxX47EAHFuv9Gv0SBbiVZtOrmmo/R2WiJXP7bN8Vpg4p7NN3mLr1JciaXboJNpSp
	9/uOaUmAhXdpyFizwDonvz5+I9P2t7zFTY6mdH2VIqUnDDBJq4rRzBzJXfo2NXyVJAfXHlcdXOU
	Fx4ep0mHoCrQkLar1cZ08ULr+s4RSTTcNpEs2IaEPVAYAtQfW7O3+fUyrarZntXyKj+xdvbyMsB
	ZFWu+QpJmnbm/BC0bisfUPwVC37qnoDnseQJJHOYoKlATN123VEMvIOBMBCTPqrJTEhVS0psyNn
	5mRHMtlZwHI1ZPreNd1dYiLQ9J6Qa4HnU1vcQ3Ra9VCDZlhdl3ba09kjFosWlFTOLReHJeztw6o
	pfb7hNebLUNfqspGmM7MhRTWTu6Cw3uy9x7kJc69GDFnUvprvYHhHVsTBt9/p5xqNIVQmQ0QgXD
	TCO05O1PTGyYQBafqo
X-Received: by 2002:a05:6a20:549d:b0:38b:d95e:67bc with SMTP id adf61e73a8af0-38bed2ccb62mr98811637.5.1768331223791;
        Tue, 13 Jan 2026 11:07:03 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:7269:2bf1:da7f:a929])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8058d144sm187780b3a.51.2026.01.13.11.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 11:07:02 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [Patch net v7 9/9] selftests/tc-testing: Add a test case for HTB with netem
Date: Tue, 13 Jan 2026 11:06:34 -0800
Message-Id: <20260113190634.681734-10-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113190634.681734-1-xiyou.wangcong@gmail.com>
References: <20260113190634.681734-1-xiyou.wangcong@gmail.com>
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
index 4ebdb27e39b3..83ff9e7406f2 100644
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


