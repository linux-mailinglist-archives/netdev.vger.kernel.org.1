Return-Path: <netdev+bounces-154320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B269FCFCA
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 04:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7C018837D1
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 03:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFF43597B;
	Fri, 27 Dec 2024 03:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="WfP/klk5"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-7.cisco.com (alln-iport-7.cisco.com [173.37.142.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C121CA84
	for <netdev@vger.kernel.org>; Fri, 27 Dec 2024 03:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735269345; cv=none; b=e6t10W0Jx105tPM+C8nuPmPSdQT20VFo8EhqcaVSb8fi0Qk6myWh2jvYczluyUXzG98/lC8UPv3S0zgMiBnRuPhvgYFoMvAKYjsjp7bUdgaVJvEwJFU9tmGKh39dSn+r9+Lk3Tgj/aN1U7HbeqLDsw6bYrsEYW0JhCEwSZ9IlGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735269345; c=relaxed/simple;
	bh=T4hWg15WZP+lApfrr9Y/thSG09sNb0ZXX0qr/vwtnN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rRLtPK84BviHcpG8QV+PYnsM+X2Doek/UWa9xyDZvyS+yJiRIH4zYkLb1NASFQP/ra+cVb/aZM7zpvJgTZsN685ER4GjoR9z8zUAzDZ1BUYKMgz7OGHN2ARWEJEFfe8b75p9wSxV9Nj/xX7kprhfVGjebx3A37j3j346Rv9upzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=WfP/klk5; arc=none smtp.client-ip=173.37.142.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2510; q=dns/txt; s=iport;
  t=1735269343; x=1736478943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mJaW4D8IoGJsrpAQ4RXWrveI+HMg7JYPf5VPwYrwcqs=;
  b=WfP/klk5G4AomOjfS8bb7J4Pzr/KNuDPnU01P9NBcQ6SX4FXfyFx7y7g
   IGzJ24ZJXYqyTe1EM8XgaLHoAGw/GuDKgWY2KSQx0vvnnTxmiWeGKMSw2
   byfrCAtClJMQgiWUzHEtOuUeTsDY13uYIH+tiO+AI98a9ltLzLHl8Ff7u
   A=;
X-CSE-ConnectionGUID: 1kgAxxt6SAiaV9R/RzGxHQ==
X-CSE-MsgGUID: 4Amo/IZDRdqxT3jLxyH3Aw==
X-IPAS-Result: =?us-ascii?q?A0ANAADbGm5nj5P/Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBhBlDSIxyX6EwhV2BJQNWDwEBAQ9EBAEBhQcCim4CJjQJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFFAEBAQEBATkFDjuGCIZbAgEDJ?=
 =?us-ascii?q?wsBRhBRKysHEoMBgmUDrxWBeTOBAd4zgW2BSAGFaodfcIR3JxuBSUSCUIE+b?=
 =?us-ascii?q?4UQhXcEiRWedUiBIQNZLAFVEw0KCwcFgTk6AyIMCwwLFBwVAoEegQEBFAYVB?=
 =?us-ascii?q?IELRT2CSmlJNwINAjaCICRYgk2FF4RhhFeCSVWCe4IXfIEdgiVAAwsYDUgRL?=
 =?us-ascii?q?DcGDhsGPm4HnGRGg3SBD4IopgehA4QkgWOfYxozqlIuh2SQaiKkJIRmgWc6g?=
 =?us-ascii?q?VszGggbFYMiUhkPji0NCRa1fCUyPAIHCwEBAwmRNwEB?=
IronPort-Data: A9a23:BEoyyK7tuU8akwfjC3mN4gxRtNzHchMFZxGqfqrLsTDasY5as4F+v
 mcfXz2EbqyPYTPzfItwO96/oE9X6MOBytI2TAFppShgZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa/lH1dOC89RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wr+aUzBHf/g2QoazhOtPrawP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eZI4X0/ZnHT913
 P0RFmE3KSqRqPKW+efuIgVsrpxLwMjDJogTvDRkiDreF/tjGMiFSKTR7tge1zA17ixMNa+BP
 IxCNnw1MUmGOkEQUrsUIMpWcOOAhH7/dTFRrF+9rqss6G+Vxwt0uFToGIaNJoLbFJoJwy50o
 Eqa1mH+RTAoGOaT0Cq5qXCIlv7vxgrkDdd6+LqQraMy3wbJmQT/EiY+WVKlrPyRhkegVtdbL
 EIIvCwjscAa+UC2S9DvUgGQr3mDsRoRHdFXFoUS6xyHw4LX7hyfC2xCSSROAPQvssMsSCNp0
 FKVk973LThytrvTQnL13q+dpz60OAAPIGMCbDNCRgwAi/HlrZ0/gwznUNluCui2g8fzFDW2x
 CqFxBXSnJ0JhsINkqH+9lfdjnf1/t7CTxU+4UPcWWfNAh5FiJCNPo+nwEjL8ah7BYeQcAi7+
 0IWtNi+1bVbZX2SrxClTOIIFbCvwv+KNjzAnFJid6XNERzzoBZPmqgOvFlDyFdVDyoSRdP+j
 KbuVeJtCH17YSHCgUxfOt7Z5yEWIU7ISY6Nuhf8NYYmX3SJXFXblByCnGbJt4wXrGAikLskJ
 bCQetu2AHARBMxPlWXtGr1Gju96nXFjnQs/oKwXKTz5iNJyg1bIGd843KemNLtRAF6s+V+Mq
 o0ObaNmNT0CD7GhPkE7DrL/3XhRcCBkXsqpwyCmXuWCOQFhUHowEOPcxKhpeopu2cxoehTgo
 BmAtrtj4AOn3xXvcFzSAlg6Me+Hdcgk9xoTY3dzVWtELlB/Ou5DGo9DLMNvJdHKNYVLkZZJc
 hXyU57fW64TEWWap2t1gFuUhNUKSSlHTDmmZ0KNCAXTtbY5L+AV0rcIpjfSyRQ=
IronPort-HdrOrdr: A9a23:l2k8NqH9qB38ANE5pLqE78eALOsnbusQ8zAXPo5KJiC9Ffbo8P
 xG88576faZslsssTQb6LK90cq7MBfhHOBOgbX5VI3KNGKNhILrFvAG0WKI+VPd8kPFmtK1rZ
 0QEJSXzLbLfCFHZQGQ2njfL+od
X-Talos-CUID: =?us-ascii?q?9a23=3AC/pLHWnT/s7fkylp0dTweLaisELXOSTew17AM1P?=
 =?us-ascii?q?mMk9oQYPEcxiq6ox0s/M7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AAKT6fgyUtoED6NMmWZ8MMkn8O0eaqPiHDUdKsKc?=
 =?us-ascii?q?qgcWdJRArORONnRTsa5Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,268,1728950400"; 
   d="scan'208";a="404699745"
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
  by alln-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 27 Dec 2024 03:14:34 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-10.cisco.com (Postfix) with ESMTP id E59EF1800026B;
	Fri, 27 Dec 2024 03:14:33 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id B97B520F2005; Thu, 26 Dec 2024 19:14:33 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: benve@cisco.com,
	satishkh@cisco.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: John Daley <johndale@cisco.com>,
	Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next v2 2/5] enic: Remove an unnecessary parameter from function enic_queue_rq_desc
Date: Thu, 26 Dec 2024 19:14:07 -0800
Message-Id: <20241227031410.25607-3-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20241227031410.25607-1-johndale@cisco.com>
References: <20241227031410.25607-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-10.cisco.com

The function enic_queue_rq_desc has a parameter os_buf_index which was
only called with a hard coded 0. Remove it.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c |  8 ++------
 drivers/net/ethernet/cisco/enic/enic_res.h  | 10 +++-------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 33890e26b8e5..f8d0011486d7 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1301,14 +1301,11 @@ static int enic_rq_alloc_buf(struct vnic_rq *rq)
 	struct net_device *netdev = enic->netdev;
 	struct sk_buff *skb;
 	unsigned int len = netdev->mtu + VLAN_ETH_HLEN;
-	unsigned int os_buf_index = 0;
 	dma_addr_t dma_addr;
 	struct vnic_rq_buf *buf = rq->to_use;
 
 	if (buf->os_buf) {
-		enic_queue_rq_desc(rq, buf->os_buf, os_buf_index, buf->dma_addr,
-				   buf->len);
-
+		enic_queue_rq_desc(rq, buf->os_buf, buf->dma_addr, buf->len);
 		return 0;
 	}
 	skb = netdev_alloc_skb_ip_align(netdev, len);
@@ -1324,8 +1321,7 @@ static int enic_rq_alloc_buf(struct vnic_rq *rq)
 		return -ENOMEM;
 	}
 
