Return-Path: <netdev+bounces-247302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F515CF6A70
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 05:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FEFD3025580
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 04:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9D51EC01B;
	Tue,  6 Jan 2026 04:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCHN+fAr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C204819E992
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 04:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767673269; cv=none; b=uaw8ThWLX4pYCSv3GzJuoEIu2PFr769gHImAdLjLQl6gLS6qupCwhuND4/5wKqWIsg6vpGoZbwudT9/jRagq5KQYLFWNIDirUWaAih89LNXt4WBQduAHz4RijfX/JoYWkiCnK/sAdhWU6WBaEbmpDKW21TH5rHhF/EpGO27agSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767673269; c=relaxed/simple;
	bh=QdiGgC8bGawkE/NfYgtXXjps+ZdKPkdxylhntu8tO68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkEiaJr1OZaCZ8awLtxid3faOlSCUngxkjwFJpQS8+35tSI+j15kKmf18DWithmwNIlxpy8RTDx8tpGNR6iL9fQ7aUD40R2KNmqQcN4C0Fpt91fD8zvyGpCbtPwSLvG3su3b12qSZbykyGEN5dCTYxBfZlhbyGlhnlsbcV+dDy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCHN+fAr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so5339555e9.0
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 20:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767673266; x=1768278066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RnWf8bR9MzpHmNENe1Pna05tYYxiGOL+UoXNiAdXb8=;
        b=dCHN+fAr9wG0o3BMSBj7dsyVEVAWyfU579BfS7pdZLcU5cCQsPR/MXkJ6XFJ3+J9bZ
         JsmDAdrfVNfH7oaANzw+i0vjuHOH20MlKG9I5nm4jKbmN9ZYpq+v/gAVqvyTHLK/PemH
         yt5lhZS1FB8761MFc5jv34PTSkp/3JoUqBwXA+TpNqqj7UHwMybk1rHs0pswxVPMSXmo
         SZZpoBBZJHS5bVC6z3O0YeAx8E0ZqZ1dvplsINcrKD2msYKC9ke/bI2BqPV4ZT7k3Rar
         eFN5ss7A75rKy+DJGJCNtf+78SJJAeyw3fd7EYHv7QJrGgv3gtn/TNhi1Jt7cPmruu/0
         bVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767673266; x=1768278066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4RnWf8bR9MzpHmNENe1Pna05tYYxiGOL+UoXNiAdXb8=;
        b=rUgqk5gGZIA+KSZNBK8KNSPO8spEqXWglVFe5HJUDXtjCt3XJA/QXOaHmPXfz495eb
         Fwrg1/KvxPDikU8OAb7ey3Mhw+rAlCYq82k0+bUjNn6mexjWke1pKRrCUeGTLGncpUWf
         AKyHBzHxTPjchFYMaQ5nT21q5MtTZHjQmlYo18qnbCd3cc7T0vHxH+DVvk6Yk8+H164r
         KmWuf0pPZ3kRLkBAVT0ClfjVP35zShr82mPafd0lpZwbumWmVX2fa5d+WDHEqaOQjzup
         yMpOMWNXGn7Hjyp87uRobDJw3TNwdnNJTiG6ZuWcryW83b2+bnCJPiDkoI4XGPMPula+
         kzDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwGvFPCWvjLOxySUMlzK6PeuxAoEH1aRMNLoi6bl+n56tKKTCBQWJ53/v21NA7E7KBrmAP/f4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrsF4GX9TBPovRvgUro786aHXHOETAwQLNCBEGVLBh1Jy7pYeT
	5apjIWOIUfzAyhurAaBWSms6YafvdZFCH7KRaIUnxMger9JwfibtdTzuilfsKqrbm6E2fqM7444
	ifhUGMw1YmcLsn1EpEWHmeaC1xKhim8o=
X-Gm-Gg: AY/fxX4wz3QW5n8dcPnaPkTw2hOYwuyobLIg01vuOXegX5SFf24CgvcvTgWLlnzsO9z
	dEu2ygQsoLAQ19ctkIJONPzSAURGrAM1yMloiyDEqQsAf24gvRfi4NwcODwKUyJF0DL2NShmj5C
	8NnEA8Pg0OklaK4CilCk7I9JYIT1bv6+SGz/BzQkZEIwaEZDAvh4+EeWqwEfUFckPq3mOLHPsLw
	DiAFpt52uu+NzJXgjbzAoUmusnDLA3+xR8NTXyXgkK4E7j1jiOUNx1h1s/KKCTkXxBntCdgOXR8
	D/jj/04xP9WpvXrUJ2mr0dwe/flBQt43EpsZ8nI=
X-Google-Smtp-Source: AGHT+IGrNVIBe2BPS/FffT+/FZLhy1duokS4RUbj4ZYSgo+6/ME+WKqfIwPeJgaazC6hjd/emIAeqGklTt6LRXVEM8k=
X-Received: by 2002:a05:6000:4301:b0:432:8667:51c7 with SMTP id
 ffacd0b85a97d-432bca522demr2379580f8f.44.1767673265769; Mon, 05 Jan 2026
 20:21:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104122814.183732-1-dongml2@chinatelecom.cn>
 <CAEf4BzbCyMWr5tq5i45SB3jPvUFd4zOAYwJG3KBBeaoWmEq8kw@mail.gmail.com> <3389151.aeNJFYEL58@7940hx>
In-Reply-To: <3389151.aeNJFYEL58@7940hx>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 Jan 2026 20:20:54 -0800
X-Gm-Features: AQt7F2qISJSYqOQWH8CWZ2k3IT3E58T_18khV0bzCNj5zV0_W1jo093f_ClmF0Y
Message-ID: <CAADnVQ+EzgMEXAN9oJ8asRj_WYOZh2VQOKDJz8mhkqehr7f=3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 00/10] bpf: fsession support
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 7:05=E2=80=AFPM Menglong Dong <menglong.dong@linux.d=
ev> wrote:
>
> On 2026/1/6 05:20 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> > On Sun, Jan 4, 2026 at 4:28=E2=80=AFAM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> > >
> > > Hi, all.
> > >
> [......]
> > > Maybe it's possible to reuse the existing bpf_session_cookie() and
> > > bpf_session_is_return(). First, we move the nr_regs from stack to str=
uct
> > > bpf_tramp_run_ctx, as Andrii suggested before. Then, we define the se=
ssion
> > > cookies as flexible array in bpf_tramp_run_ctx like this:
> > >     struct bpf_tramp_run_ctx {
> > >         struct bpf_run_ctx run_ctx;
> > >         u64 bpf_cookie;
> > >         struct bpf_run_ctx *saved_run_ctx;
> > >         u64 func_meta; /* nr_args, cookie_index, etc */
> > >         u64 fsession_cookies[];
> > >     };
> > >
> > > The problem of this approach is that we can't inlined the bpf helper
> > > anymore, such as get_func_arg, get_func_ret, get_func_arg_cnt, etc, a=
s
> > > we can't use the "current" in BPF assembly.
> > >
> >
> > We can, as Alexei suggested on your other patch set. Is this still a
> > valid concern?
>
> Yeah, with the support of BPF_MOV64_PERCPU_REG, it's much easier
> now.
>
> So what approach should I use now? Change the prototype of
> bpf_session_is_return/bpf_session_cookie, as Alexei suggested, or
> use the approach here? I think both works, and I'm a little torn
> now. Any suggestions?

I think adding 'void *ctx' to existing kfuncs makes tramp-based
kfuncs faster, since less work needs to be done to store/read
the same data from run_ctx/current.
So that's my preference.

