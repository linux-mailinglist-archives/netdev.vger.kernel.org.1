Return-Path: <netdev+bounces-249990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D2ED22164
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 03:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 728C4301F034
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 02:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473672417C2;
	Thu, 15 Jan 2026 02:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jZxqloSK"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FE835972
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 02:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768442740; cv=none; b=YJGGKxTX+DoMXVamv5ylHyVn6N/V+bCfXuI/DDwZaXsd684tiQK/EfbWtuW+kDUQ8sZ/rur8D3cCuyR/NapzSLEhZZhkZRUbLtGrAPS8CiSEKboq5p0OUpXlO1dQESvzai1i3QubMgnTM+CiRGpPzqa20VPjC8bSuXiF43zTptI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768442740; c=relaxed/simple;
	bh=QqRkRsY6W6cDg2r9/GWdrhfW8vG4bXD+1TOJ5m14h2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PL5VdL9+K4uBuv90aS+W+mWqWO51D9iOj8Sqy4AjO7Vx9lamQSv9Tg7FBcKyhrPsTvlown7hfJsRCXqFTnWyvmoi14wJlbqNfvCdMVjqtBDkwCHwQOTkf0THRlA5UM0AiWYAtJS2Nu6Ag/QEaSbva2Lq0OXYldbIz8PE5xnIvDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jZxqloSK; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768442725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w1dVBa1uqlDFXUaBoOe7Sd2+L0eYTFhi+IVix/28bQU=;
	b=jZxqloSKgyUDzuZg1j1fKmAHPfh1FMRvaNKyyrWZ7ay4YNtXzrQZuttKwi2O7oldR0RGlZ
	0AXxMKOjnkawyarHbD2YiyDl8Iew528hfRXTZLk9QxG5guU8jkFvYCoKq+eGm8FX8F2/jh
	5vjhjDZUd5d4OKvihEtCJb1XhyGqpnA=
From: Menglong Dong <menglong.dong@linux.dev>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, dsahern@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, jiang.biao@linux.dev, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v9 01/11] bpf: add fsession support
Date: Thu, 15 Jan 2026 10:05:11 +0800
Message-ID: <2815339.mvXUDI8C0e@7940hx>
In-Reply-To:
 <CAEf4Bza84H=FL-KxJEFAn6pFpVBQVnvrpif6_gtf_SWHH4pRJQ@mail.gmail.com>
References:
 <20260110141115.537055-1-dongml2@chinatelecom.cn> <3026834.e9J7NaK4W3@7940hx>
 <CAEf4Bza84H=FL-KxJEFAn6pFpVBQVnvrpif6_gtf_SWHH4pRJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/15 02:56 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> On Tue, Jan 13, 2026 at 6:11=E2=80=AFPM Menglong Dong <menglong.dong@linu=
x.dev> wrote:
> >
> > On 2026/1/14 09:22 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> > > On Sat, Jan 10, 2026 at 6:11=E2=80=AFAM Menglong Dong <menglong8.dong=
@gmail.com> wrote:
> > > >
> > > > The fsession is something that similar to kprobe session. It allow =
to
> > > > attach a single BPF program to both the entry and the exit of the t=
arget
> > > > functions.
> > > >
> > [...]
> > > > --- a/kernel/bpf/btf.c
> > > > +++ b/kernel/bpf/btf.c
> > > > @@ -6107,6 +6107,7 @@ static int btf_validate_prog_ctx_type(struct =
bpf_verifier_log *log, const struct
> > > >                 case BPF_TRACE_FENTRY:
> > > >                 case BPF_TRACE_FEXIT:
> > > >                 case BPF_MODIFY_RETURN:
> > > > +               case BPF_TRACE_FSESSION:
> > > >                         /* allow u64* as ctx */
> > > >                         if (btf_is_int(t) && t->size =3D=3D 8)
> > > >                                 return 0;
> > > > @@ -6704,6 +6705,7 @@ bool btf_ctx_access(int off, int size, enum b=
pf_access_type type,
> > > >                         fallthrough;
> > > >                 case BPF_LSM_CGROUP:
> > > >                 case BPF_TRACE_FEXIT:
> > > > +               case BPF_TRACE_FSESSION:
> > >
> > > According to the comment below we make this exception due to LSM.
> > > FSESSION won't be using FSESSION programs, no? So this is not
> > > necessary?
> >
> > The comment describe the LSM case here, but the code
> > here is not only for LSM. It is also for FEXIT, which makes
> > sure that we can get the return value with "ctx[nr_args]".
> > So I think we still need it here, as we need to access the
> > return value with "ctx[nr_args]" too.
>=20
> please update the comment then as well

ACK

>=20
> >
> > >






