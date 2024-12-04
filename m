Return-Path: <netdev+bounces-149140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F259E4752
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 23:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126A018803A2
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 22:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8536199947;
	Wed,  4 Dec 2024 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QMTliMd2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106A41946A2
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 22:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733349613; cv=none; b=mSADmEG2wo3mRXwfA54XRnwTRASzd8dXa7bSMAgRPG8igVgWVh6Roxjv8NBnNCH4edqhT1nbQuFz1ZceRhoUmauHQKyItlERmceuhYWnbzbh2lIJX/hmu+JLN0J8Dd/gyXiGO93xnoqwX1B0GxFuXmfBvJlDU+h4KhGtaKacpZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733349613; c=relaxed/simple;
	bh=8wUDNXpHf/8SPAXe8iIOE0RaJG21LZagvFnY77viw6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWNM03hbfV+HvTtb4MDD+OYlCJQE9xTpctdUYm+WdZVw5nYpAs7ZvA7ojaa/hCx4l5P5sNbwWvwKHfQFim0nmXhmjMTRByTQAB//OKeRZFiHyNowy51iZTqmivPsmTihhm0NzFdH7+wsvNmWfaNhYKGizeS/4bGt7aDEQQ9U4Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QMTliMd2; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fbbe0fb0b8so211415a12.0
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 14:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733349611; x=1733954411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDgLwffLQVCdg82vmSrJ4+SPK5JkXN4iKKgvM6T6Wz4=;
        b=QMTliMd2AQ+pJzx2Rl5oM7grZT9b7LG2k7HYm80RlRe3/WR8kDuWpWAAURhNWD8MeC
         phO55oM/fHtb8mVJtdvSofGzgHLx6b4XEKNV9WJ1j2bQKyD6Vym9sqycS9RpTm7WWbL0
         /fTr6yU4grnsGsWltfpBWVlw41deNgSMEsRws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733349611; x=1733954411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDgLwffLQVCdg82vmSrJ4+SPK5JkXN4iKKgvM6T6Wz4=;
        b=aH8ApqvOLCvfV9cgHNMf/Dfqrj3FGiqC2doABrB3MTxGEE98oXpT1aAsvLOOzHlxTI
         2peVSYsRqk2i0xUswjWdmo5/wElxLI8kLeghd5Ebarmh005x4yiRfK7FGa7of83YrlG4
         PvxhNm9kCBdLXAu2NimqEzPVTcuSrceqtYyxqZBNwazQ/bG7NmK++fjPmCpsaiIFWI2L
         TEsoymLVi+HS6VqcHhKibWJdqAue2LiebQM5L6a+uVmVya+r8QDNLIBKGpobV5dnStP8
         lNy4YpwQC2OK3uvdbolGpwekNlV1lW/VoI2Lbj1+TiEAGbVqeB1Xg2Hb+x5ruRO+jX83
         +xvg==
X-Gm-Message-State: AOJu0YzmVTLFQJmMgPp8sIo3MbHVnP7zem6JgIFMmkJo1KjVww/5mYFZ
	ZLm9jpfmepWHsOmUY4AQ7pnRlqpEsodkLSPVP32WFFwUtNkvt3d/RX6rlJwfUw==
X-Gm-Gg: ASbGncvsUWv7Ys+elVwobFSdhLoXdvszpB1IsRnL/Eosp98dx7TOsAJBK1octTcmxfP
	W6QJ/GMUHyb6i6/2//dGVVsLxL5Yru7dODbIvQa5k3haF9HssNeqgE95jY2OyZGBrnofxM7I0UL
	Lp6IGAjMBBOqtvHz2RLdA3xC1nhgcda/9dpZ4xnzLYN7YyqLWcy2mOz1yOp1nP6a0CyrjCTQ/Ci
	B/fre8wCdV6rtzcKtoBlKpO7ShPsOumjsLThrmybTkm4PUKiNy+TDKXTto9Hu3R0Wy5b0G0aHzU
	K1paJZRDZbdX6PdzpVEhrVDJZQ==
X-Google-Smtp-Source: AGHT+IFGDxk3c1BX3pjbDoK+If2/v0II+y+3+F53LJYpTX8h7+tTxhrgvGQbyy32q6G6k+G4VgBY9g==
X-Received: by 2002:a17:90b:3e81:b0:2ee:fd53:2b17 with SMTP id 98e67ed59e1d1-2ef0125c849mr11162745a91.29.1733349611373;
        Wed, 04 Dec 2024 14:00:11 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541814873sm12897937b3a.153.2024.12.04.14.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 14:00:10 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH net 2/2] bnxt_en: Fix potential crash when dumping FW log coredump
Date: Wed,  4 Dec 2024 13:59:18 -0800
Message-ID: <20241204215918.1692597-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241204215918.1692597-1-michael.chan@broadcom.com>
References: <20241204215918.1692597-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongguang Gao <hongguang.gao@broadcom.com>

