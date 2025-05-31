Return-Path: <netdev+bounces-194507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7939AC9B7B
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 17:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70A867A1D3E
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 15:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F00D23C8AA;
	Sat, 31 May 2025 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="zJvjNtDN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337C02D600
	for <netdev@vger.kernel.org>; Sat, 31 May 2025 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748705027; cv=none; b=qf+Q+IcHFCIYVk1wzrkOzOuGfVOt7Q4xrEPJrDtMFp8eujDrFzPwbammrOCDAlsREyL8BAPvg3DnwHRRIoqrTlfiT/4Z7iQWLGsEeykCLsKKMhzw8bphR6rOSeETSDGsaD8k9a8IVpHOGDJSJcXmgG2ZYXFD84kQhvHh7nNOO8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748705027; c=relaxed/simple;
	bh=t40Lvftm8YGv9osiJ7P0AFqii2+uEXez4/TRhp0wkVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTKcPfFU0ntbexvmjaPAmnycvaCi3nsW9eCDXCHafNwQTSeyV5nhcRzUi+JC8HyQRbogRQjn859WfHvkXaJtkWkPcP9NSYaXGupAU9o3zb6HtFTIS1OoKJK+YdXiJRfQtrtXRam55itKCaCxQu20BMPxRiEtBNsa8RBbZyHOjws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=zJvjNtDN; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so2383605b3a.1
        for <netdev@vger.kernel.org>; Sat, 31 May 2025 08:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1748705024; x=1749309824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngrX88mzWKby9pTC+UORNPGtrzojk+17EDA+UP37iPk=;
        b=zJvjNtDNu3rNKcsNqbdzstMnZKJqaonrozfxeLK0QTp32DzQ6r9+2atRopjrMiJwnA
         ElZe+BsLjpzPtcRO+f+gHQLkXEXwH5jT56vssGyTRBalC4KDra5iwwX1bGCAdna+Ycpi
         sklgUFi5o/Paimdv3z9UXktwmeYiNUw5+rMwm152Y70I3jX1VSkXIUms06BVxr4I90Fh
         O5Qtvv5TO2BBk0ujCeniucmW4fCgQARzXrTabkBa+V3yCmeAwaaqzlqWKLV3mIhpMST2
         qn3ev2DSCFTPx2Huz/D5B98v0Youge/yuf8hZc0xsAYedVLk9mtMA2vFfvD/BWc/cAtq
         BvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748705024; x=1749309824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngrX88mzWKby9pTC+UORNPGtrzojk+17EDA+UP37iPk=;
        b=Lb+d8Jv2gPPCk/eO1sn87ZA3DZjK+pJE1mOEgkgexZdGQxa4PKm/e0PggwS39istLe
         74FBW+Y1B/ESmh8wUHTvhZUr1TqRVrHbfmp/E9K7Idmrv3GkUnLgSCDM/zBb1M3ONusn
         GBlH1/Vbg4snBX6Wz5xJo5kBNxypuyxxCvbGLEyWjHzc5oYWayCeyzDneZ+4GVMfEyJh
         4r7SOSVXgmnGzh0SuIHe2Kix4ixXPYNM7Dtk7s+cftc/qeQTXFWXY5oJHHGjcYD8MSzy
         ZxspMaRfJdyZb6y+VWHx/RKImLEfz0kBkk7tQGtJc+oxvvZrmNVhwSMyt9vBLzYXRg30
         8UOw==
X-Forwarded-Encrypted: i=1; AJvYcCUhRBr1HeqryFwH2o3CZKfoeUgv7mK400i2j34c+BslVQmxsPdyuVSlRzawnl7hUjj+Twde6+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1O8oDN8f3dxLNdGU+lY61roxAIfHY3IiyM1LbmHyRVIpVSdQu
	FEAK9Vcq6wrkjdd5Zs2QTEQneZjOHJ5DONno3T6NCHl4CaJ0YflybBtMFbytTGtHyP3nWvC5FzQ
	+1Okqt8O4nnmRI8w3sufJEcO4cERcHzGmvefY2rY0
