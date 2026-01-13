Return-Path: <netdev+bounces-249379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A9DD17CE0
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D6C630012C9
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 09:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE60378D96;
	Tue, 13 Jan 2026 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dNFLI1Hj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ECB316905;
	Tue, 13 Jan 2026 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298200; cv=none; b=TSdcmxq3jYuEO4a27JZCuTaT8qneDD+7keUCqjHh0pSPv5F66qJteypZ4gZMJv0SOO9q1RF4p/kmYjX9S7qkK9RqtnwMtXOPNRxZa2aaNDVL5NflZLockZGRGbW0BBZJW+lbiSQGQOx7qqZgP3TlGaBKwJIrwKBckoQ1HR0HGVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298200; c=relaxed/simple;
	bh=YMvXKJzZkZEDSkYelQIL/6s3sLzcxSUVfF3hvRpmCtc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJmpX99O9pdotmAMLk2BPsvhXIIheoF3VTF6TjLky9uukeBID35KjEhwToAeN4q/KmCQ2uMUFXLZRosf0OySJ9x7W9Db3DvumwsRcnAQa9e5yhY34nX3u2v0nCw8nIjAYz+ES1tlbeHETQ8AhTih3Vtpbd3sBnB38tOLzh4XLys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dNFLI1Hj; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D7Q8oF3356419;
	Tue, 13 Jan 2026 01:56:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=6MbAH3Y3HuTOPW66nuxPz3wbP
	pVmaWpaKulGNrBd6tU=; b=dNFLI1HjekKTpnTSaAqtqroXQ4uhKxSdAZkRZpupM
	5YaAszHMDjkvRMiqHhAf+fZxRSEs3gCRa79PAcRCXQLnra33YMPkMoWtoq+JDg4Y
	n84bd9fkcMyBWWwTEdK0UwxlhsqN6ALlW17koWFFjI3Gz8cRUnyODn9WzhcvmrYd
	BCytx9Uf1DCzd7gAWZlyngxu4rQFoaczEhcMNtVQBN1FmVcN0n/aiKfdNplwt4cV
	NB5/pB2aBi3lPKbGs9jRbj2a3KjXJmqdY52Dy0+fi5m4HTQdUHCe8egbKsEKv5Rz
	eGW2B21j+0XE64AuxLx1YkyuSCG51/E49UZXavls+gsCA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bnd2g8s12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 01:56:36 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 13 Jan 2026 01:56:35 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 13 Jan 2026 01:56:35 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 53CDE3F7096;
	Tue, 13 Jan 2026 01:56:34 -0800 (PST)
Date: Tue, 13 Jan 2026 15:26:33 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [net-next,v3,05/13] octeontx2-af: npc: cn20k: Allocate default
 MCAM indexes
Message-ID: <aWYW0cbXn2ew9igB@rkannoth-OptiPlex-7090>
References: <20260109054828.1822307-6-rkannoth@marvell.com>
 <20260110225935.3900857-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260110225935.3900857-1-kuba@kernel.org>
X-Proofpoint-ORIG-GUID: Fnz30NAzwHyYV5hEP-662tOZLh9pPJ2d
X-Authority-Analysis: v=2.4 cv=OvlCCi/t c=1 sm=1 tr=0 ts=696616d4 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9R54UkLUAAAA:8 a=VwQbUJbxAAAA:8 a=k9KW9QKFpIuq3wM-gmAA:9 a=CjuIK1q_8ugA:10
 a=16MAPSKLCI0A:10 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-GUID: Fnz30NAzwHyYV5hEP-662tOZLh9pPJ2d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA4MiBTYWx0ZWRfXwRZ+9pqMMYPp
 +3yAobNeIHH39VQ2k4VF+N5cIXdYOR6h8KdeTSiUSFN4+h2moZ9h2r2QA1ygyBkefIR8sZ4nO4L
 sZBvUygMcqVn4+M9HbfvnwQwHsqjCgamX7Df4JwEEFf1tRmN61CBQOyEoWI7mcwBEy6ichk8aAo
 Lx5YiK35f8zo9Qc8twRFCbVHKANyVKl3FuHW06xa94nW10S6WfXzmzAM4f+g12FspEHtvb9dtpI
 xF4SRdxf/TACFLpg+9xuvOBEw0MjW5jcC7vlZ6QquZRczAJaWnlYCncbFEluc3adPHvpmaTOidL
 nDlvXxNQBQBPcQicgyvfzhxC/2N3VB0gQMgdvQMaIMMeph+n75x/ZsV10fMOkYyQARF36Yae7y/
 NcT8J0jCNEmsyBxG8q7+60nUSB5OMyjwIsjvq3AiS9iuOQYta62sp/EaCJkTu1WUSYAG50PUfTD
 DFhTlCDcFR//087w79Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01

