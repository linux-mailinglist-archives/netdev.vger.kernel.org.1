Return-Path: <netdev+bounces-202202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F42AECA69
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 23:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124E13B76AC
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 21:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2DF2222A8;
	Sat, 28 Jun 2025 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="i2kFNNF2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347937DA66
	for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751147021; cv=none; b=OaGosRUZxxaHCt9MxuqikcmUC3vNVOPHa63jGeylBqU6gzdpPClgu+Xnvh5M3mXVDyTES03GFBIEiTPB/kYD58NAcHG0s93Y1EJlLLDAximgBLdvFgMza36KrJ+9iBWJ6qJxuOh9+eYL9AwmRRuwyqi4m2uTYhM3KS4UWm/0sYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751147021; c=relaxed/simple;
	bh=8qpfupX9YM+cPjJYUBH2kd5c0PcyqN/5Z8aODDgIleA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1H5I79f48+fIC0hSbXAYJsdsts8cN4VHKtFhJv9amgbB8aetCAvUl6AW0rSUFDzICFkp8EI8XCPl/cI7FUWK2+ClbnixLSdq9ji4zC+BYtDNT9F1GeA65IBr7pCeMiGa9H+IhqaHJ5uz4NXX7C+y9kPDmLmU80XLnM3eRJtYok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=i2kFNNF2; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-73972a54919so966069b3a.3
        for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 14:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751147016; x=1751751816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MU6rUaXd/jwIT7Zn2GEQQNo0DhvukKg2e5GHoI2EbLc=;
        b=i2kFNNF2XfvvmFqXnfPLS/gi/HlifkML3+zohWJVgxwQStz9PB2Qq3ofiac/Sq7wsU
         I8dfvPpByNH3u+IZKfTN5MLHRU0Qoq3lKyzVe/79cgWYtGGWO394Yp2kYz5Xff9RgxOX
         RFxt4vqu95xlrwrHk+FBrRLYGgYMeUpbPZIwyf3ls1miGJ21tQATnMJHvt28Vp5czg0b
         jRJuVgxb79mTnG2PPqYafgr0LuqBmHSd4YQGBs81n2bo5HC/ZcXcxFYTjM6qfEZh/0oz
         Oe40/fpx/oOmjikeQpcRkatItuv6vS749eM7Ohb+YzwMuWd1WxKgJg3dv23mQ8RyF+vb
         ITMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751147016; x=1751751816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MU6rUaXd/jwIT7Zn2GEQQNo0DhvukKg2e5GHoI2EbLc=;
        b=uVfM9UZ968qX8bnMwQV+ebld7hA+DbX42mLeFgS77a9N/aVquqArY1UgcsUeda9bWu
         gJ+1CJB/biyOlU29oD4/oS8pv11DYgK1g7jLi+4dL+EzYdYPBzpfzapAEl5CGXZIyOPg
         bSYBHwPByWV4DafDiLCXOW5rmpZ/JAG9TR1OV7Lq6gSCU+HQULK4vAPdB22IfZMgSup2
         LTy2DE3kXckB6ttgftjW/OM1my8FjikS9JTez61dw1b9qlvdRIx+Ft1i/oMqRMaWZrfe
         atvyqLd3AXqX0r3aB/2ez+eM2ZDuT1Zg7Gkz0N9XCFrvQcFQagh9f7M+lV/vPlqcXr+W
         KL2g==
X-Forwarded-Encrypted: i=1; AJvYcCVi+lZ9vF1kVZWeEo2D1LbdNVn8wplYiWyrL/8rxoUQu+1xE5OH0ZvcbscYbWkHfpwiwPVk4fY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+rqacR/2kbhay0q+NOKeY6H030SdLKMi9UrzQDJFLRdRkVi3N
	H4oYSR6kvcouLCDZkIDDTukIpJJeuPjIDNbK1k8Sj17aP02sw87fDwCWcY74jslI7Kq/mnhXszo
	BD9nNvkCkyUimb9Gma0HHLuhWzn7A35jkteXoE143drXPti9+TY7yrg==
