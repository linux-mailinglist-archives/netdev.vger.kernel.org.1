Return-Path: <netdev+bounces-218012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F83B3AD4B
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595E0201A63
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699122BF000;
	Thu, 28 Aug 2025 22:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMFMYgSt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440141EEF9
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 22:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756419137; cv=none; b=WFXBWuArU0s+q78dGwT51UWBA/vaX+cNFjqFjCXWEMOmFGPXSZrlY+wN0gtyokoJ7e7TrybQOMPVakWLO4kIluNWQ1II86PNKbkLM9+xbf/Ye/1YIbL4UVFwjS70geletF0epKyvWdivStp6/hs5vRv5lXE1yxXp3WYPyMubgYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756419137; c=relaxed/simple;
	bh=WmL1d29O8AcDy47oe74uDZce4Y/iihIsCVl+G1jYo8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GuQ39Ueyp0T6oOjOeJtewaSCpjCYbEvc0uMEmjP/Srb1Xnifk+KD0dAvwjA3iWEPPn52uY8l5hpyadBlWPrvDoYKXpemimCOma89QXiq/pHY9vcB/0qFTHKVeIpMshgKgSbwfq4sBaJumqK65tUWwSo4aQSPAzkPZPYsGewM1Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMFMYgSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658B1C4CEEB;
	Thu, 28 Aug 2025 22:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756419136;
	bh=WmL1d29O8AcDy47oe74uDZce4Y/iihIsCVl+G1jYo8c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TMFMYgStBPZaU4VMQE5X2nkj6DOcmAMGgd1gCtYGCSSFvIzhT3khY7cqQm5aB266z
	 p37i6Mz+teuhygTV4oS9u3x0YCexEjg0+Zg6vy9cL5lrTm+QjO/LSPw6M6vUosw2GN
	 rZ1gQTfjSx6TGVMsDbxX+6fcP2vGsxNnLmrmkE3zeV3uKl/MYkb0/cMydXhl59/WWf
	 ssQiHlBxEt5lhJixnfs0F7tX7j7eiBUUcue+FGLf+AEctclw5k7tELcj7vnJMF658U
	 KyVU8QvgfDUucG/FmLan1WGuTfCl1qHoGceA4nl4O3+7FBgAf+B2EacuhjTxudxRH+
	 aKxjdrAacnTKg==
Message-ID: <5b7aabf0-0bed-43bb-9fc8-164f3638a7d1@kernel.org>
Date: Thu, 28 Aug 2025 16:12:15 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/8] net: use dst_dev_rcu() in sk_setup_caps()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20250828195823.3958522-1-edumazet@google.com>
 <20250828195823.3958522-6-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250828195823.3958522-6-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 1:58 PM, Eric Dumazet wrote:
> Use RCU to protect accesses to dst->dev from sk_setup_caps()
> and sk_dst_gso_max_size().
> 
> Also use dst_dev_rcu() in ip6_dst_mtu_maybe_forward(),
> and ip_dst_mtu_maybe_forward().
> 
> ip4_dst_hoplimit() can use dst_dev_net_rcu().
> 
> Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/ip.h        |  6 ++++--
>  include/net/ip6_route.h |  2 +-
>  include/net/route.h     |  2 +-
>  net/core/sock.c         | 16 ++++++++++------
>  4 files changed, 16 insertions(+), 10 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



