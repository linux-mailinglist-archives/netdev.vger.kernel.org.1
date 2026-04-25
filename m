Return-Path: <netdev+bounces-281118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHFcGpzL7Gn8cgAAu9opvQ
	(envelope-from <netdev+bounces-281118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 16:11:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A34CD4668DD
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 16:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82BD5300E3BC
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 14:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C23035BDD5;
	Sat, 25 Apr 2026 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avcVIe9u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190B915ECCC
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777126254; cv=none; b=Nk66aOGMQdM49hfoqBWe4TuqQn62LOF/39RpeOhLQC+SquijVtkvpR0kXlNxwvkHWeqzxFWJ8H3Xvp8OyQEimiZkxiC5Q57lPVKl7ezKaiZTrwjeD1yV4Rot6kJMkAoV0vOHExydzUyDOQRW5TUO6lCRTkWnekeq8N6JRYA1R/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777126254; c=relaxed/simple;
	bh=wagJbOabzBX4c3I3/fpQnk3/gb9n7mhfA2RWn9EY5NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XakogDUcr/nYMqtaIKbXgCkY7JPY/aM/57VoEM6GrmW4+jWfjw5u4xgXdlLc+7TNkVQ2Qn/uAsaNknYfUZYbcO1GZIxGg+C0pe4aggqiHH5dNm9NLi+0c0mimIQk03y3dA8+P89ieeXQvr3bbAAYO+FQg2TIBNxCZeld0VOee9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avcVIe9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F892C2BCB0;
	Sat, 25 Apr 2026 14:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777126253;
	bh=wagJbOabzBX4c3I3/fpQnk3/gb9n7mhfA2RWn9EY5NU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=avcVIe9uVideLxvgqZdXGOU5N0OIGskkLBJJMVEnRmjir9GW7F6hRNAesMAwospOe
	 1P4JdGVEWbL15vJm4SllIZ0PZ4pZJx07Q6AY0OdTosB6pD7iIVk0rrezENQ60C/lc2
	 RyIKmNA+q6xorvq1Yh31gIL1lFJL7BFlIpLOXJwjApA5efUMdqVc3AIwoG+0cCgWto
	 nLtLiBO3hD6pn+dhZZa+lWDBNTYSU7HnDEQDdFwUrP7Y9y1caJJrmpupbqqSfr6pqe
	 P3Va2G3zCVcjaKMHUCUtigVuy561vO5g7XICgO0cnWF04SW7kjgMx2qEZ8B1Tio0aZ
	 RM3vNuIeW0ghg==
Date: Sat, 25 Apr 2026 16:10:51 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Do not read uninitialized fragment
 address in airoha_dev_xmit()
Message-ID: <aezLa2POvT0It5AA@lore-desk>
References: <20260424-airoha-xmit-fix-read-frag-v1-1-fdc0a83c79e8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0VgauHS1AwOXXx5H"
Content-Disposition: inline
In-Reply-To: <20260424-airoha-xmit-fix-read-frag-v1-1-fdc0a83c79e8@kernel.org>
X-Rspamd-Queue-Id: A34CD4668DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281118-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[]


--0VgauHS1AwOXXx5H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The transmit loop in airoha_dev_xmit() reads fragment address and length
> during its final iteration, when the loop index equals
> skb_shinfo(skb)->nr_frags, at which point the fragment data is
> uninitialized. While these values are never consumed, the read itself is
> unsafe and may trigger a page fault. Fix this by avoiding the fragment
> read on the last iteration.
> Additionally, move the skb pointer from the first to the last used packet
> descriptor, so that airoha_qdma_tx_napi_poll() defers freeing the skb
> until the final descriptor is processed.
>=20
> Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581=
 SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 2bb0a3ff9810..d3a841908c82 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1997,8 +1997,8 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *=
skb,
>  	struct netdev_queue *txq;
>  	struct airoha_queue *q;
>  	LIST_HEAD(tx_list);
> +	int i =3D 0, qid;
>  	void *data;
> -	int i, qid;
>  	u16 index;
>  	u8 fport;
> =20
> @@ -2057,7 +2057,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *=
skb,
>  			     list);
>  	index =3D e - q->entry;
> =20
> -	for (i =3D 0; i < nr_frags; i++) {
> +	while (true) {
>  		struct airoha_qdma_desc *desc =3D &q->desc[index];
>  		skb_frag_t *frag =3D &skb_shinfo(skb)->frags[i];
>  		dma_addr_t addr;
> @@ -2069,7 +2069,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *=
skb,
>  			goto error_unmap;
> =20
>  		list_move_tail(&e->list, &tx_list);
> -		e->skb =3D i ? NULL : skb;
> +		e->skb =3D i =3D=3D nr_frags - 1 ? skb : NULL;
>  		e->dma_addr =3D addr;
>  		e->dma_len =3D len;
> =20
> @@ -2088,6 +2088,9 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *=
skb,
>  		WRITE_ONCE(desc->msg1, cpu_to_le32(msg1));
>  		WRITE_ONCE(desc->msg2, cpu_to_le32(0xffff));
> =20
> +		if (++i =3D=3D nr_frags)
> +			break;
> +
>  		data =3D skb_frag_address(frag);
>  		len =3D skb_frag_size(frag);
>  	}
>=20
> ---
> base-commit: e728258debd553c95d2e70f9cd97c9fde27c7130
> change-id: 20260423-airoha-xmit-fix-read-frag-dc6aa001ca4b
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

Commenting on Sashiko reported issues:
https://sashiko.dev/#/patchset/20260424-airoha-xmit-fix-read-frag-v1-1-fdc0=
a83c79e8%40kernel.org

- Does the TSO checksum calculation earlier in this function ensure the
  TCP header is in the linear portion of the SKB?
  This issue is not related to the current patch. Moreover, can we have a T=
SO
  packet where the tcp header is not in the linear area of the skb?

- If dma_map_single() fails partway through a multi-fragment packet and
  triggers this goto error_unmap, will it break the Tx ring contiguity?
  This issue is not related to the current patch. Moreover, I guess the hw =
is
  capable of managing out-of-order descriptors.

- Is it safe to map fragment data using dma_map_single() instead of
  skb_frag_dma_map()?
  This issue is not related to the current patch. I will post a dedicated p=
atch
  for it.

Regards,
Lorenzo

--0VgauHS1AwOXXx5H
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaezLawAKCRA6cBh0uS2t
rCSVAP4hJXo5r610dexifSQ7HqAQwgINCipaQyT6j0sTiA11XwD/a4KlozQd3xg7
gPp2llCfFkiPrwcWIN60uNLYuPWkrAE=
=4VRT
-----END PGP SIGNATURE-----

--0VgauHS1AwOXXx5H--

