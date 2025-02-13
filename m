Return-Path: <netdev+bounces-166202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A589FA34ECC
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 20:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D423189088D
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 19:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41F32661BC;
	Thu, 13 Feb 2025 19:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZVqHzfis"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E006324BC0F
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476501; cv=none; b=El1UfV/VkAYozKd5XN2XR/B3U1iMcTJjPLm9XwLti0vBK5/oWNQYlwjrKK/NTaaldKyw8MiqNiRvONtt9/+RdNqumXycERnoHGBpUGCFRMCU196hOstxb6oYtk8x5cYTH4/Ex/p9b5Za9Gvf2jD/MVs6FtEraZHGEnhe4dpi1eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476501; c=relaxed/simple;
	bh=gkhsxtf9qrRF8WXSpi9+XQph/BdpyHFwb9XUpfJkdek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGiPsxeeZKweb4SAEL04EVN19y/Huq+58FPhZ+KhpJqHoT1vT/tLDHEULcMQ78M+xFdtKgBtBwt1dYQoUH2oaDIVb6j2bWjkZoT/iwGA+70nQA1jc8rPzeb3NpfNqvCcBPNaFuFl534IrDUikkOFFYnffdYFZSHIbdmmXYqn1NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZVqHzfis; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0bee571a-927d-4042-9e89-53bf695ec054@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739476487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kq5wfnoFKln0Y2OzD3jZdnjsfuZI5Yaaccu5d5315Sk=;
	b=ZVqHzfisqjB1D8ffEBfdpMuxGU2JY0k8Mfay+2bURk6tYJYzAhwkU3Pse7G/OeAolFuDxx
	/qXtphDImXClZ9pzJ90Kfx7YO3fFUGh+B/V+ShYfAs95Tmn8fmU+hzuMOFrq5/snHcVd6D
	nZepCTZJYU4KfJHLzk14IZq6+RvmS8M=
Date: Thu, 13 Feb 2025 11:54:41 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 01/19] bpf: Make every prog keep a copy of
 ctx_arg_info
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org,
 kuba@kernel.org, edumazet@google.com, xiyou.wangcong@gmail.com,
 cong.wang@bytedance.com, jhs@mojatatu.com, sinquersw@gmail.com,
 toke@redhat.com, jiri@resnulli.us, stfomichev@gmail.com,
 ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn,
 yepeilin.cs@gmail.com, kernel-team@meta.com
References: <20250210174336.2024258-1-ameryhung@gmail.com>
 <20250210174336.2024258-2-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250210174336.2024258-2-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/10/25 9:43 AM, Amery Hung wrote:
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9971c03adfd5..a41ba019780f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -22377,6 +22377,18 @@ static void print_verification_stats(struct bpf_verifier_env *env)
>   		env->peak_states, env->longest_mark_read_walk);
>   }
>   
> +int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
> +			       const struct bpf_ctx_arg_aux *info, u32 cnt)
> +{
> +	prog->aux->ctx_arg_info = kcalloc(cnt, sizeof(*info), GFP_KERNEL);

Missing a kfree.

> +	if (!prog->aux->ctx_arg_info)
> +		return -ENOMEM;
> +
> +	memcpy(prog->aux->ctx_arg_info, info, sizeof(*info) * cnt);
> +	prog->aux->ctx_arg_info_size = cnt;
> +	return 0;
> +}
> +

