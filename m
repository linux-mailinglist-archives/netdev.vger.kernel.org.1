Return-Path: <netdev+bounces-238019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D4FC52B9D
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 15:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1CB6134179A
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 14:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBE026FD97;
	Wed, 12 Nov 2025 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIinGQwg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE86429993D;
	Wed, 12 Nov 2025 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957905; cv=none; b=ExgbfwiyPsTk6vfmUbRfbkgzevsvp4fixzRwbc5YuepmFfAkhVD4+gEEwaFd03Ksh4MgZb7QGZRWFmlBjUUSd6TZky8we4Jqpofyoy8a7Aqb238fa3CVaJTsCG2q80W2k3cD3g13y3K2Cc1B/ZaM/cU/bTtg0F5sWDNlR0b1fZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957905; c=relaxed/simple;
	bh=Zh735Muu3xEoGfWdwvFpedTcy89mgtmJ14KbCy/3EQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZ0KmG9vVuDiikt83/CPhaVU5bjyffgXZcATGqMCe95fXUpZ5/07AGIsG0ds+ZSzTrTiVgkehf4pH3zaaGPGSEMiF/C3c2E5A63NPa3Jo/Ln3KqvovPyTaZXJDUzQBku16QcNzWjSlC4F8Tn34kFJA+zJGRb4EqFjafsaoaq+Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIinGQwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32E1C4CEF5;
	Wed, 12 Nov 2025 14:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762957905;
	bh=Zh735Muu3xEoGfWdwvFpedTcy89mgtmJ14KbCy/3EQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GIinGQwghyLFcbqlaCIqJdMQRe/oeTlsFI8shPpORhabfRb0llPMkSikbIEd/JZiK
	 +gBPQOsFBELK1bMqOdX+yU7Sn3GfSNLITAxYB0gjD3FL260k1FYnk/QWT86Ilv7G9S
	 YQppZvMVUWCXvbcjoevdvtKdBAqw6OGpHaM5bhHPQtGrqYCG2MsqWGlz9ufN5kx+o6
	 C1F5qOC3ET/u09SZQQv0w0hYR4eDjHSanx15/qQ49GB0p8xKafEKuqvgDT/cgjs43k
	 l8NhT0rSDWDwEKKTWVrEG7CsCmalw1FY9fvBx3gx5TEfqSDwyyDWcTX9hUe3uwRNH0
	 vKTUa3Nh0HI5w==
Date: Wed, 12 Nov 2025 06:31:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: Geoff Levand <geoff@infradead.org>, netdev@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ps3_gelic_net: handle skb allocation failures
Message-ID: <20251112063143.1040d431@kernel.org>
In-Reply-To: <aRRUiYIrOcpSiakH@lithos>
References: <20251110114523.3099559-1-fuchsfl@gmail.com>
	<20251111180451.0ef1dc9c@kernel.org>
	<aRRUiYIrOcpSiakH@lithos>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Nov 2025 10:34:01 +0100 Florian Fuchs wrote:
> > > --- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> > > +++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> > > @@ -259,6 +259,7 @@ void gelic_card_down(struct gelic_card *card)
> > >  	mutex_lock(&card->updown_lock);
> > >  	if (atomic_dec_if_positive(&card->users) == 0) {
> > >  		pr_debug("%s: real do\n", __func__);
> > > +		timer_delete_sync(&card->rx_oom_timer);
> > >  		napi_disable(&card->napi);  
> > 
> > I think the ordering here should be inverted  
> 
> I thought, that there might be a race condition in the inverted order
> like that napi gets re-enabled by the timer in between of the down:
> 
> 1. napi_disable
> 2. rx_oom_timer runs and calls napi_schedule again
> 3. timer_delete_sync
> 
> So the timer is deleted first, to prevent any possibility to run.

napi_disable() makes napi_schedule() a nop (it makes it look like it's
already scheduled).

> > TBH handling the OOM inside the Rx function seems a little fragile.
> > What if there is a packet to Rx as we enter. I don't see any loop here
> > it just replaces the used buffer..  
> 
> I am not sure, the handling needs to happen, when the skb allocation
> fails, and that happens in the rx function, right? I am open to better
> fitting fix position.

Purely from the structure of the code PoV it'd be cleaner if the
alloc/refill was separate from the processing so we can call just 
that part.

But looking closer I think the handling is fine as is. So I think
just addressing the nits is fine for v2

