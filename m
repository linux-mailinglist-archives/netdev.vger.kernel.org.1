Return-Path: <netdev+bounces-217620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9597DB394D5
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E128163148
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 07:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BD676025;
	Thu, 28 Aug 2025 07:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cAajJqN8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AFF30CD89
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 07:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756365375; cv=none; b=ju9w2yta8IEaMBgESwDsdWRb/LcC/kquT79EcExWBz7mainhRR9NNeMgpOjLzTonFmGVjd8JuAR7Vf5uPAkLfM5RHh3PexBv4zNbOSctuct4KEqIy0PguCEXIYIzJH/Rm6F9pjmhMwmeXjcGmeDzXjRlh2Rtuy+tYYo8RatMsds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756365375; c=relaxed/simple;
	bh=EP5LAkVGPHYBWFNWQT51n48XaZ8vkDl7dsaHJY9cEpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XgTvKYsJVIVcfDVb2CoNstjCoUNqmaHFULs3+bsiuXVFvDBCxdcojRZYpdQrd0fedD/R0KaTBlLdECv487yLq44p2iT996niTY44jgxax5BWOEUtOnS0Q5d+K6UfjUMH+DgCP/hq3LmFOuhI1nEbGNItemAuIY62Gf62F+kQRy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=cAajJqN8; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A155B3F7BB
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 07:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756365364;
	bh=EP5LAkVGPHYBWFNWQT51n48XaZ8vkDl7dsaHJY9cEpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=cAajJqN8qt566q2SGECHt7e9WfVAfUSpYtPpHn+uPrNB43h/5WG+S2yBQcAU4t89M
	 XQS59NVayZN0+ecAnNPNe4gTePWYTfZTyY8bN+o6Yupfkmj8wiVzWidUs0nTo20Ok7
	 sgVLyg7glqxW21HiaJd2B0pjKWF2oDkuWDMT+3lItF0zToHA7TehZXefrdgpNb7GYc
	 CvcYSnqbsJ/SxMqon+z9snsaSMHpGknnoa4iRBgLAjV/If+fsiDdbFQPOZk5d7Hue8
	 XSi4TfLnm8daPyIxbxjA5JzMIqrxStcXawboUq+wVwmW6W0q/8UDihZkI70Un9Ar8g
	 kig4vQ3QctqBQ==
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0cc989so4612665e9.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 00:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756365364; x=1756970164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EP5LAkVGPHYBWFNWQT51n48XaZ8vkDl7dsaHJY9cEpw=;
        b=okyg0xpTzYdDhnl7CQX+QsdC+eTNw8+JXXeOHSAgXH0V3FcAmPaIvpjjtikbOuiyM3
         JI3oZOC6ArwCGo1dkLJepCk7X7yZ2GcZV+PQu5w9ahX+K+xYU4977Z7uZN8qPp3BFQRB
         GuvUrsYL8zF1jHCZjbGlgv44yqs6cqOTHvJcZVevjvp5DRRly1Ip+thk96zrZU14WUqm
         3S/WdbBMRDo3JpAVilSdSu8GR0Fpak0j/v0g67jzlDgEojai/K7MnLt7aTKJOWjmN2Nd
         0uxFvq/dDhHMv/0vKaGj1Asj8XBS43Eiz1CFm5Iet84CAaFT9HMPWq+g5muhNzPXq5bx
         rFxA==
X-Forwarded-Encrypted: i=1; AJvYcCXxAE1fZDQg7L7TtOffeoCZyGy34gugNZk5UFMoNG/ulYvBGDQ6AQCHb/zajvOkhjFUTHz6ocY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTBO2Qtm61vlkus0kG8pSTIek/0957giODa6XRSjCUqNeeieIq
	an2rohE3EpZD3lo31fMhzKB/X8i9BUN8/LJj9Q9WRkDgo7gvFsAC0QrLSUhFGvmwIA5GnxqfqWD
	UjSkrm8j3Tcarhoby5Wm8oNoHn10lSR4AiutcoxLEzGfzy46ZljY7EjDMzixgYCVDi2EJh4c1Mm
	WKUktu3ek+Rk3aoEpg2jiTvAur2VUQ6PMWKnCZdO2FVh2EL4Ds
X-Gm-Gg: ASbGncuJ7uehdN8ngAPKQpT9cDulM09MlHAOsy+2+wus64oXf+MxMV5/xp69DidgXIN
	fgM+GY6NGI4dFM0nic+hUwn+b5fyilnv9pgfeqX+eVgMM+k0ecVxS5E1oR8Zr8GvoHiOTSYjfws
	1/Z8LdR2ssJQ1eBhdc00HBTA==
X-Received: by 2002:a05:6000:2281:b0:3cd:4ff9:c487 with SMTP id ffacd0b85a97d-3cd4ff9c926mr2620668f8f.45.1756365363829;
        Thu, 28 Aug 2025 00:16:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfuC2ElMmFlTZiiutii9/xomw0gubj1uQZfa6woHQEtKq8aJkUR/KAMbs3OKEPrupW13u7FOwjSrGKvNtXbv4=
