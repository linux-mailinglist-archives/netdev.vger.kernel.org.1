Return-Path: <netdev+bounces-290714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIdGMiIMEGpqSwYAu9opvQ
	(envelope-from <netdev+bounces-290714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:56:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5FC5B0440
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 26A2C301902C
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070C13A5E9E;
	Fri, 22 May 2026 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTtH4SvS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B6939061D;
	Fri, 22 May 2026 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779436192; cv=none; b=m9zCzTaIa/Mn9HfJiWICsmJXz7j7jc7IZMKPQXtQaFd0nF0FOdx/p9pNsGWF2pl7IbEPONlYYK81cHHA7fF1c6LE3n/VQ1DMu6HE8cvHA9ilABa7Hwf/gOrHShMShRA0kSW2j4XgaOLHLiyPcPDoyWqT9dh+xQS8cBlpl+dSMH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779436192; c=relaxed/simple;
	bh=OEZ/RGESlWViizQ8Mdc0YYcBdRwlhgiefjsvtUoKQaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hH2JYBQ0fdnlJbExSFnmy7u8eQsXY7quTeqY0uAx8lo4BZYgWMSOl40SPKG/pBpjsLiZmKnif6nutPgL8j0o7PAmQ/lxH5PBinmDFPtlUmPY8sFK9iTjC1ltwJiKkBtgZPzGpuo/B3sAisuSAY009Pj/xwsn7zXZNvHn144jlNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTtH4SvS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 792F91F000E9;
	Fri, 22 May 2026 07:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779436191;
	bh=UTZ+v+2T0JKFk3EeFAx1g/ZlkREKCjoGk4RioeeBzGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=HTtH4SvSSVcmGVhq8qvIzeKLPehOnZ9wHMChPThW9vHgrcThd4S6u2UQCzLYXY712
	 2hJkZuTVVoCge8GDNTxP2ih7oDxG0Mlffuazpsycq+x7DgxUGljsA/+PpQvVjYe5Mr
	 YM213lmevr17d0a8c2wXMiOkH5tAiw7BLqIIO/vydZC/b2limzoDuDot3LyU1v+ISJ
	 eR2oI6cIZL5lSYYIhNuacJHrOoXWvSJsXseIOhNOJyzU6S6GQl8Ah4oiRyiAM0233Q
	 pbsFopTlBOnUIiimfUjA373VRbxtCkHt8s33Z5kHz268/sx/ts9XcfvQAf6d40LSXZ
	 WH/FdTXa+0y3A==
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
In-Reply-To: <38ded3d61878f319ad74869924a55665d8baadb9.camel@infradead.org>
References: <20260514225842.110706-1-hramamurthy@google.com>
 <20260514225842.110706-4-hramamurthy@google.com>
 <cd5868258edee932fd9b4ed46a48b5a07b4c6da8.camel@infradead.org>
 <87tss0vdrj.ffs@tglx>
 <63ff978516925951df0f95aecbd4ea5d7bb2956e.camel@infradead.org>
 <87bje8v0xl.ffs@tglx>
 <38ded3d61878f319ad74869924a55665d8baadb9.camel@infradead.org>
Date: Fri, 22 May 2026 09:49:47 +0200
Message-ID: <877bovvq78.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [4.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290714-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,intel.com,vger.kernel.org,linutronix.de];
	NEURAL_HAM(-0.00)[-0.502];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4D5FC5B0440
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22 2026 at 01:12, David Woodhouse wrote:
> On Fri, 2026-05-22 at 00:43 +0200, Thomas Gleixner wrote:
>> > So surely a device can only support this if it *does* have a precise
>> > hardware timestamp, e.g. from ART? And the corresponding sys_realtime
>> > and sys_monoraw fields also have to be from the *same* value, surely?
>> 
>> That is correct, but you still fail to explain how this new made up
>> att.counter_id/att.counter_value is filled in coherently without the
>> driver doing something abysmal?
>>
>> You can't explain it, because the only way to do that correctly is by
>> extending the cross time stamp struct and get_device_system_crosststamp().
>
> Yes. Isn't that what I asked Arthur to do?

You maybe asked him, but I can't see any evidence of it anywhere. All I
can see is a magic struct attr, which conveys CS related data that is
supposed to be produced magically at some undefined place.

>> > Is that not how it works? If not.... WTF *is* it for?
>> 
>> Yes, that's the way it works since get_device_system_crosststamp() got
>> introduced, but that does not give a random driver access to the actual
>> converted (TSC) counter value. The driver can only observe the PTM value
>> which is ART on x86 and whatever on other architectures. So it does not
>> know anything about it.
>
> Sure, the driver can only return what it *knows*.
>
> We're certainly missing some infrastructure here... maybe the pci_bus
> should have a CSID which corresponds to its PTM domain, which on x86
> would be CSID_X86_ART?

Yes, that's correct. But that does not solve the underlying problem:

The driver gets the PTP/SystemTime pair from the hardware/firmware,
which is what it hands back to get_device_system_crosststamp(). What
does SystemTime mean?

Here it gets interesting as that depends on the NIC/PTP magic firmware
and the architecture:

   On X86:

     - The plain ART value, which is converted to TSC in
       get_device_system_crosststamp().

     - The ART value which is magically converted to "nanoseconds" by
       the firmware.

    That is conveyed in system_counterval_t and the 'use_nsec' flag,
    which is a misnomer, determines the conversion in the core.
   
     - If set it uses the nominal frequency of the underlying base clock
       (ART) for conversion.
   
     - If not it uses the nominator/denominator pair of the underlying base
       clock (ART) for conversion.
   
   On ARM64:
   
     - The ARM ARCH counter value (however that is converted from PTM
       magically)
   
     - The ARM ARCH counter which is magically converted to "nanoseconds"
       by the firmware. Actually it's not, but the drivers claim it is.
   
     It does not matter because the core does no conversion for ARM64 as
     the SystemTime CSID is the same as the core timekeeper CSID.

Q: How is a driver supposed to fill in attr->cs_cycles coherently?

A: Not at all.

The consequence of this is that the next driver writer will just go and
do:

       attr->cs_id = IS_ENABLED(X86) ? CSID_X86_TSC : CSID_ARM_COUNTER;
       attr->cs_cycles = get_cycles();
   or
       attr->cs_cycles = ptm_cycles * pulledout_of_thin_air_factor +
                         pulledout_of_thin_air_offset;

and this mess is going to proliferate faster than you can breathe.

The same applies to the pre/post timestamp mechanism for
gettimexattrs64().

These new attr IOCTLs are not restricted to your favorite vmclock PTP
toy. They are available for every PTP driver which implements them, but
there is no infrastructure to actually provide the required data. That
ENA driver implementing gettimexattrs64() is demonstrating it. It at
least does not try to make them up, but that's just a matter of time to
happen.

I know you don't care because that's outside of your sandpit, but I care
because providing this interface is going to result in random drivers
growing the most absurd warts just to work around the lack of core
infrastructure.

Are you going to monitor drivers/net/ for those instances and make sure
they are burned before seeing the light of day?

Surely not and neither is netdev going to care as demonstrated with
this GEV mess.

It took me half an hour to add basic support for that into the core
infrastructure, but this new IOCTL stuff has been in the making for
almost a year without anyone spending a single brain cycle to even think
about it.

And you just have proven it by still claiming that this is a completely
cosmetic problem.

Seriously?

>> I agree, but the way how this attr.counter_id/value extension is defined
>> either requires unholy hacks to get access to the ART/TSC conversion or
>> resort to get_cycles().

> Never get_cycles(). Let's perhaps make it *not* need unholy hacks to
> interpret a PTM counter value. Otherwise what's the point in ART and
> PTM at all?

Perhaps? There is no perhaps and aside of that I gave you the solution
for the problem already in the mail you just replied to, no?

I'm glad we agree on "Never get_cycles()" at least. May I ask you then
to get a stiff drink ready and run:

  # git blame drivers/ptp/ptp_vmclock.c | grep get_cycles

:)

Thanks,

        tglx

