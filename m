Return-Path: <netdev+bounces-100049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E42478D7AE9
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 06:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8451C20C9F
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 04:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731E818622;
	Mon,  3 Jun 2024 04:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ux6YFgWb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0955D19E
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 04:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717390698; cv=none; b=D2BZSEZVZ1pojQ9QpqFocd0PGXNBSNNSDADFsOvJIy/qjHlYupZ5ZGjgF4LYBF8nx295XIHmCICDPZv/MeewVBQjXSGrADlt54OEazje26J1kFCmO97DTklYDipx7M/3mfkY8ScU4Wbn4I7w8rCWM+2y51ufgTSWKlFvqQIC6hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717390698; c=relaxed/simple;
	bh=baOJhNAcu9rsaRHgCRG51NX07FSEcQmhvlhvKbTxvk0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W0w911ARvd0zXEoMuboMXLTRL325XeMEILvLBN2LCltOfbCl5yqlcGyVYqZO8wrCmhnmffnNr0EFdgX4UDPaBmDvmcc1PaJdqxUNYOSZDFuiCUqKbHazS9lMnRw6sLLpxgyHBqxYrDXUVtECifVubTuqcyyeNSresKpGmdF4DpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ux6YFgWb; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6c4f3e0e3d2so1895950a12.1
        for <netdev@vger.kernel.org>; Sun, 02 Jun 2024 21:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717390696; x=1717995496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XLWuROMco0PK0Z/K2k/5+DtzdUvyHK5Tfliu4nlPs0w=;
        b=Ux6YFgWbxHCGbbBKRBGnxIeW/lnIKdiR96TYOctQYvRr9TAgNrcRnh0xxGchYSBHWT
         ljwRc9tHahbibV4QDMCXzJOw9drsbK1/iUspBYUcy2AgLOqmfo3HtosQETH5BAMXjGpk
         czfYLbddxey7P+NiIJLDnIjlfJiKbSBTgMHzhs1HlFj53gUO8nbgK5aAiLkMbzmYB3It
         S5SqazeHtJCn1GNuY3j+58FXz3PRsrj2tIg6b6BkDTaaKH0OHz3X/zHI61rmhApM31MF
         UiRe9y/KIV+f+fTFtbuNW42ituIzNuYPECSvlKAZO9BeWwK24p6GumT8HrkB6qrkgrLH
         USWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717390696; x=1717995496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLWuROMco0PK0Z/K2k/5+DtzdUvyHK5Tfliu4nlPs0w=;
        b=Ud7YfZa/fUTtMxFYcnlkjvYFH04AdvLwwr33TUcrtc6IO2JkwPKrAJ26SvqnNZrHWg
         A1g//TLOTdkS+nWYWpg9VtzCiophaSm0hj1ywYjcAXV5URQDKJwd6hmGp5Vu310QcsHo
         JIDsUOQTvF2zrAcMo1pVn9sv9vEUA5GU7tJsJvKFTXELKxjLRSBSoH013J5Jzg3QPgKb
         aVX+be/qaIwRiuZUIwYIqoWK520hxtDYIGJZ07v8XHibvFxoDKuADp6aLuqMs+GHvaeM
         0tACIlv3lfD8iz3k5T6DS5jSriH4tFgLqOe3h4Zep2HcqII5z/C5/l4Q3DWvFSKLwmje
         Ml3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7WSVULelY/KVl7ohwWh/YYPbsXP1j55u0UwCsgmpFCQa7afiALcU5w/99PNdCSfQA2bHAhjFa5df3YnrrZoQnV95xSdGE
X-Gm-Message-State: AOJu0YyIsv+RUOIJ9J5PjD8qoLWK3zHMHrOpLEtuY13vFXnIhXcWIUAd
	Q+VjBENBrrKUyi3Fv2OQPRA2t8cc3w9ZdASeYbRY1c9HHoTtLj3K
