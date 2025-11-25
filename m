Return-Path: <netdev+bounces-241660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FCFC87489
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D67594E33A0
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 22:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476AD3002DE;
	Tue, 25 Nov 2025 22:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="OY6osGdd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06572DF15B
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 22:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764108155; cv=none; b=s5uNHzLjbCqo5Ocgp3UQfS7ChwYMXxTZnWTfWy4C3VZUe56KYa5dqnU63iXahqnVkTOhgTh3sLsYEJZ/tfnjylm4nTwhEL6qDUHJm1JWoEb2v78ebeAOIRD2PBy6LS7BHiPc77QrzNZrI6cMXw67NRBUpPRLcEQ6K3WRn6VLHpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764108155; c=relaxed/simple;
	bh=S+/gF2DqarVkPwX1TUdyC9IYtOT8iKuWjZmkl6QSpWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/TOOI+bL8XsSetL05en6p45zzawwWKrTmUeff11lRHnIgKWJxoHRU25mVWiiyNpgtcVl2mH9pKNGXoxVtMOgVyWsWhBcA78D+31hb+BfceQpMVYqh/IXOZE6yXqHcqUbwej7e6rQ9Bam5ObO3Oh9zLC30qG/4pBmFXEulvBbvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=OY6osGdd; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bc2abdcfc6fso3663907a12.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 14:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1764108153; x=1764712953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLLp+9xoYFeMM6ThcXlZ5mTZXoCrUuoipov9zgXj5Hk=;
        b=OY6osGddBGEneA8Avf48FnbA+Nh/qcbHQctg6vlrc+Sc57GELFlLuhoin4GYC5VYwi
         8utx2Lm5ZTg7wHBsFr9LeOkGk1cMB6M/bQ/xbA+TVlv2qihzjkzEGqW7Ff+jxTSLymmR
         7aqJnTP9xjMDG513kcqO7EVBeL+fHpG3F1zz0SPzeUI/9aw7YfLaUnLLCf0KRRGj210E
         4NVUMcMzn/wPV8yp9hwB7FeFqps2+zrjQp65MiEUaiLtNsRclvaHqxTYuhKb2uaFiHYQ
         MXV1CONb80kiBoxDtTy1E18sieuz/THdfLgDSkxHbrUXfZ6NA7d1I/x3CUEG4nvgkHv0
         oYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764108153; x=1764712953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QLLp+9xoYFeMM6ThcXlZ5mTZXoCrUuoipov9zgXj5Hk=;
        b=aMnl0ZlfYBO/pPcxUClwdz2eeaR2c+ZsHrnes3543A9kIOq6ekvOj1O0Xbx7cAt9wN
         +BoFqf5CtsvRmpqf+HWZ5DfCuOaWVheifDuLCHSlihxOOPoitNve9YKgr7aTYN40oJNu
         CAJ2+z5/r6tyDmsxGTsTldOS9Y1cljyyoOSF8LbaclRgrE29exjb723XM8D+QEliDzYH
         WbxeneA1x0C3EvQ8iDcpTH0Imri3itf//xafn0p7OhadQIBPNS2tWvG01wJHKaimDz/R
         cf08pIU96OQRhiMskQXtFIZwjakF+DpcWDqspeqa4EfnZPldKW75RNYbzUP4bc+5T+e8
         NcqA==
X-Gm-Message-State: AOJu0YxCB/QCHvNbdNbUnIzAlMEEdq9rVeznYwqjyarZNtnsAbHXajiI
	kYxxrv3zjx9A9Osm+Jni6AOsQUeSZm+t41IXPmLzBZJPih1ynxl4cSGTWAXGt3eEmw==
