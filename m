Return-Path: <netdev+bounces-280652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JOvFJrP6Wm9kgIAu9opvQ
	(envelope-from <netdev+bounces-280652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:51:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CEA44E2F0
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B933D3013271
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9ED30F95F;
	Thu, 23 Apr 2026 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiS3vX7F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2805223AB9D
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 07:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776930695; cv=none; b=nFo4odO+X0bvMkSop0IkgDi3Z6fDlsY+RHgOqcrJSBBiXk0l3B77AOOutUvXfDKLp2FCjFioW5vjRQ/rB20+y0RyKuBP++iJuQsaud1Kn1uUeTsBbESPeVg8I+DJwgMgtZsJ7xhpy+2w5vGPW08w+xX3mj001AS5BAHVyHm7mnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776930695; c=relaxed/simple;
	bh=rdiTke8XyX0S2GN9uBMDJp0R3HUEvjW7NtSpQ2rhGKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZB1bUXTMLwmp8E52xvOOUFDDdFDTxLsKIbBtpQtjnQtl8MLE3fKHFb2qruQbEFsJWRYhcZwTdTQuhMhdu3MjoN1wY50onO8px9X3k9MVfCdbTNKl1pSIO2vI/xlYY/DLriXSDs1Dw4c31haY6tpbcBgCJdxVydrnE7Rqm0obbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiS3vX7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78698C2BCB2;
	Thu, 23 Apr 2026 07:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776930694;
	bh=rdiTke8XyX0S2GN9uBMDJp0R3HUEvjW7NtSpQ2rhGKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NiS3vX7FA0vFcZHdxMZ/EqcQFsnGykfFjh6Z+n41wUOhfrGEmXu1A8GOMpmxEcYS0
	 A+UD0jMdRL4gNUSrevsxzuPsQ0fKhQjzP/WBF5QGMBqpxRe2IZVcKDXLeF8hEKrazt
	 3VvCPzHUpF2F5M5KaGIVteQ8Z8R0QiL/V148XkTj5r+Olgy+jOWG4PnkClC47ecRIB
	 Ric0d45vDj/x7Ek6/Y3MNrNWggMgH7WM7dx3b20trZ7W9Zqn1qhc4Eo5UwZZCZyGQP
	 7d/tha8OVklBWmRoaA+TtwLM4frNnYNH1DwbFuZRv0C14KUOrTunxZOjMMCsI3SgXd
	 AVv9E8+NpsZ/A==
Date: Thu, 23 Apr 2026 09:51:32 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Do not wake all netdev TX queues in
 airoha_qdma_wake_netdev_txqs()
Message-ID: <aenPhDotJMJ1pxG-@lore-desk>
References: <20260421-airoha-wake_netdev_txqs-optmization-v1-1-e0be95115d53@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XIMRgkZKP4wfW4rh"
Content-Disposition: inline
In-Reply-To: <20260421-airoha-wake_netdev_txqs-optmization-v1-1-e0be95115d53@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280652-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1CEA44E2F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--XIMRgkZKP4wfW4rh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Do not wake every netdev TX queue across all ports sharing the QDMA
> running netif_tx_wake_all_queues routine in airoha_qdma_wake_netdev_txqs()
> but only the ones that are mapped the specific QDMA stopped hw TX queue.
> This patch can potentially avoid waking already stopped netdev TX queues
> that are mapped to a different QDMA hw TX queue.
> Introduce airoha_qdma_get_txq utility routine.
>=20
> Fixes: b94769eb2f30 ("net: airoha: Fix possible TX queue stall in airoha_=
qdma_tx_napi_poll()")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 19 +++++++++++++++----
>  drivers/net/ethernet/airoha/airoha_eth.h |  5 +++++
>  2 files changed, 20 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 19f67c7dd8e1..2ca569501045 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -847,13 +847,24 @@ static void airoha_qdma_wake_netdev_txqs(struct air=
oha_queue *q)
>  {
>  	struct airoha_qdma *qdma =3D q->qdma;
>  	struct airoha_eth *eth =3D qdma->eth;
> -	int i;
> +	int i, qid =3D q - &qdma->q_tx[0];
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
>  		struct airoha_gdm_port *port =3D eth->ports[i];
> +		int j;
> +
> +		if (!port)
> +			continue;
> =20
> -		if (port && port->qdma =3D=3D qdma)
> -			netif_tx_wake_all_queues(port->dev);
> +		if (port->qdma !=3D qdma)
> +			continue;
> +
> +		for (j =3D 0; j < port->dev->num_tx_queues; j++) {
> +			if (airoha_qdma_get_txq(qdma, j) !=3D qid)
> +				continue;
> +
> +			netif_wake_subqueue(port->dev, j);
> +		}
>  	}
>  	q->txq_stopped =3D false;
>  }
> @@ -1965,7 +1976,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *=
skb,
>  	u16 index;
>  	u8 fport;
> =20
> -	qid =3D skb_get_queue_mapping(skb) % ARRAY_SIZE(qdma->q_tx);
> +	qid =3D airoha_qdma_get_txq(qdma, skb_get_queue_mapping(skb));
>  	tag =3D airoha_get_dsa_tag(skb, dev);
> =20
>  	msg0 =3D FIELD_PREP(QDMA_ETH_TXMSG_CHAN_MASK,
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index 87b328cfefb0..c3ea7aadbd82 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -631,6 +631,11 @@ u32 airoha_rmw(void __iomem *base, u32 offset, u32 m=
ask, u32 val);
>  #define airoha_qdma_clear(qdma, offset, val)			\
>  	airoha_rmw((qdma)->regs, (offset), (val), 0)
> =20
> +static inline u16 airoha_qdma_get_txq(struct airoha_qdma *qdma, u16 qid)
> +{
> +	return qid % ARRAY_SIZE(qdma->q_tx);
> +}
> +
>  static inline bool airoha_is_lan_gdm_port(struct airoha_gdm_port *port)
>  {
>  	/* GDM1 port on EN7581 SoC is connected to the lan dsa switch.
>=20
> ---
> base-commit: a663bac71a2f0b3ac6c373168ca57b2a6e6381aa
> change-id: 20260421-airoha-wake_netdev_txqs-optmization-65171ce4ebad
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

commenting on Sashiko retported issues:
https://sashiko.dev/#/patchset/20260421-airoha-wake_netdev_txqs-optmization=
-v1-1-e0be95115d53%40kernel.org

- Can this cause an infinite NETDEV_TX_BUSY livelock when a QDMA hardware q=
ueue is full?
  The issue is already fixed in the following patch:
  https://patchwork.kernel.org/project/netdevbpf/patch/20260421-airoha-fix-=
bql-v1-1-f135afe4275b@kernel.org/

Regards,
Lorenzo

--XIMRgkZKP4wfW4rh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaenPhAAKCRA6cBh0uS2t
rHJIAP0RzHPxXsooTEbHddLt9AmAIV7hyhy8/FTGlixGmdPCaAD8CiQD9SYwaFzL
ze4QoY9encRv73xcr4oY4lM9zMag5gc=
=Z0sJ
-----END PGP SIGNATURE-----

--XIMRgkZKP4wfW4rh--

