Return-Path: <netdev+bounces-191358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 903B0ABB230
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 00:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D721753C9
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 22:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9370F20B808;
	Sun, 18 May 2025 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0zWxDpb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A59207A22
	for <netdev@vger.kernel.org>; Sun, 18 May 2025 22:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747606872; cv=none; b=C7nY7C7aTnI120yo9ZJQjVocUQG0dVUAJCaipMKas+0gWyTebPahBdMcsUE6+KLz0P/dWPiwsk1xhuP7liMiafDk6mhV7tr1XXi+zBDH5J4d7Ac+G041whTTL8Az7aBRWoRx/W1oCHN+fXVMpdTpPgUaw/yUbIdpnZELUbCXSqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747606872; c=relaxed/simple;
	bh=Ow/LSIPbhMdmPYYQ/exw1paikGOwZU84kQVdLu7MVH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MAOuxtrJcZwlZTcXamTE2x1fOABsspth/rWcLKGlC584FsFxkLw02HCtIWcyS5noDUTOc+hnEQrFQTRC+HL/yJ9vYO3P153ccLt/mNMC/0TXwFOUBXTf9touh3AOCN0BLtmoCleFy+PQ92EMQweXKVjrhEwlknU2XAnDEkfpvv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0zWxDpb; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b26ef4791a5so2317388a12.1
        for <netdev@vger.kernel.org>; Sun, 18 May 2025 15:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747606870; x=1748211670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVIgHmj7tlgvYTJtNj+uxrq46Mi1MDxof/OrVDNabAc=;
        b=I0zWxDpb79pdkVPMtSV87wnU7Oy5pG1l43Gmt0vAMFfxsLOEAiy8PB7yX72MKqFr+I
         tlsFLm8uwJ9Ei39zzeMWQTCorL6AViW4bqaEIifN8CnorKk8/G3rVukIwRf26KZrrDQE
         VjXGOhSlAeAoCTx+q6thYDHsfYD37+2h0012CsBongboTOVKcsHHseJiEth1gVZb+Oso
         ReqyHkZKPMdcNdJdxrGpdZ7WOXnV0nMHTNAcTgvcyPOu9aVNXF56oAlZWZQH+mMxcFqk
         GZVRb4LUIiadoL3gh4SIUwrN4XjkqypKTgQhmKEyAY6TfViWbHQtJjfVtwAiXDjspYeb
         sruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747606870; x=1748211670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVIgHmj7tlgvYTJtNj+uxrq46Mi1MDxof/OrVDNabAc=;
        b=WmIWmCEYO9qSvUnZpJSti5+6VqFx3PH31b5RSsZkZGWYITrrPR9+IBUHCtVauTHEt3
         6Aq+SqwSe0g6VPFP1aqzChx694133RaZ+sE+uIKsv/Y9WFro6XXhoVWB3q7T8ZzZ2luR
         a2aNMnlp/dZ5bYjjeVEgOIlB0a9J1IhJutfp8Y4He/FpMbozjyt/FKtFEln248XR0cjL
         aKM1f88yf7nI8norjUWtlBY32WN/ZExx7OKYV9EGLIE+dSOq624D0ZFszr7sW8ytc/we
         mjaIo0SwNxkJnlzF6rP5sgGlTI+fWdbvRnB8ZgxCQ2kgmIv+wUjCv9bYzEmCSUkStb4k
         VstQ==
X-Gm-Message-State: AOJu0YzziPBZtPK2j5+v39c8w4leTqzJDGA190Qjj4f8n2miSo4bdnKO
	Ty56dire6Aqa80auuJVho8RreEYtmqzUx8q26rDGVmP6qcM97s7JC92nKioskw==
X-Gm-Gg: ASbGncu2K0oAAcrXgyGghMA1Je1fGNZTK6IDC4zfWr93qFqirRCVn+6mVj+RH3ShTwR
	OzDGnUl/AQf6G73QxxIRAH2Z1V9gyqhzBUvNZlDyfQdwxLYNRx9dhfFnnmELmfBuKQOx5WXeWjY
	Zjv5bQtxqDpsnLwp3/aihTOF8FfS6EBDWYx/BNvP1eDOUbXB2iuYLlcMuZREoMwbXnOqCrLoVfn
	BBnQGJFVIqJhSxRpZxqLcwKlVjRAiZdKRDdJiB3gt9ogfpQ+ETfr7DFn/buoZfCAVGBZOY3vZMh
	vQu6Hfu3ONBfD8y1/q6PqZSXzVh8I4rOpDijChLwEilSW0+5v0n0YjoG
X-Google-Smtp-Source: AGHT+IGhfmCpySLEHvK5KgF/38sFeWoGu3nEttNhEeoRCftCeHBwfR0lzYkZGIdtqQ/Gt/xdGzxxSw==
X-Received: by 2002:a17:902:dad0:b0:231:bfbc:3081 with SMTP id d9443c01a7336-231d45a9e30mr157976715ad.44.1747606869914;
        Sun, 18 May 2025 15:21:09 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:b16f:3701:bd1c:9bc3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed4ecfsm47360005ad.234.2025.05.18.15.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 15:21:09 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Mingi Cho <mincho@theori.io>
Subject: [Patch net 2/2] selftests/tc-testing: Add an HFSC qlen accounting test
Date: Sun, 18 May 2025 15:20:38 -0700
Message-Id: <20250518222038.58538-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250518222038.58538-1-xiyou.wangcong@gmail.com>
References: <20250518222038.58538-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test reproduces a scenario where HFSC queue length and backlog accounting
can become inconsistent when a peek operation triggers a dequeue and possible
drop before the parent qdisc updates its counters. The test sets up a DRR root
qdisc with an HFSC class, netem, and blackhole children, and uses Scapy to
inject a packet. It helps to verify that HFSC correctly tracks qlen and backlog
even when packets are dropped during peek-induced dequeue.

Cc: Mingi Cho <mincho@theori.io>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index a951c0d33cd2..ddc97ecd8b39 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -573,5 +573,32 @@
         "teardown": [
             "$TC qdisc del dev $DEV1 handle 1: root"
         ]
+    },
+    {
+        "id": "831d",
+        "name": "Test HFSC qlen accounting with DRR/NETEM/BLACKHOLE chain",
+        "category": ["qdisc", "hfsc", "drr", "netem", "blackhole"],
+        "plugins": { "requires": ["nsPlugin", "scapyPlugin"] },
+        "setup": [
+            "$IP link set dev $DEV1 up || true",
+            "$TC qdisc add dev $DEV1 root handle 1: drr",
+            "$TC filter add dev $DEV1 parent 1: basic classid 1:1",
+            "$TC class add dev $DEV1 parent 1: classid 1:1 drr",
+            "$TC qdisc add dev $DEV1 parent 1:1 handle 2: hfsc def 1",
+            "$TC class add dev $DEV1 parent 2: classid 2:1 hfsc rt m1 8 d 1 m2 0",
+            "$TC qdisc add dev $DEV1 parent 2:1 handle 3: netem",
+            "$TC qdisc add dev $DEV1 parent 3:1 handle 4: blackhole"
+        ],
+        "scapy": {
+            "iface": "$DEV0",
+            "count": 5,
+            "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+        },
+        "cmdUnderTest": "$TC -s qdisc show dev $DEV1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DEV1",
+        "matchPattern": "qdisc hfsc",
+        "matchCount": "1",
+        "teardown": ["$TC qdisc del dev $DEV1 root handle 1: drr"]
     }
 ]
-- 
2.34.1