X-Google-Smtp-Source: AGHT+IFPqmXGLRjiVGTCEUCfUvOLzk8y/p/fpk/+3KRdVlfUpimGfys9Uk8BBygHEyBLBoMcuWf2rQ==
X-Received: by 2002:a05:6a20:3218:b0:1b2:1ef8:3409 with SMTP id adf61e73a8af0-1b26f245d68mr8381059637.49.1717390696129;
        Sun, 02 Jun 2024 21:58:16 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632379db9sm55001585ad.110.2024.06.02.21.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 21:58:15 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	shannon.nelson@amd.com,
	brett.creeley@amd.com,
	drivers@pensando.io,
	netdev@vger.kernel.org
Cc: ap420073@gmail.com,
	jacob.e.keller@intel.com
Subject: [PATCH net] ionic: fix kernel panic in XDP_TX action
Date: Mon,  3 Jun 2024 04:57:55 +0000
Message-Id: <20240603045755.501895-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the XDP_TX path, ionic driver sends a packet to the TX path with rx
page and corresponding dma address.
After tx is done, ionic_tx_clean() frees that page.
But RX ring buffer isn't reset to NULL.
So, it uses a freed page, which causes kernel panic.

BUG: unable to handle page fault for address: ffff8881576c110c
PGD 773801067 P4D 773801067 PUD 87f086067 PMD 87efca067 PTE 800ffffea893e060
Oops: Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN NOPTI
CPU: 1 PID: 25 Comm: ksoftirqd/1 Not tainted 6.9.0+ #11
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/2021
RIP: 0010:bpf_prog_f0b8caeac1068a55_balancer_ingress+0x3b/0x44f
Code: 00 53 41 55 41 56 41 57 b8 01 00 00 00 48 8b 5f 08 4c 8b 77 00 4c 89 f7 48 83 c7 0e 48 39 d8
RSP: 0018:ffff888104e6fa28 EFLAGS: 00010283
RAX: 0000000000000002 RBX: ffff8881576c1140 RCX: 0000000000000002
RDX: ffffffffc0051f64 RSI: ffffc90002d33048 RDI: ffff8881576c110e
RBP: ffff888104e6fa88 R08: 0000000000000000 R09: ffffed1027a04a23
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881b03a21a8
R13: ffff8881589f800f R14: ffff8881576c1100 R15: 00000001576c1100
FS: 0000000000000000(0000) GS:ffff88881ae00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8881576c110c CR3: 0000000767a90000 CR4: 00000000007506f0
PKRU: 55555554
Call Trace:
<TASK>
? __die+0x20/0x70
? page_fault_oops+0x254/0x790
? __pfx_page_fault_oops+0x10/0x10
? __pfx_is_prefetch.constprop.0+0x10/0x10
? search_bpf_extables+0x165/0x260
? fixup_exception+0x4a/0x970
? exc_page_fault+0xcb/0xe0
? asm_exc_page_fault+0x22/0x30
? 0xffffffffc0051f64
? bpf_prog_f0b8caeac1068a55_balancer_ingress+0x3b/0x44f
? do_raw_spin_unlock+0x54/0x220
ionic_rx_service+0x11ab/0x3010 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
? ionic_tx_clean+0x29b/0xc60 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
? __pfx_ionic_tx_clean+0x10/0x10 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
? __pfx_ionic_rx_service+0x10/0x10 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
? ionic_tx_cq_service+0x25d/0xa00 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
? __pfx_ionic_rx_service+0x10/0x10 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
ionic_cq_service+0x69/0x150 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
ionic_txrx_napi+0x11a/0x540 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
__napi_poll.constprop.0+0xa0/0x440
net_rx_action+0x7e7/0xc30
? __pfx_net_rx_action+0x10/0x10

Fixes: 8eeed8373e1c ("ionic: Add XDP_TX support")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 5dba6d2d633c..2427610f4306 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -586,6 +586,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 			netdev_dbg(netdev, "tx ionic_xdp_post_frame err %d\n", err);
 			goto out_xdp_abort;
 		}
+		buf_info->page = NULL;
 		stats->xdp_tx++;
 
 		/* the Tx completion will free the buffers */
-- 
2.34.1


