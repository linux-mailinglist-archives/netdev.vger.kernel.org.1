Return-Path: <netdev+bounces-206461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B20B03323
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 23:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8D63A66B6
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 21:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE3D1F582C;
	Sun, 13 Jul 2025 21:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBulYmld"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8811F4615
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 21:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752443290; cv=none; b=gmo/OdpjRr2krG18dKL40T9wh57qRp/dEQKNpwtFzNrM/+o+9w0Q4/mExZm9+11DjkXPNk6f29n44bRr2uQ/3YB+3M0MrncWp6LG1mluDeAXCJpiW+XGe5V476e5eA/y+a7G8jxn7/uIL07fiHWmw933H/yVJmtuCOM21Xk40z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752443290; c=relaxed/simple;
	bh=0xF/qoMYScGyzsUrxqXDhqBlTWWhc5uFUH02xwEcbyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aoEXb2z1Ah2CAAOV9XUWEEq8rYNRhYqmsq1mkIw/WyJOR2dW0OZto83/mcRdrguJrdkxoAoHR1iLbc5E3OlphhtAX8J3DFZ2zDupvmzG6sCPWkFOd/nGKi8vGX00ffrEveDxjczliu6+X54p6/B5QpsUNkax59aWQHMS8DteOPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBulYmld; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23dc5bcf49eso44955065ad.2
        for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 14:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752443288; x=1753048088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dA8rnfeRTQ3UoeWxoB8E6weN1m+0woqy2zqDPqU2zrg=;
        b=VBulYmld+BTCMPe8ukv2J2NuIJgtX0g8crva93Yrp9ydy+z6/bSRFWWq7PoZkNNsCk
         nyxVK0YCQQ4cRQXMnym1xi8ojr2P7qNV4EYtsl8OA3o/JhPQgVzSLfrD29Qpz+KKknQ/
         ZQ1klgjEPP2nUzo9xcMGjVUHJsWMO6e7xK5IAau2Dk+A2g93GzHPaC2r6DIVXP7lBzcm
         exVGHtIC9HB55jsPvMHhXun+MvHrN2lOrGrKG+1kggPp6jcWX7jx3ThO1pAFrxQZOya2
         rDSXrteSoNIn5iNws39aWpxWEeon7HpfVpZgXmYHsKREBfs6GNa4YQRxvlZjCTlDXnPJ
         Nxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752443288; x=1753048088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dA8rnfeRTQ3UoeWxoB8E6weN1m+0woqy2zqDPqU2zrg=;
        b=SeOkFG5qZ4Z92JRxkoeQJd81L+2AzAGoAA6ZywHz91oVJ1l0qjB7GdkDFQVDydqzKF
         sCVyj48cihKBFBh42C2UnjIlOwCTdCxkz2bhaA4Rp6E7eeFMbess53I6402Xog9cyiLy
         aguJOPwqCjAtk88R4wIV3d+e4blvxz7WWUtbdOnBJSTQ88GAZb9s2iZWBKj+MXgbKxnp
         yvyevtbN2nMesh77qTrPvQomyMe4QjtE7pvD3vWcVghj1TXNKaUgaSIpGsteeffHcD3O
         Pa4RiyuoW7QH8WIhX49kwfAs7gxS3TFwuMmiktK0KM1Eqk1iTO/rRtRSL/G21NbWxQu0
         t90A==
X-Gm-Message-State: AOJu0Yx8upbeQVXohB0rCBQv9Cn0KOxBjSWKu3gw8IGL61bgxOxj5voE
	CNfCYZ4c98i7+2lLWhO5og7bwx5Uxbci0EJbVP3sAoIY93o4FF+2vHw1yD7+tA==
X-Gm-Gg: ASbGncvHvtNWUEOSWCr6OZHEfoA3arWia674U5jQraeEzwu+aMIENLEVa/xpr8Yl7fV
	hFPZP5PyBaBhUyu3q618eXxmMNmhGWUvuiigbAI1MgwARdFj1BIi86c6YxOWIVQKZhJtHP7SUzO
	egxOtxlkkm+4PJOo5SJOtw1kIfslpruP7lwaph5wRIk4Z3+F6n2h594AwxGgfkbMqerRnq8CTLb
	azeV1Q23EQTogWQcoxFz+hnVSNeLNcOKfLtqtU9s9+t5BkDBQOHIKTA+bXRTjEz6jT08mgtMhaA
	QN6nGushpRFL6EgTeh1cA4wKgh9SxWwiyheoM2l9GyFwHG9ezeBVSGaD12u9vOkMV/hYYeERdGj
	XOgdoIeEWLLz6Zn4AjOYwh3yIUm0=
X-Google-Smtp-Source: AGHT+IHiTu437k+u48QiDtkDEh6Z6JU6R3IKvUKlepAhydhRqPJ4YxFokYwtewa9fM897NIEK2fZJw==
X-Received: by 2002:a17:902:e54d:b0:236:748f:541f with SMTP id d9443c01a7336-23dede81a0dmr155913625ad.33.1752443287942;
        Sun, 13 Jul 2025 14:48:07 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:b9d2:1ae4:8a66:82b2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6f1fd0sm8628370a12.53.2025.07.13.14.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 14:48:07 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	will@willsroot.io,
	stephen@networkplumber.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch v3 net 2/4] selftests/tc-testing: Add a nested netem duplicate test
Date: Sun, 13 Jul 2025 14:47:46 -0700
Message-Id: <20250713214748.1377876-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250713214748.1377876-1-xiyou.wangcong@gmail.com>
References: <20250713214748.1377876-1-xiyou.wangcong@gmail.com>
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


