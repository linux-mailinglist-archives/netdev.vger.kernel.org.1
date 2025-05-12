Return-Path: <netdev+bounces-189733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0A7AB3628
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 13:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5933417BD60
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0B62673BE;
	Mon, 12 May 2025 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XCJOcLPc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F721A316E
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747050366; cv=none; b=ickcIsW/cviGRmgQd2tASmAhaeeyIF1WPdnwt9fmU7NtZ5G493D1LBy6wcXj/wmkuYtP4RzU6oUChKsn7/q/F21DEOIlOZzo4cemxfJrO4YJ5H+lEmfj7McFeqgdC+295xllfSqQZDmvflpSCs4RBybuOin20xDMuYMR6mgMIyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747050366; c=relaxed/simple;
	bh=VYsbC6pjOeqbcl9PL92v/znlEfay+PSXnr/Cqf8zSOk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTSPBvW4PBhHU4WeEK+s4QSd9vskzyd+TdfCk+ag2p11wFFlX7pghGLxI2Px7tMC2sYWkzWQZ+GxUw16EkzYBxMk2Zuc8e4a3UbwKEPAEBpMzkU7BsOTekBooJvVaWDPW50XGC4xwxTJZSp3foNktRg55Ug4qD6jjn+ZcVsW9dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=XCJOcLPc; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C5BSjW019412;
	Mon, 12 May 2025 04:45:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=T96oSuMItsxfy3oWU9moC4+0D
	WoE7EDHWCxOhPQ14gA=; b=XCJOcLPcz/fSpeiMJ6Zis61LunnnDqrduPbXAxGVh
	78F0NJJ6urXE84oxOEg+u4kCNvbI/pHm7tPyVcc0sJInlawDQflo1hV+vXWuJhdc
	iGJvSGQqE2tPjU8DEjs/3MZ1Qk95ST9G7ozCDDCJzbvA3hoLTp8l0apmNWJyz8iX
	9dRb3mLZvpH821QuL9epiiiqtb4kEhBgoEjJJ020V5UpjpwxLGzsAm4tUUZe8IGk
	JspDJBp1wCfZ1ZXXZpmZSvHayAq6/kg6WepbCUFcbS9FR4l0x8xxX1/Q/5A4Ifxl
	SoC6k1+eJIYv9vOSq+DUeJcw4gig5FTFtelXsvdqqiXCA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46kamdgjph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 04:45:50 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 12 May 2025 04:45:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 12 May 2025 04:45:49 -0700
Received: from 90a8923ee8d1 (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id AF65E3F7060;
	Mon, 12 May 2025 04:45:45 -0700 (PDT)
Date: Mon, 12 May 2025 11:45:43 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH] octeontx2-af: Send Link events one by one
Message-ID: <aCHfZ_MxtfVmhXVj@90a8923ee8d1>
References: <1746638183-10509-1-git-send-email-sbhatta@marvell.com>
 <20250512100954.GU3339421@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250512100954.GU3339421@horms.kernel.org>
X-Authority-Analysis: v=2.4 cv=DtpW+H/+ c=1 sm=1 tr=0 ts=6821df6e cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=EZAAayXskDsXsr5XbIwA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Ie58mgPVRzXInmmL7-LAgxHjDqpzxsqN
X-Proofpoint-ORIG-GUID: Ie58mgPVRzXInmmL7-LAgxHjDqpzxsqN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDEyMyBTYWx0ZWRfXyrLgtZKzXgJT x9JXciLvGs3qYxcexO7Z8wO3M92+5TanNKIXW28HQ+7dZuHIhF/qiPu5vC3RyKf4cLFr5SsbALj sRU7EYyJRALMVJI12YsGSRT6k41x22HhDSSZ96gG8j7N8oUghHpKlz4ROjHcLZro+LBPJRKXtoK
 xOYL0oqtj64wMI31TAnwomqOkESFeXBQPJwAPJFKbl7bGXfLebktUjoO/dUgUbf9nsrPk6l1ng+ ISv40t5cguvecYd1gNimjgHSeBEnwfLVwp4+sQWjiGzLsBRrLzfH2+L2XSEa5BSqAAD1CgwlFd0 7L/yNGLJUemNP53aayAN7KSm4MAE9gQ2xKlQwQzCqyDRO4x+hbFiEGmWPl7LNTt5jrJAs7yepw9
 1acECH22lSAemOMMG3CSlJelb0D0wwo2kXkUHgi0c0WPS/DwfBYUl2ZSlABnflVnkE6FR/45
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_04,2025-05-09_01,2025-02-21_01

Hi Simon,

On 2025-05-12 at 10:09:54, Simon Horman (horms@kernel.org) wrote:
> On Wed, May 07, 2025 at 10:46:23PM +0530, Subbaraya Sundeep wrote:
> > Send link events one after another otherwise new message
> > is overwriting the message which is being processed by PF.
> > 
> > Fixes: a88e0f936ba9 ("octeontx2: Detect the mbox up or down message via register")
> > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> > ---
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
> 
> Hi Subbaraya,
> 
> Are there other callers of otx2_mbox_msg_send_up()
> which also need this logic? If so, perhaps a helper is useful.
> If not, could you clarify why?
> 
UP messages are async notifications where we just send and forget.
There are other callers as I said we just send and forget everywhere
in the driver. Only this callsite has been modified because we have
seen an issue on customer setup where bunch of link events are queued
for a same device at one point of time.
> >  
> > +		otx2_mbox_wait_for_rsp(&rvu->afpf_wq_info.mbox_up, pfid);
> 
> This can return an error. Which is checked in otx2_sync_mbox_up_msg().
> Does it make sense to do so here too?
> 
Yes it makes sense to use otx2_sync_mbox_up_msg here. I will use it
here.

Thanks,
Sundeep
> > +
> >  		mutex_unlock(&rvu->mbox_lock);
> >  	} while (pfmap);
> >  }
> > -- 
> > 2.7.4
> > 

