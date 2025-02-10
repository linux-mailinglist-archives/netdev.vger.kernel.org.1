Return-Path: <netdev+bounces-164788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5DAA2F19D
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 16:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DE03A8AD9
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 15:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A33A23F27F;
	Mon, 10 Feb 2025 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="q5YjC4Ou"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5856223E238;
	Mon, 10 Feb 2025 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739201094; cv=none; b=nzaq4MKP26yQ6oW9/XrUpEVxePOs0XcrIQMQQIWCEP+jw1yRTFiqadVtw8pf818v+zeOSNw69KzyNg3CuBv5T5VMgnDtFIALKAI+SbXjjfExcjjjMbF7jD9rQUDLZekPwINF4wxJ4To7vwKPsgVH+lP9HPfYDJN8d45hcX2PZxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739201094; c=relaxed/simple;
	bh=itKc4JFN62L7eknbAIaoYJmyaznDChnyO0SaX8LpLS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=iYBDiIt2v9tJGZRXNMv1gm4pUfFDe1pOy2lQMfbilIS3OjTBvMqnDkJ7y+Nszy403p5tc4xfq3RIDV0t1OZrDoOPq8vye7Im6mjuAPGyeWgf4n9y8aUtBe/aLdDNK/8qEniJgcCH+4+JeIPaaHV94ASrhu4126qaFAohsQkClhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=q5YjC4Ou; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AF0p8m016534;
	Mon, 10 Feb 2025 16:24:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	b5Tvhn8A9wvlhyeA7dmIZaaAQOCoRp93WSAR9jXgEio=; b=q5YjC4OuiPEhaac7
	9uW8Ge9s5oLc4le55343PJpmhflXPx4+udSe6AZF85fF2fFtBdVFDb4NhTSGjkzZ
	clREgdqrFhpIrT7pHKxo89LXANbrqD35MUaPK5weRVw2Fj3tCU4a3aiyj3Db9CkB
	dYtN9ycQmo3MFJgf2LjA31aNhtjCb68C1p2J3GF2hUzTVWwZXUTObejWUa1HTwP4
	tioQyf8DK6lUBI5cBespV3RmpdyoO8k7cTdWmj6izF/2L9ei5opwDorpkhNCmmx+
	gNgp3IXuxJ54SX3La5VxH0mCZRb8Ua3IZrJE1F9y0uyXI2VswIiIrGknAOmk73f3
	/WnDnA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44p0rhy5sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 16:24:41 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9065B40062;
	Mon, 10 Feb 2025 16:23:25 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D49E62957AD;
	Mon, 10 Feb 2025 16:21:41 +0100 (CET)
Received: from localhost (10.48.87.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 16:21:41 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Mon, 10 Feb 2025 16:21:01 +0100
Subject: [PATCH 07/10] arm64: Kconfig: expand STM32 Armv8 SoC with
 STM32MP21 SoCs family
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250210-b4-stm32mp2_new_dts-v1-7-e8ef1e666c5e@foss.st.com>
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

Expand config ARCH_STM32 with the new STM32MP21 SoCs family which is
composed of STM32MP211, STM32MP213 and STM32MP215 SoCs.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 arch/arm64/Kconfig.platforms | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 844a39620cfea8bfc031a545d85e33894ef20994..f788dbc09c9eb6f5801758ccf6b0ffe50a96090e 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -325,6 +325,8 @@ config ARCH_STM32
 			- STM32MP251, STM32MP253, STM32MP255 and STM32MP257.
 		- STM32MP23:
 			- STM32MP231, STM32MP233, STM32MP235.
+		- STM32MP21:
+			- STM32MP211, STM32MP213, STM32MP215.
 
 config ARCH_SYNQUACER
 	bool "Socionext SynQuacer SoC Family"

-- 
2.25.1


