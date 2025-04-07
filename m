Return-Path: <netdev+bounces-179760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F05A7E762
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016D43B7F22
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE72B21323E;
	Mon,  7 Apr 2025 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QYtsHvD9"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5665C21148B;
	Mon,  7 Apr 2025 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044699; cv=none; b=Zkaw/SV8lfJr4oFEsdgiVmw3rUw+nKzhmge9+cdayMXaJn1N+jc5K8eo+QwVQDSFNmk6wMC6k+unHNsXYaeLpASKLiQA9+a8ACfrZYswj5zz8JuLODluFKkqv27W3puc8FsDmkCcCyE3h8/ycbCXLvFMMD0kz9WtZ8qm1g2Tmw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044699; c=relaxed/simple;
	bh=ZzdiNXHuskzVB8qqfZ+KEStr8CQJVJ+kBhPW7XeWeY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jNBhiXJ7tXekHnEtuKlZZSaX270BepfoafvrVBYcdDRlRTRfNcuQDiyEfl3lGvxx4nIJ4YUqJ1Q0mB02TLDwOBk/Fgd4eqn2dCSY7jL7kp5PdHgDR7PQx1rnoYkWDL+l2v6NXl+aMWdRfiF/olUaW4MN+6WGmKfs7wwdEy+LvpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QYtsHvD9; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5D6084439C;
	Mon,  7 Apr 2025 16:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744044694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H1iMwU3ajJMnMcuSPtx2gxJdVmNL3/UCZFSDfHMc86M=;
	b=QYtsHvD9DTOGiFETvj+We/hzG7h1j54bIDzufGVCgmf9PbORkltx0JqHpWe+aPyMEzw+BY
	BLDFSYOw4BRIzx3SstgbwbImXzPVHlUsTqWNRXQMNtJwh5XyQjekREZy25k9HxtytuDyZN
	qV59Wm1ThVZCXTV3w9PeAglD6hgRNxlH/IwDQIUaCvNdsDNQovSjkUY3vwG7oobLiOXONu
	3fcpBrr6eKbvYY2tiur2Zp4fDRRWjdS+BQCz++nt2rDXujLJerJnif/Ws3w7qaHXJ5i+Nh
	B4dnM/nggzNsA6Hna2/Z08ckKMc22MO7DWqmr40zEGjIdMt7bvIlwiAJxj0IUQ==
Date: Mon, 7 Apr 2025 18:51:29 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Christian Marangi
 <ansuelsmth@gmail.com>, upstream@airoha.com, Heiner Kallweit
 <hkallweit1@gmail.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Clark Wang <xiaoning.wang@nxp.com>, Claudiu
 Beznea <claudiu.beznea@microchip.com>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Conor Dooley <conor+dt@kernel.org>, Ioana Ciornei
 <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>, Joyce Ooi
 <joyce.ooi@intel.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Li Yang
 <leoyang.li@nxp.com>, Madalin Bucur <madalin.bucur@nxp.com>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal
 Simek <michal.simek@amd.com>, Naveen N Rao <naveen@kernel.org>, Nicholas
 Piggin <npiggin@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Rob Herring
 <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>, Robert Hancock
 <robert.hancock@calian.com>, Saravana Kannan <saravanak@google.com>, Shawn
 Guo <shawnguo@kernel.org>, UNGLinuxDriver@microchip.com, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC net-next PATCH 00/13] Add PCS core support
Message-ID: <20250407185129.654e7c9c@kmaincent-XPS-13-7390>
In-Reply-To: <720b6db8-49c5-47e7-98da-f044fc38fc1a@linux.dev>
References: <20250403181907.1947517-1-sean.anderson@linux.dev>
	<20250407182738.498d96b0@kmaincent-XPS-13-7390>
	<720b6db8-49c5-47e7-98da-f044fc38fc1a@linux.dev>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtjedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfduveekuedtvdeiffduleetvdegteetveetvdelteehhfeuhfegvdeuuedtleegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeegledprhgtphhtthhopehsvggrnhdrrghnuggvrhhsohhnsehlihhnuhigrdguvghvpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegur
 ghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhk
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 7 Apr 2025 12:33:28 -0400
Sean Anderson <sean.anderson@linux.dev> wrote:

> On 4/7/25 12:27, Kory Maincent wrote:
> > On Thu,  3 Apr 2025 14:18:54 -0400
> > Sean Anderson <sean.anderson@linux.dev> wrote:
> >  =20
> >> This series adds support for creating PCSs as devices on a bus with a
> >> driver (patch 3). As initial users,
> >>=20
> >> - The Lynx PCS (and all of its users) is converted to this system (pat=
ch 5)
> >> - The Xilinx PCS is broken out from the AXI Ethernet driver (patches 6=
-8)
> >> - The Cadence MACB driver is converted to support external PCSs (namely
> >>   the Xilinx PCS) (patches 9-10).
> >>=20
> >> The last few patches add device links for pcs-handle to improve boot t=
imes,
> >> and add compatibles for all Lynx PCSs.
> >>=20
> >> Care has been taken to ensure backwards-compatibility. The main source
> >> of this is that many PCS devices lack compatibles and get detected as
> >> PHYs. To address this, pcs_get_by_fwnode_compat allows drivers to edit
> >> the devicetree to add appropriate compatibles. =20
> >=20
> > I don't dive into your patch series and I don't know if you have heard
> > about it but Christian Marangi is currently working on fwnode for PCS:
> > https://lore.kernel.org/netdev/20250406221423.9723-1-ansuelsmth@gmail.c=
om
> >=20
> > Maybe you should sync with him! =20
>=20
> I saw that series and made some comments. He is CC'd on this one.

Oh indeed, you have replied on his v1, sorry I missed it.
It seems he forgot to add you in CC in the v2.

> I think this approach has two advantages:
>=20
> - It completely solves the problem of the PCS being unregistered while the
> netdev (or whatever) is up
> - I have designed the interface to make it easy to convert existing
>   drivers that may not be able to use the "standard" probing process
>   (because they have to support other devicetree structures for
>   backwards-compatibility).

Ok, thanks for the clarification!
I was working on the axienet driver to add support for the 10G version that=
's
why I discovered your series.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

