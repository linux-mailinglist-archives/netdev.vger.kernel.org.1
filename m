Return-Path: <netdev+bounces-218007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4854B3AD03
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 23:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94D6567D74
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 21:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F7128C84C;
	Thu, 28 Aug 2025 21:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEPitXQo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1897404E
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 21:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756417985; cv=none; b=h6Y498gH73cdxBtB3kNjzQOrVjJw7iiHNijSiYxjjYfGXOecu94xMWI7oMO2gYJVSm8KOs1dCpI0oddExrek04Qpizp2YmdBDMoPHz3loSm9xmPLg9kF1sEBiyUqmc10xs8g6swY2N0otbRR/qgbVABPu+XsABR0kKhqyeh0F/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756417985; c=relaxed/simple;
	bh=bu4WbmFO9IfID3zAOGzNS/okVkZSM2lvJpQ6jliVnmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZcQ+jBgK5Kyt/cSq6PFXOhEPJaoE7KUiM3F7GBeUkPCUE+F0d1uAevMrISBPPmL28/FY4wcSUool58A/893nTeDAc2LX8FgEsHwPpTaTBK8SMh4tJKPf8oukKHVZOQErcps+TSu8Fj7+Ew5q4YnvCg8UHVhFLC3RmbtNfEnMx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEPitXQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA5AC4CEEB;
	Thu, 28 Aug 2025 21:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756417985;
	bh=bu4WbmFO9IfID3zAOGzNS/okVkZSM2lvJpQ6jliVnmQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cEPitXQozs/jcKqPTbMFGXtEIRHqfSXgferpWw5XAh4vr5QWtTxe2QmwbfpN87TTx
	 DaUfYiKV424XbVZ1vVQrKtBfAiLzPCNUGNNELovQI5Hsl3Iyqnb22/TboKRzOSFwNp
	 9jX8+eSvcVVEF1aD6amETO0Qk5Z80tKVz6CWI1/V0gDHyyOblk1B9VsKLcd6baPqNw
	 G7d0oRUW3iv/qAMR40ASu/NRvud4jgMsXzukjvSZBCUa61r3GLyOcta2XzUxqXSfXE
	 xL9DDwz/Nf0uiRiqMwZnZHYJI/B/sfI3rxySZwFCJCwJvI0M9CnqjqD4BNobJWqk0f
	 oEs3IN7LOrpfw==
Message-ID: <4b3f7ea4-2acc-43ff-93dc-1f67a1e2e6a4@kernel.org>
Date: Thu, 28 Aug 2025 15:53:04 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/8] ipv6: use RCU in ip6_xmit()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20250828195823.3958522-1-edumazet@google.com>
 <20250828195823.3958522-4-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250828195823.3958522-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 1:58 PM, Eric Dumazet wrote:
> Use RCU in ip6_xmit() in order to use dst_dev_rcu() to prevent
> possible UAF.
> 
> Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/ip6_output.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



