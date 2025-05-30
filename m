Return-Path: <netdev+bounces-194444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B542AC9741
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 23:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326F89E3C75
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 21:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8BD28B514;
	Fri, 30 May 2025 21:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="fQFWLOYq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A23428A700
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 21:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748641266; cv=none; b=FUiesSi4vn3KU0UkWCUo5LgIy/oRNzLOfiZUtLmw6sEOWkLSKxMM5mlFSLEr9V/oqVCNTsXArfC/UQWWTG1AR4zKKn+8TEeM9Z83ck30/OIQDUI9YCcrli02GQTSfjwy8URRmfDSO5EC5w2CSAK7EsIpyGjLVXNUfTfKxuZZR8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748641266; c=relaxed/simple;
	bh=ozHE81qJj1rmIelhRBQ5DRKURWfmzq6zSFDX7IJB5xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqKXvCPIGlzCNBGqoRBFPD2DSxeKEZowusK1C5qXkxgiIAbpTc05H6c5DftQcTHtr82cygCxDJnZwb+ELTVPxhaT+zjWvVfIn3ePr4DK97LHYkr0JdxAGQoNy6/nFzpSSUDmhYn3FC96ntUbeiaKpOUeFBnaqI46G7g3qUIbq8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=fQFWLOYq; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742b0840d98so1780415b3a.1
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 14:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1748641263; x=1749246063; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ozHE81qJj1rmIelhRBQ5DRKURWfmzq6zSFDX7IJB5xc=;
        b=fQFWLOYqeMAndg/yw/H4fMQb5Di+KpCllNjCePFWP6z4tll0mzW0qlp7XPPpAqW8O4
         kW/tuL1Oe3II7pAWplAdMRg45+WTFM6tH/QyVoJX9+18tPaO1nGgBhrx/MhK/mJhRHQK
         V/mSb0iWDu9VbQFe4pYDaoaNmGyLJq+lKY2VwlifEsTHcwUE1U9JIYkePeA55I+FFrD2
         mjWAxooHXtE4kuw9yrHuKlODL//Vww9SB3FrUp2+y1vZVnjTs3yT2ZW35Wu+MUCf4YW3
         Unl4CNsErMdsguHPyi6vepzCSMA7RtHey6viPx40L/b6dXkWSRDhfHH6JIumFDuvBpqK
         s3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748641263; x=1749246063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ozHE81qJj1rmIelhRBQ5DRKURWfmzq6zSFDX7IJB5xc=;
        b=faJH6PyLFYWFOXWIGgQnFpo2/8i3iGiP3vOhZR6mn2uiO612kG2nq0l/A57xtbrdEf
         UQTnxIjVsh4t06EYePXDrB1g8D22S9rivGZftNYFDnaLaPCTEMuXGdm3qxrLM8AqB44u
         Ke7UndiR+rM6eBXZqNwfsHb65x6luXTYdagKkGXCfiDkU3azDquoka/pjxAkZDyp63z7
         xab65hwXrBDt8JsoB1Xb5nyvrbe3FP/jXsC3MVSUs1UK+MkP8t475G38e6RlEACKalzf
         pCL9g69TBRnJCSocafWR0eEM4Wr54Mwjs9YGUsg2nWZ1wbRxGgQ9rS4r92fb9lx+83Qq
         Btiw==
X-Gm-Message-State: AOJu0YzvMLJE2BcW3XSRoohGlSZM+X56d/YHulLzSVqo1Ceqgz3aKBV3
	HDFBjbfEXp8sj4FYyNDZc7SaeFhlzCgjnMHLsMbPKzh7fWZaUQnaSuR+4eYhWwplAS923S+i77F
	Mw4auuWtMpHZTUxWmweqgacNoWvxh1JI01SMk1eq/
