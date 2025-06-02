Return-Path: <netdev+bounces-194672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A81E1ACBCC4
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 23:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926CA3A4764
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 21:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87EB1C3306;
	Mon,  2 Jun 2025 21:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="gadPEcSO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA31921CA07
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748900394; cv=none; b=js5yNLf7bJ+X8YxlLpykI1OIz28v3qWUZGda5iLgh7Un3FAbTspGdkRMazHUovdGhkjqkeWELUI5x9raabhOayNbL0ofNquwHMVx660Wp2Qon+hCQLYntyO5e6mGakpCVo85hBqdWoh4MYsnsxx/7fEAQcCKO1MJIDq8jP/nzNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748900394; c=relaxed/simple;
	bh=oV4o9ufZfwHnQumSRQwAPKDcR0e5kzNHKsF6OZ5dc0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRx8zSWWCHJWKwzssv7lL7KX61NnzQllWe6okWWXQKmbH4CyWD4dXllT3En2clHj1o/dFRWIv/fFxkCsLK07oIx8ZB27pt8hznWfHEPg+QstqRO5vql2f/bpTNHMwYXcUYT3W253bYvfHDafkdLS6LB8948y+gsI+Xer8ly9BKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=gadPEcSO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-742c73f82dfso3914968b3a.2
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 14:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1748900392; x=1749505192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBDXAon3IWFHrLePINlpDFJEccrgLoomDUmYurFTrMg=;
        b=gadPEcSOdePqo0lJaOFRH7zknfDzvmvmmLCXxqGl2OEV21yYziI6aFdbR/OcZvU/uT
         BYR6MljKIFlEhiWS29VIiG7eAKt8ahzk22lARjBQ48DOB57b7TbZFQ2Rc5CtmHueLUZN
         nuU7G9kHOhM65VGqREZ8MtNW78eFRvpk4pXsesDrVB12Lzzg/2m0MWRcDVA2Edgm4b/U
         xpjMwM+g8K0YDdn6JZ+io3Iu66tSq0Hg8oUUlDramLclItbxUMrA9LUkUfhsV3SWDZdX
         FOiyeG+V1U35XIokNu9PdLMMH5ANiMX7h/yb1VsuqQNLpQkxMCB1xsX1XiJ2XBQpQLi0
         9RBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748900392; x=1749505192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBDXAon3IWFHrLePINlpDFJEccrgLoomDUmYurFTrMg=;
        b=Qr0d734DKCw2PvDMsrLnArG382dYA6+Mrh9FylWKZ6PQGvK0pt3BGo4gktDSE0MIxs
         RXl0Ly4WowRxjiqjPAvuDkpxR/WrnECTAWzI9yNt7Ib5oT4hPbxs6a19BN1RxlIqzESa
         nGd9BYH4qrx/jISIS+sYNk1aQU7wp5l8WbyIfEEQjn7t3o2xVbtdyqePgKVof+rg3JpX
         unKOMM9xg/KNY9A4t1aXqEzCsvwYio+gZ6+BO+Ydi16867h3ridxskiQT2KB4Llo1CL9
         syWbV8V9PTGNhFgbHde2Yh/9wBLvAwQRi/DABsE3HJwBOmLy31DoN08ulhFrWwkXGiXN
         W/OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWazZrAyzgZ1UbXYZZLFA+EC+mkLixsjX5pkkrhFIOKkxxxG2J7cgwy2Y5omv3jqwog+3+44ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkY6WdrrJ5ot3aUM36mEZ96j74j7S7vfwc6cJh5gKZeNVCWckB
	HIObmyblGeaJW7QO28Z2y9RYxVJVRgkWssN3EFo9IEa9HVRqlJaZZI1FURnJrxoPsU8bKopJR+t
	OaMUy2w+IUMCHhc0aUktB3vmP45J5y7Vnf/+6ruiA
X-Gm-Gg: ASbGncvKn65l80KMMYgN7GF+QEc/2VFmFcFpWf8rxA4eo3v4aZUxWy/l+mcwpgbkuxl
	yQE08AEN6CZH4AE7trrNCc3YA61UKZPhL+zxsxTjpnsZ8LvskZ2fVJjxV1drmTokx/S9GE8Hu6x
	ZDCPjkWAdDJBWxfDztODJhCq7ycgDp9R4=
