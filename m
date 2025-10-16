Return-Path: <netdev+bounces-230103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EFDBE3FA5
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 16:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D66904E7D3C
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 14:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F57343D82;
	Thu, 16 Oct 2025 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hb4ZMJMO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5335333CEB3;
	Thu, 16 Oct 2025 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760625994; cv=none; b=WEnWC1PpSrILGaoyhdtLWpJAHJLn1iAAPYYkXtbAVKjay2j3yCwhmyIbMMaA7uWinHlAgo60ZvbWq7ElfW+J7s7PP600bSwK3/hMwScdsFkmENt8VM2KQhes6e0N0p9j85CBiZPrxdZbBy/DEkhtz4mT2oh1fSY4to2PNFZZFcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760625994; c=relaxed/simple;
	bh=111kYeLRLTtxqwmaa4KPeLAAqv2BDWLAy3DypP9gk3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRrTFHRcmq3itfl3NN+L42cztRZtxCtxPhT99J8UaYxls37GdZybrtt+hIOF/8H3JirscH/zABvb3w+OOlTzXka/HfR6TvQvXwbJI8rezbC8Xk03TqldVImb25UnT/3vGV9pPtW5VOewP3aFyr5Pvy2Pzp0dy/F086+J0CO/VY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hb4ZMJMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEA6C4CEF1;
	Thu, 16 Oct 2025 14:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760625993;
	bh=111kYeLRLTtxqwmaa4KPeLAAqv2BDWLAy3DypP9gk3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hb4ZMJMOCc4ODegoCo9Vq33hsYDg4admmS0v6+GLHKotnyl1xo1Z8cIfaL6U+ApCc
	 vh3qE1AaFH2evPR+ec44zCRCSYn2O1RRwTsSu2xEQOO8TNObpLHjrtO0fUzgGu3N9x
	 ZajiC+f1ZXRIzoqbcZ+qIIyjk4pHJj6yQV/K9mHw=
Date: Thu, 16 Oct 2025 16:46:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	cynthia@kosmx.dev, rafael@kernel.org, dakr@kernel.org,
	christian.brauner@ubuntu.com, edumazet@google.com,
	pabeni@redhat.com, davem@davemloft.net, horms@kernel.org
Subject: Re: [PATCH] sysfs: check visibility before changing group attribute
 ownership
Message-ID: <2025101604-filing-plenty-ec86@gregkh>
References: <20251016101456.4087-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016101456.4087-1-fmancera@suse.de>

On Thu, Oct 16, 2025 at 12:14:56PM +0200, Fernando Fernandez Mancera wrote:
> Since commit 0c17270f9b92 ("net: sysfs: Implement is_visible for
> phys_(port_id, port_name, switch_id)"), __dev_change_net_namespace() can
> hit WARN_ON() when trying to change owner of a file that isn't visible.
> See the trace below:
> 
>  WARNING: CPU: 6 PID: 2938 at net/core/dev.c:12410 __dev_change_net_namespace+0xb89/0xc30
>  CPU: 6 UID: 0 PID: 2938 Comm: incusd Not tainted 6.17.1-1-mainline #1 PREEMPT(full)  4b783b4a638669fb644857f484487d17cb45ed1f
>  Hardware name: Framework Laptop 13 (AMD Ryzen 7040Series)/FRANMDCP07, BIOS 03.07 02/19/2025
>  RIP: 0010:__dev_change_net_namespace+0xb89/0xc30
>  [...]
>  Call Trace:
>   <TASK>
>   ? if6_seq_show+0x30/0x50
>   do_setlink.isra.0+0xc7/0x1270
>   ? __nla_validate_parse+0x5c/0xcc0
>   ? security_capable+0x94/0x1a0
>   rtnl_newlink+0x858/0xc20
>   ? update_curr+0x8e/0x1c0
>   ? update_entity_lag+0x71/0x80
>   ? sched_balance_newidle+0x358/0x450
>   ? psi_task_switch+0x113/0x2a0
>   ? __pfx_rtnl_newlink+0x10/0x10
>   rtnetlink_rcv_msg+0x346/0x3e0
>   ? sched_clock+0x10/0x30
>   ? __pfx_rtnetlink_rcv_msg+0x10/0x10
>   netlink_rcv_skb+0x59/0x110
>   netlink_unicast+0x285/0x3c0
>   ? __alloc_skb+0xdb/0x1a0
>   netlink_sendmsg+0x20d/0x430
>   ____sys_sendmsg+0x39f/0x3d0
>   ? import_iovec+0x2f/0x40
>   ___sys_sendmsg+0x99/0xe0
>   __sys_sendmsg+0x8a/0xf0
>   do_syscall_64+0x81/0x970
>   ? __sys_bind+0xe3/0x110
>   ? syscall_exit_work+0x143/0x1b0
>   ? do_syscall_64+0x244/0x970
>   ? sock_alloc_file+0x63/0xc0
>   ? syscall_exit_work+0x143/0x1b0
>   ? do_syscall_64+0x244/0x970
>   ? alloc_fd+0x12e/0x190
>   ? put_unused_fd+0x2a/0x70
>   ? do_sys_openat2+0xa2/0xe0
>   ? syscall_exit_work+0x143/0x1b0
>   ? do_syscall_64+0x244/0x970
>   ? exc_page_fault+0x7e/0x1a0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  [...]
>   </TASK>
> 
> Fix this by checking is_visible() before trying to touch the attribute.
> 
> Fixes: 303a42769c4c ("sysfs: add sysfs_group{s}_change_owner()")
> Reported-by: Cynthia <cynthia@kosmx.dev>
> Closes: https://lore.kernel.org/netdev/01070199e22de7f8-28f711ab-d3f1-46d9-b9a0-048ab05eb09b-000000@eu-central-1.amazonses.com/
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>  fs/sysfs/group.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)

Nice, thanks!  This has been tested, right?

thanks,

greg k-h

