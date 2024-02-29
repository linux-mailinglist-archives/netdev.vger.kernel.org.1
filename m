Return-Path: <netdev+bounces-76125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE63B86C6E0
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 11:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BBD61F22942
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 10:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C828663504;
	Thu, 29 Feb 2024 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTwCAOB7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE1264CD5
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709202410; cv=none; b=qDnH2g29rT3GMH0iYQJVCcKYgEzanW9SusU+lODTM178mMdIAqU7zh5rbvhoD7uP7K8miVIhfY0ntOE0T1ET/j8XJOQRXulUGG9i8zLRIo3Yvy/ghiocdL/eat3azyYYKWBo322KtEP6BcJmWkzzC9EWKltmeZWt3JQi1M+Js1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709202410; c=relaxed/simple;
	bh=JFtlQtX08v24Ylx3dxXE35IPy+/hi1g6yJZ61zeJeQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YE+x+YLHdUPn3bHV9h7SH859kv3Hh9BdxsTppYyQ4eqWkvPcgusxPRmF3LEp+8bG8JkXspHVhw05gvDGyJc5qEicPZe1dW5J+jyWMIvZL/4JoNSYgsPaXUvZQkAxnJVtJU0GIvC+jPhDAqoVqDmFMQsyS4gtJNszguSDZ0ucrlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTwCAOB7; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so797739276.1
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 02:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709202408; x=1709807208; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5jta4vjvJ7/12MtOocaS6dVP2qRC6nZvFeLA6WW4lo=;
        b=MTwCAOB7qlISEFeL/fimRc8jH2+CqNpKgaq9dQ2WeD2s4Fgz0aZqFwV9Y+9i0cJ0kY
         PE36o9aOVuGw0s9DmJj01Bwrz8xukSpo+Ly1QSB1/GKUDXxQw/hVIDA386dnj0btCuv1
         CVH0krOxuquyixNhh5Z7UfapwOVXPQAe2+2a4yvNuZgTlzvqZIpz0IJPekYO1/XHf78I
         6BI7v9eaZm+JDd2bjGCkF6HhhH5VeAGERZ/QDIKABeCcEbf2NxLTxF1p+BMqwkGuU6dU
         YTAvtLlFVZfw+ZV5gR93XzBjTUXZkIJaV6pyUFdJ3agC/9gK0J3V1m3wZyJc+q6DI/1X
         YT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709202408; x=1709807208;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5jta4vjvJ7/12MtOocaS6dVP2qRC6nZvFeLA6WW4lo=;
        b=E5V8YXLX/ovkfAi0+BTnQ357nUIVWnnLEopTCyvA/Ig7W59mGlY9R/y1pkZ1FZHZzW
         jp9MrFwiPzF+c4QvipM3Js7UXTLglEZhibqb1QmHTvknCjWjh58I9QEIzzNT58sIfYM9
         qJ2peNpMeu0F7uz1pFC57vQnpOEVPNd1FUeMsg9+6m5+bWh41K8M3jf7pOuxoBTalsWR
         fSY5p8oiE+y46oK9VNQpWzKF2OOniU1PvbvN4/isTLkrUDqFnA2ayTW5X/ppyoSc2cnD
         G114OYpwC9JZw0JTq1ZfNLeGiDJLqHUzlY4WrN5ACf8QZwUz+o4sK6OQIz9nyP/bQLpf
         UB9A==
X-Gm-Message-State: AOJu0YzKtdTuQrH7BucLItK3WojntkZLkAtaMeHFFJdbLXrNgb/NoiHo
	3m9L84YXbOCgjv6TYjs8MDOFtSBiQZ4nx/Razw6PWtQ+XSg1YI0xNm5p1RXn/kOCCPvGbIn0P4T
	Muy07TLVfZKsIPc8cIU6/q6BImqzkD0a55U3z7Ks=
X-Google-Smtp-Source: AGHT+IF+7dKFxBTBBMSuGNDnRt1Ca+LXdwoykQaA/7yXe3p2D1/Rp1crVXD44arV69zGEvPlsvdhUAup7FiQum2eqNA=
X-Received: by 2002:a25:ab34:0:b0:dc7:8c3a:4e42 with SMTP id
 u49-20020a25ab34000000b00dc78c3a4e42mr1935854ybi.30.1709202407941; Thu, 29
 Feb 2024 02:26:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229052813.GA23899@didi-ThinkCentre-M920t-N000>
 <CAL+tcoAhvFhXdr1WQU8mv_6ZX5nOoNpbOLAB6=C+DB-qXQ11Ew@mail.gmail.com> <CABbqxmdM+zbn+78rcB_amqfwFKXCTwyj2MPt2GVioQpR0Tj1Tg@mail.gmail.com>
