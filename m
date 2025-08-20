Return-Path: <netdev+bounces-215406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7248EB2E7EE
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 00:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A979A25765
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 22:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC22218AB4;
	Wed, 20 Aug 2025 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="98oNY+0g";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="LTiVPiWJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E126FBF
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 22:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755727707; cv=none; b=Etn8krYJll9/Iz1E9BfyqkjjTTzYPJtiGEshdDez3MnP7GZ/v8ZR6maAHT8qlMpunNotfXUeymfbEaqixzO9Y9dSwuDME5tu5NBeE0INkYggya3MBVDcH377ozo3A+Ctg0rDW/kRtz/1BXI60Vjn1iwbxsgWjDO6MV2gWYmmD+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755727707; c=relaxed/simple;
	bh=/x5QajoDgwXMVSw/rIZyRh3DUpqBRNIKtnaUkyxQFmg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AacLNBQ+L66s8KPVcFOzA32/s9EZ5f8nX26RSpNb2XGvRuQBPdRoNI7OAzB+Z2N1gqsvm9sdDYeki1IX6x8s2DuyXLmrzsmIeW2qGvp8dQEtjLRWXdRJ3oi+R10L6lB0dSMAspg10VAbXOHxbDWOxU0wQSFIMR1hGgVLkyJANvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=98oNY+0g; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=LTiVPiWJ; arc=none smtp.client-ip=160.80.4.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 57KM85Fx001719;
	Thu, 21 Aug 2025 00:08:10 +0200
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id F42031200FE;
	Thu, 21 Aug 2025 00:07:50 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1755727681; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vj3AszSloNl44Ayy6ELMYJwkKykzed1iUZ0ZK9inZek=;
	b=98oNY+0gr40+BMBwtQ/xBMVRPP3Y2s4RqkNMPcMcpc8qg4kyVAHAKZ1aAjGfl4qXeKLOff
	VW2cOfWIDYKQ4HBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1755727681; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vj3AszSloNl44Ayy6ELMYJwkKykzed1iUZ0ZK9inZek=;
	b=LTiVPiWJ2w6ADGx6MjLifPuUqKwUNdBi6ZbK363E7W/5HYJB6ezF0o2IKS4jS3kOcdilsk
	eggKp0zP1SBfyvv/zSbswqdvAFM5ooqk4U8D3gCEyEDjfsbw86OS58Lm3HB+4aU0c2GDFi
	URoxbAyDyNweK3X0RzsQ9nf1HxTYgWBnl73c3hSQo7y+DgREtHGnj+gNjROb2Mf9ESrcmn
	zcsqKgemh4k+ugia/+CTxTAkkHH1YF72gBPQwAlRYE2iqTTa9PHs5swMMPqaTUKsSpnK7O
	qFwIDxJYVjpLj/tyq8Uy3nBNbR1JNcPYLKctedNVEfY/jOydGsczlxEKvmPmAg==
Date: Thu, 21 Aug 2025 00:07:43 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org,
        David Ahern
 <dsahern@gmail.com>, David Lebrun <dlebrun@google.com>,
        Paolo Lungaroni
 <paolo.lungaroni@uniroma2.it>,
        stefano.salsano@uniroma2.it, Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH iproute2-next v2] man8: ip-sr: Document that passphrase
 must be high-entropy
Message-Id: <20250821000743.0679c8cc8b41d0c9821c7727@uniroma2.it>
In-Reply-To: <20250820125458.0335f600@hermes.local>
References: <20250816031846.483658-1-ebiggers@kernel.org>
	<20250820092535.415ee6e0@hermes.local>
	<20250820184317.GA1838@quark>
	<20250820125458.0335f600@hermes.local>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Wed, 20 Aug 2025 12:54:58 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> On Wed, 20 Aug 2025 11:43:17 -0700
> Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > On Wed, Aug 20, 2025 at 09:25:35AM -0700, Stephen Hemminger wrote:
> > > On Fri, 15 Aug 2025 20:18:46 -0700
> > > Eric Biggers <ebiggers@kernel.org> wrote:
> > >   
> > > > diff --git a/man/man8/ip-sr.8 b/man/man8/ip-sr.8
> > > > index 6be1cc54..cd8c5d18 100644
> > > > --- a/man/man8/ip-sr.8
> > > > +++ b/man/man8/ip-sr.8
> > > > @@ -1,6 +1,6 @@
> > > > -.TH IP\-SR 8 "14 Apr 2017" "iproute2" "Linux"
> > > > +.TH IP\-SR 8 "15 Aug 2025" "iproute2" "Linux"  
> > > 
> > > NAK - do not change man page date for each change.  
> > 
> > Sure, if that's the convention for this project.  Note that this differs
> > from the convention used by most projects with dated man pages.  The
> > purpose of the date is normally to indicate how fresh the man page is.
> > 
> > > >  .SH "NAME"
> > > >  ip-sr \- IPv6 Segment Routing management
> > > >  .SH SYNOPSIS
> > > >  .sp
> > > >  .ad l
> > > > @@ -32,13 +32,21 @@ internal parameters.
> > > >  .PP
> > > >  Those parameters include the mapping between an HMAC key ID and its associated
> > > >  hashing algorithm and secret, and the IPv6 address to use as source for encapsulated
> > > >  packets.
> > > >  .PP
> > > > -The \fBip sr hmac set\fR command prompts for a passphrase that will be used as the
> > > > -HMAC secret for the corresponding key ID. A blank passphrase removes the mapping.
> > > > -The currently supported algorithms for \fIALGO\fR are \fBsha1\fR and \fBsha256\fR.
> > > > +The \fBip sr hmac set\fR command prompts for a newline-terminated "passphrase"  
> > > 
> > > That implies that newline is part of the pass phrase.  
> > 
> > Not really.  "NUL-terminated" strings don't include the NUL in the
> > string content.  If you prefer, it could be made explicit as follows:
> > 
> >     The \fBip sr hmac set\fR command prompts for a "passphrase" that
> >     will be used as the HMAC secret for the corresponding key ID. The
> >     passphrase is terminated by a newline, but the terminating newline
> >     is not included in the resulting passphrase.
> > 
> > But I don't think it's very useful, as it's not needed to know how to
> > use the command correctly.
> > 
> > > The code to read password is using getpass() which is marked as obsolete
> > > in glibc. readpassphrase is preferred.  
> > 
> > Is that relevant to this documentation patch?
> > 
> > > > +that will be used as the HMAC secret for th
> 
> Since this is only part of iproute2 that uses getpass() probably should
> be rethought. Having key come from terminal seems hard to script
> and awkward.

Hi Stephen,

Recently, I started working on implementing some self-tests for SRv6 on HMAC.
The command:

  ip sr hmac set <keyid> <algo>

uses getpass() internally, as you mentioned earlier, which can be inconvenient
for automation.

To address this, Paolo Lungaroni has extended the command to support an
additional parameter called "secret" (this is within our internal fork of
iproute2):

  ip sr hmac set 17 sha1 secret <your-secret>

This enhancement allows the secret to be specified directly on the command
line, making it much more convenient for scripting and automated testing
environments.
If the "secret" parameter is not provided, the command will continue to behave
as before, prompting for the passphrase interactively (i.e., the legacy
behavior; we haven't modified the getpass() function, but we can consider to
update it).

If you're interested, I can reach out to Paolo Lungaroni, the author of this
patchset, tomorrow morning (CEST) and ask him to prepare everything for
submission, including updates to the man page.

Andrea

