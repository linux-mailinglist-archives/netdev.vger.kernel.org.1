Return-Path: <netdev+bounces-173926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12055A5C3D7
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0C8189933B
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FD925C6FF;
	Tue, 11 Mar 2025 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NyjgEq5u"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C643F1D516C;
	Tue, 11 Mar 2025 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703569; cv=none; b=ulzxFRnNxxgto8Wr12CKQCmATOrLcNMp4QI3P/ziNmqcKr5tUfT1qhoMM0aNGSxWySYMq+NQz7r4HreYnlqi6AHl0DwA+4yIuXryQbfo8Ofg2q5HKRj8jewksVx3H/5g7Rog1mJlKWX5E3qa3J9/Xmbaif0bA+tRLv2cWIOBJdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703569; c=relaxed/simple;
	bh=6LRWqagH50pWtOvWLzmPECzX8JInGE4+p6WZsOeip2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3PJJ5lhUQOQwtbhgm4u9NUl5vPh7RuPLetBCRKJkDWTFQu5rrXmD0BEcK9jfujLxV9Z7iBhMKagLLXb1FXU+NxxTlTdVKpNvPqlcx/xtL4fnDYTXXzpmfXxym+ofsSyhyt7drq76CR6V1o/01A+ZEPdvK7xF2OyRmo//n1gT2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NyjgEq5u; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 689B844293;
	Tue, 11 Mar 2025 14:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741703559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=03SEpe76buerxO1Tyt/a95sW01GQX/8qXbwOFtLXNuw=;
	b=NyjgEq5uNCMIvDFGJV4PzI9PBcADaiZ+rts7F1XijZiBRgxbhADNqb4p0IdN4cEJu6WMpi
	JxUHcKEk/q2Pdw/oF/ikapdSxAyUThyvIWkCUCFakseQp8l45mVbcXUilmvFTzhBA7UWLC
	PfvzwTymO1lcAjJzoafWUpNjDfGZ7XIrxIzaOOLdLLxruovnbTEiaupjv0tMPiRjNh2xJz
	owTVU6I/Ndid2IM4CRuC0Y0pqkdhvJhqbPOO+4h/RO+DVyXePQ4miKTXZjFaWyKhW6B6Yo
	gJN5eJtTocgxk7BGSc3dA3oSbs6fCxcuQZ0B4DsR7Y64QwyEaAuRw5mRJMo6XQ==
Date: Tue, 11 Mar 2025 15:32:35 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: netdev@vger.kernel.org, Oliver Neukum <oliver@neukum.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Leon Schuermann <leon@is.currently.online>
Subject: Re: [PATCH v2] net-next: cdc_ether|r8152: ThinkPad Hybrid USB-C/A
 Dock quirk
Message-ID: <20250311153235.6cae893a@kmaincent-XPS-13-7390>
In-Reply-To: <f736f5bd20e465656ebe2cc2e7be69c0ada852e3.1741627632.git.p.hahn@avm.de>
References: <f736f5bd20e465656ebe2cc2e7be69c0ada852e3.1741627632.git.p.hahn@avm.de>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvgeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeetgeeghfduhefhleelueeuueejjeegueegffdviedtheejieekhedvveejteehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdplhgvnhhovhhordgtohhmpdgsohhothhlihhnrdgtohhmnecukfhppeduleehrddvledrheegrddvgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrvdelrdehgedrvdegfedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohepphhhrghhnhdqohhsshesrghvmhdruggvpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhlihhvvghrsehnvghukhhumhdrohhrghdprhgtphhtthhopegrnhgurhgvfidon
 hgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 11 Mar 2025 11:21:34 +0100
Philipp Hahn <phahn-oss@avm.de> wrote:

> Lenovo ThinkPad Hybrid USB-C with USB-A Dock (17ef:a359) is affected by
> the same problem as the Lenovo Powered USB-C Travel Hub (17ef:721e):
> Both are based on the Realtek RTL8153B chip used to use the cdc_ether
> driver. However, using this driver, with the system suspended the device
> constantly sends pause-frames as soon as the receive buffer fills up.
> This causes issues with other devices, where some Ethernet switches stop
> forwarding packets altogether.
>=20
> Using the Realtek driver (r8152) fixes this issue. Pause frames are no
> longer sent while the host system is suspended.

It seems patchwork detects it for net-next tree but nonetheless the subject
of your patch should look like this:
[PATCH net-next v2] cdc_ether|r8152: ThinkPad Hybrid USB-C/A Dock quirk

Regards,

