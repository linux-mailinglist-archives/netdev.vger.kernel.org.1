Return-Path: <netdev+bounces-158271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2966EA11475
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3650B1691E6
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 22:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A3F213245;
	Tue, 14 Jan 2025 22:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V+VkjcfX"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF60526AC3
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895488; cv=none; b=U1d+UWldh2b+4icKXmT1J+LNmdBPDzeg1TKz5UgKg70Gr+dPTg+0NdHrjqZPzQi9vxK5DuyhQEPaHidio9Cr8dRfdjc/0inG5NcfZjkSUXnX3nMCP+UF/N0eMr5cOOfGkPnTZg60lTS19fVm/oQWODOQlDKJhiuu31SJ5eTFZvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895488; c=relaxed/simple;
	bh=f8Cx4kaV5HkWhMihrfDO7msmMYTrOzfL2LF7U3+V4N0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTyM8abxHfJbabNhfzUnL3ks0V/hNq3IcdalwMa9jH5D3XjsCXDyCPsTa3Tqr7Xc+52Wzl5qMeUDJx/jMXfkDUWbkIOM8LzfBFwZtSvWyp9ZH5hCglwropi34J5vScC20NXORTCffgzabuJTU3d38mgdt6uCpBwwY1DYbApNC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V+VkjcfX; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b7473f0a-6f0b-434c-ae6e-3505c4b7e5db@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736895477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cSN3EmFV+NGsBZTvj+1kfc9sOf978KY+nMFIHkr49hY=;
	b=V+VkjcfXujPNdlLUJGwkhzHjCzjT4fdSdbjKmVhikK1GzNCJ5iAk86IeKq+4YCCTyIyP2V
	8R2whbo4hEErXIyFV7Di0dnmHcmSz2qvUBw7cQ/S8Zzx12kdoJVHspDLalCMa++sRbUXzX
	izC7JW9cUtXiU9IP0/MnGfQZMmjYs54=
Date: Tue, 14 Jan 2025 14:57:42 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 net-next 1/5] net: expedite synchronize_net() for
 cleanup_net()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 eric.dumazet@gmail.com, "jbrandeb@kernel.org" <jbrandeb@kernel.org>
References: <20250114205531.967841-1-edumazet@google.com>
 <20250114205531.967841-2-edumazet@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jesse Brandeburg <jesse.brandeburg@linux.dev>
In-Reply-To: <20250114205531.967841-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/14/25 12:55 PM, Eric Dumazet wrote:
> cleanup_net() is the single thread responsible
> for netns dismantles, and a serious bottleneck.
> 
> Before we can get per-netns RTNL, make sure
> all synchronize_net() called from this thread
> are using rcu_synchronize_expedited().
> 
> v3: deal with CONFIG_NET_NS=n
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Seems like a good cleanup!

Reviewed-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>


