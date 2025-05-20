Return-Path: <netdev+bounces-191731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EABBCABCF84
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 08:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2923A5A06
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 06:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E9E25D203;
	Tue, 20 May 2025 06:40:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDFE2561D1
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 06:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747723202; cv=none; b=oheBn2APDv39GIlOFW04Cxpe1U2SazLmmS4gIzya6IKGz1jbS9+igLstW53M5hwpIK8sGDI8k/SNIgdEtZ7DZIx2FzjY9dSga7oGvVE38ihb7j0POQgSA37fvT+8kyf0LLNIiNeZGvKTZctM7TEbN3MowpmwuDWMdmHrt/SKBrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747723202; c=relaxed/simple;
	bh=br2jlz+Rrk6dx5ODQElqj8HJSQkkbvn5NxLmvN3JgY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7+tGewC6e6Ax9AyAs4405p/HkIiXEJuir3bMvMDUOtjX6qtCJ+eMNBwS/vFhGzxOLjgzD36j2GlFiegSkgbRITZZjpy17QJG0qq9wYrRCiRtiR7hK1THZB8IsnwVwtyPMFkVAr3SOrHTKFHZXQtUhrlhlPrROfURNslpqH7lgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz16t1747723156t031523b9
X-QQ-Originating-IP: FqbgjK/fZn6h1JGiIssIBTyznEwccwYhOt6S8gCE0jo=
Received: from w-MS-7E16.trustnetic.com ( [125.119.67.87])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 20 May 2025 14:39:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16825404772766257503
EX-QQ-RecipientCnt: 8
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	mengyuanlou@net-swift.com
Cc: Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 2/2] net: txgbe: Support the FDIR rules assigned to VFs
Date: Tue, 20 May 2025 14:39:00 +0800
Message-ID: <38C9EBBEE8FCE61E+20250520063900.37370-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250520063900.37370-1-jiawenwu@trustnetic.com>
References: <20250520063900.37370-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NRfl6k/eYe7AaYidOh4miUqPvgr4daCD6IRQ3ohjJTlvXlNluTs9d3iU
	z2y4xb5eDTIrdZupA2LdLVL8WQedd5bSGQULJ20O1nIhiC0qbHvNvKcKj/k2vGBhm2yYItn
	tldALQAjrSI2ChUOvNv6lKtoJTIxab4wh74qkzZrfaUys7O69jG3nhBVQzlkjkDgO1AlBRD
	vESkNffbto5qBlqzCLrpSTZrXIBPKWcqgYtFNZQm5TI6VsiqW4Gl3I2gcPol2UDRNzo6Ymq
	/APNp714TSNpRSG+GTnwhHVEV92cXLwnISlzv94o4hTwOT3/xhhT3uEJ+xCddd1PpPSSV1Y
	8aAdyMT+mm7YO6Od548lOEGwCPfccGvJgM8LsH2BAQ6X3ccxN3tq2n456Q36ge5b0OH4oQj
	UFEBO5mOBZD5wl4p8JQk55S+omdwRBq/hInJJuRWrfKVU5lxto6nhIwuyiEzZwknxDXCVes
	638HzEegC9+h8JYP1Kp6KXs+3uIShU2jpYljqkVVVtkx+dy6TFveIMZspinXmpObOA1CVL9
	7z67r/aJXMIyrvnU9LGwJG0IPvH8bJCP7eIjFEURGoHBsw67XxfEJblbbv28kwpYDsbXJBc
	y8lfVufXcMlgBMwkt8ns8WnpLrH645BVO6Zp4zH021430wwuEdS3UqnjlAGBWNhv3uWddzP
	uN8dYDaPW+gQHCBSXhxSbhIq5dMH8HvPJJ821RFDWQ8CtlIdwtPYaUQ/g7SImPY8G5w4v8u
	9gnn5HH4AnGocULDmPuGIK3GJfpP4JedSQPrkGWFJPkYrMwq/Ahqo3XPzPxmTtVkO41hEVT
	t07WK3yeSLccfr6LIa3P3jt4gvQfZa4kLEhfi1yG790I9JU74P9ln/ygxRaQaRXLiYqweng
	4fpoW8i8VoK/lEjGvdD2h1zKQHUr2bdChfXFxFR7h6qjsF9jY6fSUoXzsneRc3OaxrhLVo0
	rArl5h9FZh/+n92LL8gcusj5KxagE4LAKulSINpookb5ED/4wOLQeomLQzGz/YUxO1NOqTy
	T2hJmr8nZNfacVbLfPlmuyGx9O2bs=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

