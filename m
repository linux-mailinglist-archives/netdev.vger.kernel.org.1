Return-Path: <netdev+bounces-243688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 286E0CA5EA6
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 03:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D848230C38BC
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 02:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35CF2E172D;
	Fri,  5 Dec 2025 02:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="MQWWhghv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2599B2DEA73
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 02:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764902303; cv=none; b=nEsMVh95zgFZwDDrNUEN9l1q2iasUQnajWI6GFpJQehY5rNNVOJnvLqpBXhzyzsXELisMFoCOx7r7SsyIFeXQRgsdvp/quG2TJe9jicfF7QdvtAM3gOVwfesOIY2ZBR5hkvjGLnXu/rhg2JY8qR8GmVZ+Ct4GDBCdfnxbN6ChIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764902303; c=relaxed/simple;
	bh=AyNZFE4FkEQDamkvYFUjpXfr/cIYnjOim0z8aUvD258=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OLmxfSSfkVp6eIIeJA4oPwFcnkF+EuISYLkK3z2V5iNj2prVE+G5LCo1BM+98NWXy1P7AIGpPSiBFPOl82eTzGZdUVHhmikC3VCSjv3es1IjZk4/8ksAfdiGGjgkR/0Zm3jtUBvjgXBw9gGuV9OBZX4HAH7OISeb0Hyif+0t/K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=MQWWhghv; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4B316403F7
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 02:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764902298;
	bh=uJGwalCsK5wg+VSROCE2YDpeUgGvxPcagIFbkdcqD2Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=MQWWhghvEpgwzPztljIvnBznVS06vUqZp8wvLGovAc5KZ8xr2rH6eVGAwLxg5adaR
	 0prry4den4IQ80+ivf5poNJisGPCs9yrYLZTkrfI/GIYZP0t6DzTfY3IiYQ0AqNUO0
	 +oLV7zRDSRC0gNOcyabVUHgx4RagbCTCgfD7zcfOOJn7GK+6mGJ1fXf5UBZblPY28y
	 KZM9OJ9Wd8b3QVk0WtQcGA3+XypPMXFE8rQ6wbQAoHchXnuXT3EoH0NXlW1kFGSWI5
	 mmR34a5jUp4Vq/J2Bg6ZwLCl9YRngSXx7JPz5OXFQkK5YuTz8E9IWBUur8nEMAb4lU
	 w9hy7vWuM5GxuWntYPfpSsvO7DUDPRTWWf2UbTzl0skQquJuQTvdnLeck7AwIi6qDQ
	 wn0/v85VwoKpWOLiPb/AhAOasmWM675xG8Tyb3BZFaDshcgPo+WVHNKCJgIzx7bciP
	 CSr/IVWCwRKRhomExf8CGrf2VH2lR0KhqL4aF2hm4DOSed8x00qVPeh7wTzvnynUPg
	 LeWrlg6qiKxjbMXUUJZMknjUFOpDKlngAWEwppTDHdmNj7+FDZ8JdAp/jsp9Pnt+xc
	 qhKbVsqgI00EWj3D1d8THtpHr5bT8k7jcOvSyN3kswklojL3OKPfoMcISsCLvsJQCR
	 geFtS5J8QHLJ/wz1BjIu8Mlg=
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2958a134514so23261465ad.2
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 18:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764902297; x=1765507097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJGwalCsK5wg+VSROCE2YDpeUgGvxPcagIFbkdcqD2Q=;
        b=hQxTznyQbgF0ICb1gIlNKP8Vt31IPxhFzuYCiuOHIsWuD/HTe1ZXOyqiv4sWzIhO8/
         myrQfVEj4ELddi8V5pLqYurUkuk209G4RN8AgbPqsB0JDi9GsZr8gy1VQdA593dGmzUT
         LWhSZj/OAhnJ67kQh2tIIR4/36JIVBnsls2kA8I5UFz80ZiN8Woou91MbBLOOk91R0JR
         eNs0fxS2iX2hijH9RPgJejOgN+y4vP78u3qf+b20DcitPMco15bct6vP58BmdQ/1+ZrD
         3w6/rlBOt9vp33kRzIY4mM1u86aLRrmiH0/KcAxIMq5LzsAWnbc2WEejNEjWqrxVR9kW
         HEAg==
X-Forwarded-Encrypted: i=1; AJvYcCU7yMzOYiENbJtZ34LqcX9OfCGapihe7R0i5rGcSDoUwHhSWi0VjlzDm6nU3KGQPA5Jj9Rb3Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzUuc3tNMu/HQl9utq7/MerAVf7RvHVe2o9mX5eoXwq5b1DFHD
	akjGDuHaPptJgdFB7xFska3237mOuSH7I22Etv8kBFqdJ8yvNdY6WjoPIz9F+Qj/k55rJIAoj1Q
	+OnKw6t1EY7RxNR8Z6d7AI0RleZWcx2ZixpCZmF5C5B9hc7ZKplu/9badR/fyJ7rklPRP64uR5g
	==
