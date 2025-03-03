Return-Path: <netdev+bounces-171236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB47A4C17A
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 14:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93DB71882C6F
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 13:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FEA78F32;
	Mon,  3 Mar 2025 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLwbYfcY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCE63C30
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007785; cv=none; b=fVLP8KOQ/sRM3fZ319LaZUWiZyf4n9F7AMiTDOAn6KciRkQg1p+Ud45ciuq/ay4GC5eIuu+5mzL3vSxzXuTxIIdMTb8640DxrLtlluVoEdP0TIXM4SgP0ec90WlGD3KCL9JXrdITXnatfvAWk7Ogj/Vv1QogxX5k0eHzN4F6SqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007785; c=relaxed/simple;
	bh=xvegqZrgGG85LvX4XtWQMY44BkQwedH2aiK13aawNvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGheQis0C+niZxLbr0hPP8g3m9PJVZdL+n+3XISdZDxiaPc3WKe9JeUd+O4RQXQWxZsHEi+Xdj+ZrEa9Mgfxo3auvseMdh9WV/LalKl6scgmJ8LYEK3AYppYVtFRQBMzcmK0PHYsvdTIem9uBdgyij3xQBIIOcBM/lZocGrUv1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLwbYfcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26978C4CED6;
	Mon,  3 Mar 2025 13:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741007784;
	bh=xvegqZrgGG85LvX4XtWQMY44BkQwedH2aiK13aawNvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZLwbYfcY/YVIat3SFKdoGfUFv0k4cR8gFGMaqZpyziQyVr3jzPv6H52siWVf7/fzf
	 wyhbYtQTOKETs13qfJAGZjpmSXkRWD3fKcOBbDRgL8yOih1S2tR3nnQ8KDvm6uawJN
	 epJEOk3yJqZkMJAmmwmg/WA+p+nqerxBMGDmMf9Ue7KEhwkEh/PLGZkyWcP/Hg0/MV
	 4PfZKIcdJwG7R4FIhYsuaUz2aPKm2B59u8Xk/ALmFgz07mYYtOuLA0chMujFeJ2sKM
	 9vIWVQ6mJsRXrYpscQZhDMlTNPMf6B2hyOAqufDKg07pxW3bSmo0hWz8oCLuK1pA5B
	 XzwSavaqzbQJw==
Date: Mon, 3 Mar 2025 13:16:20 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+da65c993ae113742a25f@syzkaller.appspotmail.com
Subject: Re: [PATCH net] llc: do not use skb_get() before dev_queue_xmit()
Message-ID: <20250303131620.GT1615191@kernel.org>
References: <20250227082642.2461118-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227082642.2461118-1-edumazet@google.com>

On Thu, Feb 27, 2025 at 08:26:42AM +0000, Eric Dumazet wrote:
> syzbot is able to crash hosts [1], using llc and devices
> not supporting IFF_TX_SKB_SHARING.
> 
> In this case, e1000 driver calls eth_skb_pad(), while
> the skb is shared.
> 
> Simply replace skb_get() by skb_clone() in net/llc/llc_s_ac.c
> 
> Note that e1000 driver might have an issue with pktgen,
> because it does not clear IFF_TX_SKB_SHARING, this is an
> orthogonal change.
> 
> We need to audit other skb_get() uses in net/llc.
> 
> [1]
> 
> kernel BUG at net/core/skbuff.c:2178 !
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 16371 Comm: syz.2.2764 Not tainted 6.14.0-rc4-syzkaller-00052-gac9c34d1e45a #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>  RIP: 0010:pskb_expand_head+0x6ce/0x1240 net/core/skbuff.c:2178
> Call Trace:
>  <TASK>
>   __skb_pad+0x18a/0x610 net/core/skbuff.c:2466
>   __skb_put_padto include/linux/skbuff.h:3843 [inline]
>   skb_put_padto include/linux/skbuff.h:3862 [inline]
>   eth_skb_pad include/linux/etherdevice.h:656 [inline]
>   e1000_xmit_frame+0x2d99/0x5800 drivers/net/ethernet/intel/e1000/e1000_main.c:3128
>   __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
>   netdev_start_xmit include/linux/netdevice.h:5160 [inline]
>   xmit_one net/core/dev.c:3806 [inline]
>   dev_hard_start_xmit+0x9a/0x7b0 net/core/dev.c:3822
>   sch_direct_xmit+0x1ae/0xc30 net/sched/sch_generic.c:343
>   __dev_xmit_skb net/core/dev.c:4045 [inline]
>   __dev_queue_xmit+0x13d4/0x43e0 net/core/dev.c:4621
>   dev_queue_xmit include/linux/netdevice.h:3313 [inline]
>   llc_sap_action_send_test_c+0x268/0x320 net/llc/llc_s_ac.c:144
>   llc_exec_sap_trans_actions net/llc/llc_sap.c:153 [inline]
>   llc_sap_next_state net/llc/llc_sap.c:182 [inline]
>   llc_sap_state_process+0x239/0x510 net/llc/llc_sap.c:209
>   llc_ui_sendmsg+0xd0d/0x14e0 net/llc/af_llc.c:993
>   sock_sendmsg_nosec net/socket.c:718 [inline]
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+da65c993ae113742a25f@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/67c020c0.050a0220.222324.0011.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


