Return-Path: <netdev+bounces-291687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJXZJ1+WFWp9WgcAu9opvQ
	(envelope-from <netdev+bounces-291687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:47:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFE55D5BF0
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3351930091C7
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05DF202C46;
	Tue, 26 May 2026 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajvfM8AI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F8E199FAC
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 12:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799640; cv=none; b=eF3HK3QZxifvG+HuJXjHz0tYp1qr2KzWB3ak7ldW/qdOtnhh1u4nFmxlylv+NljBeWQVYUjZKm4LkuHKfWMnuiUftI6UUjm4c7/ssQBQG2cISWT1RqNSXYZR+nTdYmPP+p/IQ3pGwWwBim8LZwrZuE7E+kSmfsNhj4GrIlS/t98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799640; c=relaxed/simple;
	bh=hMcRAkYldHJ78uX0deYIHqN6LL8j+EL56qjjoEgiwwA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsqey11JbOq/LHEM1pJQX/y4lUz2YGhcRnDdp6egKccQMLkCi27iof647BWE7srhSMagInLf3Hyo5PiL4w9KVNxKN1eVhMAwA4VlYTso38hCXYfsTDN4R670FKedUMToGGhHW2NjBRpH3DmMi3/Q/z/d95vmTCoc4wcQi0KnLOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajvfM8AI; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d73422431so7463370f8f.2
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 05:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779799637; x=1780404437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcEqXbrIbOE1ZYxntxe5FIRRwiUUUrNk8UQv35w52MU=;
        b=ajvfM8AIFOut+CyUoYFPzEjQVgG0Fo8sThEO+/MeIgDylpQm1RcigzV7muqwz3n/GC
         eKXFnv87KTqkldPbELh9rfTxfljTiBPYbi6zKqpdsO9NB34/XK+EgWzjULOrE5sauIxc
         yUtukd/laK1MiFH9PkCJ6/TZmBfFcMR3XmSLKuXZXjoyrrif30pNg2+XUGDJaI8oe23E
         7EGj1MLuBL4dSwm4tp9W/9O+m/57vDRfLTSoPJd781WStyxZfBGgWsiAEtOw4BJ6V5Xd
         MJZsWjVT4Icz6yw32dfwm0TTaMlHBmiIOjI9WuWxMTmxdCaizjdnvSOXE3fRyAl8smAE
         VTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779799637; x=1780404437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZcEqXbrIbOE1ZYxntxe5FIRRwiUUUrNk8UQv35w52MU=;
        b=ALd55pdEn0CALF59mYI5YVYPby77sCkZ7YRdRbWQyNAYHgavZPh/9ID2ROd5lbxmJn
         QFAboru/1Ppt9X2hA9kEKcF45X9SBelOGmyxTfP5atbp2VSj/qOMb/RxKc8JqV5/s5/C
         HM2Yj5RoU4OyVrV6lDV5DsfTRadbTz0rK+cYxvVKBGs7Roe/spHThIlepI0QeaB3mZ8Y
         JZyFY+I7fo2ZndLpBbWzqDSh0T39d55OT3GnXhym4NYswM/mxOv9APKbNLRj2+3sI1sv
         EciEGdk/2SopVxIicJ67Q1Eo520SZKSWicL90e19I/FEjOIw5zsa29Cg5tzhP8565a7X
         8yJw==
X-Forwarded-Encrypted: i=1; AFNElJ8DDrRfbtmpPz7KrB9liP5lYKX1LwzXFP4UQMgA33zYjuMMKSqZcJrxyDcZ2xm/qp2k0BvYwXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFIyARHMjUG+Mfy7hdurByp7HsyFJ5hXzQCOAv8lOzgwDaTPac
	y0MuJn2dwnd4m3lGAdIeUjr/uzLbFxybcWxOMAf75DhN1FYrrzO7QdK8mY2Vqd32
X-Gm-Gg: Acq92OFWLQeQ6LRYf6nhTMwfFVH7oVmqRjPrhgckRxSvtEZbpqt31CumQgZ92tJqYJY
	yZOmeex1fORBhewsSPQ53z911XEEgD2/0darkac+kkCBfT/nbqlXJWC29DNQbMtdAu4zl8Na7H0
	JJTSs9Wc0tORxz0qY9Zg9p4ct+uqPrDpId6quW5jXKHBBcSxrJWFyuWeIPQSE/ZFgYF9NsFpaDz
	viqiNgGMEcx7Wcri/pbXKTBHYrK4s4pbSwz6/rwh3l9PptsPEgULS7y38VesFdap0uQPoZjYmuc
	SkZM19cL7NqiLq9V94qq0/dCw8DmVFDEGqehwQ9FPVRpUYZpU9UxI0Bt8nycNdwwfxr/1GdryNG
	n56fwBmIc71O2U0kq1M9tI+x2GHr5lQrIga474d7PerZz60Xgl7jEH3pDyAsibt0tG5IKGNhhKX
	lza9cMTy7GYczgInF5QziUozANgZyojrCbWALZNfDZeips+rhSCcVcIL8HP1Qp8+bnTbqJTNjaD
	a0=
X-Received: by 2002:a5d:59c4:0:b0:44a:9b52:8891 with SMTP id ffacd0b85a97d-45eb36909d9mr27773186f8f.11.1779799637018;
        Tue, 26 May 2026 05:47:17 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d493dfsm36096114f8f.23.2026.05.26.05.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 05:47:16 -0700 (PDT)
Date: Tue, 26 May 2026 13:47:15 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Rajat Gupta <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 yimingqian591@gmail.com, keenanat2000@gmail.com, 2045gemini@gmail.com,
 rollkingzzc@gmail.com
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
Message-ID: <20260526134715.49d0f4a3@pumpkin>
In-Reply-To: <CAM0EoMmNnPj-UO_7PN2Z3vaWKSqo4M6PzcSnn80Kzm_H1JTptA@mail.gmail.com>
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
	<20260519033950.2037-1-rajat.gupta@oss.qualcomm.com>
	<20260526105306.48a2bee7@pumpkin>
	<CAM0EoMmNnPj-UO_7PN2Z3vaWKSqo4M6PzcSnn80Kzm_H1JTptA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291687-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ABFE55D5BF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 08:01:08 -0400
Jamal Hadi Salim <jhs@mojatatu.com> wrote:

> On Tue, May 26, 2026 at 5:53=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Mon, 18 May 2026 20:39:50 -0700
> > Rajat Gupta <rajat.gupta@oss.qualcomm.com> wrote:
> > =20
> > > tcf_pedit_act() computes the COW range for skb_ensure_writable()
> > > once before the key loop using tcfp_off_max_hint, but the hint does
> > > not account for the runtime header offset added by typed keys. This
> > > can leave part of the write region un-COW'd.
> > >
> > > Fix by moving skb_ensure_writable() inside the per-key loop where
> > > the actual write offset is known, and add overflow checking on the
> > > offset arithmetic. For negative offsets (e.g. Ethernet header edits
> > > at ingress), use skb_cow() to COW the headroom instead. Guard
> > > offset_valid() against INT_MIN, where negation is undefined.
> > >
> > > Additionally, linearize skbs with shared frags upfront to prevent
> > > silent data corruption when pedit operates on zero-copy pages
> > > (e.g. from sendfile).
> > >
> > > Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is =
writable")
> > > Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> > > Reported-by: Yiming Qian <yimingqian591@gmail.com>
> > > Reported-by: Keenan Dong <keenanat2000@gmail.com>
> > > Reported-by: Han Guidong <2045gemini@gmail.com>
> > > Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> > > Tested-by: Han Guidong <2045gemini@gmail.com>
> > > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> > > ---
> > >  net/sched/act_pedit.c | 54 ++++++++++++++++++++++++++++++++---------=
--
> > >  1 file changed, 41 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > > index bc20f08a2..79921b8d8 100644
> > > --- a/net/sched/act_pedit.c
> > > +++ b/net/sched/act_pedit.c
> > > @@ -16,6 +16,7 @@
> > >  #include <linux/ip.h>
> > >  #include <linux/ipv6.h>
> > >  #include <linux/slab.h>
> > > +#include <linux/overflow.h>
> > >  #include <net/ipv6.h>
> > >  #include <net/netlink.h>
> > >  #include <net/pkt_sched.h>
> > > @@ -323,8 +324,10 @@ static bool offset_valid(struct sk_buff *skb, in=
t offset)
> > >       if (offset > 0 && offset > skb->len)
> > >               return false;
> > >
> > > -     if  (offset < 0 && -offset > skb_headroom(skb))
> > > -             return false;
> > > +     if (offset < 0) {
> > > +             if (offset =3D=3D INT_MIN || -offset > skb_headroom(skb=
))
> > > +                     return false;
> > > +     } =20
> >
> > Can't you negate skb_headroom() instead - that cannot be INT_MIN.
> > So:
> >         if (offset < 0 && offset < -skb_headroom(skb))
> > =20
>=20
> You mean something like this? if (offset < 0 && offset <
> -(int)skb_headroom(skb))
>  That does feel cleaner, yes.

yes - it does need the cast...

-- David

>=20
> > >
> > >       return true;
> > >  }
> > > @@ -393,17 +396,21 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_b=
uff *skb,
> > >       struct tcf_pedit_key_ex *tkey_ex;
> > >       struct tcf_pedit_parms *parms;
> > >       struct tc_pedit_key *tkey;
> > > -     u32 max_offset;
> > >       int i;
> > >
> > >       parms =3D rcu_dereference_bh(p->parms);
> > >
> > > -     max_offset =3D (skb_transport_header_was_set(skb) ?
> > > -                   skb_transport_offset(skb) :
> > > -                   skb_network_offset(skb)) +
> > > -                  parms->tcfp_off_max_hint;
> > > -     if (skb_ensure_writable(skb, min(skb->len, max_offset)))
> > > -             goto done;
> > > +     /*
> > > +      * If the skb has shared frags the user is likely using zero-co=
py
> > > +      * (e.g. sendfile).  Those page frags may point to page-cache p=
ages;
> > > +      * writing into them would silently corrupt the page cache.
> > > +      * Linearize so pedit operates on a private copy.
> > > +      * TL;DR: if you want zero-copy, don't use pedit.
> > > +      */
> > > +     if (skb_has_shared_frag(skb)) {
> > > +             if (__skb_linearize(skb))
> > > +                     goto bad;
> > > +     } =20
> >
> > Should there be a way of 'unsharing' frags by just copying the frags
> > rather than doing a full linearize?
> > That would be much less likely to fail for big skb.
> > =20
>=20
> It has been agreed that this chunk is unnecessary, so it will be
> removed in the next update.
>=20
> cheers,
> jamal