X-Gm-Gg: ASbGncsxCIHOPxLEKxxJfaZQpuMyX5HOxN+taLPJ4WjehPWK2LpZWJaMGhCWlI1p/si
	w4aJf3DneJECiOeltrCHQwHbAsusMfzkmfK1W+oR0rzhaXJ0O9bZ2V+UbY1mnp/mTlas/h/Pvs0
	G1F8csPDwOBkl8Wir6kjrKb1bzbNsHCWc=
X-Google-Smtp-Source: AGHT+IHqXsUy1bQi1r13j7ww5Saig/+nQYO/djY2iKdl6v8g0rZqg7zABOJogBTtNUS0e4lZbJDZtJC4vjg5wpYIW4o=
X-Received: by 2002:a05:6a00:2349:b0:742:3cc1:9485 with SMTP id
 d2e1a72fcca58-747d18a55cfmr3482372b3a.12.1748705024362; Sat, 31 May 2025
 08:23:44 -0700 (PDT)
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
 <CAM0EoMmns+rSyg4h-WGAMewqYWx0-MYC1DtRyJe4=rbgZN2UKQ@mail.gmail.com> <99X_9_r0DXyyKP-0xVz3Bg2FFXhmpCsIdTix8J-a52alNswEyVRbhMFnzyT35EOUP-8TVPL-UDvBbOd8u5_jRE10A98e_ULf5x6GTv03tbg=@syst3mfailure.io>
In-Reply-To: <99X_9_r0DXyyKP-0xVz3Bg2FFXhmpCsIdTix8J-a52alNswEyVRbhMFnzyT35EOUP-8TVPL-UDvBbOd8u5_jRE10A98e_ULf5x6GTv03tbg=@syst3mfailure.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 31 May 2025 11:23:33 -0400
X-Gm-Features: AX0GCFuecXHpaumN8f_BJ_Z4vgmBBibQM_H-PMIBvZDv9lSYqBE5M1Eofo_vFO4
Message-ID: <CAM0EoMnCHu5HrNjE-mf8_OFanrptcTFgaEPJbkWXJybhm8f8tw@mail.gmail.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
To: Savy <savy@syst3mfailure.io>
Cc: William Liu <will@willsroot.io>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 9:20=E2=80=AFAM Savy <savy@syst3mfailure.io> wrote:
>
> On Friday, May 30th, 2025 at 9:41 PM, Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> >
> >
> > Hi Will,
> >
> > On Fri, May 30, 2025 at 10:49=E2=80=AFAM William Liu will@willsroot.io =
wrote:
> >
> > > On Friday, May 30th, 2025 at 2:14 PM, Jamal Hadi Salim jhs@mojatatu.c=
om wrote:
> > >
> > > > On Thu, May 29, 2025 at 11:23=E2=80=AFAM William Liu will@willsroot=
.io wrote:
> > > >
> > > > > On Wednesday, May 28th, 2025 at 10:00 PM, Jamal Hadi Salim jhs@mo=
jatatu.com wrote:
> > > > >
> > > > > > Hi,
> > > > > > Sorry for the latency..
> > > > > >
> > > > > > On Sun, May 25, 2025 at 4:43=E2=80=AFPM William Liu will@willsr=
oot.io wrote:
> > > > > >
> > > > > > > I did some more testing with the percpu approach, and we real=
ized the following problem caused now by netem_dequeue.
> > > > > > >
> > > > > > > Recall that we increment the percpu variable on netem_enqueue=
 entry and decrement it on exit. netem_dequeue calls enqueue on the child q=
disc - if this child qdisc is a netem qdisc with duplication enabled, it co=
uld duplicate a previously duplicated packet from the parent back to the pa=
rent, causing the issue again. The percpu variable cannot protect against t=
his case.
> > > > > >
> > > > > > I didnt follow why "percpu variable cannot protect against this=
 case"
> > > > > > - the enqueue and dequeue would be running on the same cpu, no?
> > > > > > Also under what circumstances is the enqueue back to the root g=
oing to
> > > > > > end up in calling dequeue? Did you test and hit this issue or i=
ts just
> > > > > > theory? Note: It doesnt matter what the source of the skb is as=
 long
