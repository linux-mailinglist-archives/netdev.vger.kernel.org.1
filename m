Return-Path: <netdev+bounces-135946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3249599FDBD
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA53282AEC
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4800158861;
	Wed, 16 Oct 2024 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p9sncRBS"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA272261D
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040500; cv=none; b=pC33vOy9jnNpUs1u1AaD96itWXRHLpWYz7jHn1eRaDp4NAWo/CIPQZ415F9cnHkwWiazzQ9vWCDytLIC5UNUOADlv1cFvyJruQKOEBNviRV0X3LCMDXDJ9olD6ssO3dr1yikQXatgEnoEH3vs1KqUs+aG89ijBKb/Cd4pV5of1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040500; c=relaxed/simple;
	bh=UhJQ20276+wCQLVdmkTazIjsjskEUth8Bgtwk9llFLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ou8H3fkZTRrl90r5vXZcmJGk9A80Xncp1oNGu1cCBhirEWRfpp+saZbtLlfQkqC6ZgoQ1wbIyyMMBdpeGguTevflhYG96VZW++yvVJXJNMryMuInJJWhxCLAKi+BNvY+0WuQqEad0gmuCJpglmSgeB6D118mvemcgMINPVFZ2f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p9sncRBS; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b4767fab-9c61-49f0-8185-6445349ae30b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729040496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPdwG9pHPiWTE2rtTkLbAlDmqGXFuooyI1m6EGMgO0s=;
	b=p9sncRBSDIhBgnM8NZh2IyDcXXKtRjpGgU0dNMfqSXvJrptAsuPt9jBbDEACpqUzkporAk
	EEcLKecuKQGhZiGYEu3kg+2dlwaLmPpfY/dT/GRLwPidXNnM1m1nxjSnzsJH9wU0jscGVP
	A8qVIx1wKZ+kXIfzp0guN7mLr6up6+8=
Date: Tue, 15 Oct 2024 18:01:23 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 06/12] net-timestamp: introduce
 TS_SCHED_OPT_CB to generate dev xmit timestamp
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-7-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241012040651.95616-7-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/11/24 9:06 PM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Introduce BPF_SOCK_OPS_TS_SCHED_OPT_CB flag so that we can decide to
> print timestamps when the skb just passes the dev layer.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>   include/uapi/linux/bpf.h       |  5 +++++
>   net/core/skbuff.c              | 17 +++++++++++++++--
>   tools/include/uapi/linux/bpf.h |  5 +++++
>   3 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 157e139ed6fc..3cf3c9c896c7 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7019,6 +7019,11 @@ enum {
>   					 * by the kernel or the
>   					 * earlier bpf-progs.
>   					 */
> +	BPF_SOCK_OPS_TS_SCHED_OPT_CB,	/* Called when skb is passing through
> +					 * dev layer when SO_TIMESTAMPING
> +					 * feature is on. It indicates the
> +					 * recorded timestamp.
> +					 */
>   };
>   
>   /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 3a4110d0f983..16e7bdc1eacb 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5632,8 +5632,21 @@ static void bpf_skb_tstamp_tx_output(struct sock *sk, int tstype)
>   		return;
>   
>   	tp = tcp_sk(sk);
> -	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG))
> -		return;
> +	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG)) {
> +		struct timespec64 tstamp;
> +		u32 cb_flag;
> +
> +		switch (tstype) {
> +		case SCM_TSTAMP_SCHED:
> +			cb_flag = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
> +			break;
> +		default:
> +			return;
> +		}
> +
> +		tstamp = ktime_to_timespec64(ktime_get_real());
> +		tcp_call_bpf_2arg(sk, cb_flag, tstamp.tv_sec, tstamp.tv_nsec);

There is bpf_ktime_get_*() helper. The bpf prog can directly call the 
bpf_ktime_get_* helper and use whatever clock it sees fit instead of enforcing 
real clock here and doing an extra ktime_to_timespec64. Right now the 
bpf_ktime_get_*() does not have real clock which I think it can be added.

I think overall the tstamp reporting interface does not necessarily have to 
follow the socket API. The bpf prog is running in the kernel. It could pass 
other information to the bpf prog if it sees fit. e.g. the bpf prog could also 
get the original transmitted tcp skb if it is useful.

> +	}
>   }
>   
>   void __skb_tstamp_tx(struct sk_buff *orig_skb,
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 93853d9d4922..d60675e1a5a0 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7018,6 +7018,11 @@ enum {
>   					 * by the kernel or the
>   					 * earlier bpf-progs.
>   					 */
> +	BPF_SOCK_OPS_TS_SCHED_OPT_CB,	/* Called when skb is passing through
> +					 * dev layer when SO_TIMESTAMPING
> +					 * feature is on. It indicates the
> +					 * recorded timestamp.
> +					 */
>   };
>   
>   /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect


