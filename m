Return-Path: <netdev+bounces-194153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AC9AC7967
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 09:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21535A42BD3
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 07:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B192550CA;
	Thu, 29 May 2025 07:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="lJWCqeai"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624CF24E019
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 07:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748502315; cv=none; b=WqozT0CKvrw26uqd+96dup8zk/ZX/jQlWRVi0CFOYKSq+EcY8yf97IRbJ+BrqckW776GBy1otP65RocCuYoxJ2pr/klFWjsKqooyfE06J93GjubVXG68VcAjiHdtWvmrlEFAxao/6okfNVNiu2RblqoSEJcWyRXahrA5/YZwGBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748502315; c=relaxed/simple;
	bh=JxvxgzMU6tE8NIhuDhwgPN8jpA/uz3g6w7yCFlq/aBo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCkrnFCWv+xDsWy7BN3zloIXoCpaDMtP5GJ6kj1KVC9swNiRB3zR3e9RINdiZgSEsuE/HpbFtKRxf0rvMCa13lV+6g0vReUZp0O43x/wP3WOY4Q53zMxnf9OcQZS9/9EzXJnrH7ybRMZ16Om1cnYgdCf6kpOb82emE9uzPcNdZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=lJWCqeai; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T3TEJt015529;
	Thu, 29 May 2025 00:04:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=zMvTKDBmGtwqdJKSQMMPSAcbo
	lbtvEQqBz2pLxtI3xM=; b=lJWCqeaiA+dMfoh3/eZ9dPoPWUJehBhunWWfTeDBb
	7QWsaHECD3HF43AzNSjK42dSvNuSBc6W2byFfP+Ss06gH9ybm/eiLNkD6KL9ZNAS
	FjoarDCC/2qbRGyV8c3fFsdMc6mOLxRdCVE46xcANuq6NzOWrYDAV58aw+r4b94j
	jSBE9won+yhbW8bExAt4S1Wgf9Fe6L5uJq2GFPlKhrmke2BpioBS7GOBvtgMdk4w
	CeK7dLX+MHzYX09QI1Wosc1STsfgsNSW4gURkmeUKQfNfAoPU5Yx50n28vKAOGrL
	zdpK8gaRkIVj3UkACDF3DReUBWaZ35qstAymZfd49UJ9Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46xfqgrbge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 00:04:55 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 29 May 2025 00:04:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 29 May 2025 00:04:55 -0700
Received: from e6bae70a73d4 (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id 57B123F70AC;
	Thu, 29 May 2025 00:04:50 -0700 (PDT)
Date: Thu, 29 May 2025 07:04:48 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <saikrishnag@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>,
        <netdev@vger.kernel.org>
Subject: Re: [net v3 PATCH] octeontx2-pf: Avoid typecasts by simplifying
 otx2_atomic64_add macro
Message-ID: <aDgHEPfNQvziIqpr@e6bae70a73d4>
References: <1748407242-21290-1-git-send-email-sbhatta@marvell.com>
 <20250528150333.GB1484967@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250528150333.GB1484967@horms.kernel.org>
X-Authority-Analysis: v=2.4 cv=Wv4rMcfv c=1 sm=1 tr=0 ts=68380717 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=rNoB_mh6ZcCg6bZwnJ0A:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 7vdJcnm5lOqv5vP2z7XP2_Jf-vlHCokj
X-Proofpoint-ORIG-GUID: 7vdJcnm5lOqv5vP2z7XP2_Jf-vlHCokj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDA2OSBTYWx0ZWRfX4Royyl/2v+/H Z3ATr7p5YF+WWOS4GYk896F8EegujgASWrHCaHvvZCdiV6GgKFAfbX2S42H2pYItj31XWNEskqM Ba0EjsCy0gSnBfYiqhdCWcPvmUzT21YVow96Np8gwHK5IwJZjTEdytmqmdSFqC6ZzXrZy4Yue3t
 CUeprghm7E14jFQhFcyfLHaytoiDnW6kGCI+3/DZ6U9ffT36cIeAC9gQGbEF4G28Wi275ICKppU 9q/r75p8E31f8ERWUhTyHaEkW4cn9OT1vQw7mECs51e4ZS8ObKtTQFt5/rMBTNl+mxlFwb3NJDr PlCYkpNzWEF8gpSjQrZfuzo3dR7+lf2XT+CNY4hs/k+xZK1NLGQk+Mn5cZYLFCXFMXhQ+rdWEtj
 zt6Q1b+a0oCUaeSI+2CArrAlnFPILoaKSYXm053gE1yMgbxG2G8sWcyPYOkf5FLhd3fZ9NcT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_03,2025-05-27_01,2025-03-28_01

Hi Simon,

On 2025-05-28 at 15:03:33, Simon Horman (horms@kernel.org) wrote:
> On Wed, May 28, 2025 at 10:10:42AM +0530, Subbaraya Sundeep wrote:
> > Just because otx2_atomic64_add is using u64 pointer as argument
> > all callers has to typecast __iomem void pointers which inturn
> > causing sparse warnings. Fix those by changing otx2_atomic64_add
> > argument to void pointer.
> > 
> > Fixes: caa2da34fd25 ("octeontx2-pf: Initialize and config queues")
> > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> > ---
> > v3:
> >  Make otx2_atomic64_add as nop for architectures other than ARM64
> >  to fix sparse warnings
> > v2:
> >  Fixed x86 build error of void pointer dereference reported by
> >  kernel test robot
> 
> Sorry, I seem to have made some some comments on v2 after v3 was posted.
> 
> 1) I'm wondering if you considered changing the type of the 2nd parameter
>    of otx2_atomic64_add to u64 __iomem * and, correspondingly, the type of

My intention is to fix sparse warnings (no __force) and avoid typecasts
so that code is correct and looks cleaner. If I change 2nd param of
otx2_atomics64_add as u64 __iomem * then I still have to use
__force to make sparse happy. This way only otx2_atomic64_add looks odd
internally with assembly stuff.

>    the local variables updated by this patch. Perhaps that isn't so clean
>    for some reason. But if it can be done cleanly it does seem slightly
>    nicer to me.
>
> 2) I wonder if this is more of a clean-up for net-next (once it re-opens,
>    no Fixes tag) than a fix.
> 
Sure. Will post as net-next material later.

Thanks,
Sundeep

> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> 
> ...
> 
> > @@ -747,7 +748,11 @@ static inline u64 otx2_atomic64_add(u64 incr, u64 *ptr)
> >  
> >  #else
> >  #define otx2_write128(lo, hi, addr)		writeq((hi) | (lo), addr)
> > -#define otx2_atomic64_add(incr, ptr)		({ *ptr += incr; })
> > +
> > +static inline u64 otx2_atomic64_add(u64 incr, void __iomem *addr)
> > +{
> > +	return 0;
> 
> Is it intentional that no increment is occurring here,
> whereas there was one in the macro version this replaces?
> 
> > +}
> >  #endif
> 
> ...

