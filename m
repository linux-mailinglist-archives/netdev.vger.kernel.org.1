Return-Path: <netdev+bounces-211008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CCDB16277
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 16:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45EBB4E2D7C
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 14:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF6A2C3264;
	Wed, 30 Jul 2025 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Pw9pGtHb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4010F19DF9A
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884967; cv=none; b=W2RiSJKzTfm7eHi0fDgl/3pmQuL27qRv4gIxrpYuqGgUnQ6g0cA5zMBIc+YWBZmD9C1eZvmetbDb6z27Gq5HVExJ4u3uNrNDtFHvDX/NTf0Ge+FLjxUfAO0SIBPfl51nfTwi0Hk10AxcpZQx3DTmXljgh9y8f/D8EzzTQihVknk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884967; c=relaxed/simple;
	bh=JFVv0it87plyeiU2GHHI7nsNr1aTK9aCD6k5C50iFgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2SeP0Wn2MfGNEwVCN2PhRkNpy+8gurSDhndggnAUAOXWuW6TE8NrxvfY+axP9W2cIrPCmsYS5VIa/dZEmYhny6EoQywJ9u27brZZnhb+x/uzNo1ZvTHXRSa73D6rpX/WQgRrO5ZDc8F7hxnhBEXPVohY0uU/cp4Q7nQErIXGBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Pw9pGtHb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=E9hDhVgXJHwfV9NmtWD61ZbLsyi76zmAdJnE8IHVA3E=; b=Pw9pGtHb8aTDSTeOr3ahT8l9Xl
	6fO1fTx2y3ciw5ThZ9asqm/d/v3oH86rIZZAs2zata90mpPzAVoi1VZy+PfNW0mXVti2+VFdYGbmu
	36K01u/msab3sxHAAKRT+Ap9vgyHEDZCPJanveGzrNFhSBQkoxUnYz3OJLYXB5KWPwjc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uh7au-003HjN-0j; Wed, 30 Jul 2025 16:15:48 +0200
Date: Wed, 30 Jul 2025 16:15:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gal Pressman <gal@nvidia.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tariq Toukan <tariqt@nvidia.com>, intel-wired-lan@lists.osuosl.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [RFC PATCH] ethtool: add FEC bins histogramm report
Message-ID: <9703dd41-e1e6-42d8-a43b-01db7b38d11c@lunn.ch>
References: <20250729102354.771859-1-vadfed@meta.com>
 <041f79a2-5f96-4427-b0e2-6a159fbec84a@nvidia.com>
 <1129bf26-273e-4685-a0b8-ed8b0e4050f3@linux.dev>
 <3e84a20e-87ea-413c-9e9d-950605a55bf6@nvidia.com>
 <8b22e9d3-e4d2-4726-9622-28881b2cd406@linux.dev>
 <2dc1fc35-a906-461b-b8c1-857c240604a3@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dc1fc35-a906-461b-b8c1-857c240604a3@nvidia.com>

> Or just let the driver fill the netlink attributes directly? Not sure if
> we have precedent for that.

A variant on that exists, for cable testing. For BaseT, you can have
1, 2 or 4 pairs. Hence you need 1, 2 or 4 test results. There are
helpers which a driver can use to add test results. You can call them
as many times as you want.

The thing about cable testing is that it is not standardised in any
way, so vendors get to use there imagination. However, there are only
a limited number of ways a cable can be broken, and you can measure
the distance to the break, but not too much more. So i provided a set
of helpers to add well defined nested attributes, and it is up to user
space to handle whatever it receives, which might or might not include
all pairs, might have the length attribute or not, etc.

However, it seems like this is well defined in the standard, so i
don't think you need such flexibility. A single helper is all that
should be needed to add a bin.

So it does exist, but this does go against the general pattern.

	Andrew


