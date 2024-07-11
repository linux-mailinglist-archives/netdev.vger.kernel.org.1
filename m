Return-Path: <netdev+bounces-110753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0CB92E29A
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 10:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD66284E7C
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 08:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4281514D1;
	Thu, 11 Jul 2024 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFKvySYO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6245978283;
	Thu, 11 Jul 2024 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720687385; cv=none; b=OWw5wu+TP44wJI6WIhK1Zt9gO9/2wMBjWaLCSCBuxHs0bxtJh0/JbOSzm96hrzIzMGmnudIzKKwNOjreoadJSZgpmltANZ1qY3ZS1kWz24DEcu+Mua8iLcQDVpiLq8ELsAmnDD5Dv8J56ZIehI30YBOqSZytro4EmDYyBE05Jbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720687385; c=relaxed/simple;
	bh=OL4eMLIAlEEIyeP5j2TAdnY8as6JlFOV8HUyYszQARA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiULG09MBurnrhGoFqXrWDy+uDyoyMGc8HdcE/6XY8do56PPicFNaU1NO0PDqCYFnm4jZDux6U2NAnaq0jbbzdhTMH4CCbi7tpnULLXNpVnvt9Mbhpuo23Y7KU28LTjhBNrfQ3vCF8CGgWJP4htzWQGjDbnaUBKY5L8chHjruVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFKvySYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D926BC116B1;
	Thu, 11 Jul 2024 08:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720687385;
	bh=OL4eMLIAlEEIyeP5j2TAdnY8as6JlFOV8HUyYszQARA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vFKvySYOkZqFLvjtDMVDDC3owPWrlfU/70Mh723bXbR054nGZKVgKBCdEuoyISOlp
	 gV/+ut4uccROqJPvbShJ1vxfT9Dc41+bZg6+5MhUNOX+XTxWI8BU0aIzM2qO6S95L7
	 rQweihii33oJlxoV+A/TfhbG/3bN7Gv8TZtJA2IsnWXCVRp2wb35WY2lEEBpcbf59K
	 a7/LvnLowWuhPLqVMEwMHL4QBNVw/UssOINyuZ6U9TzbIDY/0ck1hvHksKmmt7FHkT
	 aRcZkX7DXr/6qQuFQVZj7helOTMx6+21ZqxV8j/DlZakN9z2fPfTU4gWjaJO8JgJv+
	 nHO5HPtPVwSYw==
Date: Thu, 11 Jul 2024 09:43:00 +0100
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2 1/2] net: pse-pd: Do not return EOPNOSUPP if config is
 null
Message-ID: <20240711084300.GA8788@kernel.org>
References: <20240710114232.257190-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710114232.257190-1-kory.maincent@bootlin.com>

On Wed, Jul 10, 2024 at 01:42:30PM +0200, Kory Maincent wrote:
> For a PSE supporting both c33 and PoDL, setting config for one type of PoE
> leaves the other type's config null. Currently, this case returns
> EOPNOTSUPP, which is incorrect. Instead, we should do nothing if the
> configuration is empty.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> Fixes: d83e13761d5b ("net: pse-pd: Use regulator framework within PSE framework")
> ---
> 
> Changes in v2:
> - New patch to fix dealing with a null config.

Hi Kory,

A few thing from a process perspective:

1. As fixes, with fixes tags (good!), this patchset seems like it is
   appropriate for net rather than net-next. And indeed it applies
   to net but not net-next. However, the absence of a target tree
   confuses our CI which failed to apply the patchset to net-next.

   Probably this means it should be reposted, targeted at net.

   Subject: [Patch v3 net x/y] ...

   See: https://docs.kernel.org/process/maintainer-netdev.html

2. Please provide a cover letter for patch sets with more than one
   (but not just one) patch. That provides an overview of how
   the patches relate to each other. And a convenient anchor for
   feedback such as point 1 above.

...

