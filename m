Return-Path: <netdev+bounces-41755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD277CBD67
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF68E1C2086F
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D763B28E;
	Tue, 17 Oct 2023 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PsBfDznE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D076FC2CD;
	Tue, 17 Oct 2023 08:29:40 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5DBFC;
	Tue, 17 Oct 2023 01:29:38 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF350C000B;
	Tue, 17 Oct 2023 08:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1697531377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dmxQpIzLlbHBHrdjma2mjJV6ut4SgvXoBNrtVZhL5uI=;
	b=PsBfDznE7RSnRaJOw9XIKjq3YkUFypmBDmoCj642kLRhUasKALIlXZeXRmKN1mGp2RuU4n
	sc+RRpz61XhIDXG9nFIhrq0Pm7Nq763J9O+Bbmhq3gXTPyjkgrYby74TsoCURTxJi/d4W/
	auCbKUpZINclHYRcWrATica58YFiQsanftfnTF40zZqISQN4zVBP1KAvlca1hdNfpjsBR+
	JZzx+sQx0eTg8omH2bQFiUSg0p5nfUEqiBJxY529pes55aj3gv6F242Su+gKzqbAqlOynB
	+w6w4ppPeUks1N6rBiH2zOhUNFQCFDPOiCpL9dyMA+23hjnhxRCF/8z5gd6j0g==
Date: Tue, 17 Oct 2023 10:29:20 +0200
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Florian
 Fainelli <florian.fainelli@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Michael Walle <michael@walle.cc>, Jacob Keller
 <jacob.e.keller@intel.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 08/16] net: ethtool: Add a command to expose
 current time stamping layer
Message-ID: <20231017102920.584d759f@kmaincent-XPS-13-7390>
In-Reply-To: <ZS3MKWlnPqTe8gkq@hoboy.vegasvil.org>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
	<20231009155138.86458-9-kory.maincent@bootlin.com>
	<2fbde275-e60b-473d-8488-8f0aa637c294@broadcom.com>
	<20231010102343.3529e4a7@kmaincent-XPS-13-7390>
	<20231013090020.34e9f125@kernel.org>
	<6ef6418d-6e63-49bd-bcc1-cdc6eb0da2d5@lunn.ch>
	<20231016124134.6b271f07@kmaincent-XPS-13-7390>
	<ZS3MKWlnPqTe8gkq@hoboy.vegasvil.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 16 Oct 2023 16:50:01 -0700
Richard Cochran <richardcochran@gmail.com> wrote:

> On Mon, Oct 16, 2023 at 12:41:34PM +0200, K=C3=B6ry Maincent wrote:
>=20
> > Still I am wondering why hardware timestamping capabilities can be enab=
led
> > without phc. =20
>=20
> There is hardware that simply provides time values on frames from a
> free running clock, and that clock cannot be read, set, or adjusted.
>=20
> So the time stamps only relate to other time stamps from the same
> device.  That might be used for performance analysis.

Ok, thanks you for the information.

K=C3=B6ry

