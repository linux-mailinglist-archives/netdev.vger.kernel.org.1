Return-Path: <netdev+bounces-194508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED177AC9B8D
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 17:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4481BA082F
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 15:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D2422DF83;
	Sat, 31 May 2025 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ucZIeZeh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AC9129E6E
	for <netdev@vger.kernel.org>; Sat, 31 May 2025 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748705909; cv=none; b=Z9mwYk9LSrnyxhPuA8B+7vq/P0X4AOsl04wENyFgbmQUBDRGhnquUTQt1bsSffR/juktTF8UTGkYCMMFfjksTb62XqCa5g3Pf08JbqFC05ae8UWOrwACCzFLqslTpRr+kIrqw66bUwzVzx0habsmeBgoyjw1ZlWnkZ3eZGjuy9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748705909; c=relaxed/simple;
	bh=xvpTO7UDM3qXzu7EcVRhcAvoOWNoLkAuTncAp/9Nsno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gj1ot7bUXBZMW9g6lM63nliWAsKyyoUhxY/+hcKQCYdh0UQEYlDW0ipYDmP06NUuotpcnXnWUNqlzKAoQXHDivkX2tS4yVRiYMasll1MauH3Rrh0cIH+DbueeI8N9Vj3jzqiAmlSSfkWtSOs/cqd4a+ip4wYuvY0xpVtJ6hQDjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ucZIeZeh; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7398d65476eso2158548b3a.1
        for <netdev@vger.kernel.org>; Sat, 31 May 2025 08:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1748705906; x=1749310706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7SLEO3lgM+mvvsSEXemCkYRWFW13QCjpbq4pEhohMU=;
        b=ucZIeZehT26N5nkPCVp1Dj3ywNigPO5bRXNr2naH10iNPS4jw+h+m5RXv7R7f6uww5
         sP4rWI7/bjl7N//zy2eDldOiArSuvjhPRGlDa4rQgrh/k/vV/QzllCYNeJ13OEajib3D
         /7m+JDJhbGPPbJ1ldOfkL8Xqx+eTmn27J/MpWZRJr71/g+Xyt1vJymSowlnQEfCtcoxc
         XtG5oEcFxT0sokMuShFW3IjQySeE3O1zXaKM2Oqlpbb5j8UqoijLlrRnV8nnehhrFWKs
         Z7iWIAe9i637sqaJFB5l25lB8T8hCqMK1JGifVmOqGwNJeBqK2Oo5xYDTga0iUBycvm9
         f0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748705906; x=1749310706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7SLEO3lgM+mvvsSEXemCkYRWFW13QCjpbq4pEhohMU=;
        b=ALKS4OtrZgjL2kf9gi7L4dJ3CJLzo5GxQ2pJIaxrv2npj2R+eqZnqbBr5I7gLT0nYD
         6O9NrEijG2t3FmD7cW3DcBO20QEtfXLphxhNv/OVgsG39P+UyqVG32Kdfk3dfs4vj3mr
         hWV3uD2KvXv0J5oPXwrlO/dmmT85be46jkzg4sHgbK6LvQqyDDAVjdoV1Lxiu6WlHzZ/
         vZKxh8AGVlR60kPcev4/zT52rziyQdJNOfaGp1NGUueg7gNQMMKr4Bw0wMaDC+zvxKEL
         rATVEGzyVd6ICq4PzF5Uu5TyP+SHFBCqEvVI0pRlD0+cCKpt0uVXbxckcL0574oXbydw
         gNng==
X-Forwarded-Encrypted: i=1; AJvYcCUX5v69gc9wih7Ncy9cHb1X4nsbUyh5aFDSM1wc+PiF1/2UQjnqXNsXu+35W461O9lZDm4f8dA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+DXiQrNyk5/p9kSpxFnkG35pRUS/bUrnTNPvpd8kadht9c2cN
	e3c2pzEUDkV1mxE3PWWzqoSkw+QpEQ3TC8ab3PVbviJ12nT629bdFAE/GRVADhJeZdpkpSBr96q
	icWf7kj7gtnsMiC8CfN8gzS6+Kr9wYOrwR9OSY6yo6AmZ7FTdPC8=
X-Gm-Gg: ASbGncvCI21I56ha+yBSg2FAgw6ehqx2I3btBhKT5RIAeUgzr9W5DFSMRKAlIhU5S6o
	UkfJmgBWgHx/kv5QjiHNue/AXNKqFDFUjLBTpiPQ222kc3PlyR1mKuFWF4PhCVwBKxM9goWKtiH
	WZDclsCrxwMiQYK00mf0puB5KtD1Dt1Zw=
