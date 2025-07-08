Return-Path: <netdev+bounces-204906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FB6AFC731
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A04C1785E1
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52378255E34;
	Tue,  8 Jul 2025 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gdWb6bxp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63E421FF51;
	Tue,  8 Jul 2025 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751967458; cv=none; b=VlbQgWbJxzCZYdz4zJMmCZSgWS5k4ouWqb1mwnAKBNZEcvTk2OxHkZV+fiZGMyGr1lKrSCdsC0U+ojUQlGW+33J699OUmL+bWWD78OzWW+MhQTNxJdy+xgbvpyMiozEhN/X5D0/k8DOwtP19jVzd5+oI3AppGdUpB/fdLnT6jPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751967458; c=relaxed/simple;
	bh=0DhIatYpr0tZAOUQ0uLvJSDlXCZMoMn2ooMgIUgWXhU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mebDTYQ3Lr+pk3kuziscsm9OKH1vhvw5ma7FMTD7JSoi870CfEQPg9lqJa+KBVOcf3HxEeHsSwodohO5M25qQk3OA1TXrxZNQsxhtXyTKBnmoih9n16Ytmh2AojfIGDCnFToTcFVCGz5/XoPfbkZV4M6iAoV6BUDqy14/Wz+uI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gdWb6bxp; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5685JV16008794;
	Tue, 8 Jul 2025 02:37:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=POlCOi98l8K3kXJjxUgD+wXFw
	6jYs3weIfOyCSgP4Ds=; b=gdWb6bxpStiqw+fNtG9WbgAci7gCPUIvcKjR3x8VC
	X+kjPnQ20GHi7TN5fN6mFwBKOMNYPIN+NZVeIp9OkxG500T4VEw6MOnR1LOHAaAe
	01l2kz/Lix2L76o+DO3mAFiurJrp8WXaHl5Jqv2lNpSavaVuLlED2VJyK9YOxfu3
	Jdc/ypvZXp+3zONXkEv42mO51xJgJrx8V/hYgRxiKoh9iHIw8hWDXR5zJJQh2aIE
	HR6GsklbFBYC4tC6rkaUOaLHzvZkgh9q8BssmF0tI8eB3qnl8e8FsgH3ttKNCsaH
	gfbICvYn/AmRgIuwhVBRBCzSLkZeCQzYUkvKgzm95E8oA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47rw35gj6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 02:37:14 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 8 Jul 2025 02:37:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 8 Jul 2025 02:37:13 -0700
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id 426613F70B2;
	Tue,  8 Jul 2025 02:37:09 -0700 (PDT)
Date: Tue, 8 Jul 2025 15:07:08 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "Andrew Lunn" <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Tomasz Duszynski
	<tduszynski@marvell.com>
Subject: Re: [net] Octeontx2-vf: Fix max packet length errors
Message-ID: <aGzmxAEN9KFC/qce@test-OptiPlex-Tower-Plus-7010>
References: <20250702110518.631532-1-hkelam@marvell.com>
 <20250704151511.GE41770@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250704151511.GE41770@horms.kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA3OCBTYWx0ZWRfXxwILy1kM6D/k /fBZIY24Dnw6HQmdeEsxGAetiIdgR3pfQ1kvkUNlFnunCFeMsfJqCeul/38d0z54vgd5VDlGD80 fLe40aFa+iE2QK2p8lRChxWwtUn9KZyQ861nUhE5GjWfdaal+cZXckYsfsBSDmmtS0uzLLPcwyR
 uQZtH19z4bOOjnRI4VZlcCZlxieSxFFxosJmZZcMZ5AfMKyMZG4ryPLs/E57glbvExDUIIDCaIq RgbAU32fiW0l44Qx7kXuDCiVVC0l3zsv0V9bA4BZfB0VGah/xjXyVv6WZL6ouHqNP7AIxREb4oR tTl4yynnD5QZvZY35aoX9uQ3/BLtF5iK4TfM1MV7ZllhoHUiEiFScOpfCtgFztbjUgSKVVkwTuq
 YfESeuhY4m0igHLByze3iNZWyFin1WOqsmWGGu8yawqS0k8P+VeuCUxr1Rm0VcP3xE+af0He
X-Authority-Analysis: v=2.4 cv=drLbC0g4 c=1 sm=1 tr=0 ts=686ce6ca cx=c_pps p=gIfcoYsirJbf48DBMSPrZA==:17 a=gIfcoYsirJbf48DBMSPrZA==:117 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=ahM_0CIGR7yTG_xuzX0A:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-ORIG-GUID: oweZkv2f3wcSGtCQTDindKZdCWFPtDRs
X-Proofpoint-GUID: oweZkv2f3wcSGtCQTDindKZdCWFPtDRs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01

On 2025-07-04 at 20:45:11, Simon Horman (horms@kernel.org) wrote:
> On Wed, Jul 02, 2025 at 04:35:18PM +0530, Hariprasad Kelam wrote:
> > Implement packet length validation before submitting packets to
> > the hardware to prevent MAXLEN_ERR.
> > 
> > Fixes: 3184fb5ba96e ("octeontx2-vf: Virtual function driver support")
> > Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> > ---
> >  drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> > index 8a8b598bd389..766237cd86c3 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> > @@ -394,6 +394,13 @@ static netdev_tx_t otx2vf_xmit(struct sk_buff *skb, struct net_device *netdev)
> >  	struct otx2_snd_queue *sq;
> >  	struct netdev_queue *txq;
> >  
> > +	/* Check for minimum and maximum packet length */
> > +	if (skb->len <= ETH_HLEN ||
> > +	    (!skb_shinfo(skb)->gso_size && skb->len > vf->tx_max_pktlen)) {
> > +		dev_kfree_skb(skb);
> > +		return NETDEV_TX_OK;
> > +	}
> 
> Hi Hariprasad,
> 
> I see the same check in otx2_xmit().
> But I wonder if in that case and this one the rx drop counter for the
> netdev should be incremented.
>  
  Assuming its tx_drop counter, Will add suggested change in V2.
  
> Also, do you need this check in rvu_rep_xmit() too?
> 
  ACK, will add this check in V2.

THanks,
Hariprasad k 

> > +
> >  	sq = &vf->qset.sq[qidx];
> >  	txq = netdev_get_tx_queue(netdev, qidx);
> >  
> > -- 
> > 2.34.1
> > 
> > 
> 

