Return-Path: <netdev+bounces-211534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBA4B19FB5
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 12:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC8527A786C
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 10:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F902459DA;
	Mon,  4 Aug 2025 10:26:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C2F2C1A2;
	Mon,  4 Aug 2025 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754303163; cv=none; b=s6J4WJnu93/2QV++IbCjX/ehZuF4JumKm38aihxTKogpluys+mYudoYSn6rqJmUEabyfctvEc+hL7MJCmrjpg5CYxTLLhqnc2SeP/SiwTsWEfN+51tViaqzc4pMe+I1d8lmMZj2vCAuqF1i65kwRe1JOdcJUkUZnxwqGqjkx2os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754303163; c=relaxed/simple;
	bh=9nC3jxk2RnazplfKgQ1GKMWYtuAE4k1GwNFPeqtUQNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzRxcD5myuEov3LpqQ35JOuyRVxdK1utXWAUgPOxDlIUIT4f2jblM/mkFnK4+7NaGP3RJ+Qd5hb20BzY+zr0GeUu9Ph+f2R0i+b9yDvL09GfloS7ceooIGdA+LoCIBrhIaUdnOhaYfg293o9Cs66xg1ZEavU06yG278H/v0He2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748D9C4CEE7;
	Mon,  4 Aug 2025 10:26:01 +0000 (UTC)
Date: Mon, 4 Aug 2025 11:25:58 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kuba@kernel.org, stable@kenrel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm/kmemleak: avoid deadlock by moving pr_warn() outside
 kmemleak_lock
Message-ID: <aJCKtmtus770t5LA@arm.com>
References: <20250731-kmemleak_lock-v1-1-728fd470198f@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731-kmemleak_lock-v1-1-728fd470198f@debian.org>

On Thu, Jul 31, 2025 at 02:57:18AM -0700, Breno Leitao wrote:
> When netpoll is enabled, calling pr_warn_once() while holding
> kmemleak_lock in mem_pool_alloc() can cause a deadlock due to lock
> inversion with the netconsole subsystem. This occurs because
> pr_warn_once() may trigger netpoll, which eventually leads to
> __alloc_skb() and back into kmemleak code, attempting to reacquire
> kmemleak_lock.
> 
> This is the path for the deadlock.
> 
> mem_pool_alloc()
>   -> raw_spin_lock_irqsave(&kmemleak_lock, flags);
>       -> pr_warn_once()
>           -> netconsole subsystem
> 	     -> netpoll
> 	         -> __alloc_skb
> 		   -> __create_object
> 		     -> raw_spin_lock_irqsave(&kmemleak_lock, flags);
> 
> Fix this by setting a flag and issuing the pr_warn_once() after
> kmemleak_lock is released.
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Fixes: c5665868183fec ("mm: kmemleak: use the memory pool for early allocations")
> Signed-off-by: Breno Leitao <leitao@debian.org>

I think Andrew already added this to mm-stable but, for the record:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

