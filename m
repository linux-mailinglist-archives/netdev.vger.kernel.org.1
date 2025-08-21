Return-Path: <netdev+bounces-215487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4602B2EC9F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 06:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AEDE17DA6E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 04:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB5E255F52;
	Thu, 21 Aug 2025 04:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4TN4DpN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFD0222582
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 04:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755749255; cv=none; b=DD2fW5X8fPjfKVY6YInnS7o54BMl0cBcz1Gl5wiA/a0mFhAA8ZZtj7u+LNuFhnmI575cFL2UMN0E6Rxp/+PVEpkV9K8LuUKg/h0vXhzbjsEJ/MTXKXtHqFBs44Vv9gcLa1QWWXIkNR6INs+9jVDFjv+UHAzMejm+CTUh0xIkfHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755749255; c=relaxed/simple;
	bh=5oirP7WiNifHumklvNdf1HOpwUeGPcRbhlJLskwX9hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndBhjcV9YYPouyw/PuaaUTyHSRiw7vE9vSrxGApZUrp6Oppov+KFLfc5UGwHQySD8t9Z0i3oxH14kEgzEPkuQYukSaqHJjN1qZdffCzHWEJISQecdHmhacHZswSGiLX33FD6TTsizvbufQcQhkYTnikO67Gbjp5NK5ICGpjnt64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f4TN4DpN; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-618076fd48bso3564a12.1
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 21:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755749252; x=1756354052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2zfCcSJOzjARkXqmrK2VbK9VW5RbRjtX977JzOFSGY=;
        b=f4TN4DpNGOUC91OZ4sACkuUfzsOB7BCcfva7qX/8nCC7M1sTdmQPHiQDYT47nK4V1w
         4FPmCvkdnuPZM+fVBCIN7atWpoGca6DBEI4qom+uvjjEOkRppLtg/AdebGa4Wr/B/C1U
         3Wao/GaQlSi6m4d5cuKTGbz2Ck6+azpfjcilozM56ob+g76dTu385g4Zm0c6ELKGJ5uN
         G4fpvLA7uQyk5YPGpGc8Qcj35ZHAY2gIBpgq9dIkA4ddic8M9lvw7bbt6NqMPfoMmYtm
         RtSY/0+AH4MFtDtkZ3mL/xRfcoKEwuT6PjSl0AIns1FPhYpx3bls7mPBuAqHL2Wk5SMK
         ZPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755749252; x=1756354052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2zfCcSJOzjARkXqmrK2VbK9VW5RbRjtX977JzOFSGY=;
        b=WE/sWRFxWW9KC4eH1l0nrLxP1oJhiJAuJUkqjWlpfg+c5AciOHdJ7LPR+9iArBm0Sk
         u47finz2NqkbV1PiUKb1MxSVvxJ2m0vV7AnCLHCQxOIptXDJ5h9WIp6HMFedqqslKqpc
         kw7T/QacSvDpy7sbwMdGZEql1NOgXIuGWjQawN3OoIyiUbHinCuZgusp+BM35ldYV+bs
         94FjFd6fPah/OGlMUWp6VjHDowcxzhYfT24x9uV+EoBo/UC21bPVj7m7IpqkE/BbNt10
         /ooYGrEv1TB4J/Uvki23ARh02El5z43+mqJpz8Dy26vkr/+jjWbmGWefJxzzJFiZyR1M
         1XXw==
X-Forwarded-Encrypted: i=1; AJvYcCWL2tVjIOw/wKMHH/djMZLBmJLT5y1IfrCTTLJKQDhkJixYeGC+2h49Z2sJzh/9tuooKT17FS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy7O7YXKFr3//xnPg8GEnz9vdVcA+QbAX8I7lB+QX8TyKaBWFL
	76BrwjRacr4I5scMR8ObGNnj33melmAY/cjK0yT+feVPItFAyMCXDCIoN/n986pzvK+xPVvikCZ
	X6QjUHZYNejQ1XCr/kPBzZs/8RyJQmax8/V2np6Q3
X-Gm-Gg: ASbGncsHYTS/v/lRch531m88pqF4BaswxHV/WBEE8jVA0FdD0DlIV5CFZDbguj6W/Rf
	XiX1gemsiTBIiQsS6pgXJuNw+Lu08Su26JwvikmC0WTSXPGFZ+1/KlGCkYFXGGowTECbtVEN3Zk
	TRYCysYiRdYltRjd7rucSnrWnYRMI3TeIkuZkK+PCC/yZ/XVpyWqig31vysBmIr1azHcZ3OtuWt
	gDLRQpB0tKAjLLRYWClrKKa+kCc6CbYWcsxdRGZWf8=
