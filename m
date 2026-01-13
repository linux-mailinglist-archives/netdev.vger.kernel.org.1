Return-Path: <netdev+bounces-249378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 074AAD17CC5
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D425E3011B19
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 09:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5325F3876D3;
	Tue, 13 Jan 2026 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eh8x9SRE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12C734BA56;
	Tue, 13 Jan 2026 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298084; cv=none; b=avXupmPECEJ+ZwCcwMbvX9yuPhdfH1y8Z7Oa6x2YZfRYAWJKb6vTIjRhlK5DutfhgoI3M75tgUHL6JilKQAUh+Zuwp4LJ2tNb74xJWmLOYIw2cRXh17mCRdO9wkNcC7Z3hlZs/zaNQZ7o53/sB60CbITTfKqbd7fJxTb1lLHobo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298084; c=relaxed/simple;
	bh=rU18g5LYS/tBgmsDtoagLSYU/TtFDmr2knEdo/mopNo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1DOb5XPi3pDUhNSoT+hqEZkKAFo/PGk9yEVjnCTL8n4MioqfZ24fOQUmWIVpv48fIgtCrieONU3kAItl5bA0vW/UvPQqDbZ6MygL8eSaRBeM/kXUGzm1guCIn1jtt4zmFIHGre0IpfCjZZVAAEqLRPdheoIw9NWNE330PnAe28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eh8x9SRE; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D7Q9553356474;
	Tue, 13 Jan 2026 01:54:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=XCrpKLr/opr74zGrFsxWl7wlV
	ZwhFXgy8i7+jFHphfA=; b=eh8x9SRE8+geYSwP+gUGktoHxwf2nqrNNDR4tKv5r
	bLM+7TahfYhE1EzSp2pocS1rIuA+l1Th/2SF0MRzNiqPjsntbjfwtogjODrT2R9g
	hb3Qbc2ZdV0fLFI/rxQ0i8pXE3Mh2qE2MWse2X/aoVJuS3Ear0D08nNzpGkTUjm5
	8Hpp8Ml3S4yOnqBbkIz/U8pp1UfrsGpUFUInk22ScL/QkCeO32Vwm8cE8oRN6NWi
	8uiRmoSYgk5DksXcVrMQ7/+zbLhEnF6Rds07KJav1LSMS1KJjLFxM9FFj/oDuo2M
	bIzsa1VB9A8bwRoKtrUOmlae3R+XGDmY6EdHtj1hSlKFA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bnd2g8rx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 01:54:33 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 13 Jan 2026 01:54:47 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 13 Jan 2026 01:54:47 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 3AF853F7096;
	Tue, 13 Jan 2026 01:54:30 -0800 (PST)
Date: Tue, 13 Jan 2026 15:24:30 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [net-next,v3,11/13] octeontx2-pf: cn20k: Add TC rules support
Message-ID: <aWYWVk8sQ1Ei-_x7@rkannoth-OptiPlex-7090>
References: <20260109054828.1822307-12-rkannoth@marvell.com>
 <20260110225936.3900883-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260110225936.3900883-1-kuba@kernel.org>
X-Proofpoint-ORIG-GUID: OhnZq4vePBRv8gFIr_GX2aNWbwaJAG-O
X-Authority-Analysis: v=2.4 cv=OvlCCi/t c=1 sm=1 tr=0 ts=69661659 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=PeFcFcbbUv2b5H-gWLgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: OhnZq4vePBRv8gFIr_GX2aNWbwaJAG-O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA4MiBTYWx0ZWRfX7LZXFxc5pjx9
 MVVLfxcb91EhL+Mc2G6nWDErGKgEyx4otfvN0bYBlnOlmRq3/TlEDiAxmZBBjZ+l7kK/fwGfUII
 PNMjHZtV4g0UX/omXKda7ARUltGC3TJZtdX+FbgfzdfdYvr+p8yHQAoh9f3uL/h9MllGdyZO1hF
 8iTP+g+q6vMBTSwd5bp6vtM1K9vUziSU5yNbeMw3Wi1rE/yWbanxYJYG2CyT9pTxINdvhqcLXRx
 QoqdVnZESgxmVgdu5qPH4lof4jxBYaPrkhCy3AIRGe60nKYErtLPywzuF2lZaPPUPwOzSNpDoK5
 UbCPi9vecqWHgF+dA7R7R0P0fpm8iExIJ1rh6Qrcj4/xRfd+CbYYWUh6L3ijrghNjvdi7nv/YMn
 rxnAwS4MCjXyfJXB+r9UBAJor+LN9HQj1AqQIK8F7O8Nia9S4VX5pwjUmJBfsh94PL/a/2npNYl
 xzKWUIJvFxo8O7gIDSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01

On 2026-01-11 at 04:29:36, Jakub Kicinski (kuba@kernel.org) wrote:
> > +		entry = node->entry;
> > +		goto free_mcam_entry;
> > +	}
>
> [ ... ]
>
> > +free_mcam_entry:
> > +	if (cn20k_tc_free_mcam_entry(nic, entry))
> > +		netdev_err(nic->netdev, "Freeing entry %d to AF failed\n",
> > +			   first->entry);
>                            ^^^^^^^^^^^^
>
> Should this error message print 'entry' instead of 'first->entry'? When
> the code takes the "not shiftable" path, it sets entry = node->entry and
> jumps to free_mcam_entry. At that point, first->entry may be different
> from the entry value that was actually passed to cn20k_tc_free_mcam_entry().
>
ACK
> > +}

