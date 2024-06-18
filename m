Return-Path: <netdev+bounces-104326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2145090C2B6
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 06:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1F51F217B6
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 04:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3127917740;
	Tue, 18 Jun 2024 04:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COqauQH/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE181D951A
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 04:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718684115; cv=none; b=H2MyT45jVXQMkwd5hZnNbckrGEN6y/6RMxZaYYxvaGzN3AjK3k4TtHUpKVD9KS0lKGWa/wQdx6XUIGODe/Agc8yzlwgY8FvYuQXueCQUshhPWcQtUgk2W+dPSP51GFu4r5nB2bPfvWesaQGHJdZU57ZGdkkc8T3uzaeXhjigKh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718684115; c=relaxed/simple;
	bh=S1ZJxP12zqXPT8F0N1HAGkhV9rS0uQmASRwPXELUnv0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z8IqXdb2RI/SrRjOPK8UVaQefAOaON2UwTGLfvdnfIvdAgOO78aF9sfQlagTqJYVv7WsAQMmPblBBmD3SrVNqwDDZ3zBFHenmR6PfD0WVdo+GJj99Wn6J3+xFtcMnT6+ouMHzDx2DCAFj/P/U8XiMwBwbW9x7GMN+D39GyUKElM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COqauQH/; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-681bc7f50d0so4180705a12.0
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 21:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718684113; x=1719288913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ysXuddJjh/Tdhc/VTzxE2IR534+hjBNaGNhue9PhlYA=;
        b=COqauQH/W8z4oc405yULvbhsN9gQa2H4BNHHKL5uAAij3tMOLDW9bDcDvDdSgg21DS
         j8fUKoMtmTNKidWJAZSJW8lKD+dH6fnuDwJ0IcFpnE9pC9WDcYmYeTK2MVVizLZP0JvJ
         WlcKXEAEO0J2o4/Pc3YJ6jTdR0yBDx0OvLt9Mskn8+ZONm2Y08XNpvUMZSZBac8hS74K
         6DnalTVSEGMdZJ6ifg/yLrpP2aowIyxpzDFu7DegmdcrT8wIz0Y4WUlJz78QvbhvJgL1
         nEWqbuC3X+gcIitHA83VF2kFgSJGUJvtec+uHi4zqHt2WzimDxEmJczto+NLq3AI44W3
         M4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718684113; x=1719288913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysXuddJjh/Tdhc/VTzxE2IR534+hjBNaGNhue9PhlYA=;
        b=ZxuEyMJrtIJV8p0EXDW7BViJgXUWtUrpE8eVms82hWAlJBQpOFVwiun524O0bQEjac
         UsvUaCpvQENWwokJWw16nN4i3QQt7ZGDCaSfJqsvL55aC5WTVbWFZSPwztc7fC79aMfB
         ZWBHjCuWvjr2G82Z6Vxwhi5PwZUbrJ8UL7XggE1TBpsC9YRsBfmNUvF/f2Ym/zh6Nj8R
         JWjHh/LkchsaFKaj1vJR9p2dtG50CVU9YCjt735X48+hf9PgKs+5oHMyc5yo8FdEr21z
         CFUQmGy60Z++Gz/19UfV1wnWee/jZ73G85YyTy+dlbbIbw6dsw7B9eomk42a2PS+i4Ns
         Eplw==
X-Forwarded-Encrypted: i=1; AJvYcCVFsmN8n4aobeJR+f9WMIbOH6OPAsTApGXSnnzHjdLd2U5IkLQmpLt2WJNrkZzCIpupWrO8AdCnkgWHKHtBTXX+mvja7Leg
X-Gm-Message-State: AOJu0YygJE5fuWG2WKLVE5TJTYl8cloRe2jT0q1ojVVsxqiWfby7ODdA
	rFotZEGG41s5UKso5sckQlYL9ktJ6mJpJsV9XsBIX9QlMdfaONSh
X-Google-Smtp-Source: AGHT+IG+25xPQbaFe+CR7SWMErizMVkVoAP6Isb/UTnDlLkULnvBKZy07Ky1hmgAuUxNo1jdGXuDOg==
X-Received: by 2002:a17:902:f54f:b0:1f7:1bf3:db10 with SMTP id d9443c01a7336-1f98b23f6afmr22545175ad.20.1718684112648;
        Mon, 17 Jun 2024 21:15:12 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f04c81sm87262495ad.205.2024.06.17.21.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 21:15:11 -0700 (PDT)
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
Subject: [PATCH net] ionic: fix kernel panic due to multi-buffer handling
Date: Tue, 18 Jun 2024 04:14:12 +0000
Message-Id: <20240618041412.3184919-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the ionic_run_xdp() doesn't handle multi-buffer packets
properly for XDP_TX and XDP_REDIRECT.
When a jumbo frame is received, the ionic_run_xdp() first makes xdp
frame with all necessary pages in the rx descriptor.
And if the action is either XDP_TX or XDP_REDIRECT, it should unmap
dma-mapping and reset page pointer to NULL for all pages, not only the
first page.
But it doesn't for SG pages. So, SG pages unexpectedly will be reused.
It eventually causes kernel panic.

