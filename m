Return-Path: <netdev+bounces-247298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E07CF69AC
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 04:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B88013032ADA
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 03:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2A6224B0E;
	Tue,  6 Jan 2026 03:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="QTIwu4td"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E13E21A92F;
	Tue,  6 Jan 2026 03:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767670205; cv=none; b=S3xV2q6Bxa/1RsDUxq5yz9FyDN1+B4WXVw3pYYHSbXwvunIU0jshiKRlqgG3NLtC9BgPEvef2Z8hOTpnaWjfxFiTbJWBGWApMewZNodC5lfqeEzNndiid2+B7vTB0iwkR5YOhoDAhw7dv9oQs+pK/PNqg+KYcR5KsPqLpwd7I+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767670205; c=relaxed/simple;
	bh=mcqEZLkm1zziNTYUAUA0u0gIUgqSSJeu3AE0E6byWyY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiY1W97QBHsTk9tpZR1PW0rBgiPXxIihoXlKmUgXvkQJGk/rmT4ch5jhNrQz52wf+w238hT2RdcTr+r7z82BXGiEuhJ+u8J7y96Fohazxij3v0ESeZxYChvA8fDjmq1r5+OKny/x7pTssvjw7ijTZW84Rme2/YKWj4hJk0oQRK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=QTIwu4td; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 605HFNMF2644729;
	Mon, 5 Jan 2026 19:29:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=DdXyGBk4W/P0U61HWCND4ME0x
	zqPVrj6nw6Roezba2Y=; b=QTIwu4tdvhws2pLO7wjAT1IfzTeeQk+8MymtliHG+
	W2gYQoFBrShf5JhgKEH2rueH0bkFRmDuep2BH1GBK5U9WvipmQxtQE2/82+XRcW2
	9ID3OgAdhMWL8mfxryYaSmvlwwSNOdHVR5cszhhmvYXFzr1KTNYqW4RTubLqFF1a
	6khi6e+cSSv4uQsFDRcLG/6UNTRZOSefdN39+/OwC1f8TGM2SKSN9kHItFlfYf3C
	6e05zoBCRT2vQL6oErqegol6U4Uf3BDZcHUd1ElKfhKY3mIOjgbKKggcKHkoKd0S
	Lby2iERItw2VERKuvf3aX0zrYbezP/y+0zdV/2jTl3rZA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bfr8bkbfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 19:29:43 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 5 Jan 2026 19:29:56 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 5 Jan 2026 19:29:56 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 745C43F70BE;
	Mon,  5 Jan 2026 19:29:39 -0800 (PST)
Date: Tue, 6 Jan 2026 08:59:38 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <sumang@marvell.com>
Subject: Re: [PATCH net-next 01/13] octeontx2-af: npc: cn20k: Index management
Message-ID: <aVyBoil8Yajd6v7e@rkannoth-OptiPlex-7090>
References: <20260105023254.1426488-1-rkannoth@marvell.com>
 <20260105023254.1426488-2-rkannoth@marvell.com>
 <f247416a-c774-4e32-86f0-9a3c22342f1f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f247416a-c774-4e32-86f0-9a3c22342f1f@lunn.ch>
X-Proofpoint-ORIG-GUID: 7dPdcEvedyg23eOCODFlz2DLvj-ORvhF
X-Proofpoint-GUID: 7dPdcEvedyg23eOCODFlz2DLvj-ORvhF
X-Authority-Analysis: v=2.4 cv=P/I3RyAu c=1 sm=1 tr=0 ts=695c81a7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=rBmsBfZRctnWfMS7jW0A:9 a=CjuIK1q_8ugA:10 a=quENcT-jsP8hFS3YNsuE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAyOCBTYWx0ZWRfX0NbAVB8jqfAw
 bGRmUj4bSjZ/idiyR+3pH6sqM3i3t4w9wWCnbfHvOu4Qr0Y/2McvY1mXBildtbUAtEUBR1SxR7c
 pg9t9CA+LmKmowKfk6u+sR3bi6H6G6lS3VSSD4MrHG67Bk4Rs7WgU50CkX5RHOIjuVGw8tVZiw1
 nWYgxia8pwwdudvwF96B3TjFg1dYpUWLCTbKOivu1ACoxzDi17fLU5GxemJ2kMKRE2D01LEe7a9
 uqLE7m2oj44fjb5oy7dydYAf+/WKmIpISyg3d8RqvGTCqc8EZAsJXSAiHoauYtuPMP6oF0PFHoy
 hxlJYM/QifZXE9AUib9PyIfgwA75UqLvisfuIvQsrINKOmwZgT0nc2lvg8U3T3rDTiJa12eco0q
 44jH+CfE+PbUC7LVYTWmvvtyHYCSttkWCmgbl+/EdL7IATlz+NXhFbWJxdgq7McB37A/SSznALQ
 jbd1FubzrnSCqiUShoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01

On 2026-01-05 at 20:45:12, Andrew Lunn (andrew@lunn.ch) wrote:
> > +static void npc_subbank_srch_order_dbgfs_usage(void)
> > +{
> > +	pr_err("Usage: echo \"[0]=[8],[1]=7,[2]=30,...[31]=0\" > <debugfs>/subbank_srch_order\n");
>
> Isn't checkpatch giving you warnings about pr_err(). It wants you to
> use something like netdev_err()? This is a network driver, so you
> should have a netdev structure.
>
>        Andrew
There was no warning reported by checkpatch. NPC is a global TCAM resource.
This debugfs interface sets the order in which the subbanks (there are 32
subbanks in the NPC) are searched for a free slot. Would you prefer that I
create a dummy netdevice and pass it to this function?

