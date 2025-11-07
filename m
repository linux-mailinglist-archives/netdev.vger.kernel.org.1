Return-Path: <netdev+bounces-236667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9DEC3EBEA
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 08:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A278E4EA813
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 07:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B863081B1;
	Fri,  7 Nov 2025 07:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHF4IDjh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0646926462E
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500449; cv=none; b=c1UZdjlay5L31jEWVonxs3TXzFNy79gsjSopVZXYQLwgHQIVTjDVQWvnNoEuvWH3QZe1wV/PUrTLO7leRJVR0qf0AhZM4Jla1Esw567h4mZ+zNKMl8l00m73T1rx30Lsx7Y5sLh4s9fAHhSr0zNpguv1/uh66yPD3F3Z6zNAv3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500449; c=relaxed/simple;
	bh=edsvEsw+C1MkNyld9yt/hW0PhgdDYzpXUwgbBvSlq6g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jLfSf9P6t+LU/P9vooJnCG5K5MxFSdz+QKyunr8T1lpBk6d/PzBI6gpGOjtW1pEcSxws3LSbpqHoXRoonlT6Bdt1mAFDFotNy/UNbi+1XAG/XogkEAcyw/eorbrJStw3HWZh6qdkL2RPwSxN5XDswQOKIfRBm0kxfdflZVtrC3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHF4IDjh; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7810289cd4bso465759b3a.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 23:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762500447; x=1763105247; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pm6klTaX1rSZ57/FJIJfQv26XKgYx42g4E8YZTbf4DA=;
        b=gHF4IDjhEUMy2siJcRdjGn/KF3mc3h2xbscek/d37AOWSrKcPyvuNehfJKDyTL9O7y
         4JbIPlaJzEyLXeyDB1FyJmE4GnCt1mf/r+tmNxXCjWkxyto7n70uEMlQnbavsG4+oZTb
         8ULYYaVWLFPB/fuscNYNLQvaGi3er3iAxUrqXA2YdGIgZHrp4FLUfNkdfJDPz6uneGMN
         qBd1twCvwF++thjSSeKsT7IpYhMzdQ18OvqWUbIy76swfmMke+MWznc4GaGcurkGkgTm
         64gfhFy9U/3O2qiUCmr2tk08Q/wx06WmdcBG/kjHWOzDwNjAS5DzWmSsOk2uV1u7+vcb
         Fowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762500447; x=1763105247;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pm6klTaX1rSZ57/FJIJfQv26XKgYx42g4E8YZTbf4DA=;
        b=OWYJRk4x0hhZTwMrCQr2O60iys5y/ReNMTa8o8ArzBxXLtPU2sNoVuDgLyI1K6BqCj
         +s6CpjMUUwsSmK/XH15m+erWi5w2YxlMZcfsUeKdzyqc5u7fytprNPb6Q++NbvanjsVv
         cZZkFi7OF0xIjMQaNU0gledAnkPpJfbFQi0YyzlsqYIbUSLFeyVhPhiPkaxq1gBE/zgh
         Lc8j29yQ0B0PZZdPpfMG4HYH8MNgC3PINElbg6MpjxYG3qZfNnAofJ1v6VYEu86VnuE6
         J+iNIydnWT18cXuEu2UMjR/Q5GauR+tK2/C3nssj1rrBnRYw4JkcOJJqfhoU2faz0/kL
         vNzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO6DjasrxVABAWPUM5jyAbapXs2kWnB2JgOqfkhEn8kehXqZEWrHPtscBO7BF7FxSaO+09UvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhtMQrEDk054iHbuHg/C/xlaLYLeYkyeGrpFm4kdKC+VdZ1b05
	4B3IcR7Ewx/UQrPjjV9HfrSkBiDeBdgrSWJ+ec2bCFu1LsUUZfAEZunf
X-Gm-Gg: ASbGncsJcpSOwBHDrdAOM32ymVWxQRpFNcRKSNtmHm/igZlpjAyGaIkLLo6mpULpaez
	+6Dj9Li+aMmXLVUPAUaeG1mDhszSN+QK3pyqiWGDPWjN3OJxMzFxiK5xNN7lRbQe1bGSZvCSm1j
	yK+v/SOksJhZzbr/rZ8N6WoLu2YJ9aBnSrSAZr5hS1pQPpkyU3wvuO0VieV4KeD5b0DswB/+vRN
	uGOyJUdPLtjyarH3VLk2/XS8BlRKpOkGjQwjshVrVsIxNzDuQDfY0qi63R7L+29nyqXbygDQsU+
	5HNU+4hg1cn+QfMsn+rt8w17zIzvIcTLrn8vD+Dx0M5EeRiA8QF/kuXE1Rb9C+CxO1jEuoBARRW
	QqOwZd7QB24KMPWMn5UlojnJaXx+0hpZPKFHegRLbHw7sIVlu3BGkRj9oAlD5iL/RGYZt/RaVIs
	+EbVYpH2i2J9O1I0jv7FOpDpCxDcn2riTiWXE9vMzGb9JX6Xvnprw+WMg8Gpsi9B6O6XE5Qg==
