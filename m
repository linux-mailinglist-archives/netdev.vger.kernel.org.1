Return-Path: <netdev+bounces-202242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FB0AECDF8
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 16:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66281896C6E
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 14:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA63622ACE3;
	Sun, 29 Jun 2025 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ulUaiIsB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8E7226D1F
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751207397; cv=none; b=KGNz+XdTjBAea3ijFGxjVoPec26aNiiy70ttaTgWU7+ahgeTuv5rMJK+llng4W65LHZeH5u8OQGngBAoY+Ke5BTsnw7PrXK1yLgoPvfbpYQ+DYhXRRgbBdYmnd25uiEIY7Up8FuZiiiCpozRGiMCsp5dsTOTUjUQvZl9e2RukHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751207397; c=relaxed/simple;
	bh=IKTDszvhYfUkuFWv7u7q5TgQfPXQD5hrMfklZ+abBKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3idET2kyz7ToykwH1AyB6GjrweNymu6mXfuIFAWrcHAl/7wDWqVvik48CttBlWzpHrpuys+SI69n1/Y52+uaMpQJkH4ARK6wilIrpuxcYryh1Kd84gdGkRVBWhGZmRz7nCFFdufzecfgMFGOYNQ9KEXWBFUVL93MIYLCo+m3ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ulUaiIsB; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b34a8f69862so1237559a12.2
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 07:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751207395; x=1751812195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uQx8pHp2Ruj6csJFEm0lG55UaPGAo3wBQSrKNhHOpg=;
        b=ulUaiIsBsggoOck8smctg4dcMtl3daRzg8TAQYv4xb0xuBjQYxP4qTtwfgVETlSjiB
         IMvDfKp+Vxtl4TX4+uxAzRQ0+n/KcLxKun6bpXTfrVVfSvHGv2su8SnkmgeMW38lo2qO
         mw1MyoXA8OnnmbEMEiy81Q4YDY0cHKqgnLzzq0PvXG6f48eZ1tvYBA1tH9E5sPcnlVCx
         w1nAmQweTxFFVdl9fHai7gNv6LYG5dTSDOBeNfgoYWRND/LegwX/Ls3lkKfLBCW/FDwB
         3fZw0Aq7JVLyajJYs6Si6EbKRHgHfr5qUJ3jp18misrZcYrsfyAYOQk6Y6b9j4uzg68Z
         HRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751207395; x=1751812195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uQx8pHp2Ruj6csJFEm0lG55UaPGAo3wBQSrKNhHOpg=;
        b=BL3j0XVDGTf/WFV01kz9ivf9RaMloPdWQfhq9Qic4GwwC5t41WNIsDQevTQwfDEvYk
         4uPUgq5dinrDuo88l5EESOJt1XHPmD9CRk222azZlDgCtb4ilTlpQiOitE4jxjBkHVSw
         1kpp2KbE0CThKWoRVUYFVKHMMWKt37lMvfYI7cyLKsVEv6yxjp4JMUunaeZG0JPZ6Te2
         GUcs7rHBJSwUNuRRGo+OsceW67zkdbDZ4D0w4D7i8VfaE3GA22Ldcwg9aVpbP3axUjoM
         agPIvWt57rWLT2mwBH17S3XbMmsnvBvDaeVikjVzU50cdXRTMVjYhklvK5JqbYbZuFRz
         4XMA==
X-Forwarded-Encrypted: i=1; AJvYcCXHDSxEywl0j2gOrNYoKShC+hUY+fzMPizjqAq5TZ5txr6P5nPsAoxLpBK+RiTqNZJGKNH+YXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBAftT4QCOrN2HVMtjAgvfivHR4BCfMzAfoG/+w5Nz+liD9hZN
	3kB3GAlBJSBXvXN4xPb+889bUH2Q0TrCze53DGnS2DVV+LigRbLtzyLosTlbHXjCVnuoTyJ6YGt
	lKveGar+VzTUoP09JhsiOg6p9PLsrXC3JurKAT2wz
X-Gm-Gg: ASbGncszn9dY9MwauadisfMwwmHcAZnlJ5gPN3FMthYBKvCEc8zP4EtA+s8o3k8/lDv
	0PhNzx9ZUwiclf1WB+9La24juBxIbqyUHqNEPteHsqoLVnbaPq3EkZFySyPblPi3/mB4EzS+46w
	2gGKxUDUhwYx2saWFDyWIzt9kN6L3/AqVzospsTEt0Eg==
