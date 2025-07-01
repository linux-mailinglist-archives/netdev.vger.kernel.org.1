Return-Path: <netdev+bounces-203029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77B3AF035F
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 21:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC994A83A6
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 19:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C127927EFFE;
	Tue,  1 Jul 2025 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="KWznauBR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBD91CBEAA
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751396950; cv=none; b=EjUtkxmKzdAjxr2GW3WpJH5CN/fl0ncwMBosWsAocCGtJWWoogrP/9ZBm9LUQsDyruhVzH6MmOvPXj5yFg+rz/v6MU9texMF2CdeAgBvNQsJ1rreSQQj/totaI61tCwNNdx5QNsv9T9Hltrj6wLnG/wT3O9e9Fcm+9TA90u9fpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751396950; c=relaxed/simple;
	bh=L5juT7CHvvpL1xuFHtt58yOKF71EN9zKuIRzN/GE/ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SM96tecSELfQ2/N9luUSKtj3xmCSUWT9v6QbIj2PJaxQwFTkgaWcAjYQZk9mCORIF8R2GMZtn1rZBiW6tKiH7LZyWRD2Rwn3lOq+VWQZP8wWbpfZv0BX+U5vYZL6z7XBUGaWw2UXGdPkldnGTy57xTD23xxSCXkzxIjCsvmNgfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=KWznauBR; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso3370991b3a.2
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 12:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751396948; x=1752001748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5juT7CHvvpL1xuFHtt58yOKF71EN9zKuIRzN/GE/ds=;
        b=KWznauBRBoTPSEZs7CRiuA//A+8uAMiu90OV4q3TV6TtEUQn07DnNL+yV8Dl2I13R6
         ybgsrX5Zp9FKRF+jZZvnSMwva0WE2qVpHYPpcPTcCtBnmZzvrcAiL0OCOo6rK8xWMXfL
         4bjJKPogUyeFZdAVHjU5SjX4dbFGDkBDseQbfE9N3D4c2d/A0F0b5qCYWUJWEGLR1NG2
         Cua/LaH/jwX223mT+GraJ++Stt/40vhDJkMbT70jnKh+XJXtjlm3O7qBy5hDG2Ofd52i
         5cMN8qxoK+WPOtMnOv1ZyT7mDgKgsMlS1H89GZuobn4ewj4GrWJMRAi89qxGj9WpcQQO
         VKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751396948; x=1752001748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5juT7CHvvpL1xuFHtt58yOKF71EN9zKuIRzN/GE/ds=;
        b=dntw27StXUZqng14ewP/OWoywESXuNlRc8paNuH8ZNxjtwR3Kr+3adde/48Awx3IaK
         Xup8JOMiG4A6W5TBwu+N8rOZy6/boqOsZ7F5PMOQnFZB/N9ObbBc6IXf+YbyqDVnBC++
         BhXrqOY4e9rQlXbmAsRHLS6qNwF9i6auaetBvuTgz0hG1yeHExiE80kScCR+qu1JQxIv
         x16CJM6wQzXA9RUx7SqYOmTHH93kOUf6+jVNvURzlhV0LG0necmW2/CaYCF9SV6NEfsR
         ssrA1qT0T4ABJMxkFeNgmpNVlb6beI0iUeoWmrcgqhbMKk+EezgWlpZ7rcO+La4ehukm
         1Gbg==
X-Forwarded-Encrypted: i=1; AJvYcCVAA+WVn0bTQZjYRgIwIf5fAv5XXVk10BbUOGpbfU1OUKXBJENAMZBVu3g4ujKuYgDHR2Yqafs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE+j5oCWolqdlwSeRnVI6MR2g5k0qVzm9Y3a2ZyrcSCsKUvnWj
	rhGmqlpA3GaFoA4Z1XORWibkle8oh7geBlM7WDb+MpreKIC3hqQy6vJG6lmg5mQqUpJFPmE4+PY
	sZcuuFWzHWNJPTaXEoH9Rx1uC3GYrF4FVc98zchAt
X-Gm-Gg: ASbGncuws1DbH/M+T2TpKPaHMUEJ3kpidAvLSikOrteuE5rwvebRmsieFEu8J1zN38i
	bvzkR2WjeGJp/wic4BixSbNc9Y5oUT58i21kFV8gXaBqz742L2PLnfS4bhrlqotS3z/xwg2udP/
	3/hJlcSL4vUs4vcegq3pHpyvjDaMbdq5kliDGXPsomKg==
X-Google-Smtp-Source: AGHT+IHrByLCT5sAoxzmK6Ob3CkgMdNTxmcFf2jlrx47m6FTjzXZ/LmC8hkIwFCB3He4yPkXY6wLLPhK1KxlWoZDUng=
X-Received: by 2002:a05:6a00:c90:b0:740:6f69:f52a with SMTP id
 d2e1a72fcca58-74b50b8115fmr56778b3a.0.1751396948040; Tue, 01 Jul 2025
 12:09:08 -0700 (PDT)
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
 <aGMSPCjbWsxmlFuO@pop-os.localdomain> <CAM0EoMkhASg-NVegj77+Gj+snmWog69ebHYEj3Rcj41hiUBf_A@mail.gmail.com>
 <aGQbg6Qi/K4nWG+t@pop-os.localdomain>
