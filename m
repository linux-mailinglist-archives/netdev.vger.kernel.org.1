Return-Path: <netdev+bounces-235643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79815C336FC
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 01:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 26F5034E3A7
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 00:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D8935940;
	Wed,  5 Nov 2025 00:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WDJBZS4f"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACD0125A9
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 00:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762301052; cv=none; b=h9N/PC5nxwYYZXDtZEoqcrxGx3qaaDirrJB7hOE3H21Y+JwGjwsOYWpfVhuSi/GwFwj5otXdSDZamVAlGIWuJgRnv5/f+8a6a1HQmK5REjKbvEOf2wjv4VjaZy+OdNKxaRtpZyW08T1bBszZ2inKnGSqNccKCh1dI4gwXJc0J1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762301052; c=relaxed/simple;
	bh=7V6Zs6KlpvVx06C2QRyOZxZDFwMkzToHmlqpI2nLUmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQlDZLIQfeB9y9kp05no65n7//b/PikWx2fid1PEIh0O20ugNdx0NS7u2ALVt/MAP8dWtQWWTO+MaIc9A0MZXmV40OvuwcrYcEu3aDl/mt33NmiAoMev+LyNrouD1HSOk/VHUJsz0llMu77v4GYlAWcbdQL2yy4QwcvgJWlRbpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WDJBZS4f; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4450b847-6b31-46f2-bc2d-a8b3197d15c7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762301038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kbzwZkmSNMO2Gp4Ml8hBQBywRuiXEm1FnTFeSleACss=;
	b=WDJBZS4fs54De4KH95smX8kuT3fCqEx0QJcku5KDl1IN27ZjxsaAb6GGEu9QPEPhRqvAnR
	27VYaBIfzak3LR96DLz728A3b28llmh9ycLc9h+rzrUV2j50v5KKy7IMNmA+9lCVGkGWll
	Schtw+wUle4V75kxhoy8jVjCfKN5hlk=
Date: Tue, 4 Nov 2025 16:03:46 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/3] net/smc: bpf: Introduce generic hook for
 handshake flow
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 pabeni@redhat.com, song@kernel.org, sdf@google.com, haoluo@google.com,
 yhs@fb.com, edumazet@google.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, jolsa@kernel.org, mjambigi@linux.ibm.com,
 wenjia@linux.ibm.com, wintera@linux.ibm.com, dust.li@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, bpf@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 sidraya@linux.ibm.com, jaka@linux.ibm.com
References: <20251103073124.43077-1-alibuda@linux.alibaba.com>
 <20251103073124.43077-3-alibuda@linux.alibaba.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251103073124.43077-3-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/2/25 11:31 PM, D. Wythe wrote:
> +#if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
> +#define smc_call_hsbpf(init_val, sk, func, ...) ({		\
> +	typeof(init_val) __ret = (init_val);			\
> +	struct smc_hs_ctrl *ctrl;				\
> +	rcu_read_lock();					\
> +	ctrl = rcu_dereference(sock_net(sk)->smc.hs_ctrl);	\

The smc_hs_ctrl (and its ops) is called from the netns, so the 
bpf_struct_ops is attached to a netns. Attaching bpf_struct_ops to a 
netns has not been done before. More on this later.

> +	if (ctrl && ctrl->func)					\
> +		__ret = ctrl->func(__VA_ARGS__);		\
> +	rcu_read_unlock();					\
> +	__ret;							\
> +})
> +#else
> +#define smc_call_hsbpf(init_val, sk, ...)  ({ (void)(sk); (init_val); })
> +#endif /* CONFIG_SMC_HS_CTRL_BPF */
> +
>   #endif	/* _SMC_H */
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 7f5df7a71f62..1a3234729a29 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -40,6 +40,7 @@
>   #include <net/tcp.h>
>   #include <net/tcp_ecn.h>
>   #include <net/mptcp.h>
> +#include <net/smc.h>
>   #include <net/proto_memory.h>
>   #include <net/psp.h>
>   
> @@ -802,34 +803,41 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>   	mptcp_options_write(th, ptr, tp, opts);
>   }
>   
> -static void smc_set_option(const struct tcp_sock *tp,
> +static void smc_set_option(struct tcp_sock *tp,
>   			   struct tcp_out_options *opts,
>   			   unsigned int *remaining)
>   {
>   #if IS_ENABLED(CONFIG_SMC)
> -	if (static_branch_unlikely(&tcp_have_smc)) {
> -		if (tp->syn_smc) {
> -			if (*remaining >= TCPOLEN_EXP_SMC_BASE_ALIGNED) {
> -				opts->options |= OPTION_SMC;
> -				*remaining -= TCPOLEN_EXP_SMC_BASE_ALIGNED;
> -			}
> +	struct sock *sk = &tp->inet_conn.icsk_inet.sk;

the sk is tp ...

> +
> +	if (static_branch_unlikely(&tcp_have_smc) && tp->syn_smc) {
> +		tp->syn_smc = !!smc_call_hsbpf(1, sk, syn_option, tp);

... so just pass tp instead of passing both sk and tp?

[ ... ]

> +static int smc_bpf_hs_ctrl_init(struct btf *btf) { return 0; }
> +
> +static int smc_bpf_hs_ctrl_reg(void *kdata, struct bpf_link *link)

More on attaching to netns. There is discussion on how to attach a 
bpf_struct_ops to a particular cgroup in a link. I think the link should 
be able to attach a bpf_struct_ops to a particular netns also.

I would suggest to reject link now. Later, link support can be added to 
attach to a particular netns. This will be the last non-link-only 
bpf_struct_ops addition, considering the blast radius is limited on 
smc_hs_ctrl and the smc effort was started a while ago. I could have 
missed things here. Other experts could chime in.

	if (link)
		return -EOPNOTSUPP;


pw-bot: cr

> +{
> +	return smc_hs_ctrl_reg(kdata);
> +}
> +
> +static void smc_bpf_hs_ctrl_unreg(void *kdata, struct bpf_link *link)
> +{
> +	smc_hs_ctrl_unreg(kdata);
> +}
> +

