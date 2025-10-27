Return-Path: <netdev+bounces-233332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63462C12139
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 00:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831C31A2332E
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 23:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AD2330323;
	Mon, 27 Oct 2025 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jycW97YE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F322032E68C
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761608488; cv=none; b=Jtj/Rr+xnYJ3Nl7hy4NaDDFLoqaCX2DfjnpgtZzP1gpD3UjfWq90RNYliMKHdDiFjqGih2VfIFrTMP8NPj93OxQH263C7XKCK+rqUZk20GKJYzMxmQOFAT/C7jC6DOo7BZpx2VeLJZ72uzOSLg2wGLRX/3dAIULd2smk4Q/R7Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761608488; c=relaxed/simple;
	bh=s3TSreP4LnoaIqwTPt/6jjce6Jv8PhhiuGIE2VBvxQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ripYk7l4ElqNjNYARJMgZi3j1dFZAZLmd1A3UHu9/zXr20Q0Ik2pdyHmIOsme9GH6d3MHK9y4OwzWPUL8iIKKUuEa5if0cVkyO/Rs7v6B6SAU92ImF44fG8KPLa7+43/vGpxAtt7o8AvMDsWOlDfr9g5h23h3/xzxWRDSzVUb2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jycW97YE; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b679450ecb6so3916820a12.2
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 16:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761608486; x=1762213286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s3TSreP4LnoaIqwTPt/6jjce6Jv8PhhiuGIE2VBvxQg=;
        b=jycW97YEWCsbo9DaXwNFPsIwcfXgTClw+zYMM09uK8TzURJ0gqVTWBbeTuALcNvVA0
         rxq/1jdzJIhVU4Uaw4znVqCb1lBaGDtt6YG/BuiDNg5bT2yRuEH8msFsdz7zoW19/djP
         GL8TcJwHpR9oVilsml5Ddu9KNTEwjTLeDIoWAr/9qjFOxNNyWVsibCOw5Ber2DGKxl4t
         ur06DRTInldMCQyBsfQi3/OES2d9glNwkdOHKG9lnyZWWrmL0ETVHb0lksLcv2upij5D
         QhKN7RJucXyt4GNGMF6F5xUolrUcNto55CyALsvUEwriRXTC0tz4ICza/7FYr9KrGISg
         ojgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761608486; x=1762213286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3TSreP4LnoaIqwTPt/6jjce6Jv8PhhiuGIE2VBvxQg=;
        b=DBNteSMznYYLE3vMmFGzuMrtQBWVJM0YoNNxTSoWypi8ngBNN7mxF27MVb2iPur8bt
         dIYP9xaeMygxRz/zhzsgBf/eKnVH9cgjHt4WQ12kILwyWj2nJwezH9rFGc+crYUpngBi
         iOfysITWQtBpemJOLHvhjdZKMbAGodeGIgJo3rcLylts3Rcm8KWv/eJecbogC+Qptgtr
         chiFZx1LhlKiHHePrpRs8X7hHn8IsmIEXzzbTP930sh4B8ajrI+ZMKPVs5GgRceV2art
         b46/2dcaDCsICwCsotu1ynxoe78aJRE4WtKiGjVgOjXW7XD1ljB5Utj1C2cGi+D2wME1
         SlvA==
X-Forwarded-Encrypted: i=1; AJvYcCXH4amXFZDXHpwxol201qxknlMV9UIs81iovJw4dIDJFVlqgPo+M/xotOgyfOSfFDjttH/zdY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLVgUhq1JOONxCvhaSG1BMa0mPD//Npe3sddKYZrIjQSWvkoCl
	edOfkEqrYV5guv/h7kzABRG2FRjRq2p91b74zV/zT6eQ3DAKH2Z/EELw
X-Gm-Gg: ASbGncv/4iUVEhz83ktj32x877a3GYymeUtra7RfhUBO+k37JjO7eFeesiI6ehitfAf
	whnIKOs+BOp73HrnhXxhL1ud98nLtfWr/QmF6mSXWYRuPHPW4MqaOLk0nSw8n2dWLo/dMuSMxGH
	y/ynd52MAW8whFiF98RgP0tHAKztRtqq6ltqMYvOcj/qUUv7PaixxbJttwTHk5Nga6zfGVPM8OV
	MPtMnqIHBOAh18tlzcVgb16Y/rox2xExDo4zXMBkxZ6mckRHdDV3ponph2uQOaFR8NuFhyuUjMT
	WQUb7kgJ/CNX/WsjETA6smDV/1q3tZ9vAG08LlzC1p6tKLsYskUVkj6tMy5jF5bwu2BDQ6iZOd3
	wKliyMvaP/Yy7CtH9vvK3tah9O8oFFLch8Opa5P/6pO7uA6oZBbdNWW9rRA7xb0E7z6RlSvPeHn
	pbaB6sWs0RRXg=
X-Google-Smtp-Source: AGHT+IElurffGRVabfwITQEOqntwzhUO8dSeIfiaVBREZKYDlvN/XqwOxblskEBswWTWEZMbSi3BXQ==
X-Received: by 2002:a17:903:2346:b0:270:ced4:911a with SMTP id d9443c01a7336-294cb36e45amr16790625ad.9.1761608486117;
        Mon, 27 Oct 2025 16:41:26 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf341bsm93730455ad.14.2025.10.27.16.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 16:41:25 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D53664209E50; Tue, 28 Oct 2025 06:41:22 +0700 (WIB)
Date: Tue, 28 Oct 2025 06:41:22 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net] documentation: networking: arcnet: correct the
 ARCNET web URL
Message-ID: <aQADIpGASbUxRDzx@archie.me>
References: <20251027193711.600556-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aqE60w0Sukhk/Ofa"
Content-Disposition: inline
In-Reply-To: <20251027193711.600556-1-rdunlap@infradead.org>


--aqE60w0Sukhk/Ofa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 12:37:11PM -0700, Randy Dunlap wrote:
> The arcnet.com domain has become something other than ARCNET (it is
> something about AIoT and begins with an application/registration;
> no other info.) ARCNET info is now at arcnet.cc so update the
> ARCNET hardware documentation with this URL and page title.

I'll fold this into my patch [1] when I roll the v3.

Thanks.

[1]: https://lore.kernel.org/linux-doc/20251023025506.23779-1-bagasdotme@gm=
ail.com/

--=20
An old man doll... just what I always wanted! - Clara

--aqE60w0Sukhk/Ofa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQADHQAKCRD2uYlJVVFO
o2EcAQDqLQCDDc9q+5KW8KHHfbp/58DyQrfeH9wX5LjLgi7B4QEAjuouAs2BOgN7
hFukh6lzYvKSRVRLCnPlSNMjFutJtQw=
=ft2/
-----END PGP SIGNATURE-----

--aqE60w0Sukhk/Ofa--

