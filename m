Return-Path: <netdev+bounces-104155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E784390B57B
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6AC1F25B28
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BBF14532B;
	Mon, 17 Jun 2024 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ebImhx3d"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7A513AD07;
	Mon, 17 Jun 2024 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718639239; cv=none; b=vDLO3bgZdAYpJzy/TERbTSd7aeEqtBjd3gSyh/M65Ec14ucJFNc9lNMYghsBg67rqlXPmRsMw5wYkuHFeCTUb2s4/myBG8dPUluBjMCZHMYuM1AYoI9CrWMIkz3Tk6/WzFfxCpu2v67h6vl0ZdPhvMmHFolicG8lBHeWW2RwRMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718639239; c=relaxed/simple;
	bh=qm3f50Q2TWzpzqQt6E5IZu10amAMdCvtK/DU/NPuy50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMcFWAtn4D7GfSRErfkhaCzP2w39K44s3qXdsaYCyWTTPChlLcs+5x3NdOGt2LiPrtHAUsxT9Sdf4swFV48WTamW1WqyDb0nkNv+YC78JDRhPYwwMhfRErab+5aVFkU2gJgjuQM5+bULwFbVPcAnkw9R8URviPu65X/MfDg8G9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ebImhx3d; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HDT8vu003715;
	Mon, 17 Jun 2024 17:46:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	nlhpF+k5sdW69avCqM7F1JReLRkrvKKlMuobU/k4MnM=; b=ebImhx3dEBFdm6Px
	pMQMEz54JJOvJJ0TUffevTT8uDa8kK0iaZCvyGKuctSPlODZwMbGYjs/nV5TWH/v
	PH83EqLNrVqKKPssIzy5gR9+I6u4rYn1IH2VUDVdmHGO0WcoQuqgEDsVYVcKDPZ9
	zaa4rLT2uBnLtMyt7Ng3tRvQa8ARmB0NEclUii26gM6hCACkjMEXbCQyFW67m7ig
	PPwpUIbBSmC+uzF6IgYybYsgqL6DNnLFB8ZvcbqTZg3s0JR3dhoR3Ed1u6ji5dt1
	immQvwx1roc7HYAHh57IgUTvnwNpyPamn1ioWMzSjDqsEfwTTzlqgKTFyeWxKaMp
	ANhaWg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ys0cg7g6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 17:46:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 821B540048;
	Mon, 17 Jun 2024 17:46:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A5C1F20B606;
	Mon, 17 Jun 2024 17:45:31 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 17 Jun
 2024 17:45:30 +0200
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
Subject: [net-next,PATCH v2 1/2] dt-bindings: net: add STM32MP25 compatible in documentation for stm32
Date: Mon, 17 Jun 2024 17:45:15 +0200
Message-ID: <20240617154516.277205-2-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240617154516.277205-1-christophe.roullier@foss.st.com>
References: <20240617154516.277205-1-christophe.roullier@foss.st.com>
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
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01

New STM32 SOC have 2 GMACs instances.
GMAC IP version is SNPS 5.30

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
index f6e5e0626a3f..bf23838fe6e8 100644
--- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
@@ -23,12 +23,17 @@ select:
           - st,stm32-dwmac
           - st,stm32mp1-dwmac
           - st,stm32mp13-dwmac
+          - st,stm32mp25-dwmac
   required:
     - compatible
 
 properties:
   compatible:
     oneOf:
+      - items:
+          - enum:
+              - st,stm32mp25-dwmac
+          - const: snps,dwmac-5.20
       - items:
           - enum:
               - st,stm32mp1-dwmac
@@ -121,8 +126,9 @@ allOf:
         compatible:
           contains:
             enum:
-              - st,stm32mp1-dwmac
               - st,stm32-dwmac
+              - st,stm32mp1-dwmac
+              - st,stm32mp25-dwmac
     then:
       properties:
         st,syscon:
-- 
2.25.1


