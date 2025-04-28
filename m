Return-Path: <netdev+bounces-186528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3992AA9F868
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DEB63B78C7
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A3827990B;
	Mon, 28 Apr 2025 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atRZkzsj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5AD1A072A
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745864587; cv=none; b=p87wTpvC5qd+6dnCpa4bs3VBgVym1oQDm7yLj01shMKIt1I4xx4/VmwEurfPsqnkqw+yHAdw0UdwDPNCsTCHIZCKNOGpG43i2Cp35XR+Vuk0ro4lwk3jLY+KydWnpH9qUAlABsIavtPU67pmKAX42hV03pMKVDctl1B/C3ULqkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745864587; c=relaxed/simple;
	bh=EYz/CXvNwUEMEmcYo3FQ740KMiO4l6VgyBwYCG5Ih2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQ4cXQM9oiIrJGK1jUtR5NsiBoBI+Zk1aUMAQcXH4PPqrzfEx30Iszl9jPgdn4wcl5G4cu93mCdr18InHEDwXXfkxmsBC2StKl+iVuzzSoixjRuAaj96Lory5NzGV5gVPDSH49ll18Oau2sLINGWJan2iBnIHXNbSKYD7x2J6II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atRZkzsj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CA2C4CEE4;
	Mon, 28 Apr 2025 18:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745864587;
	bh=EYz/CXvNwUEMEmcYo3FQ740KMiO4l6VgyBwYCG5Ih2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=atRZkzsjLnfFNxl+l8bewm5qNOMu4/mlu2ug4izdJZqKUUGGkmWCqK6Ka/QEAlnPH
	 GHUzOUCHO3HykJmpwDflyjI8ukuv55Rl4wr9xS+Y4Qftvx0xnAsKWZjT7/gdV0UJGI
	 +HbI3wAx3sucQx7GMd15D7USvA0Sjxo/xLbh8JCI6+nS5BrsXaH+aXJfIFYoqBE7lf
	 jI4YhEePN7csq0NQlwoX9C6K6zWR/+80ee2PJ51tniyf+BFb4C0PZ6heWYUiQU21y7
	 3fHIscyVTUoNW8u0pQkPk0cRcf+o2g8u2lG9G1cRszRW25P2MS2c3UdMli1mzci+UF
	 hStbVb9W7HoUw==
Date: Mon, 28 Apr 2025 11:23:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Joe Damato <jdamato@fastly.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com,
 mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5] Add support to set napi threaded for
 individual napi
Message-ID: <20250428112306.62ff198b@kernel.org>
In-Reply-To: <CAAywjhTsPXtKGQejc_vOWzgF18u9XG74LzjZeP9i3TQGxUi6NA@mail.gmail.com>
References: <20250423201413.1564527-1-skhawaja@google.com>
	<aArFm-TS3Ac0FOic@LQ3V64L9R2>
	<CAAywjhQhH5ctp_PSgDuw4aTQNKY8V5vbzk9pYd1UBXtDV4LFMA@mail.gmail.com>
	<aAwLq-G6qng7L2XX@LQ3V64L9R2>
	<CAAywjhTjBzU+6XqHWx=JjA89KxmaxPSuoQj7CrxQRTNGwE1vug@mail.gmail.com>
	<20250425173743.04effd75@kernel.org>
	<aAxGTE2hRF-oMUGD@LQ3V64L9R2>
	<20250425194742.735890ac@kernel.org>
	<20250425201220.58bf25d7@kernel.org>
	<CAAywjhTsPXtKGQejc_vOWzgF18u9XG74LzjZeP9i3TQGxUi6NA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 20:53:14 -0700 Samiullah Khawaja wrote:
> > > We should check the discussions we had when threaded NAPI was added.
> > > I feel nothing was exposed in terms of observability so leaving the
> > > thread running didn't seem all that bad back then. Stopping the NAPI
> > > polling safely is not entirely trivial, we'd need to somehow grab
> > > the SCHED bit like busy polling does, and then re-schedule.
> > > Or have the thread figure out that it's done and exit.  
> >
> > Actually, we ended up adding the explicit ownership bits so it may not
> > be all that hard any more.. Worth trying.  
> Agreed. NAPI kthread lets go of the ownership by unsetting the
> SCHED_THREADED flag at napi_complete_done. This makes sure that the
> next SCHED is scheduled when new IRQ arrives and no packets are
> missed. We just have to make sure that it does that if it sees the
> kthread_should_stop. Do you think we should handle this maybe as a
> separate series/patch orthogonal to this?

We need to handle the case Joe pointed out. The new Netlink attributes
must make sense from day 1. I think it will be cleanest to work on
killing the thread first, but it can be a separate series.

> Also some clarification, we can remove the kthread when disabling napi
> threaded state using device level or napi level setting using netlink.
> But do you think we should also stop the thread when disabling a NAPI?
> That would mean the NAPI would lose any configurations done on this
> kthread by the user and those configurations won't be restored when
> this NAPI is enabled again. Some drivers use enable/disable as a
> mechanism to do soft reset, so a simple softreset to change queue
> length etc might revert these configurations.

That part I think needs to stay as is, the thread can be started and
stopped on napi_add / del, IMO.

