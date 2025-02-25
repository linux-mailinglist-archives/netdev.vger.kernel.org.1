Return-Path: <netdev+bounces-169343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF3DA43889
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FA5166E26
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4F9267AFB;
	Tue, 25 Feb 2025 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="AaV0+II9"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039E7264A9F;
	Tue, 25 Feb 2025 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473865; cv=none; b=Mndz1mMmlmnmuhbTdAhmygbLD72UUmlYZBgdqIP+wUn6d6yMnzuhbuzD2axKYYuSootD6HTR23u7Zs1jdJbO9Gf4LbTO9tFa7PB4VLe6WfafchXc8y3NF4OEBQ4TSMKfCCri2zwVvToyN6tVMLH1HAkXq2O3XzqHv8Msztc5Ahc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473865; c=relaxed/simple;
	bh=9jnIRDcyx9kx5TCk74pGGkefC/3orJeLGnvb2qXc6n0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=r7D3/AGv/Ypwoikv9lUR30Jjs9bn9gQm81sskIcUjPWKwcxjqQje90HNU0b+2udMHXiTgqJHBUMpHe+zFBh//CzgJcH2/T6njnYjjCtMmaJBZCjNnv2vARLUYFO4JBcyLbN9HbNWmzQytbTXE0KyDPQnI3o2KM/8GNJ+eYfiJJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=AaV0+II9; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P7lqvQ023213;
	Tue, 25 Feb 2025 09:57:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	MrPtzYwsbePjcy64oLRtCta43bOeKcHvagBgRlZxr4Q=; b=AaV0+II9GgWSSRlU
	rYJcCvHVf38zV+CqThpMsFrVG6HU0t/Z+BRvd8p4ckA/r0dst4jAdQ/cVdFw/xv1
	vA6azll6YNQv/BUSLpef42RA4724D8FKAOmpVesQubzD53Sn5zza58G+jpy3yt/w
	gFoAk25vAwqIYbYT3rPXql5+dmdScCyGqgm4CHqwTlumOhuhwqdugo+CszI5TWdh
	dSjFSq/w9ptYZ8s1pPZFT88bALhWGOjPWoG4Um9PFfMkzypd2w/Zi0aX0228HXbF
	O1TSlp/+coqif5kVe9W/Xj10bPdD0LvR96LehqdQWjVqzwHoFeZE2r+/006kS/yT
	AxhzAg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4512sp1udt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 09:57:32 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1627F40089;
	Tue, 25 Feb 2025 09:56:12 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 51292426E64;
	Tue, 25 Feb 2025 09:54:30 +0100 (CET)
Received: from localhost (10.48.87.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 09:54:30 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Tue, 25 Feb 2025 09:54:04 +0100
Subject: [PATCH v2 01/10] dt-bindings: stm32: document stm32mp257f-dk board
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250225-b4-stm32mp2_new_dts-v2-1-1a628c1580c7@foss.st.com>
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
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01

Add new entry for stm32mp257f-dk board.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index 6825d965da3daf2b508fbd88e8c9d40e20ba1f59..7cf9c6be0388365e6bce5e34a00ccf0a0eaa89cf 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -180,6 +180,7 @@ properties:
       - description: ST STM32MP257 based Boards
         items:
           - enum:
+              - st,stm32mp257f-dk
               - st,stm32mp257f-ev1
           - const: st,stm32mp257
 

-- 
2.25.1


