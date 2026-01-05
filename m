Return-Path: <netdev+bounces-247183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DAFCF55A3
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 20:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27BEF302E611
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 19:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E5F337B8C;
	Mon,  5 Jan 2026 19:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fCTjjgcJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73CF224B04
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767640858; cv=none; b=a4DQawCeuYKUwTO6530jZ1sQRCh6s6PgJRjFRBEykCTh1E1L7R5M5Kn+MV8aWUCT2n0hfl05/NmVTt13d4kNTcqOfR+LQhFLvdJZP86t0ATESMe3xxlYV0MJmr2zcToTrQSCjBhCveXwbaSHqxG7WNXs2MLgAVbHozFfdv54qNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767640858; c=relaxed/simple;
	bh=zWmlkCpYCem5h2W6ZMEQmSoZQDZCl40PFtOtFFUd0AY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SLZcTpGitQlsfa6nXcuMqShwBVE9idcoJM7qKc2Fvb1LJpbONSaSIEPbBP0F/ApEGLwLXQhQVXcsTynuvgLdEYXBfcfGzum77MwB+Xbt7gqBFe1XB6SKYgzGQBMR4Q012DjtjU1XY4rKZY9cE8slGM3Dhi5LxjbTFyoyQ+PpmXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fCTjjgcJ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b79ea617f55so55817566b.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 11:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767640855; x=1768245655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4y9De0l+kAUSbp+YogBkFSZA64WfTPRFGE8Yy+VLOo=;
        b=fCTjjgcJTKw9EMhYztqGqh2D9CeoCyZQBozpKcJp0v9kBiq31S2DWpkf8adgZg0A6F
         ZZbjQHJUdz0B9sG1YaYoOxKm+bftpVNbEt0phVjFkBzZfzNk224xDYALLKkAkDeYZ7mB
         OErFkmOqVW9a6yq9KUQ1ROFriDZv3vDVnL/oY8kYZnNcYC/EOi97ZxhSxZKNVvIwwI4I
         xOoilPr+mOPxiyFyYZLiPzaexwDZJo4ob89K4kZ/R8J9FAZGE3+IagrPgzgjhgD8pEcJ
         H3Kr9oBps1zF9WnfltgeOGnvPW8tY6tw5+pW9qe82VIGx7sb0uPMZ87zzz/CHpqfTbQS
         x+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767640855; x=1768245655;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v4y9De0l+kAUSbp+YogBkFSZA64WfTPRFGE8Yy+VLOo=;
        b=QjpwX+elh8aU5Pw9DMbjb722QLW3uu9M2mdvJKykemHwUbrnleudKBGNJKZAx9nflY
         IBhNB0aRbhL2lI2J2HTtecaLclHY0fxPykM5KXpqhwDWV+cw71sOynV8Xbkc4Ne7RrDG
         CqIW9wO8g5AdZfgt3Q57SZplx04hOVOa9Mrd0D5rVBl1fS6cJbPhVq+we9UrlWwQUbmT
         fLbAR9WAJ68vpzgBkFmGLYFW16Kvuvge/hul90kpJp2msWaNpzFPsjKTkZYq+aNHqn49
         71m73BX1rRvDkvF98VNAyr4BSANJxLiV2Y/f6cjU0w37v4UUyewaA812RgLcoX3DzPe0
         SN/g==
X-Forwarded-Encrypted: i=1; AJvYcCWsMjO0EAv1Oz0mWsFxBI4Ah8qswv0d66WxKMqXWRYkAZ7wAtCAdcNiq/36lGHeRlfDfbG+SEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgzWzmz36OWRkU3OnEmLnYsFicHg4Vz+C7UfAOSh3M/lQ1+rL9
	pDk9ley4ObQd18Dgf27xDkl3hAYx6tK/J4d+JxXLKoR7/v1s5WGGI+lLnfEtThqMVsA=
X-Gm-Gg: AY/fxX659OHPAhz1+XMbzSz28+/Y5qj/Ahsi4x90YM2Ddq9sUfzEmDs95El1lP2OtNY
	5Z6d62bP6WT/fGSGEa8vRN7SeiS92EzPyWr02++utbI91QiBhMI1/75geJtTmkCeDAOwo0GJ7RQ
	5/+uRJ64KM0xx/Uj4rwgMxK3x0rk66prIM1MRb73N3udaG1avQvrkz7wHkKjpvfNnGy04OYzy7G
	dlSSPzW5FjiTPp7/XzrKxC1AFtEmh4VJsgdxGL2lJHvrtCA8JIc5bBjD1djJaeDQl4un5kbRa9q
	NZ0N6feeobHuHKBJh4Q0cAlGkKM7hztldMzVTN3t/R1JJdZJ7OaqO2z2QnrCgFHnesn0pYrYHoG
	7L81p1cQiKX8wfzHaAj7v11pmzr45YmEz902N/6hEgBwxIe66gn4VHadjfjF0ESUGaCds2Ysjeb
	pcgkg=
