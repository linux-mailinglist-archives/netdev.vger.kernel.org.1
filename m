Return-Path: <netdev+bounces-247200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 795A2CF5B57
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 22:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B0DB3029C39
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 21:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A50311596;
	Mon,  5 Jan 2026 21:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XROA+U9K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651CF280331
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 21:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767649651; cv=none; b=oEflHMmqXRRfdZ83iiKhUegGp31d7GW07n+KGBdnm/k5einla/eF+qt/o2oMgWYNua2+IJFz4z1CDp+RFoxErM3qM+oNpNKDg0SZcTwZPyDI2mLNwp/GjdsvKrwu2uq/NZHTAW/xHdQ43RAil3wStLE+nnEvYkXK+Ia02laIF7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767649651; c=relaxed/simple;
	bh=qM1B9p/5IU0Ae7tEVMl3F0TO7zTjn4dRquCSdiD9Eoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPGMNUTZAjd6pPDekO353+GqS5CgPocR0ruOo46ODPUwU91EYGmPxZc1d7rZpCkn3I4aSIYnSBFwkgaONagvOO2AlmwGxokn0rc6wH9Ne35kEyT21LYyIFNkA3RPDzOZN8+XMCVa7YjkNJ7XpF2XtYuKgl7QaNFVcHoQSrerMQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XROA+U9K; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so243599f8f.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 13:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767649648; x=1768254448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTTD7iyccpWiIa9PfLHfnFVUKadxKYnWZzPs73FN+wc=;
        b=XROA+U9KjY+MODHLCpXFdnZHLAtdz236eTHNPld4HrgeCgXOHYiouRS+S4qqdcvCx4
         4z5Q7skq/glomBVsH0bEIH3RBwDuf3HtVEHnEp7vOVM+f0O23N36vE6GGH89noMdp/zX
         bBBtZquppx517g1coeq76PEGd1SukCqxUYnJfCamA9CPSd1htFhsqQnqraYzbIx4K5h9
         Gr9y7a0XKOiKAc+frPX2DuLzDqtgTl5KYfas1OrQY0gmP1avPoSbKxoCtF83W3YoeEal
         683zE08CY0LGhqM8+ocsQ36QAgSyBnVkAHCbwHn2ZqUebJ/z1/bpyYdbkEfUT3A6P6Cz
         pXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767649648; x=1768254448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cTTD7iyccpWiIa9PfLHfnFVUKadxKYnWZzPs73FN+wc=;
        b=HQ1aY0fuoU+HxqTTmG0DpvVmQex8Qsj/A5V/Y5KVY08dSo+Xc8Rx74ajE+5RPJ/OaH
         rxCQ0GvV32/gF1gF4K1m3qt2wrEKUTFGp5AnV0+drylfs9gpMomu+NYLew+FXxNJ5eT8
         7C/ECx62C8aUfcxjUU60bHYEQ5k3egXU/iPD9F+gi47Xo2wHUa8pmyqL4HoHGmp2Y6at
         LMYG5sXJ9rp+kN7AT+BqJB4adDqtP334mrR1q3LPvkYX2dhDH+Qze5OLGpSKA/VwsIwN
         O7G+DSDglHUZFQzdiJdoB5ecOGQZcxeorzVN/IXT7dET0JjNdEqTiRJrne3bUxJTvMEb
         KaDA==
X-Forwarded-Encrypted: i=1; AJvYcCVvD67fEYCfbp5v9yRzGofIhAPGdXLD0N6ox3Z0/+/k7UDkcUVzMGm+MaRsn3s52qvoe2eDW/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDAxvYcUO2lqRvcZG7JO7QGt8Jk5a+gsJoMliSNvWLdv+sC95t
	BSZlSlMHVxKxiEZ4phAyJHlxxnKvCPVFZEyhBb0VO8fFXsPcvdthCqxfPm7WUMlNeYIsWLKlks0
	RFiHsVgPopJHoidhscBczghJwHUrbDKs=
X-Gm-Gg: AY/fxX4yb1m4QL3iLFI5P2TEiU6nRIcQdsU0PYlkVEKw6q8nJdGUakJPJsY/CIjZAEv
	mtWy7V2kUg5yymMiWE+IKHqy1PRorpi4lPP9MGXXRmlUxNzOMhvcvUMTx4UzmvR9PHR3X5vXs/w
	mUz754Sp+VLKsjyYAwUt96ViyeG5kXgZOrkM+BJAdtQ6Assx4o0PtxvmM8j/YUbA+aNLLRQzTr5
	caWJbdCb8+ByhJqTm7M5QM8WZNQqbg6E4bcEqoqq1+SMrc1irEeOu6hW3+7Jn9+/rB5oykk7k6+
	91eJ5ntkxMrqXd/4QNlJgVQ+LOCT
X-Google-Smtp-Source: AGHT+IHRNLXcqHWBcMprz3rQXt49jSbfW+beSjoy1/f6KZrC9ix/HWRrPMAuLI1g7BTof2V3aX2XakzPU/cFLgS7Xe0=
X-Received: by 2002:a05:6000:3108:b0:42b:3b62:cd86 with SMTP id
 ffacd0b85a97d-432bca18987mr1309690f8f.6.1767649647539; Mon, 05 Jan 2026
 13:47:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
 <20260105-skb-meta-safeproof-netdevs-rx-only-v2-15-a21e679b5afa@cloudflare.com>
 <CAADnVQJbGosoXOCdyi=NZar966FVibKYobBgQ9BiyEH3=-HOsw@mail.gmail.com>
 <CAMB2axPivi+mZOXie=VnJM8nscqkHDjSrKT=Dhp5z_copEwxLQ@mail.gmail.com> <e969a85c-94eb-4cb5-a7ac-524a16ccce01@linux.dev>
