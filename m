Return-Path: <netdev+bounces-213080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC855B23625
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 20:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90FFE1AA0BB6
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D202FF172;
	Tue, 12 Aug 2025 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Ha5oLfqO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582232FF16C
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024942; cv=none; b=VJOnncZsKPYRNJ7d82NGRLqXS71OX8LFh+I+DVvyu0hlRK6zQaYyr1zQlekWxhEOhmookz8PtZm8j7/rflL+naizynluIljcTrzUHt9sqgIOXpyWHtuKayytQZuSsFQhVjfNKW+RZfAg0cPRfpPSG2VlJSeEuDBVyFSMl1i+RIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024942; c=relaxed/simple;
	bh=HHj6p0iRfmqAn/14kELh4fItw8uH7ZkfpqWe/Ze47ck=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BLnn3vpN/a/+XAcuO03/J8iOX7mzlJpOJUEpaO/aB9y3KNpzphD+6XjF7OROJcgGIBT3en1eRJxjnJqszd8QwH9FmlfTio9wstJTHl6HS+YPiajZAPp7RSW65dnLweafDIXOQX72o+Ff6+VnwSgubRZwOw7YxySTx5Xik1wVdWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Ha5oLfqO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-242d8dff9deso33066475ad.2
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 11:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755024940; x=1755629740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/NR4hdZHMmCu4fDGp/w/+GLgfpqZ7SRw45XNFJuXHEg=;
        b=Ha5oLfqO6OMQ/BZbvHGvkOcrARiSDBNI5MAUtpICdGOEaVKsu9gxNceVK1qO9ycRcd
         4R8y0aDqkc4UDS5ZDrqzNpXeq2Td3pwUaoBVc2B1RYUIJLNWJf9WtSDHBnG3inPrfLoA
         HAXFXSK7wjZWKkCOiQBJxaXD33Pnpga2HpPpqRLA9pJBj8SmCXz5iOBPZebgUOEce2sj
         igrTJg1l3yEm4nVdP188q6J+Mc53qLueLIkflfKXinXXW79gsjycqpaJiY1d9bpGTP9g
         OYP/L5jLCNq9W8nHuYdfHhypzxufvSqv4STguDNby3HbfefROEDx5GxUAQkZXY59ohpB
         Xleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755024940; x=1755629740;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/NR4hdZHMmCu4fDGp/w/+GLgfpqZ7SRw45XNFJuXHEg=;
        b=kdzdt5Nea4irtcOqJLXvDaYnC4poDUbkWHh7Fxw6GZ6BznggwNCj8bgNUytDhbWIlf
         SuDmvrhOWFPr0NsarJsqZ3ux6m92jr25BU3DReKDJ+n9Cnnms16LxFsn1wGp+wH1gq+F
         9aF6tTxQnwgM1DU8ARtk8COhOCeWoTzjAdXGDzbr7TsOYsE+qUCb1i3QaEHAL1zSbYwn
         SICLx0wMp3XMEfVt9XjjdmwOtdZHErEymPegABmY4dHlWKdZPzyoGgbJb0w34gKpYfed
         jIfR8bwIRjZkxedWRBk3XB0KuD2Nmv+YAKls/5wcDpVx8+Bdw3vtF3yMcIcATBLLUEbn
         H7tA==
X-Gm-Message-State: AOJu0YwdBXkHOfTx0MGRzI1JEe78Vyq5B4/sNjOfsamclbsPQ5WWbbde
	/0wrXL5lbubOYId1VDz8oJjoUFIL+AAmNKHP3vE1c/5N3fwJPXwRzgMxgT9NMdMv2o4=
X-Gm-Gg: ASbGnct9HMnk0Q3PumTGCZRtU8DkZrvjYamhgQ9b6PlP9cz/fknJ3JirOq8/j8be8em
	7r9E4HgZMspzVKbSOoZZmibgTk/If26Q7apVX3gMk1TG5S6zbi1lAWJNo4GccrNQMLYufZNvtEl
	DrxSr5cVpPRWM1VU9e5FmfAQi0HWYbMLn+/Ao+sYlnqrn9iLpiOZS4Pw0kyvRQ99nO5X7MVveQt
	luYEayqocjjAngs90UCpQhAU50MWPS/Bgz2IcZofvEO58y72sKcGGnWB7rtkXC/At7vy7szZeyp
	1voltDX/8wv0lJMmoG1deNEAPOcLlo5fnpFdy9vNC8RaI5cbqLssmvvk5DP/px1KYAyVBVO78lg
	D2r+QSTY+ruUFvV0KfEQnS/m/hSAgWboSb4oF