When SR-IOV is enabled, the FDIR rule is supported to filter packets to
VFs. The action queue id is calculated as an absolute id.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
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
index ef50efbaec0f..d542c8a5a689 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
@@ -307,6 +307,7 @@ void txgbe_atr(struct wx_ring *ring, struct wx_tx_buffer *first, u8 ptype)
 int txgbe_fdir_set_input_mask(struct wx *wx, union txgbe_atr_input *input_mask)
 {
 	u32 fdirm = 0, fdirtcpm = 0, flex = 0;
+	int i, j;
 
 	/* Program the relevant mask registers. If src/dst_port or src/dst_addr
 	 * are zero, then assume a full mask for that field.  Also assume that
@@ -352,15 +353,17 @@ int txgbe_fdir_set_input_mask(struct wx *wx, union txgbe_atr_input *input_mask)
 	/* Now mask VM pool and destination IPv6 - bits 5 and 2 */
 	wr32(wx, TXGBE_RDB_FDIR_OTHER_MSK, fdirm);
 
-	flex = rd32(wx, TXGBE_RDB_FDIR_FLEX_CFG(0));
-	flex &= ~TXGBE_RDB_FDIR_FLEX_CFG_FIELD0;
+	i = VMDQ_P(0) / 4;
+	j = VMDQ_P(0) % 4;
+	flex = rd32(wx, TXGBE_RDB_FDIR_FLEX_CFG(i));
+	flex &= ~(TXGBE_RDB_FDIR_FLEX_CFG_FIELD0 << (j * 8));
 	flex |= (TXGBE_RDB_FDIR_FLEX_CFG_BASE_MAC |
-		 TXGBE_RDB_FDIR_FLEX_CFG_OFST(0x6));
+		 TXGBE_RDB_FDIR_FLEX_CFG_OFST(0x6)) << (j * 8);
 
 	switch ((__force u16)input_mask->formatted.flex_bytes & 0xFFFF) {
 	case 0x0000:
 		/* Mask Flex Bytes */
-		flex |= TXGBE_RDB_FDIR_FLEX_CFG_MSK;
+		flex |= TXGBE_RDB_FDIR_FLEX_CFG_MSK << (j * 8);
 		break;
 	case 0xFFFF:
 		break;
@@ -368,7 +371,7 @@ int txgbe_fdir_set_input_mask(struct wx *wx, union txgbe_atr_input *input_mask)
 		wx_err(wx, "Error on flexible byte mask\n");
 		return -EINVAL;
 	}
-	wr32(wx, TXGBE_RDB_FDIR_FLEX_CFG(0), flex);
+	wr32(wx, TXGBE_RDB_FDIR_FLEX_CFG(i), flex);
 
 	/* store the TCP/UDP port masks, bit reversed from port layout */
 	fdirtcpm = ntohs(input_mask->formatted.dst_port);
@@ -516,14 +519,16 @@ static void txgbe_fdir_enable(struct wx *wx, u32 fdirctrl)
 static void txgbe_init_fdir_signature(struct wx *wx)
 {
 	u32 fdirctrl = TXGBE_FDIR_PBALLOC_64K;
+	int i = VMDQ_P(0) / 4;
+	int j = VMDQ_P(0) % 4;
 	u32 flex = 0;
 
-	flex = rd32(wx, TXGBE_RDB_FDIR_FLEX_CFG(0));
-	flex &= ~TXGBE_RDB_FDIR_FLEX_CFG_FIELD0;
+	flex = rd32(wx, TXGBE_RDB_FDIR_FLEX_CFG(i));
+	flex &= ~(TXGBE_RDB_FDIR_FLEX_CFG_FIELD0 << (j * 8));
 
 	flex |= (TXGBE_RDB_FDIR_FLEX_CFG_BASE_MAC |
-		 TXGBE_RDB_FDIR_FLEX_CFG_OFST(0x6));
-	wr32(wx, TXGBE_RDB_FDIR_FLEX_CFG(0), flex);
+		 TXGBE_RDB_FDIR_FLEX_CFG_OFST(0x6)) << (j * 8);
+	wr32(wx, TXGBE_RDB_FDIR_FLEX_CFG(i), flex);
 
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


