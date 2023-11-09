Return-Path: <netdev+bounces-46933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A178F7E73CF
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 22:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02251C209F0
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 21:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C502938DF0;
	Thu,  9 Nov 2023 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWZbVbCb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11CB38DEC
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 21:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2224C433C7;
	Thu,  9 Nov 2023 21:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699566524;
	bh=7XuYnooz8inGMQvDAxkJmkzE0dIpxNG6Q8qjlRXE2fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jWZbVbCbQ7Hyw8KbYQtLjHwYIwTOFwWbTK6TD4gXX97sjNOsjjftN7frhIJf47jPc
	 zYEL90kuHV0sZUdvCoulkn05qwLf3MymNSmmy85HkwR0hVZU+8pj3Uph9Oo3sARYQY
	 wo7mR6fOEN3buUcIAX2SH3gQ/YgzbunvJDltA7qniFHwsFrdLv3y42vWbrEIBss9+n
	 bcnk8IQ3ouVFgagwUy5AYy/HVA/ZZ3zEroieV1IcBD63HwPeubk+xo5Jo6EoUG8Rzk
	 ofS9X/ty31KbdqpHNaWRPXWxMtHaMzAe4BNlREL3kQYFIejvs54nR1laf6lEdghy4x
	 YmuwvymsWoXvQ==
Date: Thu, 9 Nov 2023 16:48:38 -0500
From: Simon Horman <horms@kernel.org>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tty: Fix uninit-value access in ppp_sync_receive()
Message-ID: <20231109214838.GB568506@kernel.org>
References: <20231108154420.1474853-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108154420.1474853-1-syoshida@redhat.com>

On Thu, Nov 09, 2023 at 12:44:20AM +0900, Shigeru Yoshida wrote:
> KMSAN reported the following uninit-value access issue:
> 
> =====================================================
> BUG: KMSAN: uninit-value in ppp_sync_input drivers/net/ppp/ppp_synctty.c:690 [inline]
> BUG: KMSAN: uninit-value in ppp_sync_receive+0xdc9/0xe70 drivers/net/ppp/ppp_synctty.c:334
>  ppp_sync_input drivers/net/ppp/ppp_synctty.c:690 [inline]
>  ppp_sync_receive+0xdc9/0xe70 drivers/net/ppp/ppp_synctty.c:334
>  tiocsti+0x328/0x450 drivers/tty/tty_io.c:2295
>  tty_ioctl+0x808/0x1920 drivers/tty/tty_io.c:2694
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:871 [inline]
>  __se_sys_ioctl+0x211/0x400 fs/ioctl.c:857
>  __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:857
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> Uninit was created at:
>  __alloc_pages+0x75d/0xe80 mm/page_alloc.c:4591
>  __alloc_pages_node include/linux/gfp.h:238 [inline]
>  alloc_pages_node include/linux/gfp.h:261 [inline]
>  __page_frag_cache_refill+0x9a/0x2c0 mm/page_alloc.c:4691
>  page_frag_alloc_align+0x91/0x5d0 mm/page_alloc.c:4722
>  page_frag_alloc include/linux/gfp.h:322 [inline]
>  __netdev_alloc_skb+0x215/0x6d0 net/core/skbuff.c:728
>  netdev_alloc_skb include/linux/skbuff.h:3225 [inline]
>  dev_alloc_skb include/linux/skbuff.h:3238 [inline]
>  ppp_sync_input drivers/net/ppp/ppp_synctty.c:669 [inline]
>  ppp_sync_receive+0x237/0xe70 drivers/net/ppp/ppp_synctty.c:334
>  tiocsti+0x328/0x450 drivers/tty/tty_io.c:2295
>  tty_ioctl+0x808/0x1920 drivers/tty/tty_io.c:2694
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:871 [inline]
>  __se_sys_ioctl+0x211/0x400 fs/ioctl.c:857
>  __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:857
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> CPU: 0 PID: 12950 Comm: syz-executor.1 Not tainted 6.6.0-14500-g1c41041124bd #10
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
> =====================================================
> 
> ppp_sync_input() checks the first 2 bytes of the data are PPP_ALLSTATIONS
> and PPP_UI. However, if the data length is 1 and the first byte is
> PPP_ALLSTATIONS, an access to an uninitialized value occurs when checking
> PPP_UI. This patch resolves this issue by checking the data length.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

