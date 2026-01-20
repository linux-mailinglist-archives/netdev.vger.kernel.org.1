Return-Path: <netdev+bounces-251346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4403BD3BDEB
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 04:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B9EA34839D
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 03:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793963254BC;
	Tue, 20 Jan 2026 03:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IibjEuUp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD703246EC;
	Tue, 20 Jan 2026 03:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768879496; cv=none; b=JUCEbspypqQ7Xu4j074LZroeQcaVQ2phYDtCVnEmBr858GCFksYmmZ+X1ATqYfvfmIZVxILRRIQ4Au35qj2mZAHo4Mm8SZa0cWJ+YPgCZfsI0GDGXZ40sJO3v4P1RCt1bIGzzZ3YgCU8Bp2Yalkw3CsDfvh4vMGwafi9Wm6eOds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768879496; c=relaxed/simple;
	bh=maJ977cWygrpoH1KtLM9BqfmUd6szSNfA5eI1bu2ipI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfMvoHFWwERIcWIosqUyFxe45akXdYT1zTnuHgmIiZzMIh1MfUqMh/W2lPQDAHytfyLBb5148Fsdr2IF7CRKbUn9TiqjbCHfkoRmc0J6q/Gxq/aY3n9uWOQfi7ZfFniY7iGFr6cWCkL27Wm+0MDvww6UfQorMFsPpGWO1dMsXE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IibjEuUp; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JMk0WG2868898;
	Mon, 19 Jan 2026 19:24:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Ae8bm9wJNYT9frD4pfuP0Wqqm
	eJWo7niau7kFlh3aEI=; b=IibjEuUpObXip8zfgRa1NYYkUsiR/TctKZ819OPwy
	pVsXA40GZEtvImg8xZv+hH1JUtQIvJOzwCw62PpzPn2ORvX6MRj4Cii9I18WBKYv
	LYJK5CodXtMTCg4qP2hEkwUcSiMRyvpi7HeeROP9fvz4W44ZwQrKxSaOM48fNl9Q
	ke65sOcgFlPYA+gLOHUM/0GsZTcqJTxlOOTZ35I+JlXg6LpGkXxpZamKMsUycUAW
	TbEPePFrfdQm/EWDHvD5wUvikdV60Qx/+Gy9YxY4E3N8ZGqO7YkQLzQijOf7tgXp
	xdwYtXgC2XLj57eI7AMrd5Loqm9Pi0KYW6PyWanyE3QDA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4brv29bbe1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 19:24:51 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 Jan 2026 19:24:50 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 19 Jan 2026 19:24:50 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 387CE3F709F;
	Mon, 19 Jan 2026 19:24:48 -0800 (PST)
Date: Tue, 20 Jan 2026 08:54:48 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [net-next,v4,04/13] ocetontx2-af: npc: cn20k: MKEX profile
 support
Message-ID: <aW71gAmUhHD17h6x@rkannoth-OptiPlex-7090>
References: <20260113101658.4144610-5-rkannoth@marvell.com>
 <20260118004020.1044336-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260118004020.1044336-1-kuba@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDAyNiBTYWx0ZWRfX48QObavz2OOf
 JCe7/SdF0xbdiNz3G0CxMJCaj8E+WqBgr7rHyZniTDEpOOVcUPUNeW0U7X/of2oHUXf/IFrGLLf
 V00Q3ydPqquvN9eL5QHh8WS7RsELb4vhDzrJHtQmv3OLfjzXatV9EWHZ8r2tjuwVX7S98moZHpp
 /U8/rVYzOtTufeO6nvcq8ArIH3nU9B2nPmsPoE4+A3BJqDWHZUteZobIhe5Ff7/18y7OP/vsM8l
 xr5sNnFairEtSRK4qltgs+S+hKRhE5CLUwmnoBSZwsCLxMmWINZqJDQSotek5CnWQ1f1frS65l1
 6a8mtstGjJinSIXZdLBsFxUuGr2frUjspNPZG884ET07G7yABXowSCXobLLu9+5S4iKz5UqxchZ
 CvcsufUxSPOOUHPTTIkxeSS1EnIrFkjDYs09bT/pULl9MajVa1J6kAlc07T85+JROtBdZlS8H81
 4KYEea7cTgy0wjnQJ2w==
