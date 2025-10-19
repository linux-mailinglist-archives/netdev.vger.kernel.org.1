Return-Path: <netdev+bounces-230751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDFABEEB0F
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 19:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63EB44E2B7C
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 17:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AC521A436;
	Sun, 19 Oct 2025 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FUFuNjog"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1432144C9
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760896714; cv=none; b=nyyeSrSDGPM3UnixfpBcrP07oglU9SWTHzAN4UMG6QcoMk3nFP+99VRKUMNHWIkM7JT43KesrcN3Hcdzo0/0E3c2syDjEGyaOFNQg4ACzIiwpVzvpIJC+V/jt0imc4EcI3dAEcdR265tfETebHvUOUe9ScbNn2gkCy9HDpBp9S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760896714; c=relaxed/simple;
	bh=xd84/EziHyX69SaM1ABHRo3Wwwki8W2RnXA46/CTO00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAFQM2NehP7ZJVOPxESTqGfE0RyY77yrXZSBxJ7fazw31plwf+geY9JOv9GaRoliCnU3rAtFizNuMgFP0QCTDhl8svN9PA4IuJLj7XO/gneUBB7RhcFIFeh4n2xezGyECjsVUjPEH8HInGJ4ejDstgWMtD1IlOeK8sg+4cHyOXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FUFuNjog; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-883902b96c3so365055085a.1
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 10:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760896712; x=1761501512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0btjzCMKFinilr5hRrdOuQk9kLMqF4vdkTKBHDIdNSA=;
        b=FUFuNjogy8kxVuYdiPhUKAdlnaHAiorulsZNapWfM910im83BYjsnPCzcdNu0Pc+fF
         oBiwzWVduXuGXSgvG1IvyLbsXlvWsunLBlDrCOjn7XVYRKzq0x7VC4YGpokQXO5Z/YfX
         sWM38BVBEg53fUFNLm3oGET9YByp15u/soRTuFJW8KdvOERQttaXFjWICpfdXGd6SsqJ
         Cji9QZlMQ4rys7M1UdisO/Vm0QznG8nAxY42WLlvYN00qWwKqMrPTGBJt9FwMmvkPkxY
         uJ2Yh5eTrIm6UoHlPohtcxDwgOtMvQ3HC36dkFv8N3bhInkiGpi4x6rgZ1B7Xqe/dLlZ
         fUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760896712; x=1761501512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0btjzCMKFinilr5hRrdOuQk9kLMqF4vdkTKBHDIdNSA=;
        b=EGsTiumsijhWvrdDOSt4bJ1hXT2wxml6ddfCITN8HFt82Sy9etWMFnsv9+C3B419hG
         SsNGH6s5U1jV6X8OsoF260pDrVOOctufBC746uSfHCVL4OPCC4fHBcA6GZPY3t57Rbj9
         kikaQLICGPbmdiKvZUXwtRCk8dzRI+H8m7A90JWtG+POzylMNWdz0Lld3F/3XPeIDp0l
         0TfGfHC8zH3YKSnj2F54pkEBWQdhc91Tspi78naDpw40WOBA/kzA1LbEdv3FjAEHanvM
         kx1mx9WT3Q+tnggTTgs2LJx7orIvjA5kGT8qu1aWlWsnx6ISiO2phvGQ1trTkENlb/qt
         xgqA==
X-Forwarded-Encrypted: i=1; AJvYcCWfSGCRORcOmC96XCLM1b9UYvADS+kzcDdJZNWUeuZt6ulcCZeQj1OGnFLuZtKQcKZ+3xEerDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSQOcQl8UfEFV+gFs30DJgYE779lZKoP22XYrOWKMdpepVeAVm
	aloX7Xjo8ZAPB8rEVCCOb5F1RSQZ2Y8Nt/3Al5VIMAbFKOn81INqw4asZ8Vp7W4p4FpJjjacwsz
	6VQRvMGfjJkkwFZR8ydVu27lOygE+uCC+/YTdn2dE
X-Gm-Gg: ASbGnct1E8YHrFJkYX1rafYCvRhwtxnfO9Ubga7k+JUJ+LdcdSfDN9zMrtmiL7R+117
	xvGK4/etGKgq9dA4GaYe/Id8h8b5i9fY+gABrnVo5BCHRNCKm9H9PiQICVkiabHJJhl/DZdObxV
	uCZQnoZsapaHF+VYIkKfZlGfNKXmElHIQFGH3LdH/81L6d8d+y1E4rp/dRXMztWQQxCiHemX32f
	ycHfPoASb9H32yIzAk8blEUCTQpNh/wN+NI+vi/PrzvDoCMzncRtUWulZng
