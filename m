Return-Path: <netdev+bounces-195328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28D0ACF98A
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 00:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D86216ED2B
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 22:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922DA220685;
	Thu,  5 Jun 2025 22:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="12dqb9m+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEDF27F74E
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 22:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749161528; cv=none; b=n95uFwepcC2R7BKJBE/T7BhIS6/gySkJvN2a5MajyaBcZe383XGqC6/JtQ0mO+2Dx3sYSTxhfekXLJMuYqokiLcRh+VVw6Cnjf6MeItJV+qTNC2CwUjNDli2CRyFuwhX99c72I2za8VWMc5m6zSnpPFb1vxHPdwUtKFrGwpKocA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749161528; c=relaxed/simple;
	bh=U0acoCeoCvc+YWm82btY91MES9glhx6EOzF1AQamPn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqKvtbUI3EuKI77w90F8OGNCm2i5MeCY7wUz6F9XJQIuoLgMeah2rqoH1qYGg3FtQ2bdTxgTfp9MQhRYWDpD6qxI6+Nd5l4qvsPde29Z2w4we+hUYDUqSgJHz1WS0Aml2cN3buOPsIsofISqlAAS8FfOfqT0fbBgb49mnWcXydg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=12dqb9m+; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a58ebece05so15675121cf.1
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 15:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749161515; x=1749766315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ihE80hjZVxwRnd93NuMTMpDkR9tucUu7qLlu8sWM04=;
        b=12dqb9m+bO20ahd7wQ32KjwkW8ss3FWDkLmpC/2gcCDSnV0eRYPB5Zq1iaFtnTT5jh
         rvUuLnkb/xxsqfaZl0kB/kIfOyHIz56nuN02gpxjPQGso0IN3038bUn8Nsu2UEVE5UcK
         UWPGPsQBzgaMxGYFGwjuSI/4iKniADC+8Fu74H5QKcs4oOGFnHbRTuz9HxsFQe8xoh8o
         ANRP4yzSxBFRdR5yYriQzi4NLe3Umiw7GNa5nkkF6TbsvkfvFJ0bWOtIOWKoqLNPsb05
         ad3baJ2kEZ6Vzh0UakdvzD1b+gMfDneuuwVB+i6U2F66igCSWNpe3h5R5lAiy4/rZX25
         orZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749161515; x=1749766315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ihE80hjZVxwRnd93NuMTMpDkR9tucUu7qLlu8sWM04=;
        b=GCC3CLO70lCPLX18Zim7k/zu68JYE2h24GXpYSl0myImegQVzO+mB2jtZxkGCEXmcw
         ewf5SHJ/v4cYjvrz0gIOH4SNbmik0hs1yClPd4PascRCErQ+DO3jtsYb3SOgJkTz4lnX
         PaS8Hvdigu/4QBVBu1dVQFI5tBtPOd/FdIxu/tRKQR09H6wEBtWW8xSi233mYrLf1ZHC
         d3tXJkuyzi+yvvRko6MdY3T5QO5Docr3wbdHbAZEex+hE0BhwzgplOzF05ydWj4bQh8+
         PxUtpNYZRUdff3MR4kc14nlW1oqtCk1zIdyxJQcXw6Vk47/a/U7VFb3f1JDd+uEO7Fe6
         LHyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdWbD/1ziqD8n9Kwcj9zKnmKrLn95EEHyFG3Nf0QbkBtmcqOGJA1tO9eqKxh/FIaMsLavOSpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEvkJMZHKPJJVOPIFLILbjmuqVdv1gq+c3HoqVgAZV3EubTrB0
	RoHlUDD4j6Mqra+b5fijj3297//nCG6bDv6iPAEmpR+10+QrL7S03+JgPEX5ZKkVVX7NeETxodC
	g4qEBz8P9MVDzU+neGIlDr8rOqB/loukPfXo8FVHu
X-Gm-Gg: ASbGncu9gthGSnQ4DlA71R+4z7iY5bN11R90EXBhRevC59IkWeYwn08FdUEiiZQCgWM
	vJOSoLM2cnpUvOcznpBoJVdptA8YixlUnSNysYyWUtQcXWRQLUdunE/t3y0MGqjWIV26vgSV5U7
	bETFWZYWVDSarQzz2Pub2VTHC2DKOkW7UqtzY234b4Gg==
X-Google-Smtp-Source: AGHT+IHlJzvolYW98aXTfeyuv2pATqwuYW7vhIFciqojIZ4XHbgLhP4rJTpwPHOpJ2GA+8qoZDKdNQurut8TCSpSZg0=
X-Received: by 2002:a05:622a:4d85:b0:4a3:1b23:2862 with SMTP id
 d75a77b69052e-4a5b9dd6e44mr23952781cf.50.1749161515059; Thu, 05 Jun 2025
 15:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9da42688-bfaa-4364-8797-e9271f3bdaef@hetzner-cloud.de>
 <87zfemtbah.fsf@toke.dk> <CANn89i+7crgdpf-UXDpTNdWfei95+JHyMD_dBD8efTbLBnvZUQ@mail.gmail.com>