-	enic_queue_rq_desc(rq, skb, os_buf_index,
-		dma_addr, len);
+	enic_queue_rq_desc(rq, skb, dma_addr, len);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/cisco/enic/enic_res.h b/drivers/net/ethernet/cisco/enic/enic_res.h
index b8ee42d297aa..dad5c45b684a 100644
--- a/drivers/net/ethernet/cisco/enic/enic_res.h
+++ b/drivers/net/ethernet/cisco/enic/enic_res.h
@@ -107,19 +107,15 @@ static inline void enic_queue_wq_desc_tso(struct vnic_wq *wq,
 }
 
 static inline void enic_queue_rq_desc(struct vnic_rq *rq,
-	void *os_buf, unsigned int os_buf_index,
-	dma_addr_t dma_addr, unsigned int len)
+	void *os_buf, dma_addr_t dma_addr, unsigned int len)
 {
 	struct rq_enet_desc *desc = vnic_rq_next_desc(rq);
-	u64 wrid = 0;
-	u8 type = os_buf_index ?
-		RQ_ENET_TYPE_NOT_SOP : RQ_ENET_TYPE_ONLY_SOP;
 
 	rq_enet_desc_enc(desc,
 		(u64)dma_addr | VNIC_PADDR_TARGET,
-		type, (u16)len);
+		RQ_ENET_TYPE_ONLY_SOP, (u16)len);
 
-	vnic_rq_post(rq, os_buf, os_buf_index, dma_addr, len, wrid);
+	vnic_rq_post(rq, os_buf, 0, dma_addr, len, 0);
 }
 
 struct enic;
-- 
2.35.2


