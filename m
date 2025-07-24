Return-Path: <netdev+bounces-209733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0594B10A41
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 14:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE93317A5EB
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 12:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DDA2D130A;
	Thu, 24 Jul 2025 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="RpgRWqKA"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CC12D0C9F;
	Thu, 24 Jul 2025 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753360441; cv=none; b=pqcbcHsmM2FbYck0mf+Z0AxZvsZ7VWSSqYRtz6QalKvvYBWTp1LCuh34pOUbUUdJqe1N4lGIzMmcUVqNAyDJVlr/Qk0cTwd1d3agpTnBju9vVALc2HRlofZ1ilJ23WjopPrmysahMGBlrNkT/+s6VWI5f7EkRcsNZRDOiQ/3bqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753360441; c=relaxed/simple;
	bh=kYc22+pXE94O5MsVh/juNZH7hoJMz0fgwyYxca0rS58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LL+c1FmSrkeg8SHDye0cOMnmtGV1XBmW8TdLo4oRRlU6OaOwNoBuBMgcuLwZ8I44JqxZUiwkZ/wc6wY+nRdUEPI6s541UB+qsvT/rjHLAk31NcnRcRGu3MhuuHdU8LvRDFYb5De3Vsd6050h4RBcdvg5zs2X8X0Xygp7UmABdbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=RpgRWqKA; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OCPTHO003302;
	Thu, 24 Jul 2025 14:33:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	CKaXaYwKcu7f+nUNj+bRqaE7VbhsFGliz8Rj/en1exs=; b=RpgRWqKADW0YVWS8
	dsV0erVRnub2M2YtrMJKgbH1Nae2zWKLg9P73WN/SuX18wlo6aPnz19IwDthnM2t
	jE4A/p1BXkwVSaCREsfVSHZb3/g8UhrlyY5rIT04c6p8lAISlwgOMEcgD3u5BJrf
	kSC56gJqaYi8KmhPgbBKZ+W+V2LGTdjeZ0W/dSZHDbPjgdeK7if51fxFIUNP4rP6
	hhLY+LVFuZ/PYvOF1LfVpuMyGoW9O4uFgatUmc6dwa8spSRmVtazNbKmUPr8LytT
	/hFWDJe0Sndxiq11t+WxG7BUZ+RmCmNEL9VwjZBWf+9acVOCuKVONA2AVD61KRyr
	P04oyA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4802q2hgcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 14:33:38 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 23DF340048;
	Thu, 24 Jul 2025 14:32:26 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5F8046D58FD;
	Thu, 24 Jul 2025 14:31:40 +0200 (CEST)
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Jul
 2025 14:31:40 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Thu, 24 Jul 2025 14:31:19 +0200
Subject: [PATCH net-next 2/2] net: stmmac: select STMMAC_RELATIVE_FLEX_PPS
 for stm32 SoCs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250724-relative_flex_pps-v1-2-37ca65773369@foss.st.com>
References: <20250724-relative_flex_pps-v1-0-37ca65773369@foss.st.com>
In-Reply-To: <20250724-relative_flex_pps-v1-0-37ca65773369@foss.st.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093;
 i=gatien.chevallier@foss.st.com; h=from:subject:message-id;
 bh=kYc22+pXE94O5MsVh/juNZH7hoJMz0fgwyYxca0rS58=;
 b=owEB7QES/pANAwAKAar3Rq6G8cMoAcsmYgBogiepsTgLPZrrGMt8M3XPMRT2k5dmelVV3cHXc
 q9ZAMJ4qSmJAbMEAAEKAB0WIQRuDsu+jpEBc9gaoV2q90auhvHDKAUCaIInqQAKCRCq90auhvHD
 KGcZDAC2we1zr9ttzik/UGxxTs6+etvxhZ0YdGNPoolAcEHDnw25ypGEq63DObs3YOEc2Bh4f1o
 aBdjY0Ty7gv0RsDXsLckk/swrytxeRvD/+sJP1sbw9Vc9rZTgLqFIFsTufOo5VpMsKYgf36xiO8
 Hnej7HVWtsxZfD8M5Al/cZ3qrbnq2ZFhiTj5c/wYmGqKsWfQoTpKeXB3JEwEVC5+E+yz813aHmG
 KnEXMabOtoDKkfgUlxTESNn8X4z9Yv60Ily6ReZTBN65DCDoMNK/Z+8Alxe9t40hP88TdpbX8Do
 pTRbfAOHNEONAmbr3OsVaatVDzN0Y7xqi2KteCWN3QzzE7dSK19hZB5KyZqITOrb5Z+EmTVq0a9
 sHua8pGthqjr05iB4or9VNHOL1wgbKjvaHXvhycDNM+m2NHX3IUcVl4jdnaTzrtktT71tQsdmtd
 eWE8lW8buHb41twjsq082g2ZmWBbSyYLl4vs75ucNCigNi45Z/gxKzGFdNEg0uw3zlt9k=
X-Developer-Key: i=gatien.chevallier@foss.st.com; a=openpgp;
 fpr=6E0ECBBE8E910173D81AA15DAAF746AE86F1C328
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01

In order to simplify the generation of flexible PPS signals by passing
an time offset relative to the MAC system time, select
STMMAC_RELATIVE_FLEX_PPS for DWMAC_STM32 config.

E.g: "echo "0 3 0 1 1" > /sys/class/ptp/ptp0/period" generates a PPS
that has a 1s period, 3 seconds after entering the command for ptp0 clock,
given that the MAC system time stays stable.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 949c744d30f19f5ff480dca4811e678d2b93c450..98fae30ad5a2760ec6b9cebf3dcaf8e4d7d19b77 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -233,6 +233,7 @@ config DWMAC_STM32
 	default ARCH_STM32
 	depends on OF && HAS_IOMEM && (ARCH_STM32 || COMPILE_TEST)
 	select MFD_SYSCON
+	select STMMAC_RELATIVE_FLEX_PPS
 	help
 	  Support for ethernet controller on STM32 SOCs.
 

-- 
2.25.1


