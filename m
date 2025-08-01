Return-Path: <netdev+bounces-211412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1827AB18919
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 00:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754801C84621
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 22:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9094221FF44;
	Fri,  1 Aug 2025 22:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="aXuckxk5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0872E630
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 22:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754085857; cv=none; b=Juk5hc8gw5zSnCtLhQpGrCIunhMsRvqxLkc/QJeooO2ITc9E8YzQg1sHKKKkAUqPUQeLE5eF8G4c8fdUfgN4NF1y/zMCXTYuFYL5kYymZR7nvZ8TKIO4daTXeOnXsjFdDIYOylCtKFP6KMmKg6d6iEx+hRYnrYK2uqsjHbcNLP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754085857; c=relaxed/simple;
	bh=CXSh+LSZ8yEwZUGflJ8lGxElXHw3C7RwMmP1lvGv7ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GzqQzuhJPQeqLd2quJRKN01DUlORmWPsxP5BKlx7N+0hadOZy26822chgEV57Hia65yOHRuZqxulOuTZi4LBVtWd8srRHh5eAEk8howt8qxwrkUyUcAXaoTNEK32TzpI4X3IpdQWoy3eNPSjlEM2VvQ5kTKMZJzV8l16pubKpRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=aXuckxk5; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e8fe929b147so769618276.2
        for <netdev@vger.kernel.org>; Fri, 01 Aug 2025 15:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754085854; x=1754690654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUarmgBpnA0Prg3TA5AbKw7WqzcXnKN215MTUbjzR2s=;
        b=aXuckxk5HY7lexbMAbgj1zS8879oT1IA27ZIkmaO0+HSUeb+Oz9Iucq6ZlU1lo8XOj
         LTJvK50AwG604o0in9jP0cz0y63wOWFNNqx0mRBI3R99b5wKMrpbqRX/+1qxOqe/VuTW
         iCEH7gKMFAAoOhiogPc64w1TClD861OptZgqzzcodvnv/fw5tbidSl9XY2gc6anzLYBb
         SkOzEGhgFStwsyqp3XpQaHw/DXzDu6JybD25Tl44P7LIuv1jg4YhSvlrRaGYzrpYwbta
         5VWZSn0Ybf98KXGEEi1vT0WgWHcHf8cJZi27mPRvmplVy9HNzHPGdt41sX63JjaI3lUe
         Hk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754085854; x=1754690654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUarmgBpnA0Prg3TA5AbKw7WqzcXnKN215MTUbjzR2s=;
        b=mwD3tSYsPaHB93x+eiOHL0mEh+42Q/9MkmezkpHauRqrhT3TsYtPrXeN2bOH44i8aR
         2LH1m9wDv/CFgOrgjRkCBnp5lL+/ODmxio9K6hDnUjYxbuqtoziEdFgJ2m/VnuGyHJpx
         QTEzpu1BP7skTTyd8OKL/BI509DpPqmk5vhaJxCZ9Jn8zqBWX48LBJFWu5JbeFM58Agb
         GDa9WcFyCNZEjxHSd2ysBgp4keUgBplR9wTIFWmDBWZ+SqlNtd6Dj7CG+wBU4bqcHK0b
         LQ3r/1os5Ckk9gecJEONvUDVvmtiz1lRTUmj76sPxscn61LSCxtis/ZcdadTMuKbbATD
         bd7w==
X-Forwarded-Encrypted: i=1; AJvYcCVtnp183LHzKFktTnwg+xKF+PwtffPBXRW4PRqkbqFqEZp8/R21QxJKFYmMEaPl64Qm8Mn6rhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyreZEqf+PrgtMrgFVIrP6uHwxoSs/ZAb9MQyn5Oj5hgZba6znI
	sS/C2YiUvVB3PClVlO0YSaMi3MqT7CzjKnwdiq+75Dth/NDky02ZDtLvw18LkWvxIAI=
