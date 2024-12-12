Return-Path: <netdev+bounces-151418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9FF9EEA15
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 16:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BBBC283EB7
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F8D21766D;
	Thu, 12 Dec 2024 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="04ELYYxI"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BB8216E28
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016100; cv=none; b=R9+mXfa5bLkTJySCnrvNOnvYHBiQbxJ/Uw4jIIABX2bzR+DSKc0+mNWOUHld/y/lU/nryZVItUGPaj3XpgNwNrltFC+T4erip7UO/Z5wVLywVXMRDRGakdI8NQKuINyDOC6UKw7SgKiHyLxLOkftQo4VKbR/TacFTZfIS5i1tyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016100; c=relaxed/simple;
	bh=+7O0RmmHqwrM9kMNqvav3i1OfuJdPljrnHD4cpnI/G8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LO9EPlyP5NR3tRVu3vu0y0QWZre2BlHN5M2H+LMqa2bKuBaG6OiE7r8ddp5VeQM84TOY5NZebFRMqhFGKzjuY7fUzcpOmaMfFVOti1ssGbZnS2gTc1QnRgrqYB/gxRiCL79xeZZcb8VLoUVrbaJBww/9yJsvPclBr7cfegvz1GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=04ELYYxI; arc=none smtp.client-ip=17.58.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734016098;
	bh=nBwg5SgFJ0YuHeMTxVxfwVZNyX8XQSrvTDjypgzv0C8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=04ELYYxISWGBso0w4oNc1H8bIR+pIUEQPqFgwHd7xoS2ryIj0ZJ1TvOZNfVZJ1c/4
	 BGvvvvPrMwDoZUBdnnPfCvKGYosSfglSdx+qZoqsB1N9usDlVRZs5WUxlsZB17j/+1
	 krfVttqf0TJ6qQys2GrqJ9XDf4tAn6gBlcQnYv62DNAJ6vux95qbqhFyBIp/c9GLDd
	 TvW2xnXyAVhQ7fqRmjDrPgA6YRdVlM10Ww2vUe2XL6btGhwYzid7c1pSYC1brgwOhA
	 Od2AWXgI+wx08oRtdflUpigW7TToMP/ZTDpQq1HoxjcAouagx38TYOJMCupagQmxwD
	 JIvI7eDAZ40Rg==
Received: from [192.168.29.172] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id D029534BAA11;
	Thu, 12 Dec 2024 15:08:08 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 12 Dec 2024 23:06:55 +0800
Subject: [PATCH net 2/2] net: bcmasp: Fix device node refcount leakage in
 bcmasp_probe()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-drivers_fix-v1-2-a3fbb0bf6846@quicinc.com>
References: <20241212-drivers_fix-v1-0-a3fbb0bf6846@quicinc.com>
In-Reply-To: <20241212-drivers_fix-v1-0-a3fbb0bf6846@quicinc.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Justin Chen <justin.chen@broadcom.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Simon Horman <horms@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: UoyjhtGHkmSpiV9fF1aCE9LWjIOYZlxW
X-Proofpoint-ORIG-GUID: UoyjhtGHkmSpiV9fF1aCE9LWjIOYZlxW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_09,2024-12-12_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412120110
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

bcmasp_probe() invokes of_find_node_by_name(@dev->of_node, ...) and the
callee will put OF device node @dev->of_node refcount, but the caller
does not compensate the refcount before the invocation, so causes the node
refcount leakage.

Fix by of_node_get(@dev->of_node) before the invocation.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 297c2682a9cf979fbc4af211139f1b1ed0df01d5..517593c5894568111111aff0f6919fb02d780c85 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1367,6 +1367,7 @@ static int bcmasp_probe(struct platform_device *pdev)
 	bcmasp_core_init(priv);
 	bcmasp_core_init_filters(priv);
 
+	of_node_get(dev->of_node);
 	ports_node = of_find_node_by_name(dev->of_node, "ethernet-ports");
 	if (!ports_node) {
 		dev_warn(dev, "No ports found\n");

-- 
2.34.1


