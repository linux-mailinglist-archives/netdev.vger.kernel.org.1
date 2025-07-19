Return-Path: <netdev+bounces-208362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E001B0B22E
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 00:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77ADA561934
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 22:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5B323AB8F;
	Sat, 19 Jul 2025 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSZzywq1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A8B238C25
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 22:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752962656; cv=none; b=PrPW2wX+B2Hpc7zE4q7dbYO59+BDMpm8tR1/dd/Q00n17oWZFXj1IXw2iDiC75eWWAce5X3ig/MZi2fkG7FivEqbqYSC2bIV0YMur7gfi1TXMxjNvjdK0oQPD/uusk8nSRyn5vdFI/Ii1m/5mIvGxsn0OPA4rFXw5ipcCyYdRAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752962656; c=relaxed/simple;
	bh=0xF/qoMYScGyzsUrxqXDhqBlTWWhc5uFUH02xwEcbyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K9lbtuJzNuBjKVNWEwrSz46i/eNBLOncsV4K+eDS9ljQBHZQH91/Ab3Os9tClUHZ4M0ForFnKYDFtNP4qmj1+OUIueURgA5fvsVCZPcMxOyL+TrxrgIXbQQV4tMBz7H5u5M0oNg4yhc9+lrreX6RF3OwwOdqtqsJpy/nCKFNuH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSZzywq1; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so2995770b3a.0
        for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 15:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752962654; x=1753567454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dA8rnfeRTQ3UoeWxoB8E6weN1m+0woqy2zqDPqU2zrg=;
        b=fSZzywq10+kvUyoVdGTFT3ChQz8mNHz6VInm145G2euFDkWgGcerrc05nmReLqwstp
         Y/ZID3IBlj3fY4KJKxs4yEhX8XrgFgOUMRo6pJe+t54a8wrEowTgSOd3Tv1L7EZibtST
         I2g7qebvTd9Lb5RRnQP3FYILg6CtTQC4o9ndF0BG9bcknNgk2N5buI7qOUULS+zAx/2t
         kDGuBdBGIi6oT9LWQbGsDj2X6YXGQEOBeSEJ/XN9Uz16J9IDbV3yJpz1UlXOflh+KrRL
         6f3Oy0zg2Ts9YQJC075gTWKDsqzAvkil2QsQP6YvBberV2bZ6LpBUFH+VB/6tsvSRaBo
         vETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752962654; x=1753567454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dA8rnfeRTQ3UoeWxoB8E6weN1m+0woqy2zqDPqU2zrg=;
        b=KKtV2yoBlbT9Gzv17yeMimwsv1T1PZWCLYHBfGsponihRgeaKpkkQUd6syCV0iaiw9
         A5s4d7052KVTMv2ZVIFruP85eLFNXQRjKDIUAgWEAagoTEze3KHlsAZoabAZ1ZvP3hDP
         5FMH2e/AxNKeFCXB5W+d03UFzMZLHiRsZ6zEzNgbuOPtWk6kLnyFDxuf1TzTH+kYtqiD
         dqOmomQiKrNHLpaKgzH1xo8fVSXSmqsUTamZoRZ5WzHDnHfET7mzmYa1GiFHJPHINvpX
         avUM6hdky0JGpLT2ZHUY5sk7BBacHSrDaqTfKezq9FSqPCBA4jx+yO2q1IxWsBjhJbEA
         uXMQ==
X-Gm-Message-State: AOJu0Yyg8fi4s88c5ycFInbV542WoP5LQqEokAWviCzHVnzEclJP9ts5
	K2nvOoAYTz/SQMmYZcP/FNGe3hfJOxjPXWI04TObe9cY/2pbQE5fRfFU/DePtg==
