Return-Path: <netdev+bounces-161151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9D6A1DAAD
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 17:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9A6188767F
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 16:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B201632D7;
	Mon, 27 Jan 2025 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFZ1K4e/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4816158DC5
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737995837; cv=none; b=XPeonzt/br0c5EwPeRCDTHtSS622vKVrIMOtCxo8jydKpyhBHEi4RR4oh3RGeS5jwKhAUrKToAKxydX4Irwv3JTVw7a/xKNINVi5gPv6hghBAkyLw1Q9OywHKm1tGrlye/NmPUQ330DMQZJDrmBdi+u5W9D6sZaeSGjIIelz+nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737995837; c=relaxed/simple;
	bh=9Euv7UqqfBsOfGvW/NKr2SpMv/xKh6rZEI73AeL9Sx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcALHA7yBntBW/ZUxDZ1xikquNU3KNnVj7ZWWM+VP/W+l23ky51A6dvmLKswTYoZb14JVKsYavPfwG1klH2Py2qSHrhGllaADS0BTsqatC1tDAOgjyEhJu6CqExWKeC7vIKPF3fsC6vAt9qw7nEFNQU3UY95QSuNhjOcUqVINx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EFZ1K4e/; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa68b513abcso959023066b.0
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 08:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737995834; x=1738600634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsgDs7vjk37Nv0OdmfDEhpVK2JsB/E4w2pYC01BWuCg=;
        b=EFZ1K4e/76Kk060M/h05FUkOipigqDKh3OD2TZFzc9hhZ7MSN+XvyEuRwVVm3++uM/
         +4Jqoi3li5Q/NeB5pFpOS9d0fehL24eHTQGGLAqTSCe9Fntpp0uqpchQurp4itf6e3du
         rLN4RuZZO6efnRT8nHtRKdKuVLBKWx3nm4FGKo4MBd/9zcR3otvAIJE2cYrJd6yyDqBF
         a69/ftGYgZE31Jl8OvP6vMGx6k7Q0E2nAQ5y5k0iobMj1UPR30ENyvqKgkdrgp8/OZ2R
         tmDOPJTmtZMNr+vI/cSHnwVCBL8/SNGUlTKRzrIxmIXxUy1WzxTOXXbPmYqdrEqApWiY
         wyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737995834; x=1738600634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsgDs7vjk37Nv0OdmfDEhpVK2JsB/E4w2pYC01BWuCg=;
        b=ndwaoemsuRrdBunIK5CUk9QB7U7EhrxVvw1GMH93twwVWMef5YgGGeMrYO25aDUahQ
         iYnaiQuUO4qExvucR41U+t397rWg7OWa1cHQN+gNmJIIoDUlHFdYwmI+sSuQt6v8fdj+
         5oRm3er+skBMCuSKDcvWy+fwq5d1GOadUDfee1OtfHkZTQb1WEH4KyizoCVEkjjlWQ9y
         aKwSzXrbM2FIxNggmXRG4xFZz/GG61ywZVa1d6ouhM0SWX7KWU1dYOD+ND/Tbw0iovgP
         7h792tCxqnrSjyIg6RkXi5iUBxNVUAN5M/Sdnbwj0vTzax4DKgk/wd/nBSDW/e7d//5x
         cnzA==
X-Forwarded-Encrypted: i=1; AJvYcCWn2X9XRc5buwk72rjnfHgkZXXqHOwpM/93gkVj6y3P7xES8XubY714G/9KM/3p0vDm6ThpWE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxRnkn9nNWbL50Os7dX03NQgv08CMbkg8BxBQXY1kRgNEB66LG
	DCXgFGgBC2MCIcXFYr4+frHg+CdUYG1yBmnxXCtYshTt2gXKYG1IVEjfAgnvQYzC786ONVGcJ0F
	Kv2oO6oeefPEG3LSPocXv1z3CA3ZVoBeWySSW
X-Gm-Gg: ASbGnctPuoEfNBM9T7f6gayZgdQeM5QYzgoEdj80BSGnXx7XN2GJf0adR+XAfyoxQ0S
	zTpCduned39/UDCUNT3haEOjpDJYp82MNcbciSN8JSOmEMCLtQL3J6wrBx4P9jw==
