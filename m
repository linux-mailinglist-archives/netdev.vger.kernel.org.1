Return-Path: <netdev+bounces-242429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 170ABC905C0
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 00:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D26D44E0F28
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 23:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE3C326939;
	Thu, 27 Nov 2025 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OliMPUV1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EE8328253
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 23:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764287328; cv=none; b=buZt6+hedqAOFRUyMkI1a+np5g/foxX2G1MNyXZq2QE52xhL667gxGOlqmH7lZWEmLXxZrmEo0sb27JA5Kksk5fHLNbeQpdDQQiFzecpKpJFQZodfv83O7+uxDf1W4NIdp2eo4U66Mz8SpBoOoMlTqZO5XLOvNDHggp/kR7wHB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764287328; c=relaxed/simple;
	bh=YsduwoMsD8hIAekUKDxK/MSUACtfE2yvVw+moofjTR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RU0ddzvullK5oV0jWxtrenzeTuT1Mw/OyRxTG026b35dSdaWpBk8sW24YpUXwfBSyIAulJwve1YOUX7op2Cp5PGq9/D7+dVec6SRE1ajHCtN4nKfEeRbLtyw+3odliQQVLLRkVJXLvhrziRTQe3xj0q1mNBGvAUBc78PO9vGjPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OliMPUV1; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-4330e912c51so5794345ab.3
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 15:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764287324; x=1764892124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PW1RKfkdQpyyU5Qki8GTuvVDzxfLQHQ2GUmA7S/TM0=;
        b=OliMPUV1wIXEINDdZB099CUtUlBCtuTFKdc91JsJxdPwQUe/DlqJlZ06d5sAlVWKm+
         Fm848SmymRHSMbd9XoGStDA15UMBL1YMhlusIMLvMbBww8piShgUhicNN6kUtfueQxtV
         pH+0N4BAPWwT6OtIONY6fAXx4dEHc1NhV9jsvKjZb4xaSHGKUT8DWD4RYSdIhGEm9vRH
         bOeB1gl39Wzyf34aiYk8LR+Whs3gVhi9ttgCaS7UDjR6a+Ic8pbhLqKpe4qOfd6VVVIb
         rk2u45/4o907/qQWTQMLbMD9acIhVB4FynW05cKmKMnx0q49Kj9KsHvw2+2+KrJz7mmV
         TaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764287324; x=1764892124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3PW1RKfkdQpyyU5Qki8GTuvVDzxfLQHQ2GUmA7S/TM0=;
        b=C3YgLVViXFUK2wgTANRB0CJAsh48kw3XXkbYXOzk7cCdq+ZDWvDHoDiTaqFXYFynK2
         1i087OgRZeIXQ33fgPVqMkWuTMxWnCwOU8LZq/Vus/7zMIqfofaMf7htK7md2uF9xmFj
         Z+OeGYxeGLLy/B8pfW7GcZbtxSyPKW5fHQ1t+Q9McmKYKXysTp0e46XnJM1tGOdi77wo
         T7c1/b3DVUqzppSnBFYRiWKI9GOMfSeqlzjoyRNQm5Gzxal7Dbwf25Md7xMURLAvO7AG
         tn0sWuYXN8Y+ftv/5kBKN7UszGU+5WPe8MxkK2vKm1i5NikjJctQnq/ZIg4kPItX7YNP
         aPOg==
X-Forwarded-Encrypted: i=1; AJvYcCVWXTjNUHHo7C8k5xEg/QQMIwYZ4SdWF4DDmawgDUAHETXVaJ5yrDjsua39pbORlwqq8YPDi3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YytE30DLRHn/dGydEJMnTnrpuvCKWjiCS03+hr1T2lAD0pOgUJm
	N+oFUBfq8JW6tYY2UB/qpyx8I1bkVCD8/m1a3cfETiMbstx111qOF7Hdz7KbA5PeCfCrv3/1i5H
	NYs13Ep8MyvYJ3qtSApaClbobR/vEPK0=
X-Gm-Gg: ASbGncsHAuQj7QyjL0W8d7r1F7/QzMM0vwqpTfXBMkUISVIRVpMHzu+AqdAtEQiAm8y
	Zfi0pTvRUC1CqXnDBR9sxBxMI4gI2ObimZK+FZA1pikGyN0S8743KaRwPNWEjdv44QjmBGASseM
	WEHnhSBzR1DJdpeJZ8zy2OeeMrmKFoMZYRBmZxWRkcMHuJb9OWSGYowCgq+zq9IP3mTy2TyA1Xw
	UyCT8Vf70iafMHxkv6WcovSRdcyfMEM9hYvsjBdXHRRP+7qDX6X24X+OV2TTUoOktHMlJ8=