X-Gm-Gg: ASbGncviN4GTlczmWMspovgUKNbDExgJyiwamiaTg9w0dsMKd+lJlPwU45S2CBQj/8C
	UZQr3r2k0kjbr/Ntjh00CZZfY9C2/DliRFvfxMGlzGh/yHUGG+JlHdQunw04dERZsRvSki+7aIp
	aZM7DCoTaoVLYEFZyqWJDTF/1QLsaZrtLPOY6CSdEz2ZmDAJ2CRTEXHwPLVan0/cXquGJLcHyUA
	PWB4VbGRDG1i2AlactS9t0Xj5TOm/HxtkcBRaZpK0liJ9tbACBqHqE7yTOLnbhDkUQeNall/jBP
	9BrcM4fKBMp5yrpkY5l00b5Fpo8h6U0MXICSf4O7NcHBGIOguQtmcMR9AJ1nP5PLGC8Tg/f0ahV
	klf3vmgFfGgjy4z6iZ81/7dcvxe8=
X-Google-Smtp-Source: AGHT+IFUebMNCsDbxMX4yFaMS9Hp6Nd1udveghByri3vo8P8WpksFCQSeD9bEcqlifZLNtheiccYvA==
X-Received: by 2002:a05:6a21:6494:b0:237:b321:1e0 with SMTP id adf61e73a8af0-237d661c82amr23125589637.17.1752962653812;
        Sat, 19 Jul 2025 15:04:13 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:b3bf:9327:8494:eee4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe6a09bsm3084040a12.3.2025.07.19.15.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:04:12 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	will@willsroot.io,
	stephen@networkplumber.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch v4 net 3/6] selftests/tc-testing: Add a nested netem duplicate test
Date: Sat, 19 Jul 2025 15:03:38 -0700
Message-Id: <20250719220341.1615951-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250719220341.1615951-1-xiyou.wangcong@gmail.com>
References: <20250719220341.1615951-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Integrate the reproducer from William into tc-testing and use scapy
to generate packets for testing:

 # ./tdc.py -e 1676
  -- ns/SubPlugin.__init__
  -- scapy/SubPlugin.__init__
 Test 1676: NETEM nested duplicate 100%
 [ 1154.071135] v0p0id1676: entered promiscuous mode
 [ 1154.101066] virtio_net virtio0 enp1s0: entered promiscuous mode
 [ 1154.146301] virtio_net virtio0 enp1s0: left promiscuous mode
 .
 Sent 1 packets.
 [ 1154.173695] v0p0id1676: left promiscuous mode
 [ 1154.216159] v0p0id1676: entered promiscuous mode
 .
 Sent 1 packets.
 [ 1154.238398] v0p0id1676: left promiscuous mode
 [ 1154.260909] v0p0id1676: entered promiscuous mode
 .
 Sent 1 packets.
 [ 1154.282708] v0p0id1676: left promiscuous mode
 [ 1154.309399] v0p0id1676: entered promiscuous mode
 .
 Sent 1 packets.
 [ 1154.337949] v0p0id1676: left promiscuous mode
 [ 1154.360924] v0p0id1676: entered promiscuous mode
 .
 Sent 1 packets.
 [ 1154.383522] v0p0id1676: left promiscuous mode

 All test results:

 1..1
 ok 1 1676 - NETEM nested duplicate 100%

Reported-by: William Liu <will@willsroot.io>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/qdiscs/netem.json     | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
index 3c4444961488..03c4ceb22990 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
@@ -336,5 +336,30 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+        "id": "1676",
+        "name": "NETEM nested duplicate 100%",
+        "category": ["qdisc", "netem"],
+        "setup": [
+            "$TC qdisc add dev $DEV1 root handle 1: netem limit 1000 duplicate 100%",
+            "$TC qdisc add dev $DEV1 parent 1: handle 2: netem limit 1000 duplicate 100%"
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 root"
+        ],
+        "plugins": {
+            "requires": ["nsPlugin", "scapyPlugin"]
+        },
+        "scapy": {
+            "iface": "$DEV0",
+            "count": 5,
+            "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/TCP(sport=12345, dport=80)"
+        },
+        "cmdUnderTest": "$TC -s qdisc show dev $DEV1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DEV1",
+        "matchPattern": "Sent [0-9]+ bytes [0-9]+ pkt",
+        "matchCount": "2"
     }
 ]
-- 
2.34.1