If the FW log context memory is retained after FW reset, the existing
code is not handling the condition correctly and zeroes out the data
structures.  This potentially will cause a division by zero crash
when the user runs ethtool -w.  The last_type is also not set
correctly when the context memory is retained.  This will cause errors
because the last_type signals to the FW that all context memory types
have been configured.

Oops: divide error: 0000 1 PREEMPT SMP NOPTI
CPU: 53 UID: 0 PID: 7019 Comm: ethtool Kdump: loaded Tainted: G           OE      6.12.0-rc7+ #1
Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Hardware name: Supermicro SYS-621C-TN12R/X13DDW-A, BIOS 1.4 08/10/2023
RIP: 0010:__bnxt_copy_ctx_mem.constprop.0.isra.0+0x86/0x160 [bnxt_en]
Code: 0a 31 d2 4c 89 6c 24 10 45 8b a5 fc df ff ff 4c 8b 74 24 20 31 db 66 89 44 24 06 48 63 c5 c1 e5 09 4c 0f af e0 48 8b 44 24 30 <49> f7 f4 4c 89 64 24 08 48 63 c5 4d 89 ec 31 ed 48 89 44 24 18 49
RSP: 0018:ff480591603d78b8 EFLAGS: 00010206
RAX: 0000000000100000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ff23959e46740000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000100000 R09: ff23959e46740000
R10: ff480591603d7a18 R11: 0000000000000010 R12: 0000000000000000
R13: ff23959e46742008 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f04227c1740(0000) GS:ff2395adbf680000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f04225b33a5 CR3: 000000108b9a4001 CR4: 0000000000773ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 ? die+0x33/0x90
 ? do_trap+0xd9/0x100
 ? __bnxt_copy_ctx_mem.constprop.0.isra.0+0x86/0x160 [bnxt_en]
 ? do_error_trap+0x65/0x80
 ? __bnxt_copy_ctx_mem.constprop.0.isra.0+0x86/0x160 [bnxt_en]
 ? exc_divide_error+0x36/0x50
 ? __bnxt_copy_ctx_mem.constprop.0.isra.0+0x86/0x160 [bnxt_en]
 ? asm_exc_divide_error+0x16/0x20
 ? __bnxt_copy_ctx_mem.constprop.0.isra.0+0x86/0x160 [bnxt_en]
 ? __bnxt_copy_ctx_mem.constprop.0.isra.0+0xda/0x160 [bnxt_en]
 bnxt_get_ctx_coredump.constprop.0+0x1ed/0x390 [bnxt_en]
 ? __memcg_slab_post_alloc_hook+0x21c/0x3c0
 ? __bnxt_get_coredump+0x473/0x4b0 [bnxt_en]
 __bnxt_get_coredump+0x473/0x4b0 [bnxt_en]
 ? security_file_alloc+0x74/0xe0
 ? cred_has_capability.isra.0+0x78/0x120
 bnxt_get_coredump_length+0x4b/0xf0 [bnxt_en]
 bnxt_get_dump_flag+0x40/0x60 [bnxt_en]
 __dev_ethtool+0x17e4/0x1fc0
 ? syscall_exit_to_user_mode+0xc/0x1d0
 ? do_syscall_64+0x85/0x150
 ? unmap_page_range+0x299/0x4b0
 ? vma_interval_tree_remove+0x215/0x2c0
 ? __kmalloc_cache_noprof+0x10a/0x300
 dev_ethtool+0xa8/0x170
 dev_ioctl+0x1b5/0x580
 ? sk_ioctl+0x4a/0x110
 sock_do_ioctl+0xab/0xf0
 sock_ioctl+0x1ca/0x2e0
 __x64_sys_ioctl+0x87/0xc0
 do_syscall_64+0x79/0x150

Fixes: 24d694aec139 ("bnxt_en: Allocate backing store memory for FW trace logs")
Signed-off-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 79f2d56d7bc8..a96190dde70e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8318,7 +8318,7 @@ static int bnxt_alloc_all_ctx_pg_info(struct bnxt *bp, int ctx_max)
 		struct bnxt_ctx_mem_type *ctxm = &ctx->ctx_arr[type];
 		int n = 1;
 
-		if (!ctxm->max_entries)
+		if (!ctxm->max_entries || ctxm->pg_info)
 			continue;
 
 		if (ctxm->instance_bmap)
@@ -8922,8 +8922,8 @@ static int bnxt_backing_store_cfg_v2(struct bnxt *bp, u32 ena)
 				continue;
 			}
 			bnxt_bs_trace_init(bp, ctxm);
-			last_type = type;
 		}
+		last_type = type;
 	}
 
 	if (last_type == BNXT_CTX_INV) {
-- 
2.30.1


