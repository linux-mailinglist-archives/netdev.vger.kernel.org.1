Return-Path: <netdev+bounces-247188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CF2CF5747
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 21:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AEF43061285
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 20:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF073074B1;
	Mon,  5 Jan 2026 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5KOezfG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978802773C3
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 20:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767643349; cv=none; b=IukPXLDxB3qDdynwHLyjHo4jQ0xRP0i4bap/IcoMXqt1178dYPJmujtgG8gnjn1H6cNVsEsVGcjl8pue5wtL9msnU4yKYk+KheiqPAFizXe6NlHy4k4LqmPw2jRhR+wtRx2bhEt5yO+0JDCILxnaNVR13/PMuScqWaqMJfIGSPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767643349; c=relaxed/simple;
	bh=YQegPKcrMegEgLOVkMKugSgpWYEmPKvwTHFMUlsTBjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J23mgDVQ/bIhKM4oRbxJyEdciu5UhOiaegsUO+ziBQU22ezhzbuiJGQddCROV176zT0J9WeM8HHr8uVNvk+WVPAP/2bVTaIAy+A/nbJ8kXkg/EpIRkuk/jNxgFA8cm0gvTJFVZ+uGxdJqEaqm2G7tduMoIMcUxx1KMWHitzcLtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5KOezfG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so163417f8f.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 12:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767643346; x=1768248146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDlwYF2Xh46taUcCYeQ6K3i+m7OgRE8a63amvp2cLqM=;
        b=E5KOezfGj3gP2oWNLagJavAea6J6hk54Kd6YXFrzfqK0NcrdKvDVAIn53MH75lRNJ1
         g7+/VepC9SR3zAaCTZF3ZF4m8OirYnBLFt8w712C0RSoXJkQzH+ciRlclweTTFnitOfq
         NT+13tGziITLENv5dEkjbWZkbizHoM9Rj4NBn6cqSbAaWTF9rq/mgKi6Vt6jZAP2sdAo
         0zqNyXV9TVKIA8kpGvFiF6o7fz0ae0bC5aqUQhDJGMOMp1wctZMVps+vYS1yu0DIB745
         X2nfRAZrtqPpMRZliJpWmaSjNLGE0Sm1Kdb7x95W4TSA5rgnWV2q3DC2eP/V/MQidmWk
         FcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767643346; x=1768248146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nDlwYF2Xh46taUcCYeQ6K3i+m7OgRE8a63amvp2cLqM=;
        b=KZjvNDNOxuDbfY8uD0YpB93pRouxAfziSM3yc3GzIziJH2JxPr2YpBiQImKcyaa64j
         sqMIkPL6ojaTPjK1DwcabHgWEKlZ3HN6eqo5txwW5yyRe53ZafOPn5yruN+t4o3Vhh7y
         BPm4zHMaZ9QpDQzBjoi7P0JchnbREJ7W6Kp/vI+EzsOOMObOuIbT3E7kA81SjdP4rwt3
         z5EG34umT8325iIQsU8j510Fxvtmn1K55uSTa7XpleVqAAapXVsmGovFr8guk4azVoKJ
         eQi/PnjKCHWhgO/9t6bIb5muRPvITwEy1ZK0SCDyrUavhFd4OmdDXuop0bMwmvXZpvQU
         HCdA==
X-Forwarded-Encrypted: i=1; AJvYcCUwvuyg3T6cSvni5+nE6XU++yVGngkMaqOO6nMfqDXmLZ5XVMAekaaOp9l2j9+2NluhcRiE4EE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2mi9eL+BjRW6zxQNLhURA+lBYZS3+8SasQZLLl4UOYto79uIZ
	HMmp4rxsT96MA8L0YV5f26LG0aE7ywFvrQKSjhidFzF8teKa30z2j4lnzwlE4coEkhT4dpOQnYx
	/HID0y8WmeEww9I1NsPkEP8vX8+JfgQY=
X-Gm-Gg: AY/fxX7tOZB24dD23UTMvTfiH7xFd++vG5zpRzl1ALiWwSon9UD0LwjXBIMKL+RU3Yx
	OMft+V6eVbv5Vd3d/sMqFdPBNH1kDlCwxYpfarhbMpVIn3x6U8hP2Ft7XJGtdUOG4ZBrftpAqL1
	Dy0OnGne+aokmcTOEwUi3eHhaeA5I1Hl/Sx/Dh3mdtY68YVKLSPdlpTFoI9hiQdmOOAVs41IyF2
	F3BcGvTd/RqAxMSJheYiCi64ej1QWkiZrpNQrmAY9kNUUekXE1fMl2Dkhnj0nS04nr3IV+gQWyn
	zWnFjQ00mgPGHPs4zqJ6iqTOkdak
X-Google-Smtp-Source: AGHT+IHOnAg/ShTG5AnQyQZ1FnOjL633CK7YbUZ/C/RRFmc6h8tN7ObCBxJ3Km5eFhRyY44j7FfPae+CWlYu2VzgYIY=
X-Received: by 2002:a05:6000:178f:b0:42f:bc61:d1bd with SMTP id
 ffacd0b85a97d-432bca525d4mr1214985f8f.45.1767643345605; Mon, 05 Jan 2026
 12:02:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
 <20260105-skb-meta-safeproof-netdevs-rx-only-v2-15-a21e679b5afa@cloudflare.com>
 <CAADnVQJbGosoXOCdyi=NZar966FVibKYobBgQ9BiyEH3=-HOsw@mail.gmail.com> <CAMB2axPivi+mZOXie=VnJM8nscqkHDjSrKT=Dhp5z_copEwxLQ@mail.gmail.com>
