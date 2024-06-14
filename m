Return-Path: <netdev+bounces-103604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2339B908C51
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 15:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0321C23077
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 13:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534CB19B5A0;
	Fri, 14 Jun 2024 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NVj2LLh+"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8157419AA41;
	Fri, 14 Jun 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718370641; cv=none; b=LAgNVtfhTKCNceuCm2uaLaUN+yJ3VYKd7HeNotrtxJ5J8En295x//3ZCL9txDJxmsPcPPQYN7TV6rO9BMrZMSpQA16kzOzOiMX0uW9SS8ZXWBN6vwOm6gpS3Rq68CkFYc2B4qyjaPsZCURCr18QSOxAYayu05UHfhNV26jv7/vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718370641; c=relaxed/simple;
	bh=NkbAigM9hNiKQ/zXL8MOhk31LslpiMgdsHKa3JsXKXw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bhXtSrjAnzcpjbY/Ds+CrFACU7iTCpB4vV03dgRXGlt7buIdZ/VVPIUZk1NZLWDFyZAVSkf9jXNA98w6iXmIaCfUsarWTzVmh3EeJ0iH8ZTkEQtVSc0znMJ+WLEPrjYokCOYf6+P2DbyPzCpajXUUD+LPRceTjeuUQCSuPuboNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NVj2LLh+; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ECC56p017587;
	Fri, 14 Jun 2024 15:09:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	FLqA5KEQW8fsF+Pb8lvwIsQznW/5gUhbmt7k9cyS9cQ=; b=NVj2LLh+u6hiIDA4
	F8ArC0DESHsqFBgJ6A/P+rvNyw0hWBmRRC3EYicItoiY3OcozANwgL9mq4ojpOuJ
	PWPt7if5v1xhjsVDKIzl1N1SHmkZOKp/0B8McSPWZrJ/smkBJiTD9fjXU35kh1lp
	t5YrbNuxr2fcKY8wakIvpJ5v1pwccwxRr5gK9IbiHT6bb6+i8SfZX5+jGUcrLpGT
	ZgzLuGdhQek+q9bis/SimjnXdf0twbLMvNZm6DeABqdPy/bP2UYrHlGJaYip3D92
	s6QUVNZm+ZHnl1r6a+sv4WaBbg5lxizrcTBzN8YqJQcFMKxVwV3jtPXZ7TbjlTIz
	Syqo8A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ypbp314de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 15:09:54 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 11CA940048;
	Fri, 14 Jun 2024 15:09:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B99BF2132E1;
	Fri, 14 Jun 2024 15:08:23 +0200 (CEST)
Received: from localhost (10.252.5.68) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 14 Jun
 2024 15:08:22 +0200
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
Subject: [net-next,PATCH 1/2] dt-bindings: net: add STM32MP25 compatible in documentation for stm32
Date: Fri, 14 Jun 2024 15:08:11 +0200
Message-ID: <20240614130812.72425-2-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240614130812.72425-1-christophe.roullier@foss.st.com>
References: <20240614130812.72425-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_10,2024-06-14_03,2024-05-17_01

New STM32 SOC have 2 GMACs instances.
GMAC IP version is SNPS 5.30

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
index f6e5e0626a3f..d087d8eaea12 100644
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
@@ -121,6 +126,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - st,stm32mp25-dwmac
               - st,stm32mp1-dwmac
               - st,stm32-dwmac
     then:
-- 
2.25.1