X-Google-Smtp-Source: AGHT+IHSD9+jqjpJH51HSYxyXREnIJ+AeRFuJzas6D5NbfViJw3ekacEVCCrDTvxd0HO3HbFlPIoaMDm3mAoCFvNfE4=
X-Received: by 2002:a05:6300:4d4:10b0:220:a24b:8701 with SMTP id
 adf61e73a8af0-220a24b875emr9525373637.41.1751207395205; Sun, 29 Jun 2025
 07:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com>
 <aFosjBOUlOr0TKsd@pop-os.localdomain> <3af4930b-6773-4159-8a7a-e4f6f6ae8109@gmail.com>
 <5e4490da-3f6c-4331-af9c-0e6d32b6fc75@gmail.com> <CAM0EoMm+xgb0vkTDMAWy9xCvTF+XjGQ1xO5A2REajmBN1DKu1Q@mail.gmail.com>
 <d23fe619-240a-4790-9edd-bec7ab22a974@gmail.com> <CAM0EoM=rU91P=9QhffXShvk-gnUwbRHQrwpFKUr9FZFXbbW1gQ@mail.gmail.com>
In-Reply-To: <CAM0EoM=rU91P=9QhffXShvk-gnUwbRHQrwpFKUr9FZFXbbW1gQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 29 Jun 2025 10:29:44 -0400
X-Gm-Features: Ac12FXxULpG03pytpGRmG8FUK6F8mB11oS38vr3ptzo3A81lid4i3Bc-dM3sb8s
Message-ID: <CAM0EoM=mey1f596GS_9-VkLyTmMqM0oJ7TuGZ6i73++tEVFAKg@mail.gmail.com>
Subject: Re: Incomplete fix for recent bug in tc / hfsc
To: Lion Ackermann <nnamrec@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, Mingi Cho <mincho@theori.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 5:43=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Thu, Jun 26, 2025 at 4:08=E2=80=AFAM Lion Ackermann <nnamrec@gmail.com=
> wrote:
> >
> > Hi,
> >
> > On 6/25/25 4:22 PM, Jamal Hadi Salim wrote:
> > > On Tue, Jun 24, 2025 at 6:43=E2=80=AFAM Lion Ackermann <nnamrec@gmail=
.com> wrote:
> > >>
> > >> Hi,
> > >>
> > >> On 6/24/25 11:24 AM, Lion Ackermann wrote:
> > >>> Hi,
> > >>>
> > >>> On 6/24/25 6:41 AM, Cong Wang wrote:
> > >>>> On Mon, Jun 23, 2025 at 12:41:08PM +0200, Lion Ackermann wrote:
> > >>>>> Hello,
> > >>>>>
> > >>>>> I noticed the fix for a recent bug in sch_hfsc in the tc subsyste=
m is
> > >>>>> incomplete:
> > >>>>>     sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enq=
ueue()
> > >>>>>     https://lore.kernel.org/all/20250518222038.58538-2-xiyou.wang=
cong@gmail.com/
> > >>>>>
> > >>>>> This patch also included a test which landed:
> > >>>>>     selftests/tc-testing: Add an HFSC qlen accounting test
> > >>>>>
> > >>>>> Basically running the included test case on a sanitizer kernel or=
 with
