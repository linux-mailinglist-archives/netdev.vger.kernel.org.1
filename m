Return-Path: <netdev+bounces-249387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1339D17E60
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B36D53028237
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D001389E19;
	Tue, 13 Jan 2026 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="OjgZ+Bto"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457293148DA;
	Tue, 13 Jan 2026 10:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298972; cv=none; b=nMIMY+NhP523nV3/4cgDKQRexu1DlPLnPc8soY8qeMqgMI/bOOp8E+Dywb9bQ9sqQcjnBIDRKlBteaJelyXJcIm0szaymAS4ea8hlPlBc2cXcmBf6NR69m7pqhjeDppwpLO2a3boethwGVTPrf2Iks+zhH7dn3s4JoAbqK6AeME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298972; c=relaxed/simple;
	bh=bBq66UW7kwXyiEAYlELFke0pEaf0D6xEfm7UXN25hGI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlYF8RvFtUPydg8TQtG/Gacow1nKVoiZrSmuXpVFrHS8s7+14ObvwAzxgT0hvwPQpWsBwn/4eAUDLlp76+b2WAydfgFfv7VYFePuOqQ9yd3Dzq8QaZjpihBKcPIeUSwf8rXv/CewanFAjFT6nxEJ2Ly2B0MmKXIYN6kH7wxrMrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=OjgZ+Bto; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D7Q8pH3356419;
	Tue, 13 Jan 2026 02:09:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=bBq66UW7kwXyiEAYlELFke0pE
	af0D6xEfm7UXN25hGI=; b=OjgZ+BtoDx65NP4dJROdkwlwjZYZkCUlk4E9WT2PI
	zKg+i+9zeMUjD5P8raT4Uh1pDGXLVfF77EZhHUz002E7v/GH430oVsInkGdbtliQ
	XQxU3TEFXXv1jmkUVVc++08dHe8Ibx8DcUDDRyxxtAwpCppaLKkQurGDwwPF73l5
	XaJKcCst6yezT39rmtrk4DKjnToggZZqKUnhcQbAO3jH3tSzE5jDBabHFXabE7ej
	Viptiu+LCx/mGqsJuJb93BXc5qSGwj+YScMuBfvIlyEFtYUg04aQWN925tnLIOd2
	IJZX7q1U5a+dUwArUyBfw/GvKFL3r3SloE0u9KZVolCmw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bnd2g8sqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 02:09:22 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 13 Jan 2026 02:09:38 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 13 Jan 2026 02:09:37 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 2602F3F709C;
	Tue, 13 Jan 2026 02:09:19 -0800 (PST)
Date: Tue, 13 Jan 2026 15:39:19 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next v3 09/13] octeontx2-af: npc: cn20k: virtual
 index support
Message-ID: <aWYZz_JCZVTGsJlM@rkannoth-OptiPlex-7090>
References: <20260109054828.1822307-1-rkannoth@marvell.com>
 <20260109054828.1822307-10-rkannoth@marvell.com>
 <20260110145252.3ecf939f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260110145252.3ecf939f@kernel.org>
X-Proofpoint-ORIG-GUID: WY6JIRBHjDJ-aktizIY3xUvwst-XBCmR
X-Authority-Analysis: v=2.4 cv=OvlCCi/t c=1 sm=1 tr=0 ts=696619d3 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=l0zaMVzGWk1FG-mKCpkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: WY6JIRBHjDJ-aktizIY3xUvwst-XBCmR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA4MyBTYWx0ZWRfXwUsd9NEXl+jP
 1O8VrYZIcgXFTpRR8qgF1RXu20p/1dLcfe63mEUCmveP5RgA+dM24JyDUAv8fgZh6Xt3RBHPyvA
 OCZYKNWpwEtmrRExVudI8GHG6iwDUmTtbAmCqqYAYkcmqFTZZQSzmQLuUSr0t+z82/cKZdRnqnc
 msy0Q7rGlgUQeC7VK32tm+G3/taLZ/ONPTpsChlGCUWHq11YnbPncAAu6HhLwyJnL2RbuQ1eKAC
 cg4DSK8j58MOKwO+ZNemA09bDJzI17Wh+mBJsxbJ5RFV+QU2sYK1bywaHlOCppTjWUoKUsL2Dek
 YqPcKT9rAoyzKCsR88sXNkB5dUfwjW8P+8aI+STARatgFxygH9iPEhXg0EOBfFInO+TEd01ZfHv
 XynD5fAR4YOaLvn5xtfXLOp7gk70A4wBlv0Mj3bRAqwRoT20uyGttVTKnHt8LTQP8aHfLwudygu
 /fIaKMy3vbVGtYjOqrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01

On 2026-01-11 at 04:22:52, Jakub Kicinski (kuba@kernel.org) wrote:
> On Fri, 9 Jan 2026 11:18:24 +0530 Ratheesh Kannoth wrote:
> > This patch adds support for virtual MCAM index allocation and
> > improves CN20K MCAM defragmentation handling. A new field is
> > introduced in the non-ref, non-contiguous MCAM allocation mailbox
> > request to indicate that virtual indexes should be returned instead
> > of physical ones. Virtual indexes allow the hardware to move mapped
> > MCAM entries internally, enabling defragmentation and preventing
> > scattered allocations across subbanks. The patch also enhances
> > defragmentation by treating non-ref, non-contiguous allocations as
> > ideal candidates for packing sparsely used regions, which can free
> > up subbanks for potential x2 or x4 configuration. All such
> > allocations are tracked and always returned as virtual indexes so
> > they remain stable even when entries are moved during defrag.
> > During defragmentation, MCAM entries may shift between subbanks,
> > but their virtual indexes remain unchanged. Additionally, this
> > update fixes an issue where entry statistics were not being
> > restored correctly after defragmentation.
>
> Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:203 struct member 'xa_idx2vidx_map' not described in 'npc_priv_t'
> Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:203 struct member 'xa_vidx2idx_map' not described in 'npc_priv_t'
> Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:203 struct member 'defrag_lh' not described in 'npc_priv_t'
> Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:203 struct member 'lock' not described in 'npc_priv_t'
> Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:203 struct member 'xa_idx2vidx_map' not described in 'npc_priv_t'
> Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:203 struct member 'xa_vidx2idx_map' not described in 'npc_priv_t'
> Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:203 struct member 'defrag_lh' not described in 'npc_priv_t'
> Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:203 struct member 'lock' not described in 'npc_priv_t'
ACK.

