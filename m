Return-Path: <netdev+bounces-303546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v0u1IufTRGoU1goAu9opvQ
	(envelope-from <netdev+bounces-303546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:46:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DC96EB3D9
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:46:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=walle.cc header.s=mail2022082101 header.b=h67gQjQB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303546-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303546-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=walle.cc;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C78C30DFBA8
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 08:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8DA3ED3AF;
	Wed,  1 Jul 2026 08:43:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D88A3E0251;
	Wed,  1 Jul 2026 08:43:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895435; cv=none; b=JtJPuem2IhR+vWYtMzvmKDZuRzSCHvKgGBeRPAN4YS+hqJx/RgdQU4FBwpO6cgV+3HYW6Gh7ViJH3XYEXyfDBED7OEXJa1eUsvRZ3y+or+WGmSlzdYHCFujE8L7Vo/CvILf1Hx+vZr4RSbFyfSAIjIbqCBCWFywvJm9MoBndaSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895435; c=relaxed/simple;
	bh=IruFylOlTxcJm5hyyL/eFNS0o3To89PaJ6QDaYNLHrE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=U1uxUj0pOBzpFR5x2gQfcVljOGhO2NJnNEMTKcy9cjPbSw0987Aq3Y4ij1FhfcBgkbGLJ7FcpFa9/D7b33LkDTU9Htyp1hQFRgJrBXTCwhN/xoMSWMkwLVloKHu/A4wFBEp4MGCg3VlLiLi3fYdTS7wUv88k2mrseMzcxhLZIZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=h67gQjQB; arc=none smtp.client-ip=159.69.201.130
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 880D35B6;
	Wed,  1 Jul 2026 10:34:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1782894878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OV8gaPiQO40kpe0vnMtC2nXL8DrZwaWi9384uLF+/CY=;
	b=h67gQjQBVSxm1zGv4NOn57N9gJTCxMWWp3YcNhFmHdxQHNawukaOxBFeoTLd7xSSsUmHEb
	QHOO7Rdm6R9+IhDqEV//349b1hxptHCVf1Ld31NKjoCEVG3yZWiCutXBBQIV2AETWkCvG0
	2cvaUpJLCDQ65E9H4T7Bz3ZxH6x4FUP/Fk5LNDw6NweLNxPVKswcK05bPvhIWZ5hC03CGb
	zu9OuKTRqyoO5BGXK6QgIby1CRCo3dgJBzS+jDk1gA31fpjROSM1sYk8vN6mvqxzcilIxi
	5sg1p4WSH4Ikuhd3m7Ug/A13vn7+YhQwohIgElCdJhJ/Z95aXmB3+k3/Z3v1Aw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=7dc42cc06038756823fa21ce147a9856939103d1b021230f1b15a2a59c78;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 01 Jul 2026 10:34:35 +0200
Message-Id: <DJN3HIIAY4LE.3MXU9Q2YFSCJJ@walle.cc>
Subject: Re: [PATCH v4 1/7] dt-bindings: mtd: jedec,spi-nor: allow the SFDP
 to be exposed via NVMEM
Cc: <pratyush@kernel.org>, <mwalle@kernel.org>,
 <takahiro.kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
 <richard@nod.at>, <vigneshr@ti.com>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <srini@kernel.org>,
 <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <claudiu.beznea@tuxon.dev>, <linux@armlinux.org.uk>,
 <richardcochran@gmail.com>, <arnd@arndb.de>,
 <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <netdev@vger.kernel.org>
From: "Michael Walle" <michael@walle.cc>
To: "Linus Walleij" <linusw@kernel.org>, "Manikandan Muralidharan"
 <manikandan.m@microchip.com>
X-Mailer: aerc 0.20.0
References: <20260630092406.150587-1-manikandan.m@microchip.com>
 <20260630092406.150587-2-manikandan.m@microchip.com>
 <CAD++jL=FkEfpz-LW0vmPpZ28fLfGFMWo5E479Mapz55YUxKNAQ@mail.gmail.com>
In-Reply-To: <CAD++jL=FkEfpz-LW0vmPpZ28fLfGFMWo5E479Mapz55YUxKNAQ@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[walle.cc,quarantine];
	MV_CASE(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[walle.cc:s=mail2022082101];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303546-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[michael@walle.cc,netdev@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:pratyush@kernel.org,m:mwalle@kernel.org,m:takahiro.kuwano@infineon.com,m:miquel.raynal@bootlin.com,m:richard@nod.at,m:vigneshr@ti.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:srini@kernel.org,m:nicolas.ferre@microchip.com,m:alexandre.belloni@bootlin.com,m:claudiu.beznea@tuxon.dev,m:linux@armlinux.org.uk,m:richardcochran@gmail.com,m:arnd@arndb.de,m:linux-mtd@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linusw@kernel.org,m:manikandan.m@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[walle.cc:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael@walle.cc,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,infineon.com,bootlin.com,nod.at,ti.com,microchip.com,tuxon.dev,armlinux.org.uk,gmail.com,arndb.de,lists.infradead.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,walle.cc:dkim,walle.cc:mid,walle.cc:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22DC96EB3D9

--7dc42cc06038756823fa21ce147a9856939103d1b021230f1b15a2a59c78
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

>> Add an optional "sfdp" child node (compatible "jedec,sfdp") that
>> describes the SFDP as a read-only NVMEM provider via nvmem.yaml, so its
>> contents (e.g. a vendor EUI-48/EUI-64) can be read through NVMEM cells.
>>
>> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
>
> I would expect it to follow nvmem conventions like this, notice
> compatibles specific-to-general with sfdp first:


> sfdp {
>     /* NVMEM provided by SFDP */
>     compatible =3D "jedec,sfdp", "nvmem-cells";
>     label =3D "SFDP";

Isn't using label frowned upon? I wouldn't add that to the example.

>     read-only;
>     #address-cells =3D <1>;
>     #size-cells =3D <1>;
>
>     mac0: macaddr@0x00 {
>         reg =3D <0x00 0x06>;
>     };
>     mac1: macaddr@0x06 {
>         reg =3D <0x06 0x06>;
>     };
> };

If I'm correct, this is the old style, see commit bd912c991d2e
("dt-bindings: nvmem: layouts: add fixed-layout"). So it should
eventually look like:

sfdp {
     compatible =3D "jedec,sfdp";

     nvmem-layout {
	     compatible =3D "microchip,sst26vf-sfdp-eui";
     };
};

Which is what patch series will lead to.

Also I'm not sure if we really need to add the "nvmem-cells" here.
IIRC in MTD it was there to tell a driver to add an nvmem device to
an already existing compatible/node.

Apart from the MTD case, I've just found qcom,smem-part,yaml which
has compatible =3D "nvmem-cells".

-michael

> Your example should definitely be more elaborate like this,
> just an opaque sfdp node will not suffice. Maybe a separate
> example?
>
> Yours,
> Linus Walleij


--7dc42cc06038756823fa21ce147a9856939103d1b021230f1b15a2a59c78
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCakTRGxEcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+PesAYCvxlMrRPb3CpBzPYndulCo9xHSs8WFx8GM
YRvSkp3iZq/ziK9zzw8WIc8dB59hR7gBgJcgQcwu/qH+CFtJvfiWDEH4EWXU3HSR
2Jx1LkNCSYEaHycVFgiepmorZPwBghbBeA==
=IjRV
-----END PGP SIGNATURE-----

--7dc42cc06038756823fa21ce147a9856939103d1b021230f1b15a2a59c78--