X-Google-Smtp-Source: AGHT+IFO8f3zSjdykqf1Kr0gxE3ErDzCv2okjONO6xVq4LBpyclJaVAQQcXbM33ML2tW+E89S1xQpQ==
X-Received: by 2002:a17:90b:2b43:b0:340:d1a1:af6d with SMTP id 98e67ed59e1d1-3434c59666cmr2511464a91.36.1762500447252;
        Thu, 06 Nov 2025 23:27:27 -0800 (PST)
Received: from ?IPv6:2401:4900:88f4:f6c4:d67f:d090:f2ee:1569? ([2401:4900:88f4:f6c4:d67f:d090:f2ee:1569])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d13a6031sm2386518a91.6.2025.11.06.23.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 23:27:26 -0800 (PST)
Message-ID: <cb130473feb7b02a85c210df192fc6482ff4fa35.camel@gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v3] net: ethernet: fix uninitialized
 pointers with free attribute
From: ally heev <allyheev@gmail.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Alexander Lobakin
	 <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang	 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui	
 <decui@microsoft.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, Dan Carpenter	
 <dan.carpenter@linaro.org>
Date: Fri, 07 Nov 2025 12:57:18 +0530
In-Reply-To: <afa219b7-9ce3-4da8-a339-8f363d77824e@intel.com>
References: 
	<20251106-aheev-uninitialized-free-attr-net-ethernet-v3-1-ef2220f4f476@gmail.com>
	 <575bfdb1-8fc4-4147-8af7-33c40e619b66@intel.com>
	 <00748f83a8ae688b7063f36844e38073d29b5e19.camel@gmail.com>
	 <afa219b7-9ce3-4da8-a339-8f363d77824e@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-07 at 06:39 +0100, Przemek Kitszel wrote:
> On 11/6/25 17:05, ally heev wrote:
> > On Thu, 2025-11-06 at 15:07 +0100, Alexander Lobakin wrote:
> > [..]
> > > >=20
> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/ne=
t/ethernet/intel/ice/ice_flow.c
> > > > index 6d5c939dc8a515c252cd2b77d155b69fa264ee92..3590dacf3ee57879b38=
09d715e40bb290e40c4aa 100644
> > > > --- a/drivers/net/ethernet/intel/ice/ice_flow.c
> > > > +++ b/drivers/net/ethernet/intel/ice/ice_flow.c
> > > > @@ -1573,12 +1573,13 @@ ice_flow_set_parser_prof(struct ice_hw *hw,=
 u16 dest_vsi, u16 fdir_vsi,
> > > >   			 struct ice_parser_profile *prof, enum ice_block blk)
> > > >   {
> > > >   	u64 id =3D find_first_bit(prof->ptypes, ICE_FLOW_PTYPE_MAX);
> > > > -	struct ice_flow_prof_params *params __free(kfree);
> > > >   	u8 fv_words =3D hw->blk[blk].es.fvw;
> > > >   	int status;
> > > >   	int i, idx;
> > > >  =20
> > > > -	params =3D kzalloc(sizeof(*params), GFP_KERNEL);
> > > > +	struct ice_flow_prof_params *params __free(kfree) =3D
> > > > +		kzalloc(sizeof(*params), GFP_KERNEL);
> > >=20
> > > Please don't do it that way. It's not C++ with RAII and
> > > declare-where-you-use.
> > > Just leave the variable declarations where they are, but initialize t=
hem
> > > with `=3D NULL`.
>=20
> +1
>=20
> > >=20
> > > Variable declarations must be in one block and sorted from the longes=
t
> > > to the shortest.
> > >=20
> > > But most important, I'm not even sure how you could trigger an
> > > "undefined behaviour" here. Both here and below the variable tagged w=
ith
> > > `__free` is initialized right after the declaration block, before any
> > > return. So how to trigger an UB here?
> >=20
> > It doesn't occur here. But, many maintainers/developers consider it a
> > bad practice because if the function returns before initialization or
> > use of `goto` can cause such behaviors.
>=20
> we were bitten by that already, scenario is as follow:
> 0. have a good code w/o UB and w/o redundant =3D NULL
> 1. add some early return, say:
> 	if (dest_vsi =3D=3D fdir_vsi)
> 		return -EINVAL;
> 2. almost granted that person adding 1. will forget to add =3D NULL to al=
l
> declarations marked __free
>=20
> >=20
> > Here though, the definitions are still at the top right? Maybe I could
> > just sort them
>=20
> we discourage putting any operations, including allocations, that may
> fail into the declarations block
>=20

Makes sense. I will just initialize them with NULL then