> > > > > > as it hits the netem enqueue.
> > > > >
> > > > > Yes, I meant that just using the percpu variable in enqueue will =
not protect against the case for when dequeue calls enqueue on the child. B=
ecause of the child netem with duplication enabled, packets already involve=
d in duplication will get sent back to the parent's tfifo queue, and then t=
he current dequeue will remain stuck in the loop before hitting an OOM - re=
fer to the paragraph starting with "In netem_dequeue, the parent netem qdis=
c's t_len" in the first email for additional clarification. We need to know=
 whether a packet we dequeue has been involved in duplication - if it has, =
we increment the percpu variable to inform the children netem qdiscs.
> > > > >
> > > > > Hopefully the following diagram can help elucidate the problem:
> > > > >
> > > > > Step 1: Initial enqueue of Packet A:
> > > > >
> > > > > +----------------------+
> > > > > | Packet A |
> > > > > +----------------------+
> > > > > |
> > > > > v
> > > > > +-------------------------+
> > > > > | netem_enqueue |
> > > > > +-------------------------+
> > > > > |
> > > > > v
> > > > > +-----------------------------------+
> > > > > | Duplication Logic (percpu OK): |
> > > > > | =3D> Packet A, Packet B (dup) |
> > > > > +-----------------------------------+
> > > > > | <- percpu variable for netem_enqueue
> > > > > v prevents duplication of B
> > > > > +-------------+
> > > > > | tfifo queue |
> > > > > | [A, B] |
> > > > > +-------------+
> > > > >
> > > > > Step 2: netem_dequeue processes Packet B (or A)
> > > > >
> > > > > +-------------+
> > > > > | tfifo queue |
> > > > > | [A] |
> > > > > +-------------+
> > > > > |
> > > > > v
> > > > > +----------------------------------------+
> > > > > | netem_dequeue pops B in tfifo_dequeue |
> > > > > +----------------------------------------+
> > > > > |
> > > > > v
> > > > > +--------------------------------------------+
> > > > > | netem_enqueue to child qdisc (netem w/ dup)|
> > > > > +--------------------------------------------+
> > > > > | <- percpu variable in netem_enqueue prologue
> > > > > | and epilogue does not stop this dup,
> > > > > v does not know about previous dup involvement
> > > > > +--------------------------------------------------------+
> > > > > | Child qdisc duplicates B to root (original netem) as C |
> > > > > +--------------------------------------------------------+
> > > > > |
> > > > > v
> > > > >
> > > > > Step 3: Packet C enters original root netem again
> > > > >
> > > > > +-------------------------+
> > > > > | netem_enqueue (again) |
> > > > > +-------------------------+
> > > > > |
> > > > > v
> > > > > +-------------------------------------+
> > > > > | Duplication Logic (percpu OK again) |
> > > > > | =3D> Packet C, Packet D |
> > > > > +-------------------------------------+
> > > > > |
> > > > > v
> > > > > .....
> > > > >
> > > > > If you increment a percpu variable in enqueue prologue and decrem=
ent in enqueue epilogue, you will notice that our original repro will still=
 trigger a loop because of the scenario I pointed out above - this has been=
 tested.
> > > > >
> > > > > From a current view of the codebase, netem is the only qdisc that=
 calls enqueue on its child from its dequeue. The check we propose will onl=
y work if this invariant remains.
> > > > >
> > > > > > > However, there is a hack to address this. We can add a field =
in netem_skb_cb called duplicated to track if a packet is involved in dupli=
cated (both the original and duplicated packet should have it marked). Righ=
t before we call the child enqueue in netem_dequeue, we check for the dupli=
cated value. If it is true, we increment the percpu variable before and dec=
rement it after the child enqueue call.
> > > > > >
> > > > > > is netem_skb_cb safe really for hierarchies? grep for qdisc_skb=
_cb
> > > > > > net/sched/ to see what i mean
> > > > >
> > > > > We are not using it for cross qdisc hierarchy checking. We are on=
ly using it to inform a netem dequeue whether the packet has partaken in du=
plication from its corresponding netem enqueue. That part seems to be priva=
te data for the sk_buff residing in the current qdisc, so my understanding =
is that it's ok.
> > > > >
> > > > > > > This only works under the assumption that there aren't other =
qdiscs that call enqueue on their child during dequeue, which seems to be t=
he case for now. And honestly, this is quite a fragile fix - there might be=
 other edge cases that will cause problems later down the line.
