Return-Path: <netdev+bounces-242828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46050C952A3
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 17:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F423A3150
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 16:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7DF27EFE9;
	Sun, 30 Nov 2025 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmKGkXzG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C58E1B4F0A
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764521889; cv=none; b=sqbObd33OFnIYylUnPE17z4nyluJn9Rl8XP7nZqTrajLw8NSUHIUYDDYb4yDo/41cZ33tKSxcvnwY7Bm9nnF7Xo3f2m2yH1JytseCHhEvFZm3v+20GYvgGuFaTgrfjJxy5+Pz5ewvR5j1nIApaUHOrcQ109mdFGELclNbzKRv2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764521889; c=relaxed/simple;
	bh=CfXU5UjrNMh8jeSLQlNdscDhrMMXtyq5AFg3UzBU5h4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ek5wusOUER5a7KxSOTjYV7WRsZi+joF/Pd6JX2Mq2lFgWxjaKVkQ6UOuZK6Ecl05eplESBxca2W13vpp3aPItNNLO9kJEJlxT1r/mGoQZvL4jtCJQ436xi8odLB5mtVU2cZ25bvDpP1B8exWyQG5TTq6+8Jauy1kMs4nw1dHTdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmKGkXzG; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-640e065991dso2693245d50.3
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 08:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764521886; x=1765126686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0pM2tOIKARyUScLUv8P7Syt5GLsdtd8jm51t8qeyVE=;
        b=GmKGkXzGGZIkV09dgXbGH2jDDgdI3b4gYhbwlCyBTloV7XA5rreOvUzTA6nphSuXiO
         lhfrxVrsGt5kg+C35F72GayoLEL2Fm2bP6Z7WE3ipMk/bKCW9b+nO+sbo3DQly/GrFzf
         fRV03Nrn3c9pTaOehpruogqqVYhs+QpETXdszm9qtLrt2WuRb2beuXUYxdmRfvXwv1Bz
         8bS7NP2OH3FmgtwRVPO3sS+rztR8sMHPH/C7Qs5wf5VBT1vb5/ozeKZOFfV6fq28b6Oh
         SezdQfcWedfqPdWBxpP2kN8DFV751tZhBJGaIDtulotaJvyoKacMN+rqvo72KiK8SNO5
         y5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764521886; x=1765126686;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U0pM2tOIKARyUScLUv8P7Syt5GLsdtd8jm51t8qeyVE=;
        b=KZ5nqWTEVh/0AIt9+R6ygZ+l8xl5jxVIjj7T5T6dsiA393TU/msDHYaL/iVI89nIj8
         +UXLnqz7dnnboT92Jlx9rtZhRKN7Z6F8hF827Jq7pKxSjzIc08uykf2D18stDHeuOomj
         mLXVk/BhDoBAOlDrWH2swOMi/nr3zJRjqja5S2QTqmvmrse8ostJy5jzTaouN8QIq7Yg
         wzqUImOio5g5RWDvUC+yhlmjFqLVKe5cZmlF+Sq//vLoXPi/kVvX0aaY188yMZqSAb4m
         YI4Cht4Wf7C7G8xpUyPCL+WMdDDEA2UfpmDdJSu+e7GHp2eR1xGSiEiu/Elf1VQrWNM9
         PMcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCZumS77xcJlqo6b4BRrKWfHyLACU3bDM7n+/vasf21E9E2dRHdRMJE56AmYTR6+ofdRpGypM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoETZSPeyxbWtuWpINjV/9sn3SjqB6StOzgSKyymYzAYk89HBV
	QFHKSYcCmnKYHETbvc86QjI8dbzL5EIzB3V3jGd8CvEM4WkZI4HwoOTl
