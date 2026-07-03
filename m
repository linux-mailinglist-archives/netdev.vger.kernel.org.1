Return-Path: <netdev+bounces-304543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aqVoDMK0R2pBdwAAu9opvQ
	(envelope-from <netdev+bounces-304543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:10:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B47702B27
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:10:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=walle.cc header.s=mail2022082101 header.b=nbrNh1zR;
	dmarc=pass (policy=quarantine) header.from=walle.cc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304543-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304543-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A289301A042
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 13:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C70F3D34B9;
	Fri,  3 Jul 2026 13:05:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0E31E5207;
	Fri,  3 Jul 2026 13:05:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083930; cv=none; b=H4Xn5AoYPaQrSAAWwPYLs6CnAmzKJtQoPwDwqjx8VBBgGSDRRBQL3Hfo/YhLnW8SFz6rDUYYs+yr8zj88r2HUgbHbWf6pQf/qqu92EiqGuoqa3g+vLBIhEeT/FLWt6PQQBCKz3jk3aiaXOilPQqswYLbgFaEQyyIU/HjxwAVe1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083930; c=relaxed/simple;
	bh=pkRciNKbQ0ifl/vl6bLmmiWMxJohwsx+I+xkNEl8x9k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=s63VMeNIJFSJK/tbXW/+RZzXnhVfspjtt+DfqrrEfeO4YTruDYXhBlf3/dqApkKTD25FeQT8n6qpekwIjWnJKGUJ6eWY0J0W9UdjAXtiaTfi0BWs2ETYmrb+by1WJSPLV5fS4v4578550qlxXjLjQsxS883q4JvtazgeM/y6mms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=nbrNh1zR; arc=none smtp.client-ip=159.69.201.130
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 08A4D4E2;
	Fri,  3 Jul 2026 15:05:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1783083920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OreQQ0XdKsQWlU/ho4QuvNgm2eEyh+R1RO2QdadtGn8=;
	b=nbrNh1zRQhB03C1yi+przXweH4RnERZffAT3vCSDaaxFgOrgAE3JWwxbVruloGmMtqMku6
	T0AD0QKO85hwr06F2IJL9gKTBfGEYHPc9gCGM9BAbBkT9GLr6KFcq80FuRVMVlFY84ZJ01
	/ZT59/9gw0hoskPrAhdBxSIlLd857e/7CKd0ZAYJ9GBaqAgTDBOp1pWkJR3y0eyVwj2C21
	Wl+VrFYl3v7WRGDz8sjsns9LPSiqfPnjo2mf1c8lqxtacN2yZRDbCgvSHOFh1CVV6IH5ga
	XVRmYNWdAmYfOXvdAT8gY979h7ypsdOF0e3iWSproq2mdHOZqf/rcwxsygAS6A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 15:05:19 +0200
Message-Id: <DJOYHWDYJUT1.2PIRY8CG488AY@walle.cc>
Subject: Re: [PATCH v4 1/7] dt-bindings: mtd: jedec,spi-nor: allow the SFDP
 to be exposed via NVMEM
Cc: <Manikandan.M@microchip.com>, <krzk@kernel.org>, <pratyush@kernel.org>,
 <mwalle@kernel.org>, <takahiro.kuwano@infineon.com>, <richard@nod.at>,
 <vigneshr@ti.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <srini@kernel.org>, <Nicolas.Ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
 <linux@armlinux.org.uk>, <richardcochran@gmail.com>, <linusw@kernel.org>,
 <arnd@arndb.de>, <linux-mtd@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
From: "Michael Walle" <michael@walle.cc>
To: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Rob Herring"
 <robh@kernel.org>
X-Mailer: aerc 0.20.0
References: <20260630092406.150587-1-manikandan.m@microchip.com>
 <20260630092406.150587-2-manikandan.m@microchip.com>
 <20260702-utopian-termite-of-perfection-f1f3ec@quoll>
 <860213fd-6a4b-42d4-a8f7-7308e070f09e@microchip.com>
 <20260702163723.GA227454-robh@kernel.org> <8733y0penb.fsf@bootlin.com>
In-Reply-To: <8733y0penb.fsf@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[walle.cc,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[walle.cc:s=mail2022082101];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304543-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[michael@walle.cc,netdev@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:Manikandan.M@microchip.com,m:krzk@kernel.org,m:pratyush@kernel.org,m:mwalle@kernel.org,m:takahiro.kuwano@infineon.com,m:richard@nod.at,m:vigneshr@ti.com,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:srini@kernel.org,m:Nicolas.Ferre@microchip.com,m:alexandre.belloni@bootlin.com,m:claudiu.beznea@tuxon.dev,m:linux@armlinux.org.uk,m:richardcochran@gmail.com,m:linusw@kernel.org,m:arnd@arndb.de,m:linux-mtd@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:miquel.raynal@bootlin.com,m:robh@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[walle.cc:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael@walle.cc,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[microchip.com,kernel.org,infineon.com,nod.at,ti.com,bootlin.com,tuxon.dev,armlinux.org.uk,gmail.com,arndb.de,lists.infradead.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2B47702B27

On Fri Jul 3, 2026 at 12:10 PM CEST, Miquel Raynal wrote:
> On 02/07/2026 at 11:37:23 -05, Rob Herring <robh@kernel.org> wrote:
>
>> On Thu, Jul 02, 2026 at 06:55:15AM +0000, Manikandan.M@microchip.com wro=
te:
>>> Hi Krzysztof,
>>>=20
>>> On 7/2/26 11:46 AM, Krzysztof Kozlowski wrote:
>>> > EXTERNAL EMAIL: Do not click links or open attachments unless you kno=
w the content is safe
>>> >=20
>>> > On Tue, Jun 30, 2026 at 02:54:00PM +0530, Manikandan Muralidharan wro=
te:
>>> >> Add an optional "sfdp" child node (compatible "jedec,sfdp") that
>>> >> describes the SFDP as a read-only NVMEM provider via nvmem.yaml, so =
its
>>> >=20
>>> > What is SFDP?
>>> >=20
>>> SFDP is the Serial Flash Discoverable Parameters -- a JEDEC-standardise=
d
>>> (JESD216) read-only parameter table present in most SPI NOR flashes, th=
e=20
>>> table contents provide basic information about the flash. There are=20
>>> standard tables which are specified by the JEDEC standard and there are=
=20
>>> vendor tables.
>>
>> Is SFDP present or not discoverable? Or we have a table of discoverable=
=20
>> parameters that itself is not discoverable.
>
> SFDP is almost always there. I don't think there are any non SFDP chips
> manufactured today (?).

Oh i bet there are, and IIRC there were some additions lately. Not
sure if the chip was new though.

> The thing is, even if we don't need to define it
> in DT, we might need to point to it in order to extract eg. a unique ID
> or a MAC address through the NVMEM interface.

Exactly. We can detect whether is a SFDP table or not, by trying to
read its signature using the RDSFDP opcode. But as Miquel pointed
out, that's not what this is about. For the nvmem part being useful,
we have to have some node to point to. At the moment, there are
three different kind of NVMEM devices an spi nor flash can create:
 - partitions
 - factory OTP (i.e. OTP by the flash manufacturer)
 - user OTP (i.e. what an OEM could write to)

Now there's a fourth one: SFDP. It can contain vendor specific
tables, which in the mchp case is used to store a mac address,
which is then used for a NIC.

So we somehow has to organize all of them, thus the sfdp node. A
more complete example would be:

flash@0 {
	compatible =3D "jedec,spi-nor";

	partitions {
		compatible =3D "fixed-partitions";

		partition@0 {
			compatible =3D "nvmem-cells";
		};
	};

	otp-1 {
		compatible =3D "factory-otp";
	};

	otp-2 {
		compatible =3D "user-otp";
	};

	sfdp {
		compatile =3D "jedec,sfdp";
	};
};

All being NVMEM devices and expose some kind of data used for
drivers.

HTH
-michael

> SFDP is split into several sub-tables, the first one is mandatory, but
> then there are optional tables which can be discovered dynamically.
>
> Thanks,
> Miqu=C3=A8l


