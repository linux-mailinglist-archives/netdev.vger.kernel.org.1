Return-Path: <netdev+bounces-95897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDEE8C3CF9
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3176B21E7B
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 08:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C611474B8;
	Mon, 13 May 2024 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oock7PWb"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83822E3E0;
	Mon, 13 May 2024 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588124; cv=none; b=B/9cm6ezJ3huG6zAdQvF3Q7LIeBRCNjWsJ2JOb60BnwU4KO/pp0sWCgqqt6f0m9culr3cU/d/I/PmvfADifuRFnNYJcWVTacwysl++lUxExvR9E3RK6fAMV17U24C5t6CxBC98nOilU0q9P720f93l2izYY09vZXdxkaSm3I75g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588124; c=relaxed/simple;
	bh=AW2sukJRj2geuK1F9II8B110DE6RMhlsVGXdQzA0v3A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgczDNjHWLjz9LSRDR4QEo+gtwxLfvW2dQ8IVDgRGJkspCulUCvI3jY2468tcjeOUAo9WN821JBMQI2LIccGwk8n/GrHi+1xKTXyLCkPEzDd9u/d2q1WnMwkETDholibObhyIjsEza6i5SBQdfC7V2Fg4YXv5wSRBGtMFOdBXVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oock7PWb; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 280C7C000C;
	Mon, 13 May 2024 08:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715588119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mbGGp7SUz0j9p4WKrV3fnYD16K5tyXowtYKOvw0w32A=;
	b=oock7PWbI+10CZlHnnUwF3sji3bqsp7AAjq8ptWK0z+UTcblDcOx4MKG31JMdR8iHX9ZNl
	0qa5LNEy+PlwHpPLX6ZRq98Nf4pUROdeL+0uRHKqGUB90mezdvhLff9MhFrNaDbNB2w3JF
	0GFQPEZw4NTBp+OWpYNGpbdleCRq8rcQDd+JTY9BS5iULEtjE6TnDUpsUsU0pykvcWC/z+
	EOggSlPDSJQ4d4TqZS/Z2JF3UCDICYC1HRnQyWyBhiFMYigGfW8GfExprLtmIhrA68Bu3B
	A5/ZQhjb95rF58DjMRTv3EDDtL3SLhXm/TBIHptCdH+advrxjyFuyPLfoNBI9g==
Date: Mon, 13 May 2024 10:15:17 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>, Simon Horman
 <horms@kernel.org>, mwojtas@chromium.org, Nathan Chancellor
 <nathan@kernel.org>, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next 2/2] net: phy: phy_link_topology:
 Lazy-initialize the link topology
Message-ID: <20240513101517.2c88ece0@device-28.home>
In-Reply-To: <20240513100729.39713abb@device-28.home>
References: <20240507102822.2023826-1-maxime.chevallier@bootlin.com>
	<20240507102822.2023826-3-maxime.chevallier@bootlin.com>
	<6cedd632-d555-4c17-81cb-984af73f2c08@gmail.com>
	<20240513100729.39713abb@device-28.home>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

On Mon, 13 May 2024 10:07:29 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> Hello again Heiner,
> 
> On Wed, 8 May 2024 07:44:22 +0200
> Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
> > On 07.05.2024 12:28, Maxime Chevallier wrote:  
> > > Having the net_device's init path for the link_topology depend on
> > > IS_REACHABLE(PHYLIB)-protected helpers triggers errors when modules are being
> > > built with phylib as a module as-well, as they expect netdev->link_topo
> > > to be initialized.
> > > 
> > > Move the link_topo initialization at the first PHY insertion, which will
> > > both improve the memory usage, and make the behaviour more predicatble
> > > and robust.  
> 
> I agree with some of the comments, as stated in my previous mail,
> however I'm struggling to find the time to fix, and re-test everything,
> especially before net-next closes. Would it be OK if I re-send with a
> fix for the kbuild bot warning, improve the commit log as you
> mentionned for patch 1 so that at least the issue can be solved ?
> 
> I still have the netlink part of this work to send, so I definitely
> will have to rework that, but with a bit less time constraints so that
> I can properly re-test everything.

To clarify, I'm mostly talking about the merge of
phy_link_topology_core.h into phy_link_topology.h, I fear that this
could get rejected because of the added #include that would clutter a
bit net/core/dev.c with functions that are barely used.

All your other comments make perfect sense to me and I'm testing these
as we speak.

Regards,

Maxime

> 
> Best regards,
> 
> Maxime


