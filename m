Return-Path: <netdev+bounces-236865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB43C40E23
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 17:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80C2F4F6358
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 16:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C60527E056;
	Fri,  7 Nov 2025 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HdMbGqoA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608A527877D
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532813; cv=none; b=sCyU2VCbYsEMVdKXmZZ8hzU8MEg9P3Xyjg8r3RGeXWxhViO+KGy51NfOafZcMn3v5T+SGtlGOjhKMViILFN2PgTL84yU/94cTVBD7zELSxORSh1WW1TvRWOEvW/F5vovhtN0sMuZ6joZl3zjq1if1NxfJRNFfODclzEcqSBeNbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532813; c=relaxed/simple;
	bh=bBTiH41REMzNR9vH6ei3tdMHK8h/UJ5IKpEyRq30EqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bliohghXzEZiq4/H4WKfgjpxqfzCBRaDlW/memdWivornl1UJuFWGjwygSojX4WrAUz56jYNnGszQK5Rff57Pm8Z6m8JqOPm3SufJrBqFzCy7VZOLw0JNRDStPKO8vKedyT1AQY2qQI/RDY25q26yLfgsk9mDhTTsT0HRZoOvYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HdMbGqoA; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ed612ac7a7so9283851cf.3
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 08:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762532810; x=1763137610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhaFAS/dlnZ3SUcjIu1VxA3E7XMOIvofH8xSkA6qsmQ=;
        b=HdMbGqoAEYgzXaYMjjsuNIidkYNZfqGXESfk/AqROdoEOH4a52FBOilar2aeOSZqik
         SIC5h465Y59FDrmElJkadWtPkNMfR9v45x2uZkY6pSkg8eP5P+hRKFTTd2N7hEAUIR1P
         uumHZHWkFsATRY0F/GPeY6PEFIuk6IfkVHR7b4JVuh8OrwMGc+v+fTXgYcgZfQvGMxe6
         B9IZ2+DbsAxMOn072NHF9UQfGNe83wz4mVtRMeuo4ePrx2aT+SIJilEo5BkDntStHKfw
         hbifb9zoVeMZ0Bxaisfa4hynAvvrkpt/1uC09KJHlGLkC0576SAHsZUKHj+C/Wb+uwfJ
         bGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762532810; x=1763137610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dhaFAS/dlnZ3SUcjIu1VxA3E7XMOIvofH8xSkA6qsmQ=;
        b=l73zbrKKFy0QkEpAI7hsTruqQ0bNKj+xhMC9bJtcB35HqCCwzpReFo9uORgobQcqAE
         GbhBFPtMCBGGHMwXtbcdxFMTQvvSG0vFNrsyHJGHRgOqcoItt24CGvKpdgfD11rnmSOf
         XNukcCUkAoHJ5GCCaGkAiyYXiKk9IeULe+KGGdKv840xbtQL2cKuLTwjGtGM7/qifn3p
         B8eExzY3XTW/uf4Xtdli4zlyyF5AJk/yzAFsyL5r9xXHonnBeZYLAu7I5v7fHO7o/bCe
         maLggxmayGTzt06E2Zr1b92NFbDdTm2bwWhRB9zawO+40T1WNdIUMLerXxunGn2L5nG3
         nhWw==
X-Forwarded-Encrypted: i=1; AJvYcCWjit37daKPT13nlxAhfwCIRLjpLbWjN8KnUU249p9snJNQQXiF3VjGdnuST0F/cWgy2w0ikRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi0rLWoJvrSXJVMIuYEBUFIAUOUu7mEZuKP7pW/vfbj0F2ZWCt
	rEWYZZ9Fo8kpuYLAJ+Mnt52JVgkTnJqc38zmxmjIf6O/t1K1q+yvugM7yoqxLxrxmc89+LwEyIa
	M31lC9HQWHbOE/dg+YHrIIwcLWXMOUHcFlvi39vfd
X-Gm-Gg: ASbGncvNNmp8OafhxPmGUS3rkxdLbJUzAt4UO194d8nMb0iA2KpCqNkRPjHe/BhsnVG
	mFtKNZFae2IkGbMFtbtl1i0FkU8r5QxilAFnxT0tf1OHdKkNXvQvGN+p9O0pC5UL7ZlX6XmDSDQ
	e1opDC2GJtfCOTjv1gPF+YO5fn1Xt14P2CD4kr1peueHhV5s1NvNQjOLp5exVgJ0ap1rRCLqsXD
	b6jzR6KpnSjj7ytWDzJWth3GI8MMrgEL1DG7Fxz2IbiH9KhU8iATlG42RWt
