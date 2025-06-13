Return-Path: <netdev+bounces-197387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2CBAD877D
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68B418869E4
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 09:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197E4256C73;
	Fri, 13 Jun 2025 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="lMifu4a6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747322DA753;
	Fri, 13 Jun 2025 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749806209; cv=none; b=V4bU+qs+PBt5o4FxiEpzSk9oW83ywpDaLqj01e1Rg3/GVjW3K/8YQeL3qCCqfQ6hdieD6/rI+PEk6PiGSghRKavx08OmOxKvhIneTmLpgqhvemkexWe3YxpTTsfeRnN5kpsskxHbpIGLdJwadXMLX8wOE9EJEe2oANJKZteH/KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749806209; c=relaxed/simple;
	bh=JvXRxWo86OXDBk2ZyHGvr7t32N/IGnu9bOmgh+9I2HE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kv7//7NVfHNxgBiMsTdUPU99DoRA0Zt/aQTO3Ifb94+eD0qmFnW1kPUTW2RuRu8Cs9eIBxsCVAkyeCxcM3GUaN5CP8IAGjSTlrDeXF4iGrRcjlxydxWc2Qooq9jSpzWmbZS8/BR9kds2x9TTlZUQHcVdS6Oq78AGhf//1+ay7Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=lMifu4a6; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55D8IOEk002141;
	Fri, 13 Jun 2025 02:16:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=G5KoRAnZUPZZQGP0oxC9d6JUk
	CUEKSK8pPBaJhC/9yA=; b=lMifu4a6QraFdztb7W57zpDyAvrttgxaecBBXc5qh
	PDeDg7729rjVlG/BmmUiaKsCUT92oTk9YFjl/4PgJRzjLLWdDvv4o4zMcjnwul3q
	M17NEHEEJ/YQb1ZigcZYR8gib0hO/nV+B1YIcQ0UwXt0RSO7NALZx0g2/hP7Fxrm
	hHhL4ugSdbQgyF69IeRd7G/QczxVcSDj32d5s5oDFJS357tTQfFVbbfNUok+qP5L
	tv+XIlQSSTzYKrcFDD8By4rHSZqBXYT6I4MCcJOshEznwHV0KGxA5P6diC3poXh8
	hreX31TmFp1w+pi097O0tj7ZeAT3j94Jm1Az+REijMz+g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 478gbt83xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 02:16:30 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 13 Jun 2025 02:16:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 13 Jun 2025 02:16:29 -0700
Received: from b9e1f7b84bd3 (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id BD9E25B6926;
	Fri, 13 Jun 2025 02:16:27 -0700 (PDT)
Date: Fri, 13 Jun 2025 09:16:25 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Jun Miao <jun.miao@intel.com>, <oneukum@suse.com>,
        <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] net: usb: Convert tasklet API to new bottom half
 workqueue mechanism
Message-ID: <aEvsaUrhXgFzvtzZ@b9e1f7b84bd3>
References: <20250610145403.2289375-1-jun.miao@intel.com>
 <20250612185131.2dc7218a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250612185131.2dc7218a@kernel.org>
X-Authority-Analysis: v=2.4 cv=X9tSKHTe c=1 sm=1 tr=0 ts=684bec6e cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=07d9gI8wAAAA:8 a=VwQbUJbxAAAA:8 a=5NWDvjWUo4JBtSxIGnEA:9 a=CjuIK1q_8ugA:10
 a=e2CUPOnPG4QKp8I52DXD:22 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-ORIG-GUID: LWkoPQ7xeq6PzxOuIVZ-dsBOhUfy6FQF
X-Proofpoint-GUID: LWkoPQ7xeq6PzxOuIVZ-dsBOhUfy6FQF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDA2OCBTYWx0ZWRfX9O52cA8d0gLt jwI6NM+BEHy2GNmUzRtWzASRP4pA7qZtBOaX3CdwuP+UT+zfjoZZWppD5MJmXYeufY2UbhHonT8 4gj+OdqvjLMNiiXyILwZelgYC2vjI+FrmlvCxP0nS/F2J5Z0yxDcKpoEG3PdmvGJeOHLvIUraZS
 I1OJRQ/C/dQyRrOe14oQLf7/NgNFhqgPIpOj+dIMIYc8Cdt6RRVH7y5GbKIrVw+YL16ZZJ9cLpf dRNdwirfAWgWG37VBgDHV48PnHWu1AMGqxkUdsn6WPa2j1834VrEQaFu8sj+xOJQpAhEeTsz8/6 sGXET778dtuXsX0136LIjmRQmt2FVsa43S9E1e8uVOPS0T8UNtFRxe7iWUzu55KyNi/Yb2VSt/w
 jykZc2Gj2xfyW+CXf97O7J0vOSsllHjyu928TtK+4jYIj5W+Cn4XGpN8H+xL7s9QraxpAwhQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01

On 2025-06-13 at 01:51:31, Jakub Kicinski (kuba@kernel.org) wrote:
> On Tue, 10 Jun 2025 22:54:03 +0800 Jun Miao wrote:
> > -			if (rx_alloc_submit(dev, GFP_ATOMIC) == -ENOLINK)
> > +			if (rx_alloc_submit(dev, GFP_NOIO) == -ENOLINK)
> 
> Sorry, I think Subbaraya mislead you. v1 was fine.
> If we want to change the flags (which Im not sure is correct) it should
> be a separate commit. Could you repost v1? There is no need to attribute
Yeah hence asked to correct me if wrong.
GFP_ATOMIC has to be there - "this patchset implements BH workqueues
which are like regular workqueues but executes work items in the BH
(softirq) context" from:
https://lwn.net/Articles/960020/

Thanks,
Sundeep
> reviewers with Suggested-by tags. They can send their review tags if
> they so wish.
> -- 
> pw-bot: cr

