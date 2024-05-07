Return-Path: <netdev+bounces-94211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53C78BE9DD
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70560286265
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E33F3F9E8;
	Tue,  7 May 2024 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwF3HcFl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ECE8F72
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100933; cv=none; b=rxX/FTD6D9hiJ3wIbVqe9c0DWMiXYm/yDEZ5/xttEmd47I7M2xu7SljwF+md/TMOE4hTxhyZdpetNvOoOvho1wE482wN3BBPJ3n+SXG/2IKELeg+h7682IID4DqBezhhxZ7WWoq6bBaX9DRopu5CEKfl+CRRMGLpUqVFYLonU2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100933; c=relaxed/simple;
	bh=XzhriFPwMhiLE0x4u27I2Jmbso2FqQdddiyJo4nSyFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/TlrGtjmVoYHhpefTvaDJJk8LQ4VlItgCWjHeOYJWspUXlXwB11VlX+tK7HXqczYCk3X8NPY1RjNjJGn/4XWeXh4+9kZ7DIX59MrzV48ykCZMv6IpgOXhme00mCFpn9DbsA62Vmr38ZuOEVTWOrxyf36K/rAhPBAeAlEmfyKow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwF3HcFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B39C2BBFC;
	Tue,  7 May 2024 16:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715100932;
	bh=XzhriFPwMhiLE0x4u27I2Jmbso2FqQdddiyJo4nSyFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rwF3HcFlZK0MVvAo6IepNVxCAwW/awM8TxYBVCC5PqzHrenJIXiEyHKXnwxq+YrHP
	 sDblTSGEfjm28FuhgHshjBjGxihA3qYquWcuADW3s/ujKjCchvwvwuUngS7gEhxMMM
	 6Il/bkNW70penqh8lMzAIPgPMw7PAUlkoJYjQrTO/B5ZlKTkjmiqeZxalLpdcmbqsU
	 W7NFm5I5PIOeQOGWv6XBI9x6A1zp0zmJZbL9WPYwbhx58qF7uW/ao1QQN4+eXxPSEd
	 69t92HD184wZHJjCGjsSxRWBtFKN22x1+SNhP1WIL+ktF68QwOPPvgzBgeZBIKiHu7
	 W8M7FSwEeMuKg==
Date: Tue, 7 May 2024 17:55:28 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 5/8] rtnetlink: do not depend on RTNL for many
 attributes
Message-ID: <20240507165528.GI15955@kernel.org>
References: <20240503192059.3884225-1-edumazet@google.com>
 <20240503192059.3884225-6-edumazet@google.com>
 <20240505144608.GB67882@kernel.org>
 <CANn89i+ZKZrbmqxKU33XgN_ZyqqkFa7+BqAqFWCYdj3He1Xy8g@mail.gmail.com>
 <20240505150616.GI67882@kernel.org>
 <CANn89iJO6mAkw5kDR5g7-NvpCZOGh9Ck1RePmXps60yK+55mSg@mail.gmail.com>
 <20240507163814.GE15955@kernel.org>
 <CANn89iLB9qZ77AY8ZMBST2FMqie8sPfHDUPUcg-GXMtkmAaoWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLB9qZ77AY8ZMBST2FMqie8sPfHDUPUcg-GXMtkmAaoWw@mail.gmail.com>

On Tue, May 07, 2024 at 06:39:54PM +0200, Eric Dumazet wrote:
> On Tue, May 7, 2024 at 6:38 PM Simon Horman <horms@kernel.org> wrote:
> >
> > On Sun, May 05, 2024 at 05:14:58PM +0200, Eric Dumazet wrote:
> > > On Sun, May 5, 2024 at 5:06 PM Simon Horman <horms@kernel.org> wrote:
> > > >
> > > > On Sun, May 05, 2024 at 05:00:10PM +0200, Eric Dumazet wrote:
> > > > > On Sun, May 5, 2024 at 4:47 PM Simon Horman <horms@kernel.org> wrote:
> > > > > >
> > > > > > On Fri, May 03, 2024 at 07:20:56PM +0000, Eric Dumazet wrote:
> > > > > > > Following device fields can be read locklessly
> > > > > > > in rtnl_fill_ifinfo() :
> > > > > > >
> > > > > > > type, ifindex, operstate, link_mode, mtu, min_mtu, max_mtu, group,
> > > > > > > promiscuity, allmulti, num_tx_queues, gso_max_segs, gso_max_size,
> > > > > > > gro_max_size, gso_ipv4_max_size, gro_ipv4_max_size, tso_max_size,
> > > > > > > tso_max_segs, num_rx_queues.
> > > > > >
> > > > > > Hi Eric,
> > > > > >
> > > > > > * Regarding mtu, as the comment you added to sruct net_device
> > > > > >   some time ago mentions, mtu is written in many places.
> > > > > >
> > > > > >   I'm wondering if, in particular wrt ndo_change_mtu implementations,
> > > > > >   if some it is appropriate to add WRITE_ONCE() annotations.
> > > > >
> > > > > Sure thing. I called for these changes in commit
> > > > > 501a90c94510 ("inet: protect against too small mtu values.")
> > > > > when I said "Hopefully we will add the missing ones in followup patches."
> > > >
> > > > Ok, so basically it would be nice to add them,
> > > > but they don't block progress of this patchset?
> > >
> > > A patch set adding WRITE_ONCE() on all dev->mtu would be great,
> > > and seems orthogonal.
> >
> > Ack. I'm guessing an incremental approach to getting better coverage would
> > be best. I'll add this to my todo list.
> 
> I sent a single patch about that already ;)

:)

