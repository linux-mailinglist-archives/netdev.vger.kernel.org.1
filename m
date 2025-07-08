Return-Path: <netdev+bounces-205176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBD9AFDB1D
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 00:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9FF3A22BA
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 22:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B552264B6;
	Tue,  8 Jul 2025 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="0d6tWMCm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FBB253F1B
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013602; cv=none; b=ulWMJfmrnRUsTUDJS+eySs4IXsf16VmykfMJBDAsI0fiDEirnIm+vXp8HuAcqM+sP10/Qt0FLFy8cAC78VObAfJJO5fa9FhzygU1AkAiSxEWOj85JZGtD57RQSKFDOJq13ZLIRVmTSK4WqRhY71Dk5lfyMzYhUQUY22wJjA34dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013602; c=relaxed/simple;
	bh=VOYlpoRF7krwl9ExFoYCJ6RtFi5wqe9hK5JYTxG5CFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bIDT9JJHHCWE6ez/yFgForJJGvvfMOqSWjskQqMKfsh2EKm61ds9+7Pahd5JUQ9e0EgXk0Cuge7ElxPvYPJ6o+wcqhpRssPlpDwFsY/mKRMHMV3mVv/GvjUqnClT/whXbUqkHvS/z+r5bIapHFQp+NfLYU7L47NwrU5qvdy+/cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=0d6tWMCm; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso4269801b3a.0
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1752013600; x=1752618400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBDC23Jd9sI3gkuOXtvy89/i8NpylQ1MfMYpuzUpuCY=;
        b=0d6tWMCmBYezLeiW5Xa1VFPUew3c4ekR/KxLGhmB3TzBlEos/BNsKdfL/e+35KMwrn
         suM2++/3SuMrq3rRlV+6H/bsNv41JGALyo1ImErlPvjnC+fkSJQdzrOQae3JMPZM39Zv
         bZFcHM5ZpmokBjIwQ+bwzUvi3/VGyTjwJICRId7sE8r2YzmNwk6J9VmQptcEWkKiSD1g
         rqvOneuhL7oGAqlJTp3h6/MXIvyqREqrlGc5Dx0V+piGfaT78CmcmeYNGxeUhaxMWDdm
         mkV7zrDN/FD1s40ep4VFBoITy2vPu/oXF7MYZnfm/CtbJYxB6MqAsaeiUdOCCWszeTlc
         U8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752013600; x=1752618400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBDC23Jd9sI3gkuOXtvy89/i8NpylQ1MfMYpuzUpuCY=;
        b=KoQ1JwLMvzOylP/GRWqcbCzkLthb7wXRBKY1b8ugIk9L0+/IT1zzhe70w/PynXjPxU
         h7VLlM3eQWoi2qLTJNZUHWHyJ9SvULM4pWiAB4YAit89K4tfS2GunNzVm7t/lsr8HDGV
         Y8Rn+745usRVKf9dm5EOxoDd1XLTSNuM3OPwJ2b6+IxYPDbBmD+K7NX7/FPIKpGOOKUh
         IX87oPMmJ8xaO8QxRq2JnGHsG2rJrmmXxQT3mZnPmaheESVuIfHsEFr+JWiOiM/3Dcpx
         KzVF38Mw6HBbT1q4dp4qIHixjnvsKhVx09fiB2UffMiBe8Z1Wde36p+QRS0dUEG2ZZaM
         aquA==
X-Forwarded-Encrypted: i=1; AJvYcCWPuNYlePi75VMUsUDBbHOCaEfstFFcrNSisiftT4CccgA1Ylg3YUZHN/tDffELnkj0XEL/7qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLgAWEF/ko9uzqURIuOyMln5WyjrHrFd2NWf9b/SQFggZBl9z1
	gqLaTztjiOy3BeBfU++bvpJUrm+309ZKwTlajdaXIcPXwDAG4ATzchCXhmoCFr7ehARGHcdMnRB
	9ITjHs+slv4EoKDKxlivhGLA4IV7GruSgCJEs3X89