X-Google-Smtp-Source: AGHT+IEPNRPvJSWp7wgmE+u9RWig6WiB/sA4NDjS7llYfIiBKVwItlVvvbQk2zAxa136T09argotajc+fBScfoolHLU=
X-Received: by 2002:a05:6a00:a90:b0:742:aed4:3e1 with SMTP id
 d2e1a72fcca58-747ad443d05mr15927689b3a.2.1748705906450; Sat, 31 May 2025
 08:38:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io>
 <CAM0EoMkO0vZ4ZtODLJEBP5FiA0+ofVNOSf-BxCOGOyWAZDHdTg@mail.gmail.com>
 <FiSC_W4LweZiirPYQVe8p7CvUePHrufeDOQgkDT07zh-uy5s6eah-a8Vtr_lPrW73PAF51p6PPIrJITwrJ5vspk99wI5uZELnJijU5ILMUQ=@willsroot.io>
 <q7G0Z7oMR2x9TWwNHOiPNsZ8lHzAuXuVgrZgGmAgkH8lkIYyTgeqXwcDrelE_fdS9OdJ4TlfS96px6O9SvnmKigNKFkiaFlStvAGPIJ3b84=@willsroot.io>
 <CAM0EoMnmpjGVU2XyrH=p=-BY6JGU44qsqyfEik4g5E2M8rMMOQ@mail.gmail.com>
 <DISZZlS5CdbUKITzkIyT3jki3inTWSMecT6FplNmkpYs9bJizbs0iwRbTGMrnqEXrL3-__IjOQxdULPdZwGdKFSXJ1DZYIj6xmWPBZxerdk=@willsroot.io>
 <CAM0EoMke7ar8O=aJeZy7_XYMGbgES-X2B19R83Qcihxv4OeG8g@mail.gmail.com>
 <0x7zdcWIGm0NWid6NxFLpYOtO0Z1g6UCzrNnyVZ6hRvWr5rU6b6hi5Yz8dD7_dyUOmvJfkR8LV2_TrDf7uACFgGshyfxiRWgxjWer41EZVY=@willsroot.io>
 <CAM0EoMmns+rSyg4h-WGAMewqYWx0-MYC1DtRyJe4=rbgZN2UKQ@mail.gmail.com>
 <99X_9_r0DXyyKP-0xVz3Bg2FFXhmpCsIdTix8J-a52alNswEyVRbhMFnzyT35EOUP-8TVPL-UDvBbOd8u5_jRE10A98e_ULf5x6GTv03tbg=@syst3mfailure.io>
 <CAM0EoMnCHu5HrNjE-mf8_OFanrptcTFgaEPJbkWXJybhm8f8tw@mail.gmail.com>
In-Reply-To: <CAM0EoMnCHu5HrNjE-mf8_OFanrptcTFgaEPJbkWXJybhm8f8tw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 31 May 2025 11:38:15 -0400
X-Gm-Features: AX0GCFuQkIrcQSN1hp7Wp21rKSCJtnZQ9bA2Z2iYDGXyEhQ0l3NkShAQI6xvk88
Message-ID: <CAM0EoMk--+xXTf9ZG9M=r+gkRn2hczjqSTJRMV0dcgouJ4zw6g@mail.gmail.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
To: Savy <savy@syst3mfailure.io>
Cc: William Liu <will@willsroot.io>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 11:23=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Sat, May 31, 2025 at 9:20=E2=80=AFAM Savy <savy@syst3mfailure.io> wrot=
e:
> >
> > On Friday, May 30th, 2025 at 9:41 PM, Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > >
> > >
> > > Hi Will,
> > >
> > > On Fri, May 30, 2025 at 10:49=E2=80=AFAM William Liu will@willsroot.i=
o wrote:
> > >
> > > > On Friday, May 30th, 2025 at 2:14 PM, Jamal Hadi Salim jhs@mojatatu=
.com wrote:
> > > >
> > > > > On Thu, May 29, 2025 at 11:23=E2=80=AFAM William Liu will@willsro=
ot.io wrote:
> > > > >
> > > > > > On Wednesday, May 28th, 2025 at 10:00 PM, Jamal Hadi Salim jhs@=
mojatatu.com wrote:
> > > > > >
> > > > > > > Hi,
> > > > > > > Sorry for the latency..
> > > > > > >
> > > > > > > On Sun, May 25, 2025 at 4:43=E2=80=AFPM William Liu will@will=
sroot.io wrote:
> > > > > > >
> > > > > > > > I did some more testing with the percpu approach, and we re=
alized the following problem caused now by netem_dequeue.
> > > > > > > >
> > > > > > > > Recall that we increment the percpu variable on netem_enque=
ue entry and decrement it on exit. netem_dequeue calls enqueue on the child=
 qdisc - if this child qdisc is a netem qdisc with duplication enabled, it =
