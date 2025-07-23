Return-Path: <netdev+bounces-209261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E043B0ED64
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1148F3B64B3
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4BB27F75F;
	Wed, 23 Jul 2025 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Rgo481jY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984BF279DDB
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259887; cv=none; b=flFD/fLQgF8K89ukuBpy52C60DBSyyTkC8BWFxYvT9mPGN6HUUw8If0xWBh/Go9wmiu2Tbe6MIN11Bc2eyhKNIY7NXLmNWLiwi24zCPSCmFb8yRfBZBreArlfVVoupL44VxmhwyzccM1py/eI6QZ8cgTc8mH/IfLyYlMI7dMSGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259887; c=relaxed/simple;
	bh=n3P2VApwyqZcQGgH2xsyRWVJMZr2KQKxV6y9K6HQS9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iwu5H08gBEMYp3qvWBWqXIFqwA4fuwn4g90wMT+lVdMyQCe6D/usu8nERBvfwsM9j3YCTpzQKaq/P+8u5JrqRwAtMnAZiCWCo/nSSdCPMAeZvRpaahZBSd7dIQtgWNKIUpriXXkGxzEyYRtjYh9pfGdK5ICe+ooU13fkJH6PFHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Rgo481jY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0d7b32322so1007938266b.2
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 01:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753259884; x=1753864684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n3P2VApwyqZcQGgH2xsyRWVJMZr2KQKxV6y9K6HQS9w=;
        b=Rgo481jYofKw+/JWzltpDuIvRwCX1WfxnfcOQk5WzmZ7ZBm4ckMo6FBIf1eB5vB02Z
         fgcVh4cWZwVf27U7yr84fa5OthqEAWFmDaG29rxS9WdM8qJ8JY07ZC+h0yAgyfvQC+Vz
         FpcDdcdNTl4jEggR0gdofkXdKW3p9lABacqbcEa8EZLO5T+MmT4XUCyRivEqUFeH6VDn
         jTAtCX0mqIuYUM71BrZF2V0imJGTD3ZrzWANbMXfiNIb0pFso7SAurv+rDYNFUnaIIGd
         zgs35lFEpsPFDT9iSAAgsCg3UT93GPmHtJo4TF+bBl6QKbKKlWyEBs19znTkKyxzdlYN
         YsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753259884; x=1753864684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3P2VApwyqZcQGgH2xsyRWVJMZr2KQKxV6y9K6HQS9w=;
        b=SmFYStCtsZn8tCQ5zEDUfhpXV7taqn0oLWa3/FsQCLlL7hVzlg6SL74XDbjo5f4EAE
         rOxfu7hFgD7OMcrrfvwoWqVRyjeiKRTkBcwq3g6rJrkoIgI2jeUH3ufNQ2iyT6AR8wmG
         nyI35jgIcgzOicYgvYqOg19FVCQJYVYk0SvuP1qsInWtfdqVkWG8ZRb6AIwVE/L/2PvP
         x2mHT7pDkmUvbF+5Q7W31iGRKJTrwFcC5VrtD0DzjpYM3e/5m0xl1H6u71C8DLYk6BHD
         4wCCq6mdG95pMVT+54mF2Y6RzRnXUdx7pM9Y8ffjSRKVW/9ycL96mmX5fooJPLoYH3aZ
         A7zA==
X-Forwarded-Encrypted: i=1; AJvYcCXac/hnpQS6qn4B2ac6TUA+C9cLz3dqM2eGbZQRDYoK0cdFttEod85ue0hfzdJhcO+BPTqWw4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDJC3Gmg1bTsHyEXWVn9qfY/WExrAgJ8CLcehR1ydOLXZqFxv2
	GNa2GZK6IrMYbq3v7XzoVZslP+l7wltFiwYZTIyJdQnoEXt61BPThuK5CQAFBmYLnwk=
