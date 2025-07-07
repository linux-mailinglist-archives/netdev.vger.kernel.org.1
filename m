Return-Path: <netdev+bounces-204696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 721A1AFBCD1
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 22:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74C416DEE5
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 20:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5807121CC59;
	Mon,  7 Jul 2025 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="NvZLGt1Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F309221FC9
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921400; cv=none; b=u4eOguXHRIaEu59YbbXWEWMCbLntznaZiOmK1bkxwB8xe6DrVRdftBhbZ1iT809A3G1ApusYBC7414xlfabfzIGW/e5/CsiBVOjMa1rPERXWXKMGb72fIy9tPBTi0ZovUlkRzrpZv5wiSBfr7XczLYMjw3ukhYku69EO/+s6QOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921400; c=relaxed/simple;
	bh=1MhQRMD00+Av5qgq0nVni032LHE8EuKa1iorv+eBVqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/0sS1Fcj6qSJFw3Si73r5U7+B+c4Y0YnsAahmP4/iUY3bQU050358co1641OToE7wmszcEP7lgaGkQ2rSOP+LH+oxhnofVd1z+eqlUSVFqOfuxTHYFxo+5OCl7iCKceXD6deb16Jnx6u0eYrpTsSsiDPnyVww8FMGu0JHHbdO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=NvZLGt1Y; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b321bd36a41so3110599a12.2
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 13:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751921398; x=1752526198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MhQRMD00+Av5qgq0nVni032LHE8EuKa1iorv+eBVqc=;
        b=NvZLGt1Yq/3uS9pHBjTgbuoTYC1IaEqf9D1erf8tzYw5W4Y4WhsSVV1PGg38R5K4eZ
         AILMYddX9wzpXDyRhRVPn0wmSWYThzXeDQucDxMQaHx1fDSw/ODYye6JlWwXEjIwUQx0
         Akv6PRn5Yx3dLozS56yEvXJg5DckbB+zNzHpkvHrtvCGQ0glXW1Mi/RqlCwcByjv1V3+
         PZmMPoQL9VFDkcMVN+Lz+6OzqwkWPFLTKLSNVBowgxlyGa7rR9n+eIIiJJCtBB9PjJ9K
         H7HG4NOsIwHmeJ73vni9rgfw8pxAxigZp3eOBy9Zs8YM3c0/N6R2sGZn1UxQUHN44tiQ
         S9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751921398; x=1752526198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MhQRMD00+Av5qgq0nVni032LHE8EuKa1iorv+eBVqc=;
        b=VViY82yKnovMIleate/43TsCrYNgwYM2a7u+oaWpggN+JtN6jIPJVi9UV69XGB3pCV
         v+AXgm2rretBWIpm20Eu3+z82FxxTqKB+zrIffWgI+hAhNGZi/spw2L32DUKEzA9w1Q5
         HcLtIim2Q31WHcXvr8bUMOvNNzK/MLWEsPop7QQZ31BnvEQyd3YCYmk678UKoIy++1K7
         njb1JQBLMjDhxpNYu0aO29EttTeiwlA13UutJnHH2AfEfdYORmgrSdBYpXBrRu3l9N/H
         BjoqCPZz6QL6yhJ8JlG02EtLP77xDP40yQYIeGbqEt1xrBND362TQRgTUP2CKV1iNaih
         d2aw==
X-Forwarded-Encrypted: i=1; AJvYcCVLHJ1AJyGD2yToAZH3uWZY6Vm5Ix7G7fzMM7pYky8C2p1NZxz35z6YOhHjQ+QoHyBFPkPiDkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ3N+RMpL+GHnbEKrTFfKgTDd0Ys6e55e4eldH0tXM65ossp3A
	+eYph72BVGiIlruUfCc908snup0sMBlY1JZPJUEykz4QcbZed16Z/qsYIqckVvQcifnurLBXLb9
	/+GH982JMlKr9CIGxui/R6/HKuy5L7C21s7giA8F2
X-Gm-Gg: ASbGncuFxQp3oSV5ZCYGOjWiRpAUyfv6/z2T7xXLhuWKSUi/RxVvaBDGLpjUrxW+u+p
	5F/u6SI+8gCbkebPipsQnZn3T4Hek+3Lt+hTZ39Jab0Nycp2do1w9KnngXciYIghmg9RqbL/fJs
	ywTNXBMi+GTYJzx8V9/gqDo70W0kViNX83qyYl51f5aw==
