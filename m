Return-Path: <netdev+bounces-190797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10881AB8DDD
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 19:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03E317B77EC
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 17:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CD225A2A2;
	Thu, 15 May 2025 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LdZfCX71"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26499258CD8
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747330494; cv=none; b=Leri4dlkZ7VG21JFnkonDXYh/4litLaorGjf2Wy5C+ALrInYEn0IBPUFqlmKAcAwwUqk6826a4AbGrIb+Pm5xcb7aGNfOzIv+VgdUrWrLQVTtBKZvjdPKys14mIaFei1lTLT9LUYLvDUt9ukxbKtrHth1oaLRwuXzjyIpYIUKkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747330494; c=relaxed/simple;
	bh=HBxY2xh1Nuu2W9TNTlFRs10QyXgUdE59VBculFwZRdM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzqCVkTrLTfbNv361goz94rQ1qFrGrotFJIX7VwkpIpMOd5r1G8GCoSfgKFnzFtUlRkewMuUh48NMmyxsWlqwMC0FGX6hZQyfWcfua8Yx14HERjVPdROI+K3aodFOjBUQ7eMfLFTfGf1FxrYGcpow0/q6c5WjihKFTN53dvXh0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LdZfCX71; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEiONH006623;
	Thu, 15 May 2025 10:34:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=m20l4bF0rt992v2Wr4QhYQVJq
	deG+NrqNFKB+LCsaws=; b=LdZfCX71F14X0FD2hdJN4nRuOJsc9kSHYnLIsoIyY
	VSolyvt4bM8KBjPIFJgSiPhpQoXeN3NH378OgLH1bkp0f+MTd6wX8A4oq8nZXre1
	alH/wuyj17dPkXszWqe+YbrVmxM9H/dM1RLt7HPiIgn2AKvuAGMZAp7fEE5fIis8
	5Jlrl7uNWqhVNGcDG+nz8RgybVsr6hfWYmxCYgDKeX9OZO65UL1wpbhZoZZMXy40
	UyxdeqPTmWBus7Yu7VVLYC5qiAl1ZVFT8niaxeqjBYL6BSSX1hH/CANLHuOjqz4S
	npoqzjNzw/7BRTzoUNsXZ4D/fBnNhHTCgSJGz2u9fX0Lg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46nj9y0etq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 10:34:43 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 15 May 2025 10:34:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 15 May 2025 10:34:32 -0700
Received: from 3958e7e617f8 (unknown [10.28.168.138])
	by maili.marvell.com (Postfix) with SMTP id 5B7223F7044;
	Thu, 15 May 2025 10:34:28 -0700 (PDT)
Date: Thu, 15 May 2025 17:34:26 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <horms@kernel.org>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <bbhushan2@marvell.com>, <jerinj@marvell.com>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH net v2] octeontx2-af: Send Link events one by one
Message-ID: <aCYlosmI-28w80PJ@3958e7e617f8>
References: <1747204108-1326-1-git-send-email-sbhatta@marvell.com>
 <20250515071239.1fe4e69a@kernel.org>
 <aCYZLg2IohEbhMYY@3958e7e617f8>
 <20250515101937.72ae5ef9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250515101937.72ae5ef9@kernel.org>
X-Proofpoint-ORIG-GUID: G_VbYWnDKGxlh0YGg9Xn8jHXW-3KyqRm
X-Proofpoint-GUID: G_VbYWnDKGxlh0YGg9Xn8jHXW-3KyqRm
X-Authority-Analysis: v=2.4 cv=Tq3mhCXh c=1 sm=1 tr=0 ts=682625b3 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=TJ6JTI3gxowDfyHAyiYA:9 a=CjuIK1q_8ugA:10
 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE3NCBTYWx0ZWRfX/2ejC9x++2Xi QUcjWph8pUZfVGbAEJJ0t8kwgt17yg+39orly29aj0BjR9wx7kh5+lE2KgnPZhSPSmSGi93j46F zTy7Y9HbZ+TDCapcUYogox964zW2WmBCKPcRPWyPsVzF1nCIItD36JHenTZeGOjvgK4QS+WZY8T
 FzU+wnx7CtlMEk35MiBD4p646Dg2NJaFB1fIak91jjwGEdUNFj59Pypn3nQOg/qMnrVKruIGJjC arK2j76rJ/fGNk9PVbt0+i4fBjHkccT3ZtLJm88ud7TdK6zCj6m2BLSiST3thHF8EuXvbDYCIhy NA4R3lvVL0un0HWfX3IQbMVxcSOL9dcXtqKuiapdJiMzz919+dGitJ151lKPtNseHxGagRq98mI
 XTVsEIVgH0pj4hjiWKmGHuFpfhr6fA58EJ/PmKbEGGaQwprlcU8k7rMQHHk5fZ8qke4et9dV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01

On 2025-05-15 at 17:19:37, Jakub Kicinski (kuba@kernel.org) wrote:
> On Thu, 15 May 2025 16:41:18 +0000 Subbaraya Sundeep wrote:
> > On 2025-05-15 at 14:12:39, Jakub Kicinski (kuba@kernel.org) wrote:
> > > On Wed, 14 May 2025 11:58:28 +0530 Subbaraya Sundeep wrote:  
> > > > Send link events one after another otherwise new message
> > > > is overwriting the message which is being processed by PF.  
> > > 
> > > Please respond to reviewers in a timely fashion.  
> > 
> > Just want to know is it you or bot?
> 
> Have you seen me reply with the same text to someone else?
> Oh, that's right, you don't read the list, how would you know..
> 
:)
> > What is the time limit here?
> > Have to respond within 24hr?
> 
> The review cadence on netdev is 24h.
Got it this patch missed your recent pull request because of my
delay in response.

Thanks,
Sundeep

