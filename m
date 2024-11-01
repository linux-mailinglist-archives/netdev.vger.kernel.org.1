Return-Path: <netdev+bounces-141083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDCC9B96C5
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 18:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252971F225F6
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 17:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361C81D0148;
	Fri,  1 Nov 2024 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="rhZheW/9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FCA1CFEB7
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483280; cv=none; b=nyF5lUN5n3HFwSAOQHm2Cg00pxbn8y9hRyTDDP+2j8GAWSbHQfifcKihpAVuXqe9TQrYw5TDIbuIuYbd0g7Pa01dDctsKMk8eguj0uQQDHHNxtebTW88FXXxPHy31HMtSd46GWATbK0QLmfAUNuvryIUJG1UYrJqjwAT+ArgOOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483280; c=relaxed/simple;
	bh=iVUG9KT6K0/nf0rLEbRQ7Ry8pdO9gZ+48ZOmg9sy+SA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOB+EZow+lSo6cUugZq227zu6DpPTjwjBcLjr1MPlkwa8ZxK0cfxuXzHY7JFYDjyUJ6ozsN6IPadBBxwD/cuYCFCsD+32RICp0dzDwLaYbJc+M9/S5ixF8JN333CzA6E0lsFwFnogZuQoHQxBgYXEyPDihm1+ZE2KPkfoOgn0cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=rhZheW/9; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iVUG9KT6K0/nf0rLEbRQ7Ry8pdO9gZ+48ZOmg9sy+SA=; t=1730483278; x=1731347278; 
	b=rhZheW/97EAXsmV2hFdxqm7bqNwnkQzutI/UARsX7ibvNRP7+WpFOl8Oc8fFHTe4NVSfyUlz8wS
	3DqbfsJVvM+wLSFAv7Wlq8yaYpWsIB5ZoxMxeScj8j+yoAQ+kzj16CY+dE2aAS+mxrXG0VLWyECr0
	FUWBbVl4RUYfnociMY8roMxjKzqCnJLF0CNzVWmMZ5/RH/UJ0NwC16qqN+Ozx/dUrjW52Av6X6LGJ
	uDa+H3IVyQEOMtvHT11EaSfT+Uwab2BOXlddQ9Z27P1zl+wfJe48j/h7tJ/LcB0TNChBPdNpivIo+
	vJEmJQaL874qusElmFrCXxH+IfvCwogR85Yw==;
Received: from mail-oo1-f50.google.com ([209.85.161.50]:44475)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1t6vka-0004TE-Pw
	for netdev@vger.kernel.org; Fri, 01 Nov 2024 10:47:57 -0700
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5eb70a779baso1113421eaf.1
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 10:47:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YwetycGhXcHOgfgCNtavPsxA1trnzXKZyghA1Bq3QHbrBOmWUQI
	ZvYjhT82/WjGcBQ4wBvPReEZtIdiUTL7LHBdlnE5qYSUcZUl9lEEUQ3aao5IQdwkDw69I0b70T7
	e3PSgoQOH0YFUrwidEU1Ld+QR2I0=
X-Google-Smtp-Source: AGHT+IHu4I5qpQNnF1cWHdtVQ3W6jPO6f0mibOFpTyVWHkultMUxbuyC8cRPpKkyGComMghIOqLl5tLKczHWhRAW8ZI=
X-Received: by 2002:a05:6820:1ca6:b0:5e5:c073:9ea5 with SMTP id
 006d021491bc7-5ec5ec942e3mr7523371eaf.6.1730483276255; Fri, 01 Nov 2024
 10:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028213541.1529-1-ouster@cs.stanford.edu> <20241028213541.1529-2-ouster@cs.stanford.edu>
 <6a2ef1b2-b4d4-41c5-9a70-42f9b0e4e29a@lunn.ch> <CAGXJAmwSCeuwy6HXpzZgp8m+5v=NPCOTgKc-8LBjUuY079+h0w@mail.gmail.com>
 <ce06867d-2311-466e-924f-ffa6fa6d49c9@lunn.ch>
In-Reply-To: <ce06867d-2311-466e-924f-ffa6fa6d49c9@lunn.ch>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 1 Nov 2024 10:47:20 -0700
X-Gmail-Original-Message-ID: <CAGXJAmzuKXyfiercDz-Hxf6J1xoNV=5Bv9cz1Y4HSrBY5vPviQ@mail.gmail.com>
Message-ID: <CAGXJAmzuKXyfiercDz-Hxf6J1xoNV=5Bv9cz1Y4HSrBY5vPviQ@mail.gmail.com>
Subject: Re: [PATCH net-next 01/12] net: homa: define user-visible API for Homa
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: a11a15d02c0ec4233875b3872b0caebb

On Wed, Oct 30, 2024 at 5:41=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > Did you build for 32 bit systems?
> >
> > Sadly no: my development system doesn't currently have any
> > cross-compiling versions of gcc :-(
>
> I'm not sure in this case it is actually a cross compile. Your default
> amd64 tool chain should also be able to compile for i386.
>
> export ARCH=3Di386
> unset CROSS_COMPILE
> make defconfig
> make

Thanks for this additional information. I have now compiled Homa
(along with the rest of the kernel) for ARCH=3Di386; in the process I
learned about uintptr_t and do_div.

Question: is the distinction between the types u64 and __u64
significant? If so, is there someplace where it is explained when I
should use each? So far I have been using __u64 (almost) everywhere.

-John-

