Return-Path: <netdev+bounces-237289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39264C4877D
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 19:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14B9D4E1256
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 18:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13ED30BF67;
	Mon, 10 Nov 2025 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VG0yfw8D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5322E6CD4
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797921; cv=none; b=E0f8dnCqVdaAyZynzyqhvG2jSIDffar5LxHF1ICLEj8sVvYnWu4ofuk5bOQq67fKH2q6RtCBKgn91S5RXxZcrjSDc/cimOqDlZZ9STb48vWzAnlaANVCwnr1rzBN119o2lVDjIvWdKvW2zx+6AzYRyMY9ZdOxg9qICphK1qvYeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797921; c=relaxed/simple;
	bh=Qr0I7fSX6b99zcO+zhCx8SyngvwHfavs+AINZxmTvKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=upxmJWbMetEh1+bqqQN4etoORPLHu+s6JKYLoWW6WL2PrM5v3fdNzHB5SN+cStaxw9+OJYp3Jm1ZTnwa660AKkVeJJ/i/IscpU2Yoawo5ahb5VNlOk/Dqcvgy7uQHj7E6UDHAjmVJQ+axH6qOoYNTVzvgX/+qRwjVWFY55Fur98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VG0yfw8D; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63f97c4eccaso3071267d50.2
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 10:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762797919; x=1763402719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3VQF3OYSeTXxfA91yFIKF6gFG8XTUDg3wxKQIKvNfM=;
        b=VG0yfw8DJNI1+bWJ4Ev4sGIkVEwtYoLI0x7KIVDm8/VPoNHiygMEeGtg1Kaxd0IbQ/
         gCZdiN8fnDrh/0up6xryUPS7SMsynib1tMrlwTC2pLPpl+7AyVo/5tWLVbgQQ55pQ3Yj
         Wjym000olfm4d6kINEKyOYI174hh4o+sfftiEoFZS0dbk5+UB3OasDJtPBR5Y4WHcN3W
         poauZyNxmf0ZGEBF7V8YXVvh0c9REEuXN1zjDH0Xu0BBIxdie2F1Y32dJ5SqlSRWTzpN
         F3NeUJU7fTicdaGtsmsJT/bi1H6YxECId8EkVtj77vXdHw7HclI8wzYQudW5A24S08NO
         Eb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762797919; x=1763402719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c3VQF3OYSeTXxfA91yFIKF6gFG8XTUDg3wxKQIKvNfM=;
        b=cd8WeN2vfbFw4H5jb6nvuNz1ba8ozccdwLUxK1an7oqHpMiHam7HCmg6O+SgXQnzZU
         x5rNDh0SMGw6JLwjRHxJ7R5joag5G9TvCjEPeOn+QaAw84XXIa3UQ8Pna7kLh+D66Cm/
         tIWRasV8NkwI4nBck9+/UYfJZUbt3B5crggnCVCv17gnnNg54cgHatqBLwkjB+4/jB3Y
         n7zgj6F9l7DdxS7+a8z8n0WDEBdAUcNXNUztufZ9qBlzVrl/aVdIR7ozqVYGzKNEKU6t
         6x/G4DYDDHryeN6Tv0nL8GG5hP4JsEpfD+kROA7ccz715PhOoLAHE1ca4L58l14FWtpR
         FysQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKLZNbA064ju7e+uup4CoAMLgtHtyM15EM9hX6cdo+DJwk24eMMYg9z/FUx0X8zOyJotBdr8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYSNr2voB9bp7YG0gGZ60skGIEavYABcEZG5IzJ6UwlhmMhyRH
	xyaFG6J3vIHM77//PASWT70ukJ1lo5gePPdLC5ZzplLw/RHEuZRcGaZ/sdHHfuY6BPOPvbMB8nz
	1pT1M/9r+hT/PjoFy/w7a5rLqSro6X6UdRabWeJABL4U38UEUHIG8F/1faiY=
