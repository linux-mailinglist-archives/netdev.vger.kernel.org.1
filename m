Return-Path: <netdev+bounces-242814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 270BBC950AC
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 16:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE4934E020B
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 15:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EA1226D17;
	Sun, 30 Nov 2025 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koOX+Ar3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE4E273F9
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764515241; cv=none; b=UXOHxim4oJ5n63tlwZw9RSHe7kgGlecUOwf1Cl8BO3EVIxOmmZrKvFVBsaGl9p634+nTT4qpWQnfCI9JFKnP65J1rOwYa05gCH9mRQirzrJ61Zex06VedjybgwTdfY1yszDcHtObZKI+PcmL0byj9vJ0iN+2vQOiGaSY3UcEY/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764515241; c=relaxed/simple;
	bh=HFjCbhBOxNOYKPrlVIuMLZXavKBeUXNAPzUNniUGaO4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=peW+Ndv+/y/7Q+oIWopGpshp8smkP3yNeBkYG2cSnzMgk/64fp/Eg2HNQa10Ub4Uk4+ptvZtvA1Jnl/MIiqfsOoFGfd/yzMyfQdWF5EH+5C0Wzh8lEDGkeIe2AHbsdKECuo2Sfq4FoSXUBhMuiBEZNAqiJY03nIQbsN1chGdXbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koOX+Ar3; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-787e84ceaf7so30204817b3.2
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 07:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764515238; x=1765120038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itd4PosqC2kQ6zrsIqy/TPRszeArCm4Xh6ukzxPw+Yo=;
        b=koOX+Ar3FfrhxH+nQNhVcOSyzBPRK9eebi/OsIX0mgCaoUuABw6U+y7lNgPeDz3teX
         7926uok2aysMO0/z44Z/uwQSSh/AY7FfDb9J18dIXin4o10Cp7JlKprSE0LmzYwhg90W
         uUxi+g2iPjhnXerHx7vjqxvcQDfWjWB5q8cxgwofdQwNrZVmV76hn4b660mImDlcv5QP
         70evPtU5Mq6LgYittByqsnkF+3Ugf8xqIM1zaxMeuYo3lTDGDoxd+Ius8mhn34pQseFR
         ZcEzBEjPSXbadBgrR3RFznSplP7kl2yP4xzMcpw6UBg/zs+fRI5bHBiYvQWKWgNWawLz
         XvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764515238; x=1765120038;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=itd4PosqC2kQ6zrsIqy/TPRszeArCm4Xh6ukzxPw+Yo=;
        b=whdyiGFW1vsVp86dhQmrRJE7xrVf3UiKmIy4HGlJeilNY0R+5If59Y6H/DHyg9cAci
         vAbYkV+XLhdta9Us0P2SaLDGdajD5kvJ0Tvu9HFIM12tqPae7JmJhFHyLsjQ4DNZ5KGd
         ZrB4SdLTY2gEYe8qKHT/1zho3njAEb/HEeh4TpqxjRjO3bjnjNXHXMwkmUg6FJMgs8p5
         1FASNlEZw0pLZpKTXXvgcT/FhoXXGvu7UDlKtGnZny8IQ6ohSqGnwD3qKg5EB6SYGmEF
         P8vbZkxXK55Z2QuzIO2jcS7hMH37I1lY/Y3/bNzpQoRzklLnFzwHyklEPkJEkSVJr6ze
         r4MA==
X-Forwarded-Encrypted: i=1; AJvYcCUXgnsM8Avh5M32NxK5I4IugMc3BwiljmYPRxc/sEfrM20tvXvyBuw5C/cfz6ZsYM464DOkhvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrLc+fDYkGSaxkdNYXY8g23kPI6EV2lSvuCKVxUC52sHvsBUmj
	cxtwJ3KcPQFb9mGT8g+Mh7JODZPsucBiLdpUz91e6X75FRrC3HPdNqtw
X-Gm-Gg: ASbGncswdENZiWvhVgFo20pyPNNxquCD3djblgnwOKmJC+7WJUvJ9dKVqIeDhRDyAsr
	XGabsAzZogNI1/zyUeOqcrU1XK+jYt42P2Q/hbGZIN0xOTrgpObk8FYJ0BInALbjQIVo5KiejyI
	J3oi1Cslz/DDmFmmVy0X3+8JKBW/h10D4tfy4GnsL/dyzVbtonhNYRBPEQMUqGLVW1AYj6TUsXh
	FCi5U9mZJsBfP2Mkx1d0WrxoOOU8E58Ihdw9zORWzPR8sgNZMSFt1JdCj0bUKxIZGcQwzI8esO7
	6i7d/9JGc0Te7GsI6QCm86sdwA/4I6vyReZmSeAFDaN8cE5pmM22q+WUYcHrxhTe8HCZD8DaM2X
	03X5WkBboi4k8/QhTOwoc1ixIdAq0MWvrNcuM5JqbYWYk/2S8Fb8qbEenG9j+JegIVXWDbNIHRj
	n9IxQzxFSp3LxaxPD8qjGianCIIuX2gmKLqdwwz2fAxKABo3oMlDBRRJtdUuF0svIgxF9JDsY5R
	Kyqvw==
