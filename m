Return-Path: <netdev+bounces-169344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AC3A43897
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8191895711
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02D2267B03;
	Tue, 25 Feb 2025 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="KVJgjNLF"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155A7267AEE;
	Tue, 25 Feb 2025 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473865; cv=none; b=EZuFLIvLgudTcMggL9PGys2kqtd4d56O6ki8o2mIXeNMfTJqWa43NyJ0kv27uMTs3MdUJBR9c4XSJhk1OjE6lYHDJbjf96Kl0iv7oRULrumOIv3MtoU+jIA5rIWo48Xa7VVM1bLcKdA/FFAvCvTc9Ub3axauu2YnIjfn/gJNujA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473865; c=relaxed/simple;
	bh=+hEoOy8GJcG0XgM8eCyRjf2yPiDrmIVrx+ytpRZeirI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XYIzA2TNNrRoX0i98dfBGu1ssoX1muRALyCnIO74qrZVZYkBoWPw0ou+FfVKCAVoARQoBaukRVj4r2CKmQawfDIco8ZAtv2WHqXNIgIqqo0rbbXbCQA0Pkhg9UxRHfd0gFKYwa4JvIpgmc+yiMmXnI8NVeTcHFYV6fIlL0K4M0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=KVJgjNLF; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P7jf80018116;
	Tue, 25 Feb 2025 09:57:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	n3HMULhTdJvMc73sd1m2swXp0fxdZg6FQdwJWWZoV0I=; b=KVJgjNLF0FrKAKLA
	5kvBxLZQUY2/7Tb8VgSFel/Gjvpdqzk6BKDYtFyp075Xsqih+niQVYlyNt6PR3pF
	TtBYVaPxgbcJQjm+Mk0tUVWl1Szzk9OsVBR6FwHubxFtA6xL+l40iSpYLEDkW8I7
	Daf4YIKmBI4aYbbIn8nCwZD6sGYjgvHrhWV3LJgWAYIibl+iwQapdRMZFE8hh0sc
	F+fvZmS4BPat+SlclKLFmjO9O46/zbK79hebpC6WzZ553oJkiriNMNZThweqLZBu
	Flx6DvibnwLlJIwSzpFVdyjQcQB2SoRc0x6Ttvh2s4sDEwJr7P3Y59xveP+zemzv
	D5BtKQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4512sqsstp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 09:57:34 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 540E64008E;
	Tue, 25 Feb 2025 09:56:15 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6ECDD47D0DE;
	Tue, 25 Feb 2025 09:54:32 +0100 (CET)
Received: from localhost (10.48.87.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 09:54:32 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Tue, 25 Feb 2025 09:54:07 +0100
Subject: [PATCH v2 04/10] dt-bindings: stm32: add STM32MP21 and STM32MP23
 compatibles for syscon
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250225-b4-stm32mp2_new_dts-v2-4-1a628c1580c7@foss.st.com>
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

Add the new syscon compatibles for STM32MP21 syscfg = "st,stm32mp21-syscfg"
and for STM32MP23 syscfg = "st,stm32mp23-syscfg".

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
index d083d8ad48b70ef68150f3d1b177890282ca025a..ed97652c84922813e94b1818c07fe8714891c089 100644
--- a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
@@ -21,6 +21,8 @@ properties:
               - st,stm32f4-gcan
               - st,stm32mp151-pwr-mcu
               - st,stm32mp157-syscfg
+              - st,stm32mp21-syscfg
+              - st,stm32mp23-syscfg
               - st,stm32mp25-syscfg
           - const: syscon
       - items:

-- 
2.25.1


