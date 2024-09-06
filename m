Return-Path: <netdev+bounces-126061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707A596FD4F
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 23:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7072882B7
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 21:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1F8159582;
	Fri,  6 Sep 2024 21:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vUuR3q29"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B892D1591F3
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725658019; cv=none; b=JlUSciPgXX8eJ2pRBIgwgNaezh100MUvTvuIL31n2p7dHXfzTnH4BujpNAjlUjrExoFuk0VZ9DJt7o8qEBpgHCKmkuYDjW+7Ux5GTolR7asx4CuaJzf8ZX5Fg7Hw/pyxjEDMYQ59ZJZZdY0bGnUPT8qLn1ZFDtnG3YOrUcfZSzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725658019; c=relaxed/simple;
	bh=qDf0sb0zPsk31XSFWnAJCXFWqxuz317WwFUOXHBUD0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nyZcBJKZ/lHT4tDr7HXCe+v5pfvflLzIcTy2cFWth5YwRo47nqyRaueRUDHUt2NmRmJteKQPsBIOjIpuCSFaSik/DFrbWqgmw6gt/HKgLVf16sDXrAhGOgk5nhLkF+yujBmRZ6nUzSCHTlQNHwx/rs51uflDCCQU+rPowj122PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vUuR3q29; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0467d279-e825-4c15-ac85-859fc6b95ee2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725658015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2P9GMowORIBDHwl53frehcwBdS235SGtbdUPMq/wILw=;
	b=vUuR3q29yw/UATf/+C5Qwr5M/xBvFNMgwkGYaZa4IpNQrHtFnaSUzJllEaS1AyWoSXLjsO
	YZEiVnIm186jVC0u/xRV3Ht0shQhkSHon4J4DfUamS5p/AWY+H77FIakjlr4wOIYbVgQO7
	iVFW92hsZlfGOxkZq0bqd9UOCHrLjl8=
Date: Fri, 6 Sep 2024 14:26:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] sock_map: add a cond_resched() in sock_hash_free()
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot <syzkaller@googlegroups.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Paolo Abeni <pabeni@redhat.com>,
 "David S . Miller" <davem@davemloft.net>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>
References: <20240906154449.3742932-1-edumazet@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240906154449.3742932-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/6/24 8:44 AM, Eric Dumazet wrote:
> Several syzbot soft lockup reports all have in common sock_hash_free()
> 
> If a map with a large number of buckets is destroyed, we need to yield
> the cpu when needed.
> 
> Fixes: 75e68e5bf2c7 ("bpf, sockhash: Synchronize delete from bucket list on map free")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>   net/core/sock_map.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index d3dbb92153f2fe7f1ddc8e35b495533fbf60a8cb..724b6856fcc3e9fd51673d31927cfd52d5d7d0aa 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -1183,6 +1183,7 @@ static void sock_hash_free(struct bpf_map *map)
>   			sock_put(elem->sk);
>   			sock_hash_free_elem(htab, elem);
>   		}
> +		cond_resched();

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

Jakub, may be you can directly take it to net tree ?


