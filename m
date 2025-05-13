Return-Path: <netdev+bounces-190014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 615ACAB4E96
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7C9417A758
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 08:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F5920E70E;
	Tue, 13 May 2025 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JB8+Sghq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAC820E318
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747126576; cv=none; b=W8OfVCavXtSP+xjGYCAewckE9Jw6UbRqyzc2XfLXTGqob/NxmMbuvUz9FUgDhx+cr/omX8yKaFXlKaBu44sS9OWgdQhC7pXY2isZVaB3RPUqMuUC8kg3fAHq4xQBzQXSjGQCk6N1dhAS0OkkWYcrBFUB0PcpbZdBItepULy8ni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747126576; c=relaxed/simple;
	bh=VfErKRqIjEIlmRoRdoHsjmyuDN3yiGDJBFL0BSnxYAk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmEYTrj1CCZHebEKxpLsOvK9fher1FvmPeXc+bLyzQURVT0t1AkYvHNQa2QY0lTo0eWhZURo5uU32phZ/TG9TaLUahNiVHa9ZjWcVRXTs6nkFv7djOo0aA8DJWldtF32jPBaJyeU6RskpdRcUz/eGdS337phlhROBHlhwCqJ+Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JB8+Sghq; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CMFDZx006723;
	Tue, 13 May 2025 01:56:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=xcgvpSdcfFr4+j6fR7qbwp/16
	cqAv3qrMgNpEFil97w=; b=JB8+SghqEZYI/UfvsRFIeJjOjatyVd42bI1IYdWu7
	PYIh6mMXv14+v6cj5CLvJMceOuoJW57NXDrM7FnoLOcZDtNsMPvAeoCsHfjmzw3X
	+m6Mr1ipaV2aAwNBK4kwhLc46A7J5HdDbYnuSNwinayHl+ynQRawCmGnGgA3nEIq
	IQdt3I4mvafQKiTEw/hXc5Qi5JoToPY1VJeryavKoFSoPg/p2ZohIWyb9T5KTJVT
	mzF6GqXtC/geuiK+zIHGjadQk3xfPqMzpMKerG36HtFD9lyuybAinMUukbExZZHN
	udoIcnLpqfxpWbupWXlNndpG4Qo8oxKlR+5RCTMTc4XIA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46ksm9h0n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 01:56:04 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 13 May 2025 01:56:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 13 May 2025 01:56:03 -0700
Received: from f65018e88ba3 (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id 1FC7E3F7099;
	Tue, 13 May 2025 01:55:58 -0700 (PDT)
Date: Tue, 13 May 2025 08:55:57 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <bbhushan2@marvell.com>, <jerinj@marvell.com>,
        <netdev@vger.kernel.org>
Subject: Re: [net-next PATCH 3/5] octeontx2: Improve mailbox tracepoints for
 debugging
Message-ID: <aCMJHfYbws-amobR@f65018e88ba3>
References: <1747039315-3372-1-git-send-email-sbhatta@marvell.com>
 <1747039315-3372-5-git-send-email-sbhatta@marvell.com>
 <20250512182544.GW3339421@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250512182544.GW3339421@horms.kernel.org>
X-Authority-Analysis: v=2.4 cv=LYA86ifi c=1 sm=1 tr=0 ts=68230924 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=FuWJbcO6FHvIESCxiDYA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA4NCBTYWx0ZWRfX5ED0byeqbWRh NUb04oUVST9AlJebRECYTjePxLgf5hPddbO/IpxAO/Rm22/Cimzo/fWNPlC3VEv+JDx4r6zDndd 6M9GTZKLja+auflb/MkvdvcvUoHHJxtbO7aIn60jMKI00hTh1CU38T+l/OeLGr0u8WHGuk4uJlI
 TXORjcUMHvZEKI6Knjnci2EY87O8cnDqi/CvxnMGNpACs/Nn0AHgcvj8S0txOmR9jEtA/5rWfXO 2R7ia/Eb1uXsRAtsqRg8FfrLGeowfRVyO+dMCtsF73WinOvz7tcxP7/kFawBO4qtskVljibySQ2 8Jet+1todHhnzjjzfFru89NIDSqrfr7qquYdGMzWDedutCd+GL5NnDoAPos3w5dgKgn/+U6EYDO
 AGEmFLl5uZuZiIi4I76axHzYj0DKwk1DU1wFE+N6Kwv7Y4KdltvST5yPsh4TG87hPmuTaTrJ
X-Proofpoint-GUID: CIv64NzuIJ6J4rkp30GDgvyqJvAf0nDw
X-Proofpoint-ORIG-GUID: CIv64NzuIJ6J4rkp30GDgvyqJvAf0nDw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01

Hi Simon,

On 2025-05-12 at 18:25:44, Simon Horman (horms@kernel.org) wrote:
> On Mon, May 12, 2025 at 02:11:54PM +0530, Subbaraya Sundeep wrote:
> > There are various stages involved when a VF sends a message
> > to AF. Say for a VF to send a message to AF below are the steps:
> > 1. VF sends message to PF
> > 2. PF receives interrupt from VF
> > 3. PF forwards to AF
> > 4. AF processes it and sends response back to PF
> > 5. PF sends back the response to VF.
> > This patch adds pcifunc which represents PF and VF device to the
> > tracepoints otx2_msg_alloc, otx2_msg_send, otx2_msg_process so that
> > it is easier to correlate which device allocated the message, which
> > device forwarded it and which device processed that message.
> > Also add message id in otx2_msg_send tracepoint to check which
> > message is sent at any point of time from a device.
> > 
> > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> The cover letter and other patches in this series are n/4.
> But this is patch 3/5 (there is also a patch 3/4).
> This doesn't seem right.
Yes you are right. Some stale patch in the directory sent by mistake.
Please ignore this. Will send v2.

Thanks,
Sundeep

