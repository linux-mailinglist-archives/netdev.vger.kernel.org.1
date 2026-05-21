Return-Path: <netdev+bounces-290628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DcbNNqKD2qnNAYAu9opvQ
	(envelope-from <netdev+bounces-290628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 00:44:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBF85AC729
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 00:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EDCA3033F9E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 22:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D10835AC24;
	Thu, 21 May 2026 22:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fp1sGh9U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B383563C7;
	Thu, 21 May 2026 22:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779403404; cv=none; b=gG0/t+OduGA6ZNj/X6oykqY9E3cXa7YMfzTnxB+OD1uhhKz93Oe6GkQwyU/5AAGKxd0Dmnp9GhV+uvg8H/oTP4TEBSDzqQemlQJw1j0hoAeEVOZKlahgtkcY8Q67sGMHVrQUKR9xQllfo8CLBkCowNcVFzEKiERcZZvodL5dqhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779403404; c=relaxed/simple;
	bh=caz9R6GJsHjBM35v75bwuV2JWRZo0NlSlf+W9Q4MeaM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n7OCrvH+Jj67V37KssKWY20ba5VRRFGJCMPm7R9GECVy3hXdLJcCpAyRGY4haVUphBR6ujVCIaSqv2UMjeNCezESUTH2XkqW6GBrChmsKZ4ILk0uvptzyE+ArEnLtT/aetxdggKx0EuFwA5MCMiSixuHffP3GiL3rQzSPxSYyGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fp1sGh9U; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8009F1F000E9;
	Thu, 21 May 2026 22:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779403402;
	bh=sfmUOwNhhpcINsPZHcWUWRwlQqcSxS+LOAqE+w8QiN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Fp1sGh9UTfnMF7soOGjZUss4KjK9V0LKdnmR1+/H3UUK14WPfc/YP6Imtax9IxWvM
	 ac9Nv1RRjH1JbObYlnUvTVkRM6E1rMeDKK495Whiac8OjgwNXFkr5CDwhm3MkkR5ly
	 ZoSfs34aUHa72MiddpTtaHCEVUM/l7FPXtG6An3qg19k6jrQRYdZqDyrc5iIwy24Q9
	 eNk41mLLeuy1kM/nQz3Oej5tG/eC1WtvHRtIaCmfyG32/fbSjJkh0x5nKmYjDMEcw/
	 GiADbzKPOY2z6nAuQ87fmcvwftWqo7mrpVjzAWSdR6OLQ/ffcmepPWd0CmFDmnaldS
	 ruR+yWVa56FFg==
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
In-Reply-To: <63ff978516925951df0f95aecbd4ea5d7bb2956e.camel@infradead.org>
References: <20260514225842.110706-1-hramamurthy@google.com>
 <20260514225842.110706-4-hramamurthy@google.com>
 <cd5868258edee932fd9b4ed46a48b5a07b4c6da8.camel@infradead.org>
 <87tss0vdrj.ffs@tglx>
 <63ff978516925951df0f95aecbd4ea5d7bb2956e.camel@infradead.org>
Date: Fri, 22 May 2026 00:43:18 +0200
Message-ID: <87bje8v0xl.ffs@tglx>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290628-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,intel.com,vger.kernel.org,linutronix.de];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3EBF85AC729
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21 2026 at 20:59, David Woodhouse wrote:
> On Thu, 2026-05-21 at 20:06 +0200, Thomas Gleixner wrote:
>> > It might be good to harmonise the way we convert to KVM clock if we're
>> > going to support that (although I'll accept an argument that any guest
>> > which chooses to use the KVM clock doesn't *deserve* to have accurate
>> > timekeeping).
>>=20
>> :)
>
> I'm not sure I'm joking. The KVM clock is.... *hosed*. It was invented
> to work around the ancient broken variable-speed TSCs which stopped on
> HLT, etc.
>
> In *those* days, sure it made sense for the hypervisor to constantly
> update a data structure which let you approximate a TSC=E2=86=92nanosecon=
ds
> conversion.

It was broken from day one and I explained the why in great length
several times. But features first, correctness later...

At some point I gave up and ignored all complaints about time
inconsistencies in guests which use kvmclock.

> These days, a guest using the *actual* TSC is going to be a lot more
> accurate, and guests basically shouldn't be using the kvmclock AT ALL.

You're preaching to the choir.

