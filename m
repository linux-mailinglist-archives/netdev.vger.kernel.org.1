Return-Path: <netdev+bounces-217331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F319B38572
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341061882251
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0630C219A86;
	Wed, 27 Aug 2025 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUZWibvb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41761CD208
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306258; cv=none; b=uVx6E2uTXp5I+FI9pobshiAHsk7BYKr8woWmij+N/28dG9fglSvQQgwx+viAOyqkaE2cvCb7SVGIZi5NM+N6AgKSoYm6GaH6coUbDWRU+2Aje0upIJGX4HxVh38hDKkXUzDR8487KTERMYpCejhKFN2t1cC0c64t+bCW0Av/+Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306258; c=relaxed/simple;
	bh=JSgeEyBekHllUgbbuBBQYaUvf4t/SBuLMVrjEFA+VHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7j0YU1HR59jx4Y6c2reFfoMd5O6Gtg4Bfnj/5X/uhLags4AgHmRZwwqI2sdhUW++aOw6mT7vj4jgRwTn/C+W29g5wmLoDQgSEQPx08m5uHQTioK5QVfn1cjD3/fH+r3ewlylDzaDV2tcRIU4/8B5QSt8M7wkv5RQIkZazSP0mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUZWibvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349DFC4CEEB;
	Wed, 27 Aug 2025 14:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756306258;
	bh=JSgeEyBekHllUgbbuBBQYaUvf4t/SBuLMVrjEFA+VHU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oUZWibvbbI67455c2RE/MpXu7RosiPCh53YnRBwFcVTVdlDLxTo5F0kzpFc8otYCh
	 kZL2QIomPU9pSdlDaox3F4IrbsInpGdc1EpjNe54CZdfnXrQ9JGswzTFEyj0JoYhtU
	 PH2a8/AEMqk88ZChbRkhyNSSYzHdLvxgTWz3i+c9Fg9AyBdSzyp8UmZ4RgrT+Ospda
	 yzCn3yxzp6sH+K7+Km0mN7ut5kq6KciaBTQIoewMXcFvi8hWa9uB297Y2rQnQot1Fj
	 gTX+0Lo8ts0IsIXcq728CxHcnV0slQ9NC63fT0MXwSXW0vgQ7EaeiVZ4Et4C8xPFV0
	 FsvT4TR0QQVtg==
Message-ID: <b6013a6b-5423-4cfd-9b19-94ee26b95028@kernel.org>
Date: Wed, 27 Aug 2025 08:50:57 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] inet: ping: check sock_net() in
 ping_get_port()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20250827120503.3299990-1-edumazet@google.com>
 <20250827120503.3299990-2-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250827120503.3299990-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/25 6:05 AM, Eric Dumazet wrote:
> We need to check socket netns before considering them in ping_get_port().
> Otherwise, one malicious netns could 'consume' all ports.
> 
> Fixes: c319b4d76b9e ("net: ipv4: add IPPROTO_ICMP socket kind")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/ping.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



