Return-Path: <netdev+bounces-216173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CF6B32574
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 01:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79CF63A94B0
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 23:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1E22D7DD9;
	Fri, 22 Aug 2025 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="HuEHcqOk";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="JsJSEbGO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF279222581
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 23:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755906000; cv=none; b=HbUe8qwcpm4+giVMGDuBOaoqdyWaezeE0yTgQ/Rne/mUoijy7F/gQxzuiOiOyqikm9hmnZ0HLMsOtaX2c/Z0QrdFcT6cU4NOUoBk2pedXlEfESk9FtTm6HNsSfpnUSn6ETu8A52DLTqOVP2eqVzd8m0Gdn43xFzoeYAFEXaMjmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755906000; c=relaxed/simple;
	bh=Pjgqyo8a27okc9G41kZ+AdsRi256Mod0gB8SyNMLbow=;
	h=Date:Message-ID:From:To:Cc:Subject:References:In-Reply-To:
	 Content-Type:MIME-Version:Content-Disposition; b=Ilg1+GYFCr1xIGpBR8tEB8jizYMUcOroFpbLWUZcat0O830tkTAaSGhRUZXsxkJ/7pQuuFr5Kpwy/wq20IpBo/vVCWqhNQOtbZYqFc2L74u9BNh8VjG3nPkE77bpUVeuagigsNGyFKdUXUa9QlNQ0ZZhs9JQ+gg4vEMJLbRFmck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=HuEHcqOk; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=JsJSEbGO; arc=none smtp.client-ip=160.80.4.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 57MNdPdm017783;
	Sat, 23 Aug 2025 01:39:30 +0200
Received: from webmail.uniroma2.it (webmail.uniroma2.it [160.80.1.162])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 71C251200C8;
	Sat, 23 Aug 2025 01:39:22 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1755905962; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+gArkknKkq/0KnvUdMPt5lL4vjD5PLtnqxB2s6KCweE=;
	b=HuEHcqOk9e5ajSslaUnM8selQRkM3mgYZMRWZFxkiS8SFOITRl9zUxquD5XBFZmRe1LG0J
	DogzJ9/+kn2xOjBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1755905962; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+gArkknKkq/0KnvUdMPt5lL4vjD5PLtnqxB2s6KCweE=;
	b=JsJSEbGOrg8/TtX2X0x58A5hdvy4P4yuN4dg7voEWvgGVI9jx/cVHNMbB/2PW8rE5MTaBL
	za7EwrZmbG+GSIKFcamIqoPeVhNmiuSWPpdW1Xhy6Kp5YGo7nyR1bT/Kq20cfsXsTeGJ1s
	RAg8Wo5EvwngiE7xjAJmPOL2JqjQULpuuFwU5w6YzOzDCWg2nzo8Ck40Gu/lgx+dYECqjF
	Av8ELBKu8D8dSVPSFKWK/Iemc5tI14/Nt1/Kij4IUjs0lxDRpbqfNxmVhb6ZeHzVcIMVqF
	hmmQKaw/KDcjdL2dmcMMVNZPX04FLEBzp3XPHu0XgKQnmrruDBecHOdkbWgB5A==
Received: from host-79-46-239-209.retail.telecomitalia.it
 (host-79-46-239-209.retail.telecomitalia.it [79.46.239.209]) by
 webmail.uniroma2.it (Horde Framework) with HTTPS; Sat, 23 Aug 2025 01:39:22
 +0200
Date: Sat, 23 Aug 2025 01:39:22 +0200
Message-ID: <20250823013922.Horde.J-H85jaVn6AHI0UeML3QS3m@webmail.uniroma2.it>
From: Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>,
        Stephen Hemminger
 <stephen@networkplumber.org>,
        netdev@vger.kernel.org, David Ahern
 <dsahern@gmail.com>,
        David Lebrun <dlebrun@google.com>, stefano.salsano@uniroma2.it
Subject: Re: [PATCH iproute2-next v2] man8: ip-sr: Document that passphrase
 must be high-entropy
References: <20250816031846.483658-1-ebiggers@kernel.org>
 <20250820092535.415ee6e0@hermes.local> <20250820184317.GA1838@quark>
 <20250820125458.0335f600@hermes.local>
 <20250821000743.0679c8cc8b41d0c9821c7727@uniroma2.it>
 <20250821032132.GA185832@quark>
In-Reply-To: <20250821032132.GA185832@quark>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

Eric Biggers <ebiggers@kernel.org> ha scritto:

