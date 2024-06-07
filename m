Return-Path: <netdev+bounces-101720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D388FFDEE
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 10:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813A51C232E7
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 08:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6036515A873;
	Fri,  7 Jun 2024 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="V+hZ8qVS"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE9C15381F;
	Fri,  7 Jun 2024 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717748384; cv=none; b=HVfDJrUvxpyQZlhQEYJTxsKCVE5K7chdbqSmxT4qwW7TyssmA9Sr5km6xYaWTJw5kxHUpsiMj5m2PoXWVF/ia8TAsFr9AcItZa4egcmpF/sZKnPKTM5Uw48P2MQYSO4XIkf9qJSA+aB2yEgaiBC6M5rQN2XNOrdv2szZx/Boj5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717748384; c=relaxed/simple;
	bh=8ylq6lTmAICvJ78ovAeFFxwYjpztjGrZBRXCN4JMfuw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JgN3eTQfLcnxJVrcmpvyJLO52XC9zVEfHjCDwVeDayXoNr7Qlp+SiC1vEwQRY9Ih10SYj6iSbj/Bo1ciO4fE5HrTiRTb83oSum39yQPX+NoSvijMnv9/m6ywsiBl49uS1GSJ3WPr/pqWuWuH0fgEIweemuV8sD96z/RbyyXLp0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=V+hZ8qVS; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 1EC07A041E;
	Fri,  7 Jun 2024 10:19:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=wg6qi7CwlG9mPI6UdwwMmwNTJpAiHxal7cH+O7K8jiE=; b=
	V+hZ8qVSziVHanXhxnf5+l5T8lhFnPf3WbTtMhh9mIwqxde3ceKpv8MK1K464NGC
	dgQlb3gp1+EEH1B7w1tqVS2HX5KlfRPniKxD9pOJWYtSfE0VfPJnbBOydx7Mwmz0
	kXQV30RTeh2T3WiRkgwY/EH+2unCA5bZF7yYLJOHyT3KLEMhBGA/cS44mwp+gLIr
	OpxTXh8ZpGzZJFv9KPfFi9FQE0+dYjnIbch2INK35TvXITGLKYk7sO6IRFNmmSfv
	SXe0BCmV5mlO/Ljeg8k3U/4IOASRVAi98NnVO0cna3FlabHT9kZmBlGXw+LSM3cU
	kgvbYs5fhMx3ANzBDFYQa/FmsNeV9hgHo/xQUHSmtIPddNVJBs3WNP0Yze1Zd7lF
	Nqs9TUCDXCi2zdXYAiWn6z8Eh9Xffg6if5ItsQAdu5i4WmGvTwYCN6ydcGLP08KB
	8ffNCf3d202CNMQUUpDXfw2HOdonumwbtZ1bX7xdVfPep0BJAG8BriuttgXmW9I2
	y9MsalHyN/aT6Z/mm0XACJu1gBjVzQFtIr2CV2NrKI0Twv2Mpl5NXx48nJW5t4ef
	zFPz6FbooLpQTgKhbyGA5XgJNRbEvpErbndO7ML2iB1yTz3mTH3AoZiEbJJ9iRA8
	BozzBl0+EEVyMvn9YHzoamYq4dOgbaxxV03oT2dpJ4A=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Wei Fang
	<wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH v2] net: fec: Add ECR bit macros, fix FEC_ECR_EN1588 being cleared on link-down
Date: Fri, 7 Jun 2024 10:18:55 +0200
Message-ID: <20240607081855.132741-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1717748379;VERSION=7972;MC=3391927748;ID=131151;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2945A12957627061

FEC_ECR_EN1588 bit gets cleared after MAC reset in `fec_stop()`, which
makes all 1588 functionality shut down on link-down. However, some
functionality needs to be retained (e.g. PPS) even without link.

Signed-off-by: "Csókás, Bence" <csokas.bence@prolan.hu>
---
 drivers/net/ethernet/freescale/fec_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 881ece735dcf..fb19295529a2 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1361,6 +1361,12 @@ fec_stop(struct net_device *ndev)
 		writel(FEC_ECR_ETHEREN, fep->hwp + FEC_ECNTRL);
 		writel(rmii_mode, fep->hwp + FEC_R_CNTRL);
 	}
+
+	if (fep->bufdesc_ex) {
+		val = readl(fep->hwp + FEC_ECNTRL);
+		val |= FEC_ECR_EN1588;
+		writel(val, fep->hwp + FEC_ECNTRL);
+	}
 }
 
 static void
-- 
2.34.1



