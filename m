Return-Path: <netdev+bounces-140520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B82729B6C08
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 19:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623EC1F22131
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 18:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503111C9EB4;
	Wed, 30 Oct 2024 18:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5E6/H5U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296FB1C6882
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730312619; cv=none; b=Dzu6KEVrUYsqe+3qLVL6PZW4VOR63q+tmYrBVLto3f65aZ+FBdgag46cg7wEB2rilunL4SjRvtCl9sgAfb5r+flO3pEDSYxRgncz3jHLfGkKgEzH0yfsopis+MpDk0tKJ0mCLjqtW9xn1ZiUqg1XCcjkamkIXvlvXl3ZcGw8vTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730312619; c=relaxed/simple;
	bh=yaGUyA5XqmbcTjAWzAxPiRW7NlwnVz6817Nm/CdLhWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a9s4XVt8pAUmxH+fPSTuW4sDo0Mc6eqaWBvJv83/VW15t/rVhJ2Ui3NNavMn7PD3vMT7xWDKWMazILiLvMCU6OAFg3kNCMspUtrDL4Uo2okavHOwFLujVNCn9epncJyFq9AS7TGQbmVZioc5RmX9a0jwgjtV4S9fLPshT/YzihQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5E6/H5U; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so980185e9.3
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 11:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730312615; x=1730917415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V+gy6dmXWjgVeGP5fhPmyWmHTy23/mGOtUM+Ge5wU8A=;
        b=L5E6/H5UTm2fQWFyQMh/lR1fs8Yb2xZ/IsAGqME6abfxb5bR4UCzv0DXq0pPNTMwQC
         fCk6Gyv6G5DS/RP6G4zbTch8M608W6YCWV34sRDQ3sMnTwiPIuRRt0vol9Nn0Btf2OLz
         fquJIC3zgmDtFKgbFt+gPmbtwl4awaeaGZwCmDPB1jAii7G8P6G6Tt2WBFkV6kTUNSTy
         xBw0qd52UfWXUNHH9RrplNsfAyInwivNcp/Ozx2FARbr7HsKgVcJ74VsnVSmUWSMEhPe
         IjUaz50URRZ7cw3K6tmFDk2k/Bon0DLbZLTtuufVxomtAixo5hy4guYAPm1Dxct0w2dk
         82QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730312615; x=1730917415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+gy6dmXWjgVeGP5fhPmyWmHTy23/mGOtUM+Ge5wU8A=;
        b=QkwKtr694UHci/sj4JjHHbAENLbX+F6a1Y6md8AUtHHbbaDAfIIxeG0Caf5ng0M8wv
         OEgsGFYiOexHHmbwnzekA0HWMAkA7Yljq89t5r2pFpEecrq4F9yOovapssD/fb+Io14r
         viUntXadWa6fPY/3gRV14hk58Xfz5t+fGd+DhuSbEI0F8sfAF+IQpGEKo4oFrusTtZk6
         RjrS4ar3QS7C0OqLGJynXVs4PsEASWAFoIYRAlLIYBdvi4AVPSpAxrKJWYUkzqJruOOG
         WzGtqbzC2FK8+yb9qh7w+PDPNuguc1AeHFoo+na4C/ZnNJ+PRq+0Sz4ZS97oXm2YGmz8
         Pq7g==
X-Forwarded-Encrypted: i=1; AJvYcCWQxEkwXQNJWnfR7b6IFn42bGAgNTmbs5MVMuvCfCx2Kl55waLlbCJkP9P8bwdsG0gt3KWYpug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJBy74BQSQBs4disX6hX0dW5Y3kN16D4rzj6cfKn3Ye574yz9U
	04b3Hq6Adii8ePOLlMA90GHyU0L9M+BJ/tvclNx1QbUs/uOPSUpa
X-Google-Smtp-Source: AGHT+IGNN5Xq43SO9H+XgXnzNcnJzVwbSjI06MIXoem+WshEmIwKMbNI7u0KXPRtPYrcleIhXfIMqg==
X-Received: by 2002:a05:600c:1d15:b0:431:55bf:feb with SMTP id 5b1f17b1804b1-4319ad0899dmr148277375e9.25.1730312615195;
        Wed, 30 Oct 2024 11:23:35 -0700 (PDT)
Received: from [10.0.0.4] ([37.171.104.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b71231sm15928171f8f.66.2024.10.30.11.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 11:23:34 -0700 (PDT)
Message-ID: <e99174c4-7c09-486b-b1f0-9c57b1582232@gmail.com>
Date: Wed, 30 Oct 2024 19:23:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/12] net: homa: create homa_incoming.c
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org,
 edumazet@google.com
References: <20241028213541.1529-1-ouster@cs.stanford.edu>
 <20241028213541.1529-9-ouster@cs.stanford.edu>
Content-Language: en-US
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <20241028213541.1529-9-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/28/24 10:35 PM, John Ousterhout wrote:
> This file contains most of the code for handling incoming packets,
> including top-level dispatching code plus specific handlers for each
> pack type. It also contains code for dispatching fully-received
> messages to waiting application threads.
>
> Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
> ---
>   net/homa/homa_incoming.c | 1088 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 1088 insertions(+)
>   create mode 100644 net/homa/homa_incoming.c
>
> diff --git a/net/homa/homa_incoming.c b/net/homa/homa_incoming.c
> new file mode 100644
> index 000000000000..c61e5e250da1
> --- /dev/null
> +++ b/net/homa/homa_incoming.c
> @@ -0,0 +1,1088 @@
> +// SPDX-License-Identifier: BSD-2-Clause
> +
> +/
> +
> +/**
> + * homa_gap_new() - Create a new gap and add it to a list.
> + * @next:   Add the new gap just before this list element.
> + * @start:  Offset of first byte covered by the gap.
> + * @end:    Offset of byte just after the last one covered by the gap.
> + * Return:  Pointer to the new gap.
> + */
> +struct homa_gap *homa_gap_new(struct list_head *next, int start, int end)
> +{
> +	struct homa_gap *gap;
> +
> +	gap = kmalloc(sizeof(*gap), GFP_KERNEL);
> +	gap->start = start;
> +	gap->end = end;
> +	gap->time = get_cycles();
> +	list_add_tail(&gap->links, next);
> +	return gap;
> +}


1) kmalloc() can return NULL. This will crash your host.

2) get_cycles() is not generally available, and can go backward anyway.

   There is a reason it is not used at all in net.




