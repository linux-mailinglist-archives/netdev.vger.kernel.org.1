Return-Path: <netdev+bounces-179569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B17A7DABD
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 12:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782BB1685D6
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 10:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F3A218AD4;
	Mon,  7 Apr 2025 10:09:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792682E62B0
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 10:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744020561; cv=none; b=ah63pFbQWwfDMiyMWt8JHEV6tbG1KdraZNdJxdEKEYiB+jCu0P2Ja1S9I9o0emS5c0/x7UxOUSsRJQmQ+//nCeai/kEzH6PHqk6WYy6DtCICZ5i5XZACDLDy/ieQztoMhGdpZ0QZpE6d6EnPqSHJYkpoWYHkGJvRgdP73tymeNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744020561; c=relaxed/simple;
	bh=iSwUo8kqvIxqjk5UDpVlHbu/d6FY3MDaf8bH/oJdacA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EBapCCX+M9gFxgvnb/fjwx4TFvGN1YDg0wpLXchJoROfwVWZ6lRhIEw9xrusH8nIGcKj3pr/dapsziw0pdDfPcDgajj28drxlGnvZrwtD4ycshN7jI7YQzKFvru/RancG+SvP7Q4VvByDfkuwv091Yk3qoyNqQT2OinpHol6itQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp88t1744020455ta43f7a4
X-QQ-Originating-IP: yRmRNr7439v4JUIphHqr3T5fRshATtu616eeZytxH6Y=
Received: from wxdbg.localdomain.com ( [183.159.168.74])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 07 Apr 2025 18:07:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6583926108883719568
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net] net: libwx: Fix the wrong Rx descriptor field
Date: Mon,  7 Apr 2025 18:33:22 +0800
Message-Id: <20250407103322.273241-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N3IC8um5pMyYD/1NJKPhN2QaC5YVzi/bCL3bSCrrHpGmEl6ufOXEzD86
	B1vamd+q3exR4R2T8LaUMNeFVzsz78oGXNNzH1PiyyEecfuK8CzuZ8j+LLNlUOKVRzzjSg+
	EBTGCUS+gic5u94fvhUGEtHqsvNRZml0/8rPN/7F2i5GGlzDg0Id9oych/U8/Dij/Rf6IIr
	pdybwG7EBokJ4ZE1G7UMFaI0DXUaOpnpA0+pOPC/YYbgPyyGXdC+itRHIIV87G2BnpOiLcC
	O1clKlS5QEuw8qDMhg62HddRcNVCHLfGQ3TWetImJMpQN3WXZzTD7RK/j5HHSEQVD9yJoVt
	ph/ty/VgiTqpR50iFr2x640c07DQFsv1LmQ+DRo/xD6i5MkSCIzIq+j61Bd+fdwSuP8UUJc
	+GHmNbp+XZjLd8sr0bqWYb3PC4fEaj0uNF9WIp7vu7rj5yn2bahcVRXmZeZGoddy+cT2zem
	Cqaew2zq65em+0hpE9xYl9C+m6Xb9ScNdNmWtKae2Kmi0ArUDyF4sxjOvZT5b/NdYwCrQ2e
	QkKQAn2QlxKJ0giqTnEYX8Rv+lLEIAq3puO+alX4pKtfkP8/6Mwf7PvaXOOf0PC3ANqD14i
	3vgUZ71vFRk8HWCo2cktblzss4onrk9xWS44TAU6K7Ur/vbYlYcD5yd7yLlAhCvz6Xt9AM5
	ECpEOXHdsfznEAopmwfV/qx9WLF2VA7JvxzUdeurHQwJfGVGelJg7stA1oOpvlW8YjWGxqb
	RNBoeBFvTShFkgOyfjhL+Lhzo1Tab7OPN9w+It5ebDPVkjqz5xj0d/UTfUnE1SAHM3UtgOn
	8xJlUe4HIKYgmbQszAa2dg1NO6hgjRNV9mYA3rz9SnAcdAg10tpVoUodjD7nLkVDGeN63FK
	8aS19gmanojLvaZqqrhInyHH1YeqE48agqn7jQO3Z2UuJFRdk5L7d9vAoPeSL/JKrX4Bl6J
	2HWNMhrY6bsTx+1VBZnGGSaFEqmo4zLUNqWVbDL61Hv8M7XUf80Rw8CoU5KvdZCKM+Log7O
	Od9hfdRw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

WX_RXD_IPV6EX was incorrectly defined in Rx ring descriptor. In fact, this
field stores the 802.1ad ID from which the packet was received. The wrong
definition caused the statistics rx_csum_offload_errors to fail to grow
when receiving the 802.1ad packet with incorrect checksum.

Fixes: ef4f3c19f912 ("net: wangxun: libwx add rx offload functions")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c  | 3 ++-
 drivers/net/ethernet/wangxun/libwx/wx_type.h | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 00b0b318df27..6ebefa31ece1 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -546,7 +546,8 @@ static void wx_rx_checksum(struct wx_ring *ring,
 		return;
 
 	/* Hardware can't guarantee csum if IPv6 Dest Header found */
-	if (dptype.prot != WX_DEC_PTYPE_PROT_SCTP && WX_RXD_IPV6EX(rx_desc))
+	if (dptype.prot != WX_DEC_PTYPE_PROT_SCTP &&
+	    wx_test_staterr(rx_desc, WX_RXD_STAT_IPV6EX))
 		return;
 
 	/* if L4 checksum error */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 5b230ecbbabb..4c545b2aa997 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -513,6 +513,7 @@ enum WX_MSCA_CMD_value {
 #define WX_RXD_STAT_L4CS             BIT(7) /* L4 xsum calculated */
 #define WX_RXD_STAT_IPCS             BIT(8) /* IP xsum calculated */
 #define WX_RXD_STAT_OUTERIPCS        BIT(10) /* Cloud IP xsum calculated*/
+#define WX_RXD_STAT_IPV6EX           BIT(12) /* IPv6 Dest Header */
 #define WX_RXD_STAT_TS               BIT(14) /* IEEE1588 Time Stamp */
 
 #define WX_RXD_ERR_OUTERIPER         BIT(26) /* CRC IP Header error */
@@ -589,8 +590,6 @@ enum wx_l2_ptypes {
 
 #define WX_RXD_PKTTYPE(_rxd) \
 	((le32_to_cpu((_rxd)->wb.lower.lo_dword.data) >> 9) & 0xFF)
-#define WX_RXD_IPV6EX(_rxd) \
-	((le32_to_cpu((_rxd)->wb.lower.lo_dword.data) >> 6) & 0x1)
 /*********************** Transmit Descriptor Config Masks ****************/
 #define WX_TXD_STAT_DD               BIT(0)  /* Descriptor Done */
 #define WX_TXD_DTYP_DATA             0       /* Adv Data Descriptor */
-- 
2.27.0


