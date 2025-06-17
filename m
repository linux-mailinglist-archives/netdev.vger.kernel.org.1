Return-Path: <netdev+bounces-198722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 210A4ADD54F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 18:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1794B1885573
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4A12F2352;
	Tue, 17 Jun 2025 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdomRiN3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4F91B4257
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176267; cv=none; b=rAI99kRahdd+1kdZSAko3ibVGtkmEVUPc4voKqrpkGd3/NaxpoLp+zasdb+q8lKh86/IBiDGJtLAoDOn/wLx3qNFeioD4MRLPLQ/VBY6kIZxge5FSqPp22yNiAiHLrqTp/dcCQI33GLT/FHr7RwEYAapWPJij0YEXgkhB31297U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176267; c=relaxed/simple;
	bh=kgpHxwklZZndalThT99cZ+EI4AXYQwa3eGnbi+C8dzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIRZnu4LClJa+oNfei687RUPYQCXuo/4qz71f2ZVhgr7gKGxVDziBtpnxi60eSoPZbtVtgbgkork/2bYkdGKgLYttlXLGKAoEUEnRCW4sOzEsuiX4eyLwH4yF9aKWlg4IbZ84eFKxw8mQgxQrXeRZcJOa6LaJB0i8To1mf9zY50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdomRiN3; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b2c49373c15so4622571a12.3
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 09:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750176265; x=1750781065; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=likMQHZGXTezHe2Xv/iadx8pWp/Bi+O8w1V2oxspZFM=;
        b=IdomRiN3oxFSj3bRh+FVyozomrW2joIY+5Yi/SHaypXDhzxZ2DXWGwPKwP31U59s+x
         Uvwb7eNBtvwWafFLdigRDMj4bEqtmtHkOE5n44TArOD6Qp8OfOaNwGCMty/5NckIvb3q
         wRmKlVumT9s0OtU3FfF8jXQvsuU3z52ZPxx51BL9u7lQKvU9CDdtWzumR4e6FKc9NkHT
         YheafwPT2t73ZsScgtmcRVYOtw7UyDpDaal4ZKcgPUa+eMZxlM/ii6v7udg5JbbFbNrV
         WRnR60TI8ElSrrmJvzhlRcJ+78Zxi4FJGLo1mPA3uS3TxtH+Te/b30MdH1CD+enQt+K2
         3L3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750176265; x=1750781065;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=likMQHZGXTezHe2Xv/iadx8pWp/Bi+O8w1V2oxspZFM=;
        b=Xa8sLOdMOzBOTOuzGuxgOwBQPqN3vhoAKiaJXE7TosidfLwOXNg+RNxNr58LASrJGM
         GTWxvCgbkwF5VFjtupSCokA2chTc/iASR7ye1kwTnkMz1hL2IRYBM4LUghdq1i+6tarX
         jEHkeIZJLIwZcj6ZlVW4uErcPcnQPQlRH+NWwmLc74p9l0L9fPDWrCzv5mL3i7XwhO1Y
         cmQxMe2zysnbu9W4PxmDsPARC7t8Qj41DMdpmLog+k8wBd+JdhxySw87IrEAy2853D+E
         OsupNyoLIrR7/yydgFjBWmBbTe6Oh5s6Q/G75NWbB99+BCzQ5X/at/QVBiZa4cciukrX
         Rp0g==
X-Gm-Message-State: AOJu0YyC0q+hpi3KndJtPkiGmAxbyWXi6tJGlrNnTOZNxFhO6F2mt+Za
	BGn1wXO9CuvP/aVYLHJHIRaK/WODu7F80Oj0w7uPiWFljoHFjKorcaEscJcQcD7mz8lKMEKqdYb
	Sy+eDEvm8l6ZQmBR4+J1OZ4gJCPwEMxivfzIIy3o=
X-Gm-Gg: ASbGnct7GcK/W2M81TF/0DihHvEwPKv91zjmy2piTTfSoZaKeZ/YoKPq4cFWsoPkRZW
	uW9HMvtXxeK53nkRbHvUT4bJsBlty4Jfu31B06RK837l4yvcD6vKGXU5qAci2mByYMvCNcrFrBi
	+n1BRztk4i/tK4E1BXreXU26c2ZRt3anAsq3abt+UrF85Tqw==
X-Google-Smtp-Source: AGHT+IE9IYlny+0+NqQKm7ojjuxGofEOK+Mm15rGr5P+kqm7wimf4u6IrsuJX8H5NNoSZQObRS8+2A92i9G6piizrPU=
X-Received: by 2002:a17:90a:d2c6:b0:311:e8cc:425e with SMTP id
 98e67ed59e1d1-313f1df4413mr20400150a91.31.1750176264733; Tue, 17 Jun 2025
 09:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613174749.406826-1-vladimir.oltean@nxp.com>
 <20250613174749.406826-2-vladimir.oltean@nxp.com> <CAO9qdTE0jt5U_dN09kPEzu-NUCds2VY1Ch2up9RoLazsc1j49w@mail.gmail.com>
 <20250615160352.qsobc7c2g3zbckp2@skbuf>