> On Thu, Aug 21, 2025 at 12:07:43AM +0200, Andrea Mayer wrote:
>> On Wed, 20 Aug 2025 12:54:58 -0700
>> Stephen Hemminger <stephen@networkplumber.org> wrote:
>>
>> > On Wed, 20 Aug 2025 11:43:17 -0700
>> > Eric Biggers <ebiggers@kernel.org> wrote:
>> >
>> > > On Wed, Aug 20, 2025 at 09:25:35AM -0700, Stephen Hemminger wrote:
>> > > > On Fri, 15 Aug 2025 20:18:46 -0700
>> > > > Eric Biggers <ebiggers@kernel.org> wrote:
>> > > >
>> > > > > diff --git a/man/man8/ip-sr.8 b/man/man8/ip-sr.8
>> > > > > index 6be1cc54..cd8c5d18 100644
>> > > > > --- a/man/man8/ip-sr.8
>> > > > > +++ b/man/man8/ip-sr.8
>> > > > > @@ -1,6 +1,6 @@
>> > > > > -.TH IP\-SR 8 "14 Apr 2017" "iproute2" "Linux"
>> > > > > +.TH IP\-SR 8 "15 Aug 2025" "iproute2" "Linux"
>> > > >
>> > > > NAK - do not change man page date for each change.
>> > >
>> > > Sure, if that's the convention for this project.  Note that this differs
>> > > from the convention used by most projects with dated man pages.  The
>> > > purpose of the date is normally to indicate how fresh the man page is.
>> > >
>> > > > >  .SH "NAME"
>> > > > >  ip-sr \- IPv6 Segment Routing management
>> > > > >  .SH SYNOPSIS
>> > > > >  .sp
>> > > > >  .ad l
>> > > > > @@ -32,13 +32,21 @@ internal parameters.
>> > > > >  .PP
>> > > > >  Those parameters include the mapping between an HMAC key  
>> ID and its associated
>> > > > >  hashing algorithm and secret, and the IPv6 address to use  
>> as source for encapsulated
>> > > > >  packets.
>> > > > >  .PP
>> > > > > -The \fBip sr hmac set\fR command prompts for a passphrase  
>> that will be used as the
>> > > > > -HMAC secret for the corresponding key ID. A blank  
>> passphrase removes the mapping.
>> > > > > -The currently supported algorithms for \fIALGO\fR are  
>> \fBsha1\fR and \fBsha256\fR.
>> > > > > +The \fBip sr hmac set\fR command prompts for a  
>> newline-terminated "passphrase"
>> > > >
>> > > > That implies that newline is part of the pass phrase.
>> > >
>> > > Not really.  "NUL-terminated" strings don't include the NUL in the
>> > > string content.  If you prefer, it could be made explicit as follows:
>> > >
>> > >     The \fBip sr hmac set\fR command prompts for a "passphrase" that
>> > >     will be used as the HMAC secret for the corresponding key ID. The
>> > >     passphrase is terminated by a newline, but the terminating newline
>> > >     is not included in the resulting passphrase.
>> > >
>> > > But I don't think it's very useful, as it's not needed to know how to
>> > > use the command correctly.
>> > >
>> > > > The code to read password is using getpass() which is marked  
>> as obsolete
>> > > > in glibc. readpassphrase is preferred.
>> > >
>> > > Is that relevant to this documentation patch?
>> > >
>> > > > > +that will be used as the HMAC secret for th
>> >
>> > Since this is only part of iproute2 that uses getpass() probably should
>> > be rethought. Having key come from terminal seems hard to script
>> > and awkward.
>>
>> Hi Stephen,
>>
>> Recently, I started working on implementing some self-tests for  
>> SRv6 on HMAC.
>> The command:
>>
>>   ip sr hmac set <keyid> <algo>
>>
>> uses getpass() internally, as you mentioned earlier, which can be  
>> inconvenient
>> for automation.
>>
>> To address this, Paolo Lungaroni has extended the command to support an
>> additional parameter called "secret" (this is within our internal fork of
>> iproute2):
>>
>>   ip sr hmac set 17 sha1 secret <your-secret>
>>
>> This enhancement allows the secret to be specified directly on the command
>> line, making it much more convenient for scripting and automated testing
>> environments.
>> If the "secret" parameter is not provided, the command will  
>> continue to behave
>> as before, prompting for the passphrase interactively (i.e., the legacy
>> behavior; we haven't modified the getpass() function, but we can consider to
>> update it).
>>
>> If you're interested, I can reach out to Paolo Lungaroni, the author of this
>> patchset, tomorrow morning (CEST) and ask him to prepare everything for
>> submission, including updates to the man page.
>
> Passwords and keys don't belong on the command line, since command lines
> are often visible to all users.  Standard input is the correct way to do
> it.  The issue you seem to referring to is that the command currently
> works only when standard input is a tty.  It should of course be fixed
> to work for any file, which would allow automation via something like
> 'ip sr hmac set 17 sha256 < passphrase.txt'.  (And to be clear, that's a
> separate issue from the lack of passphrase stretching.)
>
> When giving example commands, please also use sha256 instead of sha1.
>
> - Eric

