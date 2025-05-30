Return-Path: <netdev+bounces-194370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CCCAC9149
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 16:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4FCA205DF
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 14:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF0F22ACD1;
	Fri, 30 May 2025 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="SELhWJ2T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30790219A70
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748614452; cv=none; b=CXgNcjSS8CD40MnSXPaN6VU9td0UjJbv2AHdKgbWlVzV70vQBivX5UgjbeSr1fe3Fs+jd4cLBcnnrEFwQ+5d6bWD/z/Odv0jrk3l6OynMuQuLy4N0F/xyIJvniRuHNDKI54BfgjDblbrUxeDeD438t7uXAxL3g8RTeHxDzggCe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748614452; c=relaxed/simple;
	bh=RCSmOz6XY4aungb99Z3P324ymwDZUfWL9DiXCo8QTCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGa6b7mTvpWizO0RUtjyG1r/7t71s5uytd2qIgzvPq1DGfdaufJAGq8tRAxMzUy7tvFhjsuXsh5uOVXU4jjlvXk45R5OUI2m4xjmrv3GJ1jGA7iHLINo1ov9UxOJ1yaADTVCHBc2VJ5Pz86bHHvpzSsRIfFRttApHiQc7792fms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=SELhWJ2T; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7398d65476eso1514078b3a.1
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 07:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1748614449; x=1749219249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01yP4erw9BznWzN1Kp36axN+Cy+MbQkWnzs+vb6KWtM=;
        b=SELhWJ2TAG+REeAXJL9QpDsR8lrzC5qdG2+RMdK0sZEM6jid1WsApT7z/f/TTwMnsY
         6iwDdiZp11wWRdUYVjiQgvnVK3m6ACv3dcHP9gLwEHPX1n5NhuT6nipGWLQ9jsKXXRRj
         j6afqeYYHVVr/7foshiJgKFImX+nVhq3f7jOqTMT7FFAPQF1athKGQr/Mtob8haJqJV+
         jLQslR275kFO2iImx4GBkJhVBs9e9k5w6N7t2bNi5h47i047bNtBuuCCPhWogbs3HDAg
         8FAfbEEqdyjkKUEucaMNv/LzIq/GbLIwzBBuOe7gV2t9xV47oNHve3o6aRiul1pFurNX
         iMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748614449; x=1749219249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01yP4erw9BznWzN1Kp36axN+Cy+MbQkWnzs+vb6KWtM=;
        b=Bxbrh9aex1DaNwZXdnxbskE79mKIL5SLJIF7e81SelA738TbakeN+LsUsM9J+I2qgU
         Qg8lTChjim0m2NtWsEqf1voUc7xsqjUGV/J+gSw0Gt+KL1/NErC0JVsDjDIzUTZUsxYK
         Pkys31EOP0BrT47znbfxglNB0UAbsIiaK6F6sRJsr7xYaJstruB1I1NVf/YqW5zDVEMH
         DkXYw8VVRuGQVMIH+Z3CXL5xiCasFyaSCEDRMXvEidjNSO0t3auGIpTx1O/KmBBci00t
         J1L1+Uln1rw5UA8R+T/C3Ro9E4lwA+zEzyuvc9ToZ30YEnAX1ue/ZM9pVZ5p9bJRsKgz
         FeDA==
X-Gm-Message-State: AOJu0YyH20/0+WVxJe8S43zWE1MS8KPjKbtBd3EDzNdhVGOxTsduTrAE
	qSnDiD6zvYzrH1Bs/WypU1yAexaYdOzjZ1dsfRAWHdoaa85CqOm6aSgwP7sWq7AC+oN8B87vbSc
	/jSjQOWCCf110V1rzjcA192ZMwoANDuM8dBILgwX7
X-Gm-Gg: ASbGncv30bPUoijQE7rcW+fusNjv+v8/OwTjXZ025krvxcQQXgpfToqvZUVgL+KtBqs
	5qGXPEfSaPGJXjqFEyHn/FicqjH9Qj7kSQTBrmVXHouVi5qUz/c7tPVlrPEZrAZvwi6C3KJijaA
	ReX6Eq5L4BeIzmJ86K+UMa0j/2IejKW4W9S6xRK7vvGQ==
