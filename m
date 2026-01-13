Return-Path: <netdev+bounces-249385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A7ED17E48
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5048B300A87B
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA3B3876D1;
	Tue, 13 Jan 2026 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="B44VjM7j"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C31825DB1A;
	Tue, 13 Jan 2026 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298896; cv=none; b=Bnw4SKaK0tGjwF98u1giceuRTqxwYn+GlTInFEa+1ZiYdPRESymGA8OlANypJ20y2MHd0wU3KuN6kY5FW+dwk8ganf909biCStPvRnQ5+/yq4Zst+Ey/o2Fll4x63UcaMuvh1wsrDTF1vUOZ0+NVWEufqfUGkF/h+0lVJq6Vbxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298896; c=relaxed/simple;
	bh=xyga5DvCMUZXUUhmPPrfTWpoQ4chO6cJgw5OoP0tA94=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sD6bi5cdyZ8Q2ddUdsEYc8xjuEhH7VseJLtl5h4W0UOa1Ie5/owM4b5ITzXYz0jAHWVA7gih6fq3CVJQHY+zLvacPMuvIKpNh5ArVFQ+SUU1b0bKdVGqC8TITy4GEuxTFcJS8UruEEHyAjeZlqSNLypYOIrlPJouOwPOnfksCjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=B44VjM7j; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D7QAZL3356504;
	Tue, 13 Jan 2026 02:08:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=xR8hh+CGo6v6m3f0TuMVtdsRg
	OweQFNmUIYCmuRtyhE=; b=B44VjM7jXgEWz6vbKCuwfs9/YE4dlN91/hbvDN2Gm
	w4Q1TI5oUhFJU80nUAUUel/J/SQ8kLMmCM2JvIRdm59jW1IphrA2XaTvsRU3iZhq
	Ewm7DH8hLsvlVX7B8xj57akJwCdo/soObUQERWQjz7npdZ2ipq8WRX3vOJeyWJAV
	bZnx5Z8lWMbEQToRqxGdeQwrFwrPBiR8r5ym5YSDCT9aQ59hPTBQ5+PBdlsreK+P
	p7Obg9pXjdQIUAOZXYEvznzPxPx366RldtDy218CCzqEimb+uWFC/13oAyyScRz6
	MPxixOQdohBbhgC07A1VTlrKH6n1mtPWZBEMun5MtRlIA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bnd2g8snd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 02:08:12 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 13 Jan 2026 02:08:27 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 13 Jan 2026 02:08:27 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 6DD623F709D;
	Tue, 13 Jan 2026 02:08:10 -0800 (PST)
Date: Tue, 13 Jan 2026 15:38:09 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [net-next,v3,01/13] octeontx2-af: npc: cn20k: Index management
Message-ID: <aWYZiWTX4Q9SkKko@rkannoth-OptiPlex-7090>
References: <20260109054828.1822307-2-rkannoth@marvell.com>
 <20260110225927.3900742-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260110225927.3900742-1-kuba@kernel.org>
X-Proofpoint-ORIG-GUID: fQ05Ey3WmFjfq2amN4NJdGLnKlI0OMYW
X-Authority-Analysis: v=2.4 cv=OvlCCi/t c=1 sm=1 tr=0 ts=6966198c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9R54UkLUAAAA:8 a=VwQbUJbxAAAA:8 a=HqkimtOEt4VUwEsin0UA:9 a=CjuIK1q_8ugA:10
 a=16MAPSKLCI0A:10 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-GUID: fQ05Ey3WmFjfq2amN4NJdGLnKlI0OMYW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA4MyBTYWx0ZWRfX6R+rK0uQznUU
 xAr6HPukIkyRCHhHfUMJGvR0oK3zOFPnK2/1iImkq3AZta3Ye674Fakad/K3OvGV43BdGgvV6+C
 932y7nqKxjetmk5Chc902jdNLu3tLcFeCeli4E4UhKo55/PNCRmOsJoukQ53wGL4Adml7FKPJlK
 qtFePWfmVEWtShkAIYjZxwuqimKgtCB8HPW8UD/FNsbQytwQJJ74FbEb5lOspXWIcBvLY9GjPvY
 Z1TXkYuPZ5qD8doelH7ZyNr+z582zBHZ9f9HMWfPQ5z4Up6xB4+dXRgl6AIoXJNjbGdxWIwhj6t
 IPQVL/hkYuID4VsuyXhZrYmIWhJdkdB3ZXXtAMLcksU1Lh+l9X6aNchKf6XNCx//AG05c2iOON2
 XH+yH4f3XVISgaHvGh1Tdg9RdQ0WJ2mqO3cWrGPXfB1PsNK/PahruXcxqmW1FNd365vrQ/Ve+xn
 rgLqRJlX0hc7113PR+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01

