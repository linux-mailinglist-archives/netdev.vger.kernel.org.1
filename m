Return-Path: <netdev+bounces-198748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11488ADD92E
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 19:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C534A0F9D
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24232DFF0E;
	Tue, 17 Jun 2025 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2azXULNl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07172FA65E;
	Tue, 17 Jun 2025 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179192; cv=none; b=tUp9SBaTeumoqjHsl+pEM6bquyYlFgP2W5VMEz7oJiI/lXZTddVXe2KKyyzZO342u+ovA/BBFAlD/rqtUMMJJMFC8/tV3BMc2y7u7CC2lodaLrV/I8bvePftKNM+nHQwWa1wgbCtq+KJBsUJp7Jl7X2U114v/0Kb4L4zMYFpuHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179192; c=relaxed/simple;
	bh=EDRaIpa6wJ70zFFE4EgCOpigV30lcRZVVqC50V/lpiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLrg4jrYkSN16wR/TzRH44UH9qsrObQMBWLBFLctWK9Aco8nikKrCUVEKm3ucG04AyH2jxs2yrir1LLpuNg3GTrJKpme3DIcoCEwwptW+Pl7bviomKP0WbYJmuNWRES2sJsyyqmaSy3m3PoOmsaroEE5+pHlQ2wNDuMZN0M35kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2azXULNl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=qLwy9nWk7FQ2u1fpqK0kJMRSGlwXC3AvpuB1jdFpBfY=; b=2a
	zXULNlLbVY2lA4WHwdHGKkxblSf0mo45WNp+Gn5lID9vZ7Yf/KTBHQBvKl94A+4xcEO4X0/IkCOv1
	0fic+BJ5OSeJ4W/fPjKVypf1HB1qvGsVbPWobIcMDIfuSi488jokKwMlWBP90yNvNeBEfMaQ8fn/m
	DyKUfIC/3rsRfVQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uRZYQ-00GC94-PV; Tue, 17 Jun 2025 18:52:58 +0200
Date: Tue, 17 Jun 2025 18:52:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v4 1/1] dt-bindings: net: convert qca,qca7000.txt yaml
 format
Message-ID: <c4864e76-cec3-4794-825d-cc9ccbf92e43@lunn.ch>
References: <20250616184820.1997098-1-Frank.Li@nxp.com>
 <CAOMZO5DwJ9bk26TBU46_fU0ydwQL__dxUoOULuKyZYWRdbJ0YQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5DwJ9bk26TBU46_fU0ydwQL__dxUoOULuKyZYWRdbJ0YQ@mail.gmail.com>

On Tue, Jun 17, 2025 at 01:09:21PM -0300, Fabio Estevam wrote:
> On Mon, Jun 16, 2025 at 3:48 PM Frank Li <Frank.Li@nxp.com> wrote:
> 
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        ethernet@0 {
> > +            compatible = "qca,qca7000";
> > +            reg = <0x0>;
> > +            interrupt-parent = <&gpio3>;      /* GPIO Bank 3 */
> > +            interrupts = <25 0x1>;            /* Index: 25, rising edge */
> > +            spi-cpha;                         /* SPI mode: CPHA=1 */
> > +            spi-cpol;                         /* SPI mode: CPOL=1 */
> > +            spi-max-frequency = <8000000>;    /* freq: 8 MHz */
> 
> All of these comments are obvious and don't bring any new information.
> 
> I recommend dropping all of them.

I would also suggest replacing 0x1 with IRQ_TYPE_EDGE_RISING.

  Andrew

