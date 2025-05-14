Return-Path: <netdev+bounces-190314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAA2AB62D6
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 08:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A913BC80B
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 06:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3671213E41A;
	Wed, 14 May 2025 06:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kkc0/iql"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B69F101DE
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 06:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747203404; cv=none; b=mK65QQROf2N68tu0+u0FKqfE+GM8VUk9dfwglqSuUiRrDTOc4OwEXggUP1evqSdRkLSjG/7gzIz3VJ/0OASz5FAUGuCooJKt6+H3sW32tqQdVo25ekqXTiOtJQMSEFGqwN93SIrDbz204nH34w9rrzpFVjhRXFc/w5mNfgcdxAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747203404; c=relaxed/simple;
	bh=xr4CY2Mpze7QnyAf3Rjdp5IP6eNw9fo6aT/Ri0Oq0BM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mk8WPTLPHImm9Z21WpZvO7pUjJJSdhEj4XppGY5l7zfghRqZP3lq8znLAc/UbuRv9wVhuWQVKh/OtUfJ2canNvz6yTuFKNLNcWu3lzwbPrwrNR+WDdzQYCSeTSa3IhZU5F0voItWAxxzghvcq8yq/7zIA35I6/uBZb4JzLmQ1iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kkc0/iql; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DIUnf0005900;
	Tue, 13 May 2025 23:16:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=XBDLfjHMWNMx56qzJahjgEsEX
	O1IBc8W15mzswYOYHA=; b=kkc0/iql05tVKJF3OLh92Q/9vW3YbxQcDD0g9cYhO
	aL5VaH7iJm1rAmfcTsYNzx5oEm9S7vNBWDD67DVrD0JwCOD6mFNJOaDaWj723Vy2
	QNmsOl/JOxtqCTRvifCSnyV92lLNaXymSsZWMxvKDlgg48kfqTelG5ZfTAd3F1sD
	OkZ8T0al3DGpTxU4TsMgkpMVG79z7Yp8of2wLMc4FGbdY7SdQGym2hbvRtEo0XMq
	H4vBj7jBZ8l2EmYna5wiIUDbCtOu8G9aj9EJWg/VrZexEDnsDbo7EnyTbWw8ODpd
	LghqJTz91KjPgHR7coDRxGaS2fHKhgtXOJSZBBQVPKgPQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46mbe214vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 23:16:31 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 13 May 2025 23:16:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 13 May 2025 23:16:30 -0700
Received: from fbe7a07ed869 (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id 9BA645B6934;
	Tue, 13 May 2025 23:16:26 -0700 (PDT)
Date: Wed, 14 May 2025 06:16:24 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH] octeontx2-af: Send Link events one by one
Message-ID: <aCQ1ONCy8K6AQBjx@fbe7a07ed869>
References: <1746638183-10509-1-git-send-email-sbhatta@marvell.com>
 <20250512100954.GU3339421@horms.kernel.org>
 <aCHfZ_MxtfVmhXVj@90a8923ee8d1>
 <aCHxax9GgcLL-4Xk@37b358c748b7>
 <20250513131721.GY3339421@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250513131721.GY3339421@horms.kernel.org>
X-Proofpoint-ORIG-GUID: PhrbqKPr2_asBaUoJkVtkdiQ3kfwGcpp
X-Authority-Analysis: v=2.4 cv=fbyty1QF c=1 sm=1 tr=0 ts=6824353f cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=oGJewhSNh7Begt_B-X0A:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: PhrbqKPr2_asBaUoJkVtkdiQ3kfwGcpp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA1MyBTYWx0ZWRfX/cvQLzpEDxGK pYWu+UT/pu8Cl3VN5Ko6tHmu5ZUggP1vjunRqQXjGFAvUtEcU+0Di2JAvGcNi6yNDG6iTXtZfXj iiWybYM8LosXeaZT+zbW3xRgV9qLeEBcCEKsBItiP8dQczuU69N0iZAMKlduvnKUeOKFvSncQed
 xbeSgdA1eRC5i5XKeQdmfzy41bFsake+rT7FGSSQLpzvNnRqN7jguXacjz5JXpe1McDQkF8kzDk d7uy8GncMihRMyKAearkeMv4NMBER+bJ2gfi1OPuG/4Idcih9xpHgB3LeR1FBiQyzFLpvgK+5dM abBbrxX2nmOt/49w2RLEquCAzHXoMdRAP4Wql7z78phsNvyHezm9c8rLF6HQ+DvGWqDP9Xy+lkf
 9Q837U5eG6woNpnLmDOtqzfKoI1GqLQg//ZoVwWwBbSI2jWeGqReXzUX6f5h3mL0DPWyLAeJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_01,2025-05-14_02,2025-02-21_01

Hi Simon,

On 2025-05-13 at 13:17:21, Simon Horman (horms@kernel.org) wrote:
> On Mon, May 12, 2025 at 01:02:35PM +0000, Subbaraya Sundeep wrote:
> > Hi again,
> > 
> > On 2025-05-12 at 11:45:43, Subbaraya Sundeep (sbhatta@marvell.com) wrote:
> > > Hi Simon,
> > > 
> > > On 2025-05-12 at 10:09:54, Simon Horman (horms@kernel.org) wrote:
> > > > On Wed, May 07, 2025 at 10:46:23PM +0530, Subbaraya Sundeep wrote:
> > > > > Send link events one after another otherwise new message
> > > > > is overwriting the message which is being processed by PF.
> > > > > 
> > > > > Fixes: a88e0f936ba9 ("octeontx2: Detect the mbox up or down message via register")
> > > > > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> > > > > ---
> > > > >  drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> > > > > index 992fa0b..ebb56eb 100644
> > > > > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> > > > > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> > > > > @@ -272,6 +272,8 @@ static void cgx_notify_pfs(struct cgx_link_event *event, struct rvu *rvu)
> > > > >  
> > > > >  		otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pfid);
> > > > 
> > > > Hi Subbaraya,
> > > > 
> > > > Are there other callers of otx2_mbox_msg_send_up()
> > > > which also need this logic? If so, perhaps a helper is useful.
> > > > If not, could you clarify why?
> > > > 
> > > UP messages are async notifications where we just send and forget.
> > > There are other callers as I said we just send and forget everywhere
> > > in the driver. Only this callsite has been modified because we have
> > > seen an issue on customer setup where bunch of link events are queued
> > > for a same device at one point of time.
> 
> Thanks for the clarification.
> 
> > > > >  
> > > > > +		otx2_mbox_wait_for_rsp(&rvu->afpf_wq_info.mbox_up, pfid);
> > > > 
> > > > This can return an error. Which is checked in otx2_sync_mbox_up_msg().
> > > > Does it make sense to do so here too?
> > > > 
> > > Yes it makes sense to use otx2_sync_mbox_up_msg here. I will use it
> > > here.
> > > 
> > I will leave it as otx2_mbox_wait_for_rsp. Since otx2_sync_mbox_up_msg
> > is in nic driver and we do not include nic files in AF driver. Since
> > this is a void function will print an error if otx2_mbox_wait_for_rsp
> > returns error.
> 
> Sorry, I wasn't clear in my previous email.
> 
> I was asking if it makes sense to check the return value of
> otx2_mbox_wait_for_rsp() in this patch.
> 
Not needed because there is nothing much we can do if it returns error
other than just printing that it failed. And anyway otx2_mbox_wait_for_rsp
has debug print internally so will leave this with no changes.

Thanks,
Sundeep
> ...