X-Google-Smtp-Source: AGHT+IGj4XrgKCxytO8kRchT9S3wwMzYemtc7IDRUd+KktyZrYjKV5u58yCIRKB87bEy8EY37OwbR00Q83U+34erFWo=
X-Received: by 2002:a05:6a00:c95:b0:73d:f9d2:9c64 with SMTP id
 d2e1a72fcca58-747bdda14bfmr4423475b3a.10.1748614449088; Fri, 30 May 2025
 07:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io>
 <CAM0EoMkd87-6ZJ5PWsV8K+Pn+dVNEOP9NcfGAjXVrzAH70F4YA@mail.gmail.com>
 <Ppi6ol0VaHrqJs9Rp0-SGp0J1Y0K8hki_jbNZ8sjNOmtEq0mD4f0IozBxxX-m4535QPJonGFYmiPmB643yd4SOpd1HDDYyMeGQuASuFHl-E=@willsroot.io>
 <CAM0EoM==m_f3_DNgSEKODQzHgE_zyRpXKweNGw1mxz-e3u6+Hg@mail.gmail.com>
 <8fcsX7qgyK6tCGCqfi8RN7a-hMGfmh0K2wOpqXayxNM0lKgbjttNfpYkZHA29D0SN5WJ5h3-auiaClAq1nGw5BulC8wOzfa_lqR4bx73phM=@willsroot.io>
 <CAM0EoMkO0vZ4ZtODLJEBP5FiA0+ofVNOSf-BxCOGOyWAZDHdTg@mail.gmail.com>
 <FiSC_W4LweZiirPYQVe8p7CvUePHrufeDOQgkDT07zh-uy5s6eah-a8Vtr_lPrW73PAF51p6PPIrJITwrJ5vspk99wI5uZELnJijU5ILMUQ=@willsroot.io>
 <q7G0Z7oMR2x9TWwNHOiPNsZ8lHzAuXuVgrZgGmAgkH8lkIYyTgeqXwcDrelE_fdS9OdJ4TlfS96px6O9SvnmKigNKFkiaFlStvAGPIJ3b84=@willsroot.io>
 <CAM0EoMnmpjGVU2XyrH=p=-BY6JGU44qsqyfEik4g5E2M8rMMOQ@mail.gmail.com> <DISZZlS5CdbUKITzkIyT3jki3inTWSMecT6FplNmkpYs9bJizbs0iwRbTGMrnqEXrL3-__IjOQxdULPdZwGdKFSXJ1DZYIj6xmWPBZxerdk=@willsroot.io>
In-Reply-To: <DISZZlS5CdbUKITzkIyT3jki3inTWSMecT6FplNmkpYs9bJizbs0iwRbTGMrnqEXrL3-__IjOQxdULPdZwGdKFSXJ1DZYIj6xmWPBZxerdk=@willsroot.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 30 May 2025 10:13:57 -0400
X-Gm-Features: AX0GCFvwAedY74JLi0vyCY3Lx5hmIerzEg4R_8Mvk0YlwAN-dqU30Zpvw1cOtEg
Message-ID: <CAM0EoMke7ar8O=aJeZy7_XYMGbgES-X2B19R83Qcihxv4OeG8g@mail.gmail.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
To: William Liu <will@willsroot.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Savy <savy@syst3mfailure.io>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 11:23=E2=80=AFAM William Liu <will@willsroot.io> wr=
ote:
>
> On Wednesday, May 28th, 2025 at 10:00 PM, Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
>
> >
> >
> > Hi,
> > Sorry for the latency..
> >
> > On Sun, May 25, 2025 at 4:43=E2=80=AFPM William Liu will@willsroot.io w=
rote:
> >
> > > I did some more testing with the percpu approach, and we realized the=
 following problem caused now by netem_dequeue.
> > >
> > > Recall that we increment the percpu variable on netem_enqueue entry a=
nd decrement it on exit. netem_dequeue calls enqueue on the child qdisc - i=
f this child qdisc is a netem qdisc with duplication enabled, it could dupl=
icate a previously duplicated packet from the parent back to the parent, ca=
using the issue again. The percpu variable cannot protect against this case=
.
> >
> >
> > I didnt follow why "percpu variable cannot protect against this case"
> > - the enqueue and dequeue would be running on the same cpu, no?
> > Also under what circumstances is the enqueue back to the root going to
> > end up in calling dequeue? Did you test and hit this issue or its just
> > theory? Note: It doesnt matter what the source of the skb is as long
> > as it hits the netem enqueue.
>
> Yes, I meant that just using the percpu variable in enqueue will not prot=
ect against the case for when dequeue calls enqueue on the child. Because o=
f the child netem with duplication enabled, packets already involved in dup=
lication will get sent back to the parent's tfifo queue, and then the curre=
nt dequeue will remain stuck in the loop before hitting an OOM - refer to t=
he paragraph starting with "In netem_dequeue, the parent netem qdisc's t_le=
n" in the first email for additional clarification. We need to know whether=
 a packet we dequeue has been involved in duplication - if it has, we incre=
