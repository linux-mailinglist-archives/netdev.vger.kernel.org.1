Return-Path: <netdev+bounces-249851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 352B7D1F5F3
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 15:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B9A1300B37C
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 14:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178AE2D97BB;
	Wed, 14 Jan 2026 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iF0rfkLW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC770284883
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 14:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400307; cv=none; b=Ie3EAKkQMh8in7lCWyGMqBEQ7mm6ghWcUaySzo19UVCeC0AluCzhnRPHmlSmIIeFGXCiYs3/0lk6LDcstn3hoDID5gMRgFZPQJgkYsidFHl54RdeW5YXH6VX9kpleQXhA712NDzUFuXeQPZslPmldJePVgA7VVSPNRvws46EOuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400307; c=relaxed/simple;
	bh=ByjR5pGdvbPnPjnSHDdCm2CZPaC8FU9NPFXL5Jjzn8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQ977W+lZck5bI4LGQGDZjxImuh6Phz8L6b5UC0gBcm908ZKoVPfcNkf7yHzkEsMu9/kFCvK8MKGBLCg68N1oRrb5FdBPvJbl5wNomXji+OQ2u3fLjRp3Hs+q5Ej7aFZbtru7ka8cZE034A1qM/2iP8OvOu7QkjLBQbmtCX7aqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iF0rfkLW; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1233b953bebso451747c88.1
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 06:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768400305; x=1769005105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/A3CyH4/fl15PaclcjPHyrB4q/uW86l4z0n38IG42c=;
        b=iF0rfkLW8KXPCblcILd5CsVQkYrC+1NjSnlsMugOx2oZGBKfYLPIUVuw/m4XmDMx4a
         KnZAo4A0greu03NyUC2cPMsY3Sf+RD0f3qpFZPy62iy+atpuLvXFnU+wdRyHtz8yPcn0
         mckT/hM6t7hLIUaaQmGi6xfZHV8iKhHFLwvsM4XqUbH02nQ0IHvgNM8PD0PXdEtizqBJ
         YJuDvh4MmwMYm8IghNvwvswwwRYlT3F7v+LQ4zEaAHGGquLmmVDG3Tsn921pVCOkaHxx
         WFGQMSJin/D4AS7jQNFafHF2ribH4HnWRDpwIE3UBCKsbXNNZd7mmkv2dLSq/Q1jRz7E
         gc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768400305; x=1769005105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2/A3CyH4/fl15PaclcjPHyrB4q/uW86l4z0n38IG42c=;
        b=ACVbFW9VfUg1WPQrHqBT9wWpJNDPTnDKUFu7wFqOHfW+CINvMDnHdLGx8f1YQyKwpx
         plDTc7fo7gnI79QKACJ0+4HeSmyRGO8G2lrJ4P3GQMUcMUR52KauJwh3ZHfVD3z4xcKk
         NS4S3wBf2K8e7u4b8SSJaseXeT5Nefsz2Ia19JAkircWPIM8ukz2haM15nLIz71/qs/b
         RiU70sQ37HEY+gWDohZxsM+D/dRRIwVa4iWGxd7U0SKMOY/jRt06+t1l6RzmEWvBxicP
         9t6bn/yjaWJxHSSatBtKrYZIAnLF66JLxqHR2+HhDvCfxT/sem7RNdAaj1qwo81j6Pir
         /mEg==
X-Forwarded-Encrypted: i=1; AJvYcCXE9PQ6Yz9VCPDhU7ml8hWWcBECs4SeM2oJC/94KpCj2k/X/AE4GFS6SKc380qW3tnp7a3n3WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCg1UNO4x0idFQ+aD8tre/T2+mfJcMXSLnYCTBWSuYS9Bd2hr5
	BTB0ngUV3aPq5G9fAQH+RX00T8l8c9/m15PI2uS7ry9lPdEnxr73k7fevHdtQspx1GTDoVPs+YJ
	FIVSit0W808CcuLaAOcMdafQQbdmWRMI=
X-Gm-Gg: AY/fxX7YMfWM+VRzIB5Lo5OPQ60DuRb1yMPcmeat/Jcio0cZBMnGtpBjzx4LXMAZA7x
	AqqBBN4O51Dz0EpZu3Cdv8rJcE2TPGHvpNrxerr1RExOAtCyGgfxtCrGhcYp++pXBtecOuKGfSt
	S3wtlRBGuzsC1pPZVwog/0VkwqsGDY65uJ6M0/cjrtAqHNBkTjwc2t3oy9ZYLi8WwEexel0Q2D7
	vlwpOnH93vTcA46CA4O21lp8t25nugiAclYo5kExuIwFEmYNy1hDF+AfCbQClcXPSsEa4/4
