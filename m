Return-Path: <netdev+bounces-29537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA06783AF2
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24AE280FD3
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 07:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839CC79C6;
	Tue, 22 Aug 2023 07:32:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F057379C3
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 07:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB71C433C8;
	Tue, 22 Aug 2023 07:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692689524;
	bh=KxhF+pQsKx3GhC2XIfkJW6VsrpHpZhKG0LezvhC2MSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gKN+k3P85iOdKOpmbjKtz6KKKbBbIRdj62WqlMsMN61X2IVX+5lR3GDR6Aexl3Lc0
	 LKPXjx0Olin1J6qP2x3TdogiAaynuXqIN05rDEjNYYMhIgvTx1dSDHVNGwCXlfaMVu
	 K3Xs7xZI6MNmgU0LXilJbGY6QGCQ6/Gq2pHJ3fTHjF3mzny94wOr+4+7+FpDvjS58l
	 s+bRZFRzzIhVKhCO0rWTtqWZ8bq7YtN3TZEKcxAO5G1jY4aIDV9fnNCU4SIe7i9QCt
	 yTbgjzqicPR72chVefAaFvLmOtJpe6+KMACMa2tF5fgvEN33QvvQ3q7qzi6TF5GhML
	 FDGxTemloTr7Q==
Date: Tue, 22 Aug 2023 09:32:01 +0200
From: Simon Horman <horms@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	mlxsw@nvidia.com
Subject: Re: [PATCH net-next] vrf: Remove unnecessary RCU-bh critical section
Message-ID: <20230822073201.GO2711035@kernel.org>
References: <20230821142339.1889961-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821142339.1889961-1-idosch@nvidia.com>

On Mon, Aug 21, 2023 at 05:23:39PM +0300, Ido Schimmel wrote:
> dev_queue_xmit_nit() already uses rcu_read_lock() / rcu_read_unlock()
> and nothing suggests that softIRQs should be disabled around it.
> Therefore, remove the rcu_read_lock_bh() / rcu_read_unlock_bh()
> surrounding it.
> 
> Tested using [1] with lockdep enabled.
> 
> [1]
>  #!/bin/bash
> 
>  ip link add name vrf1 up type vrf table 100
>  ip link add name veth0 type veth peer name veth1
>  ip link set dev veth1 master vrf1
>  ip link set dev veth0 up
>  ip link set dev veth1 up
>  ip address add 192.0.2.1/24 dev veth0
>  ip address add 192.0.2.2/24 dev veth1
>  ip rule add pref 32765 table local
>  ip rule del pref 0
>  tcpdump -i vrf1 -c 20 -w /dev/null &
>  sleep 10
>  ping -i 0.1 -c 10 -q 192.0.2.2
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


