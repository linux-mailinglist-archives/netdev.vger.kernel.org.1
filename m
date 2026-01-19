Return-Path: <netdev+bounces-250955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 003F9D39D2A
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 04:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23BD8300C5D5
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 03:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C0F6BB5B;
	Mon, 19 Jan 2026 03:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dXoikLwZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F13D27280F;
	Mon, 19 Jan 2026 03:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768794006; cv=none; b=uwSx0q5uleAKSTXSI/nX0v4DzgNTXZhbLA3N6206cqM2c72H9JeHTSpJT7v8W1JDp0InnoYQK7wwayyA9/f8uibONAn8zUSfgfCZa8mx6UelX4LrJ0TIlXE4bTezszx1HaOb3GCr4QX6M7BQXc1/00X3ad1pOEvUmwoOB9xiAuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768794006; c=relaxed/simple;
	bh=BXdxwLKB4xEd3oi9GRm3pZLQj0vOoUvt6DwpfgzqG1c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEtnJQDANNQ2NWMBO46GqffJxw9XC1HNryh9ZSDEBAZ0TgeGKgDvqg4Tkf4RnmrSHCpiLlvmpuwu+VsXXRd+v15dNWGHBCyWwP7TmCaQJ3we6zBz7X253wHDjUb2NtMKkP+ofbARtvPu5ggjq53aLfhn/xMc88kfaUCXLs8QnIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dXoikLwZ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J2TYeb1312471;
	Sun, 18 Jan 2026 19:39:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=oL8FbQ6/VeiCVqLhASCbvI/g2
	aOJ2d/itfiHWUOi/rs=; b=dXoikLwZYNOqsxUkEviLqs6jxTa8ATmpZMgCX9D6l
	6StYPwYxXTFpqHLxHOcnvkbz0yd8JOPNEMHgAJ0/w4Qp3n+H4D4mRfTNV3cC2hmS
	Myv0A7LyK0ebQl9Hea/RZPKOCJRy5Yi8IBJqCzHHs9Q8UZcSb5dLnsMsxyiXFutk
	CVng/otCNW222R9syOn1yfv03ThTUAUsHkZTrVof0qKS6A/afnq662l09m+0QDj4
	WZiz1dcby3MmaG8J2N7CxC96ylQMPdHfnXgn9l9CksZ19EMfGXt2Q9F83ved2GaR
	yO0fdWBL4u43fpkHYhW62jhTcmcCkny8Y2GD1k+2bSJ/g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bsbvfr2nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Jan 2026 19:39:49 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 18 Jan 2026 19:40:03 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 18 Jan 2026 19:40:03 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 567853F7041;
	Sun, 18 Jan 2026 19:39:47 -0800 (PST)
Date: Mon, 19 Jan 2026 09:09:46 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [net-next,v4,09/13] octeontx2-af: npc: cn20k: virtual index
 support
Message-ID: <aW2ngo2FwC5sZmWn@rkannoth-OptiPlex-7090>
References: <20260113101658.4144610-10-rkannoth@marvell.com>
 <20260118004027.1044394-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260118004027.1044394-1-kuba@kernel.org>
X-Proofpoint-ORIG-GUID: bDPlq_sTsNqqu7nudaaqlJc0kwyiWqn4
X-Proofpoint-GUID: bDPlq_sTsNqqu7nudaaqlJc0kwyiWqn4
X-Authority-Analysis: v=2.4 cv=ebgwvrEH c=1 sm=1 tr=0 ts=696da785 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9R54UkLUAAAA:8 a=VwQbUJbxAAAA:8 a=GEucVIB4LJz7d3GWznwA:9 a=CjuIK1q_8ugA:10
 a=16MAPSKLCI0A:10 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDAyOCBTYWx0ZWRfX1QDWfW1NIK+t
 RGcU+y7of3FChGhopBqkHxkllXpKlaE1seBOYFELnRU42pXS8abwb98fqeAws5/b/84YNCFF5Sm
 Li410HHVfn1a2bL0GdsFJQJQFVFbODF5NkMGTbdDTjE+RMkD1T7gLL65iN1V5GyPt09ShAD9APS
 B5WPMEdUfGErupTf+6UBdH5Bi3WMromiLdjdVYJSsVH0+1UrIyMprt5DzxLTuJT9WM4ynp4uiDX
 Nd8B5JvtpejDfCpd9TZqXzEvc4v+aeFGdo3tssHS/ZjvhvCroitcvZ4HNF37Ii2FKrdf8yWsNOK
 el2W8SiRRD1GAaIb61HYOA50+sfZ2HOTIitUbiNi2Se94tNK1aBRcAKQTHUhExaMvIplndmpMLa
 t4sSA8NKjTWSpOHejHwTLk2cqwzbLdDn7ATXLSwqMV315PTGv4I09wxN86rxp8IdgT6HD+HUULS
 iW5SnHY9vGAxkAl0VRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-18_02,2025-10-01_01

