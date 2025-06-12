Return-Path: <netdev+bounces-196924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD830AD6E70
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE621790E3
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB41238172;
	Thu, 12 Jun 2025 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="V1uWe0Pr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3E021B9F5;
	Thu, 12 Jun 2025 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749725895; cv=none; b=DzsMWwA4TBJGJhMAsQBzob1+7xwvjJHyHEB4WpbkIp8hsJawI1tTfa/pzs9l1mo3hbEA+nSRHQD+krWFPB6m5+zCf62tkASko1Ll1p/U3a7v5dfneMgXBRd/AmiiYaJLX+IaiMDJo+x/9Y7mTspAWXo0AM54jdCRYTm50iFB5bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749725895; c=relaxed/simple;
	bh=H4OuaDf5StydheIM3OLEp7rVlhFLqCXAFgq/V1hQP6E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qt83HBRlBMy1wwSLaOI0y+VNJgY//NJ9JKZH6SXpLoytZ9NTVA7wnW6BOnBo7tawe12utBrliUtWg4N3ap0SUQKZHHaGgwXqCH67300MfKe6UoCIUFl4JblIWMqZfBxZcqvsP1Vz4AtPP6E3FyZZFYIJ4eyUxB6wOKvmcsRsoDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=V1uWe0Pr; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C8nOrH008416;
	Thu, 12 Jun 2025 03:57:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=RzrmsF3U8d58TCrCiaBdRk3nm
	+8EgVOFqwwqcZbva7c=; b=V1uWe0PrCfmDa/X6zFt+9GUnFC2/hqwnnNlmpX0IJ
	mXM/uDEQrVjekqfTZD5d1yngRZONqPnfFQXygcP39FM1emvq7sWS03IVNQeco5eB
	jB43PDno4RGxw2/iNOfUrt/Tu/9dMmtlDswNO72RBQUq/kpeSppyvWMbd/Lalzib
	EmlZ1jo3epgUEz4HMUDGEton8+9lzUEy6q9OTyWlQtKAoAtTQ3XUIOIOZrdoX9oF
	YGDP7FujsJdqi7cRLJU14qfowMvKLGxZe8eqm7kcexKFZfcdn3/5JmV5lN9EzRQ+
	jH0C45yLcVk7+TZbN2LQRsnJ8aXy9HmjL3efAUscpiBvQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 477ttj8d8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 03:57:56 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Jun 2025 03:57:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Jun 2025 03:57:55 -0700
Received: from a5393a930297 (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id 75A1A3F7044;
	Thu, 12 Jun 2025 03:57:51 -0700 (PDT)
Date: Thu, 12 Jun 2025 10:57:49 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Jon Hunter <jonathanh@nvidia.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-tegra@vger.kernel.org>,
        Alexis Lothorrr <alexis.lothore@bootlin.com>
Subject: Re: [PATCH] net: stmmac: Fix PTP ref clock for Tegra234
Message-ID: <aEqyrWDPykceDM2x@a5393a930297>
References: <20250612062032.293275-1-jonathanh@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250612062032.293275-1-jonathanh@nvidia.com>
X-Authority-Analysis: v=2.4 cv=FssF/3rq c=1 sm=1 tr=0 ts=684ab2b4 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=Ikd4Dj_1AAAA:8 a=j1aDQpsCGRxs8slw8KsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: uMA3pJ9d0Kjiajs8b8PSsUwxBvIcSg4W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA4MyBTYWx0ZWRfXxq1/obkGJyr/ 1Bc/1xofZuyUO/2muYyZEqJYKDzcOmeUBvHiyniZ8Xex2cXo31moCqxdTqIcYXYNhpfBujIm0KU UEpbn8hrhwHeq+7o+im+sBLJiKNRpuUomo3/UyL7a8+9jA5NkLp5OWNf+NH0rJtTORPL96szvF3
 40jqF/i7AHRCF/5PC5MHqw24U8GvQjZ4RdsnsgQLIrDCqzEa/5Ywr995vJHfVEAivjhmxngojME TFAkVszAYcdJDsNvOywWna4m0gAR8oJOTY0W1mrZfPkrY+POZqVbuOsxWDWJly21AoWxH5XGDvT M5NWrwYoncz2tDU3QLp4yTBIBTNPP75vKMuTInlnZZZ885bniUjWtyQwaqPlYEIjWg1Iuh8D4Fz
 paU12PE+2ZblYF+BQbvJuUK8EVUGr6IOqFQcfE7dUPgAeTP97Zf6K/Efz7b6z9N+GHvETVbd
X-Proofpoint-GUID: uMA3pJ9d0Kjiajs8b8PSsUwxBvIcSg4W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_07,2025-06-10_01,2025-03-28_01

Hi,

On 2025-06-12 at 06:20:32, Jon Hunter (jonathanh@nvidia.com) wrote:
> Since commit 030ce919e114 ("net: stmmac: make sure that ptp_rate is not
> 0 before configuring timestamping") was added the following error is
> observed on Tegra234:
> 
>  ERR KERN tegra-mgbe 6800000.ethernet eth0: Invalid PTP clock rate
>  WARNING KERN tegra-mgbe 6800000.ethernet eth0: PTP init failed
> 
> It turns out that the Tegra234 device-tree binding defines the PTP ref
> clock name as 'ptp-ref' and not 'ptp_ref' and the above commit now
> exposes this and that the PTP clock is not configured correctly.
> 
> Ideally, we would rename the PTP ref clock for Tegra234 to fix this but
> this will break backward compatibility with existing device-tree blobs.
> Therefore, fix this by using the name 'ptp-ref' for devices that are
> compatible with 'nvidia,tegra234-mgbe'.
AFAIU for Tegra234 device from the beginning, entry in dts is ptp-ref.
Since driver is looking for ptp_ref it is getting 0 hence the crash
and after the commit 030ce919e114 result is Invalid error instead of crash.
For me PTP is not working for Tegra234 from day 1 so why to bother about
backward compatibility and instead fix dts.
Please help me understand it has been years I worked on dts.

Thanks,
Sundeep
> 
> Fixes: d8ca113724e7 ("net: stmmac: tegra: Add MGBE support")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index b80c1efdb323..f82a7d55ea0a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -635,8 +635,12 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
>  	}
>  	clk_prepare_enable(plat->pclk);
>  
> +	if (of_device_is_compatible(np, "nvidia,tegra234-mgbe"))
> +		plat->clk_ptp_ref = devm_clk_get(&pdev->dev, "ptp-ref");
> +	else
> +		plat->clk_ptp_ref = devm_clk_get(&pdev->dev, "ptp_ref");
> +
>  	/* Fall-back to main clock in case of no PTP ref is passed */
> -	plat->clk_ptp_ref = devm_clk_get(&pdev->dev, "ptp_ref");
>  	if (IS_ERR(plat->clk_ptp_ref)) {
>  		plat->clk_ptp_rate = clk_get_rate(plat->stmmac_clk);
>  		plat->clk_ptp_ref = NULL;
> -- 
> 2.43.0
> 

