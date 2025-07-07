Return-Path: <netdev+bounces-204686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AB3AFBBE8
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA0616B8BD
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 19:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FE1267AF1;
	Mon,  7 Jul 2025 19:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qvo9gA0n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713A82673BA
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751917840; cv=none; b=BpVXvdWZQ16Qi6/Jcs2F/3lgDWFgBF+HdYe6R3xDMWZeS3ojwk6GjAwBwqvHRCCqc3XIN1JFHEuF95iul4aw4kd/NCTkDkDgGhyEg+q3ESOAtv/2jXR/cZbqOEq58rEHlibtECl35ezXbO8UIdehqEJADfzByM6u3S+99uydiW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751917840; c=relaxed/simple;
	bh=mkZXK+oLdik73FT6EnqFP6nuy0VpAaEGqJxTSei9Au0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h8rz6TNZMZeiI82DQrkgpj+yQfWCwRYUDfKtZmv8C0CIeq4LHPf+p63oPyzwex8/uH9rw88Q5BGOqgHb3yBJE0CFeZev+oCZi4pScHiV4UORtAoE1bsOS6GJ/2rYF8trAqtjcLa1qtxnEH8UgIXBkbeBkaHgJnCbe6H2ReIlEBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qvo9gA0n; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7426c44e014so2764068b3a.3
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 12:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751917836; x=1752522636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APBD3b7j0vs8jmKTVIjwDu666otCHObQFFsnQzW1W1E=;
        b=Qvo9gA0nzMmVctAEMweurGdCGloiVpNEqLGN1uOcwy+xBp13YkgVqQYU5K889xjdOA
         by4CyKxsiL4uglC4XuiOk+MmK8xepu9QqZnoabNjk34RpVeiXOxJE+idGTfeMxmxGQ4L
         txiDfvlNG3UdCEhbwWM9ThKdU5nNjcw/JJEa8xriBgOtDvPB4jAhBEdfy9pdEzuJXvit
         2gLJrdF1KUyJkYlIoNQN/cqktI2YTh06idNqGEFAE43gF9yTBuTDt+s2JgA3i201T0B4
         RMBGE4XdMy5wiOdL6xDNQd5CJiuyT7K1kZPKCXLkUuiSQvN2m0vYqykG46RBH3kn9YvL
         N+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751917836; x=1752522636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APBD3b7j0vs8jmKTVIjwDu666otCHObQFFsnQzW1W1E=;
        b=ZDNKCq8iUS4B1nOLaCrxn1WSRhjzSWqwKOh4SmlCYLltb1CuaOPL/OWj9ZZGyQIVrP
         AVIuQ1O6JLfvJcTTEN2ADo52OoaGa8+pltT5JtIgefX1SVhYxnVCqhoZsT+ubMLn7k9E
         gnvTd1VzcoNQ6/jkTfVAoHzxsUNcprkizbJAWKUBTFqsd2LiVPPjd89jxHXO8x8plYsC
         MKcBOP/D/OiNoSz/yBj8V41vieTJbspxtmvJVQ38jps9aP1d6715P9uGp8rlFQSUXWiP
         BDxAU05ePr/114A4cKe5j2wIhlHetcUshQUB3UmhRDwq5L8WJxJNxEZee3AaL1My7z2H
         yvBw==
X-Gm-Message-State: AOJu0Yxc0ddh6XbpWS4jjl7JfRo1rcMscUOaURwRjCk2z/VZ/wkkJ5uK
	rWJYXG5CcMIiXPEdEJQwr07/dRL0MCSoSIGiJi3hq5DlaY/Q1+ZvvNoZyhWwaQ==
X-Gm-Gg: ASbGncvppuJ/4Uj0ee6MSB9cQQ/ESnEXuLfC0+o9PZwK0U0WouWfXcRYdoOtRJJcoPX
	B7+BQG9z07JqVkPA4Ww1z4AJd2K9SoSDFPqtpNOQ8AvAZgVtHxw80mxKeNwUtpp7RCfV6VWE1wG
	KawdtHHxp7ZgkdKdLeywZWTXgDRqYEUqLDECOQ/NdkGAVgmvgyoqxbT3bCy9YacEhuLKF8zvbcf
	w3rECCEwOGT0cc9j0DI+bxxVg7eSUzWdbtg3FWDRS9fue6o2didBMXPMivMgAQAw/4TDZYrJJK/
	wIk78B2JT/fFJtTnpbXNzZNU1HBVzcSZNDQeP+dHToDwxwZnK2y+kiojcPnSur5bmgvNglh/
X-Google-Smtp-Source: AGHT+IGsEMC7j8m2D+fu/X39YsKmMLki9avSVqYk3C+cTH8xrFxO9v6tIR4fRIFcPAYWpI+ZR6BnFw==
X-Received: by 2002:a05:6a00:2289:b0:73d:fefb:325 with SMTP id d2e1a72fcca58-74d242e84dfmr705028b3a.5.1751917836066;
        Mon, 07 Jul 2025 12:50:36 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42a2c10sm9648931b3a.136.2025.07.07.12.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 12:50:35 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	will@willsroot.io,
	stephen@networkplumber.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch v2 net 2/2] selftests/tc-testing: Add a nested netem duplicate test
Date: Mon,  7 Jul 2025 12:50:15 -0700
Message-Id: <20250707195015.823492-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707195015.823492-1-xiyou.wangcong@gmail.com>
References: <20250707195015.823492-1-xiyou.wangcong@gmail.com>
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
index 3c4444961488..1211497b2acc 100644
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
+            "$TC qdisc add dev $DEV1 root handle 1: netem limit 1 duplicate 100%",
+            "$TC qdisc add dev $DEV1 parent 1: handle 2: netem gap 1 limit 1 duplicate 100% delay 1us reorder 100%"
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


