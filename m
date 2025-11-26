Return-Path: <netdev+bounces-242012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8189C8BAF4
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DAA04E8439
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6085B33E354;
	Wed, 26 Nov 2025 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="sMJYhzem"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C106F340286
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186327; cv=none; b=nZhdHdSafT6AEy5/Si6I6J510s/TCjsSTVTDNR3xB/sB5e3PtvEbluhRBT+oPSWjbEOo+Pyod5j0oIFjD8zZZHdWtsgM9YKQ+/K/RVpxSNNsmy80BK4tXGQtdg7QLJChGJUp4UesYAcFW9KxV5uBVz+869Iiegivi7WQtVYe9dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186327; c=relaxed/simple;
	bh=SghC6yyP9gBKlF/H+O0lOacr7+cYWauu07ULJbtnJy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlfH/QtVxhQaoyGFQqqKpds50WQIw8IpF9ruzJHnT633xfHgjGYpr4ybQTzisXDg1uocnMmuqskf1oxSFL8gZgg/SVFN7FKZot2QcN46zbA4GAAh9aqyrnvn8dHGzA12K6BMKQUqqxi8zweddfANrhRLn0tce/RXzfXnPTImoS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=sMJYhzem; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bc274b8ab7dso114599a12.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1764186325; x=1764791125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb4ctooSlhuHklNq5K5hr3KOMwOrD4ELSQ0NDzCLvDw=;
        b=sMJYhzemndbDLf//iMupO4u+zYk0cex7fmQw8wGYz29HDx+01EcWnCjgFIQGgu8lUL
         BdxGY+EfRrKFQz+rqdraA7btthxzlPSEciFCBLwcdFJZZfvBGuNBYEGPvNDOHaQE2Eq6
         HT6pytd9tLcauM9iHwPPiMmWx4UktQY3avjEEttElIpy1GRkL/kvjuFZaeRY2oCI9J0t
         CLxIRaFMlkrUCN67A2OIU4nCMA/JUOrX5qN4m0NfYIncespv6ufQDB2XqjaJ9sjVE3F3
         x7a608OnqaZytXgAWXTxQUwSPlaf5Vhu+9oQSSpo9Lg0alb0vviRlGIenHR+zAFJBTZO
         mYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186325; x=1764791125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xb4ctooSlhuHklNq5K5hr3KOMwOrD4ELSQ0NDzCLvDw=;
        b=heJv8r4I1Nf1YB4hX9xzTKVUnHBk1AB1aGSDBH8FHCJ5Mtj8RRxK8EzmC7RLNlg4PF
         lxzpb3KuXCT62gFOqA6GhVvNhsWKUpmrWwFsDcKvfqHFVf/or8nNnQJGQ6FIV2tVok/X
         I/hpa7nL+T/g2wtTHxdwy4jBfaLS/d6jtFATtZ9wSuc/YBkmtqCsde5mjHskuz4iCWpb
         8duAP/hOim3YgFpiqpuMMr+EvN8rIs10JEutaO1//LAk7fEtDPyhu+71vtKyQm5DSb7K
         +BUBtzBEaUndK48YOdr8zc0jF6V67KiOzwYa94ZAXJRa6gTHaw0a5VbwSAXhGbk5XO+1
         uSEQ==
X-Gm-Message-State: AOJu0Yx+yZxN5RY6H3vy10C2eUfzuOiz4vGvSyzY/K/wh6h54scOzGeA
	08DK25BgX+HbanxsNOQuKbk7Pof/tNiPWC5h8Gbhf05YJ9JXL6UuXHsqj4bdnWJ8mw==
X-Gm-Gg: ASbGnctrL6DkAhj4FRaGa7VviIJLeglYs1vkTvbK/NiKiRyDNViJwov7T0PVUI5b/16
	jcpNwuZSHvMPs4VSaBct/CwMrMdJ5K0sDtE+YqIdqD2+RSt2DbZonvuQziGc1woJIXDvJbnHUP8
	r/swh/0EYcsH/wwXBwgXtBag/TLgfjZMp8dhVdWmuAjE8q/fyEa93wkXX/LD8lt/NIcyplK/9lZ
	P70ZE6Rgk26cj+IpwlJvTWWxI6vgz7D4LEQY7N7Gikm2Vexvct893UP9+6S8JRbot4KijL2qCGz
	y4jP0BqNxxHcLdiDpe6+gDKwzR+a3t9xGgSBnT3gHoaFwiMhQxL8oVbi1h/R5APH3/2Axun21gH
	yuZEyVC2nwVL66aXHDBexSxwjPEnxiI/402bEeT3SoPo0IgrrDxxTCod/KYJmp6BtBoA3A6Czfn
	C59T3pITElQqt6UfIFEqEcXbOF7XF1vsST6L2KIXGo
X-Google-Smtp-Source: AGHT+IFXQqaYxSU+Pn2T0MM1TKAv/3tD+zkD+FuktY4c68vJlb/ANANvXuc0oDx2oHqa4ajL3Eq3gQ==
X-Received: by 2002:a05:7300:106:b0:2a4:630b:c789 with SMTP id 5a478bee46e88-2a7192da0e8mr9168597eec.37.1764186324879;
        Wed, 26 Nov 2025 11:45:24 -0800 (PST)
Received: from p1.tailc0aff1.ts.net (209-147-139-51.nat.asu.edu. [209.147.139.51])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a93c5562b2sm24252446eec.3.2025.11.26.11.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 11:45:24 -0800 (PST)
From: Xiang Mei <xmei5@asu.edu>
To: security@kernel.org
Cc: netdev@vger.kernel.org,
	toke@toke.dk,
	xiyou.wangcong@gmail.com,
	cake@lists.bufferbloat.net,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v7 2/2] selftests/tc-testing: Test CAKE scheduler when enqueue drops packets
Date: Wed, 26 Nov 2025 12:45:13 -0700
Message-ID: <20251126194513.3984722-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251126194513.3984722-1-xmei5@asu.edu>
References: <20251126194513.3984722-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests that trigger packet drops in cake_enqueue(): "CAKE with QFQ
Parent - CAKE enqueue with packets dropping". It forces CAKE_enqueue to
return NET_XMIT_CN after dropping the packets when it has a QFQ parent.

Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: place the test in qdiscs.json
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 998e5a2f4579..e99ae8f81cf6 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -961,5 +961,33 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY root"
         ]
+    },
+    {
+        "id": "4366",
+        "name": "CAKE with QFQ Parent - CAKE enqueue with packets dropping",
+        "category": [
+            "qdisc",
+            "cake",
+            "netem"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup":[
+            "$TC qdisc add dev $DUMMY handle 1: root qfq",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 qfq maxpkt 1024",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 2: cake memlimit 9",
+            "$TC filter add dev $DUMMY protocol ip parent 1: prio 1 u32 match ip protocol 1 0xff flowid 1:1",
+            "ping -I$DUMMY -f -c1 -s64 -W1 10.10.10.1 || true",
+            "$TC qdisc replace dev $DUMMY parent 1:1 handle 3: netem delay 0ms"
+        ],
+        "cmdUnderTest": "ping -I$DUMMY -f -c1 -s64 -W1 10.10.10.1 || true",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
+        "matchPattern": "qdisc qfq 1:",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
     }
 ]
-- 
2.43.0


