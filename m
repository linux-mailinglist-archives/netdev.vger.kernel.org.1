Return-Path: <netdev+bounces-104869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 270B190EBC9
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 15:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EFF61C247B0
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 13:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD5A145324;
	Wed, 19 Jun 2024 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="lbv/A1p4"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D03143C4A;
	Wed, 19 Jun 2024 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802037; cv=none; b=jQw9NKdHfCLFe8EJ2w1xIToWNBiTaI9heSEBkY3HbZjbzrvzIXfL+tAOq0tk6fYl52gYBplhfUxaYvDDJXJSZ7NdqU65dfxbPSj6uKb5RQpKDbsM2BOW8NRKn0EJcD8Ij975O6k3KxOhwihuDNwG1dhldsZTs/7gn/RNBvBzpLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802037; c=relaxed/simple;
	bh=wGsHVpUhx8u7UWvfdCV5T02rdiVagUfMDEdPxQUkujs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sN54QXM2X/YcqUb1VJ8MX2Q3jbS7tupKmxPHJTNvmNBmaIRu5uC25duqpkERD1M5Vm5w/uEHNuUbMT2Xp9alHG13xIOPD9hghUEKXMY4zn7HfrMKrJy6meLY8hT0c4XzacAS70V8OcnvqUuURR8vwlrj9LNHeJ8lr9poBz3klX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=lbv/A1p4; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JCUgjG015592;
	Wed, 19 Jun 2024 14:59:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=ZTHr4jtqthDuPTM+Ut5COe
	zygMaELP2cVjzMdgCvEqw=; b=lbv/A1p4sqIydRgO0HzEE7ugtTZXTIS2Nv8L2c
	yt/EXiVZJrGOLSkTNwbDGqR72/JyJP4q6CWjwXDa9tWPwIwY3kmpnAng1a5u8By4
	Qhxed0NBzF0vmO5LmxTxgGwuqrdOjX7cGNddifw4O3Jwadtl4pi6J23rpVIt5U9M
	Ef9wBiZST9ex9Lyd/30mxtesDamO7fSS06xpfVUpCQR0w+V/+AQ9uRBGfrcUCycm
	DuZE2duujj8R3eZaT+UipMrhZlZNYhAxjpALI6zt1OFJcxNGAfSpDVhMGH1skgF7
	pcXAuGxUjIbqcgG6k6uSMBhXBaFgt8i8x6bATtwmoTI+OUOg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yuj9s39nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 14:59:50 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9AA5140044;
	Wed, 19 Jun 2024 14:59:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E1C31218626;
	Wed, 19 Jun 2024 14:58:28 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 19 Jun
 2024 14:58:28 +0200
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
Subject: [PATCH v2 0/3] Series DTs to deliver Ethernet for STM32MP25
Date: Wed, 19 Jun 2024 14:58:12 +0200
Message-ID: <20240619125815.358207-1-christophe.roullier@foss.st.com>
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
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01

STM32MP25 is STM32 SOC with 2 GMACs instances.
    GMAC IP version is SNPS 5.3x.
    GMAC IP configure with 2 RX and 4 TX queue.
    DMA HW capability register supported
    RX Checksum Offload Engine supported
    TX Checksum insertion supported
    Wake-Up On Lan supported
    TSO supported

Delivered Ethernet2 instance for board EV1 which is connected 
to Realtek PHY in RGMII mode.
Ethernet1 instance will be delivered in next step.

V2: - Remark from Marek (sort DT)

Christophe Roullier (3):
  arm64: dts: st: add ethernet1 and ethernet2 support on stm32mp25
  arm64: dts: st: add eth2 pinctrl entries in stm32mp25-pinctrl.dtsi
  arm64: dts: st: enable Ethernet2 on stm32mp257f-ev1 board

 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi | 59 +++++++++++++++++++
 arch/arm64/boot/dts/st/stm32mp251.dtsi        | 49 +++++++++++++++
 arch/arm64/boot/dts/st/stm32mp253.dtsi        | 51 ++++++++++++++++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    | 24 ++++++++
 4 files changed, 183 insertions(+)


base-commit: 382d1741b5b2feffef7942dd074206372afe1a96
-- 
2.25.1


