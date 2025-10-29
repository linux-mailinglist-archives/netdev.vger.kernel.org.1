Return-Path: <netdev+bounces-234141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F70CC1D1EF
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 21:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4A694E1020
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 20:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0FC31064B;
	Wed, 29 Oct 2025 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="bB92AFHl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hthmjPUC"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF32F99A8
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761768210; cv=none; b=uV1RFFFfVb0vGWqWEvVStuK0R0GIbHT9ZTn32Ks4mK/L423ft9B/2OETxuZhe4Sg9eeb4pP52ys1t/QaQjYHLJQFrKk+MLPiK/6Vs70rq6thJ8w2f0iwPXDq2O1L8Q+QvvMyjecGIqFEGB09atj4NWSIXZhInyQriUXvW16tC9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761768210; c=relaxed/simple;
	bh=uZIKTMIh75V51hl503/yr6yTZk9EazXLa2fkJcdtBJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HsuoG4HRdcZ9zysJeXFp14Bp6Y8pWOb2UpdtBZ6dGIQo8HhtbFFL95mMSacM7EU+2MZpBS1nLvi5yXs90chv3JRtZKZcvwmqJtuV1N4lKeASe7r2rsNv6HSdRbhG2jc4fMWMZpzAt7yNqPblNU8XXgRuUfTxtKmnoUD6ydDsZ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=bB92AFHl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hthmjPUC; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 382B3140010C;
	Wed, 29 Oct 2025 16:03:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 29 Oct 2025 16:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1761768206; x=1761854606; bh=tTlPC94CkpdB6o7aptJzF5shiceT6Kf4
	3SfDYb87Dwg=; b=bB92AFHlUK5e1rSvSqcv/gKGV2rQWM2J6GE4zrO7O8fDZta7
	TxMlHk5lcesxlmCKtxylaxWlOcPnlBGQLgoDo5ato71X5Sr3oj97N/19E/y3sDsH
	FCCBT310veFANt7DqTM1sbGmxekaoU4ARiqMitleJKMlk4o7RnVjeR8clDnJo6YB
	VQbXEFHWgtTZ1I9q09BP5eUGx06tb5dYuhm5av+ta5aCZDbdgWD+YpeVq5M3E9Qf
	RvsPG1RZmGCWzKyJGSda6iBQWZu+14LztdxR0U0lK6urUnXm6YC5u0xTOFxkU//W
	Vs3wQmHVdMzYkA23w/P/kZppxHWTUxMjC2r+nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761768206; x=
	1761854606; bh=tTlPC94CkpdB6o7aptJzF5shiceT6Kf43SfDYb87Dwg=; b=h
	thmjPUCINnk5W/Sqc38yPLrLNJFsG0s4FjOKwsn1jNU+RmwhICNWrEnowj1iaTFD
	TYQyCLgjnpYI01BmnmsZGpvaCnHxvL7E6mDjgXcZ8BimTj/2WwW/JoBxqm572uBl
	3tbwsYzC6//sckD+RKuEzVR6DfaR5otdSA5IJDJh7RCqtb05sjQim9nKDyqTtly9
	FTZljyUUsDiHmDqTna/hm9pbHcwjbG+m9fUWMSc31yOz7YxVgk/raxZIH/Gv6u8n
	zPULBVKhUVh6w9I2o7DUWzFD5sfZGGmRB2J5A2mD+IQyW59ABcO0e/O8ynDK8wZY
	MI+UtOHKW+ZI5dIl4zQQw==
X-ME-Sender: <xms:DXMCaT2Dg8DswDMiBvZC9MRcIUagK5Dj7Pmi155I4_BvxpGwpCxHzA>
    <xme:DXMCadDNU5FAijtaw-WfQB535tD7lLusJU4SwSKr_CnMaXygxlzK6FcSIvcsfvyqW
    8ivszofOyPEtAZuEvkScDflWloTsmWmbvccPjBV13-jsUc55JE5>
