Return-Path: <netdev+bounces-50965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1BF7F8590
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 22:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C90CCB213D4
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 21:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7163BB3A;
	Fri, 24 Nov 2023 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWXvRtEu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B147E28DB8
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 21:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA25C433C7;
	Fri, 24 Nov 2023 21:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700862263;
	bh=wKpJU85+z5ti8NPiipuZLx3lXDJJ0hWM9oAvlJ9VuJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oWXvRtEurXEtLzYXfIcw86epniNt3GJp6VypjuInduAEsShP4jccpaX9De676XYG0
	 0VKn+RI+zqEDIS9YW+YtX5DbAcn3OTKR+9PHzGEGl4G5k0w4kQ/qvJCkUWLbAGDdi8
	 CTrQYHNsE2BdxvEiVIDTpDdaZRK+zs0h5yCRHC8CpIn6eBpU+yuXor5OtD/Uf+A20x
	 FNic7D4ZLHougQlImtadbGn1Z5y0O16rE67B37pJyVMu5k2xdu6T2uiYw3wADxEAkl
	 KyZjzEJ/Zv7XCnW3u0AlrliLnLfb3dIiPERkSpRMcGqMZ09cH20mbegGLxx6r8v45D
	 mFc/fEjXllP+w==
Date: Fri, 24 Nov 2023 21:44:18 +0000
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 7/8] tcp: Factorise cookie-independent fields
 initialisation in cookie_v[46]_check().
Message-ID: <20231124214418.GX50352@kernel.org>
References: <20231123012521.62841-1-kuniyu@amazon.com>
 <20231123012521.62841-8-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123012521.62841-8-kuniyu@amazon.com>

On Wed, Nov 22, 2023 at 05:25:20PM -0800, Kuniyuki Iwashima wrote:
> We will support arbitrary SYN Cookie with BPF, and then some reqsk fields
> are initialised in kfunc, and others are done in cookie_v[46]_check().
> 
> This patch factorises the common part as cookie_tcp_reqsk_init() and
> calls it in cookie_tcp_reqsk_alloc() to minimise the discrepancy between
> cookie_v[46]_check().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv4/syncookies.c | 69 ++++++++++++++++++++++++-------------------
>  net/ipv6/syncookies.c | 14 ---------
>  2 files changed, 38 insertions(+), 45 deletions(-)
> 
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 1e3783c97e28..9bca1c026525 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -285,10 +285,44 @@ bool cookie_ecn_ok(const struct tcp_options_received *tcp_opt,
>  }
>  EXPORT_SYMBOL(cookie_ecn_ok);
>  
> +static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
> +				 struct request_sock *req)
> +{
> +	struct inet_request_sock *ireq = inet_rsk(req);
> +	struct tcp_request_sock *treq = tcp_rsk(req);
> +	const struct tcphdr *th = tcp_hdr(skb);
> +
> +	req->num_retrans = 0;
> +
> +	ireq->ir_num = ntohs(th->dest);
> +	ireq->ir_rmt_port = th->source;
> +	ireq->ir_iif = inet_request_bound_dev_if(sk, skb);
> +	ireq->ir_mark = inet_request_mark(sk, skb);
> +
> +	if (IS_ENABLED(CONFIG_SMC))
> +		ireq->smc_ok = 0;
> +
> +	treq->snt_synack = 0;
> +	treq->tfo_listener = false;
> +	treq->txhash = net_tx_rndhash();
> +	treq->rcv_isn = ntohl(th->seq) - 1;
> +	treq->snt_isn = ntohl(th->ack_seq) - 1;
> +	treq->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
> +	treq->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;

Hi Iwashima-san,

The line above seems to be duplicated.

Other than that, this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


> +	treq->req_usec_ts = false;
> +
> +#if IS_ENABLED(CONFIG_MPTCP)
> +	treq->is_mptcp = sk_is_mptcp(sk);
> +	if (treq->is_mptcp)
> +		return mptcp_subflow_init_cookie_req(req, sk, skb);
> +#endif
> +
> +	return 0;
> +}

...

