Return-Path: <netdev+bounces-215391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DACF0B2E5E6
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 21:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70CF4AA3495
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 19:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA3226E6F8;
	Wed, 20 Aug 2025 19:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="pxTa2RBQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C07519258E
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755719707; cv=none; b=XMEdbPf1K5/rIszSOk02vIC/eRJpQwBJS4LZjHJP+j9LjcgmLiTC1FXQQhfXSKsAVrjBrTr11rSAOdpNLxZKR6Wz3l3SxYxNocJw+swp6F3/FGlP3mT3PIzljObmnAbXjhOdanXsX6qs2pfPU9xnL/jpYCortTNyr/vtCMcFkJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755719707; c=relaxed/simple;
	bh=04eTeY2t6bANsJ//PUDIKwBRALzY7ViRuItEg0Y0/DU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBgx8XES7uiQKl5+4TVNoTlaWVC0cfEmik67zhtXThy/cGOhRoT9hmdVEi9cyq5jBJEUge2nQWAT8a7Sob7pBuJ2uNZ6tnYKbpbVSQTWXWwG+f5pvLOgxBU0i9XvIHsK8oZOCO57ADN0mR9sAWmqIChM7cmNH1Fv6EuZS7smDXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=pxTa2RBQ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b9d41baedeso177641f8f.0
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 12:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755719704; x=1756324504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ddcyD5pCAd5nxAtT6RAGcjHlaVQQdC280nxL98W3+A=;
        b=pxTa2RBQBIrMUd2NZOJj8heKDuranHmUXSyfLptNFSjTE479nlbjmcT28qMVMpiFxI
         tdP1kdQHH5M91RNlMFzkkf85Upfl998iyeb0dvoQxM2hB1nZGI1V5YJGaXYEjATzbrXr
         pmIyYFeCDL6WbVnh9qZdeDCufiJKG4Lk7VxPIomlJ3iIpakJJdZAnqbrJG3mgCwKV7Xy
         eDnMBI0g00U/LLXNntzlOiEzGLxvS4BxBidk5GH7KuKB/fOY8z5JiPtghF+b3WmIDYKG
         QwW7rqhTCTZvlwP8f87jFDrISK4v6Mnz+HH/1gzX8mzWRwk64YhenD9isQ4K1as4kgHq
         ESHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755719704; x=1756324504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ddcyD5pCAd5nxAtT6RAGcjHlaVQQdC280nxL98W3+A=;
        b=e+rJraVdWfpSPwlCAv0GRyHtLsqab2tdS/HbTUWobFqtiAERGsYsLt/MrZb6MZpRYW
         rFH1yIApWNQmc0ohXFk2xyQLRAOfZCRq1kozvExk7OKtkgcwilpMEWYYd7Pu5aV8QWNB
         kkBrI1os0HKOeY96KfYVi2Vj3pkJCROxwQCLpWFIWVc51kDDOnznH/X87h4p4DpVPacP
         eA7BZKDx2vhathzKFC+Otptn1+V7E6sqcdxsFO3cHci9RPNgQEiK2lamrWCjC3ux7JI+
         UeTUDljuyJ3zeWtY2FK46osITX4kkEdj0n2RednElBPaOM2Raj7u8XqrFq7wywKBhf/c
         K2Bw==
X-Gm-Message-State: AOJu0YyuhTZd2bByI02Z1TKAHvA/LkbLvbzdoFhXPSEP3Xpyx9/EwLRC
	9ssQJr60CYvRSgtcRiKWiFHz4enCQNd6IpRomh3XbS5jAkGseoaGRgwrF1V2m0pY15FaFM+DppQ
	E++p+Ac8=
X-Gm-Gg: ASbGnctkanGmwpKAh5C4hv5wDOa0UiamH8AdRyq5Pp+fcc5tN54pxZ0oKj09JER45n6
	Y4CawzayFCsQPa1j4FslkogwSB6ZAVIy+HvlPd4FhemSRGkh5H8+kWl5wyprSkVaqP2FaH1TNhj
	BxeDgQk2HF9f57nZMyQSg1u5qhLZ6l49D5GTsqADTyEKIz7wZEC3NXAt4jyWSe9pWNUp7IpWCdB
	I7KBgftWyhx69jiz3wzirhLOgHM+6D0nqw3wvEJwSp8DVyBbPQyJ9Fq9oGP6a7JJbcvTBIv2j0W
	o1A3sCElUtxp3Ygo85sWuv8sT5TfSz4bZuyDWcyeV069TKSJmJgr0T8kr5ewmzeUeW4IZ8aaOlu
	2+ERPq7L3JiaBaYEsTklQ6ECcRzYOkwlNF6dgzgHPXMvBh7h1P2WnZ8QeJ8ziIs5AeX+i4Z8Myy
	4=
