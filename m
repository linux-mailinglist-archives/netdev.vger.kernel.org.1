Return-Path: <netdev+bounces-164197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBD5A2CE41
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 21:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FAC1188F4D2
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 20:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C831B6CEF;
	Fri,  7 Feb 2025 20:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHE6+OT0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECDC1B6547
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 20:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738960889; cv=none; b=dpWc7cJJnBmAyti3yh8mfg9LDi54bb9Jd8CDzharPfqQmC3TdCRc5mxOAcpgNQlNWYY1NdTNvGDzeqbAEBVTUv/AKeZ34x7ZJX8VEPOEuWcA8kk7nlkRn964rBJM5aCp3GzH+AoqN6o9mWkMALaM+c0Wv1V7/rb4hh0+N/nWVgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738960889; c=relaxed/simple;
	bh=F0ly61zN3/Kqry4N4YBUyRLu1aOn8+mXNNOAFb/71YY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofqixbzii5aUMa44XO031F82QkQtPiv3fmFGBqsmTV3YECqEHEV51u7G3nZ2oUCLnu7ivOq9j+OfP8risg+2XuSKPdzijhKjzreRapVDs91uep8pcxkb8XxKP+wHx1abQai3rsLGDwoN5klFRieVpDDGDXTsdG+L2RDDS4a5xp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHE6+OT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AD2C4CEE5;
	Fri,  7 Feb 2025 20:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738960888;
	bh=F0ly61zN3/Kqry4N4YBUyRLu1aOn8+mXNNOAFb/71YY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rHE6+OT0kw/PjVBgdIXPRc5tKgnjmjTxebTf4rNn9+2N26Qob8Z+a9R5SjyhWwPQY
	 lYH9vM/bi4IuYmKZc6JgFzbKAM6QnRKGMS87COrjTkYJ+2y62kmjMNRJGaU9y24PYP
	 EMxvvmOjtMjSe3qpnBjg/IzmUItWEb+g0D1IsVDCYRkFQ4KdK/fGjmpo5mJz66CXmg
	 Hypa10tfNuBIAAycmp/yyHbIojUruxmRnlWxAPt2o3FLkWkLGb6VPnItJfqYRdus+Y
	 dg16hQCZjVxk252zH/i4jGbPH/qsQvy5WMj5UHStwgkMAQJP6oACNQI1p5FeJZh9jM
	 OpDflVgZkZ/Xw==
Message-ID: <d0dbc9e6-ca5d-41e1-ac98-855c3cfdaa59@kernel.org>
Date: Fri, 7 Feb 2025 13:41:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/8] ndisc: ndisc_send_redirect() must use
 dev_get_by_index_rcu()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com,
 Stephen Suryaputra <ssuryaextr@gmail.com>
References: <20250207135841.1948589-1-edumazet@google.com>
 <20250207135841.1948589-2-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250207135841.1948589-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/25 6:58 AM, Eric Dumazet wrote:
> ndisc_send_redirect() is called under RCU protection, not RTNL.
> 
> It must use dev_get_by_index_rcu() instead of __dev_get_by_index()
> 
> Fixes: 2f17becfbea5 ("vrf: check the original netdevice for generating redirect")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Stephen Suryaputra <ssuryaextr@gmail.com>
> ---
>  net/ipv6/ndisc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