X-Gm-Gg: ASbGncuyqG1CVPlujJsyPU4bupTJDF0xODRnx9xy377nsMnjWK2SjyfPJEikcOv0FLS
	CEOHO2gOdpsir5Bhwe8BkuuEBd8qxk7+W+NrzGzkgdyKbjNlzSAp7GDxwEjBhjk/t4Ke53RA9qf
	x6a1Wt7mFlCnzN/hBO68+iEu4ozQpJxexJaehNMVAwFb7s91tcFPHJZtwsDPZLgeoVIGcNRIExG
	PP7pcng8rDB6ZkLA4wTff6/75YBIkjd+KUrkq45A1QF3Dtk6Y7nA+ZcP9a5baoemZIzYBuSlcNP
	tmhiLulKINsm0/22bUp0TH1FdoeaxQ0ZRu9YdoyFbTd9tsA+5zoTOlsCXPpxr/QpIztpYNoBtb+
	qwv0vJMQWc6zP
X-Google-Smtp-Source: AGHT+IGfKxkKSgjfuBbrA9aMKGgq6w9CMUJszw4YPTrPg/PbU2Z6gWyowOy29hJBo56zgCZxcn3x3g==
X-Received: by 2002:a17:907:3d0f:b0:ae3:696c:60a with SMTP id a640c23a62f3a-af2f66c5e04mr165593266b.8.1753259883713;
        Wed, 23 Jul 2025 01:38:03 -0700 (PDT)
Received: from blackbook2 ([84.19.86.74])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6cab5f53sm1014137866b.136.2025.07.23.01.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 01:38:03 -0700 (PDT)
Date: Wed, 23 Jul 2025 10:38:00 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, 
	Daniel Sedlak <daniel.sedlak@cdn77.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: Re: [PATCH v3] memcg: expose socket memory pressure in a cgroup
Message-ID: <yruvlyxyy6gsrf2hhtyja5hqnxi2fmdqr63twzxpjrxgffov32@l7gqvdxijs5c>
References: <20250722071146.48616-1-daniel.sedlak@cdn77.com>
 <ni4axiks6hvap3ixl6i23q7grjbki3akeea2xxzhdlkmrj5hpb@qt3vtmiayvpz>
 <telhuoj5bj5eskhicysxkblc4vr6qlcq3vx7pgi6p34g4zfwxw@6vm2r2hg3my4>
 <CAAVpQUBwS3DFs9BENNNgkKFcMtc7tjZBA0PZ-EZ0WY+dCw8hrA@mail.gmail.com>
 <4g63mbix4aut7ye7b7s4m5q7aewfxq542i2vygniow7l5a3zmd@bvis5wmifscy>
 <CAAVpQUCOwFksmo72p_nkr1uJMLRcRo1VAneADon9OxDLoRH0KA@mail.gmail.com>
 <jj5w7cpjjyzxasuweiz64jqqxcz23tm75ca22h3wvfj3u4aums@gnjarnf5gpgq>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i2zmhp2yhqwmj7st"
Content-Disposition: inline
In-Reply-To: <jj5w7cpjjyzxasuweiz64jqqxcz23tm75ca22h3wvfj3u4aums@gnjarnf5gpgq>


--i2zmhp2yhqwmj7st
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] memcg: expose socket memory pressure in a cgroup
MIME-Version: 1.0

On Tue, Jul 22, 2025 at 01:11:05PM -0700, Shakeel Butt <shakeel.butt@linux.=
dev> wrote:
> > > 1 second is the current implementation and it can be more if the memcg
> > > remains in memory pressure. Regarding usefullness I think the periodic
> > > stat collectors (like cadvisor or Google's internal borglet+rumbo) wo=
uld
> > > be interested in scraping this interface.
> >=20
> > I think the cumulative counter suggested above is better at least.
>=20
> It is tied to the underlying implementation. If we decide to use, for
> example, PSI in future, what should this interface show?

Actually, if it was exposed as cummulative time under pressure (not
cummulative events), that's quite similar to PSI.

My curiosity is whether this can be useful to some responsive actions
(hence it's worth watching with high frequency or even create
notification events) or rather like post-hoc examination or low
frequency adjustments (reason for cummulative). I.e. what can this
signal to the userspace?

Michal

--i2zmhp2yhqwmj7st
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaICfVQAKCRB+PQLnlNv4
CE5mAQDDOte4EPAzuuoOKqbLKO5Ygkc70z9WHcXnUbPwPcq4swEA8kCX/rxqTORQ
i9MXibIkSfPBUZjxLcl7kwUmqFoxXQw=
=1mgK
-----END PGP SIGNATURE-----

--i2zmhp2yhqwmj7st--

