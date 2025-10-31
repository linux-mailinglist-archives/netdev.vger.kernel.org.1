Return-Path: <netdev+bounces-234728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 865D5C26909
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 19:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0732F407D62
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 18:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F0325393B;
	Fri, 31 Oct 2025 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVrDAkeM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893241DF269;
	Fri, 31 Oct 2025 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935421; cv=none; b=RFvqRCmGxJXkbUf91p2zq35tTGJglSv0a7KFXtzlwJXEVlcxY5wyiJqvxAz8XlRlrniGAoT8LyANIqwi2Wehtr0cjwUGbx0gBQsx9TUxPsf9mPYcVCE5H+1+Ke6GOwBQRCSa+Jw636PGC+J+uZqiFSQsyGT+VvJG/hoIA8ZXEuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935421; c=relaxed/simple;
	bh=iH3501CDjRZhHJ4lYEDMDBUiVAkByJFY9KcipmE4ao0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnTII4BuijbDNlAep8tb6R2uhrLiT9oaU/1iCvnXxCvqc047XpZ9lim+l8n1rcaN+D3M3OAA8JtVJwRo4MwTwS9j0Uyd1wElJ2GQ/we49wzPdBCwl8eNENYRUsbu9gl301/ZtbXUiY4Tog/UxNQkKrh+1dULRvRCnrCbFzcF2Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVrDAkeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B8CC4CEFD;
	Fri, 31 Oct 2025 18:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761935421;
	bh=iH3501CDjRZhHJ4lYEDMDBUiVAkByJFY9KcipmE4ao0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LVrDAkeMvZUg+GxUROmbRi0HHxFeD4ggUGNCjRVdcTRenUqGzd3BWk96xlAVr4s4y
	 l3MgMqKPetjdvHSh4k2/Ke0YvdlO0mzRYGC2NOfEfwOV/PmX9AdbSlBynJj4CrpWgC
	 GiNYZG+WCZx/WAEEG+iO/1OcsudejKRhuz/nlkVLgmlN+3071krhAKT+xV5p6OWOfZ
	 H0GmeDPTwDYl5XJvZsAfuQFa6OHL194/Doy0kv3KcYz/js88+XnGZRYIqvE7UQ3ZXd
	 hvxM2mcjLhrj8thGw884hth2dTdJ3He/z4fgnoz0JKcNy7dxqObSneX17WjCVfoG+i
	 UJAB1L/R4IbFA==
Date: Fri, 31 Oct 2025 13:30:19 -0500
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
Message-ID: <20251031183019.GA1606010-robh@kernel.org>
References: <cover.1761823194.git.daniel@makrotopia.org>
 <8025f8c5fcc31adf6c82f78e5cfaf75b0f89397c.1761823194.git.daniel@makrotopia.org>
 <20251031002924.GA516142-robh@kernel.org>
 <20251031003704.GA533574-robh@kernel.org>
 <aQQbCs-zn4PfrS71@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQQbCs-zn4PfrS71@makrotopia.org>

On Fri, Oct 31, 2025 at 02:12:26AM +0000, Daniel Golle wrote:
> On Thu, Oct 30, 2025 at 07:37:04PM -0500, Rob Herring wrote:
> > On Thu, Oct 30, 2025 at 07:29:24PM -0500, Rob Herring wrote:
> > > On Thu, Oct 30, 2025 at 11:28:35AM +0000, Daniel Golle wrote:
> > > > Add support for standard tx-internal-delay-ps and rx-internal-delay-ps
> > > > properties on port nodes to allow fine-tuning of RGMII clock delays.
> > > > 
> > > > The GSWIP switch hardware supports delay values in 500 picosecond
> > > > increments from 0 to 3500 picoseconds, with a post-reset default of 2000
> > > > picoseconds for both TX and RX delays. The driver currently sets the
> > > > delay to 0 in case the PHY is setup to carry out the delay by the
> > > > corresponding interface modes ("rgmii-id", "rgmii-rxid", "rgmii-txid").
> > > > 
> > > > This corresponds to the driver changes that allow adjusting MII delays
> > > > using Device Tree properties instead of relying solely on the PHY
> > > > interface mode.
> > > > 
> > > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > > ---
> > > > v4:
> > > >  * remove misleading defaults
> > > > 
> > > > v3:
> > > >  * redefine ports node so properties are defined actually apply
> > > >  * RGMII port with 2ps delay is 'rgmii-id' mode
> > > > 
> > > >  .../bindings/net/dsa/lantiq,gswip.yaml        | 31 +++++++++++++++++--
> > > >  1 file changed, 28 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > > > index f3154b19af78..8ccbc8942eb3 100644
> > > > --- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > > > +++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > > > @@ -6,8 +6,31 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> > > >  
> > > >  title: Lantiq GSWIP Ethernet switches
> > > >  
> > > > -allOf:
> > > > -  - $ref: dsa.yaml#/$defs/ethernet-ports
> > > 
> > > I think you can keep this as you aren't adding custom properties.
> > 
> > Nevermind, I see the next patch now...
> 
> I suppose you mean [08/12] ("dt-bindings: net: dsa: lantiq,gswip: add
> MaxLinear RMII refclk output property"), right?
> 
> The intention to divert from dsa.yaml#/$defs/ethernet-ports
> already in this patch was to enforce the possible values of
> {rx,tx}-internal-delay-ps.
> 
> Anyway, so you are saying I can keep the change in this patch? Or
> should I just drop the constraints on the possible values of the
> delays and only divert from dsa.yaml#/$defs/ethernet-ports once I'm
> actually adding maxlinear,rmii-refclk-out?

You can keep it as-is, but strictly speaking, some of what's here is 
only needed for [08/12]. Perhaps reverse the order of the patches. Then 
it would be most of the changes here with the maxlinear,rmii-refclk-out 
added, and then the 2nd patch is constraints on 
{rx,tx}-internal-delay-ps.

Rob

