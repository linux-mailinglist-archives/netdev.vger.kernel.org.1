Return-Path: <netdev+bounces-166118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31390A34A41
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 17:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE631896576
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8E6241661;
	Thu, 13 Feb 2025 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dw5MxLuk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50B6202F90
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463807; cv=none; b=U73XUEutbrzYUpbuV0UnjVJbjbJIqZmh6f3WfsZ/aB09/heWSbIqUSc5rRlP+vVnXmG8bAmsIycK9RCpYN0G0kvnDu5FuBh6KOD7vDMaqcIU3Hej116mjGkEVUm7PVXvN09zoRd5WcbYT5yTci/PEaFKZVtneJTOaEUNG+K7enk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463807; c=relaxed/simple;
	bh=yLcN42q4pkyuqQ5iYzlgKfolZR4H1YW/RIvfxoJi048=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=OO/CsLKOzFmHuUl+nCW+KhCKL5jdzjbgR+zVN5r0YkPeLQSH9ZLDf1H+eFz0AlKzPjkTScGHacG94ujz5cCuUO0g4IhIb6tIzTmUJowg4jsfkCH6SlpLKO1nHWfOphlrtcVmZICSo++bA0krEExUI2lKmCfBa5cnlxl7JX2vnqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dw5MxLuk; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c07351d2feso162097885a.3
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 08:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739463804; x=1740068604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6rD5ReSOWqy/AIbVioWxtKpJEV8IF16sEtSVUaNYzo=;
        b=Dw5MxLukQuVbl62w1duBAWgstRedOf+eHYaKOEWLr18ca3LJtuZlOt0xHQm0varPQu
         F+V0Cm4ZqzmubIwUR7J2lM9OSPa3a2wxdBVU8k3h1SxE0udL9IVFF8cvVB9Nfzvxy1Nf
         iSy2yRkVHrbxyPUMIOEVfl7gH0BScoxQO1q1qUaHLHXHRadmrxqdGCwWw5ogLPCb+DNh
         6Y8mZtMHDv+aB2ZF8G/BbV1NluEAByV8R64hxc61m6Wbwt0MfIqC3hfpD/dDvJEYInOr
         RmrZnuelwWMlHbASi3oI2maaZpuwBROH2Zxa3paVLDU4bqYdhtuNkERhuuWc7zKgT7G1
         iCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739463804; x=1740068604;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O6rD5ReSOWqy/AIbVioWxtKpJEV8IF16sEtSVUaNYzo=;
        b=L+yop68t0X5/Li6BZZ/DVtorNPtO3fUJFACvGYlFALUZtqRVpFiSrEYOLhiIsWAloE
         u8Q7BgWdtv22odldxi6FXsjbkZ8Pak86uoI8fv56IBm3kLp9jMx3X9A5fw1qBe4sRsun
         oEplTCS6cBEmGjHvUc9nZqCfH0yfAf5M40AcN6vH+whkMBBlkEIFY79cod+dt6oA3t+O
         ls1YhKt/DUPJht7G22pUda5QLpXYXfjF0fkDSHs+trwZ7+BQX5YxCF3+ugb9pBXbLpYf
         9dsThEg8MWIt40N3kx7MxjSVb5bc9PGdG2Py8tIQGzJHyOA1Ense4I1SHMGHiuSo5DaP
         mOMg==
X-Forwarded-Encrypted: i=1; AJvYcCVgz9spms0HnV9wXDrs1yu6M7Ibs7u/Ea0EjvIqTOg6BQbi2+Sne2KtnFz4HIYAidzQ+JO80Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjS06zkSI8OMTKyZdtF6VPo1+zh25cpFQYXK9cHKR61gDkQ2Tf
	qWBQKUB1VyGQ91+UYnvNa6JJODeMPgiytORldRUkNYyKCW+X/EdkdWcZ5g==
X-Gm-Gg: ASbGncvX1FhMyhY7seHYDpkode05BxJfeqzVl/7VVHG4gcfZxSXuumxKKFYzh3W3U5c
	e7fhYmmWYhmPNADCOA8rmsFWOfh/dsuCW3J36pY8srIOB+LFa0/Ow1kjz5HXddxPVgeLjyGFaz8
	B9RRsecl3qmAN2dCtPbTTS/YSONqz/VUxhKZMHiapHMBEIp4PeuBwMi3r+Cw3FJsWC4TTPYUmhz
	VcmhYrqgaLStPePTnzkyTDkBkAGESvwPSXOJJT4Ts/GrYy2j051Q+2+RpaEDtrghuRDl4mCdH4H
	SR5Ye7vVMnxIc2uABM/QT8IrUD0Mq/UEX3YI4Jb6pMFnbC71LfiPz379pyPw7fs=
X-Google-Smtp-Source: AGHT+IGztfnu2DdxT9pwBP9REN1/9G1OWfIFaL3oMWEfwG4nH1KllVJ3rFvES7y7LQy3GxGmIuq5Mg==
X-Received: by 2002:a05:620a:198f:b0:79f:67b:4fdc with SMTP id af79cd13be357-7c07a112530mr445989685a.2.1739463804579;
        Thu, 13 Feb 2025 08:23:24 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c616d13sm106853385a.54.2025.02.13.08.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:23:24 -0800 (PST)
Date: Thu, 13 Feb 2025 11:23:23 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 dsahern@kernel.org, 
 horms@kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <67ae1c7ba11bf_25279029419@willemb.c.googlers.com.notmuch>
In-Reply-To: <10ef7595-a74c-4915-b1f7-6635318410f7@redhat.com>
References: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
 <20250212021142.1497449-5-willemdebruijn.kernel@gmail.com>
 <10ef7595-a74c-4915-b1f7-6635318410f7@redhat.com>
Subject: Re: [PATCH net-next v2 4/7] ipv4: remove get_rttos
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> On 2/12/25 3:09 AM, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > Initialize the ip cookie tos field when initializing the cookie, in
> > ipcm_init_sk.
> > 
> > The existing code inverts the standard pattern for initializing cookie
> > fields. Default is to initialize the field from the sk, then possibly
> > overwrite that when parsing cmsgs (the unlikely case).
> > 
> > This field inverts that, setting the field to an illegal value and
> > after cmsg parsing checking whether the value is still illegal and
> > thus should be overridden.
> > 
> > Be careful to always apply mask INET_DSCP_MASK, as before.
> 
> I have a similar doubt here. I'm unsure we can change an established
> behavior.

This patch does not change behavior.

Does not intend to, at least.

> > v1->v2
> >   - limit INET_DSCP_MASK to routing
> 
> Minor nit, this should come after the '---' separator. Yep, it used to
> be the other way around, but we have less uAPI constraints here ;)

Okay. I have no preference. I thought the latest guidance was to have
it recorded. Is this something to clarify in maintainer-netdev.rst?


