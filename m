Return-Path: <netdev+bounces-47129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3917E821C
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 20:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B01C0B20BB1
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 19:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5563A29D;
	Fri, 10 Nov 2023 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPQgb5Jl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029DA2BCF7
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 19:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C71C433C7;
	Fri, 10 Nov 2023 19:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699642803;
	bh=6EnUes9wTH1mI2Pr2tlR3oBu4IGmtLezlfYoFlsdZ8E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OPQgb5JlaM+x+2Dekdbo9oDYHDwX+9NJoWCXpqAcb2qbcBvv6DKNY4REflr39/OI9
	 tCehhLFF5L1w7+0uX9RZ7L7U2vs9oKfPcBdVQqpq2mah3RWHtRoP/9hF6ZoFhTlCje
	 BYOAtl8GTJgprK6sQaYUMCU28cHAR06bcF+NZ2FE00nXeTldDyvXJS6RSgH/yJDfi1
	 QACKelD8f/asbPLLZw9PPl7zuDnB2Ps/x53rFnBjn3wkzrtd1V4cyDsmImhynte/Sw
	 gDbO2DEwjgrEtlqlOtMS325TvL5M3c15/JFMMfLwegUxc4YDhADHX+cqNmejuKsMCw
	 TSlIXA71e7OZA==
Date: Fri, 10 Nov 2023 11:00:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Jong eon Park" <jongeon.park@samsung.com>
Cc: "'Paolo Abeni'" <pabeni@redhat.com>, "'David S. Miller'"
 <davem@davemloft.net>, "'Eric Dumazet'" <edumazet@google.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "'Dong ha Kang'"
 <dongha7.kang@samsung.com>
Subject: Re: [PATCH] netlink: introduce netlink poll to resolve fast return
 issue
Message-ID: <20231110110002.7279f895@kernel.org>
In-Reply-To: <000001da13e5$d9b99e30$8d2cda90$@samsung.com>
References: <CGME20231103072245epcas1p4471a31e9f579e38501c8c856d3ca2a77@epcas1p4.samsung.com>
	<20231103072209.1005409-1-jongeon.park@samsung.com>
	<20231106154812.14c470c2@kernel.org>
	<25c501da111e$d527b010$7f771030$@samsung.com>
	<20231107085347.75bc3802@kernel.org>
	<000001da13e5$d9b99e30$8d2cda90$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Nov 2023 23:54:48 +0900 Jong eon Park wrote:
> Interestingly, in this issue, even though netlink overrun frequently 
> happened and caused POLLERRs, the user was managing it well through 
> POLLIN and 'recv' function without a specific POLLERR handler. 
> However, in the current situation, rcv queue is already empty and 
> NETLINK_S_CONGESTED flag prevents any more incoming packets. This makes 
> it impossible for the user to call 'recv'.
> 
> This "congested" situation is a bit ambiguous. The queue is empty, yet 
> 'congested' remains. This means kernel can no longer deliver uevents 
> despite the empty queue, and it lead to the persistent 'congested' status.
> 
> The reason for the difference in netlink lies in the NETLINK_S_CONGESTED 
> flag. If it were UDP, upon seeing the empty queue, it might have kept 
> pushing the received packets into the queue (making possible to call 
> 'recv').

I see, please add a comment saying that NETLINK_S_CONGESTED prevents
new skbs from being queued before the new test in netlink_poll().

Please repost next week (i.e. after the merge window) with subject
tagged [PATCH net-next v2].