X-Google-Smtp-Source: AGHT+IHSVW9uUKlMx1mZbAqcmLVXDXDpmMBtWJ7BnyY19gHDupY+DbMJHiwaMkhKItsRDH8Z5dxtiAYr1mGfSc07gTI=
X-Received: by 2002:a05:6a21:6011:b0:1f5:535c:82d6 with SMTP id
 adf61e73a8af0-21bad0fb4f1mr17015336637.35.1748900391633; Mon, 02 Jun 2025
 14:39:51 -0700 (PDT)
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
 <CAM0EoMnCHu5HrNjE-mf8_OFanrptcTFgaEPJbkWXJybhm8f8tw@mail.gmail.com> <CAM0EoMk--+xXTf9ZG9M=r+gkRn2hczjqSTJRMV0dcgouJ4zw6g@mail.gmail.com>
In-Reply-To: <CAM0EoMk--+xXTf9ZG9M=r+gkRn2hczjqSTJRMV0dcgouJ4zw6g@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 2 Jun 2025 17:39:40 -0400
X-Gm-Features: AX0GCFsf85-nCxMOqhCmitCCJkVk-wCwWC9vTIxJi1G98lMgKFfruOWAcOdCKhQ
Message-ID: <CAM0EoMk4dxOFoN_=3yOy+XrtU=yvjJXAw3fVTmN9=M=R=vtbxA@mail.gmail.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
To: Savy <savy@syst3mfailure.io>
Cc: William Liu <will@willsroot.io>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 11:38=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Sat, May 31, 2025 at 11:23=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> >
> > On Sat, May 31, 2025 at 9:20=E2=80=AFAM Savy <savy@syst3mfailure.io> wr=
ote:
> > >
> > > On Friday, May 30th, 2025 at 9:41 PM, Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > >
> > > >
> > > > Hi Will,
> > > >
> > > > On Fri, May 30, 2025 at 10:49=E2=80=AFAM William Liu will@willsroot=
.io wrote:
> > > >
> > > > > On Friday, May 30th, 2025 at 2:14 PM, Jamal Hadi Salim jhs@mojata=
tu.com wrote:
> > > > >
> > > > > > On Thu, May 29, 2025 at 11:23=E2=80=AFAM William Liu will@wills=
root.io wrote:
> > > > > >
> > > > > > > On Wednesday, May 28th, 2025 at 10:00 PM, Jamal Hadi Salim jh=
s@mojatatu.com wrote:
> > > > > > >
> > > > > > > > Hi,
> > > > > > > > Sorry for the latency..
> > > > > > > >
> > > > > > > > On Sun, May 25, 2025 at 4:43=E2=80=AFPM William Liu will@wi=
llsroot.io wrote:
> > > > > > > >
> > > > > > > > > I did some more testing with the percpu approach, and we =
realized the following problem caused now by netem_dequeue.
> > > > > > > > >
> > > > > > > > > Recall that we increment the percpu variable on netem_enq=
ueue entry and decrement it on exit. netem_dequeue calls enqueue on the chi=
ld qdisc - if this child qdisc is a netem qdisc with duplication enabled, i=
t could duplicate a previously duplicated packet from the parent back to th=
e parent, causing the issue again. The percpu variable cannot protect again=
st this case.
> > > > > > > >
> > > > > > > > I didnt follow why "percpu variable cannot protect against =
this case"
> > > > > > > > - the enqueue and dequeue would be running on the same cpu,=
 no?