X-Google-Smtp-Source: AGHT+IHW6B4+M9UITCoNNiNhOgr5XfE1v4R26PC4bxYTk+kKNLU85HD+VHad52UdnSyXi39ZQAokqaZOIKyEQeh4dV8=
X-Received: by 2002:a05:622a:110e:b0:4e8:a9a2:4d50 with SMTP id
 d75a77b69052e-4e8a9a25039mr124312201cf.41.1760896711577; Sun, 19 Oct 2025
 10:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251019170016.138561-1-peng.yu@alibaba-inc.com> <CANn89iLsDDQuuQF2i73_-HaHMUwd80Q_ePcoQRy_8GxY2N4eMQ@mail.gmail.com>
In-Reply-To: <CANn89iLsDDQuuQF2i73_-HaHMUwd80Q_ePcoQRy_8GxY2N4eMQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 19 Oct 2025 10:58:20 -0700
X-Gm-Features: AS18NWDqKi6K-NqLZEmsIBJ4Bbam4b59iIv_1EQ8veJMiqjxrscHap4wAaUF3b4
Message-ID: <CANn89i+xW+mwY=Y5_r7RPEavq63PjMAwek91+19VQLFnRYrR8g@mail.gmail.com>
Subject: Re: [PATCH] net: set is_cwnd_limited when the small queue check fails
To: Peng Yu <yupeng0921@gmail.com>
Cc: ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peng Yu <peng.yu@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 10:43=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Sun, Oct 19, 2025 at 10:00=E2=80=AFAM Peng Yu <yupeng0921@gmail.com> w=
rote:
> >
> > The limit of the small queue check is calculated from the pacing rate,
> > the pacing rate is calculated from the cwnd. If the cwnd is small,
> > the small queue check may fail.
> > When the samll queue check fails, the tcp layer will send less
> > packages, then the tcp_is_cwnd_limited would alreays return false,
> > then the cwnd would have no chance to get updated.
> > The cwnd has no chance to get updated, it keeps small, then the pacing
> > rate keeps small, and the limit of the small queue check keeps small,
> > then the small queue check would always fail.
> > It is a kind of dead lock, when a tcp flow comes into this situation,
> > it's throughput would be very small, obviously less then the correct
> > throughput it should have.
> > We set is_cwnd_limited to true when the small queue check fails, then
> > the cwnd would have a chance to get updated, then we can break this
> > deadlock.
> >
> > Below ss output shows this issue:
> >
> > skmem:(r0,rb131072,
> > t7712, <------------------------------ wmem_alloc =3D 7712
> > tb243712,f2128,w219056,o0,bl0,d0)
> > ts sack cubic wscale:7,10 rto:224 rtt:23.364/0.019 ato:40 mss:1448
> > pmtu:8500 rcvmss:536 advmss:8448
> > cwnd:28 <------------------------------ cwnd=3D28
> > bytes_sent:2166208 bytes_acked:2148832 bytes_received:37
> > segs_out:1497 segs_in:751 data_segs_out:1496 data_segs_in:1
> > send 13882554bps lastsnd:7 lastrcv:2992 lastack:7
> > pacing_rate 27764216bps <--------------------- pacing_rate=3D27764216bp=
s
> > delivery_rate 5786688bps delivered:1485 busy:2991ms unacked:12
> > rcv_space:57088 rcv_ssthresh:57088 notsent:188240
> > minrtt:23.319 snd_wnd:57088
> >
> > limit=3D(27764216 / 8) / 1024 =3D 3389 < 7712
> > So the samll queue check fails. When it happens, the throughput is
> > obviously less than the normal situation.
> >
> > By setting the tcp_is_cwnd_limited to true when the small queue check
> > failed, we can avoid this issue, the cwnd could increase to a reasonalb=
e
> > size, in my test environment, it is about 4000. Then the small queue
> > check won't fail.
>
>
> >
> > Signed-off-by: Peng Yu <peng.yu@alibaba-inc.com>
> > ---
> >  net/ipv4/tcp_output.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index b94efb3050d2..8c70acf3a060 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -2985,8 +2985,10 @@ static bool tcp_write_xmit(struct sock *sk, unsi=
gned int mss_now, int nonagle,
> >                     unlikely(tso_fragment(sk, skb, limit, mss_now, gfp)=
))
> >                         break;
> >
> > -               if (tcp_small_queue_check(sk, skb, 0))
> > +               if (tcp_small_queue_check(sk, skb, 0)) {
> > +                       is_cwnd_limited =3D true;
> >                         break;
> > +               }
> >
> >                 /* Argh, we hit an empty skb(), presumably a thread
> >                  * is sleeping in sendmsg()/sk_stream_wait_memory().
> > --
> > 2.47.3
>
> Sorry this makes no sense to me.  CWND_LIMITED should not be hijacked.
>
> Something else is preventing your flows to get to nominal speed,
> because we have not seen anything like that.
>
> It is probably a driver issue or a receive side issue : Instead of
> trying to work around the issue, please root cause it.


 BTW we recently fixed a bug in tcp_tso_should_defer()

Make sure to try a kernel with this fix ?

295ce1eb36ae47dc862d6c8a1012618a25516208 tcp: fix
tcp_tso_should_defer() vs large RTT

