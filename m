Return-Path: <netdev+bounces-209792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6219B10E1C
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 16:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACEDBAE117B
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 14:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1506D2DFF13;
	Thu, 24 Jul 2025 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hCagKSKp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DCE290BBD
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368912; cv=none; b=ZLMeP0ARouHnayiRauU/Rv3X3Z98JpD09fesXqCL6LBRDCroaHI8uXeWZac0HjBcZUqoRgTXP/vzFwffEEcnis8QPapmsdIsWaNB3u60wyQAjAFYjm506Xg7B6b5lRV5uq+R2YAWhrGWitmeJXYVe76h63g/zU1Kjpb8liNO+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368912; c=relaxed/simple;
	bh=xX45SJk1z7qeOvyYCrlbhWeLCMmqyh6ESKpZY8x10ME=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gf5a7NOTBkCmASbuZ03cyDzCUpHmu/SBcZYB5Pz3LhWzFDsAOwcefMeeAg50Bwe4lwPaVGb7dxpfG5i8SbeIshk7p3NCzbqVyYz56luTGTvrRknOFN0x3KdLJXXHCT5rgjStHkmuyYxRTgq5jL2yM/NDeHVv9B2yYIRQpFcH8Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hCagKSKp; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OEMcei015311;
	Thu, 24 Jul 2025 07:55:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=DfFNTbeVVojvbakTEgE6CrMbD
	6oNtFQnlKUmzrtvaMU=; b=hCagKSKpWLuKQWHOvaldvSzgIeiTa6IPjjoTODT7T
	8wO+y/t8JQ2WXpc3zxPSQeQ+NKvipfi5vyVAL7o9nKrcv4ay/g/BWrc3EkeB2j8/
	iNTsu2idiU5CrPGckXAZbN+qiqumdNhjtTCDy8G8zLwHPnUr0cc8P8wkvtFunMSk
	xMygBo6AWsbYu3MjPM+jxUCWAO9LJ4l0A+LQt4psdtZ3bf0LK6MVgvlu0OD2Kx8x
	dH6lDx/K+0VhiJPNe2Do7ErdESo65ku4vttdPVRSYCRutDysfypduDlPc52DXJJb
	uOaCEeek0mD9vZ0B4uHUaVmWozBo44u6nXFNUJvYfHDiA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 483keu0ft8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 07:55:01 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 24 Jul 2025 07:55:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 24 Jul 2025 07:55:01 -0700
Received: from opensource (unknown [10.29.20.14])
	by maili.marvell.com (Postfix) with SMTP id 13E703F7093;
	Thu, 24 Jul 2025 07:54:56 -0700 (PDT)
Date: Thu, 24 Jul 2025 14:54:55 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>
Subject: Re: [net-next PATCH v3 07/11] octeontx2-pf: Initialize cn20k
 specific aura and pool contexts
Message-ID: <aIJJP1OmYAk5Y6PE@opensource>
References: <1752772063-6160-1-git-send-email-sbhatta@marvell.com>
 <1752772063-6160-8-git-send-email-sbhatta@marvell.com>
 <20250722170344.GS2459@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250722170344.GS2459@horms.kernel.org>
X-Authority-Analysis: v=2.4 cv=FeE3xI+6 c=1 sm=1 tr=0 ts=68824945 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=kGzKJ8zlOR7XBKCSvVUA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 5ITDvTjJ92fzpW2l9Zl-_GRdQNpxF4sM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDExNCBTYWx0ZWRfX+zfqVKTTKvAh mvRbXo0cBHIXH+mjbooHRURYmpkJzo3q5Rgn4nX3UrH1jnTr+lZ73eazM9FgQbaHZiQmYirxrOT bjf7B2Fq4JjXaQqkS7Md2bO3qHDeF+u71+Gfzs0qXh21FXHrbr/3LBOMN0Eqoh0D27AnYspfITE
 t1hUAZtp3DiE4MokCVRXnSxjK02PDy/2Bb+cwXukzCVWwyu3iFurbU7szZDgAg3SyoVD4/a1Ej+ u4RQRxewkBHSvQvJmwET3E4Mspmg9XEoMeUjRjyIPzKn8FC8Nsub4iouZV0jJTEB+LhRg0/0YgK 1F2EAzQBgGT6PVTSFursJwgDFvx53VJq9L6Wc5lqtGwQBK4h7TXtviEtqGgZvEFzWYJE3Ar0TkQ
 3Sv9nUK/SM1V7UBQ9R8acM8OqRtZZ+0zoOZslPIvKI5x5MtLmeiGzYNi0Y++B4Mf8pZ5azAP
