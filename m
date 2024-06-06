Return-Path: <netdev+bounces-101273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 750218FDEA7
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E08C1C2418F
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 06:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271004DA14;
	Thu,  6 Jun 2024 06:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vRU+Xrt7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="87c6PaFT"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9345019D8A1;
	Thu,  6 Jun 2024 06:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717654963; cv=none; b=hoVqeyGfAU4yVy/PTgn4rb/VZ0A5eENWvbXTigjr8PMUV6x4uewk0WXkepQVRTfDCm7ACIz+pSM9WpG5CFNdE/ST2crkVfnDAgl9/p+s+IluMmb/IHDSJkSKnZ+kW3y64owvlk0TKk4c+W1ysz3QcwvP8cXmWSZWfglWhhuoyv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717654963; c=relaxed/simple;
	bh=yB68uGLMaXT1YV1sbSThDoviU8YPb91HeMCIZFMJbgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5XHAo9y54YWFsAGRBGskg9sW5zErO3qIF4Xkj3tVV1kmFSeTAyeVF53T8XBCFP5CRF2Hcap1MIai0dQDLigYATWiOk2hhHg2wKkorK/QWPUIfW8mRhdNtAuM9iJgBPC0Wj3DQAg350XZ90oBYZ2EkOvUShhENqtZhWmrKUbKHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vRU+Xrt7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=87c6PaFT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 6 Jun 2024 08:22:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717654959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PZbspwahrReSiEYm4PJOvgqOfbLgJT+v5PtwhKLRS5Q=;
	b=vRU+Xrt7qfOQCVY3ghd5wShqMojUHU2Scch7McyNsNbBycPTimJzgb6hrCTrgzVo7gFnz/
	QZk4QInUEfFvPtfRmmtRiqpg5A/OIt0TKgiNuxH/kpoIb8HwswgOyZXem1kgjMyGo/BePo
	YI1RJkl8x8xGJVUcitI9rr7YRzaAUmR7hL9z5sLsFExOTm8NL5PUXmihuTkrp6wa86iSJF
	LFIyn73IDnn71pcppGenwuIvJK7tbBPGXDll1jM9JDH8wpu/TCGuXDuG7/ztVh4gKKN1zz
	J7+LlDKVGCEJWxJXgw1M/AfM2WhWzFqQFtdeHFOVGDsHN/jhY3McCXoBiTI3QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717654959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PZbspwahrReSiEYm4PJOvgqOfbLgJT+v5PtwhKLRS5Q=;
	b=87c6PaFTSzuOuHDnarqFAleF2KS2afdlq8GLhiwo1iPMdlo3lj4MrafLsYp7Ao1MqnfWLZ
	izXGRThGBs4B1KBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 net-next 03/14] net: Use nested-BH locking for
 napi_alloc_cache.
Message-ID: <20240606062237.nuBoHreW@linutronix.de>
References: <20240604154425.878636-1-bigeasy@linutronix.de>
 <20240604154425.878636-4-bigeasy@linutronix.de>
 <20240605195420.2f47e6a1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240605195420.2f47e6a1@kernel.org>

On 2024-06-05 19:54:20 [-0700], Jakub Kicinski wrote:
> On Tue,  4 Jun 2024 17:24:10 +0200 Sebastian Andrzej Siewior wrote:
> > @@ -308,6 +311,7 @@ void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
> >  	struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
> >  
> >  	fragsz = SKB_DATA_ALIGN(fragsz);
> > +	guard(local_lock_nested_bh)(&napi_alloc_cache.bh_lock);
> >  
> >  	return __page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC,
> >  				       align_mask);
> 
> We have decided to advise against the use of guard() in networking, 
> at least for now.

Understood.

> Andrew, wasn't it on your TODO list to send the update to the docs? :)
I can add it to
	Documentation/process/maintainer-netdev.rst

Yes, no, Andrew?

Sebastian

