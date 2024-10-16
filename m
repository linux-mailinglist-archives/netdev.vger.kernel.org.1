Return-Path: <netdev+bounces-136167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D16A9A0BE2
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 15:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B38D8B25FCC
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 13:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5998C20A5CA;
	Wed, 16 Oct 2024 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmVt5VPx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC83209F29;
	Wed, 16 Oct 2024 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729086575; cv=none; b=mNWIshfNc0mKlGc92pxv/DjKmwsut1kHhk0NiOz/Mj4SXb+WzkStMDvrlZ1tfal4MJAGDK/WrEvie8Rmn7iUQasQb8gkF8EqucTVKVH+dU8CWEQT1QWMTo1XmsADpqL2r5w2Qy//5jeDDeO8xpgxk0d+ic2RgVwE6Wvjog/7U08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729086575; c=relaxed/simple;
	bh=tOY6XzLiOXjIBKdyYo4UTG7nyOXLEvKocvreGuphhho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWzJsayaU0LocmesR69z6npduuuXM/Lcc4FQEOA39nDGBEsONw9B6n+xgBknfzVTF7Wu8TGa6T/Y+6LPuWrM4M7EyHSJAnzJI1ixdcxROiNZpKtLy536cq+iNDisLTTjrboRqgJNlq+VEjGilrl3N8kXjq/MHneV8u0oM8L6f08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmVt5VPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8345C4CEC5;
	Wed, 16 Oct 2024 13:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729086574;
	bh=tOY6XzLiOXjIBKdyYo4UTG7nyOXLEvKocvreGuphhho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FmVt5VPxAy4FyG7omxUSQpkpTW+ucjkCp/w4sI+sriyKtWzN/uVE92zAdk/lQTbKe
	 Z1pon91Lp9dy+/k2i2w1296s2zjMpMZw5TcvQVpVs1ZXIRCn+34B2NocOyYp5lMedC
	 JLmq4A72xrGRdJ+AJrdBF31cGZHt2ATbkIQxOPCSxQq+tYM1xI+wUyNBGjOhoXQkvv
	 uVZ9oVW8DAxKeHK5oNaUfYlRwcJ4ce1ea9VaJ9tAS4E/n+qoN3aGrM+Ehbn8bvcHQX
	 1uGjfU9Fb7chd6cI9A5hlw0sNfBL5ICYRID/IpQnA6yDQxRvQuSX04ZLzLqGnYtA+j
	 dgwS6erh0hw3A==
Date: Wed, 16 Oct 2024 14:49:30 +0100
From: Simon Horman <horms@kernel.org>
To: Wang Hai <wanghai38@huawei.com>
Cc: sammy@sammy.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, zhangxiaoxu5@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/sun3_82586: fix potential memory leak in
 sun3_82586_send_packet()
Message-ID: <20241016134930.GF2162@kernel.org>
References: <20241015144148.7918-1-wanghai38@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015144148.7918-1-wanghai38@huawei.com>

On Tue, Oct 15, 2024 at 10:41:48PM +0800, Wang Hai wrote:
> The sun3_82586_send_packet() returns NETDEV_TX_OK without freeing skb
> in case of skb->len being too long, add dev_kfree_skb() to fix it.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  drivers/net/ethernet/i825xx/sun3_82586.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/i825xx/sun3_82586.c b/drivers/net/ethernet/i825xx/sun3_82586.c
> index f2d4669c81cf..58a3d28d938c 100644
> --- a/drivers/net/ethernet/i825xx/sun3_82586.c
> +++ b/drivers/net/ethernet/i825xx/sun3_82586.c
> @@ -1012,6 +1012,7 @@ sun3_82586_send_packet(struct sk_buff *skb, struct net_device *dev)
>  	if(skb->len > XMIT_BUFF_SIZE)
>  	{
>  		printk("%s: Sorry, max. framelength is %d bytes. The length of your frame is %d bytes.\n",dev->name,XMIT_BUFF_SIZE,skb->len);
> +		dev_kfree_skb(skb);
>  		return NETDEV_TX_OK;
>  	}

Thanks,

I agree that:
* This code-change is correct,
* and in keeping with other code in this function.
* And I agree that this problem goes back to the beginning of git history

Reviewed-by: Simon Horman <horms@kernel.org>