X-Proofpoint-GUID: 5ITDvTjJ92fzpW2l9Zl-_GRdQNpxF4sM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01

Hi Simon,

On 2025-07-22 at 17:03:44, Simon Horman (horms@kernel.org) wrote:
> On Thu, Jul 17, 2025 at 10:37:39PM +0530, Subbaraya Sundeep wrote:
> > From: Linu Cherian <lcherian@marvell.com>
> > 
> > With new CN20K NPA pool and aura contexts supported in AF
> > driver this patch modifies PF driver to use new NPA contexts.
> > Implement new hw_ops for intializing aura and pool contexts
> > for all the silicons.
> > 
> > Signed-off-by: Linu Cherian <lcherian@marvell.com>
> > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> ...
> 
> > @@ -250,3 +239,170 @@ int cn20k_register_pfvf_mbox_intr(struct otx2_nic *pf, int numvfs)
> >  
> >  	return 0;
> >  }
> > +
> > +#define RQ_BP_LVL_AURA   (255 - ((85 * 256) / 100)) /* BP when 85% is full */
> > +
> > +static int cn20k_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
> > +			      int pool_id, int numptrs)
> > +{
> > +	struct npa_cn20k_aq_enq_req *aq;
> > +	struct otx2_pool *pool;
> > +	int err;
> > +
> > +	pool = &pfvf->qset.pool[pool_id];
> > +
> > +	/* Allocate memory for HW to update Aura count.
> > +	 * Alloc one cache line, so that it fits all FC_STYPE modes.
> > +	 */
> > +	if (!pool->fc_addr) {
> > +		err = qmem_alloc(pfvf->dev, &pool->fc_addr, 1, OTX2_ALIGN);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	/* Initialize this aura's context via AF */
> > +	aq = otx2_mbox_alloc_msg_npa_cn20k_aq_enq(&pfvf->mbox);
> > +	if (!aq) {
> > +		/* Shared mbox memory buffer is full, flush it and retry */
> > +		err = otx2_sync_mbox_msg(&pfvf->mbox);
> > +		if (err)
> > +			return err;
> > +		aq = otx2_mbox_alloc_msg_npa_cn20k_aq_enq(&pfvf->mbox);
> > +		if (!aq)
> > +			return -ENOMEM;
> > +	}
> > +
> > +	aq->aura_id = aura_id;
> > +
> > +	/* Will be filled by AF with correct pool context address */
> > +	aq->aura.pool_addr = pool_id;
> > +	aq->aura.pool_caching = 1;
> > +	aq->aura.shift = ilog2(numptrs) - 8;
> > +	aq->aura.count = numptrs;
> > +	aq->aura.limit = numptrs;
> > +	aq->aura.avg_level = 255;
> > +	aq->aura.ena = 1;
> > +	aq->aura.fc_ena = 1;
> > +	aq->aura.fc_addr = pool->fc_addr->iova;
> > +	aq->aura.fc_hyst_bits = 0; /* Store count on all updates */
> > +
> > +	/* Enable backpressure for RQ aura */
> > +	if (aura_id < pfvf->hw.rqpool_cnt && !is_otx2_lbkvf(pfvf->pdev)) {
> > +		aq->aura.bp_ena = 0;
> > +		/* If NIX1 LF is attached then specify NIX1_RX.
> > +		 *
> > +		 * Below NPA_AURA_S[BP_ENA] is set according to the
> > +		 * NPA_BPINTF_E enumeration given as:
> > +		 * 0x0 + a*0x1 where 'a' is 0 for NIX0_RX and 1 for NIX1_RX so
> > +		 * NIX0_RX is 0x0 + 0*0x1 = 0
> > +		 * NIX1_RX is 0x0 + 1*0x1 = 1
> > +		 * But in HRM it is given that
> > +		 * "NPA_AURA_S[BP_ENA](w1[33:32]) - Enable aura backpressure to
> > +		 * NIX-RX based on [BP] level. One bit per NIX-RX; index
> > +		 * enumerated by NPA_BPINTF_E."
> > +		 */
> > +		if (pfvf->nix_blkaddr == BLKADDR_NIX1)
> > +			aq->aura.bp_ena = 1;
> > +#ifdef CONFIG_DCB
> > +		aq->aura.bpid = pfvf->bpid[pfvf->queue_to_pfc_map[aura_id]];
> > +#else
> > +		aq->aura.bpid = pfvf->bpid[0];
> > +#endif
> 
> >From a build coverage point of view it is a shame that we can't use
> something like this here (because queue_to_pfc_map doesn't exist
> if CONFIG_DCB isn't enabled).
> 
> 		bpid_idx = IS_ENABLED(CONFIG_DCB) ? ...;
> 
> But I do wonder if somehow it's nicer to constrain the #ifdef to an
> as-small-as-possible helper. Something like this (compile tested only):
> 
> @@ -242,6 +242,15 @@ int cn20k_register_pfvf_mbox_intr(struct otx2_nic *pf, int numvfs)
>  
>  #define RQ_BP_LVL_AURA   (255 - ((85 * 256) / 100)) /* BP when 85% is full */
>  
> +static u8 cn20k_aura_bpid_idx(struct otx2_nic *pfvf, int aura_id)
> +{
> +#ifdef CONFIG_DCB
> +	return pfvf->queue_to_pfc_map[aura_id];
> +#else
> +	return 0;
> +#endif
> +}
> +
>  static int cn20k_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
>  			      int pool_id, int numptrs)
>  {
> @@ -289,6 +298,7 @@ static int cn20k_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
>  	/* Enable backpressure for RQ aura */
>  	if (aura_id < pfvf->hw.rqpool_cnt && !is_otx2_lbkvf(pfvf->pdev)) {
>  		aq->aura.bp_ena = 0;
> +		u8 bpid_idx;
>  		/* If NIX1 LF is attached then specify NIX1_RX.
>  		 *
>  		 * Below NPA_AURA_S[BP_ENA] is set according to the
> @@ -303,11 +313,9 @@ static int cn20k_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
>  		 */
>  		if (pfvf->nix_blkaddr == BLKADDR_NIX1)
>  			aq->aura.bp_ena = 1;
> -#ifdef CONFIG_DCB
> -		aq->aura.bpid = pfvf->bpid[pfvf->queue_to_pfc_map[aura_id]];
> -#else
> -		aq->aura.bpid = pfvf->bpid[0];
> -#endif
> +
> +		bpid_idx = cn20k_aura_bpid_idx(pfvf, aura_id);
> +		aq->aura.bpid = pfvf->bpid[bpid_idx];
>  
Okay will modify as per your suggestion.

Thanks,
Sundeep
>  		/* Set backpressure level for RQ's Aura */
>  		aq->aura.bp = RQ_BP_LVL_AURA;
> 
> > +
> > +		/* Set backpressure level for RQ's Aura */
> > +		aq->aura.bp = RQ_BP_LVL_AURA;
> > +	}
> > +
> > +	/* Fill AQ info */
> > +	aq->ctype = NPA_AQ_CTYPE_AURA;
> > +	aq->op = NPA_AQ_INSTOP_INIT;
> > +
> > +	return 0;
> > +}
> 
> ...

