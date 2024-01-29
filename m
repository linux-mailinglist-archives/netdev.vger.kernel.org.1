Return-Path: <netdev+bounces-66712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B0184060D
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 14:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5B51F2471F
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 13:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9F362804;
	Mon, 29 Jan 2024 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YAA9dVaT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D43633E0
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533525; cv=none; b=NVaDGfB0OvfrAJUvqiLRbdelje4mLvWpAV8Mu9K634dupmM9qySmGdXAHJi3HithciJDygYql3MR1nKttNjuMHvnUnrJXHXiwzeM95WneKuBpMDMJLo1YfvqQ/jYZyTT5Rkv04462GZPF4noy78yMYMyeZ6acUNgtd3CkkdmeBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533525; c=relaxed/simple;
	bh=jhSXJBAa4IAI3G0hqBJhMzYpQuBKW9LSRNp5pHW1sMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOr/PWSK+IAypLfsbPvaBLpfisd3+nv6XNiA/nai3g2Fqhi0fGzrHWRqVVXHc2QY5yV//x9B5OY1jkaF6pKKbtI5qPOFZAyC3IE6KOSz5wLw27M2qOhWQT/IAvnOfNIo+x2Y1c+sPqccBQ/Wbv8DQOdSWV0WceSxe25bAko8P3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YAA9dVaT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706533522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jhSXJBAa4IAI3G0hqBJhMzYpQuBKW9LSRNp5pHW1sMw=;
	b=YAA9dVaTuWzMOlE2ogYJtKB7NQCGIF29MS5DXbJ/iwUzzXwjwf6Sg+pOnF1xhhjc4Xk0Pt
	Q413XuBAY+rJwY61FCYp5c/oldcwKHruCSn1lytQV3w6HFjji5CSHhpICI/vjV3KGE+6/p
	+S/D6YFiKALnTzb7yHDIVobTQWcumI0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-8ItPQLQqNuCcFF-QcB9t6Q-1; Mon, 29 Jan 2024 08:05:17 -0500
X-MC-Unique: 8ItPQLQqNuCcFF-QcB9t6Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-339250f6515so1109495f8f.2
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 05:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706533516; x=1707138316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhSXJBAa4IAI3G0hqBJhMzYpQuBKW9LSRNp5pHW1sMw=;
        b=T4AdHHQT14WW6uxG9tshh9a/VrjITizxQMQ4NBWv5rTHF7QPI3AtlbLkArEj0FU9Mr
         TOCkIsnvqTiXODPWat5Envmz+2Dgh8aSJ4A6W9pydbAQO007D8mtiDWtkgsPzv2KS2Ns
         +OXB7cyOAhUmdVG5943nrwWfrFmnXfOI874Le6HKuCptMgXkosEPuwlgTEGSIgse7qyG
         bswb92Mbn7mvpxVvVgc54UZSUsENr9/MaJ0wbTiXKHW7d9VQYY7/falWGSin/I9XktWy
         PHbDdU6elL81b/qXTXTW8J4A7Y7PE7Mx1t65jozLfXRiYwFyhmfZP7Gju/MCoE1Tl+pc
         +uNg==
X-Gm-Message-State: AOJu0YxX0JZiJgxmemkUpWq0Lq8M+r0PJMv4+xkqhwG2yXijtdLn1CMX
	pC8O+/IDrlplvtM48l+DQSyhpe3LxRYsmPB1bVl7ks4b98HSpbZiquEYTG3OaxH86W7b8QCauNp
	n2MIl2RM5g0TDPOzQQxJeZb8tRwSRfQB0J36u0y693LlPPIn2MHVtyw==
X-Received: by 2002:adf:ea51:0:b0:33a:e89f:1dc5 with SMTP id j17-20020adfea51000000b0033ae89f1dc5mr2668839wrn.23.1706533516564;
        Mon, 29 Jan 2024 05:05:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGU83hZ2kx/bGUSTN6uw3JgXRUj/C6gYltlkxClcBEqa8p9rlT/xqzClncFGJThJD88kRnF0w==
X-Received: by 2002:adf:ea51:0:b0:33a:e89f:1dc5 with SMTP id j17-20020adfea51000000b0033ae89f1dc5mr2668828wrn.23.1706533516337;
        Mon, 29 Jan 2024 05:05:16 -0800 (PST)
Received: from localhost (net-93-71-3-198.cust.vodafonedsl.it. [93.71.3.198])
        by smtp.gmail.com with ESMTPSA id c17-20020a5d5291000000b00337d980a68asm5721310wrv.106.2024.01.29.05.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 05:05:15 -0800 (PST)
Date: Mon, 29 Jan 2024 14:05:14 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, bpf@vger.kernel.org,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	sdf@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org
Subject: Re: [PATCH v6 net-next 0/5] add multi-buff support for xdp running
 in generic mode
Message-ID: <ZbeiijYT0ZodYq4p@lore-desk>
References: <cover.1706451150.git.lorenzo@kernel.org>
 <87msso1f9e.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QapcWhyXNDEADOc1"
Content-Disposition: inline
In-Reply-To: <87msso1f9e.fsf@toke.dk>


--QapcWhyXNDEADOc1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > Introduce multi-buffer support for xdp running in generic mode not alwa=
ys
> > linearizing the skb in netif_receive_generic_xdp routine.
> > Introduce page_pool in softnet_data structure
>=20
> This last line is not accurate anymore... :)

ack, I just copied it from v5. I will fix it.

Regards,
Lorenzo

>=20
> -Toke
>=20

--QapcWhyXNDEADOc1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZbeiigAKCRA6cBh0uS2t
rLRSAQDLhngsfTJ/SkubtC4AZWQp8GJbJge2crWzr7Bday/t1AD/Z7x2KgJQgCnx
R3gJ2Z0WLiPby+RIC7SQmLmT9l/YXQ8=
=aIyH
-----END PGP SIGNATURE-----

--QapcWhyXNDEADOc1--