In-Reply-To: <CAMB2axPivi+mZOXie=VnJM8nscqkHDjSrKT=Dhp5z_copEwxLQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 Jan 2026 12:02:14 -0800
X-Gm-Features: AQt7F2qM8D-DQgNbBk6KF3eJYStgwWlZZnJYNEuUw080W31rVtOLsWe26-INukE
Message-ID: <CAADnVQJ_hwMM0F-Fm=ELbk0-5q_AojRAjs_CyWKEjv9NdfJsQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 15/16] bpf: Realign skb metadata for TC progs
 using data_meta
To: Amery Hung <ameryhung@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 11:43=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Mon, Jan 5, 2026 at 11:14=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Jan 5, 2026 at 4:15=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare=
.com> wrote:
> > >
> > >
> > > +__bpf_kfunc_start_defs();
> > > +
> > > +__bpf_kfunc void bpf_skb_meta_realign(struct __sk_buff *skb_)
> > > +{
> > > +       struct sk_buff *skb =3D (typeof(skb))skb_;
> > > +       u8 *meta_end =3D skb_metadata_end(skb);
> > > +       u8 meta_len =3D skb_metadata_len(skb);
> > > +       u8 *meta;
> > > +       int gap;
> > > +
> > > +       gap =3D skb_mac_header(skb) - meta_end;
> > > +       if (!meta_len || !gap)
> > > +               return;
> > > +
> > > +       if (WARN_ONCE(gap < 0, "skb metadata end past mac header")) {
> > > +               skb_metadata_clear(skb);
> > > +               return;
> > > +       }
> > > +
> > > +       meta =3D meta_end - meta_len;
> > > +       memmove(meta + gap, meta, meta_len);
> > > +       skb_shinfo(skb)->meta_end +=3D gap;
> > > +
> > > +       bpf_compute_data_pointers(skb);
> > > +}
> > > +
> > > +__bpf_kfunc_end_defs();
> > > +
> > > +BTF_KFUNCS_START(tc_cls_act_hidden_ids)
> > > +BTF_ID_FLAGS(func, bpf_skb_meta_realign)
> > > +BTF_KFUNCS_END(tc_cls_act_hidden_ids)
> > > +
> > > +BTF_ID_LIST_SINGLE(bpf_skb_meta_realign_ids, func, bpf_skb_meta_real=
ign)
> > > +
> > >  static int tc_cls_act_prologue(struct bpf_insn *insn_buf, u32 pkt_ac=
cess_flags,
> > >                                const struct bpf_prog *prog)
> > >  {
> > > -       return bpf_unclone_prologue(insn_buf, pkt_access_flags, prog,
> > > -                                   TC_ACT_SHOT);
> > > +       struct bpf_insn *insn =3D insn_buf;
> > > +       int cnt;
> > > +
> > > +       if (pkt_access_flags & PA_F_DATA_META_LOAD) {
> > > +               /* Realign skb metadata for access through data_meta =
pointer.
> > > +                *
> > > +                * r6 =3D r1; // r6 will be "u64 *ctx"
> > > +                * r0 =3D bpf_skb_meta_realign(r1); // r0 is undefine=
d
> > > +                * r1 =3D r6;
> > > +                */
> > > +               *insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
> > > +               *insn++ =3D BPF_CALL_KFUNC(0, bpf_skb_meta_realign_id=
s[0]);
> > > +               *insn++ =3D BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
> > > +       }
> >
> > I see that we already did this hack with bpf_qdisc_init_prologue()
> > and bpf_qdisc_reset_destroy_epilogue().
> > Not sure why we went that route back then.
> >
> > imo much cleaner to do BPF_EMIT_CALL() and wrap
> > BPF_CALL_1(bpf_skb_meta_realign, struct sk_buff *, skb)
> >
> > BPF_CALL_x doesn't make it an uapi helper.
> > It's still a hidden kernel function,
> > while this kfunc stuff looks wrong, since kfunc isn't really hidden.
> >
> > I suspect progs can call this bpf_skb_meta_realign() explicitly,
> > just like they can call bpf_qdisc_init_prologue() ?
> >
>
> qdisc prologue and epilogue qdisc kfuncs should be hidden from users.
> The kfunc filter, bpf_qdisc_kfunc_filter(), determines what kfunc are
> actually exposed.

I see.

> BPF_CALL_x is simpler as there is no need for a kfunc filter to hide
> it. However, IMO for qdisc they don't make too much difference since
> bpf qdisc already needs the filter to limit .enqueue and .dequeue
> specific kfunc.
>
> Am I missing anything?

Just weird to have kfuncs that are not really kfunc.
A special bpf_qdisc_init_prologue_ids[] just to call it, etc
BPF_EMIT_CALL() is lower cognitive load.

