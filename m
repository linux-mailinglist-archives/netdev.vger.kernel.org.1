Return-Path: <netdev+bounces-298024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hxfQIbx+KmrDrAMAu9opvQ
	(envelope-from <netdev+bounces-298024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:24:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B9D6705D2
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:24:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=FImgUuQJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298024-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298024-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73E7B324606B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AFD270EC1;
	Thu, 11 Jun 2026 09:21:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E7340D591
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:21:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781169700; cv=none; b=ETSmHGKMmFE8ml9qzs7yVV1nNiaxBH08/2eQOTo0dYDDcXMC6HQxBMeQ0y71fJ/9zkziC2Q5SxR4hHD7uuxJLuhgHttPt11iEg4RsQHQPKB8cyVQAuQbhpeYR1aQfzQQunK+MGYLHutwsn/kLFKBX0gcd7UWHRAY22YGOa0BWeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781169700; c=relaxed/simple;
	bh=WYdH2HzIm/xGWscZvrBa9XyggmlU9lcuSrBE5X7hIJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=caBFtldPLyrAFi4cYLt4Nc+TUp5oCBBjdoei1L3Nb+AOonMLKjUHPLEpQ8yecHFNuthNeZ6SH4ERtcZra2fu/CPVakguBvyk1tMSnl51NGkiGMl8zbAuHD5HxJAbGnzrKAok9AoCpucpr4a4D/pjS/naQ7AJlOk6E2dSCeJ3N1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FImgUuQJ; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b3e03939so5677745e9.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781169698; x=1781774498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kn+GdE/qjrZNctYSdK6rTd4SMmyrCvzyNkaCaMgHjzY=;
        b=FImgUuQJDvQeTlCOisbI5+JB6usVpbL0gj6+z2klsXZt3RhBHFdcU8QQ/vNIKOLRqV
         rYu6n05jrmN+zugn+FRATh9TPy+tJbaaa9OeBAOI95ML4OgGrNTwlXm8fkp8YwxXUaOi
         INTgwVO7E6ckFa4I30FzsAfqiG5pUoiX9B77t5rlySJ6Jdt0rBDC0QcmZ4xdbp85q+K5
         txLsxjFBgW1qGTu27NkaPXcHIB1r8GenzcMPgSkJ9ej0TpbKB8ZZvjHaYgq0doxGXva0
         pTB+9rHQiE1Z25Y3aa2zpJfAieG+Ww26gYaqF2epSv15QgHcTm3LRALrJgPjCll4Imrn
         VQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781169698; x=1781774498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kn+GdE/qjrZNctYSdK6rTd4SMmyrCvzyNkaCaMgHjzY=;
        b=FHd3WrdZbkLaqjgDyJ+fJ00UtGJMbv0FimAnITU3dRhRQSLB0Vz3yyIhbwqA4vBuka
         Z5yHNlsOFvJXO3VFaOr7A3N4uLFCDSlSc0fbIJp7UgpKAHi4hjthBP2tXJy4uu/DD8Am
         QQWppAuLYAYPnqJ9MbReGPnDMv8jPQjJK6UFO84JDBYJJq8YbMwge8huJR5SyjaXFqGR
         dMXwpVuVyP77RzWH+dUaM0TSnQwuyvXel3DX1mOq3KBmMYf33JQR/MGyXDPYGkHgD3BV
         YzT6lS283T3TFVmBpZRsH8BIQPCSSVxHuheHBxvmelKWOl53A/m60eyz4k7fcTlGHu7q
         R7Fw==
X-Forwarded-Encrypted: i=1; AFNElJ88Qmi3rTHOsvD0QafQKbGMb8+eHHp9p1oZgqM1TB6UAYqUMMcmAn9biBGmnmEHxXYROHfFqX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL/AtMyg71FLk1rIkKAXvXg87G50prubyVR+XrcYN50kKWChPl
	Gt4SkxReQcMQKRDyDkvw6LdijjTd1AFeICy2THc4Upl8yfbFXyA4Gs4r
X-Gm-Gg: Acq92OHS6Lo5D1NJUYPOlCFepoXV5ZHOLCAD5gzoP/ukR3vRbkB2LaEMToh6QjvMB+X
	2nE+xtzoUUvsRwa99Tg8vT5U88D5vvFGCvu747cFS3uToCrU8lW4GROms7tsKQZR168fXBX0rfT
	tZ40VydXMxtJHowlYvm/7WHOTbpgiWu2cAE2VmVjJGjRuRZDn+nOZx4OCBvhGv9hTqpFUm/gKlE
	qaAiGdqjMElStz3BDq8RntXgUE9sT4YCVXes36TdlsM3Fv/az6dF0SVasxw1nZm5ZHUJgwMApSQ
	7H3NWPUD/D/fnHja0HA8OOu34L/tKQMcWqXxL93SmDGD0B1bFfbxwGVHZMjffvztCGO6O9w+Okr
	bMuNJrEwiDAl+gcOsIX2QDYSBWrxT0d9jiihFgIjbmQk+mdwMDbTWuhcf9dGLj7amRZU6i/EZVQ
	bzQet9Gie9JlZHAk5Asbe1iSNWgoIHG15zicDmYDlTnZI7+dj8ioZCBSaeCMj6mRSBvtoF0cI=
X-Received: by 2002:a05:600c:470b:b0:490:5000:917 with SMTP id 5b1f17b1804b1-490e52caceemr21080955e9.1.1781169697611;
        Thu, 11 Jun 2026 02:21:37 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e52b3970sm34197165e9.8.2026.06.11.02.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:21:36 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:21:34 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 pabeni@redhat.com, kuba@kernel.org, chia-yu.chang@nokia-bell-labs.com,
 ij@kernel.org, fmancera@suse.de, yuuchihsu@gmail.com, idosch@nvidia.com,
 herbert@gondor.apana.org.au, yuantan098@gmail.com, zcliangcn@gmail.com,
 bird@lzu.edu.cn, bronzed_45_vested@icloud.com
Subject: Re: [PATCH net 1/1] net: ipv4: bound TCP reordering sysctl writes
Message-ID: <20260611102134.5886fe04@pumpkin>
In-Reply-To: <CANn89iKLKNGE0aqyuCdxTBbRGWwAM0vCup+AL02u1UB-LrTvSw@mail.gmail.com>
References: <cover.1780979031.git.bronzed_45_vested@icloud.com>
	<42cd30856907350e1b3834a3338364f9828a307b.1780979031.git.bronzed_45_vested@icloud.com>
	<CANn89iKLKNGE0aqyuCdxTBbRGWwAM0vCup+AL02u1UB-LrTvSw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298024-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:n05ec@lzu.edu.cn,m:ncardwell@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:chia-yu.chang@nokia-bell-labs.com,m:ij@kernel.org,m:fmancera@suse.de,m:yuuchihsu@gmail.com,m:idosch@nvidia.com,m:herbert@gondor.apana.org.au,m:yuantan098@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lzu.edu.cn,google.com,vger.kernel.org,redhat.com,kernel.org,nokia-bell-labs.com,suse.de,gmail.com,nvidia.com,gondor.apana.org.au,icloud.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,icloud.com:email,pumpkin:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5B9D6705D2

On Wed, 10 Jun 2026 10:04:06 -0700
Eric Dumazet <edumazet@google.com> wrote:

> On Wed, Jun 10, 2026 at 9:18=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
> >
> > From: Wyatt Feng <bronzed_45_vested@icloud.com>
> >
> > Reject invalid `net.ipv4.tcp_reordering` values before they reach TCP
> > socket state. The sysctl is stored as an `int` but copied into the
> > `u32` `tp->reordering` field for new sockets, so negative writes wrap
> > to large values.
> >
> > With `tcp_mtu_probing=3D2`, the wrapped value can overflow the
> > `tcp_mtu_probe()` size calculation and drive the MTU probing path into
> > an out-of-bounds read. Route `tcp_reordering` writes through
> > `proc_dointvec_minmax()` and clamp them to the per-netns range
> > `[1, tcp_max_reordering]`.
> >
...
> Thanks for the patch. I think we can do better.
>=20
> Also I do not see a fix in tcp_mtu_probe()?
>=20
> What about:
>=20
>=20
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index c0e85cc171aec099fd5d4897b1a623dd27eaee08..987bc87e255a81680ae5e23dd=
d01c1f0de4425ec
> 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -1058,6 +1058,9 @@ static struct ctl_table ipv4_net_table[] =3D {
>                 .data           =3D &init_net.ipv4.sysctl_tcp_reordering,
>                 .maxlen         =3D sizeof(int),
>                 .mode           =3D 0644,
> +               .proc_handler   =3D proc_dointvec_minmax,
> +               .extra1         =3D SYSCTL_ONE,
> +               .extra2         =3D &init_net.ipv4.sysctl_tcp_max_reorder=
ing,
>                 .proc_handler   =3D proc_dointvec
>         },
>         {
> @@ -1293,7 +1296,8 @@ static struct ctl_table ipv4_net_table[] =3D {
>                 .data           =3D &init_net.ipv4.sysctl_tcp_max_reorder=
ing,
>                 .maxlen         =3D sizeof(int),
>                 .mode           =3D 0644,
> -               .proc_handler   =3D proc_dointvec
> +               .proc_handler   =3D proc_dointvec_minmax,
> +               .extra1         =3D SYSCTL_ONE,

Would it be reasonable to put in a 'sanity' upper bound here?

Since tcp_max_reordering can be lowered after tcp_reordering is set
the bound set here isn't 'hard'.
So the same sanity limit for both may be enough?

I also found this 'gem':
void tcp_enter_loss(struct sock *sk)
{
...
	u8 reordering;
...
	reordering =3D READ_ONCE(net->ipv4.sysctl_tcp_reordering);

Which makes be think that someone expected these values to be small.

I don't know what the sane bounds are for either sysctl or tp->reordering
itself (which is u32).

-- David