X-Gm-Gg: ASbGncth7pc+gkYyz5xBKkHSDvzqG7dCi6+lvnMQ3BdKmVDHejmLJ16kHrh7UahxT7J
	qeBDm7z6ASj8ftEeMicRtRj63FT0P2q/E2a9a+Gx0D6NmRTJEsWx9cl8yGgRkwm0xIAKhyf1SWk
	HAXsNXe/YQSQuL+Zo6LQA92tTrvzdOfu56kt9oyVNu3w==
X-Google-Smtp-Source: AGHT+IGZg4IXlxL3x10Kvx/31X16LC0IBK3hyvWl1q3uyu38lUVpfO1zW6/k8WY4u0FaRG1Zos9RGuga160MtQC5pJ4=
X-Received: by 2002:a05:6a20:2449:b0:1f5:95a7:8159 with SMTP id
 adf61e73a8af0-220a12d3834mr12486991637.10.1751147015798; Sat, 28 Jun 2025
 14:43:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com>
 <aFosjBOUlOr0TKsd@pop-os.localdomain> <3af4930b-6773-4159-8a7a-e4f6f6ae8109@gmail.com>
 <5e4490da-3f6c-4331-af9c-0e6d32b6fc75@gmail.com> <CAM0EoMm+xgb0vkTDMAWy9xCvTF+XjGQ1xO5A2REajmBN1DKu1Q@mail.gmail.com>
 <d23fe619-240a-4790-9edd-bec7ab22a974@gmail.com>
In-Reply-To: <d23fe619-240a-4790-9edd-bec7ab22a974@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 28 Jun 2025 17:43:24 -0400
X-Gm-Features: Ac12FXw6fj0AJ6Skf1_AaURBAmblgPpYqxtIRjRAgmxwJWtNAKxP_R1eZAQ6tuQ
Message-ID: <CAM0EoM=rU91P=9QhffXShvk-gnUwbRHQrwpFKUr9FZFXbbW1gQ@mail.gmail.com>
Subject: Re: Incomplete fix for recent bug in tc / hfsc
To: Lion Ackermann <nnamrec@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, Mingi Cho <mincho@theori.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 4:08=E2=80=AFAM Lion Ackermann <nnamrec@gmail.com> =
wrote:
>
> Hi,
>
> On 6/25/25 4:22 PM, Jamal Hadi Salim wrote:
> > On Tue, Jun 24, 2025 at 6:43=E2=80=AFAM Lion Ackermann <nnamrec@gmail.c=
om> wrote:
> >>
> >> Hi,
> >>
> >> On 6/24/25 11:24 AM, Lion Ackermann wrote:
> >>> Hi,
> >>>
> >>> On 6/24/25 6:41 AM, Cong Wang wrote:
> >>>> On Mon, Jun 23, 2025 at 12:41:08PM +0200, Lion Ackermann wrote:
> >>>>> Hello,
> >>>>>
> >>>>> I noticed the fix for a recent bug in sch_hfsc in the tc subsystem =
is
> >>>>> incomplete:
> >>>>>     sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enque=
ue()
> >>>>>     https://lore.kernel.org/all/20250518222038.58538-2-xiyou.wangco=
ng@gmail.com/
> >>>>>
> >>>>> This patch also included a test which landed:
> >>>>>     selftests/tc-testing: Add an HFSC qlen accounting test
> >>>>>
> >>>>> Basically running the included test case on a sanitizer kernel or w=
ith
> >>>>> slub_debug=3DP will directly reveal the UAF:
> >>>>
> >>>> Interesting, I have SLUB debugging enabled in my kernel config too:
> >>>>
> >>>> CONFIG_SLUB_DEBUG=3Dy
> >>>> CONFIG_SLUB_DEBUG_ON=3Dy
> >>>> CONFIG_SLUB_RCU_DEBUG=3Dy
> >>>>
> >>>> But I didn't catch this bug.
> >>>>
> >>>
> >>> Technically the class deletion step which triggered the sanitizer was=
 not