Ciao Eric,

The scheme I followed to develop my patch proposal is inspired by the one
already present in ip xfrm and ip macsec.
These two features require the configuration of key entered inline in the
command prompt.
The keys are also shown in plain text in the show. It should be noted,  
however,
that there are mechanisms (in some cases optional, see more later) to mask the
printing of keys.

Here are a few examples:

MACsec:

# ip link add macsec0 link eth0 type macsec encrypt on
# ip macsec add macsec0 tx sa 0 pn 1 on key 00  
12345678901234567890123456789012
# ip macsec add macsec0 rx port 1 address 00:00:12:34:56:78
# ip macsec add macsec0 rx port 1 address 00:00:12:34:56:78 sa 0 pn 1  
on key 01 09876543210987654321098765432109
# ip macsec show
4: macsec0: protect on validate strict sc off sa off encrypt on  
send_sci on end_station off scb off replay off
     cipher suite: GCM-AES-128, using ICV length 16
     TXSC: 525400d4ad0f0001 on SA 0
         0: PN 1, state on, key 00000000000000000000000000000000
     RXSC: 325341bd7c270001, state on
         0: PN 1, state on, key 01000000000000000000000000000000
     offload: off

IPsec (xfrm)

# ip xfrm state add src fc00::1 dst fc00::2 \
           proto esp spi 0x00123456 reqid 0x12345678 mode transport \
           auth sha256  
0x1234567890123456789012345678901234567890123456789012345678901234 \
           enc aes  
0x0987654321098765432109876543210987654321098765432109876543210987
# ip xfrm state list
src fc00::1 dst fc00::2
   proto esp spi 0x00123456 reqid 305419896 mode transport
   replay-window 0
   auth-trunc hmac(sha256)  
0x1234567890123456789012345678901234567890123456789012345678901234 96
   enc cbc(aes)  
0x0987654321098765432109876543210987654321098765432109876543210987
   anti-replay context: seq 0x0, oseq 0x0, bitmap 0x00000000
   sel src ::/0 dst ::/0

In these cases, other methods of insertion via file, pipe or stdin are not
supported.

In ip sr hmac set, I simply took inspiration from the examples shown above and
replicated something similar while maintaining backward compatibility with the
previous interactive mode.

One more note: on ip xfrm state list, you can shadow the keys if you enter a
specific keyword (nokeys).

# ip xfrm state list nokeys
src fc00::1 dst fc00::2
   proto esp spi 0x00123456 reqid 305419896 mode transport
   replay-window 0
   auth-trunc hmac(sha256) <<Keys hidden>> 96
   enc cbc(aes) <<Keys hidden>>
   anti-replay context: seq 0x0, oseq 0x0, bitmap 0x00000000
   sel src ::/0 dst ::/0

I can update my patch to also support ip sr hmac show, which uses an identical
secret masking mechanism.

===

Regarding your statement: 'And to be clear, that's a separate issue from the
lack of passphrase stretching,' yes, you're right: they are indeed separate.

According to RFC8754, 'The pre-shared key identified by HMAC Key ID'  
is used as
is in the HMAC computation.

I'm trying to understand how 'stretching the passphrase' could work with other
network appliances that are not Linux. Stretching the passphrase only in the
Linux implementation seems to make it incompatible with RFC8754 and,
consequently, with other software and hardware that implement Segment Routing
over IPv6 HMAC.

As an example, at the computation level, I need to use the same key when
communicating with hardware routers and when calculating an HMAC that the
hardware device can verify. If we implement passphrase stretching in Linux,
what would be the input string I should provide in iproute2 to ensure that the
same key used in the hardware device (which does not perform passphrase
stretching) is used?

Could you please clarify what you intend to do and how to remain compatible
with RFC8754, which defines HMAC for SRv6?

Best regards,
Paolo.



