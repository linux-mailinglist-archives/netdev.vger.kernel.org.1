Return-Path: <netdev+bounces-246154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A8FCE0193
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 20:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 143FC30049E2
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 19:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E99B328B52;
	Sat, 27 Dec 2025 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOoXissX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7E732862D
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766864514; cv=none; b=uKJs+H7pCOsySPQJmoGU/J90E4u2hALHzg+uMJsCPkTJU/MaePbBOtoHf0Z9GdqiLWaPBnQsKzFpk0eArLqfBpqgBJBRKyVPRwRFp0CrPD4CQnhbLy4jpj52PJHy/wl50vLcxKlnb3Tg8DDw7toAKsxbL0h37E2X7rXGddxpXZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766864514; c=relaxed/simple;
	bh=0xF/qoMYScGyzsUrxqXDhqBlTWWhc5uFUH02xwEcbyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bfikGpzojiBsBhr/p9sDnKswLd7Op4zoq8J78KtjEJjPoRzdR9btov1Rqbj41oIAyY0FuP6lKeHsMvzM2k94X0TdKWB4QwkfLnc7LxlcTyPSVWEBnF9lTm5xD6jZks0T8il4/9KpRm7Jz7/r8Z0ViTIC4X0Wqlqos61QEqL9+K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOoXissX; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c2f52585fso7142122a91.1
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 11:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766864511; x=1767469311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dA8rnfeRTQ3UoeWxoB8E6weN1m+0woqy2zqDPqU2zrg=;
        b=TOoXissXdZdS896v/FRlbkG9uBd7NVSYeWFm8zV/33r/3P7diKmvacqwxwxbqjTqh9
         r6KVZoSoMErw4kvLp0sDBrevs4UrVTZER3A8XX47ldkcg3RoHenQRM+dQYqBePmaHo+h
         nNhZUqoKWDpv6RSTLu1gNjGzRHGOw9Qiz2glugrwzKL7kKdlqjZirMwAxsF5s+LMUEq6
         PkfTVCbcaRr+CZH14CWNV72C5GVWovsfb4D0Hpl0juQscorkqh4kQuSXWMa++WxC2tBz
         YhN41SaBLvFrqgTuwF03gZQqC/Bc9AHTUWkXCz6HE8T1H8Sb/VIaZZ1+3YPECGFsdta8
         ETRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766864511; x=1767469311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dA8rnfeRTQ3UoeWxoB8E6weN1m+0woqy2zqDPqU2zrg=;
        b=XVUdXINXqU6qnfDCZgRf4t9tYZ2/vkrObps4kXverJpyUky8uh4InVuibrQn1eYIrB
         XumtIs+GQ0KLrzbLd0Wa4t8IgqGTp8A08DcAsNVAIwzUMlKCTRjl7VRB5Mu4ybRv09RL
         prmIvVIwkc+iTY92bWLIF3du8pozVdcOS7AegCMcoX75UYyJGYoDzS/EUMSnH+58KTQO
         P3so3PgVLjkY5tqzltsDuCKaaSDd/gGspqMlvkMSDTWFIH15e8z7Jze8LTM6mZ6tM8eY
         HtBUKZt8cYDKhi8awhtFGhyuzSa0FWkCQ3bVpdFtFjwL/3ns3IXPCxZkP6h+jarBFs0b
         DdpQ==
X-Gm-Message-State: AOJu0YxyjHDryJRUWdyNOy9wy2nSlctLewQXhuoJstdl7M5PfpZ3clHS
	KExbHTkACagMb+uh4NcsLEGbC52Xkoi/9igegYqi8k7E2Y+jLcDEN/58zCKDRw==
X-Gm-Gg: AY/fxX56t0CE7nHpVcy+03b+ZDuxi+oxJLpnT8sHggtT4s5NsZPKmRn0ZQktCxb26vT
	a6l4+XuX2X9r3uYYwrEjqVew9stcI474ld+6U81HORIft7JQxB05+18hCphiRbsPMtFLFEAUvKG
	J7A/1gdbwxr/KDTSO25eu8NC6nanz/Z1/MsxZQ9sHU9+XaxdQw53HZgnAKQ6ZSo14yKTVKVPNrn
	Fb53foKYzFQvWP9yWqMZFuP2pHZAxziW2SVktI5yR86edHHTU6ZWUfidXfkCDa4I/W8n5Khd0yO
	toqQR5XZFRB5xriErTZ9m12tzmPZ3K/kk4zS4NR4186XNGu4qKPMuArDsWhiHj5RValfR/n01LX
	VIuITRQXCOaTks8VchhRG9uVk7DaL6rTcSDm8irVQlMXhvH9eB5wgpLREdatfT7xaRUusoULf5a
	a5SSKG/pVFTHp0nkea
X-Google-Smtp-Source: AGHT+IHkF888PZ0dosHx8V7hfeoTdTdTTA6RvJIUN8MWJhvv3P2Bc36UtEOR6GLw7+QrhC/Bdh8l0g==
X-Received: by 2002:a05:7022:5e06:b0:119:e569:fba9 with SMTP id a92af1059eb24-121722ebbbamr24194281c88.24.1766864511477;
        Sat, 27 Dec 2025 11:41:51 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:de11:3cdc:eebf:e8cf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe5653esm59087584eec.1.2025.12.27.11.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 11:41:50 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
	William Liu <will@willsroot.io>
Subject: [Patch net v6 5/8] selftests/tc-testing: Add a nested netem duplicate test
Date: Sat, 27 Dec 2025 11:41:32 -0800
Message-Id: <20251227194135.1111972-6-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251227194135.1111972-1-xiyou.wangcong@gmail.com>
References: <20251227194135.1111972-1-xiyou.wangcong@gmail.com>
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


