Return-Path: <netdev+bounces-292607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Ky5IEsgHGGoaawgAu9opvQ
	(envelope-from <netdev+bounces-292607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:15:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B35CB5EF621
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A83DE3110289
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 08:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1D238B7DD;
	Thu, 28 May 2026 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nh5ATba1"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E027838E5F9
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958593; cv=none; b=HV16nwicB3LzuGAQ1uiU4lQiobeRuY1gWOKJDjXwxdeeroYJ4878YN3SyOnkrk+3mRIAvySgAbTyHuz9yRWc14OiDOD/GtAx2Lzd1HTbtK7Utm4yG/xvLWNluBcgdY1GpbdQCtf2hWvCWfOXRxfbP+Sr45ObPgn+nMJ3w7fLhKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958593; c=relaxed/simple;
	bh=CmApIUurd+jqirG/aIphG1tML/nEN1t+zTplugbwN3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u18FHBlfluyL8ngMbju5ZtFsgpB+s6rrTi851aFQ2JtS1j0Yi7NICJi1n3eOXTPKeU3XWm5G5YdXNM6ghZ9lJYOx3iODMg51qz+lP70jCkHln4JJbwWliFVq59t7Ibck7AfGs83Qx8wsc8R3XiokDB4sAowmJO1RClVZBgngUWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nh5ATba1; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <940b4f22-dcb0-4ff3-91b1-ac51d336c0ed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779958580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CmApIUurd+jqirG/aIphG1tML/nEN1t+zTplugbwN3s=;
	b=nh5ATba1q6yK0Xq6c/uf718OGLmnKvcw2H6uTNk3kj3SG3otMGF5oZlh8yjWwP4czg7vWb
	UYUiAQ//bJd0WwkJC6f2Dz7qEo7/cn/YEps18QPhlGE9XGhUAPsDaVy3/18BPhURy4zajK
	F4hX4D6HMYG3Rm1CAzwP3YdWXBMLaMA=
Date: Thu, 28 May 2026 16:56:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 1/2] ipv6: fix possible infinite loop in
 rt6_fill_node()
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>,
 linux-kernel@vger.kernel.org
References: <20260527053133.180695-1-jiayuan.chen@linux.dev>
 <20260528084502.GA592092@shredder>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260528084502.GA592092@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-292607-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B35CB5EF621
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/28/26 4:45 PM, Ido Schimmel wrote:
> On Wed, May 27, 2026 at 01:31:30PM +0800, Jiayuan Chen wrote:
>> Sashiko reported this issue [1]. Apply the same fix as
>> commit f8d8ce1b515a ("ipv6: fix possible infinite loop in fib6_info_uses_dev()").
>>
>> Writers holding tb6_lock can list_del_rcu(&rt->fib6_siblings)
>> without waiting for RCU readers; rt->fib6_siblings.next then still
>> points into the old ring and this softirq-side walker never reaches
>> &rt->fib6_siblings, causing a CPU stall. fib6_purge_rt() always
> s/fib6_purge_rt/fib6_del_route/ ?

You're right, that's fib6_del_route().


>> WRITE_ONCE()s rt->fib6_nsiblings to 0 before list_del_rcu(), so an
>> inside-loop check is a reliable detach signal.
>>
>> [1] https://sashiko.dev/#/patchset/20260526020227.4857-1-jiayuan.chen%40linux.dev
>>
>> Fixes: d9ccb18f83ea ("ipv6: Fix soft lockups in fib6_select_path under high next hop churn")
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>
> Sashiko points out two pre-existing issues:
>
> 1. Same issue in nft_fib6_info_nh_uses_dev(). Fixed by:
> https://lore.kernel.org/all/20260526020227.4857-1-jiayuan.chen@linux.dev/
>
> 2. Missing nlmsg_{end, cancel}() following ip6mr_get_route(). Seems
> valid, but completely unrelated.

