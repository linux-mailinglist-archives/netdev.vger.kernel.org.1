Return-Path: <netdev+bounces-229940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 00389BE2466
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1BCC3535FE
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 09:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC132C15A8;
	Thu, 16 Oct 2025 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYP5srU3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF665253B5C
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605313; cv=none; b=IXXVjkmnXTYggoxPRBP3mjYLB1xdpS8J0nSCFV06i6eMfg484H+CeQF/GKHgcML0DIN9QKzic+2A/3YjQEkExA2sYh9ZoMXhBORlAjNbh26y8SYbbJYCxrtAfhxm3iAzBIHYRxMf7aQVzllf6qjuKH2m19jUF/4RCZCbsIhZyuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605313; c=relaxed/simple;
	bh=suc4JnIRIUGOcWs/9qR0Bix6Z/KdKrVm+w6n80ouM2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3QFL5/sech71B8rQedVEfsWXSRSTCqptoK0fNZI/KC1DAdXNrV9u4/EiHsC14FWsZ9VNvpxxwCtMl9/vGeukEE04nhWRrBA6dumNpPWUbtgnLg0v66VuwNgvaFu2gryqPfVR+QI/e9R8OGwJHLw5YBBf9IPnM2dGrsNVSsWymo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYP5srU3; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b6329b6e3b0so1306027a12.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 02:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760605311; x=1761210111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=suc4JnIRIUGOcWs/9qR0Bix6Z/KdKrVm+w6n80ouM2w=;
        b=LYP5srU36HSTMU0+jbS3BCNJM0Cay+HD5d70VSyE34c31C4gZS9kkkyPF6C/Dh0Ahs
         aPXMxUlCe+HyJ0150QrTSztoGfrJ9lKgOnXco1S/kk2Twa2pYV+sF60MSxSQbGcn2cg1
         hHaqG28WBKpcl6PdlOfZq38I4VWqCUSQ8OraTRIoX8vUHj5cJE4hj7Nj54nt4uTN1V0C
         Yx5BNa3pFSLxjNf5Fk4I89tKOukhg5iyo41ypWxFIRBpELO9M1Y7OZfzUBi8A1g8zEUv
         46rlyXz3Hrz41qQTGldrsPJF6xtFDzycWMriO4ARZabr7ZqLKAmPLOTxcfBg+uDWp7CB
         EcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760605311; x=1761210111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suc4JnIRIUGOcWs/9qR0Bix6Z/KdKrVm+w6n80ouM2w=;
        b=JffUfkz7bGr7iTveJMk7Z0fvXWdjydQE0MTcU1/ObVT3WFryCF8f85qaaotJy8Wi+5
         gEkvd6LugvF17BPxUXHASzBzKbM8lEoWqXfWjpJUuay3krXvQBMlKb2IdH2RMvwmO3mA
         AWJZHF2t20482jG3kebM/LdxbUUaKfpVxTJiRZhyplJHjH/AkCVXOZ7z2IL5zA9vS8xQ
         gFHvbthNVvOTc+ZXEruQRia9IYXZBvFIYOqRgRQlVpp/4PDYFxIhwU0LP2N+yIDu+5IA
         xixBAPJfQodc0HpSqDCPgeeqYlJm1edhRWToHEe8vtKKhHtG4rQwZ3uti2/lkMGtS4fG
         n/lA==
X-Forwarded-Encrypted: i=1; AJvYcCW8MFAWghC61D1gERTgDN4I/vErag3+5xFDy7jpxBoQm3ZTga8WhbAjACa9oldByeMvWCRL4js=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjhRv4/2HmAKwKaxlct23M+X8n0B4Cl0kfZDn7yhcCEC2bl8Ch
	i/ocf0y1sw9o2BD74BWP2CSF9F2vcqUQkR6mqFcB8Dj3C1iQPUfTFjC7
X-Gm-Gg: ASbGncvEvpStLGmci5HXZEJYU3Z8a17zeTGUOHKOuDOqNDidpZDNiFaMjmOhz+0OAri
	nY0YjdlHdYmO95VhVo4LCxyaFuz4QjGd67CZ3WNlAJEOCO2y5ymB5o97iyr4mRYWjmAsPMbE9DQ
	j27tlss9y4OUYrN8S5Xqp3hMGj66nAiqj/lRNR3mwuIdQkNpAbnqeuai+W+GCDv6P8PkWlaBt57
	e4h1tNOR1MrqMfglyQA831e3uzdVSMAr7ZLqRuvmhPngKMUkvHF+r2Kpd4n9JUaJ7c73HehwuIQ
	nBfRuEvsJzNbVorlTaSlD901YII4vyCgyAcRx38vKwhhKjY3ge2V2riQFUaK0AoBRJdcvhWPfEt
	zZCbWKQDju7ri9UdazEFujYE4q14NyS+MSzJm+qyao1CPXyQwwg9rI5+2ecVW08GksOc7dfy4Qg
	YAhrEpl91o21IawA==
X-Google-Smtp-Source: AGHT+IE57WvRWVQwP15WqnNytPnJ0vJwjIIRthPOsa4cpEi8X8CD2FPyQJMr+7uqN7uOBtFrHDlVOw==
X-Received: by 2002:a17:903:1a23:b0:271:9b0e:54c7 with SMTP id d9443c01a7336-29091af3a9cmr42613085ad.11.1760605310973;
        Thu, 16 Oct 2025 02:01:50 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bb66403f4sm1073355a91.23.2025.10.16.02.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:01:49 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 098DA40C0938; Thu, 16 Oct 2025 16:01:46 +0700 (WIB)
Date: Thu, 16 Oct 2025 16:01:46 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
Subject: Re: [PATCH net] net: rmnet: Fix checksum offload header v5 and
 aggregation packet formatting
Message-ID: <aPC0et6rtTOKyDR6@archie.me>
References: <20251015092540.32282-2-bagasdotme@gmail.com>
 <aO_MefPIlQQrCU3j@horms.kernel.org>
 <aPA1BzY88pULdWJ9@archie.me>
 <aPCo2f3lybfRJvP0@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V/bGbS2sUY816rHU"
Content-Disposition: inline
In-Reply-To: <aPCo2f3lybfRJvP0@horms.kernel.org>


--V/bGbS2sUY816rHU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 09:12:09AM +0100, Simon Horman wrote:
> On Thu, Oct 16, 2025 at 06:57:59AM +0700, Bagas Sanjaya wrote:
>=20
> ...
>=20
> > I think that can go on separate net-next patch.
>=20
> Yes, sure.
>=20
> Would you like to send that patch or should I?

I'll do it myself.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--V/bGbS2sUY816rHU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPC0dgAKCRD2uYlJVVFO
o1RbAQDBHNO/O//8dreUmgf0Lc9dgz9gsgk+/PRYBouO4ont9AEAlEQdl9VwuHJJ
7cOjWsWj/n4O6weq7V/0N67jnElupwU=
=JFh8
-----END PGP SIGNATURE-----

--V/bGbS2sUY816rHU--

