Return-Path: <netdev+bounces-278097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O9NBt393Gk3YwkAu9opvQ
	(envelope-from <netdev+bounces-278097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:29:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 514303ED549
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 191B63028344
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFD33DA7D4;
	Mon, 13 Apr 2026 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQkkDCry";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScfGEnFG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949F13C1981
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776090199; cv=none; b=e0oGRBdbXebWmHK39jyiFbyRCn6cskB/Q+T07PlRi+mQdEYHd71OrE0sWzTlzf1scWbocywQJ+elJH5rW2L00KH2wjZa3r+47ll98mKMz5kNSYX+k49HChmDv5b1g5gajRcbvqCj+Qg8Pu3+lZKWaPT9TDk0+lEPu+feyPAHVMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776090199; c=relaxed/simple;
	bh=N4Kquu2QZ3tP4Y7YNlwlpZBCIDZnwM1rTYmzNTX0Q9k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ua5aBOw4CNx5qh8fnvC2ili+09bilk95NCubAIx3XlIyR5CcvjDSGkpK/t+Z5gJofNioB8CvEIMcE5rWV98FTZE7dS0pi8whLvbXHdPiEFrhrTOXZ6J+CJ43/UKLVIJ7JnPEroyllwmPaTu7hmUwyQ2YYMwfxK+Dpj8EdDs5GkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fQkkDCry; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ScfGEnFG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776090196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h8kW148tZIBnE0BHlYXnvKtZNjlpSQHEay9afhi668g=;
	b=fQkkDCrywiQWs8xzSgO2z3fjDHw+RUP315NIchdu4oyOAFh02EyKZPBI480EXKYHoIY+7P
	QUq14ga4bTBefM1PoTGPs3vE+6KBtkDb/aeON84cE1bgxQBvoS+yUUcB1XcxqotXHP25ri
	uBoDErfTMPP4PZ8xpWjZcH7hxA5hAxc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-lffHE1J9OOe1D43MLqaQSA-1; Mon, 13 Apr 2026 10:23:13 -0400
X-MC-Unique: lffHE1J9OOe1D43MLqaQSA-1
X-Mimecast-MFC-AGG-ID: lffHE1J9OOe1D43MLqaQSA_1776090192
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b9c1d5a149cso485658266b.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 07:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776090192; x=1776694992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8kW148tZIBnE0BHlYXnvKtZNjlpSQHEay9afhi668g=;
        b=ScfGEnFG8qeVj+RQzcLPEpLleAHR8Egi8LDh1P40YP4FKkqhI2uGVrWO1h6WzZS18e
         2NuwP4f3BBKO1XJcY/2p2NS7a0hgYThrgrlj6NQ1rc50AFZ5REPWqlpEE3m6kAWL2cPm
         MsJXu+4e5O1iSm/Opm50rkFi315/go3kXUpLBEXtnnhn42wzQCQD2fn8KhQtPDkPujlY
         re9wOWpN+/20fXOH+ojmTM7hoYcW6Vr17p2JKwqnfggnfN+cWfj0ZDiCFSDvVADVsM1E
         nWRxxdw4ejNrS2YSnUSs3RIHxedofPdFyJj0tgoGFCFc9u6sL3DmAyVG4fYL9mcsFKMi
         JvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776090192; x=1776694992;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h8kW148tZIBnE0BHlYXnvKtZNjlpSQHEay9afhi668g=;
        b=EbvYxaPorLwh7jnoGj4fmOfNGrFBo2hYEDArZ/VWAwhx6Z253/7Be6x+5BpzfrO/Nd
         lwg0TfaSDSEgeHtmzgRWcmQjClDH0uZKvjCMOf0NsWBRwxQAaHtR1qyz88W5YwMOOcrN
         83HpgTEed96Edp5Li2GJBwb8qJda7hNBl0VUfIMvJ2F7ujUyx0NcoC9ko0jMDnmkDoy5
         IW221Az7MbKJXXxFV2mWrk6xbYi92FSwU3bWnY+0Oy4NbKbWYr7NQFls8uT8CgkQsAFx
         WwsCqDgWWPncjTkNlq3VNOdHTSTuejixK194hYiK/ns7Xj1rm4foiVBeXYbbPqNHwOPw
         gvWg==
X-Forwarded-Encrypted: i=1; AFNElJ+pQkgWphxDjrd49ZknTqw3CwgMtvkAdZgeWiszKg+h2V+LCC/N7t5+B0DPUnryKRlOVOlhXkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx37xVsPQCoserMGNnkCMZwKc7LdzHQDEmzumzDXxYM+VR02kX3
	gPc1mzaomFU/VFkgJ4/RsbqXHatobxolNPAxz1Dgg6dUf3nIjzRWjRM22qM40RN4wfoaEeLmolD
	YmH8A2ASzEUJRig7wduvanutUNHv692tbt3t4wt+sogZqj6YlDA/w461Syg==
X-Gm-Gg: AeBDietInMNOFG/66IGoMI8uVssA0rCwAkOEDEsE2BCRBqdz8IJg2ykySlXFJM41U3M
	KlC+uOqWj3mRFysVhUL3ut2hj6bUTw10rWUUubmjdS7B0/l2Nex8oVQQ8Sm6JoV1QVFLzxQGWlY
	MGIxwMO8+5jc+XG0ciAMGzWXOSWAngzKItKy2r0w2K/RK9iyvgSydZGbpMvuJINgY+PYfHZsqgs
	I25jlfZegbkoOR4ykb8UhjisXJclcyZP6S34eYxrSv4jWlllSLojnJWTnV7Si+qfKRXxtrp4Jrg
	0bGGdy/W/gCOV7Yi/jQNhGZvWQ0cJOww3gWvUQlu8hLTjHDNWqFM+VS3828qT5TkFywFQ2qubXU
	7qSbJ4Jy9UPAI5ufSr5+kLmYvAbVrS1mbzc3zfZMNJvCm1w==
X-Received: by 2002:a17:907:6ea7:b0:b9d:61c7:2343 with SMTP id a640c23a62f3a-b9d724ec21cmr740314466b.10.1776090191831;
        Mon, 13 Apr 2026 07:23:11 -0700 (PDT)
X-Received: by 2002:a17:907:6ea7:b0:b9d:61c7:2343 with SMTP id a640c23a62f3a-b9d724ec21cmr740293866b.10.1776090185535;
        Mon, 13 Apr 2026 07:23:05 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e5c544asm317593766b.33.2026.04.13.07.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 07:23:04 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0E5DD6448F2; Mon, 13 Apr 2026 16:23:04 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko
 <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v3 net-next 13/15] net/sched: sch_cake: annotate
 data-races in cake_dump_stats()
