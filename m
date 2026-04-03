Return-Path: <netdev+bounces-275052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAlXLpDDz2lH0QYAu9opvQ
	(envelope-from <netdev+bounces-275052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:41:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2CD3949F7
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EF4C300C028
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 13:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FFB3BC68D;
	Fri,  3 Apr 2026 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDKEbgHt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CEB3BBA07
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775223665; cv=none; b=caZHTKR55ZPiG57CHFOj5vocQLx21LTvUhrDBD2CGzOZPD9BvpXNMA2VDcnX4a9nV6a/wlUWVQFrAylWtswpEUF5H66awCXj/XDQYcH+bl0Cm8hg62rPJHho//fcdJRlVFoY3XuVwEOp0wiuwCT2meFN0Bo+4LWeEgQiyyTD2AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775223665; c=relaxed/simple;
	bh=6g9R2GmeiAMhntpDVU6Z92dvhCYleNtqjiM/Wc8jXvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1Yw2/BOqwlgHAlbVWRRzAY1IkQmo3vRD7fVLVjLiTi8Lx0E8UYiXO0Frtp7HzBSLH3B+AUFh+7Mmb+4G9WOd1Hy6bBA7n0m6HJNAVJQxDO2cZfiHTwE2KJ4MmELmxPfmutQYiHOO1wrGgGTtvKTbtIjkCcNIIALuswU+H4eIg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDKEbgHt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBF5C4CEF7;
	Fri,  3 Apr 2026 13:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775223665;
	bh=6g9R2GmeiAMhntpDVU6Z92dvhCYleNtqjiM/Wc8jXvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aDKEbgHtwO03Htxu7Te0gFEyIE7S3X0OzU+6jR8id9x1tcxbx7oQlB7szyGVgVM++
	 8hv0gQoSXTfIpRCFzOwPlc5SqASExfYZLMBSKdzJWUr57pFARA/xO9fe/VqHrmB3J9
	 z3XBsFBk2Frzm56C5TsAqp6dqTZidHelQPtveZmEhjrEFcq+7m2BE6qqTDoEUwB529
	 ykcvOq++MF4mKlu5NkwAKszZ+FoWBVBROGg/Zmq29nsfpq6K3Xkbfv5TuVc0te1XZF
	 sC9VXKsEtrNhcXCN5Q3fBya2guGh3EfHEUlJcDqmYgQHXac8dvrQZ7IUWsorWXlWJC
	 Twa4nECx+zudg==
Date: Fri, 3 Apr 2026 15:41:03 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Xuegang Lu <xuegang.lu@airoha.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Add dma_rmb() and READ_ONCE() in
 airoha_qdma_rx_process()
Message-ID: <ac_Dbzfgr728lpmD@lore-desk>
References: <20260402-airoha_qdma_rx_process-fix-reordering-v1-1-53278474f062@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CcLH+/Yb/7WuJ8OG"
Content-Disposition: inline
In-Reply-To: <20260402-airoha_qdma_rx_process-fix-reordering-v1-1-53278474f062@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-275052-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B2CD3949F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--CcLH+/Yb/7WuJ8OG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Add missing dma_rmb() in airoha_qdma_rx_process routine to make sure the
> DMA read operations are completed when the NIC reports the processing on
> the current descriptor is done. Moreover, add missing READ_ONCE() in
> airoha_qdma_rx_process() for DMA descriptor control fields in order to
> avoid any compiler reordering.
>=20
> Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581=
 SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Please drop this version, I will post v2 to add a missing READ_ONCE() for
airoha_qdma_get_gdm_port().

Regards,
Lorenzo

>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 95ba99b89428e4cafb91ff7813e43ffeb38e6d9b..29dea8b35f64bfdcf88bc09fd=
711e0d8b4f7b6fa 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -612,15 +612,17 @@ static int airoha_qdma_rx_process(struct airoha_que=
ue *q, int budget)
>  	while (done < budget) {
>  		struct airoha_queue_entry *e =3D &q->entry[q->tail];
>  		struct airoha_qdma_desc *desc =3D &q->desc[q->tail];
> -		u32 hash, reason, msg1 =3D le32_to_cpu(desc->msg1);
> -		struct page *page =3D virt_to_head_page(e->buf);
> -		u32 desc_ctrl =3D le32_to_cpu(desc->ctrl);
> +		u32 hash, reason, msg1, desc_ctrl;
>  		struct airoha_gdm_port *port;
>  		int data_len, len, p;
> +		struct page *page;
> =20
> +		desc_ctrl =3D le32_to_cpu(READ_ONCE(desc->ctrl));
>  		if (!(desc_ctrl & QDMA_DESC_DONE_MASK))
>  			break;
> =20
> +		dma_rmb();
> +
>  		q->tail =3D (q->tail + 1) % q->ndesc;
>  		q->queued--;
> =20
> @@ -637,6 +639,7 @@ static int airoha_qdma_rx_process(struct airoha_queue=
 *q, int budget)
>  		if (p < 0 || !eth->ports[p])
>  			goto free_frag;
> =20
> +		page =3D virt_to_head_page(e->buf);
>  		port =3D eth->ports[p];
>  		if (!q->skb) { /* first buffer */
>  			q->skb =3D napi_build_skb(e->buf, q->buf_size);
> @@ -670,8 +673,8 @@ static int airoha_qdma_rx_process(struct airoha_queue=
 *q, int budget)
>  			 * DMA descriptor. Report DSA tag to the DSA stack
>  			 * via skb dst info.
>  			 */
> -			u32 sptag =3D FIELD_GET(QDMA_ETH_RXMSG_SPTAG,
> -					      le32_to_cpu(desc->msg0));
> +			u32 msg0 =3D le32_to_cpu(READ_ONCE(desc->msg0));
> +			u32 sptag =3D FIELD_GET(QDMA_ETH_RXMSG_SPTAG, msg0);
> =20
>  			if (sptag < ARRAY_SIZE(port->dsa_meta) &&
>  			    port->dsa_meta[sptag])
> @@ -679,6 +682,7 @@ static int airoha_qdma_rx_process(struct airoha_queue=
 *q, int budget)
>  						  &port->dsa_meta[sptag]->dst);
>  		}
> =20
> +		msg1 =3D le32_to_cpu(READ_ONCE(desc->msg1));
>  		hash =3D FIELD_GET(AIROHA_RXD4_FOE_ENTRY, msg1);
>  		if (hash !=3D AIROHA_RXD4_FOE_ENTRY)
>  			skb_set_hash(q->skb, jhash_1word(hash, 0),
>=20
> ---
> base-commit: ec7067e661193403a7a00980bda8612db5954142
> change-id: 20260402-airoha_qdma_rx_process-fix-reordering-722308255b65
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

--CcLH+/Yb/7WuJ8OG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCac/DbgAKCRA6cBh0uS2t
rBFGAQDsASA4qELdeIETxjOVDrs0SEJPliW3Cdlk2di93gqB1gD+J5i5KV2KXaow
NB6Aity+4OCEK19fVTDOFqX39VIASgA=
=NVjB
-----END PGP SIGNATURE-----

--CcLH+/Yb/7WuJ8OG--

