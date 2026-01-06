Return-Path: <netdev+bounces-247231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C73F9CF6127
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 01:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4122930060F5
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 00:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CD94503B;
	Tue,  6 Jan 2026 00:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sa/Tgktj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5293A1E86;
	Tue,  6 Jan 2026 00:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767658965; cv=none; b=YBtF9KLm8mkScgwZUUx0Mgyd6Qk5zv5sq158mwGP2VkmXuNgFsXvpaoAIJ944SSD3vc5+oNstf5fgL7OitMCFH6hozYSt5tEsAf7NogabPzbfA0boRqWrjDFb8acp1ZROfR8p95rgm+AI2vpKj1JuOhOOFHx7vYm6bMa4iq7mss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767658965; c=relaxed/simple;
	bh=D6OZRQFDcWX1zT2uhcCdp99VT1aTjjK+UclDYgARu/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1amwtLqLgo6vG/LnxnPsZze8u+xXCD/GJb9liuABHpqm+xwEOqYNEGWtWArEb6j8JUwYWn1MirRGm6YZwqCtYuVGuKlulSF7+xJf6T7ykrlJob8YX3uS+d74kp4thT444ln3LqWfR9BkCjqIC1qePePeQOjSoSm8YGAWJPtBCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sa/Tgktj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC5CC116D0;
	Tue,  6 Jan 2026 00:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767658965;
	bh=D6OZRQFDcWX1zT2uhcCdp99VT1aTjjK+UclDYgARu/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sa/TgktjQOUlAbwB55HQ2RjVxF+Op5eFY0BmGNqL8FRi9sv0FewHzNItuTCApQDOl
	 2+YosG52iyiPlrVcAtAqIYSzTQmFODg+3UhTjkTeCX74h8XG96o6+jY0PIAi5wbNCT
	 zFjvE3a3n3Pt78cUrLzhVbK5j2JgeP4CUhnRXHr4stj3rrM20TtqvCsOIDlalX5Cr3
	 VLWFd3MZq2X9SAMR1zva02ZkZMHQyu/Z5aZq5TyKxQoij2D38/ZmoSEKWPn6E4ri50
	 bjZpvgnm11hybwYQKNk6A5xQ8LWX+V7Nmn18Qe2UmqEJ5WDD868vGi2eNt2M8SxgY5
	 Ba+swgSbYSJcQ==
Date: Mon, 5 Jan 2026 16:22:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Chen Zhen <chenzhen126@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <huyizhen2@huawei.com>,
 <gaoxingwang1@huawei.com>
Subject: Re: [PATCH net] net: vlan: set header_ops to match hard_header_len
 when hw offload is toggled
Message-ID: <20260105162243.59e72816@kernel.org>
In-Reply-To: <20251231035419.23422-1-chenzhen126@huawei.com>
References: <20251231035419.23422-1-chenzhen126@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Dec 2025 11:54:19 +0800 Chen Zhen wrote:
> skbuff: skb_under_panic: text:ffffffff95b33e66 len:90 put:14 head:ffff915ac1967440 data:ffff915ac196743e tail:0x58 end:0x180 dev:br0.10
> ------------[ cut here ]------------
> kernel BUG at net/core/skbuff.c:197!
> Call Trace:
>  <TASK>
>  skb_push+0x39/0x40
>  eth_header+0x26/0xb0
>  vlan_dev_hard_header+0x58/0x130 [8021q]
>  neigh_connected_output+0xae/0x100
>  ip6_finish_output2+0x2cc/0x650
>  ? nf_hook_slow+0x41/0xc0
>  ip6_finish_output+0x27/0xd0
>  ndisc_send_skb+0x1d0/0x370
>  ? __pfx_dst_output+0x10/0x10
>  ndisc_send_ns+0x5a/0xb0
>  addrconf_dad_work+0x2b5/0x380
>  process_one_work+0x17f/0x320

Please run this stack trace thru script/decode_stacktrace
and you can cut off here, no need to include functions
below process_one_work, they are irrelevant.

>  worker_thread+0x26d/0x2f0
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0xcc/0x100
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x30/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1b/0x30
>  </TASK>
> 
> This bug can be easily reproduced by these steps:
> 
>  ip link add veth0 type veth peer name veth1
>  ip link set veth0 up
>  ip link set veth1 up
>  ethtool -K veth0 tx-vlan-hw-insert off
>  # vlandev.header_ops = vlan_header_ops, hard_header_len = 18(hard_header_len + VLAN_HLEN)
>  ip link add link veth0 name veth0.10 type vlan id 10 reorder_hdr off
>  ip addr add 192.168.10.1/24 dev veth0.10
>  ip link set veth0.10 up
>  # vlandev.hard_header_len = 14(hard_header_len)
>  ethtool -K veth0 tx-vlan-hw-insert on
>  # Panic!

Instead of putting this in the commit message please add a selftest
which will automatically catch re-occurrence of the issue.

> The reason is that when NETIF_F_HW_VLAN_CTAG_TX is off, vlandev.hard_header_len will be set to
> dev->hard_header_len since commit 029f5fc31cdb ("8021q: set hard_header_len when VLAN offload features
> are toggled"), but the header_ops remains unchanged. Then neigh_connected_output() will call
> vlan_dev_hard_header() and panic in skb_push() because reorder_hdr is off.

Please wrap commit messages at 70 columns.
-- 
pw-bot: cr