On 2026-01-18 at 06:10:27, Jakub Kicinski (kuba@kernel.org) wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> octeontx2-af: npc: cn20k: virtual index support
>
> This patch adds virtual MCAM index allocation and improves CN20K MCAM
> defragmentation. Virtual indexes allow the hardware to move mapped
> MCAM entries internally while presenting stable indexes to callers.
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> > index d549e75b2cb0..334b80ebec69 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>
> [ ... ]
>
> > +static int npc_vidx_maps_add_entry(struct rvu *rvu, u16 mcam_idx, int pcifunc,
> > +				   u16 *vidx)
> > +{
> > +	int rc, max, min;
> > +	u32 id;
> > +
> > +	/* Virtual index start from maximum mcam index + 1 */
> > +	max = npc_priv.bank_depth * 2 * 2 - 1;
> > +	min = npc_priv.bank_depth * 2;
> > +
> > +	rc = xa_alloc(&npc_priv.xa_vidx2idx_map, &id,
> > +		      xa_mk_value(mcam_idx),
> > +		      XA_LIMIT(min, max), GFP_KERNEL);
> > +	if (rc) {
> > +		dev_err(rvu->dev,
> > +			"%s: Failed to add to vidx2idx map (%u)\n",
> > +			__func__, mcam_idx);
> > +		return rc;
> > +	}
> > +
> > +	rc = xa_insert(&npc_priv.xa_idx2vidx_map, mcam_idx,
> > +		       xa_mk_value(id), GFP_KERNEL);
> > +	if (rc) {
> > +		dev_err(rvu->dev,
> > +			"%s: Failed to add to idx2vidx map (%u)\n",
> > +			__func__, mcam_idx);
> > +		return rc;
>                 ^^^^^^^^^^
>
> If xa_insert() fails here, the entry allocated by xa_alloc() in
> xa_vidx2idx_map is not cleaned up. Should there be an xa_erase() call
> to remove the allocated entry before returning the error?
ACK.

>
> > +	}
> > +
> > +	if (vidx)
> > +		*vidx = id;
> > +
> > +	return 0;
> > +}
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> > index 0f9953eaf1b0..cc83d4fc5724 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
>
> [ ... ]
>
> > +static const struct devlink_param rvu_af_dl_param_defrag[] = {
> > +	DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NPC_DEFRAG,
> > +			     "npc_defrag", DEVLINK_PARAM_TYPE_STRING,
> > +			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> > +			     rvu_af_npc_defrag_feature_get,
> > +			     rvu_af_npc_defrag,
> > +			     rvu_af_npc_defrag_feature_validate),
> > +};
> > +
> >  int rvu_register_dl(struct rvu *rvu)
> >  {
>
> [ ... ]
>
> > +	if (is_cn20k(rvu->pdev)) {
> > +		err = devlink_params_register(dl, rvu_af_dl_param_defrag,
> > +					      ARRAY_SIZE(rvu_af_dl_param_defrag));
> > +		if (err) {
> > +			dev_err(rvu->dev,
> > +				"devlink defrag params register failed with error %d",
> > +				err);
> > +			goto err_dl_exact_match;
> > +		}
> > +	}
>
> The rvu_af_dl_param_defrag parameters are registered here for CN20K
> devices, but rvu_unregister_dl() does not have a corresponding
> devlink_params_unregister() call for these parameters. Should there be
> a matching unregister call similar to the exact_match handling?
ACK.