X-Received: by 2002:a05:6000:2281:b0:3cd:4ff9:c487 with SMTP id
 ffacd0b85a97d-3cd4ff9c926mr2620642f8f.45.1756365363423; Thu, 28 Aug 2025
 00:16:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710092455.1742136-1-vitaly.lifshits@intel.com>
 <20250714165505.GR721198@horms.kernel.org> <CO1PR11MB5089BDD57F90FE7BEBE824F5D654A@CO1PR11MB5089.namprd11.prod.outlook.com>
 <b7265975-d28c-4081-811c-bf7316954192@intel.com> <f44bfb41-d3bd-471c-916e-53fd66b04f27@intel.com>
 <20250730152848.GJ1877762@horms.kernel.org> <20250730134213.36f1f625@kernel.org>
 <55570ac6-8cd7-4a00-804e-7164f374f8ae@intel.com> <20250730170641.208bbce5@kernel.org>
 <e04d3835-6870-4b82-a9a5-cb2e0b8342f5@intel.com> <20250731071900.5513e432@kernel.org>
 <f27620c4-479b-4028-8055-448855991e6a@intel.com> <a9794885-5801-401b-b892-f1fed4157a4f@intel.com>
In-Reply-To: <a9794885-5801-401b-b892-f1fed4157a4f@intel.com>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Thu, 28 Aug 2025 15:15:52 +0800
X-Gm-Features: Ac12FXwi4D0akiHpvcavQrToyonQCdZbd76txj77rnkAuclerfTJUE2K51gEfxs
Message-ID: <CAMqyJG2Kv90bzJNu10mPrmHQrfi5FL1eQPCufD3n=CNcDNMYkA@mail.gmail.com>
Subject: Re: [RFC net-next v1 1/1] e1000e: Introduce private flag and module
 param to disable K1
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Ruinskiy, Dima" <dima.ruinskiy@intel.com>, Simon Horman <horms@kernel.org>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Regarding the SKUs: the issues we've encountered aren't tied to specific =
SKUs

From our side, the issue is only specific to an SKU. If that's also
the case from other sides, I'm wondering if it's possible to add a
quirk table for enabling/disabling K1 configuration.
The upside would be:
1. There is no need for a user to bother giving the module parameter
2. Let the kernel problem leave in the kernel

Thanks for your time. Please let me know your concern.

On Sun, 3 Aug 2025 at 20:39, Lifshits, Vitaly <vitaly.lifshits@intel.com> w=
rote:
>
>
>
> On 7/31/2025 6:51 PM, Jacob Keller wrote:
> >
> >
> > On 7/31/2025 7:19 AM, Jakub Kicinski wrote:
> >> On Thu, 31 Jul 2025 10:00:44 +0300 Ruinskiy, Dima wrote:
> >>> My concern here is not as much as how to set the private flag
> >>> automatically at each boot (I leave this to the system administrator)=
.
> >>>
> >>> The concern is whether it can be set early enough during probe() to b=
e
> >>> effective. There is a good deal of HW access that happens during
> >>> probe(). If it takes place before the flag is set, the HW can enter a
> >>> bad state and changing K1 behavior later on does not always recover i=
t.
> >>>
> >>> With the module parameter, adapter->flags2 |=3D FLAG2_DISABLE_K1 gets=
 set
> >>> inside e1000e_check_options(), which is before any HW access takes
> >>> place. If the private flag method can give similar guarantees, then i=
t
> >>> would be sufficient.
>
> This was precisely the intention behind introducing the module parameter
> initially. The private flag isn't a comprehensive solution=E2=80=94it's m=
ore of
> a mechanism to allow configuration changes without unloading the e1000e
> module.
>
> >>
> >> Presumably you are going to detect all the bad SKUs in the driver to
> >> the best of your ability. So we're talking about a workaround that let=
s
> >> the user tweak things until a relevant patch reaches stable..
>
> Regarding the SKUs: the issues we've encountered aren't tied to specific
> SKUs. Instead, they stem from broader environmental configurations that
> the driver cannot address directly. For instance, misconfigurations in
> the BIOS can only be resolved by the BIOS vendor, assuming they choose
> to do so. Until such fixes are available to end users, the module
> parameter provides a practical workaround for these system firmware issue=
s.
> >>
> >
> > I think you could just default to K1 disabled, and have the parameter
> > for turning it on/off available. Ideally you'd default to disabled only
> > on known SKUs that are problematic?
>
> As mentioned earlier, defaulting to K1 disabled isn't ideal. While it
> might help avoid certain issues on specific units, it would negatively
> impact the device's power consumption across all systems, the
> overwhelming majority of which would never experience any problem.
> Therefore, it's preferable to keep K1 enabled by default and allow users
> to disable it only when necessary.
>

