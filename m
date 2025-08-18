Return-Path: <netdev+bounces-214579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B96B2A692
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 15:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56B25672E0
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 13:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921F02135CE;
	Mon, 18 Aug 2025 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsJrTqNp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECEA335BA1
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524000; cv=none; b=CshquC3Z1A8gi97X9Ph85delmWeWxIfCrPG7tdckpR0xNX1EEz7+CZ1vzymypsEjuORDCdVDavl2M74Imy0mkbnNgvhjI1v28vzLpRF/yg4F1mOPgsBvledaWxV8Yq1IfV2kJHiPE09hkMC+5EJC1d/z1+OICzoVRoE4EfPOG6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524000; c=relaxed/simple;
	bh=tzxoio87WEbosTjQRPRAqxefJXKYm4CW0JSOMO/r9M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgdgH/HPBDmVz9uJ3nwvxAsVPRGLsnMwPm8ICEs22k0KSvqttk4OnsF8wWKA6D3t41Z5Qp4NLrm8Mmxu9NQeLRrdwtWh0UXepA6EF3yu8gyvaFlpgPnwDt6seuSiEQ0oTAx4mYiuDEiE5KMC2RkQ8pTO2MoIddzy+BSAK2W1in0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsJrTqNp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A74C4CEEB;
	Mon, 18 Aug 2025 13:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755524000;
	bh=tzxoio87WEbosTjQRPRAqxefJXKYm4CW0JSOMO/r9M0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XsJrTqNp5x6uRyBTYr41XuJx4vHdjUKKzfV3vciMLRNSG+B7OMdhcnX8lPWvFbnNL
	 LkyfTuR9y6XxAzKYXpUVyuAv5ekv3JWQ08dE1PsV1lt6AIjuJT4WeByUAyPY08hfs+
	 1N/1jyvP1R4TaKuaSWwM14fWYO1hSzI6DqQjVgkRzXf/x2WsLmlMOFQ52KR8Mj8z6/
	 w3xWnW2850mJxsYekAc7VxDVMPd8Pk34PNxvro1JoiCi3Ut1x1FqnudFxOiWY/s+Wo
	 r487XAKLCzYvfAfd0HJSEekhcjBoNmr/OMUKe4Qd1+0WQ8aX798QnFzk+X2/dJcTuy
	 BEDp+J0VLsAQQ==
Message-ID: <a9ae4ab6-bc93-4a0c-8018-d8422568b09b@kernel.org>
Date: Mon, 18 Aug 2025 07:33:19 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] net: Speedup some nexthop handling when
 having A LOT of nexthops
To: cpaasch@openai.com, Nikolay Aleksandrov <razor@blackwall.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org
References: <20250816-nexthop_dump-v2-0-491da3462118@openai.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250816-nexthop_dump-v2-0-491da3462118@openai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/16/25 5:12 PM, Christoph Paasch via B4 Relay wrote:
> Configuring a very large number of nexthops is fairly possible within a
> reasonable time-frame. But, certain netlink commands can become
> extremely slow.
> 
> This series addresses some of these, namely dumping and removing
> nexthops.
> 
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> ---
> Changes in v2:
> - Added another improvement to the series "net: When removing nexthops,
>   don't call synchronize_net if it is not necessary"
> - Fixed typos, made comments within 80-character limit and unified
>   comment-style. (Ido Schimmel)
> - Removed if (nh->id < s_idx) in the for-loop as it is no more needed.
>   (Ido Schimmel)
> - Link to v1: https://lore.kernel.org/r/20250724-nexthop_dump-v1-1-6b43fffd5bac@openai.com
> 
> ---
> Christoph Paasch (2):
>       net: Make nexthop-dumps scale linearly with the number of nexthops
>       net: When removing nexthops, don't call synchronize_net if it is not necessary
> 
>  net/ipv4/nexthop.c | 42 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 3 deletions(-)
> ---
> base-commit: bab3ce404553de56242d7b09ad7ea5b70441ea41
> change-id: 20250724-nexthop_dump-f6c32472bcdf
> 
> Best regards,

For the set:
Reviewed-by: David Ahern <dsahern@kernel.org>

