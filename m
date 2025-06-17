Return-Path: <netdev+bounces-198809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D98FADDE4C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485423B907A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266E429293F;
	Tue, 17 Jun 2025 21:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GuPdFl+G"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E0B288CBE
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 21:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750197421; cv=none; b=AaEPBv7H2+mrj+B2XSVZ08NXMRBzGaZCfhy4c/r/MwFi6hg3pgW4/em4lioATbIoVsKie9kdPgcHkjrQ2Y/7oCHf3iYC2kYCF+Tx/+1w/uDwrstdOkl61npyw7WwDh503R75cJAy/CK/ZbMaIObiNBMNWB22PKOktPli93M7lRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750197421; c=relaxed/simple;
	bh=Kp9DI+2v2LShpJweRToRLsuNXfdRv2B57tjdewX2aF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgEa6JxNC8kwJYi2UaDR2jyKnbQAKE8Y+cPEyiSiN3XappD0mBUxWNZNhWgMz4amyUKFZ219Q+OZe9Rggn472VFUJoZYWplID8RKzd6uPRDNGUtx9mrNxcK+VI4/4gtX5ENl14yYdPMhzRj4Adin+bl23WwTC3TfNXNjjk6md14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GuPdFl+G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750197418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8MAberZB82Z3SmBMhm5B8kfRhyx/yzqVg3f57rHIguU=;
	b=GuPdFl+GD7Q3qeNT28yDMcDUOssUSUpk0KC11paSI2J535vObkhG2ocg3Kfxd6uyflOS/d
	DFMQvr23Mx+dg3Zzz9vYk6wSu/SDyoawoKo2LqwAR3u/sVumGYjSn0XY4cNKsj/7J33l+5
	wIfWAihfrsDE/ERcYLPSariRJKqHzqU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-bJLoURv0OW6013eF0sGQBw-1; Tue, 17 Jun 2025 17:56:56 -0400
X-MC-Unique: bJLoURv0OW6013eF0sGQBw-1
X-Mimecast-MFC-AGG-ID: bJLoURv0OW6013eF0sGQBw_1750197415
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4e9252ba0so3132933f8f.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750197415; x=1750802215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MAberZB82Z3SmBMhm5B8kfRhyx/yzqVg3f57rHIguU=;
        b=up8l/6Ivz0mZUHzFPeLCi3+FbATZth0SNRjj9BBnvCRqIi4Wn8oRMzEo4jS0S9dwtM
         UtoysIkqegcffX2exwDHdD1AWxpD5yZLOuuZc4NaMjJe2F3y9RKiArZVNTcUbP6KjGe1
         EVAt8Q1uKrhMw9POcBC3qNEmibJN1ZvxAPHHK9VmGtlmG04AlAcNwMCtc2DV+tfC4IHF
         WB//Pis2YU1r5om073HwFMArrRq3YVNmNFJstNm/ZvGwnqPdNjrYsNfgZL287nnXJ4pU
         iyZdklL4rSVPfzaq3bGdjAxYsAoPXvQk1SX41+Jein2ogUjRx4HkcOZE4jdlOfxea7C8
         PrXw==
X-Gm-Message-State: AOJu0YwXJ5AbIsmCZFYENrLk9GrkBe9ktwO9fvwYhoX5WsXrzpmhUSOz
	kUDAZknM3TqAamXtoZF+qrqFbWC9WZSR4hRZOT/Nr2pK28xwvQU8qbtW6xq0z0Px+/6vpNsKe0S
	ccS8J4pByZpWEpLsVrNR7NRQGm3GL8l9Axx77FhPUmHlRoEAA8ZTy4zNqdw==
X-Gm-Gg: ASbGncu8YcHdiGvfrYN2t1P/3zdmW9b6ttQ7ELPpTGrU0uEX2I8JKNARJjxQXKIhiLJ
	0NeUZFXGmqqcYimtZaH/fDMCd/aPFov3RcXLk6rwJRy7c2GkB9QImBZoVsctmWMidgk+a9mdpq+
	HBI5xd33zBfbTXXIFP1pJnvDbLEj1HzCm5/tsom0U1+ernXdYk6dY7b6nyZu0DYzHxbxrzAhWQ2
	4Dg7HiHHWthLWIPo5Et9T60/aHNmZ4I00VoTvWLe4DW8lsL6EX9+EWwzxLMiqmzU7Hl5buLoZ4y
	E/BT2W8MvNVIeu9uoDg/+pWHVky2P0zwcllDfzkAMzxRChqN16mhxsJLXlZGeYr1kxhdoQ==
