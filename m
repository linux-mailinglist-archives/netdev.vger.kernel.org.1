Return-Path: <netdev+bounces-201193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE56AE865E
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07EA15A6F85
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ED4264617;
	Wed, 25 Jun 2025 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="O2XcBn9C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25FF263C9B
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750861346; cv=none; b=f3uCury/FHx7Fg4qs0yIHC6r24PcUhvzKbvAWxBe2tHer5XpEQ7kgxlw/nJ4adLFWQVhmT9G71EwxbDYYy3PN0KPO0XmnLkkcc0Mr0yx9UfMQR5vfteE4hKk9NAZvt340cT/2RUBkS5V2iVfUKpyn64ZvI8by8DEbaKf1ZJRQek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750861346; c=relaxed/simple;
	bh=kzLW3zPnWa1wEO4Zrn8RenRJD4q3w8hbxkz1Q9+7Geg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YmrjuTeKMsWevFnc32+FqRhyuwCCC6Jkb8RosMfmdJgflU3MlgnFfzv8B04FbEABHTUnLaZPM62Wnm/Idm91yAJgnIVQlky/M9YjHdtCYaVGw4+mnm+VwGra/YPOudX3jE+gbwXOH/l+w6EP6KkgCIQTRwejdumo7/2jT2grbOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=O2XcBn9C; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso5168792b3a.2
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 07:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1750861344; x=1751466144; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jA6qq53Qcvg4jWB1DFZWJEUs/z5lkLOZ+8gF9kaf4zQ=;
        b=O2XcBn9CeaqdF7SDMXj/NVZQdD70z0UOZGtrx9OovXFi6NyxAPzQsJGHR1nO5mA/3v
         xHGx+YrFrpxDIa8x0xuQISF3DOcdw7rD9UbEiKJ2xIKdKS/uiVTUD/JmSMBT2es8/FBx
         DEnzKyr8vFmcAuO2EcyHcquzPX5d0N1LMfVVULMJcUc5zZen90MpZPmcoe4VtUpz55lm
         O+ZQE1q5MwLN3iaW1UIQ5UxVd2ORuQ+1EWYlremnQCQCiQqieKgjoE4oLkx1c8qMAiQs
         559yfLaRPjE3BfY1tmbh4HNBczq3g3eXAltIpYM9cY3iEGgMuUQrZHEyaO3Xh3Jf2+ci
         wnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750861344; x=1751466144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jA6qq53Qcvg4jWB1DFZWJEUs/z5lkLOZ+8gF9kaf4zQ=;
        b=GN2/WMlrlyPKdYSgkPyYqaN2nG2/rJErf2WTAfnT+ylNkNqjVeNiMiWA3YYZRs2CiI
         7Bdyd+Mcz64WLd2r99Z1LuVN1+B1Cy3vEm+oKQHTYq83DvZsID1sagSR2UoJpdidiKJm
         jctefzQGpqVg2KAtp/x0S6zy1SBzE3+d2/gBMMfAXzV6Kdu0oXXoZgJUfJuj2TgqKFAq
         uuwsE5HEjbsNYLNtbKXKVYFDFjAK/QVn5dEqy96f0/Ee8ihNMAELLeAQjNiCj1mfj7f2
         hryrC80OU73YSCiTzRrg05PHVsZ0Df7iclng8f+YC0ZqInKBN+ovPmmaaRwqc/kBSvpg
         JZ1g==
X-Forwarded-Encrypted: i=1; AJvYcCXaAkQYVD7OZpZ8oyulcMvGrzAP0lMGnbNefY9GCkH3hmC47/6HHonmeWeJ2XDm6a/WuEubFvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjcqvY4vItw1Gtxr6MtcMbY9shrdlfG8IYlop41HJjvOsLFe0j
	pKCduD18aCyqBuWJSh/Hy11xhDkpTK9mAxzfmaYKsM/qu2dxlwCu/ZQ6PdMTg9p+CeTFot/NRhA
	KVN9x8+ithXS2goSFwrVLGA4s7I4b8bc0C/gq5e4S
X-Gm-Gg: ASbGncvC5oq5AHuahFKBKcz7z503cePO+p6vyPgzm34Ysk56D9cyhhoul8o7ieXTgmE
	qHuCmTjsQvo/uNqQVuO08NGQzk4DYa6IOK7LLe4mmIEctUqX2avk0bIwTzhKGsDG0sGL/1W+TOn
	EBx+VzhKW2OCvrQSbDkthvdAhpUsBwnLZpDV27phuEskWZIpC0gmhy