In-Reply-To: <CANn89iJbFUm5NF1Q6WnB17Ufdg8PyFX4msJLVVs4PKRz6XW6yw@mail.gmail.com>
References: <20260410182257.774311-1-edumazet@google.com>
 <20260410182257.774311-14-edumazet@google.com> <87se8zcbcy.fsf@toke.dk>
 <CANn89iJbFUm5NF1Q6WnB17Ufdg8PyFX4msJLVVs4PKRz6XW6yw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 13 Apr 2026 16:23:04 +0200
Message-ID: <87jyubc52v.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.13 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.53)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278097-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,toke.dk:email,toke.dk:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 514303ED549
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Eric Dumazet <edumazet@google.com> writes:

> On Mon, Apr 13, 2026 at 5:07=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>>
>> Eric Dumazet <edumazet@google.com> writes:
>>
>> > cake_dump_stats() and cake_dump_class_stats() run without qdisc
>> > spinlock being held.
>> >
>> > Add READ_ONCE()/WRITE_ONCE() annotations.
>> >
>> > Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (ca=
ke) qdisc")
>> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>> > Cc: "Toke H=C3=B8iland-J=C3=B8rgensen" <toke@toke.dk>
>> > ---
>> >  net/sched/sch_cake.c | 404 ++++++++++++++++++++++++-------------------
>> >  1 file changed, 225 insertions(+), 179 deletions(-)
>>
>> One of these diffstats is not like the others - thanks for tackling this=
 :)
>>
>> A few nits below:
>>
>> > diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
>> > index 32e672820c00a88c6d8fe77a6308405e016525ea..f523f0aa4d830e9d3ec4d4=
3bb123e1dc4f8f289d 100644
>> > --- a/net/sched/sch_cake.c
>> > +++ b/net/sched/sch_cake.c
>> > @@ -399,14 +399,14 @@ static void cake_configure_rates(struct Qdisc *s=
ch, u64 rate, bool rate_adjust);
>> >   * Here, invsqrt is a fixed point number (< 1.0), 32bit mantissa, aka=
 Q0.32