> When I made it DTRT for ptp_vmclock, I did look briefly at what it
> would take to do it centrally in common code.
>
> But that lumbers the common PTP code with x86 arch-specific horridness
> about the KVM clock. And it literally has to call back into the driver
> in the seqcount loop, so I guess drivers would need to have a flag or
> something that says it's OK to do that (they're fast enough, or
> something?).
>
> I didn't spent *that* long trying, but I couldn't see a way of doing it
> centrally, which didn't end up making me sadder than the initial
> duplication.
>
> Honestly, whether it was intent or omission, I suspect the approach
> Harshitha took for GVE is the right one: Support TSC, and anyone who
> uses KVM clock doesn't deserve accurate time anyway.

I agree with the sentiment, but the implementation is just bonkers TBH.

The driver should not even care about TSC/ARM_XX. Drivers have to be
mostly agnostic of this and we went to a great length for that with the
existing PTM core support. The core might need extensions for the pre/post
muck, but that's not a justification for hacks like this GVE stuff.

>> > From the dedicating hosting point of view, we *only* care about the
>> > counter, and absolutely DGAF about the host's timekeeping. Migrating
>> > KVM guests requires getting the guest TSC right (in terms of scaling
>> > factors and offset from the host TSC), and feeding accurate time to
>> > guests is done in terms of the guest TSC to realtime relationship.
>>=20
>> The offset has nothing to do with the scaling. It's the delta to the TSC
>> value which the migrated guest saw last when it was packed up for
>> migration.
>
> Sure. As long as that guest TSC value is a consistent snapshot and not
> some pulled out of thin air cycles value :)

That's a different problem, which has nothing to do with the issue at
hand and if that's not solved, then providing accurate frequency ratios
is not making it much better :)

> There is lots to be said about accurate KVM migration, and a series of
> 30-odd patches on the KVM list which attempts to improve it.
>
> But either way, we still DGAF about the host's CLOCK_REALTIME when
> we're doing it at scale.
>
> KVM doesn't *have* a clean way to get/set the guest TSC based on
> realtime; it only has the scaling and offsets from the host TSC. So to
> do things precisely, we end up converting via the host TSC.
>
> So we end up comparing a {host TSC, realtime} pair between source and
> destination hosts, calculating the *guest* ticks that should have
> occurred in the intervening time, and setting the "offset from host" on
> the destination host to achieve the desired results. Almost all of
> which is in terms of TSC cycles and offsets.

Fine, but you can only do that accurately if you have the relevant
parameters:

     1) Guest TSC value at freeze
     2) Guest nominal TSC frequency
     3) Old host REALTIME at freeze - Ideally you use TAI
     4) New host TSC frequency
     5) New host TSC/REALTIME/TAI snapshot

  #1 is a KVM problem, but see #3
=20=20
  #2 ideally communicated from the guest to the host after early
     initialization at boot.

     You really want this information because the guest won't change the
     mult/shift pair for it ever.

     That is more accurate than using the scaling factor on the old host
     plus the old host frequency. Especially if you are migrating the VM
     several times because every migration results obviously in rounding
     errors, while if you use the nominal guest frequency you keep this
     back and forth conversions and the resulting errors out of the way.

  #3 That's obviously related to #1

     The old host knows the guest TSC scaling and the guest offset, so
     it can take a coherent snapshot on the host side of REALTIME/TAI
     and the host TSC value, which is convertible to the guest TSC
     value.

  #4, 5

     are obviously required to set up the new host scaling/offset for
     the guest TSC, but if based on the nominal assumed TSC frequency of
     the guest it becomes actually accurate and usable across several
     migrations.

Anything else is just crystal ball magic, which is what KVM has today....

>> > +	precise_offset_attrs.device.att.counter_id =3D att.counter_id;
>> > +	precise_offset_attrs.device.att.counter_value =3D att.counter_value;
>>=20
>> That's exactly the hackery which is counterproductive. Why?
>
> That's the same pattern as in the existing ptp_sys_offset_precise(),
> isn't it? Copying from the internal data structures it got from the
> driver, into the specific userspace structure for the ioctl that was
> called.

No.

Q: How does the driver know what the snapshot of NIC/SYSTEM time means?
A: It does not.

That's what get_device_system_crosststamp() encapsulates in a generic
way, which removes architecture/system specific knowledge from the
driver.

Q: How can the driver fill in att.counter_id and att.counter_value
   _without_ specific knowlegde?
A: It _cannot_ without get_device_system_crosststamp() providing it.

Which is what I tried to explain you here:

>> Where does ptp::info::getcrosststampattrs() retrieve the system counter
>> value from?
>>=20
>> Either it has to convert from the ART based timestamp to TSC magically
>> by circumventing the core code or it has to use get_cycles() separately
>> which defeats the whole purpose of a hardware latched combo timestamp.
>
> The point in ptp_sys_offset_precise is that all the timestamps are the
> *same* time, isn't it?

