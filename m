Return-Path: <netdev+bounces-235576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F4106C3299E
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 19:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3D5467076
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 18:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C718B34A767;
	Tue,  4 Nov 2025 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Og6FUUUG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD03834A3BD
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279846; cv=none; b=CofDarfBOs9UDdKqdqoXFnXxH+yRpmOy5mbeDeKH5GCmlJVWLp7TQHlGnAV3k5VYyROPYimtgQA212pizc5V0bGLz2FY4kUP4+lyWiILeNBgpcKz8DQsiqTkTJovsHagXVYDplrWonkie6p0HZepRMNAQRPEhFW5wGCa4ERhuHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279846; c=relaxed/simple;
	bh=gn+1cyCQ/07KM855F/NeAln3hHIcHTws74h6tFo6Okc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dM8ddCpacAYvDSsm/U2Vc7iq/efopECrA/rv2gAl5xMPBDyVj0jCohSMITrsNajQhmNplExKUyhgYxlbpKGhjhOwiYwD/GO3TLxWv4HcMl9m+yB5/qMyr/imY8ToAqKLygFgm5BNMiyS8blWgLX0m9AecbVHuHzPnbdysygOl3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Og6FUUUG; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-633c1b740c5so5534799d50.3
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 10:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279844; x=1762884644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23KFcuOuxCVXm913D7qKqfrC6/WNaTrfBBTB+yzkDBg=;
        b=Og6FUUUGMkVX2fgpRpZ3MLvoY+fyppTtg5agAeVmHO/+VNY4DtVSa5DrKITyHw6ncW
         wmrDOXBh+ydsthbwf4n6DE314ORsE8b2cdEOneThC44c+aB+rzGNfDPfbV1kAejOAMU6
         ODvyzd77PJJ17NIRzTK2WQYl7MB3ggSTowtksAkNeClzTjBwTzJrTNN9u3iSa2kEa63L
         +7G1jXmehA/3p2V8uSpuzsd8a0MzN8kTIAceFrUol9zITe8rateS1WWO9kj0LqvseegT
         yNNgOmTmGQ6dKfTZkz+NzWVXcxPvThN6IFpbTqIQWqyEbY1a1YRP+mEzX0YLl95NnJS6
         egiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279844; x=1762884644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23KFcuOuxCVXm913D7qKqfrC6/WNaTrfBBTB+yzkDBg=;
        b=V5Wn7qP2HeIZcG0hebn4AE/mjgHX2SFSIxw1SfBce4hyf5jvr3ESJuAzWBqJlMKgvT
         yBgOx6S9UXMDBpeb+tlGDxE3jxntGW4ZmTB3Y6i9M6/3VsE1kJcxqL/wfJlaBB5qkXEC
         fUTEeZfceO/FTNwtbllTgVeF8rHlIqjAl7hL8VAYJBxCym9bXW1kuhDOwTK3HaHz5adn
         Una5OwFTu64KVmutZusIoCMKuy0dlWpZI4I2pW0hdgOROHt10x6famegiBmzNKQvlTpV
         M1mbLi6RYqGC3s0hoMK97ZtjXYaDcb2YlLIikrleXpwLiyjDUn0LjrFDlBrXdGecu93c
         Mdmg==
X-Forwarded-Encrypted: i=1; AJvYcCVGIO8W8i2iTwS6Qv17BcMQ9znLSbOHYnELvfa0OFMjBAZ/hqwiRRIYJaJAWe/3kZyIew15SgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh9eJmz10/RT6g5TlXg4stOErnsc2bYk3iHVIwwP7DoUeUGha2
	fKECLUpJYFjnfNk2QjGIeGKbBAOqXM6sIcnfb3rjqDKZqUBosJenIi7vfQfXJYqkEtjpXsMIrzS
	0mJrPZNCAQdRb++VMxkX+XB6lGaZeLZ4=
X-Gm-Gg: ASbGncuM+jPH1AyynaY4l6oBYp5luap7gFTGRBlACW6nNLDOvG96UBzVKxZqK1aEIY9
	5aeC20IkkFR/pOokkgGnRnsXHPxDrpDczhEJvtFbX/klHTqSuehoHdNirrzeOyh4WnvUc8uV8CK
	0shmCc8TZBnhOKqQ3FBQNuzICWtDck5nRoYZ5FF+JVMjhFiG6xE5as7W9NWDPbozvxYQ1+fkrwM
	3XaCUrPtN6pg4d4B6z7sR1M6nCYqIrJhRJbua3uM5zSmqbkdIBwKLeI5a/1KApmcJrkJDq5TdMF
