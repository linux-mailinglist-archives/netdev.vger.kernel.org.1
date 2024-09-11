Return-Path: <netdev+bounces-127457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E287975773
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97085B256D7
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A840419CC31;
	Wed, 11 Sep 2024 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="S5LHnrlJ"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9EF192D86
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069576; cv=none; b=VPbv/vtrslnHD6K0WADYv91JeyPY434BCyiRtXKROLDw1UhPLjZcnyjV5nTaqnYO4WKXFBGP8Cu/a48vvGbGn9ZcbohjXpZVhh3LLg4tdoWoz3iz7QN7jNsmbCrmY7E6ibP3bJtsC+nmUO+h6O7eOq9Yy8QTO1Lz/uuKDh7WDuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069576; c=relaxed/simple;
	bh=bhvDXQWmYLhmSfgFlAuO39PfFTlamTCJ7EkEOV4OAhc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dg7f54NU3rkfqSa3bZ9MKRyesyLT+2FohWF7Pgy1d6MdMEb5uGSCS1fFHiaTBrgu85ETsgd2iNngxkTCXoPZbk6V8spupWc0oFq2uqR6KB36QygenRYUB8kyO10FflTuVaRG+qYYiC0Ip1XAdwMqmSqN4sCjXhqiFzTWlIpiKrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=S5LHnrlJ; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 9464D8917E;
	Wed, 11 Sep 2024 17:46:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726069567;
	bh=94Y1SbrvIRmCZCfaESkjCOiTQQ15gkKhGR++0YJ4/n4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S5LHnrlJ4hN5wCePTT1hHa0tGj/ZKHc1kCR8e06GAVo6FmidYckLzJwTN1hvF7Gg5
	 o24Ihmx+L+TwPq52Jchap89OG2ddOlHe7x2r09JZeCNx8oInKEz60FovmJRkJpd365
	 +iVw8g4DgrC4ial6UrWysTnIknja1CEF9LWeBaPQfpS58dNg0USzdMyhB3XlDopm+O
	 IiDU+gxqtrKvp2KNTnr+wakaGs8ANQnvgQ2Jisje8VUNzUjokIz0+DxnhQs0MZG8Ns
	 /uJ8GdKw/awGWpvhINIUnWnfPGd5T1Q/LQZkB35foAj3sMUq3/57+Tc51wiUgxoL8I
	 C5FRD9oCts0Hw==
Date: Wed, 11 Sep 2024 17:46:05 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 syzbot+3d602af7549af539274e@syzkaller.appspotmail.com
Subject: Re: [PATCH net 1/2] net: hsr: Use the seqnr lock for frames
 received via interlink port.
Message-ID: <20240911174605.4ab21622@wsk>
In-Reply-To: <20240906132816.657485-2-bigeasy@linutronix.de>
References: <20240906132816.657485-1-bigeasy@linutronix.de>
	<20240906132816.657485-2-bigeasy@linutronix.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VqsTMi1PTT.Xf_VHyMWEBkw";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/VqsTMi1PTT.Xf_VHyMWEBkw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sebastian Andrzej,

> syzbot reported that the seqnr_lock is not acquire for frames received
> over the interlink port. In the interlink case a new seqnr is
> generated and assigned to the frame.
> Frames, which are received over the slave port have already a sequence
> number assigned so the lock is not required.
>=20
> Acquire the hsr_priv::seqnr_lock during in the invocation of
> hsr_forward_skb() if a packet has been received from the interlink
> port.
>=20
> Reported-by: syzbot+3d602af7549af539274e@syzkaller.appspotmail.com
> Closes:
> https://groups.google.com/g/syzkaller-bugs/c/KppVvGviGg4/m/EItSdCZdBAAJ
> Fixes: 5055cccfc2d1c ("net: hsr: Provide RedBox support (HSR-SAN)")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de> ---
>  net/hsr/hsr_slave.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index af6cf64a00e08..464f683e016db 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c
> @@ -67,7 +67,16 @@ static rx_handler_result_t hsr_handle_frame(struct
> sk_buff **pskb) skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
>  	skb_reset_mac_len(skb);
> =20
> -	hsr_forward_skb(skb, port);
> +	/* Only the frames received over the interlink port will
> assign a
> +	 * sequence number and require synchronisation vs other
> sender.
> +	 */
> +	if (port->type =3D=3D HSR_PT_INTERLINK) {
> +		spin_lock_bh(&hsr->seqnr_lock);
> +		hsr_forward_skb(skb, port);
> +		spin_unlock_bh(&hsr->seqnr_lock);
> +	} else {
> +		hsr_forward_skb(skb, port);
> +	}
> =20
>  finish_consume:
>  	return RX_HANDLER_CONSUMED;

I've run it through the QEMU + buildroot setup on net-next (SHA1:
bf73478b539b) and no regression was seen.

Thanks for preparing this patch :-)

Reviewed-by: Lukasz Majewski <lukma@denx.de>
Tested-by: Lukasz Majewski <lukma@denx.de>


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/VqsTMi1PTT.Xf_VHyMWEBkw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmbhuz0ACgkQAR8vZIA0
zr0Nuwf/YI1uDITEIvGnsQ3/ML8ypYMe5THlxAFqBuPMi4Tsk7olkET8g4cTRfps
9zmRTimq1EugUyEDxlSG0YQKcowl8cOzG0+SEwL7SQpWdZ4k9Bqs4pGOnlVW7v1c
6AehnbXJ1aToqves91YrVkAYZhff2XOPWktVkWokJ84jMihJBaF3aTd9B7X1DEjE
wT7MQbvnEasumPumtme67yHwA1QfBVeF13ECA+pm+jXoOdknQEjaBdD0QD/vNY1p
mInRdO/XgZp5YnYrZSq8EsYN3Oj2qJ8GsVRBLsrKtyIQlkeMctBJQ11eTkQqbUcd
665/ywdzqnkvoeIGGw4+W9M+8b0OzA==
=2qsj
-----END PGP SIGNATURE-----

--Sig_/VqsTMi1PTT.Xf_VHyMWEBkw--