X-Google-Smtp-Source: AGHT+IFEzFfGhUsVbWP1SftYqQm+LquUdczN4fPYqkcjAqqWWKdvCwJqAmrv9XMC1dzmpBdP0v1RC5dBSvUsbNHO+us=
X-Received: by 2002:a05:6a00:3e0e:b0:748:f854:b765 with SMTP id
 d2e1a72fcca58-74ad4443c5emr4870304b3a.4.1750861343929; Wed, 25 Jun 2025
 07:22:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com>
 <aFosjBOUlOr0TKsd@pop-os.localdomain> <3af4930b-6773-4159-8a7a-e4f6f6ae8109@gmail.com>
 <5e4490da-3f6c-4331-af9c-0e6d32b6fc75@gmail.com>
In-Reply-To: <5e4490da-3f6c-4331-af9c-0e6d32b6fc75@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 25 Jun 2025 10:22:12 -0400
X-Gm-Features: Ac12FXznJiXiH5EvqI_QOcqeM7xTlvPTFIge2YrM41bHMg9TaPAQ3gUB8kMGtik
Message-ID: <CAM0EoMm+xgb0vkTDMAWy9xCvTF+XjGQ1xO5A2REajmBN1DKu1Q@mail.gmail.com>
Subject: Re: Incomplete fix for recent bug in tc / hfsc
To: Lion Ackermann <nnamrec@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, Mingi Cho <mincho@theori.io>
Content-Type: multipart/mixed; boundary="00000000000074e7e40638662cec"

--00000000000074e7e40638662cec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 6:43=E2=80=AFAM Lion Ackermann <nnamrec@gmail.com> =
wrote:
>
> Hi,
>
> On 6/24/25 11:24 AM, Lion Ackermann wrote:
> > Hi,
> >
> > On 6/24/25 6:41 AM, Cong Wang wrote:
> >> On Mon, Jun 23, 2025 at 12:41:08PM +0200, Lion Ackermann wrote:
> >>> Hello,
> >>>
> >>> I noticed the fix for a recent bug in sch_hfsc in the tc subsystem is
> >>> incomplete:
> >>>     sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enqueue=
()
> >>>     https://lore.kernel.org/all/20250518222038.58538-2-xiyou.wangcong=
@gmail.com/
> >>>
> >>> This patch also included a test which landed:
> >>>     selftests/tc-testing: Add an HFSC qlen accounting test
> >>>
> >>> Basically running the included test case on a sanitizer kernel or wit=
h
> >>> slub_debug=3DP will directly reveal the UAF:
> >>
> >> Interesting, I have SLUB debugging enabled in my kernel config too:
> >>
> >> CONFIG_SLUB_DEBUG=3Dy
> >> CONFIG_SLUB_DEBUG_ON=3Dy
> >> CONFIG_SLUB_RCU_DEBUG=3Dy
> >>
> >> But I didn't catch this bug.
> >>
> >
> > Technically the class deletion step which triggered the sanitizer was n=
ot
> > present in your testcase. The testcase only left the stale pointer whic=
h was
> > never accessed though.
> >
> >>> To be completely honest I do not quite understand the rationale behin=
d the
> >>> original patch. The problem is that the backlog corruption propagates=
 to