X-Gm-Gg: ASbGncvTeiJDN4GPif883D6vc6UVI4p4TbA1+s1o9NwCfUo5OKIcEac+btHVTfX10bC
	a6GdK9Bx5740y78M3Oz2xp0COnsOJTS13l4Ykc2LXfUT98jRt0ea4DoCP1WrOPBbU26+PqF4vxD
	KT5O15+PhZhyg6a+Pw5Lq82s8Ty02s7wX34ZnQi3MhbG2jP4xFAdnP7z4DHHBNp4kThGMktBsBY
	BsJZ3wOOtUPIwsFwBjNLbLSTlripbM4AFwljKEBZV5fIeuny3GgLb1Egt2DKt334DI2Eg8=
X-Google-Smtp-Source: AGHT+IE9fVmi2GZZcZzrBiqlH9p0XE1wJvyclBgU1ZpJRBICG2W9GbkCd20psT+4gLSP1x3JnbZpVfQoMPHIJNfsQNs=
X-Received: by 2002:a05:690c:a0a3:20b0:787:e117:9508 with SMTP id
 00721157ae682-787e117a145mr59262487b3.38.1762797918865; Mon, 10 Nov 2025
 10:05:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110094505.3335073-1-edumazet@google.com> <20251110084432.7fdf647b@kernel.org>
 <CANn89i+KtA5C3rY2ump7qr=edvhvFw8fJ0HwRkiNHs=5+wwR3Q@mail.gmail.com> <20251110092736.5642f227@kernel.org>
In-Reply-To: <20251110092736.5642f227@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Nov 2025 10:05:06 -0800
X-Gm-Features: AWmQ_bmGrLq8u6iiiGXnSQC-1edjvBP-unuu_XNf1qRvE9mOpfht9UpEDWeW5Q8
Message-ID: <CANn89i+szfpkVD8y-71RTHCmZn5KoHV5X33HzTCf-M1Xq8LJ3g@mail.gmail.com>
Subject: Re: [PATCH net-next 00/10] net_sched: speedup qdisc dequeue
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 9:27=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 10 Nov 2025 09:15:46 -0800 Eric Dumazet wrote:
> > On Mon, Nov 10, 2025 at 8:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Mon, 10 Nov 2025 09:44:55 +0000 Eric Dumazet wrote:
> > > > Avoid up to two cache line misses in qdisc dequeue() to fetch
> > > > skb_shinfo(skb)->gso_segs/gso_size while qdisc spinlock is held.
> > > >
> > > > Idea is to cache gso_segs at enqueue time before spinlock is
> > > > acquired, in the first skb cache line, where we already
> > > > have qdisc_skb_cb(skb)->pkt_len.
> > > >
> > > > This series gives a 8 % improvement in a TX intensive workload.
> > > >
> > > > (120 Mpps -> 130 Mpps on a Turin host, IDPF with 32 TX queues)
> > >
> > > According to CI this breaks a bunch of tests.
> > >
> > > https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2025-11-=
10--12-00
> > >
> > > I think they all hit:
> > >
> > > [   20.682474][  T231] WARNING: CPU: 3 PID: 231 at ./include/net/sch_=
generic.h:843 __dev_xmit_skb+0x786/0x1550
> >
> > Oh well, I will add this in V2, thank you !
> >
> > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> > index b76436ec3f4aa412bac1be3371f5c7c6245cc362..79501499dafba56271b9ebd=
97a8f379ffdc83cac
> > 100644
> > --- a/include/net/sch_generic.h
> > +++ b/include/net/sch_generic.h
> > @@ -841,7 +841,7 @@ static inline unsigned int qdisc_pkt_segs(const
> > struct sk_buff *skb)
> >         u32 pkt_segs =3D qdisc_skb_cb(skb)->pkt_segs;
> >
> >         DEBUG_NET_WARN_ON_ONCE(pkt_segs !=3D
> > -                              skb_is_gso(skb) ? skb_shinfo(skb)->gso_s=
egs : 1);
> > +                       (skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : =
1));
> >         return pkt_segs;
> >  }
>
> Hm, I think we need more..
>
> The non-debug workers are also failing and they have DEBUG_NET=3Dn
>
> Looks like most of the non-debug tests are tunnel and bridge related.
> VxLAN, GRE etc.
>
> https://netdev.bots.linux.dev/contest.html?pass=3D0&branch=3Dnet-next-202=
5-11-10--12-00&executor=3Dvmksft-forwarding

Nice !

tc_run()
   mini_qdisc_bstats_cpu_update()  //

I am not sure this path was setting qdisc_pkt_len() either...