X-Gm-Gg: ASbGncuzh01fjQZ9jP8ZI2FnwHh7PnOvCe3C63MNxRmBklFLxa+x6py5LrjNVz9A4cZ
	dxDuWQWpGJ42q13Mw3HM4uz6SY07J0qHpDMr82rmCuVpqeIiqvzKqEuqoLGtoid3UYpJrb8T7vN
	geZBqCBpeHPVJj2efBIWFGiQ4pBYq8ZnEKu9bd97/wTT6YNtq8lKYHbu675u0xF60/LqbYEmTur
	mIJO/BezgUWjqZ0THdHL8Mcbf7l7UwbAUkRGGdg8jbQr3KwLsQTKqy2FYf1TctQFAEAjwO6mk73
	2CWSzdPhlf6Msc+gBYGU5wZ2MquniZDLwZHY15oV0UDXnSYDrBc2p/85BR0P2/0E8PfdJL6yLeB
	jcD67HSy3tqMjdbO1OrdCWLQGINkOhd1wiJ9vACrI0SwQA58Zg0xTokKOc1lmHBpI2URmZBDTTO
	vUw9RNEY7kskIRCu0LSAHyLqrz3oVTj+toItf0PhtBwwwvzJNKuQr4L+ZdC+wqwjZzBX4=
X-Google-Smtp-Source: AGHT+IF3rgBa1ZcQ/kU4IUpA3oBhV19YeCk8Jh6DRPERGlRUlXwMw433U6ZZLF9efabXoGwSWtpkKw==
X-Received: by 2002:a05:690c:3510:b0:781:4b2d:7261 with SMTP id 00721157ae682-78a8b52932cmr257020527b3.41.1764521886147;
        Sun, 30 Nov 2025 08:58:06 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78ad0d3f5bbsm38926397b3.7.2025.11.30.08.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 08:58:05 -0800 (PST)
Date: Sun, 30 Nov 2025 11:58:05 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: =?UTF-8?B?Sm9uYXMgS8O2cHBlbGVy?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.69fe80979368@gmail.com>
In-Reply-To: <87tsyba3wx.fsf@toke.dk>
References: <20251127-mq-cake-sub-qdisc-v2-0-24d9ead047b9@redhat.com>
 <20251127-mq-cake-sub-qdisc-v2-2-24d9ead047b9@redhat.com>
 <willemdebruijn.kernel.2e44851dd8b26@gmail.com>
 <87a505b3dt.fsf@toke.dk>
 <willemdebruijn.kernel.352b3243bf88@gmail.com>
 <87zf84ab2d.fsf@toke.dk>
 <willemdebruijn.kernel.12cce168f29d0@gmail.com>
 <87tsyba3wx.fsf@toke.dk>
Subject: Re: [PATCH net-next v2 2/4] net/sched: sch_cake: Add cake_mq qdisc
 for using cake on mq devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> writes:
> =

> > Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> Willem de Bruijn <willemdebruijn.kernel@gmail.com> writes:
> >> =

> >> > Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> >> Willem de Bruijn <willemdebruijn.kernel@gmail.com> writes:
> >> >> =

> >> >> > Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> >> >> Add a cake_mq qdisc which installs cake instances on each hard=
ware
> >> >> >> queue on a multi-queue device.
> >> >> >> =

> >> >> >> This is just a copy of sch_mq that installs cake instead of th=
e default
> >> >> >> qdisc on each queue. Subsequent commits will add sharing of th=
e config
> >> >> >> between cake instances, as well as a multi-queue aware shaper =
algorithm.
> >> >> >> =

> >> >> >> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >> >> >> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.c=
om>
> >> >> >> ---
> >> >> >>  net/sched/sch_cake.c | 214 ++++++++++++++++++++++++++++++++++=
++++++++++++++++-
> >> >> >>  1 file changed, 213 insertions(+), 1 deletion(-)
> >> >> >
> >> >> > Is this code duplication unavoidable?
> >> >> >
> >> >> > Could the same be achieved by either
> >> >> >
> >> >> > extending the original sch_mq to have a variant that calls the
> >> >> > custom cake_mq_change.
> >> >> >
> >> >> > Or avoid hanging the shared state off of parent mq entirely. Ha=
ve the
> >> >> > cake instances share it directly. E.g., where all but the insta=
nce on
> >> >> > netdev_get_tx_queue(dev, 0) are opened in a special "shared" mo=
de (a
> >> >> > bit like SO_REUSEPORT sockets) and lookup the state from that
> >> >> > instance.
> >> >> =

> >> >> We actually started out with something like that, but ended up wi=
th the
> >> >> current variant for primarily UAPI reasons: Having the mq variant=
 be a