X-Gm-Gg: ASbGnctMh7Tofiyj0qb2RJ/58K4XrQX8ROSku+2o3M50IqB6QUcdNUz09+MNJy4BUiL
	1LLl6l8nWzd86dVC7gBsRJ/QiHdrETTXaIOD+fw96T1sYepybIroNY6A2Qqr7ohroumh57wIm2u
	0TdwWJJ9pdi12TBHGGBzu2VON82Iqj9gARjG978In5Ef04l3On3SvD
X-Google-Smtp-Source: AGHT+IHxRUCFCF4R9y4Ozta0VqRVZwh5xy6qrKNbREQ6o5TAR/ORUPkJfZQB9EqERKGzvPY78hfF6PJQgpoPpM5QV2o=
X-Received: by 2002:a05:6a20:1594:b0:1f5:5a0b:4768 with SMTP id
 adf61e73a8af0-22cd846cde7mr112244637.21.1752013599832; Tue, 08 Jul 2025
 15:26:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708164141.875402-1-will@willsroot.io> <aG10rqwjX6elG1Gx@pop-os.localdomain>
 <CAM0EoMmP5SBzhoKGGxfdkfvMEZ0nFCiKNJ8hBa4L-0WTCqC5Ww@mail.gmail.com> <aG2OUoDD2m5MqdSz@pop-os.localdomain>
In-Reply-To: <aG2OUoDD2m5MqdSz@pop-os.localdomain>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 8 Jul 2025 18:26:28 -0400
X-Gm-Features: Ac12FXxo0skEu3aU9U374unnDuJdsO-HFMwXTSqerMaTb_WzZntxLVCNU9CxUAI
Message-ID: <CAM0EoMmuL7-pOqQZMA6Y0WW_zDzpbyRsw0HRHzn0RV=An9gsRw@mail.gmail.com>
Subject: Re: This breaks netem use cases
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: William Liu <will@willsroot.io>, netdev@vger.kernel.org, victor@mojatatu.com, 
	pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, 
	stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 5:32=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com>=
 wrote:
>
> (Cc Linus Torvalds)
>
> On Tue, Jul 08, 2025 at 04:35:37PM -0400, Jamal Hadi Salim wrote:
> > On Tue, Jul 8, 2025 at 3:42=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.=
com> wrote:
> > >
> > > (Cc LKML for more audience, since this clearly breaks potentially use=
ful
> > > use cases)
> > >
> > > On Tue, Jul 08, 2025 at 04:43:26PM +0000, William Liu wrote:
> > > > netem_enqueue's duplication prevention logic breaks when a netem
> > > > resides in a qdisc tree with other netems - this can lead to a
> > > > soft lockup and OOM loop in netem_dequeue, as seen in [1].
> > > > Ensure that a duplicating netem cannot exist in a tree with other
> > > > netems.
> > >
> > > As I already warned in your previous patchset, this breaks the follow=
ing
> > > potentially useful use case:
> > >
> > > sudo tc qdisc add dev eth0 root handle 1: mq
> > > sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem duplicate 100%
> > > sudo tc qdisc add dev eth0 parent 1:2 handle 20: netem duplicate 100%
> > >
> > > I don't see any logical problem of such use case, therefore we should
> > > consider it as valid, we can't break it.
> > >
> >
> > I thought we are trying to provide an intermediate solution to plug an
> > existing hole and come up with a longer term solution.
>
> Breaking valid use cases even for a short period is still no way to go.
> Sorry, Jamal. Since I can't convince you, please ask Linus.
>
> Also, I don't see you have proposed any long term solution. If you
> really have one, please state it clearly and provide a clear timeline to
> users.
>

I explained my approach a few times: We need to come up with a long
term solution that looks at the sanity of hierarchies.
Equivalent to init/change()
Today we only look at netlink requests for a specific qdisc. The new
approach (possibly an ops) will also look at the sanity of configs in
relation to hierarchies.
You can work on it or come with an alternative proposal.
That is not the scope of this discussion though

> > If there are users of such a "potential setup" you show above we are
> > going to find out very quickly.
>
> Please read the above specific example. It is more than just valid, it
> is very reasonable, installing netem for each queue is the right way of
> using netem duplication to avoid the global root spinlock in a multiqueue
> setup.
>

