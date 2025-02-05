Return-Path: <netdev+bounces-163152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F02A296F3
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4922716667A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6109B1DC9B1;
	Wed,  5 Feb 2025 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="spfHHxUM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2CC4C76
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738775295; cv=none; b=uDggFIPKcvVf7+uzpIReBaugPO1B7KtDkobBF3uTIt9XCaq1V/0LX0K9DCWaRoXqe7EBaZUe7s3iYPzC0mrzLrqO8HhnxZwRitdpb3mmXQmlLhsXOSCbY0LIfiSvOGXpPjYZ676pr3YON6AHCv1jtlSyhjhjeYXLBK/u+f6gZFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738775295; c=relaxed/simple;
	bh=t2L34pN2hUz8xQF5rrPBVCqCJfmo3WOb3urGpAQ4sRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ImdQfgXUBMDqB83Tdm/5khatz89CwbGZkUGF0+XdYI1/rSJPJGyZqepmvLrD00o8N5kPq6lqcrr7duPh9SSxCU6FwZf09uzs+w5lC0MWZWku9sSa00M7go113sfkL8tHXRrIRujmmy3nvJZD06DfKRJykckwERNvDrMSnKCjy/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=spfHHxUM; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5dc75f98188so56160a12.2
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 09:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738775292; x=1739380092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2L34pN2hUz8xQF5rrPBVCqCJfmo3WOb3urGpAQ4sRU=;
        b=spfHHxUMLEaKoV3QWUFINqgkSa3rMDjZE92qo0UWqL6Aa+EpsYAhY0lTpyOvNBhIyO
         gZYC7bOldKAXCuFkUvuXzqn1FBb2euXxXcRD6E200xB1MteWKY3puNY2V5RM7fZPqrFD
         ud8pXhpT3rzjLHuDPu3zjzxFlAopJLYwoqVe80k/zn6Ui93JBSgW6kCR6If0vQF1TtTi
         6OWNpyGgV1u455RWThlcwywrcUx3gco0Lkqeuwn2N018gB/zNO1UMb/slNCBz9UAnV38
         Q5aI+OoDiEcaWb685rwwv7WkYJuz9UBTKlqbUyAWVVzrf3Tlsn0FRLWlXM/2M8xjsb+V
         nRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738775292; x=1739380092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2L34pN2hUz8xQF5rrPBVCqCJfmo3WOb3urGpAQ4sRU=;
        b=ipREaICIi4ULAa15o8sNYyHh9LioLup7an0CMIKZ1tYcwX08/H8w6xJCiXVERD09uy
         UCoR9KIKgH6qFiKl/mX7q6w0SwsePla/k1wimvGiwHq0oqSJPj9BisUul10tjRKH6skM
         QXL0RcfeEKiF4h1S3BVigMiMTSgeux1tqnPHGfAIxcSNwvlI/wneGgDxe/JeaJxPDDH2
         SEMh0mXYfVZ4NajL0e9uz+6r+FSxsx37eN0PGXla3TKNtdiab7MaE+45WjDKD3Wrt26Z
         R5SOK1mtwyaWhtlZM0q4tW6Oox00R+2+GYE7O+XFuaulacL3eyxe6vOZeRLXuqgQDLRi
         Ue3g==
X-Forwarded-Encrypted: i=1; AJvYcCXVN3LMa+PJZA2UzsisjqsvLgRpURpIbp1aDsdwowVrW72pRLfpmF7DRrluJvXzu3KZk6CBpY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbecNVKG2O1NOmDtDLFIADXqUygRKY1UQ4AY59JJnhRdUEElgn
	JcdhOQm6EzsFB+1NlkpUF2/nf68eKSKowdmdBzCodnCawEVMd60gAli6E6K5IStfRMN8jz8NHlU
	m/ijwcw+MD360sU5+rRJujR4VZIzTCGoesOxB
X-Gm-Gg: ASbGncvE871rOGC1WvCeqAz6X+TCnWNlLYJmZh2D7dmGP482s7G+0O0wJMz4EvK7tnO
	rz9KSl5pvToU0146uqvqoBqfD9RWaNA17O37oLNNGq40zynN+ibIGjF7apa5urY6Y1sv+apK/
X-Google-Smtp-Source: AGHT+IF96FMEiMEt4CwbA9RNG4YeDn3DguRJVDTdrlI1M/30E8qnAWjgozkcw597YlFFZ/1YDtERDgMJM1VqAQghy9U=
X-Received: by 2002:a05:6402:5d0:b0:5d3:cf08:d64d with SMTP id
 4fb4d7f45d1cf-5dcdb779fb9mr4399915a12.32.1738775291646; Wed, 05 Feb 2025
 09:08:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203-netdevsim-perm_addr-v1-1-10084bc93044@redhat.com>
 <20250203143958.6172c5cd@kernel.org> <871pweymzr.fsf@toke.dk>
 <20250204085624.39b0dc69@kernel.org> <87seosyd6a.fsf@toke.dk> <20250205090000.3eb3cb9d@kernel.org>
In-Reply-To: <20250205090000.3eb3cb9d@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Feb 2025 18:08:00 +0100
X-Gm-Features: AWEUYZkjj77gvRVHmfVcvHVGPAX1r2sGkRcFM4P8TqpQqi1mT8vKLngwYCzcJPs
Message-ID: <CANn89iK8YpzNhJv4R+x80hcq794bh_ykS-O-2UHziBXixNhzyA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: netdevsim: Support setting dev->perm_addr
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 6:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 05 Feb 2025 10:05:17 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
> > >> Can certainly add a test case, sure! Any preference for where to put=
 it?
> > >> Somewhere in selftests/net, I guess, but where? rtnetlink.sh and
> > >> bpf_offload.py seem to be the only files currently doing anything wi=
th
> > >> netdevsim. I could add a case to the former?
> > >
> > > No preference, just an emphasis on _meaningful_.
> >
> > OK, so checking that the feature works is not enough, in other words?
>
> Depends on your definition of "feature works". Going thru all the
> address types and how they behave would be a reasonable test I think.
> Checking that an address from debugfs makes it to netlink would not.
>
> > > Kernel supports loading OOT modules, too. I really don't want us
> > > to be in the business of carrying test harnesses for random pieces
> > > of user space code.
> >
> > Right. How do you feel about Andrew's suggestion of just setting a
> > static perm_addr for netdevsim devices?
>
> I don't see how that'd be sufficient for a meaningful test.

Perhaps allow IFLA_PERM_ADDRESS to be set at veth creation time,
or other virtual devices...

