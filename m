Return-Path: <netdev+bounces-160351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02348A195D2
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 16:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F7667A1711
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 15:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F49F2147FE;
	Wed, 22 Jan 2025 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tU4s5AJg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A382144DB;
	Wed, 22 Jan 2025 15:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737561097; cv=none; b=FdHEX/Swm+MickjI9X92wLQ1hlh2FbvSKTXWU0k+xkcnqFprfHkhk+23mzNAKkVtldzjavnhI3GoCYveZt0v+pX6a1RyXGC45MIB23UmtK4M6SHIsM4OBbJ5sINR3AO3l8W4D0b2itjI69VaRZ1xfYJRxFOI7sVy5qFGuXeyMO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737561097; c=relaxed/simple;
	bh=v7N4Q4l0ABvopdX/qmHrxNvdVx7lRwDM9DbQsVIvnMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCey9YupKesHWy/EKsuq3drN5LkTHaDheimt4ZRfRohhuuHiDNULzPfIC0fsAHfwpKGhmhgjoMuOtxjRMuS0t/krqUikzDc7Y+x8ShFuzZnkPNQPatsonw7fCYRCWx3/Bk8ZiyYXBlc7FAzit+IIol0k68nQzUM3rA4b5TtRJHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tU4s5AJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2991BC4CED2;
	Wed, 22 Jan 2025 15:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737561096;
	bh=v7N4Q4l0ABvopdX/qmHrxNvdVx7lRwDM9DbQsVIvnMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tU4s5AJg8xK+7eEvh/6/FAfR3BIrW0jshY1NTMRn/FtlyP7wmrg3zP2tAiwwz8++x
	 lYyunoevy7xz246E7uiSaBmTczFM+bsil7J3AhUJMIqFTLbe1cHjUxtxRDNHe7tqhx
	 FP6uxpuX3fzXdKWqqoW6HH6hWI1feP84l6WfqMMxGMQNO5xnYttzhDeiQ81MwWDdHD
	 p/mwm1Lpy14QWa70/FrGRaQfcIgsro9P4SWSDtgc3xl6uputWn4M2i7vacB6EMXDpo
	 PAKIA2+WRwgivM6ZYWwfdPSAcnC8/aMFL2WuRno+FPBoOMm3/xqA5dbft/ZyaCFu6p
	 Y01SNtieOgJMQ==
Date: Wed, 22 Jan 2025 15:51:31 +0000
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Thomas Graf <tgraf@suug.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net: netlink: prevent potential integer overflow in
 nlmsg_new()
Message-ID: <20250122155131.GF395043@kernel.org>
References: <58023f9e-555e-48db-9822-283c2c1f6d0e@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58023f9e-555e-48db-9822-283c2c1f6d0e@stanley.mountain>

On Wed, Jan 22, 2025 at 04:49:17PM +0300, Dan Carpenter wrote:
> The "payload" variable is type size_t, however the nlmsg_total_size()
> function will a few bytes to it and then truncate the result to type
> int.  That means that if "payload" is more than UINT_MAX the alloc_skb()
> function might allocate a buffer which is smaller than intended.
> 
> Cc: stable@vger.kernel.org
> Fixes: bfa83a9e03cf ("[NETLINK]: Type-safe netlink messages/attributes interface")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  include/net/netlink.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/net/netlink.h b/include/net/netlink.h
> index e015ffbed819..ca7a8152e6d4 100644
> --- a/include/net/netlink.h
> +++ b/include/net/netlink.h
> @@ -1015,6 +1015,8 @@ static inline struct nlmsghdr *nlmsg_put_answer(struct sk_buff *skb,
>   */
>  static inline struct sk_buff *nlmsg_new(size_t payload, gfp_t flags)
>  {
> +	if (payload > INT_MAX)
> +		return NULL;
>  	return alloc_skb(nlmsg_total_size(payload), flags);

Hi Dan,

I wonder if this is sufficient.

If payload is INT_MAX then won't the call to nlmsg_msg_size() inside
nlmsg_total_size() overflow. And likewise, it feels that NLMSG_ALIGN
could overflow somehow.

