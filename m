Return-Path: <netdev+bounces-202200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B3CAECA5F
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 23:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CF43BAEE5
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 21:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C93E248F47;
	Sat, 28 Jun 2025 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="GZk6TSYW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A1B1D5154
	for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 21:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751145938; cv=none; b=l/NUjeuABZ7+Ykg+hBXzK6QNs68JSpl2+ljCt9eQ3CLMKXF683jMFFDLQY6gj0EKxmnRai0J/8jCmN2yPDTz+w/4Oz5N7uw8UFCuMfe5U8+x2A/xfQGjy7aMO7zeoUqdKUJMj24xn3B4e4eZRxKOrIsUxJvD4oqyUNDtEpGiu7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751145938; c=relaxed/simple;
	bh=I8FNtyD1OFqQYGsCvrKY94nTYfrcbkG6F+nxrPz9gyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5jkz3JxMQfSHlv2PG8i7swRy0AUhdiBJIKE22RQcx3PJ4FWnf0N6jYXkFt5yz7nUDBiD8Q1o6inTMUd1vmXtHGqTjYMtpQX96E/8hEddQ52yLxfpOuRlv9OWTk3ap3lI0x9QNRQ/aGJrMLYxCbujHNa/f5NOcYefFZcbcYPTZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=GZk6TSYW; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7426c44e014so3709651b3a.3
        for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 14:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751145936; x=1751750736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8FNtyD1OFqQYGsCvrKY94nTYfrcbkG6F+nxrPz9gyk=;
        b=GZk6TSYWaCBYXxWGSj7BP4nYWTK6WiCyHH34ZLetlrsthn139COPsFLIBaU/I45K72
         0/zo3Lrc+pwGcDkPAKOgtAlYxvJwzxIvC1eNthlzNEtM9I+8sGjtKiHFgm1+Ll9yn/ET
         BsBG/vM69J/Bs7MEjyBiXIaaJcHfAhzo977gxN2bRZrgMkPgXyyP5ZnTztT5eYulU/yy
         XCc1tByl+Fze2YKhL48dY9eiXQtEaH570sXGoofZhivQdcJdu9mDVq7m/ZRu0y2Z2wmM
         +4/sMNhNEF8vOIJBk4fUmJL61v8VQESttjEukze0xdBKSHgykU/T84mfY0HNXNypNigv
         0Icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751145936; x=1751750736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8FNtyD1OFqQYGsCvrKY94nTYfrcbkG6F+nxrPz9gyk=;
        b=W2rDhu/eMPnk9VMbYw8n6s+fNkYQWbiz0459XmA66Tgw3OShNq0lnjKmK19sS3QYi1
         ugTCSI3ceksVmzHx1r7BeXKgGo8Gsxuq5AzQHr7CcAo85rtVFhxSeXSyBaU7yTgQfoWi
         RVzOJuB9+wYMCde535C4x6wsyRYNLyp3t57gDqwIMfvUg1J9gFjUvY7NTC0i6Z0ZgmWm
         iNIrlHYk4QqlZtjn9hF+v8m2kVgwaD3YNjENLueJyjAk7KC4bO6HxoAMr7BV6hbJddhc
         UaUi9sK3a2URboOOQNg6OIN7CoL6/kBBSqm7LWEPCuSaW3l7xfffE81u29bSggL91KCX
         5BqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXVJOhK9NZ7QYn/L+DUmCMI/NLFHzg+5K6R1r4Pe5fzyGRAS+1RTTMBRrPQlALGJh5b2tMnZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHSmvfwMMtK+FrX1fi5wlln5m3gkwujfrNmxFPLZ/wZeGi0vbj
	wi4aDHIQ6bo0JLnPW063novqir/92lU9AoOtKXqI5la+tHLVFS252ovdKWWFuj0Ns8sryxUvCbS
	bW+CCCBUhmIpKYUFIljRdIMwsF06At+ZCV4a2Z2wD
X-Gm-Gg: ASbGncsC98faF779ifZv+7Fg60E609YdrIN7m0EzqOASoI5flbsw2xcXew8Fsi8vC4w
	QVLT7OAzi9+4giUNAn0yOmgW/SuFwo5ZddW4MEAMDN/fptZwS5yaN3SkA8IdhjgGpO2R94aClEi
	gbZrgxqzWBo27XkATiUBzTA5ySBD6QkJ3QDh+Xwb6gow==
X-Google-Smtp-Source: AGHT+IFf09TqsMyLjmi6mpYSq1w4iw8geBEZNCm67TawcSAWEBQU9JAd8oq3XwQ3W4f9mtdoPJUQfibOcYlRae4k+tw=
X-Received: by 2002:aa7:88c9:0:b0:736:33fd:f57d with SMTP id
 d2e1a72fcca58-74af6f7e449mr10637418b3a.17.1751145936523; Sat, 28 Jun 2025
 14:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627061600.56522-1-will@willsroot.io> <aF80DNslZSX7XT3l@pop-os.localdomain>
 <sf650XmBNi0tyPjDgs_wVtj-7oFNDmX8diA3IzKTuTaZcLYNc5YZPLnAHd5eI2BDtxugv74Bv67017EAuIvfNbfB6y7Pr7IUZ2w1j6JEMrM=@willsroot.io>