X-Gm-Gg: ASbGnctzoDcJ+IhzVopw3dvxvSFDOnw6JyXubBmOPlm4+AL3iw57zwrVdOpAqHEU4GL
	ERnapd3fQuZXF7o5OkfQlGyOLEFZm0Ia3z3T0vORJrwdExW363wE8vOjrdzRJLw0bEz/Xw8L7CY
	xbAnzPHS0xCcF2VXmMnTq2zwJtTs6nFwA=
X-Google-Smtp-Source: AGHT+IH/JSqdKYAmCarpHIh3eJPKxGTR0CrjI6YJ1HA1riERLWst73jdOFOJVYBajKmZgQh6mmcoFogQkVdQr1ihxUo=
X-Received: by 2002:a05:6a00:2305:b0:736:34ca:deee with SMTP id
 d2e1a72fcca58-747c1a83b48mr5024033b3a.7.1748641263280; Fri, 30 May 2025
 14:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io>
 <CAM0EoM==m_f3_DNgSEKODQzHgE_zyRpXKweNGw1mxz-e3u6+Hg@mail.gmail.com>
 <8fcsX7qgyK6tCGCqfi8RN7a-hMGfmh0K2wOpqXayxNM0lKgbjttNfpYkZHA29D0SN5WJ5h3-auiaClAq1nGw5BulC8wOzfa_lqR4bx73phM=@willsroot.io>
 <CAM0EoMkO0vZ4ZtODLJEBP5FiA0+ofVNOSf-BxCOGOyWAZDHdTg@mail.gmail.com>
 <FiSC_W4LweZiirPYQVe8p7CvUePHrufeDOQgkDT07zh-uy5s6eah-a8Vtr_lPrW73PAF51p6PPIrJITwrJ5vspk99wI5uZELnJijU5ILMUQ=@willsroot.io>
 <q7G0Z7oMR2x9TWwNHOiPNsZ8lHzAuXuVgrZgGmAgkH8lkIYyTgeqXwcDrelE_fdS9OdJ4TlfS96px6O9SvnmKigNKFkiaFlStvAGPIJ3b84=@willsroot.io>
 <CAM0EoMnmpjGVU2XyrH=p=-BY6JGU44qsqyfEik4g5E2M8rMMOQ@mail.gmail.com>
 <DISZZlS5CdbUKITzkIyT3jki3inTWSMecT6FplNmkpYs9bJizbs0iwRbTGMrnqEXrL3-__IjOQxdULPdZwGdKFSXJ1DZYIj6xmWPBZxerdk=@willsroot.io>
 <CAM0EoMke7ar8O=aJeZy7_XYMGbgES-X2B19R83Qcihxv4OeG8g@mail.gmail.com> <0x7zdcWIGm0NWid6NxFLpYOtO0Z1g6UCzrNnyVZ6hRvWr5rU6b6hi5Yz8dD7_dyUOmvJfkR8LV2_TrDf7uACFgGshyfxiRWgxjWer41EZVY=@willsroot.io>
In-Reply-To: <0x7zdcWIGm0NWid6NxFLpYOtO0Z1g6UCzrNnyVZ6hRvWr5rU6b6hi5Yz8dD7_dyUOmvJfkR8LV2_TrDf7uACFgGshyfxiRWgxjWer41EZVY=@willsroot.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 30 May 2025 17:40:51 -0400
X-Gm-Features: AX0GCFvgye0Hene8aLX_bWuqJLnb6hwZ6o3-CVBNqLYsfnz-SrgVqv96telw02g
Message-ID: <CAM0EoMmns+rSyg4h-WGAMewqYWx0-MYC1DtRyJe4=rbgZN2UKQ@mail.gmail.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
To: William Liu <will@willsroot.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Savy <savy@syst3mfailure.io>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	Davide Caratti <dcaratti@redhat.com>
Content-Type: multipart/mixed; boundary="0000000000005696de0636614578"

