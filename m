Return-Path: <netdev+bounces-247220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C76CF5F5B
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 00:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3433C30478F4
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 23:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEAA279327;
	Mon,  5 Jan 2026 23:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLHfNNyt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A313FFD
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 23:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767655198; cv=none; b=EJ2n40XtVMJKmJrp7DPpMkf5fk3NiRv04j/i1dV6ecQMLcLLowR9Cs8jllaqVH4dU7SiMm65kN/mCxnkUUmeuZJMVLDWMM64mtKlDZGLoYnNj6hf06wFdDAdHMGzarNwC3jFyV4/Va13qnq3cTAxFoqlOGpvOTlyY4wGeClxjh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767655198; c=relaxed/simple;
	bh=dTq8JStomI+Rd+zJXWVhLeeUiRgZplYspk6c6osKbhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jT0AmysOyFLepNJEKxEgtL/oJ8WrDMq/TcMKYIbQ5cy9tH1XcWo8EnlRYva6hyFqefaaxH53IeosaI+pwVGAmvq1841nHx6LnKey8pWOMyFh2l5eC5WBIdrioJ/4toEvlXIzsAuBilj7SELSO02ffYRlkJM7Ry1Q0KtpQy5OUjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLHfNNyt; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-640e065991dso423235d50.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 15:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767655195; x=1768259995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orLcEdkcoWj6jlf41hAV3nlhz4ntQgS559KlxlSZ1AU=;
        b=kLHfNNytici3qSnMQ+I0zJ5+KJkzcXP3LOJjC7T7N3btrgaUwXPckZZ7nvMC2SuYHq
         dCIhSvmtJbXtRcILQf4g5Ar8o9DtKMgx1XgBR6ptJADXesy+3m0i+xg0N9585lbNIBxL
         syFgYotGbf1bRQQfw3775ANqG9cRYwZHnPlM/Qf501KvRwkp211Gjy5bxUVM+w3Q0pfb
         qf0V7O358HPwSx8tKsyFCV4TdZL57K1PP/McJwhbbR1n3BoZgYsfKZIv8EuoPQwlr/wE
         9h9uEYAFY1Oe28zj2TF5OrKROZgsr7LkvX5SDSpvlbfPoK9cbbaJyjQ8j92JKdQK7s+u
         V0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767655195; x=1768259995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=orLcEdkcoWj6jlf41hAV3nlhz4ntQgS559KlxlSZ1AU=;
        b=LCnK16t9wzZ0Dwz4RGdH5to/mgBMyhCp1AlbpGlNukpm1muxQmuWzUF/NPt52P0jaM
         uDNNAYdZ02XCd+8zd56mvd/jpZgQWWsRbsad/tsS/BoJjJsYslg6CcnQ1MFdG2MAEb5A
         YVfWNmNImYIRomGWngb+SlHIXpySZjGceGyj0d2oCa+O6F2tQLc+b45Z7P/Dvs5As0Co
         UEUHuYZ1EfYDmknDw5qG4G5xZw1erwL5T6WGr9482Vm2wtMojez3px2PEis65Brlo60R
         jZYfl4yHMvr24WUCw03/zTC4pdWWD4E0sZ6f0W7DaAWRCxLrMHt/SQh55H7/ol8aGdFv
         9ssQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOmWDFKVysDHtwN6JnQkjDPQHese0r5KsaPSpw3ldlRIdbTQrpFYgFiy1HhOCmJN5qKVw8wK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPO5jsebXcJcjYBQHXIMQsxjQNCiYumITN7j+TIZ08/wwPBaUH
	xsVraOqTyMtPuBKDHok5nauJbcfOe62xDz7ewOEkS849hwOyXFRvfvqrqS/K1BTNwS3HITPSVpN
	bIGtTvd4uUiplYiZcHTN1rLxC0jvzbTE=
X-Gm-Gg: AY/fxX7rX0VqyQBvNZvpBdhyPbtIjoANtwODi44kj0yuQoyHRhqEYZAB6iIzvwzIDmk
	yMNx4YLK/J/a2ltuRUqEP/ACuOJ/KmD4RUvrE0Vm3JIRpKtPWPiBqINPCVGy0OtSTRYzAXWb1ew
	k+C/g4yCQaVOSOECJdoT/iM7DEl5Pu5VR46TiOoFGM6U+C698nawfqHgDJHJoT6q8ExYrRKDmak
	QjFJSu4dV4XRgDGzbjzlnfAEWwGdos+Pnmiez0PLyeQdnCp3KUtbnQz0ESlij/HvDM1gYYbPVqC
	Haarimy4mmY=
