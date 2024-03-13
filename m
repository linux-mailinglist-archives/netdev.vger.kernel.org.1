Return-Path: <netdev+bounces-79756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6482787B330
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 22:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203DC289365
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 21:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F744D108;
	Wed, 13 Mar 2024 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="yNXU/Ss4"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D1A524BE
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 21:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710363824; cv=none; b=e+gCNwRT0Z7+HVgoB86317sqQJCl2IYD9RuRxH6IY8rAPSL6y0d8DOogGBpjyiWxd/64n/dgJFAwYagDdcQZgwSDfeAqcJkbDkRGKwQTyfYnxuSiWTxgtp77kZ19iubkOP+EoNxSWIxLRdr/gxuS9blYAsSp6k0+1PdNCpdxReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710363824; c=relaxed/simple;
	bh=mIgh25kypXsYr/q7XEic0PWYqLW/V95ZOJ+vof1HV5g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caEHdkVZpHj7QOGSaMKLPfmWQh1aRi9qtiSV2CfX3sJe28zDHPJfK9UkvWac1s96lBLjIJSIERN6CxWgeAl3fVVcGcMGC27i8F7xmE7srpjezJ+ikF08guaSYDCIB8QzDUiEj8Z9nCNwD2LAYKz6PHQphv7NNOcB6kSoG+T4Vds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=yNXU/Ss4; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 130FB208C8;
	Wed, 13 Mar 2024 22:03:39 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NwuVrbz1McJQ; Wed, 13 Mar 2024 22:03:38 +0100 (CET)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 79818208C0;
	Wed, 13 Mar 2024 22:03:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 79818208C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1710363818;
	bh=/dCJrKE6vyO1K/ahZsV4CFGg35JASAgx9ENV69t8zio=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=yNXU/Ss4Zye6c3jjqP3KQ5R767rhLjsYf8S6v9lgsrxxJ7N78eQ6LXekmHknjQAc2
	 ZTob4F/cgoPwcTiewh4RKbZpOraDTDqu+LrT30nmzVdH+kKfvoAFyUW58z7UMHAKNQ
	 gyd2UKKLQ6D+IY3GlTtBPvzk8io7o/q2eqGy7bXTkjYDgiVQuKJF4GQqDrhkxyGh7R
	 Rbk/1SegldE5YuR2465GcqKAPdbovbuXXu7+S/N1zFsPBfwQL/G4Q3B2h9kTTIMMwT
	 P8LsZt33feOl/kkCtnM6SiKvTbxQG8cPdRlsjdB66StcGfE9Ee0aNzyLLhh6XOBJuh
	 lpXkcBuxs7eMA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 6B5E680004A;
	Wed, 13 Mar 2024 22:03:38 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 22:03:38 +0100
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Mar
 2024 22:03:37 +0100
Date: Wed, 13 Mar 2024 22:03:35 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>, <devel@linux-ipsec.org>, Eyal Birger
	<eyal.birger@gmail.com>
Subject: Re: [PATCH ipsec-next v3] xfrm: Add Direction to the SA in or out
Message-ID: <ZfIUpy2u7VeuiAgU@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <8ca32bd68d6e2eee1976fd06c7bc65f8ed7e24d3.1710273084.git.antony.antony@secunet.com>
 <20240313085430.GW12921@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240313085430.GW12921@unreal>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hi Leon,

On Wed, Mar 13, 2024 at 10:54:30 +0200, Leon Romanovsky wrote:
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
> ....

I added this check too. With "!" inside ,  (!( )

> and IMHO, it is better to have this check in verify_newsa_info().

That function does not have xuo extracted. And xfrm_dev_state_add() has
other checks already. So I think this is a better place for now.

thanks,
-antony

