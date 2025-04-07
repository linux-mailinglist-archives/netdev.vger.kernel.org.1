Return-Path: <netdev+bounces-179581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C49A7DB8D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 12:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CDFA188EB4A
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 10:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19A2238148;
	Mon,  7 Apr 2025 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="alyHP/Hu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059D5237194;
	Mon,  7 Apr 2025 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744023215; cv=none; b=mCinvOteXHODt8/b+1uDtNco3K6Xd14vyQiqN74zEABjIPtztcz5K2M6frXNdd8Hec+UWN7Nno+8uxl2PbuXUtjZJUe4rmFcdjXVy21b1SDef1ZdKMnFTz9jfeeD/rsD+37G86EDMAikE1Fkp3bC6lNiyEbGqJMy0Nbk+joJE/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744023215; c=relaxed/simple;
	bh=GInDbNKfGGjESaMeC4D8+O01PDEzZ/WhFhju/ZTi0Ag=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElkWx0iMDGU0yKqfXhlrpTjIivygrT7dyoisaB/r5zq3DG723EnZhoJr7EINWR2iukyf+Gkzx2NMnZ+XJMiZyEoOUZDR9rAzAg39VI82fn0DWj2zlTbJMGoWkOs0B8+OjlxoQ6m0UW3ESmllOZnQ0vpyhSe72Z7wFo0Z6WiRqtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=alyHP/Hu; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5372o6nO020246;
	Mon, 7 Apr 2025 03:53:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=NenO193NDkHey5LBSKJMjivOr
	Ey5IGe18VgLIIxS7u0=; b=alyHP/Hun5wglwK32cpknS33PnZOfav7JaeQzWPys
	o+qG0auCZ99EZAiGeHg2fmy+TBp34yVK0a+U9c/hSxcf0Z7z9i8xLsrhq4rZmKBb
	C1eae4qr7AQ6TK1oc7+u35KjwlNmGVnYgVBby80gU9T0j33fuglTXKz0DMjQ9pUs
	TH3+FD3bPLGGN8A0bCFVO2SSYC4lsMevTyTFFs0vC4/bnZ3UKHhveyJjOnm5GeyB
	paieRv2CJ8NBCg1jmaNLPEl0JpjlfmEhwTOAOMl4HzXUhJpwHAntSam3sB12ILMY
	jy/UEAjebF7s1d694RUi3sMerZjOFQ3h2rtq1TKANfXpw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45ursc1rnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 03:53:08 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 7 Apr 2025 03:53:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 7 Apr 2025 03:53:08 -0700
Received: from a9548d409c0b (HY-LT91368.marvell.com [10.29.8.52])
	by maili.marvell.com (Postfix) with SMTP id E9BA65B6954;
	Mon,  7 Apr 2025 03:53:04 -0700 (PDT)
Date: Mon, 7 Apr 2025 10:53:03 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Wentao Liang <vulab@iscas.ac.cn>
CC: <sgoutham@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] octeontx2-pf: Add error log
 forcn10k_map_unmap_rq_policer()
Message-ID: <Z_Ouj7YHfJf0Wd2K@a9548d409c0b>
References: <20250407081118.1852-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250407081118.1852-1-vulab@iscas.ac.cn>
X-Proofpoint-GUID: kn0Pbm6ZNiCHunPD4TUfLFTGT6UTM6VK
X-Authority-Analysis: v=2.4 cv=M85NKzws c=1 sm=1 tr=0 ts=67f3ae94 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=6twwJq9BYjRo9P0tgCAA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=MdnaEeoEtbPGM3ywBibD:22
X-Proofpoint-ORIG-GUID: kn0Pbm6ZNiCHunPD4TUfLFTGT6UTM6VK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_03,2025-04-03_03,2024-11-22_01

On 2025-04-07 at 08:11:17, Wentao Liang (vulab@iscas.ac.cn) wrote:
> The cn10k_free_matchall_ipolicer() calls the cn10k_map_unmap_rq_policer()
> for each queue in a for loop without checking for any errors.
> 
> Check the return value of the cn10k_map_unmap_rq_policer() function during
> each loop, and report a warning if the function fails.
> 
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

Thanks,
Sundeep

> ---
> v3: Add failed queue number and error code to log.
> v2: Fix error code
> 
>  drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> index a15cc86635d6..9113a9b90002 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> @@ -353,8 +353,10 @@ int cn10k_free_matchall_ipolicer(struct otx2_nic *pfvf)
>  
>  	/* Remove RQ's policer mapping */
>  	for (qidx = 0; qidx < hw->rx_queues; qidx++)
> -		cn10k_map_unmap_rq_policer(pfvf, qidx,
> -					   hw->matchall_ipolicer, false);
> +		rc = cn10k_map_unmap_rq_policer(pfvf, qidx, hw->matchall_ipolicer, false);
> +		if (rc)
> +			dev_warn(pfvf->dev, "Failed to unmap RQ %d's policer (error %d).",
> +				 qidx, rc);
>  
>  	rc = cn10k_free_leaf_profile(pfvf, hw->matchall_ipolicer);
>  
> -- 
> 2.42.0.windows.2
> 