> > > > > > > > Also under what circumstances is the enqueue back to the ro=
ot going to
> > > > > > > > end up in calling dequeue? Did you test and hit this issue =
or its just
> > > > > > > > theory? Note: It doesnt matter what the source of the skb i=
s as long
> > > > > > > > as it hits the netem enqueue.
> > > > > > >
> > > > > > > Yes, I meant that just using the percpu variable in enqueue w=
ill not protect against the case for when dequeue calls enqueue on the chil=
d. Because of the child netem with duplication enabled, packets already inv=
olved in duplication will get sent back to the parent's tfifo queue, and th=
en the current dequeue will remain stuck in the loop before hitting an OOM =
- refer to the paragraph starting with "In netem_dequeue, the parent netem =
qdisc's t_len" in the first email for additional clarification. We need to =
know whether a packet we dequeue has been involved in duplication - if it h=
as, we increment the percpu variable to inform the children netem qdiscs.
> > > > > > >
> > > > > > > Hopefully the following diagram can help elucidate the proble=
m:
> > > > > > >
> > > > > > > Step 1: Initial enqueue of Packet A:
> > > > > > >
> > > > > > > +----------------------+
> > > > > > > | Packet A |
> > > > > > > +----------------------+
> > > > > > > |
> > > > > > > v
> > > > > > > +-------------------------+
> > > > > > > | netem_enqueue |
> > > > > > > +-------------------------+
> > > > > > > |
> > > > > > > v
> > > > > > > +-----------------------------------+
> > > > > > > | Duplication Logic (percpu OK): |
> > > > > > > | =3D> Packet A, Packet B (dup) |
> > > > > > > +-----------------------------------+
> > > > > > > | <- percpu variable for netem_enqueue
> > > > > > > v prevents duplication of B
> > > > > > > +-------------+
> > > > > > > | tfifo queue |
> > > > > > > | [A, B] |
> > > > > > > +-------------+
> > > > > > >
> > > > > > > Step 2: netem_dequeue processes Packet B (or A)
> > > > > > >
> > > > > > > +-------------+
> > > > > > > | tfifo queue |
> > > > > > > | [A] |
> > > > > > > +-------------+
> > > > > > > |
> > > > > > > v
> > > > > > > +----------------------------------------+
> > > > > > > | netem_dequeue pops B in tfifo_dequeue |
> > > > > > > +----------------------------------------+
> > > > > > > |
> > > > > > > v
> > > > > > > +--------------------------------------------+
> > > > > > > | netem_enqueue to child qdisc (netem w/ dup)|
> > > > > > > +--------------------------------------------+
> > > > > > > | <- percpu variable in netem_enqueue prologue
> > > > > > > | and epilogue does not stop this dup,
> > > > > > > v does not know about previous dup involvement
> > > > > > > +--------------------------------------------------------+
> > > > > > > | Child qdisc duplicates B to root (original netem) as C |
> > > > > > > +--------------------------------------------------------+
> > > > > > > |
> > > > > > > v
> > > > > > >
> > > > > > > Step 3: Packet C enters original root netem again
> > > > > > >
> > > > > > > +-------------------------+
> > > > > > > | netem_enqueue (again) |
> > > > > > > +-------------------------+
> > > > > > > |
> > > > > > > v
> > > > > > > +-------------------------------------+
> > > > > > > | Duplication Logic (percpu OK again) |
> > > > > > > | =3D> Packet C, Packet D |
> > > > > > > +-------------------------------------+
> > > > > > > |
> > > > > > > v
> > > > > > > .....
> > > > > > >
> > > > > > > If you increment a percpu variable in enqueue prologue and de=
crement in enqueue epilogue, you will notice that our original repro will s=
till trigger a loop because of the scenario I pointed out above - this has =
been tested.
> > > > > > >
> > > > > > > From a current view of the codebase, netem is the only qdisc =
that calls enqueue on its child from its dequeue. The check we propose will=
 only work if this invariant remains.
> > > > > > >
> > > > > > > > > However, there is a hack to address this. We can add a fi=
eld in netem_skb_cb called duplicated to track if a packet is involved in d=
uplicated (both the original and duplicated packet should have it marked). =
Right before we call the child enqueue in netem_dequeue, we check for the d=
uplicated value. If it is true, we increment the percpu variable before and=
 decrement it after the child enqueue call.
> > > > > > > >
> > > > > > > > is netem_skb_cb safe really for hierarchies? grep for qdisc=
_skb_cb
> > > > > > > > net/sched/ to see what i mean
> > > > > > >
> > > > > > > We are not using it for cross qdisc hierarchy checking. We ar=
e only using it to inform a netem dequeue whether the packet has partaken i=
n duplication from its corresponding netem enqueue. That part seems to be p=
rivate data for the sk_buff residing in the current qdisc, so my understand=
ing is that it's ok.
> > > > > > >
> > > > > > > > > This only works under the assumption that there aren't ot=
her qdiscs that call enqueue on their child during dequeue, which seems to =
be the case for now. And honestly, this is quite a fragile fix - there migh=
t be other edge cases that will cause problems later down the line.
> > > > > > > > >
> > > > > > > > > Are you aware of other more elegant approaches we can try=
 for us to track this required cross-qdisc state? We suggested adding a sin=
