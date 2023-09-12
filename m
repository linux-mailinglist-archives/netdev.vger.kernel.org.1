Return-Path: <netdev+bounces-33062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B15079C9E3
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B2B281AA0
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 08:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121F21774D;
	Tue, 12 Sep 2023 08:28:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7989463
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 08:28:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E181CC433C7;
	Tue, 12 Sep 2023 08:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694507290;
	bh=5qB4UhHNxlfdEU26lBim86iImVIY5x6356pApSHcaJ0=;
	h=From:To:Cc:Subject:Date:From;
	b=bP2pvNEP5pqMG2K0uyFOWp54lYCcQk39Lm2/WTZx4VB1jthaF3gHWo+jHC6BNp1Nn
	 x0wAZ+Unko6TKuIrnCLkNgkt3tz2DyFhCystl0Cft1j/PM5Jh4yH2ofYYLRc5k/tvF
	 5OSNtx4eaYStqp0AP+tWFFeOgznXSpS3W9hk0VutneldjRaLtq8EdpBCvfPm8MVM8/
	 b5YbVCfDiFk/gViGGXgsLiNxIgOt83TA6v7wB5CKdE2hU5lcPb4y/+qarYCz3vMwyR
	 1Esc/pwyASkSz4KjTu9Feqk9jByIULJ96/5fZElQusF3qkR7mcg872b7e0yJDX7rpL
	 hlmoS3IWhd5Ug==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	nbd@nbd.name,
	john@phrozen.org,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next] net: ethernet: mtk_wed: check update_wo_rx_stats in mtk_wed_update_rx_stats()
Date: Tue, 12 Sep 2023 10:28:00 +0200
Message-ID: <b0d233386e059bccb59f18f69afb79a7806e5ded.1694507226.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check if update_wo_rx_stats function pointer is properly set in
mtk_wed_update_rx_stats routine before accessing it.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_wed_mcu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
index 071ed3dea860..72bcdaed12a9 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
@@ -68,6 +68,9 @@ mtk_wed_update_rx_stats(struct mtk_wed_device *wed, struct sk_buff *skb)
 	struct mtk_wed_wo_rx_stats *stats;
 	int i;
 
+	if (!wed->wlan.update_wo_rx_stats)
+		return;
+
 	if (count * sizeof(*stats) > skb->len - sizeof(u32))
 		return;
 
-- 
2.41.0


