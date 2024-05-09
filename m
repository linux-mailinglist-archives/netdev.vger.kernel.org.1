Return-Path: <netdev+bounces-94926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BF08C1045
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36DB1F237AE
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CAB152780;
	Thu,  9 May 2024 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hM5ZgwxZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD3012E1EB
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715261085; cv=none; b=P8tplgnR8/mSH/h4YHKDoqDKT5yRjq9zH74z49V03efxQpTjgLMdPab6k0XZ+22S5uiOWTvbgunm4QcwvHzoGhhL352+UFFDhyEu4D/euQ5DIRAlYxvNRv62M8hweHwZ1+dUabn2Hw0IGSbPYiqt5WpxhCiq+FvrFbsl6n32bQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715261085; c=relaxed/simple;
	bh=CKIX6XxrbAtq5kPU1FdQlg2wHclS4WR59d04XRp/WQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpzoBhN6leXzS+8OfX/jvvnoe15zoh7Iu9Oj2AVHphqo2FtydoZnD0+J+Xx4zKM4UQIeW1T35qoVR8IVyMP6v/Qu/2w+jpMABkCRVRQ2BoMVDPnKkCVG/LxihjGnTbSBHwdz1vThjF5R2hi7oL82uqz1TdQOMYpW+tntGIBLCEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hM5ZgwxZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Nf57+YrU7JD5qIL9MvbRlBq+ihWBzIxZB9nxrrmD/8g=; b=hM5ZgwxZyIOd6QuL6/hJR30uNj
	F5mcvhM8OzYsQPm/NZFDjAYqNPCXWqgWLwfl5JZLc5NIv9WEknA//FlOraZpEKiaFi5VB2ADUvIei
	lVUVWIqIj7eIgB+K7ED/NrQTYQKt8nT7gMANdofAv7yM2bBdYYsSRsOPkUuRokHIpMXM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s53lB-00F2yK-Qe; Thu, 09 May 2024 15:24:33 +0200
Date: Thu, 9 May 2024 15:24:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 07/24] ovpn: introduce the ovpn_peer object
Message-ID: <50385582-d0ae-4288-8435-8db5f5f69a13@lunn.ch>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-8-antonio@openvpn.net>
 <ZjujHw6eglLEIbxA@hog>
 <60cae774-b60b-4a4b-8645-91eb6f186032@openvpn.net>
 <ZjzJ5Hm8hHnE7LR9@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjzJ5Hm8hHnE7LR9@hog>

On Thu, May 09, 2024 at 03:04:36PM +0200, Sabrina Dubroca wrote:
> 2024-05-08, 22:31:51 +0200, Antonio Quartulli wrote:
> > On 08/05/2024 18:06, Sabrina Dubroca wrote:
> > > 2024-05-06, 03:16:20 +0200, Antonio Quartulli wrote:
> > > > diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
> > > > index ee05b8a2c61d..b79d4f0474b0 100644
> > > > --- a/drivers/net/ovpn/ovpnstruct.h
> > > > +++ b/drivers/net/ovpn/ovpnstruct.h
> > > > @@ -17,12 +17,19 @@
> > > >    * @dev: the actual netdev representing the tunnel
> > > >    * @registered: whether dev is still registered with netdev or not
> > > >    * @mode: device operation mode (i.e. p2p, mp, ..)
> > > > + * @lock: protect this object
> > > > + * @event_wq: used to schedule generic events that may sleep and that need to be
> > > > + *            performed outside of softirq context
> > > > + * @peer: in P2P mode, this is the only remote peer
> > > >    * @dev_list: entry for the module wide device list
> > > >    */
> > > >   struct ovpn_struct {
> > > >   	struct net_device *dev;
> > > >   	bool registered;
> > > >   	enum ovpn_mode mode;
> > > > +	spinlock_t lock; /* protect writing to the ovpn_struct object */
> > > 
> > > nit: the comment isn't really needed since you have kdoc saying the same thing
> > 
> > True, but checkpatch.pl (or some other script?) was still throwing a
> > warning, therefore I added this comment to silence it.
> 
> Ok, then I guess the comment (and the other one below) can stay. That
> sounds like a checkpatch.pl bug.

I suspect it is more complex than that. checkpatch does not understand
kdoc. It just knows the rule that there should be a comment next to a
lock, hopefully indicating what the lock protects. In order to fix
this, checkpatch would need to somehow invoke the kdoc parser, and ask
it if the lock has kdoc documentation.

I suspect we are just going to have to live with this.

  Andrew


