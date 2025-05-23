Return-Path: <netdev+bounces-192976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ED4AC1E3C
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 10:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 816C07BBC87
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 08:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE4D289364;
	Fri, 23 May 2025 08:05:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BA92F41
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747987558; cv=none; b=XGpjp3lM/BJ/JkbJqHRPtyoIyRpvBEnEpwITEnxlsPATNL3MGbA+U9QrgobS6g8rZ75sOBU+79ATvgNaqfVm58mfEJkc0fwU3rYqovnQSm/XFGs0FPcNJOLQJ1X+XDRMQfNgJOg/Sl8T0D/LnWt8qsQcJ5hQoPsmzQaWB01Ux3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747987558; c=relaxed/simple;
	bh=KF8cZcqVSQmJA8aad2lOLuyUXjmW8Tj+HQjNBD6AFqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fq3XRUHf1Rx46twYhmS5+R05DHyfDvGXriPnNeUsburFy2ibSWY3uhBRmvx+/FwffEmjWasECFOzZEhSC3ITyIjuD9LFG2Dd9RQ3p1y1uIYVDxLteaaG3D8mBin4DFlj10krinyD4MOsxlwOrOGTioYINYV1eYxjwDuG+01Sh3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz2t1747987502tcb197947
X-QQ-Originating-IP: IDAfcZlKW7jIIukZAM6B4EfeFycR1wLHY8kT3F8+8JA=
Received: from w-MS-7E16.trustnetic.com ( [125.120.71.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 23 May 2025 16:05:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18297110320833851980
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
Subject: [PATCH net-next v2 2/2] net: txgbe: Support the FDIR rules assigned to VFs
Date: Fri, 23 May 2025 16:04:38 +0800
Message-ID: <BE7EA355FDDAAA97+20250523080438.27968-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250523080438.27968-1-jiawenwu@trustnetic.com>
References: <20250523080438.27968-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NPwdxSKNG61XJz5S0CB/yyALxtMdlcrsL+t2d3Ug9Cz68m9S1TAWeZCQ
	wq5wox3YpxZJGAPUJOlitcgluNvg/COZ6/1a8225pUtytcn1cWB+rY7ZXykHkK0+cyqXKeW
	F+717vKUd+jok/GeQ5OgKIwLQahN7Jws+HG5bPFTAhHDoZ+rMnuYn3hNVr48bbgu1Geua7B
	paYQd0+A069fT3yj8ro1pZkqvEEBpbiwZzX/p+HNEFDyg9A/oaviFu9xOutFZwsiSsLKxtI
	YNWGBfcE5HvY8Y3uwXwCdbEUElM9X7JoGEXEnr1pTw/VwVLwPTTzai+/lfAGOZP7ulKRaWM
	VjZhCtAQvckBUoAqgc2n3r2bS5kKSzOVbXFnCGvC9k4FlzQQNMbPDkyEhMqSxSCAenzhVru
	GzCratX7l5ipBF3lP2d5iNccS14ZIuaX97nSocL4XjFnoIGI7aXMBMlfvkoYIFMPd4hXBgf
	VgrRw3iP4G5YTwUCvgqGSK2TyMaXePA3PMRxqGptaLfY5xMYQ4bYMSPRjaySIPFW5uLYOs2
	KJ6uOCaHC02UJ/Q06qbhEzj4meAwfGoxnUS6045KNJFofVvxaoGQoZokqqzD6Mi8mKxQxIU
	3GWdn1vkx4gNH+OsUL4o2q/m+Kj2eySgNylAiBXYkFhiSo4ZMQeZlBbD9K+nhrMLTbCmo7O
	F6Zz6MU8A8AB+BQUbQxlCn+FfrehSQyoZYHk7VxpJIsjziQ+1qg/+BBBAH/HqCnQ0vuDuXh
	Xw8khzVKYwecMkm4lGMiGyQW8ucSO2bjghQ3xTIXiBPC+iBQVQJJyD+3vANmkSTXFc7Fm4H
	b4qMF0GpJV77AuEeGfUb1IYKUDK0sG9nktXgy5QU+GccWl4IRndBujIIp4o1ENhgkIk5dGV
	lA/1EYLVgl0SA7kvtcjIglFi1f2w4jL7dfSGSC/LVun8/wN4xL4K9I5YfjACF7ZM3eNMCiM
	Y0Rs/eFaDyt+oFTT/7b2Z4aUc8GUcE5uw22BcHAUWuj7VjfeRJ+XziK0IhSw9q7PAp+ZcYC
	5dbBMoOSkaZ3MjG9L/yrlPv8S87K344plsfxz6Lw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

When SR-IOV is enabled, the FDIR rule is supported to filter packets to
VFs. The action queue id is calculated as an absolute id.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
v1 -> v2:
- Rename i and j to index and offset
---
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 11 +++++++--
 .../net/ethernet/wangxun/txgbe/txgbe_fdir.c   | 23 +++++++++++--------
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  2 +-
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index 78999d484f18..23af099e0a90 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -342,12 +342,19 @@ static int txgbe_add_ethtool_fdir_entry(struct txgbe *txgbe,
 		queue = TXGBE_RDB_FDIR_DROP_QUEUE;
 	} else {
 		u32 ring = ethtool_get_flow_spec_ring(fsp->ring_cookie);
+		u8 vf = ethtool_get_flow_spec_ring_vf(fsp->ring_cookie);
 
-		if (ring >= wx->num_rx_queues)
+		if (!vf && ring >= wx->num_rx_queues)
+			return -EINVAL;
+		else if (vf && (vf > wx->num_vfs ||
+				ring >= wx->num_rx_queues_per_pool))
 			return -EINVAL;
 
 		/* Map the ring onto the absolute queue index */
-		queue = wx->rx_ring[ring]->reg_idx;
+		if (!vf)
+			queue = wx->rx_ring[ring]->reg_idx;
+		else
+			queue = ((vf - 1) * wx->num_rx_queues_per_pool) + ring;
 	}
 
 	/* Don't allow indexes to exist outside of available space */
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
index ef50efbaec0f..a84010828551 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
@@ -307,6 +307,7 @@ void txgbe_atr(struct wx_ring *ring, struct wx_tx_buffer *first, u8 ptype)
 int txgbe_fdir_set_input_mask(struct wx *wx, union txgbe_atr_input *input_mask)
 {
 	u32 fdirm = 0, fdirtcpm = 0, flex = 0;
+	int index, offset;
 
 	/* Program the relevant mask registers. If src/dst_port or src/dst_addr
 	 * are zero, then assume a full mask for that field.  Also assume that
@@ -352,15 +353,17 @@ int txgbe_fdir_set_input_mask(struct wx *wx, union txgbe_atr_input *input_mask)
 	/* Now mask VM pool and destination IPv6 - bits 5 and 2 */
 	wr32(wx, TXGBE_RDB_FDIR_OTHER_MSK, fdirm);
 
-	flex = rd32(wx, TXGBE_RDB_FDIR_FLEX_CFG(0));
-	flex &= ~TXGBE_RDB_FDIR_FLEX_CFG_FIELD0;
+	index = VMDQ_P(0) / 4;
+	offset = VMDQ_P(0) % 4;
+	flex = rd32(wx, TXGBE_RDB_FDIR_FLEX_CFG(index));
+	flex &= ~(TXGBE_RDB_FDIR_FLEX_CFG_FIELD0 << (offset * 8));
 	flex |= (TXGBE_RDB_FDIR_FLEX_CFG_BASE_MAC |
-		 TXGBE_RDB_FDIR_FLEX_CFG_OFST(0x6));
+		 TXGBE_RDB_FDIR_FLEX_CFG_OFST(0x6)) << (offset * 8);
 
 	switch ((__force u16)input_mask->formatted.flex_bytes & 0xFFFF) {
 	case 0x0000:
 		/* Mask Flex Bytes */
-		flex |= TXGBE_RDB_FDIR_FLEX_CFG_MSK;
+		flex |= TXGBE_RDB_FDIR_FLEX_CFG_MSK << (offset * 8);
 		break;
 	case 0xFFFF:
 		break;
@@ -368,7 +371,7 @@ int txgbe_fdir_set_input_mask(struct wx *wx, union txgbe_atr_input *input_mask)
 		wx_err(wx, "Error on flexible byte mask\n");
 		return -EINVAL;
 	}
-	wr32(wx, TXGBE_RDB_FDIR_FLEX_CFG(0), flex);
+	wr32(wx, TXGBE_RDB_FDIR_FLEX_CFG(index), flex);
 
 	/* store the TCP/UDP port masks, bit reversed from port layout */
 	fdirtcpm = ntohs(input_mask->formatted.dst_port);
@@ -516,14 +519,16 @@ static void txgbe_fdir_enable(struct wx *wx, u32 fdirctrl)
 static void txgbe_init_fdir_signature(struct wx *wx)
 {
 	u32 fdirctrl = TXGBE_FDIR_PBALLOC_64K;
+	int index = VMDQ_P(0) / 4;
+	int offset = VMDQ_P(0) % 4;
 	u32 flex = 0;
 
-	flex = rd32(wx, TXGBE_RDB_FDIR_FLEX_CFG(0));
-	flex &= ~TXGBE_RDB_FDIR_FLEX_CFG_FIELD0;
+	flex = rd32(wx, TXGBE_RDB_FDIR_FLEX_CFG(index));
+	flex &= ~(TXGBE_RDB_FDIR_FLEX_CFG_FIELD0 << (offset * 8));
 
 	flex |= (TXGBE_RDB_FDIR_FLEX_CFG_BASE_MAC |
-		 TXGBE_RDB_FDIR_FLEX_CFG_OFST(0x6));
-	wr32(wx, TXGBE_RDB_FDIR_FLEX_CFG(0), flex);
+		 TXGBE_RDB_FDIR_FLEX_CFG_OFST(0x6)) << (offset * 8);
+	wr32(wx, TXGBE_RDB_FDIR_FLEX_CFG(index), flex);
 
 	/* Continue setup of fdirctrl register bits:
 	 *  Move the flexible bytes to use the ethertype - shift 6 words
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 261a83308568..094d55cdb86c 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -272,7 +272,7 @@ struct txgbe_fdir_filter {
 	struct hlist_node fdir_node;
 	union txgbe_atr_input filter;
 	u16 sw_idx;
-	u16 action;
+	u64 action;
 };
 
 /* TX/RX descriptor defines */
-- 
2.48.1


