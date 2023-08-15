Return-Path: <netdev+bounces-27618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A0177C901
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 09:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CEE280DB1
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 07:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E42DBA26;
	Tue, 15 Aug 2023 07:59:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514B753AC
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 07:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D7EC433C9;
	Tue, 15 Aug 2023 07:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692086376;
	bh=Ra/ZRooFm1RD+Jr8UIyTrZhtdGZen+1qL54uTgC2ytA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CTqDcDBIDp3+pAs5NnnnJF8IGh8S19hb95fCQtt8zw2d/mjgvRnYefIMjQ44uxDr0
	 G9EKilyGklBkcvAOIOOfDxK1wxPPTFlz/R3XjQBJC9BpsCGwInMYrzNgY1PbQjb30B
	 AJlYRtS5xx/PET35GycyWklofmCO4jxXOp5rsP1TsSF+ZuIaL+Rkk6oHE6D5PCBg2u
	 Iw1K8sGpU1MKNX3Jp5RAX76ZeOzwm6tPID8qygJbVga5Gb+GfmCyCzuQJR+T9dGhF/
	 Y2rEejPI57IEqk7K2PsSbO6IROHT6ouMY/w7MdGx3psB4wklKlRUCGWLhC1bsgbP4L
	 6nvMqom9I/HJQ==
Date: Tue, 15 Aug 2023 09:59:32 +0200
From: Simon Horman <horms@kernel.org>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, netfilter-devel@vger.kernel.org,
	linux-sctp@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCH nf] netfilter: set default timeout to 3 secs for sctp
 shutdown send and recv state
Message-ID: <ZNswZDSxsFHbrq/5@vergenet.net>
References: <4e2e8aad9c4646ec3a51833cbbf95a006a98b756.1691945735.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e2e8aad9c4646ec3a51833cbbf95a006a98b756.1691945735.git.lucien.xin@gmail.com>

On Sun, Aug 13, 2023 at 12:55:35PM -0400, Xin Long wrote:
> In SCTP protocol, it is using the same timer (T2 timer) for SHUTDOWN and
> SHUTDOWN_ACK retransmission. However in sctp conntrack the default timeout
> value for SCTP_CONNTRACK_SHUTDOWN_ACK_SENT state is 3 secs while it's 300
> msecs for SCTP_CONNTRACK_SHUTDOWN_SEND/RECV state.
> 
> As Paolo Valerio noticed, this might cause unwanted expiration of the ct
> entry. In my test, with 1s tc netem delay set on the NAT path, after the
> SHUTDOWN is sent, the sctp ct entry enters SCTP_CONNTRACK_SHUTDOWN_SEND
> state. However, due to 300ms (too short) delay, when the SHUTDOWN_ACK is
> sent back from the peer, the sctp ct entry has expired and been deleted,
> and then the SHUTDOWN_ACK has to be dropped.
> 
> Also, it is confusing these two sysctl options always show 0 due to all
> timeout values using sec as unit:
> 
>   net.netfilter.nf_conntrack_sctp_timeout_shutdown_recd = 0
>   net.netfilter.nf_conntrack_sctp_timeout_shutdown_sent = 0
> 
> This patch fixes it by also using 3 secs for sctp shutdown send and recv
> state in sctp conntrack, which is also RTO.initial value in SCTP protocol.
> 
> Note that the very short time value for SCTP_CONNTRACK_SHUTDOWN_SEND/RECV
> was probably used for a rare scenario where SHUTDOWN is sent on 1st path
> but SHUTDOWN_ACK is replied on 2nd path, then a new connection started
> immediately on 1st path. So this patch also moves from SHUTDOWN_SEND/RECV
> to CLOSE when receiving INIT in the ORIGINAL direction.
> 
> Fixes: 9fb9cbb1082d ("[NETFILTER]: Add nf_conntrack subsystem.")
> Reported-by: Paolo Valerio <pvalerio@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


