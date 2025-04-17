Return-Path: <netdev+bounces-183743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 557A0A91CF1
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 14:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E022E19E6424
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 12:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3887164A98;
	Thu, 17 Apr 2025 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NltSaAaH"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A62D28E37;
	Thu, 17 Apr 2025 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894326; cv=none; b=d+WWnD73MPgH+7/W8oCMsp/eo7GmNL7DK9H2Mp3YdmzQ5vCu5eEvcEGCa+lUTM4OUSMMN2LjG/sZ5CnrUWhb1jbDdX+5nvuqjwO79VmAqHaS9o2OPf129A+6pM2FTKB35c8QqLYlBz3W86o25t/06s9kg4HqbbTjdmdwy4SkY8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894326; c=relaxed/simple;
	bh=vwg+JpeNDtpdq8I/n2KI09Z8P3wJ2LAphm0xoV+Veak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfOJyVHfbMaj3OOKPFT9A7JZuTRN/nmClD2b6iPoeTprLhnjKr9fXIBlKMwDM/UxY9vRIiyLMEeq6NILBhRGCm/rTX2VTpjZk7gLMklk4dMQMS1t73uuEVorwZ+Sry/GVIdHMFxMiYmdbcDcBiZrY5OcmdNpKm3DBDzXhGefNIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NltSaAaH; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B84C4398B;
	Thu, 17 Apr 2025 12:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744894315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEQX9dTK5OyX90/v7y2AQbh6bo08Y0ofbCQ+5EMbGpU=;
	b=NltSaAaHRmq9kixVw4vlEq72DFEmVEvEOjzZxfDRfluWkh1O39Z4pHjQGRSHy7KxtHN+JJ
	UuJqSFElgpkny4XrnUoELw1mRxcjR+9gPSPZyeLB2WqH6UG1XQ4uBY28UtjNFKthVD3Yf/
	YYpHzPO4xoGmfAGTf8OeoSm9PP34h75TgCVbJfENfwNp0LT9Er9ZPG8ZvXbAF6a61s50RG
	TgVxzo3D6sWd4tFKEm3ZQmgm95LTbL8FT/noe0GtBl0DmCj5RMSMJo/o08flh3A+1fGh+3
	ssXcJOwXcuRZlXQ/f5ftXFCnKXZxaGITCbAr3Mxhgvkm+YfyLu+zJZoLJJY31g==
Date: Thu, 17 Apr 2025 14:51:52 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 02/13] net: pse-pd: Add support for
 reporting events
Message-ID: <20250417145152.5e6718b1@kmaincent-XPS-13-7390>
In-Reply-To: <20250417144349.5b30afec@fedora.home>
References: <20250416-feature_poe_port_prio-v8-0-446c39dc3738@bootlin.com>
	<20250416-feature_poe_port_prio-v8-2-446c39dc3738@bootlin.com>
	<20250417144349.5b30afec@fedora.home>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdelfeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvt
 hdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvght
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 17 Apr 2025 14:43:49 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> Hi K=C3=B6ry,
>=20
> On Wed, 16 Apr 2025 15:44:17 +0200
> Kory Maincent <kory.maincent@bootlin.com> wrote:
>=20
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > Add support for devm_pse_irq_helper() to register PSE interrupts and re=
port
> > events such as over-current or over-temperature conditions. This follow=
s a
> > similar approach to the regulator API but also sends notifications usin=
g a
> > dedicated PSE ethtool netlink socket.
> >=20
> > Introduce an attached_phydev field in the pse_control structure to store
> > the phydev attached to the PSE PI, ensuring that PSE ethtool notificati=
ons
> > are sent to the correct network interface.
> >=20
> > The attached_phydev pointer is directly tied to the PHY lifecycle. It
> > is set when the PHY is registered and cleared when the PHY is removed.
> > There is no need to use a refcount, as doing so could interfere with
> > the PHY removal process.
> >=20
> > Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> > Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > --- =20
>=20
> [...]
>=20
> > +void ethnl_pse_send_ntf(struct phy_device *phydev, unsigned long notif=
s,
> > +			struct netlink_ext_ack *extack)
> > +{
> > +	struct net_device *netdev =3D phydev->attached_dev;
> > +	struct genl_info info;
> > +	void *reply_payload;
> > +	struct sk_buff *skb;
> > +	int reply_len;
> > +	int ret;
> > +
> > +	if (!netdev || !notifs)
> > +		return;
> > +
> > +	ethnl_info_init_ntf(&info, ETHTOOL_MSG_PSE_NTF);
> > +	info.extack =3D extack;
> > +
> > +	reply_len =3D ethnl_reply_header_size() +
> > +		    nla_total_size(sizeof(u32)); /* _PSE_NTF_EVENTS */
> > +
> > +	skb =3D genlmsg_new(reply_len, GFP_KERNEL); =20
>=20
> I think you need to check skb here before using it.

Oh, thanks for spotting that!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

