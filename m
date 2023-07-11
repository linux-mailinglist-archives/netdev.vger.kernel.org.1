Return-Path: <netdev+bounces-16835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC6974EE37
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 14:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E473C2816C9
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 12:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D8718C0D;
	Tue, 11 Jul 2023 12:20:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8A01774C
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 12:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EF4C433C7;
	Tue, 11 Jul 2023 12:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689078016;
	bh=ESrFukL6Avmq96Qu5Z0oVFoi45CucnlANyNQFqVS/EI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l0woitDjv2729w2lKE8MkSDWhI9pE3s5StDUzTavbZivo5Oyc5vZwwAUIfxPu3Juz
	 0P7vfULY6rAu7A4YI/aCthk+ruMFZURj9z0a6HJQ/81tSA46wsiaiddONLZKKmaCR4
	 9+2b84FyJcP3VMxTaU8qVaKGPyBX/Kn4GwLZBuRzMDuUXQGbO115qE1M/AYZLGmajz
	 WcUPq7qEzXmtGmHPsm37f3u0KgU8MJQ8W7Xdsv1Q/bqdXHPxh1Cz9DhsIqhx6BDxtX
	 4PdxfsZ8kqPQmS/eJo2eYK6I4wNmbVq3ai2TcCpauITpYOutNeAobWuJoB+VyS/nHJ
	 hrjIJPdP7q2cg==
Date: Tue, 11 Jul 2023 15:20:12 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next][resend v1 1/1] netlink: Don't use int as bool
 in netlink_update_socket_mc()
Message-ID: <20230711122012.GR41919@unreal>
References: <20230710100624.87836-1-andriy.shevchenko@linux.intel.com>
 <20230711063348.GB41919@unreal>
 <2a2d55f167a06782eb9dfa6988ec96c2eedb7fba.camel@redhat.com>
 <ZK002l0AojjdJptC@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK002l0AojjdJptC@smile.fi.intel.com>

On Tue, Jul 11, 2023 at 01:54:18PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 11, 2023 at 12:21:12PM +0200, Paolo Abeni wrote:
> > On Tue, 2023-07-11 at 09:33 +0300, Leon Romanovsky wrote:
> > > On Mon, Jul 10, 2023 at 01:06:24PM +0300, Andy Shevchenko wrote:
> > > > The bit operations take boolean parameter and return also boolean
> > > > (in test_bit()-like cases). Don't threat booleans as integers when
> > > > it's not needed.
> > > > 
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > ---
> > > >  net/netlink/af_netlink.c | 7 ++++---
> > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> > > > index 383631873748..d81e7a43944c 100644
> > > > --- a/net/netlink/af_netlink.c
> > > > +++ b/net/netlink/af_netlink.c
> > > > @@ -1623,9 +1623,10 @@ EXPORT_SYMBOL(netlink_set_err);
> > > >  /* must be called with netlink table grabbed */
> > > >  static void netlink_update_socket_mc(struct netlink_sock *nlk,
> > > >  				     unsigned int group,
> > > > -				     int is_new)
> > > > +				     bool new)
> > > >  {
> > > > -	int old, new = !!is_new, subscriptions;
> > > > +	int subscriptions;
> > > > +	bool old;
> > > >  
> > > >  	old = test_bit(group - 1, nlk->groups);
> > > >  	subscriptions = nlk->subscriptions - old + new;
> > > 
> > > So what is the outcome of "int - bool + bool" in the line above?
> 
> The same as with int - int [0 .. 1] + int [0 .. 1].

No, it is not. bool is defined as _Bool C99 type, so strictly speaking
you are mixing types int - _Bool + _Bool.

Thanks

> 
> Note, the code _already_ uses boolean as integers.
> 
> > FTR, I agree with Leon, the old code is more readable to me/I don't see
> > a practical gain with this change.
> 
> This change does not change the status quo. The code uses booleans as integers
> already (in the callers).
> 
> As I mentioned earlier, the purity of the code (converting booleans to integers
> beforehand) adds unneeded churn and with this change code becomes cleaner at
> least for the (existing) callers.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

