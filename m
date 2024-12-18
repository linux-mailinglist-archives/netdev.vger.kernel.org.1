Return-Path: <netdev+bounces-152912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D27F9F64E3
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15EA3188AA62
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E047619D090;
	Wed, 18 Dec 2024 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQPQR4F+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A19D19F49F;
	Wed, 18 Dec 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734521431; cv=none; b=VmKoMxU7zi9f3ak6wKiFGXMDXqKN/p3FNNZF0F8PT+f4U7RU+5zJCUNA3QtGmof52d5G3YBa1D23CXSJyf9ydm+ji476EWWk4OxwF0+j1IGqsNwiJUjwbjb+cD+IuRYfvpLv2gXXXFE5PmmAfkR0yiU5rHKP2TMgAya5TVHODCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734521431; c=relaxed/simple;
	bh=u/dq9sY0VmCBJEX53jst4O2ekctR/UHErvzmMkufc/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGXQfd0ZcfVWucR3YK3jSp/c5FAguVhDrqOqf0zlPd0LvhvRNvA4w1pHqZYlyEx2rn11iWFP8S9nMhqfvOnkxFfxtmSmb+NEyAxALHnrCTIAuIOAsuS/MRIRR3pas35xgvMcWfEo+kw47woproAdmEvh0X4GstPZg2258YzCHcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQPQR4F+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-728e1799d95so7406781b3a.2;
        Wed, 18 Dec 2024 03:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734521430; x=1735126230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u/dq9sY0VmCBJEX53jst4O2ekctR/UHErvzmMkufc/k=;
        b=NQPQR4F+2t1klDGHZ1RCTiwpvboKEJMBtkzvT575nmpULlkdRC8qySSkPuwILJxK2X
         nzRyxFJ98FUlzXcMu4m1FoKidP775LNm5FycbFQ4b638dlQ2fc6YMjJwYzjAcqVzz3+q
         foj+nb6C8pFeOP/GlNTZ+rlA76TUf/tjYt1A5eHeFACK2z9124hNHI1mqpuF7DJ4Xtig
         /kkNx/jMwkD3wmpV9By36lIbugCrzTIxYOjwSgZ0tqXvJCzPc3afFCZyLgx8fdtAn812
         uNHWTcwNoGI0Fjoh/aqgJw/1DHXT/mJicUTZCATSqDQxkhNWdugke93cMqJrsr240d1l
         D/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734521430; x=1735126230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/dq9sY0VmCBJEX53jst4O2ekctR/UHErvzmMkufc/k=;
        b=s+SWTOhN/Csvahajfv1SoxjnVsc4OKXzbLq452QHfnPLK78LeAxLqq2/Y5wDeOhXIb
         gbGVyfYfczUfIoWqcZw+vVEP0GVYe6xIe6YRWIvEbiodylHAjjd8oyFUJPIMnsyMQ9Rn
         gZmawKMJaC2aB1Ko0zW2mrsv8c0Um0EiB37p9+pHTRT0/B9WitbaE3URwu1QQDddhKeh
         5SPsZOXmWEHc6gA1c96+oTXxwzGzkhBUEx+bHGxwfm+epy1FsG5aFpjUGYR6OlxHTEKb
         V+q3I28O237tcTu0KE3bpDTl3BJiaObcTxhh5sBZYILHzgjdjqZRB10cBC9CSafIpgwC
         +GNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBB6SNv8bUvcRhkL1S/dzddzfVvRaaK3CNdIQWkYOEH5WucYjIztzHSACTuSMqjx74Al/qtnZDek4=@vger.kernel.org, AJvYcCUu8vZrRgtQON+9JMDojreMjGcTRPR/FqYZ4AIKA7DYGaNE0Ok13fOlLYsGVwUnbgXExUONSml9@vger.kernel.org, AJvYcCX7wcJw/0UwtyjQro4AbCivTV3oMW6B5wbKyXjX+c2n9FHeMqlWNFiCj7vzVErdI4yN4FqQvhBWPOzlKnCp@vger.kernel.org
X-Gm-Message-State: AOJu0YzNEXlB1A5ZUoeH5tmNI55+oykWmZ1/GDifZ5UkUP3utYjoZqhA
	E5/4aTPDQmy0CdFAoi6+tkWoT52+Zvf1/GjghIV7dbNI9c00CLq1
X-Gm-Gg: ASbGncsbcWcMhptId3mZoPi/xEJ+IzgGVc1xlmyox7S0es37YasgVONtnGShqjZVKD1
	PNWkN9zyT8GNZTrjBgqPseMwKzzJj/+sV5eKTbQaMUd5sIPW+Uo2psBsIgp55Hh98sbO+sCArgK
	WZVy6tMqOIWtKc6yAuIY4X22KEMLI3dNs9aIlPvATBqrKPWsXwGIDUABFsAHlUq/MwrNailBA4k
	siGQFdXY8RaIv3Z5MG++m0gQ3GaBlpR1ZoHRasCf5KAbuxvba1TL5Ko
X-Google-Smtp-Source: AGHT+IHF0d6gmlu1urGcxtQnY6d86ijOUf7SpKBGKEJuyViKSSbm1AohGQx4vwZDspc/ZeLtw2U0pA==
X-Received: by 2002:a05:6a21:39a:b0:1e0:d851:cda5 with SMTP id adf61e73a8af0-1e5b47fc6a3mr4668603637.14.1734521429384;
        Wed, 18 Dec 2024 03:30:29 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bcdb8dsm8297560b3a.179.2024.12.18.03.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 03:30:28 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 1D6654535844; Wed, 18 Dec 2024 18:30:25 +0700 (WIB)
Date: Wed, 18 Dec 2024 18:30:25 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next v5] net: Document netmem driver support
Message-ID: <Z2KyUYTrJBAKk_M7@archie.me>
References: <20241217201206.2360389-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qKvCz0ZWn4AzuQOu"
Content-Disposition: inline
In-Reply-To: <20241217201206.2360389-1-almasrymina@google.com>


--qKvCz0ZWn4AzuQOu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 08:12:06PM +0000, Mina Almasry wrote:
> Document expectations from drivers looking to add support for device
> memory tcp or other netmem based features.
>=20

The doc looks good, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--qKvCz0ZWn4AzuQOu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ2KyRgAKCRD2uYlJVVFO
o36cAQDZBsKe9tn8UUGg3/WJMoGEDmJgvEYJGAxih7cFAW/prQD+MNUDKsCeGQw0
vRr1onQDMkLm2A1va23eGMDtgRkbaAk=
=obHT
-----END PGP SIGNATURE-----

--qKvCz0ZWn4AzuQOu--

