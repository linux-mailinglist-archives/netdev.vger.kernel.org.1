Return-Path: <netdev+bounces-102229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5759290209B
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 13:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9641C216CE
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 11:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644A97E103;
	Mon, 10 Jun 2024 11:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JcA32OQb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CDC7D071;
	Mon, 10 Jun 2024 11:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020004; cv=none; b=I2MYdCgh5NRc/yU67dh78prIiakQXgnnRPlQOtq2g1QDqBQamCghCtG/xe/8QgNF3UdV0T4Qwx0w51uee8VN+8msun0EBqCMSaHEq3KnP+VJVfYbfxQqrciyrXYFJ45/silBswq9t3RRYMULPaoO/DDR/btGy0YPFZRp/z2trNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020004; c=relaxed/simple;
	bh=Pw3XMzxkqBcYJK8n3Hl44rHcXbi9ISiDEWqAeKRSZa0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltaVeCWJ8B+AajGor2pTOsy/RIyoKAjyXIE3XPrdk0WsIgcPB2Pi58sZj9GWUgZmKp5wcF08GGVX36On6TdMvu3ZXZuKtUfNhMxjwWHpT6eQSJjbeOEuEiapOy8SU0uA32+63L6zmALFhHIvVSupOmiFSMbqW3oe8iLxITVPD2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JcA32OQb; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 459Mua2u012266;
	Mon, 10 Jun 2024 04:46:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=6pulhWIr94j2TGUi2m0B9hvD1
	Du6IzbTRrsDCUT7KnE=; b=JcA32OQbVl4yJ+lHz5UbcgHplD+k9oU9UnSzT+wVW
	TpwfbOlqCq/vMjTvSLd27Dk2efvsudD0S5zF2Whz2XDB3GgvoD1/7jkux2dwdCEW
	E0ta+C/KloXw1bIEx75UkMl7Kiw0hYuNUxo40AomLWpBedwGNeIkava6nzZg5ulD
	PueQxwDZaMGB/tSQdZdF5e688m80U8PX5mcyD2wrynPuGW85syo9cGe8xb77+qRp
	bpdBHAJ3zCsVDjh5ZvERybsKsEYty5BpTRB/kTBezr1BRbcR8sK7dzNXb8e/QGPW
	DJ9W39x2xCF8NNdLqdTRbuMmky1lQtXhxRoRYtg7sOCrg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ympth4wga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 04:46:15 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 10 Jun 2024 04:46:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 10 Jun 2024 04:46:14 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id C822C3F707B;
	Mon, 10 Jun 2024 04:46:08 -0700 (PDT)
Date: Mon, 10 Jun 2024 17:16:07 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Christophe Roullier <christophe.roullier@foss.st.com>
CC: "David S . Miller" <davem@davemloft.net>,
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
 Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 02/12] net: stmmac: dwmac-stm32: Separate out external
 clock rate validation
Message-ID: <20240610114607.GA3818685@maili.marvell.com>
References: <20240607095754.265105-1-christophe.roullier@foss.st.com>
 <20240607095754.265105-3-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240607095754.265105-3-christophe.roullier@foss.st.com>
X-Proofpoint-GUID: 0poOBUDz3LSw5F2jxMlud8T4HHieX8pu
X-Proofpoint-ORIG-GUID: 0poOBUDz3LSw5F2jxMlud8T4HHieX8pu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-10_01,2024-05-17_01

On 2024-06-07 at 15:27:44, Christophe Roullier (christophe.roullier@foss.st.com) wrote:
> +static int stm32mp1_validate_ethck_rate(struct plat_stmmacenet_data *plat_dat)
> +{
> +	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
> +	const u32 clk_rate = clk_get_rate(dwmac->clk_eth_ck);
nit: reverse xmas tree, split definitions and assignment.