> >> >> separate named qdisc is simple and easy to understand ('cake' get=
s you
> >> >> single-queue, 'cake_mq' gets you multi-queue).
> >> >> =

> >> >> I think having that variant live with the cake code makes sense. =
I
> >> >> suppose we could reuse a couple of the mq callbacks by exporting =
them
> >> >> and calling them from the cake code and avoid some duplication th=
at way.
> >> >> I can follow up with a patch to consolidate those if you think it=
 is
> >> >> worth it to do so?
> >> >
> >> > Since most functions are identical, I do think reusing them is
> >> > preferable over duplicating them.
> >> =

> >> Sure, that's fair. Seems relatively straight forward too:
> >> =

> >> https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commi=
t/?h=3Dmq-cake-sub-qdisc&id=3Dfdb6891cc584a22d4823d771a602f9f1ee56eeae
> >
> > Great. That's good enough for me.
> =

> Cool. I folded it into the series, and it does make the patch a lot
> simpler, so thank you for the suggestion!
> =

> >> > I'm not fully convinced that mq_cake + cake is preferable over
> >> > mq + cake (my second suggestion). We also do not have a separate
> >> > mq_fq, say. But mine is just one opinion from the peanut gallery.
> >> =

> >> Right, I do see what you mean; as I said we did consider this initia=
lly,
> >> but went with this implementation from a configuration simplicity
> >> consideration. =

> >
> > Then admins have only to install one qdisc, rather than what we do fo=
r
> > FQ today which is one MQ + a loop over the FQs.
> >
> > I don't know if we have to coddle admins like that.
> =

> I don't really view it as coddling, but as making it as easy as possibl=
e
> to take advantage of the mq variant in the most common configuration.
> The primary use case for cake is shaping on the whole link (on home
> routers, in particular), and the mq extension came about to address the=

> common bottleneck here where the cake shaper can't keep up with link
> speeds on a single CPU. So I think it's worthwhile to make it as easy a=
s
> possible to consume that seems worthwhile, in a way that retains
> compatibility with the existing tools that work on top of cake, such as=

> the autorate scripts:
> =

> https://github.com/sqm-autorate/sqm-autorate
> =

> >> If we were to implement this as an option when running
> >> under the existing mq, we'd have to add an option to cake itself to =
opt
> >> in to this behaviour, and then deal with the various combinations of=

> >> sub-qdiscs being added and removed (including mixing cake and non-ca=
ke
> >> sub-qdiscs of the same mq). And userspace would have to setup the mq=
,
> >> then manually add the cake instances with the shared flag underneath=
 it.
> >
> > One question is whether the kernel needs to protect admins from doing=

> > the unexpected thing, which would be mixing mq children of different
> > type when using shared cake state between children.
> >
> > Honestly, I don't think so. But it could be done. For instance by
> > adding an mq option that requires all children to be of the same kind=
,
> > or even by silently setting this if the first child added is a cake
> > instance with shared option set.
> >
> > As for shared state, in cake_init the qdisc could check that the dev
> > root is mq and it is a direct child of this qdisc, and then scan the
> > mq children for the existence of a cake child. If one exists, take a
> > ref on a shared state struct. If not, create the struct. Again, like
> > SO_REUSEPORT.
> >
> > All easier said than implemented, of course, but seems doable?
> =

> Yeah, I do think it's doable; just needs a bit of thought around the
> lifetime management of the shared config struct as sub-qdiscs come and
> go.
> =

> I am not necessarily opposed to supporting this mode, including the cas=
e
> where there's a mix of qdiscs on different HW queues. However, I view i=
t
> as an extension of the base use case, as described above. Now that we'r=
e
> reusing the mq code, cake_mq becomes quite a lightweight addition, so w=
e
> could potentially support both? I.e., the cake_mq qdisc would be the
> straight-forward way to load cake across a device, but we could add
> support for sharing cake state across (a subset of) regular mq as well?=

> WDYT?

I'd only plan to do it once, do it right.

mq_cake has the advantage of being simpler to configure.

The alternative that it allows more configurations. But we don't
immediately see real use cases for those.

Your call, assuming no one else chimes in.

