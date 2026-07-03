Return-Path: <netdev+bounces-304518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LqbxAHWfR2rWcQAAu9opvQ
	(envelope-from <netdev+bounces-304518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 13:39:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 717C9701EDA
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 13:39:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Gq6IDiry;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304518-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304518-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B33E301F30A
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 11:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A29D3B8124;
	Fri,  3 Jul 2026 11:34:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15803BBFD1;
	Fri,  3 Jul 2026 11:34:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078480; cv=none; b=KrOPHbgol6sFf/s2NQsig5CVSnAbVPOr5lHfkT5G6RrgoQ5uH6j4UiTk5alneaddUpqP+k0gnHnQGPYDMtSIZXwCIwFktlCrEXtUPhNl4uJ7ZGWjSg/0JngCPaN6akJMlA2A3kYAcr3YEBFamK0RPyRDDTkZRbW02llQJekLj8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078480; c=relaxed/simple;
	bh=otYgFBFOKX0kdXbURgEgZM3uAsMo5mfNoYSJETUWzXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGEUH887rLddSd9F4azDLINKI9/OCUlyqL3edm7p+nWWmQ5Gj9Q6XPpjmi8s684GonTHOv8OtNMpQjF766QKEvkwc3QjYFUrx320Xl1w10kN70VcauZGQISV8MrgS+Gq6lZS89JAlLA9VzSLbR1WHcaWu0bDtKrBD/R/bPGbluU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gq6IDiry; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27EB1F000E9;
	Fri,  3 Jul 2026 11:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783078479;
	bh=faWG9jfMWKdMdxrgHPCnB5rYQL48zXpls0XEI2SI5Z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gq6IDiryD51RKQLyrEoWIEj4QIJC9P3w82PxegkwPsNX0vy8eiBIiyC/QvjwFcuE0
	 ZNS3q8EHGDNf5GGYV3sI1t6nZNdxspq2N0EaBUyw0bPfXWO5Wl7VC2VRwHiZhNF6Yu
	 cob7q73nl2feXb5Ovd1p/f1J/8xvN70zRHioE9No6DlbU0ApewTSEgMz33W3qHMxfd
	 B7vcZOlNK+57hTdDsJXJOUWuwfWns1rTa2yWv02d/SFNkRgNYA75DSK36bpETiABr5
	 iJs1X6oSjDq9M2rsxvaTPFb/BXZ/+s0EhjE9rjAf104K2QWshR3/UoXVsDIaIEYVXN
	 HW1s9OuiUubUw==
Date: Fri, 3 Jul 2026 12:34:33 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Paolo Valerio <pvalerio@redhat.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v3 04/15] net: macb: unify queue index variable
 naming convention and types
Message-ID: <20260703-monogram-unable-2eaeaf79676f@spud>
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
 <20260701-macb-context-v3-4-00268d5b1502@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7JtWFm+95co3mRD1"
Content-Disposition: inline
In-Reply-To: <20260701-macb-context-v3-4-00268d5b1502@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:theo.lebrun@bootlin.com,m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:pvalerio@redhat.com,m:nb@tipi-net.de,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304518-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,tuxon.dev,tipi-net.de,mobileye.com,bootlin.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,spud:mid,bootlin.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 717C9701EDA

--7JtWFm+95co3mRD1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2026 at 05:59:07PM +0200, Th=E9o Lebrun wrote:
> Variables are named q or queue_index. Types are int, unsigned int, u32
> and u16. Use `unsigned int q` everywhere.
>=20
> Skip over taprio functions. They use `u8 queue_id` which fits with the
> `struct macb_queue_enst_config` field. Using `queue_id` everywhere
> would be too verbose.

I'm not sure that I agree about the verbosity, and "q" isn't a letter I
would naturally associate with indexing, in the way ijk etc are. Perhaps
in netdev it is a natural choice however?

Conor.

>=20
> Signed-off-by: Th=E9o Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 32 ++++++++++++++++----------=
------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index 86c0e9ccbfce..3b75797381b6 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -877,7 +877,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue=
 *queue)
