Return-Path: <netdev+bounces-54249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 649A08065CF
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172D51F21644
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 03:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAC1D304;
	Wed,  6 Dec 2023 03:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEk+RaKy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDA0D27F
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 03:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C4BC433C8;
	Wed,  6 Dec 2023 03:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701834226;
	bh=Yt/7bAOKIimNBpZ0Q4GpZ/R6rZPYD6PxJiZ4tyrcpxs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cEk+RaKyvuWTUrYHayrbeJd+hkwdeo/6xXsVj9MQpyDav2tUpHVJPo8phFf00hoxV
	 dc2wrv7DXhihdJpBks5x4pDuOCoaGwaUSiAZ6jJi1x5gctVY2OZz3vdeHwjM7H0G9P
	 2vIP4kBu79EfQo4/XOuFXREVjY91BvCkOna62RS1TLhD26qUSGm1jQ3kY99CHeaK1z
	 JOt0YI6tPiwqQzKf7cEMiKXuCQYMZlli+23XDclgnxffCiJc6jaE0h6/vkv5jNg/61
	 Lh08gLdtNnCiuxds2dIzP+KmmDUgxpA86x5V08dpKdB1WiUj8aEN9hZ6Xdl7b6EeLb
	 43SXRNnz4tNnw==
Message-ID: <2fea2908-69a5-4c6d-ad27-94f48f2f2586@kernel.org>
Date: Tue, 5 Dec 2023 20:43:44 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
Content-Language: en-US
To: Judy Hsiao <judyhsiao@chromium.org>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>,
 Brian Haley <haleyb.dev@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Joel Granados <joel.granados@gmail.com>,
 Julian Anastasov <ja@ssi.bg>, Leon Romanovsky <leon@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20231206033913.1290566-1-judyhsiao@chromium.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231206033913.1290566-1-judyhsiao@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/23 8:38 PM, Judy Hsiao wrote:
> We are seeing cases where neigh_cleanup_and_release() is called by
> neigh_forced_gc() many times in a row with preemption turned off.
> When running on a low powered CPU at a low CPU frequency, this has
> been measured to keep preemption off for ~10 ms. That's not great on a
> system with HZ=1000 which expects tasks to be able to schedule in
> with ~1ms latency.
> 
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
> 
> ---
> 
> Changes in v2:
> - Use ktime_get_ns() for timeout calculation instead of jiffies.
> 
>  net/core/neighbour.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>


