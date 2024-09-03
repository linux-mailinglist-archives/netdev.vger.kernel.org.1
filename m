Return-Path: <netdev+bounces-124604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 245D696A245
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 17:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4F47B296FF
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E009184554;
	Tue,  3 Sep 2024 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaxYtGWJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87916F8EF
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377000; cv=none; b=F7BLjqlvWDnNFn4K49z6nVC4lQTXFF32VEICdDP2HPvD6NLJzBN6RLRwWtKLFbly4+TWf6Vz1JV/KElnRmoiEjV+PHInIRaw8dykYg0K2bTFENxaIzLXEHPxu87CXgPWKbUJ4q4HMT0QiOOdD+LFrtafbWS6OrTr9PViZWWyrsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377000; c=relaxed/simple;
	bh=o8GI0Ak+/023ld+zCZQ1jH2Br85ZeDNO0Byay46FOPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJc1htv+3vDhCzO0rbVPeoyqVlmGtQSHLKItJap8lNw43vgkZM3uZR6O+b7UoCyw0Hh+CS9r2OmASpkJO/Gc7BDNJY54Xqkm5ulKezHya6Y9lDYqFuhhqEQIn5PhmXPNLh58a7SrlFHDdVbXXB8UqA8CzgRvdG8J+wZFH9xz4ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaxYtGWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A026C4CEC4;
	Tue,  3 Sep 2024 15:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725376999;
	bh=o8GI0Ak+/023ld+zCZQ1jH2Br85ZeDNO0Byay46FOPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WaxYtGWJ0/KKy6URgk8LrmXaBsVtheGUvHnilInreypfvfHb52Rnu6qiy1OpoPoFT
	 H6Tx5p5VFs+1LN5zEIp3p61IF7GndTCoBgxGa6QXLZjQGhH+P7Np4t/1omGrheE9wU
	 0a2e16IbgF/VMGBx79kBVtLiMGjkJEXlTCxmdM1h/l5NxQj3gA5KSHGvpVgvQcTLsd
	 EHH2o6iEq6bAgLoJlQ9p2wJXvygf2Y0MctXkNMo432TNaoJB9fPSj9q7/p8fa/Ltm3
	 dgU6jF9qsSd4OQ4PSBqTyv3wSHtCIreWgLTAeXo0XENf1XxFEYu7TniSgJQmBUaZYB
	 0kYNPnttQ9UUg==
Date: Tue, 3 Sep 2024 16:23:16 +0100
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net_tstamp: add SCM_TS_OPT_ID to provide
 OPT_ID in control message
Message-ID: <20240903152316.GB4792@kernel.org>
References: <20240902130937.457115-1-vadfed@meta.com>
 <20240902183833.GK23170@kernel.org>
 <f2a5db09-decc-4e40-a6cc-d4f179a7ab68@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2a5db09-decc-4e40-a6cc-d4f179a7ab68@linux.dev>

On Mon, Sep 02, 2024 at 08:35:26PM +0100, Vadim Fedorenko wrote:
> On 02/09/2024 19:38, Simon Horman wrote:
> > On Mon, Sep 02, 2024 at 06:09:35AM -0700, Vadim Fedorenko wrote:
> > > SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
> > > timestamps and packets sent via socket. Unfortunately, there is no way
> > > to reliably predict socket timestamp ID value in case of error returned
> > > by sendmsg. For UDP sockets it's impossible because of lockless
> > > nature of UDP transmit, several threads may send packets in parallel. In
> > > case of RAW sockets MSG_MORE option makes things complicated. More
> > > details are in the conversation [1].
> > > This patch adds new control message type to give user-space
> > > software an opportunity to control the mapping between packets and
> > > values by providing ID with each sendmsg. This works fine for UDP
> > > sockets only, and explicit check is added to control message parser.
> > > 
> > > [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com/
> > > 
> > > Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> > 
> > ...
> > 
> > > diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> > 
> > ...
> > 
> > > @@ -1543,10 +1546,15 @@ static int __ip6_append_data(struct sock *sk,
> > >   			flags &= ~MSG_SPLICE_PAGES;
> > >   	}
> > > -	hold_tskey = cork->tx_flags & SKBTX_ANY_TSTAMP &&
> > > -		     READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
> > > -	if (hold_tskey)
> > > -		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
> > > +	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
> > > +	    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID) {
> > > +		if (cork->flags & IPCORK_TS_OPT_ID) {
> > > +			tskey = cork->ts_opt_id;
> > > +		} else {
> > > +			tskey = atomic_inc_return(&sk->sk_tskey) - 1;
> > > +			hold_tskey = true;
> > 
> > Hi Vadim,
> > 
> > I think that hold_tskey also needs to be assigned a value in
> > the cases where wither of the if conditions above are false.
> 
> Hi Simon!
> 
> Yes, you are right. I should probably init it with false to avoid
> 'else' statement.

Thanks, I agree that seems like a good approach.

