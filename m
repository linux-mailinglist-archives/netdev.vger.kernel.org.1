Return-Path: <netdev+bounces-158282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDC2A114FF
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616723A6170
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25341C5D41;
	Tue, 14 Jan 2025 23:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qHMbrtza"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24B121B8E7
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 23:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895962; cv=none; b=EyAJ1/OAiVT0+jC07wXLdj/2tncL5xdFURU6DZXt/rsh4ZejlkhAWbfZu8zb4+RX4tn3h6aRlzBLGeSK+sEXSm5ImQD9su9UWQgdkY5nLPO2li6yxjDvXtutvdco+kQWol8TtrM9C2HMWOKLRlmPeG1eDR31KtzpUFgYXY5Z5sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895962; c=relaxed/simple;
	bh=BlX4IdPV/L2TjARn0XuI8+C8pxeAwdZuhYDq/PCMaRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ze46utj2Kk80+S2ZcVmjyXEsK+LbCilKurz6El4KnZ4ztS1u5LS35rQC0A3myPNLsn1F9FGqGtD2AaJhoacj7GNmaF7GPGrPZp2WWcStl5Mmesa703NhnSCohuebfZD1x46ySpZaxr1OzUWo443kvPgeUJxIs+CWqHfu3DDGnE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qHMbrtza; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2d92ca69-b187-48aa-9d2c-4eff80efdf32@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736895957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tq8NW3IZOruCuMWpDVyfkifsew92BEofG/MYwxH2Z3s=;
	b=qHMbrtzaicj4q52kcrjywDESu814orOsUXdc3kgrPQuW0Y5lpGWKGBLhChzZY/4XFE0KVP
	bxozJFCwKD1DH4hBBY4BCm5aJt1c0bU4nZ3FAZeHyh5BDbgq3zR5nPNU5TymUm5Q+GiyZ0
	N1SkPtkw/HGgYpr/4b31hsdiBs4tQIY=
Date: Tue, 14 Jan 2025 15:05:53 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 net-next 4/5] net: reduce RTNL hold duration in
 unregister_netdevice_many_notify() (part 1)
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 eric.dumazet@gmail.com
References: <20250114205531.967841-1-edumazet@google.com>
 <20250114205531.967841-5-edumazet@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jesse Brandeburg <jesse.brandeburg@linux.dev>
In-Reply-To: <20250114205531.967841-5-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/14/25 12:55 PM, Eric Dumazet wrote:
> Two synchronize_net() calls are currently done while holding RTNL.
> 
> This is source of RTNL contention in workloads adding and deleting
> many network namespaces per second, because synchronize_rcu()
> and synchronize_rcu_expedited() can use 60+ ms in some cases.
> 
> For cleanup_net() use, temporarily release RTNL
> while calling the last synchronize_net().
> 
> This should be safe, because devices are no longer visible
> to other threads at this point.
> 
> In any case, the new netdev_lock() / netdev_unlock()
> infrastructure that we are adding should allow
> to fix potential issues, with a combination
> of a per-device mutex and dev->reg_state awareness.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com

Reviewed-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>



