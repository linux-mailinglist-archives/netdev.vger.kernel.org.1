Return-Path: <netdev+bounces-251435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B1BD3C535
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6272C6234AC
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1023D666F;
	Tue, 20 Jan 2026 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="M8132bni"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875AF3D3306
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904024; cv=none; b=cydeos0d54Rxpvhbx4xviPdmXDa250+umGh48auNmDuz0HPVSlr5OKuPtLmlVfWznKNL0KL1rbnVnYAgKz0HgL4mM12ptQbSFKb5QQGIi9pf2EbfAtThYkxUsh+K5n82KKO3ld6ZRGfDXMeGmi5TPwbdIsS1fFZdm0v9Q/ckgLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904024; c=relaxed/simple;
	bh=LxIDAbtpbU5pekGzjiILRlKIhr11Ph/hYmBNm1SIeHc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdWMFBeP8JLxnykTs0WdCqJR1Nwwtcw+RFtj6QTIfx4kpmNeAaSR+lYt3TiYV24LJy47Aii/f5s03nWhH+Zaa54nY+nrOQ6YmwPcrAl98UA15gU+evDxSN/8r+RHjfQPL4L1HzJfjIB9vRr0/Wv29OU+jmxozWQWJLZEWHAB/y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=M8132bni; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K9aIE8831983;
	Tue, 20 Jan 2026 02:13:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=wu5ofytX/u1BIADLswgq2rREe
	C3a8rMljsdWHeCYReI=; b=M8132bniLbHsHBJvyzrTL3VZzRlMZ8TUMR3aogom/
	dNWlYpoJ/vnggtr+PWxZVaZk6dEVb1+eDFTmgHpJ8sayBEcvmgIbU0syoXqDR3NB
	OypK7sXneL672kXuV7FzaROEvFEqvfgz3cpdLPj7QYkbF4U4zL+p1tHUBNPN2gxx
	gZORT2/5E91O6VPmisZdr5dLwUfG6HZpPGJDaF/AAib//z4oy+FCRXjLZORbPmhw
	ExZ+zDUAaxggY0KZ9Re5fBYipV1yD+UgZWFmJ+4x1ZeQN+KDiJ9JocpSXtlyQZl1
	2WYwCof2weKOK+qMkHWn/dQvWJktDG1D9ThPFNkKB32sg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bt77dg26x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 02:13:25 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 Jan 2026 02:13:39 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 20 Jan 2026 02:13:39 -0800
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id A28AC5B6936;
	Tue, 20 Jan 2026 02:13:21 -0800 (PST)
Date: Tue, 20 Jan 2026 15:43:20 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
CC: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Sunil
 Goutham" <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Bharat Bhushan
	<bbhushan2@marvell.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] octeontx2-pf: Remove unnecessary bounds check
Message-ID: <aW9VQPJ0wY/A4hmd@test-OptiPlex-Tower-Plus-7010>
References: <20260119-oob-v1-1-a4147e75e770@kernel.org>
 <e384d38a-ccfa-4888-b057-4306a297e749@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e384d38a-ccfa-4888-b057-4306a297e749@linux.dev>
X-Proofpoint-ORIG-GUID: DWS8e7Qq3f9cZHsMnOXP5HexG3vaaZhx
X-Authority-Analysis: v=2.4 cv=MZRhep/f c=1 sm=1 tr=0 ts=696f5545 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=s0aMi5Xf_MiYTxNsjKgA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA4NCBTYWx0ZWRfXz4uDjDeI9t7Z
 Z0h4NzrfhYPLQN7dxtST+2eXbYqKB2HT5z1+V1loS4Hh1IkIpdenJiACg+RC+m7SDG4WTM62MoJ
 kfIV13t2UkdFMuitW5TVzZt2h6m8rMeeRlqlfrii0EQPs7eDa+BbwbN9rYw3eBuCXDx7NvBh9NF
 r+XfhVwNNbvclgqHZd/FJ1PaO/OvQNafr+FO6+AZRfZcNz2AeeSoKhQ29yOfn7est2BtiRtr89c
 kBXFAmkS0D6RFEzVkV2v/5+J/ILer14iORtSLhMNV74OXO6qkIwlGCDRaVOL/yHcz1/+LJH0Z78
 UeL833UKlgDLuIIYENITLvod6XuQXIaVVbVyv/1hs+s1JIq/MBVBGIWZiP7TvaUCYNOBKSFc3oa
 Wt/4uEjNu/dZr9lJP3wkpuxRt95G0J1ERWasEIPKretLnlcB1yDXDT2cEfEuMdbiiQ+0zcrBVvA
 pXg7l87Mh6SfiWkrC9w==
X-Proofpoint-GUID: DWS8e7Qq3f9cZHsMnOXP5HexG3vaaZhx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01

On 2026-01-20 at 02:47:48, Vadim Fedorenko (vadim.fedorenko@linux.dev) wrote:
> On 19/01/2026 16:39, Simon Horman wrote:
> > active_fec is a 2-bit unsigned field, and thus can only have the values
> > 0-3. So checking that it is less than 4 is unnecessary.
> > 
> > Simplify the code by dropping this check.
> > 
> > As it no longer fits well where it is, move FEC_MAX_INDEX to towards the
> > top of the file. And add the prefix OXT2.  I believe this is more
> > idiomatic.
> > 
> > Flagged by Smatch as:
> >    ...//otx2_ethtool.c:1024 otx2_get_fecparam() warn: always true condition '(pfvf->linfo.fec < 4) => (0-3 < 4)'
> > 
> > No functional change intended.
> > Compile tested only.
> > 
> > Signed-off-by: Simon Horman <horms@kernel.org>
> > ---
> >   drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 9 +++++----
> >   1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> > index 8918be3ce45e9ae2e1f2fbc6396df0ab6c85bc22..a0340f3422bf90af524f682fc1fbe211d64c129c 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> > @@ -66,6 +66,8 @@ static const struct otx2_stat otx2_queue_stats[] = {
> >   	{ "frames", 1 },
> >   };
> > +#define OTX2_FEC_MAX_INDEX 4
> > +
> >   static const unsigned int otx2_n_dev_stats = ARRAY_SIZE(otx2_dev_stats);
> >   static const unsigned int otx2_n_drv_stats = ARRAY_SIZE(otx2_drv_stats);
> >   static const unsigned int otx2_n_queue_stats = ARRAY_SIZE(otx2_queue_stats);
> > @@ -1031,15 +1033,14 @@ static int otx2_get_fecparam(struct net_device *netdev,
> >   		ETHTOOL_FEC_BASER,
> >   		ETHTOOL_FEC_RS,
> >   		ETHTOOL_FEC_BASER | ETHTOOL_FEC_RS};
> > -#define FEC_MAX_INDEX 4
> > -	if (pfvf->linfo.fec < FEC_MAX_INDEX)
> > -		fecparam->active_fec = fec[pfvf->linfo.fec];
> > +
> > +	fecparam->active_fec = fec[pfvf->linfo.fec];
> >   	rsp = otx2_get_fwdata(pfvf);
> >   	if (IS_ERR(rsp))
> >   		return PTR_ERR(rsp);
> > -	if (rsp->fwdata.supported_fec < FEC_MAX_INDEX) {
> > +	if (rsp->fwdata.supported_fec < OTX2_FEC_MAX_INDEX) {
> >   		if (!rsp->fwdata.supported_fec)
> >   			fecparam->fec = ETHTOOL_FEC_NONE;
> >   		else
> 
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com> 

