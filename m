Return-Path: <netdev+bounces-102924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6340C905747
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 17:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA9E1C22300
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 15:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76875181300;
	Wed, 12 Jun 2024 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="QE00gWJ0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78B6180A92
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207206; cv=none; b=dMjmRHDR+pdSooC0afZkGy+744EymIui+ymXj5O7OIm0anz+0KkOTzqX67hdNZjB3yT35tnkSWSyrv1lIaZg+PsyoQmFl8X9rJ3LNCbMdnuDKQIJumkZIl//+cCVbeUDMtSsQElti2tdRslDoh9ttjbdtnFr5cGPUs5kCMSnxZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207206; c=relaxed/simple;
	bh=kP8B1EtDEHRLPl6cQ3qo9H978F1NbZQTNK607akF0LY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tnOZZALug+NI1sqOIK4Ho9yKz+E8vWm3lD6sMDqmN65aDxRM7T5Sze04RKtFQvO5/O41VVnKlOV3W+4SqRDPnX7m1ckCClUYkujzzR+gaU2gkXmrAlbwCgpFCX0q6qFqcar92dlZ0kFCdlTUpVdds5weVmnli4xCFcVUiuzNTTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=QE00gWJ0; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DACEC41337
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 15:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718207201;
	bh=8SWJ+twjICu3VPSrAXlWQPBg+OAHJguvfQRajwDcVbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=QE00gWJ0cDvWsfoz4WcsMtV6ugdrjX1+N+FxA4y5I6lGn6RYVKrFgjcmWp4HILOCf
	 LVB0quFW+IKKVneM6emvzqbnzE4/lTOTfJngLJe5Td2j1zuAjPmMUwWKaloYG/g24p
	 A/qW4wjLjYh+0+ucjVlTVKAvSUrm8JaAxwN1oqViDNTFXcKWB+P67KSOcUGAJVkupF
	 OpLqbw4JIlVEO6KSZGXj3YS30zg2OoX7z6BDKVdMGktQoQw8/8w3rMzCurXhAwUc1e
	 kanB0x+E/v/4o8ptoe7XW5PvgbFL4vKzMCVAqOZ4rxfdidcURS/7kkghOPGk5mh8MG
	 ZQoINjBVcrf2Q==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42183fdb37cso102745e9.3
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 08:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718207200; x=1718812000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8SWJ+twjICu3VPSrAXlWQPBg+OAHJguvfQRajwDcVbU=;
        b=XQb1BDaPuKbhvYedV/HdhchZIYcllhg7Ox6LJHPYZ+hDdrQ1bjnl/LDXVqylMNlSJS
         KTWzceKGZbfPoh0KQYic2/YIfVqcuSIuQ71pDweiVmDB+kMdWiXepir0DM18Hv/tjRBq
         EFDzAqd5uTdjHJicxy5IzimIwyirRAO14Esy9a63BIZp0fvM613zy4g2wCNb22xh/ah/
         RPN8FgIu0DR6E+Or4wRAvWmLK5f9S7dYIv9Y5QkBJv8l6Tka58yNbojrm5dWUH5j2YLv
         SZNNVkkckNL57UGjsDrvWMXv4HxFhN+O5xsEeANWiZOv7ZD89S29CNPkIN6NI0XviEsc
         usrA==
X-Gm-Message-State: AOJu0Yyaq7oVmX2TT2T+utBokJvy5KsWaWSum2ZVk58RyhWiPrBUe3m4
	xK+BZbRi6XVxP7jrOzrRon7d+5UqjG2g8Nc9VQt1a3HsnB89JsPaKjsWRf/JtqlPhyz2F4iRnEk
	qcm4rbYpibUf0vEeX0uwdL6dCbko23FA7EOFTZcQuA6WST8oGaXolsKKhQxz5/4/kFcLq7cFWQu
	PQMHR2
X-Received: by 2002:a05:600c:4587:b0:421:7f30:7ce3 with SMTP id 5b1f17b1804b1-422861af749mr18623045e9.1.1718207200422;
        Wed, 12 Jun 2024 08:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMSr9qdTcl5dEaxWrAt60xHJmkO5bs77bb1FUYZdUALYP8B5Pk8RKNk+PJyoKc+Ej3ou5rFA==
X-Received: by 2002:a05:600c:4587:b0:421:7f30:7ce3 with SMTP id 5b1f17b1804b1-422861af749mr18622925e9.1.1718207200014;
        Wed, 12 Jun 2024 08:46:40 -0700 (PDT)