X-Google-Smtp-Source: AGHT+IG60qUorMUgYcasY4EIKb1vnjohAXAd1P97tCZqWlM1nclAgl4uc4LJSWiAP/p0TAS5iyCAsg==
X-Received: by 2002:a05:690c:6c0e:b0:788:1cde:cad4 with SMTP id 00721157ae682-78a8b4720c1mr290681297b3.19.1764515238523;
        Sun, 30 Nov 2025 07:07:18 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78ad0d3f600sm37931137b3.9.2025.11.30.07.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 07:07:17 -0800 (PST)
Date: Sun, 30 Nov 2025 10:07:17 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
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
Message-ID: <willemdebruijn.kernel.12cce168f29d0@gmail.com>
In-Reply-To: <87zf84ab2d.fsf@toke.dk>
References: <20251127-mq-cake-sub-qdisc-v2-0-24d9ead047b9@redhat.com>
 <20251127-mq-cake-sub-qdisc-v2-2-24d9ead047b9@redhat.com>
 <willemdebruijn.kernel.2e44851dd8b26@gmail.com>
 <87a505b3dt.fsf@toke.dk>
 <willemdebruijn.kernel.352b3243bf88@gmail.com>
 <87zf84ab2d.fsf@toke.dk>
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
> >> >> Add a cake_mq qdisc which installs cake instances on each hardwar=
e
> >> >> queue on a multi-queue device.
> >> >> =

> >> >> This is just a copy of sch_mq that installs cake instead of the d=
efault
> >> >> qdisc on each queue. Subsequent commits will add sharing of the c=
onfig
> >> >> between cake instances, as well as a multi-queue aware shaper alg=
orithm.
> >> >> =

> >> >> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >> >> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>=

> >> >> ---
> >> >>  net/sched/sch_cake.c | 214 +++++++++++++++++++++++++++++++++++++=
+++++++++++++-
> >> >>  1 file changed, 213 insertions(+), 1 deletion(-)
> >> >
> >> > Is this code duplication unavoidable?
> >> >
> >> > Could the same be achieved by either
> >> >
> >> > extending the original sch_mq to have a variant that calls the
> >> > custom cake_mq_change.
> >> >
> >> > Or avoid hanging the shared state off of parent mq entirely. Have =
the
> >> > cake instances share it directly. E.g., where all but the instance=
 on
> >> > netdev_get_tx_queue(dev, 0) are opened in a special "shared" mode =
(a
> >> > bit like SO_REUSEPORT sockets) and lookup the state from that
> >> > instance.
> >> =

> >> We actually started out with something like that, but ended up with =
the
> >> current variant for primarily UAPI reasons: Having the mq variant be=
 a
> >> separate named qdisc is simple and easy to understand ('cake' gets y=
ou
> >> single-queue, 'cake_mq' gets you multi-queue).
> >> =

> >> I think having that variant live with the cake code makes sense. I
> >> suppose we could reuse a couple of the mq callbacks by exporting the=
m
> >> and calling them from the cake code and avoid some duplication that =
way.
> >> I can follow up with a patch to consolidate those if you think it is=

> >> worth it to do so?
> >
> > Since most functions are identical, I do think reusing them is
> > preferable over duplicating them.
> =

> Sure, that's fair. Seems relatively straight forward too:
> =

> https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?=
h=3Dmq-cake-sub-qdisc&id=3Dfdb6891cc584a22d4823d771a602f9f1ee56eeae

Great. That's good enough for me.
 =

> > I'm not fully convinced that mq_cake + cake is preferable over
> > mq + cake (my second suggestion). We also do not have a separate
> > mq_fq, say. But mine is just one opinion from the peanut gallery.
> =

> Right, I do see what you mean; as I said we did consider this initially=
,
> but went with this implementation from a configuration simplicity
> consideration. =


Then admins have only to install one qdisc, rather than what we do for
FQ today which is one MQ + a loop over the FQs.

I don't know if we have to coddle admins like that.

> If we were to implement this as an option when running
> under the existing mq, we'd have to add an option to cake itself to opt=

> in to this behaviour, and then deal with the various combinations of
> sub-qdiscs being added and removed (including mixing cake and non-cake
> sub-qdiscs of the same mq). And userspace would have to setup the mq,
> then manually add the cake instances with the shared flag underneath it=
.

One question is whether the kernel needs to protect admins from doing
the unexpected thing, which would be mixing mq children of different
type when using shared cake state between children.

Honestly, I don't think so. But it could be done. For instance by
adding an mq option that requires all children to be of the same kind,
or even by silently setting this if the first child added is a cake
instance with shared option set.

As for shared state, in cake_init the qdisc could check that the dev
root is mq and it is a direct child of this qdisc, and then scan the
mq children for the existence of a cake child. If one exists, take a
ref on a shared state struct. If not, create the struct. Again, like
SO_REUSEPORT.

All easier said than implemented, of course, but seems doable?

> Whereas with this cake_mq qdisc the user interface is as simple as
> possible: just substitute 'cake_mq' for 'cake' if you want the
> multi-queue behaviour on a device; everything else stays the same. Sinc=
e
> configuration simplicity is an explicit goal of cake, I think this is
> appropriate; although it may not be for other qdiscs.
> =

> Hope that makes sense?
> =

> -Toke