X-Google-Smtp-Source: AGHT+IEC7871tnGPEW7pCJoHJwcH326cGDcMV/EqYFJcDsAr6z3H+tfiOCOdtA+RDxxV8Kap4Iv2pMhSRxynnNcHQ24=
X-Received: by 2002:a17:907:97cb:b0:aaf:c259:7f6 with SMTP id
 a640c23a62f3a-ab38b36bcf0mr3762742066b.45.1737995833746; Mon, 27 Jan 2025
 08:37:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117214035.2414668-1-jmaloy@redhat.com> <CADVnQymiwUG3uYBGMc1ZEV9vAUQzEOD4ymdN7Rcqi7yAK9ZB5A@mail.gmail.com>
 <afb9ff14-a2f1-4c5a-a920-bce0105a7d41@redhat.com> <c41deefb-9bc8-47b8-bff0-226bb03265fe@redhat.com>
 <CANn89i+RRxyROe3wx6f4y1nk92Y-0eaahjh-OGb326d8NZnK9A@mail.gmail.com> <e15ff7f6-00b7-4071-866a-666a296d0b15@redhat.com>
In-Reply-To: <e15ff7f6-00b7-4071-866a-666a296d0b15@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Jan 2025 17:37:02 +0100
X-Gm-Features: AWEUYZlyr6kt4nD2O6C2lXtTxoIC0GSvZOwHzbAuI92mVQe7kwjeSA-M-afX5h4
Message-ID: <CANn89iJmQc6r+Ajh3N1V3Q22iJ4C=Ldte5pBVd=jC-YTQYuQTA@mail.gmail.com>
Subject: Re: [net,v2] tcp: correct handling of extreme memory squeeze
To: Jon Maloy <jmaloy@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com, 
	dgibson@redhat.com, eric.dumazet@gmail.com, 
	Menglong Dong <menglong8.dong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 6:40=E2=80=AFPM Jon Maloy <jmaloy@redhat.com> wrote=
:
>
>
>
> On 2025-01-20 11:22, Eric Dumazet wrote:
> > On Mon, Jan 20, 2025 at 5:10=E2=80=AFPM Jon Maloy <jmaloy@redhat.com> w=
rote:
> >>
> >>
> >>
> >> On 2025-01-20 00:03, Jon Maloy wrote:
> >>>
> >>>
>
> [...]
>
> >>>> I agree with Eric that probably tp->pred_flags should be cleared, an=
d
> >>>> a packetdrill test for this would be super-helpful.
> >>>
> >>> I must admit I have never used packetdrill, but I can make an effort.
> >>
> >> I hear from other sources that you cannot force a memory exhaustion wi=
th
> >> packetdrill anyway, so this sounds like a pointless exercise.
> >
> > We certainly can and should add a feature like that to packetdrill.
> >
> > Documentation/fault-injection/ has some relevant information.
> >
> > Even without this, tcp_try_rmem_schedule() is reading sk->sk_rcvbuf
> > that could be lowered by a packetdrill script I think.
> >
> Neal, Eric,
> How do you suggest we proceed with this?
> I downloaded packetdrill and tried it a bit, but to understand it well
> enough to introduce a new feature would require more time than I am
> able to spend on this. Maybe Neal, who I see is one of the contributors
> to packetdrill could help out?
>
> I can certainly clear tp->pred_flags and post it again, maybe with
> an improved and shortened log. Would that be acceptable?

Yes.

>
> I also made a run where I looked into why __tcp_select_window()
> ignores all the space that has been freed up:
>
>
>   tcp_recvmsg_locked(->)
>     __tcp_cleanup_rbuf(->) (copied 131072)
>       tp->rcv_wup: 1788299855, tp->rcv_wnd: 5812224,
>       tp->rcv_nxt 1793800175
>       __tcp_select_window(->)
>         tcp_space(->)
>         tcp_space(<-) returning 458163
>         free_space =3D round_down(458163, 1 << 4096) =3D 454656
>         (free_space > tp->rcv_ssthresh) -->
>           free_space =3D tp->rcv_ssthresh =3D 261920
>         window =3D ALIGN(261920, 4096) =3D 26144
>       __tcp_select_window(<-) returning 262144
>       [rcv_win_now 311904, 2 * rcv_win_now 623808, new_window 262144]
>       (new_window >=3D (2 * rcv_win_now)) ? --> time_to_ack 0
>       NOT calling tcp_send_ack()
>     __tcp_cleanup_rbuf(<-)
>     [tp->rcv_wup 1788299855, tp->rcv_wnd 5812224,
>      tp->rcv_nxt 1793800175]
>   tcp_recvmsg_locked(<-) returning 131072 bytes.
>   [tp->rcv_nxt 1793800175, tp->rcv_wnd 5812224,
>    tp->rcv_wup 1788299855, sk->last_ack 0, tcp_receive_win() 311904,
>    copied_seq 1788299855->1788395953 (96098), unread 5404222,
>    sk_rcv_qlen 83, ofo_qlen 0]
>
>
> As we see tp->rcv_ssthresh is the limiting factor, causing
> a consistent situation where (new_window < (rcv_win_now * 2)),
> and even (new_window < rcv_win_now).

Your changelog could simply explain this, in one sentence. instead of
lengthy traces.