X-ME-Received: <xmr:DXMCaS74X1WUUvJnER0oCrsdbMfrsQDhXeQ0cWIKcD-E8OeIIbg-cdWV-PnUVXyEFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieegieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkgggtsehgtderredttddtnecuhfhrohhmpeetlhihshhsrgcutfho
    shhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeevvdeuheeihe
    ejvdelgfekheefkeeiveefgeeljefgteelffehfefgvefhleekhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrdhish
    dpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgv
    ghhrvghsshhiohhnsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehvih
    hrthhurghlihiirghtihhonheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthho
    pehjrghsohifrghnghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhhsthesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgt
    phhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:DXMCaeIDDEApw9FIo_vc6aY3-FPUT4bccolILXVk7_TxOVN6N0vMTg>
    <xmx:DXMCaTuPNoxpit_-w0urIZO4xvlkIWaJJJWrewjO3JRPSk5JFbyEUg>
    <xmx:DXMCaVJs_Xq6_twvNzBGf2A8u_aeEPjpjNsgQUfDwiUingtUHXHXgQ>
    <xmx:DXMCaU-fhUxahQPSFErQz6HefjiOpECSKK3eZawpFegejnxQFa8B-Q>
    <xmx:DnMCaQsziutttIqtkgotQXFw_emIEgK8P8t-3hBdcdaJHSVMdrhOsH-3>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 16:03:25 -0400 (EDT)
Received: by fw12.qyliss.net (Postfix, from userid 1000)
	id D1FE153B67E; Wed, 29 Oct 2025 21:03:12 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 regressions@lists.linux.dev
Subject: [REGRESSION][BISECTED] virtio_net CSUM broken with Cloud Hypervisor
Date: Wed, 29 Oct 2025 21:03:08 +0100
Message-ID: <87y0ota32b.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Since 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support."),
networking in Cloud Hypervisor is no longer working for me.

I've narrowed down the problem to here:

> @@ -2555,14 +2567,21 @@ static void virtnet_receive_done(struct virtnet_i=
nfo *vi, struct receive_queue *
>  	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
>  		virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
>=20=20
> -	if (flags & VIRTIO_NET_HDR_F_DATA_VALID)
> -		skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> +	hdr->hdr.flags =3D flags;

It looks like this was added because virtio_net_handle_csum_offload()
looks at the flags from the hdr it's given, rather than having it passed
separately, but it appears something later on relies on the previous
value of hdr->hdr.flags.

From=20my tracing, hdr->hdr.flags is set to either 0 or
VIRTIO_NET_HDR_F_NEEDS_CSUM before this assignment, and flags is always
0, so in some cases VIRTIO_NET_HDR_F_NEEDS_CSUM now ends up being unset.

> +	if (virtio_net_handle_csum_offload(skb, &hdr->hdr, vi->rx_tnl_csum)) {
> +		net_warn_ratelimited("%s: bad csum: flags: %x, gso_type: %x rx_tnl_csu=
m %d\n",
> +				     dev->name, hdr->hdr.flags,
> +				     hdr->hdr.gso_type, vi->rx_tnl_csum);
> +		goto frame_err;
> +	}

If I change it to save the previous value of hdr->hdr.flags, and restore
it again here, everything works again.

Disabling offload_csum in Cloud Hypervisor is a usable workaround,
because then hdr->hdr.flags is always 0 to begin with anyway.

#regzbot introduced: 56a06bd40fab

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQGoGac7QfI+H5ZtFCZddwkt31pFQUCaQJy/AAKCRCZddwkt31p
FeMVAQCCcV1aIVBGzBul9zvWkrbJiqS36VHDAoAzy0bgDvXPHAEAwkKq/FTuMNe4
SIO7tqTHMwVVA8q3xx8FzeYI0YqqYwc=
=OdHf
-----END PGP SIGNATURE-----
--=-=-=--

