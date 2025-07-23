Return-Path: <netdev+bounces-209416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7365B0F8C1
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90AE1CC0284
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBAD20E717;
	Wed, 23 Jul 2025 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="FRSyI64/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F72210F59;
	Wed, 23 Jul 2025 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753290895; cv=none; b=EQF8BIp3K8y65GV/4t54kZAHS+tehZtqHDa6vpmzA45sQtnrw+YNu8JOsDjVjlfPQATlOVmFjE1Jy2qaJ/28Hcv9KpkxS/mempiLUpHQTCkTyfYP3yo2nGuWpAARuJsH/75hnCRPhLFI8KzM5GNKEOX77NHmC2Th57iFrqcAxkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753290895; c=relaxed/simple;
	bh=376GIzdk3UK3ULXlhu8XycOTMZW+JFFzHA6EjVpQvw8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsEGI1YTgTQ0sVc9iPQI2lV3r92BixVm1hL4ryAP225ncfIo25eq/U/iCbi/sE0az9SRBUCEQS3sAkkyYUyPuHyFt3Fo3goYSp6ODJuuQR53H/AAi2mMaasi496XVQrJzYDuhmtt6uUBKvfDe5Bjzym/bDEbt+ByN1/Ylrm32l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=FRSyI64/; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NFBbL3024070;
	Wed, 23 Jul 2025 10:14:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Gl1TWmaJUfAG+7Fw2CmtDcyTN
	4evgDZ3kNkyr2icgUg=; b=FRSyI64/ROiMobw+Y553Of0ur/Ybcv7khMgmXKRI7
	alfFUBFrW5ELE574BaDZaUVFYMsSc/8HXtSjVdIVVS9aD39cPpb16MVBfG4PVoDj
	qG1+cNekc2wQoMs4EnnUQprRlkjct5ZHtu/3H9D7HKc2Zf3gsgutE8djMh70J4JH
	ub2TDwwTYIJXs5y6IKQlgtp2MA6gv9ZbqNhAwRIrhh/H9gUZeoKkgyYQcZwOMUmH
	sRnmBFRqKVz5VJRWbieypjr/BHFZhvo8QDIJVeq7DrF4scMpT/Urg6vB3RpTC+Ae
	9dsFS81DKX8CDs+N9Lv/UhV0drQb9VNExa+awef7pdMPg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 482vpwh31b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 10:14:42 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 23 Jul 2025 10:14:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 23 Jul 2025 10:14:41 -0700
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id 93ED23F70A1;
	Wed, 23 Jul 2025 10:14:36 -0700 (PDT)
Date: Wed, 23 Jul 2025 22:44:35 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Andrew Lunn <andrew@lunn.ch>
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
	<tduszynski@marvell.com>,
        Simon Horman <horms@kernel.org>
Subject: Re: [net PatchV3] Octeontx2-vf: Fix max packet length errors
Message-ID: <aIEYe/lXNAsvv24l@test-OptiPlex-Tower-Plus-7010>
References: <20250721085815.1720485-1-hkelam@marvell.com>
 <316e5fb7-7f45-4564-9354-e50305f6f3fd@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <316e5fb7-7f45-4564-9354-e50305f6f3fd@lunn.ch>
X-Proofpoint-GUID: MM7CKpi23qhCnyf_IyNa9LI0yrfgSPEL
X-Authority-Analysis: v=2.4 cv=DstW+H/+ c=1 sm=1 tr=0 ts=68811882 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=RiCNH3QyFshw-4LhWYEA:9 a=CjuIK1q_8ugA:10 a=quENcT-jsP8hFS3YNsuE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE0OSBTYWx0ZWRfX/OyVmweVQczU oSEHC2jYm4u8UkbV2rUobiwZsEGmQJ/ZOgGf5w1kI0s8BybEFqytH7kJJyFRkoxDx/muZr05Bqv D7j+kmTwPa74rnksfmVRvVSmewLCe4dpiSauyKasw2M3wgQ5IMbVVBXGGLGmUCTAq89NBvcDRTr
 OE6TpV8Bs7Nmzm9SsFqutA6NIwsS+0JW39gOr9vQNQPJtqyVRkxX+ieRQZgRl42xyObthrOX7id u/3RnnM7kQQghmsVpwgcrzjUZMgwh6HCNHITOntgehDywxMSsa+tijy3uyvhhSwLpUvbLYRtVal +qIqXPfZ5r0euWAm+l+pINvc5X/2mfTEOpR7F71INE28FymQtvM4HwsHOYKQQNe5vRIx7chV/rS
 lVmFsJgMUl21RJtWDAcjelP/p1KgRs4s/9kA0QOXffITrnS2FKYgZkCw7DL5VX5WKNYAkPfZ
X-Proofpoint-ORIG-GUID: MM7CKpi23qhCnyf_IyNa9LI0yrfgSPEL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01

On 2025-07-21 at 19:28:05, Andrew Lunn (andrew@lunn.ch) wrote:
> On Mon, Jul 21, 2025 at 02:28:15PM +0530, Hariprasad Kelam wrote:
> > Implement packet length validation before submitting packets to
> > the hardware to prevent MAXLEN_ERR. Increment tx_dropped counter
> > on failure.
> 
> Sorry, i did not look at previous versions of this patch, so i might
> be asking a question some other Reviewer already asked.
> 
> How expensive is MAXLEN_ERR? What do you need to do when it happens?
>
  On error case, hardware raises the queue interrupts about max lenth errors 
  goes to hang state. Driver needs to execute reset to come out of the state.

 
> I would _guess_ that if ndev->mtu is set correctly, and any change to
> it validated, you are going to get very few packets which are too big.
> 
> Is it better to introduce this test on the hot path which effects
> every single packet, or just deal with MAXLEN_ERR if it ever actually
> happens, so leaving the hot path optimised for the common case?
> 
> Maybe you could include something about this in the commit message?
>
 ACK will update the commit description. 
> 	Andrew
> 

