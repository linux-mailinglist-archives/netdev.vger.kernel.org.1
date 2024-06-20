Return-Path: <netdev+bounces-105210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804C5910208
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479A51C208E8
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 10:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2745515A49F;
	Thu, 20 Jun 2024 10:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNy/z8da"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E223BBF5
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718881118; cv=none; b=QURoMuaJqpYZBl+A/W+wq1lF2VJKqUp7OKhvhpnZ7G5TMDeeWR5KNSzfrmses/BeoZCICWuZ5aZuG7hi8P0MAm33e1nlzy4oNiFBYWCYerNwxiGp6Y4qGO2p9CtohGA6pBKlkRCW8c6wHpS+vbHz+JVt2rg1b8RLVqicom+qfYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718881118; c=relaxed/simple;
	bh=FoUdsNUpPXCF3NWfQYEuRmWJ4v+PXTfG14TYQ511a3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kvMv7+I9GpjHuiwGkiYIJLpMImFS4aw+fnMyQGKELYlqTf33xqfsoY63iDPf7km//pNclMMiwt4B6b/MSc3gHmi1RXwyGUypaZLD5ujLTgxX7BQFo30MiKWvv9t5mek9+ZKBINpWmAq2DOHd4ohq3T6KWcA9A0FfylmZVuLr974=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNy/z8da; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d35f1dfda2so357887b6e.3
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 03:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718881115; x=1719485915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bPn1X48wjcIxA95LYBJxQRxyt11kb9I3EwWwDedgJXA=;
        b=iNy/z8daiVa/s5YcfU43RdkYmnjUStJiO1cVsutmPSWl4rAFiMKmb98TidVIq0QQr2
         cs/B6eOMtinQj53yOL5bW453DLg7MpyvvBUqRLRsnF2XLeoUKEjaRWNJPQ0rnUfKEREW
         f+VeZ/nq5oo9Fh2HMhhW3EDFt4MzmXQwcQfgWiLfgnxTJwUVxrBwGPTvGaau+zdzGtvs
         0/te8/2u/1upQp4EEi/Zbrzr8xCUrmwEuMiXZXRTZsDEql2jcOxYRfnCf6qDqelqjPWx
         bJ68o1vxHVk1COpzW5UqaDA68BGCIsc4YH/UT5/0FQ5XwGWq3tOvFrTby/wd1lN5k+Rx
         PFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718881115; x=1719485915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPn1X48wjcIxA95LYBJxQRxyt11kb9I3EwWwDedgJXA=;
        b=q28gGaBBPfAcb99I5FSLZZUe72roc/wkslRch8Ufi9TXsA287Ktqi7LRmYrgaX1A/8
         KnhpGR9/fwMxIFj1SMn9J0cdUUOj7I+Zd1x2nu2Y1bePE/ONQmi8um2SI8EUh9Uo7jS3
         I255ALTu6HygTk3o5XxSreKJBbVw1v9nJHJMVPJdzeEf64Id1/xe5OztfFjdWXxFN729
         F8+85tvs4XMbVKhXZ7RAD4XF1SP0RgieOcvFUI5240IWzr3XETwMF4E4sV9xYejHTm99
         AHkamQ7vpUjhIb9oh5Cm2THjwQCisoTbVsdI5NmYP0oGqSP4srCBB6P/2I4Z8UIUh2ja
         t/tw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ0DPp/gKTCqa6jnWWAVF0c2Cx4V+eTA2znYrTlQlRZbrna9HMNKEYiEhd3yH/N9jO4+9N+Fzdp7TeftCddTwjVJ8oOPBs
X-Gm-Message-State: AOJu0YwQRemlmpZCSPizYiuYPul6s1Ui3N1XoJogcDafcWrXPoSDA9kM
	VgH/RWXXnKqDv0zJp80PXxtpFKYElu+iTBtazzxXfTO9tVOW0sRL
X-Google-Smtp-Source: AGHT+IFUAmnqJwFYWDkJVLRNCRSWuQ+G98buLoZGOyua44x4jtn4ogSOtladHI+m+wyd90yhf6waaA==
X-Received: by 2002:a05:6871:3a23:b0:254:94a4:35d0 with SMTP id 586e51a60fabf-25c94d5ae1cmr5247032fac.48.1718881115460;
        Thu, 20 Jun 2024 03:58:35 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb4a830sm12070396b3a.128.2024.06.20.03.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:58:34 -0700 (PDT)
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
Subject: [PATCH net v2] ionic: fix kernel panic due to multi-buffer handling
Date: Thu, 20 Jun 2024 10:58:08 +0000
Message-Id: <20240620105808.3496993-1-ap420073@gmail.com>
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

v2:
 - Use ionic_xdp_rx_put_bufs() instead of open code.

 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 27 ++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 2427610f4306..aed7d9cbce03 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -480,6 +480,20 @@ int ionic_xdp_xmit(struct net_device *netdev, int n,
 	return nxmit;
 }
 
+static void ionic_xdp_rx_put_bufs(struct ionic_queue *q,
+				  struct ionic_buf_info *buf_info,
+				  int nbufs)
+{
+	int i;
+
+	for (i = 0; i < nbufs; i++) {
+		dma_unmap_page(q->dev, buf_info->dma_addr,
+			       IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
+		buf_info->page = NULL;
+		buf_info++;
+	}
+}
+
 static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 			  struct net_device *netdev,
 			  struct bpf_prog *xdp_prog,
@@ -493,6 +507,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 	struct netdev_queue *nq;
 	struct xdp_frame *xdpf;
 	int remain_len;
+	int nbufs = 1;
 	int frag_len;
 	int err = 0;
 
@@ -542,6 +557,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 			if (page_is_pfmemalloc(bi->page))
 				xdp_buff_set_frag_pfmemalloc(&xdp_buf);
 		} while (remain_len > 0);
+		nbufs += sinfo->nr_frags;
 	}
 
 	xdp_action = bpf_prog_run_xdp(xdp_prog, &xdp_buf);
@@ -574,9 +590,6 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 			goto out_xdp_abort;
 		}
 
-		dma_unmap_page(rxq->dev, buf_info->dma_addr,
-			       IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
-
 		err = ionic_xdp_post_frame(txq, xdpf, XDP_TX,
 					   buf_info->page,
 					   buf_info->page_offset,
@@ -586,23 +599,19 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 			netdev_dbg(netdev, "tx ionic_xdp_post_frame err %d\n", err);
 			goto out_xdp_abort;
 		}
-		buf_info->page = NULL;
+		ionic_xdp_rx_put_bufs(rxq, buf_info, nbufs);
 		stats->xdp_tx++;
 
 		/* the Tx completion will free the buffers */
 		break;
 
 	case XDP_REDIRECT:
-		/* unmap the pages before handing them to a different device */
-		dma_unmap_page(rxq->dev, buf_info->dma_addr,
-			       IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
-
 		err = xdp_do_redirect(netdev, &xdp_buf, xdp_prog);
 		if (err) {
 			netdev_dbg(netdev, "xdp_do_redirect err %d\n", err);
 			goto out_xdp_abort;
 		}
-		buf_info->page = NULL;
+		ionic_xdp_rx_put_bufs(rxq, buf_info, nbufs);
 		rxq->xdp_flush = true;
 		stats->xdp_redirect++;
 		break;
-- 
2.34.1


