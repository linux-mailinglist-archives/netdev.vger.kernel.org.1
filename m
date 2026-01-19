Return-Path: <netdev+bounces-250958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B97B7D39D4B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 05:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 701943005FF8
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 04:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3831E8320;
	Mon, 19 Jan 2026 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="a8P2IOlf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1338F5B;
	Mon, 19 Jan 2026 04:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768795260; cv=none; b=uX2KAMpW5UHf7Z7V3CFm0eITx6GxSNL2Cv6ifzAUeHJ/URLxO9V8SzRuhkq9w+6FJMNmajAm3YMnWw8/DxFRJdfRsmZXADq+B97oR4hL8JFGXUXWdYf4gXAzxLtYJPob5+F5tzEyJlA2gZu3eR0P3SQ8NMpHaeT7g9bE/pU+1hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768795260; c=relaxed/simple;
	bh=Agy8NMcMWsEC/lFbtbPrfZ7R4xrmzw1pkND0ppnbefU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaPp/+axL1MzlwpFdSZkDQ/7xqcy/gLes4z+0aWSYmg+VVLP+z4NIFbq6JTSgi7f6Jf3my9J3hGFiEC4OWlP9+wA/iuXJtx0G8fGYTQ+GAZy74RdsBd2iXgBZix+PJZuTGXtbnF/68aFCbKlWa1P8v5kGsSkTKyb/Cdmacr/3Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=a8P2IOlf; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60IN1Fix382891;
	Sun, 18 Jan 2026 20:00:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=XH5/Z53VYMJepCvfLsk06k32w
	Hmea4DM4sMiZb8xZ7Y=; b=a8P2IOlfeDxfdW30t4vMmKf3i/YLOC7a0zkFltGJb
	fx6h2DAogBXGBUiJcsiDbpxe+zXTUY5YqwZY2rK7U7fuzpAnqY56Hj6UcpeFbRC6
	5KHI0t1Zc5brrgzfPYOhtid3FM14lv9akF12nrKwTazyBncg4JXzSfTRQPMDzc9e
	czrVRZWaT9ap84D03HzvD3RdK4+oZrgdFFT+xNEJQYX9Q8LJgWOiZuafyqlKmYDm
	iLYpasjXp/t2noRNm4UlIT4hiS67IwusXIKv4cVtzRctgEYurjSZIhjJqlXj0d8Q
	eJTIrpsp0c1FINKRuSwr6NTUz+SMSGL/12Hr00MK1wqXA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4brv2996be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Jan 2026 20:00:55 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 18 Jan 2026 20:01:08 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 18 Jan 2026 20:01:08 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 923713F7082;
	Sun, 18 Jan 2026 20:00:52 -0800 (PST)
Date: Mon, 19 Jan 2026 09:30:51 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [net-next,v4,01/13] octeontx2-af: npc: cn20k: Index management
Message-ID: <aW2sc2JAxGJGe88W@rkannoth-OptiPlex-7090>
References: <20260113101658.4144610-2-rkannoth@marvell.com>
 <20260118004017.1044291-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260118004017.1044291-1-kuba@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDAzMCBTYWx0ZWRfX3HDPCmsR6/cF
 Z1XBlGvBUgNfCgrd8sSX5ZsaONgui5OtxfE6Yg2g7TRRQqt5eH+ItVPsLTPYyxW+WApqHoPOvqw
 o7Rz93olPI5h0w6RDtvpqoh0KfIp85aTtk4xqhYyfLUHg6awdZkmwK9/bjnLZOUg5HVBUKGzMKy
 DGMtl4Qj1h+mKNYSBK3KfNlbEsTOl8y35K61Eatpk9ADYg3DTdp2eVwmXP9KBNGLNDyDa/u68R3
 DS2lEBr4qUt634Kvl5g2uqm2EVNmioyqeetc24GDIpmplmuGNOnZXqY3LaEsY1VDeBVNvwhHrhS
 g3JA+zxZp6Jgrsm0pOPKi0gGEc4a3PF54Cle1hPJv7c9CbZES3/YoKFzGdhUnpb/40r5PRlfrMz
 W6sj81exSMSmwTiLmO9MhVT8qSdpqvXVBVgmZQFMNdKUExmexjd+ovkud/uNRC5P//NOUEz5WEp
 8l+hQOi9egg4rdAsN6A==
