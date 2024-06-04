Return-Path: <netdev+bounces-100639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 464238FB6CD
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 17:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52701F2218F
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F384513C827;
	Tue,  4 Jun 2024 15:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyrZhOp1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA86D30B;
	Tue,  4 Jun 2024 15:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514342; cv=none; b=Wx5Jj2szk48x/0fJhGqfF541N+0FjyswEJ1l9icHMYDCH1J1/jP9nt5UawZPIr1UOOwBJODga6QuxVuTRWVLry995IPAwczriWtakL1In1opm0ZWdiRi3Z9DWxxxn7d7WKQreo5E1lOAsSaEYS/R+hmqgOEizN3rq6pj+Aq3ObQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514342; c=relaxed/simple;
	bh=SgYhZ1mbIunBtwN4LKIszTbrQvB7J8eU/XbTXIjeK1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TB+VotbM6doXY6PzfCYAEa5gSF0qYKcEdZ4q35KGjW4XYGw4hooa09FWzCQJvh4aDkZgIlf4KjIobc/yL19wa8qnh2+cXNeVhvy5+xktqyBqTCOa3kVIs2xdW1Us9scc90Knt/VvQlZvKt/8SWKoHRUDnZ2xkafeCp+Iq5xEbfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyrZhOp1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEDCC2BBFC;
	Tue,  4 Jun 2024 15:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717514342;
	bh=SgYhZ1mbIunBtwN4LKIszTbrQvB7J8eU/XbTXIjeK1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MyrZhOp15I4XFkFD+6fehBKN2mI4y5rGUfIh9flVaQMTk7j+KqUkgTuT4qKqbjHZB
	 q333b3h11kdC3Wc+/3qNCGkLw8D6Z++35usa8mQ81mqSAD+zMFIquk2uX+Nn7u97B7
	 c8d4Zu8BgGuSobzdZdqks9FnbB2gYB2UAfZZP/GV+HyY0d6pYuqBsL3hVHGHgQ7fiY
	 yG1tQoTjmARwBu8+y40vGzGxjBk72VffHwwN1Z/L61agKiHL3vIJ800ryuLvQE5zGQ
	 4JIlzAEEzVxRTEet/DZexud0+/HeIdANRcpFtK/iDyiYApg0WRrRVOzJdIIGZRAeMC
	 RU8uo0vqYXLng==
Date: Tue, 4 Jun 2024 16:18:55 +0100
From: Simon Horman <horms@kernel.org>
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Mina Almasry <almasrymina@google.com>,
	Florian Westphal <fw@strlen.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Howells <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [RFC v2 net-next 7/7] af_packet: use sk_skb_reason_drop to free
 rx packets
Message-ID: <20240604151855.GT491852@kernel.org>
References: <cover.1717206060.git.yan@cloudflare.com>
 <b86569aac8c4a2f180e7d3e22389547ff2e26cdc.1717206060.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b86569aac8c4a2f180e7d3e22389547ff2e26cdc.1717206060.git.yan@cloudflare.com>

On Fri, May 31, 2024 at 06:43:00PM -0700, Yan Zhai wrote:
> Replace kfree_skb_reason with sk_skb_reason_drop and pass the receiving
> socket to the tracepoint.
> 
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
>  net/packet/af_packet.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index fce390887591..3133d4eb4a1b 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c

Hi Yan Zhai,

Near the top of packet_rcv,
immediately after local variable declarations, and
before sk is initialised is the following:

	if (skb->pkt_type == PACKET_LOOPBACK)
		goto drop;

> @@ -2226,7 +2226,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
>  		skb->len = skb_len;
>  	}
>  drop:
> -	kfree_skb_reason(skb, drop_reason);
> +	sk_skb_reason_drop(sk, skb, drop_reason);

So sk may be used uninitialised here.

Similarly in tpacket_rcv()

Flagged by clang-18 W=1 allmodconfig builds on x86_64.

>  	return 0;
>  }
>  
> @@ -2494,7 +2494,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  		skb->len = skb_len;
>  	}
>  drop:
> -	kfree_skb_reason(skb, drop_reason);
> +	sk_skb_reason_drop(sk, skb, drop_reason);
>  	return 0;
>  
>  drop_n_account:
> @@ -2503,7 +2503,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  	drop_reason = SKB_DROP_REASON_PACKET_SOCK_ERROR;
>  
>  	sk->sk_data_ready(sk);
> -	kfree_skb_reason(copy_skb, drop_reason);
> +	sk_skb_reason_drop(sk, copy_skb, drop_reason);
>  	goto drop_n_restore;
>  }
>  
> -- 
> 2.30.2
> 
> 

