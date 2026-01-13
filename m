Return-Path: <netdev+bounces-249386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEED5D17E84
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04CFC30783F5
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F4E378D93;
	Tue, 13 Jan 2026 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="H/p9X1N+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5B830CDB1;
	Tue, 13 Jan 2026 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298927; cv=none; b=Xc7BIZ4kD2rU7A5a+2psKJJRx0FliYAj+ks/w2vjQtn93iqZKY7wPb4AB5cLcHmuv78BLdzdOAblgiWXy1GZItrF/Gf2+fDXUZj8cJQsr4PzA5n+KFKSr0xuKoVpS7e2wEk60UbGmGJ3ZBzSCYlD3Z9qFfE14jpKKFpkviZD0d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298927; c=relaxed/simple;
	bh=fqFPbYw5oLvWFytjK2wRi6gOc7giQlP6DGJIFe/qWRk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMpTq/k0LJhVQe8a9oBw0b5yQ39im/uZ8q/zYKQNb68QvL4AL9tAtI5bZblx6a7fsPJWIXrmdmHflLS1KwT71K4Gcq8OH6yngq6O+2y6dBOtTkkwkuCnNz9ai4hAHAVs6NbnL9loV9v/D0vumm7iHZj35s+6yjbQ6P9IskJhPxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=H/p9X1N+; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D7Q8n42460637;
	Tue, 13 Jan 2026 02:08:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=kA5qBBF4ozMFQD07x/hlX7pww
	cqT/3U5H8hPC4vZpT4=; b=H/p9X1N+IxmdSMvv+83aCe4aoLelSshJHf3zh+92j
	i17QO0UZ48hUxASxZ/3JI0YXVDYWQENPxLeF4f/UVq6a0GoRcSaLWohrSQAll4dB
	hw3FtlhWIyZ9616gV1Vu8b96d5tR/P3T2Gu6WWFaCIQXtp+q3uWcuV2ewXBCySxy
	7xG/OeJ3Hk9ZLLO5+GDcdWWlglZTTt7p7FFSmVYmZKhrNzei1tCGMVXLLWkiDiQl
	lEUowqt9rYzQANH3x6nYaTcz+nKbwWDmUrSCCzlkr/dCpKU77bfNxmsbEz6cId/6
	1MhvoQPU+iYVo7KqbImHgBcpeZxgKxU47VL8VXGu144UQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bmvfkbcf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 02:08:37 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 13 Jan 2026 02:08:52 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 13 Jan 2026 02:08:52 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 8E5DB3F709C;
	Tue, 13 Jan 2026 02:08:34 -0800 (PST)
Date: Tue, 13 Jan 2026 15:38:33 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next v3 01/13] octeontx2-af: npc: cn20k: Index
 management
Message-ID: <aWYZoXZXsYU-_u8n@rkannoth-OptiPlex-7090>
References: <20260109054828.1822307-1-rkannoth@marvell.com>
 <20260109054828.1822307-2-rkannoth@marvell.com>
 <20260110145114.0533cb52@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260110145114.0533cb52@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA4NSBTYWx0ZWRfXwFYUWRInu4G9
 NRoQu7xfn2Cm9J62Cs6LjHjFcyrPIfA10sfuGYEohwwOmK/52fxHZH/FxLvWu4ZFaUYr6W+2Hah
 h9Xj548mpmtyj4mISX3pr68JH+jwyhgZqev22npuRFEp7aoN/BDxB/1v3u0e9dwIxPnFU30yV9S
 TiDM/GmsMD+8E3/IKYkuPkDmJNc0FhWhDnI2pi6Dl9CLP9J+SuTyjCu+MXG/5A66WU0JtU4YSsx
 ATOP8UvQ+1gX+F+f73sLibZaCaLA6ov4uz4hzMJnuJzdmTpliUQmftQMcqAUz5fBvtzirdjnLI3
 3pOEOMfnrR+wHveaE8i8n2uU7zur7dKyDq9ogs5GX8G7x3AZyz6InA6WxsuZteC2Kk0jCDNlP7o
 Mqw3FupHYVmJlRvJvWfemAiQyu8dgbTDKh+xmqSoZejQ0fYaD7nPMS02ZZAxT+FrSZuGzizK24R
 CoCYUFA05vd3bkTJHxA==
X-Proofpoint-GUID: M48IZI2Bpq4Q55IXiXfRf2NfaknSHb2G
X-Proofpoint-ORIG-GUID: M48IZI2Bpq4Q55IXiXfRf2NfaknSHb2G
X-Authority-Analysis: v=2.4 cv=AZe83nXG c=1 sm=1 tr=0 ts=696619a6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=fhcEZZ2jcmKIN_m_G_AA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01

On 2026-01-11 at 04:21:14, Jakub Kicinski (kuba@kernel.org) wrote:
> On Fri, 9 Jan 2026 11:18:16 +0530 Ratheesh Kannoth wrote:
> > +/**
> > + * struct npc_priv_t - NPC private structure.
> > + * @bank_depth:		Total entries in each bank.
> > + * @num_banks:		Number of banks.
> > + * @subbank_depth:	Depth of subbank.
> > + * @kw:			Kex configured key type.
> > + * @sb:			Subbank array.
> > + * @xa_sb_used:		Array of used subbanks.
> > + * @xa_sb_free:		Array of free subbanks.
> > + * @xa_pf2idx_map:	PF to mcam index map.
> > + * @xa_idx2pf_map:	Mcam index to PF map.
> > + * @xa_pf_map:		Pcifunc to index map.
> > + * @pf_cnt:		Number of PFs.A
> > + * @init_don:		Indicates MCAM initialization is done.
> > + *
> > + * This structure is populated during probing time by reading
> > + * HW csr registers.
> > + */
> > +struct npc_priv_t {
> > +	int bank_depth;
> > +	const int num_banks;
> > +	int num_subbanks;
> > +	int subbank_depth;
> > +	u8 kw;				/* Kex configure Keywidth. */
> > +	struct npc_subbank *sb;		/* Array of subbanks */
> > +	struct xarray xa_sb_used;	/* xarray of used subbanks */
> > +	struct xarray xa_sb_free;	/* xarray of free subbanks */
> > +	struct xarray *xa_pf2idx_map;	/* Each PF to map its mcam idxes */
> > +	struct xarray xa_idx2pf_map;	/* Mcam idxes to pf map. */
> > +	struct xarray xa_pf_map;	/* pcifunc to index map. */
> > +	int pf_cnt;
> > +	bool init_done;
> > +};
>
> Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:93 struct member 'num_subbanks' not described in 'npc_priv_t'
> Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:93 struct member 'init_done' not described in 'npc_priv_t'
> Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:93 struct member 'num_subbanks' not described in 'npc_priv_t'
> Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:93 struct member 'init_done' not described in 'npc_priv_t'
ACK.
> --
> pw-bot: cr