--0000000000005696de0636614578
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Fri, May 30, 2025 at 10:49=E2=80=AFAM William Liu <will@willsroot.io> wr=
ote:
>
> On Friday, May 30th, 2025 at 2:14 PM, Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> >
> >
> > On Thu, May 29, 2025 at 11:23=E2=80=AFAM William Liu will@willsroot.io =
wrote:
> >
> > > On Wednesday, May 28th, 2025 at 10:00 PM, Jamal Hadi Salim jhs@mojata=
tu.com wrote:
> > >
> > > > Hi,
> > > > Sorry for the latency..
> > > >
> > > > On Sun, May 25, 2025 at 4:43=E2=80=AFPM William Liu will@willsroot.=
io wrote:
> > > >
> > > > > I did some more testing with the percpu approach, and we realized=
 the following problem caused now by netem_dequeue.
> > > > >
> > > > > Recall that we increment the percpu variable on netem_enqueue ent=
ry and decrement it on exit. netem_dequeue calls enqueue on the child qdisc=
 - if this child qdisc is a netem qdisc with duplication enabled, it could =
duplicate a previously duplicated packet from the parent back to the parent=
, causing the issue again. The percpu variable cannot protect against this =
case.
> > > >
> > > > I didnt follow why "percpu variable cannot protect against this cas=
e"
> > > > - the enqueue and dequeue would be running on the same cpu, no?
> > > > Also under what circumstances is the enqueue back to the root going=
 to
> > > > end up in calling dequeue? Did you test and hit this issue or its j=
ust
> > > > theory? Note: It doesnt matter what the source of the skb is as lon=
g
> > > > as it hits the netem enqueue.
> > >
> > > Yes, I meant that just using the percpu variable in enqueue will not =
protect against the case for when dequeue calls enqueue on the child. Becau=
se of the child netem with duplication enabled, packets already involved in=
 duplication will get sent back to the parent's tfifo queue, and then the c=
urrent dequeue will remain stuck in the loop before hitting an OOM - refer =
to the paragraph starting with "In netem_dequeue, the parent netem qdisc's =
t_len" in the first email for additional clarification. We need to know whe=
ther a packet we dequeue has been involved in duplication - if it has, we i=
ncrement the percpu variable to inform the children netem qdiscs.
> > >
> > > Hopefully the following diagram can help elucidate the problem:
> > >
> > > Step 1: Initial enqueue of Packet A:
> > >
> > > +----------------------+
> > > | Packet A |
> > > +----------------------+
> > > |
> > > v
> > > +-------------------------+
> > > | netem_enqueue |
> > > +-------------------------+
> > > |
> > > v
> > > +-----------------------------------+
> > > | Duplication Logic (percpu OK): |
> > > | =3D> Packet A, Packet B (dup) |
> > > +-----------------------------------+
> > > | <- percpu variable for netem_enqueue
> > > v prevents duplication of B
> > > +-------------+
> > > | tfifo queue |
> > > | [A, B] |
> > > +-------------+
> > >
> > > Step 2: netem_dequeue processes Packet B (or A)
> > >
> > > +-------------+
> > > | tfifo queue |
> > > | [A] |
> > > +-------------+
> > > |
> > > v
> > > +----------------------------------------+
> > > | netem_dequeue pops B in tfifo_dequeue |
> > > +----------------------------------------+
> > > |
> > > v
> > > +--------------------------------------------+
> > > | netem_enqueue to child qdisc (netem w/ dup)|
> > > +--------------------------------------------+
> > > | <- percpu variable in netem_enqueue prologue
> > > | and epilogue does not stop this dup,
> > > v does not know about previous dup involvement
> > > +--------------------------------------------------------+
> > > | Child qdisc duplicates B to root (original netem) as C |
> > > +--------------------------------------------------------+
> > > |
> > > v
> > >
> > > Step 3: Packet C enters original root netem again
> > >
> > > +-------------------------+
> > > | netem_enqueue (again) |
> > > +-------------------------+
> > > |
> > > v
> > > +-------------------------------------+
> > > | Duplication Logic (percpu OK again) |
> > > | =3D> Packet C, Packet D |
> > > +-------------------------------------+
> > > |
> > > v
> > > .....
> > >
> > > If you increment a percpu variable in enqueue prologue and decrement =
in enqueue epilogue, you will notice that our original repro will still tri=
gger a loop because of the scenario I pointed out above - this has been tes=
ted.
> > >
> > > From a current view of the codebase, netem is the only qdisc that cal=
ls enqueue on its child from its dequeue. The check we propose will only wo=
rk if this invariant remains.
> > >
> > > > > However, there is a hack to address this. We can add a field in n=
etem_skb_cb called duplicated to track if a packet is involved in duplicate=
d (both the original and duplicated packet should have it marked). Right be=
fore we call the child enqueue in netem_dequeue, we check for the duplicate=
d value. If it is true, we increment the percpu variable before and decreme=
nt it after the child enqueue call.
> > > >
> > > > is netem_skb_cb safe really for hierarchies? grep for qdisc_skb_cb
> > > > net/sched/ to see what i mean
> > >
> > > We are not using it for cross qdisc hierarchy checking. We are only u=
sing it to inform a netem dequeue whether the packet has partaken in duplic=
ation from its corresponding netem enqueue. That part seems to be private d=
ata for the sk_buff residing in the current qdisc, so my understanding is t=
hat it's ok.
> > >
> > > > > This only works under the assumption that there aren't other qdis=
cs that call enqueue on their child during dequeue, which seems to be the c=
ase for now. And honestly, this is quite a fragile fix - there might be oth=
er edge cases that will cause problems later down the line.
> > > > >
> > > > > Are you aware of other more elegant approaches we can try for us =
to track this required cross-qdisc state? We suggested adding a single bit =
to the skb, but we also see the problem with adding a field for a one-off u=
se case to such a vital structure (but this would also completely stomp out=
 this bug).