Yes.

> So surely a device can only support this if it *does* have a precise
> hardware timestamp, e.g. from ART? And the corresponding sys_realtime
> and sys_monoraw fields also have to be from the *same* value, surely?

That is correct, but you still fail to explain how this new made up
att.counter_id/att.counter_value is filled in coherently without the
driver doing something abysmal?

You can't explain it, because the only way to do that correctly is by
extending the cross time stamp struct and get_device_system_crosststamp().

> Is that not how it works? If not.... WTF *is* it for?

Yes, that's the way it works since get_device_system_crosststamp() got
introduced, but that does not give a random driver access to the actual
converted (TSC) counter value. The driver can only observe the PTM value
which is ART on x86 and whatever on other architectures. So it does not
know anything about it.

> We're allowed to set *fire* to anyone who just throws a random
> get_cycles() call in there, aren't we? That's basically just self-
> defence, m'lud.

I agree, but the way how this attr.counter_id/value extension is defined
either requires unholy hacks to get access to the ART/TSC conversion or
resort to get_cycles().

>> While this:
...=20

>> +	xtstamp->sys_counter =3D system_counterval;

...

simple core code change:

>> Provides the information coherently and without any extra hacks. No?
>
> Yeah, that looks eminently reasonable. It isn't actually that far off
> what Arthur did in patch 1 of the series, is it? He was adding other
> clock quality attributes at the same time, and ended up shoe-horning
> the cs_id and cycle_count into those instead of using a separate
> system_counterval_t as you have here, which *is* cleaner. So yes, let's
> get him to do that, but that part is cosmetic?

No. It's not cosmetic.

This patch #1 just defines new attributes, which include the CS ID and
the CS counter value with absolutely ZERO explanation where these values
are supposed to come from and ZERO explanation how they are coherent.

It suggests that the driver can fill them in along with the other truly
driver related data, e.g. error_bound.

But as I explained before the driver _cannot_ fill them in coherently
neither for the new gettimexattrs64() nor for the getcrosststampattrs()
callbacks.

So you add an extension to the existing interface without core support,
which means once that is merged the driver crowd will happily take any
shortcut to support it.

Are _you_ going to mop up the resulting mess?

>> Extending get_device_system_crosststamp() for AUX clocks is on my todo
>> list for a long time, but I did not come around to it yet. It's not
>> really complicated to make that work.
>>=20
>> The actual ena_phc_gettimexattrs64() implementation does not provide the
>> counter value at all despite the fact that it could trivially do so with
>> a modified ktime_get_snapshot() except for AUX clock IDs, but that's a
>> solvable problem. See uncompiled PoC below.
>
> Huh? Unless it has PTM and is converting from ART (or is something
> virtual like vmclock or the older non-LM-safe KVM hacks), surely the
> driver has no business pretending to support 'precise' mode, and no
> business providing a counter value?

Huch?

According to your earlier argumentation about counter values, you want
the counter value, REALTIME, RAW combo even for gettimexattrs64() for
the pre/post timestamps in case the hardware does not support PTM, no?

> In this case, we'd want the pre_ts and post_ts to be generated by the
> common code using ktime_get_snapshot_id(cs_id) so that we have the
> corresponding system_counterval_t in the 'A' parts of the ABA tuple...
> but the device part of it can't pull one out of thin air unless it is
> *part* of the device reading, surely?

Correct, but where does the proposed patch set implement any of this?

In the ena driver it sets cs_id and cs_value to 0, which will be
replaced by abysmal hacks within no time because someone figures out
that adding these values will give "better" results ....

Neither the gettimexattrs64() nor the getcrosststampattrs() have any
coherent way to fill in the CS related data, but you are pushing for
adding this infrastructure first before thinking about the
consequences. You can't be serious about that.

>> I really have to ask why we put a lot of effort into consolidated
>> infrastructure, when every drivers/foo/ subsystem decides it needs it's
>> own absymal hacks just because sitting down and extending the generic
>> infrastructure is asked too much. TBH, that's frustrating as hell and
>> no, none of these usecases is so special that it would justify a single
>> one of these hacks.
>
> Meh. I'm literally here trying to join the dots between timekeeping,
> PTP and KVM, and come up with a holistic solution that makes sense for
> all the use cases. And my brain hurts... :)

Welcome to the wonderful world of time(keeping). Once you have done that
for 20 years your brain stops to hurt :)

Thanks,

        tglx