ment the percpu variable to inform the children netem qdiscs.
>
> Hopefully the following diagram can help elucidate the problem:
>
> Step 1: Initial enqueue of Packet A:
>
>     +----------------------+
>     |     Packet A         |
>     +----------------------+
>               |
>               v
>     +-------------------------+
>     |     netem_enqueue       |
>     +-------------------------+
>               |
>               v
>     +-----------------------------------+
>     | Duplication Logic (percpu OK):   |
>     |   =3D> Packet A, Packet B (dup)    |
>     +-----------------------------------+
>               | <- percpu variable for netem_enqueue
>               v    prevents duplication of B
>         +-------------+
>         | tfifo queue |
>         |   [A, B]    |
>         +-------------+
>
> Step 2: netem_dequeue processes Packet B (or A)
>
>         +-------------+
>         | tfifo queue |
>         |   [A]       |
>         +-------------+
>               |
>               v
>     +----------------------------------------+
>     | netem_dequeue pops B in tfifo_dequeue  |
>     +----------------------------------------+
>               |
>               v
>     +--------------------------------------------+
>     | netem_enqueue to child qdisc (netem w/ dup)|
>     +--------------------------------------------+
>               | <- percpu variable in netem_enqueue prologue
>               |    and epilogue does not stop this dup,
>               v    does not know about previous dup involvement
>     +--------------------------------------------------------+
>     | Child qdisc duplicates B to root (original netem) as C |
>     +--------------------------------------------------------+
>               |
>               v
>
> Step 3: Packet C enters original root netem again
>
>     +-------------------------+
>     | netem_enqueue (again)   |
>     +-------------------------+
>               |
>               v
>     +-------------------------------------+
>     | Duplication Logic (percpu OK again) |
>     |   =3D> Packet C, Packet D             |
>     +-------------------------------------+
>               |
>               v
>             .....
>
> If you increment a percpu variable in enqueue prologue and decrement in e=
nqueue epilogue, you will notice that our original repro will still trigger=
 a loop because of the scenario I pointed out above - this has been tested.
>
> From a current view of the codebase, netem is the only qdisc that calls e=
nqueue on its child from its dequeue. The check we propose will only work i=
f this invariant remains.
>
>
> > > However, there is a hack to address this. We can add a field in netem=
_skb_cb called duplicated to track if a packet is involved in duplicated (b=
oth the original and duplicated packet should have it marked). Right before=
 we call the child enqueue in netem_dequeue, we check for the duplicated va=
lue. If it is true, we increment the percpu variable before and decrement i=
t after the child enqueue call.
> >
> >
> > is netem_skb_cb safe really for hierarchies? grep for qdisc_skb_cb
> > net/sched/ to see what i mean
>
> We are not using it for cross qdisc hierarchy checking. We are only using=
 it to inform a netem dequeue whether the packet has partaken in duplicatio=
n from its corresponding netem enqueue. That part seems to be private data =
for the sk_buff residing in the current qdisc, so my understanding is that =
it's ok.
>
> > > This only works under the assumption that there aren't other qdiscs t=
hat call enqueue on their child during dequeue, which seems to be the case =
for now. And honestly, this is quite a fragile fix - there might be other e=
dge cases that will cause problems later down the line.
> > >
> > > Are you aware of other more elegant approaches we can try for us to t=
rack this required cross-qdisc state? We suggested adding a single bit to t=
he skb, but we also see the problem with adding a field for a one-off use c=
ase to such a vital structure (but this would also completely stomp out thi=
s bug).
> >
> >
> > It sounds like quite a complicated approach - i dont know what the
> > dequeue thing brings to the table; and if we really have to dequeue to
>
> Did what I say above help clarify what the problem is? Feel free to let m=
e know if you have more questions, this bug is quite a nasty one.
>

The text helped a bit, but send a tc reproducer of the issue you
described to help me understand better how you end up in the tfifo
which then calls the enqueu, etc, etc.

cheers,
jamal

