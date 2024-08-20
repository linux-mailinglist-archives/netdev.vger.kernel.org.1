Return-Path: <netdev+bounces-120308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 216AC958E53
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 20:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24FF1F243BD
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210D51537A2;
	Tue, 20 Aug 2024 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hw9/UfYB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1999A31
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724180298; cv=none; b=V23NjU8IAqUEKg7DwsUdbPuvyTa/P836kM7m/PpOaRL44xOSUAPEuplJs3zB6jdANkU5Vp/ki1TKLSNVIuDwJfAzr6dWmLbPOoNaSQ/NAB2Ec0IL5jZAH54vWoVittCAitdfy7YfaGpo9qlElhB4QLbUIzZoWKLHPzaYrfGu7fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724180298; c=relaxed/simple;
	bh=yRNVQrRDmvjkofLtO2ZqgR6JHXjWetWzEUqac1E1GSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HyJYnMBKI/Gjv1qV56+A/c0m5QLoByKYwWXaNLT96U2kBQjxzPxYSCkx6Cz9VK2/LqzDlctAoRN0EoaIrcjqG4vkq/O598z0nNrVTA3sshkoJx7fCPefvqHnPxM+0ur7YznFFSDYxFKBPXLDcRIPIlZCSgHAMXkIejzcERRw5IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hw9/UfYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1BBC4AF09;
	Tue, 20 Aug 2024 18:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724180297;
	bh=yRNVQrRDmvjkofLtO2ZqgR6JHXjWetWzEUqac1E1GSI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hw9/UfYBT0rJqKXVHlPuDNlDjM1xkUJ7fSZzvExy4ifoINw7E49FiqqtIuodTsXzY
	 iaD+PGak8aqR1UXOU285Iv2Z07I81j7DWgc5d/URz0RGfGzbsNuaBI8W2jyTHRvFTl
	 +DLlir/h4W8YmCqKma1bhepjSSxqfJgzaoeM1+P9rq9dr8s7guWka1o8W0+fKoxnzh
	 3m0gZlJh037e7jW4eQqZ2ccNpnuC7AOjjS9FmbkRE/IJYBhu6mt3eQwUE1B9hUZMO6
	 TSgqUshu892hMmC67wJ1rDdhUnoxZwY0OvJGxbrpN0SiAT5irOTSenlLO9R37oim/Q
	 oaOXi6rwOPW7w==
Message-ID: <2e40c724-7a88-4271-bac5-900cd338e002@kernel.org>
Date: Tue, 20 Aug 2024 12:58:16 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 1/3] ipv6: prevent UAF in ip6_send_skb()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot <syzkaller@googlegroups.com>
References: <20240820160859.3786976-1-edumazet@google.com>
 <20240820160859.3786976-2-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240820160859.3786976-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/24 10:08 AM, Eric Dumazet wrote:
> syzbot reported an UAF in ip6_send_skb() [1]
> 
> After ip6_local_out() has returned, we no longer can safely
> dereference rt, unless we hold rcu_read_lock().
> 
> A similar issue has been fixed in commit
> a688caa34beb ("ipv6: take rcu lock in rawv6_send_hdrinc()")
> 
> Another potential issue in ip6_finish_output2() is handled in a
> separate patch.
> 

...

> 
> Fixes: 0625491493d9 ("ipv6: ip6_push_pending_frames() should increment IPSTATS_MIB_OUTDISCARDS")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot <syzkaller@googlegroups.com>
> ---
>  net/ipv6/ip6_output.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
Reviewed-by: David Ahern <dsahern@kernel.org>



