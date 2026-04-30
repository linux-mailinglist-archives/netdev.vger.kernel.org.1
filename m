Return-Path: <netdev+bounces-282829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BH5CdpJ82ngzAEAu9opvQ
	(envelope-from <netdev+bounces-282829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:23:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6480F4A2BA2
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1B9E3009FB7
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4F23A7F79;
	Thu, 30 Apr 2026 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="op3A97ZY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ECB34B1A7
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777551821; cv=none; b=DVMOgg8qj/lKUVBVNNXZMoQIxGNEXMgShHVKS8fJnU8L0PXxnUXI4f/B4jkj5SFTmamwV3J4PGkRpGWx0BPHndM74OfYoWorV1Vu90cBCYGGBxDCSOptb+DGTQY7AJip5/FOWMUKQuQmYIUo5Q+xj+yFoO/aVzyXsiIEmrFpo9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777551821; c=relaxed/simple;
	bh=9jQIOHWUDbMyaXsyCpKYu6cCyujvTULfSz7FqVfVXpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+9GysqOFKc7a9v567YztGJeX0llWVq0ECic/9l7FOYGaFzR8NJEXAZJagFpImW5XarBT3dGLk6Q6YZ+KsbeOWKoiwryfxGZz8hBw3l9UOaRuC16g/9uaZMDFQICbYkV2ypfxwuBQ8QV4yD0KKxGCzXe/+eGyUTxtPHc652L4bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=op3A97ZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43559C2BCB3;
	Thu, 30 Apr 2026 12:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777551820;
	bh=9jQIOHWUDbMyaXsyCpKYu6cCyujvTULfSz7FqVfVXpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=op3A97ZYlW6JY6JQn8rr8FitB+pkyBEB5XAYYJ1VBsPS+Ucif55Q7M7+nk90YpF8l
	 wOcbnvwdSLgrwvZNEm9VQ/O3oro/dCpOrwlbmH3VqDUhGaMRbBS9eRfvARrM58FZ80
	 XqUaUMPrhUwFdiqNEERTkjWcabRq/D/vATMHBVTpNUdr4GZ5um4t87Lkj4srrLzur5
	 bXqGQjfVpo3EX56RpxhGDEYap4paRAUwxLtT1AK7YQltAkdDo5h0qGp3ENDy0To9Q/
	 KcL/ZKvRhbWLl3lohwP1+X4Bte6tnCmBc6/IOaKdZuVkEhSUUj7F8AznLEbr2L1BWc
	 sMhn0F75dBajA==
Date: Thu, 30 Apr 2026 14:23:38 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net: airoha: Move entries to queue head in case
 of DMA mapping failure in airoha_dev_xmit()
Message-ID: <afNJyrJKz-tPP3VP@lore-desk>
References: <20260429-airoha-xmit-unmap-error-path-v2-1-32e43b7c6d25@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xt+h5H/7PrMUntb6"
Content-Disposition: inline
In-Reply-To: <20260429-airoha-xmit-unmap-error-path-v2-1-32e43b7c6d25@kernel.org>
X-Rspamd-Queue-Id: 6480F4A2BA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-282829-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]


--xt+h5H/7PrMUntb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In order to respect the original descriptor order and avoid any
> potential IOMMU fault or memory corruption, move pending queue entries
> to the head of hw queue tx_list if the DMA mapping of current inflight
> packet fails in airoha_dev_xmit routine.
>=20
> Fixes: 3f47e67dff1f7 ("net: airoha: Add the capability to consume out-of-=
order DMA tx descriptors")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v2:
> - Remove leftover airoha_queue_entry initialization inside the loop from
>   the previous version.
> - Link to v1: https://lore.kernel.org/r/20260428-airoha-xmit-unmap-error-=
path-v1-1-aec44c6765c1@kernel.org
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 5effb4a4ae84..fb4f51d67dd7 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2123,14 +2123,12 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff=
 *skb,
>  	return NETDEV_TX_OK;
> =20
>  error_unmap:
> -	while (!list_empty(&tx_list)) {
> -		e =3D list_first_entry(&tx_list, struct airoha_queue_entry,
> -				     list);
> +	list_for_each_entry(e, &tx_list, list) {
>  		dma_unmap_single(dev->dev.parent, e->dma_addr, e->dma_len,
>  				 DMA_TO_DEVICE);
>  		e->dma_addr =3D 0;
> -		list_move_tail(&e->list, &q->tx_list);
>  	}
> +	list_splice(&tx_list, &q->tx_list);
> =20
>  	spin_unlock_bh(&q->lock);
>  error:

commenting on Sashiko's reported issues:
https://sashiko.dev/#/patchset/20260429-airoha-xmit-unmap-error-path-v2-1-3=
2e43b7c6d25%40kernel.org

- Should the driver be updated to use skb_frag_dma_map() for mapping the SKB
  fragments, and correspondingly use dma_unmap_page() for those fragments in
  this error handling path?
  As we already pointed out here [0], we decided to skip this request and k=
eep
  using dma_map_single() even for skb fragments.

Regards,
Lorenzo

[0] https://lore.kernel.org/netdev/20260427173935.6a1e36ee@kernel.org/

>=20
> ---
> base-commit: 0c7a5ba011d336df4fcd1f667fcc16ea5549be12
> change-id: 20260428-airoha-xmit-unmap-error-path-8125594efb23
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

--xt+h5H/7PrMUntb6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCafNJygAKCRA6cBh0uS2t
rNgvAQDcio7RfE8FHhr52yeau67/5vWcdnxcizu8/yAGQVnyXwD8Caa7RJoxjVnP
Khmg846cqMbyJY1xeHJAYGO5dF2CqAI=
=38rW
-----END PGP SIGNATURE-----

--xt+h5H/7PrMUntb6--

