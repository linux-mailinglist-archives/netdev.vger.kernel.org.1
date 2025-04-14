Return-Path: <netdev+bounces-182377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEE0A8898D
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D111894687
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E12527FD48;
	Mon, 14 Apr 2025 17:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e8pEI8iY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848921A315C
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744650987; cv=none; b=EggVkIAKbFv2FuWd7TEFQq0IE8jIBKOpaWi50cjPnAzKtLBNcBRr0ta0korAN4wxrlOhAcrVavtlKptGFlSE3X8tjFgk/+TjD9xtM2rdfDxVyHq1msiNIzuuZXGMA3HNSRlw0UyOR/tZd5XTcuRf57V5uBaHSU0h1YhhV7qk3Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744650987; c=relaxed/simple;
	bh=sFs2g4xYbu5M6SPcfo6YX+d3PrkYfu8++4HE/r/l9Rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SntYFbUbqC3xpvl8Q50uh63HpCiODygj0yRWR1CpFjqZrLdReITOlfWfqnkF2iROJran6Qb8nUeKsRRN3hnFFYs7+KG5kQULUd0GGt3IQaRVtc/hoJS8Vj5Com4eIys9jGA95MQYDv1rTKqVmmaNUSl8ejoJlJ9IDu02E+trCP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e8pEI8iY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2240aad70f2so17795ad.0
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 10:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744650985; x=1745255785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuD+BMBw3cxAzSBqf2HEJp3kjAN3TRnWITBBnYh1KSM=;
        b=e8pEI8iY6Q8II+KUCvRAKXef1lUTGS5FbXwR+5nibsw1btZE0gBmEGcqJfTtM1w5Jy
         vqGfv7JowBEd2KRJ/Sm+AXWsDPQW8OGGIlYzIYiUXh1qDvtM4TMNbysQVX1BCgfsCTOC
         kDkzy8uD7tVZ3xN9uZDd57tuHM6osW2MgBW8UezNTxKSS6auQVlUsVBgdXJ85bFelfAK
         buv7r2HQiRyH6X9eGcs0AixOmvf8m1o2kTmqeBkhpzuI0P+oi5hOFyt5rFfm1BRXoCJk
         RUlWkus01gxYY3arNPv3dvzZndIAPaBRB+IKIZDdWcgnYIBBP0rfOW7v5cEk4DXxOjY3
         p3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744650985; x=1745255785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuD+BMBw3cxAzSBqf2HEJp3kjAN3TRnWITBBnYh1KSM=;
        b=vZ7NI1c+Aiq74Nx5I5RPRWwPz4/L3tN2wISh0whpSxu+I3TMqDzZwDBelsPldY4KrS
         6QhwPEbRBCSVCngTPMWA3T8cp7ExNWYnFsxHsPSY/s4jmbQwCh81mNr097sRyh6wUxg4
         /jD/gqbSrTke/zM7kPk6fmJm0E/7ls7HdMMSn5FtthY8B64Fddpd+yRXt0r7clTq3BM6
         ksWk1vz2uKdnZQ8jWdy+Ile6ci/6XRfGAsqRD4iJyonjYf/MyAZBNZGPQ0JMvLplsrMK
         2rTyjRn+BiNIK52TvllbVO+RWQ7QFGif7235X6G3B5uOkwrHegZ9MmEPON2y7cB87bNE
         4z7A==
X-Forwarded-Encrypted: i=1; AJvYcCU45R+07DL/2wWPBGWqKMSwsYN5tFVJ0yE0xgrTJF1IlzlgPd6rAtMHxySx9ULf0sWU3WWPXwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycB9FeO/jUfJllFEShI70upiyEfSc3gNlHw9Z3Hh8uKFkr0OHN
	j4OuXw1F+6U3DlFpqAqM40Mg1iYJ2VPSaZKfYJh7tsmU3A1SHcYCvthzQzYpnw1TfnsOI7fYgod
	Ck7R7niRzaNlbZSyq/bBilugoGgOikEK8LRUN
X-Gm-Gg: ASbGncs+blKIcRyfdwHX2bZ7EtdANkEDAa71Duq7tAWbBNj6D8GgHgt2ieT5kYLkW+P
	4ttH8oU9H/8bLh+19FZ2GnIsjAy5m1KXhJOMjjYz2cpzvU5R20AZv4Tq6p0I5SRkPbcXrmLm17f
	TfOap5IZtETGCRxEFYgfc6feJ9TCpQTNsgTvC3Gq+8y7eP3jrY65NcjFiwBVw9qmQ=
X-Google-Smtp-Source: AGHT+IGSAszAOnuIilo8K5NNvKL7cQwcQViH0ZPPO2YcRy9FkhkFE3wha81QDbWdBV1DQS6Xm8ouxN3WiMyhs7QafZM=
X-Received: by 2002:a17:903:185:b0:215:7ced:9d66 with SMTP id
 d9443c01a7336-22bf4472724mr5275395ad.10.1744650984337; Mon, 14 Apr 2025
 10:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321021521.849856-1-skhawaja@google.com> <20250321021521.849856-2-skhawaja@google.com>
 <Z92dcVfEiI2g8XOZ@LQ3V64L9R2> <20250325075100.77b5c4c0@kernel.org> <20250401112706.2ff58e3d@kernel.org>
