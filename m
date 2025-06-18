Return-Path: <netdev+bounces-198972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B1AADE82C
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 12:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9115B3A9F9B
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 10:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E8228541A;
	Wed, 18 Jun 2025 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="c9LYX9BC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB1A27F4CA
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750241045; cv=none; b=lGAXeiGgSwg44OGK4TcXk+60/rOx/QKWktqYXafndAZ/RV8P5RT1LscqEWBBVZK1t4YJTCJ2p8W17iQ6o6NEOHCHA8SzwQA1+70UVr6aJNOU99OMV63mVmrjcLBOzOVQxTsEXc6BpkppkfejxVU66doqIJO5E8JXaohPVQCoaV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750241045; c=relaxed/simple;
	bh=CEGgbA0D9d8qIyvxXzMI7MZQVww8ZngN/udDcgiYGjk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktHwTnNThlChroYzmlN6HsDfhLywi/Kz8+CsfOGzFomZfdwUt9Z+oAWawzAupn/vDGAhv2Oojba6DGQ1mkm9PFzpfQRGeIG1mcd6jIz4OCBvdPwADdwcgXHZZU3FJcfUhAVuLiSsqHnbpo+YLnkkCMmBxHknmnQbk4qcxEk/SaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=c9LYX9BC; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I9G3Br022724;
	Wed, 18 Jun 2025 03:03:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Hwwg7GghgmZfv6V0guts5PA55
	jA4pBVmENns3oE9eb4=; b=c9LYX9BCPcci//gUz3Ru+nCo//BuzHC6MWnrmU4sH
	ohkYP+S0KntTZRvBoNFTFzVbHWqE56MDZsLOZbRZp2NnoUP4TfTT27lgYJZiJIwg
	53bPq1xHAjGqFGZEBntbAEPSeNnijKC5gIrDXF9TCMaz6LaSYDJhyGHA47iOEoaW
	PxdRTG+lHZGpszvRzWErDOTPuQ+bEwGst1zQyPD3iwquaztgrv6ghxHEMvkHoDOK
	AvDrN00ailD+s1h1ORL+pWw7b2o0fpviWx3BllhJZnEvnDgr8Eowidbs39ECx8gf
	veYJSj7eStEtgCxONzJz98hUct52eCknuMZFl5b/lUEpw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47btnx83ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 03:03:47 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Jun 2025 03:03:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 18 Jun 2025 03:03:46 -0700
Received: from de6bfc3b068f (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id 82A023F7060;
	Wed, 18 Jun 2025 03:03:40 -0700 (PDT)
Date: Wed, 18 Jun 2025 10:03:38 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
        <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
        <shayagr@amazon.com>, <akiyano@amazon.com>, <darinzon@amazon.com>,
        <skalluru@marvell.com>, <manishc@marvell.com>,
        <michael.chan@broadcom.com>, <pavan.chebbi@broadcom.com>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <bbhushan2@marvell.com>
Subject: Re: [PATCH net-next 1/5] eth: bnx2x: migrate to new RXFH callbacks
Message-ID: <aFKO-lWjm4aYXHZj@de6bfc3b068f>
References: <20250617014555.434790-1-kuba@kernel.org>
 <20250617014555.434790-2-kuba@kernel.org>
 <aFENwzdHRYbjW2WX@9fd6dd105bf2>
 <20250617151428.499f80c2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250617151428.499f80c2@kernel.org>
X-Authority-Analysis: v=2.4 cv=E4TNpbdl c=1 sm=1 tr=0 ts=68528f03 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=QXJ8sekdQaIREAroi-EA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: R8um0_kx2FCxRZexueo1Af_p73faHNrf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA4NSBTYWx0ZWRfX0dsmlUavoEBw jZQ33bL+7bu33Vk6IBfQixP3isNhUJTjplSf3KvXnN28dQW0ZMhgaghnYaowY+bkDcwfGgvT+bv FmfL1jSCVHo1koUY802f0pQI/DLBw1t8cWtYv9FcI/4Vos9/pfCJa6qW8VvsxH9yvAKkYKwYBbj
 AxrKGj5hM7birzxoj+A/aT/sutDECfWWZzid4lEex+AlyTxl5H7fcBoU8enzymgFHcowuuBHOcU m+11ImNoj9BQbC9YhMXUkpqvOCX7LZoz7A5vG77a3/2j3swzQFSTvfwXXlBpCuN080RKN4FnUoY MIrlPZ/OrfH88BVB0T2dURTgpw0U5NY3GjW1fV0a2r43Esl9M/Ufp6PBWxwmrU7Lmr4DlZUQeYX
 a8yOpVC/PW5fXU5E9EMX5rHuh3DDNdfMw0qPsaz/Gf9fsElaoViQFfZNjGQke5ADyhoPYrCR
X-Proofpoint-GUID: R8um0_kx2FCxRZexueo1Af_p73faHNrf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_04,2025-06-18_02,2025-03-28_01

On 2025-06-17 at 22:14:28, Jakub Kicinski (kuba@kernel.org) wrote:
> On Tue, 17 Jun 2025 06:40:03 +0000 Subbaraya Sundeep wrote:
> > > The driver as no other RXNFC functionality so the SET callback can  
> > typo as -> has
> 
> I'll fix when applying, thanks

Since there wont be v2, for patchset

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

Thanks,
Sundeep

