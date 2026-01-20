Return-Path: <netdev+bounces-251339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE32D3BD02
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 02:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A9AC3028D7F
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 01:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D7823A9BD;
	Tue, 20 Jan 2026 01:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ap3q+GF/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D71B19CCF5;
	Tue, 20 Jan 2026 01:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873066; cv=none; b=DGVtDS4L3NtkMuEb1hNhAC0BsiEnuwnDsO7OGqovSQiddkGdJK5BG5JtQCTjc0L/Tq5Y4cU9dA4eyWQIhlVI9oQpvPaCy4rNUWmiKG+MkeOym0GsDFUhfRijN3ZoGtGyROi+nrhwudz1Nk3+iZ+/wgKWpRW7Ra+oiPdwuBmO7oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873066; c=relaxed/simple;
	bh=JMcW0uOUYe74ATcUaNZQss62+62Wlxv4Na4jaqwAFcI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYAERQObYe/3EUsSrtQEIWtkFOuA27LVG+75Bpl8MZ42w6deXG61o7k5OZt4SeFG6zNeM8+gGhaqXfhxvxY6rYJ3Ek+oiYzNGEI8eGCX6NIGDXsHIl0nJXePzalZKNjgk98VWGP0pebbJB6oC2XT4raKP/WDaYlREVLCpg0A7io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ap3q+GF/; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JNNdrV1487956;
	Mon, 19 Jan 2026 17:37:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=ncevGm0jinHFSP9WGHs+IMjYq
	XK8ok1Xt/PrlwmlCc0=; b=Ap3q+GF/VyS0Q2NWUCrvuHBP0Ajr8BxV/+1o0NAMp
	caBS+XTuIbin4/4YlewFddaaAxzeiv3aoTTQp9V7VuUSn1G+XjeFDYnSOS6pmQpP
	IcvHrPs1wh3XRurxOBI9NktKEMeCHI5hQsrMk2ihQErI4zhNelT0WcDiMsetitrJ
	lz8rWSMKdSAagZSmA+M2YCym7EiPgI/qJKqUUlxE3s/62RGcTqKc/3Q5A3Kp3eUU
	1+WOg8LwuWrWWdwbVmvgoawsir1TrirhyaMHigEjN8VdZL+FdLpZuobQGAo9WyHY
	9afeuRyz9YiqaMwmTW8nAz9qFej3ywWjjFMX3saJABLKg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4br8nncjcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 17:37:42 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 Jan 2026 17:37:40 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 19 Jan 2026 17:37:40 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 237423F7067;
	Mon, 19 Jan 2026 17:37:38 -0800 (PST)
Date: Tue, 20 Jan 2026 07:07:38 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [net-next,v4,05/13] octeontx2-af: npc: cn20k: Allocate default
 MCAM indexes
Message-ID: <aW7cYrYGtFgo8lHp@rkannoth-OptiPlex-7090>
References: <20260113101658.4144610-6-rkannoth@marvell.com>
 <20260118004024.1044368-1-kuba@kernel.org>
 <aW2oKKg73zwRNals@rkannoth-OptiPlex-7090>
 <20260119093245.0544f5ce@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260119093245.0544f5ce@kernel.org>
X-Proofpoint-ORIG-GUID: J8BtFhic3fym6SBoqLW4Ch3qZUNupWMx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDAxMiBTYWx0ZWRfX9afESlckkEqU
 BCXHciaqu/m+cui+/wszz65O2iOrsSlto0UiXmeDiwrfEo8cEAM5bMfSBeJMelqyR6rRxNtoww3
 KUwX4i4zgZ/A4TtUZwW+lXWO2PQtRWbOfCl+M0grPr2Y3HpKoS0QW7aVnAFKH4wUxWH6fed3Z8w
 uy97IGiqQKnUGE+kmIIxg6ITjEKV2gMcKwpxkFS1djPmnWQv4aROVMQfd5g2Xj1YD2Wd5KMtddo
 Y8yfE5vjHEyIgR5mBJqjEGfoMpO5Zgyd/elpSc1DIh9kmoV/sJdNhGy9mcZ/Zj6kw282rqemjaM
 r89r/nsvVsIjwfzCaDyMRi3wCEi61djiMb5BWn7vqwvGL3tEh+4XlkHP2EcvhdyloPiMLXtQ+jT
 xzo1dCZ3P5l+EN4AUaRFFDytbTcouirjf5HfsVMbg5mChdYlg+Z+lZrwElr88amGuwiSG+B14fv
 g1UmaWR8dyvVSrrmusA==
X-Proofpoint-GUID: J8BtFhic3fym6SBoqLW4Ch3qZUNupWMx
X-Authority-Analysis: v=2.4 cv=FcM6BZ+6 c=1 sm=1 tr=0 ts=696edc66 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=hK4Fb_7klQWKyjwAzxUA:9 a=CjuIK1q_8ugA:10
 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_01,2026-01-19_03,2025-10-01_01

On 2026-01-19 at 23:02:45, Jakub Kicinski (kuba@kernel.org) wrote:
> On Mon, 19 Jan 2026 09:12:32 +0530 Ratheesh Kannoth wrote:
> > > > -	if (attach->nixlf)
> > > > +	if (attach->nixlf) {
> > > >  		rvu_attach_block(rvu, pcifunc, BLKTYPE_NIX, 1, attach);
> > > > +		if (is_cn20k(rvu->pdev)) {
> > > > +			err = npc_cn20k_dft_rules_alloc(rvu, pcifunc);
> > > > +			if (err)
> > > > +				goto exit;
> > >                         ^^^^
> > >
> > > When npc_cn20k_dft_rules_alloc() fails after rvu_attach_block() has
> > > already attached the NIX LF, the error path jumps to exit without
> > > detaching NIX. The caller (otx2_init_rsrc in otx2_pf.c) assumes that on
> > > error nothing was attached, so it does not call otx2_detach_resources().
> > >
> > > Could this leave NIX LF attached without proper cleanup on allocation
> > > failure?
> > There is no proper error handling done for rvu_attach_block function (in existing code)
> > We can address this later as different patch ?
>
> Different patch, yes, but _before_ these patches are merged.
ACK.

