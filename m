Return-Path: <netdev+bounces-198907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2325CADE498
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F57A189D9AB
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 07:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CC527F005;
	Wed, 18 Jun 2025 07:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aLX4I420"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4AF2046B3;
	Wed, 18 Jun 2025 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750231749; cv=none; b=KKoykxybxdwtEThOlg9NhPOWY+qkz4gq69ANG0a0To9fl+zM20iFhT3pHdsE3cSVpOq7j47OQ/6aXOigR0bBcCz2hhuNY4IPbTunip5BHvqDXQmzmd4PYqpTBbsV/QVXF1rEWZY58zgGPd2Akw3LrY2UqjRxopkbeF+DpTrOTFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750231749; c=relaxed/simple;
	bh=vbqCH5bqQ1AIc3Vn7Y7IkzuSaS7vImzq2PcScFKzkLM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcNDKt7dkeIE2rBCG9wB2ogqCIx53Pd9RLexXI85fJgvl5PnxX1JiqekcqrL25bYF9c5gRoOe+Qorrwes+N9OsD+pk4WlYVSGCeBwKCRTfZ5zL+rbi09q9yMLBGWnDc3Cy9tJECiH7j2Lk06NiM5rTpU5xxvEOcHfu0DlMHMP9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aLX4I420; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I5Gfm3021060;
	Wed, 18 Jun 2025 00:28:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=j/1ti6TbzFKoUASfVh2csn+pm
	T/Ygcnd7my2w4/SjRY=; b=aLX4I420Gk5oU0f2oJ2UUL0zK6DPiJOqmVhjdCUt7
	kwhg4T3cuic1o3eNOXzO/f0DDe638aUQkBRjA2wukep3KB0wtxDj4Wi4IzBK1iHo
	CYwmaHzOCXwgf+YiA7Djm959cm5bBrkYC/KBUEAQi24wCpHUhakXx2PXniOJOGH3
	On3gEI6FPDoQt2HEJ4nE/sOLVp3gyQKfoftS+T7rSQwyZT5RGqpe0M1nm0OHGOI0
	kxWfFLANNSThYUAdN+9nceBFf2wVv+Uq3K18QYQ9v1im/wzfD6yNEVCD9K265L4p
	6bjXcmbMBnU1BkoZfGNb7FnKU+TaD51MA57yJYlubetgA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47bgt9gxs1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 00:28:51 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Jun 2025 00:28:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 18 Jun 2025 00:28:49 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 1918A3F7043;
	Wed, 18 Jun 2025 00:28:46 -0700 (PDT)
Date: Wed, 18 Jun 2025 12:58:45 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Mina Almasry <almasrymina@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linyunsheng@huawei.com>
Subject: Re: [RFC]Page pool buffers stuck in App's socket queue
Message-ID: <20250618072845.GB824830@maili.marvell.com>
References: <20250616080530.GA279797@maili.marvell.com>
 <CAHS8izN6M3Rkm_woO9kiqPfHxb6g+=gNo7NEjQBZdA4d+rPPnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHS8izN6M3Rkm_woO9kiqPfHxb6g+=gNo7NEjQBZdA4d+rPPnQ@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=IrYecK/g c=1 sm=1 tr=0 ts=68526ab3 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=1XWaLZrsAAAA:8 a=LbbWhBTsJFo73-GiDgsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: MojllMER0MWFaBD6ieN4vKsoXe28a3O-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA2MyBTYWx0ZWRfX/JOIEACFYP1L ojSEd6/Vut5H2J7xPih6MS2HeL5Z1vurqzlJZi8Too7zAGfLW7sxnZiEKRFjZELYNfSHhXMhdCz uVu039ZwvToZXSYyTwuhxKmoaOi5tFWa2Y2yGxWV9oROezJ1iwVpBaYEeBIAvoyB/14V7Np6LgH
 UeDDR5kx5IjfAV3u7hRVQnzTD7HJ3dZ4J8emoJWz9CwytsUKnB2wiNXMNfi4W0s9mIc/v0yhpxF Xw5ReNjPpQsGOtyicQGuTiyIrWI9Gbr0Tj7ZpWU64iE3j3IW8+arfOKgsQJjHFtHsh+LmfVleUa ZLtdJHo/rF6tGW9i1gB+tFYkSOOYjT4wcIR6JTjmApoZ8Amq0ngl0PnQ4Xbjvl7qLeVg1AYyGVl
 P3hYLCQwgGROUYXscXcM1FUmxsUG2a8VrjQ2yc21BW4zpfS0p0iUNtvBMIqBWroGVbWxtKtz
X-Proofpoint-ORIG-GUID: MojllMER0MWFaBD6ieN4vKsoXe28a3O-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_02,2025-06-13_01,2025-03-28_01

On 2025-06-18 at 02:30:04, Mina Almasry (almasrymina@google.com) wrote:
> >
> > Those packets will never gets processed. And if customer does a interface down/up, page pool
> > warnings will be shown in the console.
> >
>
> Right, I have a few recommendations here:
>
> 1. Check that commit be0096676e23 ("net: page_pool: mute the periodic
> warning for visible page pools") is in your kernel. That mutes
> warnings for visible page_pools.

Thanks. netdevice is not gettting unregistered in octeontx2 driver while interface
is brought down; but page pool is destroyed.

>
> 2. Fix the application to not leave behind these RAW6 socket data.
> Either processing the data incoming in the socket or closing the
> socket itself would be sufficient.

Customer is using opensource ping (from iptutils). They run a
ping to an ipv4 address (ping 192.x.x.x -A &). Here the app opens both
RAW4 and RAW6 sockets. IPv6 router advertisement messages from the network
lands up in this RAW6 socket qeueue. And ping App never dequeue from this RAW6
socket queue. They want to avoid killing and starting the ping APP.
Customer creates  RAW6 socket with other Apps also (third party) and page pool
issues pops up there as well.  Ping App reproduction steps are shared to us;
so quoting the same.

>
> > Customer was asking us for a mechanism to drain these sockets, as they dont want to kill their Apps.
> > The proposal is to have debugfs which shows "pid  last_processed_skb_time  number_of_packets  socket_fd/inode_number"
> > for each raw6/raw4 sockets created in the system. and
> > any write to the debugfs (any specific command) will drain the socket.
> >
> > 1. Could you please comment on the proposal ?
>
> Oh boy. I don't think this would fly at all. The userspace simply
> closing the RAW6 socket would 'fix' the issue, unless I'm missing
> something.
>
> Having a roundabout debugfs entry that does the same thing that
> `close(socket_fd);` would do is going to be a very hard sell upstream.

>
> I think we could also mute the page_pool warning or make it less
> visible. The kernel usually doesn't warn when the userspace is leaking
> data.
>
> We could also do what Yunsheng suggests and actually disconnect the
> pages from the page_pool and let the page_pool clean up, but that may
> be a complicated change.
>
> Honsetly there are a lot of better solutions here than this debugfs file.
Thanks a lot !. Could you suggest some solutions. I will try to work on those.

>
> --
> Thanks,
> Mina

