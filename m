Return-Path: <netdev+bounces-96340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C7C8C5467
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 13:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29685285728
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 11:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AB146430;
	Tue, 14 May 2024 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzrOM0SW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C892B9B3;
	Tue, 14 May 2024 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687163; cv=none; b=F+AASUgAGoOZN9t7YV+Hr7B8za8D0mTQ8+akqs/S1LU65Nb5XKHLI67B00k9q3DzbUgbWayAE2cTZtMiqxkayD7MKJAYnAvcLcO8LOQD4j5i4ZBnU8m6RVTU+B9BiSYt7olQtQ6blw1imsoXezWosCz13FX7XYMrynu1f2E/9Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687163; c=relaxed/simple;
	bh=vzZi26UYR5VN7UyU7t24xek7Nj49k7x0ToivZqJNoVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3UMLCcwja+AS9K8VekUZCGCJu9pJ4eLcXRXZLdivmkeYIbw0x3XWZDFZ84qa/Gaq2yKVqQey2aSWS8FVUcS2VvuiTQY2buVmKwjPprRLf49Pm0yOhR4Yt8IM2Hs/60ePWGUZw0cPasCHkAviUKkMqcQw3exqXPo5AMaPYzXEXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzrOM0SW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2394C32782;
	Tue, 14 May 2024 11:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715687163;
	bh=vzZi26UYR5VN7UyU7t24xek7Nj49k7x0ToivZqJNoVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XzrOM0SW5VSxg91KiW8sorRhNb+bQIrAvWQkd0QOx6tW0AH44AI32vzllky6B0xiI
	 e0HitANm3oGvuSAUe1ze5cMHUh/fj9P/Sn5DbcCb9c5EoYGf6W9lYGNY0hI4GG4tDH
	 V3IYcQj0p/Or/a8gX5NJ8IVeeH2oKADthDzj6kxSxLGfWMoj18qRmOtFtZeLcgUowi
	 CDl/8WZcJ4/6uDbA5OkIGEFTpWv5nEAox1RGLUmPWJWSMA8vn98F3w2MLYRozeFd/g
	 ZS/vL/F/UvfPcRDbDQZYSCxdmCGI1dO4iEWkoWx3C/oNNCr2I4PIPgK9F3VEbTtLVu
	 0rG7FYNQrtSbQ==
Date: Tue, 14 May 2024 12:45:58 +0100
From: Simon Horman <horms@kernel.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Geethasowjanya Akula <gakula@marvell.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Jerin Jacob <jerinj@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>
Subject: Re: [EXTERNAL] Re: [net-next,v2 3/8] octeontx2-af: Disable
 backpressure between CPT and NIX
Message-ID: <20240514114558.GG2787@kernel.org>
References: <20240513105446.297451-1-bbhushan2@marvell.com>
 <20240513105446.297451-4-bbhushan2@marvell.com>
 <20240513161447.GR2787@kernel.org>
 <SN7PR18MB53149716909DE5993145509AE3E32@SN7PR18MB5314.namprd18.prod.outlook.com>
 <20240514104125.GD2787@kernel.org>
 <SN7PR18MB53148EC4FCE8C06611A284E6E3E32@SN7PR18MB5314.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR18MB53148EC4FCE8C06611A284E6E3E32@SN7PR18MB5314.namprd18.prod.outlook.com>

On Tue, May 14, 2024 at 11:26:54AM +0000, Bharat Bhushan wrote:
> Please see inline
> 
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>

...

> > > > I suspect 1 will have little downside and be easiest to implement.
> > >
> > > pfc_en is already a field of otx2_nic but under CONFIG_DCB. Will fix by
> > adding a wrapper function like:
> > 
> > Thanks. Just to clarify, my first suggestion was to move pfc_en outside of
> > CONFIG_DCB in otx2_nic.
> > 
> > >
> > > static bool is_pfc_enabled(struct otx2_nic *pfvf) { #ifdef CONFIG_DCB
> > >         return pfvf->pfc_en ? true : false;
> > 
> > FWIIW, I think this could also be:
> > 
> > 	return !!pfvf->pfc_en;
> > 
> > > #endif
> > >         return false;
> > > }
> > 
> > Also, I do wonder if the following can work:
> > 
> > 	return IS_ENABLED(CONFIG_DCB) && pfvf->pfc_en;
> 
> This is required at more than one place, so will keep wrapper function with this condition check.

Thanks, sounds good.

...

