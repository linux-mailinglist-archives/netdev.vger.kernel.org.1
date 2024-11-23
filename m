Return-Path: <netdev+bounces-146895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3D59D689A
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 11:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8962281A4E
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 10:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD7B187342;
	Sat, 23 Nov 2024 10:27:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B261E1494DA;
	Sat, 23 Nov 2024 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732357649; cv=none; b=HbRABB1W6oUvvbPoh+Lg8yut6hzsTHw887tecVs8WmSktLijL5rhGcKOzAO9zwOqc8GkhoKVyOUghrlKGoMqCKQdsizPfTn5HUb63QQ/KklAVofQ3N0gy2BZzgSdzBtePSHiNsWHV9GGS0+HRnDmB7NaKLyrLtfdvKg5dQ431Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732357649; c=relaxed/simple;
	bh=gQ+LMnil8VvAbta1VbX2hwf/o0g/b8g9nqX/DTd6NuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nq2XUbOpyG5hOeJNkNQ6kEAKKxv/Xh2TdtWl7748SfGL6Lwbx8MF8wGiOd4YG/pXElVZuG/M8WnS0CuSWhIMBdFI8w8kPYHAhz4YX/3QltWhlMSmirBatKfHuOiyUZNLUk8TueeSrYP7LVz1LnVwSfVxzOymxLRehdwsDb1yhFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 85810f88a98511efa216b1d71e6e1362-20241123
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:c63e5237-cba9-49ba-a0b8-592c30a58f9c,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-50
X-CID-META: VersionHash:82c5f88,CLOUDID:4620050064f3ee47d4970b9363f56b6c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:1,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 85810f88a98511efa216b1d71e6e1362-20241123
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1089383395; Sat, 23 Nov 2024 18:27:20 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 8010FE0080FF;
	Sat, 23 Nov 2024 18:27:20 +0800 (CST)
X-ns-mid: postfix-6741AE08-3066921
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id 4465CE0080FF;
	Sat, 23 Nov 2024 18:27:15 +0800 (CST)
From: zhangheng <zhangheng@kylinos.cn>
To: joyce.ooi@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chris.snook@gmail.com,
	f.fainelli@gmail.com,
	horms@kernel.org,
	shannon.nelson@amd.com,
	jacob.e.keller@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangheng <zhangheng@kylinos.cn>
Subject: [PATCH] net: ethernet: Use dma_set_mask_and_coherent to set DMA mask
Date: Sat, 23 Nov 2024 18:27:13 +0800
Message-ID: <20241123102713.1543832-1-zhangheng@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Replace the setting of the DMA masks with the dma_set_mask_and_coherent
function call.

Signed-off-by: zhangheng <zhangheng@kylinos.cn>
---
 drivers/net/ethernet/altera/altera_tse_main.c | 7 ++-----
 drivers/net/ethernet/atheros/atlx/atl2.c      | 3 +--
 drivers/net/ethernet/micrel/ksz884x.c         | 3 +--
 drivers/net/ethernet/rdc/r6040.c              | 7 +------
 drivers/net/ethernet/silan/sc92031.c          | 6 +-----
 5 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/=
ethernet/altera/altera_tse_main.c
index 3f6204de9e6b..ad58e589a723 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -1219,11 +1219,8 @@ static int altera_tse_probe(struct platform_device=
 *pdev)
 		goto err_free_netdev;
 	}
=20
-	if (!dma_set_mask(priv->device, DMA_BIT_MASK(priv->dmaops->dmamask))) {
-		dma_set_coherent_mask(priv->device,
-				      DMA_BIT_MASK(priv->dmaops->dmamask));
-	} else if (!dma_set_mask(priv->device, DMA_BIT_MASK(32))) {
-		dma_set_coherent_mask(priv->device, DMA_BIT_MASK(32));
+	if (dma_set_mask_and_coherent(priv->device, DMA_BIT_MASK(priv->dmaops->=
dmamask))) {
+		dma_set_mask_and_coherent(priv->device, DMA_BIT_MASK(32));
 	} else {
 		ret =3D -EIO;
 		goto err_free_netdev;
diff --git a/drivers/net/ethernet/atheros/atlx/atl2.c b/drivers/net/ether=
net/atheros/atlx/atl2.c
index fa9a4919f25d..aa3aba4a59f3 100644
--- a/drivers/net/ethernet/atheros/atlx/atl2.c
+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
@@ -1329,8 +1329,7 @@ static int atl2_probe(struct pci_dev *pdev, const s=
truct pci_device_id *ent)
 	 * until the kernel has the proper infrastructure to support 64-bit DMA
 	 * on these devices.
 	 */
-	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(32)) &&
-	    dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32))) {
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))) {
 		printk(KERN_ERR "atl2: No usable DMA configuration, aborting\n");
 		err =3D -EIO;
 		goto err_dma;
diff --git a/drivers/net/ethernet/micrel/ksz884x.c b/drivers/net/ethernet=
/micrel/ksz884x.c
index dc1d9f774565..d74c319852a5 100644
--- a/drivers/net/ethernet/micrel/ksz884x.c
+++ b/drivers/net/ethernet/micrel/ksz884x.c
@@ -6559,8 +6559,7 @@ static int pcidev_init(struct pci_dev *pdev, const =
struct pci_device_id *id)
=20
 	result =3D -ENODEV;
=20
-	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(32)) ||
-	    dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32)))
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))
 		return result;
=20
 	reg_base =3D pci_resource_start(pdev, 0);
diff --git a/drivers/net/ethernet/rdc/r6040.c b/drivers/net/ethernet/rdc/=
r6040.c
index f4d434c379e7..a3e65ccd48ce 100644
--- a/drivers/net/ethernet/rdc/r6040.c
+++ b/drivers/net/ethernet/rdc/r6040.c
@@ -1041,12 +1041,7 @@ static int r6040_init_one(struct pci_dev *pdev, co=
nst struct pci_device_id *ent)
 		goto err_out;
=20
 	/* this should always be supported */
-	err =3D dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
-	if (err) {
-		dev_err(&pdev->dev, "32-bit PCI DMA addresses not supported by the car=
d\n");
-		goto err_out_disable_dev;
-	}
-	err =3D dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+	err =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (err) {
 		dev_err(&pdev->dev, "32-bit PCI DMA addresses not supported by the car=
d\n");
 		goto err_out_disable_dev;
diff --git a/drivers/net/ethernet/silan/sc92031.c b/drivers/net/ethernet/=
silan/sc92031.c
index ff4197f5e46d..228f2608d288 100644
--- a/drivers/net/ethernet/silan/sc92031.c
+++ b/drivers/net/ethernet/silan/sc92031.c
@@ -1409,11 +1409,7 @@ static int sc92031_probe(struct pci_dev *pdev, con=
st struct pci_device_id *id)
=20
 	pci_set_master(pdev);
=20
-	err =3D dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
-	if (unlikely(err < 0))
-		goto out_set_dma_mask;
-
-	err =3D dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+	err =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (unlikely(err < 0))
 		goto out_set_dma_mask;
=20
--=20
2.45.2