X-Google-Smtp-Source: AGHT+IFLNAP5DWouoGjkq63VsxfmD7DfdBkDVZaHAp82JQppde6Bf0FPnRhFnmMQtmZCqJNVEl+f/w==
X-Received: by 2002:a17:906:7945:b0:b7f:fd02:9b4e with SMTP id a640c23a62f3a-b8426aa7960mr93851266b.28.1767640855248;
        Mon, 05 Jan 2026 11:20:55 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:f4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a56c552sm5760566b.68.2026.01.05.11.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 11:20:54 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>,  Martin KaFai Lau
 <martin.lau@kernel.org>,  bpf <bpf@vger.kernel.org>,  Network Development
 <netdev@vger.kernel.org>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Jesper Dangaard Brouer
 <hawk@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Simon Horman <horms@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Martin KaFai Lau <martin.lau@linux.dev>,
  Eduard Zingerman <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,
  Yonghong Song <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,
  Hao Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  kernel-team
 <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 15/16] bpf: Realign skb metadata for TC
 progs using data_meta
In-Reply-To: <CAADnVQJbGosoXOCdyi=NZar966FVibKYobBgQ9BiyEH3=-HOsw@mail.gmail.com>
	(Alexei Starovoitov's message of "Mon, 5 Jan 2026 11:14:32 -0800")
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
	<20260105-skb-meta-safeproof-netdevs-rx-only-v2-15-a21e679b5afa@cloudflare.com>
	<CAADnVQJbGosoXOCdyi=NZar966FVibKYobBgQ9BiyEH3=-HOsw@mail.gmail.com>
Date: Mon, 05 Jan 2026 20:20:53 +0100
Message-ID: <87bjj7988a.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 05, 2026 at 11:14 AM -08, Alexei Starovoitov wrote:
> On Mon, Jan 5, 2026 at 4:15=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.c=
om> wrote:
>>
>>
>> +__bpf_kfunc_start_defs();
>> +
>> +__bpf_kfunc void bpf_skb_meta_realign(struct __sk_buff *skb_)
>> +{
>> +       struct sk_buff *skb =3D (typeof(skb))skb_;
>> +       u8 *meta_end =3D skb_metadata_end(skb);
>> +       u8 meta_len =3D skb_metadata_len(skb);
>> +       u8 *meta;
>> +       int gap;
>> +
>> +       gap =3D skb_mac_header(skb) - meta_end;
>> +       if (!meta_len || !gap)
>> +               return;
>> +
>> +       if (WARN_ONCE(gap < 0, "skb metadata end past mac header")) {
>> +               skb_metadata_clear(skb);
>> +               return;
>> +       }
>> +
>> +       meta =3D meta_end - meta_len;
>> +       memmove(meta + gap, meta, meta_len);
>> +       skb_shinfo(skb)->meta_end +=3D gap;
>> +
>> +       bpf_compute_data_pointers(skb);
>> +}
>> +
>> +__bpf_kfunc_end_defs();
>> +
>> +BTF_KFUNCS_START(tc_cls_act_hidden_ids)
>> +BTF_ID_FLAGS(func, bpf_skb_meta_realign)
>> +BTF_KFUNCS_END(tc_cls_act_hidden_ids)
>> +
>> +BTF_ID_LIST_SINGLE(bpf_skb_meta_realign_ids, func, bpf_skb_meta_realign)
>> +
>>  static int tc_cls_act_prologue(struct bpf_insn *insn_buf, u32 pkt_acces=
s_flags,
>>                                const struct bpf_prog *prog)
>>  {
>> -       return bpf_unclone_prologue(insn_buf, pkt_access_flags, prog,
>> -                                   TC_ACT_SHOT);
>> +       struct bpf_insn *insn =3D insn_buf;
>> +       int cnt;
>> +
>> +       if (pkt_access_flags & PA_F_DATA_META_LOAD) {
>> +               /* Realign skb metadata for access through data_meta poi=
nter.
>> +                *
>> +                * r6 =3D r1; // r6 will be "u64 *ctx"
>> +                * r0 =3D bpf_skb_meta_realign(r1); // r0 is undefined
>> +                * r1 =3D r6;
>> +                */
>> +               *insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
>> +               *insn++ =3D BPF_CALL_KFUNC(0, bpf_skb_meta_realign_ids[0=
]);
>> +               *insn++ =3D BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
>> +       }
>
> I see that we already did this hack with bpf_qdisc_init_prologue()
> and bpf_qdisc_reset_destroy_epilogue().
> Not sure why we went that route back then.

Right. That's where I "stole" it from.

> imo much cleaner to do BPF_EMIT_CALL() and wrap
> BPF_CALL_1(bpf_skb_meta_realign, struct sk_buff *, skb)
>
> BPF_CALL_x doesn't make it an uapi helper.
> It's still a hidden kernel function,
> while this kfunc stuff looks wrong, since kfunc isn't really hidden.
>
> I suspect progs can call this bpf_skb_meta_realign() explicitly,
> just like they can call bpf_qdisc_init_prologue() ?

Thanks for pointing me in the right direction. Will rework this.

