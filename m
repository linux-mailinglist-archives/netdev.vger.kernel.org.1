Return-Path: <netdev+bounces-134423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C12C999500
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 00:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D9C1F238A1
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 22:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC721BE86E;
	Thu, 10 Oct 2024 22:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aLOv+ciK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BA01C6888
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 22:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598512; cv=none; b=FyFObusEJdRDIJkGzC6HZcohO8Ot/1uzjlFdy+hyUWI/au79gylF+S/SsQG/Ts3rMsKE72K4eby8vN07cRDVrZ0nF9xGHtu/t9+e9LbRZ9tinB54SYlN1toBCh2UZmN+TuzaTGqILBQrN2hU2+EQ0F4BpryXxmBAVg7TDr7MIic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598512; c=relaxed/simple;
	bh=HOgeh/9hU/kmgs7FcQH6nvlEOYPE06f0qf8QgeXLhTs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hytTx1GM0Re9IBMxxu/k63afjsdvCpLQ7v7m4waGywtBiqPnFFxusi66aq2BqFOF0q6wI2qJF5ql7+X/r3pihE7+A4/Sexqqxjp+GyM3cvnkwW8v7glOOO2/XlP6+YX20paD4sBaNMAfSrBHCsyeTAkbqnao+g0WhMB/HLRzmr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aLOv+ciK; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so1177095a12.3
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 15:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728598510; x=1729203310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FVC6IZSUMEdR9UAAbPyZAJ9MQ8PXUx9QKz/xSicX6IM=;
        b=aLOv+ciK8Qcmg5MaHPASbK1sX65gl7Za/1Zqdfvx5HHvUnUgl49ibQ/YMHAprhx2Nl
         wL9NMZJsyw/A67E/csM/Q7tyhEpYRZc1vtG8bdnFoEN2dD5HjjgmeV2qvXTKoY22IbZT
         rVzrXMHDxTBZmgjsmwYQmSyj1HezDIGHRnFfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728598510; x=1729203310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVC6IZSUMEdR9UAAbPyZAJ9MQ8PXUx9QKz/xSicX6IM=;
        b=QKZ/PnWW5mZpeqa4iy9P2uCAtfzMjHXb7Hn75XsSk50wgDLt4mxrYDeXsYWeoCRP7o
         ZM/CcwfosAnOZ+1gSlJCAdfqOI5gwA+SmxS7ocfGRDDZ7HPbw//IyMWxFfH2vu7k+35/
         JNSKC9wzVdTMucnvxs173BmbZB/O8LJS3ebHkoqdxwHyX/hn8wVBUim3KaG0STO2xXXO
         e67YpqcBVaqO6rjCwSB211CIW+pBG6z9OLZYBi1PrTYqI7bkq855Vfb8ZwMNuab4bfgq
         /96tFIFwxPYrMWpLDh8YnguaqWphsS07/Quh2Qe7XCWrZCUH83NsU3tMRAfYz2BK8JQX
         b+9g==
X-Gm-Message-State: AOJu0Yy9oVbO2DtHm8A/PkMSy0uxzxWPr6lyhmoimM6QqUcg4MSy7z38
	doxjJgdBmspfquIh+LfqAxTxRQtUDgUE/S2RuYW6uGOvSoWCgnc8PdC76fjHrgm/g2jYAywi4cN
	jZS9bf1b8wx+VVHDQhfv7G16RoGQ+hkfEkm1Vs00fFtPx6Z1PK2yLSvL7/bz4O3ZdlhRWrGkPPh
	8zPF7WajVpRw4c4lYojqtktP4gR3tyZ0qDST6sAiCy3nxn
X-Google-Smtp-Source: AGHT+IGsmwm6s7PF83VYJTWt6HaUcj4TlBwn/SNJXxkSvgvRIxguBVISBaAS5tx04IZfpj6vuFwpeQ==
X-Received: by 2002:a17:90a:d783:b0:2e2:e4d3:3401 with SMTP id 98e67ed59e1d1-2e2f0b0a6dcmr848031a91.20.1728598510279;
        Thu, 10 Oct 2024 15:15:10 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5caa23esm4165452a91.53.2024.10.10.15.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 15:15:09 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next] net: bcmasp: enable SW timestamping
Date: Thu, 10 Oct 2024 15:15:06 -0700
Message-Id: <20241010221506.802730-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add skb_tx_timestamp() call and enable support for SW
timestamping.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c | 1 +
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c    | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
index ca163c8e3729..67928b5d8a26 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
@@ -496,4 +496,5 @@ const struct ethtool_ops bcmasp_ethtool_ops = {
 	.get_strings		= bcmasp_get_strings,
 	.get_ethtool_stats	= bcmasp_get_ethtool_stats,
 	.get_sset_count		= bcmasp_get_sset_count,
+	.get_ts_info		= ethtool_op_get_ts_info,
 };
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index 82768b0e9026..34f14d6059af 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -364,6 +364,9 @@ static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	intf->tx_spb_index = spb_index;
 	intf->tx_spb_dma_valid = valid;
+
+	skb_tx_timestamp(skb);
+
 	bcmasp_intf_tx_write(intf, intf->tx_spb_dma_valid);
 
 	if (tx_spb_ring_full(intf, MAX_SKB_FRAGS + 1))
-- 
2.34.1


