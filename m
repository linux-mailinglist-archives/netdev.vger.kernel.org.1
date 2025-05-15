Return-Path: <netdev+bounces-190583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBB8AB7B17
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 03:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90CD93BB3FA
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 01:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A504A27A92E;
	Thu, 15 May 2025 01:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7umvand"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBEC27A458
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 01:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747273504; cv=none; b=XTUo9Nw5aDwKmSeMjjK640z9YQsY/8bvBk3dFZiO1tDytIWSrY4OMSKtm0b+uwP7nnmOzRA83siU49+Ge8yZhkGu1JuonK3KA6kzE+00VgUUoETUNdyze0Gf+glbaPXAcT5HN1tt6eRsRJRBnwBKQ+DmfMHvfRzRjyLlbbRB4c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747273504; c=relaxed/simple;
	bh=j9GIg/igXjykx8jaONqIvDfRxriM6ZmhLmLXUcEJkUs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QnCZPe2cpR0h6SCYEboVfUkwgDORO1zjrH1QluOpaE3Mk7ha8So/63dQOjVl9Eu91huuL/GC+T4wW34vGzI+0mSLC93psSsFdkg/rOgb0icI4Gb4GaQEbfnzSiTrjrNTPQX49puzADl82eZsRi9TMMaUyJIW1Y8puzqyXB6mE7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7umvand; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9C0C4CEE3;
	Thu, 15 May 2025 01:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747273504;
	bh=j9GIg/igXjykx8jaONqIvDfRxriM6ZmhLmLXUcEJkUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h7umvandJC1wZYofVeI5ryUsPRUdXhYqaPneiryF7K9kSibDeW+PCJWloaHOW2Ugf
	 qIFwdFQrIWscnbBVftRN/+1VVwqeBPWEShZAZrw4s3JJf9glfmiILFjm/muONU+Tdf
	 hOBvmmmlXYy6ZHTiQVouNgYoWQVZgkrhvNvO+SZsqynVarcc1x2kYU5wdRkCPMLYvL
	 7i5WNrIcJoMhgeOSg9riqXe1jOB4B1oqhViyQu/EYWqa2lbpHHiAheGuUuUh4uB7/g
	 95pAxSyu3AIAs7OCtpHtSkdD2wZE6A/1QoVs8dNbzKKQfWjYu/FkZlq6xxotx48mI3
	 84YBwLoXVxuCg==
Date: Wed, 14 May 2025 18:45:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, "Paolo Abeni"
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 0/7] ipv6: Follow up for RTNL-free
 RTM_NEWROUTE series.
Message-ID: <20250514184502.22f4c4e6@kernel.org>
In-Reply-To: <20250514201943.74456-1-kuniyu@amazon.com>
References: <20250514201943.74456-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 May 2025 13:18:53 -0700 Kuniyuki Iwashima wrote:
> Patch 1 removes rcu_read_lock() in fib6_get_table().
> Patch 2 removes rtnl_is_held arg for lwtunnel_valid_encap_type(), which
>  was short-term fix and is no longer used.
> Patch 3 fixes RCU vs GFP_KERNEL report by syzkaller.
> Patch 4~7 reverts GFP_ATOMIC uses to GFP_KERNEL.

Hi! Something in the following set of patches is making our CI time out.
The problem seems to be:

[    0.751266] virtme-init: waiting for udev to settle
Timed out for waiting the udev queue being empty.
[  120.826428] virtme-init: udev is done

+team: grab team lock during team_change_rx_flags
+net: mana: Add handler for hardware servicing events
+ipv6: Revert two per-cpu var allocation for RTM_NEWROUTE.
+ipv6: Pass gfp_flags down to ip6_route_info_create_nh().
+Revert "ipv6: Factorise ip6_route_multipath_add()."
+Revert "ipv6: sr: switch to GFP_ATOMIC flag to allocate memory during seg6local LWT setup"
+ipv6: Narrow down RCU critical section in inet6_rtm_newroute().
+inet: Remove rtnl_is_held arg of lwtunnel_valid_encap_type(_attr)?().
+ipv6: Remove rcu_read_lock() in fib6_get_table().
+net/mlx5e: Reuse per-RQ XDP buffer to avoid stack zeroing overhead
 amd-xgbe: read link status twice to avoid inconsistencies
+net: phy: fixed_phy: remove fixed_phy_register_with_gpiod
 drivers: net: mvpp2: attempt to refill rx before allocating skb
+selftest: af_unix: Test SO_PASSRIGHTS.
+af_unix: Introduce SO_PASSRIGHTS.
+af_unix: Inherit sk_flags at connect().
+af_unix: Move SOCK_PASS{CRED,PIDFD,SEC} to struct sock.
+net: Restrict SO_PASS{CRED,PIDFD,SEC} to AF_{UNIX,NETLINK,BLUETOOTH}.
+tcp: Restrict SO_TXREHASH to TCP socket.
+scm: Move scm_recv() from scm.h to scm.c.
+af_unix: Don't pass struct socket to maybe_add_creds().
+af_unix: Factorise test_bit() for SOCK_PASSCRED and SOCK_PASSPIDFD.

I haven't dug into it, gotta review / apply other patches :(
Maybe you can try to repro? 