> >>> the parent _before_ parent is even expecting any backlog updates.
> >>> Looking at f.e. DRR: Child is only made active _after_ the enqueue co=
mpletes.
> >>> Because HFSC is messing with the backlog before the enqueue completed=
,
> >>> DRR will simply make the class active even though it should have alre=
ady
> >>> removed the class from the active list due to qdisc_tree_backlog_flus=
h.
> >>> This leaves the stale class in the active list and causes the UAF.
> >>>
> >>> Looking at other qdiscs the way DRR handles child enqueues seems to r=
esemble
> >>> the common case. HFSC calling dequeue in the enqueue handler violates
> >>> expectations. In order to fix this either HFSC has to stop using dequ=
eue or
> >>> all classful qdiscs have to be updated to catch this corner case wher=
e
> >>> child qlen was zero even though the enqueue succeeded. Alternatively =
HFSC
> >>> could signal enqueue failure if it sees child dequeue dropping packet=
s to
> >>> zero? I am not sure how this all plays out with the re-entrant case o=
f
> >>> netem though.
> >>
> >> I think this may be the same bug report from Mingi in the security
> >> mailing list. I will take a deep look after I go back from Open Source
> >> Summit this week. (But you are still very welcome to work on it by
> >> yourself, just let me know.)
> >>
> >> Thanks!
> >
> >> My suggestion is we go back to a proposal i made a few moons back (was
> >> this in a discussion with you? i dont remember): create a mechanism to
> >> disallow certain hierarchies of qdiscs based on certain attributes,
> >> example in this case disallow hfsc from being the ancestor of "qdiscs =
that may
> >> drop during peek" (such as netem). Then we can just keep adding more
> >> "disallowed configs" that will be rejected via netlink. Similar idea
> >> is being added to netem to disallow double duplication, see:
> >> https://lore.kernel.org/netdev/20250622190344.446090-1-will@willsroot.=
io/
> >>
> >> cheers,
> >> jamal
> >
> > I vaguely remember Jamal's proposal from a while back, and I believe th=
ere was
> > some example code for this approach already?
> > Since there is another report you have a better overview, so it is prob=
ably
> > best you look at it first. In the meantime I can think about the soluti=
on a
> > bit more and possibly draft something if you wish.
> >
> > Thanks,
> > Lion
>
> Actually I was intrigued, what do you think about addressing the root of =
the
> use-after-free only and ignore the backlog corruption (kind of). After th=
e
> recent patches where qlen_notify may get called multiple times, we could =
simply
> loosen qdisc_tree_reduce_backlog to always notify when the qdisc is empty=
.
> Since deletion of all qdiscs will run qdisc_reset / qdisc_purge_queue at =
one
> point or another, this should always catch left-overs. And we need not ca=
re
> about all the complexities involved of keeping the backlog right and / or
> prevent certain hierarchies which seems rather tedious.
> This requires some more testing, but I was imagining something like this:
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -780,15 +780,12 @@ static u32 qdisc_alloc_handle(struct net_device *de=
v)
>
>  void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
>  {
> -       bool qdisc_is_offloaded =3D sch->flags & TCQ_F_OFFLOADED;
>         const struct Qdisc_class_ops *cops;
>         unsigned long cl;
>         u32 parentid;
>         bool notify;
>         int drops;
>
> -       if (n =3D=3D 0 && len =3D=3D 0)
> -               return;
>         drops =3D max_t(int, n, 0);
>         rcu_read_lock();
>         while ((parentid =3D sch->parent)) {
> @@ -797,17 +794,8 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, in=
t n, int len)
>
>                 if (sch->flags & TCQ_F_NOPARENT)
>                         break;
> -               /* Notify parent qdisc only if child qdisc becomes empty.
> -                *
> -                * If child was empty even before update then backlog
> -                * counter is screwed and we skip notification because
> -                * parent class is already passive.
> -                *
> -                * If the original child was offloaded then it is allowed
> -                * to be seem as empty, so the parent is notified anyway.
> -                */
> -               notify =3D !sch->q.qlen && !WARN_ON_ONCE(!n &&
> -                                                      !qdisc_is_offloade=
d);
> +               /* Notify parent qdisc only if child qdisc becomes empty.=
 */
> +               notify =3D !sch->q.qlen;
>                 /* TODO: perform the search on a per txq basis */
>                 sch =3D qdisc_lookup(qdisc_dev(sch), TC_H_MAJ(parentid));
>                 if (sch =3D=3D NULL) {
> @@ -816,6 +804,9 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int=
 n, int len)
>                 }
>                 cops =3D sch->ops->cl_ops;
>                 if (notify && cops->qlen_notify) {
> +                       /* Note that qlen_notify must be idempotent as it=
 may get called
> +                        * multiple times.
> +                        */
>                         cl =3D cops->find(sch, parentid);
>                         cops->qlen_notify(sch, cl);
>                 }
>

I believe this will fix the issue. My concern is we are not solving
the root cause. I also posted a bunch of fixes on related issues for
something Mingi Cho (on Cc) found - see attachments, i am not in favor
of these either.
Most of these setups are nonsensical. After seeing so many of these my
view is we start disallowing such hierarchies.

cheers,
jamal

--00000000000074e7e40638662cec
Content-Type: application/octet-stream; name="drr_fix.diff"
Content-Disposition: attachment; filename="drr_fix.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mcc1lzem0>
X-Attachment-Id: f_mcc1lzem0

