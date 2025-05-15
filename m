Return-Path: <netdev+bounces-190790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A1CAB8CB7
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 18:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44610178920
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF941C07C3;
	Thu, 15 May 2025 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="K0pIu8Ru"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242FA72614
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327307; cv=none; b=FMoUQnxtgbVdnRROt3ZVmfu3jYDSESDNN7BTrhtbf1CJoW8efhjiwChQXm/3YRvXhG4EE80S7AZ94K2B9rVLBe1OBXgEuOBBh9rNALykBYB16/P8c0wImIEgmaesSaY8z0EITYcAdSLHEFM+WT8qVjmTYpN3u5x7IV98ihARIOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327307; c=relaxed/simple;
	bh=NjxV6MQfTRcDcLVm3DRZD2w06dUyiZZ4jSLdCg02BjQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMpY1u2QBBaBYysH9VKXXJ6Y4bFFDHewggPdFAxyNdymn0Tb64Qye2jRrevYYbHXDGFvekaAOyzRBAyIR3kMno50KXpjFY4ug4Par/dYYWnZB4meqFwoH3gDT3JOMDbfP7rmkZvMdCUev4iQ5yIqk8pMNjZRZMGdJ/sLhus80Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=K0pIu8Ru; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FBLYak030234;
	Thu, 15 May 2025 09:41:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=IdxvSxObU4niooGdtOLyuv9BM
	9M3iyJFMvJ+1TDvjmE=; b=K0pIu8Ruwd9ayqISAg7+xxbxswBwWQZ4orhIF2nGA
	J0lxRW013YqLePw2Jwrt5eqeauMOtmED0Oaumsm4YtLaoMJj1KLABWLy16lWfAaU
	epWLfqCL1rwBFMFGVIV0zxq0RQRehZwPjyUA2TCRZSwA24KZSXsjnKm2q8M+exIf
	LLu9HtfOA3Z5zSXTDO9Vdl1WXJoxrntn58KpFdK4VPh4y54TMOeYhbcVrmzBRgVn
	wK4DAGEpZGjWeDQo1Iro1aQEdlvDgew9TiPaVJGwe60zpIribFBld5cbNtiNysbj
	W4o9eHztmClNBw1Fqn9fRHbnIhcX1tX/JGv6X1FNzgkCA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46nfaqrrjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 09:41:25 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 15 May 2025 09:41:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 15 May 2025 09:41:24 -0700
Received: from 3958e7e617f8 (unknown [10.28.168.138])
	by maili.marvell.com (Postfix) with SMTP id 2A3B13F7050;
	Thu, 15 May 2025 09:41:19 -0700 (PDT)
Date: Thu, 15 May 2025 16:41:18 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <horms@kernel.org>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <bbhushan2@marvell.com>, <jerinj@marvell.com>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH net v2] octeontx2-af: Send Link events one by one
Message-ID: <aCYZLg2IohEbhMYY@3958e7e617f8>
References: <1747204108-1326-1-git-send-email-sbhatta@marvell.com>
 <20250515071239.1fe4e69a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250515071239.1fe4e69a@kernel.org>
X-Proofpoint-GUID: U3Mij7GbU8CyJC0xiZvvMKOZxvFsAQWC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2NiBTYWx0ZWRfX422/oTu1KppW PMG7qreB8JaHcbfsho2w1IRlpurPm5yPDYoWlEP2+Py9Cux9r9NayZ9TDK67SR+WDSdrsjNAjsu QcPZLVyCJliNbCIbLA+kyyQ4Brc2ldHllR8E8cIrh0NhY9oXhL1ZxtE6pJCHXdIeTnzFm9XQG5B
 oCB68YRmn/jlN3qONPS6dLGqpd31LDMnapL1NlExpujwIQnrCC60MtP81iL1Ova/VedJRQ8QHOP ZjaiKbDqbz9vz9axBWeWuQIl3eHOzA9gSfzRx1vHGQ+q6kfvoLHScZy8LMjpAoOLz/mdA0TTlhg ABEa8c3HUzAya4qMQJH5PFbMCJXqNX1GH5evUbC6HESN5DgLuHSDqqKkpEJ6/RLc+h6tmqKva0L
 AsYvtL9fPktp8IufdLe8VR3V2gl4swU3wv242reWdkHdqI5TpSn8tNKjobocF0QxrthGLVtS
X-Proofpoint-ORIG-GUID: U3Mij7GbU8CyJC0xiZvvMKOZxvFsAQWC
X-Authority-Analysis: v=2.4 cv=GKwIEvNK c=1 sm=1 tr=0 ts=68261935 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=WVyoFZxKQhT9brzLjWUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01

Hi Jakub,

On 2025-05-15 at 14:12:39, Jakub Kicinski (kuba@kernel.org) wrote:
> On Wed, 14 May 2025 11:58:28 +0530 Subbaraya Sundeep wrote:
> > Send link events one after another otherwise new message
> > is overwriting the message which is being processed by PF.
> 
> Please respond to reviewers in a timely fashion.

Just want to know is it you or bot? What is the time limit here?
Have to respond within 24hr?

Thanks,
Sundeep

