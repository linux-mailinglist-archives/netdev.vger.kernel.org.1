Return-Path: <netdev+bounces-243760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F820CA76EB
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 12:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E09BC39F0862
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 08:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC46D336EEC;
	Fri,  5 Dec 2025 08:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="XX70AqPs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE90336ECD
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764923129; cv=none; b=cGkH2/9fvQ/vzLIO+BO4l4B/oIB3Zjew3uqTdlZ1xvd/H/3NDWLtlDkvn5fPuIb5/0Od8bggoEl8p2JwB4P15WdG1w7URZ14gJvcLTXBjguVUSYmxCzgJdomQ18gr+hH97iWER+jhRck1tq44EudkHP5X+6u/nHtLCyAh6N1lb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764923129; c=relaxed/simple;
	bh=b7E6WBe+Fu0Qz9A8vGHqpx4aMMH5NUrSA7NG4EtSYDY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sFc3kPKfxS5WT91AKkgJf36fO5dkuvXakmanXJkAuUh3DEEDPZdKBRJ9Ss5xOVALEVVGSVgxd0gkgrm7tk/6i0bs/tx/mirb2MCO5J763PRwcY93V+FRUmrHkC64TU42QVr9Ayz80gs/lRX3cuV27m5DmymzPhGulCAoFW+FPqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=XX70AqPs; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6819440182
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 08:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764923113;
	bh=8T0UHhzai2fWCo6tRGyMn8d6SwcVbZ4Ka0x+SCnjr+g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=XX70AqPsLmpe/c5+lwWPfSF/BvGnOKY8RH55z990CFqZrfiD6D2YPOPQ9D0rg88hj
	 3rKJK/CYDtQ8oP12yBu3tXVCZ2C9IWFNRrI1CHD85tkxz9FZoqDSvN5QyffninvYtr
	 Q+p8ZrSU6QV++PRKnwq3wvLobuuvYA4Q7FvzTLiHUmG2WQwHOiMarC3W1f8InIfSmK
	 KE/eFPqSSVN2tIGnNEOumuWWBbI5VZIkdoVaj/PH7gROrIMcovz6G8P7EjcDvdnX9p
	 El9LS6ay9bHypKrTXb+JpR+1oCaAVvKf1rEhrhahaD5budTomqDQffyb/JBbr+b49V
	 bMPy9IZFDvc+fxugaylCqY712qAzB+/xKYcILRr+E4VlYPD8brNNK5eRrUc6D6kK08
	 y1JpzYlT6KLRlnW9qfnBoQjl4Tgpf70EpdVWo7wKKEm+0aRZqKDCfFH5fZcDsx7+Uq
	 955R5NUexA9heDiNyqeXWK1RjhWwPbsWE5jptm/TcCDfFGkFD2eqyEN5yCAFz1N1nD
	 S730RHfT/Fnaflcly4qgDBiB6d9K9zQF1d5sqJJ7pDi1ZqOEBwCC5fuy0YMHNaUz0t
	 3cBqJMImqa8y+TaqtAViofwnt/b2MUy5pttUDeGG9FUxjBpEwBZ7AaHlAfVN6Ffvem
	 EQUAJo/B+FYKihHGc9yD//cY=
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2956cdcdc17so20371675ad.3
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 00:25:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764923112; x=1765527912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8T0UHhzai2fWCo6tRGyMn8d6SwcVbZ4Ka0x+SCnjr+g=;
        b=cS9VnMv3qZrp+mJMK0JXMGvNKtaGbLshR4ildb9PLwSPUsn/mB2ImcSoO+YwDQ60Aj
         YHNooniX3bWYBHQyX2iFOgZ2ekGWzVGGBpKCrligRE5Nq2ysoszWOrs4bKyOXD2IntxR
         ZP78CzKG9Hz9L98NywUaaAUbK8kDxb5QqGquoHK2JJF4o44nQmdmCqXtE+HoLen53oXA
         EuGrgfu0eX+ZhJe94BG7BGYcq72KQI0uZNz3lVZLnE5kaOUcaPcW9FWgyB7dI5FL4OIm
         XXA/c8la28Z1l18nr8Ht7Wgua+B181iKbhm+ddJQDz7Jwg+QGuxBC0yHTjumMnerHzOU
         eKkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD3Bi4UDtyWW+kXozETD4YYy0INFpPF7P2Lzf7P6wl4ItsehbqibOCKTOHLTXolNZCmkc/N80=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDEijH4bVVIOXVRRs95/lEPqoTyiA0JmFwhcgHfQE0dBFsRKMK
	6jigQe7fMkzyUXUdjkR75yEnMjfsmDLVBrLC/i9XxPsno2mUaQUr0opvvkZi5kxEMFTqWwJH0Z+
	YU/DzE/h+dNGscyPBRBK5aIcC1PnCC+7/TZWDAz9kGTxLeAoRq1cO/neFlOKGfUlKLt4kBp4W1Q
	==
X-Gm-Gg: ASbGnctoBXuzzmNMmaX+q5YMydQLgeEZnBesWXQplZSUnlCA8Z7lXdFs81XofVzwViH
	6EwvXqkcOzPvackph0RczjJyx5Pbj4oBjUQFtIT0FuphnuWZywsWOZo1SzuxUQRKOZ4a4licSkA
	vGwEssflfSI2dFFlpO2ucO6fIB5hhVCyO2NXcgh0ek39QjFX1lBOPpZAwiMvtYGX8QiEubrIRqB
	suW5BXicstCvC+uPJQUVT0zjhiGYYgoZhvBElQyOFhtKvJ2rarhFW+3hnhmKaSyvYS8FwjTUL4t
	Aopz1/HxevLqNPukFkOVYcHIDZTkSlOQAvf2/Uptc9rB6EaTrhkJTYV55XxvgzGF2Ey0N095oPg
	RSmUw+PBV7kxl5fMxyFDLVcj/
X-Received: by 2002:a17:903:1a2d:b0:295:bedb:8d7 with SMTP id d9443c01a7336-29d683b103fmr119060465ad.48.1764923111849;
        Fri, 05 Dec 2025 00:25:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESNNepcAR75GX1HTpnznXPE60phc9h2xI6LaFnX+Dw43NLPltYKyx42/JGzBrUjBoHtNzU+Q==
X-Received: by 2002:a17:903:1a2d:b0:295:bedb:8d7 with SMTP id d9443c01a7336-29d683b103fmr119060085ad.48.1764923111440;
        Fri, 05 Dec 2025 00:25:11 -0800 (PST)
Received: from localhost.localdomain ([103.155.100.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4cfaecsm40896875ad.27.2025.12.05.00.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 00:25:11 -0800 (PST)
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
Subject: [PATCH v2 1/2] ice: Fix NULL pointer dereference in ice_vsi_set_napi_queues
Date: Fri,  5 Dec 2025 16:24:58 +0800
Message-ID: <20251205082459.1586143-1-aaron.ma@canonical.com>
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

Tested adaptor:
60:00.0 Ethernet controller [0200]: Intel Corporation Ethernet Controller E810-XXV for SFP [8086:159b] (rev 02)
        Subsystem: Intel Corporation Ethernet Network Adapter E810-XXV-2 [8086:4003]

SR-IOV state: both disabled and enabled can reproduce this issue.

kernel version: v6.18

Reproduce steps:
Bootup and execute suspend like systemctl suspend or rtcwake.

Log:
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
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
V1 -> V2: add test device info.

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


