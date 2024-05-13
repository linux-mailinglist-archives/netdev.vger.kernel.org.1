Return-Path: <netdev+bounces-96102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5528C8C4572
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 18:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9CA41F20FD1
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 16:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EF41A29A;
	Mon, 13 May 2024 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTosOve5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D5D208A1
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619472; cv=none; b=RL5mmJqu+RuAH1FjkzZEaa/k9eVV0/5dRJO6XxPCYXpUkuB1t/zaiZSz3umuyNPBT9p8j0ZSEf96RA20rgwt68KKFWnuzHDAbgQQSlr97/TjBXbN80iisUtcRfBcG0XKfXk3FH0vQJyrrmvqK24Rs18tDix0AQMBUMqnY0tYAX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619472; c=relaxed/simple;
	bh=NTXd4vtPEvnazawCKloVyhwoOmQZC0+hrwhaosm28N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEKqOlk1cezhIEhaJEMZPixTQMHpNX9rfnAqWAJ4+gBQgqdmczU0hleitQLc06uZ1AxrlPYyWJSuqysg/CSCDfG5ZOwv1WiYTKZaUvRXPIw2PZ5eH+VE5PBy/+xT6A6pKgnazmt7yICIv5xKSrKZe2aT6j6btLGZ0YUlqU8Wp1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTosOve5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A3DC113CC;
	Mon, 13 May 2024 16:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715619471;
	bh=NTXd4vtPEvnazawCKloVyhwoOmQZC0+hrwhaosm28N8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZTosOve5xWspTnQQfNBf6xvdhRh5nOGmwe3FAzeIbNvfj3n1gs/wqamDdDrU4qu16
	 6g85VortfcZb+MzMfUs+VRaEfhgkRbe4BNR7LYKKdbK9jI938+5YflMjVSL+nB8WN0
	 RoW28Ef6OpMTlXM3L5Ap9qVC/z1wj97de8EqtuD/3ZLPkJvOsj7sxfrm6zHXKxRkl4
	 DSAznxid0ybmw2ODgWVQ2/nzl9K4gcrpizJVzuOAZ4UngkoXHLZJyI+Uqz4rJEND0f
	 OxmBfvxMMJXROqjVB1ENRTvKgxYNwosBRhV6LkF0VhxojxGd5wVW2ElBdXSVk0WmHI
	 X0rTcF0WoGQIw==
Date: Mon, 13 May 2024 17:57:47 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	Michal Luczaj <mhal@rbox.co>, netdev@vger.kernel.org,
	Billy Jheng Bing-Jhong <billy@starlabs.sg>
Subject: Re: [PATCH v3 net] af_unix: Update unix_sk(sk)->oob_skb under
 sk_receive_queue lock.
Message-ID: <20240513165747.GT2787@kernel.org>
References: <20240513130628.33641-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513130628.33641-1-kuniyu@amazon.com>

On Mon, May 13, 2024 at 10:06:28PM +0900, Kuniyuki Iwashima wrote:

...

> @@ -2666,13 +2681,19 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
>  			} else if (flags & MSG_PEEK) {
>  				skb = NULL;
>  			} else {
> -				skb_unlink(skb, &sk->sk_receive_queue);
> +				__skb_unlink(skb, &sk->sk_receive_queue);
>  				WRITE_ONCE(u->oob_skb, NULL);
> -				if (!WARN_ON_ONCE(skb_unref(skb)))
> -					kfree_skb(skb);
> +				unlinked_skb = skb;
>  				skb = skb_peek(&sk->sk_receive_queue);
>  			}
>  		}
> +
> +		spin_unlock(&sk->sk_receive_queue.lock);
> +
> +		if (unlinked_skb) {
> +			WARN_ON_ONCE(skb_unref(skb));
> +			kfree_skb(skb);

Hi Iwashima-san,

Here skb is kfree'd.

> +		}
>  	}
>  	return skb;

But here it is returned.
This doesn't seem right.

Flagged by Smatch.

>  }

...

-- 
pw-bot: changes-requested