> > > >
> > > > It sounds like quite a complicated approach - i dont know what the
> > > > dequeue thing brings to the table; and if we really have to dequeue=
 to
> > >
> > > Did what I say above help clarify what the problem is? Feel free to l=
et me know if you have more questions, this bug is quite a nasty one.
> >
> >
> > The text helped a bit, but send a tc reproducer of the issue you
> > described to help me understand better how you end up in the tfifo
> > which then calls the enqueu, etc, etc.
>
> The reproducer is the same as the original reproducer we reported:
> tc qdisc add dev lo root handle 1: netem limit 1 duplicate 100%
> tc qdisc add dev lo parent 1: handle 2: netem gap 1 limit 1 duplicate 100=
% delay 1us reorder 100%
> ping -I lo -f -c1 -s48 -W0.001 127.0.0.1
>
> We walked through the issue in the codepath in the first email of this th=
read at the paragraph starting with "The root cause for this is complex. Be=
cause of the way we setup the parent qdisc" - please let me know if any add=
itional clarification is needed for any part of it.
>

Ok, so I tested both your approach and a slight modification of the
variant I sent you. They both fix the issue. TBH, I still find your
approach complex. While i hate to do this to you, my preference is
that you use the attached version - i dont need the credit, so just
send it formally after testing.

cheers,
jamal

--0000000000005696de0636614578
Content-Type: application/octet-stream; name="netem_fix.patchlet"
Content-Disposition: attachment; filename="netem_fix.patchlet"
Content-Transfer-Encoding: base64
Content-ID: <f_mbbbsufp0>
X-Attachment-Id: f_mbbbsufp0

