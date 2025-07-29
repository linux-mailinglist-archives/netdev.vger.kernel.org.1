Return-Path: <netdev+bounces-210822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8B6B14FA4
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 16:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9111189EA29
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 14:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F222D27F736;
	Tue, 29 Jul 2025 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="fhUsSC+e"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7FE235072;
	Tue, 29 Jul 2025 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800904; cv=none; b=UlXS6BPY9PujKHa9MqNhi6u2Z2CkkpNdS/FgwD31dymibjnoLYWbJ+MQSPnonEULvlUwLjFR+eeyOkczDE7NcC43lW/1DOUfZQVnbF/mIv+KO7dIF/Bm/6GDKzNkk5lYZinZ+V0h6cnq5MDW2Mo2Gc4a2XuL7lOHfMIdtQ15rU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800904; c=relaxed/simple;
	bh=3xLYcQjGPpyPczQsz7e/xiiPVawJjtc7gQMc2ZeKIQo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=kmA9LDJAcgzIJciq0mErbywBzFM04eZNXw6wXBrFWkGIewH2jd00g9tSF47liQQFn3YKRexHfbrQZNVTunFST/Q2MEDH8RRNiYeGxk5H1zpWjYyyPKMdQrwHATycui1QtLk3NyQcmi87QrSv7E5jfDzcbfEE9qvh/giqjwlcHmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=fhUsSC+e; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TE7qnw019597;
	Tue, 29 Jul 2025 16:54:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=Um5h6E5hgrYH74DBhV8xzP
	bAvTei/UQkgD6+aDRBd0k=; b=fhUsSC+eVFNTgK+DE3Kh+wDbMnKyeyprXks9EM
	5h2zo7Xk1J1C1Vas7o3ZijLouDtMb2ps7XH5+fyDxl3/ABTXctxIttm+Pmv3fZ12
	Q7WgfLsiCbf9OrYf0FVRwYZhV8Njbj+4OI5Mmu0Np/zfgdNWqZj1sIvvyzd7o5Fg
	bqLfD4PQFh1wuq1tmHWdoBvdNMYKQsm62AusEu+QKRM7qRd6QMFsAN4dtqyvu8ML
	qZFL2MvoCH38cP/FV4dZi1Ac0P4NxMwjtUMYdxNuIoNcLnb62lvczJHElbpmirZc
	/4cAxyi4A7ZR3j+V6+bbeFNEfMMfBB0m1xcenwA6vPpSL2+g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 484pc2depw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 16:54:42 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6E45D40046;
	Tue, 29 Jul 2025 16:53:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 92F66776AAD;
	Tue, 29 Jul 2025 16:52:17 +0200 (CEST)
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Jul
 2025 16:52:17 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Subject: [PATCH net-next v2 0/2] net: stmmac: allow generation of flexible
 PPS relative to MAC time
Date: Tue, 29 Jul 2025 16:51:59 +0200
Message-ID: <20250729-relative_flex_pps-v2-0-3e5f03525c45@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA/giGgC/22NQQrCMBBFryKzNqVNbKOuvIeUEuPEDtSkZEKol
 N7dUFy6fDz++yswRkKG62GFiJmYgi8gjwewo/EvFPQsDLKWba2lEhEnkyjj4CZchnlm4YyR7mG
 NO6sWym6O6GjZm3fwmITHJUFfzEicQvzsZ7nZ/a97+tPNjaiF0tZ0rdZKdZebC8wVp8qGN/Tbt
 n0BnI8vzr4AAAA=
X-Change-ID: 20250723-relative_flex_pps-faa2fbcaf835
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Gatien Chevallier
	<gatien.chevallier@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01

When doing some testing on stm32mp2x platforms(MACv5), I noticed that
the command previously used with a MACv4 for genering a PPS signal:
echo "0 0 0 1 1" > /sys/class/ptp/ptp0/period
did not work.

This is because the arguments passed through this command must contain
the start time at which the PPS should be generated, relative to the
MAC system time. For some reason, a time set in the past seems to work
with a MACv4.

Because passing such an argument is tedious, consider that any time
set in the past is an offset regarding the MAC system time. This way,
this does not impact existing scripts and the past time use case is
handled.

Example to generate a flexible PPS signal that has a 1s period 3s
relative to when the command was entered:

echo "0 3 0 1 1" > /sys/class/ptp/ptp0/period

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
Changes in v2:
- Drop STMMAC_RELATIVE_FLEX_PPS config switch
- Add PTP reference clock in stm32mp13x SoCs
- Link to v1: https://lore.kernel.org/r/20250724-relative_flex_pps-v1-0-37ca65773369@foss.st.com

---
Gatien Chevallier (2):
      drivers: net: stmmac: handle start time set in the past for flexible PPS
      ARM: dts: stm32: add missing PTP reference clocks on stm32mp13x SoCs

 arch/arm/boot/dts/st/stm32mp131.dtsi             |  2 ++
 arch/arm/boot/dts/st/stm32mp133.dtsi             |  2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 31 ++++++++++++++++++++++++
 3 files changed, 35 insertions(+)
---
base-commit: fa582ca7e187a15e772e6a72fe035f649b387a60
change-id: 20250723-relative_flex_pps-faa2fbcaf835

Best regards,
-- 
Gatien Chevallier <gatien.chevallier@foss.st.com>


