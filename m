Return-Path: <netdev+bounces-128186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5939786A2
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 19:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E048282D54
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB77823C3;
	Fri, 13 Sep 2024 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yk6uccGY"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B601EEE4;
	Fri, 13 Sep 2024 17:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726248266; cv=none; b=eiZRiXLjvxikoYyrvwx9YewrJmswrlsBwyLIpqzQWAB5Mf3Zxuz1lsyS/jWfMLbd5CTQmof06xfVyb84+If0t9Nyq10vK9phk4aNB+vQrryABqNuYF/di+UN4oUzuUjNlpzP/r9pGzeRf3k1e6iwmfPsLMooSOoKkw9rIvmiDVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726248266; c=relaxed/simple;
	bh=sllu2LtMOhcdH/FD8wUSmEhJWjy45HTpNiNXgVAUspU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6d9rI4buhMyghtEFb88LzzWRx9F2PcRgSxcJMe2F2jElJK0OA24kGShvjrV9c4AOranFtFORK1KynlSBuB+oJ9aYbvjlI56KQRMKh2ouOyUAxw/xeOoBigF/682Cwiy+ik6lHozrKC6LS1+OEsdl88taFwjudnptWVj+2M9ueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yk6uccGY; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e1435276-d106-411f-9c0f-c98abd2bce08@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726248260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eUlMI/VUG0tbtBW/0vyoiiaa/eRH5yrftzcJDI7pfa4=;
	b=Yk6uccGYN6b+Y8rna0u6tXJc1FyRwl3xoyTZX3NS+dAPIOwIqURDELqvdltb8saVILHLKL
	7PBy7oqaLuG2UqwAsSfCyCvkQrO2/FVD+0bJ2DQDaFpSTgZdACLrpjp96GU8e8GHJWLCxP
	bVc3vdUJ6gUo+6M8+OEDHunEIIMXq48=
Date: Fri, 13 Sep 2024 10:24:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] netkit: Assign missing bpf_net_context
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, bpf@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 vadim.fedorenko@linux.dev, andrii@kernel.org,
 "open list:BPF [NETKIT] (BPF-programmable network device)"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240912155620.1334587-1-leitao@debian.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240912155620.1334587-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/12/24 8:56 AM, Breno Leitao wrote:
> During the introduction of struct bpf_net_context handling for
> XDP-redirect, the netkit driver has been missed, which also requires it
> because NETKIT_REDIRECT invokes skb_do_redirect() which is accessing the
> per-CPU variables. Otherwise we see the following crash:
> 
> 	BUG: kernel NULL pointer dereference, address: 0000000000000038
> 	bpf_redirect()
> 	netkit_xmit()
> 	dev_hard_start_xmit()
> 
> Set the bpf_net_context before invoking netkit_xmit() program within the
> netkit driver.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