> > > > > > >
> > > > > > > Are you aware of other more elegant approaches we can try for=
 us to track this required cross-qdisc state? We suggested adding a single =
bit to the skb, but we also see the problem with adding a field for a one-o=
ff use case to such a vital structure (but this would also completely stomp=
 out this bug).
> > > > > >
> > > > > > It sounds like quite a complicated approach - i dont know what =
the
> > > > > > dequeue thing brings to the table; and if we really have to deq=
ueue to
> > > > >
> > > > > Did what I say above help clarify what the problem is? Feel free =
to let me know if you have more questions, this bug is quite a nasty one.
> > > >
> > > > The text helped a bit, but send a tc reproducer of the issue you
> > > > described to help me understand better how you end up in the tfifo
> > > > which then calls the enqueu, etc, etc.
> > >
> > > The reproducer is the same as the original reproducer we reported:
> > > tc qdisc add dev lo root handle 1: netem limit 1 duplicate 100%
> > > tc qdisc add dev lo parent 1: handle 2: netem gap 1 limit 1 duplicate=
 100% delay 1us reorder 100%
> > > ping -I lo -f -c1 -s48 -W0.001 127.0.0.1
> > >
> > > We walked through the issue in the codepath in the first email of thi=
s thread at the paragraph starting with "The root cause for this is complex=
. Because of the way we setup the parent qdisc" - please let me know if any=
 additional clarification is needed for any part of it.
> >
> >
> > Ok, so I tested both your approach and a slight modification of the
> > variant I sent you. They both fix the issue. TBH, I still find your
> > approach complex. While i hate to do this to you, my preference is
> > that you use the attached version - i dont need the credit, so just
> > send it formally after testing.
> >
> > cheers,
> > jamal
>
> Hi Jamal,
>
> Thank you for your patch. Unfortunately, there is an issue that Will and =
I
> also encountered when we submitted the first version of our patch.
>
> With this check:
>
>         if (unlikely(nest_level > 1)) {
>                 net_warn_ratelimited("Exceeded netem recursion %d > 1 on =
dev %s\n",
>                                      nest_level, netdev_name(skb->dev));
>                 // ...
>         }
>
> when netem_enqueue is called, we have:
>
>         netem_enqueue()
>                 // nest_level is incremented to 1
>                 // q->duplicate is 100% (0xFFFFFFFF)
>                 // skb2 =3D skb_clone()
>                 // rootq->enqueue(skb2, ...)
>                 netem_enqueue()
>                         // nest_level is incremented to 2
>                         // nest_level now is > 1
>                         // The duplicate is dropped
>
> Basically, with this approach, all duplicates are automatically dropped.
>
> If we modify the check by replacing 1 with 2:
>
>         if (unlikely(nest_level > 2)) {
>                 net_warn_ratelimited("Exceeded netem recursion %d > 1 on =
dev %s\n",
>                                      nest_level, netdev_name(skb->dev));
>                 // ...
>         }
>
> the infinite loop is triggered again (this has been tested and also verif=
ied in GDB).
>
> This is why we proposed an alternative approach, but I understand it is m=
ore complex.
> Maybe we can try to work on that and make it more elegant.
>

I am not sure.
It is a choice between complexity to "fix" something that is a bad
configuration, i.e one that should not be allowed to begin with, vs
not burdening the rest.
IOW, if you created a single loop(like the original report) the
duplicate packet will go through but subsequent ones will not). If you
created a loop inside a loop(as you did here), does anyone really care
about the duplicate in each loop not making it through? It would be
fine to "fix it" so you get duplicates in each loop if there was
actually a legitimate use case. Remember one of the original choices
was to disallow the config ...

cheers,
jamal

