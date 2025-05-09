Return-Path: <netdev+bounces-189135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE420AB094D
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 06:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216BA1C2019B
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 04:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955E62550D4;
	Fri,  9 May 2025 04:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="RJdDgwkN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0936623D2A1
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 04:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746765760; cv=none; b=gz0oh/Q4LwzIdbGFzo0EjP/SesGhsSowDlekffiGWGKNGGvMPkk0A9Zf7+cwyus9f0ZJOc4tDX5+Np68jdkdrvm4XINmgib2ezVpGsPzBndUWJUTagmQxXDV8RYMPN8T+byTOzRFeNrHTgUsgq96XzuvKioVY2QIQA2a1xZKxEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746765760; c=relaxed/simple;
	bh=9rI54/A5WiIri5pD4+GamCeOQKkHas/dwlZaZCKfoKA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5CWV7IV/Lj/rkyjTgSoN9uiGaylQ4vNnnJV6C1zz5e+AGdTYun2jE6nKzQZqfutIYM45xvqBMHYymBsSFVLkzZQBCdr8AJvbhKa0IWGZWjOmoL3ixq5Kzb0mPw0TyeA4NPmIKh986aGJjUWm5faLXLoyB/wrW708rD301ubXRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=RJdDgwkN; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548NIuDw004077;
	Thu, 8 May 2025 21:42:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=0bhCGcy80eEnGrnDrk3+mxIsF
	oRYIeqUD5h45KgW1kU=; b=RJdDgwkNGuav3DQxtt3dZUV7wGeaLmpHb/9RBeAWr
	MGos7Jyoq9bmOLo0DYO9ZYTKHq9MozxAagfwdiU9hcAuwh166iMUh3oKxMJCINkv
	FsOa4yTwEYyijg7fYwKT4aed5CgmbVNP6Ezxu9H9Rwh1Jiy5i7MPYoOblM7Bl4Jq
	yuQXejHiCl9VqmAWmVYP2/rJiTXMEyZiSIyJGoRacfW6LDt1Q4SHrnj0XIEBtnBI
	zKjnK1sotbm135yjngzE8NSC1hfDyttiBQ4VrPN8kchnjyxQlBVOyelUy/9oeWh/
	jmqH0iP7XRqFElBf0i04BnS0ZWu+SrhDNUOwH03VJTdEQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46h65x0g9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 21:42:17 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 8 May 2025 21:42:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 8 May 2025 21:42:16 -0700
Received: from ce1afb5360f2 (unknown [10.193.77.153])
	by maili.marvell.com (Postfix) with SMTP id 5F1123F7043;
	Thu,  8 May 2025 21:42:12 -0700 (PDT)
Date: Fri, 9 May 2025 04:42:10 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <sd@queasysnail.net>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH] octeontx2-pf: macsec: Fix incorrect MTU size in TX secy
 policy
Message-ID: <aB2Hoixm3Liupy6m@ce1afb5360f2>
References: <1746638060-10419-1-git-send-email-sbhatta@marvell.com>
 <20250508190003.GP3339421@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250508190003.GP3339421@horms.kernel.org>
X-Authority-Analysis: v=2.4 cv=ZdsdNtVA c=1 sm=1 tr=0 ts=681d87a9 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=SyZdK3nC6_mUR3acqn8A:9 a=CjuIK1q_8ugA:10
 a=ZXulRonScM0A:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA0MiBTYWx0ZWRfX5rx9K62siqob lIDeI/L1Xg3ZgMT+ZjICw11Q91VeaAIqRrIysxqC9cbE5zUohLU0lXG4+3Yl2aOLYp6Au7Nib5N N3SrFkwNoWSy6rq/vYCKHBUDrFTSZx8uVEBqNkBeSQRp2rhYHudmSrlF0q+c87Fx1xLVDu0kGWJ
 eABNx2KB83bXEqhSRkypC6Z8q1XY/6p1N9pxesjI804qyYN3nevX4qU4MS4xnoP+ybOvehXtM9A gnP8ni9xzogunpbOHLDESQWg8z+byaVXXopv0Fkp8OdHihEUuFX+D0mga91o3eGoeEhPyebKzEU G8xql7cNPaxbsRdL7M8ojuS+AbSVh8gJSQRcYe/Mv2AlQrHubkJrj5txE7SJg7VsPcSkjqbSk/9
 dlTO2m+pVHFAJekys7E+GgWA8g9S9xqe54z5dN9c0lSr4KyK4goCUTtxO0oW+toRTIcVt1Eb
X-Proofpoint-GUID: RcyC3er5bQwMKN-0xVyFNKmvBy5DcY9H
X-Proofpoint-ORIG-GUID: RcyC3er5bQwMKN-0xVyFNKmvBy5DcY9H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_01,2025-05-08_04,2025-02-21_01

Hi Simon,

On 2025-05-08 at 19:00:03, Simon Horman (horms@kernel.org) wrote:
> On Wed, May 07, 2025 at 10:44:20PM +0530, Subbaraya Sundeep wrote:
> > Underlying real device MTU plus the L2 header length has to
> > be configured in TX secy policy because hardware expects the
> > mtu to be programmed is outgoing maximum transmission unit from
> > MCS block i.e, including L2 header, SecTag and ICV.
> 
> Hi Subbaraya,
> 
> I think it would be good to include an explanation of how
> this bug manifests.
> 
> And please target fixes for bugs present in net at net.
> 
> Subject: [PATCH net] ...
> 
Yes I missed the net in subject. I will send v2.

Thanks,
Sundeep
> > 
> > Fixes: c54ffc73601c ("octeontx2-pf: mcs: Introduce MACSEC hardware offloading")
> > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> ...
> 
> -- 
> pw-bot: changes-requested

