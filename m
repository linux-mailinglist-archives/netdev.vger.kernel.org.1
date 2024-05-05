Return-Path: <netdev+bounces-93505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 018838BC19B
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 17:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBCC1F21484
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 15:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FBB36124;
	Sun,  5 May 2024 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxK+9jq4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CD33610A
	for <netdev@vger.kernel.org>; Sun,  5 May 2024 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714921580; cv=none; b=gyyrbvow3siw9gTT30Zx7Jki/W2zPcLQr1NsnMOPVJZ6ZcJGpKDRFqNuaqXXGteH/ZjWghrbyWJpeskayyduJeXRylU9Vp0bMSE+8w4h2MTqLSy5AoZahiuVnD71WTKz70u+VBizQPmrXWhJz8pfwyJPbcat7+KLv3eFOGds2Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714921580; c=relaxed/simple;
	bh=uQtpAtbgweAPP54L4gCpNx0cyngq4TWEkFiAwdnnJ70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4w71G1RbcDbDaGfCgX56P2dyUSZdUwup+h8aX0Dr3+F/IC17kG1MuGvA+GVEH6vFcp3vyvvjJhVzeVaWiiqmbKFiKqHuVzpwfMkDc7FjnmhOjPcPhOrPxxhS9twvydSHkNp/39iqluO7rK7jbWfS3V39X5LI4w3zshP/CCg3j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxK+9jq4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4CCC113CC;
	Sun,  5 May 2024 15:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714921580;
	bh=uQtpAtbgweAPP54L4gCpNx0cyngq4TWEkFiAwdnnJ70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OxK+9jq4N3z5ZPyBVtvNuscqmQcZgtiUXMXu81E/M4Zn5tCET/si9NBse9kS/xUNQ
	 52fyoSWI5FoUf2hePy/jOHedUmBd1j1Ws7XvK3Ghtg8Qvjn19z8izUYWtubp0XA7bV
	 bespEiRJD02JKB/8zRF1uQwEbnK5/uabce7hwfH6Byp9gLueunogSVeW1js06+VuvT
	 M6bAnlBg2UzLrQS5a3RkcszAYUHROgGi49Lv8z00QCbBTefsYRKlwNc61AABXUFDwB
	 C4M9jJcxrRhaudLxZq1jOPgTmClOqfd7ZYmwsDk7RwBS8R5dTlGf3wQRHRGbHtzPzB
	 zChZMqfxZVG+Q==
Date: Sun, 5 May 2024 16:06:16 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 5/8] rtnetlink: do not depend on RTNL for many
 attributes
Message-ID: <20240505150616.GI67882@kernel.org>
References: <20240503192059.3884225-1-edumazet@google.com>
 <20240503192059.3884225-6-edumazet@google.com>
 <20240505144608.GB67882@kernel.org>
 <CANn89i+ZKZrbmqxKU33XgN_ZyqqkFa7+BqAqFWCYdj3He1Xy8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+ZKZrbmqxKU33XgN_ZyqqkFa7+BqAqFWCYdj3He1Xy8g@mail.gmail.com>

On Sun, May 05, 2024 at 05:00:10PM +0200, Eric Dumazet wrote:
> On Sun, May 5, 2024 at 4:47 PM Simon Horman <horms@kernel.org> wrote:
> >
> > On Fri, May 03, 2024 at 07:20:56PM +0000, Eric Dumazet wrote:
> > > Following device fields can be read locklessly
> > > in rtnl_fill_ifinfo() :
> > >
> > > type, ifindex, operstate, link_mode, mtu, min_mtu, max_mtu, group,
> > > promiscuity, allmulti, num_tx_queues, gso_max_segs, gso_max_size,
> > > gro_max_size, gso_ipv4_max_size, gro_ipv4_max_size, tso_max_size,
> > > tso_max_segs, num_rx_queues.
> >
> > Hi Eric,
> >
> > * Regarding mtu, as the comment you added to sruct net_device
> >   some time ago mentions, mtu is written in many places.
> >
> >   I'm wondering if, in particular wrt ndo_change_mtu implementations,
> >   if some it is appropriate to add WRITE_ONCE() annotations.
> 
> Sure thing. I called for these changes in commit
> 501a90c94510 ("inet: protect against too small mtu values.")
> when I said "Hopefully we will add the missing ones in followup patches."

Ok, so basically it would be nice to add them,
but they don't block progress of this patchset?

> > * Likewise, is it appropriate to add WRITE_ONCE() to dev_set_group() ?
> 
> In general, a lot of write sides would need to be changed.
> 
> In practice, most compilers will not perform store tearing, this would
> be quite expensive.
> 
> Also, adding WRITE_ONCE() will not prevent a reader from reading some
> temporary values,
> take a look at dev_change_tx_queue_len() for instance.

Thank you, I will study this more closely.

