Return-Path: <netdev+bounces-246633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DA5CEF836
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 01:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 866E43009084
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 00:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBB21A9FBA;
	Sat,  3 Jan 2026 00:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9DjK7g3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35843D3B3
	for <netdev@vger.kernel.org>; Sat,  3 Jan 2026 00:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399301; cv=none; b=KWRyPdxPiftz2lOwCmjC66ZhVFz82DaBKny4g7HJNMDmdcSjhGMm6lnB9LXNdxlP7Rt9xn7oLtW0sDNrsgm7wMSx3skPCDcSFL0GRVSq1cwYh9iFqWsYZVVwDXlC+Dl0RYDKTXOwzb4AST6V/b6i/kLE96gUaFRX9uRAYJrfadw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399301; c=relaxed/simple;
	bh=PyqUjkxb6usvaX1FPyXgGb6lW3uRD0ozW2LWqJdC8qE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLLYzYfuNyPWJ+HWgu59LngfpHTEch/ILOfZ3ltWmHCjr994D07NBuwQp0r26Ixkt52UN8Ws0qWJInhJocJGWgC1I/l9WPDXR6XewhGPV04G1hNmbeIgitQFbmLtm1GX2LEM4ZMiq02G01uJo7F62sL9/weQjX5wiX+GlDLcqk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9DjK7g3; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42e2d02a3c9so8266177f8f.3
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 16:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767399298; x=1768004098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7m3Xzq4yrS7S661mIt0t1819iS3JesXub/bksAIEXnM=;
        b=c9DjK7g3AqL06U0Bbz+gRjvNuqUHd3+oYT6Wjm8iVlCiLRUmaZQOI3OYWZN27Yn/T5
         hT4SoB9zsTab6R2n9WcQqlefJiqcohnDbM22sxAa9O2Ob8CLGo0zk3RDJ71meGkvgRKC
         mMYHjRVV4a9sjq1FU+iYyc17y4Nl69fUIuexYlZm7FMlQbxnpTNWcdbS9/nz6YCfDXGz
         Ui839WECzS6g6Aff2tVRrsTloyktTPnQyms0vBbG9DNEeNhXigy2d/35pYsFsnjavK6g
         wEt2K4hpeb34SFGIKjLiZBk68Y4oV7CwfaXWlVqoaGWUT7VFrxWOIE0LQAg4nTAtgXov
         rmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767399298; x=1768004098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7m3Xzq4yrS7S661mIt0t1819iS3JesXub/bksAIEXnM=;
        b=YCMPq9XYVN80ZS7SeTFche17DgG+5QRkOPEkKz6e633A5lwjr+VnJvI6DLv6odDSo7
         Hx5fLnIq15Vk3XiYHxrXz0I8dmI+CT7N9aUzwFP8+OzMuJ59S9hTpYULqGawDG/6VrLP
         kxg4Ik/MYXrs3hphwqmNBNHASuBKDFXrhNK3qqEV+wfiFgsJ8MQkzEQ6tSl/SugQ8WRd
         Nko8ZJ8/fRMu8a2oely9ThrCShuuBxx+u69GkWSfn2vxhScn0+0+ChqAwMEVfkp4jnf3
         /sMWsm0HwDV9m9tXeyiphqynxnHrQ8frLnG9/F/yzZRfnvO2ETlpbpAI9cgFdLJI+rRB
         WxXw==
X-Forwarded-Encrypted: i=1; AJvYcCWEK6PmxsSevMiwQRaa/R30dphycQmPd9vCsCJdqxZjLFoaN3ESLnLNJdjLRO9U3hZbfM2P+Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9a7xBtb9ZTlsTWkIDEGWO5vc+NB4SkaDLzzZdJAwuvjgbGCb7
	62Z4y4kVIf3dFbphqtPoHbbdPiQqK8AmN3oiM8Th7T+SymVwh4IyYd+n9Osj8w0oUCidLOQXcRW
	6M7pPNKfS9Lba62GPPn56QvMSeWTWWco1KQ==
X-Gm-Gg: AY/fxX5ZXF5t7lUILkd2KHS4qt7lZbQkcVT54Z/V6x03BpSEPMAZGDUMzE0KVpqckxw
	cEFVwDcafqT9iY0/pxrAj/Z1uYTUd0EHZBFwVPMe2dZLv5owLCr73oYHrqSKicIecwddWqc7qgC
	Nu8CH/wXqJl9htHNJXz1tBBarfdrEMZdtKCLeYMn3xtwtc7rBY/fEhzqjxNNcD20JymJVNg0YJD
	HGlGRMNd6c3AdBKzh7vURexHs+hzrYS1Y37GmWJ4ByV4DHchWQQXa8E4qOQ5DI9hQqD+xQWGiAK
	Z04mvuWCzK92pi8/4UN/+HplqMUN
