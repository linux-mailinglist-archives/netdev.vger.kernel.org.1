Return-Path: <netdev+bounces-79353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AED878D39
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 03:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41FD91F226D3
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 02:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CA779E0;
	Tue, 12 Mar 2024 02:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="d2Ova4t3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F572B669
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 02:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710212195; cv=none; b=Va1zEQSD92b2EoPRBlYT0Tw5SjgZow2UQnnE/283BmXvPq0AMv7D1vILaso3Yiz30cIhWN4hiRfM7ibG0WSPYUTDkwB63NFmarGObQM4eW88Q/WjmhoE9OL8i4HKTiuRZAm4t1NcCt3G+YGjuSQ/jZ0pmhUmgOoibfX+ZW1enL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710212195; c=relaxed/simple;
	bh=8duYlw7yiLaMQiEjvPs64/nXpWh4xT1l7do/uy0Ifvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HagPZUrwZOCzDoPRxuK8qtlqBDVdU2yyfqIjL7URJVjz2lHrQ8jP57j+79S6rWJhGo4rfjq1qAf5VUwgSeO61W7pqESy+MT9PGjUbpkKX9hZ4DXQf0NCtk4guahbU8q4KTl9E2/cdnU0c8XEeVFa3sLS33LK+r2UIZLpEEdES94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=d2Ova4t3; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29b7b9a4908so2250020a91.1
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 19:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710212192; x=1710816992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8duYlw7yiLaMQiEjvPs64/nXpWh4xT1l7do/uy0Ifvk=;
        b=d2Ova4t3LH8K/YV1te1DCzhVl3PLbvJaG/iY2pzTDJkcosWx6A/MdUZ/mM4MW9sfUR
         GQ5sY5+buMi0xl8pZAl6oybDues4UiLqfZLkGdHy7hPxqm0DSdeog5UKj7At1YM1DJbF
         l6UuGZe+F+ck+GPIQFyxK9ZWsB8KHcJnj8TP5e3nSaFDsrIcxIZjimixhc84Rouc2Ru1
         jU20/9p6MyfoCzVO+QitGrjhtK31dySWPAfyxG2PMVfo2ka/f/+TxRDVMZ2SEVhhX4tC
         +C70CU73YnvAnGtEokTXbWYERGIAFzRa+RhVapWsKkGeZhM3DUaa0u5ykhQUncKB7WlF
         EL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710212192; x=1710816992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8duYlw7yiLaMQiEjvPs64/nXpWh4xT1l7do/uy0Ifvk=;
        b=O6DVmH4KRpl2t3ifGKFaN++iLLtJIxDRMZUhPOFQeWgsCjXvG3ZofX1FLwAF14UVGg
         /OXobRmEBouHOmen7z/nE199+3SWZaKfKzT1mbTDdNSiOFHY6oisqwMmkFRaftkQ7lLs
         ZtdXy/LFsJpnqSd6eW246PQxrz4ZEm95pNsV4fdxpR7qgIUbe7Z1Qylw/rtgwHO8WJjF
         c0S4+J+sY/5V75WW/QUhikPsbSsm+2m13uHbt+C5/inLzo8ElTT36X9prJa2weHMGJRT
         0RcGx9M7o8k3mgST3CcOGYJ8+k+MSDY3lbhr9jOHdF+MSqxGYA5LOFOjQEc4XGq2Wgl8
         782A==
X-Forwarded-Encrypted: i=1; AJvYcCUt+XlEOlGwnj3/ouiacjNu10weFDjjRQrX2OMZFL7ooxmrlQagsRYAVWFLto2Y5n4tm2GUHnF2HM0jEQsT58XHSeKMjDCr
X-Gm-Message-State: AOJu0Yxi0v85WGAZOAIojXhemEXiusHh8whlf6EQTL1H47Q9PcFJmGCK
	86mXo0yulV0GrQ5bYAoDY5/TSmQkqehXlwTTWHxSQzyIcEBOW4xAkhGY1E+GXEll1vTztEVSbZ2
	FLMowQPm83qfBUqj+/3AAmPKikfh41A7b6Vok9A==
X-Google-Smtp-Source: AGHT+IEEbNdZpfvWrZfgFQVH2ecv7uQ4oHjBsb6d+e9PBZQkR1FkO3HlcgN1IPWibJVLKEs+f74flvYnRRAAWujNw0M=
X-Received: by 2002:a17:90a:f305:b0:299:63fe:3a27 with SMTP id
 ca5-20020a17090af30500b0029963fe3a27mr5454778pjb.19.1710212192599; Mon, 11
 Mar 2024 19:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-8-dongmenglong.8@bytedance.com> <CAADnVQK4tdefa3s=sim69Sc+ztd-hHohPEDXaUNVTU-mLNYUiw@mail.gmail.com>
 <CALz3k9iabeOwHSrPb9mkfCuOebanh3+bAfi7xh3kBBN0DzHC3A@mail.gmail.com> <CAADnVQKsrLB-2bD53R4ZdzUVdx1aqkgom1rzGCGKK0M3Uc+csQ@mail.gmail.com>
In-Reply-To: <CAADnVQKsrLB-2bD53R4ZdzUVdx1aqkgom1rzGCGKK0M3Uc+csQ@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Tue, 12 Mar 2024 10:56:21 +0800
Message-ID: <CALz3k9jJtxVRmgGM4F-33m1wp=aCShnqdaX+7pZ9UmHwntFgXw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 7/9] libbpf: don't free btf if
 program of multi-link tracing existing
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	X86 ML <x86@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Quentin Monnet <quentin@isovalent.com>, 
	bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 10:13=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 11, 2024 at 7:05=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <dong=
menglong.8@bytedance.com> wrote:
> >
> > > >
> > > > +LIBBPF_API void bpf_object__free_btfs(struct bpf_object *obj);
> > > > +
> > >
> > > It shouldn't be exported.
> > > libbpf should clean it up when bpf_object is freed.
> >
> > Yes, libbpf will clean up the btfs when bpf_object is freed in
> > this commit. And I'm trying to offer a way to early free the btfs
> > by the users manual to reduce the memory usage. Or, the
> > btfs that we opened will keep existing until we close the
> > bpf_object.
> >
> > This is optional, I can remove it if you prefer.
>
> Let's not extend libbpf api unless we really need to.
> bpf_program__attach_trace_multi_opts() and
> *skel*__attach() can probably free them.

That's a good idea! Should we add a "bool free_btf" field
to struct bpf_trace_multi_opts? bpf_program__attach_trace_multi_opts()
can be called multi times for a bpf_object, which has multi bpf
program of type tracing multi-link. Or, can we free the btfs
automatically if we found all tracing multi-link programs are attached?

Thanks!
Menglong Dong

> I don't see a use case where you'd want to keep them afterwards.