X-Google-Smtp-Source: AGHT+IFrsPEyM2E5GeeRSvRDPHxWAC8MsuCNQnD2ZE2YVMx9fd6Zq4+VAYIDnVwZC2VKlhk7LZVLABzTWFCADUsy7rk=
X-Received: by 2002:a50:d658:0:b0:61b:f987:42d9 with SMTP id
 4fb4d7f45d1cf-61bf98753a1mr20993a12.2.1755749251625; Wed, 20 Aug 2025
 21:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813073955.1775315-1-maze@google.com> <6df59861-8334-49ac-8dca-2b0bac82f2d7@linux.dev>
In-Reply-To: <6df59861-8334-49ac-8dca-2b0bac82f2d7@linux.dev>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Wed, 20 Aug 2025 21:07:19 -0700
X-Gm-Features: Ac12FXwOFUmHRzE1mYnem_hnpYjz3EZEML8HNI_-8PwFPwygE3VYTkye6feLPsg
Message-ID: <CANP3RGek2nTodF_niyenmrLg2_g=BCPV6MQkwXT4SpZ6W8+9pg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: hashtab - allow BPF_MAP_LOOKUP{,_AND_DELETE}_BATCH
 with NULL keys/values.
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 1:58=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
> On 8/13/25 12:39 AM, Maciej =C5=BBenczykowski wrote:
> > BPF_MAP_LOOKUP_AND_DELETE_BATCH keys & values =3D=3D NULL
> > seems like a nice way to simply quickly clear a map.
>
> This will change existing API as users will expect
> some error (e.g., -EFAULT) return when keys or values is NULL.

No reasonable user will call the current api with NULLs.

This is a similar API change to adding a new system call
(where previously it returned -ENOSYS) - which *is* also a UAPI
change, but obviously allowed.

Or adding support for a new address family / protocol (where
previously it -EAFNOSUPPORT)
Or adding support for a new flag (where previously it returned -EINVAL)

Consider why userspace would ever pass in NULL, two possibilities:
(a) explicit NULL - you'd never do this since it would (till now)
always -EFAULT,
  so this would only possibly show up in a very thorough test suite
(b) you're using dynamically allocated memory and it failed allocation.
  that's already a program bug, you should catch that before you call bpf()=
.

> We have a 'flags' field in uapi header in
>
>          struct { /* struct used by BPF_MAP_*_BATCH commands */
>                  __aligned_u64   in_batch;       /* start batch,
>                                                   * NULL to start from be=
ginning
>                                                   */
>                  __aligned_u64   out_batch;      /* output: next start ba=
tch */
>                  __aligned_u64   keys;
>                  __aligned_u64   values;
>                  __u32           count;          /* input/output:
>                                                   * input: # of key/value
>                                                   * elements
>                                                   * output: # of filled e=
lements
>                                                   */
>                  __u32           map_fd;
>                  __u64           elem_flags;
>                  __u64           flags;
>          } batch;
>
> we can add a flag in 'flags' like BPF_F_CLEAR_MAP_IF_KV_NULL with a comme=
nt
> that if keys or values is NULL, the batched elements will be cleared.

I just don't see what value this provides.

> > BPF_MAP_LOOKUP keys/values =3D=3D NULL might be useful if we just want
> > the values/keys and don't want to bother copying the keys/values...
> >
> > BPF_MAP_LOOKUP keys & values =3D=3D NULL might be useful to count
> > the number of populated entries.
>
> bpf_map_lookup_elem() does not have flags field, so we probably should no=
t
> change existins semantics.

This is unrelated to this patch, since this only touches 'batch' operation.
(unless I'm missing something)

> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> > ---
> >   kernel/bpf/hashtab.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 5001131598e5..8fbdd000d9e0 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -1873,9 +1873,9 @@ __htab_map_lookup_and_delete_batch(struct bpf_map=
 *map,
> >
> >       rcu_read_unlock();
> >       bpf_enable_instrumentation();
> > -     if (bucket_cnt && (copy_to_user(ukeys + total * key_size, keys,
> > +     if (bucket_cnt && (ukeys && copy_to_user(ukeys + total * key_size=
, keys,
> >           key_size * bucket_cnt) ||
> > -         copy_to_user(uvalues + total * value_size, values,
> > +         uvalues && copy_to_user(uvalues + total * value_size, values,
> >           value_size * bucket_cnt))) {
> >               ret =3D -EFAULT;
> >               goto after_loop;