> > >>>>> slub_debug=3DP will directly reveal the UAF:
> > >>>>
> > >>>> Interesting, I have SLUB debugging enabled in my kernel config too=
:
> > >>>>
> > >>>> CONFIG_SLUB_DEBUG=3Dy
> > >>>> CONFIG_SLUB_DEBUG_ON=3Dy
> > >>>> CONFIG_SLUB_RCU_DEBUG=3Dy
> > >>>>
> > >>>> But I didn't catch this bug.
> > >>>>
> > >>>
> > >>> Technically the class deletion step which triggered the sanitizer w=
as not
> > >>> present in your testcase. The testcase only left the stale pointer =
which was
> > >>> never accessed though.
> > >>>
> > >>>>> To be completely honest I do not quite understand the rationale b=
ehind the
> > >>>>> original patch. The problem is that the backlog corruption propag=
ates to
> > >>>>> the parent _before_ parent is even expecting any backlog updates.
> > >>>>> Looking at f.e. DRR: Child is only made active _after_ the enqueu=
e completes.
> > >>>>> Because HFSC is messing with the backlog before the enqueue compl=
eted,
> > >>>>> DRR will simply make the class active even though it should have =
already
> > >>>>> removed the class from the active list due to qdisc_tree_backlog_=
flush.
> > >>>>> This leaves the stale class in the active list and causes the UAF=
.
> > >>>>>
> > >>>>> Looking at other qdiscs the way DRR handles child enqueues seems =
to resemble
> > >>>>> the common case. HFSC calling dequeue in the enqueue handler viol=
ates
> > >>>>> expectations. In order to fix this either HFSC has to stop using =
dequeue or
> > >>>>> all classful qdiscs have to be updated to catch this corner case =
where
> > >>>>> child qlen was zero even though the enqueue succeeded. Alternativ=
ely HFSC
> > >>>>> could signal enqueue failure if it sees child dequeue dropping pa=
ckets to
> > >>>>> zero? I am not sure how this all plays out with the re-entrant ca=
se of
> > >>>>> netem though.
> > >>>>
> > >>>> I think this may be the same bug report from Mingi in the security
> > >>>> mailing list. I will take a deep look after I go back from Open So=
urce
> > >>>> Summit this week. (But you are still very welcome to work on it by
> > >>>> yourself, just let me know.)
> > >>>>
> > >>>> Thanks!
> > >>>
> > >>>> My suggestion is we go back to a proposal i made a few moons back =
(was
> > >>>> this in a discussion with you? i dont remember): create a mechanis=
m to
> > >>>> disallow certain hierarchies of qdiscs based on certain attributes=
,
> > >>>> example in this case disallow hfsc from being the ancestor of "qdi=
scs that may
> > >>>> drop during peek" (such as netem). Then we can just keep adding mo=
re
> > >>>> "disallowed configs" that will be rejected via netlink. Similar id=
ea
> > >>>> is being added to netem to disallow double duplication, see:
> > >>>> https://lore.kernel.org/netdev/20250622190344.446090-1-will@willsr=
oot.io/
> > >>>>
> > >>>> cheers,
> > >>>> jamal
> > >>>
> > >>> I vaguely remember Jamal's proposal from a while back, and I believ=
e there was
> > >>> some example code for this approach already?
> > >>> Since there is another report you have a better overview, so it is =
probably
> > >>> best you look at it first. In the meantime I can think about the so=
lution a
> > >>> bit more and possibly draft something if you wish.
> > >>>
> > >>> Thanks,
> > >>> Lion
> > >>
> > >> Actually I was intrigued, what do you think about addressing the roo=
t of the
> > >> use-after-free only and ignore the backlog corruption (kind of). Aft=
er the
> > >> recent patches where qlen_notify may get called multiple times, we c=
ould simply
> > >> loosen qdisc_tree_reduce_backlog to always notify when the qdisc is =
empty.
> > >> Since deletion of all qdiscs will run qdisc_reset / qdisc_purge_queu=
e at one
> > >> point or another, this should always catch left-overs. And we need n=
ot care
> > >> about all the complexities involved of keeping the backlog right and=
 / or
