Return-Path: <netdev+bounces-185610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B89FFA9B21A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AAA59A349B
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5723422156E;
	Thu, 24 Apr 2025 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="rqbpViVz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBFC1B4248
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508174; cv=none; b=iOwi0W95JFhtV5QonDrhcQ7Zmmylquauio/spaNWXuciI3zE+BnMHMjAE5bdCgOEKO2IX4xIfyOxk0ewPSbzeQGJypT/u5P9/ZJ1pQKbE6btMCCBy3Sq5PiKKsQbMYerCzyrVldKKhpoMfKprcZqFBKaxsNpkCKFem9QOpywtlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508174; c=relaxed/simple;
	bh=P9Ra9EBsuHe57phVU2HbSxsMHXG4p3mA6LrK5RQN/0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+8iJSdYgvGNDlClRWOQ6VL9Z+8R++5jHfW2pJPIp16ajMBD/mkerurF/zo30WvetNKnws2onjoSic4X+0/ZGppXArxgwwZQiNyom9eNGWLhAhdwZXq9ScniVV9KStZoC4opaQ2wymfk2HHI8hkb2LLc8PzB3KU1+sbpil/r8ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=rqbpViVz; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af52a624283so1127210a12.0
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 08:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1745508172; x=1746112972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hA7Ba26JGhfQR9p9e92P+E28XsBHiTPtB8nzPxji11A=;
        b=rqbpViVzSZbt2wLY5uNsRliMXRpBFkBU2B4Yurc2DhExXKrqfTyU2EJPacZOqCfD4z
         k7GyuWhhggikOILoZjpmdwRTIVQrAOl347e76YIYfJvZpHXQhp7DOqMhhpyHdICezrEl
         r2kuXsLioXAK6IYUyRbCljYrr3QM4xmGy/ijB72Yf019tfnJXgRHl2FjNfu1MwzRekle
         P0belweU1Bp6JOHxDZNfbDVaMTA4LyFv7S9opNwLlPzCeEOBRs/n97nnHO+Ia6NCDzDZ
         6lJhk3ICzVlmfgrSZA/vH4h9isJbz1Cff4qndjf4Y9TzKaQ9dXGkAxDjFpYkP9OfLMlL
         HfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745508172; x=1746112972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hA7Ba26JGhfQR9p9e92P+E28XsBHiTPtB8nzPxji11A=;
        b=ZC3ufnLVwDUFINznhR88saIeUor2g6Fp7p7yKHaI8pW3VnQ7iTgyoVxpce9f6tfDkM
         FzjYpP1oPTrCy1e7YWkSV/1KQMQbzi/cI82fhbV1YrQzzlhNqWVvJPH+2W2gb0SoMfvp
         EmcTio/T1yL8YF6nbMNqf+fn/zPVrF4tvupemBGkvBO74wlJyT5PuT3g6NrfdPscQQTr
         RumBKFlqVzM7zkvcI28IkioDXsZjrAgJaYFTxMzZbfWAkBGvs4QCEKcVo7pCaX8p4uDi
         3QflMgyr4rG/zvT3NIQRnZVxtZbUgNlHtScmIPTCiQC8jfAF7KIksazf/bOzLSPXAe3I
         /wMg==
X-Forwarded-Encrypted: i=1; AJvYcCVETIVPpORp3WfH/pLdN8T36qozYey4DnOjIfZY8h1fAL9UlEn1EZI5nrrlAPjF8E89ojpnS5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/c4QW3UhczbIYiQ4NMC8nA7Zsc9K/WSa/Lj1GdyDt4xj4UtCw
	9xP/uKComQB+w85uXH3x04nSCQud4SXziBnoiu+T7NdBNKG+ZWY7BAmQgH1ceS938u1SQsCz1oF
	jybS2uqIDGLVu3/UGXVZw7o3pIkmqE6WSbzCp
X-Gm-Gg: ASbGncuJ2JSsfI75lPd+fqROgaNmPqyZupE3e2UIKIXYzZ+e6z60jJ2UmzHXGpXZva3
	kIenC4q5J+Gc0vtetarRo2qbdHxVLNR+tlwgXQi/VuAF+aNbHJClIYI/ousJZUlMW/S1EaB0RFp
	Tc1o9ujciYXPWYQIL7friXIg==
X-Google-Smtp-Source: AGHT+IG5HfEL/z0REAwTeryaLmO6NfaYs4y1TsRfmRdtE7Z6X9OWTg7C7P9OE6KHDVTDsCdahLpFslE7lpGcD9TUyyY=
X-Received: by 2002:a05:6a21:204:b0:1f3:1ba1:266a with SMTP id
 adf61e73a8af0-20445af2509mr2893535637.0.1745508171865; Thu, 24 Apr 2025
 08:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416102427.3219655-1-victor@mojatatu.com> <aAFVHqypw/snAOwu@pop-os.localdomain>
 <4295ec79-035c-4858-9ec4-eb639767d12b@redhat.com> <aAlSqk9UBMNu6JnJ@pop-os.localdomain>
 <aAl34pi75s8ItSme@pop-os.localdomain> <20250423172416.4ee6378d@kernel.org>
In-Reply-To: <20250423172416.4ee6378d@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 24 Apr 2025 11:22:40 -0400
X-Gm-Features: ATxdqUGCnFqiTk74fmm4pr3DZdxYO9--y-VuPiXyIZihMTDtLglBEi4wXWTlOsI
Message-ID: <CAM0EoMki518j_geesnGwh2jk51Z5BGRGootTGQq3HcP79y2ygQ@mail.gmail.com>
Subject: Re: [PATCH net v2 0/5] net_sched: Adapt qdiscs for reentrant enqueue cases
To: Jakub Kicinski <kuba@kernel.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Victor Nogueira <victor@mojatatu.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Gerrard Tai <gerrard.tai@starlabs.sg>, Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 8:24=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 23 Apr 2025 16:29:38 -0700 Cong Wang wrote:
> > > +   /*
> > > +    * If doing duplication then re-insert at top of the
> > > +    * qdisc tree, since parent queuer expects that only one
> > > +    * skb will be queued.
> > > +    */
> > > +   if (skb2) {
> > > +           struct Qdisc *rootq =3D qdisc_root_bh(sch);
> > > +           u32 dupsave =3D q->duplicate; /* prevent duplicating a du=
p... */
> > > +
> > > +           q->duplicate =3D 0;
> > > +           rootq->enqueue(skb2, rootq, to_free);
> > > +           q->duplicate =3D dupsave;
> > > +           skb2 =3D NULL;
> > > +   }
> > > +
> > >  finish_segs:
> > >     if (skb2)
> > >             __qdisc_drop(skb2, to_free);
> > >
> >
> > Just FYI: I tested this patch, netem duplication still worked, I didn't
> > see any issue.
>
> Does it still work if you have another layer of qdiscs in the middle?
> It works if say DRR is looking at the netem directly as its child when
> it does:
>
>         first =3D cl->qdisc->q.qlen
>
> but there may be another layer, the cl->qdisc may be something that
> hasn't incremented its qlen, and something that has netem as its child.

Very strong feeling it wont work in that scenario. We can double check.
Regardless - even if it did - what Victor sent is still a fix. Seems
DRR had that bug originally. And then in the true tradition of
TheLinuxWay(tm) was cutnpasted into HFSC and then the others followed.

cheers,
jamal

