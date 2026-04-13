Return-Path: <netdev+bounces-278062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPlgEZHd3GnrXgkAu9opvQ
	(envelope-from <netdev+bounces-278062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:12:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C173EBBD9
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C146F3020AB6
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFC33C2796;
	Mon, 13 Apr 2026 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I55IxDGb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCDHwtmZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89892D3A69
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776082054; cv=none; b=j1FgaVQYTDXy4+bzeyLI2gtnXcz3ofa37b9LXZ/v9mHTzRBf9U/f3kZVnXItTGzFkaws2lNWPC/8KPz4KVYpU3T9mUJg+P0fAQ9oQlU4RXIsmUaQVoX+AtE2ewVqIXKbhJnnjfPx2oRcyyOj0m3QjUXeSyC7uCyiP6LqtM+DNNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776082054; c=relaxed/simple;
	bh=Bccng/9Vj8fRqFHb18hVhp77z2NxTOZmkgu3j3Yega4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YvvvhX4PQ6N88AW6RTrr7P0d6B+P5af2n9ASjK1B7lJgXFoQOTGxlMoD1mKLZ64SFKUIFzEpWa/GTPJJTNEsfJTLEqhClk2IcCCSHAyVBFBeIcHj5CjzV+XLCossB3jTSaeerh3Pc+DAzyn83ta0qsXVBtNHxpOykJgZ+PduLrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I55IxDGb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dCDHwtmZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776082051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lp2dL6lZEZ9y2TYvoTWI8Q8lUKnO4IM4LneWr8IQXRw=;
	b=I55IxDGbiaBhtfwD0jABlsgHdNLv78xC+91MXMQDR2iSaHmr/8ArDzPP2rXdmxyscwPL4K
	Mne3OTtCVqAajJwn1fAla05vq7WgRsCJPgSHAIcZDp9oAEhoTrhGnwgrJU9SS6N8rPnuNQ
	akXuAXE1k8hOoctnAPRJGIAFWKA/2Lc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-OijV3FeTN_WzYaDhivyE5A-1; Mon, 13 Apr 2026 08:07:30 -0400
X-MC-Unique: OijV3FeTN_WzYaDhivyE5A-1
X-Mimecast-MFC-AGG-ID: OijV3FeTN_WzYaDhivyE5A_1776082049
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b9c0787da95so278020966b.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 05:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776082049; x=1776686849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lp2dL6lZEZ9y2TYvoTWI8Q8lUKnO4IM4LneWr8IQXRw=;
        b=dCDHwtmZ3dOKjPk0l1phQYZMpEcNfrKda545VUF8gXGVm6NkZ1qXhwtO66lVErD1U3
         GXo1146CYeJwSUmSfgHil2wMP79dMFamzllUGoH3+oeGGLHRsx0iVpNBtWCwjOSWNeTp
         aL4ax//RqP4oevYcpOShssjejOaMKoC/IqdUX6onXPCo6ROhx6miJqNGuS7svE3v+zGU
         DNibvWsyTw3biOli2QnLhZ17eiVr6c69B9KgcRpimativ0o005eLtFcejIP7aTOrMSc0
         7Rlk0rSFqQ+249DpsBF/QWmA/+BBWMDVivxkrVn0byARuFQCipyiJlM9CKrz052Hyr9E
         nZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776082049; x=1776686849;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lp2dL6lZEZ9y2TYvoTWI8Q8lUKnO4IM4LneWr8IQXRw=;
        b=smz7aECroAuEjEBeJXDMdeWI/S8fuMkOldvQLEkCvVLwLqfLNwHYFOtm40vYmD9BnE
         cW3KEDSRwkn73PXgvHdqR6VKtwkHQ18PPalTfe6ywXtLbtsQNcgd0YpggRhxaKyt94gk
         cP6KdkOpBE7T310l0WSZYSQ8eJuuhwPV5Ee2YKpxCjredbP+slGviCgFJ6nDjOtJv4af
         ZpcIhuuhiTDZBr1QAm3YNzhP0RSZGmKMDt1GRvb1l2aK1uyCAFRfmK3ISkeUygqU/KTJ
         3NSWIP3S6Smad3Jwp79cbRTJqaWz++EYpgh14cNkT45qPz9e6FOuEBqp3pMWiCSQgchL
         n8bQ==
X-Forwarded-Encrypted: i=1; AFNElJ+6cWmsi08d9FhMGrHooqHV/U8V7NlNGi8kO6gi50hIkZnAfRk9PIsVyB5UW/hu4cMuzwKIquM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhVg1xatU0C+a428i+NFSjdF50usi4qo1JCgYw2nfidOZGHYUA
	Nv6jKBQ8Eje3KKOKeYDT3NCcwx/+Qi6j94Xn+agTJlUQgz4tBDuhvbiunX3esIQ2YJXPSlUDVdc
	/NwUVBw1Mn9ypwz5zqNMX6b7ymjRJNrlsXJ61zs7rwz4bcIuoixcuo3lv5g==
X-Gm-Gg: AeBDiesFbjOyHlqdRe7rVdToko5VRA7XPjb6R0gU8Y+mRYwE70sg6B9Tlz6SGvSbIGo
	ndPnFPhfB5t8Mp5ONevEC+1/6gNzxYm9v9ibNathaO1sG/IKNHz2v4Er2lmw/tdurUfzwKV80tf
	37AZtW1Y2vUSuPODpC623XntMMG8oOtjU/cKsjhj+sioLY593FjQU3ZLNX+oJEu4zWomf7Qa/TI
	B/fDgvZFeOION1xedq1wtMjR58Hn7SaEYh2hE99JZXKZ9z4WbwCWjLNu4YjDN7CBPbAfETrtduF
	tVsvR0/Em29fAI0egMuVBqu7WbFLrO7EF9Ucv2sd4HlpsnWeyvhHrbKl1BTm1z4Z1LUm3NEOrds
	0Fn9m7AiDzz1Kih3GOUym/UTTGGAEOoj2NGcodxMFL1aXDoGe
X-Received: by 2002:a17:907:1c07:b0:b9d:4652:2f75 with SMTP id a640c23a62f3a-b9d722f6b43mr701088966b.0.1776082048501;
        Mon, 13 Apr 2026 05:07:28 -0700 (PDT)
X-Received: by 2002:a17:907:1c07:b0:b9d:4652:2f75 with SMTP id a640c23a62f3a-b9d722f6b43mr701085366b.0.1776082047464;
        Mon, 13 Apr 2026 05:07:27 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e5c5824sm304901666b.38.2026.04.13.05.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:07:26 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B6B3A644895; Mon, 13 Apr 2026 14:07:25 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v3 net-next 13/15] net/sched: sch_cake: annotate
 data-races in cake_dump_stats()
