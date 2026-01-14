Return-Path: <netdev+bounces-249720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E11D5D1C9C8
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 06:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72A3030A86F1
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 05:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C26136AB47;
	Wed, 14 Jan 2026 05:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fp5SOl5C"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C6836A03B;
	Wed, 14 Jan 2026 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768369964; cv=none; b=fbVfjzHfrURT00hISafdVWbsWzjdIQtKVz1kVvWh60I+TcpH7pO4QbLJ+g/ikjzHY+HyX017knLQeKRpuBhBv781LkRaPotkqb4mx1pqdl0+BwuyDpBNKpAzD2FBaPo1ULiflFc5LyGGQuHSkDLoFe0GSSm7jLMNcAUk6Fd03wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768369964; c=relaxed/simple;
	bh=g2LkqvRtuBct/J/Fkpwya0RVWLu5EwkRtimhteEo8Zo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjPGo3FgFDWNPFaxl9Vijf3Lq+qjMqAlHjdC63Hvjr/auNavLscIlye0oprg8aHYU0APJrOvpUmAVBWdUI7QyLA4zhrxwcrarKj6LdIVpHVinkzm0YNUAQFLq4hAbHNjW+FyAsNyEP0AnW4uJ/BX6zFfQMrMFhUfUEZH97gBb/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fp5SOl5C; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E5iQI94068936;
	Tue, 13 Jan 2026 21:52:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=f
	JCBygnE5Tg8EFGYmXgzsci9eoL9JmGqk/sN8KXUE8M=; b=fp5SOl5CV0BSmYNLZ
	txjjRBpLnN+bN0ZmXMgEJudN0bDEjN8hGYMtVs/isDTb8conmiz2uUtnD9FUlx99
	IA81uJOhrJ2M3OWRI9XQW8j9PRTPZXCMS2JXkyDXn0pcTqqQvFZ/cfey3NdHr3qb
	nKOOK+PDlPvsIz7l82rXYAK3M1qiOKsHDaV6VqJyczAkc1Cmd2YhA95YRxy9vHBM
	xW7csIo76z7Q3oWae62eLAWDQxkL45xlzO8qThbYdaYenLDWpFTH7ejLFT2vkYJc
	E1b2B8dFUDryYSaOGuo9C70BdA0DQQQOHTIqejm3djIAp0uEyoIk4MgGzJsUH9qW
	sVJTw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bnr0wa63x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 21:52:24 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 13 Jan 2026 21:52:23 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 13 Jan 2026 21:52:22 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 52F7D3F70B7;
	Tue, 13 Jan 2026 21:52:20 -0800 (PST)
Date: Wed, 14 Jan 2026 11:22:19 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next v3 01/13] octeontx2-af: npc: cn20k: Index
 management
Message-ID: <aWcvE-WN09pvpS4g@rkannoth-OptiPlex-7090>
References: <20260109054828.1822307-1-rkannoth@marvell.com>
 <20260109054828.1822307-2-rkannoth@marvell.com>
 <20260110145842.2f81ffdc@kernel.org>
 <aWYebi6adm9zD2gB@rkannoth-OptiPlex-7090>
 <20260113070732.6eb491de@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113070732.6eb491de@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA0MiBTYWx0ZWRfX6v6N18wAsoWq
 p4yTN4k7jhVxiLA7JiBD6VPEdBLRp1Yy9IC20wowyTFB9Ok7X68K1Sp0OCiqpcfDOzyRc3CNqHH
 qj5nWD5H6YRil/5OmJrF0TMP7e8u3QCWv0XS02jOstNE4on26sHpMIMtj4puIcHABlTZDlOhGqX
 p4g39Kvli+bNNEMV1ZkJ79qTnTE4sc/1xFHvyb/ViZpFSkUX0MqJJkZMS3ipjL1hUsV9gS6NCkd
 6Hdnv++sScHAoHd00xsclmEjPJzVkO2c4bjFzHNzUIg3QLWyLbWWic5/0M7FZxmFgC2pc5PPCA3
 0sIUZ6+R5g8yibmOBO9zjKu9AUBP4391WIQKttBwOLt63kdTjNZ0YGgmtfZN9xT6lLSUpgDL9yY
 uUfm60rsXlzRi2PeAaiVJsfleRpnotRMECO8UFjOTtxwgEuYvOtptGtnnAn/1lN+1b9hGhyXF8b
 t2odiEkHpNkGf/Iakxw==
X-Proofpoint-GUID: lH_I6XO5dB1j_GfS46iEAU7CX8EpiCQM
X-Proofpoint-ORIG-GUID: lH_I6XO5dB1j_GfS46iEAU7CX8EpiCQM
X-Authority-Analysis: v=2.4 cv=Jpz8bc4C c=1 sm=1 tr=0 ts=69672f18 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=QyK8Rs_vEw7abrMO5mkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_02,2026-01-09_02,2025-10-01_01

On 2026-01-13 at 20:37:32, Jakub Kicinski (kuba@kernel.org) wrote:
> On Tue, 13 Jan 2026 15:59:02 +0530 Ratheesh Kannoth wrote:
> > On 2026-01-11 at 04:28:42, Jakub Kicinski (kuba@kernel.org) wrote:
> > > On Fri, 9 Jan 2026 11:18:16 +0530 Ratheesh Kannoth wrote:
> > > > +static int
> > > > +npc_subbank_srch_order_parse_n_fill(struct rvu *rvu, char *options,
> > > > +				    int num_subbanks)
> > >
> > > Please avoid writable debugfs files,
> > I explored devlink option, but the input string is too big.
> >
> > > do you really need them?
> > Customer can change subbank search order by modifying the search order
> > thru this devlink.
>
> Unclear what you're trying to say.
TCAM memory is dividied into 32 horizontal chunks. Each chunk is called
a subbank. When a request to alloc a free TCAM slot is requested by PF,
these 32 subbank are searched in a specific order. Since bottom subbank rules
have higher priority than top subbanks, customer may need to alter the
search order to control the distribution of allocation to different subbanks.

Example search order format to debugfs entry is as below

"[0]=[8],[1]=7,[2]=30,[3]=0,[4]=1,[5]=2,[6]=3,[4]=4,[5]=5,[6]=6,[7]=9,[9]=10,[10]=11,[11]=12,[12]=13,[13]=14......[31]=0"

This input "string" is too long for devlink ?

union devlink_param_value {
        u8 vu8;
        u16 vu16;
        u32 vu32;
        char vstr[__DEVLINK_PARAM_MAX_STRING_VALUE];
        bool vbool;
};

>Hope you documented this much better
> in v4,
My bad—already sent V4. I will make sure to document this in V5

