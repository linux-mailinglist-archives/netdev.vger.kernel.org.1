Return-Path: <netdev+bounces-209790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E04D7B10E17
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 16:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B21E7B541E
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 14:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292522E92BB;
	Thu, 24 Jul 2025 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="QQJh+yB4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D982E92BA
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368675; cv=none; b=kFpMUPp/pE9uVXsQlHkgINZgiLCzFgOnuqohvQ3EXtJwUH8hiBEyUzkXuYfXsQmK4pbGIBglEhK84IVEiPk23TlieRQcveBTZcEBZV6hU2EaQl/WSDzmDu3mIAefe4Aqv6OiIW2MqLfLKwX0w7vzadzUqukiV+b7rFFZHbTgZCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368675; c=relaxed/simple;
	bh=xF2dClkg3M9HprN85JtU9dodP0neFUB2RJ1/jt/2+0g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDca2EtFNg2QX+loFrGD2d5OJMPgqRGLp8ikBmoT7OaWGlRc2IKicGUQ5CMMWOAMRdNkbQadj1AG+b2Ud8x6VineLkTLR38Oex2/Toi6i5eYgA2SCCEF7kXDPeWfK3GDQDfXLL2G8oc9gy2EtvDiPqZqx22GyxyyJrepbPhaqC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=QQJh+yB4; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OEMbVR018212;
	Thu, 24 Jul 2025 07:51:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=ND0VNZs1tkQ5/0Lz5wjXAq5rN
	+zSfSyh6zUNSk/HwtU=; b=QQJh+yB4pc0pUl4I4VwxwMufQVQCIWQkwHtkpDCII
	WEdO4ORYQpWvv6ZDOqTIg1PPnKeaPeCAUae9QqSi29AWUqNrbzRqDplhacBMI4CX
	6/Hv3ABMfx8iTxR3wgA0VsZG9J+8LJ0uVEAEgn1ZVJC7pfFOfcs6szrPM73l7ENN
	xuv/i73MmBBDYM+2IlaYeGW4IAYZSieP4nZGVx2oK4urLqoLCA0GTFlQNW63TkrL
	PghnaddvmOSiqSP9OoV9t2lNd2zRXdCPvUOO7bnF7Nhg2WXrejBEKIm6sOE0vA36
	NBuW2H7z6V4G5NUwvOIWFbPOD/TcHWfH0XdSNUJULcgAg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 483kde8g2k-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 07:51:03 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 24 Jul 2025 07:50:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 24 Jul 2025 07:50:46 -0700
Received: from opensource (unknown [10.29.20.14])
	by maili.marvell.com (Postfix) with SMTP id D2CC23F708D;
	Thu, 24 Jul 2025 07:50:41 -0700 (PDT)
Date: Thu, 24 Jul 2025 14:50:40 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>
Subject: Re: [net-next PATCH v3 01/11] octeontx2-af: Simplify context writing
 and reading to hardware
Message-ID: <aIJIQDtlx7WJtftf@opensource>
References: <1752772063-6160-1-git-send-email-sbhatta@marvell.com>
 <1752772063-6160-2-git-send-email-sbhatta@marvell.com>
 <20250722162743.GN2459@horms.kernel.org>
 <20250722162950.GO2459@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250722162950.GO2459@horms.kernel.org>
X-Authority-Analysis: v=2.4 cv=P4Q6hjAu c=1 sm=1 tr=0 ts=68824857 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=NOyLQWl8sNbytOs2YR4A:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-GUID: q4Jo5MINaMkwvGshStdzmSZ-z4Oc0CPd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDExMyBTYWx0ZWRfX+hKIGgpm/RaS pkMlE/3YURSPcm/X7KIwTGIJsctpm8tguzdmLm3QtUHRy6VeufGUtusYfir3yd2M6YLbVzi7jsz 3XcuzI2LYr4pTzA95C6sYk7POehiBvo1D04INTpWxFzymgbE2D/RWM2GF4R/ayHzlf1hax4ZPFx
 Og2+x2l6ePf7NnnoLonMAc1FSuMKoeg0kCpEH4yV1XF4HgaHM7P1IcB2dQ26c4iF1b5htAsnIqP Eb6Sws13qOWNvJj9X1xd/OxT0Ny6iJ7DsK/l0PdzBtJwoqYwwzGxR3yoPz0TdG06xj7tHbAC30H 5GvvPCClyox67xLXdeAqkSZQIpwBs22+2YQeNIPT3e7S8fTJ1s6SEdnO7+vKl18cxaWUuPDdLVR
 RF9IEDMLXNgsD/F5mmzAV/BLcu+QoIhRQLmHtEPB6amyukElpcTQqs429sZ0o8Hnu+kB/2NT
X-Proofpoint-ORIG-GUID: q4Jo5MINaMkwvGshStdzmSZ-z4Oc0CPd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01

Hi Simon,

On 2025-07-22 at 16:29:50, Simon Horman (horms@kernel.org) wrote:
> On Tue, Jul 22, 2025 at 05:27:43PM +0100, Simon Horman wrote:
> > On Thu, Jul 17, 2025 at 10:37:33PM +0530, Subbaraya Sundeep wrote:
> > > Simplify NIX context reading and writing by using hardware
> > > maximum context size instead of using individual sizes of
> > > each context type.
> > > 
> > > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> > 
> > ...
> > 
> > > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
> > > index 0596a3ac4c12..1097c86fdc46 100644
> > > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
> > > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
> > > @@ -13,6 +13,8 @@
> > >  
> > >  #define RVU_MULTI_BLK_VER		0x7ULL
> > >  
> > > +#define NIX_MAX_CTX_SIZE		128
> > > +
> > >  /* RVU Block Address Enumeration */
> > >  enum rvu_block_addr_e {
> > >  	BLKADDR_RVUM		= 0x0ULL,
> > > @@ -370,8 +372,12 @@ struct nix_cq_ctx_s {
> > >  	u64 qsize		: 4;
> > >  	u64 cq_err_int		: 8;
> > >  	u64 cq_err_int_ena	: 8;
> > > +	/* Ensure all context sizes are minimum 128 bytes */
> > 
> > Would this be better phrased as follows?
> > 
> > 	/* Ensure all context sizes are 128 bytes */
> > 
> > > +	u64 padding[12];
> > >  };
> > >  
> > > +static_assert(sizeof(struct nix_cq_ctx_s) == NIX_MAX_CTX_SIZE);
> > 
> > I would suggest adding +static_assert() for all the
> > drivers that you expect to be NIX_MAX_CTX_SIZE.
> > 
> > So also:
> > - struct nix_rq_ctx_s
> > - struct nix_sq_ctx_s
> > - struct nix_bandprof_s
> 
> Likewise for new structures added by subsequent patches.

Sure. I will add for all structures

Thanks,
Sundeep
> 
> ...

