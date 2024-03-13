Return-Path: <netdev+bounces-79648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E3387A5FA
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 11:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62D91C212AD
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 10:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1055F383BD;
	Wed, 13 Mar 2024 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAN8ArOY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C473E476
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710326287; cv=none; b=mk3KCarFU51jldeyFs6cFmJ7JEQtFXFFaICXB90FlnpgyWm7MeB4Yg0o5diJFlUkDOTIYyw7AO8qWoNmKg/IbE9RBtacdm5T4uWPUdGoC7VCzYCmvZK2nDAxp42/OJlj24qT45HSdQdj1MBRNHmj/0iDxW/llQnCJpPHw6sYNNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710326287; c=relaxed/simple;
	bh=E/fdKp31WnGbUcp4J9/fqw3qqeVuoRP+lnWF5szQNrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvDlX3YCqVU4vPIP9w+M9mR8rgS39/tC7EbMBi9+nBrn9mnCCPGMm4BwhRFT4zvAUp6KGk/WIeInaaMMJOJ56II/ZE2VaF9DJ4ZwHXBZ1MH7EYHR4HyQYVofJPA14ZtqDSEFZw3lRnTVcQv0hEO4nrp7V6I/gI6nFbOgk4gbiIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAN8ArOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CE4C433C7;
	Wed, 13 Mar 2024 10:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710326286;
	bh=E/fdKp31WnGbUcp4J9/fqw3qqeVuoRP+lnWF5szQNrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BAN8ArOYnCwLN5D42dexAQoSSp3EQI0LOA4zaszji0b5svZ3VrIzY+4MMxaJ4DKMv
	 aJPQyMLkFmhDFfJxF9Z3TdDEx04hm79X6VUWkJjkwX02Q3KFjVrA5LC57XNNTcmbJ8
	 +Ub7TiYDhrZSUIQHWFSxurMnCHshSCpJ43n+k1g6Ojs12VtfCgvEFgzXcpPUO2Kgju
	 rKAek14xOrGqcrtNpsm11fjUWHPUTtUIsEjXXsrMeImGAU+5Cxzdrb4Qiq/CuvgrJF
	 zX4ehPHKPvfxZK+60BWuvhfF77Z93gbzlwKOm78yBhHCyobkGm3fss3Z5nByKZAR9i
	 nHI6gpeTiEAow==
Date: Wed, 13 Mar 2024 12:38:02 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	devel@linux-ipsec.org, Eyal Birger <eyal.birger@gmail.com>
Subject: Re: [PATCH ipsec-next v3] xfrm: Add Direction to the SA in or out
Message-ID: <20240313103802.GZ12921@unreal>
References: <8ca32bd68d6e2eee1976fd06c7bc65f8ed7e24d3.1710273084.git.antony.antony@secunet.com>
 <20240313085430.GW12921@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313085430.GW12921@unreal>

On Wed, Mar 13, 2024 at 10:54:30AM +0200, Leon Romanovsky wrote:
> On Tue, Mar 12, 2024 at 08:59:29PM +0100, Antony Antony wrote:
> > This patch introduces the 'dir' attribute, 'in' or 'out', to the
> > xfrm_state, SA, enhancing usability by delineating the scope of values
> > based on direction. An input SA will now exclusively encompass values
> > pertinent to input, effectively segregating them from output-related
> > values. This change aims to streamline the configuration process and
> > improve the overall clarity of SA attributes.
> > 
> > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > ---
> > v2->v3:
> >  - delete redundant XFRM_SA_DIR_USET
> >  - use u8 for "dir"
> >  - fix HW OFFLOAD DIR check
> > 
> > v1->v2:
> >  - use .strict_start_type in struct nla_policy xfrma_policy
> >  - delete redundant XFRM_SA_DIR_MAX enum
> > ---
> >  include/net/xfrm.h        |  1 +
> >  include/uapi/linux/xfrm.h |  6 +++++
> >  net/xfrm/xfrm_compat.c    |  7 ++++--
> >  net/xfrm/xfrm_device.c    |  5 +++++
> >  net/xfrm/xfrm_state.c     |  1 +
> >  net/xfrm/xfrm_user.c      | 46 +++++++++++++++++++++++++++++++++++----
> >  6 files changed, 60 insertions(+), 6 deletions(-)
> 
> <...>
> 
> > diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> > index 3784534c9185..481a374eff3b 100644
> > --- a/net/xfrm/xfrm_device.c
> > +++ b/net/xfrm/xfrm_device.c
> > @@ -253,6 +253,11 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
> >  		return -EINVAL;
> >  	}
> > 
> > +	if (xuo->flags & XFRM_OFFLOAD_INBOUND && x->dir == XFRM_SA_DIR_OUT) {
> > +		NL_SET_ERR_MSG(extack, "Mismatched SA and offload direction");
> > +		return -EINVAL;
> > +	}
> 
> It is only one side, the more comprehensive check should be done for
> XFRM_SA_DIR_IN too.
> 
> if ((xuo->flags & XFRM_OFFLOAD_INBOUND && x->dir == XFRM_SA_DIR_OUT) ||
> !((xuo->flags & XFRM_OFFLOAD_INBOUND) && x->dir == XFRM_SA_DIR_IN))

(!(...) ... ) and not !((....) ... ).

> ....
> 
> and IMHO, it is better to have this check in verify_newsa_info().
> 
> Thanks
> 

