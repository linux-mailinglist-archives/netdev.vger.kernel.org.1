Return-Path: <netdev+bounces-203055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE89CAF06CD
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 01:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44C067A5B1F
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 23:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4742271456;
	Tue,  1 Jul 2025 23:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CynIYWw1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A13284672
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751411607; cv=none; b=MtdIJXgrj9e1QGx9vhrpZRQ28FdeW5uHgElnpPXKKpqYxEjfdPM2/IBXU5uD2waT+NLF8+wvWKt7lsxrkLrl42aQ0cacIilnPVbH3+kwHYMio5AIpVDQIKGb7pBK+uJ84vRqbZAoGamh2GDkZYpO7mTEkCz8g1FHp3HZ/zBRfgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751411607; c=relaxed/simple;
	bh=GZ23yzjE5Op9rlKEYe/hlNzE+mQEuoWgauvjEB+RHsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pF0BEPp/xUpJu0Pski1tJWd9i1SsJY7EFJcLw5YiM4SCZbWATj1I07AAWh24Y0D/PRECzHTB8hVCFNqp80jJRQucvzWQJ6ym3MAxs1dvx1+Nl9NTrUCFaCgvK79ww4SRDrfmDSm2qNL4IE0d4N2YELd2sbnHoZ1Cg1OWmtiOS38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CynIYWw1; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31329098ae8so5253106a91.1
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 16:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751411605; x=1752016405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QPknUyaO5fE8fNn+q2cniHPAEFNSkspR7Tg/gRHJQQ=;
        b=CynIYWw1LsiiRlCdup26B6QgrSBqsAAAgMt0SHOGxSjt1YUV63h7t+hRreo+E+rm9J
         SnBKj0EJoT2oNqmiEnXPhvSwI5mx61zr54sDx1FVnEujXsDSgnGm/gR17rK5ruYA0NSu
         6+4TAluFZpVIGiKakVx0EGKoqE0q/vqKOMFMSGV0hJSZL8+Z2qg6i1Qdfk8HpGJMBK6c
         H8D0CnEFy97xxOXXAcnXvq93vqwEnOkoBLhZ/dJlGsk8EG/NFhbqXxKxoQNPPqtRz/Wa
         gsndafgADB2G6voXaVKSl++9YaNB7rKUH+0UXUxxg4kNrlJrMhtY6RBUXIt50c80RY76
         Nveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751411605; x=1752016405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QPknUyaO5fE8fNn+q2cniHPAEFNSkspR7Tg/gRHJQQ=;
        b=ceDKjwack+bMS1PF5WXLyFYSGiuGsCOWC5DnOEX2syUWINJn43+sEwmk05SOVnBg8T
         qQKofmf6nmDLNi/Xm/KZRWFz7aWiYv2NHyXb4bGOekb0j1i6WMkXzVNZ/W2GGMg0j2Bf
         ytE77csonBdFkhOU3Q/ESRXIsiy/aik8V7iiCdTRTK5SbOudEF7H4EMBdEJog4vKxQCE
         YWQKuql8OSzVJMMFA1YreuYjQa0ZOKV9pTyEx9IWjAFKS8efXMg9lx/Wz3Yw6s2gzXcs
         tTDSY5VB7v9oS5L7k1rJNIQp5tEnxD0TXzUP2KrzCJBv3mVPYG8LtyHAzoWyDUa09DCz
         a4Bg==
X-Gm-Message-State: AOJu0YyNZBAmK1jHDQfw8UIsOJDKq7DVu/D9F7yFpE9DkW60/UdQo6fw
	t7c4WIHzDJBbDFxhkwMgBcVNaX+o+JSQWLAIOQIOzxBgk3wg/asOcOA0ikpqDQ==
X-Gm-Gg: ASbGncu7JgKYUFcmkJx33i8JWWQkC7HrmKQKDBTh4TnSo+v9UosEl0oJErYY8SPUd+z
	LXXeDCwIFeNGp7hIhzEMBEu2hRiH+aySEkoeMM1hyc8c9XeI5WGPeK8AQsHOvLnWKFac90QaFKP
	tCpo3caaNfroD4eDgf7EeaTirphUevAzcHMUUx7RZ8eCjezvK93+qjuR9Hs8Sxwkd/uPFJqEMVJ
	pFidz+9wM/I2DqitlUPAwf4S+rdTHw6/xvC4DKBI6NSawAJQmuPxqgqKdwTsl5tzPaAmNxJ26kd
	wfE2VCfcWEd8ac1FPvZ98lfuQ9MAD5esxEhopxC4SjlSUdeYSJs49qbxma+4TIvnlLgxrmBi
X-Google-Smtp-Source: AGHT+IHA+2JJHoeCIcuFUQWogaEPxvjG7gFI4bR1EK0lyyOa+T2nNA5izVaZtO8xB/8OyAqAbGGHSg==
X-Received: by 2002:a17:90b:5108:b0:313:d361:73d7 with SMTP id 98e67ed59e1d1-31a9183ab51mr407076a91.13.1751411605165;
        Tue, 01 Jul 2025 16:13:25 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f542661asm16685564a91.26.2025.07.01.16.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 16:13:24 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	will@willsroot.io,
	stephen@networkplumber.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net 2/2] selftests/tc-testing: Add a nested netem duplicate test
Date: Tue,  1 Jul 2025 16:13:06 -0700
Message-Id: <20250701231306.376762-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250701231306.376762-1-xiyou.wangcong@gmail.com>
References: <20250701231306.376762-1-xiyou.wangcong@gmail.com>
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
index 3c4444961488..e5425b3bdd5e 100644
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
+        "matchPattern": "qdisc netem",
+        "matchCount": "2"
     }
 ]
-- 
2.34.1