X-Received: by 2002:a05:6000:25e9:b0:3a4:d994:be4b with SMTP id ffacd0b85a97d-3a572367d55mr11055136f8f.1.1750197414923;
        Tue, 17 Jun 2025 14:56:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiebOmEYk+uqov68RgYSGzETTCjeLdec14dBe0riZts1tKLupIn7pTXi12Ct4usn7f1R5b6g==
X-Received: by 2002:a05:6000:25e9:b0:3a4:d994:be4b with SMTP id ffacd0b85a97d-3a572367d55mr11055124f8f.1.1750197414493;
        Tue, 17 Jun 2025 14:56:54 -0700 (PDT)
Received: from localhost (net-130-25-105-15.cust.vodafonedsl.it. [130.25.105.15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c4e8sm184972735e9.3.2025.06.17.14.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 14:56:53 -0700 (PDT)
Date: Tue, 17 Jun 2025 23:56:53 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linyunsheng@huawei.com
Subject: Re: [RFC]Page pool buffers stuck in App's socket queue
Message-ID: <aFHkpVXoAP5JtCzQ@lore-desk>
References: <20250616080530.GA279797@maili.marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oKdl6g1Fns34EoZE"
Content-Disposition: inline
In-Reply-To: <20250616080530.GA279797@maili.marvell.com>


--oKdl6g1Fns34EoZE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi,
>=20
> Recently customer faced a page pool leak issue And keeps on gettting foll=
owing message in
> console.
> "page_pool_release_retry() stalled pool shutdown 1 inflight 60 sec"
>=20
> Customer runs "ping" process in background and then does a interface down=
/up thru "ip" command.
>=20
> Marvell octeotx2 driver does destroy all resources (including page pool a=
llocated for each queue of
> net device) during interface down event. This page pool destruction will =
wait for all page pool buffers
> allocated by that instance to return to the pool, hence the above message=
 (if some buffers
> are stuck).
>=20
> In the customer scenario, ping App opens both RAW and RAW6 sockets. Even =
though Customer ping
> only ipv4 address, this RAW6 socket receives some IPV6 Router Advertiseme=
nt messages which gets generated
> in their network.
>=20
> [   41.643448]  raw6_local_deliver+0xc0/0x1d8
> [   41.647539]  ip6_protocol_deliver_rcu+0x60/0x490
> [   41.652149]  ip6_input_finish+0x48/0x70
> [   41.655976]  ip6_input+0x44/0xcc
> [   41.659196]  ip6_sublist_rcv_finish+0x48/0x68
> [   41.663546]  ip6_sublist_rcv+0x16c/0x22c
> [   41.667460]  ipv6_list_rcv+0xf4/0x12c
>=20
> Those packets will never gets processed. And if customer does a interface=
 down/up, page pool
> warnings will be shown in the console.
>=20
> Customer was asking us for a mechanism to drain these sockets, as they do=
nt want to kill their Apps.
> The proposal is to have debugfs which shows "pid  last_processed_skb_time=
  number_of_packets  socket_fd/inode_number"
> for each raw6/raw4 sockets created in the system. and
> any write to the debugfs (any specific command) will drain the socket.
>=20
> 1. Could you please comment on the proposal ?
> 2. Could you suggest a better way ?
>=20
> -Ratheesh

Hi,

this problem recall me an issue I had in the past with page_pool
and TCP traffic destroying the pool (not sure if it is still valid):

https://lore.kernel.org/netdev/ZD2HjZZSOjtsnQaf@lore-desk/

Do you have ongoing TCP flows?

Regards,
Lorenzo

>=20

--oKdl6g1Fns34EoZE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaFHkpAAKCRA6cBh0uS2t
rJciAP4kr3mXRHurFuZcWturaTMGISYAguYrukCV8U9yWHjsAgD+MxhlvONcverh
W/NGSNtKhX38Yr5Ys0hqEb1xMzSGjgI=
=Y9Ae
-----END PGP SIGNATURE-----

--oKdl6g1Fns34EoZE--


