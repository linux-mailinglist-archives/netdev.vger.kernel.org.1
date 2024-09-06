Return-Path: <netdev+bounces-125751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C181796E725
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 03:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777981F219DC
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 01:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364FD1799F;
	Fri,  6 Sep 2024 01:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v9pEJT8m"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5535E17BA3
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 01:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725585239; cv=none; b=dkm2nnS/QbtTBMdtyLVR/e1CjLloIYDI2wdh6EPGgQpX5QTnwSehSNQUtbDu8AorvSLtaWPoPpKwDtlz8EsgYI7SMjnP9T93xPjG6SpQimUUPmosdRsksuIGd3KS9DSfh8cConoOLMnkEXLzNEH791C+dI1w5+9NeTkKE9HzC6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725585239; c=relaxed/simple;
	bh=+40/PKcAluOFhthFyit1izNfoYiHHdYw1abpmwwERqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ErNoWlQNjcHHE6B+yzJqWbef5Q41nO0Gl3Z6LzrI9qsci50mr/iSpVlRG8Vba3ml9800kJIlk0xNggYOnWt1o9iFZcyFNrXFredTcxfzad0OO54KANVGeqsTXgo/q0mrkFDtooaW1sL/EExtUiqrH/4t3YKEqJxCOo0FTU0CZ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v9pEJT8m; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8ee6b7d3-71b7-4b66-aa49-26421d9c5b78@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725585235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LzUdF+fiRFn6RgwFUtIzdarKamkAFDCW16qaVIlXx38=;
	b=v9pEJT8msZi7N912djrtrxNn4xWjlap344gkT8Wy055Hw6Pmv1X9rRH20/faNByHSOHyZT
	s2YxQ00sm6vAKLY6OGuZ6zdpUysrVHKm72pllzrRu/IO128qNXTh+h9lOWK9n3LIlsBBgA
	vM+/DVdzTsJ51xWR+JVSoKqn8xrWvFU=
Date: Thu, 5 Sep 2024 18:13:43 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 4/5] bpf: Allow bpf_dynptr_from_skb() for
 tp_btf
To: Philo Lu <lulie@linux.alibaba.com>
Cc: bpf@vger.kernel.org, edumazet@google.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com, shuah@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 thinker.li@gmail.com, juntong.deng@outlook.com, jrife@google.com,
 alan.maguire@oracle.com, davemarchevsky@fb.com, dxu@dxuuu.xyz,
 vmalik@redhat.com, cupertino.miranda@oracle.com, mattbobrowski@google.com,
 xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20240905075622.66819-1-lulie@linux.alibaba.com>
 <20240905075622.66819-5-lulie@linux.alibaba.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240905075622.66819-5-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/5/24 12:56 AM, Philo Lu wrote:
> Making tp_btf able to use bpf_dynptr_from_skb(), which is useful for skb
> parsing, especially for non-linear paged skb data. This is achieved by
> adding KF_TRUSTED_ARGS flag to bpf_dynptr_from_skb and registering it
> for TRACING progs. With KF_TRUSTED_ARGS, args from fentry/fexit are
> excluded, so that unsafe progs like fexit/__kfree_skb are not allowed.
> 
> We also need the skb dynptr to be read-only in tp_btf. Because
> may_access_direct_pkt_data() returns false by default when checking
> bpf_dynptr_from_skb, there is no need to add BPF_PROG_TYPE_TRACING to it
> explicitly.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


