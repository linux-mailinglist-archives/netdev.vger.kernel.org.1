Return-Path: <netdev+bounces-209791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 412A6B10E15
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 16:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E50A1CE7C1A
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 14:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8342E8DE4;
	Thu, 24 Jul 2025 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="G0BrbHE7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538622DCF50
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368716; cv=none; b=Jq5JLpldymA3X4dOvHr0b2fndI6gCAaqLLJonZK3Kn8VSr3D2LVPFLshd5kPwAm0ZEfzw4iqMwFj99Nr5871jultIkBXfTvj1dhpRjrsbpEdtfD/7cd6DKACgn+XE1m0qyBEhA/Rj9VYzqfThB8L8UUgPUfO4/jyQdQ2Fey9teA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368716; c=relaxed/simple;
	bh=wVTgIoRKy0W2yNYInxU+dbVlNvmw6A/R8g12N9P2owM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7pSU7YDf/VK56A1n0Ci9M5Vu79UngdZyR7ypcdHqmZqibHoggY+dG69FjMDD/db6/eBX/GRR0aT08GfUAkKjxOEyVQyQrLVdRusC7MO6VwMqWsQ3uTLN1NOfcC+gbN98oqL0O+QRP4MSX74prdaDBKCNrfYNjXr2ZqCHRJ88mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=G0BrbHE7; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OEMm9Z015422;
	Thu, 24 Jul 2025 07:51:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=bBIx1nFRrIL4uQvgTlps9r7vN
	jvYYx/Xvq5obyARjA4=; b=G0BrbHE7q2sX36i9q7dAyo+FyIVjh4vs4pwnXlXOD
	oAZ6mh2BSmJ1VqqcypUe11wheYqBBn+SkEN6daLXQMdY49H78hLegoM/rpirKv4C
	NvT1W+RFon9HiY9sSoX5/L/vBjheDaebKBJhZwtSxgzQtmenCgycf+Ould7O6Gum
	TP20475IabE7gcnEjvAS5ESboFZOTtz1g+IOcLvGBDoNmK2PbEcaUArq/uz+H84q
	AKNC1sB2czfzg01vBU9aQcRqE7ed8h92P2woECu61uKcJBDDbzzfB2sp1RiBlfgc
	vnm0P/7oTvM//cvC147LNTi1kqVF6Lr+WKknNMRKMXKOg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 483keu0fmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 07:51:46 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 24 Jul 2025 07:51:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 24 Jul 2025 07:51:46 -0700
Received: from opensource (unknown [10.29.20.14])
	by maili.marvell.com (Postfix) with SMTP id 932313F7068;
	Thu, 24 Jul 2025 07:51:41 -0700 (PDT)
Date: Thu, 24 Jul 2025 14:51:40 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>
Subject: Re: [net-next PATCH v3 03/11] octeontx2-af: Extend debugfs support
 for cn20k NIX
Message-ID: <aIJIfHMwk5q1PnGM@opensource>
References: <1752772063-6160-1-git-send-email-sbhatta@marvell.com>
 <1752772063-6160-4-git-send-email-sbhatta@marvell.com>
 <20250722164027.GR2459@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250722164027.GR2459@horms.kernel.org>
X-Authority-Analysis: v=2.4 cv=FeE3xI+6 c=1 sm=1 tr=0 ts=68824882 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=InTIS5cwANq-F0pGvIkA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-ORIG-GUID: fjV1e9o38lVSM4BPb30Yp613y6ioGxqG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDExMyBTYWx0ZWRfX0PczcCjU65+Y bRmRLsY72JG4VFPNgRHAreJbprk9MJpUWp+c4/xoQys8nuzeT/PbD5t2/d+3FDX8GTFCiht9nAn zKlpIOpIraJ4/zeBf4MiUfeY9ELW9FEs23nKJgq4RnLhWkf9bMiYGE0zTbIO/fuEsl7q9FvCrKa
 HbtmPKvJt5/wzoiCDYINL8OmxEMdBLg8a98flnVMcOVoRjVRIX2953GEhn64KeXKUAHFAl280+O wvJNtHRa1LuYwAPbogXkXzcLPQYkQBUQzrvp0S6v2arfY2iXhW/wEQpJ1SAvtWCfnC3fPIuZL84 Bgz7hWvcRXf4qXiPs34I5fAiaaMdHR0pOjlBFHWI3g+Gjx6ljWyQ/xAPU7OkhWAztO6VIlOB33s
 ajKXHLHYM6CdwQhjEdX07JQjfspAsZOUtkJeGyQbdXNrWMpZH2sayRUO1VTGLxWi0kTR1Ot0
X-Proofpoint-GUID: fjV1e9o38lVSM4BPb30Yp613y6ioGxqG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01

On 2025-07-22 at 16:40:27, Simon Horman (horms@kernel.org) wrote:
> On Thu, Jul 17, 2025 at 10:37:35PM +0530, Subbaraya Sundeep wrote:
> > Extend debugfs to display CN20K NIX send, receive and
> > completion queue contexts.
> > 
> > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
> 
> ...
> 
> > +void print_nix_cn20k_sq_ctx(struct seq_file *m,
> > +			    struct nix_cn20k_sq_ctx_s *sq_ctx)
> > +{
> 
> ...
> 
> > +	seq_printf(m, "W11: octs \t\t\t%llu\n\n", (u64)sq_ctx->octs);
> > +	seq_printf(m, "W12: pkts \t\t\t%llu\n\n", (u64)sq_ctx->pkts);
> > +	seq_printf(m, "W13: aged_drop_octs \t\t\t%llu\n\n", (u64)sq_ctx->aged_drop_octs);
> > +	seq_printf(m, "W13: aged_drop_pkts \t\t\t%llu\n\n", (u64)sq_ctx->aged_drop_pkts);
> 
> nit: please line-wrap the above two lines.
> 
Okay

Thanks,
Sundeep

> > +	seq_printf(m, "W14: dropped_octs \t\t%llu\n\n",
> > +		   (u64)sq_ctx->dropped_octs);
> > +	seq_printf(m, "W15: dropped_pkts \t\t%llu\n\n",
> > +		   (u64)sq_ctx->dropped_pkts);
> > +}
> 
> ...

