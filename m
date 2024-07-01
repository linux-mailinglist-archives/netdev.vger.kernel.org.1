Return-Path: <netdev+bounces-108259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF8791E8B1
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 21:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09BC12832C7
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AB516F848;
	Mon,  1 Jul 2024 19:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NIEDJQw1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B6516F831;
	Mon,  1 Jul 2024 19:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862479; cv=none; b=Bf2oCD5577oc5bBbiP3+A1Eqnlw4T5b8jUf48lCzRCFJf3k5wkd+tHO+Km0dJ5q5i9+aNlknFM+OACI2HP7/Vd8oW2Y0eztFVuMEFlXrlnwB9oHqUCZGlz96KCzeDem0svZufEV2HKE3BKo3z5u685PaWF53ZUhsE1SOf9fu5cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862479; c=relaxed/simple;
	bh=d9fZCxHQRa8rqR1mVTrPIuIHYXb5Ohfiw4TsPiCXbu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/NEeXRcNnjyHktw2rK5qh4baOIOIbhU48R6sWi1K3DGGXQWZa5qaeu/YT/Ubd8Jo32ZH4c0lDniZ1c4Khfh/avfiRNM4CHdzjgy7nHywOgmnDhwwwKXEi0agqAQB0zSzMGL3t1XH9+3F8mixFf0bAXzpHTMReKdT2KOmlfRRJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NIEDJQw1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Hlc7vN0+BS6/oCNmuKai7lZkBuqsjCUBGPNasP7Zohk=; b=NIEDJQw1woLFCZ2yD7zjzMUHvp
	4hZlgWxvjgO6qNHM9rjYe65FG/NGCNoLQ8J07jBOz9TDZ9p0uUwxbtM5xVBn837WrClOtAxK9F/LG
	pjpRyJVt9G2jF4VQH45CglJi2M1hvmIPuocNH1llorE3PlZVeCSuMQp868f7/pN1mRjc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sOMnB-001Zs4-D2; Mon, 01 Jul 2024 21:34:25 +0200
Date: Mon, 1 Jul 2024 21:34:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek Vasut <marex@denx.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, netdev@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Joakim Zhang <qiangqing.zhang@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org, kernel@dh-electronics.com
Subject: Re: [net-next,PATCH v2] dt-bindings: net: realtek,rtl82xx: Document
 known PHY IDs as compatible strings
Message-ID: <0ffaba97-fb41-4fd6-ae1f-f633476322ee@lunn.ch>
References: <20240625184359.153423-1-marex@denx.de>
 <CAMuHMdWJmQ-Jhko-0SO6_dKceXPNu8nx++wgWxxLn=6xPcBMPg@mail.gmail.com>
 <c1b3dffb-f7e5-4c10-8cda-a4c26ce3c74b@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1b3dffb-f7e5-4c10-8cda-a4c26ce3c74b@denx.de>

> > >   properties:
> > > +  compatible:
> > > +    enum:
> > > +      - ethernet-phy-id001c.c800
> > > +      - ethernet-phy-id001c.c816
> > > +      - ethernet-phy-id001c.c838
> > > +      - ethernet-phy-id001c.c840
> > > +      - ethernet-phy-id001c.c848
> > > +      - ethernet-phy-id001c.c849
> > > +      - ethernet-phy-id001c.c84a
> > > +      - ethernet-phy-id001c.c862
> > > +      - ethernet-phy-id001c.c878
> > > +      - ethernet-phy-id001c.c880
> > > +      - ethernet-phy-id001c.c910
> > > +      - ethernet-phy-id001c.c912
> > > +      - ethernet-phy-id001c.c913
> > > +      - ethernet-phy-id001c.c914
> > > +      - ethernet-phy-id001c.c915
> > > +      - ethernet-phy-id001c.c916
> > > +      - ethernet-phy-id001c.c942
> > > +      - ethernet-phy-id001c.c961
> > > +      - ethernet-phy-id001c.cad0
> > > +      - ethernet-phy-id001c.cb00
> > 
> > Can you please elaborate why you didn't add an
> > "ethernet-phy-ieee802.3-c22" fallback?

Sorry, missed the original email.

"ethernet-phy-ieee802.3-c22" is not a fallback. It simply states you
can talk to the PHY using clause 22. This is the default. You can also
use "ethernet-phy-ieee802.3-c45" to say use clause 45 to talk to the
PHY. So you are basically saying which protocol the device is
compatible with, not what driver the device is compatible with.

In general, you don't need a compatible. The bus will be probed and
the ID registers read. A driver matching those IDs will be found and
loaded.

If the PHY does not respond, for example because its clocks are off,
or it is held in reset, you might need to specific the values of the
ID registers in DT. The driver for those ID values will then be
loaded, and the driver can arrange to enable the clocks/reset etc. No
checking is performed if the ID values in DT match the actual
hardware, so use with caution. It is known for boards to swap for a
pin compatible PHY during the life of a product. If you don't have a
compatible, the right thing should happen. With a compatible, you
force the use of the wrong driver.

	  Andrew

