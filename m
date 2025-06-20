Return-Path: <netdev+bounces-199925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED35AE2451
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 23:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72CCC18984D4
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 21:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D70238144;
	Fri, 20 Jun 2025 21:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBbmfqwF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CA9233721;
	Fri, 20 Jun 2025 21:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750456152; cv=none; b=h3nMjLOW+U0hkNaD6LwQJGOmSmCsZYigpNIJv8rFDw5+L7E6x1QHamCvt0fEgW7q7teFdBWDsyCEmEi9qip8ai+akup5z2loDB+DV4UJ2K2mNBKsZXUukFN+WcwA8DK8xP6PNYLPg+t3yGMokEUyIa6MbFi1sP1sqDE0mUgK85M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750456152; c=relaxed/simple;
	bh=qh/IyVfcuIlM9SBo9aGWenEhO9QLRSKZCKrPJUNw760=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwRtHqSbtyHaLemNPDSLMheq1DgZ+t3+t/v4QEoEPhGG43qRNRylYv/OYWXbppumjZi5pvP7gmiHsfuxMHVwgHJO6MpcZSrTPrrSZWx0aDd6FEzdAkkUerRdoeWoQWdzxdk8PuXS3+Fmpcq0xyDc9M9txjJufhvXrl/Up7lxGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBbmfqwF; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-711751e2d9fso2314457b3.0;
        Fri, 20 Jun 2025 14:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750456149; x=1751060949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QELowKEXA7R77PUl1OqaRZQ4vmTwB/KNp4b6p3jgc+0=;
        b=iBbmfqwFJst4Hvzv6ck8hylMWZXIzKe7qd5HKCMwLwF+PiwTw9aDIYYeBX5BXNnQCi
         kBn2ZMU+f87x5FWCZsxnHHZ0MutPxcEfuFvbo+wFcSlErp5ANzQlZVKZNRxsqR/5WbJ1
         Vaw6TtvJyr9AsvT97FLicaOmNod9lMSQrtfANfsqTTjzKjZvYdx3cA4NHx9OjTq6cE+Y
         /QEYipR+SM2KQKPmlu1LDjXHfgAcfcY01dm70+BaOg7sQEOMtngvalrgBWhtY+WpFMxq
         F4+Cwt6RXUCOJQySHBDRFArmsrSEdmSVX9RlrmYUze4SEtu0Y0fsRLdCIXlV8Xg0tpct
         Eg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750456149; x=1751060949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QELowKEXA7R77PUl1OqaRZQ4vmTwB/KNp4b6p3jgc+0=;
        b=Y99OzmIqkwwMwL9NTVcdWEyczAkmbjkxCfYKthX2jpPZMyjpNLFMLktm/dDDAIWJf9
         8YQjOo+b0Wa6gZkZneK7PqSCHF8Gini+SCJ+uMYQf0GsARBxq3E+ONH49eWA+lG/kMkZ
         wRLJrheKrkSgBirRSwE1tqIzeA4/fxBrS5pHhdezHFFDv5LUfdpBMHkuSl4BrX/Vx/eu
         HznA0+peoNRaCxavqiHq5riNRngEj3THezKSI04xOtxDojoxAJYtOOqitRXS6A6MAS8m
         Kw6tJC8JvbF8lNo4JU1tKINjB0KdBhwPQrXpqCu3pKXk4mHt9I6rqvMl7IRBed8uM8nB
         Ahsw==
X-Forwarded-Encrypted: i=1; AJvYcCVL89Db9Royj9siLKUZlQe9hFdcpxiOFb64cOqqA/U+E8jehXjdeoq0Kl5FRb0ogqiAMdZDXbKWqnLXgXbM@vger.kernel.org, AJvYcCWPobeh0vY+OuuTwcXktmMQFPVtXl6OFPSl/MfLziU2Ju6MTHOGgVUVqeM5kO7zXIBH4UIcrQda@vger.kernel.org, AJvYcCXkfczUTXzXpka0g/efdDwMxZ3G+vcL/eeY1Q8d491Q1aDXtEa/VgUyQU/NUu5lEXPRPn5iOJdIAss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmL/nTDFvEIcCU8Y7aBOlPKcOeK8aNL+6X8y79qu/yKnQj/LPV
	t19SgdV2VEyCePCrS85WtMRdAkIu4ayAg6baEv080T8YA/PJZGHy6O17BoeI9xvfPAkQhaWPejB
	gp5MFxaN0kGrKUJxvJ0OWl1mogqqnlho=
X-Gm-Gg: ASbGncsH+DCES2c9BZZiHDROBdJB/4IilGH8uIdguOFDHZCWg9nsH+94+4n9bOSo+dh
	/QX0BUHmYXN/jDn2EZrOGiymTaWQksFuUxXe4OKIgSgYz7qkr0b668FnX1KFpToOWAvaflWl7kh
	Z8qN8rnSU+0RUnqw13SfYlXv9zKZRP94MaO0ZYXBZ1KbSJ
X-Google-Smtp-Source: AGHT+IGFRd+SUbN4k0ULblstnmL1Dz7mO/FJidC5D8wq7DGHLKGZn9t7alLOtBhhKHFNRMftIWOmpxJrPWMpPbFv/5A=
X-Received: by 2002:a05:690c:3503:b0:712:c55c:4e67 with SMTP id
 00721157ae682-712c65261ffmr31332997b3.4.1750456148909; Fri, 20 Jun 2025
 14:49:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614225324.82810-1-abdelrahmanfekry375@gmail.com>
 <20250614225324.82810-2-abdelrahmanfekry375@gmail.com> <20250617183124.GC2545@horms.kernel.org>