In-Reply-To: <aGQbg6Qi/K4nWG+t@pop-os.localdomain>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 1 Jul 2025 15:08:56 -0400
X-Gm-Features: Ac12FXy-xNWbwu2dUeFVmFmDNPZHTapf7KwkUgYIMD1HANekZJRapiPXA8DTyKM
Message-ID: <CAM0EoMmvxHV5Dm3fLnk1Quw4zXuKuKjHOp2vSKxf4BM4Y0i_ug@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] net/sched: Restrict conditions for adding
 duplicating netems to qdisc tree
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: William Liu <will@willsroot.io>, netdev@vger.kernel.org, victor@mojatatu.com, 
	pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, 
	stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 1:31=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com>=
 wrote:
>
> On Tue, Jul 01, 2025 at 10:15:10AM -0400, Jamal Hadi Salim wrote:
> > On Mon, Jun 30, 2025 at 6:39=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail=
.com> wrote:
> > >
> > > On Mon, Jun 30, 2025 at 07:32:48AM -0400, Jamal Hadi Salim wrote:
> > > > On Sun, Jun 29, 2025 at 4:16=E2=80=AFPM Cong Wang <xiyou.wangcong@g=
mail.com> wrote:
> > > > >
> > > > > On Sat, Jun 28, 2025 at 05:25:25PM -0400, Jamal Hadi Salim wrote:
> > > > > > your approach was to overwrite the netem specific cb which is e=
xposed
> > > > > > via the cb ->data that can be overwritten for example by a triv=
ial
> > > > > > ebpf program attach to any level of the hierarchy. This specifi=
c
> > > > > > variant from Cong is not accessible to ebpf but as i expressed =
my view
> > > > > > in other email i feel it is not a good solution.
> > > > > >
> > > > > > https://lore.kernel.org/netdev/CAM0EoMk4dxOFoN_=3D3yOy+XrtU=3Dy=
vjJXAw3fVTmN9=3DM=3DR=3DvtbxA@mail.gmail.com/
> > > > >
> > > > > Hi Jamal,
> > > > >
> > > > > I have two concerns regarding your/Will's proposal:
> > > > >
> > > > > 1) I am not sure whether disallowing such case is safe. From my
> > > > > understanding this case is not obviously or logically wrong. So i=
f we
> > > > > disallow it, we may have a chance to break some application.
> > > > >
> > > >
> > > > I dont intentionaly creating a loop-inside-a-loop as being correct.
> > > > Stephen, is this a legit use case?
> > > > Agreed that we need to be careful about some corner cases which may
> > > > look crazy but are legit.
> > >
> > > Maybe I misunderstand your patch, to me duplicating packets in
> > > parallel sub-hierarchy is not wrong, may be even useful.
> > >
> >
> > TBH, there's no real world value for that specific config/repro and
> > worse that it causes the infinite loop.
> > I also cant see a good reason to have multiple netem children that all
> > loop back to root.
> > If there is one, we are going to find out when the patch goes in and
> > someone complains.
>
> I tend to be conservative here since breaking potential users is not a
> good practice. It takes a long time for regular users to realize this
> get removed since many of them use long term stable releases rather than
> the latest release.
>
> Also, the patch using qdisc_skb_cb() looks smaller than this one,
> which means it is easier to review.
>

I think we are at a stalemate.

> >
> > > >
> > > > > 2) Singling out this case looks not elegant to me.
> > > >
> > > > My thinking is to long term disallow all nonsense hierarchy use cas=
es,
> > > > such as this one, with some
> > > > "feature bits". ATM, it's easy to catch the bad configs within a
> > > > single qdisc in ->init() but currently not possible if it affects a
> > > > hierarchy.
> > >
> > > The problem with this is it becomes harder to get a clear big picture=
,
> > > today netem, tomorrow maybe hfsc etc.? We could end up with hiding su=
ch
> > > bad-config-prevention code in different Qdisc's.
> > >
> > > With the approach I suggested, we have a central place (probably
> > > sch_api.c) to have all the logics, nothing is hidden, easier to
> > > understand and easier to introduce more bad-config-prevention code.
> > >
> > > I hope this makes sense to you.
> > >
> >
> > To me the most positive outcome from the bounty hunters is getting
> > clarity that we not only need a per-qdisc validation as we do today,
> > but per-hierarchy as well; however, that is a different discussion we
> > can have after.
> >
> > IIUC, we may be saying the same thing - a generic way to do hierarchy
> > validation. I even had a patch which i didnt think was the right thing
> > to do at the time. We can have that discussion.
>
> Why not? It is not even necessarily more complex to have a generic
> solution. With AI copilot, it is pretty quick. :)
>
> FYI: I wrote the GSO segmentation patches with AI, they work well to fix
> the UAF report by Mingi. I can post them at any time, just waiting for
> Mingi's response to decide whether they are for -net or -net-next. I
> hope this more complicated case could convince you to use AI to write
> kernel code, if you still haven't.
>
> >
> > But let's _please_ move forward with this patch, it fixes the
> > outstanding issues then we can discuss the best path forward more
> > calmly. The issue this patch fixes can be retrofitted into whatever
> > new scheme that we agree on after (and we may have to undo all the
> > backlog fixes as well).
>
> Sure, I will send out a patch to use qdisc_skb_cb() to help everyone out
> of this situation.
>


I really dont see the point. Let's get Williams patch in please.

cheers,
jamal

> Thanks!