ZGlmZiAtLWdpdCBhL25ldC9zY2hlZC9zY2hfYXBpLmMgYi9uZXQvc2NoZWQvc2NoX2FwaS5jCmlu
ZGV4IGM1ZTM2NzNhYWRiZS4uNDZiMjQyMzNhODE4IDEwMDY0NAotLS0gYS9uZXQvc2NoZWQvc2No
X2FwaS5jCisrKyBiL25ldC9zY2hlZC9zY2hfYXBpLmMKQEAgLTgxOSw4ICs4MTksMTEgQEAgdm9p
ZCBxZGlzY190cmVlX3JlZHVjZV9iYWNrbG9nKHN0cnVjdCBRZGlzYyAqc2NoLCBpbnQgbiwgaW50
IGxlbikKIAkJCWNsID0gY29wcy0+ZmluZChzY2gsIHBhcmVudGlkKTsKIAkJCWNvcHMtPnFsZW5f
bm90aWZ5KHNjaCwgY2wpOwogCQl9Ci0JCXNjaC0+cS5xbGVuIC09IG47Ci0JCXNjaC0+cXN0YXRz
LmJhY2tsb2cgLT0gbGVuOworCQkvKiBBdm9pZCB1bmRlcmZsb3dpbmcgcWxlbiBhbmQgYmFja2xv
ZyAqLworCQlpZiAoc2NoLT5xLnFsZW4pCisJCQlzY2gtPnEucWxlbiAtPSBuOworCQlpZiAoc2No
LT5xc3RhdHMuYmFja2xvZykKKwkJCXNjaC0+cXN0YXRzLmJhY2tsb2cgLT0gbGVuOwogCQlfX3Fk
aXNjX3FzdGF0c19kcm9wKHNjaCwgZHJvcHMpOwogCX0KIAlyY3VfcmVhZF91bmxvY2soKTsKZGlm
ZiAtLWdpdCBhL25ldC9zY2hlZC9zY2hfZHJyLmMgYi9uZXQvc2NoZWQvc2NoX2Ryci5jCmluZGV4
IDliNmQ3OWJkODczNy4uNDVkYTVmMzI5NzAxIDEwMDY0NAotLS0gYS9uZXQvc2NoZWQvc2NoX2Ry
ci5jCisrKyBiL25ldC9zY2hlZC9zY2hfZHJyLmMKQEAgLTIwLDYgKzIwLDcgQEAgc3RydWN0IGRy
cl9jbGFzcyB7CiAKIAlzdHJ1Y3QgZ25ldF9zdGF0c19iYXNpY19zeW5jCQlic3RhdHM7CiAJc3Ry
dWN0IGduZXRfc3RhdHNfcXVldWUJCXFzdGF0czsKKwlfX3U4CQkJCXFsZW5fbm90aWZ5X2luYWN0
aXZlOwogCXN0cnVjdCBuZXRfcmF0ZV9lc3RpbWF0b3IgX19yY3UgKnJhdGVfZXN0OwogCXN0cnVj
dCBsaXN0X2hlYWQJCWFsaXN0OwogCXN0cnVjdCBRZGlzYwkJCSpxZGlzYzsKQEAgLTIzNSw3ICsy
MzYsMTAgQEAgc3RhdGljIHZvaWQgZHJyX3FsZW5fbm90aWZ5KHN0cnVjdCBRZGlzYyAqY3NoLCB1
bnNpZ25lZCBsb25nIGFyZykKIHsKIAlzdHJ1Y3QgZHJyX2NsYXNzICpjbCA9IChzdHJ1Y3QgZHJy
X2NsYXNzICopYXJnOwogCi0JbGlzdF9kZWxfaW5pdCgmY2wtPmFsaXN0KTsKKwlpZiAoY2xfaXNf
YWN0aXZlKGNsKSkKKwkJbGlzdF9kZWxfaW5pdCgmY2wtPmFsaXN0KTsKKwllbHNlCisJCWNsLT5x
bGVuX25vdGlmeV9pbmFjdGl2ZSA9IDE7CiB9CiAKIHN0YXRpYyBpbnQgZHJyX2R1bXBfY2xhc3Mo
c3RydWN0IFFkaXNjICpzY2gsIHVuc2lnbmVkIGxvbmcgYXJnLApAQCAtMzYwLDYgKzM2NCwxNiBA
QCBzdGF0aWMgaW50IGRycl9lbnF1ZXVlKHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBRZGlz
YyAqc2NoLAogCQlyZXR1cm4gZXJyOwogCX0KIAorCS8qIEFkZHJlc3MgY29ybmVyIGNhc2Ugd2hl
cmUgYSBjaGlsZCBxZGlzYyBkcm9wcGVkIHRoZSBwYWNrZXQgYWZ0ZXIKKwkgKiBlbnF1ZXVlIHJl
dHVybmVkIHN1Y2Nlc3MgKGFzIG9mIG5vdyB0aGlzIGNhbiBvbmx5IGhhcHBlbiBpZiB0aGUgdXNl
cgorCSAqIGhhcyBuZXRlbSBkb3duIHRoZSBoaWVyYXJjaHkpLgorCSAqLworCWlmICh1bmxpa2Vs
eShjbC0+cWxlbl9ub3RpZnlfaW5hY3RpdmUpKSB7CisJCWNsLT5xbGVuX25vdGlmeV9pbmFjdGl2
ZSA9IDA7CisJCXJldHVybiBORVRfWE1JVF9TVUNDRVNTIHwgX19ORVRfWE1JVF9CWVBBU1M7CisJ
fQorCiAJaWYgKCFjbF9pc19hY3RpdmUoY2wpKSB7CiAJCWxpc3RfYWRkX3RhaWwoJmNsLT5hbGlz
dCwgJnEtPmFjdGl2ZSk7CiAJCWNsLT5kZWZpY2l0ID0gY2wtPnF1YW50dW07Cg==
--00000000000074e7e40638662cec
Content-Type: application/octet-stream; name="qfq_netem_child_fix.diff"
Content-Disposition: attachment; filename="qfq_netem_child_fix.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mcc1mo7i1>
X-Attachment-Id: f_mcc1mo7i1

