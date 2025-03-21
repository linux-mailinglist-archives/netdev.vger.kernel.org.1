Return-Path: <netdev+bounces-176790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35295A6C264
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 19:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98FEF48356B
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 18:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D28A227E89;
	Fri, 21 Mar 2025 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqPSKHRK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6141A22F16F
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581844; cv=none; b=cGhe6IzoVVc8z1USpCedhOzphNvyEnLenawu+UBWOF7N2Es5fzAp44okL8J9eN94PKetbOfkVw8kWgo51Lebjjw0UUahaeXonyO0CK+wZ1AbwaQ8mWjVDpx1M6CF8w/Gw/xJL5tGMoOzZv8Opdxu4/UB9Fc+dZkzWMBkxaD34Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581844; c=relaxed/simple;
	bh=POaaDDx+6VKUN16QFd1u0FiLETpRwgak0JQ68zTB+fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkqhkkJt/h52gOgiyZDZV+c/o3mBAFm2jQp8oFlf43NWG1t4u1CWJ3SKnxSRJRWs56/TXPjNggqdfY7oSr1V8svDKPFzDqQMVc5Ijo0RnnvXUTCbRqFq5g0HoABigm8dCf5mkvV1/95OUHT8i9Caesgh4kA6i/eerWxCAkSGVZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LqPSKHRK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742581841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TCYnaCr6t2CITiy2CVtW2Iw29QsHSOWYrJlCz4eX7VE=;
	b=LqPSKHRK8vzB4E7gY6AEigdMG+1NH+Ohm8Te2BZNOcqn3cWLOIR2PMiAxVAknvP2dhzFjG
	oCNCBejJeC0IvhBYFjgJZLYeVMJ5Wj/x7OWA0emcTaxzWhGFnDVkrJxLu971WTbu51BIoN
	Xr1RnOyfpOQ4ttxtYk8lvhoY8qRx0Y4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-PY9DOpGlMUmgsO_mBbiMKw-1; Fri, 21 Mar 2025 14:30:39 -0400
X-MC-Unique: PY9DOpGlMUmgsO_mBbiMKw-1
X-Mimecast-MFC-AGG-ID: PY9DOpGlMUmgsO_mBbiMKw_1742581838
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf327e9a2so18828615e9.3
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 11:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742581838; x=1743186638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCYnaCr6t2CITiy2CVtW2Iw29QsHSOWYrJlCz4eX7VE=;
        b=cnlnzSfOgM93M4/o+VSqjikBZfVQOIBFGy2Vk2nJmdNFPFIKo0SfDG9fJunpuQmi4U
         Cx1cmNUSAN1hzQ7OQQThNawystj/Kd/2aJDthPjJ5iO+egK4GPPB1VMZWTMyIDZkxXzg
         ig2IuPdT6LhJax44yEFGfhAV70R2ng9sEpVGAi93fH+Y6c0ILNk4cYAp6CZ6NtZsA+E/
         eKzC+u8gKcDSbDs59G4bAbz1L8Uun/Dyj0/pdIv62Q8qNJUdqJtD6AJSBkQbWh9uiZFJ
         e36/mV5Ke+dG+GXYSC4+wLZVoJVRN3TnkN01bm0qCDSNtR6Ti433C3a26g0P7PyrWuS3
         Ab9w==
X-Forwarded-Encrypted: i=1; AJvYcCWD/MWIMWb5gB4yeasX+2p458EK1Uy90t7m3OVPkucWjJgEwZtUbwBW86lfNTGERtdqHEIKd/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQWpuF+U0ucD4kvlHmDxqNiCMHLw9IDGRwLzDbEigxh4wbptCo
	7wJlk5R7Rl8qHtUqZDaoF+f9imYusP7d6YO1eN+y6xfKJm/a7JVyiSJYr97zfvT7UujU5Rj2pCT
	HFY14GRL+TMjj3OLCjbKzn9JRgRELZE2TX9ixBKlM2yq/CHxh4u8+Tg==
X-Gm-Gg: ASbGncs8w8Elv5mdxABJwPxKN8MxC4SSY0rYURHfw1u393VAToukQwW6UwMFLdS256A
	2kKlxKtl+LOMhR82qX3Kb2Gq0qNv7bjVzPCOD1AZEG+pVhAva4xyAc2uJrjwBvzW3u3n0ZxhH6G
	VSb1ff7Q3UZeibP83yKheNgJ0togIhZYt4uh15YemP9VmGSNEYjglQ09NVDL1M/kTwQFtVTxKEM
	Xxrhgq9vdiVQwcakJxK9QPaDUGkW0aEnPUvDzmS7x14M/9tUt11H7JknzjEzoGZ82h9wloaar/K
	Fzha7EnUbBjsrSO4TdFszwkzylSHmVO162TUf5QJBptqf3hoy2UdE3Ze21DY5VU=
