Return-Path: <netdev+bounces-198485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC802ADC52B
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 10:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A433ABC20
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 08:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737DD28FA93;
	Tue, 17 Jun 2025 08:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DLGs21Sl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D47D2AD0D;
	Tue, 17 Jun 2025 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750149543; cv=none; b=XRTbW2RtT9K9lHKJ693c6VjDox0vTmG4K8XejmFKLjydS4Qo/oW6YZZrb9/X98ppWpHddsyYFRtRK3pZulMsXyEPNVExRYyQd0CAnBieqjirJUux2GowEnBYRUMtZMkUSEScETqqlijr6lB+62BfOcTg13AMr0pEqz0FrTMbYvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750149543; c=relaxed/simple;
	bh=5GKY5sBiJ94ezFHEaUbp9RYLPqQWJyB8UuP3zBIcjmA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuFq9uzWDsOru23xD9Sz5BbhzFS8i03vo/V0rdIOkuVEsndn4bt3Dc9qtOXfno/C47xqKaJ/oH8g5I0sW07XxqcbkPyPzr855G4VCZIrqnzSu99YiP/A2AmXviit6FSteXANEslsRE+Isj+CipZryx+XHbFzjAIAaV7KrZL7P5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DLGs21Sl; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GNXt1Z031548;
	Tue, 17 Jun 2025 01:38:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=VvrxOl46dE2voqkeT8SgCprbB
	EdBQIVHPEh8DeXm5R8=; b=DLGs21Sl5b1A7abkc9baWXGISU2Nx1YUrlJPNxldO
	nUzt5TRdbZx6cdI09wr+lgsqGD+mh4BLbhm9maPhMqwGdxnvORDB3KDs1DkUpfv/
	AkKFqC2Sy58nri58+T0h27k9BDc6DhGFmD931m6t7zVtajJ1bfw4jj1x2q68VmzO
	t1hWHAvB3EV+281mLX2mwh7OOQnRRnoQwP46n73pBKil3cWQ6Pq8ShvTCqz5U4eC
	h++BecrtSw/aW0wVSu6Yo7Of578Xc0cjXH82fTTcFsCwgmfXw2ytzo9Mm2AcJ9iA
	zj0U2oEolL8FhXDj3ovbsj7E88mVx/Upy5SGqKctWhfWw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47aw21rxve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 01:38:47 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 17 Jun 2025 01:38:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 17 Jun 2025 01:38:46 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 1531B62676C;
	Tue, 17 Jun 2025 01:38:42 -0700 (PDT)
Date: Tue, 17 Jun 2025 14:08:42 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
Subject: Re: [RFC]Page pool buffers stuck in App's socket queue
Message-ID: <20250617083842.GA417272@maili.marvell.com>
References: <20250616080530.GA279797@maili.marvell.com>
 <d152d5fa-e846-48ba-96f4-77493996d099@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d152d5fa-e846-48ba-96f4-77493996d099@huawei.com>
X-Proofpoint-GUID: 6qlfk6nOuYiMn8ZaBITEqb46CkTMp0sO
X-Proofpoint-ORIG-GUID: 6qlfk6nOuYiMn8ZaBITEqb46CkTMp0sO
X-Authority-Analysis: v=2.4 cv=DfMXqutW c=1 sm=1 tr=0 ts=68512997 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=20KFwNOVAAAA:8 a=e0OHxoh_bsvbLNUbZbIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA2OSBTYWx0ZWRfX5/MUD9U/15we xiisDhPnUSQCh/IM5jkA13xCES8zgijUEGjVc0UxCdnAQFNCE5w1jLWi6stfL/ySPu/7SG5JQkv NU9Fl2KrW6bPjIWXFtteOvDrm0LcBOpz16i1MoGudC1I0ABrysiwUQPGHNTb1bQSYuEKuTFmZHn
 VfesEr1xjDQw8MmdhKxq+1xqlRrPi9K6S0X8hCMsUCWMJ5gCZi2iExT3IsaIKPNr8byUiliKeyt Ufh+Wr4zeH95w1reSTGRgTdFhfje6k2GRL8QsF1O+ZJ3qFAMFi+Px0YKprjEHpUmwBC8jZuNs9U 1Ywkz0PwCHT+NXaHNQ5ica+BzDz/YPdmKOfGFtA3/XSwJeKWRb2SFTRbLe8vIAT4Geo6ofzCQ6p
 OKIxs/xX99puzZ56OtktSnaNBA8aHwp5AjJsRnZ/55kbYVm/3CG300Wc/E1Y6LtaTByQ/JYM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_03,2025-06-13_01,2025-03-28_01

On 2025-06-17 at 12:03:41, Yunsheng Lin (linyunsheng@huawei.com) wrote:
> > Customer was asking us for a mechanism to drain these sockets, as they dont want to kill their Apps.
> > The proposal is to have debugfs which shows "pid  last_processed_skb_time  number_of_packets  socket_fd/inode_number"
> > for each raw6/raw4 sockets created in the system. and
> > any write to the debugfs (any specific command) will drain the socket.
> >
> > 1. Could you please comment on the proposal ?
>
> I would say the above is kind of working around the problem.
> It would be good to fix the Apps or fix the page_pool.
>
> > 2. Could you suggest a better way ?
>
> For fixing the page_pool part, I would be suggesting to keep track
> of all the inflight pages and detach those pages from page_pool when
> page_pool_destroy() is called, the tracking part was [1], unfortunately
> the maintainers seemed to choose an easy way instead of a long term
> direction, see [2].
>
> 1. https://lore.kernel.org/all/20250307092356.638242-1-linyunsheng@huawei.com/
> 2. https://lore.kernel.org/all/20250409-page-pool-track-dma-v9-0-6a9ef2e0cba8@redhat.com/

i think, both issues are different. Above links, fixes late DMA unmap issue. In my case,
buffers do not return at all. So some entity should purge those socket queues which are not getting
processed. App modification would be difficult as customer may use opensource Apps/third party apps.

Buffers are stuck in socket queue. And we need to free them. Page pool infra tracking socket queue and
process information would be an over kill ? And packets in socket queue of a process, being freed from page pool wont
work well. (That app could be killed later, causing skbs to be freed. or we dont know whether App processing socket queue
is slow).

I was thinking of extending /proc/net/raw and /proc/net/raw6 OR creating similar proc entries; which
can show "pid and timestamp of first skb in the queue" etc. And a .proc_write() function to purge a
specifc socket queue. Using these, customer can decide which queue is stuck and purge manualy (thru some script) after
netdevice down/up.