In-Reply-To: <CABbqxmdM+zbn+78rcB_amqfwFKXCTwyj2MPt2GVioQpR0Tj1Tg@mail.gmail.com>
From: yuanli fu <fuyuanli0722@gmail.com>
Date: Thu, 29 Feb 2024 18:26:35 +0800
Message-ID: <CABbqxmfyLZRLk7OkUDtvdchc=VaC2iPgnY2tiSFTqzaJ6SzR+A@mail.gmail.com>
Subject: Fwd: [PATCH] tcp: Add skb addr and sock addr to arguments of
 tracepoint tcp_probe.
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

---------- Forwarded message ---------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A yuanli fu <fuyuanli0722@gmail.com>
Date: 2024=E5=B9=B42=E6=9C=8829=E6=97=A5=E5=91=A8=E5=9B=9B 16:27
Subject: Re: [PATCH] tcp: Add skb addr and sock addr to arguments of
tracepoint tcp_probe.
To: Jason Xing <kerneljasonxing@gmail.com>


Jason Xing <kerneljasonxing@gmail.com> =E4=BA=8E2024=E5=B9=B42=E6=9C=8829=
=E6=97=A5=E5=91=A8=E5=9B=9B 15:30=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Feb 29, 2024 at 1:33=E2=80=AFPM fuyuanli <fuyuanli@didiglobal.com=
> wrote:
> >
> > It is useful to expose skb addr and sock addr to user in tracepoint
> > tcp_probe, so that we can get more information while monitoring
> > receiving of tcp data, by ebpf or other ways.
> >
> > For example, we need to identify a packet by seq and end_seq when
> > calculate transmit latency between lay 2 and lay 4 by ebpf, but which i=
s
> > not available in tcp_probe, so we can only use kprobe hooking
> > tcp_rcv_esatblised to get them. But we can use tcp_probe directly if sk=
b
> > addr and sock addr are available, which is more efficient.
> >
> > Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
>
> Please target 'net-next' in the title of your v2 patch.
Got it, thanks.
>
> > ---
> >  include/trace/events/tcp.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> > index 7b1ddffa3dfc..096c15f64b92 100644
> > --- a/include/trace/events/tcp.h
> > +++ b/include/trace/events/tcp.h
> > @@ -258,6 +258,8 @@ TRACE_EVENT(tcp_probe,
> >                 __field(__u32, srtt)
> >                 __field(__u32, rcv_wnd)
> >                 __field(__u64, sock_cookie)
> > +               __field(const void *, skbaddr)
> > +               __field(const void *, skaddr)
> >         ),
> >
> >         TP_fast_assign(
> > @@ -285,6 +287,9 @@ TRACE_EVENT(tcp_probe,
> >                 __entry->ssthresh =3D tcp_current_ssthresh(sk);
> >                 __entry->srtt =3D tp->srtt_us >> 3;
> >                 __entry->sock_cookie =3D sock_gen_cookie(sk);
> > +
> > +               __entry->skbaddr =3D skb;
> > +               __entry->skaddr =3D sk;
> >         ),
> >
> >         TP_printk("family=3D%s src=3D%pISpc dest=3D%pISpc mark=3D%#x da=
ta_len=3D%d snd_nxt=3D%#x snd_una=3D%#x snd_cwnd=3D%u ssthresh=3D%u snd_wnd=
=3D%u srtt=3D%u rcv_wnd=3D%u sock_cookie=3D%llx",
>
> If they are useful, at least you should printk those two addresses
> like what trace_kfree_skb() does.
>
Got it, I will add to printk
> May I ask how it could be useful if there is no more function printing
> such information in the receive path?
We can get seq and end_seq by skbaddr in netif_receive_skb, so latency
between l2->l4 can be calculated.
>
> Thanks,
> Jason
> > --
> > 2.17.1
> >
> >
>
thanks
fuyuanli

