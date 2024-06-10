Return-Path: <netdev+bounces-102184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22775901C50
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 10:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488DF1C212D5
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 08:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B5557888;
	Mon, 10 Jun 2024 08:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="EKlc5Pgy"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5075558AD;
	Mon, 10 Jun 2024 08:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718006722; cv=none; b=r7nWiqWgeD7vgNKVcA+p/A87jY3gs8tCvmuinh4XuUNI5nAcxxE0LP9YZaC6JNW8L9WAWNRxE3+MWkbbBvFCDzq4G873pYFVkD/N7P/45qjAEuP2sK27jfR7z6PRsL4DiMKxLnBovl3gTuGmu9n9JsFxWoD5HomKL4fvL3uKGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718006722; c=relaxed/simple;
	bh=DM5/3D0EhcPSfTYo/bsWdkHu5NuG7JJOggRRZv5PDvs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AjcFP7yp7Zna3AktJ130SvD+YvkRQDJAWXMJ0RT9dnZAblyWd+cee7xHrpOEMZLG5ghWesxupDyk4qF5GYYMpBW1QQB9sEz+ZBZFVxHTEnHFvYk3lBkJvtf01FV2qCZFqOl41ovnU6reO7INtDs+C+oCTIevHvFkwSszy4uxFAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=EKlc5Pgy; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A7jaH3009359;
	Mon, 10 Jun 2024 10:04:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=IEtb4KLuy/9rGMriSQ9JkQ
	yG0IXoKUzi25O4/LQFtO8=; b=EKlc5Pgy67pFTY7YxSLbs6/5yrQv1S+vhYh5vB
	LJlrC/eG08VIPRwFPDVRUoEt1FGPpDRaFNoFYK/zZJpGzVPGHrhTBENAw/pLUwcv
	iDxw/qdw7U71jRjBAQWeDOGYaP09P957DxvwjQRB3U0G4WNPooXljE2G4LucP3Eu
	X3Y89juXdKn7LDaS9IFDFExLIHx7bqmVD223SQdFFTRiadUVKWQlRRiToGTnQYsh
	B1IATxlxp5SijUys3MZr0VCtq6DVMpCFSEUdzn4b+/fMxPdp+z6FW7AVXuMLNw7p
	CQQX7D7vh9cYX8CK/E6nAsfYi/gCqRe1/cyTckRsKgAJ26Jw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ymemxnp94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 10:04:51 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 12DD140047;
	Mon, 10 Jun 2024 10:04:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3C6B621197C;
	Mon, 10 Jun 2024 10:03:34 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 10 Jun
 2024 10:03:31 +0200
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
Subject: [PATCH 0/3] Series DTs to deliver Ethernet for STM32MP13
Date: Mon, 10 Jun 2024 10:03:06 +0200
Message-ID: <20240610080309.290444-1-christophe.roullier@foss.st.com>
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

Christophe Roullier (3):
  ARM: dts: stm32: add ethernet1 and ethernet2 support on stm32mp13
  ARM: dts: stm32: add ethernet1/2 RMII pins for STM32MP13F-DK board
  ARM: dts: stm32: add ethernet1 for STM32MP135F-DK board

 arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi | 71 +++++++++++++++++++++
 arch/arm/boot/dts/st/stm32mp131.dtsi        | 38 +++++++++++
 arch/arm/boot/dts/st/stm32mp133.dtsi        | 31 +++++++++
 arch/arm/boot/dts/st/stm32mp135f-dk.dts     | 23 +++++++
 4 files changed, 163 insertions(+)


base-commit: 28f961f9d5b7c3d9b9f93cc59e54477ba1278cf9
-- 
2.25.1


