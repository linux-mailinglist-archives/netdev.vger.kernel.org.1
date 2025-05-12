Return-Path: <netdev+bounces-189757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B9BAB3807
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 15:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0B0189F008
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 13:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAF9258CFB;
	Mon, 12 May 2025 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="E7SlaJKm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273F42BAF7
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054974; cv=none; b=GdrPGng7CAIjLX5lAkY+52qBSrhwb2deVKUQPadseYAqNZEm5Y4/sr1sa/EbDW+Bie14C7yyTnK2NAFdssFeZH097ySPQvB1XMi5BfJGCV27OlQOYxOO3kbzNDRC7I0wtl+fG+ue3fldGQDcWsQbL66SMph2vuiKTknSY9CsCJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054974; c=relaxed/simple;
	bh=sDuTZrD8Eaor3JG0HPFQ/ioYnhvuFz04INy+e0JE3uE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ne8oSeQhqLD1eQ2IjK+YSAjJXMRMpoDkS74tXXc0Gci00rjTArxiE5jcYwNqY6IWAIgBbkwHMJh+RLzFQw6DDmG14Q0rdM8QdxlRKuAJOzeymvLso2l5RFTSzhFSlumYG3UxZs/qZW8yFBl993VuIk7rnqEO43Duvh5TmFvhW0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=E7SlaJKm; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C0nrJ0017169;
	Mon, 12 May 2025 06:02:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=O54lGc+HNzkzD+QPN44PhtIFt
	JkeaDuJbjUBZuszK8M=; b=E7SlaJKmfIkJbWbyqMQHTrkmex8COHnDPIBqnbEM/
	6A6Z7WCstYwctbMcxNmSiYy+3x0U4KlzbfkFDmVb+Q3yPN89jxvLQRRViDKpI+Vo
	svHmgoSROvuV/3E+kvTeDCC2hr8qNItb+HJiZytgstrlhg3jeA16qdiOWQzEBc27
	1FJGANg8hPuIYCvi+clCNFsnyvIRqt0rmDDIJooK8fBsaNDjiXmz1GeqIaLjWLSR
	f2tBwf0Q4yi9cTymJlVxqqdowVqAXScUXmNxoRO5Nc+Fm82RQZSDtsw6a8aQBOJf
	R15+ZtVFyBBwh14y+iR5wPgiVLN9RQQ8DL301mC7Jp5Mw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46k5r6h3en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 06:02:43 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 12 May 2025 06:02:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 12 May 2025 06:02:41 -0700
Received: from 37b358c748b7 (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id C37283F7095;
	Mon, 12 May 2025 06:02:37 -0700 (PDT)
Date: Mon, 12 May 2025 13:02:35 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH] octeontx2-af: Send Link events one by one
Message-ID: <aCHxax9GgcLL-4Xk@37b358c748b7>
References: <1746638183-10509-1-git-send-email-sbhatta@marvell.com>
 <20250512100954.GU3339421@horms.kernel.org>
 <aCHfZ_MxtfVmhXVj@90a8923ee8d1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aCHfZ_MxtfVmhXVj@90a8923ee8d1>
X-Authority-Analysis: v=2.4 cv=WMp/XmsR c=1 sm=1 tr=0 ts=6821f173 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=5P80QGrGfck98o8MOnwA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: wQkGsb3a-2O4k2GgYth7iwRKTh93GrPz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDEzNiBTYWx0ZWRfX2m5EnNP5uTIZ C7H+fKEVfXgwVrdxRJ24bA3RcILapk1jB+DLhIJOSJ4LuPALPnHG3MgX+k+45zYQCamsJnmKMNb Z4O0FPSQ4WCkE4y1vxrgsJGCA6gfceOULiakV9S0WaWSLRLmjV5faVxMj64kYaoHY608bLqUsFh
 ZVm+J0IIxgDslfboSxwMnbNX7LzxHb1uLwlEnJG9YxFoZlA5J2dJa5msEXey7fDCxju34+Sfvkk qGPiBdA8dLzhuOF3XmzLVUkZzPsYvEAbSjHhYIRyN3RiW55NwoBMFq+2X1GKC7ScL3VQLEh7QqW BpI/jcttHbAN2/UZZ0916f75obecJEb+ccXN1mpYKD14KrmyejV3xiv//TZqm1q2muYDSQXjIxA
 oNK7sEiiB0spISbRVJYifgOIZR7se114xkonEP6OZRxVoPvdSeJaubljLfFeejhVmfucXvM4
X-Proofpoint-ORIG-GUID: wQkGsb3a-2O4k2GgYth7iwRKTh93GrPz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_04,2025-05-09_01,2025-02-21_01

Hi again,

On 2025-05-12 at 11:45:43, Subbaraya Sundeep (sbhatta@marvell.com) wrote:
> Hi Simon,
> 
> On 2025-05-12 at 10:09:54, Simon Horman (horms@kernel.org) wrote:
> > On Wed, May 07, 2025 at 10:46:23PM +0530, Subbaraya Sundeep wrote:
> > > Send link events one after another otherwise new message
> > > is overwriting the message which is being processed by PF.
> > > 
> > > Fixes: a88e0f936ba9 ("octeontx2: Detect the mbox up or down message via register")
> > > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> > > ---
> > >  drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> > > index 992fa0b..ebb56eb 100644
> > > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> > > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> > > @@ -272,6 +272,8 @@ static void cgx_notify_pfs(struct cgx_link_event *event, struct rvu *rvu)
> > >  
> > >  		otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pfid);
> > 
> > Hi Subbaraya,
> > 
> > Are there other callers of otx2_mbox_msg_send_up()
> > which also need this logic? If so, perhaps a helper is useful.
> > If not, could you clarify why?
> > 
> UP messages are async notifications where we just send and forget.
> There are other callers as I said we just send and forget everywhere
> in the driver. Only this callsite has been modified because we have
> seen an issue on customer setup where bunch of link events are queued
> for a same device at one point of time.
> > >  
> > > +		otx2_mbox_wait_for_rsp(&rvu->afpf_wq_info.mbox_up, pfid);
> > 
> > This can return an error. Which is checked in otx2_sync_mbox_up_msg().
> > Does it make sense to do so here too?
> > 
> Yes it makes sense to use otx2_sync_mbox_up_msg here. I will use it
> here.
> 
I will leave it as otx2_mbox_wait_for_rsp. Since otx2_sync_mbox_up_msg
is in nic driver and we do not include nic files in AF driver. Since
this is a void function will print an error if otx2_mbox_wait_for_rsp
returns error.

Thanks,
Sundeep

> Thanks,
> Sundeep
> > > +
> > >  		mutex_unlock(&rvu->mbox_lock);
> > >  	} while (pfmap);
> > >  }
> > > -- 
> > > 2.7.4
> > > 