In-Reply-To: <20250401112706.2ff58e3d@kernel.org>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Mon, 14 Apr 2025 10:16:12 -0700
X-Gm-Features: ATxdqUFVOi66hBUlwLqWG4F0t11-EzxKlzYCXHMr7MW4brpDPxQaAYOvE-H__UI
Message-ID: <CAAywjhRCYJ2+=ei3jhbTg-p+MRTpgj6p1f8jj8ba43Y21OW-bw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/4] Add support to set napi threaded for
 individual napi
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 11:27=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 25 Mar 2025 07:51:00 -0700 Jakub Kicinski wrote:
> > On Fri, 21 Mar 2025 10:10:09 -0700 Joe Damato wrote:
> > > > +int napi_set_threaded(struct napi_struct *napi, bool threaded)
> > > > +{
> > > > + if (napi->dev->threaded)
> > > > +         return -EINVAL;
> > >
> > > This works differently than the existing per-NAPI defer_hard_irqs /
> > > gro_flush_timeout which are also interface wide.
> > >
> > > In that implementation:
> > >   - the per-NAPI value is set when requested by the user
> > >   - when the sysfs value is written, all NAPIs have their values
> > >     overwritten to the sysfs value
> > >
> > > I think either:
> > >   - This implementation should work like the existing ones, or
> > >   - The existing ones should be changed to work like this
> > >
> > > I am opposed to have two different behaviors when setting per-NAPI
> > > vs system/nic-wide sysfs values.
> > >
> > > I don't have a preference on which behavior is chosen, but the
> > > behavior should be the same for all of the things that are
> > > system/nic-wide and moving to per-NAPI.
> >
> > And we should probably have a test that verifies the consistency
> > for all the relevant attrs.
>
> I was thinking about it some more in another context, and I decided
> to write down what came to mind. Does this make sense as part of
> our docs?
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Adding new configuration interfaces
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Best practices for implementing new configuration interfaces in networkin=
g.
>
> Multi-level configuration
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> In certain cases the same configuration option can be specified with diff=
erent
> levels of granularity, e.g. global configuration, and device-level
> configuration. Finer-grained rules always take precedence. A more tricky
> problem is what effect should changing the coarser settings have on alrea=
dy
> present finer settings. Setting coarser configuration can either reset
> all finer grained rules ("write all" semantics), or affect only objects
> for which finer grained rules have not been specified ("default" semantic=
s).
Our current approach for napi configuration is using "write all"
semantics as Joe mentioned above and I am going to change the "napi
threaded" to that also for consistency. To do the "default" semantics,
we would need something that tracks the "dirty" configuration state in
each napi. Also if we do this, we might also need to decide on a
mechanism from the user that propagates the intent that the fine
grained configuration is not needed anymore. I can send another patch
later to switch to the "default" semantics if this is decided.

>
> The "default" semantics are recommended unless clear and documented reaso=
n
> exists for the interface to behave otherwise.
>
> Configuration persistence
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> User configuration should always be preserved, as long as related objects
> exist.
>
> No loss on close
> ----------------
>
> Closing and opening a net_device should not result in loss of configurati=
on.
> Dynamically allocated objects should be re-instantiated when the device
> is opened.
>
> No partial loss
> ---------------
>
> Loss of configuration is only acceptable due to asynchronous device error=
s,
> and in response to explicit reset requests from the user (``devlink reloa=
d``,
> ``ethtool --reset``, etc.). The implementation should not attempt to pres=
erve
> the objects affected by configuration loss (e.g. if some of net_device
> configuration is lost, the net_device should be unregistered and re-regis=
tered
> as part of the reset procedure).
>
> Explicit default tracking
> -------------------------
>
> Network configuration is often performed in multiple steps, so it is impo=
rtant
> that conflicting user requests cause an explicit error, rather than silen=
t
> reset of previously requested settings to defaults. For example, if user
> first requests an RSS indirection table directing to queues 0, 1, and 2,
> and then sets the queue count to 2 the queue count change should be rejec=
ted.
>
> This implies that network configuration often needs to include an indicat=
ion
> whether given setting has been requested by a user, or is a default value
> populated by the core, or the driver. What's more the user configuration =
API
> may need to provide an ability to not only set a value but also to reset
> it back to the default.
>
> Indexed objects
> ---------------
>
> Configuration related to indexed objects (queues, NAPI instances etc.)
> should not be reset when device is closed, but should be reset when objec=
t
> is explicitly "freed" by the user. For example reducing the queue count
> should discard configuration of now-disabled queued.
>
> Core validation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> For driver-facing APIs the networking stack should do its best to validat=
e
> the request (using maintained state and potentially requesting other conf=
ig
> from the driver via GET methods), before passing the configuration to
> the driver.
>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
>
> All new configuration APIs are required to be accompanied by tests,
> including tests validating the configuration persistence, and (if applica=
ble)
> the interactions of multi-level configuration.
>
> Tests validating the API should support execution against netdevsim,
> and real drivers (netdev Python tests have this support built-in).
>

