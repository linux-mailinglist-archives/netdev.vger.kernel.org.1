Return-Path: <netdev+bounces-234528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5A8C22CD0
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 01:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49BAA4E201A
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 00:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3CC1DEFE7;
	Fri, 31 Oct 2025 00:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJ5r1ie3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9260F137923;
	Fri, 31 Oct 2025 00:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761871028; cv=none; b=rXGmljbRoIGTb+QbMaGCZ/TxlePXh7e/B0EPx8s7F387yU+Vfq2JS78XBsPcVSuy11BS4K5xMHKLZNX8oeI3iy8R4t0/SCzqO5DvW4cafOZukgJlRLyiNr+kw1p6K+bn+TLJAX2UAFES/2rRZQ7a7bMPWUP58oHYGKw0zsMio10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761871028; c=relaxed/simple;
	bh=jLf1Hh7rEwj5sCd2S4sAxXRf3uxFm8dvr7AA+/qLXb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/NqPlkNaSxVEjM4xVDZiq5/Q0maD7Q1pAhQoCeZF2s5ZfM6VD59dGnuNP6xC+sREyW8YeNAr2MkiYtFYeF53LeM99ZvORvLq/OyixIDp2LGsuSw9e2qq+f6f46jchtTAFgQW1n3kyEU9gv6TVPvmpAGfc/R7ubbU7WBQd2lFPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJ5r1ie3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B925FC4CEF1;
	Fri, 31 Oct 2025 00:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761871026;
	bh=jLf1Hh7rEwj5sCd2S4sAxXRf3uxFm8dvr7AA+/qLXb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aJ5r1ie323hi5IWdAPIVoMekAOs+9PKprMhFwfUgXxM2Bxy0CkZhpZ3oixlDAY7Hq
	 3Jo1VOPBuyVuulRMoK5BrAJftKZr8b+e/Y+l7cHQoNLxgkO9syJeeATgRniETncCS5
	 tkHsTppVPVawO6rvkAqaBnvHFsa7w/GLXs24FT1tc2vTc64f+md4q6cVz3N/qoL+Ko
	 zSwBIIoVKJ0sEMZugGDgiUn9+DG92np5GZKbTLpKADIXMqSHBPhFL1JLT9ecdc/VDE
	 d3n98CzJWdTTgWYmp13SqMUp6Hc0rKB5iP+SZhj7WGv0Pn4kx7dziDQ95isF0DDfcB
	 rhy35ocCcF8WA==
Date: Thu, 30 Oct 2025 19:37:04 -0500
From: Rob Herring <robh@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v5 06/12] dt-bindings: net: dsa: lantiq,gswip:
 add support for MII delay properties
Message-ID: <20251031003704.GA533574-robh@kernel.org>
References: <cover.1761823194.git.daniel@makrotopia.org>
 <8025f8c5fcc31adf6c82f78e5cfaf75b0f89397c.1761823194.git.daniel@makrotopia.org>
 <20251031002924.GA516142-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031002924.GA516142-robh@kernel.org>

On Thu, Oct 30, 2025 at 07:29:24PM -0500, Rob Herring wrote:
> On Thu, Oct 30, 2025 at 11:28:35AM +0000, Daniel Golle wrote:
> > Add support for standard tx-internal-delay-ps and rx-internal-delay-ps
> > properties on port nodes to allow fine-tuning of RGMII clock delays.
> > 
> > The GSWIP switch hardware supports delay values in 500 picosecond
> > increments from 0 to 3500 picoseconds, with a post-reset default of 2000
> > picoseconds for both TX and RX delays. The driver currently sets the
> > delay to 0 in case the PHY is setup to carry out the delay by the
> > corresponding interface modes ("rgmii-id", "rgmii-rxid", "rgmii-txid").
> > 
> > This corresponds to the driver changes that allow adjusting MII delays
> > using Device Tree properties instead of relying solely on the PHY
> > interface mode.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> > v4:
> >  * remove misleading defaults
> > 
> > v3:
> >  * redefine ports node so properties are defined actually apply
> >  * RGMII port with 2ps delay is 'rgmii-id' mode
> > 
> >  .../bindings/net/dsa/lantiq,gswip.yaml        | 31 +++++++++++++++++--
> >  1 file changed, 28 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > index f3154b19af78..8ccbc8942eb3 100644
> > --- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > +++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > @@ -6,8 +6,31 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  
> >  title: Lantiq GSWIP Ethernet switches
> >  
> > -allOf:
> > -  - $ref: dsa.yaml#/$defs/ethernet-ports
> 
> I think you can keep this as you aren't adding custom properties.

Nevermind, I see the next patch now...

