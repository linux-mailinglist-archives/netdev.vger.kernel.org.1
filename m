Return-Path: <netdev+bounces-98467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 202FD8D186A
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2D89B23FBC
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB8D16D331;
	Tue, 28 May 2024 10:21:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from externalmx.cuda-inc.com (externalmx01.cuda-inc.com [198.35.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E397616C680
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 10:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.35.20.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891672; cv=none; b=o3cRjRonuDWxLmtimEyz3SvEbUaCjClEHBQU9EHfl8vudwcwq7AkYIYLXuZ235dKcGIZko4m4i5DOVyT8JkgehqtzFIxv4iUMY528R36RrNrTFduhZ3pOyoy4+wat3sy2wwTgzz7sCtzPDxvueephj/MtPRF77Wl/32RyxnaRt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891672; c=relaxed/simple;
	bh=nQ9q4lQbHqZGAD5UEOzWy1NEc7ZnP6DduBejFL9A51U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C6g8qEx0sd4/3n/uKVT1mtK8F0lvFSSjfenWKYLvBtTiaJ1qRAk41CurbwpMe1XU7D2fRDbGQhNoieEkEewYAkyshNoiMX40vZyPe0EuFyxYEfZzpQzouoUSP2Dj0ba5PsliVh4G5hZTAiCHk3thVT4Byv2WZeuPS4Z5Kw+Huzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=barracuda.com; spf=pass smtp.mailfrom=barracuda.com; arc=none smtp.client-ip=198.35.20.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=barracuda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barracuda.com
X-ASG-Debug-ID: 1716890796-1fbdb972684b315d0001-BZBGGp
Received: from Rick.fritz.box ([10.42.96.1]) by externalmx.cuda-inc.com with ESMTP id z8PqspYW5MAaDZWI; Tue, 28 May 2024 03:06:36 -0700 (PDT)
X-Barracuda-Envelope-From: mstocker@barracuda.com
X-Barracuda-RBL-Trusted-Forwarder: 10.42.96.1
From: Matthias Stocker <mstocker@barracuda.com>
To: doshir@vmware.com,
	pv-drivers@vmware.com,
	netdev@vger.kernel.org
Cc: Matthias Stocker <mstocker@barracuda.com>
Subject: [PATCH] vmxnet3: disable rx data ring on dma allocation failure
Date: Tue, 28 May 2024 12:06:15 +0200
X-ASG-Orig-Subj: [PATCH] vmxnet3: disable rx data ring on dma allocation failure
Message-ID: <20240528100615.30818-1-mstocker@barracuda.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: UNKNOWN[10.42.96.1]
X-Barracuda-Start-Time: 1716890796
X-Barracuda-URL: https://10.42.53.111:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 3167
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125454
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

When vmxnet3_rq_create fails to allocate memory for the data ring,
vmxnet3_rq_destroy_all_rxdataring is called, but rq->data_ring.desc_size
is not zeroed, as is the case when adapter->rxdataring_enabled is set to
false. This leads to the box crashing a short time later with a
NULL pointer dereference in memcpy.

[1101376.713751] vmxnet3 0000:13:00.0 dhcp: rx data ring will be disabled
[1101376.719942] vmxnet3 0000:13:00.0 dhcp: intr type 3, mode 0, 3 vectors allocated
[1101376.721085] vmxnet3 0000:13:00.0 dhcp: NIC Link is Up 10000 Mbps
[1101377.020907] BUG: kernel NULL pointer dereference, address: 0000000000000000
[1101377.023396] #PF: supervisor read access in kernel mode
[1101377.025172] #PF: error_code(0x0000) - not-present page
[1101377.026966] PGD 115a58067 P4D 115a58067 PUD 115a55067 PMD 0
[1101377.028930] Oops: 0000 [#1] SMP NOPTI
[1101377.033776] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[1101377.037316] RIP: 0010:__memcpy+0x12/0x20
[1101377.038700] Code: c0 74 0b 48 8b 78 08 31 f6 e8 ca 7d 86 ff eb c4 cc cc cc cc cc cc cc cc 0f 1f 44 00 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 <f3> 48 a5 89 d1 f3 a4 e9 72 22 40 00 66 90 48 89 f8 48 89 d1 f3 a4
[1101377.044849] RSP: 0018:ffff991cc0003e70 EFLAGS: 00210202
[1101377.046639] RAX: ffff952ca8287e40 RBX: 0000000000000000 RCX: 0000000000000007
[1101377.049035] RDX: 0000000000000004 RSI: 0000000000000000 RDI: ffff952ca8287e40
[1101377.051449] RBP: ffff952c13c01180 R08: 0000000000000000 R09: 00000000000000c0
[1101377.053914] R10: ffff952c13c00980 R11: 0000000000000000 R12: ffff952d2b0a0000
[1101377.056358] R13: ffff952d16e10000 R14: ffff952d0cee0000 R15: 00000000ffffffff
[1101377.058773] FS:  0000000000000000(0000) GS:ffff952d3bc00000(0063) knlGS:00000000f79e3880
[1101377.061500] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[1101377.063488] CR2: 0000000000000000 CR3: 000000010dade000 CR4: 00000000000406f0
[1101377.065921] Call Trace:
[1101377.066844]  <IRQ>
[1101377.067621]  vmxnet3_rq_rx_complete+0x596/0xed0 [vmxnet3]
[1101377.072607]  vmxnet3_poll_rx_only+0x30/0xb0 [vmxnet3]
[1101377.074486]  net_rx_action+0x145/0x3e0
[1101377.075819]  __do_softirq+0xcb/0x28c
[1101377.077102]  asm_call_irq_on_stack+0x12/0x20
[1101377.078595]  </IRQ>
[1101377.079395]  do_softirq_own_stack+0x37/0x50
[1101377.080872]  irq_exit_rcu+0xc7/0x110
[1101377.082158]  common_interrupt+0x6c/0x120
[1101377.083547]  asm_common_interrupt+0x1e/0x40

Signed-off-by: Matthias Stocker <mstocker@barracuda.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 0578864792b6..beebe09eb88f 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2034,8 +2034,8 @@ vmxnet3_rq_destroy_all_rxdataring(struct vmxnet3_adapter *adapter)
 					  rq->data_ring.base,
 					  rq->data_ring.basePA);
 			rq->data_ring.base = NULL;
-			rq->data_ring.desc_size = 0;
 		}
+		rq->data_ring.desc_size = 0;
 	}
 }
 
-- 
2.45.1


