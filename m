Return-Path: <netdev+bounces-210685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 378DBB1448D
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 01:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8397F3AFBFB
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 23:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D81230981;
	Mon, 28 Jul 2025 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d3t6tgEu"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B980319A2A3
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753744092; cv=none; b=MwgNYInQGTM+As6BCQKVob1xVOnaFChotRN6qcRU5WWWANraGEU6xwLpHu87E+mW3fzMo3HRlq8ec2AMQsVCpuXvZo45mtE28EZIO6H7ihNGK2KzHc28dwI7Ao2TrBU15BWQVsFfGA7wPs/vSha2jRQVlpGA/vU9nnhxF8iEluQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753744092; c=relaxed/simple;
	bh=3KwB3D7apCTLi2B/PzN4GcMBuEZIOjbqWsj72q0Qjjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OZIlJBzOTRbAKTuZcQgafX1vd6DpYfKIfo2DZ0LG8QvgH7BFzkmEjmvhQ94Wtg+ysSM8H4z7JGxbWU7CzuzZZDmaEM/Da8a15KVmuZLDAGbMf6pYqAde95JJaKBNC2GxQki/LiU1+D3C3aWS17sd1z94wdLMcjY7sKVEdVgWd8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d3t6tgEu; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <66f4a64c-a6fa-478b-bc79-495a9def10c8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753744077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSRV8xtJBo0Hs5hGzkNd3Im3++PoIWb28AxiDkWp4uQ=;
	b=d3t6tgEuSRVO+u6fMP9M/cqRcrdXmE2f5N3tRdjNreZtyotJi7g1cE4j1Sd8K2LleyGcq9
	oQhmloe5TM27fMjC0cO1OjKgqUFQABhBFN3CJXft4j51kagozyHSxiInd++e3UwJ/SsCed
	ErT0w+nEjWAuzHTgk5EAq1hxR6x2GHA=
Date: Mon, 28 Jul 2025 16:07:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/4] bpf: crypto: Use the correct destructor
 kfunc type
Content-Language: en-GB
To: Sami Tolvanen <samitolvanen@google.com>, bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250728202656.559071-6-samitolvanen@google.com>
 <20250728202656.559071-7-samitolvanen@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250728202656.559071-7-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/28/25 1:26 PM, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG enabled, the kernel strictly enforces that
> indirect function calls use a function pointer type that matches the
> target function. I ran into the following type mismatch when running
> BPF self-tests:
>
>    CFI failure at bpf_obj_free_fields+0x190/0x238 (target:
>      bpf_crypto_ctx_release+0x0/0x94; expected type: 0xa488ebfc)
>    Internal error: Oops - CFI: 00000000f2008228 [#1]  SMP
>    ...
>
> As bpf_crypto_ctx_release() is also used in BPF programs and using
> a void pointer as the argument would make the verifier unhappy, add
> a simple stub function with the correct type and register it as the
> destructor kfunc instead.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


