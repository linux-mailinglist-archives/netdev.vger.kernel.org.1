Return-Path: <netdev+bounces-234380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CFAC1FE77
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 13:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA24A34D851
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 12:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B813002C1;
	Thu, 30 Oct 2025 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="QBtxjQNr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uN/JOSbo"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0048F2E0415
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825638; cv=none; b=Lt3lBXd8BXda7I76V9JCeb8zOmT1HGmqtR5f0TmYNPYP9iSVhBvOOzmfxghRIMMg7l1mgjyQga+24RRdntPmSJugdWJ9/90UsyiJxi65ynO0i7Yk0tUMlqNB1NA/X9Vw2jBT1QjJA82kAjW8C4hmCdGsM2yrpSN0zxVycRYQW2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825638; c=relaxed/simple;
	bh=lxKECbHONxEfh+uepSlivY+rDgIROzH5SW0S9XXEFKY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QU71N6sDvK9mZKHfxR+1vBk9ZUTeTV83s8irZd7Liq37GEioU13NGNpavJDxR5Ur1yVTDQT7Sis6RwOksiN7iqCZu6p5xnSnRtRC7tY3G0PhavMaPDP2Ql5eg827OWqZwq4TaSo6JHb52HzRIFR+7AMJDuZ+iFvXaWKOeyYHu+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=QBtxjQNr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uN/JOSbo; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E81087A00EC;
	Thu, 30 Oct 2025 08:00:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 30 Oct 2025 08:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761825634; x=1761912034; bh=BqX5Vn+FAN
	lCndnwOlMnd00xB8BKUwdZpfARoXmVKUE=; b=QBtxjQNrDy807pw1Fh2iWrtr19
	w5zbArR6JNvNwzJ9nTCMujdg+flh96D3eDafenW/bdG1LnfC2fvncYwpNrTDCPLg
	Yh1FDOO/ZJuLkAAED5kJ5+aAkQqZ5QFI4V64QZflR8hql9595Lx0+OAzf43aeBjo
	8CAxdq0ks1Xi0K8THqrmmoDsYh/8hSEcxOuzl79ybSDfWUsiUS7QdM7u8Wc/zJDE
	q/515ZHxKkOpHCY4CA4FvJmsdsdtpFqO0jaWjYXyBIROyJwvmPURDqYLSoL5a2CQ
	qF17wPxvDgnuZCkcYFf4llqOvC80P2j2FhM2HZ0BdQiLj2t+ZG+NYH6VSzOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761825634; x=1761912034; bh=BqX5Vn+FANlCndnwOlMnd00xB8BKUwdZpfA
	RoXmVKUE=; b=uN/JOSboyappqibGCFuhO263oJxVzJElAMM8sy41DjOZU0PJlHi
	ObNPRLBFno+gL1V2h5MwDanjx/6Wbp96O/9/v21zjcJ6AhzG1O7DAiJwGx/PpFtW
	V4Lq8fZoLAmIG1JlveqMsBQ7+h+YZ1+elRJtYExPH06W17Pl+G4s9RMkwSPFm7T9
	hgmb5Ma6IJJIe9y/jh/Y4yOGX0v8HqpQ0ljmnYt4XQjhpLGydSDQFDCJVQwhunOu
	sI1Kk3A5ikq41ff3IoBzf4PALLtDkwsnf6i7vPby5OuO9G/BhsecnRp5RJuFlGU9
	FA0uE5GCVgyOlRKhwvPh+xBoX+r9q1lElKg==
X-ME-Sender: <xms:YlMDaa7SKXs8wsI2RNFh1v9dcowi74Gg9lZ9rCxouHcrd-H7DhahCQ>
    <xme:YlMDae0mr6-8_7-5KI-IikuyynYGMkNbIiRr56n_I9ozPdx2OgkYR-sOVlHhNZ2vP
    Hd3UOEyZJOTxW47_rQOOYmehef8yvAjWk4Hnz_dbDD2tf4-2sispA>
