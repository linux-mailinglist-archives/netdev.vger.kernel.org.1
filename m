Return-Path: <netdev+bounces-242035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC61AC8BBA5
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56D8A4EED07
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A52343D91;
	Wed, 26 Nov 2025 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeXYOiaf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BAA343D76
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186786; cv=none; b=HGWJYUinMXWNwlcNsmOYe+RLhy6dFScadLlNdd3Oft8H1WAVfxElQm5B9axniNof7o9V8/cigJ0s9TOtPaIT9lULWp0llfx+tHJWGN/LBhH0hLsORop6AY+n5xf1uaKNfDo+JXOnl0e3L5xHPGMMevDZFlrYJGcCJ7tBECmfDvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186786; c=relaxed/simple;
	bh=0xF/qoMYScGyzsUrxqXDhqBlTWWhc5uFUH02xwEcbyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KIhQtcSRMkvYVX42D0ZrQnUZ1mns8KRvEhkLQRmUpUVq3zDOHJ5aVuwUX80v6UOWKdp6NTc+SsiXwdqFt54o/SOMFVixGvYWdwYnS2chuWoBo+vLP+WT6MK5v+yTokb0MBR0eXWp6LJKmypGdZvKQpVckKikkwChEaEqAcIcTok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeXYOiaf; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so94465b3a.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764186783; x=1764791583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dA8rnfeRTQ3UoeWxoB8E6weN1m+0woqy2zqDPqU2zrg=;
        b=WeXYOiaf2eJpJXjcSelbmMPH5iHzuClSEUvdIHR4C6V1J0lq/pBROu9HvZgYGGwo9g
         MiN7PqLHHSgKLRzp74tdxrKGtSDCq64HFIh8T3WM+5wF621APdObv4RGzvS2NjBsuGDn
         pLQeoIGLZ1tFWgXZ+6tuYdLuz3NZTgiXB/TBgx04s9Yz/q8tJFdoR1SqAVshxFIZwmdT
         2FLhYPNSL88g+GrEz6ib39F/Yg2nQPNLp5IUbBQ1plmgtDXbzFenJRauBlOa1HsvKNB/
         SUayBgdjK08gDwfiXrDILHMBvvVQGkt4RNwtrM6VlpeWE8j8ew7Xxq4NKdOMeXdomhW5
         PXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186783; x=1764791583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dA8rnfeRTQ3UoeWxoB8E6weN1m+0woqy2zqDPqU2zrg=;
        b=aw15KcEgupOn7OdzNanETsIRuF56VWniz5bOIW9LwKSt4muPRrY9JR1j8xVWlYUkrK
         wjpZhXM09KpKl7mXJoYn9Z03Y180a7cCtuNCfybK7TwjEGv/eC9tc/uzb2bMwPgRT2iK
         /5kCrojyA+iWSfD2KW29BK4DWbKTtY6emkNm4sHQmtbHa+NTDUGYEV2C5QfztbAdXwY+
         VyAp2kdKD9GaJSUbnmfEMndHWca2sL6std1AT1a9MP/qvjdss6bEbNfzFlgLKUN1Vcqs
         w3pli4p1vbRz3KPTgTrVnvlZCvoAcYzpbFY7F473dK4PFgT78ZOGXWKKTFHe0VAkiNWp
         YCzQ==
X-Gm-Message-State: AOJu0Yx4E4/k/yhquygNXjGCMHpI5cG/+IPjwDXgIkXbjKNZvT4E1DKY
	Mqpe1t4yGDxqZz4JBlNMeD9jxFkGJ0FIrGYehe25yW9gASIUqmVl+wnOKiNYhg==
X-Gm-Gg: ASbGnctxsp4wOswYLD9f8eZNYONI2RvfpPaWN0Y9PSpa5WBSDQQX6OxHjP6f8ZOx7xS
	YLN6u5ZhPJyl7/QXak7X+2iPgsdcxnOsTsxG/sEVWF+vnXG9SJLcq1kxJZZ3QI++bIu6BU+TlQd
	ItlaxtxIKqCfSSXvM4e0Qp4UYqCn0Yt7Nm4nyzbYTMXWXuqGk4DfTlVTvFxGMqANJ1utVePk56P
	UdNTLdDHZQCttAyFYQu2fXOGI2Y3+q6z1o5FYJglhZyu7sn7YhUIusNmBRiRE4GvTs1KZF5Es2q
	2kLONySK3rCNtEkgkKHqCnAWfcBg+9f3TKimEqvxGKxUlDofrv8MTrcDvuZule5WoADBbfKJ4mM
	ZCzEk1ewWZgYs/s4uNh1hCqjAofX2k6aXYaRM4HhWPvLwywxkX80rX/N7/JkWyl1Tsw2Uv7oDj2
	F8zX7RlNuMFDioKuWbw6SSOw==
X-Google-Smtp-Source: AGHT+IHl1lZr4olfMlD2+1BY5DLy2qVaM1pPxXkdjLBCMW+W0gKmTCv/uyFaNkkSXKJ3dSh/knf92w==
X-Received: by 2002:a05:7022:f415:b0:11a:5065:8763 with SMTP id a92af1059eb24-11cb3ee2197mr5323910c88.5.1764186783375;
        Wed, 26 Nov 2025 11:53:03 -0800 (PST)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93db4a23sm101508235c88.2.2025.11.26.11.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 11:53:02 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	kuba@kernel.org,
	Cong Wang <xiyou.wangcong@gmail.com>,
	William Liu <will@willsroot.io>
Subject: [Patch net v5 6/9] selftests/tc-testing: Add a nested netem duplicate test
Date: Wed, 26 Nov 2025 11:52:41 -0800
Message-Id: <20251126195244.88124-7-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
References: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
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


