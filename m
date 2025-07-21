Return-Path: <netdev+bounces-208562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5DFB0C2B0
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D72AC7A3C98
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDAF28DF33;
	Mon, 21 Jul 2025 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="HYe47YEZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B131BD01F;
	Mon, 21 Jul 2025 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096859; cv=none; b=foLbs9xQNn26J3yPKQe0WO4+DbgukTGavARTMfRl6q5MfL0pWyEdLQStaGI2O1OPsLt8gqrLnM6P4O1RoYzLKIxKmJPaSXzo58JMtrCLkCq6DoVbIKYlthWdRKEbZxFvvNJy8buSbZqVyCxFuspiOWi9BGmR0mfXvVlVtgqRK0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096859; c=relaxed/simple;
	bh=Avv0u0uet8c5vtxzqKAUxwgjxaChkzjjAaArsW/vmjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jfrvtNHdRg5/7lcRVvkP7QdINUBqrE2RdA2e4zM96Sxg4TDiiNojf9SStiHYlX9P+WO8rETMprFhYoAxeOHNSzGr+ptgmlWgiccdi2/vZ2k8yNHWo2cfgE+hmxngeykSSyKEhSPBwRrn3GDkxxIaaTInpTt1RGoekfhsyTkfOrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=HYe47YEZ; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LB7PB1006642;
	Mon, 21 Jul 2025 13:20:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	b1X0fuL9CtcX6g3IEG7r9imekG29ASEidJw6mr4wREU=; b=HYe47YEZUTNoJYQh
	T/2IjBN55bAJkVxJYzyXpIDLAanCNWjT7pm5gU/C8a2OA50PlWv4eidqi6pUKoX+
	3w3Becc2OTbYGGNlmw+FxEWyBfJU+Nms+JDcTLO+rxy7zknVH6UaTfiLobiyzKe4
	uZHvKbHH8+VKLAW92tnTK06bvYj93wJKbsDyQascnWj2lFSFyPzVO52ROIkfnvbP
	a4uOF4DqoFxBG8HpSTyU9v3pZVT8/dQk0xH6YTRA1lYVYwJ8wxZ7nHTUTFnRBUw1
	54bD7BUjJQujLK7kdCZtrvAk3tnwJhKz5aqL7QXi/pp6WR7r5+H0W5kMebBn4hdb
	obH4BQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4800sks1g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 13:20:31 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B985540045;
	Mon, 21 Jul 2025 13:18:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DDB8F7A320F;
	Mon, 21 Jul 2025 13:17:46 +0200 (CEST)
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 13:17:46 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Mon, 21 Jul 2025 13:14:43 +0200
Subject: [PATCH net-next 1/4] dt-bindings: net: document st,phy-wol
 property
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250721-wol-smsc-phy-v1-1-89d262812dba@foss.st.com>
References: <20250721-wol-smsc-phy-v1-0-89d262812dba@foss.st.com>
In-Reply-To: <20250721-wol-smsc-phy-v1-0-89d262812dba@foss.st.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, Simon
 Horman <horms@kernel.org>,
        Tristram Ha <Tristram.Ha@microchip.com>,
        Florian
 Fainelli <florian.fainelli@broadcom.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=922;
 i=gatien.chevallier@foss.st.com; h=from:subject:message-id;
 bh=Avv0u0uet8c5vtxzqKAUxwgjxaChkzjjAaArsW/vmjk=;
 b=owEB7QES/pANAwAKAar3Rq6G8cMoAcsmYgBofiHY88LFa3fXDxaGmYnrUy6pV1AKeZuGRUcAD
 ReXaesVm4qJAbMEAAEKAB0WIQRuDsu+jpEBc9gaoV2q90auhvHDKAUCaH4h2AAKCRCq90auhvHD
 KJ3lDACBs2nHBOOs5HXp4qavSVXFh3fM0Nadp4bsTykIIfRE/DzwWWCk1k5kffsi3m6v4fHG1Hu
 0wwqWl2Aklr448xtZNx+LsFWL4FQQaiAdLrksz+cEoRaaJc8QXopBmDRYpJny2lj3FRyx81TF2Z
 bCx9NTqSLh2T0EZZwe8/Jm/ynHoAdHUDMJELVHgmRL7j7mWULiUPuVEzra65oLaK4uhNQu9gWaP
 qXn+PeTvYLNzwJzr8vuDBJ2ZIu7Iuv95caFuWjVlPUCTpCgYyffvTZ/qJNjQtcaLd9Xr/tCj5r7
 0UWvo++8ZRPZbHObcAF7HLmoCYoPWAiczq7GgIcb4rkf+e/y4fdoj/eTlqRt+eV/F7BYozOlv1G
 +1IlRmapIVGKcPxS+I2Btr2sr46MI0qg0bM6I6ulpY7/LpBhHc+mMqHa1Bnm+EVOgNPsMdPjy7E
 ocZd3sm9hEVVEUKHLhkFyUZ/5DKIhplTCr4jCJD3FKmh3GMNW5NYv0QJsUvf1h/Xvrpls=
X-Developer-Key: i=gatien.chevallier@foss.st.com; a=openpgp;
 fpr=6E0ECBBE8E910173D81AA15DAAF746AE86F1C328
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_03,2025-07-21_01,2025-03-28_01

The "st,phy-wol" property can be set to use the wakeup capability of
the PHY instead of the MAC.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
index 987254900d0da7aab81237f20b1540ad8a17bd21..985bd4c320b3e07fd1cd0aa398d6cce0b55a4e4d 100644
--- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
@@ -121,6 +121,12 @@ properties:
     minItems: 1
     maxItems: 2
 
+  st,phy-wol:
+    description:
+      set this property to use the wakeup capability from the PHY, if supported, instead of the
+      MAC.
+    type: boolean
+
 required:
   - compatible
   - clocks

-- 
2.35.3