>> >   */
>> >
>> > -static void cobalt_newton_step(struct cobalt_vars *vars)
>> > +static void cobalt_newton_step(struct cobalt_vars *vars, u32 count)
>> >  {
>> >       u32 invsqrt, invsqrt2;
>> >       u64 val;
>> >
>> >       invsqrt =3D vars->rec_inv_sqrt;
>> >       invsqrt2 =3D ((u64)invsqrt * invsqrt) >> 32;
>> > -     val =3D (3LL << 32) - ((u64)vars->count * invsqrt2);
>> > +     val =3D (3LL << 32) - ((u64)count * invsqrt2);
>> >
>> >       val >>=3D 2; /* avoid overflow in following multiply */
>> >       val =3D (val * invsqrt) >> (32 - 2 + 1);
>> > @@ -414,12 +414,12 @@ static void cobalt_newton_step(struct cobalt_var=
s *vars)
>> >       vars->rec_inv_sqrt =3D val;
>> >  }
>> >
>> > -static void cobalt_invsqrt(struct cobalt_vars *vars)
>> > +static void cobalt_invsqrt(struct cobalt_vars *vars, u32 count)
>> >  {
>> > -     if (vars->count < REC_INV_SQRT_CACHE)
>> > -             vars->rec_inv_sqrt =3D inv_sqrt_cache[vars->count];
>> > +     if (count < REC_INV_SQRT_CACHE)
>> > +             vars->rec_inv_sqrt =3D inv_sqrt_cache[count];
>> >       else
>> > -             cobalt_newton_step(vars);
>> > +             cobalt_newton_step(vars, count);
>> >  }
>> >
>> >  static void cobalt_vars_init(struct cobalt_vars *vars)
>> > @@ -449,16 +449,19 @@ static bool cobalt_queue_full(struct cobalt_vars=
 *vars,
>> >       bool up =3D false;
>> >
>> >       if (ktime_to_ns(ktime_sub(now, vars->blue_timer)) > p->target) {
>> > -             up =3D !vars->p_drop;
>> > -             vars->p_drop +=3D p->p_inc;
>> > -             if (vars->p_drop < p->p_inc)
>> > -                     vars->p_drop =3D ~0;
>> > -             vars->blue_timer =3D now;
>> > -     }
>> > -     vars->dropping =3D true;
>> > -     vars->drop_next =3D now;
>> > +             u32 p_drop =3D vars->p_drop;
>> > +
>> > +             up =3D !p_drop;
>> > +             p_drop +=3D p->p_inc;
>> > +             if (p_drop < p->p_inc)
>> > +                     p_drop =3D ~0;
>> > +             WRITE_ONCE(vars->p_drop, p_drop);
>> > +             WRITE_ONCE(vars->blue_timer, now);
>> > +     }
>> > +     WRITE_ONCE(vars->dropping, true);
>> > +     WRITE_ONCE(vars->drop_next, now);
>> >       if (!vars->count)
>> > -             vars->count =3D 1;
>> > +             WRITE_ONCE(vars->count, 1);
>> >
>> >       return up;
>> >  }
>> > @@ -474,21 +477,25 @@ static bool cobalt_queue_empty(struct cobalt_var=
s *vars,
>> >
>> >       if (vars->p_drop &&
>> >           ktime_to_ns(ktime_sub(now, vars->blue_timer)) > p->target) {
>> > -             if (vars->p_drop < p->p_dec)
>> > -                     vars->p_drop =3D 0;
>> > +             u32 p_drop =3D vars->p_drop;
>> > +
>> > +             if (p_drop < p->p_dec)
>> > +                     p_drop =3D 0;
>> >               else
>> > -                     vars->p_drop -=3D p->p_dec;
>> > -             vars->blue_timer =3D now;
>> > -             down =3D !vars->p_drop;
>> > +                     p_drop -=3D p->p_dec;
>> > +             WRITE_ONCE(vars->p_drop, p_drop);
>> > +             WRITE_ONCE(vars->blue_timer, now);
>> > +             down =3D !p_drop;
>> >       }
>> > -     vars->dropping =3D false;
>> > +     WRITE_ONCE(vars->dropping, false);
>> >
>> >       if (vars->count && ktime_to_ns(ktime_sub(now, vars->drop_next)) =
>=3D 0) {
>> > -             vars->count--;
>> > -             cobalt_invsqrt(vars);
>> > -             vars->drop_next =3D cobalt_control(vars->drop_next,
>> > -                                              p->interval,
>> > -                                              vars->rec_inv_sqrt);
>> > +             WRITE_ONCE(vars->count, vars->count - 1);
>> > +             cobalt_invsqrt(vars, vars->count);
>> > +             WRITE_ONCE(vars->drop_next,
>> > +                        cobalt_control(vars->drop_next,
>> > +                                       p->interval,
>> > +                                       vars->rec_inv_sqrt));
>> >       }
>> >
>> >       return down;
>> > @@ -507,6 +514,7 @@ static enum qdisc_drop_reason cobalt_should_drop(s=
truct cobalt_vars *vars,
>> >       bool next_due, over_target;
>> >       ktime_t schedule;
>> >       u64 sojourn;
>> > +     u32 count;
>> >
>> >  /* The 'schedule' variable records, in its sign, whether 'now' is bef=
ore or
>> >   * after 'drop_next'.  This allows 'drop_next' to be updated before t=
he next
>> > @@ -528,45 +536,50 @@ static enum qdisc_drop_reason cobalt_should_drop=
(struct cobalt_vars *vars,
>> >       over_target =3D sojourn > p->target &&
>> >                     sojourn > p->mtu_time * bulk_flows * 2 &&
>> >                     sojourn > p->mtu_time * 4;
>> > -     next_due =3D vars->count && ktime_to_ns(schedule) >=3D 0;
>> > +     count =3D vars->count;
>> > +     next_due =3D count && ktime_to_ns(schedule) >=3D 0;
>> >
>> >       vars->ecn_marked =3D false;
>> >
>> >       if (over_target) {
>> >               if (!vars->dropping) {
>> > -                     vars->dropping =3D true;
>> > -                     vars->drop_next =3D cobalt_control(now,
>> > -                                                      p->interval,
>> > -                                                      vars->rec_inv_s=
qrt);
>> > +                     WRITE_ONCE(vars->dropping, true);
>> > +                     WRITE_ONCE(vars->drop_next,
>> > +                                cobalt_control(now,
>> > +                                               p->interval,
>> > +                                               vars->rec_inv_sqrt));
>> >               }
>> > -             if (!vars->count)
>> > -                     vars->count =3D 1;
>> > +             if (!count)
>> > +                     count =3D 1;
>> >       } else if (vars->dropping) {
>> > -             vars->dropping =3D false;
>> > +             WRITE_ONCE(vars->dropping, false);
>> >       }
>> >
>> >       if (next_due && vars->dropping) {
>> >               /* Use ECN mark if possible, otherwise drop */
>> > -             if (!(vars->ecn_marked =3D INET_ECN_set_ce(skb)))
>> > +             vars->ecn_marked =3D INET_ECN_set_ce(skb);
>> > +             if (!vars->ecn_marked)
>> >                       reason =3D QDISC_DROP_CONGESTED;
>> >
>> > -             vars->count++;
>> > -             if (!vars->count)
>> > -                     vars->count--;
>> > -             cobalt_invsqrt(vars);
>> > -             vars->drop_next =3D cobalt_control(vars->drop_next,
>> > -                                              p->interval,
>> > -                                              vars->rec_inv_sqrt);
>> > +             count++;
>> > +             if (!count)
>> > +                     count--;
>> > +             cobalt_invsqrt(vars, count);
>> > +             WRITE_ONCE(vars->drop_next,
>> > +                        cobalt_control(vars->drop_next,
>> > +                                       p->interval,
>> > +                                       vars->rec_inv_sqrt));
>> >               schedule =3D ktime_sub(now, vars->drop_next);
>> >       } else {
>> >               while (next_due) {
>> > -                     vars->count--;
>> > -                     cobalt_invsqrt(vars);
>> > -                     vars->drop_next =3D cobalt_control(vars->drop_ne=
xt,
>> > -                                                      p->interval,
>> > -                                                      vars->rec_inv_s=
qrt);
>> > +                     count--;
>> > +                     cobalt_invsqrt(vars, count);
>> > +                     WRITE_ONCE(vars->drop_next,
>> > +                                cobalt_control(vars->drop_next,
>> > +                                               p->interval,
>> > +                                               vars->rec_inv_sqrt));
>> >                       schedule =3D ktime_sub(now, vars->drop_next);
>> > -                     next_due =3D vars->count && ktime_to_ns(schedule=
) >=3D 0;
>> > +                     next_due =3D count && ktime_to_ns(schedule) >=3D=
 0;
>> >               }
>> >       }
>> >
>> > @@ -575,11 +588,12 @@ static enum qdisc_drop_reason cobalt_should_drop=
(struct cobalt_vars *vars,
>> >           get_random_u32() < vars->p_drop)
>> >               reason =3D QDISC_DROP_FLOOD_PROTECTION;
>> >
>> > +     WRITE_ONCE(vars->count, count);
>> >       /* Overload the drop_next field as an activity timeout */
>> > -     if (!vars->count)
>> > -             vars->drop_next =3D ktime_add_ns(now, p->interval);
>> > +     if (count)
>>
>> This seems to reverse the conditional?
>
> Ah right, thanks !
>
>>
>> > +             WRITE_ONCE(vars->drop_next, ktime_add_ns(now, p->interva=
l));
>> >       else if (ktime_to_ns(schedule) > 0 && reason =3D=3D QDISC_DROP_U=
NSPEC)
>> > -             vars->drop_next =3D now;
>> > +             WRITE_ONCE(vars->drop_next, now);
>> >
>> >       return reason;
>> >  }
>> > @@ -813,7 +827,7 @@ static u32 cake_hash(struct cake_tin_data *q, cons=
t struct sk_buff *skb,
>> >                    i++, k =3D (k + 1) % CAKE_SET_WAYS) {
>> >                       if (q->tags[outer_hash + k] =3D=3D flow_hash) {
>> >                               if (i)
>> > -                                     q->way_hits++;
>> > +                                     WRITE_ONCE(q->way_hits, q->way_h=
its + 1);
>> >
>> >                               if (!q->flows[outer_hash + k].set) {
>> >                                       /* need to increment host refcnt=
s */
>> > @@ -831,7 +845,7 @@ static u32 cake_hash(struct cake_tin_data *q, cons=
t struct sk_buff *skb,
>> >               for (i =3D 0; i < CAKE_SET_WAYS;
>> >                        i++, k =3D (k + 1) % CAKE_SET_WAYS) {
>> >                       if (!q->flows[outer_hash + k].set) {
>> > -                             q->way_misses++;
>> > +                             WRITE_ONCE(q->way_misses, q->way_misses =
+ 1);
>> >                               allocate_src =3D cake_dsrc(flow_mode);
>> >                               allocate_dst =3D cake_ddst(flow_mode);
>> >                               goto found;
>> > @@ -841,7 +855,7 @@ static u32 cake_hash(struct cake_tin_data *q, cons=
t struct sk_buff *skb,
>> >               /* With no empty queues, default to the original
>> >                * queue, accept the collision, update the host tags.
>> >                */
>> > -             q->way_collisions++;
>> > +             WRITE_ONCE(q->way_collisions, q->way_collisions + 1);
>> >               allocate_src =3D cake_dsrc(flow_mode);
>> >               allocate_dst =3D cake_ddst(flow_mode);
>> >
>> > @@ -875,7 +889,8 @@ static u32 cake_hash(struct cake_tin_data *q, cons=
t struct sk_buff *skb,
>> >                       q->flows[reduced_hash].srchost =3D srchost_idx;
>> >
>> >                       if (q->flows[reduced_hash].set =3D=3D CAKE_SET_B=
ULK)
>> > -                             cake_inc_srchost_bulk_flow_count(q, &q->=
flows[reduced_hash], flow_mode);
>> > +                             cake_inc_srchost_bulk_flow_count(q, &q->=
flows[reduced_hash],
>> > +                                                              flow_mo=
de);
>> >               }
>> >
>> >               if (allocate_dst) {
>> > @@ -899,7 +914,8 @@ static u32 cake_hash(struct cake_tin_data *q, cons=
t struct sk_buff *skb,
>> >                       q->flows[reduced_hash].dsthost =3D dsthost_idx;
>> >
>> >                       if (q->flows[reduced_hash].set =3D=3D CAKE_SET_B=
ULK)
>> > -                             cake_inc_dsthost_bulk_flow_count(q, &q->=
flows[reduced_hash], flow_mode);
>> > +                             cake_inc_dsthost_bulk_flow_count(q, &q->=
flows[reduced_hash],
>> > +                                                              flow_mo=
de);
>> >               }
>> >       }
>> >
>> > @@ -1379,9 +1395,9 @@ static u32 cake_calc_overhead(struct cake_sched_=
data *qd, u32 len, u32 off)
>> >               len -=3D off;
>> >
>> >       if (qd->max_netlen < len)
>> > -             qd->max_netlen =3D len;
>> > +             WRITE_ONCE(qd->max_netlen, len);
>> >       if (qd->min_netlen > len)
>> > -             qd->min_netlen =3D len;
>> > +             WRITE_ONCE(qd->min_netlen, len);
>> >
>> >       len +=3D q->rate_overhead;
>> >
>> > @@ -1401,9 +1417,9 @@ static u32 cake_calc_overhead(struct cake_sched_=
data *qd, u32 len, u32 off)
>> >       }
>> >
>> >       if (qd->max_adjlen < len)
>> > -             qd->max_adjlen =3D len;
>> > +             WRITE_ONCE(qd->max_adjlen, len);
>> >       if (qd->min_adjlen > len)
>> > -             qd->min_adjlen =3D len;
>> > +             WRITE_ONCE(qd->min_adjlen, len);
>> >
>> >       return len;
>> >  }
>> > @@ -1416,7 +1432,7 @@ static u32 cake_overhead(struct cake_sched_data =
*q, const struct sk_buff *skb)
>> >       u16 segs =3D qdisc_pkt_segs(skb);
>> >       u32 len =3D qdisc_pkt_len(skb);
>> >
>> > -     q->avg_netoff =3D cake_ewma(q->avg_netoff, off << 16, 8);
>> > +     WRITE_ONCE(q->avg_netoff, cake_ewma(q->avg_netoff, off << 16, 8)=
);
>> >
>> >       if (segs =3D=3D 1)
>> >               return cake_calc_overhead(q, len, off);
>> > @@ -1590,16 +1606,17 @@ static unsigned int cake_drop(struct Qdisc *sc=
h, struct sk_buff **to_free)
>> >       }
>> >
>> >       if (cobalt_queue_full(&flow->cvars, &b->cparams, now))
>> > -             b->unresponsive_flow_count++;
>> > +             WRITE_ONCE(b->unresponsive_flow_count,
>> > +                        b->unresponsive_flow_count + 1);
>> >
>> >       len =3D qdisc_pkt_len(skb);
>> >       q->buffer_used      -=3D skb->truesize;
>> > -     b->backlogs[idx]    -=3D len;
>> > -     b->tin_backlog      -=3D len;
>> > +     WRITE_ONCE(b->backlogs[idx], b->backlogs[idx] - len);
>> > +     WRITE_ONCE(b->tin_backlog, b->tin_backlog - len);
>> >       qstats_backlog_sub(sch, len);
>> >
>> > -     flow->dropped++;
>> > -     b->tin_dropped++;
>> > +     WRITE_ONCE(flow->dropped, flow->dropped + 1);
>> > +     WRITE_ONCE(b->tin_dropped, b->tin_dropped + 1);
>> >
>> >       if (q->config->rate_flags & CAKE_FLAG_INGRESS)
>> >               cake_advance_shaper(q, b, skb, now, true);
>> > @@ -1795,7 +1812,7 @@ static s32 cake_enqueue(struct sk_buff *skb, str=
uct Qdisc *sch,
>> >       }
>> >
>> >       if (unlikely(len > b->max_skblen))
>> > -             b->max_skblen =3D len;
>> > +             WRITE_ONCE(b->max_skblen, len);
>> >
>> >       if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG=
_SPLIT_GSO) {
>> >               struct sk_buff *segs, *nskb;
>> > @@ -1819,13 +1836,13 @@ static s32 cake_enqueue(struct sk_buff *skb, s=
truct Qdisc *sch,
>> >                       numsegs++;
>> >                       slen +=3D segs->len;
>> >                       q->buffer_used +=3D segs->truesize;
>> > -                     b->packets++;
>>
>> Right above this hunk we do sch->q.qlen++; - does that need changing as
>> well?
>
> This was changed to qdisc_qlen_inc() in a prior commit in this series.
> ( net/sched: add qdisc_qlen_inc() and qdisc_qlen_dec() )

Ah, right, missed that; sorry!

>>
>> >               }
>> >
>> >               /* stats */
>> > -             b->bytes            +=3D slen;
>> > -             b->backlogs[idx]    +=3D slen;
>> > -             b->tin_backlog      +=3D slen;
>> > +             WRITE_ONCE(b->bytes, b->bytes + slen);
>> > +             WRITE_ONCE(b->packets, b->packets + numsegs);
>> > +             WRITE_ONCE(b->backlogs[idx], b->backlogs[idx] + slen);
>> > +             WRITE_ONCE(b->tin_backlog, b->tin_backlog + slen);
>> >               qstats_backlog_add(sch, slen);
>> >               q->avg_window_bytes +=3D slen;
>> >
>> > @@ -1843,10 +1860,10 @@ static s32 cake_enqueue(struct sk_buff *skb, s=
truct Qdisc *sch,
>> >                       ack =3D cake_ack_filter(q, flow);
>> >
>> >               if (ack) {
>> > -                     b->ack_drops++;
>> > +                     WRITE_ONCE(b->ack_drops, b->ack_drops + 1);
>> >                       qdisc_qstats_drop(sch);
>> >                       ack_pkt_len =3D qdisc_pkt_len(ack);
>> > -                     b->bytes +=3D ack_pkt_len;
>> > +                     WRITE_ONCE(b->bytes, b->bytes + ack_pkt_len);
>> >                       q->buffer_used +=3D skb->truesize - ack->truesiz=
e;
>> >                       if (q->config->rate_flags & CAKE_FLAG_INGRESS)
>> >                               cake_advance_shaper(q, b, ack, now, true=
);
>> > @@ -1859,10 +1876,10 @@ static s32 cake_enqueue(struct sk_buff *skb, s=
truct Qdisc *sch,
>> >               }
>> >
>> >               /* stats */
>> > -             b->packets++;
>> > -             b->bytes            +=3D len - ack_pkt_len;
>> > -             b->backlogs[idx]    +=3D len - ack_pkt_len;
>> > -             b->tin_backlog      +=3D len - ack_pkt_len;
>> > +             WRITE_ONCE(b->packets, b->packets + 1);
>> > +             WRITE_ONCE(b->bytes, b->bytes + len - ack_pkt_len);
>> > +             WRITE_ONCE(b->backlogs[idx], b->backlogs[idx] + len - ac=
k_pkt_len);
>> > +             WRITE_ONCE(b->tin_backlog, b->tin_backlog + len - ack_pk=
t_len);
>> >               qstats_backlog_add(sch, len - ack_pkt_len);
>> >               q->avg_window_bytes +=3D len - ack_pkt_len;
>> >       }
>> > @@ -1894,9 +1911,9 @@ static s32 cake_enqueue(struct sk_buff *skb, str=
uct Qdisc *sch,
>> >                       u64 b =3D q->avg_window_bytes * (u64)NSEC_PER_SE=
C;
>> >
>> >                       b =3D div64_u64(b, window_interval);
>> > -                     q->avg_peak_bandwidth =3D
>> > -                             cake_ewma(q->avg_peak_bandwidth, b,
>> > -                                       b > q->avg_peak_bandwidth ? 2 =
: 8);
>> > +                     WRITE_ONCE(q->avg_peak_bandwidth,
>> > +                                cake_ewma(q->avg_peak_bandwidth, b,
>> > +                                          b > q->avg_peak_bandwidth ?=
 2 : 8));
>> >                       q->avg_window_bytes =3D 0;
>> >                       q->avg_window_begin =3D now;
>> >
>> > @@ -1917,27 +1934,30 @@ static s32 cake_enqueue(struct sk_buff *skb, s=
truct Qdisc *sch,
>> >               if (!flow->set) {
>> >                       list_add_tail(&flow->flowchain, &b->new_flows);
>> >               } else {
>> > -                     b->decaying_flow_count--;
>> > +                     WRITE_ONCE(b->decaying_flow_count,
>> > +                                b->decaying_flow_count - 1);
>> >                       list_move_tail(&flow->flowchain, &b->new_flows);
>> >               }
>> >               flow->set =3D CAKE_SET_SPARSE;
>> > -             b->sparse_flow_count++;
>> > +             WRITE_ONCE(b->sparse_flow_count,
>> > +                        b->sparse_flow_count + 1);
>> >
>> > -             flow->deficit =3D cake_get_flow_quantum(b, flow, q->conf=
ig->flow_mode);
>> > +             WRITE_ONCE(flow->deficit,
>> > +                        cake_get_flow_quantum(b, flow, q->config->flo=
w_mode));
>> >       } else if (flow->set =3D=3D CAKE_SET_SPARSE_WAIT) {
>> >               /* this flow was empty, accounted as a sparse flow, but =
actually
>> >                * in the bulk rotation.
>> >                */
>> >               flow->set =3D CAKE_SET_BULK;
>> > -             b->sparse_flow_count--;
>> > -             b->bulk_flow_count++;
>> > +             WRITE_ONCE(b->sparse_flow_count, b->sparse_flow_count - =
1);
>> > +             WRITE_ONCE(b->bulk_flow_count, b->bulk_flow_count + 1);
>> >
>> >               cake_inc_srchost_bulk_flow_count(b, flow, q->config->flo=
w_mode);
>> >               cake_inc_dsthost_bulk_flow_count(b, flow, q->config->flo=
w_mode);
>> >       }
>> >
>> >       if (q->buffer_used > q->buffer_max_used)
>> > -             q->buffer_max_used =3D q->buffer_used;
>> > +             WRITE_ONCE(q->buffer_max_used, q->buffer_used);
>> >
>> >       if (q->buffer_used <=3D q->buffer_limit)
>> >               return NET_XMIT_SUCCESS;
>> > @@ -1976,8 +1996,8 @@ static struct sk_buff *cake_dequeue_one(struct Q=
disc *sch)
>> >       if (flow->head) {
>> >               skb =3D dequeue_head(flow);
>> >               len =3D qdisc_pkt_len(skb);
>> > -             b->backlogs[q->cur_flow] -=3D len;
>> > -             b->tin_backlog           -=3D len;
>> > +             WRITE_ONCE(b->backlogs[q->cur_flow], b->backlogs[q->cur_=
flow] - len);
>> > +             WRITE_ONCE(b->tin_backlog, b->tin_backlog - len);
>> >               qstats_backlog_sub(sch, len);
>> >               q->buffer_used           -=3D skb->truesize;
>> >               qdisc_qlen_dec(sch);
>> > @@ -2042,7 +2062,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc=
 *sch)
>> >
>> >               cake_configure_rates(sch, new_rate, true);
>> >               q->last_checked_active =3D now;
>> > -             q->active_queues =3D num_active_qs;
>> > +             WRITE_ONCE(q->active_queues, num_active_qs);
>> >       }
>> >
>> >  begin:
>> > @@ -2149,8 +2169,10 @@ static struct sk_buff *cake_dequeue(struct Qdis=
c *sch)
>> >                */
>> >               if (flow->set =3D=3D CAKE_SET_SPARSE) {
>> >                       if (flow->head) {
>> > -                             b->sparse_flow_count--;
>> > -                             b->bulk_flow_count++;
>> > +                             WRITE_ONCE(b->sparse_flow_count,
>> > +                                        b->sparse_flow_count - 1);
>> > +                             WRITE_ONCE(b->bulk_flow_count,
>> > +                                        b->bulk_flow_count + 1);
>> >
>> >                               cake_inc_srchost_bulk_flow_count(b, flow=
, q->config->flow_mode);
>> >                               cake_inc_dsthost_bulk_flow_count(b, flow=
, q->config->flow_mode);
>> > @@ -2165,7 +2187,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc=
 *sch)
>> >                       }
>> >               }
>> >
>> > -             flow->deficit +=3D cake_get_flow_quantum(b, flow, q->con=
fig->flow_mode);
>> > +             WRITE_ONCE(flow->deficit,
>> > +                        flow->deficit + cake_get_flow_quantum(b, flow=
, q->config->flow_mode));
>> >               list_move_tail(&flow->flowchain, &b->old_flows);
>> >
>> >               goto retry;
>> > @@ -2177,7 +2200,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc=
 *sch)
>> >               if (!skb) {
>> >                       /* this queue was actually empty */
>> >                       if (cobalt_queue_empty(&flow->cvars, &b->cparams=
, now))
>> > -                             b->unresponsive_flow_count--;
>> > +                             WRITE_ONCE(b->unresponsive_flow_count,
>> > +                                        b->unresponsive_flow_count - =
1);
>> >
>> >                       if (flow->cvars.p_drop || flow->cvars.count ||
>> >                           ktime_before(now, flow->cvars.drop_next)) {
>> > @@ -2187,16 +2211,22 @@ static struct sk_buff *cake_dequeue(struct Qdi=
sc *sch)
>> >                               list_move_tail(&flow->flowchain,
>> >                                              &b->decaying_flows);
>> >                               if (flow->set =3D=3D CAKE_SET_BULK) {
>> > -                                     b->bulk_flow_count--;
>> > +                                     WRITE_ONCE(b->bulk_flow_count,
>> > +                                                b->bulk_flow_count - =
1);
>> >
>> > -                                     cake_dec_srchost_bulk_flow_count=
(b, flow, q->config->flow_mode);
>> > -                                     cake_dec_dsthost_bulk_flow_count=
(b, flow, q->config->flow_mode);
>> > +                                     cake_dec_srchost_bulk_flow_count=
(b, flow,
>> > +                                                                     =
 q->config->flow_mode);
>> > +                                     cake_dec_dsthost_bulk_flow_count=
(b, flow,
>> > +                                                                     =
 q->config->flow_mode);
>>
>> These seem like unnecessary whitespace changes?
>
> Line length was 105 ... a bit over the recommended limit.

Right, do realise that, but I personally find the one-liners more
readable even if they are a bit long. Won't insist, though; it's just
whitespace, after all :)

-Toke


