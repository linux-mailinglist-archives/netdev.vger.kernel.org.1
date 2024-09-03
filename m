Return-Path: <netdev+bounces-124699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 718F496A79F
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 21:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2EC91F2136F
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 19:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0281D1D88A2;
	Tue,  3 Sep 2024 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IV/B1VjJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAB81C9DC4;
	Tue,  3 Sep 2024 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392599; cv=none; b=tftwHb4zsJLi7ziezOY3e5rUpFdCrN0fzI8+zQzEC8zhACfSA/825/o/W1QzKTSPVn6MPD7cRkCObjOFeWD08dhO1vV6bFggffJUEcm/T9kCTCVYzbrz9lOvBDFXQNVhClkK42uP6jxBbSJ3D8Hqw24OQ9nlcF6BK5Tni69AgOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392599; c=relaxed/simple;
	bh=6uvvc9omu3anzlEvACmMTuKSdfG9cb2rFtNsC2yfkMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzmlAMRYtCPNQC99eITRrNxPnkEL4N4Ons8whLAVRdVhvy/V7I4aeac2ffJZd/PSCfWsyBFVW5rKGRelNj/6bvYKdcpru+gmZqR13H965PzYXYwjRv0XSefLhTccxZqb2SeFcVVgcUomevQ9rG24BfiU+XhsHxWxtelq57JvMew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IV/B1VjJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20551eeba95so23134055ad.2;
        Tue, 03 Sep 2024 12:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725392598; x=1725997398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KB25pXa0H13f7ZRmiCasC1oMh5SE34bhfNLrxpD/z/Q=;
        b=IV/B1VjJ483n+b5UM8P90bAPlhbsbucDI7MhecMbSjkLHkgddDO65I1grk6wKUKqKI
         v8oiDvamJYojH/Ng/z2+UPzf8yvq0AZnWEQ/LjFioRj5P8iV6rljI7bl7DjHbFOuOIpc
         q4uufOmejyF9frYbcem8r+b/atYLVSMVj0pnygG+btH3ZmOo85VHwUOx3fRpex93zw//
         y3K1f0eQiAzXApSUSPYTaeNahxk6/vWG+xDjfDO6v1besCqbIgKmeEoiXoJdQZFkLteh
         j4MoWApmN7SJQcLL520fx0ApOeN1RlbLUVHwXXoVRbNmoEEQZG7zsL4tWsn/5mZFnt54
         PLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725392598; x=1725997398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KB25pXa0H13f7ZRmiCasC1oMh5SE34bhfNLrxpD/z/Q=;
        b=YMtcY6J9rF9R7LDXbq2XD6H5zL/N9ZSePAH3UiolTIkd++uf1XfBqtueX5lXjot4YL
         z9fyfaw3ylvr45l2f2WXFnvVM9t1NNXLGk8yszVLaPVYE80bfaxhtL1UDH9IH1s4ybx+
         VOrdtbmTg3zu+OXJPvWZHtU5yRPdwp+Go++8b/mOgB+hO/yM/cx+9Kr5WWB8L0W5svxP
         lXKpdTXKAOZIZb6tZBLxtFS67BJ+1dAdOU/wCHQifEb2A2epobCJZDvcNDPads3sAkD6
         CUm9ZugRFc6YjQhUXGlueAEz4hHfPHGtkmmVeckV1hGLsyY5n+C+C6iEDRfNGq9ih8sP
         G7MA==
X-Forwarded-Encrypted: i=1; AJvYcCVQKHxzKoT3RC4Db2YdisVdp2iiImQwGwJMIellc0YA2YOS1s5X4jZFSCNrosS6FFHHJRyS9mcv6n+EV1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz7e+SMLcbfaYxj++2D2e81WY2X9a6nEQbszyKyFZz/gopLV3+
	cWz+g589tvAGL+editz2pD0/CAtYOfEfgQx5RPIfxu+cJ1oomnryrVl+ofCW
