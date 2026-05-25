Return-Path: <netdev+bounces-291347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BcaCfVgFGqgMwcAu9opvQ
	(envelope-from <netdev+bounces-291347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:47:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9157B5CBDF8
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E6D03034B32
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13993F39F6;
	Mon, 25 May 2026 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Fc8mlKLN"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B06234973;
	Mon, 25 May 2026 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779720351; cv=none; b=CrtogKnLtqg22DRkL0i6iuB7J1xUzGSRbBremTteG9hF7/KryjeD4EHn5XI8J1WK/NJjOzS9mQbxc3GmmuSQi3OP0VY9zL3aQZl0wM2JhVX3ma2LXBA/Jj+BS/AwEZ+7vG/1I1JOsO/f9EEofe7ZY8zuwxzts4xE4E1/m1qNPhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779720351; c=relaxed/simple;
	bh=Di0dtW0FCCt62JIbVFLFNix8ccDL4v8LHAIQg2ae6K0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPpcAyCZK8rciiIWt9PHqBMHijpZ8rzefdi1/k7KMhtF1v21NpSFHiKg7WCLwa3rqGPpnCvb70vSdvzrkMfzUdMD7DXuNHK5XT4A0vjtu8iwy8vIOCsvmx9ziVIYR2LfLAV/7MFfJP0EyZcMi/W6HoDaXMNCc8bleUOSbSDF0lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Fc8mlKLN; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BaIQuixUu8bOy5IBSAGiECJYkfHH0weA2tJPzmfLhow=;
	b=Fc8mlKLNJUOBXI3p9HQqesQY1jQDBA22Uy9XAiRzEsXyg7K+H/wQG+11iOdnIoFh+a9+O7cav
	6q4E7pbJJK2v010JBlmCzDQpibg5HHN/ULr+q/1A1NlTOfW5sZotmtmMD9fSbg5q/wEB6W+q8M+
	5GhsP4E7gwAQ+a495+xV68w=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gPJQH2CHvzcZy1;
	Mon, 25 May 2026 22:37:59 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id BFD8D4056D;
	Mon, 25 May 2026 22:45:42 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 25 May 2026 22:45:42 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <shiyongbang@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V3 net 2/2] net: hibmcge: move dma_rmb() after dma_sync_single_for_cpu() in RX path
Date: Mon, 25 May 2026 22:45:25 +0800
Message-ID: <20260525144525.94884-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260525144525.94884-1-shaojijie@huawei.com>
References: <20260525144525.94884-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291347-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:mid,huawei.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9157B5CBDF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The dma_rmb() barrier was placed before dma_sync_single_for_cpu(), which
is incorrect. DMA sync must complete first to make the buffer accessible
to the CPU, then the rmb barrier ensures subsequent descriptor reads
observe the latest data written by the hardware.

Reorder the operations so dma_sync_single_for_cpu() is called before
dma_rmb() to guarantee the driver reads consistent data from the DMA
buffer.

Fixes: f72e25594061 ("net: hibmcge: Implement rx_poll function to receive packets")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
index a4ea92c31c2f..0ae314994676 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
@@ -452,12 +452,12 @@ static bool hbg_sync_data_from_hw(struct hbg_priv *priv,
 {
 	struct hbg_rx_desc *rx_desc;
 
-	/* make sure HW write desc complete */
-	dma_rmb();
-
 	dma_sync_single_for_cpu(&priv->pdev->dev, buffer->page_dma,
 				buffer->page_size, DMA_FROM_DEVICE);
 
+	/* make sure HW write desc complete */
+	dma_rmb();
+
 	rx_desc = (struct hbg_rx_desc *)buffer->page_addr;
 	return FIELD_GET(HBG_RX_DESC_W2_PKT_LEN_M, rx_desc->word2) != 0;
 }
-- 
2.33.0


