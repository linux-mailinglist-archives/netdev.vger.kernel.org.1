Return-Path: <netdev+bounces-304247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id km0uGmmvRmpLbgsAu9opvQ
	(envelope-from <netdev+bounces-304247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:35:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7B26FC1D5
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:35:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=uQ3t3hfE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304247-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304247-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=mailbox.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5A4C32E60E1
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 17:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F08E390CB2;
	Thu,  2 Jul 2026 17:59:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD26437A83C;
	Thu,  2 Jul 2026 17:59:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783015178; cv=none; b=GYbMOfEru3hNd34AT59dRBjxsE0BBt8cjgypeVWRSxd417k9lAqc/kfY91JCw9J7dnVtK1KvtCvv4JeDWVB9Hjs3kGurtGf7FDEI8rMosVRpqo3VMrVV4ZfBWe94/D28ZlytgsWfQbQMg9mzxxi1V6FZ5MUzIjH+oQIVorECrYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783015178; c=relaxed/simple;
	bh=LoyIyESVrjYzJI6SPmZ/GDfq/dL8YkCIIXoSL4OMCO8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SoSPVSr0tODTVuaNAReJcE5E07gWAD0Jysw16hpa8b90tJook1nVftUfm/E8QeYx6P9rvekCmRmQyHK9gjIXGgV8jEOVm9sn1ZQ/24EcTmBZs+LzyWpqM/HTyExO0idsjVWmT/VbhhqKjsFmJGWSycNc0/VB7Sw3T3qQIxxgKvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=uQ3t3hfE; arc=none smtp.client-ip=80.241.56.152
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4grl5J28TKz9vC5;
	Thu,  2 Jul 2026 19:59:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783015172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ywjV1awI0xQmL6UspABb7TRzlwiMMZxNh+Ixexv7qNE=;
	b=uQ3t3hfEVJfu8dotfvTW9IfnzVbYviNpNmS3qT8SkfXwtRPkXb0TxkqONT81rU2xcXQJ2n
	ieqniQpy413K35nlNRv/RH3UOE9WWlM0q/+4UFN7r//FWRHU11iQFXmVP26vYEAspCAoIo
	kHI+w5mycA9AfhG5meu3fEq6s4hdowVRAwlJXXYRq8MX/yQcZzAk+fwmw8OQc8KshUVA/z
	E/2nHcyAimlEOZ3jcFqPDs+Sa5FK5/+it6MWXUdZPTaHaz9TfgrgQ+4S+dJn0gF/sqBxLR
	Wgt6HT3XtkjA/ovrNNIDCJF0zNo9NR1SS/hdnv7di6HFnl1uFru++b7EQKyoBA==
Message-ID: <c3bd9f9134182accf7f6ab77cd07a5f15fab0fd3.camel@mailbox.org>
Subject: Re: [PATCH net-next 1/4] net: usb: move updating filter and status
 from cdc to usbnet
From: Manuel Ebner <manuelebner@mailbox.org>
To: Oliver Neukum <oneukum@suse.com>, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, 	shaoxul@foxmail.com, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Thu, 02 Jul 2026 19:59:26 +0200
In-Reply-To: <20260702143142.890654-2-oneukum@suse.com>
References: <20260702143142.890654-1-oneukum@suse.com>
	 <20260702143142.890654-2-oneukum@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 833862cdbbafb120f73
X-MBO-RS-META: 9qygaxxsps7n9o5hns71g9ndcpb4rg89
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304247-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[suse.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,foxmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[manuelebner@mailbox.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:oneukum@suse.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shaoxul@foxmail.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manuelebner@mailbox.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,mailbox.org:from_mime,suse.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF7B26FC1D5

Hi,
I have a couple suggestions for you patch. Some parts are
weird to read - it could also be that my perception today is off.

On Thu, 2026-07-02 at 16:25 +0200, Oliver Neukum wrote:
> These helpers are used by multiple drivers and do not depend

"and do not only depend on cdc core. They also depend on
other cdc drivers."
is this better?=20

> on the rest of cdc. Leavin them in a cdc driver means that

/Leavin/Leaving/

> more drivers are loaded just for infrastructure, not hardware

just for the support of other drivers, not their hardware.

> support.
>=20
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
> =C2=A0drivers/net/usb/cdc_ether.c | 75 ----------------------------------=
--
> =C2=A0drivers/net/usb/usbnet.c=C2=A0=C2=A0=C2=A0 | 76 +++++++++++++++++++=
++++++++++++++++++
> =C2=A02 files changed, 76 insertions(+), 75 deletions(-)
>=20
> diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
> index a0a5740590b9..b4df32e18461 100644
> --- a/drivers/net/usb/cdc_ether.c
> +++ b/drivers/net/usb/cdc_ether.c
> @@ -63,35 +63,6 @@ static const u8 mbm_guid[16] =3D {
> =C2=A0	0xa6, 0x07, 0xc0, 0xff, 0xcb, 0x7e, 0x39, 0x2a,
> =C2=A0};
> =C2=A0
> -void usbnet_cdc_update_filter(struct usbnet *dev)
> -{
> -	struct net_device	*net =3D dev->net;
> -
> -	u16 cdc_filter =3D USB_CDC_PACKET_TYPE_DIRECTED
> -			| USB_CDC_PACKET_TYPE_BROADCAST;
> -
> -	/* filtering on the device is an optional feature and not worth
> -	 * the hassle so we just roughly care about snooping and if any
> -	 * multicast is requested, we take every multicast
> -	 */
> -	if (net->flags & IFF_PROMISC)
> -		cdc_filter |=3D USB_CDC_PACKET_TYPE_PROMISCUOUS;
> -	if (!netdev_mc_empty(net) || (net->flags & IFF_ALLMULTI))
> -		cdc_filter |=3D USB_CDC_PACKET_TYPE_ALL_MULTICAST;
> -
> -	usb_control_msg(dev->udev,
> -			usb_sndctrlpipe(dev->udev, 0),
> -			USB_CDC_SET_ETHERNET_PACKET_FILTER,
> -			USB_TYPE_CLASS | USB_RECIP_INTERFACE,
> -			cdc_filter,
> -			dev->intf->cur_altsetting->desc.bInterfaceNumber,
> -			NULL,
> -			0,
> -			USB_CTRL_SET_TIMEOUT
> -		);
> -}
> -EXPORT_SYMBOL_GPL(usbnet_cdc_update_filter);
> -
> =C2=A0/* We need to override usbnet_*_link_ksettings in bind() */
> =C2=A0static const struct ethtool_ops cdc_ether_ethtool_ops =3D {
> =C2=A0	.get_link		=3D usbnet_get_link,
> @@ -400,52 +371,6 @@ EXPORT_SYMBOL_GPL(usbnet_cdc_unbind);
> =C2=A0 * (by Brad Hards) talked with, with more functionality.
> =C2=A0 */
> =C2=A0
> -static void speed_change(struct usbnet *dev, __le32 *speeds)
> -{
> -	dev->tx_speed =3D __le32_to_cpu(speeds[0]);
> -	dev->rx_speed =3D __le32_to_cpu(speeds[1]);
> -}
> -
> -void usbnet_cdc_status(struct usbnet *dev, struct urb *urb)
> -{
> -	struct usb_cdc_notification	*event;
> -
> -	if (urb->actual_length < sizeof(*event))
> -		return;
> -
> -	/* SPEED_CHANGE can get split into two 8-byte packets */
> -	if (test_and_clear_bit(EVENT_STS_SPLIT, &dev->flags)) {
> -		speed_change(dev, (__le32 *) urb->transfer_buffer);
> -		return;
> -	}
> -
> -	event =3D urb->transfer_buffer;
> -	switch (event->bNotificationType) {
> -	case USB_CDC_NOTIFY_NETWORK_CONNECTION:
> -		netif_dbg(dev, timer, dev->net, "CDC: carrier %s\n",
> -			=C2=A0 event->wValue ? "on" : "off");
> -		if (netif_carrier_ok(dev->net) !=3D !!event->wValue)
> -			usbnet_link_change(dev, !!event->wValue, 0);
> -		break;
> -	case USB_CDC_NOTIFY_SPEED_CHANGE:	/* tx/rx rates */
> -		netif_dbg(dev, timer, dev->net, "CDC: speed change (len %d)\n",
> -			=C2=A0 urb->actual_length);
> -		if (urb->actual_length !=3D (sizeof(*event) + 8))
> -			set_bit(EVENT_STS_SPLIT, &dev->flags);
> -		else
> -			speed_change(dev, (__le32 *) &event[1]);
> -		break;
> -	/* USB_CDC_NOTIFY_RESPONSE_AVAILABLE can happen too (e.g. RNDIS),
> -	 * but there are no standard formats for the response data.
> -	 */
> -	default:
> -		netdev_err(dev->net, "CDC: unexpected notification %02x!\n",
> -			=C2=A0=C2=A0 event->bNotificationType);
> -		break;
> -	}
> -}
> -EXPORT_SYMBOL_GPL(usbnet_cdc_status);
> -
> =C2=A0int usbnet_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
> =C2=A0{
> =C2=A0	int				status;
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index 25518635b7b7..5544af1f4aa5 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -22,6 +22,7 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/netdevice.h>
> =C2=A0#include <linux/etherdevice.h>
> +#include <linux/usb/cdc.h>

why do you put it there?
it could be alphabetical instead.

> =C2=A0#include <linux/ctype.h>
> =C2=A0#include <linux/ethtool.h>
> =C2=A0#include <linux/workqueue.h>
> @@ -2271,6 +2272,81 @@ int usbnet_write_cmd_async(struct usbnet *dev, u8 =
cmd, u8
> reqtype,
> =C2=A0
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(usbnet_write_cmd_async);
> +
> +void usbnet_cdc_update_filter(struct usbnet *dev)
> +{
> +	struct net_device	*net =3D dev->net;
> +
> +	u16 cdc_filter =3D USB_CDC_PACKET_TYPE_DIRECTED
> +			| USB_CDC_PACKET_TYPE_BROADCAST;
> +
Multi-line-comments in coding-style:
	/*
	 * filtering on ..
> +	/* filtering on the device is an optional feature and not worth
> +	 * the hassle so we just roughly care about snooping and if any
> +	 * multicast is requested, we take every multicast
				 , we take that multicast.
also that's a pretty long sentence.



> +	 */
> +	if (net->flags & IFF_PROMISC)
> +		cdc_filter |=3D USB_CDC_PACKET_TYPE_PROMISCUOUS;
> +	if (!netdev_mc_empty(net) || (net->flags & IFF_ALLMULTI))
> +		cdc_filter |=3D USB_CDC_PACKET_TYPE_ALL_MULTICAST;
> +
> +	usb_control_msg(dev->udev,
> +			usb_sndctrlpipe(dev->udev, 0),
> +			USB_CDC_SET_ETHERNET_PACKET_FILTER,
> +			USB_TYPE_CLASS | USB_RECIP_INTERFACE,
> +			cdc_filter,
> +			dev->intf->cur_altsetting->desc.bInterfaceNumber,
> +			NULL,
> +			0,
> +			USB_CTRL_SET_TIMEOUT
> +		);
> +}
> +EXPORT_SYMBOL_GPL(usbnet_cdc_update_filter);
> +
> +static void speed_change(struct usbnet *dev, __le32 *speeds)
> +{
> +	dev->tx_speed =3D __le32_to_cpu(speeds[0]);
> +	dev->rx_speed =3D __le32_to_cpu(speeds[1]);
> +}
> +
> +void usbnet_cdc_status(struct usbnet *dev, struct urb *urb)
> +{
> +	struct usb_cdc_notification	*event;
> +
> +	if (urb->actual_length < sizeof(*event))
> +		return;
> +
> +	/* SPEED_CHANGE can get split into two 8-byte packets */
> +	if (test_and_clear_bit(EVENT_STS_SPLIT, &dev->flags)) {
> +		speed_change(dev, (__le32 *)urb->transfer_buffer);
> +		return;
> +	}
> +
> +	event =3D urb->transfer_buffer;
> +	switch (event->bNotificationType) {
> +	case USB_CDC_NOTIFY_NETWORK_CONNECTION:
> +		netif_dbg(dev, timer, dev->net, "CDC: carrier %s\n",
> +			=C2=A0 event->wValue ? "on" : "off");
> +		if (netif_carrier_ok(dev->net) !=3D !!event->wValue)
> +			usbnet_link_change(dev, !!event->wValue, 0);
> +		break;
> +	case USB_CDC_NOTIFY_SPEED_CHANGE:	/* tx/rx rates */
> +		netif_dbg(dev, timer, dev->net, "CDC: speed change (len %d)\n",
> +			=C2=A0 urb->actual_length);
> +		if (urb->actual_length !=3D (sizeof(*event) + 8))
> +			set_bit(EVENT_STS_SPLIT, &dev->flags);
> +		else
> +			speed_change(dev, (__le32 *)&event[1]);
> +		break;

	/*
	 * USB ..
> +	/* USB_CDC_NOTIFY_RESPONSE_AVAILABLE can happen too (e.g. RNDIS),
> +	 * but there are no standard formats for the response data.
> +	 */
> +	default:
> +		netdev_err(dev->net, "CDC: unexpected notification %02x!\n",
> +			=C2=A0=C2=A0 event->bNotificationType);
> +		break;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(usbnet_cdc_status);
> =C2=A0/*-----------------------------------------------------------------=
--------*/
> =C2=A0
> =C2=A0static int __init usbnet_init(void)

You can add my=20
Reviewed-by: Manuel Ebner <manuelebner@mailbox.org>

Thanks
 Manuel

