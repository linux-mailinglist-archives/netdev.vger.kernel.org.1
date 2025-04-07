Return-Path: <netdev+bounces-179513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A715EA7D3B4
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 07:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399043ADF55
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 05:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73F02248A1;
	Mon,  7 Apr 2025 05:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JGCqMZYt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF57B22489F;
	Mon,  7 Apr 2025 05:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744005467; cv=none; b=u1OEJTCJnrtF8NIDelQcwHsfY6YpFv8m/UDbv2mE64ExzE9UjU0V/EpUotytDkbQ5qWAOgav+8s1jGKRy17XiHtekvgAxlm677d1yDdGTuHOh73UBdftziBTSISHjSsz6rFUW/sQbP3tr+selhERTWDwiLLDrS3xFWhr8qqJgMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744005467; c=relaxed/simple;
	bh=zt6kWMl9BZ1/fMMzHi+s7KMgVhsrLW8umjL1PuIh724=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WaDR/V+5mKMqW8wyd0L10gGsBfgGRN0xjUaSLUhckrQpg7oZqTFTzAq3fyx/F7MdLjfhbCXvi6NKbUQdzBovtSva4QjqV/3N2d5jzcmzVIDNqoV2I5pe3taqyMSgPELVLxOqz3QVKJmI3on5oRFXLq6/unfF/dpAP96DUpA+1sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JGCqMZYt; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5372oDFK001710;
	Sun, 6 Apr 2025 22:57:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=vItfOaiXvJslBJLKIFzdUle8A4aTm7a+nZgd/p8XQww=; b=JGC
	qMZYt3b+mX31LlE2CSmApDHXByaDmKHplub1yhzQ/mJWx8ei9+257nsgEdbmOD7E
	HjHu4Z5k19reeT6YTGkneGSz2JupWZKl1WeemqgtLx10UdCHas/5yEEN6M8yiS19
	MeE04U1VZ9qCxjiHxepodil3BuTRNNwEUpdE/FcXhJsYP+0aRCQ6wR+4uPG+ixCB
	wJhomTvKaBo/qTfCg9IVkWJbdLZtGHBZWvGKdRPP8vBR+7G1ybMBqp3auD79xp/J
	+OYaeAf5mFfrOyclzt8PLGMQHiW3PGyTN82cGaD6ZnXzOPJsN/NEmwbbRen5LD8E
	PqbtMNnpKNnD9puQ0qw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45un99se9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 06 Apr 2025 22:57:21 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 6 Apr 2025 22:57:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 6 Apr 2025 22:57:19 -0700
Received: from 452e0070d9ab (HY-LT91368.marvell.com [10.29.8.52])
	by maili.marvell.com (Postfix) with SMTP id A4A575E689F;
	Sun,  6 Apr 2025 22:57:16 -0700 (PDT)
Date: Mon, 7 Apr 2025 05:57:14 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: Wentao Liang <vulab@iscas.ac.cn>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        "Hariprasad Kelam" <hkelam@marvell.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] octeontx2-pf:  Add error handling for
 cn10k_map_unmap_rq_policer().
Message-ID: <Z_NpOu08haGEgqi6@452e0070d9ab>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Authority-Analysis: v=2.4 cv=I/JlRMgg c=1 sm=1 tr=0 ts=67f36941 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8
 a=GBOcKGS_P0nr7jNeXqQA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-GUID: Z-HvqX0urDsTaNFetK0Gnp6pkfeh4NIf
X-Proofpoint-ORIG-GUID: Z-HvqX0urDsTaNFetK0Gnp6pkfeh4NIf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_02,2025-04-03_03,2024-11-22_01

On 2025-04-04 at 11:11:38, Simon Horman (horms@kernel.org) wrote:
> On Fri, Apr 04, 2025 at 05:22:16AM +0000, Subbaraya Sundeep Bhatta wrote:
> > Hi,
> > 
> > From: Wentao Liang <vulab@iscas.ac.cn> 
> > Sent: Thursday, April 3, 2025 8:43 PM
> > To: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Geethasowjanya Akula <gakula@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>; andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@redhat.com
> > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Wentao Liang <vulab@iscas.ac.cn>
> > Subject: [PATCH] octeontx2-pf: Add error handling for cn10k_map_unmap_rq_policer().
> > 
> > The cn10k_free_matchall_ipolicer() calls the cn10k_map_unmap_rq_policer()
> > for each queue in a for loop without checking for any errors. A proper
> > implementation can be found in cn10k_set_matchall_ipolicer_rate().
> > 
> > Check the return value of the cn10k_map_unmap_rq_policer() function during
> > each loop. Jump to unlock function and return the error code if the
> > funciton fails to unmap policer.
> > 
> > Fixes: 2ca89a2c3752 ("octeontx2-pf: TC_MATCHALL ingress ratelimiting offload")
> > Signed-off-by: Wentao Liang <mailto:vulab@iscas.ac.cn>
> > ---
> >  drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> > index a15cc86635d6..ce58ad61198e 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> > @@ -353,11 +353,13 @@ int cn10k_free_matchall_ipolicer(struct otx2_nic *pfvf)
> >  
> >  	/* Remove RQ's policer mapping */
> >  	for (qidx = 0; qidx < hw->rx_queues; qidx++)
> > -		cn10k_map_unmap_rq_policer(pfvf, qidx,
> > -					   hw->matchall_ipolicer, false);
> > +		rc = cn10k_map_unmap_rq_policer(pfvf, qidx, hw->matchall_ipolicer, false);
> > +		if (rc)
> > +			goto out;
> >  
> > Intentionally we do not bail out when unmapping one of the queues is failed. The reason is during teardown if one of the queues is failed then
> > we end up not tearing down rest of the queues and those queues cannot be used later which is bad. So leave whatever queues have failed and proceed
> > with tearing down the rest. Hence all we can do is print an error for the failed queue and continue.
> 
> Hi Sundeep,
> 
> Sorry that I didn't notice your response before sending my own to Wentao.
> 
> I do agree that bailing out here is not a good idea.  But I wonder if there
> is any value in the function should propagate some error reporting if any
> call to cn10k_map_unmap_rq_policer fails - e.g. the first failure - while
> still iterating aver all elements.
> 
> Just an idea.
> 
Hi Simon,

We can do but it gets compilcated if more than one queue failed and
reasons are different. Hence just print error and continue.

Thanks,
Sundeep

> > 
> > Thanks,
> > Sundeep
> > 
> >  	rc = cn10k_free_leaf_profile(pfvf, hw->matchall_ipolicer);
> >  
> > +out:
> >  	mutex_unlock(&pfvf->mbox.lock);
> >  	return rc;
> >  }
> > -- 
> > 2.42.0.windows.2
> > 