X-Google-Smtp-Source: AGHT+IGSeOl1abZhEz6haRZS6F363yMwLkHnsQeAmDxWQ4dsIqhIhX11adSgTwjP6ka+EDTNz6LBI6qqtHbCVW6VAs8=
X-Received: by 2002:a05:6e02:2389:b0:433:5a5c:5d75 with SMTP id
 e9e14a558f8ab-435dd06a9f3mr103094115ab.18.1764287324153; Thu, 27 Nov 2025
 15:48:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125085431.4039-1-kerneljasonxing@gmail.com>
 <20251125085431.4039-3-kerneljasonxing@gmail.com> <0bcdd667-1811-4bde-8313-1a7e3abe55ad@redhat.com>
 <CAL+tcoCy9vkAmreAvtm2FhgL0bfjZ_kJm2p9JxyaCd1aTSiHew@mail.gmail.com> <f4ca72ea-e975-431e-9b7a-e32c449248ca@redhat.com>
In-Reply-To: <f4ca72ea-e975-431e-9b7a-e32c449248ca@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 28 Nov 2025 07:48:07 +0800
X-Gm-Features: AWmQ_bn1RrO6F9wHfjxgTzZoV5sAqGSoQ2rFYDySfa4EFa9ImHxo6OumszU2P8M
Message-ID: <CAL+tcoA7ZMsw1f6e=3WtpoyaT53cM9ryumcxT-b40VaUfuj-jw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] xsk: use atomic operations around
 cached_prod for copy mode
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 11:32=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 11/27/25 2:55 PM, Jason Xing wrote:
> > On Thu, Nov 27, 2025 at 7:35=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 11/25/25 9:54 AM, Jason Xing wrote:
> >>> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> >>> index 44cc01555c0b..3a023791b273 100644
> >>> --- a/net/xdp/xsk_queue.h
> >>> +++ b/net/xdp/xsk_queue.h
> >>> @@ -402,13 +402,28 @@ static inline void xskq_prod_cancel_n(struct xs=
k_queue *q, u32 cnt)
> >>>       q->cached_prod -=3D cnt;
> >>>  }
> >>>
> >>> -static inline int xskq_prod_reserve(struct xsk_queue *q)
> >>> +static inline bool xsk_cq_cached_prod_nb_free(struct xsk_queue *q)
> >>>  {
> >>> -     if (xskq_prod_is_full(q))
> >>> +     u32 cached_prod =3D atomic_read(&q->cached_prod_atomic);
> >>> +     u32 free_entries =3D q->nentries - (cached_prod - q->cached_con=
s);
> >>> +
> >>> +     if (free_entries)
> >>> +             return true;
> >>> +
> >>> +     /* Refresh the local tail pointer */
> >>> +     q->cached_cons =3D READ_ONCE(q->ring->consumer);
> >>> +     free_entries =3D q->nentries - (cached_prod - q->cached_cons);
> >>> +
> >>> +     return free_entries ? true : false;
> >>> +}
> >> _If_ different CPUs can call xsk_cq_cached_prod_reserve() simultaneous=
ly
> >> (as the spinlock existence suggests) the above change introduce a race=
:
> >>
> >> xsk_cq_cached_prod_nb_free() can return true when num_free =3D=3D 1  o=
n
> >> CPU1, and xsk_cq_cached_prod_reserve increment cached_prod_atomic on
> >> CPU2 before CPU1 completed xsk_cq_cached_prod_reserve().
> >
> > I think you're right... I will give it more thought tomorrow morning.
> >
> > I presume using try_cmpxchg() should work as it can detect if another
> > process changes @cached_prod simultaneously. They both work similarly.
> > But does it make any difference compared to spin lock? I don't have
> > any handy benchmark to stably measure two xsk sharing the same umem,
> > probably going to implement one.
> >
> > Or like what you suggested in another thread, move that lock to struct
> > xsk_queue?
>
> I think moving the lock should be preferable: I think it makes sense
> from a maintenance perspective to bundle the lock in the structure it
> protects, and I hope it should make the whole patch simpler.

Agreed. At least so far I cannot see the benefits of using
try_cmpxchg() instead as the protected area is really small. Probably
in the future I will try a better way after successfully spotting the
contention causing the performance problem.

I'm going to add your suggested-by tag since you provide this good
idea :) Thanks!

Thanks,
Jason

