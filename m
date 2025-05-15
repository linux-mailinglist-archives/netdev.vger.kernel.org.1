Return-Path: <netdev+bounces-190787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E528AB8C8D
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 18:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4321BC16F0
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B99E220F3E;
	Thu, 15 May 2025 16:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CnvCz+XI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F2321CC70
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747326936; cv=none; b=PIWQeW3h4iEQu7wDwB8EjvToQw+OxsVIlqC+gSdjMdNqXULsmC/mKWh3/UOmPaSMDuQe726vah9/MM/uoT1wzWFXO8Y+43Q5UG5avhFZuDOM8qoD21KLG5W31qqZS8hyg87LbFJ8TMpWGvRldkCe2rfQzJCpkCubRbp5BKeuBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747326936; c=relaxed/simple;
	bh=AS0D6HIT8gVFIYzu6AoWDL05TH8bK0mdYVB7qdxB9nc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfxwSDtuY6RMADr7uqeuX5lM9ZIQNjoZm6h8dc9auehYpNyM7DQhBkfSURXJHzfRGNz7rJwLRHigKpNoED+QyXzzGetoOWTFxM7DhNFkUcE7ZQlFlg6K52959izyqaKNySUPoMTCfXpv6hbR9ArSR5ms8AVYvNoFV/42vo3gpzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CnvCz+XI; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEiOIp006623;
	Thu, 15 May 2025 09:35:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=IveLT/HZ7IyIyPigWZilVN3p0
	xtbP1jSP9LjiyskEAE=; b=CnvCz+XIlFvIbZnX+Pc4ajDKSVe1NhRES/luyhmlQ
	zwqpz2JD5ZHxSlhormE4WeJa5JLVhe9OIE4GhU/94ChdBabBGz+nOiMg+eow9Apb
	0f3CHAc0lqsIBV3FDBR/Js/j00IPf+cX77B5LgD6DIj+rdevc5ovC+7Zlc337h5b
	CiwttfNwIgQpnp1o37xg/xnIbQDk73bQ1mcV1z48/aCdl3HMmkkHVqfY9ptxSPqM
	uPV6Yhg9Oo6Tna13rYYlHX0G8dKSDb9bFY7ok22MuwB6YRnplHqvEWc33/zZz0E3
	LzCl6sauCXTJCSfe4FL+e9CQbWc4VUL7s6y6J2shTlA6w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46nj9y099p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 09:35:22 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 15 May 2025 09:35:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 15 May 2025 09:35:20 -0700
Received: from 3958e7e617f8 (unknown [10.28.168.138])
	by maili.marvell.com (Postfix) with SMTP id 72D933F7096;
	Thu, 15 May 2025 09:35:16 -0700 (PDT)
Date: Thu, 15 May 2025 16:35:14 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH net v2] octeontx2-af: Send Link events one by one
Message-ID: <aCYXwo-0CfHYGhh9@3958e7e617f8>
References: <1747204108-1326-1-git-send-email-sbhatta@marvell.com>
 <aCRQNJbYL2ORGmMh@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aCRQNJbYL2ORGmMh@mev-dev.igk.intel.com>
X-Proofpoint-ORIG-GUID: jKs8ejTw4JN5LTjPndHzjO40BCMTuNqZ
X-Proofpoint-GUID: jKs8ejTw4JN5LTjPndHzjO40BCMTuNqZ
X-Authority-Analysis: v=2.4 cv=Tq3mhCXh c=1 sm=1 tr=0 ts=682617ca cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=QyXUC8HyAAAA:8 a=M5GUcnROAAAA:8 a=EZAAayXskDsXsr5XbIwA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=ZFRsO2Wz9R1JO6LuwK9s:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2NSBTYWx0ZWRfX7ccaac6WW1ni DJl15+e+q/lwlPoD9WYYJPZpKCjTSWJFkLa8rsMD0F8f3rrhUtCGvOS9k5JS/supJP/CoR7RP7A czbplRKRDl2vO5cbOjCeJVHOdsoj5NNUOsqvcKq5aZAvSEifNf5akjs7l/Le5GB8a/PtK8dXK+0
 1+as6HR9UeYZP+Q3FmSxTr9adpBbWfruOmFfJo6cUNR9Rc0zOZGR9KML60DZMJjGqXRGwoZI3ul p+Q4kmhYgG9MS+lBva7drxJz2VOnZJ4Q+Tl5T4a+GxH+O62wCohzYKJCXADBtJxl54TUMl3+RFm hOqbDCFOfGTUAXn4cX0hjgaF63taftmywwNlNF2a6WyJf6yd4Jm/8tWwpwlmx9FJJ8QMKJzlWdr
 PhTpo536S/iKQ8Owp7N2sQkT5ITYJpwmGo5a5JKpD/xiaPBjuGjtSWm8w4iNAJfozmoApT1v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01

Hi Michal,

On 2025-05-14 at 08:11:32, Michal Swiatkowski (michal.swiatkowski@linux.intel.com) wrote:
> On Wed, May 14, 2025 at 11:58:28AM +0530, Subbaraya Sundeep wrote:
> > Send link events one after another otherwise new message
> > is overwriting the message which is being processed by PF.
> > 
> > Fixes: a88e0f936ba9 ("octeontx2: Detect the mbox up or down message via register")
> > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> > ---
> > v2:
> >  No changes. Added subject prefix net.
> > 
> >  drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> > index 992fa0b..ebb56eb 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> > @@ -272,6 +272,8 @@ static void cgx_notify_pfs(struct cgx_link_event *event, struct rvu *rvu)
> >  
> >  		otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pfid);
> >  
> > +		otx2_mbox_wait_for_rsp(&rvu->afpf_wq_info.mbox_up, pfid);
> > +
> >  		mutex_unlock(&rvu->mbox_lock);
> 
> Fix looks fine.
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> In rvu_rep_up_notify() the same send function is called (and
> rvu_rep_up_notify() is called in do, while loop in
> rvu_rep_wq_handler()). Doesn't it also need waiting for response?
> Are there a message that don't need waiting? Maybe it will be best to
> always wait for response if another call can overwrite.
> 
> Thanks
> 
Okay I will modify rvu_rep_up_notify, test and send next version along
with this.

Thanks,
Sundeep

> >  	} while (pfmap);
> >  }
> > -- 
> > 2.7.4