X-Google-Smtp-Source: AGHT+IFidLZmnE2M0YQTfqo9xcBgDHBcfzcPjRX1l4MsOv6rXc3hmXcBtzHjRTSDznJxIbJDYuQ1zQ==
X-Received: by 2002:a17:903:245:b0:240:9f9:46b1 with SMTP id d9443c01a7336-2430d1ccbfdmr4090855ad.37.1755024940563;
        Tue, 12 Aug 2025 11:55:40 -0700 (PDT)
Received: from [100.96.46.103] ([104.28.237.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bb0be58sm25348650a12.57.2025.08.12.11.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 11:55:40 -0700 (PDT)
Message-ID: <9b27d605-9211-43c9-aa49-62bbf87f7574@cloudflare.com>
Date: Tue, 12 Aug 2025 11:55:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Subject: Re: [BUG] mlx5_core memory management issue
To: Dragos Tatulea <dtatulea@nvidia.com>, Chris Arges <carges@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team <kernel-team@cloudflare.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, tariqt@nvidia.com,
 saeedm@nvidia.com, Leon Romanovsky <leon@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
 Andrew Rzeznik <arzeznik@cloudflare.com>, Yan Zhai <yan@cloudflare.com>,
 hawk@kernel.org
References: <CAFzkdvi4BTXb5zrjpwae2dF5--d2qwVDCKDCFnGyeV40S_6o3Q@mail.gmail.com>
 <dhqeshvesjhyxeimyh6nttlkrrhoxwpmjpn65tesani3tmne5v@msusvzdhuuin>
 <aIEuZy6fUj_4wtQ6@861G6M3>
 <jlvrzm6q7dnai6nf5v3ifhtwqlnvvrdg5driqomnl5q4lzfxmk@tmwaadjob5yd>
 <aJTYNG1AroAnvV31@861G6M3>
 <hlsks2646fmhbnhxwuihheri2z4ymldtqlca6fob7rmvzncpat@gljjmlorugzw>
 <aqti6c3imnaffenkgnnw5tnmjwrzw7g7pwbt47bvbgar2c4rbv@af4mch7msf3w>
Content-Language: en-US
Autocrypt: addr=jbrandeburg@cloudflare.com; keydata=
 xjMEZs5VGxYJKwYBBAHaRw8BAQdAUXN66Fq6fDRHlu6zZLTPwJ/h0HAPFdy8PYYCdZZ3wfjN
 LUplc3NlIEJyYW5kZWJ1cmcgPGpicmFuZGVidXJnQGNsb3VkZmxhcmUuY29tPsKZBBMWCgBB
 FiEEbDWZ8Owh8iVtmZ5hwWdFDvX9eL8FAmbOVRsCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsC
 BBYCAwECHgcCF4AACgkQwWdFDvX9eL/S7QD7BVW5aabfPjCwaGfLU2si1OkRh2lOHeWx7cvG
 fGUD3CUBAIYDDglURDpWnxWcN34nE2IHAnowjBpGnjG1ffX+h4UFzjgEZs5VGxIKKwYBBAGX
 VQEFAQEHQBkrBJLpr10LX+sBL/etoqvy2ZsqJ1JO2yXv+q4nTKJWAwEIB8J+BBgWCgAmFiEE
 bDWZ8Owh8iVtmZ5hwWdFDvX9eL8FAmbOVRsCGwwFCQWjmoAACgkQwWdFDvX9eL8blgEA4ZKn
 npEoWmyR8uBK44T3f3D4sVs0Fmt3kFKp8m6qoocBANIyEYnUUfsJFtHh+5ItB/IUk67vuEXg
 snWjdbYM6ZwN
In-Reply-To: <aqti6c3imnaffenkgnnw5tnmjwrzw7g7pwbt47bvbgar2c4rbv@af4mch7msf3w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 8:44 AM, 'Dragos Tatulea' via kernel-team wrote:

> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 482d284a1553..484216c7454d 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -408,8 +408,10 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
>          /* If not all frames have been transmitted, it is our
>           * responsibility to free them
>           */
> +       xdp_set_return_frame_no_direct();
>          for (i = sent; unlikely(i < to_send); i++)
>                  xdp_return_frame_rx_napi(bq->q[i]);
> +       xdp_clear_return_frame_no_direct();

Why can't this instead just be xdp_return_frame(bq->q[i]); with no 
"no_direct" fussing?

Wouldn't this be the safest way for this function to call frame 
completion? It seems like presuming the calling context is napi is wrong?

The other option here seems to be using the xdp_return_frame_bulk() but 
you'd need to be careful to make sure the rcu lock was taken or already 
held, but it should already be, since it's taken inside xdp_do_flush.

>   
>   out:
>          bq->count = 0;




