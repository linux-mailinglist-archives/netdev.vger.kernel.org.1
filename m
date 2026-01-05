Return-Path: <netdev+bounces-247182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AA848CF551C
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 20:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 266383009D49
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 19:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA1433FE0A;
	Mon,  5 Jan 2026 19:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHMP1+F3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191163090FB
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767640486; cv=none; b=ByDhu9d8IXMKlc9SqbJZxzOxKQwzS/+gT9Eneqq/nOn7Ov/EtK5CgiTdLEDyrHIGnmnmv4KISyxvSE9DYeik5L4QcNSqVYGn7RCO7C9RzQTlXMSJ5HtXwIgirKYX7Iz0uvksx9c+sOTWas0/vVAmgcmtfCCWg44q5cu3qvDkpgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767640486; c=relaxed/simple;
	bh=vbD6KpPmlOSY4oMKN6CzZa9VmQ/pu2paqrb7C9WKYBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmBJpWsAVN8f3ZfmV073uUOIWrGUc+EImhJXFLqdO1VbDP5FELqQyRD0F7a5Ekv4jYCBF1yk4u2EtdtGppBD1k4tzJG8Z168hjuk5toY1X2QtKyDW5uN+aU69wEQNVgPYx8Yo+VYPXbJqgWyhKoQbC9yEYJ8EL+fZx335aNpE1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHMP1+F3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4775ae77516so2716985e9.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 11:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767640483; x=1768245283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuboypouASyDyCh3W81iGlwUfqZjwq3w6T/f9mhZrd4=;
        b=KHMP1+F30apmlTqbtgTM4ou9zL0l2G9aO9aJk4Gnd5bSDhKT2zG5izuYoH1eddOY84
         KpC0UhCgQOfh0zNQsuUD2J62woIsIejLD4h+yrcfX1IfGww9x7gDDX348YaasR7Lmfrt
         DDpbh/eyoW3XNojOw/BfJZuNITKEptRo2eMzjrgBiPde6TD3P/oXQ37/tB+HGP4kQDb+
         Pnijq1OQhu1/58efusssIQuiXWYouNe9YMNnhWmQFpqEJdSzl8PUsOUCvXZHAT5cxdhY
         auZZDw6QyPKyL22NSf3rMWaeSSCxAkJpO3NxnAqLNdif9kDlRzq/bfSlwlQYrpOvMrWI
         RUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767640483; x=1768245283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VuboypouASyDyCh3W81iGlwUfqZjwq3w6T/f9mhZrd4=;
        b=H4sTr7WItoVYfrnT3S0CdY+R6CgzSpA0dK5j32EZG2JiHfXj1xAstC88s8oYcQ/PYy
         cXvKcLS5cvVA7+y8ngeUtnY6cYsdt1sqGFZg5ayJoiqSYtYQb7QrldaBywTq+0IbbihZ
         Cq3+IPU/SKH/c0AOonLw5O1XUNFoEEWWwUC1eWliNrdIGYOLPjh93DoZ99uOE/YM+oyL
         /cbNjMConc2PDNay9ovymln93VYfZCVAjoJYoOcqOhpC9ZgPqCqcoUk0EbY4Y4C0r48O
         hjbNjPVg/TgJYj3rvDUyy1HZc4kNGXi+1IvXkDobINWGwJyYi11CY5gIYsN/qhwhRHSc
         5ljw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ1NPDZjByjypW3F2TbZCS48ZlLBtZcSybK9l8Yk38HLMiluJP9bps9Us1lMPiSCcPBCZ22gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO3sqpSlPQV2t1zAn+arWp+B8sdn4lpG8Ub8rcXxLbvWr7kbLq
	nEpJrj240gzbsa1wcj9i0Mhx5Xu6/20Dn69aYZo98VyNcGbrYKwrAVgbiYkRccHMzmq8HyTlE8p
	yIXI3NtMhOUouuuvk9I9xHAys/YSbCck=
X-Gm-Gg: AY/fxX6NVzaQa/LbVKdSX5HDui7vJuzMFbxHBREn7XmmAWu4TSSFvy3lrni0jX/XV+t
	pLvUL9dPaE8fr8MIqP1SKeTkPYmw1PFVIIlZGujOwfc4NeYWkmc030HZkGy69Q/Sqf3PjoaNYI+
	rSyA8y+TlmG/vk66D8akxg1nGB+tbQyn6umN3W4TED8XezVxHXxXIkioakCx4fm5d28I01Bjvwz
	1k5tM/MyTIGKPshMm/nKxVczrkMjkIAKqeYnydnD6fUpHaUCFNFEbgNJ06fAv7fG7cs2teEIWbe
	8m0EaE7pSbuRwNseqvZWZ7Z7eSzogTa4c4lX
