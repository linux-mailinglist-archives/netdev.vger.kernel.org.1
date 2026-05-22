Return-Path: <netdev+bounces-290863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLY+HOh2EGoZXgYAu9opvQ
	(envelope-from <netdev+bounces-290863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:31:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E71B5B6ED9
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 22B1830E2440
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 14:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29DE45BD4E;
	Fri, 22 May 2026 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvN3kuP+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5435D453497;
	Fri, 22 May 2026 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779460905; cv=none; b=Z/U1FHdiL04o7L8DCrU1CUmDjrVMYb88z1yNF1ktd6OdwEbALRHEniK05RdCdehdyKw6So9+wOn/uElUVUlSCe+3HVfv7/LxgiRNEon+rYOPFXv2EuZtPXnnYFTCCVURDofKw0g+D/3Fw/GPqmY9IPawXggLjXpkxCxFIxvhqEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779460905; c=relaxed/simple;
	bh=6kwndAI54ykbd14MfQpobPLyWZQFunt8w+NTyqwBzoA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dtJnUPsO2VK57SojTIZxGScje5N9dUZVjR6u09fmnCib61KXxapvnhyioCbQvZIo1Ge7swxAlu3FMtiNhL5QANzb7gzFHhiviCQKKT5/Tn86stL2ccVLHVBabzziUW9lkCROZpgysLL8q1yADs4qI6kYqZXAJiQ9qXJDO3z67KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvN3kuP+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1EE1E1F000E9;
	Fri, 22 May 2026 14:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779460904;
	bh=XhazYkywIhcFYHcRayPh7W596CTcJBSKO86QebIax/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=WvN3kuP+IVdtbn3hl0XTrnzZkf7sI3FZiQFfeYOi3r2K+V4QeRlINGCd3UBWxEIzt
	 Ario05nMx60HmIBq5sDLD41KKirvXqqgu82lp06ro1O8z9egBf6MZ0+s494fn+cJp6
	 T6NRrEs8aIyf/BI9B/lZr9jPDea6OTvACsoY5TnAz6V853e9tmJ7iljiPtNZuzg33V
	 F5a4f+1022hOCzMCZdg5UW0R7eGgnsMxy6nNmJiGp130alW8OMZvGfnyiCIjoNTJwU
	 9ewovBWRWXECultSAyH2tptxygRZNgEV+jGwfXKuAuvaPocmqfuBDHoIXVRL4134zm
	 11POazFhNHV+Q==
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
In-Reply-To: <0d13721307646d7ca2bf1aaf22926f0137b9de30.camel@infradead.org>
References: <20260514225842.110706-1-hramamurthy@google.com>
 <20260514225842.110706-4-hramamurthy@google.com>
 <cd5868258edee932fd9b4ed46a48b5a07b4c6da8.camel@infradead.org>
 <87tss0vdrj.ffs@tglx>
 <63ff978516925951df0f95aecbd4ea5d7bb2956e.camel@infradead.org>
 <87bje8v0xl.ffs@tglx>
 <38ded3d61878f319ad74869924a55665d8baadb9.camel@infradead.org>
 <877bovvq78.ffs@tglx>
 <0d13721307646d7ca2bf1aaf22926f0137b9de30.camel@infradead.org>
Date: Fri, 22 May 2026 16:41:40 +0200
Message-ID: <871pf3v74r.ffs@tglx>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290863-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.966];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,intel.com,vger.kernel.org,linutronix.de];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,tglx:email]
X-Rspamd-Queue-Id: 6E71B5B6ED9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22 2026 at 09:56, David Woodhouse wrote:
> On Fri, 2026-05-22 at 09:49 +0200, Thomas Gleixner wrote:
>> > Yes. Isn't that what I asked Arthur to do?
>>=20
>> You maybe asked him, but I can't see any evidence of it anywhere. All I
>> can see is a magic struct attr, which conveys CS related data that is
>> supposed to be produced magically at some undefined place.
>
> https://lore.kernel.org/all/8b8a748a2ac6e8e3d970f5e74a2774133e7e7d8c.came=
l@infradead.org/

Right, after I pointed it out :)

>> > > > Is that not how it works? If not.... WTF *is* it for?
>> > >=20
>> > > Yes, that's the way it works since get_device_system_crosststamp() g=
ot
>> > > introduced, but that does not give a random driver access to the act=
ual
>> > > converted (TSC) counter value. The driver can only observe the PTM v=
alue
>> > > which is ART on x86 and whatever on other architectures. So it does =
not
>> > > know anything about it.
>> >=20
>> > Sure, the driver can only return what it *knows*.
>> >=20
>> > We're certainly missing some infrastructure here... maybe the pci_bus
>> > should have a CSID which corresponds to its PTM domain, which on x86
>> > would be CSID_X86_ART?
>>=20
>> Yes, that's correct. But that does not solve the underlying problem:
>>=20
>> ...
>>
>> Q: How is a driver supposed to fill in attr->cs_cycles coherently?
>>=20
>> A: Not at all.
>>=20
>
> Let me rephrase that to check my full understanding of it in context:
>
>  Q: There are drivers today which operate on the TSC or arch counter,
>     and they're just fine. But how is a future driver which uses PCIe
>     PTM supposed to full in attr->cs_cycles coherently?
>
>  A: Yeah, our PCI and platform code lack the proper arch-agnostic
>     support for interpreting PTM time values; a driver wanting to do
>     that is going to need to do some infrastructure work first to
>     enable a proper conversion. But that's literally what PTM/ART is
>     *for* so that work has to happen at some point anyway.