could duplicate a previously duplicated packet from the parent back to the =
parent, causing the issue again. The percpu variable cannot protect against=
 this case.
> > > > > > >
> > > > > > > I didnt follow why "percpu variable cannot protect against th=
is case"
> > > > > > > - the enqueue and dequeue would be running on the same cpu, n=
o?
> > > > > > > Also under what circumstances is the enqueue back to the root=
 going to
> > > > > > > end up in calling dequeue? Did you test and hit this issue or=
 its just
> > > > > > > theory? Note: It doesnt matter what the source of the skb is =
as long
> > > > > > > as it hits the netem enqueue.
> > > > > >
> > > > > > Yes, I meant that just using the percpu variable in enqueue wil=
l not protect against the case for when dequeue calls enqueue on the child.=
 Because of the child netem with duplication enabled, packets already invol=
ved in duplication will get sent back to the parent's tfifo queue, and then=
 the current dequeue will remain stuck in the loop before hitting an OOM - =
refer to the paragraph starting with "In netem_dequeue, the parent netem qd=
isc's t_len" in the first email for additional clarification. We need to kn=
ow whether a packet we dequeue has been involved in duplication - if it has=
, we increment the percpu variable to inform the children netem qdiscs.
> > > > > >
> > > > > > Hopefully the following diagram can help elucidate the problem:
> > > > > >
> > > > > > Step 1: Initial enqueue of Packet A:
> > > > > >
> > > > > > +----------------------+
> > > > > > | Packet A |
> > > > > > +----------------------+
> > > > > > |
> > > > > > v
> > > > > > +-------------------------+
> > > > > > | netem_enqueue |
> > > > > > +-------------------------+
> > > > > > |
> > > > > > v
> > > > > > +-----------------------------------+
> > > > > > | Duplication Logic (percpu OK): |
> > > > > > | =3D> Packet A, Packet B (dup) |
> > > > > > +-----------------------------------+
> > > > > > | <- percpu variable for netem_enqueue
> > > > > > v prevents duplication of B
> > > > > > +-------------+
> > > > > > | tfifo queue |
> > > > > > | [A, B] |
> > > > > > +-------------+
> > > > > >
> > > > > > Step 2: netem_dequeue processes Packet B (or A)
> > > > > >
> > > > > > +-------------+
> > > > > > | tfifo queue |
> > > > > > | [A] |
> > > > > > +-------------+
> > > > > > |
> > > > > > v
> > > > > > +----------------------------------------+
> > > > > > | netem_dequeue pops B in tfifo_dequeue |
> > > > > > +----------------------------------------+
> > > > > > |
> > > > > > v
> > > > > > +--------------------------------------------+
> > > > > > | netem_enqueue to child qdisc (netem w/ dup)|
> > > > > > +--------------------------------------------+
> > > > > > | <- percpu variable in netem_enqueue prologue
> > > > > > | and epilogue does not stop this dup,
> > > > > > v does not know about previous dup involvement
> > > > > > +--------------------------------------------------------+
> > > > > > | Child qdisc duplicates B to root (original netem) as C |
> > > > > > +--------------------------------------------------------+
> > > > > > |
> > > > > > v
> > > > > >
> > > > > > Step 3: Packet C enters original root netem again
> > > > > >
> > > > > > +-------------------------+
> > > > > > | netem_enqueue (again) |
> > > > > > +-------------------------+
> > > > > > |
> > > > > > v
> > > > > > +-------------------------------------+
> > > > > > | Duplication Logic (percpu OK again) |
> > > > > > | =3D> Packet C, Packet D |
> > > > > > +-------------------------------------+
> > > > > > |
> > > > > > v
> > > > > > .....
> > > > > >
> > > > > > If you increment a percpu variable in enqueue prologue and decr=
ement in enqueue epilogue, you will notice that our original repro will sti=
ll trigger a loop because of the scenario I pointed out above - this has be=
en tested.
> > > > > >
> > > > > > From a current view of the codebase, netem is the only qdisc th=
at calls enqueue on its child from its dequeue. The check we propose will o=
nly work if this invariant remains.
> > > > > >
> > > > > > > > However, there is a hack to address this. We can add a fiel=
d in netem_skb_cb called duplicated to track if a packet is involved in dup=
licated (both the original and duplicated packet should have it marked). Ri=
ght before we call the child enqueue in netem_dequeue, we check for the dup=
licated value. If it is true, we increment the percpu variable before and d=
ecrement it after the child enqueue call.
> > > > > > >
> > > > > > > is netem_skb_cb safe really for hierarchies? grep for qdisc_s=
kb_cb
> > > > > > > net/sched/ to see what i mean
> > > > > >
> > > > > > We are not using it for cross qdisc hierarchy checking. We are =
only using it to inform a netem dequeue whether the packet has partaken in =
duplication from its corresponding netem enqueue. That part seems to be pri=
vate data for the sk_buff residing in the current qdisc, so my understandin=
g is that it's ok.
> > > > > >
> > > > > > > > This only works under the assumption that there aren't othe=
r qdiscs that call enqueue on their child during dequeue, which seems to be=
 the case for now. And honestly, this is quite a fragile fix - there might =
