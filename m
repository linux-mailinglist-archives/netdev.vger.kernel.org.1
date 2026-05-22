Return-Path: <netdev+bounces-290864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODvJE4t3EGoZXgYAu9opvQ
	(envelope-from <netdev+bounces-290864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:34:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5B75B6F69
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C32930ED66F
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 14:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C1F28C037;
	Fri, 22 May 2026 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArWfXnOm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7FE1EB5F8;
	Fri, 22 May 2026 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779461201; cv=none; b=LI1TU2lTE6I9q5uUXA0uV2HqVTgokfVxm1YE3RO/xTF8uNmWiQThdm50gq4rn45ffHlYVVOUd0KbpoN8LjKXnGhRMcwizh5Ina51OzG8hh67dmFNi61w3VlOK75fKn4p935sWeI+IqVfi3quydj09n1aZ66HJL3paz3sPMnqx7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779461201; c=relaxed/simple;
	bh=Yp0VhlSjj4hC2bY8q4IjNmRjjbYV8C00jZK2I3AyY6I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eHQDhaT9W/SsXze2qb32B9kXR74OCFRvO+WyNbUNkER5VLwQNkrNA2ClTVBLEL/XrB9/1m0oRGbTUTlHhjcvVBHmmhSdIrlsagS6EWU6/sL7HhiIdGd1pwLKKoNA7enbI5b0SMOgYX1jKmvtyNBtLhb5NEvY4TOMrhADktxQ9dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArWfXnOm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A0F8B1F000E9;
	Fri, 22 May 2026 14:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779461199;
	bh=SGZr8Z9dvV6o2/B3gMU5MbwLi0hr/e+BnLdke7tQ7YE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ArWfXnOmiM7hqpskVqjSpkVw34uhn3pqyjxZCXoT2Daxo36AJYjkkGtTclcDez/b6
	 as6xFrJNvqspDm1Zm71AYi2ksyo5pOi9ZAaIYlyQJzBSTXmPVycysiNEPLi4bYr0Px
	 wpDXPMFZ6AdyJMe00cH37Uy/REAQwWHuhozc9KrRD+I43wHQbqTDAUocErxEkjs7zX
	 k0cqTFWm8l4C1ucJBv8VzPzEzdGaI0U4BiAF3IBWWgEJHt+5XBvhdnGqU8kdleYGzs
	 d0EairH0WAbinTYK17yfWwyiNcoP2045Yazzg3tbTTU3v6aK1jcr2NyfSkErS8nIzS
	 HoAhGBMVVlAqA==
From: Thomas Gleixner <tglx@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>, Harshitha Ramamurthy
 <hramamurthy@google.com>, netdev@vger.kernel.org, Arthur Kiyanovski
 <akiyano@amazon.com>
Cc: joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, jstultz@google.com, sboyd@kernel.org,
 willemb@google.com, nktgrg@google.com, jfraker@google.com,
 ziweixiao@google.com, maolson@google.com, jordanrhee@google.com,
 thostet@google.com, alok.a.tiwari@oracle.com, pkaligineedi@google.com,
 horms@kernel.org, jacob.e.keller@intel.com, yyd@google.com,
 jefrogers@google.com, linux-kernel@vger.kernel.org, Naman Gulati
 <namangulati@google.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH net-next v8 3/3] gve: implement PTP gettimex64
In-Reply-To: <aee6f77138e5f173d36f3f4ce65cc2acc4e4ae69.camel@infradead.org>
References: <20260514225842.110706-1-hramamurthy@google.com>
 <20260514225842.110706-4-hramamurthy@google.com>
 <cd5868258edee932fd9b4ed46a48b5a07b4c6da8.camel@infradead.org>
 <87tss0vdrj.ffs@tglx>
 <63ff978516925951df0f95aecbd4ea5d7bb2956e.camel@infradead.org>
 <87bje8v0xl.ffs@tglx>
 <aee6f77138e5f173d36f3f4ce65cc2acc4e4ae69.camel@infradead.org>
Date: Fri, 22 May 2026 16:46:36 +0200
Message-ID: <87y0hbtsc3.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290864-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.920];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,intel.com,vger.kernel.org,linutronix.de];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5B5B75B6F69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22 2026 at 11:34, David Woodhouse wrote:
> On Fri, 2026-05-22 at 00:43 +0200, Thomas Gleixner wrote:
>> =C2=A0=C2=A0=C2=A0=C2=A0 1) Guest TSC value at freeze
>> =C2=A0=C2=A0=C2=A0=C2=A0 2) Guest nominal TSC frequency
>> =C2=A0=C2=A0=C2=A0=C2=A0 3) Old host REALTIME at freeze - Ideally you us=
e TAI
>> =C2=A0=C2=A0=C2=A0=C2=A0 4) New host TSC frequency
>> =C2=A0=C2=A0=C2=A0=C2=A0 5) New host TSC/REALTIME/TAI snapshot
>>=20
>> =C2=A0 #1 is a KVM problem, but see #3
>> =C2=A0=20
>> =C2=A0 #2 ideally communicated from the guest to the host after early
>> =C2=A0=C2=A0=C2=A0=C2=A0 initialization at boot.
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0 You really want this information because the gu=
est won't change the
>> =C2=A0=C2=A0=C2=A0=C2=A0 mult/shift pair for it ever.
>
> If *tell* the guest the frequency in CPUID, then it shouldn't be trying
> to manually calibrate it against an emulated PIT while suffering steal
> time, and its mult/shift should have a little bit less entropy.

They are identical on every boot evaluation.

> Even a system which *has* to do that crappy calibration still does it
> with a lot more *precision* than accuracy, so I suspect we ought to be
> rounding the result to the nearest 1MHz as long as that's within 10PPM
> or something like that. But that really *is* a digression :)

:)

> The model I'm enabling and documenting for KVM migration is basically
> within the noise of what you describe above, yes.
>
> But if we want to give the illusion of the TSC just ticking away while
> the guest happens to experience a little steal time, when in fact it's
> been completely migrated to a new host, we actually want to work with
> the *true* running frequency of the TSC at the moment of migration.
>
> So...=20
>
>  1)=C2=A0Use clock_get_time_reference() to get a { host tsc, time, rate }
>     from the source host at 'freeze' time.=20
>
>  2) Use clock_get_time_reference() to get a { host tsc, time, rate }
>     from the destination host, when resuming.
>
>  3) (Optionally) scale the guest's TSC frequency, not by the *nominal*=C2=
=A0
>     rates, but by the *actual* ratio of the rates from (1) and (2)
>     above (plus any original nominal scaling of the guest's TSC from
>     the original host).
>
>  4) Calculate the guest TSC *offset* in order to convey the effect
>     that the guest's TSC continued to tick at the rate from (1),
>     during the time period between (1) and (2).
>
>  5) (Optionally) Once the guest is running, slowly undo the scaling
>     in=C2=A0(1) in order to get the guest back to a nice simple unscaled
>     TSC (or scaled only by nominal frequencies as it was when launched)
>
>
> Obviously, a dedicated environment which disciplines its TSC directly
> can do all of that right now already because it *has* all the
> information it would get from clock_get_time_reference().
>
> But as you know perfectly well, Thomas, I'm never happy to keep the
> blinkers on and focus only on my specific use case at hand; I want this
> to work for the *general* case, including people running QEMU in a
> fairly standard environment. And I think clock_get_time_reference()
> might be a reasonable way of doing that, and a fairly clean counterpart
> to the clock_set_time_reference() you suggested?

Agreed.

