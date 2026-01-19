Return-Path: <netdev+bounces-250963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE769D39D75
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 05:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A0993006A75
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 04:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3038207A32;
	Mon, 19 Jan 2026 04:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HpJBKBD5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FD13FEF;
	Mon, 19 Jan 2026 04:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768796253; cv=none; b=BxlvemWe/0+l6Pr0+dmg1rKnX28QjF0Uv+SqIneT28Dy8Zns7vo+mDZyLaYVYknjl/RU5uCbbPHxejkhi+AmA75uPR0rFc3gY5HTOjjFGDJzURSOzRq+ifgRkj7wG9Zc7o/e0lf1Yd4D4EbfRDCeTKUPNUV5hPzoc4TxJwC1hS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768796253; c=relaxed/simple;
	bh=26e1nYXY21Ypq0tK+V6EDx0VlMOZ2Fj0d7F4horydqY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwBT59zmXbfW/75OJz3b5wJOST/rEHz2GOYnpJhpzA3ghgnk7lVh/AClkI5wgJIsSmQTg7DI87dwInDpPBrSzQ7bR27THbMaieIEaHqY1hwh6Wivsm1Kc2+jM/la+0LOQkJ2E5UGesLJL9UM15SJHoqUZ+Sb6KGGw0t4H7lkJhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HpJBKBD5; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60INSU1c1441154;
	Sun, 18 Jan 2026 20:17:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=48Dp4mHoAI64sipMMKUMQrUMe
	DycfuESfeYHE+8BiqM=; b=HpJBKBD5Ssq1FdDz2zFsKLishFTEhTJFM4qOPRxWL
	fUWbKXFMZ4AthqoybGBICjZ+v1ZI5TnvqYOPSqY1WMHrPkoI1LSlilO4vUSIUKeI
	MZ7MMq8zsw9pH9zhDKVn44ccaxTxytv0GIlOhemoutCULdIzgUHlQCfKGqBhuOs/
	rNlbRP4ouE+ncLcvjCI9KS9oLJkIV95FTM96lrOZqseevr7ordqezue6WCZWjSPc
	A2p6a0kIV/Idcr8k2lWAJsIa1Hnk5kumdTFLevRLD2UbqrQM/CadbSxlbF3UFyXX
	VW1UywGSAF0MB/9VaTuTREtWLbybu9CB5npwSqFPhtB6w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bryjc901v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Jan 2026 20:17:29 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 18 Jan 2026 20:17:28 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 18 Jan 2026 20:17:28 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 6F7653F707F;
	Sun, 18 Jan 2026 20:17:26 -0800 (PST)
Date: Mon, 19 Jan 2026 09:47:25 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>, <sumang@marvell.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [net-next,v4,04/13] ocetontx2-af: npc: cn20k: MKEX profile
 support
Message-ID: <aW2wVTnV_WNsyX70@rkannoth-OptiPlex-7090>
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
X-Proofpoint-GUID: OHrg9CwYCxRgGtN2u57udKwcodz4H6O8
X-Proofpoint-ORIG-GUID: OHrg9CwYCxRgGtN2u57udKwcodz4H6O8
X-Authority-Analysis: v=2.4 cv=RuDI7SmK c=1 sm=1 tr=0 ts=696db059 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9R54UkLUAAAA:8 a=VwQbUJbxAAAA:8 a=T8SPX7Xl44gxGUi8oY8A:9 a=CjuIK1q_8ugA:10
 a=16MAPSKLCI0A:10 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDAzMiBTYWx0ZWRfX7SexwDlCtmkg
 Qqu6NS8+ejkWwO5QWU7WtGHPREB1DZyOHtYubVSE853Jp9xkPYkX4g0o+UbB5K53OAJwW4fc6ja
 //mk5VvoW4awJKtSTEBm6YgrJ1VSEv9dKFHFiGjX2TrUtuKoxKsMgQ4WeFZlYj9XNAxp7pkWrPE
 sdT/FleZ3l0H70wpFgwWOIPkVmOUWfXAHc/XcQ6zR+3x8GK22uv14AaZy4QfimBf8fPEltMwrqL
 L97uwxNexKeLxV+QuU6YQbmn15Fc6jc6vikRjIjBrJo4JvlFxfLc83pUmE0k/IW5l9pHhHGP4hc
 rKhcalfUjnN/XyzgOercIZthp6ib+lHkW3WDvsTqpFw7boNImm06O35ms1Jq7REXhmowb+Lkoxw
 5vURgsBI+GHj0TTeTkl/lWyZv9hXiCIo0r88kVyorlOkD7yhQ7BpjBxGuxhf+C82VqjgsfMcQiL
 82UetMgjOJ7Kp7YsK7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-18_02,2025-10-01_01

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
Suman, Could you please check this comment ?

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

