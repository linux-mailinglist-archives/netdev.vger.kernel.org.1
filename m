Return-Path: <netdev+bounces-21000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DFC7621D4
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DF8F1C20F58
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CA1263A2;
	Tue, 25 Jul 2023 18:55:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937091D2FD
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 18:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3D3C433C9;
	Tue, 25 Jul 2023 18:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690311329;
	bh=s6phFJ9yBv1XmQB6gDeUZIImvyU/LkcA0/ax2HSpizY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o/r1Y25gagTV062gymRgKk6qq04PwJT5zjfx02tXUHLCKL8yZx6UFZVp4k7A0D3g5
	 AR/ZYAfN24NroHcUWIQClQEa4RwJ4pGq371mLm9e8YyBowWNDE7vOt3hk+R1HlsYBC
	 B/AjTIvxb3ods6l/uVaQGv1mNiLzhJm7CCaxpdk2Sek3wOsCj+Rrlez/y2/sdDj/dO
	 lbHMkcGFwK0dF0fsxU9gqaiOZ6Tt1fsOXuzWXzQD58T20FFIc8FSasH6uABZZ+I9lC
	 uq9Mnhe7hE7kfm3qfK08wi7kqwJkeqITbC4k6LPBiqGlf3gBf4u+NkSiaWrXClgPNo
	 jOvEhLhLXAO0Q==
Date: Tue, 25 Jul 2023 11:55:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander H Duyck <alexander.duyck@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH net] docs: net: clarify the NAPI rules around XDP Tx
Message-ID: <20230725115528.596b5305@kernel.org>
In-Reply-To: <c429298e279bd549de923deba09952e7540e534a.camel@gmail.com>
References: <20230720161323.2025379-1-kuba@kernel.org>
	<c429298e279bd549de923deba09952e7540e534a.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 10:30:24 -0700 Alexander H Duyck wrote:
> > -In other words, it is recommended to ignore the budget argument when
> > -performing TX buffer reclamation to ensure that the reclamation is not
> > -arbitrarily bounded; however, it is required to honor the budget argument
> > -for RX processing.
> > +In other words for Rx processing the ``budget`` argument limits how many
> > +packets driver can process in a single poll. Rx specific APIs like page
> > +pool or XDP cannot be used at all when ``budget`` is 0.
> > +skb Tx processing should happen regardless of the ``budget``, but if
> > +the argument is 0 driver cannot call any XDP (or page pool) APIs.
> 
> This isn't accurate, and I would say it is somewhat dangerous advice.
> The Tx still needs to be processed regardless of if it is processing
> page_pool pages or XDP pages. I agree the Rx should not be processed,
> but the Tx must be processed using mechanisms that do NOT make use of
> NAPI optimizations when budget is 0.
> 
> So specifically, xdp_return_frame is safe in non-NAPI Tx cleanup. The
> xdp_return_frame_rx_napi is not.
> 
> Likewise there is napi_consume_skb which will use either a NAPI or non-
> NAPI version of things depending on if budget is 0 or not.
> 
> For the page_pool calls there is the "allow_direct" argument that is
> meant to decide between recycling in directly into the page_pool cache
> or not. It should only be used in the Rx handler itself when budget is
> non-zero.
> 
> I realise this was written up in response to a patch on the Mellanox
> driver. Based on the patch in question it looks like they were calling
> page_pool_recycle_direct outside of NAPI context. There is an explicit
> warning above that function about NOT calling it outside of NAPI
> context.

Unless I'm missing something budget=0 can be called from hard IRQ
context. And page pool takes _bh() locks. So unless we "teach it"
not to recycle _anything_ in hard IRQ context, it is not safe to call.

> >  .. warning::
> >  
> > -   The ``budget`` argument may be 0 if core tries to only process Tx completions
> > -   and no Rx packets.
> > +   The ``budget`` argument may be 0 if core tries to only process
> > +   skb Tx completions and no Rx or XDP packets.
> >  
> >  The poll method returns the amount of work done. If the driver still
> >  has outstanding work to do (e.g. ``budget`` was exhausted)  
> 
> We cannot make this distinction if both XDP and skb are processed in
> the same Tx queue. Otherwise you will cause the Tx to stall and break
> netpoll. If the ring is XDP only then yes, it can be skipped like what
> they did in the Mellanox driver, but if it is mixed then the XDP side
> of things needs to use the "safe" versions of the calls.

IDK, a rare delay in sending of a netpoll message is not a major
concern.