X-Google-Smtp-Source: AGHT+IGaIoXQ09hd438co5n1aUxz4cbfXHjGNkT5dEqcJK2ELfDCwDr6ZUtMvpqTKVK8p6odBRSELG1GsLyaiNmaJh0=
X-Received: by 2002:a05:6000:604:b0:430:7d4c:3dbc with SMTP id
 ffacd0b85a97d-4324e50b175mr59838287f8f.53.1767399297908; Fri, 02 Jan 2026
 16:14:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231232048.2860014-1-maze@google.com> <CAADnVQL4ZPaiwuXtB7b9nrVVMg0eDiT6gnnNGrU5Ys61UWdgCA@mail.gmail.com>
 <CANP3RGdFdAf9gP5G6NaqvoGm7QZkVvow9V1OfZrCPBzyvVDoGg@mail.gmail.com>
In-Reply-To: <CANP3RGdFdAf9gP5G6NaqvoGm7QZkVvow9V1OfZrCPBzyvVDoGg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 2 Jan 2026 16:14:46 -0800
X-Gm-Features: AQt7F2rlLrvLQd3a1vVdYBsWIyI0gmj4lnLMEl0kDjUy1JeIS_8xIT_Xuw6h_AE
Message-ID: <CAADnVQJXdRiNpDAqoKotq5PrbCVbQbztzK_QDbLMJqZzcmy6zw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: 'fix' for undefined future potential exploits of BPF_PROG_LOAD
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 4:57=E2=80=AFPM Maciej =C5=BBenczykowski <maze@goog=
le.com> wrote:
>
> On Thu, Jan 1, 2026 at 1:07=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Dec 31, 2025 at 3:21=E2=80=AFPM Maciej =C5=BBenczykowski <maze@=
google.com> wrote:
> > >
> > > Over the years there's been a number of issues with the eBPF
> > > verifier/jit/codegen (incl. both code bugs & spectre related stuff).
> > >
> > > It's an amazing but very complex piece of logic, and I don't think
> > > it's realistic to expect it to ever be (or become) 100% secure.
> > >
> > > For example we currently have KASAN reporting buffer length violation
> > > issues on 6.18 (which may or may not be due to eBPF subsystem, but ar=
e
> > > worrying none-the-less)
> > >
> > > Blocking bpf(BPF_PROG_LOAD, ...) is the only sure fire way to guarant=
ee
> > > the inability to exploit the eBPF subsystem.
> > > In comparison other eBPF operations are pretty benign.
> > > Even map creation is usually at most a memory DoS, furthermore it
> > > remains useful (even with prog load disabled) due to inner maps.
> > >
> > > This new sysctl is designed primarily for verified boot systems,
> > > where (while the system is booting from trusted/signed media)
> > > BPF_PROG_LOAD can be enabled, but before untrusted user
> > > media is mounted or networking is enabled, BPF_PROG_LOAD
> > > can be outright disabled.
> > >
> > > This provides for a very simple way to limit eBPF programs to only
> > > those signed programs that are part of the verified boot chain,
> > > which has always been a requirement of eBPF use in Android.
> > >
> > > I can think of two other ways to accomplish this:
> > > (a) via sepolicy with booleans, but it ends up being pretty complex
> > >     (especially wrt verifying the correctness of the resulting polici=
es)
> > > (b) via BPF_LSM bpf_prog_load hook, which requires enabling additiona=
l
> > >     kernel options which aren't necessarily worth the bother,
> > >     and requires dynamically patching the kernel (frowned upon by
> > >     security folks).
> > >
> > > This approach appears to simply be the most trivial.
> >
> > You seem to ignore the existence of sysctl_unprivileged_bpf_disabled.
> > And with that the CAP_BPF is the only way to prog_load to work.
>
> I am actually aware of it, but we cannot use sysctl_unprivileged_bpf_disa=
bled,
> because (last I checked) it disables map creation as well,

yes, because we had bugs in maps too. prog_load has a bigger
bug surface, but map_create can have issues too.

> which we do
> want to function
> as less privileged (though still partially priv) daemons/users (for
> inner map creation)...
>
> Additionally the problem is there is no way to globally block CAP_BPF...
> because CAP_SYS_ADMIN (per documentation, and backwards compatibility)
> implies it, and that has valid users.
>
> > I suspect you're targeting some old kernels.
>
> I don't believe so.  How are you suggesting we globally block BPF_PROG_LO=
AD,
> while there will still be some CAP_SYS_ADMIN processes out of necessity,
> and without blocking map creation?

Sounds like you don't trust root, yet believe that map_create is safe
for unpriv?!
I cannot recommend such a security posture to anyone.
Use LSM to block prog_load or use bpf token with userns for fine grained ac=
cess.