In-Reply-To: <CANn89i+7crgdpf-UXDpTNdWfei95+JHyMD_dBD8efTbLBnvZUQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 5 Jun 2025 15:11:43 -0700
X-Gm-Features: AX0GCFu7qvbmaAXvQ_Cf4hUkvMm5HQpqCLgrLfmyA2lfuALjsLDUhKGTPKh5Uy4
Message-ID: <CANn89iKpZ5aLNpv66B9M4R1d_Pn5ZX=8-XaiyCLgKRy3marUtQ@mail.gmail.com>
Subject: Re: [BUG] veth: TX drops with NAPI enabled and crash in combination
 with qdisc
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 9:46=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Jun 5, 2025 at 9:15=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
> >
> > Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de> writes:
> >
> > > Hi,
> > >
> > > while experimenting with XDP_REDIRECT from a veth-pair to another int=
erface, I
> > > noticed that the veth-pair looses lots of packets when multiple TCP s=
treams go
> > > through it, resulting in stalling TCP connections and noticeable inst=
abilities.
> > >
> > > This doesn't seem to be an issue with just XDP but rather occurs when=
ever the
> > > NAPI mode of the veth driver is active.
> > > I managed to reproduce the same behavior just by bringing the veth-pa=
ir into
> > > NAPI mode (see commit d3256efd8e8b ("veth: allow enabling NAPI even w=
ithout
> > > XDP")) and running multiple TCP streams through it using a network na=
mespace.
> > >
> > > Here is how I reproduced it:
> > >
> > >   ip netns add lb
> > >   ip link add dev to-lb type veth peer name in-lb netns lb
> > >
> > >   # Enable NAPI
> > >   ethtool -K to-lb gro on
> > >   ethtool -K to-lb tso off
> > >   ip netns exec lb ethtool -K in-lb gro on
> > >   ip netns exec lb ethtool -K in-lb tso off
> > >
> > >   ip link set dev to-lb up
> > >   ip -netns lb link set dev in-lb up
> > >
> > > Then run a HTTP server inside the "lb" namespace that serves a large =
file:
> > >
> > >   fallocate -l 10G testfiles/10GB.bin
> > >   caddy file-server --root testfiles/
> > >
> > > Download this file from within the root namespace multiple times in p=
arallel:
> > >
> > >   curl http://[fe80::...%to-lb]/10GB.bin -o /dev/null
> > >
> > > In my tests, I ran four parallel curls at the same time and after jus=
t a few
> > > seconds, three of them stalled while the other one "won" over the ful=
l bandwidth
> > > and completed the download.
> > >
> > > This is probably a result of the veth's ptr_ring running full, causin=
g many
> > > packet drops on TX, and the TCP congestion control reacting to that.
> > >
> > > In this context, I also took notice of Jesper's patch which describes=
 a very
> > > similar issue and should help to resolve this:
> > >   commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ri=
ng to
> > >   reduce TX drops")
> > >
> > > But when repeating the above test with latest mainline, which include=
s this
> > > patch, and enabling qdisc via
> > >   tc qdisc add dev in-lb root sfq perturb 10
> > > the Kernel crashed just after starting the second TCP stream (see out=
put below).
> > >
> > > So I have two questions:
> > > - Is my understanding of the described issue correct and is Jesper's =
patch
> > >   sufficient to solve this?
> >
> > Hmm, yeah, this does sound likely.
> >
> > > - Is my qdisc configuration to make use of this patch correct and the=
 kernel
> > >   crash is likely a bug?
> > >
> > > ------------[ cut here ]------------
> > > UBSAN: array-index-out-of-bounds in net/sched/sch_sfq.c:203:12
> > > index 65535 is out of range for type 'sfq_head [128]'
> >
> > This (the 'index 65535') kinda screams "integer underflow". So certainl=
y
> > looks like a kernel bug, yeah. Don't see any obvious reason why Jesper'=
s
> > patch would trigger this; maybe Eric has an idea?
> >
> > Does this happen with other qdiscs as well, or is it specific to sfq?
>
> This seems like a bug in sfq, we already had recent fixes in it, and
> other fixes in net/sched vs qdisc_tree_reduce_backlog()
>
> It is possible qdisc_pkt_len() could be wrong in this use case (TSO off ?=
)

This seems to be a very old bug, indeed caused by sch->gso_skb
contribution to sch->q.qlen

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index b912ad99aa15d95b297fb28d0fd0baa9c21ab5cd..77fa02f2bfcd56a36815199aa2e=
7987943ea226f
100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -310,7 +310,10 @@ static unsigned int sfq_drop(struct Qdisc *sch,
struct sk_buff **to_free)
                /* It is difficult to believe, but ALL THE SLOTS HAVE
LENGTH 1. */
                x =3D q->tail->next;
                slot =3D &q->slots[x];
-               q->tail->next =3D slot->next;
+               if (slot->next =3D=3D x)
+                       q->tail =3D NULL; /* no more active slots */
+               else
+                       q->tail->next =3D slot->next;
                q->ht[slot->hash] =3D SFQ_EMPTY_SLOT;
                goto drop;
        }

