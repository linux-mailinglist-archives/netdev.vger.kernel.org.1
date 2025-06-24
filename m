Return-Path: <netdev+bounces-200731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1798DAE69CA
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBC03BB04E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775132E2F07;
	Tue, 24 Jun 2025 14:43:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616662E175F;
	Tue, 24 Jun 2025 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776199; cv=none; b=tbgAliUlB9Fnd/TNSfSTXbQXVJ8sMh9TurXT8lPi6Ac9NxdaCpC6hE40DkWfYvlRA+SKT1Fm0U6nYgm6KOMbVJySUZRWTWK/yNbEWB4P54bTewevmYnUAfA+gEdD/HBG1y7141qwCN9Bzpo55Xl3lZeHrkvrzu8bddIwZZTrzoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776199; c=relaxed/simple;
	bh=gm05zOftEwfrXqVxKIbq5Eu6YqOXsIaRljvnTWIMGh8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CwOcB8H5olJY6lXVobVJ0bq+H6SMdOtsg+hgyf09EVYNla6SOjiNxspfXwW5m9SD3ULhX+Uzx7SzM3g3RFJ5fJohMC/wGd+2VbiBCkagbSQydMrgRe4kzp4cA1/1U0A7cekk/MRK+blVyD4DEVWGRNaeMJgHmYn5tjd8+NU3AsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <ioana.ciornei@nxp.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Fushuai Wang
	<wangfushuai@baidu.com>
Subject: [PATCH net] dpaa2-eth: fix xdp_rxq_info leak in dpaa2_eth_setup_rx_flow
Date: Tue, 24 Jun 2025 22:42:35 +0800
Message-ID: <20250624144235.69622-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc3.internal.baidu.com (172.31.50.47) To
 bjkjy-mail-ex22.internal.baidu.com (172.31.50.16)
X-FEAS-Client-IP: 172.31.50.16
X-FE-Policy-ID: 52:10:53:SYSTEM

When xdp_rxq_info_reg_mem_model() fails after a successful
xdp_rxq_info_reg(), the kernel may leaks the registered RXQ
info structure. Fix this by calling xdp_rxq_info_unreg() in
the error path, ensuring proper cleanup when memory model
registration fails.

Fixes: d678be1dc1ec ("dpaa2-eth: add XDP_REDIRECT support")
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 2ec2c3dab250..b4a62eae4719 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -3939,6 +3939,7 @@ static int dpaa2_eth_setup_rx_flow(struct dpaa2_eth_priv *priv,
 					 MEM_TYPE_PAGE_ORDER0, NULL);
 	if (err) {
 		dev_err(dev, "xdp_rxq_info_reg_mem_model failed\n");
+		xdp_rxq_info_unreg(&fq->channel->xdp_rxq);
 		return err;
 	}
 
-- 
2.36.1


