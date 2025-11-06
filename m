Return-Path: <netdev+bounces-236440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CC0C3C424
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 17:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38DA24E6A42
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 16:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEDF33509C;
	Thu,  6 Nov 2025 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOBYrVKJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B87A2E0934
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445146; cv=none; b=PXEWRtLyEcbc56zUwG7TvIzJFu7YEYWRex0JEYdGqNbRGwOF6TtC4M8XYH26p01riCQd1ZysKUyx+vDEEIp/Og01SZxPKJ68QDZbnfTe4vfpuTH557ZRdmnLyKEIpTD/cNRG9S94re20c13kSLNQr+cBM8KfhEFtk1fjIOA0UHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445146; c=relaxed/simple;
	bh=2XzFEQIosTqoRCGRFBzMqp/d9PqQjlhTqHGwa99fBRQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EnvnMjteXiyjD+iCB1CRWU3PsR/POwyXeakpVxU5LdQqJsz9/yMDCwmGFZW5eWh72Cj7rgXBPUyjlIin996zypA2mTqpnuUNkDbQ6pktx9tbVwnU3JkY3z5g0Z32XhrOPWRY5s6gIDMUYX/5g3P6eyMzPDC0bRttIRXlp3LsGCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOBYrVKJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29524c38f4fso15240135ad.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 08:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762445144; x=1763049944; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iV/5B6HmWeJyKHU1V2F6K7SftQouTs2fm0Ng6BYBU90=;
        b=gOBYrVKJ1Fy83iCOaqBuaXkwPEeInuYqyt1rGIS8QdzSCD6tpAm/hSX9Sl1QEx9ixZ
         Aww/9IIUjFSBLl3S4DHO2KOjN712hZ9lacrvL8h7yBLZdGauQNORHPXdWMBl0YWBY26S
         9PeHQfJciKD2dQD8Iayv4GFhmcXqTimNX9I1eMTxR//PBjbjMoe3rhbteUUJ17NTcryg
         K88tiw+yAryI3xVNYeRnDv+tGdNdTyShBeMwHmL6G198Pw4UI6DB86juuo9Tr8i2JHCt
         17ilyw10n7UI8+W00LURjJjiprgPeJM2FQxlsyRSniU14Lrt3036ZFb/Sn2ctPozbKwJ
         H3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445144; x=1763049944;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iV/5B6HmWeJyKHU1V2F6K7SftQouTs2fm0Ng6BYBU90=;
        b=gcgiJ9/u/TlfxnGwJX5EVFwuUMlb7VahQ7G4PlWUWQtXFlkpg2SJO0vfh2JfISD60y
         ej5mUwv2B0KBQoMfqqnZZd4P4l5UVHaJZcwqvuP0Q/JhZJSRLcJEuyDwvJsv/dqccyfK
         ln6Iux3a/vwk4ai4PCFSIgQAr/wGmppcaSYQgHYqv9p/SV9XELcdGU1kKtzW40+UMJlG
         uynwFj93TsPqvfFhW+zUjBUORQwX4SW0CfPZhWazIEB/NQl1OCSglja4a4vq16RDLqsy
         Q3rerg7TaR28Vs1fbeimXUfXHHcvS7dnlr1Iw4Q0geKmSgOnUmD1vffNdxUKjQw6QXZM
         LMnA==
X-Forwarded-Encrypted: i=1; AJvYcCUV5xR0/xpaMc8W5eSc13RA8dOnOZLL38bn0LNUz+18n06Pd5E4jG6+RVWW4yC2+FMN7lDU3es=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBmTd/nzCOarYaMQT7barX01PHMfJWsKmUU1QrXIUo36BMQs9x
	H9Yp+NG2toeE1ztZJIu6BpEUpt1M8PhcA1rYrm1uDXJt2hLH2+qEaO+q
X-Gm-Gg: ASbGncuwMI3jraCPNZhzcd16H/UxXkjHT//g2yjev/uLgdX7etsMBUq7bvoJ6n6gjwI
	Tn/LQO8Q2/Z6mnHVgr1M2Kb0RR4tRYkBZ7YWSl98En5l6KUqXG1rz1H5bFrrteWST3QZNKv84W3
	W6cySmn55eCJb1kD5v6iFE+s6TksBbANy75aCNOJGUGa1tTc4r4P5MWkY6Gp3JGjJ5ZYUkNlp8H
	YXNEBAOG9q5rXEiZTmjMupegWEyYyFJ8OF9LyUBhOZyGvegYmrBlJuAa/p3sYThCn9OU3XVn/+t
	sQ+I3Ild+b1SgbSuIYw9PX8IE2gB0kgRs4pqdejtrbqUlu68FwdAFtPJpDNy2H+uUVptojRWzxE
	yZwxOOprG0KnvXPYj6Pl1XwT6bPpRHQlTRp2W0dtqSaBjS2EAc5MmXnQ7VG0o3Zii8HkoewNc9j
	vbOuwg560fstiWeFvYU2G0V+vT8USEUFwe+qyZUvpFLkFna4y6pFFXq+Ypwo3O9snS4xuqtw==