X-Gm-Gg: ASbGncuAurOGZekY0GXmfTaSmRZFKVKRRa/ZMszikGZglt+coTqdN0C9OTB9+Ps1hPK
	1ydYGvvX35O5tnjRsFv+UdvuZRTw9rxU6thU1uuT1zwUaKA8MXKwQfedmgIOUzuLRZ1gsUCxlzq
	/+1dhvX8xZtXa8EcqBaKoSsZOxyuM7kwyLguxRKXb+cRQUenJcwbSgYXzcmkCehZlnMmtJOBjt0
	neYpr/MRYrKIMLioBAsXKXTRCOfViLLWy/7Z9uhHHuMpw/IajweERKnc7eXLWtow5hJukt0XjQl
	2QAVe/vfdv91rLETbWzqqz3CCcvLvGb9UaVF+AtplhooE6aqJAiw3V0EsbW3fuGaLxEAR0mrppv
	9X4XJ6KQgInlJZsK2rY8Bu8asNxXp9SidctFFuP4j72xXIZLLLXiE9mBC5kj5pX1ecngl1ZHHh0
	+ZpLp1Byhz5XDYPiL/FMZaYlJwml+Ce4FojHWstNM+0q5QjwCXFGs=
X-Google-Smtp-Source: AGHT+IHYWLHwfJQFY5vPSpfY4MhaPUMp6tbUtQbHpPh6Vb3yoGU/MUbAJFQn9lUN23VjbXJqfRBt5A==
X-Received: by 2002:a05:7301:1298:b0:2a4:3593:dddd with SMTP id 5a478bee46e88-2a7195804a8mr10507256eec.10.1764108152650;
        Tue, 25 Nov 2025 14:02:32 -0800 (PST)
Received: from p1.tailc0aff1.ts.net (209-147-139-51.nat.asu.edu. [209.147.139.51])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc3d0bb6sm93697505eec.2.2025.11.25.14.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 14:02:31 -0800 (PST)
From: Xiang Mei <xmei5@asu.edu>
To: security@kernel.org
Cc: netdev@vger.kernel.org,
	toke@toke.dk,
	xiyou.wangcong@gmail.com,
	cake@lists.bufferbloat.net,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v6 2/2] selftests/tc-testing: Check Cake Scheduler when enqueue drops packets
Date: Tue, 25 Nov 2025 15:02:13 -0700
Message-ID: <20251125220213.3155360-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125220213.3155360-1-xmei5@asu.edu>
References: <20251125220213.3155360-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests that trigger packet drops in cake_enqueue(). The tests use
CAKE under a QFQ parent/class, then replace CAKE with NETEM to exercise
the previously fixed bug where cake_enqueue() drops a packet in the
same flow and returns NET_XMIT_CN.

Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 .../tc-testing/tc-tests/qdiscs/cake.json      | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/cake.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/cake.json
index c4c5f7ba0e0f..47ecd3fb1ea4 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/cake.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/cake.json
@@ -441,5 +441,33 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+	"id": "4366",
+	"name": "Enqueue CAKE with packets dropping",
+	"category": [
+	    "qdisc",
+	    "cake",
+	    "netem"
+	],
+	"plugins": {
+	    "requires": "nsPlugin"
+	},
+	"setup":[
+	    "$TC qdisc add dev $DUMMY handle 1: root qfq",
+	    "$TC class add dev $DUMMY parent 1: classid 1:1 qfq maxpkt 1024",
+	    "$TC qdisc add dev $DUMMY parent 1:1 handle 2: cake memlimit 9",
+	    "$TC filter add dev $DUMMY protocol ip parent 1: prio 1 u32 match ip protocol 1 0xff flowid 1:1",
+	    "ping -I$DUMMY -f -c1 -s64 -W1 10.10.10.1 || true",
+	    "$TC qdisc replace dev $DUMMY parent 1:1 handle 3: netem delay 0ms"
+	],
+	"cmdUnderTest": "ping -I$DUMMY -f -c1 -s64 -W1 10.10.10.1 || true",
+	"expExitCode": "0",
+	"verifyCmd": "$TC -s qdisc show dev $DUMMY",
+	"matchPattern": "qdisc qfq 1:",
+	"matchCount": "1",
+	"teardown": [
+	    "$TC qdisc del dev $DUMMY handle 1: root"
+	]
     }
 ]
-- 
2.43.0


