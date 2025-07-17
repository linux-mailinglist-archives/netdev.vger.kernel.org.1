Return-Path: <netdev+bounces-207955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F8DB09242
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 18:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C1857B76A4
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 16:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0492FCE34;
	Thu, 17 Jul 2025 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GFrXlH3e"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392E52F6FAD
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771289; cv=none; b=raPsmcRuwXn46P3kaW0tDYufGtoQepwJKsmciQnSXgcSId2jxXkFJlHVSfmvp0ynPU5cYLAVsWD59jBqoEuTHbjbUgWB4A9SZ982Nmj+3ALMjpuY+s2V+sHolhcprwX1G9MfvMisRwXodW8X5riBQsPPLTztkV9ykPzS5CTKd7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771289; c=relaxed/simple;
	bh=1h1WVuuAb98PSwzS2wFZF7PYMBdvAiL7dFQcsItT8EU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIynyUfg/RLvmLbLXsYX2eLpclgMU6uJSTV9PsnGrUTKgxzhFStkVohvi5PO3S6fEj+wGZN8NvaLKJu/cAN2rgg/oXexB0SWgJgaINkhGbixz/x+QNP8GCitctb70R8TTDMENb7al08GrVKwxViaXtt4JDJFiEw3vzoYhPx6MMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GFrXlH3e; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H9e5dj022219;
	Thu, 17 Jul 2025 09:54:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=CcKqaVQHH43jGiIVAkpQfysaB
	broQCgxroVdsmN3e5o=; b=GFrXlH3eEOHlWZ8+MfEbTJlC4Qd/ToCs92XgsGXhi
	0yzzGvv8OXYjQuD25qq4q9q2wYrTjoLglH1s1Cp7KnuPgR/VJ22o4qQ/s1q+47yN
	oaEvsHAaFO/ifjtzFrNJ7cCUfy5XjcCTh1tPnmgqIr320YLHJhceNEpCap9BtpKS
	/p6r4F2yS2y9m4G2u3KkWj1e3fnZs72qFvyE7oGsBmetwJwJLzJHH4nQi5Xa/6yA
	QohV3YcN1N4sfQVEb0bLteXRkeaMgkxwNniaPlicAo8h6ymayX1r7pt9BM1GF2ML
	2YeIVTTcpvMSfb8NebKCh56ZIn30Z53jpIWeG/UjZSr7w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47xnt3hxhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 09:54:21 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 17 Jul 2025 09:54:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Jul 2025 09:54:20 -0700
Received: from 67d05fca9368 (unknown [10.193.66.145])
	by maili.marvell.com (Postfix) with SMTP id 2B84F3F7071;
	Thu, 17 Jul 2025 09:54:15 -0700 (PDT)
Date: Thu, 17 Jul 2025 16:54:14 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni4redhat.com@mx0a-0016f401.pphosted.com>,
        <horms@kernel.org>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <bbhushan2@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sgoutham@marvell.com>, <netdev@vger.kernel.org>
Subject: Re: [net-next PATCH v2 01/11] octeontx2-af: Simplify context writing
 and reading to hardware
Message-ID: <aHkqtoNCJvorNnSq@67d05fca9368>
References: <1752598924-32705-1-git-send-email-sbhatta@marvell.com>
 <1752598924-32705-2-git-send-email-sbhatta@marvell.com>
 <aHdvt63yoJLt/1g9@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aHdvt63yoJLt/1g9@mev-dev.igk.intel.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE0OCBTYWx0ZWRfX/ncxYcCTQHXN vfmlEiOfCh4UENIplSxo505gcWPmMulu79tzz8ULZwYWfrJrbjfEDBzrqb56TZ+M5HLeaC8oh3c tRsYjLtJOLz3US5RNh5jrWJ4DVtH5OyzMO8I67IvO+1YiMovmir3tuJ6d7FswjThSFq/AisOJe/
 ojiLRXup9ihi6GqigLcOHD2jSVR01343vKPJTqBB6UuvhfNv36Mnk/Sc0OJCInRMSQlE/33NOfT f+SfrdypxVCB80VNmKTBEcKVl3Pxfs/MO2BqNhDd7g1biNAp/4c0JPtAiPB2DC6dvLHydvbLPqj kmHzCwD42k+7gxt94z2LrWR738bkho9vGDLaoBW+MAlEtLGEEhQKcXoaPO4oAkuJnMxOQe7BMmE
 SQHVXX8LIzbd7NH1oBC8MMU5lImtwDUFRoV1wSQn5KaibzsGjxkRBv5NXiDzlpv/BG1dv9HV
X-Authority-Analysis: v=2.4 cv=dpDbC0g4 c=1 sm=1 tr=0 ts=68792abd cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=QyXUC8HyAAAA:8 a=M5GUcnROAAAA:8 a=vSvK-7wL9DrjbFCmeUoA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 2L28ncVPcUXGVX5i34hgXQW2lLX3New1
X-Proofpoint-GUID: 2L28ncVPcUXGVX5i34hgXQW2lLX3New1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01

On 2025-07-16 at 09:24:07, Michal Swiatkowski (michal.swiatkowski@linux.intel.com) wrote:
> On Tue, Jul 15, 2025 at 10:31:54PM +0530, Subbaraya Sundeep wrote:
> > Simplify NIX context reading and writing by using hardware
> > maximum context size instead of using individual sizes of
> > each context type.
> > 
> > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> > ---
> >  .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 46 ++++++++++---------
> >  .../marvell/octeontx2/af/rvu_struct.h         |  7 ++-
> >  2 files changed, 30 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> > index bdf4d852c15d..48d44911b663 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> > @@ -17,6 +17,8 @@
> >  #include "lmac_common.h"
> >  #include "rvu_npc_hash.h"
> >  
> > +#define NIX_MAX_CTX_SIZE	128
> > +
> 
> [...]
> 
> >  
> >  	return 0;
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
> > index 0596a3ac4c12..8a66f53a7658 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
> > @@ -370,6 +370,8 @@ struct nix_cq_ctx_s {
> >  	u64 qsize		: 4;
> >  	u64 cq_err_int		: 8;
> >  	u64 cq_err_int_ena	: 8;
> > +	/* Ensure all context sizes are minimum 128 bytes */
> > +	u64 padding[12];
> >  };
> >  
> >  /* CN10K NIX Receive queue context structure */
> > @@ -672,7 +674,8 @@ struct nix_sq_ctx_s {
> >  struct nix_rsse_s {
> >  	uint32_t rq			: 20;
> >  	uint32_t reserved_20_31		: 12;
> > -
> > +	/* Ensure all context sizes are minimum 128 bytes */
> > +	u64 padding[15];
> >  };
> >  
> >  /* NIX receive multicast/mirror entry structure */
> > @@ -684,6 +687,8 @@ struct nix_rx_mce_s {
> >  	uint64_t rsvd_31_24 : 8;
> >  	uint64_t pf_func    : 16;
> >  	uint64_t next       : 16;
> > +	/* Ensure all context sizes are minimum 128 bytes */
> > +	u64 padding[15];
> >  };
> 
> To be sure that each used structures are correct size you can
> use static assertion, sth like:
> static_assert((NIC_MAX_CTX_SIZE) == sizeof(struct X))
> 
> Thanks
> 
Sure will do it.

Thanks,
Sundeep
> >  
> >  enum nix_band_prof_layers {
> > -- 
> > 2.34.1
> > 

