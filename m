Return-Path: <netdev+bounces-251093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB4FD3AAD7
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06538300C370
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 13:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C07636E489;
	Mon, 19 Jan 2026 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYiIrJRs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AAB33ADA9
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768830882; cv=none; b=ZbADoDh7tXAJ8FSk2QCj5lP5lqJnxO5F4GT4y9j7LPf10y0VrcuYkfXQ4Mn5xr4ck26cG40E2rwFpRzuThr1h7lGdSx56REToZOefd1bd3bf0BBlO8jqVBpgFod/k2VitiorZNEd8BfgK625eKWYxlpQ3zAkKUtAdKTDEmNgM0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768830882; c=relaxed/simple;
	bh=lo81BFx/Ulv0xcaPTgRdmV6KO1F84bHVc1SQVycS4S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ud1FWbk090/j0eRbZ5TvEiVNnFbGHNkeaFEqi95hil6hSosR7kcHsjTSmH9+VCzc8MIUNXwnKk4rPaq8jfV7R69+ug3hwcbtMEXTTh0+k2VhikqyHzx6mCXSh49/VZQtBmddBnhShyXbKVwwLmvB5EK+P7AIfHFmHdLOh31royI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYiIrJRs; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42fbc544b09so2859808f8f.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 05:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768830878; x=1769435678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MPy6cjzmHwuoEQvvRHEOfQ3zwGp51DN3ulInpeNRzkQ=;
        b=OYiIrJRseciC2w1wnZYx/HQx+/0wX9AA+uU2X5/x12E/i8fcD9BBGk2WIj8Vzl3nQ2
         heoHllWVgyETGz3o9UJgZUj2iw1g5A5wmNYoC6B6US3c9/XQGop6MP/TI4iL4MetxhRY
         Kgm5v0Ns51mj3FsZElRH0eS5inpYEalQgzOnzZJg34NDzxt6sEx55JnBLY9QqwL0TAZM
         yKR9AQMFWpTfpCIbn+BPlWKV+6IlkWqzjZnim0bEJWKxZhSFiE9zCJqz4FO0cu+JXDSh
         KRlwuTmdMrX0dyEWK65U+OJAyPp+Pq2QXSV3yn85P+XNHgTTnyyXX46U0HrzUcZZQLQD
         EG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768830878; x=1769435678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPy6cjzmHwuoEQvvRHEOfQ3zwGp51DN3ulInpeNRzkQ=;
        b=I8NyoaPJWz8OCc8vYeDUAqKEtfEMssyNiiGJL7PWxnE1O5uUqcjuM/tmhiiZHeyr/D
         Y19ZHupZ4aclmvjP76TvDSjkwnF+Fh42Z8cAOwTL1QnjwLtKvrqy5og00PliYNcJ+eCL
         LUAg9VtTbbqU2BiKHwLiqDVY7ZG6yrjXN0NQYqrwXSoIUyB4kwlwq5YQe8agC3iUr8CQ
         5qIGm8DAsT8VpGjrrqwDJWcDUGrIVHSwTgV9rjFPPnU8gOhYoVnU7cJQlA2wOUPcJ5Zf
         /2fSRFXLaB0+h9ouWQJKW3NEVPKohX7n4rdrxS+MXUesvSY+a21Us7ZE9x+vGx7CS25M
         b2JQ==
X-Gm-Message-State: AOJu0YwKKSsVNhrakC35M1hrG0UD300erVgv4Gex2+a2F5fAxWbfr+4R
	B+TsqJPULbr7E6fTmy7FLzSSWJspdrwwiFxa9T6h2TS5svpuqWu0wzOA/Ssqsg==
X-Gm-Gg: AZuq6aJ5XNE5yZ6qU/Ys+ypsI5N+42qANfoKF0bcrsvFRhnRG8XOfApVWGdwhVKG9g8
	Lz0IO7ehMGsbRjpax9lvlZx/aAuNG+YUhriaXuK9zG5xkKHF4F+Emgf7KA4KyxXd86suTae++JO
	9G/BdZwy5O/ukQGamVr6i6Gn2Fq9+dJzuAfhY3GiX3qhCKyhNfyPH7hWDX5YfFLZTjbLWlcQ9PX
	hGapyim4CJtkzGwL7c49DuS56AM+hRczK1k9A0c773Fq3ycvUJaecwxHL0UrbDHCZI+GqP+JpJz
	rlx6RUiIc5dzVY8bx1Tvoyrficq8xfRcDS/UMlVxuXwgXguXEPQ9yI56PZuo/kBUI+j0PNUGa+6
	/d7z4Boizwk9G+sMyyDqXH6aGV7VdgIhBGL1GZwlQOBjmWModbVHtG+niBU6ZXsqqz74cVxr2WP
	MXcGC3ZHXZx+uW3nUdVgVj48XB7VJ7GCvlXwE0zPeSCYZnMgmCcvwJbbkHqAhpPwpt5BSqMwPGl
	hvX4v3tNB34Ie9HJZcR9SL6/cvdT9gQ2MwRPa4am8llmscEMRjmwZZ2TWF2CCpk
X-Received: by 2002:a05:6000:3110:b0:431:48f:f78f with SMTP id ffacd0b85a97d-4356996f2f0mr12962136f8f.1.1768830877534;
        Mon, 19 Jan 2026 05:54:37 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921f6esm22810483f8f.4.2026.01.19.05.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 05:54:36 -0800 (PST)
Message-ID: <7ab5309d-8654-4fa8-9a1e-24b948bccba2@gmail.com>
Date: Mon, 19 Jan 2026 13:54:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 0/9] Add support for providers with large rx
 buffer
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Alexander Duyck <alexanderduyck@fb.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan
 <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>,
 Alok Tiwari <alok.a.tiwari@oracle.com>, Ziwei Xiao <ziweixiao@google.com>,
 John Fraker <jfraker@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Joe Damato <joe@dama.to>,
 Mina Almasry <almasrymina@google.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>,
 Samiullah Khawaja <skhawaja@google.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, David Wei
 <dw@davidwei.uk>, Yue Haibing <yuehaibing@huawei.com>,
 Haiyue Wang <haiyuewa@163.com>, Jens Axboe <axboe@kernel.dk>,
 Simon Horman <horms@kernel.org>, Vishwanath Seshagiri <vishs@fb.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, dtatulea@nvidia.com, kernel-team@meta.com,
 io-uring@vger.kernel.org
References: <cover.1768493907.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <cover.1768493907.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 17:11, Pavel Begunkov wrote:
> Note: it's net/ only bits and doesn't include changes, which shoulf be
> merged separately and are posted separately. The full branch for
> convenience is at [1], and the patch is here:

Looks like patchwork says the patches don't apply, but the branch
still merges well. Alternatively, I can rebase on top of net-next
and likely delay the final io_uring commit to one release after.

-- 
Pavel Begunkov