In-Reply-To: <e969a85c-94eb-4cb5-a7ac-524a16ccce01@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 Jan 2026 13:47:16 -0800
X-Gm-Features: AQt7F2rdjlSyN4qFfp63S5pz7wqdp9Ujg0XhM9kloQzz_9bsqHM6ukfRg475F2g
Message-ID: <CAADnVQKB5vRJM4kJC5515snR6KHweE-Ld_W1wWgPSWATgiUCwg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 15/16] bpf: Realign skb metadata for TC progs
 using data_meta
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Amery Hung <ameryhung@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
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

On Mon, Jan 5, 2026 at 12:55=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
>
>
> On 1/5/26 11:42 AM, Amery Hung wrote:
> > On Mon, Jan 5, 2026 at 11:14=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Mon, Jan 5, 2026 at 4:15=E2=80=AFAM Jakub Sitnicki <jakub@cloudflar=
e.com> wrote:
> >>>
> >>>
> >>> +__bpf_kfunc_start_defs();
> >>> +
> >>> +__bpf_kfunc void bpf_skb_meta_realign(struct __sk_buff *skb_)
> >>> +{
> >>> +       struct sk_buff *skb =3D (typeof(skb))skb_;
> >>> +       u8 *meta_end =3D skb_metadata_end(skb);
> >>> +       u8 meta_len =3D skb_metadata_len(skb);
> >>> +       u8 *meta;
> >>> +       int gap;
> >>> +
> >>> +       gap =3D skb_mac_header(skb) - meta_end;
> >>> +       if (!meta_len || !gap)
> >>> +               return;
> >>> +
> >>> +       if (WARN_ONCE(gap < 0, "skb metadata end past mac header")) {
> >>> +               skb_metadata_clear(skb);
> >>> +               return;
> >>> +       }
> >>> +
> >>> +       meta =3D meta_end - meta_len;
> >>> +       memmove(meta + gap, meta, meta_len);
> >>> +       skb_shinfo(skb)->meta_end +=3D gap;
> >>> +
> >>> +       bpf_compute_data_pointers(skb);
> >>> +}
> >>> +
> >>> +__bpf_kfunc_end_defs();
> >>> +
> >>> +BTF_KFUNCS_START(tc_cls_act_hidden_ids)
> >>> +BTF_ID_FLAGS(func, bpf_skb_meta_realign)
> >>> +BTF_KFUNCS_END(tc_cls_act_hidden_ids)
> >>> +
> >>> +BTF_ID_LIST_SINGLE(bpf_skb_meta_realign_ids, func, bpf_skb_meta_real=
ign)
> >>> +
> >>>   static int tc_cls_act_prologue(struct bpf_insn *insn_buf, u32 pkt_a=
ccess_flags,
> >>>                                 const struct bpf_prog *prog)
> >>>   {
> >>> -       return bpf_unclone_prologue(insn_buf, pkt_access_flags, prog,
> >>> -                                   TC_ACT_SHOT);
> >>> +       struct bpf_insn *insn =3D insn_buf;
> >>> +       int cnt;
> >>> +
> >>> +       if (pkt_access_flags & PA_F_DATA_META_LOAD) {
> >>> +               /* Realign skb metadata for access through data_meta =
pointer.
> >>> +                *
> >>> +                * r6 =3D r1; // r6 will be "u64 *ctx"
> >>> +                * r0 =3D bpf_skb_meta_realign(r1); // r0 is undefine=
d
> >>> +                * r1 =3D r6;
> >>> +                */
> >>> +               *insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
> >>> +               *insn++ =3D BPF_CALL_KFUNC(0, bpf_skb_meta_realign_id=
s[0]);
> >>> +               *insn++ =3D BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
> >>> +       }
> >>
> >> I see that we already did this hack with bpf_qdisc_init_prologue()
> >> and bpf_qdisc_reset_destroy_epilogue().
> >> Not sure why we went that route back then.
> >>
> >> imo much cleaner to do BPF_EMIT_CALL() and wrap
> >> BPF_CALL_1(bpf_skb_meta_realign, struct sk_buff *, skb)
> >>
> >> BPF_CALL_x doesn't make it an uapi helper.
> >> It's still a hidden kernel function,
> >> while this kfunc stuff looks wrong, since kfunc isn't really hidden.
> >>
> >> I suspect progs can call this bpf_skb_meta_realign() explicitly,
> >> just like they can call bpf_qdisc_init_prologue() ?
> >>
> >
> > qdisc prologue and epilogue qdisc kfuncs should be hidden from users.
> > The kfunc filter, bpf_qdisc_kfunc_filter(), determines what kfunc are
> > actually exposed.
>
> Similar to Amery's comment, I recalled I tried the BPF_CALL_1 in the
> qdisc but stopped at the "fn =3D env->ops->get_func_proto(insn->imm,
> env->prog);" in do_misc_fixups(). Potentially it could add new enum ( >
> __BPF_FUNC_MAX_ID) outside of the uapi and the user space tool should be
> able to handle unknown helper also but we went with the kfunc+filter
> approach without thinking too much about it.

hmm. BPF_EMIT_CALL() does:
#define BPF_CALL_IMM(x) ((void *)(x) - (void *)__bpf_call_base)
.imm   =3D BPF_CALL_IMM(FUNC)

the imm shouldn't be going through validation anymore.
none of the if (insn->imm =3D=3D BPF_FUNC_...) in do_misc_fixups()
will match, so I think I see the path where get_func_proto() is
called.
But how does it work then for all cases of BPF_EMIT_CALL?
All of them happen after do_misc_fixups() ?

I guess we can mark such emitted call in insn_aux_data as finalized
and get_func_proto() isn't needed.

