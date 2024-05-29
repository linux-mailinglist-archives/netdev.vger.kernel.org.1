Return-Path: <netdev+bounces-99117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888398D3BD1
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF731C206A7
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7431187342;
	Wed, 29 May 2024 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="jYAPhQ+s"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD75B1836FD
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998745; cv=none; b=ALf4+0JF2f18jr7vIIBpi2KuKDa7ei2bu6hwzJyMIRi+SXD+fPCrKFfyXryjoLluqqMzo2q2UE6KlkV6oCXFrVMeVYTvUllu9kloKtuyb+1ciciCGVYXWpULThGL1Ndy7um0J7ZKgQ+1v17FOpNI0jyol6LxLey8hF+EftwdPTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998745; c=relaxed/simple;
	bh=3oNbe7+kl949vpSxjYDcQs/lpiG/Vv5Of/GL7kFfQV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KWJ0h8bFszOxCBSfkIeE4zrmG7VcOjV9rC7QzIaV5q2SLrNElS7zJKrNwRb/IL80vBUsQDTFqKd7OChOjVIX6W6BV+LqqtJDCNNsYBLd0ABcUUny02jptHNvkzlsm1AqlTcwXTgeR/l4H9rlgd47lCJ+MchLCmt0nbS26wMlr2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=jYAPhQ+s; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202405291605340a8599fcbb0bd62077
        for <netdev@vger.kernel.org>;
        Wed, 29 May 2024 18:05:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=t0N1v6lGOWmbUT2zPk1pBlnpA8KnITb1ou0m2UPQizo=;
 b=jYAPhQ+sPK401ZFkELi4ZYu1n6CQmj8eOgGVaGjv+JIi8P2Z3kVAr7ylkgSdejxVQ/o8Yd
 RyvwOg8ge+rV2/CETuM5SGkDJfhOhOJadRzU/Sq2CGDkoh87zXaN5T/2uXneCKGYebwksX/l
 8qtPPfKJ0wYdUup8TPrw5NJ/Q9Nj4=;
From: Diogo Ivo <diogo.ivo@siemens.com>
Date: Wed, 29 May 2024 17:05:10 +0100
Subject: [PATCH 1/3] net: ti: icssg-prueth: Enable PTP timestamping support
 for SR1.0 devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-iep-v1-1-7273c07592d3@siemens.com>
References: <20240529-iep-v1-0-7273c07592d3@siemens.com>
In-Reply-To: <20240529-iep-v1-0-7273c07592d3@siemens.com>
To: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Diogo Ivo <diogo.ivo@siemens.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716998732; l=3011;
 i=diogo.ivo@siemens.com; s=20240529; h=from:subject:message-id;
 bh=3oNbe7+kl949vpSxjYDcQs/lpiG/Vv5Of/GL7kFfQV4=;
 b=8GNTjGB2viq7HJxCXsyDfzcZ62uwz78d5Ex2SZIOKIvNum45Vl7fAHZKU017hReeDpGJV1/p7
 YiKGMWTfgv6DTLFGOTd+HryoVUFc6foZcvKzicEhmWjzF1H+gIuKwF9
X-Developer-Key: i=diogo.ivo@siemens.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Enable PTP support for AM65x SR1.0 devices by registering with the IEP
infrastructure in order to expose a PTP clock to userspace.

Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c | 49 +++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
index 7b3304bbd7fc..01cad01965dc 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
@@ -1011,16 +1011,42 @@ static int prueth_probe(struct platform_device *pdev)
 	dev_dbg(dev, "sram: pa %llx va %p size %zx\n", prueth->msmcram.pa,
 		prueth->msmcram.va, prueth->msmcram.size);
 
+	prueth->iep0 = icss_iep_get_idx(np, 0);
+	if (IS_ERR(prueth->iep0)) {
+		ret = dev_err_probe(dev, PTR_ERR(prueth->iep0), "iep0 get failed\n");
+		goto free_pool;
+	}
+
+	prueth->iep1 = icss_iep_get_idx(np, 1);
+	if (IS_ERR(prueth->iep1)) {
+		ret = dev_err_probe(dev, PTR_ERR(prueth->iep1), "iep1 get failed\n");
+		goto put_iep0;
+	}
+
+	ret = icss_iep_init(prueth->iep0, NULL, NULL, 0);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to init iep0\n");
+		goto put_iep;
+	}
+
+	ret = icss_iep_init(prueth->iep1, NULL, NULL, 0);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to init iep1\n");
+		goto exit_iep0;
+	}
+
 	if (eth0_node) {
 		ret = prueth_netdev_init(prueth, eth0_node);
 		if (ret) {
 			dev_err_probe(dev, ret, "netdev init %s failed\n",
 				      eth0_node->name);
-			goto free_pool;
+			goto exit_iep;
 		}
 
 		if (of_find_property(eth0_node, "ti,half-duplex-capable", NULL))
 			prueth->emac[PRUETH_MAC0]->half_duplex = 1;
+
+		prueth->emac[PRUETH_MAC0]->iep = prueth->iep0;
 	}
 
 	if (eth1_node) {
@@ -1033,6 +1059,8 @@ static int prueth_probe(struct platform_device *pdev)
 
 		if (of_find_property(eth1_node, "ti,half-duplex-capable", NULL))
 			prueth->emac[PRUETH_MAC1]->half_duplex = 1;
+
+		prueth->emac[PRUETH_MAC1]->iep = prueth->iep1;
 	}
 
 	/* register the network devices */
@@ -1091,6 +1119,19 @@ static int prueth_probe(struct platform_device *pdev)
 		prueth_netdev_exit(prueth, eth_node);
 	}
 
+exit_iep:
+	icss_iep_exit(prueth->iep1);
+exit_iep0:
+	icss_iep_exit(prueth->iep0);
+
+put_iep:
+	icss_iep_put(prueth->iep1);
+
+put_iep0:
+	icss_iep_put(prueth->iep0);
+	prueth->iep0 = NULL;
+	prueth->iep1 = NULL;
+
 free_pool:
 	gen_pool_free(prueth->sram_pool,
 		      (unsigned long)prueth->msmcram.va, msmc_ram_size);
@@ -1138,6 +1179,12 @@ static void prueth_remove(struct platform_device *pdev)
 		prueth_netdev_exit(prueth, eth_node);
 	}
 
+	icss_iep_exit(prueth->iep1);
+	icss_iep_exit(prueth->iep0);
+
+	icss_iep_put(prueth->iep1);
+	icss_iep_put(prueth->iep0);
+
 	gen_pool_free(prueth->sram_pool,
 		      (unsigned long)prueth->msmcram.va,
 		      MSMC_RAM_SIZE_SR1);

-- 
2.45.1