be other edge cases that will cause problems later down the line.
> > > > > > > >
> > > > > > > > Are you aware of other more elegant approaches we can try f=
or us to track this required cross-qdisc state? We suggested adding a singl=
e bit to the skb, but we also see the problem with adding a field for a one=
-off use case to such a vital structure (but this would also completely sto=
mp out this bug).
> > > > > > >
> > > > > > > It sounds like quite a complicated approach - i dont know wha=
t the
> > > > > > > dequeue thing brings to the table; and if we really have to d=
equeue to
> > > > > >
> > > > > > Did what I say above help clarify what the problem is? Feel fre=
e to let me know if you have more questions, this bug is quite a nasty one.
> > > > >
> > > > > The text helped a bit, but send a tc reproducer of the issue you
> > > > > described to help me understand better how you end up in the tfif=
o
> > > > > which then calls the enqueu, etc, etc.
> > > >
> > > > The reproducer is the same as the original reproducer we reported:
> > > > tc qdisc add dev lo root handle 1: netem limit 1 duplicate 100%
> > > > tc qdisc add dev lo parent 1: handle 2: netem gap 1 limit 1 duplica=
te 100% delay 1us reorder 100%
> > > > ping -I lo -f -c1 -s48 -W0.001 127.0.0.1
> > > >
> > > > We walked through the issue in the codepath in the first email of t=
his thread at the paragraph starting with "The root cause for this is compl=
ex. Because of the way we setup the parent qdisc" - please let me know if a=
ny additional clarification is needed for any part of it.
> > >
> > >
> > > Ok, so I tested both your approach and a slight modification of the
> > > variant I sent you. They both fix the issue. TBH, I still find your
> > > approach complex. While i hate to do this to you, my preference is
> > > that you use the attached version - i dont need the credit, so just
> > > send it formally after testing.
> > >
> > > cheers,
> > > jamal
> >
> > Hi Jamal,
> >
> > Thank you for your patch. Unfortunately, there is an issue that Will an=
d I
> > also encountered when we submitted the first version of our patch.
> >
> > With this check:
> >
> >         if (unlikely(nest_level > 1)) {
> >                 net_warn_ratelimited("Exceeded netem recursion %d > 1 o=
n dev %s\n",
> >                                      nest_level, netdev_name(skb->dev))=
;
> >                 // ...
> >         }
> >
> > when netem_enqueue is called, we have:
> >
> >         netem_enqueue()
> >                 // nest_level is incremented to 1
> >                 // q->duplicate is 100% (0xFFFFFFFF)
> >                 // skb2 =3D skb_clone()
> >                 // rootq->enqueue(skb2, ...)
> >                 netem_enqueue()
> >                         // nest_level is incremented to 2
> >                         // nest_level now is > 1
> >                         // The duplicate is dropped
> >
> > Basically, with this approach, all duplicates are automatically dropped=
.
> >
> > If we modify the check by replacing 1 with 2:
> >
> >         if (unlikely(nest_level > 2)) {
> >                 net_warn_ratelimited("Exceeded netem recursion %d > 1 o=
n dev %s\n",
> >                                      nest_level, netdev_name(skb->dev))=
;
> >                 // ...
> >         }
> >
> > the infinite loop is triggered again (this has been tested and also ver=
ified in GDB).
> >
> > This is why we proposed an alternative approach, but I understand it is=
 more complex.
> > Maybe we can try to work on that and make it more elegant.
> >
>
> I am not sure.
> It is a choice between complexity to "fix" something that is a bad
> configuration, i.e one that should not be allowed to begin with, vs
> not burdening the rest.
> IOW, if you created a single loop(like the original report) the
> duplicate packet will go through but subsequent ones will not). If you
> created a loop inside a loop(as you did here), does anyone really care
> about the duplicate in each loop not making it through? It would be
> fine to "fix it" so you get duplicates in each loop if there was
> actually a legitimate use case. Remember one of the original choices
> was to disallow the config ...
>

Actually I think i misunderstood you. You are saying it breaks even
the working case for duplication.
Let me think about it..

cheers,
jamal

