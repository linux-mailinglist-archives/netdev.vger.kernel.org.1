Return-Path: <netdev+bounces-139071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33E29AFF1E
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 11:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77DEB28577D
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 09:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E80118C33C;
	Fri, 25 Oct 2024 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClC8C93m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464D718B484;
	Fri, 25 Oct 2024 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850153; cv=none; b=Jr0SuGGVT9POE4RrdngD2cV/SuFDD3NpjeWApTWbF3TBjuuUAIor2YfSxowMGJESxZ7RfSpQeIxFj9MkHzmwIBHTceHoRqBU0e85gVQ1bvln3OWLG4ZgaBkw84e2YRiN69hXG3SWRVru7bJ5jJCZDb0cyFF9Vh47M7+G+qxCKmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850153; c=relaxed/simple;
	bh=wlrY1vs1nsbCxzDxxcd+OFmhf/hbqWWSnOFh0CqZsKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8CRzI5bVumB2IB4qrQMeCZ20Uu/6tZNlzI9+QhEqL56RuAuJmGTDWlyw129gSnoa6dHxfRwTvZRiCLJ2Ttgh9LfAz2Y0KIjCDKHdMe8dUsJNkT/xc4AvUATdgyPIoogqx3UB6UM9Q3s4KB0aQwhtHRQCB8Svasu/IwUP/piJTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClC8C93m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AB9C4CEC3;
	Fri, 25 Oct 2024 09:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729850152;
	bh=wlrY1vs1nsbCxzDxxcd+OFmhf/hbqWWSnOFh0CqZsKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ClC8C93mBMEkehGC8+JVia7Rds7TISRgEVnosgYtW195/YEuAuBO8rE2Dgw4WIVET
	 MCeq2H52MDBCDyy3j4rTHh0L33quPPA9TN3unMVEBSecmnbOKNqSkMeve4i+upDl8C
	 4U9s9ODz5pQXG5v7OjgDECQt1yZ70t0Ng5KNGhD4p/g5bx/WcYxK7nIa4jTNGMfXUn
	 fC/J92lnbVa50MBNvyEAhJVle/LHzJ3IRm1JwppYgOZhitokZwAZfvBCQDJqh3NpZO
	 kwjLhqjTA3eZJKBGDx3Aa/knKkDb/6F5evQDHTBkI3lyRGe8OsSSE5fabGk4RkbMoF
	 QV7AFB7XAogAA==
Date: Fri, 25 Oct 2024 10:55:48 +0100
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gang Yan <yangang@kylinos.cn>
Subject: Re: [PATCH net-next 2/4] mptcp: annotate data-races around
 subflow->fully_established
Message-ID: <20241025095548.GM1202098@kernel.org>
References: <20241021-net-next-mptcp-misc-6-13-v1-0-1ef02746504a@kernel.org>
 <20241021-net-next-mptcp-misc-6-13-v1-2-1ef02746504a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-net-next-mptcp-misc-6-13-v1-2-1ef02746504a@kernel.org>

On Mon, Oct 21, 2024 at 05:14:04PM +0200, Matthieu Baerts (NGI0) wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> We introduce the same handling for potential data races with the
> 'fully_established' flag in subflow as previously done for
> msk->fully_established.
> 
> Additionally, we make a crucial change: convert the subflow's
> 'fully_established' from 'bit_field' to 'bool' type. This is
> necessary because methods for avoiding data races don't work well
> with 'bit_field'. Specifically, the 'READ_ONCE' needs to know
> the size of the variable being accessed, which is not supported in
> 'bit_field'. Also, 'test_bit' expect the address of 'bit_field'.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/516
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

...

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 568a72702b080d7610425ce5c3a409c7b88da13a..a93e661ef5c435155066ce9cc109092661f0711c 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -513,7 +513,6 @@ struct mptcp_subflow_context {
>  		request_bkup : 1,
>  		mp_capable : 1,	    /* remote is MPTCP capable */
>  		mp_join : 1,	    /* remote is JOINing */
> -		fully_established : 1,	    /* path validated */
>  		pm_notified : 1,    /* PM hook called for established status */
>  		conn_finished : 1,
>  		map_valid : 1,
> @@ -532,10 +531,11 @@ struct mptcp_subflow_context {
>  		is_mptfo : 1,	    /* subflow is doing TFO */
>  		close_event_done : 1,       /* has done the post-closed part */
>  		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
> -		__unused : 8;
> +		__unused : 9;
>  	bool	data_avail;
>  	bool	scheduled;
>  	bool	pm_listener;	    /* a listener managed by the kernel PM? */
> +	bool	fully_established;  /* path validated */
>  	u32	remote_nonce;
>  	u64	thmac;
>  	u32	local_nonce;

...

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 6170f2fff71e4f9d64837f2ebf4d81bba224fafb..860903e0642255cf9efb39da9e24c39f6547481f 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -800,7 +800,7 @@ void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
>  				       const struct mptcp_options_received *mp_opt)
>  {
>  	subflow_set_remote_key(msk, subflow, mp_opt);
> -	subflow->fully_established = 1;
> +	WRITE_ONCE(subflow->fully_established, true);
>  	WRITE_ONCE(msk->fully_established, true);
>  
>  	if (subflow->is_mptfo)
> @@ -2062,7 +2062,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
>  	} else if (subflow_req->mp_join) {
>  		new_ctx->ssn_offset = subflow_req->ssn_offset;
>  		new_ctx->mp_join = 1;
> -		new_ctx->fully_established = 1;
> +		WRITE_ONCE(new_ctx->fully_established, true);
>  		new_ctx->remote_key_valid = 1;
>  		new_ctx->backup = subflow_req->backup;
>  		new_ctx->request_bkup = subflow_req->request_bkup;

My understanding is that 1) fully_established is now a single byte and
2) WRITE_ONCE is not necessary for a single byte, as if I understand Eric's
comment in [1] correctly, tearing is not possible in this case.

[1] https://lore.kernel.org/netdev/CANn89i+8myPgn61bn7DBqcnK5kXX2XvPo2oc2TfzntPUkeqQ6w@mail.gmail.com/



