Return-Path: <netdev+bounces-102165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC167901BA1
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 09:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970F01F22215
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 07:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFDD1E876;
	Mon, 10 Jun 2024 07:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VeBkoF70"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA321946F;
	Mon, 10 Jun 2024 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718003851; cv=none; b=e29mNPcmxruetI1K/YLNKIx19E6K7Mi+twImpudIOCxGMuiNzf0ZxFLP/lf62wbGZJtrN1DeHj0+eica7J9l5nfDU5MDRAHkNhXZ1atdGZKA8NUJC/vXmGTV5v98M2H2jbHkrxouR+ynq+qaJ/l2CIy03jOAOc8UpXuDs5c5xSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718003851; c=relaxed/simple;
	bh=HL1/PgFcmvtq8Mgs03MygUKUe0HGx+ZKEBK7mpchO1c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SWT2FGVQsAZdaiZkQS4paB7gyuOWqDACfTWuYF6KxmUwKTL6HekPNN2woAc8mQazc/gofRCt+Ch7WKBHAtxAtQXrPVG7a2t1g+WNC45G6T2G592kl2cJhz+kFA3RSo0Ck8BX4VG8iRGhUwOV9KPm19ZXFx+tHgWlOB+rqtUa7Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VeBkoF70; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 459Lv4or018093;
	Mon, 10 Jun 2024 09:16:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=ywgMJ0d2V3+vIlguLKK9it
	AB89YC4L19ERf/9tF4bzM=; b=VeBkoF70/fwECtDm4mHRr0Zb2ky3B6Yvxu6Rj/
	BVbEoElFZzv1eAOAYlfs5z6718PeInL+KrTc7o1TOkKScQFd6pH1wNfhg2EuCxFF
	NzZMR+bUqseslvwu71xf0PJzXpe2qE8zdAWXZAHXyusuMcMX+199nWP/XHN8ZLke
	Y4JsajJzcWgxvM7a+qCUy67pzhRzWBKJtX2dFRvHg7b0YxgKGeXmJXkpUrpX26OE
	kD3Uy8xYQADW2zeIFbfGDwm0T7t+/Zx677yd2iLspK2S+Bl0u9PLCpU4YHAI0IMd
	Rkt8n3NC8nHd04kzVRyMEQ59R5ixRIfP7f9WTLCuhoyoPpDQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yme6d5cb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 09:16:55 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2B42D40047;
	Mon, 10 Jun 2024 09:16:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 75074210757;
	Mon, 10 Jun 2024 09:15:07 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 10 Jun
 2024 09:15:07 +0200
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
Subject: [net-next,PATCH v6 0/8] Series to deliver Ethernet for STM32MP13
Date: Mon, 10 Jun 2024 09:14:51 +0200
Message-ID: <20240610071459.287500-1-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-06_02,2024-05-17_01

STM32MP13 is STM32 SOC with 2 GMACs instances
    GMAC IP version is SNPS 4.20.
    GMAC IP configure with 1 RX and 1 TX queue.
    DMA HW capability register supported
    RX Checksum Offload Engine supported
    TX Checksum insertion supported
    Wake-Up On Lan supported
    TSO supported
Rework dwmac glue to simplify management for next stm32 (integrate RFC from Marek)

V2: - Remark from Rob Herring (add Krzysztof's ack in patch 02/11, update in yaml)
      Remark from Serge Semin (upate commits msg)
V3: - Remove PHY regulator patch and Ethernet2 DT because need to clarify how to
      manage PHY regulator (in glue or PHY side)
    - Integrate RFC from Marek
    - Remark from Rob Herring in YAML documentation
V4: - Remark from Marek (remove max-speed, extra space in DT, update commit msg)
    - Remark from Rasmus (add sign-off, add base-commit)
    - Remark from Sai Krishna Gajula
V5: - Fix warning during build CHECK_DTBS
    - Remark from Marek (glue + DT update)
    - Remark from Krzysztof about YAML (Make it symmetric)
V6: - Replace pr_debug by dev_dbg
    - Split serie driver/DTs separately 

Christophe Roullier (3):
  dt-bindings: net: add STM32MP13 compatible in documentation for stm32
  net: stmmac: dwmac-stm32: Mask support for PMCR configuration
  net: stmmac: dwmac-stm32: add management of stm32mp13 for stm32

Marek Vasut (5):
  net: stmmac: dwmac-stm32: Separate out external clock rate validation
  net: stmmac: dwmac-stm32: Separate out external clock selector
  net: stmmac: dwmac-stm32: Extract PMCR configuration
  net: stmmac: dwmac-stm32: Clean up the debug prints
  net: stmmac: dwmac-stm32: Fix Mhz to MHz

 .../devicetree/bindings/net/stm32-dwmac.yaml  |  43 ++++-
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 174 +++++++++++++-----
 2 files changed, 169 insertions(+), 48 deletions(-)


base-commit: 28f961f9d5b7c3d9b9f93cc59e54477ba1278cf9
-- 
2.25.1


