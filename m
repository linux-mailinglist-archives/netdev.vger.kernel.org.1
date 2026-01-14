Return-Path: <netdev+bounces-249880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA987D200C4
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 17:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 136AD300217B
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EFD3A1D14;
	Wed, 14 Jan 2026 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwdjZ+3j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AF6399A59
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406692; cv=none; b=NXCFDjStZ6BF5I5gj0/Gwf7574Cxm8djMeFETSKH6pfsFBpDGSD4AwwmLnbIJTjPqYfcR1AyZnj+iVDlhp7Oq+C9KVqloSEAP2tCrzwANtt7Mmfhybqd9jwzadnZoJ4LdQq574t0o41l/jQPglqBEXhUPuHZCHlLr1pFZl8vAgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406692; c=relaxed/simple;
	bh=AOAKPHneUH2k+u5Nki0rOk/2j6zn7hjEd1n2qbAL9Jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvqM9FOmBfk6mY/Vwg4+vs0BRrtZ4OTm1/rA/Es6LM7p9RMvxAGb2vUTXIQ2sKXEILJT7TCrXCB6TflSMYa6F8mZw/RGxyN3OQYnYpjWmTC2kgFMhQeUS21tIyIZzlknOx91DarZgpF34S8EJ7uWWmE578zfG9l/f2vcthIdSUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwdjZ+3j; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso4825005f8f.2
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 08:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768406689; x=1769011489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFL3Ab0hoeKdAkXw+EXhrpvZ7ps8U7iR9VnnL8zsKgI=;
        b=UwdjZ+3ja9U6LW28eu4yE/EjY0CLNQj1/LyosjrARrgKRuawfoB0RLZWH2fjSSGA4m
         9kq6TrgWBLDsTKM6ZlrqoYy82B82MsIdHWUjJ0vf461eb6L36XKlfS5JmERGKyNbNsU2
         vXNgBR7vSWtIEcBhFoLvJlXHRI38iwMoOStziJhvW0wKi2lapDkCCXlBqWIpy5aeKShr
         k0aFIUrNz7w+px7SmBIpax4DatWuzvPP87tHpftBqH0DGuPprUgpycoUlfT8lnFjtfca
         aUKMnJZvsPQ2hHUYeh1lygu01X0XsFppKt0AtrBQvv/hM6/1OpYsBdDy9cPSlZJmJOIQ
         YkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406689; x=1769011489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DFL3Ab0hoeKdAkXw+EXhrpvZ7ps8U7iR9VnnL8zsKgI=;
        b=PNnUns+vNyNWv0QOmq2J31S/FfX9PT1GCxEro0AIlnXYGFuf5xEe22UOZJOEcmIePV
         sjiYU4RifduyyTPnqWrhwcLjMMfa5YoUJsyVMr+JcBwEm2WuhpS9ugvxSsXrO3PhY5c7
         Vhz1NqLDfd86A1V2ry7D/Q2Wb+boDZR6zyoeEljK0g+UoQv+xsLp8DVP85GEFxOBZRvQ
         L5Ev79dRCtvNWjnXmtt1ekohu+62U+P/qKWVmDzO+Vmri9fKe5qrQYJeezYY/yGZAxgh
         suwvwvlGTdTS9PPrg7/gaNmm1J1kl4ZdgXuqAYhNSLa6Rh/YLnaKYhrJ0tXSwszd+21O
         B/RA==
X-Forwarded-Encrypted: i=1; AJvYcCXsypzG/KyoKftYzKKnxnwysL1SVHvh4efUOHPlpspB1XFgejKhJspIvFyUDmvE/Z4R/oeJNVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOFszy3cGYfms3oc4umVlxlLZn5nrdj4B6KedzvIjJKgxrfpWw
	5hi2bBY+ce40kyXjAak//9SM4Alri/Cw1srv83Ku4pYRwirf5LXa1nH83nn+ILaAkAYAnkNf/8z
	6dL9B/JPelwShr64tIeeGMoWK4Ss2bX0=
