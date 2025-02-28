Return-Path: <netdev+bounces-170764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F196A49D79
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 16:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3AF18994ED
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 15:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845D326B95A;
	Fri, 28 Feb 2025 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vk3S99ER"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0CA3597A
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756589; cv=none; b=hN0p7C59E2CR6H8IpXWUlDm7s8LmEcqIfk6Bx2Ve7ftmM6xFm7lVFI0ajEDtsPoCqO4x4Lt0dz7NzyrF2x59iRGzgaqX4FRU3RwgWQ1fniQtkvlBXryhYo1qiMiB5NfYFuIwXlGV/proWwBnIgj1hGM/s/UJO1BHyDvvXvOMROc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756589; c=relaxed/simple;
	bh=XCJk2h9jZrkXzyM4MzFEXBe8P2mFNejO149x+dHUVj8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HE0gzCFkoptGS+ogwhpKnfgCoHd7Hej6u2aAy882V/5WoE8QtBSEcCA0vmodrloJ5tHAECkAEgi+JxHoJw5nl9lZ34JEPFeLihVhcu7/7Ma3ymNthfEWtLPwDj+IAZM6SAE2ssc2Z749tYW+x+I3sFsYb/hd+wYLSdIeWy9e7iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vk3S99ER; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1cb0c2cbso7162644a91.1
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 07:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740756587; x=1741361387; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0NdNWjsGqI6Dafogyd1Kwr8H92XGqubxgRj7O/f1eiU=;
        b=Vk3S99ERaKHJ8vSqMMabPxe+XlZ0nkbbRoP3sxi41jlfCzXoIR1nQHPk/LV53GU1yp
         OVJ6PVBaom4yAZmUY64rym/0xFOGF1N1Ckvm/y68wyo2J/BM3w7ZVdwdbMANkmI6ogVQ
         lDkloh47Kig2QxQRI4v7orQox+oIo+aRRKt8/ivSfqj0goO6iI1C2V2/lnJmprEwez/T
         LjEBVil+x44I1XUHY65pvyJMCzLxAZakFKXO2liXyANv6pirXy79E4mBiNFJMfQu+Kma
         P9WAioTVUR6aJSPUIAl5GwhowI0N4XmVHvJLOh3Xo61wCKikDFH6+0n7n+9VMSOcM1zq
         3cdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740756587; x=1741361387;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0NdNWjsGqI6Dafogyd1Kwr8H92XGqubxgRj7O/f1eiU=;
        b=vHsNOtT12YDO/ELgtze5kuT/QYbUashDXB636vfIBn3czVwZLZhQTz8cQdgdanDiHx
         ubC/GsVRC8E0O63gee3wCmJ7s8eJYg3PfesfSjjuPKUFyLq/09xiPJoNnZ1lCfHRRZtW
         MyNiY9cGzNgISTFoOQkXlHDZ/GKKQZ7SHYgWymsiMTUQCp3f6ddRJ+7aDerBI2SptNJD
         EpcWQBV2W5NfHxroStASSGOJ+13pBwvy8hv1VjQip2EYq4Z50E+OiwoAqhGBTnJFxftc
         RvDn/WltOoLrqmiRNTq0gJIUxvLfYx2P2AEIjHxAOQ5JvmnquExGAXJGPl9eJSjEXZg8
         BmXA==
X-Forwarded-Encrypted: i=1; AJvYcCWs0HpuhSp3oqtjKd80RYoGoJoXkufLbfs//fjalFYMWwqMkmfR73xTBhLuqzUScqLB15GbTGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVe/ExhXwFj9yvrjswGDIngXV/7MTbOZG7F4gL6HCy1ss1GMWN
	J80t08K1imnLHx7J+kGfB+yNwndUoklWc3o66BEGkgmcXXll6YjWEE9T5qRAtnOQsS4YohknYxt
	K1g==
X-Google-Smtp-Source: AGHT+IEk/ms6AP8TpnMjRdBXF3xnEipvWGFCCXnDnNMxEOlOgXa2qA7dn9VfelOnGm0U+bmMyOfy55V6fHE=
X-Received: from pfbde10.prod.google.com ([2002:a05:6a00:468a:b0:730:7d9a:3251])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4323:b0:1ee:e0c0:85a8
 with SMTP id adf61e73a8af0-1f2f4ce57d2mr6819058637.15.1740756587183; Fri, 28
 Feb 2025 07:29:47 -0800 (PST)
Date: Fri, 28 Feb 2025 07:29:45 -0800
In-Reply-To: <Z8HPENTMF5xZikVd@kbusch-mbp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227230631.303431-1-kbusch@meta.com> <CAPpAL=zmMXRLDSqe6cPSHoe51=R5GdY0vLJHHuXLarcFqsUHMQ@mail.gmail.com>
 <Z8HE-Ou-_9dTlGqf@google.com> <Z8HJD3m6YyCPrFMR@google.com> <Z8HPENTMF5xZikVd@kbusch-mbp>
Message-ID: <Z8HWab5J5O29xsJj@google.com>
Subject: Re: [PATCHv3 0/2]
From: Sean Christopherson <seanjc@google.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Lei Yang <leiyang@redhat.com>, Keith Busch <kbusch@meta.com>, pbonzini@redhat.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 28, 2025, Keith Busch wrote:
> On Fri, Feb 28, 2025 at 06:32:47AM -0800, Sean Christopherson wrote:
> > > diff --git a/include/linux/call_once.h b/include/linux/call_once.h
> > > index ddcfd91493ea..b053f4701c94 100644
> > > --- a/include/linux/call_once.h
> > > +++ b/include/linux/call_once.h
> > > @@ -35,10 +35,12 @@ static inline int call_once(struct once *once, int (*cb)(struct once *))
> > >                 return 0;
> > >  
> > >          guard(mutex)(&once->lock);
> > > -        WARN_ON(atomic_read(&once->state) == ONCE_RUNNING);
> > > -        if (atomic_read(&once->state) != ONCE_NOT_STARTED)
> > > +        if (WARN_ON(atomic_read(&once->state) == ONCE_RUNNING))
> > >                  return -EINVAL;
> > >  
> > > +        if (atomic_read(&once->state) == ONCE_COMPLETED)
> > > +                return 0;
> > > +
> > >          atomic_set(&once->state, ONCE_RUNNING);
> > >         r = cb(once);
> > >         if (r)
> 
> Possible suggestion since it seems odd to do an atomic_read twice on the
> same value.

Yeah, good call.  At the risk of getting too cute, how about this?

static inline int call_once(struct once *once, int (*cb)(struct once *))
{
	int r, state;

	/* Pairs with atomic_set_release() below.  */
	if (atomic_read_acquire(&once->state) == ONCE_COMPLETED)
		return 0;

	guard(mutex)(&once->lock);
	state = atomic_read(&once->state);
	if (unlikely(state != ONCE_NOT_STARTED))
		return WARN_ON_ONCE(state != ONCE_COMPLETED) ? -EINVAL : 0;

	atomic_set(&once->state, ONCE_RUNNING);
	r = cb(once);
	if (r)
		atomic_set(&once->state, ONCE_NOT_STARTED);
	else
		atomic_set_release(&once->state, ONCE_COMPLETED);
	return r;
}