X-Google-Smtp-Source: AGHT+IH1Uc2/x6H7MOPzrWBvs8yZqvepSEedX1g7I7xn9HuCpzuxaCGEL50fSwR8DpcDpbduWbsH9tXyCTyi+wLyl+c=
X-Received: by 2002:a05:6a20:7f9e:b0:1f5:a3e8:64c1 with SMTP id
 adf61e73a8af0-226060889c5mr22790655637.0.1751921397560; Mon, 07 Jul 2025
 13:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701231306.376762-1-xiyou.wangcong@gmail.com>
 <20250701231306.376762-2-xiyou.wangcong@gmail.com> <aGSSF7K/M81Pjbyz@pop-os.localdomain>
 <CAM0EoMmDj9TOafynkjVPaBw-9s7UDuS5DoQ_K3kAtioEdJa1-g@mail.gmail.com>
 <CAM0EoMmBdZBzfUAms5-0hH5qF5ODvxWfgqrbHaGT6p3-uOD6vg@mail.gmail.com>
 <aGh2TKCthenJ2xS2@pop-os.localdomain> <CAM0EoM=99ufQSzbYZU=wz8fbYOQ2v+cMa7BX1EM6OHk+dBrE0Q@mail.gmail.com>
 <lhR3z8brE3wSKO4PDITIAGXGGW8vnrt1zIPo7C10g2rH0zdQ1lA8zFOuUBklLOTAgMcw4Z6N5YnqRXRzWnkHO-unr5g62msCAUHow-NmY7k=@willsroot.io>
In-Reply-To: <lhR3z8brE3wSKO4PDITIAGXGGW8vnrt1zIPo7C10g2rH0zdQ1lA8zFOuUBklLOTAgMcw4Z6N5YnqRXRzWnkHO-unr5g62msCAUHow-NmY7k=@willsroot.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 7 Jul 2025 16:49:46 -0400
X-Gm-Features: Ac12FXybeXnLOLjVUttkDQXM2ub0fX8k-T8tRXrLPgDiynef-zkiY0xdHH5TI08
Message-ID: <CAM0EoM=SPbm6VdjPTTPRjtm7-gXzTvShrG=EdBiO7nCz=uJw0w@mail.gmail.com>
Subject: Re: [Patch net 1/2] netem: Fix skb duplication logic to prevent
 infinite loops
To: William Liu <will@willsroot.io>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org, 
	stephen@networkplumber.org, Savino Dicanosa <savy@syst3mfailure.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 6, 2025 at 10:59=E2=80=AFAM William Liu <will@willsroot.io> wro=
