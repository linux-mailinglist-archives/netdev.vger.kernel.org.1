Return-Path: <netdev+bounces-250811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2B5D392FC
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 07:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B40BB30049D7
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 06:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0CA25CC79;
	Sun, 18 Jan 2026 06:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpZ+K277"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6B1213254
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 06:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768716968; cv=none; b=Fj93WD/A1ywKAFYFIIqIh8JbTVuIZZSKE79cOF07VYvpMnOBhZmXxS3dtDZGtbB8kcwyUh1gKA2kAC4uPEtFEO1nbHlt/NpM2YM3KD8DCZ8QB/dmg3PIrlwQym3T0eW5Vlve+9rKg+lyPyy1PPVOn8dEHR80qKknML1kJtsmkIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768716968; c=relaxed/simple;
	bh=0xF/qoMYScGyzsUrxqXDhqBlTWWhc5uFUH02xwEcbyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=COxpT+Wn3l8T7W8V4pofi/8ajqCmLVVS/t3WnpnpiCffPhPa5TD5eN2INY/kAQiEWHoT3q6rOOtJPsasBCh4bxvJyCa0A0TXjesx6MeKXLRzFw8zgqn22aFRQfNYkDY48kuiWB8J+CK2E7N2Fa0SSlJ6apxSSg4Zab8/1dP8vm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpZ+K277; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ae255ac8bdso6317460eec.0
        for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 22:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768716966; x=1769321766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dA8rnfeRTQ3UoeWxoB8E6weN1m+0woqy2zqDPqU2zrg=;
        b=MpZ+K277ilGC4+70pWF8eqAQsW4ju5YewJKtWPdBb3+IS1UZ9o3Vcw3XZ+BK4o76wf
         WCnnjeLcvv94on1sw2oBzkrEJmkTVTcWhqnNnxkMAS5zOLifWaQDxRaN4PTvXtCsdq2W
         Ej8AXUG52logFMUefuyoIH5Ru9GInEslbCdVlvZ9dJhllmSVD1IbTjsHC4qnJSK/uX8k
         WQ0OL23lJGmWOcTexIKy9j58u3ev+joi03EHAT3Lc4VIV7XwPMtq2W2oMjsLg3tZaMbR
         Mzb7Fh3sZ6RtoHn8Q2oDIEuR6Hp8AuWVUh83HkoRpuqBirzgCFoXm5lH7a4dUh9OSpyT
         ujhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768716966; x=1769321766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dA8rnfeRTQ3UoeWxoB8E6weN1m+0woqy2zqDPqU2zrg=;
        b=dn3g88P5Df/MKzliPRBJg6eB0Nslp1y7E467IdpFEeo4gwZW/5IId6IjRwnieB3Ud2
         uNUhSaW/VwIHDlEYVBPxm4K4h1TxgaKnjee8imXtL34NoDJcfL5nLrK0xUQ9x6gkGG5y
         fsxTIwKrv+RTf9P5e058XqFxjlFJX0Gl3AgY4yrhzKcbuSCLYyGkvQW6Ina7EVU0+wbC
         jFOcRNeghu8IxWNIhSBEeSDL8NzVfS5Nai7RadQapyeaIVl4ZvQpHyuuOPqV1c4HLeSL
         U+wXuJ3KI83y/3R/R6h9amFGFNIGnsdAgntURCqIxstpoliztx/oRYu9f79ijxdEvxRX
         u4WQ==
X-Gm-Message-State: AOJu0Yyuwq3likRaO8b8YqaCN9aiVW+tIBhStNMQPUAaLXNkMEafcgc1
	6J2Z51PEX8554Q+yRZ28r/h5F1i9WTN/JTqn+9jjW42AHyBx/JS7/ajlDl+IDw==
X-Gm-Gg: AY/fxX6bp8oCaJWYPSsW7xXzh7WmX7SeQEdFjSa4WAgSXiYn5KG9PtJ6Cb34eXvgjJk
	2ovk05YyeVvbReSba9zzez3H1uX+9R/IcDnQ0cCGyDGFu0P0b0+LgZGEV+dAnnLCYuVYj9/a10Q
	+efmYhStziqAFJOl0rjJUntAcv6o29XViW623n3ugpweMaOIDyKWhXTYbDTvA8tErZ4vHrA0yWR
	KCpWb/fMOcagphiaDKG7xBxaHY6kX2zhbbS2lN4LjMaXHUiLqlzMJWIMnF6cGrcU5PmHSE6j/b0
	k/MfyG06gVbMx2miZrUfo3eKSdtkCEsdvMDvv5grt56f5vn5OgKcIQEPzoXLp0VQmuOqGJh45QJ
	1z0k8hOvssJKiSeEduNhM9/MEXogoNeBbcHpGa00QUQ+/yYxcPoMHaNWeKcQ0rVJ38RQxryIdEI
	2Zv02baaRXxTK22Hy8
X-Received: by 2002:a05:7300:dc0f:b0:2a4:3593:646b with SMTP id 5a478bee46e88-2b6b40dcae8mr5762033eec.27.1768716965626;
        Sat, 17 Jan 2026 22:16:05 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:8fdd:4695:1309:5b93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c65sm8163816eec.8.2026.01.17.22.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 22:16:04 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
	William Liu <will@willsroot.io>
Subject: [Patch net v8 5/9] selftests/tc-testing: Add a nested netem duplicate test
Date: Sat, 17 Jan 2026 22:15:11 -0800
Message-Id: <20260118061515.930322-6-xiyou.wangcong@gmail.com>
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


