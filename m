Return-Path: <netdev+bounces-37673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 026247B6944
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 14:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A83C528158E
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 12:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C92821361;
	Tue,  3 Oct 2023 12:44:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2C61F934
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 12:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7789CC433C7;
	Tue,  3 Oct 2023 12:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696337092;
	bh=yxVFqdrVypVYPhUgP12T4SsGPkXaA4vzqa7NeiFSR9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M0i4klhBXUIXUlg47tK0NRlTedyhHHdA8YYeevRcp1em7QNl37cFoRiT09JUuHAUL
	 2+M+SNVyeHFBJB83Kdwe+NgXCXeznXXPiWUkH/4O3GbcpW2iUNYxvhTI5CSYlvGggr
	 TBJHhRq53IcM0BHSRxI880efmAs/RoabBsEgEA3IKd5GR4uaFSSwLI3j1ivaRhwSyc
	 2DK/S0gqAmq3REMhlNcBFn100K10pcBjNF8+8van2GMGRq1ZdF+dAZroOeIEiYcnzD
	 JOiVbo0QITiuBTMCjCpAtLrOkTJiB6w0dNtxsUbO5ukafcpcFRRAV2vOF/5nXKDAa3
	 epvChKHD2eRrQ==
Date: Tue, 3 Oct 2023 14:44:48 +0200
From: Simon Horman <horms@kernel.org>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, netfilter-devel@vger.kernel.org,
	linux-sctp@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCH nf] netfilter: handle the connecting collision properly
 in nf_conntrack_proto_sctp
Message-ID: <ZRwMwFgCCM3nMeBG@kernel.org>
References: <6ee630f777cada3259b29e732e7ea9321a99197b.1696172868.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ee630f777cada3259b29e732e7ea9321a99197b.1696172868.git.lucien.xin@gmail.com>

On Sun, Oct 01, 2023 at 11:07:48AM -0400, Xin Long wrote:
> In Scenario A and B below, as the delayed INIT_ACK always changes the peer
> vtag, SCTP ct with the incorrect vtag may cause packet loss.
> 
> Scenario A: INIT_ACK is delayed until the peer receives its own INIT_ACK
> 
>   192.168.1.2 > 192.168.1.1: [INIT] [init tag: 1328086772]
>     192.168.1.1 > 192.168.1.2: [INIT] [init tag: 1414468151]
>     192.168.1.2 > 192.168.1.1: [INIT ACK] [init tag: 1328086772]
>   192.168.1.1 > 192.168.1.2: [INIT ACK] [init tag: 1650211246] *
>   192.168.1.2 > 192.168.1.1: [COOKIE ECHO]
>     192.168.1.1 > 192.168.1.2: [COOKIE ECHO]
>     192.168.1.2 > 192.168.1.1: [COOKIE ACK]
> 
> Scenario B: INIT_ACK is delayed until the peer completes its own handshake
> 
>   192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
>     192.168.1.1 > 192.168.1.2: sctp (1) [INIT] [init tag: 144230885]
>     192.168.1.2 > 192.168.1.1: sctp (1) [INIT ACK] [init tag: 3922216408]
>     192.168.1.1 > 192.168.1.2: sctp (1) [COOKIE ECHO]
>     192.168.1.2 > 192.168.1.1: sctp (1) [COOKIE ACK]
>   192.168.1.1 > 192.168.1.2: sctp (1) [INIT ACK] [init tag: 3914796021] *
> 
> This patch fixes it as below:
> 
> In SCTP_CID_INIT processing:
> - clear ct->proto.sctp.init[!dir] if ct->proto.sctp.init[dir] &&
>   ct->proto.sctp.init[!dir]. (Scenario E)
> - set ct->proto.sctp.init[dir].
> 
> In SCTP_CID_INIT_ACK processing:
> - drop it if !ct->proto.sctp.init[!dir] && ct->proto.sctp.vtag[!dir] &&
>   ct->proto.sctp.vtag[!dir] != ih->init_tag. (Scenario B, Scenario C)
> - drop it if ct->proto.sctp.init[dir] && ct->proto.sctp.init[!dir] &&
>   ct->proto.sctp.vtag[!dir] != ih->init_tag. (Scenario A)
> 
> In SCTP_CID_COOKIE_ACK processing:
> - clear ct->proto.sctp.init[dir] and ct->proto.sctp.init[!dir]. (Scenario D)
> 
> Also, it's important to allow the ct state to move forward with cookie_echo
> and cookie_ack from the opposite dir for the collision scenarios.
> 
> There are also other Scenarios where it should allow the packet through,
> addressed by the processing above:
> 
> Scenario C: new CT is created by INIT_ACK.
> 
> Scenario D: start INIT on the existing ESTABLISHED ct.
> 
> Scenario E: start INIT after the old collision on the existing ESTABLISHED ct.
> 
>   192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
>   192.168.1.1 > 192.168.1.2: sctp (1) [INIT] [init tag: 144230885]
>   (both side are stopped, then start new connection again in hours)
>   192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 242308742]
> 
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Hi,

as a fix I wonder if this warrants a Fixes tag.
Perhaps our old friend:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

