Return-Path: <netdev+bounces-218057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAA5B3AFE3
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 02:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950F7981580
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85A118A93F;
	Fri, 29 Aug 2025 00:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvoTlLEm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDC214F9FB;
	Fri, 29 Aug 2025 00:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756427989; cv=none; b=Qmq9GuQbyTMnqGE/rmhDn/gb8rQIcBm3WMktYcp0fbApbTKtZS61wk2pelnDK1bj42MCuXzry6b5+Nz2/LeVlhZWhE7wJ+gvgOM35pSwp6H5o6PqSkptJqRq6MQeNEqtq9zzJccNeedHY6R1n1jN194IqgzQ/eoiRsciBLlOVoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756427989; c=relaxed/simple;
	bh=HjEkIMNq6edKPazSpUHC+a4rJ/7MEeRbNqqydoWKOWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSX3KeabGjA25LhpAqwkqgqRIRsJvw9hpu8XUsaS56r7CtJ5+ZmrtABpJtuWuo30zS+f9n6foGdJHMmYPDH9+uRWz97TJBlCjoJznG3A8cAuODl6rPqoHxMGoCmTovHT+XZm3Cw2+ZXqykCh+PdKvxl4mDXa2bye37hcKdpMrn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvoTlLEm; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-327d47a0e3eso582802a91.3;
        Thu, 28 Aug 2025 17:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756427986; x=1757032786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HjEkIMNq6edKPazSpUHC+a4rJ/7MEeRbNqqydoWKOWQ=;
        b=DvoTlLEmNpmDVOj5HigteKLFy3ruTQrVg5Cm4+vDmsrswyVam5jQjd1onqmyhvoMtP
         lXR5ffkTngZ3YqHU2yAE/bvOCNWyMhR77hDLdPFbY/ib/7oXq2MGd9F8JsY/s6MNWJZ8
         dZpv4+H0Yxgs0nng5Z64n2TNT19WpT0azU1rLvwjRkkYuGkqGXsyQzAaZ4Zxz1zxujll
         tl95g8f8Qbu5xzopWViJQavFD+khIPf4usoWv5bz1pmzm8HGfnplyHW1kHwxDNVz4fiT
         iH5wYGIIYXWL+Fkih4kKHHZXfD8LO2lTulfJKOkiRBMZIyJMkpUS5zyE3y05YDP+BsWm
         A+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756427986; x=1757032786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjEkIMNq6edKPazSpUHC+a4rJ/7MEeRbNqqydoWKOWQ=;
        b=mqeNAqQuXU9Qdn6hMhSudbt8qxA86xNVIbaoqOoub7b4dX21yljpgOml3eo6ZEBAIG
         HyIikhDrDSGoVwX8MFoNDEaASdqbzHob1fVEpi/WX1EiPPa9rkKayOJZLYfqvaQ9NH2x
         F/FmdZXjVWAralT89AddufOsmFgtbkIn5GMM5LQlJrOfzFIcfeUIMEkafiHd407CR8ZQ
         aQA2nn+7D1wSBtg3yBCc2m8LOQjTl+znkj5OXFou1hRXXHxNqLWlH33Ydc8U7xy3w0kr
         s6EAHbVXBwCSdu7hPmqH1FoHIHoJJOhzz+BkfWLuDLT36em7dWUI2dma2GCXQakLyTdw
         iYKg==
X-Forwarded-Encrypted: i=1; AJvYcCVN+9HavAl0YwpCAyQkUGL9KRtT8dxqzDo9SzRAzJzX3EyIPyuJfmip1lvnRvuC1UOc+o0/gNujMQ0=@vger.kernel.org, AJvYcCVTLzWYAlUOpb4toVs3Y39ac3GRVGOP9OzGlPZh+sBgrW0dgNmiSjRkWEvwV7t1nJOp38+cgjAxhLU6RNLU@vger.kernel.org
X-Gm-Message-State: AOJu0YwqjMnDWeuXheeok/mJFU/NlPtNBSmjlBxv5JPfTp3F+0w9YjPT
	ykqte1wQJxc68oCE+4DMqAdai1BdtBTez3XCTW1N/PqSrP5ZbX7UG6q2e45UyeVp
X-Gm-Gg: ASbGncsILlntbu9Q2XMhCgkwK+EcnOGVHiMh+zLCg2VYngzg7dtwpYR07+LiHm6v9UO
	BWxNJJb/8+aAyFCknaFIofjEuoRXsr7o7efRHhN4KKig6Za0/wZQT3SnI/9rP1QfuF2Gdl0cJe1
	VEo90mQZMj8NpkK1Z3UpkoNdV3kJarBeSv1NuLP33wT+QmS+C+64LUsu0qeZCZbP19tn+CXGv1J
	Q8+XD4B09pWfxnC0zyI4ZPo1ZmVgjb6PTAHbnMmBAQvq7HLwhoZQCdN/3Un4xoloeGBlBKsRCqB
	4lyhRhTMAiBFDOzb04CZaSzEqA/YT7lCRizhukgGF3ue7fysdTZ5qZz4yLpj4XyNqFyFRRRrbvV
	6TvZpecMa+D9M29iAXuE6MNGCsKxH/9ROqo9F
X-Google-Smtp-Source: AGHT+IF1YudI+s6sw6sE+IWUiy2Mn4oQ7GQtenPTE2oA54T0F42+6rBSBMBC1LrlEzomvfn55tPh7w==
X-Received: by 2002:a17:90b:4c50:b0:327:ce6d:9873 with SMTP id 98e67ed59e1d1-327ce6d98dbmr3634593a91.6.1756427986323;
        Thu, 28 Aug 2025 17:39:46 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f592587sm6412248a91.9.2025.08.28.17.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 17:39:45 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 19D34420A933; Fri, 29 Aug 2025 07:39:42 +0700 (WIB)
Date: Fri, 29 Aug 2025 07:39:42 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: MD Danish Anwar <danishanwar@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Fan Gong <gongfan1@huawei.com>, Lee Trager <lee@trager.us>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] net: rpmsg-eth: Add Documentation for
 RPMSG-ETH Driver
Message-ID: <aLD2zmMy3mzgLSWC@archie.me>
References: <20250723080322.3047826-1-danishanwar@ti.com>
 <20250723080322.3047826-2-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0rED3SbdtTerq1Fh"
Content-Disposition: inline
In-Reply-To: <20250723080322.3047826-2-danishanwar@ti.com>


--0rED3SbdtTerq1Fh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 01:33:18PM +0530, MD Danish Anwar wrote:
> +References
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +- RPMSG Framework Documentation: https://www.kernel.org/doc/html/latest/=
rpmsg.html
> +- Linux Networking Documentation: https://www.kernel.org/doc/html/latest=
/networking/index.html

Instead of using external link to kernel docs, you can also use internal
cross-references, simply by mentioning the docs path
(Documentation/staging/rpmsg.rst and Documentation/networking/index.rst in =
this
case).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--0rED3SbdtTerq1Fh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaLD2ygAKCRD2uYlJVVFO
o/BgAQDSPVFRGptmLhUre16UZlfqM4csP5BAL3DpOqI3M0PBFwD9E23OnP9+Hc+f
9uGYvqSKZzSpJCye5e9AriAOLF2HfgY=
=hJ6M
-----END PGP SIGNATURE-----

--0rED3SbdtTerq1Fh--

