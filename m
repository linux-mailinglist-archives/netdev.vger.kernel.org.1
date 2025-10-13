Return-Path: <netdev+bounces-228687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0232CBD23CA
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 11:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62EAA4EDABF
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 09:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5188D2FC86F;
	Mon, 13 Oct 2025 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZszY7V+V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4E32FCC19
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347117; cv=none; b=PizDuFS/oABaltu+pUytOv7FEuyMlDlAb87L6IFBi3tL5hu03dYNhH0pCMPKT9+a8q2Lm3NMa54xbeCcJgGclpGvuGcdVCK34HUvz9Fu5ZUu9I79PWyyvuUM1waEqjgTU/DDtbJEr1ryn9ZIwK8qk/sqsuBxGPqjXPcZIhqPMyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347117; c=relaxed/simple;
	bh=TzJ0qjMgPcDH/kPq8D2fbNdC1r/y4oeuskCQaHWZSRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMCrX6AX8Ja6f64WquRVB0gcGaBGJlYcwT8mn3bWv3gQAvHNLYosAMrYvADqZ+bJDCGc5y0KGaIB3EZdpyua5zKuaeRkMz7ttyeD6BpigmjS/o4QxC0GxqUjF84xwDwL9W4faGa2t3bXQHGu50eTWZzUsdTdA1jdUOAzEzzBbHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZszY7V+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499FBC4CEE7;
	Mon, 13 Oct 2025 09:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760347116;
	bh=TzJ0qjMgPcDH/kPq8D2fbNdC1r/y4oeuskCQaHWZSRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZszY7V+VkWLUKoBZh9FAWl9AOeR6ENwCZP1HTysTl8lz0rWcQz/SzVNqJRkbesvzJ
	 hiNk8dC9OI0avK+PpYk+uHI1iqsPCdPLPbW5sinHftPmc38XK6j0NhtCzml/gjU9WN
	 JAl/d8e4H9bg2KJVL30YxP3ZCSi+9Dz6h9cSTmW3HAqlslvH7S9SIMDVcz6BoGv6/n
	 z626AtIedh9nHJwhMBtLrRZMWXP1P7b4ZtLYhl18E33NsNNoKs0ksEwhYoNA10ElcD
	 t7pse7HeXvIgorPearV9L7bYhYHQLY1+9jpWwwPyN0tKyfmV6FlSwVPoCXHJTpz4LM
	 Wg8r/nu945+Ag==
Date: Mon, 13 Oct 2025 10:18:33 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH RFC net-next 4/4] net: allow busy connected flows to
 switch tx queues
Message-ID: <aOzD6T6dzZNq06Lj@horms.kernel.org>
References: <20251008104612.1824200-1-edumazet@google.com>
 <20251008104612.1824200-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008104612.1824200-5-edumazet@google.com>

On Wed, Oct 08, 2025 at 10:46:11AM +0000, Eric Dumazet wrote:
> This is a followup of commit 726e9e8b94b9 ("tcp: refine
> skb->ooo_okay setting") and to the prior commit in this series
> ("net: control skb->ooo_okay from skb_set_owner_w()")
> 
> skb->ooo_okay might never be set for bulk flows that always
> have at least one skb in a qdisc queue of NIC queue,
> especially if TX completion is delayed because of a stressed cpu.
> 
> The so-called "strange attractors" has caused many performance
> issues, we need to do better.
> 
> We have tried very hard to avoid reorders because TCP was
> not dealing with them nicely a decade ago.
> 
> Use the new net.core.txq_reselection_ms sysctl to let
> flows follow XPS and select a more efficient queue.
> 
> After this patch, we no longer have to make sure threads
> are pinned to cpus, they now can be migrated without
> adding too much spinlock/qdisc/TX completion pressure anymore.
> 
> TX completion part was problematic, because it added false sharing
> on various socket fields, but also added false sharing and spinlock
> contention in mm layers. Calling skb_orphan() from ndo_start_xmit()
> is not an option unfortunately.
> 
> Note for later: move sk->sk_tx_queue_mapping closer
> to sk_tx_queue_mapping_jiffies for better cache locality.
> 
> Tested:
> 
> Used a host with 32 TX queues, shared by groups of 8 cores.
> XPS setup :
> 
> echo ff >/sys/class/net/eth1/queue/tx-0/xps_cpus
> echo ff00 >/sys/class/net/eth1/queue/tx-1/xps_cpus
> echo ff0000 >/sys/class/net/eth1/queue/tx-2/xps_cpus
> echo ff000000 >/sys/class/net/eth1/queue/tx-3/xps_cpus
> echo ff,00000000 >/sys/class/net/eth1/queue/tx-4/xps_cpus
> echo ff00,00000000 >/sys/class/net/eth1/queue/tx-5/xps_cpus
> echo ff0000,00000000 >/sys/class/net/eth1/queue/tx-6/xps_cpus
> echo ff000000,00000000 >/sys/class/net/eth1/queue/tx-7/xps_cpus
> ...
> 
> Launched a tcp_stream with 15 threads and 1000 flows, initially affined to core 0-15
> 
> taskset -c 0-15 tcp_stream -T15 -F1000 -l1000 -c -H target_host
> 
> Checked that only queues 0 and 1 are used as instructed by XPS :
> tc -s qdisc show dev eth1|grep backlog|grep -v "backlog 0b 0p"
>  backlog 123489410b 1890p
>  backlog 69809026b 1064p
>  backlog 52401054b 805p
> 
> Then force each thread to run on cpu 1,9,17,25,33,41,49,57,65,73,81,89,97,105,113,121
> 
> C=1;PID=`pidof tcp_stream`;for P in `ls /proc/$PID/task`; do taskset -pc $C $P; C=$(($C + 8));done
> 
> Set txq_reselection_ms to 1000
> echo 1000 > /proc/sys/net/core/txq_reselection_ms
> 
> Check that the flows have migrated nicely:
> 
> tc -s qdisc show dev eth1|grep backlog|grep -v "backlog 0b 0p"
>  backlog 130508314b 1916p
>  backlog 8584380b 126p
>  backlog 8584380b 126p
>  backlog 8379990b 123p
>  backlog 8584380b 126p
>  backlog 8487484b 125p
>  backlog 8584380b 126p
>  backlog 8448120b 124p
>  backlog 8584380b 126p
>  backlog 8720640b 128p
>  backlog 8856900b 130p
>  backlog 8584380b 126p
>  backlog 8652510b 127p
>  backlog 8448120b 124p
>  backlog 8516250b 125p
>  backlog 7834950b 115p
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Very nice :)

> ---
>  include/net/sock.h | 40 +++++++++++++++++++---------------------
>  net/core/dev.c     | 27 +++++++++++++++++++++++++--
>  2 files changed, 44 insertions(+), 23 deletions(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 2794bc5c565424491a064049d3d76c3fb7ba1ed8..61f92bb03e00d7167cccfe70da16174f2b40f6de 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -485,6 +485,7 @@ struct sock {
>  	unsigned long		sk_pacing_rate; /* bytes per second */
>  	atomic_t		sk_zckey;
>  	atomic_t		sk_tskey;
> +	unsigned long		sk_tx_queue_mapping_jiffies;

nit: please add sk_tx_queue_mapping_jiffies to Kernel doc

>  	__cacheline_group_end(sock_write_tx);
>  
>  	__cacheline_group_begin(sock_read_tx);

