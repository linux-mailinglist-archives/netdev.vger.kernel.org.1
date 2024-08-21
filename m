Return-Path: <netdev+bounces-120550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7DF959BD1
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AE32846B8
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABAC169AE3;
	Wed, 21 Aug 2024 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="xsXsQrgy"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FF2166313
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243448; cv=none; b=AAAIA+vn5uSOQ/oTd+Rg+FzyoOPP2ueP3FmG+XYyHDxoL58QIFAG1dCahAhOA9UW0p1ZNayHw/OOJMBZvg32GqroGK7zbXysuPUFs2FqZvR7jcNip/3RL46K6/Z3gXCQ83HGXLvWmRttSgDXhMtnAXWZtUd4IoE46cdbgWv1Ee0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243448; c=relaxed/simple;
	bh=dxoPeIpC3bPF0XwBvdWAoHUGZ81+KYBt2ZMJQxLOHeE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9ga6caOptQaUavzUlwRWP5WcQJxLlUJPG0w3YMwA+WcXJaRIAhyFe2WAuM+P11lxUzanCf94uu4i9kS7+D13pGtCbkHEhgpX/O4SuW3VAG8nwc6HZK3aeMa1oNTxMWSvyK9B4+oGiA92MtLHPtd8/CwczR9G7w7biYKQFjxNEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=xsXsQrgy; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 5C55A20896;
	Wed, 21 Aug 2024 14:30:43 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O4roPggqcM5l; Wed, 21 Aug 2024 14:30:42 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1F42520883;
	Wed, 21 Aug 2024 14:30:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1F42520883
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1724243442;
	bh=eRBvyrO0yehzD7g7EO59nswAv9i1/S+HPM6v5osLZlE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=xsXsQrgyqu1Y0vq3kZmLxYe5Bl8DRD5ibK2s/zd6/TQO88HXAGWMc8eeiOuB4N5t7
	 Tlcov3jCsUY/o60rOI4325MHLXbPUEZgPSwlwzLHWffUH4YZpA1LRoGnn+sGJNhCv6
	 +GomRekHKnpNGvfAZZk49TyzDHFdtVpbMWjAFTH4ntg4YYoTwGZ+TeF50FV9ryPF9l
	 +ZOz3dLTADCCaNOdLHb4In6vIlWtkopKrmPXxKp9efaGI81NDsrGdgk7DltC1fBGkO
	 5YB7frF/ctcPnR/XK+/CkR2DKa9qu+5Vog7kKe81phl5PAj2QwhL9QolUbstU88/8U
	 z3aDinqE7TTUQ==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 14:30:41 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 14:30:41 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 45DAE3183CDE; Wed, 21 Aug 2024 14:30:41 +0200 (CEST)
Date: Wed, 21 Aug 2024 14:30:41 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: Hangbin Liu <liuhangbin@gmail.com>, <netdev@vger.kernel.org>, Jay Vosburgh
	<j.vosburgh@gmail.com>, "David S . Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Nikolay Aleksandrov <razor@blackwall.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Simon Horman
	<horms@kernel.org>
Subject: Re: [PATCHv3 net-next 2/3] bonding: Add ESN support to IPSec HW
 offload
Message-ID: <ZsXd8adxUtip773L@gauss3.secunet.de>
References: <20240820004840.510412-1-liuhangbin@gmail.com>
 <20240820004840.510412-3-liuhangbin@gmail.com>
 <ZsS3Zh8bT-qc46s7@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZsS3Zh8bT-qc46s7@hog>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Aug 20, 2024 at 05:33:58PM +0200, Sabrina Dubroca wrote:
> Hi Hangbin,
> 
> (adding Steffen since we're getting a bit into details of IPsec)
> 
> 2024-08-20, 08:48:39 +0800, Hangbin Liu wrote:
> > Currently, users can see that bonding supports IPSec HW offload via ethtool.
> > However, this functionality does not work with NICs like Mellanox cards when
> > ESN (Extended Sequence Numbers) is enabled, as ESN functions are not yet
> > supported. This patch adds ESN support to the bonding IPSec device offload,
> > ensuring proper functionality with NICs that support ESN.
> > 
> > Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> >  drivers/net/bonding/bond_main.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > index 560e3416f6f5..24747fceef66 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -651,10 +651,35 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
> >  	return err;
> >  }
> >  
> > +/**
> > + * bond_advance_esn_state - ESN support for IPSec HW offload
> > + * @xs: pointer to transformer state struct
> > + **/
> > +static void bond_advance_esn_state(struct xfrm_state *xs)
> > +{
> > +	struct net_device *real_dev;
> > +
> > +	rcu_read_lock();
> > +	real_dev = bond_ipsec_dev(xs);
> > +	if (!real_dev)
> > +		goto out;
> > +
> > +	if (!real_dev->xfrmdev_ops ||
> > +	    !real_dev->xfrmdev_ops->xdo_dev_state_advance_esn) {
> > +		pr_warn("%s: %s doesn't support xdo_dev_state_advance_esn\n", __func__, real_dev->name);
> 
> xdo_dev_state_advance_esn is called on the receive path for every
> packet when ESN is enabled (xfrm_input -> xfrm_replay_advance ->
> xfrm_replay_advance_esn -> xfrm_dev_state_advance_esn), this needs to
> be ratelimited.

How does xfrm_state offload work on bonding?
Does every slave have its own negotiated SA?

