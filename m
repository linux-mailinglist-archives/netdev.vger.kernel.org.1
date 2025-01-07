Return-Path: <netdev+bounces-155886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55A5A04325
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55DC316191F
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F491F2C5A;
	Tue,  7 Jan 2025 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhd6dseO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769021F131F
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261393; cv=none; b=ajBWTxzQpgtXZY0fjME6W8cxoaPaFn5KAL9Mmv27N02XktMOD12avh8Wh1txWwcEG3waTrbltpYLvFWMvIZRieQHUxTG2Vnc8SaFz1drTlgQdT6ac4P2fGgpoa2/tvUACJZy/spelYDcZ+rJVGlIgKrDtDtI2Mpj3opoBXRY/+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261393; c=relaxed/simple;
	bh=6exH/+pEe84SukQNeOJiC7e/aHitIRWtAXA4dc2lHkM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKSJPREuNVRbZsyKqP+4YjGvYlGELMR82cWGaxSWFH5E66JD70mMTo+VlAwhO+p9cJX351nlQwTeTzRqlsyOMmL1jeYJNWMyTtJF0NU54V+x0ahMdplkb9pV6ku9jVDvmEgSM6L9BrWvFgz6rXqSXq9jcW0LAqLD3jVjiiNDfjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhd6dseO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90024C4CED6;
	Tue,  7 Jan 2025 14:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736261392;
	bh=6exH/+pEe84SukQNeOJiC7e/aHitIRWtAXA4dc2lHkM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qhd6dseOD/KQNLhrX8qVRAIqAJNLRaC55BdwNrI5roofUdmeHRY6JKSBKi59IX0Ic
	 Celfs12KSpIdyv9hqWy6+UvfXivqflh0P9T4DX6HIm5DhXPCm0onXLD+Z6YD0P6pOC
	 epM6L+n4pL+DwOFYUEZU78Y/Iq//8DPs3CtZy6QWer28tiMULTn2jKJo/gMGXwBOMP
	 0/6SmtDAvJKtSxeZRdRShNnHDzE0o/sJTTuh2Scq1rTtt4nnKox2/wmO0Lrv24WBP5
	 1rjonRfcVBsV/YRGvOxgkBk7ZeUTAdrQjkarP5QKp6Sw7ZHPlOt2B/7xpqBg046v6G
	 FOhDyYJJzD6Pg==
Date: Tue, 7 Jan 2025 06:49:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dw@davidwei.uk, almasrymina@google.com,
 jdamato@fastly.com
Subject: Re: [PATCH net-next 6/8] netdevsim: add queue management API
 support
Message-ID: <20250107064951.200e9dfd@kernel.org>
In-Reply-To: <677d344a30383_25382b29446@willemb.c.googlers.com.notmuch>
References: <20250103185954.1236510-1-kuba@kernel.org>
	<20250103185954.1236510-7-kuba@kernel.org>
	<677d344a30383_25382b29446@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 07 Jan 2025 09:03:54 -0500 Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > +/* Queue reset mode is controled by ns->rq_reset_mode.  
> 
> controlled

ack

> also perhaps an enum for the modes?

I couldn't come up with concise yet meaningful names for them, TBH :(

> > + * - normal - new NAPI new pool (old NAPI enabled when new added)
> > + * - mode 1 - allocate new pool (NAPI is only disabled / enabled)
> > + * - mode 2 - new NAPI new pool (old NAPI removed before new added)
> > + * - mode 3 - new NAPI new pool (old NAPI disabled when new added)
> > + */

> > +	/* netif_napi_add()/_del() should normally be called from alloc/free,
> > +	 * here we want to test various call orders.
> > +	 */
> > +	if (ns->rq_reset_mode == 2) {
> > +		netif_napi_del(&ns->rq[idx]->napi);
> > +		netif_napi_add_config(dev, &qmem->rq->napi, nsim_poll, idx);
> > +	} else if (ns->rq_reset_mode == 3) {
> > +		netif_napi_add_config(dev, &qmem->rq->napi, nsim_poll, idx);
> > +		netif_napi_del(&ns->rq[idx]->napi);  
> 
> Just to make sure my understanding: this is expected to not change
> anything, due to test_and_(set|clear)_bit(NAPI_STATE_LISTED, ..),
> right?

Say more..
Note that ns->rq[idx]->napi != qmem->rq->napi

