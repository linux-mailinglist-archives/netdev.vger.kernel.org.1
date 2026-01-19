Return-Path: <netdev+bounces-250956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C12E8D39D36
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 04:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67CF230071BB
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 03:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824012F2619;
	Mon, 19 Jan 2026 03:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LQ5Kf1G1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FB92ED87C;
	Mon, 19 Jan 2026 03:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768794163; cv=none; b=Kr22M+/4ow+ZhugHmfxdsbpBuR/97RiGjoFkNE/v2Ga9kHujqTNAm6e7M0LzOip82DQZMwLDU/eP0YLMiC85EUG+nGg+WqSXvO5i3yDN15qfQHjXmIAbFIZB+YWcesdjwszVt7KgXvKx4pjnbM1XO480xQaVZ2e90ffU501hm/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768794163; c=relaxed/simple;
	bh=rtZG/V54jqtdkvBDVr/pR0pSejzaweOOTyqN363usFY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVhNlC080xUEjGCzlRLdkHoBE6gE0bp40ekhAc041LVUmmXsuke0QdtaNZx/H9XYtJbiZrk5PSPdO63/pLJKvWeZ5pG6899Mhl3Wem1eNido14u2g/UKupjJ2VA42+t+EMaPyqYXdSWtT+u5qed+vpwf/Ee8Jw4wC4DZ64mS514=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LQ5Kf1G1; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60INfJDA448946;
	Sun, 18 Jan 2026 19:42:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=/0cDq05A56723haJmSmaPV1sB
	Oi1RvjfPSfkdF1ZWLk=; b=LQ5Kf1G12UCxALBsC7Bd4eKj0xvwcJ2nqtI1GIM0Z
	aNaop/4gHJPpxn+X0zV3Ec9hSlLGJkW2+C8EEP/8jeh4ex1Bs5hGn6PM3pxv/SX+
	xXp70Y+Fw+7QdCMhEA+Wcz/rspsy72ZaQruePdpFb6PgsxWSDRzpqsJ2ZufZm0RD
	iRCDLsRja/XmSgEB2o/qjok89iDaC/qWDFeyZn11WISV+DBMlzPZxU7fTM7rYaOk
	9dRZF44FyMuofLmQ2jDXpq7SnFYdYrXEJXfE3s2dznk9K3g478R60I7xoIeGWTPL
	xtuvxoSm7fA19uXU2if9apW7JYBDtgKJG6GkKDtPHuhpQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4brv2995sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Jan 2026 19:42:36 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 18 Jan 2026 19:42:49 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 18 Jan 2026 19:42:49 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id CF70C3F7041;
	Sun, 18 Jan 2026 19:42:33 -0800 (PST)
Date: Mon, 19 Jan 2026 09:12:32 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [net-next,v4,05/13] octeontx2-af: npc: cn20k: Allocate default
 MCAM indexes
Message-ID: <aW2oKKg73zwRNals@rkannoth-OptiPlex-7090>
References: <20260113101658.4144610-6-rkannoth@marvell.com>
 <20260118004024.1044368-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260118004024.1044368-1-kuba@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDAyOSBTYWx0ZWRfX+CzZI1C+6jAf
 Zj2XxSZQ42H6m3S17BlnmZAkdoxviUZ5Y43AJFVzM1HT9KxTZqbO/9Z8b5fiOuDn79Hxbrt9HAe
 dMOkZtMx7Bx+0cAK9rGhBBWvS/2DT0c6tSDTyr4fdqsNJQs4Oi6jBFfE8swXd5Jz9iQ+T34Zvl0
 N4v5l7ki8RF7F+nIDoHqpsD0yMni+L5MZcgZgTRrlFjWMnlFcBXLguGejbtRUjvV5McYrrQMp1S
 M5G1WqjzMkOL0IcVR2Wx28nfCZz56yIyWT9LmbEKcWZlcUfVT1uK59zI8EFCqJhqfbXfi0wSpS3
 O59iUsT385juLNwIcGYVrHovbKKkxuLX+0Hg9y5kMr/RBhzxh/OovwzoS7mSGaALKxyK/0yqQtX
 2xPNY7E0Kj74cH9aJiSYF/r9L9MxBjBQrNOPiopJOoNikczcitwXiJg1a3eNq1G0U8KD2kfN1oC
 sevyOXYv4xZMf6CH05w==
