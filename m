Return-Path: <netdev+bounces-249559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBC3D1AF2E
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 20:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB6F03037381
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB6235970A;
	Tue, 13 Jan 2026 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdviyni6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FA63590CD
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331220; cv=none; b=AwO5dFHjAAdyB9DUHda8HU2Y2mANVC1tZPApIvMz5mSG/A/ByhaVICkMGO/IGcTfRYgc85cVGdLgZdPAXy0+EAxIOc4kVMTgk9HrNC18mBwZ+3opzvlmpSeKJS1gLqTVsvvsDyXBcqJwYcxQTTQwqrzMJy0f/dRFPRNT1i/axKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331220; c=relaxed/simple;
	bh=0xF/qoMYScGyzsUrxqXDhqBlTWWhc5uFUH02xwEcbyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U0KxldWfHM7FxMZaDmRNHHY3Q2HaIt/yQW8iH66vHQA10wQK/nooy5JDFaBgDGnduSMTOKNoJbhVA8cjpNgStjlUoQzmtF4jVKDxqFyHt4nWX1dIktoQkS2hSriIf77YB2806ue/kBbtJay3Zod4Pb13R6pIGhywFJ9vI3hHlbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdviyni6; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81ecbdfdcebso2280349b3a.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 11:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768331219; x=1768936019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dA8rnfeRTQ3UoeWxoB8E6weN1m+0woqy2zqDPqU2zrg=;
        b=bdviyni6v5GgbYlkOPkWrNnGspuyaPYeXLZQXsQQ9s6RaoroJ6h4MVYd7OZo5RZUmr
         a+m72tQJZIiT04lU69OheUylpYrfvnQLQgXXGs8fnx1EqxNftfbv0Iob688oVixWHuRo
         jwPWLGm7eBdjeoNwGa76nowYWkO4tbPbDykwGVCgQBI0tj0SCtNJsnAkvuty8YrOYqGj
         vonuaxniVbGWusEFb+wVJYzchR27tqrtIPidXiVzkvV/+laew6d0nrF8IP9Lfki2LUhb
         v7ZrLAQYjcNfgLReQBS2ELEqlxSuZtIrrcFIlYJtJb+KsErzt6eZ3a+3+JkaoCx+SMk6
         CygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768331219; x=1768936019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dA8rnfeRTQ3UoeWxoB8E6weN1m+0woqy2zqDPqU2zrg=;
        b=eu8V40jwiv89fN7DzuUSHui67gctGY6NZQpAMOf0Lkv4If3qm8pOj/nT2k3WUtY38u
         sUHF7Ke22gYX/Ij7FMT7nkahmsE/75AxOuCFATwEdq6vUMpYSfaLMWQ9WEhoros011sz
         ygWXbamHUhp1Jyg7jjZt3A6ZTCT4N3RH1xI8mvZu6UphslHmYrGDk9XHJIXJ9N9AYslX
         J/9x5TBbmhogsBYLvkLwTq+ijPgPcmtpsmP6J0K+fKAAcGKql+zkwQ7UuJl7/Ibeth64
         vIMmlVOzwHFqaRuGLtVI1jn/6vCldTGQAp1/GfxsBFDxPsQ2hCpfEXcsLocH2Zoy0jau
         PpLQ==
X-Gm-Message-State: AOJu0Yw3mFolCsjVRw4Xs1DY3u7zC6NETjoo78nGhFOzgPyNeoRZLa88
	myRXN50mpT6Z1dZOXm2RoEz6JYmtuq9fzSemtuRjYlJD6uqswKlsPvK1ux/kpA==
X-Gm-Gg: AY/fxX6o0/g9EHo3LtpLNIM2wtVpI0IuqshG4b+n2V5aHg0Nur8xnhdHnt1VojClBYh
	xL1DoBv7ngyimfTGEHuQBTapmfsLcu+3MdFanytATuEdYxKNysNXfTAQR3eZOx+CxXiyed3XyXW
	aEphzecVNEc1uYOrt6laIgwyjaqYevcw4EqaZd+34ADQL5zgAQbjFWbeon1K9L5qhWUlpNQbIOe
	7FzRSRpbEIg2LehxYr4ZecFoJkFyTDYA3IODH+lLLFgGPlUQdqr+XvkF5Q0IkHLmNMon+dT/2Y7
	hJ0nWvaw98HhM+xMrdQEIxjuf63Tw5U+ZpIReDVyvqZWbVyTdGPnlaVbXFJe57eJ46YfncPsVJ+
	FUL6iRAKNj3UAgZMh18CYWEu/RUxMWNXAsCheS4BDRq7OUF7KuVdp/oiM9M798906sdOJI3RX9S
	/e8yWm8g3KU5NTpv4v
X-Google-Smtp-Source: AGHT+IHh6Guwf6WCO63JgWKRsrzDqZH5Wc9NyT6wrgQOBbfHAzG3a9SH2Leg428IK7xq6FP0oEASxQ==
X-Received: by 2002:a05:6a00:7084:b0:81b:87f2:c25d with SMTP id d2e1a72fcca58-81b87f2c2d6mr18605507b3a.0.1768331218589;
        Tue, 13 Jan 2026 11:06:58 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:7269:2bf1:da7f:a929])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8058d144sm187780b3a.51.2026.01.13.11.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 11:06:57 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
	William Liu <will@willsroot.io>
Subject: [Patch net v7 5/9] selftests/tc-testing: Add a nested netem duplicate test
Date: Tue, 13 Jan 2026 11:06:30 -0800
Message-Id: <20260113190634.681734-6-xiyou.wangcong@gmail.com>
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


