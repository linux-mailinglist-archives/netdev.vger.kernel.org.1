Return-Path: <netdev+bounces-77600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D656872451
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D14B21272
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AB712F37C;
	Tue,  5 Mar 2024 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ru2OeMx1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9985B12D1E9
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656000; cv=none; b=VQ3EeNJfhP4pEjvsE4SzTHUtiJSADkmdagGagiEK2v16m4HmsyUBz2r+4bN2LK1ruCyMl/cjDJRbKVwyUbr0IqVaqab2/J024gjeeYRjYLLNGdUN7A2dlrPO0/xJqUsCay1DPhOeySIjdFgDIT9CLsOmMbzS/DYRkKC3VGZTrnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656000; c=relaxed/simple;
	bh=bSTJlS/2J9jN7CS76dAHIyf9lmkJd+GtHf4N2KUlCrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KG/sEAORlgcp2XLkjKuLjPhMAnYPo32L1Tx0SCwRM8qC6HLwcNRvCKtWKr67kel5kCAeR6KqybJGdEiToBA5veC2hIHP1aV6fbZNSgYbcKafdt6ZFf+atrT0QfLzvTJxF1DFpuXLV/4b/IH1iruK0ac6PavaNXe6OyutMg7PaHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ru2OeMx1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tc+REPklifplsm4yXfqVpSkD9sKEcjAsGBPb7sadDz0=; b=Ru2OeMx1eB15Vk9SyxUenKe4sm
	Qz7+VOHORBnIqYd+nR+a2foVTjhVQ0s6o/MKrfhsygpssQQ4zEdM3x2UKg39SvpHQU9bsdpia6dCB
	BZEMCyQC9bqgdkhkMd4XjUZvn+Xx6i3uS7aG8jiQ52fKCfEVrYfRcqVeD4uQcLd7rAlo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhXdA-009RhS-LA; Tue, 05 Mar 2024 17:27:04 +0100
Date: Tue, 5 Mar 2024 17:27:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 04/22] ovpn: add basic interface
 creation/destruction/management routines
Message-ID: <540ab521-5dab-44fa-b6b4-2114e376cbfa@lunn.ch>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-5-antonio@openvpn.net>
 <e89be898-bcbd-41f9-aaae-037e6f88069e@lunn.ch>
 <48188b78-9238-44cc-ab2f-efdddad90066@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48188b78-9238-44cc-ab2f-efdddad90066@openvpn.net>

> > > +void ovpn_iface_destruct(struct ovpn_struct *ovpn, bool unregister_netdev)
> > > +{
> > > +	ASSERT_RTNL();
> > > +
> > > +	netif_carrier_off(ovpn->dev);
> > 
> > You often see virtual devices turn their carrier off in there
> > probe/create function, because it is unclear what state it is in after
> > register_netdevice().
> 
> Are you suggesting to turn it off both here and in the create function?
> Or should I remove the invocation above?

I noticed it in the _destruct function and went back to look at
create. You probably want it in both, unless as part of destruct, you
first disconnect all peers, which should set the carrier to off when
the last peer disconnects?

    Andrew