X-Received: by 2002:a05:600c:331c:b0:43c:f332:7038 with SMTP id 5b1f17b1804b1-43d52a8ff41mr16399575e9.21.1742581838134;
        Fri, 21 Mar 2025 11:30:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV1J4g5vZeaiZX63RdE3knu8eFnfAyikgZWs5oJe594PE0zRqxZLu0vVxmRdyWaSppnlnHbw==
X-Received: by 2002:a05:600c:331c:b0:43c:f332:7038 with SMTP id 5b1f17b1804b1-43d52a8ff41mr16399465e9.21.1742581837658;
        Fri, 21 Mar 2025 11:30:37 -0700 (PDT)
Received: from localhost (net-93-146-37-148.cust.vodafonedsl.it. [93.146.37.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd26cecsm33890485e9.17.2025.03.21.11.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 11:30:37 -0700 (PDT)
Date: Fri, 21 Mar 2025 19:30:36 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: airoha: Validate egress gdm port in
 airoha_ppe_foe_entry_prepare()
Message-ID: <Z92wTGu_Sp9VnqPf@lore-desk>
References: <20250315-airoha-flowtable-null-ptr-fix-v2-1-94b923d30234@kernel.org>
 <b647d3c2-171e-43ea-9329-ea37093f5dec@lunn.ch>
 <Z9WV4mNwG04JRbZg@lore-desk>
 <2d39033d-0303-48d0-98d3-49d63fba5563@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+vQwyXtwdSXuM5kh"
Content-Disposition: inline
In-Reply-To: <2d39033d-0303-48d0-98d3-49d63fba5563@redhat.com>


--+vQwyXtwdSXuM5kh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 3/15/25 3:59 PM, Lorenzo Bianconi wrote:
> >>> Fix the issue validating egress gdm port in airoha_ppe_foe_entry_prep=
are
> >>> routine.
> >>
> >> A more interesting question is, why do you see an invalid port? Is the
> >> hardware broken? Something not correctly configured? Are you just
> >> papering over the crack?
> >>
> >>> -static int airoha_ppe_foe_entry_prepare(struct airoha_foe_entry *hwe,
> >>> +static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
> >>> +					struct airoha_foe_entry *hwe,
> >>>  					struct net_device *dev, int type,
> >>>  					struct airoha_flow_data *data,
> >>>  					int l4proto)
> >>> @@ -224,6 +225,11 @@ static int airoha_ppe_foe_entry_prepare(struct a=
iroha_foe_entry *hwe,
> >>>  	if (dev) {
> >>>  		struct airoha_gdm_port *port =3D netdev_priv(dev);
> >>
> >> If port is invalid, is dev also invalid? And if dev is invalid, could
> >> dereferencing it to get priv cause an opps?
> >=20
> > I do not think this is a hw problem. Running bidirectional high load tr=
affic,
> > I got the sporadic crash reported above. In particular, netfilter runs
> > airoha_ppe_flow_offload_replace() providing the egress net_device point=
er used
> > in airoha_ppe_foe_entry_prepare(). Debugging with gdb, I discovered the=
 system
> > crashes dereferencing port pointer in airoha_ppe_foe_entry_prepare() (e=
ven if
> > dev pointer is not NULL). Adding this sanity check makes the system sta=
ble.
> > Please note a similar check is available even in mtk driver [0].
>=20
> I agree with Andrew, you need a better understanding of the root cause.
> This really looks like papering over some deeper issue.
>=20
> AFAICS 'dev' is fetched from the airoha driver itself a few lines
> before. Possibly you should double check that code.

Are you referring to airoha_get_dsa_port() routine?
I think dev pointer in airoha_ppe_foe_entry_prepare() is not strictly
necessary a device from a driver itself since it is an egress device
and the flowtable can contain even a wlan or a vlan device. In this
case airoha_get_dsa_port() will just return the original device pointer
and we can't assume priv pointer points to a airoha_gdm_port struct.
Agree?

Regards,
Lorenzo

>=20
> Thanks,
>=20
> Paolo
>=20
>=20

--+vQwyXtwdSXuM5kh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ92wTAAKCRA6cBh0uS2t
rL/MAQDcn4FFF3wmkVqDFXlch5Wj9+r8ZXCL12r0CY8mcPZm1gD/UWZra+6Q2LlQ
dfGzn/9YsTjGEJxgAcx5ERuOnJ7eBQQ=
=/fph
-----END PGP SIGNATURE-----

--+vQwyXtwdSXuM5kh--


