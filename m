Return-Path: <netdev+bounces-231911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27854BFE952
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 01:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83161A02110
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 23:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631D0329C58;
	Wed, 22 Oct 2025 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LNYmkNCv"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88A435B133
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761175824; cv=none; b=hxjSCGkbhpwcZbrzzcXQzd/NZi+N+6rjZQQBK7XZoIZhCBQdfPcqD+Ky+r3TLNSoRx9tCnWqxG4GZ2zODd3RdkirryZ7Kd/+4tj67qGZB3Eg/2nqWgFFiUnmGnnWK0iI+Ouar+du5I2gkKX+oUH4bvQ9/r8q+lzYnh3nOztkhh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761175824; c=relaxed/simple;
	bh=LP9jECv1nZN9/lEv6/pgQwWQcXpg1pIVXaHbZLhUq2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fezRFbtvJM/PcvJgjPPus5fev3MdexlpNg+cKGLes4cL8QYa5DbwQ7ACmSznsc8KPYhcWBG1MS5zI+Zcd/k30EcpsZHUpAJe2ToiKqAQS7ofe7XnzWGWFrvsGWqch3weLHyieb/r0Q6xEgdT9rjcTNkpHBFGShAOKeEDpDLke/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LNYmkNCv; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7956ac25-f0ba-4d29-a07f-d1eaafb84acc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761175817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCPGOpdo5Nmk/Kszs6n64vYNNo8tBBkaZBLbzyLFFic=;
	b=LNYmkNCvOLLw9/sHIK7spnXjs7KwO+qClOrYCTnvYJS8QA48bKZ3uzfFncriCDLHm7ztjd
	ctjFUgI5EzbHBWpx5XBQvnI8+81zfU17+CTZ5fH7SzBv8nD6p8OjVNIXFVTd9QJd1iuFe2
	BrD66XJz/1E2i3hhIP4KkOAQz7uHtCo=
Date: Wed, 22 Oct 2025 16:30:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 10/15] selftests/bpf: Dump skb metadata on
 verification failure
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, kernel-team@cloudflare.com
References: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
 <20251019-skb-meta-rx-path-v2-10-f9a58f3eb6d6@cloudflare.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251019-skb-meta-rx-path-v2-10-f9a58f3eb6d6@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/19/25 5:45 AM, Jakub Sitnicki wrote:
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> index 93a1fbe6a4fd..a3de37942fa4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> @@ -171,6 +171,25 @@ static int write_test_packet(int tap_fd)
>   	return 0;
>   }
>   
> +enum {
> +	BPF_STDOUT = 1,
> +	BPF_STDERR = 2,

There is BPF_STREAM_STDERR in uapi/bpf.h
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
> index 11288b20f56c..33480bcb8ec1 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
> @@ -18,6 +18,11 @@
>    * TC program then verifies if the passed metadata is correct.
>    */
>   
> +enum {
> +	BPF_STDOUT = 1,
> +	BPF_STDERR = 2,
> +};
> +

