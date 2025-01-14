Return-Path: <netdev+bounces-158283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7D0A11505
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624F7160B40
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA6C212D7D;
	Tue, 14 Jan 2025 23:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KhW9rhIm"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2852066EA
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736896165; cv=none; b=BTNYghXhDFv71PZIksE7LKEUISjJsLe3r/LKUyqzTp26gqJEo8aLDHX9vk0kZF+3rnhMnUrbAxGOdLAa0PHxq3NI7QDD00lZ8G4nZgakE4gzdbHrJH56VkDUhmDWjmU9Io7vVJ5cJe3l5a/q5+lJXNK2kdp+OZ+tr4XUv9GBJ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736896165; c=relaxed/simple;
	bh=6IiUdCi8zqLQ5axPo4oZOwB4y0MAercPgqj8JzeKd/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DX1l1QAsKLI11INBF6Vgj0Wyouwl+IMaGXWVr/6LsWGTvjcJauBoOKAyK0I7nb6ACe5fEAGnZngzBY22jRa+aiqBzVa+5jIBGwIo2ik8i+JO/xxs5AD5gME8dPn/50dmqps/arzoNy2vwVQt/DNH25mKpGNSIJztP4X9iObglL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KhW9rhIm; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9f222ade-715c-4010-a5f8-7058a0e0f1ba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736896160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncoN1koz42OQlba5NJ4Xf43OnT2bBNgg/Y91C7rqmQs=;
	b=KhW9rhImprxRmz4a+12Cu3YpthFJoneXd9Vzo7v7ZgkVXUnXaJNNH8yybHPe7v93KoR/NM
	56U3VtNuW78r+dp45ELogwzWr4vJ8rtxm7hPlHzObpAPJZI7EdESYJNoZAUMkWNaPh2BAH
	FpN+hK36RDrMlE62dfsswBogzsNePpo=
Date: Tue, 14 Jan 2025 15:09:16 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 net-next 5/5] net: reduce RTNL hold duration in
 unregister_netdevice_many_notify() (part 2)
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 eric.dumazet@gmail.com
References: <20250114205531.967841-1-edumazet@google.com>
 <20250114205531.967841-6-edumazet@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jesse Brandeburg <jesse.brandeburg@linux.dev>
In-Reply-To: <20250114205531.967841-6-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/14/25 12:55 PM, Eric Dumazet wrote:
> One synchronize_net() call is currently done while holding RTNL.
> 
> This is source of RTNL contention in workloads adding and deleting
> many network namespaces per second, because synchronize_rcu()
> and synchronize_rcu_expedited() can use 60+ ms in some cases.
> 
> For cleanup_net() use, temporarily release RTNL
> while calling the last synchronize_net().
> 
> This should be safe, because devices are no longer visible
> to other threads after unlist_netdevice() call
> and setting dev->reg_state to NETREG_UNREGISTERING.
> 
> In any case, the new netdev_lock() / netdev_unlock()
> infrastructure that we are adding should allow
> to fix potential issues, with a combination
> of a per-device mutex and dev->reg_state awareness.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>


