Return-Path: <netdev+bounces-230543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3656BEADD3
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 18:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224C81AE1D91
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 16:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B952E5B2E;
	Fri, 17 Oct 2025 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJ1JEkwC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B152BEFF1
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719756; cv=none; b=nD+lLbNwY/8zeAkv9NQ4orZwIvAcY5/7N7c9ldNYedqI5MbEFX/65EFpIhv9+3SCeCl6sA6EvhVYS/M4sAlU427WAj179w/Hf6++9tVcG/XgUmg05+I4zc0Kw7XLdIPGanZZ36Aji9/tPANvFGGzVO0YeVDxWg3Q0Jy6r7k/2nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719756; c=relaxed/simple;
	bh=f7LeaCgpkpv/0cKz2fOxN7nq7fxaeGm/IHO/bAgYlKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FH12Z44Ila+9Ub+s7rqLzyYxu6nBIb+RvWRiu2k0FsTNB4/kaVOoN4dAWezsd91UO9gptVTqBnpngJI8ioqK/R7LBTcqJ3uk9HWaSmkAMbe9iU6fG6DjFKZa/u1pcMqSoJaDXQmMDyK1UK58XJLODqIUgi8Kx2w8eXgMp/sELto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJ1JEkwC; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7814273415cso19263887b3.1
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760719753; x=1761324553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7LeaCgpkpv/0cKz2fOxN7nq7fxaeGm/IHO/bAgYlKk=;
        b=bJ1JEkwC7NByXKq6dy11aptUFxntDH84unl5OVEp5R2dkoTjsid1AOJURc8OOkhU0T
         i54bTevcV06/x1VHdMvHvgBlbXJgsA8crUMf7aL/x8IDPJhsdF7BRuJwhPklnjm4QuC0
         EvqNHPyqqbR179Ysm0DfJfBIFmATSNc1yVjD7rZqH54CSfvxI0EVbi9S7G2+cvSQyP17
         0NSAX1v8FacDo4m0berWoPudfiiLD9iD5jOVhTydiGbmTvQxh1BuE1dj4sg6UbLrydXI
         Ozgj2A5ui/w4BqrZw57XXHC27w72qJLu88CJGH9ASEhj47NQa7GkxkeU1I1C+fUVuifF
         9ltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760719753; x=1761324553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7LeaCgpkpv/0cKz2fOxN7nq7fxaeGm/IHO/bAgYlKk=;
        b=HH1grTpfJ9hQX9woh6gVVgd2h0r6EUsyI4qrYG+eQ+egECv5gOJ+yhzlsbCh7CakYK
         FYwT0Cu4pIF/A4UEEoZzQHAoZkWJAnkOXEflbh3bQui4z0uZuBiIBwpqHk23R5dUoKh9
         URpNMbXjC1njqhuxisFLqXY2pUVS84w4SrAj89807um4U67bWJYXYzJC1WWcSfBlAk/a
         YBGvLMFctjkbKc9YV5AhxCORHjjUC9zKhNNhZUzTOCxeliE/2Q0v2yOovbub9pxvjlOU
         5b+yvuVacYfhGeJ2jZTwz33OHCgISwjhZEZt++TsLp8hWnz1PKhw9UytYX5HfjNeRiX0
         3HAQ==
X-Gm-Message-State: AOJu0YwfFfHtfbKk3cKbqC3DkyUFRkqLOZQY/mgBpO4U0b6SeBos0Dov
	fFFZvypQvUp4lCcc/GR1v00QH+Ovn2vYV2i6cD6ISqRyJa0PamFXwwpZaB4ZM2ddP/2Lq7GhuhV
	6yyBxQIo/tukPSjE7MY+nSYOwHgN2phY=
X-Gm-Gg: ASbGncuPqE4jZcoEh6LoHEnxm1yX38MnYAUeEYIoHCTXUxh/JFAj//yy6IUz1WOQPeS
	YSfRPCNFIxtSDvrZNUuG+m38BrtPMV31E8JeUPxi9IRn0EltOn5Ii7sxJjBEvKRahKCA+HXxNYy
	X/9jPBFgupdAT+EnpOvzAfFZWmyUolYfksmJ4hB+U/sL1i2VhAAZ71tzUPyzxrUQyaktivZUzoo
	f2yqRMZS3kjMBijTDDYEaL0uszFB1APG7o9BsoCPCZn1GZV/zxjFLrriyGJO0FaKVRc3fc=
X-Google-Smtp-Source: AGHT+IHFbQbxlxK7FSTPuj1BO+alMVxSt0ml/8VBdjoMgkxZPLITTYvd3gbOYdpc/sSfjuHAODkTjL5FEpC7MabQXUY=
X-Received: by 2002:a53:c050:0:10b0:632:ed6b:754 with SMTP id
 956f58d0204a3-63e160e7c37mr3564373d50.9.1760719752582; Fri, 17 Oct 2025
 09:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016204503.3203690-1-ameryhung@gmail.com> <20251016204503.3203690-3-ameryhung@gmail.com>
 <285ba391-1d23-41be-8cc4-e2874fbcb1af@linux.dev> <CAMB2axO9GN=EMK2uLxqDLFkNk-V8sA7Rdb9LH3u6xx7fpCTyRA@mail.gmail.com>
In-Reply-To: <CAMB2axO9GN=EMK2uLxqDLFkNk-V8sA7Rdb9LH3u6xx7fpCTyRA@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 17 Oct 2025 09:49:01 -0700
X-Gm-Features: AS18NWC8POPlCZpJlI32QBv7z9tfYzxCClQbkuYPGVUyOeqiGA4bbSrWJ-paX4E
Message-ID: <CAMB2axMitKK6yvSKkyApMaoD2+W973N+7X2sDKj1yCVAMvakmw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: Support associating BPF program with struct_ops
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 9:38=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Thu, Oct 16, 2025 at 5:19=E2=80=AFPM Martin KaFai Lau <martin.lau@linu=
x.dev> wrote:
> >
> >
> >
> > On 10/16/25 1:45 PM, Amery Hung wrote:
> > > Each associated programs except struct_ops programs of the map will t=
ake
> > > a refcount on the map to pin it so that prog->aux->st_ops_assoc, if s=
et,
> > > is always valid. However, it is not guaranteed whether the map member=
s
> > > are fully updated nor is it attached or not. For example, a BPF progr=
am
> > > can be associated with a struct_ops map before map_update. The
> >
> > Forgot to ask this, should it at least ensure the map is fully updated
> > or it does not help in the use case?
>
> It makes sense and is necessary. Originally, I thought we don't need
> to make any promise about the state of the map since the struct_ops
> implementers have to track the state of the struct_ops themselves
> anyways. However, checking the state stored in kdata that may be
> incomplete does not look right.
>
> I will only return kdata from bpf_prog_get_assoc_struct_ops () when
> kvalue->common.state =3D=3D READY or INUSE.

should be kvalue->common.state !=3D INIT to make it consistent across
legacy and link-based attachment.

>
> If tracking the state in struct_ops kdata is overly complicated for
> struct_ops implementers, then we might need to consider changing the
> associated struct_ops from map to link.
>
> >
> > > struct_ops implementer will be responsible for maintaining and checki=
ng
> > > the state of the associated struct_ops map before accessing it.
> >

