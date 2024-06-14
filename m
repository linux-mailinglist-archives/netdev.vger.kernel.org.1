Return-Path: <netdev+bounces-103602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D0C908C4B
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 15:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51D6289AB8
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 13:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7805C19A2A9;
	Fri, 14 Jun 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="U8DNlf1x"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784111991B3;
	Fri, 14 Jun 2024 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718370639; cv=none; b=Qfbkibdc8aQFU0Kz0IFTQKqqHiPH1yh899xNI83ir5Opqgz2fN2Wy/j2foddKyCIiy/MLR7Evg0DmVTp9Ys5CD7GJqLz2HCPrm08pd3fl/4TJ2L7FqgF8ByssHiys4F6m3PqAvRFZMm8CwTbXtj0uK2SkCih4i3G2aOQ8JDH684=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718370639; c=relaxed/simple;
	bh=jzwkfggLDXFJDcRbziWhvAco8PbVOMWsz0rQYdDWX58=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pM22Q8wyBwMvHlKjs3jjYUoSV6xQJOtBMc8c1Dfaro/OfTuqnoRfZDQzd3Cuw+qlV8/Oue58JqfsPZ5p+OZ2t4Sxiz5p/82OY/oyQre4HzKXCB4No5eQfvZu82jeH0MR87G0LGmDQFhOXuwagPVJEU5ehdG1gCMu73pOfZaCBdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=U8DNlf1x; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EAWa9V026928;
	Fri, 14 Jun 2024 15:09:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=u88B3uHAwNfzN7+owQRQcC
	LwIQp1OrA8QpebdDFwe/o=; b=U8DNlf1xzJ9iYyIiP7Tljjc9V/cK9rd5fi4d3s
	ofUxQYPsWHbPI9MSpuxKqZrO69BT++q+9wgWGixTiulNdmAzqtToXWJYVtSIghSr
	Lx6TTkbIdfvKhAoMRXZoDvGce4n8FXHgqKrLXau5WoEPFK+0KnpV2vBl5mmvownB
	qGGo3jucZA5n92qOwjdXmBLegW/5TO46SpZgA0ps15i2wRAaz/TYiNOfylHc6TZe
	kKi0v7/QPcJBWyp9ZDnRJ6Kh4bPRrdDcmIJK51geVm9aenUuTFNUtk8oAoDFsU3X
	s8HHBu8s0N5W89IXmkAuUAggmz4MstLdxhyq8CXt35Z+diIQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yrfuj9wsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 15:09:54 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 112AE40046;
	Fri, 14 Jun 2024 15:09:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D14D3214D2E;
	Fri, 14 Jun 2024 15:08:24 +0200 (CEST)
Received: from localhost (10.252.5.68) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 14 Jun
 2024 15:08:21 +0200
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
Subject: [net-next,PATCH 0/2] Series to deliver Ethernet for STM32MP25
Date: Fri, 14 Jun 2024 15:08:10 +0200
Message-ID: <20240614130812.72425-1-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_10,2024-06-14_03,2024-05-17_01

STM32MP25 is STM32 SOC with 2 GMACs instances.
    GMAC IP version is SNPS 5.3x.
    GMAC IP configure with 2 RX and 4 TX queue.
    DMA HW capability register supported
    RX Checksum Offload Engine supported
    TX Checksum insertion supported
    Wake-Up On Lan supported
    TSO supported

Christophe Roullier (2):
  dt-bindings: net: add STM32MP25 compatible in documentation for stm32
  net: stmmac: dwmac-stm32: stm32: add management of stm32mp25 for stm32

 .../devicetree/bindings/net/stm32-dwmac.yaml  |   6 +
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 121 +++++++++++++++---
 2 files changed, 110 insertions(+), 17 deletions(-)


base-commit: 404dbd26322f50c8123bf5bff9a409356889035f
-- 
2.25.1


