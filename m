Return-Path: <netdev+bounces-164786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC71A2F18B
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 16:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C2597A1421
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 15:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273C023C37C;
	Mon, 10 Feb 2025 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="gZVpkvhV"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2B6204867;
	Mon, 10 Feb 2025 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739201086; cv=none; b=eT0COwBitOhMlbuzNXfVopKb3wZ6M2nFAEe/NwY0AonRsDV2fo0KYDg17Q4yBHxttbe0DsxFjsbtxuNo7oexKfsamPwT5pft7va0tiWCpi+oEWEMuZR1uis39xy6AsuRbXh6UudMYwvR0WeW9+DR9Jq1Eo7OisLhTtCFyJXhq3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739201086; c=relaxed/simple;
	bh=NuyCFeWKEw1BalTWA9UZzgH8ev3KfEom2aLyMFVUhMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QmryAJpVb0BHxSjgwfm3igTM6tkYCDS4wd3CRZY+Q3pNGKdpMcVj9+FScyF2Sg+kLvx++X5Vw0YhjglxkEn40Z2CizmKIEyutDs0EI3D11toZfBdi+wSUhOT3Q4+nINVboFL4WcuejLTcNm9Y0RRPQgy+I1eg8n/XZmVRK8xDUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=gZVpkvhV; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AF0qsq032479;
	Mon, 10 Feb 2025 16:24:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	E0uBt0qdfbgPaSAU+tmuCzWxGHoEweyEWa0O3H5K8Hw=; b=gZVpkvhVJIVbC7dh
	Ihd9CFt1OoRaj1t9D5cNbjQDnnijPt0sHyiWWDXIiKRbtyAEgy38qMyftgyXmWHW
	h60dXMge38XiAo+kCI0vKYEdjyHT6QhPUIl97iP22Nl7rzcaR0+BwimerJEKMJGN
	gxQrsf9J8mr5zS3722Zu6spbhua9sjFx4Qe7ajjn64YYf5OqNDtLsRTbgGUfqq9e
	htH7Rn46hU4w3YlbszqwBhbWrCiaht7Vb+GRoJX8jmVr1JfkwUUiH76FaoFwUYhZ
	wL9bc2XitKxEzLcghCLGZvay9EfHnSb8G+fMKGGGveJRXy812ClYHhE6AndzymQI
	cLXlkQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44p0wsxy6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 16:24:22 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 042E24004D;
	Mon, 10 Feb 2025 16:23:17 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 09B71295250;
	Mon, 10 Feb 2025 16:21:39 +0100 (CET)
Received: from localhost (10.48.87.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 16:21:38 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Mon, 10 Feb 2025 16:20:57 +0100
Subject: [PATCH 03/10] arm64: Kconfig: expand STM32 Armv8 SoC with
 STM32MP23 SoCs family
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250210-b4-stm32mp2_new_dts-v1-3-e8ef1e666c5e@foss.st.com>
References: <20250210-b4-stm32mp2_new_dts-v1-0-e8ef1e666c5e@foss.st.com>
In-Reply-To: <20250210-b4-stm32mp2_new_dts-v1-0-e8ef1e666c5e@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_08,2025-02-10_01,2024-11-22_01

Expand config ARCH_STM32 with the new STM32MP23 SoCs family which is
composed of STM32MP231, STM32MP233 and STM32MP235 SoCs.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 arch/arm64/Kconfig.platforms | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 02f9248f7c84da36619ddb8dac55a4bfd96d65e3..844a39620cfea8bfc031a545d85e33894ef20994 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -323,6 +323,8 @@ config ARCH_STM32
 	  STM32 family, including:
 		- STM32MP25:
 			- STM32MP251, STM32MP253, STM32MP255 and STM32MP257.
+		- STM32MP23:
+			- STM32MP231, STM32MP233, STM32MP235.
 
 config ARCH_SYNQUACER
 	bool "Socionext SynQuacer SoC Family"

-- 
2.25.1


