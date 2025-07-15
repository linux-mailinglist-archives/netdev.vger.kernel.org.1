Return-Path: <netdev+bounces-207215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1296FB0649C
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 18:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5996E5659E3
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3D225D546;
	Tue, 15 Jul 2025 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jmfgJ+3B"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70C5F50F;
	Tue, 15 Jul 2025 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598039; cv=none; b=syxno+F7T3G1l6VHALhLyb5UouOG1G3dZX0ts7CTljG42c2Fa9FURRevxzGd8XNXtjH06NwzlT52B5B7pWxpTZ9CZ/zfaOxiyFa35rHHMYmctELMPf/I/6TONp+rqaOnS0W1GBld1lDqVLDx4hVsA4Fh9NVSPgWnsPggopiJsQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598039; c=relaxed/simple;
	bh=+wyztfzslwZqOk58ssVUZ73/lv091+8tdwS7atcyI54=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaOPpw8Cw1kOGHvProXfQFncgZQW0yQtsUbInoTkVSV56rUrvfWEBJUQrlhKAWuQswGifrbGhld2MStBcrnzct2AummFaakt3eKGETmyARyS1Y2RxFSs5of4aS3T1IyxNoEBowAommuhE1GPYhNNotS/9gopmmq4/MTXTQnwWxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jmfgJ+3B; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FEk751000654;
	Tue, 15 Jul 2025 09:46:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=rLP3DK64YZ7bv73XUea6+GImb
	VkY1Oems9meKjPz52M=; b=jmfgJ+3B/ObgMNf/1iyc1FVGpsQwjISIBDLLI/fYb
	VlWOtibl5xtjSHBnabIT1aAi3xSl6FQmP5VwJagw9AEFxdynGXiDLoQpQQcYpnEq
	DniPKAwwxzErw208nsiOASR0/TVPtfo5pkZkSI0hXNbt2usHxErzjRv/NBRwdi/B
	oo4Kl0iHuD+3m62VJEbjtyQpB1/3CJs9MFMRKzlcEyEYgKXsH6ZMdtuUU2ivSRJ1
	p/ZKTzNU5aqdUZpiEXFO5xVt8HzuXMTZZj0K9zHcl0Tjop0jptko1e4009sU1CQJ
	dlvDS51EKAotgoAF9x++yITxsjyIljEH7czPyW7rkB8Ig==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47wbm52a3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 09:46:56 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Jul 2025 09:46:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Jul 2025 09:46:55 -0700
Received: from 2bdc17c5cd25 (unknown [10.28.168.138])
	by maili.marvell.com (Postfix) with SMTP id C94635B692E;
	Tue, 15 Jul 2025 09:46:49 -0700 (PDT)
Date: Tue, 15 Jul 2025 16:46:47 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Kees Cook <kees@kernel.org>,
        <linux-hardening@vger.kernel.org>
Subject: Re: [net-next PATCH 01/11] octeontx2-af: Simplify context writing
 and reading to hardware
Message-ID: <aHaF9yM4FC0OICpt@2bdc17c5cd25>
References: <1752420669-2908-1-git-send-email-sbhatta@marvell.com>
 <1752420669-2908-2-git-send-email-sbhatta@marvell.com>
 <20250714104557.GG721198@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714104557.GG721198@horms.kernel.org>
X-Authority-Analysis: v=2.4 cv=M7tNKzws c=1 sm=1 tr=0 ts=68768600 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=qz1HUbaLauafrQh6Lv0A:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: vebmtUSfF5pzwPW3Igc6ogXShHb274VO
X-Proofpoint-ORIG-GUID: vebmtUSfF5pzwPW3Igc6ogXShHb274VO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1NCBTYWx0ZWRfX4zRbi0T/rtjJ M9gl8IpBUM2tYGNy5xR83XKem1P0+g3p+WkJaAMW2QTisYG1GFJKJwU+GrSUvLKaideyGAh9O54 JlqFtTUJ5JkCxalkZFSrYvmnyYMbbST3c87FxC5OFs9eAmtwzWIv8601kcY913HTSLh/leyrGBZ
 /YugxBanbtJuJaG5dIXE1CQBJ+3gTEj1msGzB6+wdl5AfCZ+oiUfonJLuGRsBkYWRtr1To0zs1a bx5shUfmPOUs+BJoCOQlM2buqTOyc90A72v9ZNK/HZ0lXSBw7HHcM3htPUaE++pI7Oyc/M9NthE EAw3CQQXuVkGAYDdNzugJbHAtq8clG3MaCyH4IrCK+s9XUBirFpOlMaisxpLxQyaUlP+zZx0YoC
 +9NCk7KE0/d8GTHLDJwALi7Ux/GyXRvaLYXc9UuWmCU5GT29Z5rSEWnWk7PDU3lqMBAo566+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01

