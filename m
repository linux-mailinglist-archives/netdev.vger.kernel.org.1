Return-Path: <netdev+bounces-100564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A35D8FB353
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A4F5B25B4C
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 13:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB59146A83;
	Tue,  4 Jun 2024 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="CXcRVcpB"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0B28BF7
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717506938; cv=none; b=OGKS0eKCcXHiW0U3+oasnByXCY5hPbBaHiPBvjKzpA+cshEMk80gxHl2YTHfRbLsKPy0dw9FR0bhLaOmqn2F7xDNSZO01AnJ1Fgl91ZeEMcAbBSLC4dtF8TOCmwOH2ljTmvwSYEYQNQL0JZJ12drJiO259S/pVAApzHpKaE2iAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717506938; c=relaxed/simple;
	bh=atMXczjLyf8GAjV1Wp38xZVTh5h1FyoEieam3CEu9ro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ez45Dvq7/vaaVcQsAb8snLIsbuLwIXJyDcbrsJHaZp7ya7XZT7oDUjhH5DUPs5shtnwY9tIZFb65F4VCMjOwt2CtqiT88AtBsEkEqBDFVtXrjgDOIyfelbW0Xh8EisUzE8VhewgN2pXlpJOrXIj5+cJ0r2oyjxiVyIHpqpodfrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=CXcRVcpB; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240604131527acda6f151570674302
        for <netdev@vger.kernel.org>;
        Tue, 04 Jun 2024 15:15:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=gyr1CD+UnLkCQ5vXJuQGttb1QaQr4bwr82HurIQkO2o=;
 b=CXcRVcpB+cokNNqxkt9cPkSKynEy2WGzvg4CfRiVMmEWhmSAszaofTzAEI2CpkVvYehp2p
 tmA/7y5D0lpX1jHBXH0d2LCPWztf53L/MtM2g5wFHgsX2EtkK1XYK+rWsXuPJ2y4k43JuE5Y
 8optpE5fsZ2dkaP1d7hTwjZB28BFA=;
From: Diogo Ivo <diogo.ivo@siemens.com>
Date: Tue, 04 Jun 2024 14:15:10 +0100
Subject: [PATCH net-next v2 1/3] net: ti: icssg-prueth: Enable PTP
 timestamping support for SR1.0 devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-iep-v2-1-ea8e1c0a5686@siemens.com>
References: <20240604-iep-v2-0-ea8e1c0a5686@siemens.com>
In-Reply-To: <20240604-iep-v2-0-ea8e1c0a5686@siemens.com>
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
 Diogo Ivo <diogo.ivo@siemens.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717506924; l=3085;
 i=diogo.ivo@siemens.com; s=20240529; h=from:subject:message-id;
 bh=atMXczjLyf8GAjV1Wp38xZVTh5h1FyoEieam3CEu9ro=;
 b=MHuyIRXScvlOzyj+7BlmPGj7tdOD60gxU9q5nw8OI71GluXik7fa0TU0cTTsznh9trx3JbTIH
 xY7Uu4T811hAOyIA5Rp0/cobtwk1gpqurTXmkb9vZqzvfwEjd2OMuQh
X-Developer-Key: i=diogo.ivo@siemens.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Enable PTP support for AM65x SR1.0 devices by registering with the IEP
infrastructure in order to expose a PTP clock to userspace.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
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