X-Google-Smtp-Source: AGHT+IGlTSngbchI/Fat2wEQK0I/MeEpoR13iFU8f27B+Kh0meZehvD/b1BPt2vKVsMUN7QS5gVkWw==
X-Received: by 2002:a17:902:e5d2:b0:206:a87c:2864 with SMTP id d9443c01a7336-206a87c2f32mr23233805ad.42.1725392597531;
        Tue, 03 Sep 2024 12:43:17 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea52a8asm1979505ad.182.2024.09.03.12.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:43:16 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv2 net-next 2/8] net: ibm: emac: manage emac_irq with devm
Date: Tue,  3 Sep 2024 12:42:38 -0700
Message-ID: <20240903194312.12718-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903194312.12718-1-rosenp@gmail.com>
References: <20240903194312.12718-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's the last to go in remove. Safe to let devm handle it.

Also move request_irq to probe for clarity. It's removed in _remove not
close.

Use dev_err_probe instead of printk. Handles EPROBE_DEFER automatically.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: used dev_err_probe
 drivers/net/ethernet/ibm/emac/core.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 348702f462bd..4e260abbaa56 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -1228,18 +1228,10 @@ static void emac_print_link_status(struct emac_instance *dev)
 static int emac_open(struct net_device *ndev)
 {
 	struct emac_instance *dev = netdev_priv(ndev);
-	int err, i;
+	int i;
 
 	DBG(dev, "open" NL);
 
-	/* Setup error IRQ handler */
-	err = request_irq(dev->emac_irq, emac_irq, 0, "EMAC", dev);
-	if (err) {
-		printk(KERN_ERR "%s: failed to request IRQ %d\n",
-		       ndev->name, dev->emac_irq);
-		return err;
-	}
-
 	/* Allocate RX ring */
 	for (i = 0; i < NUM_RX_BUFF; ++i)
 		if (emac_alloc_rx_skb(dev, i)) {
@@ -1293,8 +1285,6 @@ static int emac_open(struct net_device *ndev)
 	return 0;
  oom:
 	emac_clean_rx_ring(dev);
-	free_irq(dev->emac_irq, dev);
-
 	return -ENOMEM;
 }
 
@@ -1408,8 +1398,6 @@ static int emac_close(struct net_device *ndev)
 	emac_clean_tx_ring(dev);
 	emac_clean_rx_ring(dev);
 
-	free_irq(dev->emac_irq, dev);
-
 	netif_carrier_off(ndev);
 
 	return 0;
@@ -3082,6 +3070,14 @@ static int emac_probe(struct platform_device *ofdev)
 		err = -ENODEV;
 		goto err_gone;
 	}
+
+	/* Setup error IRQ handler */
+	err = devm_request_irq(&ofdev->dev, dev->emac_irq, emac_irq, 0, "EMAC", dev);
+	if (err) {
+		dev_err_probe(&ofdev->dev, err, "failed to request IRQ %d", dev->emac_irq);
+		goto err_gone;
+	}
+
 	ndev->irq = dev->emac_irq;
 
 	/* Map EMAC regs */
@@ -3237,8 +3233,6 @@ static int emac_probe(struct platform_device *ofdev)
  err_irq_unmap:
 	if (dev->wol_irq)
 		irq_dispose_mapping(dev->wol_irq);
-	if (dev->emac_irq)
-		irq_dispose_mapping(dev->emac_irq);
  err_gone:
 	/* if we were on the bootlist, remove us as we won't show up and
 	 * wake up all waiters to notify them in case they were waiting
@@ -3284,9 +3278,6 @@ static void emac_remove(struct platform_device *ofdev)
 
 	if (dev->wol_irq)
 		irq_dispose_mapping(dev->wol_irq);
-	if (dev->emac_irq)
-		irq_dispose_mapping(dev->emac_irq);
-
 }
 
 /* XXX Features in here should be replaced by properties... */
-- 
2.46.0