X-Gm-Gg: ASbGncucJOu86Ekt+krEFQoRC1SscbAgLDubHz+YxO6vChTPDhYP3bcAcpFEY+3ndDU
	jbMDuQuobuohJQVWwKQsnohH0Plh7ngTlEDbwhqxgkgvwgrpjad8vB/JTALa4B6ML9i1GXjvpzP
	eZCPP4zyl/5l/lUQIsxxTjQS1BEiN1LafBqu71F0utj7FoqxHfSdHuTxSqtCPl7LQLMM4o3PHki
	sS0ZXpBRRjW7ea0MKhrEW3S9FVXSXzvPA4kAvOukFEgLyIpnNBrPGgXJHYD3gwgkCZnmsjrohPr
	vgT3l+vD7UIL+oGrbw6um6sTn3PtUezDergIrDVGBtFBrlbQbusjkbUBnDnLXs23pXRqv7JqoyI
	TkN1HI6GDUoeNtXU6EA7HOEj7SCKH3Lf/E4dblA4WsGxZ8vsM4QATV95hFUl2Ebn9939JHzq/I0
	Q=
X-Google-Smtp-Source: AGHT+IEo5d5uY+q/Pbr3f/3Hl7RuotEonjlOZV7mfqu12Q2yRVSPFnI3c+1+2ma5D24zm2iaBgKLhg==
X-Received: by 2002:a05:6902:2884:b0:e87:9fda:35c with SMTP id 3f1490d57ef6-e8fee0616d5mr1812040276.26.1754085854526;
        Fri, 01 Aug 2025 15:04:14 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd3860b42sm1825897276.25.2025.08.01.15.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 15:04:14 -0700 (PDT)
Date: Fri, 1 Aug 2025 15:04:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org,
 will@willsroot.io
Subject: Re: [Patch v4 net 0/6] netem: Fix skb duplication logic and prevent
 infinite loops
Message-ID: <20250801150410.396a565e@hermes.local>
In-Reply-To: <aIpvuNyyvud0sJOl@pop-os.localdomain>
References: <20250719220341.1615951-1-xiyou.wangcong@gmail.com>
	<CAM0EoMmTZon=nFmLsDPKhDEzHruw701iV9=mq92At9oKo0LGpA@mail.gmail.com>
	<aIpvuNyyvud0sJOl@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Jul 2025 12:17:12 -0700
Cong Wang <xiyou.wangcong@gmail.com> wrote:

> On Mon, Jul 21, 2025 at 10:00:30AM -0400, Jamal Hadi Salim wrote:
> > On Sat, Jul 19, 2025 at 6:04=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail=
.com> wrote: =20
> > >
> > > This patchset fixes the infinite loops due to duplication in netem, t=
he
> > > real root cause of this problem is enqueuing to the root qdisc, which=
 is
> > > now changed to enqueuing to the same qdisc. This is more reasonable,
> > > more predictable from users' perspective, less error-proone and more =
elegant.
> > >
> > > Please see more details in patch 1/6 which contains two pages of deta=
iled
> > > explanation including why it is safe and better.
> > >
> > > This replaces the patches from William, with much less code and witho=
ut
> > > any workaround. More importantly, this does not break any use case.
> > > =20
> >=20
> > Cong, you are changing user expected behavior.
> > So instead of sending to the root qdisc, you are looping on the same
> > qdisc. I dont recall what the history is for the decision to go back
> > to the root qdisc - but one reason that sounds sensible is we want to
> > iterate through the tree hierarchy again. Stephen may remember.
> > The fact that the qfq issue is hit indicates the change has
> > consequences - and given the check a few lines above, more than likely
> > you are affecting the qlen by what you did. =20
>=20
> Please refer the changelog of patch 1/6, let me quote it here for you:
>=20
>     The new netem duplication behavior does not break the documented
>     semantics of "creates a copy of the packet before queuing." The man p=
age
>     description remains true since duplication occurs before the queuing
>     process, creating both original and duplicate packets that are then
>     enqueued. The documentation does not specify which qdisc should recei=
ve
>     the duplicates, only that copying happens before queuing. The impleme=
ntation
>     choice to enqueue duplicates to the same qdisc (rather than root) is =
an
>     internal detail that maintains the documented behavior while preventi=
ng
>     infinite loops in hierarchical configurations.
>=20
> I think it is reasonable to use man page as our agreement with users. I
> am open to other alternative agreements, if you have one. I hope using
> man page is not of my own preference here.
>=20
> Thanks.

There is a chance that cases that mix duplication, corruption and drop
parameters would see different results after this patch.