X-Google-Smtp-Source: AGHT+IEaemxYcUh/ny7vD1Nzf+YP+qnuQ8bT2tLL0qWHMb/e7UfQ0N9sVifekzAIwlTS01QOSneeow==
X-Received: by 2002:a17:902:c943:b0:295:21ac:352b with SMTP id d9443c01a7336-297c03ac555mr252575ad.15.1762445144171;
        Thu, 06 Nov 2025 08:05:44 -0800 (PST)
Received: from ?IPv6:2401:4900:88f4:f6c4:12e8:f050:511d:31f3? ([2401:4900:88f4:f6c4:12e8:f050:511d:31f3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296509680fesm32629925ad.18.2025.11.06.08.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:05:43 -0800 (PST)
Message-ID: <00748f83a8ae688b7063f36844e38073d29b5e19.camel@gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v3] net: ethernet: fix uninitialized
 pointers with free attribute
From: ally heev <allyheev@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel	
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang	 <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui	 <decui@microsoft.com>, Aleksandr
 Loktionov <aleksandr.loktionov@intel.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, Dan Carpenter	
 <dan.carpenter@linaro.org>
Date: Thu, 06 Nov 2025 21:35:21 +0530
In-Reply-To: <575bfdb1-8fc4-4147-8af7-33c40e619b66@intel.com>
References: 
	<20251106-aheev-uninitialized-free-attr-net-ethernet-v3-1-ef2220f4f476@gmail.com>
	 <575bfdb1-8fc4-4147-8af7-33c40e619b66@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-06 at 15:07 +0100, Alexander Lobakin wrote:
[..]
> >=20
> > diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/et=
hernet/intel/ice/ice_flow.c
> > index 6d5c939dc8a515c252cd2b77d155b69fa264ee92..3590dacf3ee57879b3809d7=
15e40bb290e40c4aa 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_flow.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_flow.c
> > @@ -1573,12 +1573,13 @@ ice_flow_set_parser_prof(struct ice_hw *hw, u16=
 dest_vsi, u16 fdir_vsi,
> >  			 struct ice_parser_profile *prof, enum ice_block blk)
> >  {
> >  	u64 id =3D find_first_bit(prof->ptypes, ICE_FLOW_PTYPE_MAX);
> > -	struct ice_flow_prof_params *params __free(kfree);
> >  	u8 fv_words =3D hw->blk[blk].es.fvw;
> >  	int status;
> >  	int i, idx;
> > =20
> > -	params =3D kzalloc(sizeof(*params), GFP_KERNEL);
> > +	struct ice_flow_prof_params *params __free(kfree) =3D
> > +		kzalloc(sizeof(*params), GFP_KERNEL);
>=20
> Please don't do it that way. It's not C++ with RAII and
> declare-where-you-use.
> Just leave the variable declarations where they are, but initialize them
> with `=3D NULL`.
>=20
> Variable declarations must be in one block and sorted from the longest
> to the shortest.
>=20
> But most important, I'm not even sure how you could trigger an
> "undefined behaviour" here. Both here and below the variable tagged with
> `__free` is initialized right after the declaration block, before any
> return. So how to trigger an UB here?

It doesn't occur here. But, many maintainers/developers consider it a
bad practice because if the function returns before initialization or
use of `goto` can cause such behaviors.

Here though, the definitions are still at the top right? Maybe I could
just sort them

>=20
> > +
> >  	if (!params)
> >  		return -ENOMEM;
> > =20
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/=
net/ethernet/intel/idpf/idpf_virtchnl.c
> > index cbb5fa30f5a0ec778c1ee30470da3ca21cc1af24..368138715cd55cd1dadc686=
931cdda51c7a5130d 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > @@ -1012,7 +1012,6 @@ static int idpf_send_get_caps_msg(struct idpf_ada=
pter *adapter)
> >   */
> >  static int idpf_send_get_lan_memory_regions(struct idpf_adapter *adapt=
er)
> >  {
> > -	struct virtchnl2_get_lan_memory_regions *rcvd_regions __free(kfree);
> >  	struct idpf_vc_xn_params xn_params =3D {
> >  		.vc_op =3D VIRTCHNL2_OP_GET_LAN_MEMORY_REGIONS,
> >  		.recv_buf.iov_len =3D IDPF_CTLQ_MAX_BUF_LEN,
> > @@ -1023,7 +1022,9 @@ static int idpf_send_get_lan_memory_regions(struc=
t idpf_adapter *adapter)
> >  	ssize_t reply_sz;
> >  	int err =3D 0;
> > =20
> > -	rcvd_regions =3D kzalloc(IDPF_CTLQ_MAX_BUF_LEN, GFP_KERNEL);
> > +	struct virtchnl2_get_lan_memory_regions *rcvd_regions __free(kfree) =
=3D
> > +		kzalloc(IDPF_CTLQ_MAX_BUF_LEN, GFP_KERNEL);
> > +
> >  	if (!rcvd_regions)
> >  		return -ENOMEM;
>=20
> Same here, @rcvd_regions is initialized before the very first return, no
> idea how one can provoke an UB here.
>=20
> > =20
> >=20
> > ---
> > base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
> > change-id: 20251105-aheev-uninitialized-free-attr-net-ethernet-7d106e4a=
b3f7
> >=20
> > Best regards,
>=20
> Thanks,
> Olek

Regards,
Ally

