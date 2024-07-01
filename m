Return-Path: <netdev+bounces-108004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6479691D847
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 08:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC3CFB2114E
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 06:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91B147F45;
	Mon,  1 Jul 2024 06:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="cuvQgMeU"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F3A81AB6;
	Mon,  1 Jul 2024 06:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719816661; cv=none; b=GxFcJ7zTNC2zd4PcgHDoWFP2HtjiefpNITzxjWqQcZ7spbkE9abJEgODjLFYbcLMsO3cw3qQQWpRQqSDgVoWxtiSFjNgGovfc5JXKV8KbA1HmQT0uVF5gxMtAVhJ7PRmmN+LGtr//n7hPYfIM30ECI2if7w1pscil5y1ZIKATW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719816661; c=relaxed/simple;
	bh=V45pDhWOjj9ZnjgUrk2MPtnmz3Bx1uG6/4DaCIklLaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOqXMZuFH8sNvi78EFcdZGENNxRMmapZHNREF2mXVatAVW7NmOHWm7WZfweUQsauepWzkPqd0P7l7cfCWuy+5sxdyU3rloCR9raIJ/9g5KrjVTUiuAW4R3ZtZ7nOpIlJKmpsX9fl17hHRMmYBFK1JRc5J+zea2jcTuv/gBeTWeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=cuvQgMeU; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UL7pwx008788;
	Mon, 1 Jul 2024 08:50:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	oVYvgLSac21UfB9I65BrDV2O86rp+PBBcbFGWgOHqeg=; b=cuvQgMeUUIhp8zgx
	6JJFFzfAG/5LWTMD+y8ewBMWpKQd/GVQccxhWhPX9qbJMYbljVn2B6vh/PWJxaBp
	YrN9KdChzRpNmsrp9FRJsPzi1QpjmPmzS/eKXc3l7jTKuki8X9iSqjwOyURdrar7
	TTDms71uZaG1qcprYLmt0+fJwKiHhgLlyR4b5JkQF6jQTCMkS3V4THeB0zc4Gh9y
	TqknG2fzMpWxM6lNrAbnpWFVtZwx/OmN13Y4ptheqnhvIYZtxiHPG1qwLJm4cmYH
	nEhd7YsLBmZlRLbe3U5lAeIcm045rQ93JZUMaR1hei23ltptsNxXMxmLb9mTCFko
	vmOGEA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 402uu0k9ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 08:50:36 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 459C840046;
	Mon,  1 Jul 2024 08:50:32 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D65DF214D1D;
	Mon,  1 Jul 2024 08:49:18 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 1 Jul
 2024 08:49:17 +0200
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
Subject: [net-next,PATCH v2 2/2] net: stmmac: dwmac-stm32: update err status in case different of stm32mp13
Date: Mon, 1 Jul 2024 08:48:38 +0200
Message-ID: <20240701064838.425521-3-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701064838.425521-1-christophe.roullier@foss.st.com>
References: <20240701064838.425521-1-christophe.roullier@foss.st.com>
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
 definitions=2024-07-01_05,2024-06-28_01,2024-05-17_01

The mask parameter of syscfg property is mandatory for MP13 but
optional for all other cases.
The function should not return error code because for non-MP13
the missing syscfg phandle in DT is not considered an error.
So reset err to 0 in that case to support existing DTs without
syscfg phandle.

Fixes: 50bbc0393114 ("net: stmmac: dwmac-stm32: add management of stm32mp13 for stm32")

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
Reviewed-by: Marek Vasut <marex@denx.de>
Tested-by: Mark Brown <broonie@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index d6a268237ca1..c1732955a697 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -435,10 +435,12 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
 	dwmac->mode_mask = SYSCFG_MP1_ETH_MASK;
 	err = of_property_read_u32_index(np, "st,syscon", 2, &dwmac->mode_mask);
 	if (err) {
-		if (dwmac->ops->is_mp13)
+		if (dwmac->ops->is_mp13) {
 			dev_err(dev, "Sysconfig register mask must be set (%d)\n", err);
-		else
+		} else {
 			dev_dbg(dev, "Warning sysconfig register mask not set\n");
+			err = 0;
+		}
 	}
 
 	return err;
-- 
2.25.1