X-Gm-Gg: AY/fxX76bhEFCHjaMQ5YyCr6ea9btfogmef4Lv0McP99E4kO972XTbCQQ0gBcWy2ubx
	hjErFLPKi1EqArBTvQiEtTKs68F8PDA/VEZ9Zu1I/YdQ07d0SrEstdwA4MqgfOF46uD0BRpoG2R
	S4Or4sEpKn4TM1cT5AyjMiuNOhm3jYH3iJBlmKdvAiavsvaxiQAsQvqkiLtFmNy8gYDqWmS4gX5
	fOa0lw1EoK751ilWm11T+vF5qeA2ws5gKY15c1v59kMWFx0iq70NxXodRbCrEABCHpVIH01dF9T
	XFZxOJOB1IXDSAsmeYEtKaV26ra1
X-Received: by 2002:a05:6000:2409:b0:432:84f9:9802 with SMTP id
 ffacd0b85a97d-4342c5483a3mr3996169f8f.49.1768406689407; Wed, 14 Jan 2026
 08:04:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102150032.53106-1-leon.hwang@linux.dev> <CAADnVQJugf_t37MJbmvhrgPXmC700kJ25Q2NVGkDBc7dZdMTEQ@mail.gmail.com>
 <aWd9z8GVYO12YsaH@krava>
In-Reply-To: <aWd9z8GVYO12YsaH@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 14 Jan 2026 08:04:38 -0800
X-Gm-Features: AZwV_QhBzgwavE9dCvsyPnD3846iYc1-CBAq5_FLY28uDU4ys3fEyjL92GFBT_8
Message-ID: <CAADnVQLxo1uPbutGNKrv=f=bSVkzxOfSof0ea8n7VvqsaU+S3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] bpf: tailcall: Eliminate max_entries and
 bpf_func access at runtime
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 3:28=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Jan 02, 2026 at 04:10:01PM -0800, Alexei Starovoitov wrote:
> > On Fri, Jan 2, 2026 at 7:01=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev=
> wrote:
> > >
> > > This patch series optimizes BPF tail calls on x86_64 and arm64 by
> > > eliminating runtime memory accesses for max_entries and 'prog->bpf_fu=
nc'
> > > when the prog array map is known at verification time.
> > >
> > > Currently, every tail call requires:
> > >   1. Loading max_entries from the prog array map
> > >   2. Dereferencing 'prog->bpf_func' to get the target address
> > >
> > > This series introduces a mechanism to precompute and cache the tail c=
all
> > > target addresses (bpf_func + prologue_offset) in the prog array itsel=
f:
> > >   array->ptrs[max_entries + index] =3D prog->bpf_func + prologue_offs=
et
> > >
> > > When a program is added to or removed from the prog array, the cached
> > > target is atomically updated via xchg().
> > >
> > > The verifier now encodes additional information in the tail call
> > > instruction's imm field:
> > >   - bits 0-7:   map index in used_maps[]
> > >   - bits 8-15:  dynamic array flag (1 if map pointer is poisoned)
> > >   - bits 16-31: poke table index + 1 for direct tail calls
> > >
> > > For static tail calls (map known at verification time):
> > >   - max_entries is embedded as an immediate in the comparison instruc=
tion
> > >   - The cached target from array->ptrs[max_entries + index] is used
> > >     directly, avoiding the 'prog->bpf_func' dereference
> > >
> > > For dynamic tail calls (map pointer poisoned):
> > >   - Fall back to runtime lookup of max_entries and prog->bpf_func
> > >
> > > This reduces cache misses and improves tail call performance for the
> > > common case where the prog array is statically known.
> >
> > Sorry, I don't like this. tail_calls are complex enough and
> > I'd rather let them be as-is and deprecate their usage altogether
> > instead of trying to optimize them in certain conditions.
> > We have indirect jumps now. The next step is indirect calls.
> > When it lands there will be no need to use tail_calls.
> > Consider tail_calls to be legacy. No reason to improve them.
>
> hi,
> I'd like to make tail calls available in sleepable programs. I still
> need to check if there's technical reason we don't have that, but seeing
> this answer I wonder you'd be against that anyway ?

tail_calls are not allowed in sleepable progs?
I don't remember such a limitation.
What prevents it?
prog_type needs to match, so all sleepable progs should be fine.
The mix and match is problematic due to rcu vs srcu life times.

> fyi I briefly discussed that with Andrii indicating that it might not
> be worth the effort at this stage.

depending on complexity of course.