That work is there:

     get_device_system_cross_timestamp()

The only lacking feature is that there is no generic PCI method to tell
the driver which PMT clocksource ID it should use.

So the drivers do it manually:

   system->cycles =3D PTM_READ();
   system->cs_id =3D CSID_ART;

instead of doing:

   system->cs_id =3D pci_dev_ptm_csid(pdev);

everything else is done by the core code for several years already.

The core code provides:

    - PCH timestamp
    - sys_realtime derived from system->cycles
    - sys_monoraw derived from system->cycles

So now with your new proposed attr extenstions, you want attr to return
system->cycles to user space and you don't want the raw PTM value (ART)
but you want the corresponding TSC value which is:

    TSC =3D M * ART + offset;

But the driver has no access to this information. That's why I'm ranting
about an interface which lacks the infrastructure to utilize it
properly.

I've seen this in the past 20 years over and over. The lack of
infrastructure makes driver people do abysmal hacks because they are
tasked to utilize the new interface. The result is a horrible mess,
which others have to clean up later when they want to do core changes.

>> The consequence of this is that the next driver writer will just go and
>> do:
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr->cs_id =3D IS_ENABLED(X86) ? C=
SID_X86_TSC : CSID_ARM_COUNTER;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr->cs_cycles =3D get_cycles();
>> =C2=A0=C2=A0 or
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr->cs_cycles =3D ptm_cycles * pu=
lledout_of_thin_air_factor +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pu=
lledout_of_thin_air_offset;
>
> Driver authors are crap, sure, but that would just be egregiously wrong
> and hopefully it would be caught in review.

You wish. Shit get's merged faster than you can mop it up.

I agree that driver authors are interesting creatures, but you can't
whack them over the head when there is no generic infrastructure they
can use. They never will go and extend existing or provide new
infrastructure. That's on the people who add new functionality, which
will be consumed by driver writers.

> It has to be a literally *synchronous* capture or it's pointless.

You know that and I know that, but ...

>> The same applies to the pre/post timestamp mechanism for
>> gettimexattrs64().
>
> There's literally a ptp helper to generate those, which can use
> ktime_get_snapshot().

With some massaging, yes. Now that someone provided an extensible
snapshot function. :)

> Of *course* I'm trying to solve things for the general case.
>
> But that doesn't extend to implementing random parts of PCI and
> platform infrastructure to allow for hypothetical future drivers which
> want to use PTM to implement the optional fields we're adding today.

Optional fields are going to get filled when people see value in
them. You need no new drivers for that. Existing drivers hop on the new
bus as soon as it hits the road.

>> > Never get_cycles(). Let's perhaps make it *not* need unholy hacks to
>> > interpret a PTM counter value. Otherwise what's the point in ART and
>> > PTM at all?
>>=20
>> Perhaps? There is no perhaps and aside of that I gave you the solution
>> for the problem already in the mail you just replied to, no?
>
> Hm, did you? I'm sorry, I must have missed it. Even rereading it this
> morning, I see a lot of 'is bonkers' and 'unholy hacks' and '_cannot_
> fill them in coherently' but I can't see a concrete constructive
> suggestion. You meant <87bje8v0xl.ffs@tglx>, yes?

The demonstration patches to extend ktime_get_snapshot() and the half
assed support in get_device_system_crosststamp(). You actually asked me
to provide a SOB for the ktime_get_snapshot_id() part. No?

> Maybe it's lost in the noise. Let's try to simplify.
>
>  =E2=80=A2 Userspace would like to be able to use PTP clocks to disciplin=
e the
>    actual counter which is directly accessible in userspace and by KVM
>    guests. Do do this, we only really need a system_counterval_t in
>    the pre/post timestamps, and the helpers can add that.
>
>  =E2=80=A2 *Some* drivers can actually provide a system_counterval_t in t=
he
>    device reading itself, either because they're naturally based on
>    the CPU counter or because they have PTM. Drivers should report
>    what=C2=A0they *do* know, in the correct time domain, and not make
>    crap up.

     Which needs support in get_device_system_crosststamp() because
     that's what drivers have to use to utilize PTM.

>  =E2=80=A2 Any driver which actually wants to do this based on PTM in the
>    future will need to do the infrastructure work to make that work
>    cleanly, and avoid having to make crap up.

     That's wishful thinking. It did not happen in the last two decades
     so why would this be different today?

> And if I'm understanding correctly:
>
>  =E2=80=A2 The GVE driver made crap up? Although they do so orthogonally =
to the
>    patch set we're *actually* talking about in this thread, because
>    they did that entirely on their own *without* reference to Arthur's
>    userspace API changes?

Correct.

Let's move this to the other thread which actually talks about your
vmclock stuff.

Thanks,

        tglx