>  static void gem_shuffle_tx_rings(struct macb *bp)
>  {
>  	struct macb_queue *queue;
> -	int q;
> +	unsigned int q;
> =20
>  	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; q++, queue++)
>  		gem_shuffle_tx_one_ring(queue);
> @@ -1258,7 +1258,7 @@ static void macb_tx_error_task(struct work_struct *=
work)
>  						      tx_error_task);
>  	bool			halt_timeout =3D false;
>  	struct macb		*bp =3D queue->bp;
> -	u32			queue_index;
> +	unsigned int		q;
>  	u32			packets =3D 0;
>  	u32			bytes =3D 0;
>  	struct macb_tx_skb	*tx_skb;
> @@ -1267,9 +1267,9 @@ static void macb_tx_error_task(struct work_struct *=
work)
>  	unsigned int		tail;
>  	unsigned long		flags;
> =20
> -	queue_index =3D queue - bp->queues;
> +	q =3D queue - bp->queues;
>  	netdev_vdbg(bp->netdev, "macb_tx_error_task: q =3D %u, t =3D %u, h =3D =
%u\n",
> -		    queue_index, queue->tx_tail, queue->tx_head);
> +		    q, queue->tx_tail, queue->tx_head);
> =20
>  	/* Prevent the queue NAPI TX poll from running, as it calls
>  	 * macb_tx_complete(), which in turn may call netif_wake_subqueue().
> @@ -1342,7 +1342,7 @@ static void macb_tx_error_task(struct work_struct *=
work)
>  		macb_tx_unmap(bp, tx_skb, 0);
>  	}
> =20
> -	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, queue_index),
> +	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, q),
>  				  packets, bytes);
> =20
>  	/* Set end of TX queue */
> @@ -1407,7 +1407,7 @@ static bool ptp_one_step_sync(struct sk_buff *skb)
>  static int macb_tx_complete(struct macb_queue *queue, int budget)
>  {
>  	struct macb *bp =3D queue->bp;
> -	u16 queue_index =3D queue - bp->queues;
> +	unsigned int q =3D queue - bp->queues;
>  	unsigned long flags;
>  	unsigned int tail;
>  	unsigned int head;
> @@ -1469,14 +1469,14 @@ static int macb_tx_complete(struct macb_queue *qu=
eue, int budget)
>  		}
>  	}
> =20
> -	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, queue_index),
> +	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, q),
>  				  packets, bytes);
> =20
>  	queue->tx_tail =3D tail;
> -	if (__netif_subqueue_stopped(bp->netdev, queue_index) &&
> +	if (__netif_subqueue_stopped(bp->netdev, q) &&
>  	    CIRC_CNT(queue->tx_head, queue->tx_tail,
>  		     bp->tx_ring_size) <=3D MACB_TX_WAKEUP_THRESH(bp))
> -		netif_wake_subqueue(bp->netdev, queue_index);
> +		netif_wake_subqueue(bp->netdev, q);
>  	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
> =20
>  	if (packets)
> @@ -2470,10 +2470,10 @@ static int macb_pad_and_fcs(struct sk_buff **skb,=
 struct net_device *netdev)
>  static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
>  				   struct net_device *netdev)
>  {
> -	u16 queue_index =3D skb_get_queue_mapping(skb);
>  	struct macb *bp =3D netdev_priv(netdev);
> -	struct macb_queue *queue =3D &bp->queues[queue_index];
> +	unsigned int q =3D skb_get_queue_mapping(skb);
>  	unsigned int desc_cnt, nr_frags, frag_size, f;
> +	struct macb_queue *queue =3D &bp->queues[q];
>  	unsigned int hdrlen;
>  	unsigned long flags;
>  	bool is_lso;
> @@ -2512,8 +2512,8 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *=
skb,
> =20
>  #if defined(DEBUG) && defined(VERBOSE_DEBUG)
>  	netdev_vdbg(bp->netdev,
> -		    "start_xmit: queue %hu len %u head %p data %p tail %p end %p\n",
> -		    queue_index, skb->len, skb->head, skb->data,
> +		    "start_xmit: queue %u len %u head %p data %p tail %p end %p\n",
> +		    q, skb->len, skb->head, skb->data,
>  		    skb_tail_pointer(skb), skb_end_pointer(skb));
>  	print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_OFFSET, 16, 1,
>  		       skb->data, 16, true);
> @@ -2539,7 +2539,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *=
skb,
>  	/* This is a hard error, log it. */
>  	if (CIRC_SPACE(queue->tx_head, queue->tx_tail,
>  		       bp->tx_ring_size) < desc_cnt) {
> -		netif_stop_subqueue(netdev, queue_index);
> +		netif_stop_subqueue(netdev, q);
>  		netdev_dbg(netdev, "tx_head =3D %u, tx_tail =3D %u\n",
>  			   queue->tx_head, queue->tx_tail);
>  		ret =3D NETDEV_TX_BUSY;
> @@ -2555,7 +2555,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *=
skb,
>  	/* Make newly initialized descriptor visible to hardware */
>  	wmb();
>  	skb_tx_timestamp(skb);
> -	netdev_tx_sent_queue(netdev_get_tx_queue(bp->netdev, queue_index),
> +	netdev_tx_sent_queue(netdev_get_tx_queue(bp->netdev, q),
>  			     skb->len);
> =20
>  	spin_lock(&bp->lock);
> @@ -2564,7 +2564,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *=
skb,
>  	spin_unlock(&bp->lock);
> =20
>  	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1)
> -		netif_stop_subqueue(netdev, queue_index);
> +		netif_stop_subqueue(netdev, q);
> =20
>  unlock:
>  	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
>=20
> --=20
> 2.55.0
>=20

--7JtWFm+95co3mRD1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakeeSQAKCRB4tDGHoIJi
0szKAQCwi/s4jfcr8c56b2uyMBWdEkRa6jhdcr/cTJOgsb8LggD/fHEnaAOUJ+gL
Ej0m6hzvvnRRncJn17XugZmu3dlsaA8=
=H9yw
-----END PGP SIGNATURE-----

--7JtWFm+95co3mRD1--