In-Reply-To: <20250617183124.GC2545@horms.kernel.org>
From: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Date: Sat, 21 Jun 2025 00:48:57 +0300
X-Gm-Features: AX0GCFvqmEkkV13jSqvRdKfTQr6HjsP-DYV9223ypVJqavMJc3V_jZXyECyhqS4
Message-ID: <CAGn2d8MS2PQnosR7AVp=1dRUat_Gu0E9t-P-AQ=k0Ei0ofT_sQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] docs: net: sysctl documentation cleanup
To: Simon Horman <horms@kernel.org>
Cc: corbet@lwn.net, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, linux-doc@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, skhan@linuxfoundation.com, jacob.e.keller@intel.com, 
	alok.a.tiwari@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review


On Tue, Jun 17, 2025 at 9:31=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Sun, Jun 15, 2025 at 01:53:23AM +0300, Abdelrahman Fekry wrote:
> > I noticed that some boolean parameters have missing default values
> > (enabled/disabled) in the documentation so i checked the initialization
> > functions to get their default values, also there was some inconsistenc=
y
> > in the representation. During the process , i stumbled upon a typo in
> > cipso_rbm_struct_valid instead of cipso_rbm_struct_valid.
>
> Please consider using the imperative mood in patch discriptions.

Noted , will be used in v3.

> As per [*] please denote the target tree for Networking patches.
> In this case net-next seems appropriate.
>
>   [PATCH net-next v3 1/2] ...
>
> [*] https://docs.kernel.org/process/maintainer-netdev.html
>
> And please make sure the patches apply cleanly, without fuzz, on
> top of the target tree: this series seems to apply cleanly neither
> on net or net-next.

Noted, will make sure to denote the target tree and to test it first.

> The text below, up to (but not including your Signed-off-by line)
> doesn't belong in the patch description. If you wish to include
> notes or commentary of this nature then please do so below the
> scissors ("---"). But I think the brief summary you already
> have there is sufficient in this case - we can follow
> the link to v1 for more information.
>
> >
> > Thanks for the review.
> >
> > On Thu, 12 Jun 2025, Jacob Keller wrote:
> > > Would it make sense to use "0 (disabled)" and "1 (enabled)" with
> > > parenthesis for consistency with the default value?
> >
> > Used as suggested.
> >
> > On Fri, 13 Jun 2025, ALOK TIWARI wrote:
> > > for consistency
> > > remove extra space before colon
> > > Default: 1 (enabled)
> >
> > Fixed.
> >
> > On Sat, 14 Jun 2025 10:46:29 -0700, Jakub Kicinski wrote:
> > > You need to repost the entire series. Make sure you read:
> > > https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
> > > before you do.
> >
> > Reposted the entire series, Thanks for you patiency.
> >
> > Signed-off-by: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
> > ---

Noted, Thanks.

> > diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/net=
working/ip-sysctl.rst
> > index 0f1251cce314..68778532faa5 100644
> > --- a/Documentation/networking/ip-sysctl.rst
> > +++ b/Documentation/networking/ip-sysctl.rst
> > @@ -8,14 +8,16 @@ IP Sysctl
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >
> >  ip_forward - BOOLEAN
> > -     - 0 - disabled (default)
> > -     - not 0 - enabled
> > +     - 0 (disabled)
> > +     - not 0 (enabled)
> >
> >       Forward Packets between interfaces.
> >
> >       This variable is special, its change resets all configuration
> >       parameters to their default state (RFC1122 for hosts, RFC1812
> >       for routers)
> > +
> > +     Default: 0 (disabled)
> >
> >  ip_default_ttl - INTEGER
> >       Default value of TTL field (Time To Live) for outgoing (but not
> > @@ -75,7 +77,7 @@ fwmark_reflect - BOOLEAN
> >       If unset, these packets have a fwmark of zero. If set, they have =
the
> >       fwmark of the packet they are replying to.
>
> Maybe it would be more consistent to describe this in terms
> of enabled / disabled rather than set / unset.

Will do this  here and in other parameters to ensure consistency.

>
> >
> > -     Default: 0
> > +     Default: 0 (disabled)
> >
> >  fib_multipath_use_neigh - BOOLEAN
> >       Use status of existing neighbor entry when determining nexthop fo=
r
> > @@ -368,7 +370,7 @@ tcp_autocorking - BOOLEAN
> >       queue. Applications can still use TCP_CORK for optimal behavior
> >       when they know how/when to uncork their sockets.
> >
> > -     Default : 1
> > +     Default: 1 (enabled)
>
> For consistency, would it make sense to document the possible values here=
.

Noted, will document possible values here and in other parameters for
consistency.

>
> >
> >  tcp_available_congestion_control - STRING
> >       Shows the available congestion control choices that are registere=
d.
> > @@ -407,6 +409,12 @@ tcp_congestion_control - STRING
> >
> >  tcp_dsack - BOOLEAN
> >       Allows TCP to send "duplicate" SACKs.
> > +
> > +     Possible values:
> > +             - 0 (disabled)
> > +             - 1 (enabled)
>
> In the case of ip_forward, the possible values are not explicitly named
> as such and appear at the top of the documentation for the parameter.
>
> Here they are explicitly named possible values and appear below the
> description of the parameter, but before documentation of the Default.
> Elsewhere, e.g. ip_forward_use_pmtu, they appear after the documentation =
of
> the Default. And sometimes, e.g. ip_default_ttl, the possible values are
> documented at all.
>

Noted, will make sure that all representation follow the same appearance,
first the description then possible values then default.