Oops: general protection fault, probably for non-canonical address 0x504f4e4dbebc64ff: 0000 [#1] PREEMPT SMP NOPTI
CPU: 3 PID: 0 Comm: swapper/3 Not tainted 6.10.0-rc3+ #25
RIP: 0010:xdp_return_frame+0x42/0x90
Code: 01 75 12 5b 4c 89 e6 5d 31 c9 41 5c 31 d2 41 5d e9 73 fd ff ff 44 8b 6b 20 0f b7 43 0a 49 81 ed 68 01 00 00 49 29 c5 49 01 fd <41> 80 7d0
RSP: 0018:ffff99d00122ce08 EFLAGS: 00010202
RAX: 0000000000005453 RBX: ffff8d325f904000 RCX: 0000000000000001
RDX: 00000000670e1000 RSI: 000000011f90d000 RDI: 504f4e4d4c4b4a49
RBP: ffff99d003907740 R08: 0000000000000000 R09: 0000000000000000
R10: 000000011f90d000 R11: 0000000000000000 R12: ffff8d325f904010
R13: 504f4e4dbebc64fd R14: ffff8d3242b070c8 R15: ffff99d0039077c0
FS:  0000000000000000(0000) GS:ffff8d399f780000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f41f6c85e38 CR3: 000000037ac30000 CR4: 00000000007506f0
PKRU: 55555554
Call Trace:
 <IRQ>
 ? die_addr+0x33/0x90
 ? exc_general_protection+0x251/0x2f0
 ? asm_exc_general_protection+0x22/0x30
 ? xdp_return_frame+0x42/0x90
 ionic_tx_clean+0x211/0x280 [ionic 15881354510e6a9c655c59c54812b319ed2cd015]
 ionic_tx_cq_service+0xd3/0x210 [ionic 15881354510e6a9c655c59c54812b319ed2cd015]
 ionic_txrx_napi+0x41/0x1b0 [ionic 15881354510e6a9c655c59c54812b319ed2cd015]
 __napi_poll.constprop.0+0x29/0x1b0
 net_rx_action+0x2c4/0x350
 handle_softirqs+0xf4/0x320
 irq_exit_rcu+0x78/0xa0
 common_interrupt+0x77/0x90

Fixes: 5377805dc1c0 ("ionic: implement xdp frags support")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

In the XDP_DROP and XDP_ABORTED path, the ionic_rx_page_free() is called
to free page and unmap dma-mapping.
It resets only the first page pointer to NULL.
DROP/ABORTED path looks like it also has the same problem, but it's not.
Because all pages in the XDP_DROP/ABORTED path are not used anywhere it
can be reused without any free and unmap.
So, it's okay to remove the function in the xdp path.

I will send a separated patch for removing ionic_rx_page_free() in the
xdp path.

 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 26 +++++++++++++++----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 2427610f4306..792e530e3281 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -487,14 +487,13 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 			  struct ionic_buf_info *buf_info,
 			  int len)
 {
+	int remain_len, frag_len, i, err = 0;
+	struct skb_shared_info *sinfo;
 	u32 xdp_action = XDP_ABORTED;
 	struct xdp_buff xdp_buf;
 	struct ionic_queue *txq;
 	struct netdev_queue *nq;
 	struct xdp_frame *xdpf;
-	int remain_len;
-	int frag_len;
-	int err = 0;
 
 	xdp_init_buff(&xdp_buf, IONIC_PAGE_SIZE, rxq->xdp_rxq_info);
 	frag_len = min_t(u16, len, IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN);
@@ -513,7 +512,6 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 	 */
 	remain_len = len - frag_len;
 	if (remain_len) {
-		struct skb_shared_info *sinfo;
 		struct ionic_buf_info *bi;
 		skb_frag_t *frag;
 
@@ -576,7 +574,6 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 
 		dma_unmap_page(rxq->dev, buf_info->dma_addr,
 			       IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
-
 		err = ionic_xdp_post_frame(txq, xdpf, XDP_TX,
 					   buf_info->page,
 					   buf_info->page_offset,
@@ -587,12 +584,22 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 			goto out_xdp_abort;
 		}
 		buf_info->page = NULL;
+		if (xdp_frame_has_frags(xdpf)) {
+			for (i = 0; i < sinfo->nr_frags; i++) {
+				buf_info++;
+				dma_unmap_page(rxq->dev, buf_info->dma_addr,
+					       IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
+				buf_info->page = NULL;
+			}
+		}
+
 		stats->xdp_tx++;
 
 		/* the Tx completion will free the buffers */
 		break;
 
 	case XDP_REDIRECT:
+		xdpf = xdp_convert_buff_to_frame(&xdp_buf);
 		/* unmap the pages before handing them to a different device */
 		dma_unmap_page(rxq->dev, buf_info->dma_addr,
 			       IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
@@ -603,6 +610,15 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 			goto out_xdp_abort;
 		}
 		buf_info->page = NULL;
+		if (xdp_frame_has_frags(xdpf)) {
+			for (i = 0; i < sinfo->nr_frags; i++) {
+				buf_info++;
+				dma_unmap_page(rxq->dev, buf_info->dma_addr,
+					       IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
+				buf_info->page = NULL;
+			}
+		}
+
 		rxq->xdp_flush = true;
 		stats->xdp_redirect++;
 		break;
-- 
2.34.1


