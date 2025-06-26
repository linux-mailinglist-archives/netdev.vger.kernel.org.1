Return-Path: <netdev+bounces-201411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7D2AE961B
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436DC3B1F9E
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 06:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82BC2264C3;
	Thu, 26 Jun 2025 06:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Uz9FVkXr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF5F218EB1
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 06:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750919030; cv=none; b=OgHHTBbEhkAT2Sgmnirn97KKyJYC/eZGXvt7FyYErjqbFJwjyk+mLaDtOSofISZisKxXyKJbUf/EGd/d6Rp3W+Jg0tjNNmd5WjDt/hKtbuAMyRz8kYsxTgD2IzFq/VzWpXXncMa4Qakw0YE/HzjZw6TE4816JyTKPyvAvuh/qYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750919030; c=relaxed/simple;
	bh=9uHYPcqrdgZ4mnygRlgk7No3/9/yVw/vv0A8ZczncDE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQ/syEn+5C5ABOpexKLuxG6KNnzqHIVfuXdp8FaK29BKHND2nbhL/mhjTeuz5JLucQ0Rjk8iJd+eIwsEr7szWK0AxhsKeOVUpg+0Fs6pvvL+VCPtG4C+C5yrNGbQ34rNch7KCChr7jfeB9EtCKub798vFItxsMMBkNbLS/yS9Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Uz9FVkXr; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PNIbvO020055;
	Wed, 25 Jun 2025 23:23:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=S+SzSkZgmPIHIbhha7gX9A3Nq
	Iw3IqU6z51h5K8R1vg=; b=Uz9FVkXrgGU42krYfWAOKtc+7rLceX0WUdlW9d2gY
	XoUW3KjXCvtH02dehi7Yx96PVoxES5vXOsvr2gQVoW+42KzCm3zpDFqGBmEz4br/
	lqjjXqUwBIlsSj394i59RNiJDzsR5MolCykVUuu/Y7YbZPBVi69u3pJLYH+ioLOe
	htBXFCUXr/vMV8GKmNhQ73c4dx37nWhiY8EUQ+AKJUClDl2FGSnLDF206nalC7wz
	8GuolaCkIhyNYqvkXbKEaFtSfDqgsb7Nt+8OARdf+YR0Pg8wxIzIV7WvfBmI/sWQ
	YFOqotj8gecW4TdXZtegMbmLLTfeS2L25XXlShBsatAzQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47gtnv0msq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 23:23:37 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 25 Jun 2025 23:23:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 25 Jun 2025 23:23:36 -0700
Received: from 822c91e11a5c (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id E51133F706C;
	Wed, 25 Jun 2025 23:23:31 -0700 (PDT)
Date: Thu, 26 Jun 2025 06:23:30 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <netdev@vger.kernel.org>, Suman Ghosh <sumang@marvell.com>
Subject: Re: [net-next PATCH] octeontx2-pf: Check for DMAC extraction before
 setting VF DMAC
Message-ID: <aFznYtDq9ywfk5FJ@822c91e11a5c>
References: <1750851002-19418-1-git-send-email-sbhatta@marvell.com>
 <20250625190247.GO1562@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250625190247.GO1562@horms.kernel.org>
X-Proofpoint-ORIG-GUID: L3B0okXH6d-E_wVYMHxUwSg5esD8JIRk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA1MCBTYWx0ZWRfXxxVwNR4B8P5F jG2C63gjJcH9mw3sntqKjdcZx5ERiCXUf2rtoF9iXPQXei/3jh2GoLz1FrD+KLQfMY7GO9LkB38 aqLPkjVqwlJCtSX1cIHmKB1LKiQA4UgEmvFbbAOg7EtDR/oF79aiPltipRkt7Rlf6sHSoJPlcEo
 8kJW6vBtQtWZVRG8feBA0lTt6lP8rR9X28YzMbGYdI8AL/V9r9Kop8QBFPkvXxV4tAgn7tYi2sP 1leuDhdeC/d07WnyQEqQF/Yemp38bVwsnqYdZDyPTPD7wZPd/DyEzK3/2y/2DvKxfg7Ir+TbjML YzJeHvkBU6qDmx86dtkHOSCB0Uzp90ouCp6mCRv0im6PFsdptAimQhpFzZAjwRI9MzE0w9I9zzP
 3srXKv2W4TexXiT5at++HUEfvCfmXf4J4xfaeGUiPZTUmIVJOQfYBW1glI/ltz3Xmoxi3oyg
X-Proofpoint-GUID: L3B0okXH6d-E_wVYMHxUwSg5esD8JIRk
X-Authority-Analysis: v=2.4 cv=T4iMT+KQ c=1 sm=1 tr=0 ts=685ce769 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=99ZVTgxCbylFN8c5AE8A:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_03,2025-06-25_01,2025-03-28_01

On 2025-06-25 at 19:02:47, Simon Horman (horms@kernel.org) wrote:
> On Wed, Jun 25, 2025 at 05:00:02PM +0530, Subbaraya Sundeep wrote:
> > From: Suman Ghosh <sumang@marvell.com>
> > 
> > Currently while setting a MAC address of a PF's VF (e.g. ip link set
> > <pf-netdev> vf 0 mac <mac-address>), it simply tries to install a DMAC
> > based hardware filter. But it is possible that the loaded hardware parser
> > profile does not support DMAC extraction. Hence check for DMAC extraction
> > before installing the filter.
> 
> Makes sense to me, but should this be treated as a bug fix?
> 
No strong opinion on whether this is a bug fix or not.
We assumed DMAC is required always until on of our customers
came up with profile with no DMAC extraction so that they can
use the additional MCAM space created for other packet fields.
I will send as bug fix if you insist.

Thanks,
Sundeep
> > 
> > Signed-off-by: Suman Ghosh <sumang@marvell.com>
> > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> ...

