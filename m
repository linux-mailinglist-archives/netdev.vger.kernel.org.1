Return-Path: <netdev+bounces-63344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C5282C5AA
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 19:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F22B234FE
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 18:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485D615AC6;
	Fri, 12 Jan 2024 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZozLVC2m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D368156DF
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 18:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEEFC433F1;
	Fri, 12 Jan 2024 18:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705085923;
	bh=cB29rpJs3arn2ac2MbLETGx3Oj72/OPYTcmXnDj9h1Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ZozLVC2mzIzpJhZQFd+/mAVKgXXEXx3n/DIbnboLt8if1RboHK47QqJnzuCBBJEQp
	 qhwNCkfPVuxQgdOuN4SAkRzNCKYzchROa/oBixbkJ4PxEquQ3EZ/DjvmtKrf5JF5LS
	 n+qiNVzGUp8hsfr1qUR2us4v5J3ZjXzV8N68x6P8o+zayFgNVcaRT4z6uTiXWeP9Su
	 mB8SxPQmLKgJrqTsofU3WB0G1Q5v7EJAr0wQtH0hp1rg4Xx78WsV3qqHOPtqbgBeYA
	 oDi7C1YAKeTnMggrp70RuWENNfGm3pow+lUMOCjbAM5A4LAVet1DrLUwzk7MoNlQiR
	 Yx51U2P7xl4vw==
Date: Fri, 12 Jan 2024 10:58:42 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Eric Dumazet <edumazet@google.com>
cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
    Geliang Tang <geliang.tang@linux.dev>, Florian Westphal <fw@strlen.de>, 
    netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net 5/5] mptcp: refine opt_mp_capable determination
In-Reply-To: <20240111194917.4044654-6-edumazet@google.com>
Message-ID: <2417961c-cb35-2dec-ce94-884afd636f24@kernel.org>
References: <20240111194917.4044654-1-edumazet@google.com> <20240111194917.4044654-6-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 11 Jan 2024, Eric Dumazet wrote:

> OPTIONS_MPTCP_MPC is a combination of three flags.
>
> It would be better to be strict about testing what
> flag is expected, at least for code readability.
>
> mptcp_parse_option() already makes the distinction.
>
> - subflow_check_req() should use OPTION_MPTCP_MPC_SYN.
>
> - mptcp_subflow_init_cookie_req() should use OPTION_MPTCP_MPC_ACK.
>
> - subflow_finish_connect() should use OPTION_MPTCP_MPC_SYNACK
>
> - subflow_syn_recv_sock should use OPTION_MPTCP_MPC_ACK
>

Should this be applied to net-next?

If intended for -net, I think

Fixes: 74c7dfbee3e1 ("mptcp: consolidate in_opt sub-options fields in a bitmask")

is the appropriate commit to reference.


- Mat


> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> net/mptcp/subflow.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 13039ac8d1ab641fb9b22b621ac011e6a7bc9e37..1117d1e84274a5ea1ede990566f67c0073fd86a0 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -157,7 +157,7 @@ static int subflow_check_req(struct request_sock *req,
>
> 	mptcp_get_options(skb, &mp_opt);
>
> -	opt_mp_capable = !!(mp_opt.suboptions & OPTIONS_MPTCP_MPC);
> +	opt_mp_capable = !!(mp_opt.suboptions & OPTION_MPTCP_MPC_SYN);
> 	opt_mp_join = !!(mp_opt.suboptions & OPTION_MPTCP_MPJ_SYN);
> 	if (opt_mp_capable) {
> 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVE);
> @@ -254,7 +254,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
> 	subflow_init_req(req, sk_listener);
> 	mptcp_get_options(skb, &mp_opt);
>
> -	opt_mp_capable = !!(mp_opt.suboptions & OPTIONS_MPTCP_MPC);
> +	opt_mp_capable = !!(mp_opt.suboptions & OPTION_MPTCP_MPC_ACK);
> 	opt_mp_join = !!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK);
> 	if (opt_mp_capable && opt_mp_join)
> 		return -EINVAL;
> @@ -486,7 +486,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
>
> 	mptcp_get_options(skb, &mp_opt);
> 	if (subflow->request_mptcp) {
> -		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPC)) {
> +		if (!(mp_opt.suboptions & OPTION_MPTCP_MPC_SYNACK)) {
> 			MPTCP_INC_STATS(sock_net(sk),
> 					MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
> 			mptcp_do_fallback(sk);
> @@ -783,7 +783,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
> 		 * options.
> 		 */
> 		mptcp_get_options(skb, &mp_opt);
> -		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPC))
> +		if (!(mp_opt.suboptions & OPTION_MPTCP_MPC_ACK))
> 			fallback = true;
>
> 	} else if (subflow_req->mp_join) {
> -- 
> 2.43.0.275.g3460e3d667-goog
>
>

