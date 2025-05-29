Return-Path: <netdev+bounces-194189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBA6AC7BBB
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 12:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531A04E19A3
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 10:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA7A227E86;
	Thu, 29 May 2025 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYgZ1oot"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BEC226CF4;
	Thu, 29 May 2025 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748514498; cv=none; b=WOHfIwCsIKfQm599cBUWc60k9aKTQZReiab3V1zXx3ATCItfahu4bPfUcjS3OsV4gifh4T3RBbu9MReVA0Cb68g049ZO0GAdaothfYflQn01RvLFkQVqSfc9wOWXOZnhV2e/KHTUZuFyDwpJ2QSFMC2p2uLdqgMziFrIgZIcf0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748514498; c=relaxed/simple;
	bh=oZNH2VSpnTfpJCZrWcUJQiqZm62W1HZxvQPvid5zsBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWHVftE3twwTgkTKfQ9Crhb302To1TBCAKpFPxOh/RHsFLiBXzSRPWUmwKwLE+ke0h7z7MYugJq9QJ/4UYcCH6BoKGrtI4azKpaHvcRdxPosvJ7EW3DoQVQq5vk0h2jNaO+nv+5F9rAE/L1EDPFI8M7J+qIByeRF9FoO1FjLlH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYgZ1oot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F72C4CEE7;
	Thu, 29 May 2025 10:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748514497;
	bh=oZNH2VSpnTfpJCZrWcUJQiqZm62W1HZxvQPvid5zsBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tYgZ1ootQs40l8ImVx808zn3WUPRC6a8TjUMe76HuYjcg42e1MPKuU/riTGBLf1hS
	 2MwS714D5CikiGXmHpz17CPWLM39Q5JWxe4CJIknDQGT/5tx8Zoccq3Ktblv57cj7D
	 MlNxScsyLmam0JbzTT4YW8V/KGwtM0mJk7Z3ruV//yRESIYs6GRwmsBdk4Jo0l4cmX
	 6MxLmPJl8So6vK6IioztPMB9035j34KXG43RwcF2HUYJ4z+PRu2FmwrJyS+vHXu9gH
	 62cz1PPWsytgNUpTngAhhgVy0PSfGXSchTC3AU2x21AlsVKb1Ju4J/Y58txBdwhhh2
	 Axy3C6gIl4FxA==
Date: Thu, 29 May 2025 11:28:12 +0100
From: Simon Horman <horms@kernel.org>
To: Shiming Cheng <shiming.cheng@mediatek.com>
Cc: willemdebruijn.kernel@gmail.com, willemb@google.com,
	edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, matthias.bgg@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	lena.wang@mediatek.com
Subject: Re: [PATCH net v5] net: fix udp gso skb_segment after pull from
 frag_list
Message-ID: <20250529102812.GL1484967@horms.kernel.org>
References: <20250529015901.3814-1-shiming.cheng@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529015901.3814-1-shiming.cheng@mediatek.com>

On Thu, May 29, 2025 at 09:58:56AM +0800, Shiming Cheng wrote:
> Commit a1e40ac5b5e9 ("net: gso: fix udp gso fraglist segmentation after
> pull from frag_list") detected invalid geometry in frag_list skbs and
> redirects them from skb_segment_list to more robust skb_segment. But some
> packets with modified geometry can also hit bugs in that code. We don't
> know how many such cases exist. Addressing each one by one also requires
> touching the complex skb_segment code, which risks introducing bugs for
> other types of skbs. Instead, linearize all these packets that fail the
> basic invariants on gso fraglist skbs. That is more robust.
> 
> If only part of the fraglist payload is pulled into head_skb, it will
> always cause exception when splitting skbs by skb_segment. For detailed
> call stack information, see below.
> 
> Valid SKB_GSO_FRAGLIST skbs
> - consist of two or more segments
> - the head_skb holds the protocol headers plus first gso_size
> - one or more frag_list skbs hold exactly one segment
> - all but the last must be gso_size
> 
> Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can
> modify fraglist skbs, breaking these invariants.
> 
> In extreme cases they pull one part of data into skb linear. For UDP,
> this  causes three payloads with lengths of (11,11,10) bytes were
> pulled tail to become (12,10,10) bytes.
> 
> The skbs no longer meets the above SKB_GSO_FRAGLIST conditions because
> payload was pulled into head_skb, it needs to be linearized before pass
> to regular skb_segment.
> 
>     skb_segment+0xcd0/0xd14
>     __udp_gso_segment+0x334/0x5f4
>     udp4_ufo_fragment+0x118/0x15c
>     inet_gso_segment+0x164/0x338
>     skb_mac_gso_segment+0xc4/0x13c
>     __skb_gso_segment+0xc4/0x124
>     validate_xmit_skb+0x9c/0x2c0
>     validate_xmit_skb_list+0x4c/0x80
>     sch_direct_xmit+0x70/0x404
>     __dev_queue_xmit+0x64c/0xe5c
>     neigh_resolve_output+0x178/0x1c4
>     ip_finish_output2+0x37c/0x47c
>     __ip_finish_output+0x194/0x240
>     ip_finish_output+0x20/0xf4
>     ip_output+0x100/0x1a0
>     NF_HOOK+0xc4/0x16c
>     ip_forward+0x314/0x32c
>     ip_rcv+0x90/0x118
>     __netif_receive_skb+0x74/0x124
>     process_backlog+0xe8/0x1a4
>     __napi_poll+0x5c/0x1f8
>     net_rx_action+0x154/0x314
>     handle_softirqs+0x154/0x4b8
> 
>     [118.376811] [C201134] rxq0_pus: [name:bug&]kernel BUG at net/core/skbuff.c:4278!
>     [118.376829] [C201134] rxq0_pus: [name:traps&]Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
>     [118.470774] [C201134] rxq0_pus: [name:mrdump&]Kernel Offset: 0x178cc00000 from 0xffffffc008000000
>     [118.470810] [C201134] rxq0_pus: [name:mrdump&]PHYS_OFFSET: 0x40000000
>     [118.470827] [C201134] rxq0_pus: [name:mrdump&]pstate: 60400005 (nZCv daif +PAN -UAO)
>     [118.470848] [C201134] rxq0_pus: [name:mrdump&]pc : [0xffffffd79598aefc] skb_segment+0xcd0/0xd14
>     [118.470900] [C201134] rxq0_pus: [name:mrdump&]lr : [0xffffffd79598a5e8] skb_segment+0x3bc/0xd14
>     [118.470928] [C201134] rxq0_pus: [name:mrdump&]sp : ffffffc008013770
> 
> Fixes: a1e40ac5b5e9 ("net: gso: fix udp gso fraglist segmentation after pull from frag_list")

nit: This may not be important, but I believe that "net :" doesn't appear
     in the subject of the cited patch in git history.

     That is, I think this should be:

Fixes: a1e40ac5b5e9 ("gso: fix udp gso fraglist segmentation after pull from frag_list")


> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>

...

