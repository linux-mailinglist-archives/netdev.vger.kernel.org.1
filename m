Return-Path: <netdev+bounces-258123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK4uFmBfi2msUAAAu9opvQ
	(envelope-from <netdev+bounces-258123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 17:40:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFD211D5BD
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 17:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C25D3001329
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 16:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA6430CD80;
	Tue, 10 Feb 2026 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="j+o6onEO"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686AE209F43
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770741595; cv=none; b=nWXc+fo+LfT9m49QroP6ItZvp8qkP1jI+Y7ItCy4gelqXqO5eMA7FR72p6KdaomVfYJLUbLIxdBRffyrqYCnfhjq8LoXz0FHMtgQALolGEVa/LjeSsFYFgeaQbZaObtpvkHpv0426QdSe7lx5TQn4HLFBxvPObJDgFOX7RCCGxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770741595; c=relaxed/simple;
	bh=GDePuShHAghlSQB6vfLGP85WO2lRyKMweKzmbcTR+uw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s26pfN/eMddQZj0IcmYYcWlNy/sCpoOyW2O4DGENgfJSfY3wygT5QInw5pKMYh7Uunmy8KYNwphd7fFC7CUNoclCq2K3chqSy6+/OZx7vmxIl/Okz+4kmf577R0Uz01ZIiXmLZSR3FOjAuHDFGFNHP5wcrW870WKeoR/4WjcySw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=j+o6onEO; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=j+o6onEO;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 61AGRPKv076434
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 16:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1770740845; bh=4q0qcv4kgrYSGhfN+pNAAhr7ag9zqoz3w6zp+eJR3r0=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=j+o6onEOCal52W5nlCXV4O2rC5kGlYnQsggNwLj5SxgnWtPa44WvNq9PMCXqYztDx
	 vHX0VYiDF1AU4ztUT33SxmIQ6Hvk3F/MqrD/DMn5Jdg9zdm2X5SSRUtoQwqL55RWGW
	 nJcFjLu1ic9a2uaHeYcPmbUekximUrGnSaYSBtxc=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 61AGRODi238953
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 17:27:25 +0100
Received: (nullmailer pid 114151 invoked by uid 1000);
	Tue, 10 Feb 2026 16:27:24 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Oliver Neukum <oneukum@suse.com>
Cc: netdev@vger.kernel.org, hayeswang@realtek.com, o.rempel@pengutronix.de
Subject: Re: [RFC net-next 1/3] net: usb: divorce private data and cdc state
 in usbnet
In-Reply-To: <20260210151416.42254-2-oneukum@suse.com> (Oliver Neukum's
	message of "Tue, 10 Feb 2026 16:11:12 +0100")
Organization: m
References: <20260210151416.42254-1-oneukum@suse.com>
	<20260210151416.42254-2-oneukum@suse.com>
Date: Tue, 10 Feb 2026 17:27:24 +0100
Message-ID: <87ikc4mumr.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at canardo.mork.no
X-Virus-Status: Clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mork.no,reject];
	R_DKIM_ALLOW(-0.20)[mork.no:s=b];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258123-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mork.no:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@mork.no,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBFD211D5BD
X-Rspamd-Action: no action

Oliver Neukum <oneukum@suse.com> writes:

> --- a/include/linux/usb/usbnet.h
> +++ b/include/linux/usb/usbnet.h
> @@ -16,6 +16,18 @@
>  #include <linux/usb.h>
>  #include <linux/spinlock.h>
>=20=20
> +/* Drivers that reuse some of the standard USB CDC infrastructure
> + * (notably, using multiple interfaces according to the CDC
> + * union descriptor) get some helper code.
> + */
> +struct cdc_state {
> +        struct usb_cdc_header_desc      *header;
> +        struct usb_cdc_union_desc       *u;
> +        struct usb_cdc_ether_desc       *ether;
> +        struct usb_interface            *control;
> +        struct usb_interface            *data;
> +};
> +
>  /* interface from usbnet core to each USB networking link we handle */
>  struct usbnet {
>  	/* housekeeping */
> @@ -41,7 +53,7 @@ struct usbnet {
>  	/* protocol/interface state */
>  	struct net_device	*net;
>  	int			msg_enable;
> -	unsigned long		data[5];
> +	struct cdc_state	cdc;		/* too common to leave out*/
>  	u32			xid;
>  	u32			hard_mtu;	/* count any extra framing */
>  	size_t			rx_urb_size;	/* size for rx urbs */
> @@ -84,6 +96,7 @@ struct usbnet {
>   * that must be broken
>   */
>  #		define EVENT_UNPLUG		31
> +	unsigned long		private[5];
>  };
>=20=20
>  static inline bool usbnet_going_away(struct usbnet *ubn)

I like the idea.  Nice to get rid of those extra allocations for drivers
needing more than 5 pointers.

But I don't understand why you make struct cdc_state special.  That's
just confusing.

I know I intentionally made the "control" and "data" fields of
"struct qmi_wwan_state" position and name compatible with
"struct cdc_state". Maybe not very important.  But adds to the
confusion if we end up with a double set of those fields.

Or should the qmi_wwan driver split out the=20
        struct usb_interface            *control;
        struct usb_interface            *data;

part of its private data and put those into "cdc", allowing us to reduce
"struct qmi_wwan_state" from 5 to 3 longs?  I don't think that's a very
good idea...

Let's keep this a single private minidriver allocation.  Making it
flexible is nice.


Bj=C3=B8rn


