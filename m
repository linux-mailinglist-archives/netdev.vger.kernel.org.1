Return-Path: <netdev+bounces-205350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D64AFE3B9
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1C0583B88
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBFF283FDD;
	Wed,  9 Jul 2025 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVcSa+Oa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FA5283FD9
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052284; cv=none; b=SVNU3DY0nb9g0KS05blS9E8b8aU9y1OY86xod33HJXlaKwPwvl3aZXlIhX4jyy5KovyyUdscq72zphXq/eaP8OQ0yhZIChV8gXeUyKzazg+PTd5VCwhNF+rF3xD4+QYezcHy6bQZRxC39pWw8lvy4jGqYsni5pOSP6whzQvkCYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052284; c=relaxed/simple;
	bh=9/1I0gZ9OP43GCWB/hpm9hxhtJV12QkqfBmu2VbGiFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFTNPypQZmAo7u2cVSLXrZZ7bPG1In+Yo9JwWobvvFxYetur54nnxPvW6TwWcj1goBbnwr58f87/CjD++zyO4rhvB82X3hngndsceOlVzASXSmMhsAhICchBBMLeTsCjwswBpiV4Hm120/zEUTXF0utjcNlKtdLn0iQjCUA3WFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVcSa+Oa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DB7C4CEF0;
	Wed,  9 Jul 2025 09:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752052283;
	bh=9/1I0gZ9OP43GCWB/hpm9hxhtJV12QkqfBmu2VbGiFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVcSa+Oa4scGLQ5dLXrbJSAdpQCld5UmTDwStwg5mofUm4dbZVBAdaplwA5JBsefN
	 RX/d2AVxT/kpHrZD+IQt/sCoyC/8SIzvlwTHspPZMyJKz35b2DSc0P8vF5DPAsazIS
	 X3m4BahNQS8/LEkKTkOnyScaaaKyRrNnD2gqvT1l1NyLCCEyHBz/J260Q+gr2SIsrr
	 w2EJepwt/SJUgz/8FtBxz1lrn085c+CRP/G5wYj7c3wu/9BSc3wcY+liMSpLyUz2t3
	 ICrtONw4XDR1RKi8Id5f1P8TaQNaVvTgBPU90JSD7+vko9SSGamiKCcVlPm54niZ5k
	 47iq1gZqhv6hQ==
Date: Wed, 9 Jul 2025 10:11:20 +0100
From: Simon Horman <horms@kernel.org>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 6/8] net: mctp: Allow limiting binds to a
 peer address
Message-ID: <20250709091120.GQ452973@horms.kernel.org>
References: <20250709-mctp-bind-v3-0-eac98bbf5e95@codeconstruct.com.au>
 <20250709-mctp-bind-v3-6-eac98bbf5e95@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709-mctp-bind-v3-6-eac98bbf5e95@codeconstruct.com.au>

On Wed, Jul 09, 2025 at 04:31:07PM +0800, Matt Johnston wrote:

...

> @@ -87,13 +87,33 @@ static int mctp_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
>  	 * lookup time.
>  	 */
>  	if (smctp->smctp_network == MCTP_NET_ANY &&
> -	    msk->bind_addr != MCTP_ADDR_ANY) {
> +	    msk->bind_local_addr != MCTP_ADDR_ANY) {
>  		msk->bind_net = mctp_default_net(net);
>  	} else {
>  		msk->bind_net = smctp->smctp_network;
>  	}
>  
> -	msk->bind_type = smctp->smctp_type & 0x7f; /* ignore the IC bit */
> +	/* ignore the IC bit */
> +	smctp->smctp_type &= 0x7f;
> +
> +	if (msk->bind_peer_set) {
> +		if (msk->bind_type != smctp->smctp_type) {
> +			/* Prior connect() had a different type */
> +			return -EINVAL;

Hi Matt,

I think you need to set rc and goto out_release here so
that sk is released.

> +		}
> +
> +		if (msk->bind_net == MCTP_NET_ANY) {
> +			/* Restrict to the network passed to connect() */
> +			msk->bind_net = msk->bind_peer_net;
> +		}
> +
> +		if (msk->bind_net != msk->bind_peer_net) {
> +			/* connect() had a different net to bind() */
> +			return -EINVAL;

Ditto.

Flagged by Smatch.

> +		}
> +	} else {
> +		msk->bind_type = smctp->smctp_type;
> +	}
>  
>  	rc = sk->sk_prot->hash(sk);
>  

...

-- 
pw-bot: changes-requested