X-Google-Smtp-Source: AGHT+IFXXEcRtVrVvUgBPamzGJldJmvn2rZ2nzwNop5sRGIvNBhWCM4jMNX8HopjXK6OJCdf+/JRug==
X-Received: by 2002:a05:6000:2c07:b0:3b7:886b:fb76 with SMTP id ffacd0b85a97d-3c49433e9fbmr67405f8f.12.1755719704247;
        Wed, 20 Aug 2025 12:55:04 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c166bsm8947803f8f.33.2025.08.20.12.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 12:55:04 -0700 (PDT)
Date: Wed, 20 Aug 2025 12:54:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>, Andrea Mayer
 <andrea.mayer@uniroma2.it>, David Lebrun <dlebrun@google.com>
Subject: Re: [PATCH iproute2-next v2] man8: ip-sr: Document that passphrase
 must be high-entropy
Message-ID: <20250820125458.0335f600@hermes.local>
In-Reply-To: <20250820184317.GA1838@quark>
References: <20250816031846.483658-1-ebiggers@kernel.org>
	<20250820092535.415ee6e0@hermes.local>
	<20250820184317.GA1838@quark>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 11:43:17 -0700
Eric Biggers <ebiggers@kernel.org> wrote:

> On Wed, Aug 20, 2025 at 09:25:35AM -0700, Stephen Hemminger wrote:
> > On Fri, 15 Aug 2025 20:18:46 -0700
> > Eric Biggers <ebiggers@kernel.org> wrote:
> >   
> > > diff --git a/man/man8/ip-sr.8 b/man/man8/ip-sr.8
> > > index 6be1cc54..cd8c5d18 100644
> > > --- a/man/man8/ip-sr.8
> > > +++ b/man/man8/ip-sr.8
> > > @@ -1,6 +1,6 @@
> > > -.TH IP\-SR 8 "14 Apr 2017" "iproute2" "Linux"
> > > +.TH IP\-SR 8 "15 Aug 2025" "iproute2" "Linux"  
> > 
> > NAK - do not change man page date for each change.  
> 
> Sure, if that's the convention for this project.  Note that this differs
> from the convention used by most projects with dated man pages.  The
> purpose of the date is normally to indicate how fresh the man page is.
> 
> > >  .SH "NAME"
> > >  ip-sr \- IPv6 Segment Routing management
> > >  .SH SYNOPSIS
> > >  .sp
> > >  .ad l
> > > @@ -32,13 +32,21 @@ internal parameters.
> > >  .PP
> > >  Those parameters include the mapping between an HMAC key ID and its associated
> > >  hashing algorithm and secret, and the IPv6 address to use as source for encapsulated
> > >  packets.
> > >  .PP
> > > -The \fBip sr hmac set\fR command prompts for a passphrase that will be used as the
> > > -HMAC secret for the corresponding key ID. A blank passphrase removes the mapping.
> > > -The currently supported algorithms for \fIALGO\fR are \fBsha1\fR and \fBsha256\fR.
> > > +The \fBip sr hmac set\fR command prompts for a newline-terminated "passphrase"  
> > 
> > That implies that newline is part of the pass phrase.  
> 
> Not really.  "NUL-terminated" strings don't include the NUL in the
> string content.  If you prefer, it could be made explicit as follows:
> 
>     The \fBip sr hmac set\fR command prompts for a "passphrase" that
>     will be used as the HMAC secret for the corresponding key ID. The
>     passphrase is terminated by a newline, but the terminating newline
>     is not included in the resulting passphrase.
> 
> But I don't think it's very useful, as it's not needed to know how to
> use the command correctly.
> 
> > The code to read password is using getpass() which is marked as obsolete
> > in glibc. readpassphrase is preferred.  
> 
> Is that relevant to this documentation patch?
> 
> > > +that will be used as the HMAC secret for th

Since this is only part of iproute2 that uses getpass() probably should
be rethought. Having key come from terminal seems hard to script
and awkward.

