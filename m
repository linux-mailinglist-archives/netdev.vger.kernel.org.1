Return-Path: <netdev+bounces-169337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73317A4388A
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22E6B7A59FE
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 08:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B014266B70;
	Tue, 25 Feb 2025 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="L5l6jvia"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DD8263C8C;
	Tue, 25 Feb 2025 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473853; cv=none; b=A/eABWSgKxzHnG/mJtVCMVZnoZw+V+A+PgFdQtwpxoDkWMu9GMdbfefAMohkSSHGSChu3bxe+203LORtsBIE0RzxtN1eSjiNyltJyWowsidSZ6nXy20HLA4MYbW15EN1PMyVJau7ZRjAzbuTixhrquMLKKHH8j1G2KHbOM5D3hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473853; c=relaxed/simple;
	bh=BamJIIzhLRsvyP/Ug9CblE0TNfEWffLUxxb/nAagAIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UdNi2nJUui5VHFcY+Wl33JGLXpHiVNhWCFFQHJH9s01ZMRgrSzJS356WEFaYzk1ccZmmVauRTBW/udB0zN3gdXq2sSdn6RB6FAylhS+szVqsh4KtLw1WAS4liUEITxBDmuAvz5S2y1nbkJzwPYKl9HwXrINfy8Q2tEcgDuB51tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=L5l6jvia; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P7jf7w018116;
	Tue, 25 Feb 2025 09:57:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	20owZPyvCqdzO67jL6iAj7bGP8jkca0HcDebvg0pgwc=; b=L5l6jviacu61kees
	gmuQAzj44Wv1uU1hXNRC4tdmrJzs69SjLDcpOxCsNHw7R1TVPFMAi5qwtrJ08hD6
	fUEKAxySxmBP3P45t7Rkrr55xaTDyeRY0euFdEd3J8uaTby5lMhkLyOOqa1pdkj2
	JZ9UmxD8W0XDLy19MF7qO7b4PvIkihC+0+Vl86MZ8QDKgeqG0JKsKaieM2B7162z
	FXsilfzu5CJXet5Bsu6z1/6+/i3OH83YERGyc5ujDUzSM0GFfC56/FAI4+J2FEYB
	ojr6Nt3hHvS3bJg97iuLKELzHr6LdW91VQFXf+VVEzGce0sG3g+0b8jztx4WkoTa
	DJ1fyw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4512sqsssk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 09:57:21 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 792D84008D;
	Tue, 25 Feb 2025 09:56:12 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B5AA647D0EE;
	Tue, 25 Feb 2025 09:54:31 +0100 (CET)
Received: from localhost (10.48.87.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 09:54:31 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Tue, 25 Feb 2025 09:54:06 +0100
Subject: [PATCH v2 03/10] arm64: Kconfig: expand STM32 Armv8 SoC with
 STM32MP21/STM32MP23 SoCs family
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250225-b4-stm32mp2_new_dts-v2-3-1a628c1580c7@foss.st.com>
References: <20250225-b4-stm32mp2_new_dts-v2-0-1a628c1580c7@foss.st.com>
In-Reply-To: <20250225-b4-stm32mp2_new_dts-v2-0-1a628c1580c7@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01

Expand config ARCH_STM32 with two new SoCs families:
- STM32MP21 SoCs family, which is composed of STM32MP211, STM32MP213 and
  STM32MP215 SoCs;
- STM32MP23 SoCs family, which is composed of STM32MP231, STM32MP233 and
  STM32MP235 SoCs.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

---
Changes in v2:
- STM32MP21 and STM32MP23 added in a single patch
---
 arch/arm64/Kconfig.platforms | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 02f9248f7c84da36619ddb8dac55a4bfd96d65e3..6b7ca916c9c1e21d4fb2d7edf444780745c8d926 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -321,6 +321,10 @@ config ARCH_STM32
 	help
 	  This enables support for ARMv8 based STMicroelectronics
 	  STM32 family, including:
+		- STM32MP21:
+			- STM32MP211, STM32MP213, STM32MP215.
+		- STM32MP23:
+			- STM32MP231, STM32MP233, STM32MP235.
 		- STM32MP25:
 			- STM32MP251, STM32MP253, STM32MP255 and STM32MP257.
 

-- 
2.25.1


