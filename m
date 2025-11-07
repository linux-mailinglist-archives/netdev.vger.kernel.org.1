Return-Path: <netdev+bounces-236867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 574BAC40F77
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 18:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 164F34E18F2
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 17:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D63B332ED3;
	Fri,  7 Nov 2025 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdpnBAYf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95C832E72C
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762534805; cv=none; b=VaEZCqJ7G1/9zkgc3KplqKmJ5pREQj5g+EE4+TT/NJfxqYlznr2Pt1JBCpUOkaO8JMNE85QrlkunZ5u2WqHoP0XptUFeM5trtiP2AbpnOf54mwz1vI/d64Y/aJZHxaADmEATFHB10mExBzqUCfOMEsBeggaylp/8QlZ6OTdM3MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762534805; c=relaxed/simple;
	bh=JNn1/5CORQs7BafP9HBMVTgY9oN5qXiyyf7XVqGL2f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1ujDb9y/lz0DIJmibJh7TDkdVfR7WlRIj0WhwkV7TiSomx2fPFswcHoeM1F+5jotyH+V2hyq6cykWg66iwiS4CF6gUuDDGVx2wTaiUPRpfDjTXpdP76fRe4KYBiGTaONwPuLWoR4oDqp0QcXZJoH9GChH9Zh6iPCiTMD7yu/g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdpnBAYf; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-4332ae0635fso8197365ab.2
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 09:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762534803; x=1763139603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYxnmWzGo2FgZSV3QrLGs31hRLu8o7tb5ORNvsUhoO4=;
        b=WdpnBAYfZxUsOmr5v+4aE3lcZdppgmgJSor++1iAP10FPcIsV30Aru7cNCT8ZoKlfh
         92QE4kKBoiBDI53ecZg3yDsU45/Qp/8MrJ3I/cBnUCdRLewy9mz4tW7Zvxv8CX2kJYsC
         sre+u8zLL0IiJ0NeSpn7Tw2QXuQdRnOBl0dtPrUfhCrR2dDpDjc3Re0g9TQfq1cRDh+D
         kr5XtkAZqcJE15fgJqaPW0bJJI4uhqJ3OhmhlyFVbtKnj8qMtbw/3mwn+K7NlYjfIv8Q
         PrxCvaVp5Tx0JRBTje9Y5qOnUQEAwdl7z10DvMJCI5l2eXI7uDDx0Bd3ALGEID5Ohnd4
         Grzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762534803; x=1763139603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aYxnmWzGo2FgZSV3QrLGs31hRLu8o7tb5ORNvsUhoO4=;
        b=ASpW10SBVYHErvdvPl4eQfXA7xGr7UHcjjpVRFFfFMvLf/jg+9qT3Egy9tczHraI57
         hG2Ov9/GpH4nVu+VgpXaDOmKLiOZo6pExXL/70GfjIimiB5ZQxxJ0jRt789ZW7wiQouV
         DqsRp2ka6wP7qoM9JN815RTL81g+p9tkzyzVlQAFzg4cbZyGI5elPgR+FCs4rT38Y9Dv
         a+K+5pWh7JGmUt/xrvaDw4YPSpmfX1BnRAfPEO8MKeis4kqZc6UJPlLTIPtFzqLZdJjc
         50GNdyBA16HOcxllFMrnIspchS8IkG1GdxizdNpf38Q4ylw87t0khjxDTrrSMqcIi84E
         VU5w==
X-Forwarded-Encrypted: i=1; AJvYcCVIMP1jDYPGCNZZLqbOsT9iZcd8t6j9WDJYbapFV2cyrYVKMvAIQ7vsNeVXUrBJh1OqjqWbZto=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPqEGJLat8iK597t88McOCBLh+ik+o3WrhoU9JhP4iom7Ytu09
	UC7lVVszeSpZg1spQH7djNCT6FCBkRxz5UlZ3G9pdOZoRXjV4nbVEnyFLdJBLVqy3RqhwdyG0Wi
	im8/QEIgZpH7t6hr2fOGPN0jWh4BYmTI=
X-Gm-Gg: ASbGnctpo39NkOEvDqaGMaWsbe3LcHHqJas0zOVGBErvmDrLUHgRhUcBFrkMbF7ZXS5
	O5I/wSDZUOCcXDTF0ojmBj5mdtHTh81lIjnLGmFvWL87Ogx9CaT7BstegDe9xRKtsS3kBKtm0y5
	wz+0w9zWpdYOcuw88TiK/7yIwYxgQpc1hvnU3QGAbvqQjiE3AUHfOkFPBvK36a3caa8DrKJQVsW
	ED40lylsX2u0QDiF0L+O80hpijTXAE0sXI7ybTOuVD99zPelwwQ/DEmz8WhBm+Eyaqi24t5+Q==
