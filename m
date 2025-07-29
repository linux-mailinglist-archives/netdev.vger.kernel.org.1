Return-Path: <netdev+bounces-210823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD50B14FA6
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 16:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF994E5F37
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 14:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE9A285C86;
	Tue, 29 Jul 2025 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="f/tV+cw8"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C869246BC4;
	Tue, 29 Jul 2025 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800904; cv=none; b=fanRoKw9ziaT6JqUsxYHfE5oDpGq1ql+wpsGZbBmhjNrOOr5q/W6HunXHFxBq4xBZwEzCUJxJEDfRfBtvZHu9aJWKCrQvDPRtAbGywW4+Y57yNQ+jwZn4Fx3ULM+TtokGch4M2ncdaiUC1QD0O//QgOFgKgrQSF7B+vOq6VXmtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800904; c=relaxed/simple;
	bh=5rDR+UqN1NZbe+MiRbDZnIug9UCVJXza9xPJyMwrjlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QC04vcyfgx3aaVGQPXMYx9k3Bm/Ycz3sXirUcUWbRmm1eLDTAzCdS6LU35WnedwQgkW3ny9ytv8amGa8hKSJCklP8cUHvRXSxd70Di9VXlDk4VY2OSnoGsNY6Kbywq4Pa2GF6J+FhHaRwhOWmzA1tUMBCmqaUMz4Pw2bk3R1wzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=f/tV+cw8; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TDqD6D023729;
	Tue, 29 Jul 2025 16:54:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	f/Foo9POshykOfCA1tCQxxLdk6j4kVXsCtJfrKcrneA=; b=f/tV+cw8yLM1QTsX
	jftRGfiAZCia852woVLiue+QfJQkryig+H9TTOxqdiPp2rhMirV0lIeG1AxqOiBp
	lyTWhg8wj4RnQBYOUpUIZ1SRG455sxnsSvBAoU1ScbvIwMKaohFgRfZyLdMtG3yo
	UjAPkbHpUijYL5MQDZFrlKaXEQ0Lg0o3EJxaBM76tJn4aSYC/0qED+1x5zjcjEUk
	IGIMfx/4eB0QqecOkjd2PPCbk4Kg1mW2VGi4RH+lGiURbVuw+O5yzwwC4p8qAWEp
	LJm5Ssvv+TIfTnjsf9ge4cqz+nvm6JZucdDBFu1z7u2aT8FHpJV5G86NfcGw0kIz
	u4F9/g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 484memnux3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 16:54:42 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6E3B94002D;
	Tue, 29 Jul 2025 16:53:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E3340778886;
	Tue, 29 Jul 2025 16:52:18 +0200 (CEST)
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Jul
 2025 16:52:18 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Tue, 29 Jul 2025 16:52:01 +0200
Subject: [PATCH net-next v2 2/2] ARM: dts: stm32: add missing PTP reference
 clocks on stm32mp13x SoCs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250729-relative_flex_pps-v2-2-3e5f03525c45@foss.st.com>
References: <20250729-relative_flex_pps-v2-0-3e5f03525c45@foss.st.com>
In-Reply-To: <20250729-relative_flex_pps-v2-0-3e5f03525c45@foss.st.com>
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

ETH1/2 miss their PTP reference clock in the SoC device tree. Add them
as the fallback is not correctly handled for PPS generation and it seems
there's no reason to not add them.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp131.dtsi | 2 ++
 arch/arm/boot/dts/st/stm32mp133.dtsi | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
index 492bcf586361c487208439ed71a93c2bf83d5eb2..6f5720fb9fa1f58bd97b6bf19fc898f0fecb34d1 100644
--- a/arch/arm/boot/dts/st/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
@@ -1602,11 +1602,13 @@ ethernet1: ethernet@5800a000 {
 					      "mac-clk-tx",
 					      "mac-clk-rx",
 					      "ethstp",
+					      "ptp_ref",
 					      "eth-ck";
 				clocks = <&rcc ETH1MAC>,
 					 <&rcc ETH1TX>,
 					 <&rcc ETH1RX>,
 					 <&rcc ETH1STP>,
+					 <&rcc ETH1PTP_K>,
 					 <&rcc ETH1CK_K>;
 				st,syscon = <&syscfg 0x4 0xff0000>;
 				snps,mixed-burst;
diff --git a/arch/arm/boot/dts/st/stm32mp133.dtsi b/arch/arm/boot/dts/st/stm32mp133.dtsi
index e48838374f0df4e003aee5046e45b49986c1daea..0112c05b13e1f02e5ec4b4bffc9a11b4bef1b9bc 100644
--- a/arch/arm/boot/dts/st/stm32mp133.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp133.dtsi
@@ -81,11 +81,13 @@ ethernet2: ethernet@5800e000 {
 			      "mac-clk-tx",
 			      "mac-clk-rx",
 			      "ethstp",
+			      "ptp_ref",
 			      "eth-ck";
 		clocks = <&rcc ETH2MAC>,
 			 <&rcc ETH2TX>,
 			 <&rcc ETH2RX>,
 			 <&rcc ETH2STP>,
+			 <&rcc ETH2PTP_K>,
 			 <&rcc ETH2CK_K>;
 		st,syscon = <&syscfg 0x4 0xff000000>;
 		snps,mixed-burst;

-- 
2.25.1


