Return-Path: <netdev+bounces-106011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE71F914346
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 09:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C5F284AA1
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 07:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA6F3B1BC;
	Mon, 24 Jun 2024 07:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="b+eZTLPo"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0C0482C3;
	Mon, 24 Jun 2024 07:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719213178; cv=none; b=H1TbluJ7pwS8ZhP8e9ObGDI8Vqhh3DYzrtKLEyhYObPAff6tvGmf00pg8B+Xv0fMDRf6RhdzOxqYYSVMGDEiaJB8eztedAR3aVp/XBix8GXhpEEUXh67+Zi0vyhejXm7yltEs07eVwZl9kA6XG8Ex/3JBoMg1dKT6CCiFAOUDtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719213178; c=relaxed/simple;
	bh=jx2Lle67sF8Ye9IhyISsKOMZJj9OGpYsv7zvrSSDdSA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EH5FH4wUOc3Mwek7bSAO+j6rDTzIntfDgkJN9Z4Wxh6j1J2AHTklp9vdP73kct/4+8xAoh5OUFoaITIQI8paHoRp1OnB/n8Yoe/PJmyd/QrxJVyhSu6qDJrqiA95k+GUOrPuXYBGEPK5krPIdMIZLwRZL773qrVx+R86uI3HzAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=b+eZTLPo; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45NEdBwo027079;
	Mon, 24 Jun 2024 09:12:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	7QQp0ll7mULHxC80OBumXN8x5vwlpC7MjkT/JCmD22E=; b=b+eZTLPozRZezVUI
	+H9TGuB8K749xxqRMe/tP6YWQ7N7DlqsNKIPoAAGfWFDgJ4V6iuPqZ9UH6bvsswk
	8Ud9196dE76iWQ6Ml1GYDt/bB1UlKJq2RY/x1Ao4AoqrXBN5zBnbeBzXGXjeLnsR
	X2kScg410kuR2yMAaoQAWNowIttyqIltBkInlAynUgsltcZDvIw+C9OyF8//dtTa
	j/vHPFo4f0wsbtxMQhvS53Hs3SYI7TkP+K2At9QOECk4b+oXBEz/EO0ihA9L9A2N
	hWQLZbE3PnxqmkLk/cUpmio8FE8FXJ/qJh8yNeTXd5G4NKV5SWGTKHjMmynbZK5B
	n0w3Hg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ywngd5f8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 09:12:23 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 45E0540044;
	Mon, 24 Jun 2024 09:12:16 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DCFED2115F0;
	Mon, 24 Jun 2024 09:11:03 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 24 Jun
 2024 09:11:03 +0200
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
Subject: [net-next,PATCH v3 1/2] dt-bindings: net: add STM32MP25 compatible in documentation for stm32
Date: Mon, 24 Jun 2024 09:10:51 +0200
Message-ID: <20240624071052.118042-2-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240624071052.118042-1-christophe.roullier@foss.st.com>
References: <20240624071052.118042-1-christophe.roullier@foss.st.com>
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
 definitions=2024-06-24_06,2024-06-21_01,2024-05-17_01

New STM32 SOC have 2 GMACs instances.
GMAC IP version is SNPS 5.30

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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