ZGlmZiAtLWdpdCBhL25ldC9zY2hlZC9zY2hfbmV0ZW0uYyBiL25ldC9zY2hlZC9zY2hfbmV0ZW0u
YwppbmRleCBmZGQ3OWQzY2NkOGMuLmU1NWE2OGU1YjY0OSAxMDA2NDQKLS0tIGEvbmV0L3NjaGVk
L3NjaF9uZXRlbS5jCisrKyBiL25ldC9zY2hlZC9zY2hfbmV0ZW0uYwpAQCAtMTY3LDYgKzE2Nyw4
IEBAIHN0cnVjdCBuZXRlbV9za2JfY2IgewogCXU2NAkgICAgICAgIHRpbWVfdG9fc2VuZDsKIH07
CiAKK3N0YXRpYyBERUZJTkVfUEVSX0NQVSh1bnNpZ25lZCBpbnQsIGVucXVldWVfbmVzdF9sZXZl
bCk7CisKIHN0YXRpYyBpbmxpbmUgc3RydWN0IG5ldGVtX3NrYl9jYiAqbmV0ZW1fc2tiX2NiKHN0
cnVjdCBza19idWZmICpza2IpCiB7CiAJLyogd2UgYXNzdW1lIHdlIGNhbiB1c2Ugc2tiIG5leHQv
cHJldi90c3RhbXAgYXMgc3RvcmFnZSBmb3IgcmJfbm9kZSAqLwpAQCAtNDQ4LDYgKzQ1MCw3IEBA
IHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqbmV0ZW1fc2VnbWVudChzdHJ1Y3Qgc2tfYnVmZiAqc2ti
LCBzdHJ1Y3QgUWRpc2MgKnNjaCwKIHN0YXRpYyBpbnQgbmV0ZW1fZW5xdWV1ZShzdHJ1Y3Qgc2tf
YnVmZiAqc2tiLCBzdHJ1Y3QgUWRpc2MgKnNjaCwKIAkJCSBzdHJ1Y3Qgc2tfYnVmZiAqKnRvX2Zy
ZWUpCiB7CisJdW5zaWduZWQgaW50IG5lc3RfbGV2ZWwgPSBfX3RoaXNfY3B1X2luY19yZXR1cm4o
ZW5xdWV1ZV9uZXN0X2xldmVsKTsKIAlzdHJ1Y3QgbmV0ZW1fc2NoZWRfZGF0YSAqcSA9IHFkaXNj
X3ByaXYoc2NoKTsKIAkvKiBXZSBkb24ndCBmaWxsIGNiIG5vdyBhcyBza2JfdW5zaGFyZSgpIG1h
eSBpbnZhbGlkYXRlIGl0ICovCiAJc3RydWN0IG5ldGVtX3NrYl9jYiAqY2I7CkBAIC00NTUsNiAr
NDU4LDE3IEBAIHN0YXRpYyBpbnQgbmV0ZW1fZW5xdWV1ZShzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBz
dHJ1Y3QgUWRpc2MgKnNjaCwKIAlzdHJ1Y3Qgc2tfYnVmZiAqc2VncyA9IE5VTEw7CiAJdW5zaWdu
ZWQgaW50IHByZXZfbGVuID0gcWRpc2NfcGt0X2xlbihza2IpOwogCWludCBjb3VudCA9IDE7CisJ
aW50IHJldHZhbDsKKworCWlmICh1bmxpa2VseShuZXN0X2xldmVsID4gMSkpIHsKKwkJbmV0X3dh
cm5fcmF0ZWxpbWl0ZWQoIkV4Y2VlZGVkIG5ldGVtIHJlY3Vyc2lvbiAlZCA+IDEgb24gZGV2ICVz
XG4iLAorCQkJCSAgICAgbmVzdF9sZXZlbCwgbmV0ZGV2X25hbWUoc2tiLT5kZXYpKTsKKwkJcWRp
c2NfcXN0YXRzX292ZXJsaW1pdChzY2gpOyAvKiBGYWlyIHRvIGFzc3VtZSBvdmVybGltaXQ/PyAq
LworCQlxZGlzY19xc3RhdHNfZHJvcChzY2gpOyAvKiBGYWlyIHRvIGFzc3VtZSBvdmVybGltaXQ/
PyAqLworCQlyZXR2YWwgPSBORVRfWE1JVF9EUk9QOworCQlfX3FkaXNjX2Ryb3Aoc2tiLCB0b19m
cmVlKTsKKwkJZ290byBkZWNfbmVzdF9sZXZlbDsKKwl9CiAKIAkvKiBEbyBub3QgZm9vbCBxZGlz
Y19kcm9wX2FsbCgpICovCiAJc2tiLT5wcmV2ID0gTlVMTDsKQEAgLTQ3Myw3ICs0ODcsOCBAQCBz
dGF0aWMgaW50IG5ldGVtX2VucXVldWUoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IFFkaXNj
ICpzY2gsCiAJaWYgKGNvdW50ID09IDApIHsKIAkJcWRpc2NfcXN0YXRzX2Ryb3Aoc2NoKTsKIAkJ
X19xZGlzY19kcm9wKHNrYiwgdG9fZnJlZSk7Ci0JCXJldHVybiBORVRfWE1JVF9TVUNDRVNTIHwg
X19ORVRfWE1JVF9CWVBBU1M7CisJCXJldHZhbCA9IE5FVF9YTUlUX1NVQ0NFU1MgfCBfX05FVF9Y
TUlUX0JZUEFTUzsKKwkJZ290byBkZWNfbmVzdF9sZXZlbDsKIAl9CiAKIAkvKiBJZiBhIGRlbGF5
IGlzIGV4cGVjdGVkLCBvcnBoYW4gdGhlIHNrYi4gKG9ycGhhbmluZyB1c3VhbGx5IHRha2VzCkBA
IC01MjgsNyArNTQzLDggQEAgc3RhdGljIGludCBuZXRlbV9lbnF1ZXVlKHN0cnVjdCBza19idWZm
ICpza2IsIHN0cnVjdCBRZGlzYyAqc2NoLAogCQlxZGlzY19kcm9wX2FsbChza2IsIHNjaCwgdG9f
ZnJlZSk7CiAJCWlmIChza2IyKQogCQkJX19xZGlzY19kcm9wKHNrYjIsIHRvX2ZyZWUpOwotCQly
ZXR1cm4gTkVUX1hNSVRfRFJPUDsKKwkJcmV0dmFsID0gTkVUX1hNSVRfRFJPUDsKKwkJZ290byBk
ZWNfbmVzdF9sZXZlbDsKIAl9CiAKIAkvKgpAQCAtNjQyLDkgKzY1OCwxNCBAQCBzdGF0aWMgaW50
IG5ldGVtX2VucXVldWUoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IFFkaXNjICpzY2gsCiAJ
CS8qIFBhcmVudCBxZGlzY3MgYWNjb3VudGVkIGZvciAxIHNrYiBvZiBzaXplIEBwcmV2X2xlbiAq
LwogCQlxZGlzY190cmVlX3JlZHVjZV9iYWNrbG9nKHNjaCwgLShuYiAtIDEpLCAtKGxlbiAtIHBy
ZXZfbGVuKSk7CiAJfSBlbHNlIGlmICghc2tiKSB7Ci0JCXJldHVybiBORVRfWE1JVF9EUk9QOwor
CQlyZXR2YWwgPSBORVRfWE1JVF9EUk9QOworCQlnb3RvIGRlY19uZXN0X2xldmVsOwogCX0KLQly
ZXR1cm4gTkVUX1hNSVRfU1VDQ0VTUzsKKwlyZXR2YWwgPSBORVRfWE1JVF9TVUNDRVNTOworCitk
ZWNfbmVzdF9sZXZlbDoKKwlfX3RoaXNfY3B1X2RlYyhlbnF1ZXVlX25lc3RfbGV2ZWwpOworCXJl
dHVybiByZXR2YWw7CiB9CiAKIC8qIERlbGF5IHRoZSBuZXh0IHJvdW5kIHdpdGggYSBuZXcgZnV0
dXJlIHNsb3Qgd2l0aCBhCg==
--0000000000005696de0636614578--

