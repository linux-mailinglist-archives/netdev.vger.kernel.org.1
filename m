Return-Path: <netdev+bounces-179514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A52A7D3CB
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 08:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410C23ADE4E
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 06:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B432135A4;
	Mon,  7 Apr 2025 06:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BrnpHO9O"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8064A55;
	Mon,  7 Apr 2025 06:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744005736; cv=none; b=W8j4jHiQ/HmDCLR7N3spslaVmtUTNztDMKNi9Ds3tCIoJlD78gU8QcPFj3KcDjxXwuumPJmVxelrQvGlzukXNEXQYB9+so9l3wXuX8jOo9oLtzWmEPgWqn9ngHdxPLnO6piOLiENiRi3JP0koK78U8aioH8vjsKhldM/eFRo8sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744005736; c=relaxed/simple;
	bh=H/DN+IGFERvFuFDKrxwkrcuAN/o1R7RZj+ZcKKslgls=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N2dWhKa3yZaMWcf9fDfP7HKSa4miV6yXtnpJHmaF1DGZSfok9kCFxSiWeIvVMofRW6VFIh1Vl9ZfARqakFNFtWOBTHQ9X2FRYaYLH/hdftVxC+BY5Nt284e8f4kMHlgD/Xtyzo27/n/yi4yMfDD2jFuAxC3ZGpeRSu2eepA7+ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BrnpHO9O; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5372oEQd001745;
	Sun, 6 Apr 2025 23:02:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=44fsOX6TG7LBfegSeqHa/Lp8L9umgjt8n2TcLILnhz0=; b=Brn
	pHO9OXdZar81ZjD8I2axk20ceVRhGGiquMKwKmxyEZ1dz6At4oBZpvQu/1coNSPG
	2buxJaTkyslG4O3iSOGXv5hKeqwirkeCNcYX29ILThcxp9dTTiK8zIm0VzfV0pbA
	DLqRfQiCecAmidWBvyt5H6Cs6TUowzsaHxpoSOjAT34WK/VkW2JMPHRHCtwhIQXU
	gCz8Oo3/94ndXXqw77A9nR0uPnh77Pb5lT3EmtfkCRzQEtpoN7JgozqXzt1nq6ub
	qKH7ci198DjG1xW/icqdE7fAhKve8G2nK1N+3kJetr24x4hX+XkJuSTKJuo1/p1W
	h+4TZIAMtq7sNALS/AQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45un99segn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 06 Apr 2025 23:02:03 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 6 Apr 2025 23:02:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 6 Apr 2025 23:02:02 -0700
Received: from 452e0070d9ab (HY-LT91368.marvell.com [10.29.8.52])
	by maili.marvell.com (Postfix) with SMTP id E55945E689E;
	Sun,  6 Apr 2025 23:01:58 -0700 (PDT)
Date: Mon, 7 Apr 2025 06:01:57 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Wentao Liang <vulab@iscas.ac.cn>
CC: <sgoutham@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] octeontx2-pf: Add error log
 forcn10k_map_unmap_rq_policer()
Message-ID: <Z_NqVUSiG6Ia1qSK@452e0070d9ab>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Authority-Analysis: v=2.4 cv=I/JlRMgg c=1 sm=1 tr=0 ts=67f36a5b cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=8WfIFTDPXWsKq01BisAA:9 a=CjuIK1q_8ugA:10 a=MdnaEeoEtbPGM3ywBibD:22
X-Proofpoint-GUID: Ups23XZxmlBTK0z0QtCZeE3XS11QHXVF
X-Proofpoint-ORIG-GUID: Ups23XZxmlBTK0z0QtCZeE3XS11QHXVF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_02,2025-04-03_03,2024-11-22_01

On 2025-04-05 at 15:23:34, Wentao Liang (vulab@iscas.ac.cn) wrote:
> The cn10k_free_matchall_ipolicer() calls the cn10k_map_unmap_rq_policer()
> for each queue in a for loop without checking for any errors.
> 
> Check the return value of the cn10k_map_unmap_rq_policer() function during
> each loop, and report a warning if the function fails.
> 
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> index a15cc86635d6..895f0f8c85b2 100644
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
> +			dev_warn(pfvf->dev,
> +				 "Failed to unmap RQ's policer.");

Print failed queue number also please.

Thanks,
Sundeep
>  
>  	rc = cn10k_free_leaf_profile(pfvf, hw->matchall_ipolicer);
>  
> -- 
> 2.42.0.windows.2
> 

