Return-Path: <netdev+bounces-280648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFfAKH3O6Wm9kgIAu9opvQ
	(envelope-from <netdev+bounces-280648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:47:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3878A44E208
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D769030BBE0D
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D2A3264C8;
	Thu, 23 Apr 2026 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CY+i9rXP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE0C320A14
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776930151; cv=none; b=pqfUUsaR0M6Ff9rCh905EUlYxilbZrdp76ZmD0EzBXYUh4t6dQAiq9dpMD1mKhw9ejeZyfEoYjDhpj6///+VwUTScLIoVLeqjjAEdkKZcTg8EjX0z63V2D4SiQudDu/5wENC5qAEujIj31OMyUI/5EBnYLZdj5Lamxk+kStMDvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776930151; c=relaxed/simple;
	bh=XRdpb9nVRkqJctOt0Dfi0nllkU3AoSVeiFDjds5RJCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kb8eNajv60/n2JEgSl/LpJ9K9lGrA/QUPw9t4B9JWslXbw/AhzuYfYVngbsUcbKZ9TZXl+ON6z/yUaQDqg0oYjOzxCqhnu29XVnjkUgBGkgAbtJhmKqPk7lc3R5VdwBXK6Aeb0cO9t9eBlb2Qk0lVXIcpwDGlV0peVsDLJaGRVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CY+i9rXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7C2C2BCAF;
	Thu, 23 Apr 2026 07:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776930151;
	bh=XRdpb9nVRkqJctOt0Dfi0nllkU3AoSVeiFDjds5RJCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CY+i9rXP7j/oBVjARa/Hga/mWJYfWrYij6Ejp9K8Fmx0Fw52s4dCXIhvCr4xf4AjC
	 FTw+atqA7j65Cn7ygGjeEL27vpc0HE1LEpl9kwxrUt6m/TmN6E055rWYx2vlycLXgH
	 jdwz/9GyxoyZWXWYQ0Ink7GFquEUAiigkToZ/84M7crxVGd4r7DcWI93Rs5xWvZknE
	 HaO/yxJ0/LpHzxR3I3UNkOJd8s1jMt3Vh2WJhCoUmVW1ti3bHRrN7cjsL+L87uABsU
	 APkFOfhiQsdu7qcAHL4wPA+BiMgpXi4oWVzwVSAVhYMj11JKDf4bvq5Mg4z2OQkA38
	 UiLHj27jE0X5w==
Date: Thu, 23 Apr 2026 09:42:28 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: stop net_device TX queue before
 updating CPU index
Message-ID: <aenNZELmY3Z7VP7j@lore-desk>
References: <20260421-airoha-xmit-stop-condition-v1-1-e670d6a48467@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n+fdmW4T+/Z6vLY1"
Content-Disposition: inline
In-Reply-To: <20260421-airoha-xmit-stop-condition-v1-1-e670d6a48467@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280648-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3878A44E208
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--n+fdmW4T+/Z6vLY1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Currently, airoha_eth driver updates the CPU index register prior of
> verifying whether the number of free descriptors has fallen below the
> threshold.
> Move net_device TX queue length check before updating the TX CPU index
> in order to update TX CPU index even if there are more packets to be
> transmitted but the net_device TX queue is going to be stopped
> accounting the inflight packets.
>=20
> Fixes: 1d304174106c ("net: airoha: Implement BQL support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 19f67c7dd8e1..5d327237e274 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2058,17 +2058,16 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff=
 *skb,
> =20
>  	skb_tx_timestamp(skb);
>  	netdev_tx_sent_queue(txq, skb->len);
> +	if (q->ndesc - q->queued < q->free_thr) {
> +		netif_tx_stop_queue(txq);
> +		q->txq_stopped =3D true;
> +	}
> =20
>  	if (netif_xmit_stopped(txq) || !netdev_xmit_more())
>  		airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid),
>  				TX_RING_CPU_IDX_MASK,
>  				FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
> =20
> -	if (q->ndesc - q->queued < q->free_thr) {
> -		netif_tx_stop_queue(txq);
> -		q->txq_stopped =3D true;
> -	}
> -
>  	spin_unlock_bh(&q->lock);
> =20
>  	return NETDEV_TX_OK;
>=20
> ---
> base-commit: a663bac71a2f0b3ac6c373168ca57b2a6e6381aa
> change-id: 20260421-airoha-xmit-stop-condition-344dc0292a19
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

commenting on Sashiko retported issues:
https://sashiko.dev/#/patchset/20260421-airoha-xmit-stop-condition-v1-1-e67=
0d6a48467%40kernel.org

- Could this cause a deadlock if exactly q->free_thr descriptors are free?
  This does not seem a problem to me since, even if the netdev tx queue is
  stopped as described in the report, the airoha_qdma_tx_napi_poll() will f=
ree
  space in the queue and subsequent packets will update REG_TX_CPU_IDX regi=
ster.

- Is it possible for this loop to read past the end of the frags array?
  As pointed out by Sashiko, this issue is not introduced by this patch and=
 I
  will fix with a dedicated patch.

- Might this lead to memory corruption if the tcp header is not in the line=
ar area?
  This issue is not introduced by this patch and I will fix with a dedicate=
d patch.

- If an error occurs during transmission, the driver jumps to the error lab=
el
  frees the skb, and returns NETDEV_TX_OK without ringing the qdma cpu inde=
x doorbell?
  Similar to the first issue, this does not seem a problem to me since subs=
equent
  packets will update REG_TX_CPU_IDX register.

Regards,
Lorenzo

--n+fdmW4T+/Z6vLY1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaenNZAAKCRA6cBh0uS2t
rC1vAP9MtTmL8U3BdrfMedc+Vlc+MTA91gnMBQG8HOGouOvAdgEA1r1ltUGjtato
t0YBtofFZLtW7ijWbfS45I4FIwGzKAo=
=N6KP
-----END PGP SIGNATURE-----

--n+fdmW4T+/Z6vLY1--