Received: from XPS-17-9720.han-hoki.ts.net ([213.204.117.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870f75f9sm30782245e9.34.2024.06.12.08.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 08:46:39 -0700 (PDT)
From: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
To: netdev@vger.kernel.org
Cc: Ghadi Elie Rahme <ghadi.rahme@canonical.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 net] bnx2x: Fix multiple UBSAN array-index-out-of-bounds
Date: Wed, 12 Jun 2024 18:44:49 +0300
Message-ID: <20240612154449.173663-1-ghadi.rahme@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix UBSAN warnings that occur when using a system with 32 physical
cpu cores or more, or when the user defines a number of Ethernet
queues greater than or equal to FP_SB_MAX_E1x using the num_queues
module parameter.

The value of the maximum number of Ethernet queues should be limited
to FP_SB_MAX_E1x in case FCOE is disabled or to [FP_SB_MAX_E1x-1] if
enabled to avoid out of bounds reads and writes.

Stack traces:

UBSAN: array-index-out-of-bounds in
       drivers/net/ethernet/broadcom/bnx2x/bnx2x_stats.c:1529:11
index 20 is out of range for type 'stats_query_entry [19]'
CPU: 12 PID: 858 Comm: systemd-network Not tainted 6.9.0-060900rc7-generic
	     #202405052133
Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9,
	       BIOS P89 10/21/2019
Call Trace:
 <TASK>
 dump_stack_lvl+0x76/0xa0
 dump_stack+0x10/0x20
 __ubsan_handle_out_of_bounds+0xcb/0x110
 bnx2x_prep_fw_stats_req+0x2e1/0x310 [bnx2x]
 bnx2x_stats_init+0x156/0x320 [bnx2x]
 bnx2x_post_irq_nic_init+0x81/0x1a0 [bnx2x]
 bnx2x_nic_load+0x8e8/0x19e0 [bnx2x]
 bnx2x_open+0x16b/0x290 [bnx2x]
 __dev_open+0x10e/0x1d0
RIP: 0033:0x736223927a0a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca
      64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00
      f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
RSP: 002b:00007ffc0bb2ada8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000583df50f9c78 RCX: 0000736223927a0a
RDX: 0000000000000020 RSI: 0000583df50ee510 RDI: 0000000000000003
RBP: 0000583df50d4940 R08: 00007ffc0bb2adb0 R09: 0000000000000080
R10: 0000000000000000 R11: 0000000000000246 R12: 0000583df5103ae0
R13: 000000000000035a R14: 0000583df50f9c30 R15: 0000583ddddddf00
</TASK>
---[ end trace ]---
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in
       drivers/net/ethernet/broadcom/bnx2x/bnx2x_stats.c:1546:11
index 28 is out of range for type 'stats_query_entry [19]'
CPU: 12 PID: 858 Comm: systemd-network Not tainted 6.9.0-060900rc7-generic
	     #202405052133
Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9,
	       BIOS P89 10/21/2019
Call Trace:
<TASK>
dump_stack_lvl+0x76/0xa0
dump_stack+0x10/0x20
__ubsan_handle_out_of_bounds+0xcb/0x110
bnx2x_prep_fw_stats_req+0x2fd/0x310 [bnx2x]
bnx2x_stats_init+0x156/0x320 [bnx2x]
bnx2x_post_irq_nic_init+0x81/0x1a0 [bnx2x]
bnx2x_nic_load+0x8e8/0x19e0 [bnx2x]
bnx2x_open+0x16b/0x290 [bnx2x]
__dev_open+0x10e/0x1d0
RIP: 0033:0x736223927a0a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca
      64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00
      f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
RSP: 002b:00007ffc0bb2ada8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000583df50f9c78 RCX: 0000736223927a0a
RDX: 0000000000000020 RSI: 0000583df50ee510 RDI: 0000000000000003
RBP: 0000583df50d4940 R08: 00007ffc0bb2adb0 R09: 0000000000000080
R10: 0000000000000000 R11: 0000000000000246 R12: 0000583df5103ae0
R13: 000000000000035a R14: 0000583df50f9c30 R15: 0000583ddddddf00
 </TASK>
---[ end trace ]---
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in
       drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c:1895:8
index 29 is out of range for type 'stats_query_entry [19]'
CPU: 13 PID: 163 Comm: kworker/u96:1 Not tainted 6.9.0-060900rc7-generic
	     #202405052133
Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9,
	       BIOS P89 10/21/2019
Workqueue: bnx2x bnx2x_sp_task [bnx2x]
Call Trace:
 <TASK>
 dump_stack_lvl+0x76/0xa0
 dump_stack+0x10/0x20
 __ubsan_handle_out_of_bounds+0xcb/0x110
 bnx2x_iov_adjust_stats_req+0x3c4/0x3d0 [bnx2x]
 bnx2x_storm_stats_post.part.0+0x4a/0x330 [bnx2x]
 ? bnx2x_hw_stats_post+0x231/0x250 [bnx2x]
 bnx2x_stats_start+0x44/0x70 [bnx2x]
 bnx2x_stats_handle+0x149/0x350 [bnx2x]
 bnx2x_attn_int_asserted+0x998/0x9b0 [bnx2x]
 bnx2x_sp_task+0x491/0x5c0 [bnx2x]
 process_one_work+0x18d/0x3f0
 </TASK>
---[ end trace ]---

Fixes: 7d0445d66a76 ("bnx2x: clamp num_queues to prevent passing a negative value")
Signed-off-by: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
Cc: stable@vger.kernel.org
---
Changes since v1:
 * Fix checkpatch complaints:
   - Wrapped commit message to comply with 75 character limit
   - Added space before ( in if condition

 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index a8e07e51418f..c895dd680cf8 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -66,7 +66,12 @@ static int bnx2x_calc_num_queues(struct bnx2x *bp)
 	if (is_kdump_kernel())
 		nq = 1;
 
-	nq = clamp(nq, 1, BNX2X_MAX_QUEUES(bp));
+	int max_nq = FP_SB_MAX_E1x - 1;
+
+	if (NO_FCOE(bp))
+		max_nq = FP_SB_MAX_E1x;
+
+	nq = clamp(nq, 1, max_nq);
 	return nq;
 }
 
-- 
2.43.0


