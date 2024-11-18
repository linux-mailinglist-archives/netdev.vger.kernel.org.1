Return-Path: <netdev+bounces-145797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 041B69D0EE1
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 11:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B8E1F21FA4
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 10:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5BA1990DC;
	Mon, 18 Nov 2024 10:47:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A288196C6C;
	Mon, 18 Nov 2024 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926878; cv=none; b=hMmXEybEXcaYOIf3IAIgD+LDoM3MVeWjPtRJalErPizSvx7Kg0RiY9ERcT1rsNLIeRlhV1Dz8b5lVJRzgWooM1YRxxaZKVfcy2vsoaY/BvvKVbIuSf+Gf2pNF3hETv2uT+fD3sA84bL1tmosV/EHw8EWGcLUURx6VGJaqmiZ3BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926878; c=relaxed/simple;
	bh=dXLOxAWUC9uvWEp4IdnazNBiiiYWM19Awg/Y3cHQtN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWn8mdW0RvqXyIajpSPWo4UrKyF3R+jJGaBmQj5L9Eg3ZZkb5xSg/VA5pi1xCOX3zaSbK7vZA5+HYHOJmawRxC8KDPeHnPkX1JZJaelP+aZFEyKECpnHR8Y0boXtgH3MpcRAFaq9ILhIeShnVEQCxQ/eRmKzTIgXCp1o6QPvQvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 18 Nov
 2024 18:47:35 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 18 Nov 2024 18:47:35 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [net-next 2/3] net: mdio: aspeed: Add support for AST2700
Date: Mon, 18 Nov 2024 18:47:34 +0800
Message-ID: <20241118104735.3741749-3-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
References: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The Aspeed 7th generation SoC features three Aspeed MDIO.
The design of AST2700 MDIO controller is the same as AST2600.
Therefore, just add AST2700 compatible here.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/mdio/mdio-aspeed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
index e55be6dc9ae7..4d5a115baf85 100644
--- a/drivers/net/mdio/mdio-aspeed.c
+++ b/drivers/net/mdio/mdio-aspeed.c
@@ -188,6 +188,7 @@ static void aspeed_mdio_remove(struct platform_device *pdev)
 
 static const struct of_device_id aspeed_mdio_of_match[] = {
 	{ .compatible = "aspeed,ast2600-mdio", },
+	{ .compatible = "aspeed,ast2700-mdio", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, aspeed_mdio_of_match);
-- 
2.25.1


