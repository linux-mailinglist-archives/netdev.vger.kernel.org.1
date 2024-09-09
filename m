Return-Path: <netdev+bounces-126472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C7D97145A
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 11:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342C91C22F51
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1A71B29A3;
	Mon,  9 Sep 2024 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="bEXS9Nw4"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5FC1B14F3
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875393; cv=none; b=NNK0p7+DfVjk9MT6PDRU91dGkRGb1974yVt1zz+CmLoDHhxUJ1nepbifrzkX0vizYZCyZ2JFJxMsvIuYUPwW5eErJYEv+sUtNWIwaB7WGQj2kGAOOWgefFfX5cZ0HF8JB/CNHcQRSCmF9s0sbGmm8oFBC1dUylnucBgjEt4IEuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875393; c=relaxed/simple;
	bh=qJEcHtD3/lIxA6+g6I4vNkc35G+IepBUr6nL26HgJGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqJWynDGBxX05eHkL83MODv/auT8Xdu+oABFtEXDfN7GfV7uSu8bxKWYEK+daZz14/l15GYi1dk9gfWPskx/JfiXzds/HrkW94Ef8HPLmn/lGwxfWbCNqPhn/Oyd5J6lkGzmbsNwIlt7SRMj7yOdK2JDCnFSrDGNZv3CGQTZsiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=bEXS9Nw4; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 4921E88B49;
	Mon,  9 Sep 2024 11:49:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725875389;
	bh=MNx64q/9XNzdZpqnw7FvloVFMKbR2eLLJquLc3tmUrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bEXS9Nw44jN7NYkH2x1rB7IoLdEsqXdEycpb8laHOv+dJuR9aCbPdSSULRCkSExSv
	 r/1KF4X0gVQIjpnqaM7Yhw1Xf7+EjNgy8rKaikkO8VFNMKxT5bqepE0MsfKGRtyRJZ
	 r9vCT6P7m+FuxOykASHYSEMGZ6Rrz0aQ0MnHiSP4MJMZKEtP3mAGr0klGroV779SSu
	 tQsPC2BrccBDehAuaR7c3O9rURxoAypY6D2qCsYFO98Cr4P/eHB/W36UXK+kXtLsLZ
	 19sj65uO1JV3QTsucAdeTqR7Fz7c1KSyv9zWDHLJVmupesEueoynWaHw1P5uMsI9vy
	 xgvFiBs/ZAn0g==
Date: Mon, 9 Sep 2024 11:49:48 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 syzbot+3d602af7549af539274e@syzkaller.appspotmail.com
Subject: Re: [PATCH net 1/2] net: hsr: Use the seqnr lock for frames
 received via interlink port.
Message-ID: <20240909114948.129735b9@wsk>
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
Content-Type: multipart/signed; boundary="Sig_/s7I4owHF4ZGfP9IjmS+c.Mz";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/s7I4owHF4ZGfP9IjmS+c.Mz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

> syzbot reported that the seqnr_lock is not acquire for frames received
> over the interlink port. In the interlink case a new seqnr is
> generated and assigned to the frame.

Yes, correct.

The seq number for frames incomming from HSR ring are extracted from
the HSR header.

For frames going from interlink (SAN) network to RedBox, the start seq
number is assigned when node is created (and the creation node code is
reused).

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

I'm just wondering if this could have impact on offloaded HSR operation.

I will try to run hsr_redbox.sh test on this patch (with QEMU) and
share results.

> +		hsr_forward_skb(skb, port);
> +		spin_unlock_bh(&hsr->seqnr_lock);
> +	} else {
> +		hsr_forward_skb(skb, port);
> +	}
> =20
>  finish_consume:
>  	return RX_HANDLER_CONSUMED;




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/s7I4owHF4ZGfP9IjmS+c.Mz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmbexLwACgkQAR8vZIA0
zr0lFwgAp+PzpGyRfUz2Ji7ANR1zTWStDXoVMvLATtkJntN6QodFTFPf/w4XUZ+z
clvptnn8hJbGVikHD54WZuLYFdq7LrXonuFJhrFRa2nuT9lzTNNfqiek0KSJw2w8
SZ0+7lVKhkbVwd4Hr7z+0WuFrF5eV69xsnka7uGr31p0OqNe8Nd794CKboITdSFS
tnuG21zZWXSm4jS76KcVKvNtjA5+RYrLdKQWz7D0TNdeTaBjPNiD0MHNliZz/HtV
5w8NmZRlKYzJmhfmw8hGyjqLHAgtXhV4EVR2rwrfrTKI8Bg5KbHPv5RIpf5iKUIn
vw9s70wCLRwRHpcc03pu49fgLdmHtQ==
=OELS
-----END PGP SIGNATURE-----

--Sig_/s7I4owHF4ZGfP9IjmS+c.Mz--

