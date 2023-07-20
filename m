Return-Path: <netdev+bounces-19421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6CD75A996
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 10:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32339281DB2
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 08:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3579A380;
	Thu, 20 Jul 2023 08:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A826F361
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 720F0C433C8;
	Thu, 20 Jul 2023 08:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689843021;
	bh=HiymFkzn2VlYD4erRYjbfat/dY8f93cmuvR+0otyWxs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ifUlMrsbt+YcgBYzM30q1vFPtQuhbtGKxS9M8FqfreP4wpGVEv66nhkhmZO136qNU
	 P48X3xm1ksR1mRoJ85uWBgn6WGoBthjYVQFZEPsLXea143gc0OOhQvdXyYhNalofci
	 4Vdk8n6fdVjrcGH+hNXgRTo97IuWQD/QoceW72zjNHO9Nbu2ms+bksvi3AiXtAKQxc
	 cR6fVL5gIDmGDeH5W8DLfm5Idyw4GLlOsjM0VI3babvmpde1dXr+xGycBBwBeIiZDG
	 6eCwrEwxyvmkr+8KcjGwIzCEy84CBEq3GRH5GcxFPBYTNd1S82ORM1EGFRUuKHZPzv
	 F8WsUQ6ZTvEWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A177E21EF6;
	Thu, 20 Jul 2023 08:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/4] net: Support STP on bridge in non-root netns.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168984302136.20786.4393470788080951518.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jul 2023 08:50:21 +0000
References: <20230718174152.57408-1-kuniyu@amazon.com>
In-Reply-To: <20230718174152.57408-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, roopa@nvidia.com, razor@blackwall.org,
 ebiederm@xmission.com, hcoin@quietfountain.com, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 18 Jul 2023 10:41:48 -0700 you wrote:
> Currently, STP does not work in non-root netns as llc_rcv() drops
> packets from non-root netns.
> 
> This series fixes it by making some protocol handlers netns-aware,
> which are called from llc_rcv() as follows:
> 
>   llc_rcv()
>   |
>   |- sap->rcv_func : registered by llc_sap_open()
>   |
>   |  * functions : regsitered by register_8022_client()
>   |    -> No in-kernel user call register_8022_client()
>   |
>   |  * snap_rcv()
>   |    |
>   |    `- proto->rcvfunc() : registered by register_snap_client()
>   |
>   |       * aarp_rcv()  : drop packets from non-root netns
>   |       * atalk_rcv() : drop packets from non-root netns
>   |
>   |  * stp_pdu_rcv()
>   |    |
>   |    `- garp_protos[]->rcv() : registered by stp_proto_register()
>   |
>   |       * garp_pdu_rcv() : netns-aware
>   |       * br_stp_rcv()   : netns-aware
>   |
>   |- llc_type_handlers[llc_pdu_type(skb) - 1]
>   |
>   |  * llc_sap_handler()  : NOT netns-aware (Patch 1)
>   |  * llc_conn_handler() : NOT netns-aware (Patch 2)
>   |
>   `- llc_station_handler
> 
> [...]

Here is the summary with links:
  - [v2,net,1/4] llc: Check netns in llc_dgram_match().
    https://git.kernel.org/netdev/net/c/9b64e93e83c2
  - [v2,net,2/4] llc: Check netns in llc_estab_match() and llc_listener_match().
    https://git.kernel.org/netdev/net/c/97b1d320f48c
  - [v2,net,3/4] llc: Don't drop packet from non-root netns.
    https://git.kernel.org/netdev/net/c/6631463b6e66
  - [v2,net,4/4] Revert "bridge: Add extack warning when enabling STP in netns."
    https://git.kernel.org/netdev/net/c/7ebd00a5a20c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



