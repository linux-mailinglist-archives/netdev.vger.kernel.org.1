Return-Path: <netdev+bounces-250907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA7ED39851
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 18:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5B2B30012F3
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 17:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BA823D7E0;
	Sun, 18 Jan 2026 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LA2/G8WK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7200500976
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768756087; cv=none; b=VsLTT6KJ+tSHAgQCqon2Y43Ar2vrPtJ2wvTcPF4wmNdkbnZ0JFa6XcuwMLpylKYiilPUuUon3PNOY5J/zZ5UC09MOr+cCcv/eOwtTGp6DwarF4wZYFeu2mDYcyRAoEo/0c9fmtQjy0AveU5AmKY9tXzMNWjDzF9N1DwjjFI+2Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768756087; c=relaxed/simple;
	bh=/VofKsQVNKyW3loqyJ3RPZigG6pb29CRF4Nkx5NzTdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgPZh9q+gdpJIcXBSzMvOAwo4TIl5jy8zVeNmj4AcfXF9tYShAgfQ3HXs1T4362Ivt1eLV9D48LHhn0JN56AQyd/cUyX/wfTnWm51sPHVDFex8uKBsY3m91wHT9Yj7UafPBvrBJcAO3XNIR7cKdtSb7IA7vrCNLhABk6YSe4EHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LA2/G8WK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E29C116D0;
	Sun, 18 Jan 2026 17:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768756087;
	bh=/VofKsQVNKyW3loqyJ3RPZigG6pb29CRF4Nkx5NzTdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LA2/G8WK6ZJyDxkk6tgDgBzOo9DA0TnyHn5oYLg05Iy6WNopOj/eQM7bYmxPOuY4Z
	 gPtkBdWkDz1mHu/7TOyFaROCWX+8VuR7cuihb+hNyZ8ZpntdKIF8LCzLeBqsnr//Jj
	 UzbITEMzkZCUeUef47LbY3gf1iSHjJLh9iuSQIqKZPvRHr3d4oQU12Xxgi25l5gk74
	 W3p/zsWyTuaamynlKW0ClrpLAtZc/TqsPfwTX61c9Twv+Jz31lGM/eS2ccS28mMPAR
	 NpcXQe85SEP5fKBTv0UtoBSdGH3hgYPLAzfmdLozqepH7G4U/YD4gupJsynGEK4tdt
	 3GT0kFw6lauqQ==
Date: Sun, 18 Jan 2026 19:08:03 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: "Leon Romanovsky <leon@kernel.org> Leon Romanovsky <leonro@nvidia.com> Shannon Nelson <shannon.nelson@oracle.com> Steffen Klassert <steffen.klassert@secunet.com> Yossef Efraim" <yossefe@mellanox.com>,
	Network Development <netdev@vger.kernel.org>
Subject: Re: xfrm: Possible refcount bug in xfrm_dev_state_add() ?
Message-ID: <20260118170803.GC13201@unreal>
References: <c232db28-622d-4dd9-a61f-f12cd0ff39bb@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c232db28-622d-4dd9-a61f-f12cd0ff39bb@I-love.SAKURA.ne.jp>

On Sat, Jan 17, 2026 at 08:00:16PM +0900, Tetsuo Handa wrote:
> Just browsing call trace for
> 
>   unregister_netdevice: waiting for netdevsim0 to become free. Usage count = 2
>   ref_tracker: netdev@ffff888052f24618 has 1/1 users at
>        __netdev_tracker_alloc include/linux/netdevice.h:4400 [inline]
>        netdev_tracker_alloc include/linux/netdevice.h:4412 [inline]
>        xfrm_dev_state_add+0x3a5/0x1080 net/xfrm/xfrm_device.c:316
>        xfrm_state_construct net/xfrm/xfrm_user.c:986 [inline]
>        xfrm_add_sa+0x34ff/0x5fa0 net/xfrm/xfrm_user.c:1022
>        xfrm_user_rcv_msg+0x58e/0xc00 net/xfrm/xfrm_user.c:3507
>        netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2550
>        xfrm_netlink_rcv+0x71/0x90 net/xfrm/xfrm_user.c:3529
>        netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
>        netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1344
>        netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1894
>        sock_sendmsg_nosec net/socket.c:727 [inline]
>        __sock_sendmsg net/socket.c:742 [inline]
>        ____sys_sendmsg+0xa5d/0xc30 net/socket.c:2592
>        ___sys_sendmsg+0x134/0x1d0 net/socket.c:2646
>        __sys_sendmsg+0x16d/0x220 net/socket.c:2678
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> problem, I noticed a different-but-possible refcount bug.
> 
> Commit 67a63387b141 ("xfrm: Fix negative device refcount on offload failure.")
> resets xso->dev to NULL. Commit 50bd870a9e5c ("xfrm: Add ESN support for IPSec
> HW offload") also resets xso->dev to NULL. Then, why not commit 585b64f5a620
> ("xfrm: delay initialization of offload path till its actually requested") also
> resets xso->dev to NULL (like shown below) ? (Note that I don't know the
> background of these commits...)
> 
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index 52ae0e034d29..daa640f1ff9c 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -308,6 +308,7 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
>  
>  	if (!x->type_offload) {
>  		NL_SET_ERR_MSG(extack, "Type doesn't support offload");
> +		xso->dev = NULL;

I do not expect this change to have any visible impact. After this failure,
the xso object should not be reused, so setting "xso->dev = NULL" is likely
unnecessary as well.

Thanks

>  		dev_put(dev);
>  		return -EINVAL;
>  	}
> 

