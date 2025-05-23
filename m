Return-Path: <netdev+bounces-192975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F64AC1E3B
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 10:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 757677B8AD0
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 08:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1D8286D6E;
	Fri, 23 May 2025 08:05:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630ED289344
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747987557; cv=none; b=SKXbBi6SOWGwE6vOSlxd+/MERTUJFkrfmbR4YhuAxfa0KR6DOibFyXB2PEzg4vne7Iwrn4R8UVclCDfH2DHOx4Lto9tMzbo3TCuIwj4lpFH+N9P6L52CpTGjuvFWOCq+i+dCk7GjCqDE0d/ZKQX3m8V2J4MWvEXOAFSlDYBbEwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747987557; c=relaxed/simple;
	bh=m/70Ndmj0aEr6ohUSaKccKLgoLUh2A+tMVysDdEDyIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A/DjSOgyTxPlmXLPEi+CLZq4dUjiy9vWMFIFqvP8lvTRLAB+paZ1U1MK4PlQEQqVjT05QU36cUV66S7P/pcWGuX7WApwNhUmcjIwrw7dRrImhDs0Lj6xR7hvVu3GZ+EYXSDqrQPMm7m87moYl/bHGQrpn4ML+4yz+e95VegyoH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz2t1747987499t645a91fa
X-QQ-Originating-IP: X6mE/5ZsFJEx6e7pxzfR9XxZZ1BNP4Vhp+Mb4uzLkT0=
Received: from w-MS-7E16.trustnetic.com ( [125.120.71.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 23 May 2025 16:04:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4135908724909295465
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 1/2] net: libwx: Fix statistics of multicast packets
Date: Fri, 23 May 2025 16:04:37 +0800
Message-ID: <F70910CFE86C1F6F+20250523080438.27968-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Nj32X60U+bRE6s12X6LMG6rzuJPDQ7/FTvaYwK/3Lxn0O/NUi9z8Zid1
	p2l6doovXnpha0MgTJBJqku1kZCPOPTDXSxDk79EyWmGfdCtNF1flmmDl7G+vUhSx+0cSAG
	R5TN4dVMpLpvXNCPpTFHnUs3UzHvgav2AuJMAXsOstYGsSStU9GS2RGxZBFsjU5n64sAUeD
	AKTQIDNIsKQTphWjg3GIrVgBDZ5b9HJXIllDSW+jP4gOOMjiuw5+Dv33UbkRKC52TI2dYiR
	V3o6aTQKf0OVFPc1Uty5ORTOJLdewCQVTHR00QENa99xl0s9qGHmOTtYr+L2EoQs9AQg4Kd
	3UqJfPGzL6uEB5DAJKli3DBaR04LQ+bAYisrZd44V0ld2KoWn+EtqFrRBUG+iIewIMYQSUe
	ZUPwjwbsZ8hr8eQLmc23r7pybWQyqMOYSJdLpa3zKS+QPiWKUMVS8WdCVzyBPbiVjoyUJB3
	qW3LZkUZbG01zs/SPncHVKPcrkJjTcEZpXLD1gEdpwPbmiEZeJ6ijPHsNqJ9ZaXlnlNuzqR
	4YzF8J3U9glIvH0fr9Xrlt/siZ1FtleXjg/L2ZCrzpq9AC7W/UBFeEdL9RYKe1bDoJeqn2s
	BOO00WdBk/LsY5et5IbuIqQLMtMK2YzH6DiZ2MZvi4sOvIFr/OT+/F0VqvFrdMR0kjb0I9n
	vli36V6Gu18K5s+FFt22pu7zHyJ7UGVvgnQng4+2NzThxJ4Kvz2ZJH3i5E2UkAJhfHYJdsn
	PYucisrMuP1klcvPzurhX1HviIikYPMP3LQpubLlPPGzZ3BmDT/uQxZPp5QarzOWe5zbNG0
	l39l40PzDk8D6zQj9dapGTkxbOzSrttsSYYEwsGqtZdS1yJj9zGIf81/VymWHBDfRV1ag+n
	zKXPn0G01TYpo64S+L1mPaehYCf+YCGNqKpWNO7ajct8g4EBMsAynzWlkp8CDWJgcWtMf8A
	h8s8pAOW5JvPrg7rRU0wNN8tiCp+meKGCQM90XlHYhLFca1syCvrKLZaqYCBL7sr4haL68R
	iHtONxGjJBEOtZlErJeyNGpmxP9bT2rU34xb99DGudr+sLE8bOZohcV8YK6D8M2WnEZCezc
	w==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

When SR-IOV is enabled, the number of multicast packets is mistakenly
counted starting from queue 0. It would be a wrong count that includes
the packets received on VF. Fix it to count from the correct offset.

Fixes: c52d4b898901 ("net: libwx: Redesign flow when sriov is enabled")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 143cc1088eea..17ff3c21539a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2792,7 +2792,8 @@ void wx_update_stats(struct wx *wx)
 		hwstats->fdirmiss += rd32(wx, WX_RDB_FDIR_MISS);
 	}
 
-	for (i = 0; i < wx->mac.max_rx_queues; i++)
+	for (i = wx->num_vfs * wx->num_rx_queues_per_pool;
+	     i < wx->mac.max_rx_queues; i++)
 		hwstats->qmprc += rd32(wx, WX_PX_MPRC(i));
 }
 EXPORT_SYMBOL(wx_update_stats);
-- 
2.48.1