X-Google-Smtp-Source: AGHT+IH3du6tEAP5+M3nwf4Auy9T2ScsUUH3EpG1JUxqPt9E0EbeIWZ5Aj8oLsNw3pcr7usRwCkKhksMxd3mc2i5jPc=
X-Received: by 2002:a05:6e02:3398:b0:433:4efc:aa6e with SMTP id
 e9e14a558f8ab-43367dd9ae5mr3300675ab.6.1762534802149; Fri, 07 Nov 2025
 09:00:02 -0800 (PST)
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
 <CANn89i+4OKrAq6DPZ_=MeDhGmEXDn6k-dRrEyzO8pmy=hN6VwA@mail.gmail.com>
 <CAL+tcoBkzggvE=3Y4jeeY9BnnBkNTFXjxN1H1ceKkDGg1ktzAQ@mail.gmail.com> <CANn89iKP7X_GsuP9VcUJURC3T4Z2wJTyjf2GS0PCxZnb6APnCQ@mail.gmail.com>
In-Reply-To: <CANn89iKP7X_GsuP9VcUJURC3T4Z2wJTyjf2GS0PCxZnb6APnCQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 8 Nov 2025 00:59:26 +0800
X-Gm-Features: AWmQ_bn-hxfcVp2m8Wzezu0u5UxGPaxr5On6sktMLPWHjmXCbAfCcKUhifnFII8
Message-ID: <CAL+tcoBH+wLmmuCpJ-rr+nbDrDRbUdGjpxUO1bcsc=CK141OuA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: increase skb_defer_max default to 128
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 12:26=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Nov 7, 2025 at 8:21=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > On Sat, Nov 8, 2025 at 12:08=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Fri, Nov 7, 2025 at 8:04=E2=80=AFAM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > > >
> > > > On Sat, Nov 8, 2025 at 12:00=E2=80=AFAM Eric Dumazet <edumazet@goog=
le.com> wrote:
> > > > >
> > > > > On Fri, Nov 7, 2025 at 7:50=E2=80=AFAM Jason Xing <kerneljasonxin=
g@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Nov 7, 2025 at 11:47=E2=80=AFPM Eric Dumazet <edumazet@=
google.com> wrote:
> > > > > > >
> > > > > > > On Fri, Nov 7, 2025 at 7:37=E2=80=AFAM Jason Xing <kerneljaso=
nxing@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Nov 7, 2025 at 4:30=E2=80=AFAM Eric Dumazet <edumaz=
et@google.com> wrote:
> > > > > > > > >
> > > > > > > > > skb_defer_max value is very conservative, and can be incr=
eased
> > > > > > > > > to avoid too many calls to kick_defer_list_purge().
> > > > > > > > >
> > > > > > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > > > > >
> > > > > > > > I was thinking if we ought to enlarge NAPI_SKB_CACHE_SIZE()=
 to 128 as
> > > > > > > > well since the freeing skb happens in the softirq context, =
which I
> > > > > > > > came up with when I was doing the optimization for af_xdp. =
That is
> > > > > > > > also used to defer freeing skb to obtain some improvement i=
n
> > > > > > > > performance. I'd like to know your opinion on this, thanks =
in advance!
> > > > > > >
> > > > > > > Makes sense. I even had a patch like this in my queue ;)
> > > > > >
> > > > > > Great to hear that. Look forward to seeing it soon :)
> > > > >
> > > > > Oh please go ahead !
> > > >
> > > > Okay, thanks for letting me post this minor change. I just thought =
you
> > > > wanted to do this on your own :P
> > > >
> > > > Will do it soon :)
> > >
> > > Note that I was thinking to free only 32 skbs if we fill up the array
> > > completely.
> > >
> > > Current code frees half of it, this seems better trying to keep 96
> > > skbs and free 32 of them.
> > >
> > > Same for the bulk alloc, we could probably go to 32 (instead of 16)
> >
> > Thanks for your suggestion!
> >
> > However, sorry, I didn't get it totally. I'm wondering what the
> > difference between freeing only 32 and freeing half of the new value
> > is? My thought was freeing the half, say, 128/2, which minimizes more
> > times of performing skb free functions. Could you shed some light on
> > those numbers?
>
> If we free half, a subsequent net_rx_action() calling 2 or 3 times a
> napi_poll() will exhaust the remaining 64.
>
> This is a per-cpu reserve of sk_buff (256 bytes each). I think we can
> afford having them in the pool just in case...

I think I understand what you meant:
1) Freeing half of that (which is even though more than 32) doesn't
make a big deal as it will be consumed in few rounds. Thus, we don't
need to adjust the policy of freeing skbs.
2) Enlarging the volume of this pool makes more sense. It will then be
increased from 32 to 64.
3) Also increase NAPI_SKB_CACHE_BULK to 32 in accordance with the above upd=
ates.

If I'm missing something, please point out the direction I should take :)

>
> I also had a prefetch() in napi_skb_cache_get() :
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 7ac5f8aa1235a55db02b40b5a0f51bb3fa53fa03..3d40c4b0c580afc183c30e2ef=
b0f953d0d5aabf9
> 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -297,6 +297,8 @@ static struct sk_buff *napi_skb_cache_get(void)
>         }
>
>         skb =3D nc->skb_cache[--nc->skb_count];
> +       if (nc->skb_count)
> +               prefetch(nc->skb_cache[nc->skb_count - 1]);
>         local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
>         kasan_mempool_unpoison_object(skb, skbuff_cache_size);

Interesting. Thanks for your suggestion. I think I will include this :)

Thanks,
Jason

