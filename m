Return-Path: <netdev+bounces-234525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAD8C22C4E
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 01:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DBDB3B3A45
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 00:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BC343147;
	Fri, 31 Oct 2025 00:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L636SIob"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B083F9D2
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 00:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761869550; cv=none; b=iTbBHGY5os6ELt9MoxiyH+nGWceBfUe5v9fFltjM65ThyLKpvxUOnRNd3t8uXTEYCSZcc5Yb7VVYfl3D1JHNn47MCl2J+yaIRTTqNCrSnVoLvhyEoT6jzSVbm3CSXQUUCZN/UX1HGwSSFu47haKWaTjXL7zt96u9k3arCuxIG+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761869550; c=relaxed/simple;
	bh=OYK7bpF90lUBkVSRihAcXGkmo5r7+CiEUhECu7W7zAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvlPUZkr+0FJjg7bICWaTXueWNpb2L9zofD0SB3L4pQ1h3DACJNNAY3PIw1a/8HjanJ1RXUvG8V5/Jlmhi8KmAhfZP0pu27y+KwLLkpsrxxqzf3mu6DUJBk9TmccNcXexePmMcZ6IBbMKUA71DaVVZBF9HA7q2w3Y9QLVZzx27o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L636SIob; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso1744600b3a.0
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 17:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761869549; x=1762474349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OYK7bpF90lUBkVSRihAcXGkmo5r7+CiEUhECu7W7zAk=;
        b=L636SIobdL2UixK1IuXhxEmq7xtobqXFvSWEFpLDY3aC+0duRTEf+QCaZoglEVPVAZ
         j2qvkc3vZVuLnhAVSZLUKiF5I+q0l+NmrhnzDWfesXwPo8oW2b5vI9WVhBqjpSqTJxxf
         qDYFBGt50p6coNPWg2Q8XfMFxRbmaLnqmR945FRjHSMrFD8pei5nXomNhdPz2p0UaIvl
         4icEKdboffpA5g9G4fezmBCbybU2gkVUKxDAcd0wME393v/kcRyOr2gl5Hnrtbwy1Q/P
         e5+MMrscHOuTkxj79t6VjKMD5bPHJQfrfTCS+eEstcxVQSUZ+k0QNEoem/Afudf4TG2x
         A/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761869549; x=1762474349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYK7bpF90lUBkVSRihAcXGkmo5r7+CiEUhECu7W7zAk=;
        b=kFXL/hWHFT42gagDUxKGEck5s0lPM26bOfOJBgLNtKe9u/DhYVqOMg9Lotm4JXp34R
         9sm7FZ8Dxi7o7q5bNVCz560ljk4sG5XYat3QhCXLw1RV+v4PM1T3SYgY33gfKtDRX8V7
         J3T9oA41kQxAgNSc2iTCAmF1FLvw6+GS1ux28Ltvf+Wud1lPw3D2pB4JkxInySDJttdA
         Ax+1EtftatIO1UVeJy92HLXdNrDwLDm3dnbybG8S68FhoWsA7Ugph6PBOPwxQzBWw/iJ
         VxKfHyq8/oVoqB5CRVBFNOd+vq+SLZdopnNcfIuHuTO99sur/rTfHuxHSAATB92/ZyDG
         VmIA==
X-Forwarded-Encrypted: i=1; AJvYcCUZfXxqpSZKFKARsxEROM8ya1sFntaZBEaasJg4H2M0ErVJX2NEIcKn49NzfDbnHmEw37A8DLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvKEsG6d2aUOJLFtfuoJWzikI330AtPKm9UFLziO+z7Cv9X9Gk
	IrkDBhbB7XBLoyK1Y3DfRSFMfqnfVq6Thr/H//ZLlzrktl/MeiQGQPm9
X-Gm-Gg: ASbGncuN6ru9IP+Fs+uWAMzi5+lQ6G7LXWI7BZqa9IZdUTeehVuRpmIdJTVhyYroQ/T
	b6hbl8AX6ikufNMcOUOHybP33DQSEcezzg9Zmxo4Tv10n7z+XDWtCZ8W+7xvuB1K4wtaHasAPI3
	wf0HcPHLkXyxWJIFXLl5itIa6x325q1WKFTOkpbdxKlRcvub/93YECPjDjdvprUv0fYR251hx0g
	mOkYvMNCSQO0Ng48m5NRwEGihbL7ni9T3SqAtJAv2v5UCgDpUqWzx9ZXuqXF6Lg0QiptdsSetOy
	UpV70JfDeymZaTaKxLTKhGrCtE64CeUx/iY1uWxylJ0VZ/zIqRz0Gbr51TlWy/sowmPeJJSUwHM
	i/vWGAASybdU8UhSKt/v/AAd4RVOD82WWal7umgjVOp0M9bJcbOy5OLStMnPcT4ZTvBBMJoLZQe
	Kt9hsZtkIsyuA=
X-Google-Smtp-Source: AGHT+IELexDJlzNWfGl/5+vJtbg1Bsn4ue6Mg8eRWqqle2QVF1oB4UwzGk4VnwtZwT73neTtyqbuCg==
X-Received: by 2002:a05:6a00:4f88:b0:77f:50df:df31 with SMTP id d2e1a72fcca58-7a778fdf48emr1109262b3a.20.1761869548554;
        Thu, 30 Oct 2025 17:12:28 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db86f0fesm52953b3a.60.2025.10.30.17.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 17:12:27 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 3242D4209E4A; Fri, 31 Oct 2025 07:12:25 +0700 (WIB)
Date: Fri, 31 Oct 2025 07:12:25 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH net-next 6/6] MAINTAINERS: Add entry for XFRM
 documentation
Message-ID: <aQP-6eQdFIN1wjNe@archie.me>
References: <20251029082615.39518-1-bagasdotme@gmail.com>
 <20251029082615.39518-7-bagasdotme@gmail.com>
 <aQMd886miv39BEPC@secunet.com>
 <20251030084158.61455ddc@kernel.org>
 <20251030084412.5f4dc096@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gb1uviwcsJe1v/2q"
Content-Disposition: inline
In-Reply-To: <20251030084412.5f4dc096@kernel.org>


--gb1uviwcsJe1v/2q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 08:44:12AM -0700, Jakub Kicinski wrote:
> I take back the "Awaiting Upstream" part. This set conflicts with=20
> the big ToC tree reorg patch. Let's either merge this into net-next=20
> or wait for trees to re-sync?

You mean this one [1]? If so, I'm happy for this series to go first then
I can respin the toctree patch.

Thanks.

[1]: https://lore.kernel.org/linux-doc/20251028113923.41932-2-bagasdotme@gm=
ail.com/

--=20
An old man doll... just what I always wanted! - Clara

--gb1uviwcsJe1v/2q
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQP+6AAKCRD2uYlJVVFO
o3uiAQCn2eApnNdhBoCFHbk7RH6C5AfjOnHJrOx3QrAwPi2Y0gD+JoziL/V8KP3c
BLsmoE9RWhrc7eMxcBlNU7LoiJxtaws=
=oq6K
-----END PGP SIGNATURE-----

--gb1uviwcsJe1v/2q--

