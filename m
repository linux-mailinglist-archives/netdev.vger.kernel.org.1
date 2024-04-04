Return-Path: <netdev+bounces-85014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7A2898F97
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 22:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693561F28D61
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 20:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF11138494;
	Thu,  4 Apr 2024 20:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBwzypIY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367B18592E;
	Thu,  4 Apr 2024 20:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712262782; cv=none; b=jxY/54jpiqHr2FUG+zyyZ/yN/HdizzpLbBDE2etWqHz1gScpyQvBQrUH5GNOyLsx7Me9yZbBt54O4vrY3Eu7u8TEoDa4hbypL7FhzfuNoQwRQ8MPPtwu8zbhYA/gievt2KSyPaAuEUm/J4xCpGabzuG+J/3pelWWy3pwG/VXTaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712262782; c=relaxed/simple;
	bh=5O8+BKNqKibpFQk3vzrgXJN73S3pYdFvvcUjNSf12rE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=V9zI2KFutbeano/47aMThE2fn5f/NvOiV1QvwaQpnPL+O2wiprxnFb4I/XQ8+ynZFIpCn+S0zjPAZZGUNejKmFMlY2gU2LjqxjHnkq6734p0IWIDL7sDuncAKA+1FXFndVxy/rgkW9GFRNrqo05uGlxAix3oUtOlobj3xd8Wch8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBwzypIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708EDC433F1;
	Thu,  4 Apr 2024 20:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712262781;
	bh=5O8+BKNqKibpFQk3vzrgXJN73S3pYdFvvcUjNSf12rE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=NBwzypIYjr8+Y4tKlMF6uf04DeteGSceef4HGtLT6SiUEFOhn2RyJejkaWU5vfK3v
	 ktt5jj+Yxm5yaOf1NnWKh7B//pLpAD61s/FlHAE7akYNDCeLwxDZReWm3PvJEpLjIn
	 vQ+yZLON5gPnhqBmbMv8jeRog4G43LlmveuWhVCGYE+fEnpqGfqYe6R30L/NyUWjLx
	 Jp0+xjWsSKwELhXfuc+IWeAMVMGaMmcEN6qv2fi6PekqYMXgpQ15zyPn4Kg1XfXOIw
	 4wXIIW9/5g3BAD/805hUxkwp6mBLyOCnXHwCOYKNo6IYAJoaaUC7pqNCagiHBA1Z3e
	 /iXa9m2iX3h5Q==
Date: Thu, 4 Apr 2024 13:33:00 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
cc: edumazet@google.com, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
    rostedt@goodmis.org, kuba@kernel.org, pabeni@redhat.com, 
    davem@davemloft.net, matttbe@kernel.org, geliang@kernel.org, 
    mptcp@lists.linux.dev, netdev@vger.kernel.org, 
    linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2 5/6] mptcp: support rstreason for passive
 reset
In-Reply-To: <20240404072047.11490-6-kerneljasonxing@gmail.com>
Message-ID: <d8fe5d37-e317-59a5-9a01-d7c6ae43be7b@kernel.org>
References: <20240404072047.11490-1-kerneljasonxing@gmail.com> <20240404072047.11490-6-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 4 Apr 2024, Jason Xing wrote:

> From: Jason Xing <kernelxing@tencent.com>
>
> It relys on what reset options in MPTCP does as rfc8684 says. Reusing
> this logic can save us much energy. This patch replaces all the prior
> NOT_SPECIFIED reasons.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> net/mptcp/subflow.c | 26 ++++++++++++++++++++------
> 1 file changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index a68d5d0f3e2a..24668d3020aa 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -304,7 +304,10 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
>
> 	dst_release(dst);
> 	if (!req->syncookie)
> -		tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
> +		/* According to RFC 8684, 3.2. Starting a New Subflow,
> +		 * we should use an "MPTCP specific error" reason code.
> +		 */
> +		tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_MPTCP_RST_EMPTCP);

Hi Jason -

In this case, the MPTCP reset reason is set in subflow_check_req(). Looks 
like it uses EMPTCP but that isn't guaranteed to stay the same. I think it 
would be better to extract the reset reason from the skb extension or the 
subflow context "reset_reason" field.


> 	return NULL;
> }
>
> @@ -371,7 +374,10 @@ static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
>
> 	dst_release(dst);
> 	if (!req->syncookie)
> -		tcp6_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
> +		/* According to RFC 8684, 3.2. Starting a New Subflow,
> +		 * we should use an "MPTCP specific error" reason code.
> +		 */
> +		tcp6_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_MPTCP_RST_EMPTCP);

Same issue here.

> 	return NULL;
> }
> #endif
> @@ -778,6 +784,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
> 	bool fallback, fallback_is_fatal;
> 	struct mptcp_sock *owner;
> 	struct sock *child;
> +	int reason;
>
> 	pr_debug("listener=%p, req=%p, conn=%p", listener, req, listener->conn);
>
> @@ -833,7 +840,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
> 		 */
> 		if (!ctx || fallback) {
> 			if (fallback_is_fatal) {
> -				subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
> +				reason = MPTCP_RST_EMPTCP;
> +				subflow_add_reset_reason(skb, reason);
> 				goto dispose_child;
> 			}
> 			goto fallback;
> @@ -861,7 +869,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
> 		} else if (ctx->mp_join) {
> 			owner = subflow_req->msk;
> 			if (!owner) {
> -				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
> +				reason = MPTCP_RST_EPROHIBIT;
> +				subflow_add_reset_reason(skb, reason);
> 				goto dispose_child;
> 			}
>
> @@ -875,13 +884,18 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
> 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
> 				if (!mptcp_pm_sport_in_anno_list(owner, sk)) {
> 					SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTACKRX);
> +					reason = MPTCP_RST_EUNSPEC;

I think the MPTCP code here should have been using MPTCP_RST_EPROHIBIT.


- Mat

> 					goto dispose_child;
> 				}
> 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINPORTACKRX);
> 			}
>
> -			if (!mptcp_finish_join(child))
> +			if (!mptcp_finish_join(child)) {
> +				struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> +
> +				reason = subflow->reset_reason;
> 				goto dispose_child;
> +			}
>
> 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKRX);
> 			tcp_rsk(req)->drop_req = true;
> @@ -901,7 +915,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
> 	tcp_rsk(req)->drop_req = true;
> 	inet_csk_prepare_for_destroy_sock(child);
> 	tcp_done(child);
> -	req->rsk_ops->send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
> +	req->rsk_ops->send_reset(sk, skb, convert_mptcp_reason(reason));
>
> 	/* The last child reference will be released by the caller */
> 	return child;
> -- 
> 2.37.3
>
>
>