ZGlmZiAtLWdpdCBhL25ldC9zY2hlZC9zY2hfYXBpLmMgYi9uZXQvc2NoZWQvc2NoX2FwaS5jCmlu
ZGV4IGM1ZTM2NzNhYWRiZS4uMTBmYjcyZmVmOThlIDEwMDY0NAotLS0gYS9uZXQvc2NoZWQvc2No
X2FwaS5jCisrKyBiL25ldC9zY2hlZC9zY2hfYXBpLmMKQEAgLTgxNCw2ICs4MTQsMTEgQEAgdm9p
ZCBxZGlzY190cmVlX3JlZHVjZV9iYWNrbG9nKHN0cnVjdCBRZGlzYyAqc2NoLCBpbnQgbiwgaW50
IGxlbikKIAkJCVdBUk5fT05fT05DRShwYXJlbnRpZCAhPSBUQ19IX1JPT1QpOwogCQkJYnJlYWs7
CiAJCX0KKworCQlpZiAodW5saWtlbHkoKCFzY2gtPnEucWxlbiAmJiBuKSB8fAorCQkJICAgICAo
IXNjaC0+cXN0YXRzLmJhY2tsb2cgJiYgbGVuKSkpCisJCQljb250aW51ZTsKKwogCQljb3BzID0g
c2NoLT5vcHMtPmNsX29wczsKIAkJaWYgKG5vdGlmeSAmJiBjb3BzLT5xbGVuX25vdGlmeSkgewog
CQkJY2wgPSBjb3BzLT5maW5kKHNjaCwgcGFyZW50aWQpOwpkaWZmIC0tZ2l0IGEvbmV0L3NjaGVk
L3NjaF9xZnEuYyBiL25ldC9zY2hlZC9zY2hfcWZxLmMKaW5kZXggYmYxMjgyY2IyMmViLi42ZDg1
ZGEyMWM0YjggMTAwNjQ0Ci0tLSBhL25ldC9zY2hlZC9zY2hfcWZxLmMKKysrIGIvbmV0L3NjaGVk
L3NjaF9xZnEuYwpAQCAtMTI1OCw3ICsxMjU4LDE3IEBAIHN0YXRpYyBpbnQgcWZxX2VucXVldWUo
c3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IFFkaXNjICpzY2gsCiAJYWdnID0gY2wtPmFnZzsK
IAkvKiBpZiB0aGUgY2xhc3MgaXMgYWN0aXZlLCB0aGVuIGRvbmUgaGVyZSAqLwogCWlmIChjbF9p
c19hY3RpdmUoY2wpKSB7Ci0JCWlmICh1bmxpa2VseShza2IgPT0gY2wtPnFkaXNjLT5vcHMtPnBl
ZWsoY2wtPnFkaXNjKSkgJiYKKwkJY29uc3QgdTMyIHByZV9wZWVrX2JhY2tsb2cgPSBzY2gtPnFz
dGF0cy5iYWNrbG9nOworCisJCXNrYiA9IGNsLT5xZGlzYy0+b3BzLT5wZWVrKGNsLT5xZGlzYyk7
CisJCS8qIEFkZHJlc3MgY29ybmVyIGNhc2Ugd2hlcmUgYSBjaGlsZCBxZGlzYyBkcm9wcGVkIHRo
ZSBwYWNrZXQKKwkJICogaW4gcGVlayBhZnRlciBlbnF1ZXVlIHJldHVybmVkIHN1Y2Nlc3MuCisJ
CSAqIFFkaXNjcyBsaWtlIG5ldGVtIG1heSBleGhpYml0IHRoaXMgYmVoYXZpb3VyLgorCQkgKi8K
KwkJaWYgKHVubGlrZWx5KHNjaC0+cXN0YXRzLmJhY2tsb2cgPCBwcmVfcGVla19iYWNrbG9nKSkK
KwkJCXJldHVybiBORVRfWE1JVF9TVUNDRVNTIHwgX19ORVRfWE1JVF9CWVBBU1M7CisKKwkJaWYg
KHVubGlrZWx5KHNrYikgJiYKIAkJICAgIGxpc3RfZmlyc3RfZW50cnkoJmFnZy0+YWN0aXZlLCBz
dHJ1Y3QgcWZxX2NsYXNzLCBhbGlzdCkKIAkJICAgID09IGNsICYmIGNsLT5kZWZpY2l0IDwgbGVu
KQogCQkJbGlzdF9tb3ZlX3RhaWwoJmNsLT5hbGlzdCwgJmFnZy0+YWN0aXZlKTsKZGlmZiAtLWdp
dCBhL25ldC9zY2hlZC9zY2hfdGJmLmMgYi9uZXQvc2NoZWQvc2NoX3RiZi5jCmluZGV4IDRjOTc3
ZjA0OTY3MC4uNDY1NWRiZjJjODNhIDEwMDY0NAotLS0gYS9uZXQvc2NoZWQvc2NoX3RiZi5jCisr
KyBiL25ldC9zY2hlZC9zY2hfdGJmLmMKQEAgLTIxNyw2ICsyMTcsNyBAQCBzdGF0aWMgaW50IHRi
Zl9zZWdtZW50KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBRZGlzYyAqc2NoLAogCQlyZXR1
cm4gcWRpc2NfZHJvcChza2IsIHNjaCwgdG9fZnJlZSk7CiAKIAluYiA9IDA7CisJcmV0ID0gTkVU
X1hNSVRfU1VDQ0VTUzsKIAlza2JfbGlzdF93YWxrX3NhZmUoc2Vncywgc2VncywgbnNrYikgewog
CQlza2JfbWFya19ub3Rfb25fbGlzdChzZWdzKTsKIAkJc2VnX2xlbiA9IHNlZ3MtPmxlbjsKQEAg
LTIzMCw2ICsyMzEsMjIgQEAgc3RhdGljIGludCB0YmZfc2VnbWVudChzdHJ1Y3Qgc2tfYnVmZiAq
c2tiLCBzdHJ1Y3QgUWRpc2MgKnNjaCwKIAkJCWxlbiArPSBzZWdfbGVuOwogCQl9CiAJfQorCisJ
aWYgKHJldCAhPSBORVRfWE1JVF9TVUNDRVNTKSB7CisJCXdoaWxlIChuYiA+IDApIHsKKwkJCXN0
cnVjdCBza19idWZmICpkc2tiID0gcWRpc2NfZGVxdWV1ZV9wZWVrZWQocS0+cWRpc2MpOworCisJ
CQlpZiAoZHNrYikgeworCQkJCWtmcmVlX3NrYihkc2tiKTsKKwkJCQlxZGlzY19xc3RhdHNfZHJv
cChzY2gpOworCQkJfQorCQkJbmItLTsKKwkJfQorCQlrZnJlZV9za2JfbGlzdChzZWdzKTsKKwkJ
Y29uc3VtZV9za2Ioc2tiKTsKKwkJcmV0dXJuIE5FVF9YTUlUX0RST1A7CisJfQorCiAJc2NoLT5x
LnFsZW4gKz0gbmI7CiAJc2NoLT5xc3RhdHMuYmFja2xvZyArPSBsZW47CiAJaWYgKG5iID4gMCkg
ewo=
--00000000000074e7e40638662cec--