In-Reply-To: <20260410182257.774311-14-edumazet@google.com>
References: <20260410182257.774311-1-edumazet@google.com>
 <20260410182257.774311-14-edumazet@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 13 Apr 2026 14:07:25 +0200
Message-ID: <87se8zcbcy.fsf@toke.dk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278062-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,toke.dk:email,toke.dk:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 92C173EBBD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Eric Dumazet <edumazet@google.com> writes:

> cake_dump_stats() and cake_dump_class_stats() run without qdisc
> spinlock being held.
>
> Add READ_ONCE()/WRITE_ONCE() annotations.
>
> Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake)=
 qdisc")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: "Toke H=C3=B8iland-J=C3=B8rgensen" <toke@toke.dk>
> ---
>  net/sched/sch_cake.c | 404 ++++++++++++++++++++++++-------------------
>  1 file changed, 225 insertions(+), 179 deletions(-)

One of these diffstats is not like the others - thanks for tackling this :)

A few nits below:

> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index 32e672820c00a88c6d8fe77a6308405e016525ea..f523f0aa4d830e9d3ec4d43bb=
123e1dc4f8f289d 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -399,14 +399,14 @@ static void cake_configure_rates(struct Qdisc *sch,=
 u64 rate, bool rate_adjust);
>   * Here, invsqrt is a fixed point number (< 1.0), 32bit mantissa, aka Q0=
.32
>   */
>=20=20
> -static void cobalt_newton_step(struct cobalt_vars *vars)
> +static void cobalt_newton_step(struct cobalt_vars *vars, u32 count)
>  {
>  	u32 invsqrt, invsqrt2;
>  	u64 val;
>=20=20
>  	invsqrt =3D vars->rec_inv_sqrt;
>  	invsqrt2 =3D ((u64)invsqrt * invsqrt) >> 32;
> -	val =3D (3LL << 32) - ((u64)vars->count * invsqrt2);
> +	val =3D (3LL << 32) - ((u64)count * invsqrt2);
>=20=20
>  	val >>=3D 2; /* avoid overflow in following multiply */
>  	val =3D (val * invsqrt) >> (32 - 2 + 1);
> @@ -414,12 +414,12 @@ static void cobalt_newton_step(struct cobalt_vars *=
vars)
>  	vars->rec_inv_sqrt =3D val;
>  }
>=20=20
> -static void cobalt_invsqrt(struct cobalt_vars *vars)
> +static void cobalt_invsqrt(struct cobalt_vars *vars, u32 count)
>  {
> -	if (vars->count < REC_INV_SQRT_CACHE)
> -		vars->rec_inv_sqrt =3D inv_sqrt_cache[vars->count];
> +	if (count < REC_INV_SQRT_CACHE)
> +		vars->rec_inv_sqrt =3D inv_sqrt_cache[count];
>  	else
> -		cobalt_newton_step(vars);
> +		cobalt_newton_step(vars, count);
>  }
>=20=20
>  static void cobalt_vars_init(struct cobalt_vars *vars)
> @@ -449,16 +449,19 @@ static bool cobalt_queue_full(struct cobalt_vars *v=
ars,
>  	bool up =3D false;
>=20=20
>  	if (ktime_to_ns(ktime_sub(now, vars->blue_timer)) > p->target) {
> -		up =3D !vars->p_drop;
> -		vars->p_drop +=3D p->p_inc;
> -		if (vars->p_drop < p->p_inc)
> -			vars->p_drop =3D ~0;
> -		vars->blue_timer =3D now;
> -	}
> -	vars->dropping =3D true;
> -	vars->drop_next =3D now;
> +		u32 p_drop =3D vars->p_drop;
> +
> +		up =3D !p_drop;
> +		p_drop +=3D p->p_inc;
> +		if (p_drop < p->p_inc)
> +			p_drop =3D ~0;
> +		WRITE_ONCE(vars->p_drop, p_drop);
> +		WRITE_ONCE(vars->blue_timer, now);
> +	}
> +	WRITE_ONCE(vars->dropping, true);
> +	WRITE_ONCE(vars->drop_next, now);
>  	if (!vars->count)
> -		vars->count =3D 1;
> +		WRITE_ONCE(vars->count, 1);
>=20=20
>  	return up;
>  }
> @@ -474,21 +477,25 @@ static bool cobalt_queue_empty(struct cobalt_vars *=
vars,
>=20=20
>  	if (vars->p_drop &&
>  	    ktime_to_ns(ktime_sub(now, vars->blue_timer)) > p->target) {
> -		if (vars->p_drop < p->p_dec)
> -			vars->p_drop =3D 0;
> +		u32 p_drop =3D vars->p_drop;
> +
> +		if (p_drop < p->p_dec)
> +			p_drop =3D 0;
>  		else
> -			vars->p_drop -=3D p->p_dec;
> -		vars->blue_timer =3D now;
> -		down =3D !vars->p_drop;
> +			p_drop -=3D p->p_dec;
> +		WRITE_ONCE(vars->p_drop, p_drop);
> +		WRITE_ONCE(vars->blue_timer, now);
> +		down =3D !p_drop;
>  	}
> -	vars->dropping =3D false;
> +	WRITE_ONCE(vars->dropping, false);
>=20=20
>  	if (vars->count && ktime_to_ns(ktime_sub(now, vars->drop_next)) >=3D 0)=
 {
> -		vars->count--;
> -		cobalt_invsqrt(vars);
> -		vars->drop_next =3D cobalt_control(vars->drop_next,
> -						 p->interval,
> -						 vars->rec_inv_sqrt);
> +		WRITE_ONCE(vars->count, vars->count - 1);
> +		cobalt_invsqrt(vars, vars->count);
> +		WRITE_ONCE(vars->drop_next,
> +			   cobalt_control(vars->drop_next,
> +					  p->interval,
> +					  vars->rec_inv_sqrt));
>  	}
>=20=20
>  	return down;
> @@ -507,6 +514,7 @@ static enum qdisc_drop_reason cobalt_should_drop(stru=
ct cobalt_vars *vars,
>  	bool next_due, over_target;
>  	ktime_t schedule;
>  	u64 sojourn;
> +	u32 count;
>=20=20
>  /* The 'schedule' variable records, in its sign, whether 'now' is before=
 or
>   * after 'drop_next'.  This allows 'drop_next' to be updated before the =
next
> @@ -528,45 +536,50 @@ static enum qdisc_drop_reason cobalt_should_drop(st=
ruct cobalt_vars *vars,
>  	over_target =3D sojourn > p->target &&
>  		      sojourn > p->mtu_time * bulk_flows * 2 &&
>  		      sojourn > p->mtu_time * 4;
> -	next_due =3D vars->count && ktime_to_ns(schedule) >=3D 0;
> +	count =3D vars->count;
> +	next_due =3D count && ktime_to_ns(schedule) >=3D 0;
>=20=20
>  	vars->ecn_marked =3D false;
>=20=20
>  	if (over_target) {
>  		if (!vars->dropping) {
> -			vars->dropping =3D true;
> -			vars->drop_next =3D cobalt_control(now,
> -							 p->interval,
> -							 vars->rec_inv_sqrt);
> +			WRITE_ONCE(vars->dropping, true);
> +			WRITE_ONCE(vars->drop_next,
> +				   cobalt_control(now,
> +						  p->interval,
> +						  vars->rec_inv_sqrt));
>  		}
> -		if (!vars->count)
> -			vars->count =3D 1;
> +		if (!count)
> +			count =3D 1;
>  	} else if (vars->dropping) {
> -		vars->dropping =3D false;
> +		WRITE_ONCE(vars->dropping, false);
>  	}
>=20=20
>  	if (next_due && vars->dropping) {
>  		/* Use ECN mark if possible, otherwise drop */
> -		if (!(vars->ecn_marked =3D INET_ECN_set_ce(skb)))
> +		vars->ecn_marked =3D INET_ECN_set_ce(skb);
> +		if (!vars->ecn_marked)
>  			reason =3D QDISC_DROP_CONGESTED;
>=20=20
> -		vars->count++;
> -		if (!vars->count)
> -			vars->count--;
> -		cobalt_invsqrt(vars);
> -		vars->drop_next =3D cobalt_control(vars->drop_next,
> -						 p->interval,
> -						 vars->rec_inv_sqrt);
> +		count++;
> +		if (!count)
> +			count--;
> +		cobalt_invsqrt(vars, count);
> +		WRITE_ONCE(vars->drop_next,
> +			   cobalt_control(vars->drop_next,
> +					  p->interval,
> +					  vars->rec_inv_sqrt));
>  		schedule =3D ktime_sub(now, vars->drop_next);
>  	} else {
>  		while (next_due) {
> -			vars->count--;
> -			cobalt_invsqrt(vars);
> -			vars->drop_next =3D cobalt_control(vars->drop_next,
> -							 p->interval,
> -							 vars->rec_inv_sqrt);
> +			count--;
> +			cobalt_invsqrt(vars, count);
> +			WRITE_ONCE(vars->drop_next,
> +				   cobalt_control(vars->drop_next,
> +						  p->interval,
> +						  vars->rec_inv_sqrt));
>  			schedule =3D ktime_sub(now, vars->drop_next);
> -			next_due =3D vars->count && ktime_to_ns(schedule) >=3D 0;
> +			next_due =3D count && ktime_to_ns(schedule) >=3D 0;
>  		}
>  	}
>=20=20
> @@ -575,11 +588,12 @@ static enum qdisc_drop_reason cobalt_should_drop(st=
ruct cobalt_vars *vars,
>  	    get_random_u32() < vars->p_drop)
>  		reason =3D QDISC_DROP_FLOOD_PROTECTION;
>=20=20
> +	WRITE_ONCE(vars->count, count);
>  	/* Overload the drop_next field as an activity timeout */
> -	if (!vars->count)
> -		vars->drop_next =3D ktime_add_ns(now, p->interval);
> +	if (count)

This seems to reverse the conditional?

> +		WRITE_ONCE(vars->drop_next, ktime_add_ns(now, p->interval));
>  	else if (ktime_to_ns(schedule) > 0 && reason =3D=3D QDISC_DROP_UNSPEC)
> -		vars->drop_next =3D now;
> +		WRITE_ONCE(vars->drop_next, now);
>=20=20
>  	return reason;
>  }
> @@ -813,7 +827,7 @@ static u32 cake_hash(struct cake_tin_data *q, const s=
truct sk_buff *skb,
>  		     i++, k =3D (k + 1) % CAKE_SET_WAYS) {
>  			if (q->tags[outer_hash + k] =3D=3D flow_hash) {
>  				if (i)
> -					q->way_hits++;
> +					WRITE_ONCE(q->way_hits, q->way_hits + 1);
>=20=20
>  				if (!q->flows[outer_hash + k].set) {
>  					/* need to increment host refcnts */
> @@ -831,7 +845,7 @@ static u32 cake_hash(struct cake_tin_data *q, const s=
truct sk_buff *skb,
>  		for (i =3D 0; i < CAKE_SET_WAYS;
>  			 i++, k =3D (k + 1) % CAKE_SET_WAYS) {
>  			if (!q->flows[outer_hash + k].set) {
> -				q->way_misses++;
> +				WRITE_ONCE(q->way_misses, q->way_misses + 1);
>  				allocate_src =3D cake_dsrc(flow_mode);
>  				allocate_dst =3D cake_ddst(flow_mode);
>  				goto found;
> @@ -841,7 +855,7 @@ static u32 cake_hash(struct cake_tin_data *q, const s=
truct sk_buff *skb,
>  		/* With no empty queues, default to the original
>  		 * queue, accept the collision, update the host tags.
>  		 */
> -		q->way_collisions++;
> +		WRITE_ONCE(q->way_collisions, q->way_collisions + 1);
>  		allocate_src =3D cake_dsrc(flow_mode);
>  		allocate_dst =3D cake_ddst(flow_mode);
>=20=20
> @@ -875,7 +889,8 @@ static u32 cake_hash(struct cake_tin_data *q, const s=
truct sk_buff *skb,
>  			q->flows[reduced_hash].srchost =3D srchost_idx;
>=20=20
>  			if (q->flows[reduced_hash].set =3D=3D CAKE_SET_BULK)
> -				cake_inc_srchost_bulk_flow_count(q, &q->flows[reduced_hash], flow_mo=
de);
> +				cake_inc_srchost_bulk_flow_count(q, &q->flows[reduced_hash],
> +								 flow_mode);
>  		}
>=20=20
>  		if (allocate_dst) {
> @@ -899,7 +914,8 @@ static u32 cake_hash(struct cake_tin_data *q, const s=
truct sk_buff *skb,
>  			q->flows[reduced_hash].dsthost =3D dsthost_idx;
>=20=20
>  			if (q->flows[reduced_hash].set =3D=3D CAKE_SET_BULK)
> -				cake_inc_dsthost_bulk_flow_count(q, &q->flows[reduced_hash], flow_mo=
de);
> +				cake_inc_dsthost_bulk_flow_count(q, &q->flows[reduced_hash],
> +								 flow_mode);
>  		}
>  	}
>=20=20
> @@ -1379,9 +1395,9 @@ static u32 cake_calc_overhead(struct cake_sched_dat=
a *qd, u32 len, u32 off)
>  		len -=3D off;
>=20=20
>  	if (qd->max_netlen < len)
> -		qd->max_netlen =3D len;
> +		WRITE_ONCE(qd->max_netlen, len);
>  	if (qd->min_netlen > len)
> -		qd->min_netlen =3D len;
> +		WRITE_ONCE(qd->min_netlen, len);
>=20=20
>  	len +=3D q->rate_overhead;
>=20=20
> @@ -1401,9 +1417,9 @@ static u32 cake_calc_overhead(struct cake_sched_dat=
a *qd, u32 len, u32 off)
>  	}
>=20=20
>  	if (qd->max_adjlen < len)
> -		qd->max_adjlen =3D len;
> +		WRITE_ONCE(qd->max_adjlen, len);
>  	if (qd->min_adjlen > len)
> -		qd->min_adjlen =3D len;
> +		WRITE_ONCE(qd->min_adjlen, len);
>=20=20
>  	return len;
>  }
> @@ -1416,7 +1432,7 @@ static u32 cake_overhead(struct cake_sched_data *q,=
 const struct sk_buff *skb)
>  	u16 segs =3D qdisc_pkt_segs(skb);
>  	u32 len =3D qdisc_pkt_len(skb);
>=20=20
> -	q->avg_netoff =3D cake_ewma(q->avg_netoff, off << 16, 8);
> +	WRITE_ONCE(q->avg_netoff, cake_ewma(q->avg_netoff, off << 16, 8));
>=20=20
>  	if (segs =3D=3D 1)
>  		return cake_calc_overhead(q, len, off);
> @@ -1590,16 +1606,17 @@ static unsigned int cake_drop(struct Qdisc *sch, =
struct sk_buff **to_free)
>  	}
>=20=20
>  	if (cobalt_queue_full(&flow->cvars, &b->cparams, now))
> -		b->unresponsive_flow_count++;
> +		WRITE_ONCE(b->unresponsive_flow_count,
> +			   b->unresponsive_flow_count + 1);
>=20=20
>  	len =3D qdisc_pkt_len(skb);
>  	q->buffer_used      -=3D skb->truesize;
> -	b->backlogs[idx]    -=3D len;
> -	b->tin_backlog      -=3D len;
> +	WRITE_ONCE(b->backlogs[idx], b->backlogs[idx] - len);
> +	WRITE_ONCE(b->tin_backlog, b->tin_backlog - len);
>  	qstats_backlog_sub(sch, len);
>=20=20
> -	flow->dropped++;
> -	b->tin_dropped++;
> +	WRITE_ONCE(flow->dropped, flow->dropped + 1);
> +	WRITE_ONCE(b->tin_dropped, b->tin_dropped + 1);
>=20=20
>  	if (q->config->rate_flags & CAKE_FLAG_INGRESS)
>  		cake_advance_shaper(q, b, skb, now, true);
> @@ -1795,7 +1812,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
>  	}
>=20=20
>  	if (unlikely(len > b->max_skblen))
> -		b->max_skblen =3D len;
> +		WRITE_ONCE(b->max_skblen, len);
>=20=20
>  	if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLIT_=
GSO) {
>  		struct sk_buff *segs, *nskb;
> @@ -1819,13 +1836,13 @@ static s32 cake_enqueue(struct sk_buff *skb, stru=
ct Qdisc *sch,
>  			numsegs++;
>  			slen +=3D segs->len;
>  			q->buffer_used +=3D segs->truesize;
> -			b->packets++;

Right above this hunk we do sch->q.qlen++; - does that need changing as
well?

>  		}
>=20=20
>  		/* stats */
> -		b->bytes	    +=3D slen;
> -		b->backlogs[idx]    +=3D slen;
> -		b->tin_backlog      +=3D slen;
> +		WRITE_ONCE(b->bytes, b->bytes + slen);
> +		WRITE_ONCE(b->packets, b->packets + numsegs);
> +		WRITE_ONCE(b->backlogs[idx], b->backlogs[idx] + slen);
> +		WRITE_ONCE(b->tin_backlog, b->tin_backlog + slen);
>  		qstats_backlog_add(sch, slen);
>  		q->avg_window_bytes +=3D slen;
>=20=20
> @@ -1843,10 +1860,10 @@ static s32 cake_enqueue(struct sk_buff *skb, stru=
ct Qdisc *sch,
>  			ack =3D cake_ack_filter(q, flow);
>=20=20
>  		if (ack) {
> -			b->ack_drops++;
> +			WRITE_ONCE(b->ack_drops, b->ack_drops + 1);
>  			qdisc_qstats_drop(sch);
>  			ack_pkt_len =3D qdisc_pkt_len(ack);
> -			b->bytes +=3D ack_pkt_len;
> +			WRITE_ONCE(b->bytes, b->bytes + ack_pkt_len);
>  			q->buffer_used +=3D skb->truesize - ack->truesize;
>  			if (q->config->rate_flags & CAKE_FLAG_INGRESS)
>  				cake_advance_shaper(q, b, ack, now, true);
> @@ -1859,10 +1876,10 @@ static s32 cake_enqueue(struct sk_buff *skb, stru=
ct Qdisc *sch,
>  		}
>=20=20
>  		/* stats */
> -		b->packets++;
> -		b->bytes	    +=3D len - ack_pkt_len;
> -		b->backlogs[idx]    +=3D len - ack_pkt_len;
> -		b->tin_backlog      +=3D len - ack_pkt_len;
> +		WRITE_ONCE(b->packets, b->packets + 1);
> +		WRITE_ONCE(b->bytes, b->bytes + len - ack_pkt_len);
> +		WRITE_ONCE(b->backlogs[idx], b->backlogs[idx] + len - ack_pkt_len);
> +		WRITE_ONCE(b->tin_backlog, b->tin_backlog + len - ack_pkt_len);
>  		qstats_backlog_add(sch, len - ack_pkt_len);
>  		q->avg_window_bytes +=3D len - ack_pkt_len;
>  	}
> @@ -1894,9 +1911,9 @@ static s32 cake_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
>  			u64 b =3D q->avg_window_bytes * (u64)NSEC_PER_SEC;
>=20=20
>  			b =3D div64_u64(b, window_interval);
> -			q->avg_peak_bandwidth =3D
> -				cake_ewma(q->avg_peak_bandwidth, b,
> -					  b > q->avg_peak_bandwidth ? 2 : 8);
> +			WRITE_ONCE(q->avg_peak_bandwidth,
> +				   cake_ewma(q->avg_peak_bandwidth, b,
> +					     b > q->avg_peak_bandwidth ? 2 : 8));
>  			q->avg_window_bytes =3D 0;
>  			q->avg_window_begin =3D now;
>=20=20
> @@ -1917,27 +1934,30 @@ static s32 cake_enqueue(struct sk_buff *skb, stru=
ct Qdisc *sch,
>  		if (!flow->set) {
>  			list_add_tail(&flow->flowchain, &b->new_flows);
>  		} else {
> -			b->decaying_flow_count--;
> +			WRITE_ONCE(b->decaying_flow_count,
> +				   b->decaying_flow_count - 1);
>  			list_move_tail(&flow->flowchain, &b->new_flows);
>  		}
>  		flow->set =3D CAKE_SET_SPARSE;
> -		b->sparse_flow_count++;
> +		WRITE_ONCE(b->sparse_flow_count,
> +			   b->sparse_flow_count + 1);
>=20=20
> -		flow->deficit =3D cake_get_flow_quantum(b, flow, q->config->flow_mode);
> +		WRITE_ONCE(flow->deficit,
> +			   cake_get_flow_quantum(b, flow, q->config->flow_mode));
>  	} else if (flow->set =3D=3D CAKE_SET_SPARSE_WAIT) {
>  		/* this flow was empty, accounted as a sparse flow, but actually
>  		 * in the bulk rotation.
>  		 */
>  		flow->set =3D CAKE_SET_BULK;
> -		b->sparse_flow_count--;
> -		b->bulk_flow_count++;
> +		WRITE_ONCE(b->sparse_flow_count, b->sparse_flow_count - 1);
> +		WRITE_ONCE(b->bulk_flow_count, b->bulk_flow_count + 1);
>=20=20
>  		cake_inc_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
>  		cake_inc_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
>  	}
>=20=20
>  	if (q->buffer_used > q->buffer_max_used)
> -		q->buffer_max_used =3D q->buffer_used;
> +		WRITE_ONCE(q->buffer_max_used, q->buffer_used);
>=20=20
>  	if (q->buffer_used <=3D q->buffer_limit)
>  		return NET_XMIT_SUCCESS;
> @@ -1976,8 +1996,8 @@ static struct sk_buff *cake_dequeue_one(struct Qdis=
c *sch)
>  	if (flow->head) {
>  		skb =3D dequeue_head(flow);
>  		len =3D qdisc_pkt_len(skb);
> -		b->backlogs[q->cur_flow] -=3D len;
> -		b->tin_backlog		 -=3D len;
> +		WRITE_ONCE(b->backlogs[q->cur_flow], b->backlogs[q->cur_flow] - len);
> +		WRITE_ONCE(b->tin_backlog, b->tin_backlog - len);
>  		qstats_backlog_sub(sch, len);
>  		q->buffer_used		 -=3D skb->truesize;
>  		qdisc_qlen_dec(sch);
> @@ -2042,7 +2062,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *s=
ch)
>=20=20
>  		cake_configure_rates(sch, new_rate, true);
>  		q->last_checked_active =3D now;
> -		q->active_queues =3D num_active_qs;
> +		WRITE_ONCE(q->active_queues, num_active_qs);
>  	}
>=20=20
>  begin:
> @@ -2149,8 +2169,10 @@ static struct sk_buff *cake_dequeue(struct Qdisc *=
sch)
>  		 */
>  		if (flow->set =3D=3D CAKE_SET_SPARSE) {
>  			if (flow->head) {
> -				b->sparse_flow_count--;
> -				b->bulk_flow_count++;
> +				WRITE_ONCE(b->sparse_flow_count,
> +					   b->sparse_flow_count - 1);
> +				WRITE_ONCE(b->bulk_flow_count,
> +					   b->bulk_flow_count + 1);
>=20=20
>  				cake_inc_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
>  				cake_inc_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
> @@ -2165,7 +2187,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *s=
ch)
>  			}
>  		}
>=20=20
> -		flow->deficit +=3D cake_get_flow_quantum(b, flow, q->config->flow_mode=
);
> +		WRITE_ONCE(flow->deficit,
> +			   flow->deficit + cake_get_flow_quantum(b, flow, q->config->flow_mod=
e));
>  		list_move_tail(&flow->flowchain, &b->old_flows);
>=20=20
>  		goto retry;
> @@ -2177,7 +2200,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *s=
ch)
>  		if (!skb) {
>  			/* this queue was actually empty */
>  			if (cobalt_queue_empty(&flow->cvars, &b->cparams, now))
> -				b->unresponsive_flow_count--;
> +				WRITE_ONCE(b->unresponsive_flow_count,
> +					   b->unresponsive_flow_count - 1);
>=20=20
>  			if (flow->cvars.p_drop || flow->cvars.count ||
>  			    ktime_before(now, flow->cvars.drop_next)) {
> @@ -2187,16 +2211,22 @@ static struct sk_buff *cake_dequeue(struct Qdisc =
*sch)
>  				list_move_tail(&flow->flowchain,
>  					       &b->decaying_flows);
>  				if (flow->set =3D=3D CAKE_SET_BULK) {
> -					b->bulk_flow_count--;
> +					WRITE_ONCE(b->bulk_flow_count,
> +						   b->bulk_flow_count - 1);
>=20=20
> -					cake_dec_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
> -					cake_dec_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
> +					cake_dec_srchost_bulk_flow_count(b, flow,
> +									 q->config->flow_mode);
> +					cake_dec_dsthost_bulk_flow_count(b, flow,
> +									 q->config->flow_mode);

These seem like unnecessary whitespace changes?

>=20=20
> -					b->decaying_flow_count++;
> +					WRITE_ONCE(b->decaying_flow_count,
> +						   b->decaying_flow_count + 1);
>  				} else if (flow->set =3D=3D CAKE_SET_SPARSE ||
>  					   flow->set =3D=3D CAKE_SET_SPARSE_WAIT) {
> -					b->sparse_flow_count--;
> -					b->decaying_flow_count++;
> +					WRITE_ONCE(b->sparse_flow_count,
> +						   b->sparse_flow_count - 1);
> +					WRITE_ONCE(b->decaying_flow_count,
> +						   b->decaying_flow_count + 1);
>  				}
>  				flow->set =3D CAKE_SET_DECAYING;
>  			} else {
> @@ -2204,14 +2234,20 @@ static struct sk_buff *cake_dequeue(struct Qdisc =
*sch)
>  				list_del_init(&flow->flowchain);
>  				if (flow->set =3D=3D CAKE_SET_SPARSE ||
>  				    flow->set =3D=3D CAKE_SET_SPARSE_WAIT)
> -					b->sparse_flow_count--;
> +					WRITE_ONCE(b->sparse_flow_count,
> +						   b->sparse_flow_count - 1);
>  				else if (flow->set =3D=3D CAKE_SET_BULK) {
> -					b->bulk_flow_count--;
> +					WRITE_ONCE(b->bulk_flow_count,
> +						   b->bulk_flow_count - 1);
>=20=20
> -					cake_dec_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
> -					cake_dec_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);

Same here?

-Toke