In all my years working on tc I have never seen _anyone_ using
duplication where netem is _not the root qdisc_. And i have done a lot
of "support" in this area.
You can craft any example you want but it needs to be practical - I
dont see the practicality in your example.
Just because we allow arbitrary crafting of hierarchies doesnt mean
they are correct.
The choice is between complicating things to fix a "potential" corner
use case vs simplicity (especially of a short term approach that is
intended to be obsoleted in the long term).


> Breaking users and letting them complain is not a good strategy either.
>
> On the other hand, thanks for acknowledging it breaks users, which
> confirms my point.
>
> I will wait for Linus' response.
>
> > We are working against security people who are finding all sorts of
> > "potential use cases" to create CVEs.
>
> I seriouly doubt the urgency of those CVE's, because none of them can be
> triggered without root. Please don't get me wrong, I already fixed many o=
f
> them, but I believe they can wait, false urgency does not help anything.
>

All tc rules require root including your example  - afaik, bounties
are being given for unprivileged user namespaces

> >
> > > >
> > > > Previous approaches suggested in discussions in chronological order=
:
> > > >
> > > > 1) Track duplication status or ttl in the sk_buff struct. Considere=
d
> > > > too specific a use case to extend such a struct, though this would
> > > > be a resilient fix and address other previous and potential future
> > > > DOS bugs like the one described in loopy fun [2].
> > >
> > > The link you provid is from 8 years ago, since then the redirection
> > > logic has been improved. I am not sure why it helps to justify your
> > > refusal of this approach.
> > >
> > > I also strongly disagree with "too specific a use case to extend such
> > > a struct", we simply have so many use-case-specific fields within
> > > sk_buff->cb. For example, the tc_skb_cb->zone is very specific
> > > for act_ct.
> > >
> > > skb->cb is precisely designed to be use-case-specific and layer-speci=
fic.
> > >
> > > None of the above points stands.
> > >
> >
> > I doubt you have looked at the code based on how you keep coming back
> > with the same points.
>
> Please avoid personal attacks. It helps nothing to your argument here,
> in fact, it will only weaken your arguments.
>

How is this a personal attack? You posted a patch that breaks things furthe=
r.
I pointed it to you _multiple times_. You still posted it as a solution!


> > > >
> > > > 2) Restrict netem_enqueue recursion depth like in act_mirred with a
> > > > per cpu variable. However, netem_dequeue can call enqueue on its
> > > > child, and the depth restriction could be bypassed if the child is =
a
> > > > netem.
> > > >
> > > > 3) Use the same approach as in 2, but add metadata in netem_skb_cb
> > > > to handle the netem_dequeue case and track a packet's involvement
> > > > in duplication. This is an overly complex approach, and Jamal
> > > > notes that the skb cb can be overwritten to circumvent this
> > > > safeguard.
> > >
> > > This is not true, except qdisc_skb_cb(skb)->data, other area of
> > > skb->cb is preserved within Qdisc layer.
> > >
> >
> > Your approach has issues as i pointed out. At minimum invest the time
> > please and look at code.
>
> Sure, no one's patch is perfect. I am open to improve any of my patch
> First, let's discard this user-breaking patch for disatractions and
> start focusing other solutions (not necessarily mine).
>
> If it could help you, I can set the author to be you.

You think i am after getting my name on patches after all these years?
The patch is not sent by me - it is William's. There's zero credit on
my name. I could have written the patch myself, instead i guided a new
contributor on a path forward. That is my general approach to these
things.

> I have no interest
> to take any credit out of here, the reason why I sent out a patch is only
> because you asked me to help.
>

I think you are still missing the point. Let William get his patch in.

cheers,
jamal

> > I am certain you could keep changing other code outside of netem and
> > fix all issues you are exposing.
> > We agreed this is for a short term solution and needs to be contained
>
> I never agreed with you on breaking users, to me it is out of table for
> discussion. Just to clarify.
>
> > on just netem, what is the point of this whole long discussion really?
>
> To defend users, obviously.
>
> > We have spent over a month already..
>
> Sorry to hear that, I think you are going to a wrong direction. The
> earlier you switch to a right direction, the sooner we will have a right
> solution without breaking any users.
>
> Once again, please let me know how I specifically can help you out of
> this situation. I am here to solve problems, not to bring one.
>
> (If you need a video call for help, my calendar is open.)
>
> Thanks for your understanding!

