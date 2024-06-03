Return-Path: <netdev+bounces-100094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C428D7D4F
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 10:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040741C21D8B
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 08:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431C85821A;
	Mon,  3 Jun 2024 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fC2hui4T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8862859B4A
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717403172; cv=none; b=sSFpOJtDtckIJVtja+0kwoP58ZU9rckqJUrVTHVgsD96gigMzM/DpjJXyVliMZ3T1wYXJcT1Vz0NHkc6JanZYtGcQJEIRtp7I3GOkuSfGpH7rvaVfIitP2MVe7wN7+FxOTQNvlLBaeJJPWB4P8OoqffOjx6yUzfMqdOucuc7Fl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717403172; c=relaxed/simple;
	bh=bSiPANs1zqvcKZQI2zpHQ/6pcDeUisEkCeFQwKMGNtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axJyOawNd0syHE18SS/P4ypE4x1ImFYOJ0EkL9OeQ4xbTAzoabOSDwxoOu6B6gkMvIiyVo7iRpvrPlKKe7tyyzcTX4g+iIaYIRPTt8sNq+P8kp4c2NXmFTqtoIrXmGWvovwjaBnpPD8Xp7rlesdIBa+417UlmkwBQuh5B3o5FAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fC2hui4T; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so15064a12.0
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 01:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717403169; x=1718007969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8dFqRUzN06I6td+1eA8YESyOb42WkNK5puVp1UusMM=;
        b=fC2hui4T3F52MLqPAbUVUUU0xfxICcCYkISNVk14KUO/WWV6RRs3QJI8aWAAuJ+TCb
         PRbfKMhCG7Rd3bHxrk6mY4o27b//w+mYyGhsTo8Q5MeTo0MsvY7QYb7vl7sgz24L+/sA
         VZiRfQPRVlxWp1sLOdGeiwitOUaR0TVVG5cCN1bUWkvRzOekWqLY/T+OV3AkQKMhr5q4
         h7e9e6MiUf7+dKFcqlsQhLOukCofDzzj/GoQKcLzLTPFaC6fu9Lxf5punwIzMf1zVFyo
         NcsDRFHsJD65Ty29jjenS6qqpiqO58mUlMGKdLIvWEKbVAqOmOGp+9KEKAot/D4+hki2
         NSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717403169; x=1718007969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8dFqRUzN06I6td+1eA8YESyOb42WkNK5puVp1UusMM=;
        b=a10skdKHoHVih8HcskhpCGNHspeziajUMD81WCUEtOZyGorsmvE6UX7odLjZRGNAqY
         /ShDb/rlnj3571zg0htJNgHH3EbsQAxbqgOXRm1m45b8wMSG2eFU1EvbUr4Oif9hJuP6
         N3iLPNuE2BQeIYseNFM3xmOed6HFgGtnv3r3TlfcGCeZPgaR/Y5vcX1Iikcwxmbg0kqY
         wSls8VDHM2Rfrf+1O0cHQtyrQl5LmedkdLdzzsPDxo6P4CrFkFgO9pF11AI6KpdKJ/zx
         AwopV/DD6CH0Ngt8gIHEK/DjcKLfQ7Yq4AjOJaGXy58LYJ1kpzylOGO11ukjLGMKakS+
         lLMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW77d/ixNe7IdNU8JNV29JZhZCEgZwhF/1KD4cgKbRwC7uvLhazaSaR9HikqNKbksN0KM+/QoAqrhSOS4ZUC2amGfoP2wNZ
X-Gm-Message-State: AOJu0Yxhpky6x0X9//+SZ2S9G2DByB9jevszfyS4Ri+GVNq3FlH0SHjV
	OpOwxJ6Rh6DBL5sFihYXx+8PxwHiiDp9RE+e37x8JMEnh5Usog1qeq3Ie0wLb73MtZ9vXKGhu+v
	BqqitZEECIChRucfFmBM6+RbRqIE+Oc9N4Azu
X-Google-Smtp-Source: AGHT+IGZuDthXbWoFSnEQ7MaNweVS5sD7QeK3KCUOLuZLtw+fgjft1YjRnq0rFgcK1OXGLQN/XyrGOdazbJuRadceCA=
X-Received: by 2002:a50:ee85:0:b0:57a:22c8:2d3c with SMTP id
 4fb4d7f45d1cf-57a45f1cde0mr245850a12.0.1717403168431; Mon, 03 Jun 2024
 01:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529111844.13330-1-petrm@nvidia.com> <20240529111844.13330-3-petrm@nvidia.com>
 <CANn89iL8P68pHvCKy242Z6ggWsceK4_TWMr7OakS3guRok=_gw@mail.gmail.com> <875xuqiivg.fsf@toke.dk>
In-Reply-To: <875xuqiivg.fsf@toke.dk>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 3 Jun 2024 10:25:54 +0200
Message-ID: <CANn89iJ5UzQGBMNvZJqknuTCn13Ov4pXp7Rr+pq0G+BkJ53g7Q@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] net: ipv4: Add a sysctl to set multipath
 hash seed
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 9:30=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> Eric Dumazet <edumazet@google.com> writes:
>
> > On Wed, May 29, 2024 at 1:21=E2=80=AFPM Petr Machata <petrm@nvidia.com>=
 wrote:
> >>
> >> When calculating hashes for the purpose of multipath forwarding, both =
IPv4
> >> and IPv6 code currently fall back on flow_hash_from_keys(). That uses =
a
> >> randomly-generated seed. That's a fine choice by default, but unfortun=
ately
> >> some deployments may need a tighter control over the seed used.
> >>
> >> In this patch, make the seed configurable by adding a new sysctl key,
> >> net.ipv4.fib_multipath_hash_seed to control the seed. This seed is use=
d
> >> specifically for multipath forwarding and not for the other concerns t=
hat
> >> flow_hash_from_keys() is used for, such as queue selection. Expose the=
 knob
> >> as sysctl because other such settings, such as headers to hash, are al=
so
> >> handled that way. Like those, the multipath hash seed is a per-netns
> >> variable.
> >>
> >> Despite being placed in the net.ipv4 namespace, the multipath seed sys=
ctl
> >> is used for both IPv4 and IPv6, similarly to e.g. a number of TCP
> >> variables.
> >>
> > ...
> >
> >> +       rtnl_lock();
> >> +       old =3D rcu_replace_pointer_rtnl(net->ipv4.sysctl_fib_multipat=
h_hash_seed,
> >> +                                      mphs);
> >> +       rtnl_unlock();
> >> +
> >
> > In case you keep RCU for the next version, please do not use rtnl_lock(=
) here.
> >
> > A simple xchg() will work just fine.
> >
> > old =3D xchg((__force struct struct sysctl_fib_multipath_hash_seed
> > **)&net->ipv4.sysctl_fib_multipath_hash_seed,
> >                  mphs);
>
> We added a macro to do this kind of thing without triggering any of the
> RCU type linter warnings, in:
>
> 76c8eaafe4f0 ("rcu: Create an unrcu_pointer() to remove __rcu from a poin=
ter")
>
> So as an alternative to open-coding the cast, something like this could
> work - I guess it's mostly a matter of taste:
>
> old =3D unrcu_pointer(xchg(&net->ipv4.sysctl_fib_multipath_hash_seed, RCU=
_INITIALIZER(mphs)));

Good to know, thanks.

Not sure why __kernel qualifier has been put there.