te:
>
> On Saturday, July 5th, 2025 at 1:52 PM, Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
>
> >
> >
> > On Fri, Jul 4, 2025 at 8:48=E2=80=AFPM Cong Wang xiyou.wangcong@gmail.c=
om wrote:
> >
> > > On Wed, Jul 02, 2025 at 11:04:22AM -0400, Jamal Hadi Salim wrote:
> > >
> > > > On Wed, Jul 2, 2025 at 10:12=E2=80=AFAM Jamal Hadi Salim jhs@mojata=
tu.com wrote:
> > > >
> > > > > On Tue, Jul 1, 2025 at 9:57=E2=80=AFPM Cong Wang xiyou.wangcong@g=
mail.com wrote:
> > > > >
> > > > > > On Tue, Jul 01, 2025 at 04:13:05PM -0700, Cong Wang wrote:
> > > > > >
> > > > > > > diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> > > > > > > index fdd79d3ccd8c..33de9c3e4d1b 100644
> > > > > > > --- a/net/sched/sch_netem.c
> > > > > > > +++ b/net/sched/sch_netem.c
> > > > > > > @@ -460,7 +460,8 @@ static int netem_enqueue(struct sk_buff *=
skb, struct Qdisc *sch,
> > > > > > > skb->prev =3D NULL;
> > > > > > >
> > > > > > > /* Random duplication */
> > > > > > > - if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_c=
or, &q->prng))
> > > > > > > + if (tc_skb_cb(skb)->duplicate &&
> > > > > >
> > > > > > Oops, this is clearly should be !duplicate... It was lost durin=
g my
> > > > > > stupid copy-n-paste... Sorry for this mistake.
> > > > >
> > > > > I understood you earlier, Cong. My view still stands:
> > > > > You are adding logic to a common data structure for a use case th=
at
> > >
> > > You are exaggerating this. I only added 1 bit to the core data struct=
ure,
> > > the code logic remains in the netem, so it is contained within netem.
> >
> >
> > Try it out ;->
> >
> > Here's an even simpler setup:
> >
> > sudo tc qdisc add dev lo root handle 1: prio bands 3 priomap 0 0 0 0 0
> > 0 0 0 0 0 0 0 0 0 0 0
> > sudo tc filter add dev lo parent 1:0 protocol ip bpf obj
> > netem_bug_test.o sec classifier/pass classid 1:1
> > sudo tc qdisc add dev lo parent 1:1 handle 10: netem limit 4 duplicate =
100%
> > then:
> > ping -c 1 127.0.0.1
> >
> > Note: there are other issues as well but i thought citing the ebpf one
> > was sufficient to get the point across.
> >
> > > > > really makes no sense. The ROI is not good.
> > >
> > > Speaking of ROI, I think you need to look at the patch stats:
> > >
> > > William/Your patch:
> > > 1 file changed, 40 insertions(+)
> > >
> > > My patch:
> > > 2 files changed, 4 insertions(+), 4 deletions(-)
> >
> >
> > ROI is not just about LOC. The consequences of a patch are also part
> > of that formula. And let's not forget the time spent so far debating
> > instead of plugging the hole.
> >
> > > > > BTW: I am almost certain you will hit other issues when this goes=
 out
> > > > > or when you actually start to test and then you will have to fix =
more
> > > > > spots.
> > > >
> > > > Here's an example that breaks it:
> > > >
> > > > sudo tc qdisc add dev lo root handle 1: prio bands 3 priomap 0 0 0 =
0 0
> > > > 0 0 0 0 0 0 0 0 0 0 0
> > > > sudo tc filter add dev lo parent 1:0 protocol ip bpf obj
> > > > netem_bug_test.o sec classifier/pass classid 1:1
> > > > sudo tc qdisc add dev lo parent 1:1 handle 10: netem limit 4 duplic=
ate 100%
> > > > sudo tc qdisc add dev lo parent 10: handle 30: netem gap 1 limit 4
> > > > duplicate 100% delay 1us reorder 100%
> > > >
> > > > And the ping 127.0.0.1 -c 1
> > > > I had to fix your patch for correctness (attached)
> > > >
> > > > the ebpf prog is trivial - make it just return the classid or even =
zero.
> > >
> > > Interesting, are you sure this works before my patch?
> > >
> > > I don't intend to change any logic except closing the infinite loop. =
IOW,
> > > if it didn't work before, I don't expect to make it work with this pa=
tch,
> > > this patch merely fixes the infinite loop, which is sufficient as a b=
ug fix.
> > > Otherwise it would become a feature improvement. (Don't get me wrong,=
 I
> > > think this feature should be improved rather than simply forbidden, i=
t just
> > > belongs to a different patch.)
> >
> >
> > A quick solution is what William had. I asked him to use ext_cb not
> > because i think it is a better solution but just so we can move
> > forward.
> > Agree that for a longer term we need a more generic solution as discuss=
ed ...
> >
> > cheers,
> > jamal
>
> The tc_skb_ext approach has a problem... the config option that enables i=
t is NET_TC_SKB_EXT. I assumed this is a generic name for skb extensions in=
 the tc subsystem, but unfortunately this is hardcoded for NET_CLS_ACT reci=
rculation support.
>
> So what this means is we have the following choices:
> 1. Make SCH_NETEM depend on NET_CLS_ACT and NET_TC_SKB_EXT
> 2. Add "|| IS_ENABLED(CONFIG_SCH_NETEM)" next to "IS_ENABLED(CONFIG_NET_T=
C_SKB_EXT)"
> 3. Separate NET_TC_SKB_EXT and the idea of recirculation support. But I'm=
 not sure how people feel about renaming config options. And this would req=
uire a small change to the Mellanox driver subsystem.
>
> None of these sound too nice to do, and I'm not sure which approach to ta=
ke. In an ideal world, 3 would be best, but I'm not sure how others would f=
eel about all that just to account for a netem edge case.
>

I think you should just create a new field/type, add it here:
include/linux/skbuff.h around line 4814 and make netem just select
CONFIG_SKB_EXTENSIONS kconfig
It's not the best solution but we are grasping for straws at this point.

cheers,
jamal