> >>> present in your testcase. The testcase only left the stale pointer wh=
ich was
> >>> never accessed though.
> >>>
> >>>>> To be completely honest I do not quite understand the rationale beh=
ind the
> >>>>> original patch. The problem is that the backlog corruption propagat=
es to
> >>>>> the parent _before_ parent is even expecting any backlog updates.
> >>>>> Looking at f.e. DRR: Child is only made active _after_ the enqueue =
completes.
> >>>>> Because HFSC is messing with the backlog before the enqueue complet=
ed,
> >>>>> DRR will simply make the class active even though it should have al=
ready
> >>>>> removed the class from the active list due to qdisc_tree_backlog_fl=
ush.
> >>>>> This leaves the stale class in the active list and causes the UAF.
> >>>>>
> >>>>> Looking at other qdiscs the way DRR handles child enqueues seems to=
 resemble
> >>>>> the common case. HFSC calling dequeue in the enqueue handler violat=
es
> >>>>> expectations. In order to fix this either HFSC has to stop using de=
queue or
> >>>>> all classful qdiscs have to be updated to catch this corner case wh=
ere
> >>>>> child qlen was zero even though the enqueue succeeded. Alternativel=
y HFSC
> >>>>> could signal enqueue failure if it sees child dequeue dropping pack=
ets to
> >>>>> zero? I am not sure how this all plays out with the re-entrant case=
 of
> >>>>> netem though.
> >>>>
> >>>> I think this may be the same bug report from Mingi in the security
> >>>> mailing list. I will take a deep look after I go back from Open Sour=
ce
> >>>> Summit this week. (But you are still very welcome to work on it by
> >>>> yourself, just let me know.)
> >>>>
> >>>> Thanks!
> >>>
> >>>> My suggestion is we go back to a proposal i made a few moons back (w=
as
> >>>> this in a discussion with you? i dont remember): create a mechanism =
to
> >>>> disallow certain hierarchies of qdiscs based on certain attributes,
> >>>> example in this case disallow hfsc from being the ancestor of "qdisc=
s that may
> >>>> drop during peek" (such as netem). Then we can just keep adding more
> >>>> "disallowed configs" that will be rejected via netlink. Similar idea
> >>>> is being added to netem to disallow double duplication, see:
> >>>> https://lore.kernel.org/netdev/20250622190344.446090-1-will@willsroo=
t.io/
> >>>>
> >>>> cheers,
> >>>> jamal
> >>>
> >>> I vaguely remember Jamal's proposal from a while back, and I believe =
there was
> >>> some example code for this approach already?
> >>> Since there is another report you have a better overview, so it is pr=
obably
> >>> best you look at it first. In the meantime I can think about the solu=
tion a
> >>> bit more and possibly draft something if you wish.
> >>>
> >>> Thanks,
> >>> Lion
> >>
> >> Actually I was intrigued, what do you think about addressing the root =
of the
> >> use-after-free only and ignore the backlog corruption (kind of). After=
 the
> >> recent patches where qlen_notify may get called multiple times, we cou=
ld simply
> >> loosen qdisc_tree_reduce_backlog to always notify when the qdisc is em=
pty.
> >> Since deletion of all qdiscs will run qdisc_reset / qdisc_purge_queue =
at one
> >> point or another, this should always catch left-overs. And we need not=
 care
> >> about all the complexities involved of keeping the backlog right and /=
 or
