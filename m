Return-Path: <netdev+bounces-203017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C82BCAF0206
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 19:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96FDE441B25
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 17:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0F425E822;
	Tue,  1 Jul 2025 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="Bbddy+lC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10624.protonmail.ch (mail-10624.protonmail.ch [79.135.106.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF804A0F
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751391462; cv=none; b=aenZjAoPQsxEtPABW/y9McREnb/PVrdnnUbxJutK6fGLR4hz+Y+PYAUh6v9V7wC9W/kKLJiKiJXFFa2/RURKq+gMH2uJ8Xr6ycG4EwrbGIVclk7htS8XUqk9cXWKt/R5xVdG9TfZkezftdtIUuQ2NM5UlLl1RGqK3WV14v9/SpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751391462; c=relaxed/simple;
	bh=Izn1/OiGplcFFPJfFIlfQ95TJ4iEFAhWX9ReGOj2nYQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rfj1B1akoQXJ/5j14EuyCwlk+toV5GwELIVD0bC5uVOmsUKOQEPn6y0B9BvpoRYL466dfdsMi6G7nAvsdJlYrBchyTkwsEof7EBn3El6VcWOo5Yd+ra/XoGuBWJMLwGGw29dv96Dd66KpXGyboZvt3nBJHmWQ21UQjwk5fJd3L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=Bbddy+lC; arc=none smtp.client-ip=79.135.106.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1751391453; x=1751650653;
	bh=Izn1/OiGplcFFPJfFIlfQ95TJ4iEFAhWX9ReGOj2nYQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Bbddy+lC4P4I0gRHOGFqAwpW/MLLR+lE9SEU6Sita6S7fAOvu2ihnRnqe7GSlmw3U
	 paKs52NzUuyJjvcim2Gx0DrOkNxi+7CBrjWowqvfB9TYqUR0SnAkXjSfUKUpcFf3a6
	 SMyaBkLd4GHJEDqw8y+n8dxj54m0FqgkQQ/o6G5D4kRtulujsQbLpJPM6xuvkkYoJW
	 1Pu1jppRfl58St+DTf1vMGzJGAnzJbyZn7OyYn+mUBz3ERgURIIUk+Sz/hAgkA1djF
	 0JwIzWNr3qQtK+yApJnub98lEkNPJJOykuHEFBoLY/n05W/bX3zq/LWj2+UlNNvpTL
	 QZrg+ALBD/P1Q==
Date: Tue, 01 Jul 2025 17:37:25 +0000
To: Cong Wang <xiyou.wangcong@gmail.com>
From: William Liu <will@willsroot.io>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org, victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org
Subject: Re: [PATCH net v4 1/2] net/sched: Restrict conditions for adding duplicating netems to qdisc tree
Message-ID: <gM-JGSLu4nHZhYs2dX6HRSjzJ_lTno28spo53-24pSDBk-sc3ygkQDrJEwxabhqB5PLf1IUJ1M64pEuj2t51mXDCUeqfzPhhHeu78P5oYrk=@willsroot.io>
In-Reply-To: <aGQbg6Qi/K4nWG+t@pop-os.localdomain>
References: <20250627061600.56522-1-will@willsroot.io> <aF80DNslZSX7XT3l@pop-os.localdomain> <sf650XmBNi0tyPjDgs_wVtj-7oFNDmX8diA3IzKTuTaZcLYNc5YZPLnAHd5eI2BDtxugv74Bv67017EAuIvfNbfB6y7Pr7IUZ2w1j6JEMrM=@willsroot.io> <CAM0EoMkUi470+z86ztEMAGfYcG8aYiC2e5pP0z1BHz82O4RCPg@mail.gmail.com> <aGGfLB+vlSELiEu3@pop-os.localdomain> <CAM0EoMnjS0kaNDttQtCZ+=hq9egOiRDANN+oQcMOBRnXLVjgRw@mail.gmail.com> <aGMSPCjbWsxmlFuO@pop-os.localdomain> <CAM0EoMkhASg-NVegj77+Gj+snmWog69ebHYEj3Rcj41hiUBf_A@mail.gmail.com> <aGQbg6Qi/K4nWG+t@pop-os.localdomain>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 753acf9b6ad37b1bea1bbb9bb9fb08e37f3ae52d
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable






On Tuesday, July 1st, 2025 at 5:31 PM, Cong Wang <xiyou.wangcong@gmail.com>=
 wrote:

>=20
>=20
> On Tue, Jul 01, 2025 at 10:15:10AM -0400, Jamal Hadi Salim wrote:
>=20
> > On Mon, Jun 30, 2025 at 6:39=E2=80=AFPM Cong Wang xiyou.wangcong@gmail.=
com wrote:
> >=20
> > > On Mon, Jun 30, 2025 at 07:32:48AM -0400, Jamal Hadi Salim wrote:
> > >=20
> > > > On Sun, Jun 29, 2025 at 4:16=E2=80=AFPM Cong Wang xiyou.wangcong@gm=
ail.com wrote:
> > > >=20
> > > > > On Sat, Jun 28, 2025 at 05:25:25PM -0400, Jamal Hadi Salim wrote:
> > > > >=20
> > > > > > your approach was to overwrite the netem specific cb which is e=
xposed
> > > > > > via the cb ->data that can be overwritten for example by a triv=
ial
> > > > > > ebpf program attach to any level of the hierarchy. This specifi=
c
> > > > > > variant from Cong is not accessible to ebpf but as i expressed =
my view
> > > > > > in other email i feel it is not a good solution.
> > > > > >=20
> > > > > > https://lore.kernel.org/netdev/CAM0EoMk4dxOFoN_=3D3yOy+XrtU=3Dy=
vjJXAw3fVTmN9=3DM=3DR=3DvtbxA@mail.gmail.com/
> > > > >=20
> > > > > Hi Jamal,
> > > > >=20
> > > > > I have two concerns regarding your/Will's proposal:
> > > > >=20
> > > > > 1) I am not sure whether disallowing such case is safe. From my
> > > > > understanding this case is not obviously or logically wrong. So i=
f we
> > > > > disallow it, we may have a chance to break some application.
> > > >=20
> > > > I dont intentionaly creating a loop-inside-a-loop as being correct.
> > > > Stephen, is this a legit use case?
> > > > Agreed that we need to be careful about some corner cases which may
> > > > look crazy but are legit.
> > >=20
> > > Maybe I misunderstand your patch, to me duplicating packets in
> > > parallel sub-hierarchy is not wrong, may be even useful.
> >=20
> > TBH, there's no real world value for that specific config/repro and
> > worse that it causes the infinite loop.
> > I also cant see a good reason to have multiple netem children that all
> > loop back to root.
> > If there is one, we are going to find out when the patch goes in and
> > someone complains.
>=20
>=20
> I tend to be conservative here since breaking potential users is not a
> good practice. It takes a long time for regular users to realize this
> get removed since many of them use long term stable releases rather than
> the latest release.
>=20
> Also, the patch using qdisc_skb_cb() looks smaller than this one,
> which means it is easier to review.
>=20
> > > > > 2) Singling out this case looks not elegant to me.
> > > >=20
> > > > My thinking is to long term disallow all nonsense hierarchy use cas=
es,
> > > > such as this one, with some
> > > > "feature bits". ATM, it's easy to catch the bad configs within a
> > > > single qdisc in ->init() but currently not possible if it affects a
> > > > hierarchy.
> > >=20
> > > The problem with this is it becomes harder to get a clear big picture=
,
> > > today netem, tomorrow maybe hfsc etc.? We could end up with hiding su=
ch
> > > bad-config-prevention code in different Qdisc's.
> > >=20
> > > With the approach I suggested, we have a central place (probably
> > > sch_api.c) to have all the logics, nothing is hidden, easier to
> > > understand and easier to introduce more bad-config-prevention code.
> > >=20
> > > I hope this makes sense to you.
> >=20
> > To me the most positive outcome from the bounty hunters is getting
> > clarity that we not only need a per-qdisc validation as we do today,
> > but per-hierarchy as well; however, that is a different discussion we
> > can have after.
> >=20
> > IIUC, we may be saying the same thing - a generic way to do hierarchy
> > validation. I even had a patch which i didnt think was the right thing
> > to do at the time. We can have that discussion.
>=20
>=20
> Why not? It is not even necessarily more complex to have a generic
> solution. With AI copilot, it is pretty quick. :)
>=20
> FYI: I wrote the GSO segmentation patches with AI, they work well to fix
> the UAF report by Mingi. I can post them at any time, just waiting for
> Mingi's response to decide whether they are for -net or -net-next. I
> hope this more complicated case could convince you to use AI to write
> kernel code, if you still haven't.
>=20
> > But let's please move forward with this patch, it fixes the
> > outstanding issues then we can discuss the best path forward more
> > calmly. The issue this patch fixes can be retrofitted into whatever
> > new scheme that we agree on after (and we may have to undo all the
> > backlog fixes as well).
>=20
>=20
> Sure, I will send out a patch to use qdisc_skb_cb() to help everyone out
> of this situation.
>=20

I can send a patch with that variant for you all to compare sometime in the=
 next 24 hrs - I have been working on fixing this back and forth with Jamal=
 for the past month.

Best,
Will