On 2026-01-11 at 04:29:35, Jakub Kicinski (kuba@kernel.org) wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least pausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> octeontx2-af: npc: cn20k: Allocate default MCAM indexes
>
> This patch allocates MCAM indexes for promiscuous, multicast, broadcast,
> and unicast traffic when the NIX LF is attached to the PF/VF, rather than
> reserving entries upfront.
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> > index 88d7f65d246c..cc5a2fde02b9 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>
> [ ... ]
>
> > +int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
> > +{
> > +	u16 mcam_idx[4] = { 0 }, pf_ucast, pf_pcifunc;
> > +	struct npc_mcam_alloc_entry_req req = { 0 };
> > +	struct npc_mcam_alloc_entry_rsp rsp = { 0 };
>
> [ ... ]
>
> > +	ret = rvu_mbox_handler_npc_mcam_alloc_entry(rvu, &req, &rsp);
> > +
> > +	/* successfully allocated index */
> > +	if (!ret) {
> > +		/* Copy indexes to local array */
> > +		for (i = 0; i < cnt; i++)
> > +			mcam_idx[i] = rsp.entry_list[i];
> > +
> > +		goto chk_sanity;
> > +	}
>
> [ ... ]
>
> > +chk_sanity:
>
> [ ... ]
>
> > +	/* LBK */
> > +	if (is_lbk_vf(rvu, pcifunc)) {
> > +		index = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_PROMISC_ID);
> > +		ret = xa_insert(&npc_priv.xa_pf2dfl_rmap, index,
> > +				xa_mk_value(mcam_idx[0]), GFP_KERNEL);
> > +		if (ret) {
>
> [ ... ]
>
> > +			ret = -EFAULT;
> > +			goto err;
> > +		}
> > +
> > +		goto done;
> > +	}
> > +
> > +	/* VF */
> > +	if (is_vf(pcifunc)) {
> > +		index = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_UCAST_ID);
> > +		ret = xa_insert(&npc_priv.xa_pf2dfl_rmap, index,
> > +				xa_mk_value(mcam_idx[0]), GFP_KERNEL);
> > +		if (ret) {
>
> [ ... ]
>
> > +			ret = -EFAULT;
> > +			goto err;
> > +		}
> > +
> > +		goto done;
> > +	}
> > +
> > +	/* PF */
> > +	for (i = NPC_DFT_RULE_START_ID, k = 0; i < NPC_DFT_RULE_MAX_ID &&
> > +	     k < cnt; i++, k++) {
> > +		index = NPC_DFT_RULE_ID_MK(pcifunc, i);
> > +		ret = xa_insert(&npc_priv.xa_pf2dfl_rmap, index,
> > +				xa_mk_value(mcam_idx[k]), GFP_KERNEL);
> > +		if (ret) {
>
> [ ... ]
>
> > +			ret = -EFAULT;
> > +			goto err;
> > +		}
> > +	}
> > +
> > +done:
> > +	return 0;
> > +err:
> > +	/* TODO: handle errors */
> > +	return ret;
> > +}
>
> If xa_insert() fails here, the MCAM entries that were allocated earlier
> via rvu_mbox_handler_npc_mcam_alloc_entry() are not freed before
> returning the error. Could this leak the MCAM entries?
>
> The comment indicates this is known incomplete error handling. For the
> PF case, partial xa_insert failures in the loop could also leave some
> entries inserted in the xarray while others are not, leading to an
> inconsistent state.
ACK

