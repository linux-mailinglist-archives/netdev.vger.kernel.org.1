Return-Path: <netdev+bounces-222891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E55B56D24
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 02:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D18F18997ED
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 00:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A3E523A;
	Mon, 15 Sep 2025 00:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG7Up0pu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1FC4A35;
	Mon, 15 Sep 2025 00:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757894905; cv=none; b=p8qTxorfsNsywTLmcQXio9zllc+XSIwCdVI73pG0jOo40jD97kwSVsDYcx46HN1JpqGe+oz4HdLl4xs+QEtoHWSlT2ZPIgGI+4I9+3YlMCTctwECrcktEdm2jIo8cHzbtApef4pjgxEcdhvCPeUP4pswRQuqzN9gBqV1fN/UGk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757894905; c=relaxed/simple;
	bh=6W35ED/5B6DMe6+JEfViwGJLMbiEsNhy58ZClSAv1W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZ2XuPEQ/hR8egDR375kMypE743gznZp60xRjzYR8k1YexKtv9ZLI/oODgHT9oj/R0nzV49/g0DDGfx8jfK+S5KWwjZMl+aKBhtTOVTyMVIesFIrkrAWtwaJFzTMp89PqD8F5s2xJYYSFBgNoJMOpkLEepUB7yYF9aMcNHs0vHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG7Up0pu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AA0C4CEF0;
	Mon, 15 Sep 2025 00:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757894904;
	bh=6W35ED/5B6DMe6+JEfViwGJLMbiEsNhy58ZClSAv1W0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jG7Up0puetanBV5R16T9Mr5YOcJLCgaxlDxjZBjU+M0rn926h86BboU2D7lC0/4S6
	 5LCgjt++UOgh1/WThZ8Q4LAQU4yjViY8zK1f9Fgm2jxbL2Rj59LNHwbjwqLssHC39/
	 dLxezNIv5NX6PfJDyd6Xj+baN3I3Tpx7VG3FXUgXlOLG1MiVwonH5wl1FE/rrzvVLL
	 E8bmf3j4k1b4jsIYIXvyUPwxF3I8hSmfOIOR2tb0C5srcGVfHI2ta2YBQVumVp9Z0r
	 AdHPjLMT17JeVft4fvJGJzfK3fT0EQMaI/rMvoi9mnuJFUxTWlwnZWR9MrdLZXnhKi
	 BTg7oKM3lhJgQ==
Date: Sun, 14 Sep 2025 19:08:23 -0500
From: Rob Herring <robh@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Mark Brown <broonie@kernel.org>, Jonas Rebmann <jre@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/4] dt-bindings: net: dsa: nxp,sja1105: Add reset-gpios
 property
Message-ID: <20250915000823.GA2282513-robh@kernel.org>
References: <20250910-imx8mp-prt8ml-v1-0-fd04aed15670@pengutronix.de>
 <20250910-imx8mp-prt8ml-v1-1-fd04aed15670@pengutronix.de>
 <20250910125611.wmyw2b4jjtxlhsqw@skbuf>
 <20250910143044.jfq5fsv2rlsrr5ku@pengutronix.de>
 <20250910144328.do6t5ilfeclm2xa4@skbuf>
 <693c3d1e-a65b-47ea-9b21-ce1d4a772066@sirena.org.uk>
 <20250910153454.ibh6w7ntxraqvftb@skbuf>
 <20250910155359.tqole7726sapvgzr@pengutronix.de>
 <20250910164231.cnrexx4ds3cdg6lu@skbuf>
 <20250910165518.bzpz5to5dtwe2z6x@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910165518.bzpz5to5dtwe2z6x@pengutronix.de>

On Wed, Sep 10, 2025 at 06:55:18PM +0200, Marco Felsch wrote:
> On 25-09-10, Vladimir Oltean wrote:
> > On Wed, Sep 10, 2025 at 05:53:59PM +0200, Marco Felsch wrote:
> > > IMHO silently removing the support will break designs for sure and
> > > should never be done. As said, imagine that the firmware will handle the
> > > supplies and the driver only needs to release the reset. If you silently
> > > remove the support, the device will be kept in reset-state. In field
> > > firmware updates are seldom, so you break your device by updating to a
> > > new kernel.
> > > 
> > > One could argue that the driver supported it but there was no dt-binding
> > > yet, so it was a hidden/unstable feature but I don't know the policy.
> > 
> > Ok, I didn't think about, or meet, the case where Linux is required by
> > previous boot stages to deassert the reset. It is the first time you are
> > explicitly saying this, though.
> > 
> > So we can keep and document the 'reset-gpios' support, but we need to
> > explicitly point out that if present, it does not supplant the need to
> > ensure the proper POR sequence as per AH1704.
> 
> We could do that but I think that no one should assume that the driver
> ensures this due to the missing power-supply and clock support. But this
> goes to the DT maintainers. IMHO we shouldn't mention any document
> within the binding, maybe within the commit message, since those
> documents may get removed.

We probably have lots of dead links... So what's one more possible one. 
If the information is useful, then I'd put the link there.

Rob

