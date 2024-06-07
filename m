Return-Path: <netdev+bounces-101921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 750C89009A7
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 17:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12CCFB21B82
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55678199E8D;
	Fri,  7 Jun 2024 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eA0aPNPg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26F4199234;
	Fri,  7 Jun 2024 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717775683; cv=none; b=stOlsSx37E7sje1pHQKWVBfLvW9+q6isMUtPbXf6Ta3eJjO3dLxy8hRVjWlQ+/L2HZIhluBmE4AIjX4MLuliWNBaMRHsDfmDAQ58gKlrqO3mCTfWEkQ6YSwj9bHff9wEFJX/YicMqkliBkaiSYsv/6sQvO4qCJfcZ6n/Cv8LVRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717775683; c=relaxed/simple;
	bh=xmd67umfymHcJ44Kt4eIRJxEDJGDef0iHkNvcUkjnTo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isrHyysfpM8IqBz3w/3JgE3Hj8duscV9ceehm8xKjcTDzcPyi3MPWpY3kDkJyipegdUdFno79FLaF9ePCBjZLq197cpa1HZzY6ODfLnKEVTVyDczVypZOLQwiee2C5TdG6uiTnKOEdk65jrbWeOKjZUNGrYetIv0+DEM3WYWANc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eA0aPNPg; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45798tGw026974;
	Fri, 7 Jun 2024 08:54:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=756gArjuo2v/8U2A0jAbflCts
	ep0ltO8YlA9qtCTL1w=; b=eA0aPNPgFgSiUxyUhjmZ2kYr5Z/t6npNpunDn+fjE
	DfMI0KdyDAihJ1c6eAf6w/OGOmbk5pFrJSC5YFFdNZov2RCLuHAVC9qNAwzYba8c
	DAA3HiWbmuKX3CkJ41j7pPsPC+gPVWvGE1z2atti3dwI17uWXPcdlzLxNfg8YIYb
	d+FzvOiz/Axwy21oxErfqO26XXsadJ+kaEHbXHANutKoIy2cQSgT1nhU3Pmk2Fqj
	jUGK2k9wIJWh+9uXli1mlOckOB12L8jYM+zYeREZwx1z31+nVw6qVT1bdEok0uvX
	LkzN3++HJoVUS7/Ff5cB7WJR1W9KKAEz4nuoTYvEF1HcA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ykuu21qjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 08:54:26 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 7 Jun 2024 08:54:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 7 Jun 2024 08:54:25 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 7C71E3F708F;
	Fri,  7 Jun 2024 08:54:21 -0700 (PDT)
Date: Fri, 7 Jun 2024 21:24:20 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Justin Lai <justinlai0215@realtek.com>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <andrew@lunn.ch>, <jiri@resnulli.us>,
        <horms@kernel.org>, <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v20 06/13] rtase: Implement .ndo_start_xmit
 function
Message-ID: <20240607155420.GA3743392@maili.marvell.com>
References: <20240607084321.7254-1-justinlai0215@realtek.com>
 <20240607084321.7254-7-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240607084321.7254-7-justinlai0215@realtek.com>
X-Proofpoint-ORIG-GUID: Rrqbr78-72hns9XLeDN7k4VOZYSi2O56
X-Proofpoint-GUID: Rrqbr78-72hns9XLeDN7k4VOZYSi2O56
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_09,2024-06-06_02,2024-05-17_01

On 2024-06-07 at 14:13:14, Justin Lai (justinlai0215@realtek.com) wrote:
> Implement .ndo_start_xmit function to fill the information of the packet
> to be transmitted into the tx descriptor, and then the hardware will
> transmit the packet using the information in the tx descriptor.
> In addition, we also implemented the tx_handler function to enable the
> tx descriptor to be reused.
>
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  .../net/ethernet/realtek/rtase/rtase_main.c   | 285 ++++++++++++++++++
>  1 file changed, 285 insertions(+)
>
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> index 23406c195cff..6bdb4edbfbc1 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -256,6 +256,68 @@ static void rtase_mark_to_asic(union rtase_rx_desc *desc, u32 rx_buf_sz)
>  		   cpu_to_le32(RTASE_DESC_OWN | eor | rx_buf_sz));
>  }
>
> +static u32 rtase_tx_avail(struct rtase_ring *ring)
> +{
> +	return READ_ONCE(ring->dirty_idx) + RTASE_NUM_DESC -
> +	       READ_ONCE(ring->cur_idx);
> +}
dirty_idx and cur_idx wont wrap ? its 32bit in size.

>

