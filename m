Return-Path: <netdev+bounces-213345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9637EB24A7D
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581591B610D1
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 13:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24412E8885;
	Wed, 13 Aug 2025 13:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CXR6z/pb"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFEB2D7810;
	Wed, 13 Aug 2025 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755091366; cv=none; b=nGBNEAk4txwEEpnJBQLO5DrpG7lk0SvIJ6iRkszZChZO8DXv8v0rL2vKbDRzqmya6mkiDEqOYJTVLPH5maTm/Ctc4KuzFD1yIbgJYQpphmc0KY2CTjre+8693bpV1T/4mEYATODFuKS5kYCl7pGqyq7yx6oAop4dYPrn7QNegDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755091366; c=relaxed/simple;
	bh=fCBmTh88MZDvXGpdEYpG3d87a68a/e1nlVkSKzJyl74=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ya+T2KwShb4Jjqu10m1+kdoyO57rU8ryLjmtegl90PEQXuBXf1Qm7ljExpEUKz7mZKdoCDODNldlJ09UAKv1u+A1khLGYZ+p1ZiSEshGJlrNHi5EbKF8cHvrgOtswsFhJMRUrZB0eObB4fUGf8HkhcdAR+5W66FyBhn/W0Pt65k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CXR6z/pb; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9F8A743EAD;
	Wed, 13 Aug 2025 13:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755091362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEy8hvPOK8wPfW+EzdJoUVH+gxchH9nuhA1YConvGio=;
	b=CXR6z/pboR+DITWcBEcS2f1Y1u4le7/6kEN5iPk3osmhK1iR1VdTbyAiMbcp56+Xnt0kyz
	1s6VbzfXpCWecv/Onbeayxel8QNwTRM/1q33GUQo/w64yDKf7QHgro5gB1pTohp3ZAAqMJ
	+HjqQEw6wjmyRglZ2MUIxTvyXbPWZtKI87UvSTOflc521RkKLqy+qj544jEB5Wf8bHTyPo
	wOlf3qMhf46LoPs0u3D4aXKwsb63hgv8VWbHG0OUgbRvsD34dYy27uQ1XYK/B9BCWRTePj
	3BKYgCmK8eADsLRnUJ83qXpAF8WNmRu9300UcweR68Bhr6bxdwu07IwHXyFnzQ==
Date: Wed, 13 Aug 2025 15:22:40 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Michal Kubecek
 <mkubecek@suse.cz>, Dent Project <dentproject@linuxfoundation.org>, Kyle
 Swenson <kyle.swenson@est.tech>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH ethtool v2 3/3] ethtool: pse-pd: Add PSE event
 monitoring support
Message-ID: <20250813152240.3b6e7708@kmaincent-XPS-13-7390>
In-Reply-To: <aJyIqz4T1MWuI-p9@pengutronix.de>
References: <20250813-b4-feature_poe_pw_budget-v2-0-0bef6bfcc708@bootlin.com>
	<20250813-b4-feature_poe_pw_budget-v2-3-0bef6bfcc708@bootlin.com>
	<aJyIqz4T1MWuI-p9@pengutronix.de>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeekfeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepp
 hgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehmkhhusggvtggvkhesshhushgvrdgtiidprhgtphhtthhopeguvghnthhprhhojhgvtghtsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
X-GND-Sasl: kory.maincent@bootlin.com

Le Wed, 13 Aug 2025 14:44:27 +0200,
Oleksij Rempel <o.rempel@pengutronix.de> a =C3=A9crit :

> > +int pse_ntf_cb(const struct nlmsghdr *nlhdr, void *data)
> > +{
> > +	const struct nlattr *tb[ETHTOOL_A_PSE_MAX + 1] =3D {}; =20
>=20
> s/ETHTOOL_A_PSE_MAX/ETHTOOL_A_PSE_NTF_MAX ?

Thanks, well spotted.

> > +	struct nl_context *nlctx =3D data;
> > +	DECLARE_ATTR_TB_INFO(tb);
> > +	u64 val;
> > +	int ret, i;
> > +
> > +	ret =3D mnl_attr_parse(nlhdr, GENL_HDRLEN, attr_cb, &tb_info);
> > +	if (ret < 0)
> > +		return MNL_CB_OK;
> > +
> > +	if (!tb[ETHTOOL_A_PSE_NTF_EVENTS])
> > +		return MNL_CB_OK;
> > +
> > +	nlctx->devname =3D get_dev_name(tb[ETHTOOL_A_PSE_HEADER]); =20
>=20
> s/ETHTOOL_A_PSE_HEADER/ETHTOOL_A_PSE_NTF_HEADER ?

Thanks, well spotted.

> > +	if (!dev_ok(nlctx))
> > +		return MNL_CB_OK;
> > +
> > +	open_json_object(NULL);
> > +	print_string(PRINT_ANY, "ifname", "PSE event for %s:\n",
> > +		     nlctx->devname);
> > +	open_json_array("events", "Events:");
> > +	val =3D attr_get_uint(tb[ETHTOOL_A_PSE_NTF_EVENTS]); =20
>=20
> we have here uint but val is u64, is it as expected?

Yes, same behavior in Linux using nla_put_uint().

> > +	for (i =3D 0; 1 << i <=3D ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR; i++)
> > +		if (val & 1 << i)
> > +			print_string(PRINT_ANY, NULL, " %s",
> > +				     pse_events_name(val & 1 << i)); =20
>=20
> Hm, may be it is better to not limit to ETHTOOL_PSE_EVENT_SW_PW_CONTROL_E=
RROR
> and report unknow numeric value. It will keep even old ethtool at least
> partially usable.

Ok, I will loop until UINT_MAX then.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

