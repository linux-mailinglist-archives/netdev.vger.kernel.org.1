Return-Path: <netdev+bounces-111846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FED9338C3
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 10:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1561F23CB1
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 08:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1076E224F2;
	Wed, 17 Jul 2024 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGSDfhVd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC6B22081
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721204196; cv=none; b=nULc/8QH53nbyHWp/bEEHTxMFyEhQA23CapMZIdvpvNnLEkqVkiUuMvqkONcz8XV8jJ0bsw+o8m05tEb7zFZzrrUu4fh3MVcsawRFVXNCGMou7QWY2t2quoUPTQwDji1/8HAa6eUpMdVs38qoXlRD7pcWEEfDADbnDM+7y4SNAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721204196; c=relaxed/simple;
	bh=yDsns82MnrYt7Bo2jMAKgQSAdRDY5L1H5Za0sQwomiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lQIsc1U70F2nqzaB3SRlkKRz5b2oM6apj38ukVFoN4/cq449KYwAAwlLSbqJ4y7CXAe3nVOEyxxb57Hjhx3cRlPYJRqXkICcaaugZ26q4izyp80b0+12nfkIKi+gIEeMHYP3sYEH4p0zNRaxHMx0xY2MyhxdfLag/yGm4uuXE2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGSDfhVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001DCC32782;
	Wed, 17 Jul 2024 08:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721204195;
	bh=yDsns82MnrYt7Bo2jMAKgQSAdRDY5L1H5Za0sQwomiY=;
	h=From:To:Cc:Subject:Date:From;
	b=WGSDfhVd0dV6i7w7WrS//yQjRaArSufiLqlAdUVg+/f0v9+RhLvbW88zM18JO8Bgn
	 Qw3MEv/pJOYKceKnqDsv+DBUr8RYuxyYd0bS/AOR3J/A6FL6sdm3mWVuZXoHQpS6Bm
	 tjPNWa886JccisSmGZLTCY6TvjEKKkAoVTshofe+nHpe9u9eam35x7sgNEbKjIJ50a
	 q416Bvf+atIZ++d2lYTxAarRk+wtw3rFd40U7c3hNQcL+2rPmoWbAEe0nh+h6QrJSs
	 hJfbB7cxVnPXXGbBrlz2OUDibylY9DPtH5GYCT9Gys7tj4aA2NHOrXq+ukA+j++fnC
	 PCgfpVSV9XPcQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	lorenzo.bianconi83@gmail.com
Subject: [PATCH net] net: airoha: fix error branch in airoha_dev_xmit and airoha_set_gdm_ports
Date: Wed, 17 Jul 2024 10:15:46 +0200
Message-ID: <b628871bc8ae4861b5e2ab4db90aaf373cbb7cee.1721203880.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix error case management in airoha_dev_xmit routine since we need to
DMA unmap pending buffers starting from q->head.
Moreover fix a typo in error case branch in airoha_set_gdm_ports
routine.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 7967a92803c2..cc1a69522f61 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -977,7 +977,7 @@ static int airoha_set_gdm_ports(struct airoha_eth *eth, bool enable)
 	return 0;
 
 error:
-	for (i--; i >= 0; i++)
+	for (i--; i >= 0; i--)
 		airoha_set_gdm_port(eth, port_list[i], false);
 
 	return err;
@@ -2431,9 +2431,11 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 
 error_unmap:
-	for (i--; i >= 0; i++)
-		dma_unmap_single(dev->dev.parent, q->entry[i].dma_addr,
-				 q->entry[i].dma_len, DMA_TO_DEVICE);
+	for (i--; i >= 0; i--) {
+		index = (q->head + i) % q->ndesc;
+		dma_unmap_single(dev->dev.parent, q->entry[index].dma_addr,
+				 q->entry[index].dma_len, DMA_TO_DEVICE);
+	}
 
 	spin_unlock_bh(&q->lock);
 error:
-- 
2.45.2


