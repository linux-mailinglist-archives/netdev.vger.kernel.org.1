Return-Path: <netdev+bounces-247437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBC3CFA452
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 19:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48532304F67E
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 18:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B20F34F47E;
	Tue,  6 Jan 2026 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXCeqP5G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD09A34F46F
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767724841; cv=none; b=PPyGu5jv0KDMlyOoJKw94pSpBM2bW0dpUaP6ezml7z/hpryO/Cg6pwaReAXgOLu6ve0Rg2lj8B3AQw6o904GN8vfvX3dsTQrSM0tbcxe3Chqf9hgw2DI2VcrV5J52wgCzVPHyUT6BFTCfbNcMfuPHTLuTjMukGCOzAH+UjNZJPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767724841; c=relaxed/simple;
	bh=RWNQHn4DGRgRLcnmtfeCdhR5hdgZkUGWzcMWI26afZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ognaI+AlFbWmkklPimlOAZecfNA+nsn974ISKi5t1YIuuCk2VJu+WaHJklEDCvt6CrfIC71MYbG9m5lCABdZ4sXgigD8kTd4DNaGnx72jKYIj6CAFAdMwdYszV8zhWo6I0h2LYbboWvJxim1nP0VPIKu8+v/BYOJpiTw4Q3JT8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXCeqP5G; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3d7c1321so749009f8f.3
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 10:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767724838; x=1768329638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88EtJmRK4Gu5YixrUz19hmnSc1gn5W+C/wUxSX+bTSg=;
        b=bXCeqP5GQns8wI+KvhIMU2WqwCdUH0yjZAW8P1q21ATMurPZu0Le+JRuQa8bw/Kqi9
         GpAVWI4uW+slJlNUIkL+Gq+HJpbgGJSZLcxEs1HMgTkSGA7OUY+paov1BN063fbj6g0c
         msM7awvtENEnqdK0OtbAoBjKS6yw8LzGwQ18S+YxQ5JRWHABg+DbapOmHMyu8mmM5XQx
         2474leM2EkFewrWraD/qIVif5pdcsn19fdK/q+cp0Lb5qt7rc8agDher0HPE/T1iv5cU
         ry3bitU+B/IB8gmvqMVD/HPpYacc3FrLP1B/pvSFuUawpn9ybhTBS34cv1JlOkhZEG09
         iWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767724838; x=1768329638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=88EtJmRK4Gu5YixrUz19hmnSc1gn5W+C/wUxSX+bTSg=;
        b=mO+35n9ELZyPSIweSOOouCHaVhgktEWYPPBYY9oCtWedX9fS2XSHwRiIbE2p5qYFHg
         quYWnZxpVV1+EbP4ewsnAZUAyW6D9h/fsTTWn8E/5QyEr0aA9ZK4rGX/Rvb5Jcebntro
         OIaKQBMZsUEosbd7tF7VX+/zQEs9XibKlZsMhutDvKS2Eeef/0mkXGmu204MQpXLn6N2
         oSCTGmIsRIy7Bc7jrMZ/pPh261nBihTDOz0Ut1UgYtWwL5vcjvzCfRI77/el60nRNX1P
         z/jfttAk9ev9sf5LuMgwl6J5Vs7PczsmeynG+x0IGLSN8GtbOov5aIKAprgRGe7PMdb5
         HD0w==
X-Forwarded-Encrypted: i=1; AJvYcCXQ9uHQOxND3QlGC+Gi4tU4ID9Y1lL54OR9aC47x5ekBXV6xxf6IlPGsWB2XR3mdvcYgkGuyfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5fr1ek40Ga3xFIcDZxgd+R88RA3ffmrKvOuUUKo8TrLf76IgP
	g5klUxL1e4epRjT8VfVl12HdJ2qcnXapPRLDKoGPl0ZssfSnjGzS0J5tMnp6MUzmL4xqQ8oA7s8
	Km4kX+NnbSLzDYxvTKdWK2SfjkiTfJyk=
X-Gm-Gg: AY/fxX7eqcof7LrzVMPjgeBmjHbJ7N7b+DvEq5E1GfxXufIxFYbK6zSfYOzW2FNxEVw
	ISq4AImu1gMQihckUyRyuuTCoDUAOJ/4r1y8PiPRT7EeKhcdwheMW0dUsnywQwara4kyttdHIkv
	mevAf9UUwx41TNhqgtCo9yEWKnjN82QAudG7lcQSPiVG36WcxniJyQ3V/X5BxM5Ox2mGKH2A2lO
	ohPRw/4dYyEN6KRWnHEnuFOb9ZOKkPBLd8dQW8ZIbIOaCD4BCdGSZ5LYZ9XYClZcJcfLdyJWf1N
	xWrnbVPayeI=
X-Google-Smtp-Source: AGHT+IGtlzo16Yj6LrFYJJD81pxgkQ4sznqpXw3oPq0nDS8PbHxR5tTePeMz/bovrxfRyAl9nY40dO3V8xON2Mne5mE=
X-Received: by 2002:a05:6000:1449:b0:430:feb3:f5ae with SMTP id
 ffacd0b85a97d-432c37a721dmr93020f8f.55.1767724837702; Tue, 06 Jan 2026
 10:40:37 -0800 (PST)
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
 <d267c646-1acc-4e5b-aa96-56759fca57d0@linux.dev> <CAMB2axM+Z9npytoRDb-D1xVQSSx__nW0GOPMOP_uMNU-ZE=AZA@mail.gmail.com>
 <CAADnVQJ=kmVAZsgkG9P2nEBTUG3E4PrDG=Yz8tfeFysH4ZBqVw@mail.gmail.com>
 <877btu8wz2.fsf@cloudflare.com> <CAMB2axNnCWp0-ow7Xbg2Go7G61N=Ls_e+DVNq5wBWFbqbFZn-A@mail.gmail.com>
In-Reply-To: <CAMB2axNnCWp0-ow7Xbg2Go7G61N=Ls_e+DVNq5wBWFbqbFZn-A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 Jan 2026 10:40:25 -0800
X-Gm-Features: AQt7F2pViPcfQAB67_hx0J5Vj0LqXq-3QfVnB7KSk1GcSWnVDyn6jxTDjYHR88w
Message-ID: <CAADnVQ+VfT8nQA4eFec2Q7Fga0_2sbYmdaJffSbKpFmTwsE8eg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 15/16] bpf: Realign skb metadata for TC progs
 using data_meta
To: Amery Hung <ameryhung@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
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

On Tue, Jan 6, 2026 at 9:47=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 7f5bc6a505e1..53993c2c492d 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -9082,8 +9082,7 @@ static int bpf_unclone_prologue(struct bpf_insn *=
insn_buf, u32 pkt_access_flags,
> >         /* ret =3D bpf_skb_pull_data(skb, 0); */
> >         *insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
> >         *insn++ =3D BPF_ALU64_REG(BPF_XOR, BPF_REG_2, BPF_REG_2);
> > -       *insn++ =3D BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
> > -                              BPF_FUNC_skb_pull_data);
>
> This is why I was suggesting setting off =3D 1 in BPF_EMIT_CALL to mark
> a call as finalized. So that we can continue to support using
> BPF_RAW_INSN to emit a helper call in prologue and epilogue.

That's the only place in the code where BPF_RAW_INSN(CALL, BPF_FUNC_xxx)
is used, and it was done this way only because we didn't think
of finalized_call concept.
So I don't think we should introduce more corner cases with off=3D1.

