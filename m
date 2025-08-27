Return-Path: <netdev+bounces-217249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D060FB3808A
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 13:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A04346097A
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 11:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3681C34AB0D;
	Wed, 27 Aug 2025 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="7wv4BqlE"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA571FA178;
	Wed, 27 Aug 2025 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756292865; cv=none; b=FfMNHD23J+dx7joA/sroxqCa31TwhCSrsU4f72zV33Ru79RECBneZlfYKXiSyHvMTBxsOE7ShOYsAiJ8aqK486N6sn7eJmTO0iPNojHIgpWwHd/hUUTfICQTdU61XHtdNVLNiCT3sljKJ1D2KPBseZPAgqYlRfHfLqUc1uPDoN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756292865; c=relaxed/simple;
	bh=E8razsN2CaYngWDYKNr7kDo+Q9Mhr1B4Q82JBBWUqSM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=seZSZDaBERHvRJSmgPoV4dwUiH+oQ7VByx5nn5WJXem5tEVnQVxsNUv6GUuiBdyru36m8T6Rs0rMT/6Fjlf9nY80uVRK9i6xWtzihJ+ge2qLbH//GIBttpzv87j4XLIGEKhEd4nfnfVq+Zl7tNZnX4/EsTF8fixOF+PlYD3pn74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=7wv4BqlE; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RA4cGb026189;
	Wed, 27 Aug 2025 13:07:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=gChpukKe/Co4j4eyT56FMO
	0lc9aier7sQ6umEpqMPig=; b=7wv4BqlEGcf8Adj3Tl5KlzJClyjpur32grL9Cr
	AufZtlaYRTrNopWfDqw9lduzT5fSc3+wkQ6aTTbcKdDCqGXP2IHAVZsvH0dOvWfz
	N2dyRJ7Ese0M053XZd1OpbmPA1a0FCprP5SWvKrV+ivHCd1stclQjcZZ8Fkg8y96
	ASGvBgVT98r0xXebyHJXXrlH/xzgz6yX88XJ9w+h9eRMzUJa1B1UjcmDw76Phw32
	a++WzuI1j085Lw8pZbCjzq5FG3h7PEx13wKqVTrGLm7PhB59GkzVtMN71IzBdi3M
	UAVNE+rm1gbXHiqLZaieOlUTBo+etozvD0ePR/HcILy57gDQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48qq745m9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 13:07:13 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4594240047;
	Wed, 27 Aug 2025 13:05:58 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8A10A546F2C;
	Wed, 27 Aug 2025 13:05:02 +0200 (CEST)
Received: from localhost (10.252.21.245) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 27 Aug
 2025 13:05:02 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Subject: [PATCH net-next v3 0/2] net: stmmac: allow generation of flexible
 PPS relative to MAC time
Date: Wed, 27 Aug 2025 13:04:57 +0200
Message-ID: <20250827-relative_flex_pps-v3-0-673e77978ba2@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFnmrmgC/23N0QrCIBgF4FcZXudwOmfrqveIGGa/TVg6VGQx9
 u6ZdFGwy8PhfGdFAbyBgE7VijwkE4yzObBDhdQo7QOwueeMKKGcCMqwh0lGk2DQEyzDPAespaT
 6pqQ+Mo7ybvagzVLMC7IQsYUlomtuRhOi869ylprSf912x00NJpgJJTsuBGNdf9YuhDrEWrln8
 RL9Nfo9g34M4JowTrlq+b+xbdsb3n2FJQIBAAA=
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
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_02,2025-08-26_01,2025-03-28_01

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
handled. Edit: But maybe that's not important and we can just change
the default behavior to this.

Example to generate a flexible PPS signal that has a 1s period 3s
relative to when the command was entered:

echo "0 3 0 1 1" > /sys/class/ptp/ptp0/period

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
Changes in v3:
- Fix warning on braces for the switch case.
- Link to v2: https://lore.kernel.org/r/20250729-relative_flex_pps-v2-0-3e5f03525c45@foss.st.com

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
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 35 +++++++++++++++++++++++-
 3 files changed, 38 insertions(+), 1 deletion(-)
---
base-commit: 242041164339594ca019481d54b4f68a7aaff64e
change-id: 20250723-relative_flex_pps-faa2fbcaf835

Best regards,
-- 
Gatien Chevallier <gatien.chevallier@foss.st.com>


