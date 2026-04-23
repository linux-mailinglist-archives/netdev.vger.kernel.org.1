Return-Path: <netdev+bounces-280659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qE5eHp7U6WnxlAIAu9opvQ
	(envelope-from <netdev+bounces-280659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:13:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2D744E655
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85AD83018283
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643EB322B7D;
	Thu, 23 Apr 2026 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABr3DnpM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38188335555
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776931944; cv=none; b=mKBDBnvzz5P1vaB2RkuyIayLixyreJ/1w2jfyhcQpY6OooLc/29yXz5JJqsjViU2CNbnwx4N6Be2uujgyeWYQcjU2i1g2z4nJbwhow6deSzlx89+lX35UjfOVS/O58rjNYo0wgdj/+t+epvrW6hfOBnptU8Ofsbm5y7oWCYkg20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776931944; c=relaxed/simple;
	bh=iEcYAM0VwzzlUdBWlgBenv9RwXM4rAx4T+7N+FRLWSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emODR7qXNuS8lXOK0Q6M1QZTGyZ5DkzuEY8asAmQ5PJwEcq5f6rocjKU8kaTZpQrH4njfRQ+zDgHpdNGgPepvTNbI9/9Sv3/KQc8Knjr0v3aZ9tA3XJP2wuN+xpTg6yNvF2kUSytJo7erqk/zuQxMQE/tauMxYiWbh5W4ZAyKZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABr3DnpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712BCC2BCAF;
	Thu, 23 Apr 2026 08:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776931943;
	bh=iEcYAM0VwzzlUdBWlgBenv9RwXM4rAx4T+7N+FRLWSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ABr3DnpMiq0MaldPMg3udYOvaz02Da8BaHqPFrDJJvdIQu6rX4u1n80nNj85WCRkS
	 75QaPBYbDsvs+SQWIHNn4vbdEG2DJuDCutTTDclvCanI9VqhwfNbofQ7qQErKoILTn
	 yv+3KlbN9Lm+M1Ov6Yv6xWmvS6EESQFZjT87DeXBI5f9RCMGJVg9avF1JNChp22TSK
	 /+dletROj0tX1pLtgoa12poN5h9xK38mu4qJO/yRyQ7zbtcf3qLHsJIJLCFZRQMbBJ
	 eEY72aKJQVg1Zi1ahz6S1l3h6epEH+BBMj/JXz0HWlCBHYjul2CaiNPhw144AEKdNp
	 PnDtcUOfMpoxA==
Date: Thu, 23 Apr 2026 10:12:21 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hariprasad Kelam <hkelam@marvell.com>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: fix BQL imbalance in TX path
Message-ID: <aenUZc6mSBuSvWbz@lore-desk>
References: <20260421-airoha-fix-bql-v1-1-f135afe4275b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UnahIpJ2gghwFW0k"
Content-Disposition: inline
In-Reply-To: <20260421-airoha-fix-bql-v1-1-f135afe4275b@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280659-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F2D744E655
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--UnahIpJ2gghwFW0k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Fix a possible BQL imbalance in airoha_dev_xmit(), where inflight
> packets are accounted only for the AIROHA_NUM_TX_RING netdev TX
> queues. The queue index is computed as:
>=20
>     qid =3D skb_get_queue_mapping(skb) % ARRAY_SIZE(qdma->q_tx)
>     txq =3D netdev_get_tx_queue(dev, qid);
>=20
> However, airoha_qdma_tx_napi_poll() accounts completions across all
> netdev TX queues (num_tx_queues), leading to inconsistent BQL
> accounting.
>=20
> Also reset all netdev TX queues in the ndo_stop callback.
>=20
> Fixes: 1d304174106c ("net: airoha: Implement BQL support")
> Fixes: c9f947769b77 ("net: airoha: Reset BQL stopping the netdevice")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 19f67c7dd8e1..6c7390f0de5d 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -929,10 +929,9 @@ static int airoha_qdma_tx_napi_poll(struct napi_stru=
ct *napi, int budget)
>  		q->queued--;
> =20
>  		if (skb) {
> -			u16 queue =3D skb_get_queue_mapping(skb);
>  			struct netdev_queue *txq;
> =20
> -			txq =3D netdev_get_tx_queue(skb->dev, queue);
> +			txq =3D skb_get_tx_queue(skb->dev, skb);
>  			netdev_tx_completed_queue(txq, 1, skb->len);
>  			dev_kfree_skb_any(skb);
>  		}
> @@ -1711,7 +1710,7 @@ static int airoha_dev_stop(struct net_device *dev)
>  	if (err)
>  		return err;
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(qdma->q_tx); i++)
> +	for (i =3D 0; i < dev->num_tx_queues; i++)
>  		netdev_tx_reset_subqueue(dev, i);
> =20
>  	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
> @@ -2002,7 +2001,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *=
skb,
> =20
>  	spin_lock_bh(&q->lock);
> =20
> -	txq =3D netdev_get_tx_queue(dev, qid);
> +	txq =3D skb_get_tx_queue(dev, skb);
>  	nr_frags =3D 1 + skb_shinfo(skb)->nr_frags;
> =20
>  	if (q->queued + nr_frags >=3D q->ndesc) {
>=20
> ---
> base-commit: a663bac71a2f0b3ac6c373168ca57b2a6e6381aa
> change-id: 20260421-airoha-fix-bql-7fff7cebbc9a
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

commenting on Sashiko reported issues:
https://sashiko.dev/#/patchset/20260421-airoha-fix-bql-v1-1-f135afe4275b%40=
kernel.org

- This isn't a bug in this patch, but does using 0xff as a sentinel value c=
ause a permanent stall?
  I do not think this is a real issue since, according to my understanding,=
 the NIC
  never writes 0xff in irq_q queue.

- This is another pre-existing issue, but does freeing the SKB here cause a=
 DMA use-after-free
  for multi-fragment packets?
  This issue is not related to this patch, and I will fix it in a dedicated
  patch storing the skb pointer in the last descriptor in airoha_dev_xmit()

- Since the QDMA hardware and NAPI instance are shared among multiple ports=
 (qdma->users),
  could active NAPI polling cause a BUG_ON() in dql_completed()?
  This is not an issue related to this patch since here we are just resetti=
ng
  all the netdev tx queues instead of just the first ARRAY_SIZE(qdma->q_tx)
  ones.

- This isn't a bug in this patch, but does failing to wait for the DMA engi=
nes to become
  idle before unmapping buffers cause memory corruption?
  This issue is not related to this patch and it will be fixed with a dedic=
ated
  patch.

- This is also pre-existing, but can this mapping cause a kernel panic on h=
ighmem systems?
  Can we have fragments in high memory? e.g on ARM architecture? Anyway, as
  pointed out by Sashiko, this issue is not related to this patch.

- This isn't introduced here, but does this logic cause a permanent TX stal=
l?
  this issue is already fixed in the following patch:
  https://patchwork.kernel.org/project/netdevbpf/patch/20260421-airoha-xmit=
-stop-condition-v1-1-e670d6a48467@kernel.org/

Regards,
Lorenzo

--UnahIpJ2gghwFW0k
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaenUZQAKCRA6cBh0uS2t
rG34AP9NRfrm2/98XzQnX8x/rvejxWGK4oyc/yAPXY8BBSwGWgEA0/gbqM6hiF2B
TP2H8hOsiFsTF5in8IVx3jPq3E8e7Qk=
=ET9C
-----END PGP SIGNATURE-----

--UnahIpJ2gghwFW0k--

