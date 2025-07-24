Return-Path: <netdev+bounces-209793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 051B0B10E21
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 16:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F42181D00342
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 14:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AF02E8DE0;
	Thu, 24 Jul 2025 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="RtVsw7yX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9DF284B25
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753369047; cv=none; b=nWkfU8onHIJOB7/+oTDUGcf16AhULu8zCvVYMNTSJ6e9+TEmGwR5C1H9GV68pU/CCQuVBPeROVubvk3zYmnX/Rvdt5GSex4Y9eIYCbux7wC7LpzDs2JQ36DC+KxesHsCSOnrVUSwF8Z7+1M31Ng/maSg7mRkDpjhaykt8pNWbI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753369047; c=relaxed/simple;
	bh=oBVkwcR5dhaj0VBE5B5qDiWJqGtVsvZDp19BUpi8Eyo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aco90Bjly/TQ+9HEDZc8YKWUsNqXIt4+VaO7/SRmGTFoB9WMlzRW2WHUHA1GcZG/d3nPQVjNoFjo56A+xDxv2xFmszsyUnO+T1CSF5944EJtVgXWjZ8yK5VBD2rqwLGjak6K+F2V5agNc4Xf7NGWJdATyuOjMF40h45tAYWJndk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=RtVsw7yX; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OEMfU2005379;
	Thu, 24 Jul 2025 07:57:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=ollxqL00var1FA4cVv4jyDZlO
	MR0NQqD2SKt3rEXi9g=; b=RtVsw7yX3lUefDFv7GOzr/Ws2JLlv4/Mleg1WBMTo
	vRuNylcnEq69kiCIfmOQLpeOWsdqdlAg4MwGlU1M5Aj0ISzXReenNgpskkp+wrG8
	49j1UjKlnYyjb1eIJyYulsmduHHSfzIPobdUJnbeVXQUDBClPDUtZQXf7a3SoAKL
	0PCzON55vSGucK7iYaUwb3MYaaZbT7EvHcPg7xFw8A71Lg23VyjEHTpEeEvGN7xg
	iJn/iDYjuqskjDC7zRdGnbrdYNV6rykeAS3hYniVYEV1nZ0k8fzp0vrzrJQJ6mvs
	W8CwA8a8Q2d1ltN8TmrU+kparhtRn75OOyoaGg/jORAdQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 483k5h0jb9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 07:57:16 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 24 Jul 2025 07:57:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 24 Jul 2025 07:57:15 -0700
Received: from opensource (unknown [10.29.20.14])
	by maili.marvell.com (Postfix) with SMTP id D92D23F708D;
	Thu, 24 Jul 2025 07:57:10 -0700 (PDT)
Date: Thu, 24 Jul 2025 14:57:09 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>
Subject: Re: [net-next PATCH v3 08/11] octeontx2-pf: Initialize new NIX SQ
 context for cn20k
Message-ID: <aIJJxapuXxymyZ_A@opensource>
References: <1752772063-6160-1-git-send-email-sbhatta@marvell.com>
 <1752772063-6160-9-git-send-email-sbhatta@marvell.com>
 <20250722170638.GT2459@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250722170638.GT2459@horms.kernel.org>
X-Proofpoint-GUID: O3q-ZWjTF9ydRCcLpRcIGTXwCTlQT7--
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDExNCBTYWx0ZWRfX+XlcjIQlD3aq 9HB0CxDlxsHafxE6tiDQNl5j0TeY8Fhq2PLGInFNlHsVt/qPaLSN/+HPNhAdy4PX3755TGk4Er9 ylMPnG9VCPks/WJr6ruCRuDMk+doN42m396ixL7sBT8dxS9+5QSKY+iCK9hFDSOK4ydQqis18Qw
 cFMoGz2wYZr4m8nhuf2nhLtXTmZIhFxR1t2GzYHCYnYgQjIU0iwFFUjjO4vQYL18cFLYwQC73iD pyyOTh9NdOMNlxy8xP+a/5jWNl8/C0GeH8YYTInY4MDOHelYoCKypBwqeZOD6BWSEDXwYycOGD/ V/6u9cMmMYSodASUBKdtxaLLDzw5MslSBU2rLnODTgrBPktqh0LNSeYsR0WOEyx9B3AU7/7+6q+
 jdU63ex+dWMRx3X4TNgO1QKKoeRZeACpRb8S6SW8zEIiLDbznfdv/grQExwVy3HZzkZZHUs+
