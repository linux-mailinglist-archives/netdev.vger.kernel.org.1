Return-Path: <netdev+bounces-247892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD24D00436
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 23:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B98330031A2
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 22:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81A02FB630;
	Wed,  7 Jan 2026 22:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To8+gMxo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384202F7AAC
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 22:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767823286; cv=none; b=Kbf1Jl05bVjvp7j1wgqayzD46GHkKhWuu32bfGcZgmcL4YMt1w+VCppHIF7hStLcVB0fHBzH4haO2dtA9N46VRyRkrpR5tOSJdO4tp7vXCk6wFsKRQqehqdrZwSoM/i/WidPnEiUzCeWDg0J2dEmIv/7wWFce4S6o+EQew7VanA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767823286; c=relaxed/simple;
	bh=YYrgN1/4b3uYrEh9czfhj31efOuWQwyB0QIyz0KcNhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgZxXFeeqIpz8VE5WfkbfQZYPjCRJzjkIzpatLLSKGCwgwcZNUUZJPVXz+0F17W+Ld3SLgAHboYJDKhJQGTIeDDgTKykWG89lTKmEAVRW+94bRX09yUxVX9MIi9tOSLU2Tre+vfNMpLSL9ruvQoDOfUAQkhvpeUnRjEc1rH1qe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=To8+gMxo; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42e2d02a3c9so1894450f8f.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 14:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767823283; x=1768428083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbVOCVA3+xNf5U98se1N6HGmg+GeYqwwN9lCOLrIIo0=;
        b=To8+gMxobzuLscpw/eDYAGxxjrtwz9Oun/PI7aSPVNNC/FBK1deLZNK9+CveqpBgGr
         7g2+ydAjL+Xr6Lmn6n2PF+uLK8fB2/6TJem/pNY+H+5TVd7EqAgdTrKMZ/gL8EtI0T63
         St2tLgSQEyGX8dxi8FxvWWivZpJRSy0imDcO3aPMTzvXoyGWEDVYkY7/0+2VmNc3ymUV
         l5JEUiD+AZnm891H6nd+q2h05xPOglt0BgTh+ZR0ozID4qg/XI0mdGUIZZzKIhA7t7d0
         bzt5RrsxvbanZWWE5R2WImDhoY11IPOyspsbF77Ok6DoPy5PhTUA29srTIxLvlFk0MgA
         253g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767823283; x=1768428083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PbVOCVA3+xNf5U98se1N6HGmg+GeYqwwN9lCOLrIIo0=;
        b=pckejT5reMdcl5ucUfvegUPVGwQ+iH7pK8K7Nk8ECmvu7IUh72lr7PJeoNm5ma+5CS
         bWtBAnJF5jxbPEOR73US3TdhL3oM7FbmJ4a91x2E0uSf7ZtdzM30OkyNs6rQyQ4lpUB6
         gXQDZVCDNbwRZzYo5dPzAwOeTF5m2+5sXkEKH4apC8qCao8gNfg11tVmt/d+UqAtmuPr
         Rqpbpri1Xim6VACwNjx1YBXZ0m8+Pbee0CEQ6rXbEqgX2Vbb+FTOd9oO+WKnbzC5+g/K
         AsXDaDdT69g8jlerc9hXQI/G0yzMEkG6Y10v9XsblbqPAyRm/gzdNoLCw3P10iCqnRaL
         R9aA==
X-Forwarded-Encrypted: i=1; AJvYcCWnEjIjhRmZ85w/ObmntVMNCHiGSIutHYl4Zj40oBkUQxQDp3+lDDAAzIevJ2mdI67nNhIJG78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT2hM+B3hkdEMslSt/gpHfHYZPzuL5lzRna00arWs2vW0gu5/E
	mZcbjx3BeaC2vbDqG59dshC/R6HPvLkPDR/L5/u7YB3wP4Tn3g8TGZtG7reVA5XvqooDd1tjyoB
	FFI5WQkJcDJbzcss9SAI4kI3mJ0fmenc=
X-Gm-Gg: AY/fxX6CGpXnbPbdwqFAdI/6T+S6LYc7JEd6eAw5jRTt91+HCF/zEGLEjy4Fwkafhlj
	xfTRWZyM9JmBiTNVQ+AjCeptzQqMXniwJHojGr3u9legkLDWRFeASy8hLZrzbI7Lw0ohvdrv5DZ
	afWGjnBkwF1W5Vli0gcQF6KcoT8YV01q6rTtWguiDW6grMA1miiuetzuGq7Jy8ODfIFo/0jeRV4
	2UHfigxYkh/o+RyzAOyr7As27FVqwfL5FfNWqx/bA04Kh+UFACNj8LbE/jT36sbRJ+yFSW627+Q
	oR+TmNElLOj8tEt9QJ1r0J304zFw
X-Google-Smtp-Source: AGHT+IEdyOPZbDPif6fAIcsc+jEyvHVzWI1qQCxKOJRLKNXGewKU26ff6NB16EAqwPwYvPeC/wTX3Z8ltq/NDljKPKQ=
X-Received: by 2002:a05:6000:2287:b0:431:5ac:1fc with SMTP id
 ffacd0b85a97d-432c3790890mr5108810f8f.14.1767823283308; Wed, 07 Jan 2026
 14:01:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
 <20260107-skb-meta-safeproof-netdevs-rx-only-v3-16-0d461c5e4764@cloudflare.com>
In-Reply-To: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-16-0d461c5e4764@cloudflare.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 7 Jan 2026 14:01:12 -0800
X-Gm-Features: AQt7F2rZVzSbDVPQ7QFEgQKdB5_5SNHGgDXI0efgoxcd0dCh3XETY7iDFndTT_M
Message-ID: <CAADnVQKR9Myx_ervEzNihoWm=6=_B4LebPhPezm9rOSReE1bjQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 16/17] bpf: Realign skb metadata for TC progs
 using data_meta
To: Jakub Sitnicki <jakub@cloudflare.com>
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

On Wed, Jan 7, 2026 at 6:28=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.com=
> wrote:
>
>
> +static void bpf_skb_meta_realign(struct sk_buff *skb)
> +{
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
> +               BUILD_BUG_ON(!__same_type(&bpf_skb_meta_realign,
> +                                         (void (*)(struct sk_buff *))NUL=
L));
> +               *insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
> +               *insn++ =3D BPF_EMIT_CALL(bpf_skb_meta_realign);

Not quite. drop this BUILD_BUG_ON(), since it's pointless and misleading.
bpf_skb_meta_realign() has to be the one done with BPF_CALL_1(...).
Otherwise above will work only on x86.
In this case on arm64 too, but it's by accident.
BPF_CALL* has to do ABI conversion from BPF to native.

For kfuncs that's what JITs do via btf_func_model machinery.

pw-bot: cr