X-Authority-Analysis: v=2.4 cv=d9n4CBjE c=1 sm=1 tr=0 ts=696dac77 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9R54UkLUAAAA:8 a=VwQbUJbxAAAA:8 a=BlRNhARagtyhgYYsq1MA:9 a=CjuIK1q_8ugA:10
 a=16MAPSKLCI0A:10 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-ORIG-GUID: UG486AfVIkDBBegxbDBPOZLaGreK3DFl
X-Proofpoint-GUID: UG486AfVIkDBBegxbDBPOZLaGreK3DFl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-18_02,2025-10-01_01

On 2026-01-18 at 06:10:17, Jakub Kicinski (kuba@kernel.org) wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> octeontx2-af: npc: cn20k: Index management
>
> This patch adds MCAM index management for CN20K silicon, implementing
> contiguous and non-contiguous allocation schemes with reference, limit,
> and priority parameters across the new subbank architecture.
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> > new file mode 100644
> > index 000000000000..ebccc780ab8e
> > --- /dev/null
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>
> [ ... ]
>
> > +static int npc_idx_free(struct rvu *rvu, u16 *mcam_idx, int count,
> > +			bool maps_del)
> > +{
> > +	struct npc_subbank *sb;
> > +	int idx, i;
> > +	bool ret;
> > +	int rc;
> > +
> > +	for (i = 0; i < count; i++) {
> > +		rc =  npc_mcam_idx_2_subbank_idx(rvu, mcam_idx[i],
> > +						 &sb, &idx);
> > +		if (rc)
> > +			return rc;
> > +
> > +		ret = npc_subbank_free(rvu, sb, idx);
> > +		if (ret)
> > +			return -EINVAL;
>
> If an error occurs partway through this loop, for example when freeing
> entry i out of count entries, entries from i+1 to count-1 remain allocated
> but are never freed. Could this leak MCAM slots when npc_idx_free() is
> called from error paths in npc_multi_subbank_ref_alloc() or
> npc_subbank_noref_alloc()?
if npc_idx_free() failed for an allocated index, system wont be able to function
properly as index management goes for a toss. So there is no point in rolling back.
i moved npc_mcam_idx_2_subbank_idx() out of the loop and checked whether all indexes can
be converted to proper mcam index.
>
> > +
> > +		if (!maps_del)
> > +			continue;
> > +
> > +		rc = npc_del_from_pf_maps(rvu, mcam_idx[i]);
> > +		if (rc)
> > +			return rc;
> > +	}
> > +
> > +	return 0;
> > +}
>
> [ ... ]
>
> > +static int npc_priv_init(struct rvu *rvu)
> > +{
>
> [ ... ]
>
> > +	npc_priv.sb = kcalloc(num_subbanks, sizeof(struct npc_subbank),
> > +			      GFP_KERNEL);
> > +	if (!npc_priv.sb)
> > +		return -ENOMEM;
> > +
> > +	xa_init_flags(&npc_priv.xa_sb_used, XA_FLAGS_ALLOC);
> > +	xa_init_flags(&npc_priv.xa_sb_free, XA_FLAGS_ALLOC);
> > +	xa_init_flags(&npc_priv.xa_idx2pf_map, XA_FLAGS_ALLOC);
> > +	xa_init_flags(&npc_priv.xa_pf_map, XA_FLAGS_ALLOC);
> > +
> > +	if (npc_create_srch_order(num_subbanks)) {
> > +		kfree(npc_priv.sb);
> > +		return -ENOMEM;
> > +	}
>
> The four xarrays initialized above are not destroyed before returning
> here. Should xa_destroy() be called for xa_sb_used, xa_sb_free,
> xa_idx2pf_map, and xa_pf_map on this error path?
ACK.
>
> [ ... ]
>
> > +	npc_priv.xa_pf2idx_map = kcalloc(npc_priv.pf_cnt,
> > +					 sizeof(struct xarray),
> > +					 GFP_KERNEL);
> > +	if (!npc_priv.xa_pf2idx_map) {
> > +		kfree(subbank_srch_order);
> > +		kfree(npc_priv.sb);
> > +		return -ENOMEM;
> > +	}
>
> Same question here - the four xarrays are still not destroyed on this
> error path.
ACK.
>
> > +
> > +	for (i = 0; i < npc_priv.pf_cnt; i++)
> > +		xa_init_flags(&npc_priv.xa_pf2idx_map[i], XA_FLAGS_ALLOC);
> > +
> > +	return 0;
> > +}
> --
> pw-bot: cr

