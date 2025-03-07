Return-Path: <netdev+bounces-172931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F377A56894
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A370172BC7
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 13:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C6521A440;
	Fri,  7 Mar 2025 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="timUFPbV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0CD21A436;
	Fri,  7 Mar 2025 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353208; cv=none; b=Mwr4ygpw8G29xJJ9oZL2F1kwANpBL/PaZW3JUjt3Zx9SbufVIwLM32FlSb9ze5jVQkgfUWU1i7lr/gUG3tQfe+bW6+kZOLYK5mK4yOWHxntX6Ka+j16vaIemr5kAMUjFspb+PdwSn1qpzqw9Ve4H9r9h3mx9Yr38Nl7SagGOdJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353208; c=relaxed/simple;
	bh=yse6HLeSO1NJH+GpzkEtzrWTo+s5HQhw1DSwCupPSwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2CgiMCg6CqX7mWV5+cwGrjVjDsasIClYUD7MIuAEMzvwQLlbuedaetSAI1PfF/O9XptjmnjQwD3CLTNmF/GWqVLMsYkgmhRdzPQI23aaBVKpaGYibWYjXfDSB0QXQFvubtu55nD/5PyCadMh/+BpWExGAkr3bP4MN2ySRFIBKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=timUFPbV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60496C4CEE5;
	Fri,  7 Mar 2025 13:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741353207;
	bh=yse6HLeSO1NJH+GpzkEtzrWTo+s5HQhw1DSwCupPSwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=timUFPbVHfjS8X4Ql2wgr2962zbQix+9K3vOeOmF74aR5/u5/LqXa+qgSDhkfP2GE
	 5eLvGr6GaQMJ/xxelR8nzvn8xjtQQ2SSwen/Ba0bDCiQDpUo0SkMOogEfnt4SQ/Qev
	 +Ii6wx2Io6fSoRSf3NHEYthlH1auXyrXSpBxIWw076N4Me001dKKQJEezCqjpWVfCy
	 AlnMfSbJeHiPPkMW+pBV/uI9NMdYwWtcojJLR7QPZIvY14GGGAxhDZLMVZug2i15Nk
	 H9LBcq+TqAjx6s2D50eO7KVGuFRpda8kQtF9HcrMF2zEfhOrvAt9axqRs1ewCLRAuv
	 rWScXl+b6qw0w==
Date: Fri, 7 Mar 2025 13:13:22 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Amerigo Wang <amwang@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net v2] netpoll: hold rcu read lock in
 __netpoll_send_skb()
Message-ID: <20250307131322.GG3666230@kernel.org>
References: <20250306-netpoll_rcu_v2-v2-1-bc4f5c51742a@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-netpoll_rcu_v2-v2-1-bc4f5c51742a@debian.org>

On Thu, Mar 06, 2025 at 05:16:18AM -0800, Breno Leitao wrote:
> The function __netpoll_send_skb() is being invoked without holding the
> RCU read lock. This oversight triggers a warning message when
> CONFIG_PROVE_RCU_LIST is enabled:
> 
> 	net/core/netpoll.c:330 suspicious rcu_dereference_check() usage!
> 
> 	 netpoll_send_skb
> 	 netpoll_send_udp
> 	 write_ext_msg
> 	 console_flush_all
> 	 console_unlock
> 	 vprintk_emit
> 
> To prevent npinfo from disappearing unexpectedly, ensure that
> __netpoll_send_skb() is protected with the RCU read lock.
> 
> Fixes: 2899656b494dcd1 ("netpoll: take rcu_read_lock_bh() in netpoll_send_skb_on_dev()")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v2:
> - Use rcu_read_lock() instead of guard() as normal people do (Jakub).
> - Link to v1: https://lore.kernel.org/r/20250303-netpoll_rcu_v2-v1-1-6b34d8a01fa2@debian.org

Nice that we can be normal :)

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/core/netpoll.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index 62b4041aae1ae..0ab722d95a2df 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -319,6 +319,7 @@ static int netpoll_owner_active(struct net_device *dev)
>  static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
>  {
>  	netdev_tx_t status = NETDEV_TX_BUSY;
> +	netdev_tx_t ret = NET_XMIT_DROP;
>  	struct net_device *dev;
>  	unsigned long tries;
>  	/* It is up to the caller to keep npinfo alive. */
> @@ -327,11 +328,12 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
>  	lockdep_assert_irqs_disabled();
>  
>  	dev = np->dev;
> +	rcu_read_lock();
>  	npinfo = rcu_dereference_bh(dev->npinfo);
>  
>  	if (!npinfo || !netif_running(dev) || !netif_device_present(dev)) {
>  		dev_kfree_skb_irq(skb);
> -		return NET_XMIT_DROP;

nit: I would have set ret here rather than as part of it's declaration,
     to avoid it being set twice in the non-error case.

     But as this function is doing quite a lot, and moreover the compiler
     probably has it's own ideas, I don' think this is a big deal.

> +		goto out;
>  	}
>  
>  	/* don't get messages out of order, and no recursion */
> @@ -370,7 +372,10 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
>  		skb_queue_tail(&npinfo->txq, skb);
>  		schedule_delayed_work(&npinfo->tx_work,0);
>  	}
> -	return NETDEV_TX_OK;
> +	ret = NETDEV_TX_OK;
> +out:
> +	rcu_read_unlock();
> +	return ret;
>  }
>  
>  netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
> 
> ---
> base-commit: 848e076317446f9c663771ddec142d7c2eb4cb43
> change-id: 20250303-netpoll_rcu_v2-fed72eb0cb83
> 
> Best regards,
> -- 
> Breno Leitao <leitao@debian.org>
> 

