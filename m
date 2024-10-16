Return-Path: <netdev+bounces-136164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7F09A0B68
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 15:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0461C22D8F
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 13:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262D420ADDC;
	Wed, 16 Oct 2024 13:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d4DmXHGq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A103B208D90;
	Wed, 16 Oct 2024 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085182; cv=none; b=t2eLIKxUCli/JvF0bttu+nNGO5YaOWi4GznVRKQNp4+revfP8RwDsvAm/ww+q/GJDqmNeE7Cf3piO6yW531S48EwEEEF/BCInpcHj4XKNT3HyHmG75cVxchSbHWgrOdNEwXoYba/HjMwo+2UCQuzo4G7O5NIJ9YDKVsh2QiBcHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085182; c=relaxed/simple;
	bh=ktsUmMq1owm2A/rtmJhchvXSt4SVDq3RopLtu41LSak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AgPc2IXIEAmYpbNu1k6xz18x2SVR9JeQ4+Ix5DZ682d/3YFERWwlvv5B6XCWwFQplHB/fknAqMfxhTVMbeOo3d5dwUGy+GOHQ5rysA4kecb9JZrYyc/vmMV4sAE+1sWixFdrlHAaFO9ujlh0uqbvwNobT8zacGj+uN7s6ximNfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d4DmXHGq; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729085181; x=1760621181;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ktsUmMq1owm2A/rtmJhchvXSt4SVDq3RopLtu41LSak=;
  b=d4DmXHGqoMflT8Ez0yLlrbLlW0i3iondOLc6M27Ol+xoampqEgvXWavb
   fen7k/pFXmHHw+9lb1hNJeiS6K1SIH3QV/40qgFfiRNScdZ8KaxlS+JN5
   PoFIrygien13rdzrAClg3QDtL9rCWlBNL3683DpClAiut0yxf8k2U7YbX
   bYb10U8X6ViI/k9D5ieR1nCRUIjpTb+fOKDyiN9ObQzMAKsqapDnsS0av
   DEg7kEbD8587ipIjskPI35tvkhvz1Kp3AZs1kCLX2aK/MIi9LoiSVtQvb
   BrYCgHkCVO0Rpj8ZqIxxxUkt7qzaYAprfw5XcCyzh97i6jKiLYY7aTQMs
   Q==;
X-CSE-ConnectionGUID: TbmduhNVTFGbgfjrW52OjQ==
X-CSE-MsgGUID: eXCX+1r1R96Eu50a/J3khA==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="53947539"
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="53947539"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 06:26:20 -0700
X-CSE-ConnectionGUID: QI5XSyjLSKKz53+a4UfK6A==
X-CSE-MsgGUID: gMoiiCdKQrOXvR3CJkwuog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="115665424"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 16 Oct 2024 06:26:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 59700165; Wed, 16 Oct 2024 16:26:16 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v2 1/1] net: ks8851: use %*ph to print small buffer
Date: Wed, 16 Oct 2024 16:25:26 +0300
Message-ID: <20241016132615.899037-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use %*ph format to print small buffer as hex string. It will change
the output format from 32-bit words to byte hexdump, but this is not
critical as it's only a debug message.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: wrapped on 80 (Simon), elaborated the format change (Simon)
 drivers/net/ethernet/micrel/ks8851_common.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index 7fa1820db9cc..bb5138806c3f 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -215,22 +215,6 @@ static void ks8851_init_mac(struct ks8851_net *ks, struct device_node *np)
 	ks8851_write_mac_addr(dev);
 }
 
-/**
- * ks8851_dbg_dumpkkt - dump initial packet contents to debug
- * @ks: The device state
- * @rxpkt: The data for the received packet
- *
- * Dump the initial data from the packet to dev_dbg().
- */
-static void ks8851_dbg_dumpkkt(struct ks8851_net *ks, u8 *rxpkt)
-{
-	netdev_dbg(ks->netdev,
-		   "pkt %02x%02x%02x%02x %02x%02x%02x%02x %02x%02x%02x%02x\n",
-		   rxpkt[4], rxpkt[5], rxpkt[6], rxpkt[7],
-		   rxpkt[8], rxpkt[9], rxpkt[10], rxpkt[11],
-		   rxpkt[12], rxpkt[13], rxpkt[14], rxpkt[15]);
-}
-
 /**
  * ks8851_rx_pkts - receive packets from the host
  * @ks: The device information.
@@ -296,8 +280,8 @@ static void ks8851_rx_pkts(struct ks8851_net *ks, struct sk_buff_head *rxq)
 
 				ks->rdfifo(ks, rxpkt, rxalign + 8);
 
-				if (netif_msg_pktdata(ks))
-					ks8851_dbg_dumpkkt(ks, rxpkt);
+				netif_dbg(ks, pktdata, ks->netdev,
+					  "pkt %12ph\n", &rxpkt[4]);
 
 				skb->protocol = eth_type_trans(skb, ks->netdev);
 				__skb_queue_tail(rxq, skb);
-- 
2.43.0.rc1.1336.g36b5255a03ac