X-Google-Smtp-Source: AGHT+IFhsAPTXlq+3VyuOVdggczBpYJwy6z5lBSaVH7umL6NoIJwYU5P8qNp8tafoJTe1TKhyUj9b2VWKR2M3GBayZ0=
X-Received: by 2002:a53:a00d:0:b0:644:53c0:299f with SMTP id
 956f58d0204a3-6470c8fa09bmr880723d50.74.1767655195610; Mon, 05 Jan 2026
 15:19:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
 <20260105-skb-meta-safeproof-netdevs-rx-only-v2-15-a21e679b5afa@cloudflare.com>
 <CAADnVQJbGosoXOCdyi=NZar966FVibKYobBgQ9BiyEH3=-HOsw@mail.gmail.com>
 <CAMB2axPivi+mZOXie=VnJM8nscqkHDjSrKT=Dhp5z_copEwxLQ@mail.gmail.com>
 <e969a85c-94eb-4cb5-a7ac-524a16ccce01@linux.dev> <CAADnVQKB5vRJM4kJC5515snR6KHweE-Ld_W1wWgPSWATgiUCwg@mail.gmail.com>
 <d267c646-1acc-4e5b-aa96-56759fca57d0@linux.dev>
In-Reply-To: <d267c646-1acc-4e5b-aa96-56759fca57d0@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 5 Jan 2026 15:19:44 -0800
X-Gm-Features: AQt7F2qmivT227LCIotKh_GZIiGSROl38RT7-i8CiG1qFdJjMEylCthe5nE41uA
Message-ID: <CAMB2axM+Z9npytoRDb-D1xVQSSx__nW0GOPMOP_uMNU-ZE=AZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 15/16] bpf: Realign skb metadata for TC progs
 using data_meta
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 2:26=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
>
>
> On 1/5/26 1:47 PM, Alexei Starovoitov wrote:
> > On Mon, Jan 5, 2026 at 12:55=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >>
> >>
> >>
> >> On 1/5/26 11:42 AM, Amery Hung wrote:
> >>> On Mon, Jan 5, 2026 at 11:14=E2=80=AFAM Alexei Starovoitov
> >>> <alexei.starovoitov@gmail.com> wrote:
> >>>>
> >>>> On Mon, Jan 5, 2026 at 4:15=E2=80=AFAM Jakub Sitnicki <jakub@cloudfl=
are.com> wrote:
> >>>>>
> >>>>>
> >>>>> +__bpf_kfunc_start_defs();
> >>>>> +
> >>>>> +__bpf_kfunc void bpf_skb_meta_realign(struct __sk_buff *skb_)
> >>>>> +{
> >>>>> +       struct sk_buff *skb =3D (typeof(skb))skb_;
> >>>>> +       u8 *meta_end =3D skb_metadata_end(skb);
> >>>>> +       u8 meta_len =3D skb_metadata_len(skb);
> >>>>> +       u8 *meta;
> >>>>> +       int gap;
> >>>>> +
> >>>>> +       gap =3D skb_mac_header(skb) - meta_end;
> >>>>> +       if (!meta_len || !gap)
> >>>>> +               return;
> >>>>> +
> >>>>> +       if (WARN_ONCE(gap < 0, "skb metadata end past mac header"))=
 {
> >>>>> +               skb_metadata_clear(skb);
> >>>>> +               return;
> >>>>> +       }
> >>>>> +
> >>>>> +       meta =3D meta_end - meta_len;
> >>>>> +       memmove(meta + gap, meta, meta_len);
> >>>>> +       skb_shinfo(skb)->meta_end +=3D gap;
> >>>>> +
> >>>>> +       bpf_compute_data_pointers(skb);
> >>>>> +}
> >>>>> +
> >>>>> +__bpf_kfunc_end_defs();
> >>>>> +
> >>>>> +BTF_KFUNCS_START(tc_cls_act_hidden_ids)
> >>>>> +BTF_ID_FLAGS(func, bpf_skb_meta_realign)
> >>>>> +BTF_KFUNCS_END(tc_cls_act_hidden_ids)
> >>>>> +
> >>>>> +BTF_ID_LIST_SINGLE(bpf_skb_meta_realign_ids, func, bpf_skb_meta_re=
align)
> >>>>> +
> >>>>>    static int tc_cls_act_prologue(struct bpf_insn *insn_buf, u32 pk=
t_access_flags,
> >>>>>                                  const struct bpf_prog *prog)
> >>>>>    {
> >>>>> -       return bpf_unclone_prologue(insn_buf, pkt_access_flags, pro=
g,
> >>>>> -                                   TC_ACT_SHOT);
> >>>>> +       struct bpf_insn *insn =3D insn_buf;
> >>>>> +       int cnt;
> >>>>> +
> >>>>> +       if (pkt_access_flags & PA_F_DATA_META_LOAD) {
> >>>>> +               /* Realign skb metadata for access through data_met=
a pointer.
> >>>>> +                *
> >>>>> +                * r6 =3D r1; // r6 will be "u64 *ctx"
> >>>>> +                * r0 =3D bpf_skb_meta_realign(r1); // r0 is undefi=
ned
> >>>>> +                * r1 =3D r6;
> >>>>> +                */
> >>>>> +               *insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
> >>>>> +               *insn++ =3D BPF_CALL_KFUNC(0, bpf_skb_meta_realign_=
ids[0]);
> >>>>> +               *insn++ =3D BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
> >>>>> +       }
> >>>>
> >>>> I see that we already did this hack with bpf_qdisc_init_prologue()
> >>>> and bpf_qdisc_reset_destroy_epilogue().
> >>>> Not sure why we went that route back then.
> >>>>
> >>>> imo much cleaner to do BPF_EMIT_CALL() and wrap
> >>>> BPF_CALL_1(bpf_skb_meta_realign, struct sk_buff *, skb)
> >>>>
> >>>> BPF_CALL_x doesn't make it an uapi helper.
> >>>> It's still a hidden kernel function,
> >>>> while this kfunc stuff looks wrong, since kfunc isn't really hidden.
> >>>>
> >>>> I suspect progs can call this bpf_skb_meta_realign() explicitly,
> >>>> just like they can call bpf_qdisc_init_prologue() ?
> >>>>
> >>>
> >>> qdisc prologue and epilogue qdisc kfuncs should be hidden from users.
> >>> The kfunc filter, bpf_qdisc_kfunc_filter(), determines what kfunc are
> >>> actually exposed.
> >>
> >> Similar to Amery's comment, I recalled I tried the BPF_CALL_1 in the
> >> qdisc but stopped at the "fn =3D env->ops->get_func_proto(insn->imm,
> >> env->prog);" in do_misc_fixups(). Potentially it could add new enum ( =
>
> >> __BPF_FUNC_MAX_ID) outside of the uapi and the user space tool should =
be
> >> able to handle unknown helper also but we went with the kfunc+filter
> >> approach without thinking too much about it.
> >
> > hmm. BPF_EMIT_CALL() does:
> > #define BPF_CALL_IMM(x) ((void *)(x) - (void *)__bpf_call_base)
> > .imm   =3D BPF_CALL_IMM(FUNC)
> >
> > the imm shouldn't be going through validation anymore.
> > none of the if (insn->imm =3D=3D BPF_FUNC_...) in do_misc_fixups()
> > will match, so I think I see the path where get_func_proto() is
> > called.
> > But how does it work then for all cases of BPF_EMIT_CALL?
> > All of them happen after do_misc_fixups() ?
>
> yeah, I think most (all?) of them (e.g. map_gen_lookup) happens in
> do_misc_fixups which then does "goto next_insn;" to skip the
> get_func_proto().
>
> >
> > I guess we can mark such emitted call in insn_aux_data as finalized
> > and get_func_proto() isn't needed.
>
> It is a good idea.
>

Hmm, insn_aux_data has to be marked in gen_{pro,epi}logue since this
is the only place we know whether the call needs fixup or not. However
insn_aux_data is not available yet in gen_{pro,epi}logue because we
haven't resized insn_aux_data.

Can we do some hack based on the fact that calls emitted by
BPF_EMIT_CALL() are finalized while calls emitted by BPF_RAW_INSN()
most likely are not?
Let BPF_EMIT_CALL() mark the call insn as finalized temporarily (e.g.,
.off =3D 1). Then, when do_misc_fixups() encounters it just reset off to
0 and don't call get_func_proto().