X-Gm-Gg: ASbGnctkP1gag5f8SpwevxnPoMfdeeX6JF/h66ok4gX1REocoXuRERA/yxWSNI6OtPo
	Zi5ouBtM6F9WwPafa0MuR0gTts2M9aOzxrCucA6/f7G/yPwIj6Jwe87ES97CcxyXEyaPLBEdQjd
	A/pHIpqzC/PD9HeKtGfDmu6hwl8uVRY063CiDghOaXyfUijigBw/NzLjHhMashCzZReNqXiJ1rP
	7kgdw87ufkQVv2Saon1s07y6T4lOiyXZmBs1TbzFJmDhsH37pBB5ddeueM9tZsBQi2iCMlJgLe8
	LA0ua+iD3avEfHCvtCpeFgWMm9Vs04jmSA47vDab9Fd4qzyiy7VFNa5TIH9VYw74/QKHrrYduuR
	EZwyag/iu6mMsxtULiPsqRr5B
X-Received: by 2002:a17:902:daca:b0:29d:9b3c:4fc9 with SMTP id d9443c01a7336-29da1eedfebmr67841595ad.57.1764902296855;
        Thu, 04 Dec 2025 18:38:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHc9b4mxhFlM56SAxkWLSFDcHCeO74U7vxw1Yuh33+dvWDULZVC3R1bI7UwYHAoSDDHs70lAw==
X-Received: by 2002:a17:902:daca:b0:29d:9b3c:4fc9 with SMTP id d9443c01a7336-29da1eedfebmr67841265ad.57.1764902296468;
        Thu, 04 Dec 2025 18:38:16 -0800 (PST)
Received: from localhost.localdomain ([103.155.100.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99f1cfsm32282785ad.55.2025.12.04.18.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 18:38:16 -0800 (PST)
From: Aaron Ma <aaron.ma@canonical.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ice: Fix NULL pointer dereference in ice_vsi_set_napi_queues
Date: Fri,  5 Dec 2025 10:37:56 +0800
Message-ID: <20251205023757.1541228-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NULL pointer checks in ice_vsi_set_napi_queues() to prevent crashes
during resume from suspend when rings[q_idx]->q_vector is NULL.

<1>[  231.443607] BUG: kernel NULL pointer dereference, address: 0000000000000040
<1>[  231.444052] #PF: supervisor read access in kernel mode
<1>[  231.444484] #PF: error_code(0x0000) - not-present page
<6>[  231.444913] PGD 0 P4D 0
<4>[  231.445342] Oops: Oops: 0000 [#1] SMP NOPTI
<4>[  231.446635] RIP: 0010:netif_queue_set_napi+0xa/0x170
<4>[  231.447067] Code: 31 f6 31 ff c3 cc cc cc cc 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 85 c9 74 0b <48> 83 79 30 00 0f 84 39 01 00 00 55 41 89 d1 49 89 f8 89 f2 48 89
<4>[  231.447513] RSP: 0018:ffffcc780fc078c0 EFLAGS: 00010202
<4>[  231.447961] RAX: ffff8b848ca30400 RBX: ffff8b848caf2028 RCX: 0000000000000010
<4>[  231.448443] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8b848dbd4000
<4>[  231.448896] RBP: ffffcc780fc078e8 R08: 0000000000000000 R09: 0000000000000000
<4>[  231.449345] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
<4>[  231.449817] R13: ffff8b848dbd4000 R14: ffff8b84833390c8 R15: 0000000000000000
<4>[  231.450265] FS:  00007c7b29e9d740(0000) GS:ffff8b8c068e2000(0000) knlGS:0000000000000000
<4>[  231.450715] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[  231.451179] CR2: 0000000000000040 CR3: 000000030626f004 CR4: 0000000000f72ef0
<4>[  231.451629] PKRU: 55555554
<4>[  231.452076] Call Trace:
<4>[  231.452549]  <TASK>
<4>[  231.452996]  ? ice_vsi_set_napi_queues+0x4d/0x110 [ice]
<4>[  231.453482]  ice_resume+0xfd/0x220 [ice]
<4>[  231.453977]  ? __pfx_pci_pm_resume+0x10/0x10
<4>[  231.454425]  pci_pm_resume+0x8c/0x140
<4>[  231.454872]  ? __pfx_pci_pm_resume+0x10/0x10
<4>[  231.455347]  dpm_run_callback+0x5f/0x160
<4>[  231.455796]  ? dpm_wait_for_superior+0x107/0x170
<4>[  231.456244]  device_resume+0x177/0x270
<4>[  231.456708]  dpm_resume+0x209/0x2f0
<4>[  231.457151]  dpm_resume_end+0x15/0x30
<4>[  231.457596]  suspend_devices_and_enter+0x1da/0x2b0
<4>[  231.458054]  enter_state+0x10e/0x570

Add defensive checks for both the ring pointer and its q_vector
before dereferencing, allowing the system to resume successfully even when
q_vectors are unmapped.

Fixes: 2a5dc090b92cf ("ice: move netif_queue_set_napi to rtnl-protected sections")
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 15621707fbf81..9d1178bde4495 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2779,11 +2779,13 @@ void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
 
 	ASSERT_RTNL();
 	ice_for_each_rxq(vsi, q_idx)
-		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_RX,
+		if (vsi->rx_rings[q_idx] && vsi->rx_rings[q_idx]->q_vector)
+			netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_RX,
 				     &vsi->rx_rings[q_idx]->q_vector->napi);
 
 	ice_for_each_txq(vsi, q_idx)
-		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_TX,
+		if (vsi->tx_rings[q_idx] && vsi->tx_rings[q_idx]->q_vector)
+			netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_TX,
 				     &vsi->tx_rings[q_idx]->q_vector->napi);
 	/* Also set the interrupt number for the NAPI */
 	ice_for_each_q_vector(vsi, v_idx) {
-- 
2.43.0