X-Google-Smtp-Source: AGHT+IHTNpRh2KHG6Pbc5u7di/OTCMr9jG612AsDubzWqLWd8MsoVItAKkt/jwmEPvVdEYPbEPahuJtYHKvWl/RrWm4=
X-Received: by 2002:a05:690e:1559:20b0:63f:c10e:6422 with SMTP id
 956f58d0204a3-63fd34bb6c0mr380771d50.8.1762279843545; Tue, 04 Nov 2025
 10:10:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104172652.1746988-4-ameryhung@gmail.com> <6fbae8b38c532ccd1accfa75df7614f56b6a49d6b4a851b525a59b7a07f33d25@mail.kernel.org>
In-Reply-To: <6fbae8b38c532ccd1accfa75df7614f56b6a49d6b4a851b525a59b7a07f33d25@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 4 Nov 2025 10:10:31 -0800
X-Gm-Features: AWmQ_bmSxUWeL0HOMYWBJwMhgEG7HyVRMl5w44JIdR-0dpIc-mlNp10AJxj4nFk
Message-ID: <CAMB2axN+hsZ0VQHYvw-Z31EK-7wF7SVr2nOv9=e5h=wLW_cq+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/7] bpf: Pin associated struct_ops when
 registering async callback
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, ast@kernel.org, eddyz87@gmail.com, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 10:03=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 865b0dae3..557570479 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
>
> [ ... ]
>
> > +static int bpf_async_res_get(struct bpf_async_res *res, struct bpf_pro=
g *prog)
> > +{
> > +     struct bpf_map *st_ops_assoc =3D NULL;
> > +     int err;
> > +
> > +     prog =3D bpf_prog_inc_not_zero(prog);
> > +     if (IS_ERR(prog))
> > +             return PTR_ERR(prog);
> > +
> > +     st_ops_assoc =3D READ_ONCE(prog->aux->st_ops_assoc);
> > +     if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS &&
> > +         st_ops_assoc && st_ops_assoc !=3D BPF_PTR_POISON) {
> > +             st_ops_assoc =3D bpf_map_inc_not_zero(st_ops_assoc);
> > +             if (IS_ERR(st_ops_assoc)) {
> > +                     err =3D PTR_ERR(st_ops_assoc);
> > +                     goto put_prog;
> > +             }
> > +     }
>
> Can this race with bpf_prog_disassoc_struct_ops()? Between reading
> st_ops_assoc and incrementing it, another thread could dissociate the
> map:

This is fine. struct_ops map will wait for struct_ops BPF programs to
finish running (an RCU gp) before freeing itself. Therefore, when
another thread is freeing the map and this thread is calling
bpf_async_res_get(), if this thread still sees
prog->aux->st_ops_assoc, bpf_map_inc_not_zero() will fail and stop the
async callback from being registered.

>
>   bpf_async_res_get():
>     READ_ONCE(prog->aux->st_ops_assoc)  // reads valid map pointer
>
>   bpf_prog_disassoc_struct_ops():
>     guard(mutex)(&prog->aux->st_ops_assoc_mutex)
>     WRITE_ONCE(prog->aux->st_ops_assoc, NULL)
>     bpf_map_put(st_ops_assoc)  // potentially frees map
>
>   bpf_async_res_get():
>     bpf_map_inc_not_zero(st_ops_assoc)  // use-after-free
>
> The map could be freed via RCU and memory reused before
> bpf_map_inc_not_zero() executes. Other functions that access
> st_ops_assoc (bpf_prog_assoc_struct_ops and bpf_prog_disassoc_struct_ops)
> hold prog->aux->st_ops_assoc_mutex. Additionally, bpf_map_inc_not_zero's
> documentation states "map_idr_lock should have been held or the map
> should have been protected by rcu read lock."
>
> Should bpf_async_res_get() hold the st_ops_assoc_mutex or an RCU read
> lock around the st_ops_assoc access?
>
> > +
> > +     res->prog =3D prog;
> > +     res->st_ops_assoc =3D st_ops_assoc;
> > +     return 0;
> > +put_prog:
> > +     bpf_prog_put(prog);
> > +     return err;
> > +}
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/190776=
79684

