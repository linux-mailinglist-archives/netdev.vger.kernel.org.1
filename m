Return-Path: <netdev+bounces-201414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D717AE9654
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3FF55A13D2
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 06:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3763226D18;
	Thu, 26 Jun 2025 06:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="g0m/wFnB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C0E13A3F7;
	Thu, 26 Jun 2025 06:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750919712; cv=none; b=P8uTkIEZ7Sg9WKCIDtrhb1h5qSF9gCJgw7EEl6D5mDFZRID7F5066JSPzh76E1hPkVqV/ojT5dJn1qTkhSDS9u3Vd/tFUSdxFH0Xwco43RQm3ZsCludn0DuLKLPKoj//okSYzCSuJ8WuI5aUqbzMyzAd253D202sW30y/tpsdSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750919712; c=relaxed/simple;
	bh=kXEwt3IRU2NN6XR4T29MvS381DWcfgzy/ExFUQTFHXc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwM1xhA3gsxrAxEp7JbBQ0f98jMOpZd1osm7i/AdXzz+I+MgED3WZY+8GGHa9WH6DKeqY+s27WidyWRa3lwiFtL0tMHhikn1nkki88HXu1fuQ9LkDk/CXnFnrLBrIx6PrFqsd4FIU6hrsXnLyZGBiQ7vlrH7YyAVcHm0K5HPw9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=g0m/wFnB; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PI6RxZ019763;
	Wed, 25 Jun 2025 23:34:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=/6+WkD4QKS5qw/KRv6OC76vlR
	Djj+Bgyl5FuINvA4tI=; b=g0m/wFnBbrUp46kQzthTvmNcQYmJSXvVQKnDUA8zl
	V6x3qXfQQC1fmAQ3f6Z6Ovp1EQsOjcW/RL6Xanmjbx0HpCyLAL6Uarm0kdu+zEiT
	bGPUvhTq/sVGqmIvrnjMqRLt+j3FfJ7Co7+TvrXBp2t8s/KdoGZzsL5A2//rQxhE
	TfRa3gBopk55a+C0uNRDR6ObESX3x83YcOCAdkLuP/dPan9FBi35fEVNC4WCUEo6
	Hr4+MFcv8xVjqh2pYId1WDG+YvBCjJEo84kKMO4vb+wPf1PSHLyyH0ZoOic7JN9C
	2d/eT+oImf8+Kp95CpvsE64RgC1y/CLHHU9NrOlatAYVg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47gp3q95v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 23:34:43 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 25 Jun 2025 23:34:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 25 Jun 2025 23:34:28 -0700
Received: from 822c91e11a5c (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id 360CC3F7077;
	Wed, 25 Jun 2025 23:34:23 -0700 (PDT)
Date: Thu, 26 Jun 2025 06:34:23 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Sai Krishna <saikrishnag@marvell.com>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya
	<gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>, hariprasad
	<hkelam@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH net-next] octeontx2-af: Fix error code in rvu_mbox_init()
Message-ID: <aFzp70LaPoO0ukw8@822c91e11a5c>
References: <ee7944ae-7d7d-480d-af33-b77f2aa15500@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ee7944ae-7d7d-480d-af33-b77f2aa15500@sabinyo.mountain>
X-Authority-Analysis: v=2.4 cv=AemxH2XG c=1 sm=1 tr=0 ts=685cea03 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=M5GUcnROAAAA:8 a=BdBXECxqI82sMXVekp8A:9
 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22 a=OBjm3rFKGHvpk9ecZwUJ:22 a=yGmsW_zf-WRfUAWRrVPH:22
X-Proofpoint-ORIG-GUID: rr-0S0kE2nnZrOVJiDy2RL4GxNgV0ymn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA1MiBTYWx0ZWRfX4hOtyfPTcBMi jtnd7kv0aVeZF+b8wCmCoLgKkaObtcZ5Er6sS9SKl8sDnGgC5Yz5WftEXCLRZLsTdIR+R9DoiMt 8TxxFvJs+FNThxbMb/QzOeVxQrQV7ThY6w4av1nSPkBrl2CBWG3g7ABC+45jhy2mVLM+QZqOTq/
 IH3C+biTBk/h5dG6SifF7mtXtB0B/zjtatYRerDEDtL3AZrWQHywwfX9OV69jMvVSn84HNVySbH GpvUEwEyiuOK3b9AYiL1+ZLsRbN5yUSNmFXIQ8D6EKWJ175dx1McANSXAYo81a+pu8rzcAu2VtA jm9RVmJhsROZ/cEyDNv5R9wIIpsKzWekEhT5gktLlYhH6NOPu3loQ9EnIKkvgn1sUnbr/k7b6Kf
 5V7Kezg+ptIsEL3NweP8CGDzeavdGWx/SVDwrAidq5hPJbgRIQk3g8cUXMpuRrnKFj/ZiTIJ
X-Proofpoint-GUID: rr-0S0kE2nnZrOVJiDy2RL4GxNgV0ymn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_03,2025-06-25_01,2025-03-28_01

On 2025-06-25 at 15:23:05, Dan Carpenter (dan.carpenter@linaro.org) wrote:
> The error code was intended to be -EINVAL here, but it was accidentally
> changed to returning success.  Set the error code.
> 
> Fixes: e53ee4acb220 ("octeontx2-af: CN20k basic mbox operations and structures")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

 Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

 Thanks for the patch. This has been pointed by Simon earlier:
 https://lore.kernel.org/all/20250618194301.GA1699@horms.kernel.org/

 Thanks,
 Sundeep

> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> index 7e538ee8a59f..c6bb3aaa8e0d 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> @@ -2458,9 +2458,9 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
>  			 void (mbox_handler)(struct work_struct *),
>  			 void (mbox_up_handler)(struct work_struct *))
>  {
> -	int err = -EINVAL, i, dir, dir_up;
>  	void __iomem **mbox_regions;
>  	struct ng_rvu *ng_rvu_mbox;
> +	int err, i, dir, dir_up;
>  	void __iomem *reg_base;
>  	struct rvu_work *mwork;
>  	unsigned long *pf_bmap;
> @@ -2526,6 +2526,7 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
>  			goto free_regions;
>  		break;
>  	default:
> +		err = -EINVAL;
>  		goto free_regions;
>  	}
>  
> -- 
> 2.47.2
> 

