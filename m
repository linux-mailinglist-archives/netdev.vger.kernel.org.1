Return-Path: <netdev+bounces-214923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DADB2BE8F
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 12:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C043A3EBC
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 10:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FCB31CA65;
	Tue, 19 Aug 2025 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="auYbvPmi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FZe250lS"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C182E31CA45;
	Tue, 19 Aug 2025 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598081; cv=none; b=T/uVtaWmUrQ1/CuI1bM93meICwrx/2MG9itn/+hO4B2Paw3ENirR3tzUh/V5XoQrxHOlw9r0W8BL3FGdhiCT5TAQrmDhmN7xD+QNYeVGz5ahdTjWqumeDFKMOl4e5k1CTUrPgTjpAfmWyi1nFJMVud/V6FzQB7jfI+JlGRK4HfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598081; c=relaxed/simple;
	bh=nVyrLvtFnGW6pKdDmrn0M948ArlCF/8vi280nC29aC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smCcR0rO3sml3bIyfOZ9mIRLQrYA8ftKWSzC0Qf2cpdfFYj0ac7GJnKVM94BnrnVLLxvl9EmPMpjfucFvW8YSzmHasy9O5ilhnBNynwP5W4IBAu4fW/6ytcxnDTyN0GjYMNnxinXxGNEnSoHWflWL2c/7BzElc3hiwINcRxwids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=auYbvPmi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FZe250lS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Aug 2025 12:07:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755598077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dn/X6qy0XrMI61WmXeW/uOGvPrRWbztbvR64S1pgjFw=;
	b=auYbvPmi8tvz4msSCs1Wym3uuIfSEx/Mkxt6RqGqgJxhI9zQEhOPJCzTMssoZ4Yrl+1qE0
	iRLijAkuRDPtJMa1kxZMhY2FAowouie6IUf5TM7JO8RB62B5WWG+XCuTEfKGVVRNVSrnKN
	YAuO2aAV8MP/cGAK2fd+HBisiwDhLSatSLDv9y3knFLFhmUnshsNSDaTM0zG3VVd+5wfOR
	X3bcsajaboP7J+aGR9dx747qJiCwqghC6c5h7e4cLzcRkKxBut5Err13NNTgs54Gz+kZFJ
	AdMbPw+oZ3LoRzudzcsVumpxN1TVGZkyQSKmNr/FxdB+PLV2X81Xu0eZkMre1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755598077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dn/X6qy0XrMI61WmXeW/uOGvPrRWbztbvR64S1pgjFw=;
	b=FZe250lS4laYBS7vxw2NAvjeeJ1hnAv/G/KwSKSw1NZXRP7yDQoGVAqV4p9jXWkG7rxfjG
	HwEL/kWSOAxayNDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Florian Westphal <fw@strlen.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [RFC] net: inet: Potential sleep in atomic context in
 inet_twsk_hashdance_schedule on PREEMPT_RT
Message-ID: <20250819100756.IpUQx4jh@linutronix.de>
References: <3edfd3ac-8127-41c2-afc5-3967b8b45410@kzalloc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3edfd3ac-8127-41c2-afc5-3967b8b45410@kzalloc.com>

On 2025-08-19 01:46:10 [+0900], Yunseong Kim wrote:
> Hi everyone,
Hi,

>  {
>      ...
>      local_bh_disable();
>      spin_lock(&bhead->lock);
>      spin_lock(&bhead2->lock);
>      ...
>  }
> 
> The sequence local_bh_disable() followed by spin_lock(), In a PREEMPT_RT
> enabled kernel, spin_lock() is replaced by a mutex that an sleep.
> However, local_bh_disable() creates an atomic context by incrementing
> preempt_count, where sleeping is forbidden.

As Eric said, the mentioned pattern is common and not problematic.
The wrong assumption here is that local_bh_disable() on PREEMPT_RT
"creates an atomic context by incrementing preempt_count, where sleeping
is forbidden". This is simply not the case.

> Best regards,
> Yunseong Kim

Sebastian