In-Reply-To: <20250615160352.qsobc7c2g3zbckp2@skbuf>
From: Jeongjun Park <aha310510@gmail.com>
Date: Wed, 18 Jun 2025 01:04:15 +0900
X-Gm-Features: AX0GCFuRMprajXRtg-YosKAYBb3fYiUtLrDNzZc-ERuFY6MrU_L37xxq-_f0FTA
Message-ID: <CAO9qdTHnfMJFEOvENFGxestOWGE-5rzvA1XKdQn1y1KX-Sn=og@mail.gmail.com>
Subject: Re: [PATCH net 1/2] ptp: fix breakage after ptp_vclock_in_use() rework
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Yangbo Lu <yangbo.lu@nxp.com>
Content-Type: text/plain; charset="UTF-8"

Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
>
> On Mon, Jun 16, 2025 at 12:34:59AM +0900, Jeongjun Park wrote:
> > However, I don't think it is appropriate to fix ptp_vclock_in_use().
> > I agree that ptp->n_vclocks should be checked in the path where
> > ptp_clock_freerun() is called, but there are many drivers that do not
> > have any contact with ptp->n_vclocks in the path where
> > ptp_clock_unregister() is called.
>
> What do you mean there are many drivers that do not have any contact
> with ptp->n_vclocks? It is a feature visible only to the core, and
> transparent to the drivers. All drivers have contact with it, or none
> do. It all depends solely upon user configuration, and not dependent at
> all upon the specific driver.
>

I think I wrote it strangely, so I'll explain it again.

As you know, ptp_clock_{register,unregister}() is called not only in the
ptp core but also in several networking drivers to use the ptp clock
function. However, although these kernel drivers does not use any
n_vclocks-related functionality, the initial implementation of
ptp_vclock_in_use() acquired n_vclocks_mux and checked n_vclocks when
ptp_clock_unregister() was called.

> > The reason I removed the ptp->n_vclocks check logic from the
> > ptp_vclock_in_use() function is to prevent false positives from lockdep,
> > but also to prevent the performance overhead caused by locking
> > ptp->n_vclocks_mux and checking ptp->n_vclocks when calling
> > ptp_vclock_in_use() from a driver that has nothing to do with
> > ptp->n_vclocks.
>
> Can you quantify the performance overhead caused by acquiring
> ptp->n_vclocks_mux on unregistering physical clocks?
>

I think this performance overhead is a bit hard to quantify, but I think
it's wrong to add code inside ptp_clock_unregister() that performs
unnecessary locking in most cases except for some special cases.

> >
> > Therefore, I think it would be appropriate to modify ptp_clock_freerun()
> > like this instead of ptp_vclock_in_use():
> > ---
> >  drivers/ptp/ptp_private.h | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
> > index 528d86a33f37..abd99087f0ca 100644
> > --- a/drivers/ptp/ptp_private.h
> > +++ b/drivers/ptp/ptp_private.h
> > @@ -104,10 +104,20 @@ static inline bool ptp_vclock_in_use(struct
> > ptp_clock *ptp)
> >  /* Check if ptp clock shall be free running */
> >  static inline bool ptp_clock_freerun(struct ptp_clock *ptp)
> >  {
> > +   bool ret = false;
> > +
> >     if (ptp->has_cycles)
> > -       return false;
> > +       return ret;
> > +
> > +   if (mutex_lock_interruptible(&ptp->n_vclocks_mux))
> > +       return true;
> > +
> > +   if (ptp_vclock_in_use(ptp) && ptp->n_vclocks)
> > +       ret = true;
> > +
> > +   mutex_unlock(&ptp->n_vclocks_mux);
> >
> > -   return ptp_vclock_in_use(ptp);
> > +   return ret;
> >  }
> >
> >  extern const struct class ptp_class;
> > --
>
> If we leave the ptp_vclock_in_use() implementation as
> "return !ptp->is_virtual_clock;", then a physical PTP clock with
> n_vclocks=0 will have ptp_vclock_in_use() return true.
> Do you consider that expected behavior? What does "vclocks in use"
> even mean?
>
> In any case, I do agree with the fact that we shouldn't need to acquire
> a mutex in ptp_clock_unregister() to avoid racing with the sysfs device
> attributes. This seems avoidable with better operation ordering
> (unregister child virtual clocks when sysfs calls are no longer
> possible), or the use of pre-existing "ptp->defunct", or some other
> mechanism.
>
> You can certainly expand on that idea in net-next. The lockdep splat is
> a completely unrelated issue, and only that part is 'net' material.

I agree with this, so I think it would be a good idea to add the
ptp->n_vclocks check to the caller function that absolutely needs it,
like the patch I sent in the previous email, and to remove the
ptp_vclock_in_use() function altogether and replace it with the code that
checks ptp->is_virtual_clock.

Of course, I think this idea should be discussed through net-next after
this problems caused by the previous patch are resolved as you mentioned.

Regards,

Jeongjun Park

