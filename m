Return-Path: <netdev+bounces-166966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3ACA382FB
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317303B0E8A
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 12:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72D821A43B;
	Mon, 17 Feb 2025 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTqygEUx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFBF218842
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739795265; cv=none; b=spkDBWgm/50OTl0ITrkks4JwF5KUnPMRfrDPGfLIzLRzoC5Qat45Qbhk0ziHg88dt0+sT+8w5EKxO3L97cWnnsixsVp8yRQnVh+0DFm4uvtjXAs4IqFwO6nUlrI8oTy4zJDcGo24khitEz7Pg+iq7kVPQrb6aiEW1iSj6ePHiiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739795265; c=relaxed/simple;
	bh=Jku/zKTExMPqx0Qeu5htsbRckDKQKU0bbll1siaT4uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEJ3LU31GiRw5eGALaBzYkE2NGBTvLhSIOPE1JfILvxMWngWRiR6HxT7hlUhPib51UDaKZG7uOZImqHQUa44aOYHUsh4NIIIAz42ODrGu3wqgAQRSPzZdo+fnuXI+7a7EwQGYeVLFWHJjHoFKP3+qYuvlOo4895iURs+tE+TfxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTqygEUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0ADC4CED1;
	Mon, 17 Feb 2025 12:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739795265;
	bh=Jku/zKTExMPqx0Qeu5htsbRckDKQKU0bbll1siaT4uA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LTqygEUxfzHLivS3EvtzmPCMqrl6MYf7vwYDiIHYB7tDDikuDuzmHUjvr8h+bEEc6
	 WnUGtnudlriL9T9tLkqp02IqRfQJoXg9cZZL7oqJuXN2ScZa/NNbpqmuMxzFgeEmqR
	 V6cOhAhUp32mdlxcOw4+natjU0lG5TiiRuPYDUcSr3WlYezbsC/0Gu6vtLqI2drT9Q
	 9wl+Zo+BeC8b3t2gel+u2CnwSm/YjXmj9mbwq5J0esTOwwUurNWoK+p3qZYbEFarDu
	 yM8S1zcugZySmbKFxyAFC9zvXNdSoz29FMUM18lo6s4GfRjouRmpS2fMo9DhuSORRd
	 oEJW/xWyrbv0w==
Date: Mon, 17 Feb 2025 14:27:39 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Alexandre Cassen <acassen@corp.free.fr>, netdev@vger.kernel.org
Subject: Re: [RFC ipsec-next] xfrm: fix tunnel mode TX datapath in packet
 offload mode
Message-ID: <20250217122739.GA69863@unreal>
References: <af1b9df0b22d7a9f208e093356412f8976cc1bc2.1738780166.git.leon@kernel.org>
 <Z68OQtAL2jiu/1Sg@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z68OQtAL2jiu/1Sg@gauss3.secunet.de>

On Fri, Feb 14, 2025 at 10:34:58AM +0100, Steffen Klassert wrote:
> On Wed, Feb 05, 2025 at 08:41:02PM +0200, Leon Romanovsky wrote:
> > From: Alexandre Cassen <acassen@corp.free.fr>
> > 
> > +static int xfrm_dev_direct_output(struct sock *sk, struct xfrm_state *x,
> > +				  struct sk_buff *skb)
> > +{
> > +	struct dst_entry *dst = skb_dst(skb);
> > +	struct net *net = xs_net(x);
> > +	int err;
> > +
> > +	dst = skb_dst_pop(skb);
> > +	if (!dst) {
> > +		XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
> > +		kfree_skb(skb);
> > +		return -EHOSTUNREACH;
> > +	}
> > +	skb_dst_set(skb, dst);
> > +	nf_reset_ct(skb);
> > +
> > +	err = skb_dst(skb)->ops->local_out(net, sk, skb);
> > +	if (unlikely(err != 1)) {
> > +		kfree_skb(skb);
> > +		return err;
> > +	}
> > +
> > +	/* In transport mode, network destination is
> > +	 * directly reachable, while in tunnel mode,
> > +	 * inner packet network may not be. In packet
> > +	 * offload type, HW is responsible for hard
> > +	 * header packet mangling so directly xmit skb
> > +	 * to netdevice.
> > +	 */
> > +	skb->dev = x->xso.dev;
> > +	__skb_push(skb, skb->dev->hard_header_len);
> > +	return dev_queue_xmit(skb);
> 
> I think this is absolutely the right thing for tunnel mode,
> but on transport mode we might bypass some valid netfilter
> rules.

Thanks for the acknowledge. We will prepare proper patch.

