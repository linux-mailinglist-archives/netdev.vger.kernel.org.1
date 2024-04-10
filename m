Return-Path: <netdev+bounces-86454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B3889ED6A
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 10:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1161C20BF1
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 08:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56D613D523;
	Wed, 10 Apr 2024 08:17:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59041119F
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712737077; cv=none; b=BG+Bd7xyXbC6ZCfIaNWulAvenLfZC0HhQDrdvnPkisZjtL1nLY1mt7v8fG/Ff/a4SK6VKP8CwqLnlbIO8Gw1lnlNjebd8lmlW6ZBUpdY0fBVZzVDw20Rq4cai/pSezSWdMUt1cNax5Qc1k35a2iPXaV+rn9FkYBQrLTa2OYsZg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712737077; c=relaxed/simple;
	bh=xC8ShbvJxqkkvxJat6EB7q8qZhQNhNNdUP6nh25diog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=AbZXLVlAW+1+MHWvHdlG32EpG4MnkVfNWgTg7LePcZrK5r39LwXFpfLb7uroxCUnxgdyc3STHLG2TdoKMJKsJJFea0AcwRGNc0r17qIz1LD2kyaycf0mQEMpzOvEpjGB1+51J9kkRVdWSjjqmFAQpIq0pV8LH/onFGyda3Ewkiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-03eTqZvqPL6wle2To4eTmw-1; Wed,
 10 Apr 2024 04:17:39 -0400
X-MC-Unique: 03eTqZvqPL6wle2To4eTmw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17DA029AA3AC;
	Wed, 10 Apr 2024 08:17:39 +0000 (UTC)
Received: from hog (unknown [10.39.192.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 451BE1121306;
	Wed, 10 Apr 2024 08:17:37 +0000 (UTC)
Date: Wed, 10 Apr 2024 10:17:32 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: antony.antony@secunet.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Leon Romanovsky <leon@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>
Subject: Re: [PATCH ipsec-next v9] xfrm: Add Direction to the SA in or out
Message-ID: <ZhZLHNS41G2AJpE_@hog>
References: <bb191b37cd631341552ee87eb349f0525b90f14f.1712685187.git.antony.antony@secunet.com>
 <0a51d41e-124e-479e-afd7-50246e3b0520@6wind.com>
 <ZhY_EE8miFAgZkkC@hog>
 <f2c52a01-925c-4e3a-8a42-aeb809364cc9@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f2c52a01-925c-4e3a-8a42-aeb809364cc9@6wind.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-10, 09:35:08 +0200, Nicolas Dichtel wrote:
> Le 10/04/2024 =C3=A0 09:26, Sabrina Dubroca a =C3=A9crit=C2=A0:
> > 2024-04-10, 08:32:20 +0200, Nicolas Dichtel wrote:
> >> Le 09/04/2024 =C3=A0 19:56, Antony Antony a =C3=A9crit=C2=A0:
> >>> v6->v7:
> >>>  - add replay-window check non-esn 0 and ESN 1.
> >>>  - remove :XFRMA_SA_DIR only allowed with HW OFFLOAD
> >> Why? I still think that having an 'input' SA used in the output path i=
s wrong
> >> and confusing.
> >> Please, don't drop this check.
> >=20
> > Limiting XFRMA_SA_DIR to only HW offload makes no sense. It's
> > completely redundant with an existing property. We should also try to
> > limit the divergence between offload and non-offload configuration. If
> Sure.
>=20
> > something is clearly only for offloaded configs, then fine, but
> > otherwise the APIs should be identical.
> But right now, the property is enforced for offload and but not for non-o=
ffload.
> In that sense, the api is not identical. I'm only asking to make this exp=
licit.

We can't get rid of the offload-specific way of setting the direction,
because it's a flag (off =3D out, on =3D in), but if we add another way of
setting the direction, it should be for all cases (we already have one
for offload, we don't need a 2nd offload-specific flag), and it should
correctly lock down uses (incompatible options, and use of the SA in
the datapath as you said).

> > And based on what Antony says, this is intended in large part for
> > IPTFS, which is not going to be offloaded any time soon (or probably
> > ever), so that restriction would have to be lifted immediately. I'm
> > not sure why Antony accepted your request.
> I don't see the problem with that. The attribute can be relaxed later for=
 IPTFS
> if needed.

Then we would have landed back on v4 (unless we add the checks we're
discussing now)...

> But there are use cases without offload and without IPTFS.

Sure. That's probably the vast majority of IPsec users.

> Why isn't it possible to restrict the use of an input SA to the input pat=
h and
> output SA to xmit path?

Because nobody has written a patch for it yet :)

--=20
Sabrina


