Return-Path: <netdev+bounces-184498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5225A95C9E
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 05:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90931898824
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 03:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AEE10A3E;
	Tue, 22 Apr 2025 03:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mvfrf9Mq"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0BC2F2F
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 03:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745293701; cv=none; b=jVy+peBnuxk8lbCgxmF9cQw+T2f3j6qyKPCDQ8ipjvbP674kaQNxlg0Z5qk/ZzD7qP9ZDW4h8yKNmLaR5yg6/6yYaDzWiOOFQjNrVvwH/ODGSDmdmdZwJsZQBGwubmKNixlrsQ1Qq5BIXEiimqXOn8uF/cMNiFW0mn5UGdz+CK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745293701; c=relaxed/simple;
	bh=G7vzUSQq4EdTbRpV3cT6/T4Ye2LenWWEj8g9fAdleSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GIefwtDxpg12yvQc8lmnCaF/nJ3nc5HMqhMTXjnGbTsUcqpRiOiEQD8PdxT6pK1fKAmoG4GrFH8rfi9Ez1/QY3w5tZAJ+IBWIpPYxfNWvQqmLOb0IW3mg0UPVhK111N5b+AscQRBoq9riJzq3XPWdPBpwYtf/Xaz5ZBKm9Ujccg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mvfrf9Mq; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <11f8a2b3-ad4d-4e59-b537-61e1381de692@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745293680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iJJ8zOuJRaeaBCUDDtT5H5CNBrXaLTCynq9UCqphlkk=;
	b=Mvfrf9Mqrcq/2AhrYdeEk7kN0WoxRCRumzttLrNCJSzF1Kv9WzLs0Fk70KaCnEXS0CO11L
	430iHGTId52z+PGLWd+4LpcsUsjpbIu1+D2LMaHnk/YIXqi9m1KZ6f0l5Rr4ihrqW+kF7X
	vfw7Z7ZEaE/R25mxatrjBOq2LhWqxJ8=
Date: Mon, 21 Apr 2025 20:47:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 4/6] bpf: udp: Avoid socket skips and repeats
 during iteration
To: Jordan Rife <jordan@jrife.io>
Cc: Aditi Ghag <aditi.ghag@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250419155804.2337261-1-jordan@jrife.io>
 <20250419155804.2337261-5-jordan@jrife.io>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250419155804.2337261-5-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/19/25 8:58 AM, Jordan Rife wrote:
>   static void bpf_iter_udp_put_batch(struct bpf_udp_iter_state *iter)
>   {
> -	while (iter->cur_sk < iter->end_sk)
> -		sock_put(iter->batch[iter->cur_sk++].sock);
> +	union bpf_udp_iter_batch_item *item;
> +	unsigned int cur_sk = iter->cur_sk;
> +	__u64 cookie;
> +
> +	/* Remember the cookies of the sockets we haven't seen yet, so we can
> +	 * pick up where we left off next time around.
> +	 */
> +	while (cur_sk < iter->end_sk) {
> +		item = &iter->batch[cur_sk++];
> +		cookie = __sock_gen_cookie(item->sock);

This can be called in the start/stop which is preemptible. I suspect this should 
be sock_gen_cookie instead of __sock_gen_cookie. gen_cookie_next() is using 
this_cpu_ptr.

> +		sock_put(item->sock);
> +		item->cookie = cookie;
> +	}
>   }


