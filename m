Return-Path: <netdev+bounces-202934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3991AEFC06
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0557485127
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7D22749D9;
	Tue,  1 Jul 2025 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="j5g5HvU+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C336271A7C
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379324; cv=none; b=BR/EtZbcWMgXfUEEpw0hpvNPhpn6hLFkWlkUpWgUOepsjq9jKKrjYdz8J6E5z3KxjljoMM7LcZz0Zfunc1DMOAR+8NUBUDEj9hru0XHgx4Hhhue1G1rxxyUITntWhw+EASsBg22J3W7welcoUXUB1CZnVuY5BfIfHc8jF1oeN88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379324; c=relaxed/simple;
	bh=5TyTjV5rc9VSI2AM/6duOYVNuC/8zLuG2kkklgMArbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RX6xZkzqiteM6EsIi+QLFjcyfWIKBAWBEE4sCK/H7kKvZfYDWmZ0Yj5a878vQmQnf7Sfj83DT2D4WniKNcl9obTIYBtRvwJm8DIRWelCAMmGFzWfz8yNbRUBuOfWIYkqyKCfWgQZV6TUVWw08W0MnTsAIXTBsIiF3tVU8++49X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=j5g5HvU+; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7426c44e014so5853103b3a.3
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 07:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751379322; x=1751984122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TyTjV5rc9VSI2AM/6duOYVNuC/8zLuG2kkklgMArbI=;
        b=j5g5HvU+uAj1reip0h0n8TIFjmJVdn6NaAocwdXApM+P8F987azjEAcHAuhswvNBMN
         DGKk3uP/DfBI86PmrHfHXw/bDw9FgFPWaNQqLozxaILJb3T9/bIMBNegRqeVLaODNQP/
         1Of2YbEV6PJU39Sz1yKK5K9xJAw13EUe65+4iJgv+D6WwwdBtmleF3a62rFyx3eMbrbg
         6rEnDSs1hVTzPt4YW7tCKu/SpjdPfFOLvinZJQCKqca40odDDU8RijsSBKA1sU6GKbFG
         W5NVdzfELdH5K6r/D0kRMhTHUyBGTuuBYl5c2A3JiZpKT9VueG6oYJ8Y4QK9VtKuGx1k
         33Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751379322; x=1751984122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TyTjV5rc9VSI2AM/6duOYVNuC/8zLuG2kkklgMArbI=;
        b=miP2o1EADxrWD39pCO/G2lBLBI61ddII5linFJIaeq2Ce2fSRbhMuOerssxHNNXuEl
         4BJOROzXt5CLnu7zjt7y4iB8uecFKXxcggaFT0A+rWOARN/Gl6bOeBcyELHIDDI+4vtE
         oySrJYl/N2vDlQfzY6emt//Y0Seh2B3ikqibGSPwWRux1V3noi5OhhbyhH/jGNM2bSYn
         jI6xZE7BNshyWsaiqe+ssKWBJuEKwCtn1Le06/dXnm4RgT8s9LVTbw//bI3Q0EmehvvC
         nspLZUZLNJVMzXFrL0AwDXbC+VnpQqsm7FTt+a5fDcyP5gnDYGaArTq6pZDDv1cnnokO
         p5sg==
X-Forwarded-Encrypted: i=1; AJvYcCVZAtHI4rctVUBk8joRgKLGImN3Jz71jfo3be6d7CqUonWUy4GKXSIj5zf/cit0IEI+bDEFHwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIHuFubpL89iKVZsg/oqfmHp2pfxpLdY6cJx0aXgngBtP4KgxN
	dI6sJKJZzDxqtkOPlpPXD0p4VtbRdhU7OsezKNXUmxAivj6EDQ4oeFO98conKxXyweCr0sDw0S4
	UUNWl1pr8iSg/kwYQR0R/0zdJ1Bupj6S6bfWTqOXIIo+iNQEYQI5WoQ==
X-Gm-Gg: ASbGncvVxi37G7iNXtT/MKT1a+U3RBzRFcEy22cf/+FCnuqAV0hFDmAZZIlzWW5A67L
	JuORFDARNPi8DQKWd24g4wOToZVerwSYpvddmTmaXjSMebPQYEELLFA4dAdzG9H8FjrM528tFz9
	myzxPosa717pAGZGx0i1rtwt3paUQPLDNJc+DzDpZFtg==