X-Received: by 2002:a05:701b:2411:b0:11b:88a7:e1ac with SMTP id
 a92af1059eb24-12336a34f64mr2451430c88.19.1768400304612; Wed, 14 Jan 2026
 06:18:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114060430.1287640-1-saiaunghlyanhtet2003@gmail.com>
 <87h5so1n49.fsf@toke.dk> <CAGF5Uf48mRAuUZpTAGCGQtveDoDpF_1SKXFoBECqYzU4+dVwwg@mail.gmail.com>
 <87bjiw1l0v.fsf@toke.dk> <CAGF5Uf7FiD_RQoFx9qLeOaCMH8QC0-n=ozg631g_5QVRHLZ27Q@mail.gmail.com>
 <87zf6gz83v.fsf@toke.dk> <dcad6dc7-b152-4511-becf-9e7721996f6a@kernel.org>
In-Reply-To: <dcad6dc7-b152-4511-becf-9e7721996f6a@kernel.org>
From: Sai Aung Hlyan Htet <saiaunghlyanhtet2003@gmail.com>
Date: Wed, 14 Jan 2026 23:18:13 +0900
X-Gm-Features: AZwV_Qi8DL3C6Y5jDS3l2SHHI-M8-MjhNsWwIiIEVMz4e4ML5Pe2VK-ggKtssG4
Message-ID: <CAGF5Uf6AJStzQWw1su245T+epoHENaUpQJgx48YefY6bPSAX1A@mail.gmail.com>
Subject: Re: [bpf-next,v3] bpf: cpumap: report queue_index to xdp_rxq_info
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 10:30=E2=80=AFPM Jesper Dangaard Brouer <hawk@kerne=
l.org> wrote:
>
>
>
>
> On 14/01/2026 13.33, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > Sai Aung Hlyan Htet <saiaunghlyanhtet2003@gmail.com> writes:
> >
> >> On Wed, Jan 14, 2026 at 8:39=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgens=
en <toke@redhat.com> wrote:
> >>
> >>> Yeah, this has been discussed as well :)
> >>>
> >>> See:
> >>> https://netdevconf.info/0x19/sessions/talk/traits-rich-packet-metadat=
a.html
> >>>
> >>> Which has since evolved a bit to these series:
> >>>
> >>> https://lore.kernel.org/r/20260105-skb-meta-safeproof-netdevs-rx-only=
-v2-0-a21e679b5afa@cloudflare.com
> >>>
> >>> https://lore.kernel.org/r/20260110-skb-meta-fixup-skb_metadata_set-ca=
lls-v1-0-1047878ed1b0@cloudflare.com
> >>>
>
> Above links are about 100% user defined metadata, that the kernel itself
> have no structural knowledge about.
>
> The RX queue_index (as you wrote in desc[1]) is something that gets lost
> when XDP-redirecting. The series in [0] is about transferring
> properties/info that got lost due to XDP-redirect. Lost info that the
> SKB could be populated with.
>
>   [0]
> https://lore.kernel.org/all/175146824674.1421237.18351246421763677468.stg=
it@firesoul/
>   - Subj: "[V2 0/7] xdp: Allow BPF to set RX hints for XDP_REDIRECTed
> packets"
>
>   [1]
> https://lore.kernel.org/all/20260114060430.1287640-1-saiaunghlyanhtet2003=
@gmail.com/
>
>
> >>> (Also, please don't top-post on the mailing lists)
> >>>
>
> Please read Networking subsystem (netdev) process[2]:
>   [2] https://kernel.org/doc/html/latest/process/maintainer-netdev.html
>
>
> >> Thanks for the pointers. It is really great to see this series. One
> >> question: Would adding queue_index to the packet traits KV store be
> >> a useful follow-up once the core infrastructure lands?
> >
> > Possibly? Depends on where things land, I suppose. I'd advise following
> > the discussion on the list until it does :)
> >
>
> Hmm, the "original" RX queue_index isn't super interesting to CPUMAP.
> You patch doesn't transfer this lost information to the SKB.
>
> Information that got lost in the XDP-redirect and which is needed for
> the SKB is RX-hash, hardware VLAN (not inlined in pkts) and RX-
> timestamp. As implemented in [0].
>
> --Jesper
>
>

Thanks for the clarification, Jesper. I see now
that my patch only makes queue_index available in BPF context but doesn't
restore it to the SKB.

Before I invest more time in the wrong direction, I have a few questions
about the proper path forward:

1. Does your RX hints series provide a way to restore queue_index to
   the SKB? If so, would the TODO in kernel/bpf/cpumap.c be
   addressed by that work?

2. If queue_index restoration is not part of the current RX hints series,
   would it be acceptable to add it using the same mechanism you've
   implemented for hash/VLAN/timestamp? I'd be happy to contribute a
   patch following your approach.

3. Alternatively, should I wait for the RX hints infrastructure to land
   and then submit queue_index as a follow-up?

- Sai

