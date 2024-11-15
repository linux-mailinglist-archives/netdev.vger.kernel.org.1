Return-Path: <netdev+bounces-145285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 122679CE124
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 15:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA5BFB31192
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 14:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBE71CDA17;
	Fri, 15 Nov 2024 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWGiNdqB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93D31CDA01
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679211; cv=none; b=VWsXXc9GEWyWd7Xu+mPIerAaPws2EltsDUGlhsIMvTlArO5sv+yv9rKCyuXUU+Oq/jaH8bQ8igg+ZixPnzrblcn5MWJ0nuf+FkEyTerrnECfb2eBchmYRPb7IoBvG5iwmphwgv3WZn2B14GGYxSThsyRurs0xSaHoXIEx0EJwZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679211; c=relaxed/simple;
	bh=cDTGqtS1AKIP3lkfdXu9ux5QgqKEtKYAiVT3MnFvGUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=je1FpZ8QZ98Izmvptjv+FneSicw5dVHPZo0iOEk/22SGjluX+wKyYK9PUE82ry47fyQTUgilR26sEYwNTL26UdwXygQmOkmbHrgwggrQtCDGs+uX9fYFmPH1CgfqO2Nfk78bDQVefxTXdyTYZuoRoLIDwL96EWJoue7Il9Tnp0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWGiNdqB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00A9C4CECF;
	Fri, 15 Nov 2024 14:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731679211;
	bh=cDTGqtS1AKIP3lkfdXu9ux5QgqKEtKYAiVT3MnFvGUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FWGiNdqBN4gujMzL1tvmI7Zl3ZzhzDzFLJYhZLJrG6c5dCdywWnY5G7SnUgakL/Ou
	 OzfZ4rd15q6pC16JUGQAqaa2aKe1OxwqbJ8fNi4+OMLp2/DAwvcGAVsMbUCnkSdInk
	 zQWgNQ/3VjUysd96s/8KEVwbaTS+srj/aiU3o/BzKssRcqfqRy54W1Cb4KA5lBO9lc
	 UDH8n8VLSBxqoYJVzEBQ1g5s0sUaJI0WgJ317nXvBf2a0fwF1WYevMgYH83Ng0kdOV
	 Iy4GUOYV4gubb7TbS7Pjus6MQMBjfz1QBp/vaQDR741IwqTi2QskWI2gjYeWoKPaFj
	 wcF2QIqSXYKNQ==
Date: Fri, 15 Nov 2024 14:00:07 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com,
	syzbot+d4373fa8042c06cefa84@syzkaller.appspotmail.com,
	dsahern@kernel.org
Subject: Re: [PATCH net 1/2] netlink: fix false positive warning in extack
 during dumps
Message-ID: <20241115140007.GR1062410@kernel.org>
References: <20241115003150.733141-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115003150.733141-1-kuba@kernel.org>

On Thu, Nov 14, 2024 at 04:31:49PM -0800, Jakub Kicinski wrote:
> Commit under fixes extended extack reporting to dumps.
> It works under normal conditions, because extack errors are
> usually reported during ->start() or the first ->dump(),
> it's quite rare that the dump starts okay but fails later.
> If the dump does fail later, however, the input skb will
> already have the initiating message pulled, so checking
> if bad attr falls within skb->data will fail.
> 
> Switch the check to using nlh, which is always valid.
> 
> syzbot found a way to hit that scenario by filling up
> the receive queue. In this case we initiate a dump
> but don't call ->dump() until there is read space for
> an skb.
> 
> RIP: 0010:netlink_ack_tlv_fill+0x1a8/0x560 net/netlink/af_netlink.c:2209
> Call Trace:
>  <TASK>
>  netlink_dump_done+0x513/0x970 net/netlink/af_netlink.c:2250
>  netlink_dump+0x91f/0xe10 net/netlink/af_netlink.c:2351
>  netlink_recvmsg+0x6bb/0x11d0 net/netlink/af_netlink.c:1983
>  sock_recvmsg_nosec net/socket.c:1051 [inline]
>  sock_recvmsg+0x22f/0x280 net/socket.c:1073
>  __sys_recvfrom+0x246/0x3d0 net/socket.c:2267
>  __do_sys_recvfrom net/socket.c:2285 [inline]
>  __se_sys_recvfrom net/socket.c:2281 [inline]
>  __x64_sys_recvfrom+0xde/0x100 net/socket.c:2281
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  RIP: 0033:0x7ff37dd17a79
> 
> Reported-by: syzbot+d4373fa8042c06cefa84@syzkaller.appspotmail.com
> Fixes: 8af4f60472fc ("netlink: support all extack types in dumps")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: dsahern@kernel.org
> ---
>  include/net/netlink.h    | 13 +++++++++++++
>  net/netlink/af_netlink.c | 13 +++++--------
>  2 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/netlink.h b/include/net/netlink.h
> index db6af207287c..efd906aff22f 100644
> --- a/include/net/netlink.h
> +++ b/include/net/netlink.h
> @@ -659,6 +659,19 @@ nlmsg_next(const struct nlmsghdr *nlh, int *remaining)
>  	return (struct nlmsghdr *) ((unsigned char *) nlh + totlen);
>  }
>  
> +/**
> + * nlmsg_addr_in_payload - address points to a byte within the message payload
> + * @nlh: netlink message header

nit: something about @addr should go here.

> + *
> + * Returns: true if address is within the payload of the message
> + */
> +static inline bool nlmsg_addr_in_payload(const struct nlmsghdr *nlh,
> +					 const void *addr)
> +{
> +	return addr >= nlmsg_data(nlh) &&
> +		addr - (const void *) nlh < nlh->nlmsg_len;
> +}
> +
>  /**
>   * nla_parse - Parse a stream of attributes into a tb buffer
>   * @tb: destination array with maxtype+1 elements

Otherwise, LGTM.

