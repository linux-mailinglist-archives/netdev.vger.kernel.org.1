Return-Path: <netdev+bounces-192637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 866B5AC09A8
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 12:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C171BC2843
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDF1286434;
	Thu, 22 May 2025 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="f10Kh233"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346682914;
	Thu, 22 May 2025 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747909233; cv=none; b=AIUxlDlWeCRj0Jndh3VschHS6Vihjv2sy0YSspxJU80BIwa56YawMxD+U05p02hz03b6sYyrWLNbjVJUKMdAKQ8knxqasrAlTZEkozbaSMN9QO7YVGH9qjURmFQ+X3XOX2Ohg0CfTcgYvM2ov8gCA9s+dQnECXx1KPYXBv5Y6TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747909233; c=relaxed/simple;
	bh=3wVOPp3QerPttRkuD6O+lfVxFAeAs2EqGaamxlmZxS8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAGsaF6v11Xf1iQUWNw8rpysgBqbUgO7XGxicul50+XCDB+c1VVYjFb0MF1+/zM6eMlTT2yiKdtOW4WEPcWmlzahG6OiFAwXPi9R7JWX3xWWwfMbMstOhfyfcrN93tsV1lEFyJryir8wLEEN5ezqBBZDKgXnOjkDkiWeLaKFRpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=f10Kh233; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M9HDa5007707;
	Thu, 22 May 2025 03:20:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=tst0X0n1a9HbG9MmHjemV9KEm
	LWQ1Y1zP1zqmTeUhCc=; b=f10Kh233hwwzWc53dEGDDFprhd2Oh4jzyPhzdCzo2
	QiPyaaWGeO5Db5+G+8zRIDhG+QiiZa8K3yV+P3eoKSInb5oXD1bwh1gOuDTE1qqB
	OhCPBREsWmo1+/N1fgMqCSklHqCB2PBqZ3GzepLeHv3f4On5lGtuo39k8pA8RNWE
	C/xsgBYeOi1mb5RyAQ3Od3/EHM39NCygSk3rW4lfqX6vZ3uDtOfVSChgpHaatuk/
	zD+3I3s5qKWmkUtc+hTaK7y2Y2hm2jem+mdM0GXMLUq+MM1SIraG3sfor37E4r8x
	LumZc5nhwq/SGzxV7g+Y/kJ3/SPyKfVj5ti+1+CsnYilg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46t15jr45k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 03:20:21 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 22 May 2025 03:20:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 22 May 2025 03:20:20 -0700
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id F0CC73F7086;
	Thu, 22 May 2025 03:20:15 -0700 (PDT)
Date: Thu, 22 May 2025 15:50:14 +0530
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
        Naveen Mamindlapalli
	<naveenm@marvell.com>
Subject: Re: [net] octeontx2-pf: QOS: Fix HTB queue deletion on reboot
Message-ID: <aC76XlI3Wa6ohaBq@test-OptiPlex-Tower-Plus-7010>
References: <20250520073523.1095939-1-hkelam@marvell.com>
 <20250520164339.GC365796@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250520164339.GC365796@horms.kernel.org>
X-Proofpoint-ORIG-GUID: pxUWK78XaduQokaEzY0HXGhi8KOJUg3p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDEwNCBTYWx0ZWRfX1TK7PGFgbkBR 6wevPTCcwct1DhaIpziEiwMNBsJymgHAqVkr8rhw6uIarHK8K5Gzc2bKvf2YjNpQQW9SQurqz5w ImOs4ZLPZ4HAFZloEY9DZts3vucNufyl3aAivWdfCUEU2sOvRoIuJw/hR1oQSJdEjqUR5Nm8fj+
 tH6CP4ViW/DMC9j8ZkvG135qQb4bFsnoz2ldXzcQ+jou0i79H4Dx9hdoWtnGbft248cngFrKgZa aX9rgh7xglxgLUqfE+rarvOTDxC7s0506PeoAoHy+JBMyIgC1Ea5LyCK3eAvuePj6X6LRSUhsuv JftHToq0DsGxKdeBhF/7+E0y1lLSlyyNCODQenuGTC5/wcgTJeq5nwezNbEQAjXlqTfNc+LaxBt
 RfdZZHm6/4PZvkttIG8R+I4iC+r3ckELNnn5Pu1EL1wNAJA4MAnJuJ27al1UF/3ZhVieIkyg
X-Authority-Analysis: v=2.4 cv=HOrDFptv c=1 sm=1 tr=0 ts=682efa67 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=-eSI7bYEJqvrpj8jT6wA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-GUID: pxUWK78XaduQokaEzY0HXGhi8KOJUg3p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_05,2025-05-22_01,2025-03-28_01

On 2025-05-20 at 22:13:39, Simon Horman (horms@kernel.org) wrote:
> On Tue, May 20, 2025 at 01:05:23PM +0530, Hariprasad Kelam wrote:
> > During a system reboot, the interface receives TC_HTB_LEAF_DEL
> > and TC_HTB_LEAF_DEL_LAST callbacks to delete its HTB queues.
> > In the case of TC_HTB_LEAF_DEL_LAST, although the same send queue
> > is reassigned to the parent, the current logic still attempts to update
> > the real number of queues, leadning to below warnings
> > 
> >         New queues can't be registered after device unregistration.
> >         WARNING: CPU: 0 PID: 6475 at net/core/net-sysfs.c:1714
> >         netdev_queue_update_kobjects+0x1e4/0x200
> > 
> > Fixes: 5e6808b4c68d ("octeontx2-pf: Add support for HTB offload")
> > Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> > ---
> >  drivers/net/ethernet/marvell/octeontx2/nic/qos.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> > index 35acc07bd964..5765bac119f0 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> > @@ -1638,6 +1638,7 @@ static int otx2_qos_leaf_del_last(struct otx2_nic *pfvf, u16 classid, bool force
> >  	if (!node->is_static)
> >  		dwrr_del_node = true;
> >  
> > +	WRITE_ONCE(node->qid, OTX2_QOS_QID_INNER);
> 
> Hi Hariprasad,
> 
> Perhaps a comment is warranted regarding the line above.
> It would probably be more valuable than the one on the line below.
> 

   During the leaf deletion need to make Queue as INNER (to stop traffic from stack)
   Will update the commit description accordingly.
 

