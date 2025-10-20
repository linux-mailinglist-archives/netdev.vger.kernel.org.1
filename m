Return-Path: <netdev+bounces-231023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8E8BF3FF6
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 01:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A214404215
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 23:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F122F360A;
	Mon, 20 Oct 2025 23:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMxK64PB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D912EBB8C;
	Mon, 20 Oct 2025 23:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761002201; cv=none; b=Pa4JpjvW1rZZpobJZkAVxjs8rHaYTGy3gqUNSc6fThmILJyFsheG7CTKOnn8w+azyWCOUc0rWqTeS+HhwGwlhlNKDNTzas7JUUlOsp1mtPxD3RILo6kEdMqzqDl8jPmrpwiyNJqDU8YfECb1nwHvv0sqFVgzeBTJPNgmEgthQX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761002201; c=relaxed/simple;
	bh=pQkZArZ+0yUt9XTcEaYSSPiYFA/1rIck0Ro/itOIUz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sF/9YaR75cESsjTxGEcNv7Cf3vD5QIGjvYHIxfkxfPUyhIdotHQdiAEgbpaDc5lkTixpX5Jau1MQCzeY7tFnhkIgnAopKvUbuewKHXFSDGZaEgVNPzawpzrDO33bfl2+VpC+xBBMjFlMG1DTCsEqQmSc6azAGPRfvxn033VZ7BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMxK64PB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24377C4CEFB;
	Mon, 20 Oct 2025 23:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761002200;
	bh=pQkZArZ+0yUt9XTcEaYSSPiYFA/1rIck0Ro/itOIUz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tMxK64PBi4S9wi0yAhboaxlu0i3gNII/Yb2gaYGDfF7lomFuItw8h1BT8x+XDsCWS
	 mmyC0qDPQefOaNyW6Hu49xZHfPTHy/FdVxoY4wdmLHWm9xJSwJBE8VjNKVrnYkJ6lB
	 Ro99ST3/Z1Xn/i4ZbI2GobcJhGY7nVKko+T5Np8+eQOr8cfIFfkfFGGkm0DJ949NeQ
	 5TRFY7gALoeEG/a+QGZJnurywvzny5Fhrfp+GS3BFmorv61gciwXjqQfTLG8eVtw0Z
	 vk3vOhzxY6k0rBdJu1qweKqwgPybecgxOxIpeUroCj0XVm0G0fA6nOZesDaILQ21P1
	 3DAHtT71FqrHg==
Date: Mon, 20 Oct 2025 16:16:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zahari Doychev <zahari.doychev@linux.com>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, jacob.e.keller@intel.com,
 ast@fiberby.net, matttbe@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, johannes@sipsolutions.net
Subject: Re: [PATCH 2/4] tools: ynl: zero-initialize struct ynl_sock memory
Message-ID: <20251020161639.7b1734c6@kernel.org>
In-Reply-To: <20251018151737.365485-3-zahari.doychev@linux.com>
References: <20251018151737.365485-1-zahari.doychev@linux.com>
	<20251018151737.365485-3-zahari.doychev@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Oct 2025 17:17:35 +0200 Zahari Doychev wrote:
> The memory belonging to tx_buf and rx_buf in ynl_sock is not
> initialized after allocation. This commit ensures the entire
> allocated memory is set to zero.
> 
> When asan is enabled, uninitialized bytes may contain poison values.
> This can cause failures e.g. when doing ynl_attr_put_str then poisoned
> bytes appear after the null terminator. As a result, tc filter addition
> may fail.

We add strings with the null-terminating char, AFAICT.
Do you mean that the poison value appears in the padding?

> Signed-off-by: Zahari Doychev <zahari.doychev@linux.com>
> ---
>  tools/net/ynl/lib/ynl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
> index 2bcd781111d7..16a4815d6a49 100644
> --- a/tools/net/ynl/lib/ynl.c
> +++ b/tools/net/ynl/lib/ynl.c
> @@ -744,7 +744,7 @@ ynl_sock_create(const struct ynl_family *yf, struct ynl_error *yse)
>  	ys = malloc(sizeof(*ys) + 2 * YNL_SOCKET_BUFFER_SIZE);
>  	if (!ys)
>  		return NULL;
> -	memset(ys, 0, sizeof(*ys));
> +	memset(ys, 0, sizeof(*ys) + 2 * YNL_SOCKET_BUFFER_SIZE);

This is just clearing the buffer initially, it can be used for multiple
requests. This change is no good as is.

