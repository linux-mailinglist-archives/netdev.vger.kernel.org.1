Return-Path: <netdev+bounces-146893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D829D6841
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 09:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8279B281D34
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 08:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49D615C14B;
	Sat, 23 Nov 2024 08:55:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB750F4FA;
	Sat, 23 Nov 2024 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732352156; cv=none; b=XZ8FvWs38bj1YMuyoHsWFXMJi9cKNtfM/lU52M63tMwbOUFVOHjMD1yeSzkXaNgV781aDmgKG5D5uecrd5yiY80sglCppvLo8YCsBxEwczD5J3XFAD7EtNDTTlZaeVjkO8GPnfLJKTI0ZGb5bH9H99GQb+W0GwzW618Hev2IsXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732352156; c=relaxed/simple;
	bh=W7QKvzogt7TfP3ZUil8GC+BNwtUzslI54WZF0+W46Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aFLAI3lxc4DSney6OSwX+hts6TTLHU9ckpAyC/qiw5YmmG3vJ8Emtp3WK1WToaiZEejoKbga3Xqxny931/iCvIRt38dn2OMXFzWVdkqriT1juG758XUn2UQzkEHLbber6P0zTj37FWA3Bb8KqE8mUBLY2rUS6Uw656qcDsGOWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ba03b1faa97811efa216b1d71e6e1362-20241123
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:25583f0c-cb30-4cd9-82db-18d84178b732,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:82c5f88,CLOUDID:7287d30bde16fa5513094300cd5a2bbf,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ba03b1faa97811efa216b1d71e6e1362-20241123
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 919889968; Sat, 23 Nov 2024 16:55:45 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 2EA74E0080FF;
	Sat, 23 Nov 2024 16:55:45 +0800 (CST)
X-ns-mid: postfix-67419890-93410110
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id 413F9E0080FF;
	Sat, 23 Nov 2024 16:55:42 +0800 (CST)
From: zhangheng <zhangheng@kylinos.cn>
To: khc@pm.waw.pl,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangheng <zhangheng@kylinos.cn>
Subject: [PATCH] net: wan: replace dma_set_mask()+dma_set_coherent_mask() with new helper
Date: Sat, 23 Nov 2024 16:55:40 +0800
Message-ID: <20241123085540.1470530-1-zhangheng@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Replace the following sequence:

	dma_set_mask(dev, mask);
	dma_set_coherent_mask(dev, mask);

with a call to the new helper dma_set_mask_and_coherent().

Signed-off-by: zhangheng <zhangheng@kylinos.cn>
---
 drivers/net/wan/wanxl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wan/wanxl.c b/drivers/net/wan/wanxl.c
index 5a9e262188ef..c2d5fbf887ee 100644
--- a/drivers/net/wan/wanxl.c
+++ b/drivers/net/wan/wanxl.c
@@ -574,8 +574,7 @@ static int wanxl_pci_init_one(struct pci_dev *pdev,
 	 * and pray pci_alloc_consistent() will use this info. It should
 	 * work on most platforms
 	 */
-	if (dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(28)) ||
-	    dma_set_mask(&pdev->dev, DMA_BIT_MASK(28))) {
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(28))) {
 		pr_err("No usable DMA configuration\n");
 		pci_disable_device(pdev);
 		return -EIO;
@@ -626,8 +625,7 @@ static int wanxl_pci_init_one(struct pci_dev *pdev,
 	 * We set both dma_mask and consistent_dma_mask back to 32 bits
 	 * to indicate the card can do 32-bit DMA addressing
 	 */
-	if (dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32)) ||
-	    dma_set_mask(&pdev->dev, DMA_BIT_MASK(32))) {
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))) {
 		pr_err("No usable DMA configuration\n");
 		wanxl_pci_remove_one(pdev);
 		return -EIO;
--=20
2.45.2