X-Google-Smtp-Source: AGHT+IFKltkBwdtJWMmkxlddfHl2o4PRkSDN7V77CF02lxRkBqtvUJHajyKHPAucGIuMeD9ZVOROazg8QLUu1aqeT78=
X-Received: by 2002:a05:600c:a16:b0:477:58af:a91d with SMTP id
 5b1f17b1804b1-47d7f06b874mr5768335e9.5.1767640483349; Mon, 05 Jan 2026
 11:14:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
 <20260105-skb-meta-safeproof-netdevs-rx-only-v2-15-a21e679b5afa@cloudflare.com>
In-Reply-To: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-15-a21e679b5afa@cloudflare.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 Jan 2026 11:14:32 -0800
X-Gm-Features: AQt7F2r1fUZRdG3Uaw-m_HzY97lQuIogtGOtsqJSYvnBmd2txIQ_Y10cum8_WBI
Message-ID: <CAADnVQJbGosoXOCdyi=NZar966FVibKYobBgQ9BiyEH3=-HOsw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 15/16] bpf: Realign skb metadata for TC progs
 using data_meta
To: Jakub Sitnicki <jakub@cloudflare.com>, Amery Hung <ameryhung@gmail.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
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

On Mon, Jan 5, 2026 at 4:15=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.com=
> wrote:
>
>
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc void bpf_skb_meta_realign(struct __sk_buff *skb_)
> +{
> +       struct sk_buff *skb =3D (typeof(skb))skb_;
> +       u8 *meta_end =3D skb_metadata_end(skb);
> +       u8 meta_len =3D skb_metadata_len(skb);
> +       u8 *meta;
> +       int gap;
> +
> +       gap =3D skb_mac_header(skb) - meta_end;
> +       if (!meta_len || !gap)
> +               return;
> +
> +       if (WARN_ONCE(gap < 0, "skb metadata end past mac header")) {
> +               skb_metadata_clear(skb);
> +               return;
> +       }
> +
> +       meta =3D meta_end - meta_len;
> +       memmove(meta + gap, meta, meta_len);
> +       skb_shinfo(skb)->meta_end +=3D gap;
> +
> +       bpf_compute_data_pointers(skb);
> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(tc_cls_act_hidden_ids)
> +BTF_ID_FLAGS(func, bpf_skb_meta_realign)
> +BTF_KFUNCS_END(tc_cls_act_hidden_ids)
> +
> +BTF_ID_LIST_SINGLE(bpf_skb_meta_realign_ids, func, bpf_skb_meta_realign)
> +
>  static int tc_cls_act_prologue(struct bpf_insn *insn_buf, u32 pkt_access=
_flags,
>                                const struct bpf_prog *prog)
>  {
> -       return bpf_unclone_prologue(insn_buf, pkt_access_flags, prog,
> -                                   TC_ACT_SHOT);
> +       struct bpf_insn *insn =3D insn_buf;
> +       int cnt;
> +
> +       if (pkt_access_flags & PA_F_DATA_META_LOAD) {
> +               /* Realign skb metadata for access through data_meta poin=
ter.
> +                *
> +                * r6 =3D r1; // r6 will be "u64 *ctx"
> +                * r0 =3D bpf_skb_meta_realign(r1); // r0 is undefined
> +                * r1 =3D r6;
> +                */
> +               *insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
> +               *insn++ =3D BPF_CALL_KFUNC(0, bpf_skb_meta_realign_ids[0]=
);
> +               *insn++ =3D BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
> +       }

I see that we already did this hack with bpf_qdisc_init_prologue()
and bpf_qdisc_reset_destroy_epilogue().
Not sure why we went that route back then.

imo much cleaner to do BPF_EMIT_CALL() and wrap
BPF_CALL_1(bpf_skb_meta_realign, struct sk_buff *, skb)

BPF_CALL_x doesn't make it an uapi helper.
It's still a hidden kernel function,
while this kfunc stuff looks wrong, since kfunc isn't really hidden.

I suspect progs can call this bpf_skb_meta_realign() explicitly,
just like they can call bpf_qdisc_init_prologue() ?

cc Amery, Martin.

