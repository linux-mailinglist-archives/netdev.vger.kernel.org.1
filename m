Return-Path: <netdev+bounces-192646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A49D9AC0A57
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1CB1885DCD
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 11:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD428289349;
	Thu, 22 May 2025 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="L3RFVWSn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B0C17BB6;
	Thu, 22 May 2025 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747912303; cv=none; b=jIy5Xj9s7upNT5hTH7oFRHvoxZLPvWysGlg6x0b5cVcM97ReQ7LN7b6J13ASfcQDzysaeQLX3nqV0v4vXoyIaXN+/icVHAOUuOnHt3nMIvHJpN2rVxOl6AGGIFnB2T4A3A63VTU9VqsMIyGFCVgpFZJ1cSEorHKe0MDOw3PMmls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747912303; c=relaxed/simple;
	bh=USl4YUVkSxfb7TfRutGSKttDMNWN/XNiBVJUodRetOc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfeundFXype6CMegzp+Wq3OVO6Ib+bdqXVvZQqOsnaxY/uGusqR4DLkHjOz0ICnU/PAfh+D12kJa5MQtrAqmaDtNTemFSguN4P8DvDLr0KTgxBdm1Yro5P+sxJ9h4vIFSrZCRZlpQMKXwU086FjXghRfHeUArmrI+mUQXL+JwDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=L3RFVWSn; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LM67l6010041;
	Thu, 22 May 2025 04:11:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=7RUf8XA3/mKUg3y1MmIWqtItv
	jOGVG+m/4ggFiuOdAs=; b=L3RFVWSn+PGJFwbUDl8o4mVMxI+3YPWFHBD8UIDTN
	hskFRKuTYRYRsaNTQr6gu2sk30bOKxWRovXHWUjTX5BSVwjmJVeRZU60DIAuyM0+
	DM8ERC9EBffEruW6x/PGC/ig1kZGRAryM4SS7DkoDeH5T5gwRPW/7G3YoMbDgkUl
	MQUcuLJtbSF2gn/n577iCVWtgLQ+webWfYZL8Dc+AL5Yj4rf763yNbd+i/ijC+H0
	OWUzfXA9U8+chrlQc0/6SSQnJTp5K7uyfcdWrKiyljocmFwLTX7OEnU5TZ83DvVX
	eOZEy0q8dPGn1b3s1gad6zmng/UB7CpvnDh2QYtIPTEaw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46sqap99bb-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 04:11:32 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 22 May 2025 04:11:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 22 May 2025 04:11:26 -0700
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id 08EBA3F7085;
	Thu, 22 May 2025 04:11:21 -0700 (PDT)
Date: Thu, 22 May 2025 16:41:20 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya
	<gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>,
        Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [net-next] octeontx2-pf: ethtool: Display "Autoneg" and "Port"
 fields
Message-ID: <aC8GWDelB9YwOKIz@test-OptiPlex-Tower-Plus-7010>
References: <20250519112333.1044645-1-hkelam@marvell.com>
 <20250520165019.6d075176@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250520165019.6d075176@kernel.org>
X-Proofpoint-GUID: NNbiD_89UzvgdfwUFqFFQ7RyTwLTr-TP
X-Authority-Analysis: v=2.4 cv=HfgUTjE8 c=1 sm=1 tr=0 ts=682f0664 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=i3f_dDYzph6c6JWobKwA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-ORIG-GUID: NNbiD_89UzvgdfwUFqFFQ7RyTwLTr-TP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDExMyBTYWx0ZWRfX5wRxiW88lpKY r6yqAPf6P3IhrzGrEYmFZ5c8Az7twndLJgfZ+z7t0J/Xawb4iVevdK4+ZeWMho5mzHjXJR4PFkk aNWC6MSeYdL0VV4DG9iUbJ7baUV6b+3irnHWLhP4FbnGYCPEJuiZSYCZXAJ6PN6Ob71RyJmdhaX
 HnSyf3F23vQGdAn84WV1rd4SBaAuQcrZ2cKds/MW2byMHRDcNAooZSmSxDmL07tKVpWOwFfeS8A FUn2NjRedNVkwX7rBQeQd1QJ09rAz/BqRI4Jk3B4PntpwaQwpyfAUaU/qJii4T1XbL6qmIEAejt hlOyC/7LS9mTeK2YbMa3kinJrsnygUQkfTKSs1cw01+qa+oFN2rR2eS/CF4cQirEamBQ3eGUCmP
 QIE7Rr3Gw64pUpDNUR89UlwdapiqUfuLvdsyvgJu1Ag4icu/4cYBtpjacAOR/XR6nqDuhsMS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_06,2025-05-22_01,2025-03-28_01

On 2025-05-21 at 05:20:19, Jakub Kicinski (kuba@kernel.org) wrote:
> On Mon, 19 May 2025 16:53:33 +0530 Hariprasad Kelam wrote:
> > The Octeontx2/CN10k netdev drivers access a shared firmware structure
> > to obtain link configuration details, such as supported and advertised
> > link modes.
> > 
> > This patch updates the shared firmware data to include additional
> > fields like 'Autonegotiation' and 'Port type'.
> > 
> > example output:
> >   ethtool ethx
> > 	 Advertised auto-negotiation: Yes
> > 	 Port: Twisted Pair
> 
> Can you add the real output without trimming please?
  Ack
> 
> > +	cmd->base.port = rsp->fwdata.port;
> 
> Do you validate somewhere this value is within the legitimate values
> from kernel uAPI?
  No, missed adding validation.
  Will address this in next version.

