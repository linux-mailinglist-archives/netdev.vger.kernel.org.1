Return-Path: <netdev+bounces-104156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E03690B586
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0525283830
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B979314B962;
	Mon, 17 Jun 2024 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="XgHjtcMw"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CCF146D77;
	Mon, 17 Jun 2024 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718639254; cv=none; b=sOiIausTe0/pHohNkvbvdimTouIgM7O/AQqz9CX5FMrbhL0CbQJnKEPjTSBM+z2ONm5hTXITf2RUI6ea97YGNNXljpVgx8LFoR6WSgjOTlRIde7mxpxnPIi+PHDzqigiRP4ztVLWlO42FcL+IFe8B1raJK0iEwFk0+0jIj564gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718639254; c=relaxed/simple;
	bh=0niStB/NLbg3eeXWTY6CwHcOhx+2lEBEmTzt5zp5qUY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tRptFglG8AEUE3YE/gYmNFGyzScCUnEFIoCTVOCYLRfpUETJqCEU1ILuiwNpER3WbmIxMV6oOyJ7CilhY8Yqsj910PoodJ1yP7yuC1VMrtRNQ1r3e+z4b27f6E3ON0Ui5dBcaUBlqIosGexGmWoxcDRWY3+fTbdl/oybdm/clvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=XgHjtcMw; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HDT8vt003715;
	Mon, 17 Jun 2024 17:46:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=qrP88rqf3P2C1jMZG6SITf
	Ge6w2GJOwUx9Atbrod1UM=; b=XgHjtcMwp3OCLfaXrq7OGRMmiNxuKEikDleOXW
	Zww6SOvlastGEs69flIdp227WNDIrvBlbrM9IzvF2eVkQRUrhicW3aPA643OzhjM
	1jclUspsTh4w9oMndOrw5tsJiqxelSjqx3mE6qC7Ia+OksfM8jlfLxmjL1xicDn+
	WNhCJF/oGtAj8zw2UZc25hLCF6XmpVXkL5qIF/Y/WSHhXldVymijBB4r39W635Y5
	Yz/HtJWjEljCKxhjl3+Gbpt3pTtFWFzkvH2RKWXUGQcs4Frp1ntMZOgPzYaYNh73
	EX/TPkvDdara3mKoL3gr0WONRpHalWQvvEga/zmr6LLi7oQg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ys0cg7g69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 17:46:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 164FA40045;
	Mon, 17 Jun 2024 17:46:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8D30320B604;
	Mon, 17 Jun 2024 17:45:26 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 17 Jun
 2024 17:45:26 +0200
From: Christophe Roullier <christophe.roullier@foss.st.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        Marek Vasut <marex@denx.de>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [net-next,PATCH v2 0/2] Series to deliver Ethernet for STM32MP25
Date: Mon, 17 Jun 2024 17:45:14 +0200
Message-ID: <20240617154516.277205-1-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01

STM32MP25 is STM32 SOC with 2 GMACs instances.
    GMAC IP version is SNPS 5.3x.
    GMAC IP configure with 2 RX and 4 TX queue.
    DMA HW capability register supported
    RX Checksum Offload Engine supported
    TX Checksum insertion supported
    Wake-Up On Lan supported
    TSO supported

V2: - Remark from Marek (sort compatible in YAML, change in glue to simplify)

Christophe Roullier (2):
  dt-bindings: net: add STM32MP25 compatible in documentation for stm32
  net: stmmac: dwmac-stm32: stm32: add management of stm32mp25 for stm32

 .../devicetree/bindings/net/stm32-dwmac.yaml  |  8 +-
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 77 ++++++++++++++++++-
 2 files changed, 81 insertions(+), 4 deletions(-)


base-commit: 4314175af49668ab20c0d60d7d7657986e1d0c7c
-- 
2.25.1