> >> prevent certain hierarchies which seems rather tedious.
> >> This requires some more testing, but I was imagining something like th=
is:
> >>
> >> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> >> --- a/net/sched/sch_api.c
> >> +++ b/net/sched/sch_api.c
> >> @@ -780,15 +780,12 @@ static u32 qdisc_alloc_handle(struct net_device =
*dev)
> >>
> >>  void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
> >>  {
> >> -       bool qdisc_is_offloaded =3D sch->flags & TCQ_F_OFFLOADED;
> >>         const struct Qdisc_class_ops *cops;
> >>         unsigned long cl;
> >>         u32 parentid;
> >>         bool notify;
> >>         int drops;
> >>
> >> -       if (n =3D=3D 0 && len =3D=3D 0)
> >> -               return;
> >>         drops =3D max_t(int, n, 0);
> >>         rcu_read_lock();
> >>         while ((parentid =3D sch->parent)) {
> >> @@ -797,17 +794,8 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch,=
 int n, int len)
> >>
> >>                 if (sch->flags & TCQ_F_NOPARENT)
> >>                         break;
> >> -               /* Notify parent qdisc only if child qdisc becomes emp=
ty.
> >> -                *
> >> -                * If child was empty even before update then backlog
> >> -                * counter is screwed and we skip notification because
> >> -                * parent class is already passive.
> >> -                *
> >> -                * If the original child was offloaded then it is allo=
wed
> >> -                * to be seem as empty, so the parent is notified anyw=
ay.
> >> -                */
> >> -               notify =3D !sch->q.qlen && !WARN_ON_ONCE(!n &&
> >> -                                                      !qdisc_is_offlo=
aded);
> >> +               /* Notify parent qdisc only if child qdisc becomes emp=
ty. */
> >> +               notify =3D !sch->q.qlen;
> >>                 /* TODO: perform the search on a per txq basis */
> >>                 sch =3D qdisc_lookup(qdisc_dev(sch), TC_H_MAJ(parentid=
));
> >>                 if (sch =3D=3D NULL) {
> >> @@ -816,6 +804,9 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, =
int n, int len)
> >>                 }
> >>                 cops =3D sch->ops->cl_ops;
> >>                 if (notify && cops->qlen_notify) {
> >> +                       /* Note that qlen_notify must be idempotent as=
 it may get called
> >> +                        * multiple times.
> >> +                        */
> >>                         cl =3D cops->find(sch, parentid);
> >>                         cops->qlen_notify(sch, cl);
> >>                 }
> >>
> >
> > I believe this will fix the issue. My concern is we are not solving
> > the root cause. I also posted a bunch of fixes on related issues for
> > something Mingi Cho (on Cc) found - see attachments, i am not in favor
> > of these either.
> > Most of these setups are nonsensical. After seeing so many of these my
> > view is we start disallowing such hierarchies.
> >
> > cheers,
> > jamal
>
> I would also disagree with the attached patches for various reasons:
> - The QFQ patch relies on packet size backlog, which is not to be
>   trusted because of several sources that may make this unreliable
>   (netem, size tables, GSO, etc.)
> - In the TBF variant the ret may get overwritten during the loop,
>   so it only relies on the final packet status. I would not trust
>   this always working either.
> - DRR fix seems fine, but it still requires all other qdiscs to
>   be correct (and something similar needs to be applied to all
>   classfull qdiscs?)
> - The changes to qdisc_tree_reduce_backlog do not really make sense
>   to me I must be missing something here..
>
> What do you think the root cause is here? AFAIK what all the issues
> have in common is that eventually qlen_notify is _not_ called,
> thus leaving stale class pointers. Naturally the consequence
> could be to simply always call qlen_notify on class deletion and
> make classfull qdiscs aware that it may get called on inactive
> classes. And this is what I tried with my proposal.
> This does not solve the backlog issues though. But the pressing
> issue seems to be the uaf and not the statistic counters?
>
> My concern with preventing certain hierarchies is that we would
> hide the backlog issues and we would be chasing bad hierarchies.
> Still it would also solve all the problems eventually I guess.
>

On "What do you think the root cause is here?"

I believe the root cause is that qdiscs like hfsc and qfq are dropping
all packets in enqueue (mostly in relation to peek()) and that result
is not being reflected in the return code returned to its parent
qdisc.
So, in the example you described in this thread, drr is oblivious to
the fact that the child qdisc dropped its packet because the call to
its child enqueue returned NET_XMIT_SUCCESS. This causes drr to
activate a class that shouldn't have been activated at all.

You can argue that drr (and other similar qdiscs) may detect this by
checking the call to qlen_notify (as the drr patch was
doing), but that seems really counter-intuitive. Imagine writing a new
qdisc and having to check for that every time you call a child's
enqueue. Sure  your patch solves this, but it also seems like it's not
fixing the underlying issue (which is drr activating the class in the
first place). Your patch is simply removing all the classes from their
active lists when you delete them. And your patch may seem ok for now,
but I am worried it might break something else in the future that we
are not seeing.

And do note: All of the examples of the hierarchy I have seen so far,
that put us in this situation, are nonsensical

cheers,
jamal