> Cc: Oliver Neukum <oliver@neukum.org>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: linux-usb@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Leon Schuermann <leon@is.currently.online>
> Link: https://git.kernel.org/netdev/net/c/cb82a54904a9
> Link: https://git.kernel.org/netdev/net/c/2284bbd0cf39
> Link:
> https://www.lenovo.com/de/de/p/accessories-and-software/docking/docking-u=
sb-docks/40af0135eu
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de> Reviewed-by: Kory Maincent
> <kory.maincent@bootlin.com> ---
> V1 -> V2: Prefix subject with `net-next:`
> V1 -> V2: Add additional Cc:s
>  drivers/net/usb/cdc_ether.c | 7 +++++++
>  drivers/net/usb/r8152.c     | 6 ++++++
>  drivers/net/usb/r8153_ecm.c | 6 ++++++
>  3 files changed, 19 insertions(+)
>=20
> diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
> index a6469235d904..a032c1ded406 100644
> --- a/drivers/net/usb/cdc_ether.c
> +++ b/drivers/net/usb/cdc_ether.c
> @@ -783,6 +783,13 @@ static const struct usb_device_id	products[] =3D {
>  	.driver_info =3D 0,
>  },
> =20
> +/* Lenovo ThinkPad Hybrid USB-C with USB-A Dock (40af0135eu, based on
> Realtek RTL8153) */ +{
> +	USB_DEVICE_AND_INTERFACE_INFO(LENOVO_VENDOR_ID, 0xa359,
> USB_CLASS_COMM,
> +			USB_CDC_SUBCLASS_ETHERNET, USB_CDC_PROTO_NONE),
> +	.driver_info =3D 0,
> +},
> +
>  /* Aquantia AQtion USB to 5GbE Controller (based on AQC111U) */
>  {
>  	USB_DEVICE_AND_INTERFACE_INFO(AQUANTIA_VENDOR_ID, 0xc101,
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 468c73974046..96fa3857d8e2 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -785,6 +785,7 @@ enum rtl8152_flags {
>  #define DEVICE_ID_THINKPAD_USB_C_DONGLE			0x720c
>  #define DEVICE_ID_THINKPAD_USB_C_DOCK_GEN2		0xa387
>  #define DEVICE_ID_THINKPAD_USB_C_DOCK_GEN3		0x3062
> +#define DEVICE_ID_THINKPAD_HYBRID_USB_C_DOCK		0xa359
> =20
>  struct tally_counter {
>  	__le64	tx_packets;
> @@ -9787,6 +9788,7 @@ static bool rtl8152_supports_lenovo_macpassthru(str=
uct
> usb_device *udev) case DEVICE_ID_THINKPAD_USB_C_DOCK_GEN2:
>  		case DEVICE_ID_THINKPAD_USB_C_DOCK_GEN3:
>  		case DEVICE_ID_THINKPAD_USB_C_DONGLE:
> +		case DEVICE_ID_THINKPAD_HYBRID_USB_C_DOCK:
>  			return 1;
>  		}
>  	} else if (vendor_id =3D=3D VENDOR_ID_REALTEK && parent_vendor_id =3D=3D
> VENDOR_ID_LENOVO) { @@ -10064,6 +10066,8 @@ static const struct usb_devic=
e_id
> rtl8152_table[] =3D { { USB_DEVICE(VENDOR_ID_MICROSOFT, 0x0927) },
>  	{ USB_DEVICE(VENDOR_ID_MICROSOFT, 0x0c5e) },
>  	{ USB_DEVICE(VENDOR_ID_SAMSUNG, 0xa101) },
> +
> +	/* Lenovo */
>  	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x304f) },
>  	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3054) },
>  	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3062) },
> @@ -10074,7 +10078,9 @@ static const struct usb_device_id rtl8152_table[]=
 =3D {
>  	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x720c) },
>  	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x7214) },
>  	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x721e) },
> +	{ USB_DEVICE(VENDOR_ID_LENOVO,  0xa359) },
>  	{ USB_DEVICE(VENDOR_ID_LENOVO,  0xa387) },
> +
>  	{ USB_DEVICE(VENDOR_ID_LINKSYS, 0x0041) },
>  	{ USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff) },
>  	{ USB_DEVICE(VENDOR_ID_TPLINK,  0x0601) },
> diff --git a/drivers/net/usb/r8153_ecm.c b/drivers/net/usb/r8153_ecm.c
> index 20b2df8d74ae..8d860dacdf49 100644
> --- a/drivers/net/usb/r8153_ecm.c
> +++ b/drivers/net/usb/r8153_ecm.c
> @@ -135,6 +135,12 @@ static const struct usb_device_id products[] =3D {
>  				      USB_CDC_SUBCLASS_ETHERNET,
> USB_CDC_PROTO_NONE), .driver_info =3D (unsigned long)&r8153_info,
>  },
> +/* Lenovo ThinkPad Hybrid USB-C with USB-A Dock (40af0135eu, based on
> Realtek RTL8153) */ +{
> +	USB_DEVICE_AND_INTERFACE_INFO(VENDOR_ID_LENOVO, 0xa359,
> USB_CLASS_COMM,
> +				      USB_CDC_SUBCLASS_ETHERNET,
> USB_CDC_PROTO_NONE),
> +	.driver_info =3D (unsigned long)&r8153_info,
> +},
> =20
>  	{ },		/* END */
>  };



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

