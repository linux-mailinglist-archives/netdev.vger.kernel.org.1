Return-Path: <netdev+bounces-133297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B110D9957DD
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 21:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656471F25D19
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 19:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AC3213ED6;
	Tue,  8 Oct 2024 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kH+SQUwL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6665E8BE7;
	Tue,  8 Oct 2024 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728417026; cv=none; b=d+/6L8iIn9HTGDuolFbQAl0+Df6TT7MFcd4pD/YP3NJHuDz5kqtttjGhRSRdn3f7lOnygzyjK/Z3FINnu64S2D28Yhf3d3L4Xf7QdV1ir2uePEcb9QfStTA2VJWEKJfs265SMCjbFnRJCEeIln8NxzwHXpr6LvKmZ186ILBURj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728417026; c=relaxed/simple;
	bh=x1AuM38/r2D143PMJypMNRQhPhELDWOB+s6uV2hnfhs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHnkgeIiXNUMEg7zvxmqq2VpLyBDJ4GmHMtaG8J9nxPnKFYNhdIUndf+xFMthueTrYIwwdQCP9SF1Bbnwf2TGQEY+Jc5yQH/8KMobfHNHnYEXCTPw/8fEy1HFIFVYZBD7rF/4Tz4G6rO6C/Sg7XTs0wa7peAaIagDcEQS8xvsOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kH+SQUwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0112C4CEC7;
	Tue,  8 Oct 2024 19:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728417025;
	bh=x1AuM38/r2D143PMJypMNRQhPhELDWOB+s6uV2hnfhs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kH+SQUwLUvinr3axdQLNB6uh0LovwTEfQKupa5qOVPfqBYngqBElQ0iCkM86d0B3U
	 Pr0slYEstbfayTjCsTS/EXdfABXBQUomorPlrRqZVcBhJdT/WrcaaQQ9Lz10z7/yIw
	 RZn3uU24Y+dtThoeQbVQakq6LAF5tHRetTRr86sE0s5x0T8NeTUhJz58y3jRQYhu6b
	 Sob2qvkkff6ANxUl4TgjLMnsQKmfIqmHL673+KolUQ4yQicT2MGg6y+W+715vZ2pdy
	 4y2jL44HZ8MRfRWpZIgTSIOXpEIxMMRnrKffdyNDy6ToN3XLRpFQk+dhsYwk4BdIEY
	 X09uk4CKuXtsg==
Date: Tue, 8 Oct 2024 12:50:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, donald.hunter@gmail.com, corbet@lwn.net,
 michael.chan@broadcom.com, kory.maincent@bootlin.com, andrew@lunn.ch,
 maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
 asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com,
 aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com,
 bcreeley@amd.com
Subject: Re: [PATCH net-next v3 7/7] bnxt_en: add support for device memory
 tcp
Message-ID: <20241008125023.7fbc1f64@kernel.org>
In-Reply-To: <CAMArcTU61G=fexf-RJDSW_sGp9dZCkJsJKC=yjg79RS9Ugjuxw@mail.gmail.com>
References: <20241003160620.1521626-1-ap420073@gmail.com>
	<20241003160620.1521626-8-ap420073@gmail.com>
	<CAHS8izO-7pPk7xyY4JdyaY4hZpd7zerbjhGanRvaTk+OOsvY0A@mail.gmail.com>
	<CAMArcTU61G=fexf-RJDSW_sGp9dZCkJsJKC=yjg79RS9Ugjuxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Oct 2024 19:34:45 +0900 Taehee Yoo wrote:
> > Our intention with the whole netmem design is that drivers should
> > never have to call netmem_to_page(). I.e. the driver should use netmem
> > unaware of whether it's page or non-page underneath, to minimize
> > complexity driver needs to handle.
> >
> > This netmem_to_page() call can be removed by using
> > skb_frag_fill_netmem_desc() instead of the page variant. But, more
> > improtantly, why did the code change here? The code before calls
> > skb_frag_fill_page_desc, but the new code sometimes will
> > skb_frag_fill_netmem_desc() and sometimes will skb_add_rx_frag_netmem.
> > I'm not sure why that logic changed.  
> 
> The reason why skb_add_rx_frag_netmem() is used here is to set
> skb->unreadable flag. the skb_frag_fill_netmem_desc() doesn't set
> skb->unreadable because it doesn't handle skb, it only handles frag.
> As far as I know, skb->unreadable should be set to true for devmem
> TCP, am I misunderstood?
> I tested that don't using skb_add_rx_frag_netmem() here, and it
> immediately fails.

Yes, but netmem_ref can be either a net_iov or a normal page,
and skb_add_rx_frag_netmem() and similar helpers should automatically
set skb->unreadable or not.

IOW you should be able to always use netmem-aware APIs, no?

> > This is not the intended use of PP_FLAG_ALLOW_UNREADABLE_NETMEM.
> >
> > The driver should set PP_FLAG_ALLOW_UNREADABLE_NETMEM when it's able
> > to handle unreadable netmem, it should not worry about whether
> > rxq->mp_params.mp_priv is set or not.
> >
> > You should set PP_FLAG_ALLOW_UNREADABLE_NETMEM when HDS is enabled.
> > Let core figure out if mp_params.mp_priv is enabled. All the driver
> > needs to report is whether it's configured to be able to handle
> > unreadable netmem (which practically means HDS is enabled).  
> 
> The reason why the branch exists here is the PP_FLAG_ALLOW_UNREADABLE_NETMEM
> flag can't be used with PP_FLAG_DMA_SYNC_DEV.

Hm. Isn't the existing check the wrong way around? Is the driver
supposed to sync the buffers for device before passing them down?

