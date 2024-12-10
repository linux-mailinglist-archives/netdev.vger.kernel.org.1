Return-Path: <netdev+bounces-150723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FBD9EB424
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA96C2811FB
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBBE1B85D3;
	Tue, 10 Dec 2024 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEeuwa5K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079C71B85C2
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842775; cv=none; b=av4cNsM2WHY6dD8i9MxnTbwCllP5f+w3Z2u6fCzXlCJ967v8I4B+0nwrGgDVvmc50P8FhnUl8zOLcQcxb/Mxp8Oq79SWfe68DG4+bMwvhlyvLlpXi81mGULzwAwuoxKWmQX0TRbFn3P777nJlfzZlnj7G+LLaWQDtPISStgFB1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842775; c=relaxed/simple;
	bh=ZDw6LCM1u7OLn5QVjJD4sW+N5q2OjqIvp6c9RvNl9vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOLQvXD8CYMY3/cYLE4X7vH/bs8GJSpdRGqNTm9t8r2naOjEaXKlou6uzAvKaR0Cxcyr1HlYEaDyCl+7PbaljFI1cu6pGJ+MYVCHO/JePulCSPkJym4QEN5JUeFRGtUP/v1JRoku5xLKDz0WK8m9REBsrLCXpIn38oMrDnd2jF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEeuwa5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65329C4CEDE;
	Tue, 10 Dec 2024 14:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733842774;
	bh=ZDw6LCM1u7OLn5QVjJD4sW+N5q2OjqIvp6c9RvNl9vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aEeuwa5KZh07b39hZQH33qx3aXB+Hi7OjmhoITc9t29b+xJm9Q2PB/kBf2lEqStO2
	 TzSS506mQ10vSqBn/wAPgl0XHHCUx9H6CmfrCMvdWopnUHklXdXrGYCwrT6MI3rSsF
	 0uAzDS3JGo8+j6K6nYW382HQzeJR2uLU3JnuqX7oDC3pBtmqix48nv4aO+Rgd0Hu/a
	 dmscQRFmw8GLcmCzm0BK0PxAFbBBCjw6NgM/Hk8KrMCh9ZklXPCF6szFmbm0apz1Uo
	 TgbaU8DIe18op0ltmEiBqzgob1lxhBKRoc1MAlyQ0MO2inIhZ/x1dOOeaNvdkQFBBR
	 7k5PaaIKzL+iw==
Date: Tue, 10 Dec 2024 14:59:30 +0000
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net] bnxt_en: Fix aggregation ID mask to prevent oops on
 5760X chips
Message-ID: <20241210145930.GF4202@kernel.org>
References: <20241209015448.1937766-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209015448.1937766-1-michael.chan@broadcom.com>

On Sun, Dec 08, 2024 at 05:54:48PM -0800, Michael Chan wrote:
> The 5760X (P7) chip's HW GRO/LRO interface is very similar to that of
> the previous generation (5750X or P5).  However, the aggregation ID
> fields in the completion structures on P7 have been redefined from
> 16 bits to 12 bits.  The freed up 4 bits are redefined for part of the
> metadata such as the VLAN ID.  The aggregation ID mask was not modified
> when adding support for P7 chips.  Including the extra 4 bits for the
> aggregation ID can potentially cause the driver to store or fetch the
> packet header of GRO/LRO packets in the wrong TPA buffer.  It may hit
> the BUG() condition in __skb_pull() because the SKB contains no valid
> packet header:
> 
> kernel BUG at include/linux/skbuff.h:2766!
> Oops: invalid opcode: 0000 1 PREEMPT SMP NOPTI
> CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Kdump: loaded Tainted: G           OE      6.12.0-rc2+ #7
> Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> Hardware name: Dell Inc. PowerEdge R760/0VRV9X, BIOS 1.0.1 12/27/2022
> RIP: 0010:eth_type_trans+0xda/0x140
> Code: 80 00 00 00 eb c1 8b 47 70 2b 47 74 48 8b 97 d0 00 00 00 83 f8 01 7e 1b 48 85 d2 74 06 66 83 3a ff 74 09 b8 00 04 00 00 eb a5 <0f> 0b b8 00 01 00 00 eb 9c 48 85 ff 74 eb 31 f6 b9 02 00 00 00 48
> RSP: 0018:ff615003803fcc28 EFLAGS: 00010283
> RAX: 00000000000022d2 RBX: 0000000000000003 RCX: ff2e8c25da334040
> RDX: 0000000000000040 RSI: ff2e8c25c1ce8000 RDI: ff2e8c25869f9000
> RBP: ff2e8c258c31c000 R08: ff2e8c25da334000 R09: 0000000000000001
> R10: ff2e8c25da3342c0 R11: ff2e8c25c1ce89c0 R12: ff2e8c258e0990b0
> R13: ff2e8c25bb120000 R14: ff2e8c25c1ce89c0 R15: ff2e8c25869f9000
> FS:  0000000000000000(0000) GS:ff2e8c34be300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055f05317e4c8 CR3: 000000108bac6006 CR4: 0000000000773ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <IRQ>
>  ? die+0x33/0x90
>  ? do_trap+0xd9/0x100
>  ? eth_type_trans+0xda/0x140
>  ? do_error_trap+0x65/0x80
>  ? eth_type_trans+0xda/0x140
>  ? exc_invalid_op+0x4e/0x70
>  ? eth_type_trans+0xda/0x140
>  ? asm_exc_invalid_op+0x16/0x20
>  ? eth_type_trans+0xda/0x140
>  bnxt_tpa_end+0x10b/0x6b0 [bnxt_en]
>  ? bnxt_tpa_start+0x195/0x320 [bnxt_en]
>  bnxt_rx_pkt+0x902/0xd90 [bnxt_en]
>  ? __bnxt_tx_int.constprop.0+0x89/0x300 [bnxt_en]
>  ? kmem_cache_free+0x343/0x440
>  ? __bnxt_tx_int.constprop.0+0x24f/0x300 [bnxt_en]
>  __bnxt_poll_work+0x193/0x370 [bnxt_en]
>  bnxt_poll_p5+0x9a/0x300 [bnxt_en]
>  ? try_to_wake_up+0x209/0x670
>  __napi_poll+0x29/0x1b0
> 
> Fix it by redefining the aggregation ID mask for P5_PLUS chips to be
> 12 bits.  This will work because the maximum aggregation ID is less
> than 4096 on all P5_PLUS chips.
> 
> Fixes: 13d2d3d381ee ("bnxt_en: Add new P7 hardware interface definitions")
> Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


