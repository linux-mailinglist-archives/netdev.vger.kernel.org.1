Return-Path: <netdev+bounces-220949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ABFB499E7
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 21:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD86F1BC2C01
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 19:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162C927F01D;
	Mon,  8 Sep 2025 19:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E6Guut2t"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4094C1A2381
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359692; cv=none; b=AOjBaaKB9y9urRAqYQX3g+dmLvMMAwWiG2k19viGNsCysGTXwhcq30z5hPQAvvBrKMjj9xzf2AqI00dFGcKL69kF3IXYibeIP8TeCgjzM/Ih/4AGq01NAisspvCujp12hvWR0NAvRWyDNvrS4PDZDfhbPbkNM0Ole68XwJJ+Zb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359692; c=relaxed/simple;
	bh=j6CFg6JMk/FjRGTJ06rQZUaFLUuCV1sA7BeJ+RLKj4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMbMy7flQWpzK3hmvw0VT+2jEd8DuL1TIMHKIg5nf6DBOiLp59dR11ZN5KvTmooOS0c41O/jvBTp7DXoka3khfAI4Lz+Izui9JFlJ3g5EKKcoyFvOwextzcUSqvNwGvaVB6fVbKDn+MyOhxDFauwpjXgdGTMz5Td2xjBi2qkz4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E6Guut2t; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <54cddbbd-1c0d-467a-af49-bb6484a62f26@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757359677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hYc7idK35SgQs+VEwnHBmuMBPBHhNNcDoxzAnRzN1B8=;
	b=E6Guut2tPB/ns7zM3S33BAXu7Ed/JuDyePtmd3LUJzTIgCp508bkQGEWbqhta56jEaEoZv
	tIWer+kva8JyqWFJYBwzc+tqMO1z+8BRFnSXIbLaTmTkXt0E3ABQZnfoFXiYU2QHjI7bCI
	lA5xA1ZVjMifWgiq4baxcYTFLm2cqM0=
Date: Mon, 8 Sep 2025 12:27:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/7] bpf: Support pulling non-linear xdp data
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 kuba@kernel.org, stfomichev@gmail.com, martin.lau@kernel.org,
 mohsin.bashr@gmail.com, noren@nvidia.com, dtatulea@nvidia.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 maciej.fijalkowski@intel.com, kernel-team@meta.com
References: <20250905173352.3759457-1-ameryhung@gmail.com>
 <20250905173352.3759457-4-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250905173352.3759457-4-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/5/25 10:33 AM, Amery Hung wrote:
> An unused argument, flags is reserved for future extension (e.g.,
> tossing the data instead of copying it to the linear data area).

> +__bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len, u64 flags)

I was thinking the flag may be needed to avoid copy. I think we have recently 
concluded that bpf_xdp_adjust_head can support shrink on multi buf also. If it 
is the case, it is probably better to keep a similar api as the 
bpf_skb_pull_data which does not have the flags argument.