On 2026-01-11 at 04:29:27, Jakub Kicinski (kuba@kernel.org) wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least pausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> octeontx2-af: npc: cn20k: Index management
>
> This patch adds MCAM index management for CN20K silicon, implementing
> allocation schemes for contiguous and non-contiguous MCAM entry
> allocation across 32 subbanks.
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
> > index 498968bf4cf5..9360886c88e2 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
>
> [ ... ]
>
> > +static int
> > +npc_subbank_srch_order_parse_n_fill(struct rvu *rvu, char *options,
> > +				    int num_subbanks)
> > +{
> > +	unsigned long w1 = 0, w2 = 0;
> > +	char *p, *t1, *t2;
> > +	int (*arr)[2];
> > +	int idx, val;
> > +	int cnt, ret;
> > +
> > +	cnt = 0;
> > +
> > +	options[strcspn(options, "\r\n")] = 0;
> > +
> > +	arr = kcalloc(num_subbanks, sizeof(*arr), GFP_KERNEL);
> > +	if (!arr)
> > +		return -ENOMEM;
> > +
> > +	while ((p = strsep(&options, " ,")) != NULL) {
> > +		if (!*p)
> > +			continue;
> > +
> > +		t1 = strsep(&p, "=");
> > +		t2 = strsep(&p, "");
>
> If the user input does not contain an '=' character, strsep() will return
> NULL for t2 here.  The subsequent kstrtoint(t2, ...) call would then
> dereference a NULL pointer.  Should there be a check for t2 being NULL
> before using it?
ACK.

>
> > +
> > +		if (strlen(t1) < 3) {
> > +			dev_err(rvu->dev,
> > +				"Token length is less than 3 (%s, %s)\n",
> > +				t1, t2);
> > +			goto err;
> > +		}
>
> [ ... ]
>
> > +		ret = kstrtoint(t2, 10, &val);
> > +		if (ret) {
> > +			dev_err(rvu->dev,
> > +				"Could not convert token to integer (%s)\n",
> > +				t2);
> > +			goto err;
> > +		}
> > +
> > +		arr[cnt][0] = idx;
> > +		arr[cnt][1] = val;
> > +
> > +		cnt++;
>
> The loop writes to arr[cnt] before checking whether cnt exceeds
> num_subbanks.  If a user provides more tokens than expected, this could
> overflow the arr[] buffer.  The bounds check occurs after the loop
> completes, but by then the overflow may have already happened.  Would
> it make sense to check cnt < num_subbanks before writing to arr[cnt]?
ACK.

>
> > +	}
> > +
> > +	if (cnt != num_subbanks) {
> > +		dev_err(rvu->dev,
> > +			"Could find %u tokens, but exact %u tokens needed\n",
> > +			cnt, num_subbanks);
> > +		goto err;
> > +	}
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> > new file mode 100644
> > index 000000000000..c05c0feec41d
> > --- /dev/null
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>
> [ ... ]
>
> > +static int __maybe_unused
> > +npc_add_to_pf_maps(struct rvu *rvu, u16 mcam_idx, int pcifunc)
> > +{
> > +	int rc, idx;
> > +	void *map;
> > +
> > +	dev_dbg(rvu->dev,
> > +		"%s:%d add2maps mcam_idx(%u) to xa_idx2pf map pcifunc=%#x\n",
> > +		__func__, __LINE__, mcam_idx, pcifunc);
> > +
> > +	rc = xa_insert(&npc_priv.xa_idx2pf_map, mcam_idx,
> > +		       xa_mk_value(pcifunc), GFP_KERNEL);
> > +
> > +	if (rc) {
> > +		map = xa_load(&npc_priv.xa_idx2pf_map, mcam_idx);
> > +		dev_err(rvu->dev,
> > +			"%s:%d failed to insert mcam_idx(%u) to xa_idx2pf map, existing value=%lu\n",
> > +			__func__, __LINE__, mcam_idx, xa_to_value(map));
> > +		return -EFAULT;
> > +	}
> > +
> > +	map = xa_load(&npc_priv.xa_pf_map, pcifunc);
> > +	idx = xa_to_value(map);
> > +
> > +	rc = xa_insert(&npc_priv.xa_pf2idx_map[idx], mcam_idx,
> > +		       xa_mk_value(pcifunc), GFP_KERNEL);
> > +
> > +	if (rc) {
> > +		map = xa_load(&npc_priv.xa_pf2idx_map[idx], mcam_idx);
> > +		dev_err(rvu->dev,
> > +			"%s:%d failed to insert mcam_idx(%u) to xa_pf2idx_map map, earlier value=%lu idx=%u\n",
> > +			__func__, __LINE__, mcam_idx, xa_to_value(map), idx);
> > +		return -EFAULT;
> > +	}
>
> If the second xa_insert() fails, the entry inserted by the first
> xa_insert() into xa_idx2pf_map is not cleaned up.  This leaves the two
> maps in an inconsistent state.  Should the first entry be erased when
> the second insert fails?
ACK.
>
> [ ... ]
>
> > +static int npc_priv_init(struct rvu *rvu)
> > +{
> > +	struct npc_mcam *mcam = &rvu->hw->mcam;
> > +	int blkaddr, num_banks, bank_depth;
> > +	int num_subbanks, subbank_depth;
> > +	u64 npc_const1, npc_const2 = 0;
> > +	struct npc_subbank *sb;
> > +	u64 cfg;
> > +	int i;
> > +
> > +	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> > +	if (blkaddr < 0) {
> > +		dev_err(rvu->dev, "%s:%d NPC block not implemented\n",
> > +			__func__, __LINE__);
> > +		return -ENODEV;
> > +	}
> > +
> > +	npc_const1 = rvu_read64(rvu, blkaddr, NPC_AF_CONST1);
> > +	if (npc_const1 & BIT_ULL(63))
> > +		npc_const2 = rvu_read64(rvu, blkaddr, NPC_AF_CONST2);
> > +
> > +	num_banks = mcam->banks;
> > +	bank_depth = mcam->banksize;
> > +
> > +	num_subbanks = FIELD_GET(GENMASK_ULL(39, 32), npc_const2);
> > +	npc_priv.num_subbanks = num_subbanks;
> > +
> > +	subbank_depth =	bank_depth / num_subbanks;
>
> If npc_const1 does not have bit 63 set, npc_const2 remains 0, and
> num_subbanks will be 0.  This would cause a division by zero here.
> Should there be a check that num_subbanks is non-zero before this
> division?
ACK.