X-Authority-Analysis: v=2.4 cv=d9n4CBjE c=1 sm=1 tr=0 ts=696da82c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9R54UkLUAAAA:8 a=VwQbUJbxAAAA:8 a=VIxymOikqMIK8Uk_9HsA:9 a=CjuIK1q_8ugA:10
 a=16MAPSKLCI0A:10 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-ORIG-GUID: Re-qP8DxxNcpk0gYGWhdldWl50q3oe8G
X-Proofpoint-GUID: Re-qP8DxxNcpk0gYGWhdldWl50q3oe8G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-18_02,2025-10-01_01

On 2026-01-18 at 06:10:24, Jakub Kicinski (kuba@kernel.org) wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> octeontx2-af: npc: cn20k: Allocate default MCAM indexes
>
> This patch allocates MCAM indexes for promiscuous, multicast, broadcast,
> and unicast traffic when NIX LF is attached for CN20K silicon, replacing
> the previous static reservation approach.
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> > index 2d78e08f985f..df02caedc020 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
>
> [ ... ]
>
> > @@ -1738,8 +1745,14 @@ int rvu_mbox_handler_attach_resources(struct rvu *rvu,
> >  	if (attach->npalf)
> >  		rvu_attach_block(rvu, pcifunc, BLKTYPE_NPA, 1, attach);
> >
> > -	if (attach->nixlf)
> > +	if (attach->nixlf) {
> >  		rvu_attach_block(rvu, pcifunc, BLKTYPE_NIX, 1, attach);
> > +		if (is_cn20k(rvu->pdev)) {
> > +			err = npc_cn20k_dft_rules_alloc(rvu, pcifunc);
> > +			if (err)
> > +				goto exit;
>                         ^^^^
>
> When npc_cn20k_dft_rules_alloc() fails after rvu_attach_block() has
> already attached the NIX LF, the error path jumps to exit without
> detaching NIX. The caller (otx2_init_rsrc in otx2_pf.c) assumes that on
> error nothing was attached, so it does not call otx2_detach_resources().
>
> Could this leave NIX LF attached without proper cleanup on allocation
> failure?
There is no proper error handling done for rvu_attach_block function (in existing code)
We can address this later as different patch ?
>
> > +		}
> > +	}
> >
> >  	if (attach->sso) {
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> > index c3f41f4ea99c..33be0bf0b481 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>
> [ ... ]
>
> > @@ -2473,6 +2836,7 @@ static int npc_priv_init(struct rvu *rvu)
> >  	xa_init_flags(&npc_priv.xa_sb_used, XA_FLAGS_ALLOC);
> >  	xa_init_flags(&npc_priv.xa_sb_free, XA_FLAGS_ALLOC);
> >  	xa_init_flags(&npc_priv.xa_idx2pf_map, XA_FLAGS_ALLOC);
> >  	xa_init_flags(&npc_priv.xa_pf_map, XA_FLAGS_ALLOC);
> > +	xa_init_flags(&npc_priv.xa_pf2dfl_rmap, XA_FLAGS_ALLOC);
> >
> >  	if (npc_create_srch_order(num_subbanks)) {
> >  		kfree(npc_priv.sb);
> >  		return -ENOMEM;
>                 ^^^^
>
> At this point npc_subbank_init() has been called for all subbanks (in
> the loop at lines 2850-2851), which calls xa_store() to populate
> xa_sb_free. This error path frees npc_priv.sb but does not call
> xa_destroy() on the xarrays that now contain entries.
>
> Similarly, the error path after kcalloc of xa_pf2idx_map fails (around
> line 2857-2860) also skips xa_destroy() on the populated xarrays.
>
> Could these error paths leak the xarray entries stored by
> npc_subbank_init()?
ACK.
>
> >  	}
>
> [ ... ]

