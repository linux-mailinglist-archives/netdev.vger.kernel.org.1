Return-Path: <netdev+bounces-209794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A467B10E29
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 17:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 998F37ADCB8
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 14:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5815F2E8DF1;
	Thu, 24 Jul 2025 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XbkB+ix9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97FC1A5B84
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753369169; cv=none; b=WS0IHRAdHFWcVqNEBsbLVvYKcYMgD6/lrlcK+p/MUFNLp9zBi9uyh234C+188wwZhnJfmUK6LAiKn2+HMJhx2MdCgsKcAZRszwXX8DEoOgxFpE5OWoleZ66je7/gSbYlZEiJH9R4vaPpCBKAL0Poyanc+0gmTiqrM4TfnZRBxN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753369169; c=relaxed/simple;
	bh=KueQATnS0Or9jvLh4kcYIg58tJHftU4LTymgVJgwiNI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNopIft35sJMNoSgSELzVV8Ky76q65Nrvi2MZW/xp7gVhpw3/Rq7m7KFlqTFkodMZLDiolk9Hp7c/o0bjgwuMFfpf2qYjnbm75K/eCVrCGpIpgPSJph3r0RDTIss1YWrA3qJRwR6cxbJsI8ir/PlbZH+4q8GtHfcfAnwS5WEphw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=XbkB+ix9; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OEMdKW015334;
	Thu, 24 Jul 2025 07:59:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=AyuSLv/BvTOwMTm7EN8AEHktK
	+CAe+TVMOA/bU9821Q=; b=XbkB+ix9GOLKGwkOxsQd/N3Gdt/f1i4GkWSPwYbYv
	/P4xjWdLijlDdqjeo8hwgnynyleOIYcZXl+FgoVCGfEBbiSvb+TdDfCCsU8S7qGr
	zmmHq4kgx1DP+LwDXi6v0iG+OCHFzeFOcxKv0xLZvzTkPdwrrozP7pGkX/bGCsxd
	rRdBiSZ8i66lakmr/IcdPoXuUulwxLuMi8nTeRbZe/nKXbZroLwYUEys36UVgThL
	jBxpuA7v+tWMm5TupDT5v4QhENhR+35op0sZxEfexweNuvfbzC6p0xlZt7Kc65Ju
	KguLYe5bFLgoahiGoWmzCi/TRswceN6+oeg3AkN5Q9huA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 483keu0g3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 07:59:19 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 24 Jul 2025 07:59:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 24 Jul 2025 07:59:19 -0700
Received: from opensource (unknown [10.29.20.14])
	by maili.marvell.com (Postfix) with SMTP id 904D83F708D;
	Thu, 24 Jul 2025 07:59:03 -0700 (PDT)
Date: Thu, 24 Jul 2025 14:58:59 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>
Subject: Re: [net-next PATCH v3 09/11] octeontx2-af: Accommodate more
 bandwidth profiles for cn20k
Message-ID: <aIJKM9ujO6zxrBCT@opensource>
References: <1752772063-6160-1-git-send-email-sbhatta@marvell.com>
 <1752772063-6160-10-git-send-email-sbhatta@marvell.com>
 <20250722170847.GU2459@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250722170847.GU2459@horms.kernel.org>
X-Authority-Analysis: v=2.4 cv=FeE3xI+6 c=1 sm=1 tr=0 ts=68824a47 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=-ax0aanlVlcn4xxdY48A:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Pi1bAVXsjC0kQGN5hB-K0xx7QlXW0jhJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDExNCBTYWx0ZWRfX9rlrs+76TGQ2 2FCSp7eo5qGiCDZhXV2oKUsjszWE4ILo1LdMOgBrwvcLWCMU1tlcVc1RunqjMqRMClHE9ZEHzPa 4KIOfzGLNWPfi20lUb3t7GwiQxC0BfkdyO+M1k7FfgCM27Nghh/V1OG7q00cnjCM+xDOX8dtp39
 gTBA+lAl0KRmm7DN8taVo+9Q5IPdNFPaOJRhHtwXvwGtxvKcJ9J/7KA8MfczS8xo6KBj9RLhbhq yJRQJhAoh/jUw1yrFHXwf5VIuhnQx6+4FzbM+NEewBsY5+e3ETbEgl/25aMdLPnCNwmK9GgK1vm 6BgXi1p87Ga7ATBxuqpjc9xnjv1Xvel/294YmsR7rublGIesmfqqYdHzjiQ5dN7JFGPs1zPQTqi
 9KannqioOZBQufgp71vhZtcxMhyT6/hD0dTUotL64YeZUjtYFSxsrp7qqoVsOixFkF6aIPmE
X-Proofpoint-GUID: Pi1bAVXsjC0kQGN5hB-K0xx7QlXW0jhJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01

On 2025-07-22 at 17:08:47, Simon Horman (horms@kernel.org) wrote:
> On Thu, Jul 17, 2025 at 10:37:41PM +0530, Subbaraya Sundeep wrote:
> > CN20K has 16k of leaf profiles, 2k of middle profiles and
> > 256 of top profiles. This patch modifies existing receive
> > queue and bandwidth profile context structures to accommodate
> > additional profiles of cn20k.
> > 
> > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> > ---
> >  drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 13 ++++++++-----
> >  .../net/ethernet/marvell/octeontx2/af/rvu_struct.h  |  6 ++++--
> >  2 files changed, 12 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> > index 162283302e31..f6ecdb4b5ff9 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> > @@ -5856,7 +5856,7 @@ static int nix_verify_bandprof(struct nix_cn10k_aq_enq_req *req,
> >  		return -EINVAL;
> >  
> >  	ipolicer = &nix_hw->ipolicer[hi_layer];
> > -	prof_idx = req->prof.band_prof_id;
> > +	prof_idx =  req->prof.band_prof_id_h << 7 | req->prof.band_prof_id;
> >  	if (prof_idx >= ipolicer->band_prof.max ||
> >  	    ipolicer->pfvf_map[prof_idx] != pcifunc)
> >  		return -EINVAL;
> > @@ -6021,8 +6021,10 @@ static int nix_ipolicer_map_leaf_midprofs(struct rvu *rvu,
> >  	aq_req->op = NIX_AQ_INSTOP_WRITE;
> >  	aq_req->qidx = leaf_prof;
> >  
> > -	aq_req->prof.band_prof_id = mid_prof;
> > +	aq_req->prof.band_prof_id = mid_prof & 0x7F;
> >  	aq_req->prof_mask.band_prof_id = GENMASK(6, 0);
> > +	aq_req->prof.band_prof_id_h = mid_prof >> 7;
> > +	aq_req->prof_mask.band_prof_id_h = GENMASK(3, 0);
> >  	aq_req->prof.hl_en = 1;
> >  	aq_req->prof_mask.hl_en = 1;
> >  
> 
> Perhaps it follows an existing pattern in this driver.
> But the shifts in the above two hunks look
> ripe for using FIELD_PREP/FIELD_GET along with #define GENMASK(...).
> 
> Likewise elsewhere in this patch.
Okay will use FIELD_* macros.

Thanks,
Sundeep
> 
> ...