gle bit to the skb, but we also see the problem with adding a field for a o=
ne-off use case to such a vital structure (but this would also completely s=
tomp out this bug).
> > > > > > > >
> > > > > > > > It sounds like quite a complicated approach - i dont know w=
hat the
> > > > > > > > dequeue thing brings to the table; and if we really have to=
 dequeue to
> > > > > > >
> > > > > > > Did what I say above help clarify what the problem is? Feel f=
ree to let me know if you have more questions, this bug is quite a nasty on=
e.
> > > > > >
> > > > > > The text helped a bit, but send a tc reproducer of the issue yo=
u
> > > > > > described to help me understand better how you end up in the tf=
ifo
> > > > > > which then calls the enqueu, etc, etc.
> > > > >
> > > > > The reproducer is the same as the original reproducer we reported=
:
> > > > > tc qdisc add dev lo root handle 1: netem limit 1 duplicate 100%
> > > > > tc qdisc add dev lo parent 1: handle 2: netem gap 1 limit 1 dupli=
cate 100% delay 1us reorder 100%
> > > > > ping -I lo -f -c1 -s48 -W0.001 127.0.0.1
> > > > >
> > > > > We walked through the issue in the codepath in the first email of=
 this thread at the paragraph starting with "The root cause for this is com=
plex. Because of the way we setup the parent qdisc" - please let me know if=
 any additional clarification is needed for any part of it.
> > > >
> > > >
> > > > Ok, so I tested both your approach and a slight modification of the
> > > > variant I sent you. They both fix the issue. TBH, I still find your
> > > > approach complex. While i hate to do this to you, my preference is
> > > > that you use the attached version - i dont need the credit, so just
> > > > send it formally after testing.
> > > >
> > > > cheers,
> > > > jamal
> > >
> > > Hi Jamal,
> > >
> > > Thank you for your patch. Unfortunately, there is an issue that Will =
and I
> > > also encountered when we submitted the first version of our patch.
> > >
> > > With this check:
> > >
> > >         if (unlikely(nest_level > 1)) {
> > >                 net_warn_ratelimited("Exceeded netem recursion %d > 1=
 on dev %s\n",
> > >                                      nest_level, netdev_name(skb->dev=
));
> > >                 // ...
> > >         }
> > >
> > > when netem_enqueue is called, we have:
> > >
> > >         netem_enqueue()
> > >                 // nest_level is incremented to 1
> > >                 // q->duplicate is 100% (0xFFFFFFFF)
> > >                 // skb2 =3D skb_clone()
> > >                 // rootq->enqueue(skb2, ...)
> > >                 netem_enqueue()
> > >                         // nest_level is incremented to 2
> > >                         // nest_level now is > 1
> > >                         // The duplicate is dropped
> > >
> > > Basically, with this approach, all duplicates are automatically dropp=
ed.
> > >
> > > If we modify the check by replacing 1 with 2:
> > >
> > >         if (unlikely(nest_level > 2)) {
> > >                 net_warn_ratelimited("Exceeded netem recursion %d > 1=
 on dev %s\n",
> > >                                      nest_level, netdev_name(skb->dev=
));
> > >                 // ...
> > >         }
> > >
> > > the infinite loop is triggered again (this has been tested and also v=
erified in GDB).
> > >
> > > This is why we proposed an alternative approach, but I understand it =
is more complex.
> > > Maybe we can try to work on that and make it more elegant.
> > >
> >
> > I am not sure.
> > It is a choice between complexity to "fix" something that is a bad
> > configuration, i.e one that should not be allowed to begin with, vs
> > not burdening the rest.
> > IOW, if you created a single loop(like the original report) the
> > duplicate packet will go through but subsequent ones will not). If you
> > created a loop inside a loop(as you did here), does anyone really care
> > about the duplicate in each loop not making it through? It would be
> > fine to "fix it" so you get duplicates in each loop if there was
> > actually a legitimate use case. Remember one of the original choices
> > was to disallow the config ...
> >
>
> Actually I think i misunderstood you. You are saying it breaks even
> the working case for duplication.
> Let me think about it..

After some thought and experimentation - I believe the only way to fix
this so nobody comes back in the future with loops is to disallow the
netem on top of netem setup. The cb approach can be circumvented by
zeroing the cb at the root.

cheers,
jamal