X-Authority-Analysis: v=2.4 cv=d9n4CBjE c=1 sm=1 tr=0 ts=696ef583 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9R54UkLUAAAA:8 a=VwQbUJbxAAAA:8 a=T8SPX7Xl44gxGUi8oY8A:9 a=CjuIK1q_8ugA:10
 a=16MAPSKLCI0A:10 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-ORIG-GUID: ZTUv2AKxu5s37n6ckBF-9zbfRRUcHjX7
X-Proofpoint-GUID: ZTUv2AKxu5s37n6ckBF-9zbfRRUcHjX7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_01,2026-01-19_03,2025-10-01_01

On 2026-01-18 at 06:10:20, Jakub Kicinski (kuba@kernel.org) wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> ocetontx2-af: npc: cn20k: MKEX profile support
>
> This patch adds MKEX (MicroCode Key EXtraction) profile support for the
> CN20K silicon variant, introducing a new parser profile with 24 extractors
> per packet parsing profile instead of the previous two layer-data
> information per key field type.
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> > index 0717fd66e8a1..c3f41f4ea99c 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>
> [ ... ]
>
> > +static u8 npc_map2cn20k_flag(u8 flag)
> > +{
> > +	switch (flag) {
> > +	case NPC_F_LC_U_IP_FRAG:
> > +		return NPC_CN20K_F_LC_L_IP_FRAG;
> > +
> > +	case NPC_F_LC_U_IP6_FRAG:
> > +		return NPC_CN20K_F_LC_L_IP6_FRAG;
> > +
> > +	case NPC_F_LC_L_6TO4:
> > +		return NPC_CN20K_F_LC_L_6TO4;
> > +
> > +	case NPC_F_LC_L_MPLS_IN_IP:
> > +		return NPC_CN20K_F_LC_U_MPLS_IN_IP;
> > +
> > +	case NPC_F_LC_L_IP6_TUN_IP6:
> > +		return NPC_CN20K_F_LC_U_IP6_TUN_IP6;
> > +
> > +	case NPC_F_LC_L_IP6_MPLS_IN_IP:
> > +		return NPC_CN20K_F_LC_U_IP6_MPLS_IN_IP;
> > +
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return -1;
> > +}
>
> [ ... ]
>
> > +int npc_cn20k_apply_custom_kpu(struct rvu *rvu,
> > +			       struct npc_kpu_profile_adapter *profile)
> > +{
>
> [ ... ]
>
> > +	for (kpu = 0; kpu < fw->kpus; kpu++) {
> > +		fw_kpu = (struct npc_kpu_fwdata *)(fw->data + offset);
>
> [ ... ]
>
> > +		npc_cn20k_update_action_entries_n_flags(rvu, profile);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Is it intentional to call npc_cn20k_update_action_entries_n_flags() inside
> the kpu loop? This function iterates through all kpus in the profile and
> remaps flag values from the old enum to the CN20K enum. When called
> multiple times, the mapping appears to be bidirectional:
>
>   First call:  NPC_F_LC_L_MPLS_IN_IP (2) -> NPC_CN20K_F_LC_U_MPLS_IN_IP (0x20)
>   Second call: 0x20 matches NPC_F_LC_U_IP_FRAG -> NPC_CN20K_F_LC_L_IP_FRAG (2)
>
> The old and new enum values overlap (2,3,4 map to 0x20,0x40,0x80 and
> vice-versa), so calling this function fw->kpus times will flip-flop the
> flag values. If fw->kpus is even, the flags will have incorrect values
> after the loop completes.
>
> Should the call be moved outside the loop, or should there be a guard to
> ensure it only runs once?
ACK.

>
> > +
> > +		for (entry = 0; entry < entries; entry++) {
> > +			profile->kpu[kpu].cam[entry] = cam[entry];
> > +			profile->kpu[kpu].action[entry] = action[entry];
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}

