Return-Path: <netdev+bounces-157327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0420AA09F97
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 01:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3E216ACEF
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 00:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786F47E1;
	Sat, 11 Jan 2025 00:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9ItfoTJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E442FB6
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 00:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736556114; cv=none; b=jtBrgI/l8ToSMHgtF5ZfHkcbaFubbQFt1XEXKlr3EtWeHiuhwNODIENXMsq6bYYqwSabqMuwFpZMfqx4Q71Qsn3K4rnWt9NH7RwJxTzTe25i4IqncRqiUUm19dB1dA3E0fTL4GwL6Vp+6e+l4FE/4hXctpbaIWoiN9LctNqyavc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736556114; c=relaxed/simple;
	bh=uQIGjUQW3Iwepx4tvwQX5dMTWP77Us9AYE+Ak87s72g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETKjZlmu+VUWClNLPuhmIgWov+ncDoDUrKJmtW3XlVfgR4LrpmzTDpR0BFTnGmFvQ+uKHyJupyOGmzHl4vS5FOOeT8p8Sm5UX0uJDpSt/cHRmmQGQqo4AqeeE/RCLFB4lmxn0krERIs0Ci0doAcZ7Mbu/UK/SSiKIQj2ZTUExzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9ItfoTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7458AC4CED6;
	Sat, 11 Jan 2025 00:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736556113;
	bh=uQIGjUQW3Iwepx4tvwQX5dMTWP77Us9AYE+Ak87s72g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F9ItfoTJ97Tf21VqfuDn8J3rxVm9Q+dboT79cqSpNnNkhdzifvBk5RBfZ6qppn4Oi
	 8YtYid4BN8TTrmDHZXlnZeu7NVWX/toHEQfLn9uONON/6mlEmjPFv5NSDUdqdMts6T
	 8uPGgmnTpPkbK20M0vTXEKeGrtVXydyjOBuinUskta2o/MJjpOtytE7iYTAw+uV9tR
	 eEKy8qJeamtQPTui7CLkOHImO47WwDnHPtV6ylLta0aIj24C07BJ7YdtTec+RbHCWj
	 liN0XE5GtWLjl2axTU7o7ByNnkckc9R8PoMuB0X5VgJXqmxYkfemUwvloLe2+TpPZ3
	 fI8F+c8qOt1jQ==
Date: Fri, 10 Jan 2025 16:41:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: John Daley <johndale@cisco.com>
Cc: andrew+netdev@lunn.ch, benve@cisco.com, davem@davemloft.net,
 edumazet@google.com, neescoba@cisco.com, netdev@vger.kernel.org,
 pabeni@redhat.com, satishkh@cisco.com
Subject: Re: [PATCH net-next v4 4/6] enic: Use the Page Pool API for RX when
 MTU is less than page size
Message-ID: <20250110164152.0ededf8a@kernel.org>
In-Reply-To: <20250110235204.8536-1-johndale@cisco.com>
References: <20250104174152.67e3f687@kernel.org>
	<20250110235204.8536-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 15:52:04 -0800 John Daley wrote:
> >SG, but please don't report it via ethtool. Add it in 
> >enic_get_queue_stats_rx() as alloc_fail (and enic_get_base_stats()).
> >As one of the benefits you'll be able to use
> >tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
> >to test this stat and error handling in the driver.  
> 
> Fyi, after making suggested change I used pp_alloc_fail.py but no
> errors were injected. I think the path from page_pool_dev_alloc()
> does not call page_pool_alloc_pages()?
> 
> Here is what I beleive the call path is:
> page_pool_dev_alloc(rq->pool, &offset, &truesize)
>   page_pool_alloc(pool, offset, size, gfp)
>     netmem_to_page(page_pool_alloc_netmem(pool, offset, size, gfp));
>       page_pool_alloc_frag_netmem(pool, offset, *size, gfp);
>         page_pool_alloc_netmems(pool, gfp);
>           __page_pool_alloc_pages_slow(pool, gfp);
> 
> If I change the call from page_pool_dev_alloc() to
> page_pool_dev_alloc_pages() in the driver I do see the errors injected.

Ah, good point. I think the netmems conversion broke it :(
If we moved the error injection to happen on page_pool_alloc_netmems
it would work, right? Would I be able to convince you to test that
and send a patch? :)