On 2025-07-14 at 10:45:57, Simon Horman (horms@kernel.org) wrote:
> + Kees, linux-hardening
> 
> On Sun, Jul 13, 2025 at 09:00:59PM +0530, Subbaraya Sundeep wrote:
> > Simplify NIX context reading and writing by using hardware
> > maximum context size instead of using individual sizes of
> > each context type.
> > 
> > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> > ---
> >  .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 46 ++++++++++---------
> >  1 file changed, 24 insertions(+), 22 deletions(-)
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
> >  static void nix_free_tx_vtag_entries(struct rvu *rvu, u16 pcifunc);
> >  static int rvu_nix_get_bpid(struct rvu *rvu, struct nix_bp_cfg_req *req,
> >  			    int type, int chan_id);
> > @@ -1149,36 +1151,36 @@ static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
> >  	case NIX_AQ_INSTOP_WRITE:
> >  		if (req->ctype == NIX_AQ_CTYPE_RQ)
> >  			memcpy(mask, &req->rq_mask,
> > -			       sizeof(struct nix_rq_ctx_s));
> > +			       NIX_MAX_CTX_SIZE);
> >  		else if (req->ctype == NIX_AQ_CTYPE_SQ)
> >  			memcpy(mask, &req->sq_mask,
> > -			       sizeof(struct nix_sq_ctx_s));
> > +			       NIX_MAX_CTX_SIZE);
> >  		else if (req->ctype == NIX_AQ_CTYPE_CQ)
> >  			memcpy(mask, &req->cq_mask,
> > -			       sizeof(struct nix_cq_ctx_s));
> > +			       NIX_MAX_CTX_SIZE);
> >  		else if (req->ctype == NIX_AQ_CTYPE_RSS)
> >  			memcpy(mask, &req->rss_mask,
> > -			       sizeof(struct nix_rsse_s));
> > +			       NIX_MAX_CTX_SIZE);
> >  		else if (req->ctype == NIX_AQ_CTYPE_MCE)
> >  			memcpy(mask, &req->mce_mask,
> > -			       sizeof(struct nix_rx_mce_s));
> > +			       NIX_MAX_CTX_SIZE);
> >  		else if (req->ctype == NIX_AQ_CTYPE_BANDPROF)
> >  			memcpy(mask, &req->prof_mask,
> > -			       sizeof(struct nix_bandprof_s));
> > +			       NIX_MAX_CTX_SIZE);
> >  		fallthrough;
> 
> Hi Subbaraya,
> 
> Unfortunately this patch adds string fortification warnings
> because, e.g. the size of req->rss_mask is less than 128 bytes.
> 
> GCC 15.1.0 flags this as follows:
> 
>   In function 'fortify_memcpy_chk',
>       inlined from 'rvu_nix_blk_aq_enq_inst' at drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:1159:4:
>   ./include/linux/fortify-string.h:580:4: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()?
>       __read_overflow2_field(q_size_field, size);
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> There may there is nicer way to do this. And it's entirely possible I've
> muddled up the combination of structures and unions here. But I wonder if
> an approach like this can reach your goals wile keeping the string
> fortification checker happy.

Hi Simon,

Thanks for reviewing the patch. The mask and context structures are
accessed by hardware, instead of typecasting to new context structures for new silicon
I used fixed size of 128 which is hardware maximum context size. Say CQ context
is 32 bytes and if I fill valid 32 bytes + 96 invalid/junk bytes then Hardware does not
care about the invalid bytes and it uses only 32 bytes since CTYPE is set as CQ when
submitting the instruction to hardware. To keep the string fortification
happy will padd the structures which are lesser than 128 to 128. I will submit
v2 with those changes.

Sundeep

> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index 0bc0dc79868b..0aa1e823cbd3 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -985,14 +985,17 @@ struct nix_aq_enq_req {
>  		struct nix_rx_mce_s mce;
>  		struct nix_bandprof_s prof;
>  	};
> -	union {
> -		struct nix_rq_ctx_s rq_mask;
> -		struct nix_sq_ctx_s sq_mask;
> -		struct nix_cq_ctx_s cq_mask;
> -		struct nix_rsse_s   rss_mask;
> -		struct nix_rx_mce_s mce_mask;
> -		struct nix_bandprof_s prof_mask;
> -	};
> +	struct_group(
> +		mask,
> +		union {
> +			struct nix_rq_ctx_s rq_mask;
> +			struct nix_sq_ctx_s sq_mask;
> +			struct nix_cq_ctx_s cq_mask;
> +			struct nix_rsse_s   rss_mask;
> +			struct nix_rx_mce_s mce_mask;
> +			struct nix_bandprof_s prof_mask;
> +		};
> +	);
>  };
>  
>  struct nix_aq_enq_rsp {
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index bdf4d852c15d..4089933d5a0b 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -1147,24 +1147,7 @@ static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
>  
>  	switch (req->op) {
>  	case NIX_AQ_INSTOP_WRITE:
> -		if (req->ctype == NIX_AQ_CTYPE_RQ)
> -			memcpy(mask, &req->rq_mask,
> -			       sizeof(struct nix_rq_ctx_s));
> -		else if (req->ctype == NIX_AQ_CTYPE_SQ)
> -			memcpy(mask, &req->sq_mask,
> -			       sizeof(struct nix_sq_ctx_s));
> -		else if (req->ctype == NIX_AQ_CTYPE_CQ)
> -			memcpy(mask, &req->cq_mask,
> -			       sizeof(struct nix_cq_ctx_s));
> -		else if (req->ctype == NIX_AQ_CTYPE_RSS)
> -			memcpy(mask, &req->rss_mask,
> -			       sizeof(struct nix_rsse_s));
> -		else if (req->ctype == NIX_AQ_CTYPE_MCE)
> -			memcpy(mask, &req->mce_mask,
> -			       sizeof(struct nix_rx_mce_s));
> -		else if (req->ctype == NIX_AQ_CTYPE_BANDPROF)
> -			memcpy(mask, &req->prof_mask,
> -			       sizeof(struct nix_bandprof_s));
> +		memcpy(mask, &req->mask, sizeof(req->mask));
>  		fallthrough;
>  	case NIX_AQ_INSTOP_INIT:
>  		if (req->ctype == NIX_AQ_CTYPE_RQ)
> 
> ...
> 
> -- 
> pw-bot: changes-requested

