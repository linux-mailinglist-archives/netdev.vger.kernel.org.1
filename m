Return-Path: <netdev+bounces-190293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C44AB6109
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 05:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4271B428D3
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 03:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9ED1DEFDA;
	Wed, 14 May 2025 03:01:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431E51EB36;
	Wed, 14 May 2025 03:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747191673; cv=none; b=GcAzN5P7l8E0WpO4j08i8ROAT/MigjqI+z5Lva+IDkV2SIskH4DBUMY8BBpJ2pLZp59rPXOYPRZpRCUvyXmy+Rgr658ga3UnaOzFfSHMw8BEPCwaJc1d0byeDQpSFnAMfAiWuNipsJZuT6KinLU+dbwPBMYvaWf8dVOkxS1JdCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747191673; c=relaxed/simple;
	bh=xA22KYLVW5DEbA9JJRwxFbXTmSmySKyThBXCXBOEf3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVbxmXuWhKpQFzvynBYuTUJRFvUgum/aHAwNqbIlskcY1wtraAD/fInU66dQPRBfRUSmNlyYPi1ermYZ5DYRHLB3GISZov1haLVoKRzqkQeDzgKMnKwKDLq4wPKhf4RyWaFrYUtEK4pWB0DSxVXjc/FlrAdbYdmMw5cnLvg0Nz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uF2Gt-000000000IX-1uz7;
	Wed, 14 May 2025 03:00:59 +0000
Date: Wed, 14 May 2025 04:00:54 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [net-next PATCH v4 03/11] net: phylink: introduce internal
 phylink PCS handling
Message-ID: <aCQHZnAstBXbYzgy@makrotopia.org>
References: <20250511201250.3789083-1-ansuelsmth@gmail.com>
 <20250511201250.3789083-4-ansuelsmth@gmail.com>
 <5d004048-ef8f-42ad-8f17-d1e4d495f57f@linux.dev>
 <aCOXfw-krDZo9phk@makrotopia.org>
 <7b50d202-e7f6-41cb-b868-6e6b33d4a2b9@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b50d202-e7f6-41cb-b868-6e6b33d4a2b9@linux.dev>

On Tue, May 13, 2025 at 03:23:32PM -0400, Sean Anderson wrote:
> On 5/13/25 15:03, Daniel Golle wrote:
> > just instead of having many
> > more or less identical implementations of .mac_select_pcs, this
> > functionality is moved into phylink. As a nice side-effect that also
> > makes managing the life-cycle of the PCS more easy, so we won't need all
> > the wrappers for all the PCS OPs.
> 
> I think the wrapper approach is very obviously correct. This way has me
> worried about exciting new concurrency bugs.

You may not be surprised to read that this was also our starting point 2
months ago, I had implemented support for standalone PCS very similar to
the approach you have published now, using refcnt'ed instances and
locked wrapper functions for all OPs. My approach, like yours, was to
create a new subsystem for standalone PCS drivers which is orthogonal to
phylink and only requires very few very small changes to phylink itself.
It was a draft and not as complete and well-documented like your series
now, of course.

I've then shared that implementation with Christian and some other
experienced OpenWrt developers and we concluded that having phylink handle
the PCS lifecycle and PCS selection would be the better and more elegant
approach for multiple reasons:
 - The lifetime management of the wrapper instances becomes tricky:
   We would either have to live with them being allocated by the
   MAC-driver (imagine test-case doing unbind and then bind in a loop
   for a while -- we would end up oom). Or we need some kind of garbage
   collecting mechanism which frees the wrapper once refcnt is zero --
   and as .select_pcs would 'get' the PCS (ie. bump refcnt) we'd need a
   'put' equivalent (eg. a .pcs_destroy() OP) in phylink.

   Russell repeatedly pointed me to the possibility of a PCS
   "disappearing" (and potentially "reappearing" some time later), and
   in this case it is unclear who would then ever call pcs_put(), or
   even notify the Ethernet driver or phylink about the PCS now being
   available (again). Using device_link_add(), like it is done in
   pcs-rzn1-miic.c, prevents the worst (ie. use-after-free), but also
   impacts all other netdevs exposed by the same Ethernet driver
   instance, and has a few other rather ugly implications.

 - phylink currently expects .mac_select_pcs to never fail. But we may
   need a mechanism similar to probe deferral in case the PCS is not
   yet available.
   Your series partially solves this in patch 11/11 "of: property: Add
   device link support for PCS", but also that still won't make the link
   come back in case of a PCS showing up late to the party, eg. due to
   constraints such as phy drivers (drivers/phy, not drivers/net/phy)
   waiting for nvmem providers, or PCS instances "going away" and
   "coming back" later.

 - removal of a PCS instance (eg. via sysfs unbind) would still
   require changes to phylink. there is no phylink function to
   impair the link in this case, and using dev_close() is a bit ugly,
   and also won't bring the link back up once the PCS (re-)appears.

 - phylink anyway is the only user of PCS drivers, and will very likely
   always be. So why create another subsystem?

All that being said I also see potential problems with Christians
current implementation as it doesn't prevent the Ethernet driver to
still store a pointer to struct phylink_pcs (returned eg. from
fwnode_pcs_get()).

Hence I would like to see an even more tight integration with phylink,
in the sense that pointers to 'struct phylink_pcs' should never be
exposed to the MAC driver, as only in that way we can be sure that
phylink, and only phylink, is responsible for reacting to a PCS "going
away".

Ie. instead of fwnode_phylink_pcs_parse() handing pointers to struct
phylink_pcs to the Ethernet driver, so it can use it to populate struct
phylink_config available_pcs member, this should be the responsibility
of phylink alltogether, directly populating the list of available PCS in
phylink's private structure.

Similarly, there should not be fwnode_pcs_get() but rather phylink
providing a function fwnode_phylink_pcs_register(phylink, fwnode) which
directly adds the PCS referenced to the internal list of available PCS.

I hope we can pick the best of all the suggested implementations, and
together come up with something even better.