X-Proofpoint-ORIG-GUID: O3q-ZWjTF9ydRCcLpRcIGTXwCTlQT7--
X-Authority-Analysis: v=2.4 cv=Q8LS452a c=1 sm=1 tr=0 ts=688249cc cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=fpM_G50zwOi2bFOWjl8A:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01

On 2025-07-22 at 17:06:38, Simon Horman (horms@kernel.org) wrote:
> On Thu, Jul 17, 2025 at 10:37:40PM +0530, Subbaraya Sundeep wrote:
> > cn20k has different NIX context for send queue hence use
> > the new cn20k mailbox to init SQ context.
> > 
> > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> > ---
> >  .../ethernet/marvell/octeontx2/nic/cn20k.c    | 36 ++++++++++++++++++-
> >  1 file changed, 35 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> > index 037548f36940..4f0afa5301b4 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> > @@ -389,11 +389,45 @@ static int cn20k_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
> >  	return 0;
> >  }
> >  
> > +static int cn20k_sq_aq_init(void *dev, u16 qidx, u8 chan_offset, u16 sqb_aura)
> > +{
> > +	struct nix_cn20k_aq_enq_req *aq;
> > +	struct otx2_nic *pfvf = dev;
> > +
> > +	/* Get memory to put this msg */
> > +	aq = otx2_mbox_alloc_msg_nix_cn20k_aq_enq(&pfvf->mbox);
> > +	if (!aq)
> > +		return -ENOMEM;
> > +
> > +	aq->sq.cq = pfvf->hw.rx_queues + qidx;
> > +	aq->sq.max_sqe_size = NIX_MAXSQESZ_W16; /* 128 byte */
> > +	aq->sq.cq_ena = 1;
> > +	aq->sq.ena = 1;
> > +	aq->sq.smq = otx2_get_smq_idx(pfvf, qidx);
> > +	aq->sq.smq_rr_weight = mtu_to_dwrr_weight(pfvf, pfvf->tx_max_pktlen);
> > +	aq->sq.default_chan = pfvf->hw.tx_chan_base + chan_offset;
> > +	aq->sq.sqe_stype = NIX_STYPE_STF; /* Cache SQB */
> > +	aq->sq.sqb_aura = sqb_aura;
> > +	aq->sq.sq_int_ena = NIX_SQINT_BITS;
> > +	aq->sq.qint_idx = 0;
> > +	/* Due pipelining impact minimum 2000 unused SQ CQE's
> > +	 * need to maintain to avoid CQ overflow.
> > +	 */
> > +	aq->sq.cq_limit = ((SEND_CQ_SKID * 256) / (pfvf->qset.sqe_cnt));
> 
> nit: Unnecessary parentheses
> 
>      I think this will work just as well (completely untested):
> 
> 	aq->sq.cq_limit = (SEND_CQ_SKID * 256) / pfvf->qset.sqe_cnt;
Yes. parentheses not required. Will change it.

Thanks,
Sundeep
> 
> > +
> > +	/* Fill AQ info */
> > +	aq->qidx = qidx;
> > +	aq->ctype = NIX_AQ_CTYPE_SQ;
> > +	aq->op = NIX_AQ_INSTOP_INIT;
> > +
> > +	return otx2_sync_mbox_msg(&pfvf->mbox);
> > +}
> 
> ...