> > >> prevent certain hierarchies which seems rather tedious.
> > >> This requires some more testing, but I was imagining something like =
this:
> > >>
> > >> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> > >> --- a/net/sched/sch_api.c
> > >> +++ b/net/sched/sch_api.c
> > >> @@ -780,15 +780,12 @@ static u32 qdisc_alloc_handle(struct net_devic=
e *dev)
> > >>
> > >>  void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
> > >>  {
> > >> -       bool qdisc_is_offloaded =3D sch->flags & TCQ_F_OFFLOADED;
> > >>         const struct Qdisc_class_ops *cops;
> > >>         unsigned long cl;
> > >>         u32 parentid;
> > >>         bool notify;
> > >>         int drops;
> > >>
> > >> -       if (n =3D=3D 0 && len =3D=3D 0)
> > >> -               return;
> > >>         drops =3D max_t(int, n, 0);
> > >>         rcu_read_lock();
> > >>         while ((parentid =3D sch->parent)) {
> > >> @@ -797,17 +794,8 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sc=
h, int n, int len)
> > >>
> > >>                 if (sch->flags & TCQ_F_NOPARENT)
> > >>                         break;
> > >> -               /* Notify parent qdisc only if child qdisc becomes e=
mpty.
> > >> -                *
> > >> -                * If child was empty even before update then backlo=
g
> > >> -                * counter is screwed and we skip notification becau=
se
> > >> -                * parent class is already passive.
> > >> -                *
> > >> -                * If the original child was offloaded then it is al=
lowed
> > >> -                * to be seem as empty, so the parent is notified an=
yway.
> > >> -                */
> > >> -               notify =3D !sch->q.qlen && !WARN_ON_ONCE(!n &&
> > >> -                                                      !qdisc_is_off=
loaded);
> > >> +               /* Notify parent qdisc only if child qdisc becomes e=
mpty. */
> > >> +               notify =3D !sch->q.qlen;
> > >>                 /* TODO: perform the search on a per txq basis */
> > >>                 sch =3D qdisc_lookup(qdisc_dev(sch), TC_H_MAJ(parent=
id));
> > >>                 if (sch =3D=3D NULL) {
> > >> @@ -816,6 +804,9 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch=
, int n, int len)
> > >>                 }
> > >>                 cops =3D sch->ops->cl_ops;
> > >>                 if (notify && cops->qlen_notify) {
> > >> +                       /* Note that qlen_notify must be idempotent =
as it may get called
> > >> +                        * multiple times.
> > >> +                        */
> > >>                         cl =3D cops->find(sch, parentid);
> > >>                         cops->qlen_notify(sch, cl);
> > >>                 }
> > >>
> > >
> > > I believe this will fix the issue. My concern is we are not solving
> > > the root cause. I also posted a bunch of fixes on related issues for
> > > something Mingi Cho (on Cc) found - see attachments, i am not in favo=
r
> > > of these either.
> > > Most of these setups are nonsensical. After seeing so many of these m=
y
> > > view is we start disallowing such hierarchies.
> > >
> > > cheers,
> > > jamal
> >
> > I would also disagree with the attached patches for various reasons:
> > - The QFQ patch relies on packet size backlog, which is not to be
> >   trusted because of several sources that may make this unreliable
> >   (netem, size tables, GSO, etc.)
> > - In the TBF variant the ret may get overwritten during the loop,
> >   so it only relies on the final packet status. I would not trust
> >   this always working either.
> > - DRR fix seems fine, but it still requires all other qdiscs to
> >   be correct (and something similar needs to be applied to all
> >   classfull qdiscs?)
> > - The changes to qdisc_tree_reduce_backlog do not really make sense
> >   to me I must be missing something here..
> >
> > What do you think the root cause is here? AFAIK what all the issues
> > have in common is that eventually qlen_notify is _not_ called,
> > thus leaving stale class pointers. Naturally the consequence
> > could be to simply always call qlen_notify on class deletion and
> > make classfull qdiscs aware that it may get called on inactive
> > classes. And this is what I tried with my proposal.
> > This does not solve the backlog issues though. But the pressing
> > issue seems to be the uaf and not the statistic counters?
> >
> > My concern with preventing certain hierarchies is that we would
> > hide the backlog issues and we would be chasing bad hierarchies.
> > Still it would also solve all the problems eventually I guess.
> >
>
> On "What do you think the root cause is here?"
>
> I believe the root cause is that qdiscs like hfsc and qfq are dropping
> all packets in enqueue (mostly in relation to peek()) and that result
> is not being reflected in the return code returned to its parent
> qdisc.
> So, in the example you described in this thread, drr is oblivious to
> the fact that the child qdisc dropped its packet because the call to
> its child enqueue returned NET_XMIT_SUCCESS. This causes drr to
> activate a class that shouldn't have been activated at all.
>
> You can argue that drr (and other similar qdiscs) may detect this by
> checking the call to qlen_notify (as the drr patch was
> doing), but that seems really counter-intuitive. Imagine writing a new
> qdisc and having to check for that every time you call a child's
> enqueue. Sure  your patch solves this, but it also seems like it's not
> fixing the underlying issue (which is drr activating the class in the
> first place). Your patch is simply removing all the classes from their
> active lists when you delete them. And your patch may seem ok for now,
> but I am worried it might break something else in the future that we
> are not seeing.
>
> And do note: All of the examples of the hierarchy I have seen so far,
> that put us in this situation, are nonsensical
>

At this point my thinking is to apply your patch and then we discuss a
longer term solution. Cong?

cheers,
jamal

