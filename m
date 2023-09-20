Return-Path: <netdev+bounces-35117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DF07A72AB
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 08:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603D01C208A6
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 06:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8383FF5;
	Wed, 20 Sep 2023 06:16:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAD83C24
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 06:16:12 +0000 (UTC)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA079D
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 23:16:09 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-577fb90bb76so3585765a12.2
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 23:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695190569; x=1695795369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uM+9IiWPEF3F1CPkHQIOgF++G8nvzeRdPlLs2FAEgto=;
        b=RHRooVprKmgR3BD7sK6BbnY8ni/6C56FRNm7eYYgx9SvkUtIF+DM4df1i0O4cQrjoP
         ArNSjK8W03DG8W/ADX0+2dENqoRSav8LZwgxsKD/PRwQwuD6Y45poRLnV3nS+HR9S0eg
         UF228RGkw8NgP4juWAZwdp+gb8XGHikrbWqyB5Ytmm2ozsnV9+//rFwh7/M51P/GR8e2
         KfSHiV2jmEQ30UpesVQDQNYdavRj6+fJ1BjjOYibaQ+xUTZqgCMM69lUSSpHswYimXfM
         2oCFq264YO2cq/0WEUwge49XSzqYgzhRJPd6gvY7djzzHKJlvaOzjwl53QIopozFjCpg
         nZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695190569; x=1695795369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uM+9IiWPEF3F1CPkHQIOgF++G8nvzeRdPlLs2FAEgto=;
        b=u+QdpEYsXKki2Xksw6ZJcdY+9XV1JrPYmpGweRQRRwcFrfnLO+vn4w98zb8ICzSef3
         6srcvr9z9y5xnzA9mFOClcn8iDehbvViOYUB9bc9gArTFv9ndX7wrXPtb1cr4mQuMcIx
         CZsGXeYW6wn+xDD5tViTFo0pEtpmHCtLZuJjJYApEv16SE7VnZkTMk2P9eTn4geaoA3D
         qkNCgf8a8r7ShQtd85QEwqtk9He1D8+cwmqfThnvV/pJnMC348UZpSKtTPZKMN30VLsZ
         0FH3UjNP4gCBIq2SAvrx71rnB3306yJ9dof5UluL7ARTn5GLfq3Es7XymnDceOoK67+e
         RNUw==
X-Gm-Message-State: AOJu0YxHgFrfN22Bg1QaEzIfzVPLL2Y5rOE8vg/kW0KkNroOejEvYW8K
	UriO7ZYnPaSYMzPuGZXQJiY=
X-Google-Smtp-Source: AGHT+IFVbF1eOipnMLYiid4ujwUEYA6kn8aUf4HxYKWDYyGs+fm3mvOU7pWqYg/+INrNOpuQUp5WlA==
X-Received: by 2002:a05:6a20:5486:b0:14d:7130:7bb3 with SMTP id i6-20020a056a20548600b0014d71307bb3mr2167328pzk.13.1695190569140;
        Tue, 19 Sep 2023 23:16:09 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id b1-20020aa78701000000b0068b1149ea4dsm2010522pfo.69.2023.09.19.23.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 23:16:08 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id 0837096EFACB; Wed, 20 Sep 2023 13:16:04 +0700 (WIB)
Date: Wed, 20 Sep 2023 13:16:04 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Martin Zaharinov <micron10@gmail.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev <netdev@vger.kernel.org>,
	patchwork-bot+netdevbpf@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	kuba+netdrv@kernel.org, dsahern@gmail.com,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: Urgent Bug Report Kernel crash 6.5.2
Message-ID: <ZQqOJOa_qTwz_k0V@debian.me>
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
 <51294220-A244-46A9-A5B8-34819CE30CF4@gmail.com>
 <67303CFE-1938-4510-B9AE-5038BF98ABB7@gmail.com>
 <8a62f57a9454b0592ab82248fca5a21fc963995b.camel@redhat.com>
 <CALidq=UR=3rOHZczCnb1bEhbt9So60UZ5y60Cdh4aP41FkB5Tw@mail.gmail.com>
 <43ED0333-18AB-4C38-A615-7755E5BE9C3E@gmail.com>
 <5A853CC5-F15C-4F30-B845-D9E5B43EC039@gmail.com>
 <A416E134-BFAA-45FE-9061-9545F6DCC246@gmail.com>
 <CANn89iKXxyAQG-N+mdhNA8H+LEf=OK+goMFxYCV6yU1BpE=Xvw@mail.gmail.com>
 <BB129799-E196-428C-909D-721670DD5E21@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y/g/orgXWo/aLrJK"
Content-Disposition: inline
In-Reply-To: <BB129799-E196-428C-909D-721670DD5E21@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--y/g/orgXWo/aLrJK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 09:05:10AM +0300, Martin Zaharinov wrote:
> > On 20 Sep 2023, at 6:59, Eric Dumazet <edumazet@google.com> wrote:
> > Again, your best route is a bisection.
>=20
> For now its not possible to make bisection , its hard to change kernel on=
 running machine =E2=80=A6
>=20

You have to do bisection, unfortunately. There is many guides there on
Internet. Or you can read Documentation/admin-guide/bug-bisect.rst.

Bye!

--=20
An old man doll... just what I always wanted! - Clara

--y/g/orgXWo/aLrJK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQqOHgAKCRD2uYlJVVFO
o6H2AQDDfFl6X30Q86X2rOc98F9gU/lVu6FnDR845N53s4w9agEAlh5FsabMfC+K
2INhhkgWBUvMFztEauEKf0FPMC6bmwg=
=L2ji
-----END PGP SIGNATURE-----

--y/g/orgXWo/aLrJK--

