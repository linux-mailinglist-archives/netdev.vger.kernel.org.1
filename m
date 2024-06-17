Return-Path: <netdev+bounces-104148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F61E90B51A
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6181F21AFA
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1857D15B14E;
	Mon, 17 Jun 2024 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="CB/FVxKo"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84D615ADAC
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718637757; cv=none; b=f7RLjw44S6B+b8L3CAM5CgIyOfK+wGt7g1oLePUzw8OfJbZ+uiJ/3qOX06BAljTSGUmbAcR9fL9w0MYAywXP9WHI7XYzg4AdmNizRC3UD5A4YJsNkzSVhjXJwZLL70FpjbETOVU7avvtBD2Vi/BX1sLZ5qFRMrk3R2yYtu+sCbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718637757; c=relaxed/simple;
	bh=gVkjhihYssjxx3HmUUIcdEn5ObHN127myBwzSS6vJW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OxDsmjS2pr+swZ3K+OcJlsjRkwtN649AQSJqfCHQprjCrsZnRoXdVR3e2efUFfWDa7LCcdJqB77f7YFKN0tK5TYLc3FTq73vSC+ki96De7L8r46l9QCGIoFS01l2x6IA8ISkwhWxwR3A+aWkLxqHfMdflS/fNvUqVrCnZUwGX0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=CB/FVxKo; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240617152224e47f7f59f1299bb557
        for <netdev@vger.kernel.org>;
        Mon, 17 Jun 2024 17:22:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=x4YRkE+XFm1D29pl4Ld17TEKG1sVow5yeZQG9PSUP5I=;
 b=CB/FVxKoMjqGYkzbJv1QQWSgwJSKYYp+NUVIIuZ7inV8aYM48zBQZJwFvHbvAibvMIRldV
 Si2JRv3IT+ILGEQkH4XgGbm3oxJtWEiXZuw60kecwmikaF5VdE4Qpv+kjL/KHq+4hvNG+4dM
 kMw3mtLQtxWUDqgi254VUbb0i0D2w=;
From: Diogo Ivo <diogo.ivo@siemens.com>
Date: Mon, 17 Jun 2024 16:21:40 +0100
Subject: [PATCH net-next v4 1/5] net: ti: icssg-prueth: Enable PTP
 timestamping support for SR1.0 devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-iep-v4-1-fa20ff4141a3@siemens.com>
References: <20240617-iep-v4-0-fa20ff4141a3@siemens.com>
In-Reply-To: <20240617-iep-v4-0-fa20ff4141a3@siemens.com>
To: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Diogo Ivo <diogo.ivo@siemens.com>, 
 Wojciech Drewek <wojciech.drewek@intel.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718637740; l=3143;
 i=diogo.ivo@siemens.com; s=20240529; h=from:subject:message-id;
 bh=gVkjhihYssjxx3HmUUIcdEn5ObHN127myBwzSS6vJW0=;
 b=Ne4QQFK6QP2v+OQaF2Mwx32o+Eu/500f6KJ6QoKnoUYpnbEN6uIgN3kbTR1HVyy9gq1wudeuy
 PZeFyR9AFhID9sIi0AcbI9ElMgQOirT0djR07GcwdRh9A/tRbGYsiMf
X-Developer-Key: i=diogo.ivo@siemens.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Enable PTP support for AM65x SR1.0 devices by registering with the IEP
infrastructure in order to expose a PTP clock to userspace.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c | 51 +++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
index 7b3304bbd7fc..fa98bdb11ece 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
@@ -1011,16 +1011,44 @@ static int prueth_probe(struct platform_device *pdev)
 	dev_dbg(dev, "sram: pa %llx va %p size %zx\n", prueth->msmcram.pa,
 		prueth->msmcram.va, prueth->msmcram.size);
 
+	prueth->iep0 = icss_iep_get_idx(np, 0);
+	if (IS_ERR(prueth->iep0)) {
+		ret = dev_err_probe(dev, PTR_ERR(prueth->iep0),
+				    "iep0 get failed\n");
+		goto free_pool;
+	}
+
+	prueth->iep1 = icss_iep_get_idx(np, 1);
+	if (IS_ERR(prueth->iep1)) {
+		ret = dev_err_probe(dev, PTR_ERR(prueth->iep1),
+				    "iep1 get failed\n");
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
@@ -1033,6 +1061,8 @@ static int prueth_probe(struct platform_device *pdev)
 
 		if (of_find_property(eth1_node, "ti,half-duplex-capable", NULL))
 			prueth->emac[PRUETH_MAC1]->half_duplex = 1;
+
+		prueth->emac[PRUETH_MAC1]->iep = prueth->iep1;
 	}
 
 	/* register the network devices */
@@ -1091,6 +1121,19 @@ static int prueth_probe(struct platform_device *pdev)
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
@@ -1138,6 +1181,12 @@ static void prueth_remove(struct platform_device *pdev)
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
2.45.2