X-Google-Smtp-Source: AGHT+IGEkrDMYMILtf9+bfDZu8vryqAavdu2cVvsMevtgOZjI+tGQcLvXU5dEU+akWjtl8Pw7EK8UOjdbKRnSamGU6Q=
X-Received: by 2002:a05:622a:488:b0:4e5:8d07:ce80 with SMTP id
 d75a77b69052e-4ed94a3be40mr44889391cf.41.1762532809730; Fri, 07 Nov 2025
 08:26:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106202935.1776179-1-edumazet@google.com> <20251106202935.1776179-4-edumazet@google.com>
 <CAL+tcoBEEjO=-yvE7ZJ4sB2smVBzUht1gJN85CenJhOKV2nD7Q@mail.gmail.com>
 <CANn89i+fN=Qda_J52dEZGtXbD-hwtVdTQmQGhNW_m_Ys-JFJSA@mail.gmail.com>
 <CAL+tcoBGSvdoHUO6JD2ggxx3zUY=Mgms+wKSp3GkLN-pLO3=RA@mail.gmail.com>
 <CANn89iJcWc+Qi7xVcsnLOA1q9qjtqZLL5W4YQg=SND3tX=sLgw@mail.gmail.com>
 <CAL+tcoCmpzJ_z4DCvcoWok2LrR9vL2An8j3zi5XHOjiSity3jg@mail.gmail.com>
 <CANn89i+4OKrAq6DPZ_=MeDhGmEXDn6k-dRrEyzO8pmy=hN6VwA@mail.gmail.com> <CAL+tcoBkzggvE=3Y4jeeY9BnnBkNTFXjxN1H1ceKkDGg1ktzAQ@mail.gmail.com>
In-Reply-To: <CAL+tcoBkzggvE=3Y4jeeY9BnnBkNTFXjxN1H1ceKkDGg1ktzAQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Nov 2025 08:26:38 -0800
X-Gm-Features: AWmQ_bm4ywfiyRhttAnNfY8Zqky4P8arDWm6j7HzbSebjOJ4K7U16NcT6qaxs50
Message-ID: <CANn89iKP7X_GsuP9VcUJURC3T4Z2wJTyjf2GS0PCxZnb6APnCQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: increase skb_defer_max default to 128
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 8:21=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Sat, Nov 8, 2025 at 12:08=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Fri, Nov 7, 2025 at 8:04=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> > >
> > > On Sat, Nov 8, 2025 at 12:00=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Fri, Nov 7, 2025 at 7:50=E2=80=AFAM Jason Xing <kerneljasonxing@=
gmail.com> wrote:
> > > > >
> > > > > On Fri, Nov 7, 2025 at 11:47=E2=80=AFPM Eric Dumazet <edumazet@go=
ogle.com> wrote:
> > > > > >
> > > > > > On Fri, Nov 7, 2025 at 7:37=E2=80=AFAM Jason Xing <kerneljasonx=
ing@gmail.com> wrote:
> > > > > > >
> > > > > > > On Fri, Nov 7, 2025 at 4:30=E2=80=AFAM Eric Dumazet <edumazet=
@google.com> wrote:
> > > > > > > >
> > > > > > > > skb_defer_max value is very conservative, and can be increa=
sed
> > > > > > > > to avoid too many calls to kick_defer_list_purge().
> > > > > > > >
> > > > > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > > > >
> > > > > > > I was thinking if we ought to enlarge NAPI_SKB_CACHE_SIZE() t=
o 128 as
> > > > > > > well since the freeing skb happens in the softirq context, wh=
ich I
> > > > > > > came up with when I was doing the optimization for af_xdp. Th=
at is
> > > > > > > also used to defer freeing skb to obtain some improvement in
> > > > > > > performance. I'd like to know your opinion on this, thanks in=
 advance!
> > > > > >
> > > > > > Makes sense. I even had a patch like this in my queue ;)
> > > > >
> > > > > Great to hear that. Look forward to seeing it soon :)
> > > >
> > > > Oh please go ahead !
> > >
> > > Okay, thanks for letting me post this minor change. I just thought yo=
u
> > > wanted to do this on your own :P
> > >
> > > Will do it soon :)
> >
> > Note that I was thinking to free only 32 skbs if we fill up the array
> > completely.
> >
> > Current code frees half of it, this seems better trying to keep 96
> > skbs and free 32 of them.
> >
> > Same for the bulk alloc, we could probably go to 32 (instead of 16)
>
> Thanks for your suggestion!
>
> However, sorry, I didn't get it totally. I'm wondering what the
> difference between freeing only 32 and freeing half of the new value
> is? My thought was freeing the half, say, 128/2, which minimizes more
> times of performing skb free functions. Could you shed some light on
> those numbers?

If we free half, a subsequent net_rx_action() calling 2 or 3 times a
napi_poll() will exhaust the remaining 64.

This is a per-cpu reserve of sk_buff (256 bytes each). I think we can
afford having them in the pool just in case...

I also had a prefetch() in napi_skb_cache_get() :

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7ac5f8aa1235a55db02b40b5a0f51bb3fa53fa03..3d40c4b0c580afc183c30e2efb0=
f953d0d5aabf9
100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -297,6 +297,8 @@ static struct sk_buff *napi_skb_cache_get(void)
        }

        skb =3D nc->skb_cache[--nc->skb_count];
+       if (nc->skb_count)
+               prefetch(nc->skb_cache[nc->skb_count - 1]);
        local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
        kasan_mempool_unpoison_object(skb, skbuff_cache_size);

