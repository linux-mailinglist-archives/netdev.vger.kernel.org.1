Return-Path: <netdev+bounces-228002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 641C2BBEF4F
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 20:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B5BB4F216A
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 18:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4026B2DE6F1;
	Mon,  6 Oct 2025 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="upTwnuUy"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F562D979F
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775291; cv=none; b=ahTsDWco0dnQy7jfIBX2yYYNJrYoIANV2Tx6k+imoCGAyrWG2MuOWxlJoud66ZmF7lECALG1IBNjqTeMnVd7nLqwh5CgfKQxjv1rLobOXf/o3J21wQR4ZjWeoHoiB++pHmKQPtbQ/BveX0+Ru4UUcY1ajb+ocYf/edc0MYdE/V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775291; c=relaxed/simple;
	bh=WRwgJ3oEqoJZKzzCY24fJsymFYMZ2aXCzOoCEKjLVBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fB9Q26ssmvYqhWilf/Gvol7hy6AdeZKDe1Di8GK5iysBVJeZcTLnw12AEijMdn7xdNG8WG2n2BbaEA9GEB/M1pHQOugQKSh3TbzIWvheswylc3GM8fWzEQkssfn0Zgn0mrgw5LOrBkZFBkFsSxPkbJiK4mWk5bATgP+GdKwsl6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=upTwnuUy; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <31ec0460-ddbb-49b0-977c-25fafc5b8242@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759775276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fCG+pWwci9CbUyXhUlqJsoQtEiaYQVMbs4I6FSZousY=;
	b=upTwnuUyjJkK4JNli/doziRePFnkHs/eSSOgcp6co2VlVUcOQvhGXFe/MHMA+dgk8U3yyf
	EjjTQ80D1Ixm+OIaAHXkj2gcf03d7j8vO7EaLk0+3HocrMP1cDNdbcRJWQPkTh0umy/Y79
	t7CELvPfKAN0VZukaLC+oHFzsDQh1hM=
Date: Mon, 6 Oct 2025 11:27:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: fix potential use-after-free in
 ch_ipsec_xfrm_add_state() callback
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>,
 Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Leon Romanovsky <leon@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Harsh Jain <harsh@chelsio.com>,
 Atul Gupta <atul.gupta@chelsio.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Ganesh Goudar <ganeshgr@chelsio.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20251001111646.806130-1-Pavel.Zhigulin@kaspersky.com>
 <f0cef998-0d49-4a52-b1b8-2f89b81d4b07@linux.dev>
 <20251006110317.39d08275@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20251006110317.39d08275@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/6/25 11:03 AM, Jakub Kicinski wrote:
> On Fri, 3 Oct 2025 21:28:51 -0700 Zhu Yanjun wrote:
>> When the function ch_ipsec_xfrm_add_state is called, the kernel module
>> cannot be in the GOING or UNFORMED state.
> That was my intuition as well, but on a quick look module state is set
> to GOING before ->exit() is called. So this function can in fact fail
> to acquire a reference.
>
> Could you share your exact analysis?

I delved into this function ch_ipsec_xfrm_add_state.

Yes — your understanding is correct:

When a module begins unloading, the kernel sets its state to GOING 
before invoking its ->exit() method.

Any concurrent call to try_module_get() will fail after this point.

So try_module_get() can return false, even though it’s extremely rare.

Ignoring that failure means continuing to use data that may already be 
in teardown, creating a use-after-free hazard.

This commit properly closes that race window.

Yanjun.Zhu