In-Reply-To: <sf650XmBNi0tyPjDgs_wVtj-7oFNDmX8diA3IzKTuTaZcLYNc5YZPLnAHd5eI2BDtxugv74Bv67017EAuIvfNbfB6y7Pr7IUZ2w1j6JEMrM=@willsroot.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 28 Jun 2025 17:25:25 -0400
X-Gm-Features: Ac12FXwj9dkPd5S1ljdvv7pmDiwwvDw7a3dFUTB3IHBXC4jwT5Wdpc5PGKGowzw
Message-ID: <CAM0EoMkUi470+z86ztEMAGfYcG8aYiC2e5pP0z1BHz82O4RCPg@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] net/sched: Restrict conditions for adding
 duplicating netems to qdisc tree
To: William Liu <will@willsroot.io>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org, victor@mojatatu.com, 
	pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, 
	stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 12:23=E2=80=AFAM William Liu <will@willsroot.io> wr=
ote:
>
> On Saturday, June 28th, 2025 at 12:15 AM, Cong Wang <xiyou.wangcong@gmail=
.com> wrote:
>
> >
> >
> > On Fri, Jun 27, 2025 at 06:17:31AM +0000, William Liu wrote:
> >
> > > netem_enqueue's duplication prevention logic breaks when a netem
> > > resides in a qdisc tree with other netems - this can lead to a
> > > soft lockup and OOM loop in netem_dequeue, as seen in [1].
> > > Ensure that a duplicating netem cannot exist in a tree with other
> > > netems.
> >
> >
> > Thanks for providing more details.
> >
> > > Previous approaches suggested in discussions in chronological order:
> > >
> > > 1) Track duplication status or ttl in the sk_buff struct. Considered
> > > too specific a use case to extend such a struct, though this would
> > > be a resilient fix and address other previous and potential future
> > > DOS bugs like the one described in loopy fun [2].
> > >
> > > 2) Restrict netem_enqueue recursion depth like in act_mirred with a
> > > per cpu variable. However, netem_dequeue can call enqueue on its
> > > child, and the depth restriction could be bypassed if the child is a
> > > netem.
> > >
> > > 3) Use the same approach as in 2, but add metadata in netem_skb_cb
> > > to handle the netem_dequeue case and track a packet's involvement
> > > in duplication. This is an overly complex approach, and Jamal
> > > notes that the skb cb can be overwritten to circumvent this
> > > safeguard.
> >
> >
> > This approach looks most elegant to me since it is per-skb and only
> > contained for netem. Since netem_skb_cb is shared among qdisc's, what
> > about just extending qdisc_skb_cb? Something like:
> >
> > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> > index 638948be4c50..4c5505661986 100644
> > --- a/include/net/sch_generic.h
> > +++ b/include/net/sch_generic.h
> > @@ -436,6 +436,7 @@ struct qdisc_skb_cb {
> > unsigned int pkt_len;
> > u16 slave_dev_queue_mapping;
> > u16 tc_classid;
> > + u32 reserved;
> > };
> > #define QDISC_CB_PRIV_LEN 20
> > unsigned char data[QDISC_CB_PRIV_LEN];
> >
> >
> > Then we just set and check it for duplicated skbs:
> >
> >
> > diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> > index fdd79d3ccd8c..4290f8fca0e9 100644
> > --- a/net/sched/sch_netem.c
> > +++ b/net/sched/sch_netem.c
> > @@ -486,7 +486,7 @@ static int netem_enqueue(struct sk_buff *skb, struc=
t Qdisc *sch,
> > * If we need to duplicate packet, then clone it before
> > * original is modified.
> > */
> > - if (count > 1)
> >
> > + if (count > 1 && !qdisc_skb_cb(skb)->reserved)
> >
> > skb2 =3D skb_clone(skb, GFP_ATOMIC);
> >
> > /*
> > @@ -540,9 +540,8 @@ static int netem_enqueue(struct sk_buff *skb, struc=
t Qdisc *sch,
> > struct Qdisc rootq =3D qdisc_root_bh(sch);
> > u32 dupsave =3D q->duplicate; / prevent duplicating a dup... */
> >
> >
> > - q->duplicate =3D 0;
> >
> > + qdisc_skb_cb(skb2)->reserved =3D dupsave;
> >
> > rootq->enqueue(skb2, rootq, to_free);
> >
> > - q->duplicate =3D dupsave;
> >
> > skb2 =3D NULL;
> > }
> >
> >
> > Could this work? It looks even shorter than your patch. :-)
> >
> > Note, I don't even compile test it, I just show it to you for discussio=
n.
> >
>
> Thank you for the suggestion. Jamal, would this work in this case? I reca=
ll you mentioning that the cb approach can be circumvented by zeroing the c=
b at the root:

your approach was to overwrite the netem specific cb which is exposed
via the cb ->data that can be overwritten for example by a trivial
ebpf program attach to any level of the hierarchy. This specific
variant from Cong is not accessible to ebpf but as i expressed my view
in other email i feel it is not a good solution.

cheers,
jamal

https://lore.kernel.org/netdev/CAM0EoMk4dxOFoN_=3D3yOy+XrtU=3DyvjJXAw3fVTmN=
9=3DM=3DR=3DvtbxA@mail.gmail.com/
>
> I'm not sure if qdisc_skb_cb would be different than the case for private=
 data for qdiscs.
>

