Return-Path: <netdev+bounces-103884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ED7909F2F
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 20:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7624B207C1
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 18:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4237A3611A;
	Sun, 16 Jun 2024 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4UhmDO4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B60014012
	for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718562399; cv=none; b=Cs8q3ibhAV8rSJHgs/WbQD2y0+g4zS2VaABJ2cU2DDlm6ohbt8vmrIgbRXeyyKfFY9PC+8XgHMf4iEngbSDtfomxbAGAOOvncjbw+Il8VUjjWF0CI36jJuOA82NNAQbCuQjxVi57FcWd+Zl1oEOqTx5+fXS4r+n/JjoAYgWm8AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718562399; c=relaxed/simple;
	bh=VdX4TUv0QOEdzaZFGC1z4BPOxV2h/05qgV69gDxJjJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLlnT8LhGI4uS31bb6rD6wKlEe4kPrB2yI+OLlPj5JY4RB4EN4bnxYUaTh0ES/PMINF6mxiqwxAJreH366B9i9O6I9rX8wMuPsAZ5UqmMrVJ1gQwn1bs1/hc4D2lrx8kqZupPQ83DKU/MU5PhW0R5Ivbn7HUbchFlx/b4oNZBFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4UhmDO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4479AC2BBFC;
	Sun, 16 Jun 2024 18:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718562398;
	bh=VdX4TUv0QOEdzaZFGC1z4BPOxV2h/05qgV69gDxJjJY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B4UhmDO4c6iM0f8qzIjMpuJcLLmRyvBmrFfosnPnqRu2cqJgS8QGjWmqp+6GB7/Qi
	 BKoRvdxijMTj/sSshuCfW7fijkUJp8AJA727sSi1s14Wf5UrChh8dg2e+zk8UwICUY
	 hOKyuIWgeaZyleqZru9I3IQ+/v9TEpEOCBdMicizp5qQljivmDVSVVaGArN5ekpBkn
	 azyO+AOk7TkTXzlz0sGuzreWnvJDzZ6YsGKEbheU7iQx9Jo3pgyxQJ8zSjlfIAMR/A
	 VT20SxfAU4VZe1evwGHyqdzHpUZ3DR7G1uy/1J7kxbYEuAQB1OsfaBZboNAgYUN80A
	 5RBLRr7RHs9HA==
Message-ID: <d1349a69-791f-474b-979b-a0f155c58a61@kernel.org>
Date: Sun, 16 Jun 2024 12:26:37 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] xfrm6: check ip6_dst_idev() return value in
 xfrm6_get_saddr()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
References: <20240615154231.234442-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240615154231.234442-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/15/24 9:42 AM, Eric Dumazet wrote:
> ip6_dst_idev() can return NULL, xfrm6_get_saddr() must act accordingly.
> 
> syzbot reported:
> 

...

> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/xfrm6_policy.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