X-Google-Smtp-Source: AGHT+IHL2D9BYQJanb9784n4qc4e1Zm29e7PCnVRphAxB3I7BEJAToOJ1fVry6l+UnQ2yaP8vRD4aOi2iqpDV8NGGKM=
X-Received: by 2002:a05:6a20:7f93:b0:203:9660:9e4a with SMTP id
 adf61e73a8af0-220a1804eeamr30335684637.41.1751379321520; Tue, 01 Jul 2025
 07:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627061600.56522-1-will@willsroot.io> <aF80DNslZSX7XT3l@pop-os.localdomain>
 <sf650XmBNi0tyPjDgs_wVtj-7oFNDmX8diA3IzKTuTaZcLYNc5YZPLnAHd5eI2BDtxugv74Bv67017EAuIvfNbfB6y7Pr7IUZ2w1j6JEMrM=@willsroot.io>
 <CAM0EoMkUi470+z86ztEMAGfYcG8aYiC2e5pP0z1BHz82O4RCPg@mail.gmail.com>
 <aGGfLB+vlSELiEu3@pop-os.localdomain> <CAM0EoMnjS0kaNDttQtCZ+=hq9egOiRDANN+oQcMOBRnXLVjgRw@mail.gmail.com>
 <aGMSPCjbWsxmlFuO@pop-os.localdomain>
In-Reply-To: <aGMSPCjbWsxmlFuO@pop-os.localdomain>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 1 Jul 2025 10:15:10 -0400
X-Gm-Features: Ac12FXzErkyILNyXohcB1bGYZZAn1EZu94j1IPLA5QmKLqv59FFK3Tt4ZQghsWk
Message-ID: <CAM0EoMkhASg-NVegj77+Gj+snmWog69ebHYEj3Rcj41hiUBf_A@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] net/sched: Restrict conditions for adding
 duplicating netems to qdisc tree
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: William Liu <will@willsroot.io>, netdev@vger.kernel.org, victor@mojatatu.com, 
	pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, 
	stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 6:39=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> On Mon, Jun 30, 2025 at 07:32:48AM -0400, Jamal Hadi Salim wrote:
> > On Sun, Jun 29, 2025 at 4:16=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail=
.com> wrote:
> > >
> > > On Sat, Jun 28, 2025 at 05:25:25PM -0400, Jamal Hadi Salim wrote:
> > > > your approach was to overwrite the netem specific cb which is expos=
ed
> > > > via the cb ->data that can be overwritten for example by a trivial
> > > > ebpf program attach to any level of the hierarchy. This specific
> > > > variant from Cong is not accessible to ebpf but as i expressed my v=
iew
> > > > in other email i feel it is not a good solution.
> > > >
> > > > https://lore.kernel.org/netdev/CAM0EoMk4dxOFoN_=3D3yOy+XrtU=3DyvjJX=
Aw3fVTmN9=3DM=3DR=3DvtbxA@mail.gmail.com/
> > >
> > > Hi Jamal,
> > >
> > > I have two concerns regarding your/Will's proposal:
> > >
> > > 1) I am not sure whether disallowing such case is safe. From my
> > > understanding this case is not obviously or logically wrong. So if we
> > > disallow it, we may have a chance to break some application.
> > >
> >
> > I dont intentionaly creating a loop-inside-a-loop as being correct.
> > Stephen, is this a legit use case?
> > Agreed that we need to be careful about some corner cases which may
> > look crazy but are legit.
>
> Maybe I misunderstand your patch, to me duplicating packets in
> parallel sub-hierarchy is not wrong, may be even useful.
>

TBH, there's no real world value for that specific config/repro and
worse that it causes the infinite loop.
I also cant see a good reason to have multiple netem children that all
loop back to root.
If there is one, we are going to find out when the patch goes in and
someone complains.

> >
> > > 2) Singling out this case looks not elegant to me.
> >
> > My thinking is to long term disallow all nonsense hierarchy use cases,
> > such as this one, with some
> > "feature bits". ATM, it's easy to catch the bad configs within a
> > single qdisc in ->init() but currently not possible if it affects a
> > hierarchy.
>
> The problem with this is it becomes harder to get a clear big picture,
> today netem, tomorrow maybe hfsc etc.? We could end up with hiding such
> bad-config-prevention code in different Qdisc's.
>
> With the approach I suggested, we have a central place (probably
> sch_api.c) to have all the logics, nothing is hidden, easier to
> understand and easier to introduce more bad-config-prevention code.
>
> I hope this makes sense to you.
>

To me the most positive outcome from the bounty hunters is getting
clarity that we not only need a per-qdisc validation as we do today,
but per-hierarchy as well; however, that is a different discussion we
can have after.

IIUC, we may be saying the same thing - a generic way to do hierarchy
validation. I even had a patch which i didnt think was the right thing
to do at the time. We can have that discussion.

But let's _please_ move forward with this patch, it fixes the
outstanding issues then we can discuss the best path forward more
calmly. The issue this patch fixes can be retrofitted into whatever
new scheme that we agree on after (and we may have to undo all the
backlog fixes as well).

cheers,
jamal