X-ME-Received: <xmr:YlMDaYf3EKEXfMyyblERUAT6yf2Nvcd9BjLjd3baEInG0Lr_hNTH2rn1zyPFAWJWPAY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeiheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkgggtsehgtderredttdejnecuhfhrohhmpeetlhihshhsrgcu
    tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeefhfejhe
    fgledtleefudduvefggfduuedugfdvjedvieekhfejffdtieehgfeiveenucffohhmrghi
    nhepmhgrrhgtrdhinhhfohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehhihesrghlhihsshgrrdhishdpnhgspghrtghpthhtohepiedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgvghhrvghsshhiohhnsheslhhishhtsh
    drlhhinhhugidruggvvhdprhgtphhtthhopehvihhrthhurghlihiirghtihhonheslhhi
    shhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjrghsohifrghnghesrhgvughhrg
    htrdgtohhmpdhrtghpthhtohepmhhsthesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    phgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YlMDacey3hMvra4dqrhxNpFhfjRIpwbOVQLuzrmwPtOqhHRBeZdMRg>
    <xmx:YlMDabzEKNeFOJTba8B1nQ87_Oewy3pfkoJxLQf6UomLxwBjzyN0BQ>
    <xmx:YlMDaT8aHDG-KZtBmWY4C-PZnXxAYisWxa60geJRjt8CJsAJ11kBbQ>
    <xmx:YlMDaTibVETKl4fVbPoMH9O677T0qizKPEMwSShyUlFrmnIqoWKhmw>
    <xmx:YlMDaQw9Mu4-9zE867NkVWdDFkvIEarY4IE4Y-5gmBKuYQAqbpcBShmm>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 08:00:34 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 04B6F6205407; Thu, 30 Oct 2025 12:48:51 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Jason Wang <jasowang@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 regressions@lists.linux.dev
Subject: Re: [REGRESSION][BISECTED] virtio_net CSUM broken with Cloud
 Hypervisor
In-Reply-To: <CACGkMEuTnLX7EPuOLb2UhrZT2oH2AcXPQrvq-uw2ZydYV_FAgQ@mail.gmail.com>
References: <87y0ota32b.fsf@alyssa.is>
 <CACGkMEuTnLX7EPuOLb2UhrZT2oH2AcXPQrvq-uw2ZydYV_FAgQ@mail.gmail.com>
Date: Thu, 30 Oct 2025 12:48:43 +0100
Message-ID: <87v7jwwqxw.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Wang <jasowang@redhat.com> writes:

> On Thu, Oct 30, 2025 at 4:03=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
>>
>> Since 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support."),
>> networking in Cloud Hypervisor is no longer working for me.
>>
>> I've narrowed down the problem to here:
>>
>> > @@ -2555,14 +2567,21 @@ static void virtnet_receive_done(struct virtne=
t_info *vi, struct receive_queue *
>> >       if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
>> >               virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
>> >
>> > -     if (flags & VIRTIO_NET_HDR_F_DATA_VALID)
>> > -             skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>> > +     hdr->hdr.flags =3D flags;
>>
>> It looks like this was added because virtio_net_handle_csum_offload()
>> looks at the flags from the hdr it's given, rather than having it passed
>> separately, but it appears something later on relies on the previous
>> value of hdr->hdr.flags.
>>
>> From my tracing, hdr->hdr.flags is set to either 0 or
>> VIRTIO_NET_HDR_F_NEEDS_CSUM before this assignment, and flags is always
>> 0, so in some cases VIRTIO_NET_HDR_F_NEEDS_CSUM now ends up being unset.
>
> Are you using XDP, if not there should be no change.
>
>>
>> > +     if (virtio_net_handle_csum_offload(skb, &hdr->hdr, vi->rx_tnl_cs=
um)) {
>> > +             net_warn_ratelimited("%s: bad csum: flags: %x, gso_type:=
 %x rx_tnl_csum %d\n",
>> > +                                  dev->name, hdr->hdr.flags,
>> > +                                  hdr->hdr.gso_type, vi->rx_tnl_csum);
>> > +             goto frame_err;
>> > +     }
>>
>> If I change it to save the previous value of hdr->hdr.flags, and restore
>> it again here, everything works again.
>>
>> Disabling offload_csum in Cloud Hypervisor is a usable workaround,
>> because then hdr->hdr.flags is always 0 to begin with anyway.
>>
>> #regzbot introduced: 56a06bd40fab
>
> Is mergeable rx buffer enabled, if not, I wonder if this can be fixed by:
>
> https://marc.info/?l=3Dlinux-netdev&m=3D176170721926346&w=3D2

That patch does fix it, thank you!

#regzbot fix: virtio-net: fix incorrect flags recording in big mode

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCaQNQnAAKCRBbRZGEIw/w
ohOQAQDLxZuMcKYN0k3GnM3RqtAZlaIoeA/1DoR+5ysX5/GVOwD9Hu8Nskv7B5H8
NgvMbITEXcfnNVlo/+iQCswKTUUMYwA=
=WiqU
-----END PGP SIGNATURE-----
--=-=-=--

