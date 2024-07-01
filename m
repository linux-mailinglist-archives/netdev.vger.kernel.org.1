Return-Path: <netdev+bounces-107988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ADC91D5F3
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 04:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA40A1C21064
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 02:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216448BFD;
	Mon,  1 Jul 2024 02:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WR4YkUM4"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811502F3B;
	Mon,  1 Jul 2024 02:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719799993; cv=none; b=ItsFuAtkUrpD3ReJ3GH2OiYzxDKvFT+7GxWD1nhslAJjAP27McFHtTzm4C4j+zQz4ekBI7uV7JM9aW4ZUoC1u/cW5sti9kT7KkhMR8h7Vh6rBX9wEQbNP0P13lDfZFx8gF7u2UsNdvlQICdHldDn35ZxUKSTTil8F7FDLyiEvNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719799993; c=relaxed/simple;
	bh=V02GNauEJ6+FSANwXykZArgTu/EBTd0wTyKo2/sT9wg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X5xs4doJkSWM8dnH9ZdVk/bCvmQQYqRzjFV38JoTd59s3Oma9kImdadIeGFdLkSGaWZCxn7IWgTRzSQc3PYQfon7sMaLzf7OuXrKS+cM8EeeQYdq4Kh8ZQsdnU9GjU/TCfKlrK1FRIbH5tIJ9I/YO2Ht6QpFADg27bxl9Q8dvLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WR4YkUM4; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=bIEJK
	Cnc2r/xvNNJlLvKU399iLjorSiJjIjlxZDacws=; b=WR4YkUM4fPREvCef3jAWW
	kHqYbcWBV4lxR80YCGWp/ia1pCDHKpOXGw3nlzC8QhN+u62vxKA7VgCoCQt/kxSY
	gbscZFhjjvtlhjoIC2YuYIBCMU5A6HMt3zbp13X7a6V7VDWX93gBh53h3QfvvtbO
	sdscLOl3sEOIIvh0ZePAUo=
Received: from localhost.localdomain (unknown [223.104.68.114])
	by gzga-smtp-mta-g3-3 (Coremail) with SMTP id _____wD3v0uFEIJm1iKSBA--.55558S4;
	Mon, 01 Jul 2024 10:12:27 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: manivannan.sadhasivam@linaro.org,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	quic_jhugo@quicinc.com
Cc: netdev@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>
Subject: [PATCH v4 3/3] net: wwan: mhi: make default data link id configurable
Date: Mon,  1 Jul 2024 10:12:16 +0800
Message-Id: <20240701021216.17734-3-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701021216.17734-1-slark_xiao@163.com>
References: <20240701021216.17734-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v0uFEIJm1iKSBA--.55558S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrykXF15Gr4DJF4fuF1Utrb_yoW5Gr4Dpa
	yUKFW3tr48J3y7Wa18Cr4UZa4Y9r4qka4ak342gws8tw1Yyry3XFWxXFyjkryYkFWv9r1q
	yF18try5GanFkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_5l1DUUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiowcPZGVOEKVIpwABs-

For SDX72 MBIM mode, it starts data mux id from 112 instead of 0.
This would lead to device can't ping outside successfully.
Also MBIM side would report "bad packet session (112)". In order
to fix this issue, we decide to use the device name of MHI
controller to do a match in wwan side. Then wwan driver could
set a corresponding mux_id value according to the MHI product.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
v2: Remove Fix flag
v3: Use name match solution instead of use mux_id
---
 drivers/net/wwan/mhi_wwan_mbim.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index 3f72ae943b29..e481ced496d8 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -42,6 +42,8 @@
 #define MHI_MBIM_LINK_HASH_SIZE 8
 #define LINK_HASH(session) ((session) % MHI_MBIM_LINK_HASH_SIZE)
 
+#define WDS_BIND_MUX_DATA_PORT_MUX_ID 112
+
 struct mhi_mbim_link {
 	struct mhi_mbim_context *mbim;
 	struct net_device *ndev;
@@ -93,6 +95,15 @@ static struct mhi_mbim_link *mhi_mbim_get_link_rcu(struct mhi_mbim_context *mbim
 	return NULL;
 }
 
+static int mhi_mbim_get_link_mux_id(struct mhi_controller *cntrl)
+{
+	if (strcmp(cntrl->name, "foxconn-dw5934e") == 0 ||
+	    strcmp(cntrl->name, "foxconn-t99w515") == 0)
+		return WDS_BIND_MUX_DATA_PORT_MUX_ID;
+
+	return 0;
+}
+
 static struct sk_buff *mbim_tx_fixup(struct sk_buff *skb, unsigned int session,
 				     u16 tx_seq)
 {
@@ -596,7 +607,7 @@ static int mhi_mbim_probe(struct mhi_device *mhi_dev, const struct mhi_device_id
 {
 	struct mhi_controller *cntrl = mhi_dev->mhi_cntrl;
 	struct mhi_mbim_context *mbim;
-	int err;
+	int err, link_id;
 
 	mbim = devm_kzalloc(&mhi_dev->dev, sizeof(*mbim), GFP_KERNEL);
 	if (!mbim)
@@ -617,8 +628,11 @@ static int mhi_mbim_probe(struct mhi_device *mhi_dev, const struct mhi_device_id
 	/* Number of transfer descriptors determines size of the queue */
 	mbim->rx_queue_sz = mhi_get_free_desc_count(mhi_dev, DMA_FROM_DEVICE);
 
+	/* Get the corresponding mux_id from mhi */
+	link_id = mhi_mbim_get_link_mux_id(cntrl);
+
 	/* Register wwan link ops with MHI controller representing WWAN instance */
-	return wwan_register_ops(&cntrl->mhi_dev->dev, &mhi_mbim_wwan_ops, mbim, 0);
+	return wwan_register_ops(&cntrl->mhi_dev->dev, &mhi_mbim_wwan_ops, mbim, link_id);
 }
 
 static void mhi_mbim_remove(struct mhi_device *mhi_dev)
-- 
2.25.1


