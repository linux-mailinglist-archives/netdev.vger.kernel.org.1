Return-Path: <netdev+bounces-248255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 650DED05F00
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 20:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E16B4302AB96
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 19:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83653321428;
	Thu,  8 Jan 2026 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HyKBO1G1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83C231B815
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 19:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767902099; cv=none; b=rIxsTpf+PDOUOySR3v8zj2rLnszXcLZFiPlSZwIMJaCHJzbaG/Ny4D8ETczAxvJed9SNj1oJ6n2cmM7NsoItk9SpDNsOPWpgYhH30SBmTMpJPddHO0u9Y/krZFKQktlOiL6LPoiIMPTvg+sHm2rJB+5LgwBm2VKeLBwMPqFXHhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767902099; c=relaxed/simple;
	bh=Ueg/uK/VwM5WDV0ZDNriuLOQACaUCKN531srjWgt3zE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pq9DPS8Yg8R+OmB6+K9WK7/HdBrmaRfgz9SrKFdGIy3SigwF+TLfDKlmW20m7eogsn0az4kAXJ6vDTgM0O5jgj0P2wpebwc4RV6TIVwacSuGMimTYeAxuMAWs/O8A/bxQlhrOwv80VDKFg+FRNuzLMfVQ8JzDGsZvV2qZqYbpvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HyKBO1G1; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64d02c01865so5737267a12.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 11:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767902096; x=1768506896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2qTtzY0pedb8FPcFYKSts+tG++byprdDKwKSqO61Ikk=;
        b=HyKBO1G1a13tnWB8k+2b7SrSBOYSTQAyCVm6ao+PEFkF+IHV50tBy0hG3T07RrzASF
         dd5GioIIzgrFVds81tQAicmGlwQnKzQ13Kc0r06Rs22O50526UEBDiHro1Fcp6jTiryx
         RSTICTyVDZHEtCNY0wbYQ3YO37KqBd5yffS2wMgSlxn7/Vp/xLICUUwnbqPOsOqtHoMq
         zSMQQtBbVtfOejYTKiRttAyKKMhl+Bya/tkBggMEmW0M0+PKC0Mjkz9mnxtA7tb/y+Z8
         6rUHbOCj3zONO6ZIuqQ/sH1haRU5EnAVzwgeQfQbAJDAGCh/UFNMoN50Zd1ti2KhJwa6
         4MDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767902096; x=1768506896;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2qTtzY0pedb8FPcFYKSts+tG++byprdDKwKSqO61Ikk=;
        b=BCmlu5Snqbye+Yv7AfzwRXZMiyFxy4rS1u2Med+qSRvCWGoa3AF0BIzbOiE900jr/n
         pBZ+HiKMbZsxCIKSA67ek1cHXruSr2FXR+dXGwMiBwE5UBjbmE6rZebe59vy55V1n/bI
         bMk2w5UenVRscMjrsubllf5e0WS4CmfEZ0UvxBQp6lf/fCWKlZdeG/1vmZ7zJbogTjwe
         lQMUSCPrnE76kwBBKRWWHGFWgX0QFuKSde3lynD+dbi1fmK3XX5qhCuG0xpYRfP7X0YR
         ZqjJKVIAwQFS1D5HUhN1ipbMlv+wiVZjOAz1IvcDugGBUXjqj//8Ka/afj5zHSfoSl3Q
         mqVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzpfOMKoGgjgIqAvMe5qyG5TYFXXM6KTnm9ZdTZZ9sHj6ifhfJBzJ13M9vIcI0K3M1mkEH0Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDyRHLXm3KtY2sP9bO6LyPIHBAmMCQIJEwqKJnVaPI2AeBZRi0
	ofFvzdGp1m8rJ9p3A1H+v/u6sn70DX2Tg90oRVqAbJcIOUnJ8NbHpHSUsYgIyNVDuMU=
X-Gm-Gg: AY/fxX4L2HNigHQ0Mb9Ep6M7f4ZQpt3dxWp55H/3z9Vy3RBZL2m6u9lzCJdbaZ22aHw
	DKM8dtADCeqyeOd+miU3CykH0Eg31HkvhLYb3NVaS15JM3Z4uJWqLxTGPO3bkZYnwpM7/9DRetb
	mJa9dSuR4vj/LF2J1ripk1sq+wOh6YUA5abkl9sb28Rf7xgDJaXOWk7ebvO2uEp2tyVLoBqEZQE
	yWZyLrq3P1n/REgIaZ26Rciyf0dJ0HAgSrPZOVxwp7W1xdyxOSVOyn7ksQrzqiF2ujUWUj5t4IR
	tkCcOEq19jfnztB4yKyKF+2gN4GIF8y9obE+TpQifQMOC5mQq+7G1X7GnV6vkWDYrujMey8Y6zF
	h3Af80ExOGELK+lMq1qhZQaMsF7NfkPWE6/Hz47n0eVZ2DOr6/BzMP2riNP6XGpMOUC04/FKQkr
	qzsaE=
X-Google-Smtp-Source: AGHT+IGhZGXqwlpY9isjdOemIgVTeM/DYdQfqUAtffSLUH2xxZWs2oDNQhiU+XuXBvoM7kC4/ooa4w==
X-Received: by 2002:a17:907:9483:b0:b80:3101:cd13 with SMTP id a640c23a62f3a-b8444d4eb13mr844347166b.10.1767902096178;
        Thu, 08 Jan 2026 11:54:56 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2969::420:14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a511829sm883889566b.51.2026.01.08.11.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 11:54:55 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,  Network Development
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
Subject: Re: [PATCH bpf-next v3 16/17] bpf: Realign skb metadata for TC
 progs using data_meta
In-Reply-To: <CAADnVQKR9Myx_ervEzNihoWm=6=_B4LebPhPezm9rOSReE1bjQ@mail.gmail.com>
	(Alexei Starovoitov's message of "Wed, 7 Jan 2026 14:01:12 -0800")
References: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
	<20260107-skb-meta-safeproof-netdevs-rx-only-v3-16-0d461c5e4764@cloudflare.com>
	<CAADnVQKR9Myx_ervEzNihoWm=6=_B4LebPhPezm9rOSReE1bjQ@mail.gmail.com>
Date: Thu, 08 Jan 2026 20:54:54 +0100
Message-ID: <87a4ynj2wh.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2026 at 02:01 PM -08, Alexei Starovoitov wrote:
> On Wed, Jan 7, 2026 at 6:28=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.c=
om> wrote:
>>
>>
>> +static void bpf_skb_meta_realign(struct sk_buff *skb)
>> +{
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
>> +               BUILD_BUG_ON(!__same_type(&bpf_skb_meta_realign,
>> +                                         (void (*)(struct sk_buff *))NU=
LL));
>> +               *insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
>> +               *insn++ =3D BPF_EMIT_CALL(bpf_skb_meta_realign);
>
> Not quite. drop this BUILD_BUG_ON(), since it's pointless and misleading.

Will do.

> bpf_skb_meta_realign() has to be the one done with BPF_CALL_1(...).
> Otherwise above will work only on x86.
> In this case on arm64 too, but it's by accident.
> BPF_CALL* has to do ABI conversion from BPF to native.
>
> For kfuncs that's what JITs do via btf_func_model machinery.

Oh, 32-bit ARM has different register mapping. TIL. Thanks.

