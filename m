Return-Path: <netdev+bounces-254188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QSQTK8zjeWl60wEAu9opvQ
	(envelope-from <netdev+bounces-254188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:24:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 074A79F64E
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B795830086E2
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DCF2E1F11;
	Wed, 28 Jan 2026 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQXJVvMS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153042E0B5B
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769595848; cv=none; b=Tp5M/85nw8W40AD2khnVId9n+teEevpO83vBS0dUInTx2x79fpraEMbagJfhxZvS/Ln0qYDVCui/5VL5tmLIyu1XsggJByUP67+wQnWRmF/slV5WBjb6t7LvRZ7fH0y1AA+R1JYx2MbP1W6+F2iq1c4JCzDo7kLuFKJUHwfcifU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769595848; c=relaxed/simple;
	bh=2gqSXz28rXRrY5+w44k9nYUBHyiTPsj7oG7a7xU8FFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UspF5PKzuXjQnXo1xbaibAuOgroo1ziqUlmyRjZ+iFjVfBZ2GDSzap6BoLRFY/wYh8ln7vvgp6C2Q8Lp/72ySl6GSOnh8xHOUvpmPC8u7dPwN0BkMAs+jvwMvdCdc/nN22M3DM7co3If7eFUqq6F4yFUJ8VB1eHCCDugppj8BeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQXJVvMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09124C4CEF1;
	Wed, 28 Jan 2026 10:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769595847;
	bh=2gqSXz28rXRrY5+w44k9nYUBHyiTPsj7oG7a7xU8FFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sQXJVvMSMhCJlru9Nh4jw2YoibdHS8G74wwSLQf9viV2rsUhVISfm16s8ZW5mBCYy
	 TklP1OOny9pj1q4fKqibc1XMpeKT4UjWBhtO+1dLekjPFkLX3PBIgrQGRXAvsmTGuA
	 lkyeyWEj8Xgc2jxlMGVRbDy8EWq1NSctJPbfbC54KN0ToOCvy8etKqrX+QwdE2RCyX
	 m9za7FFCKgUQXsuRG1zfyLtt98FJ5qz5pNAUpdoDkMZl9XFJscqgn99vVz4jGaeWdN
	 e4roakIrjZF0QBzwloDa0430VgLLQUW7E1OiXMss/uXtftS0M8EPh8nFM0YXZJhVWp
	 64fKbSayieYoQ==
Date: Wed, 28 Jan 2026 12:24:04 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Ilan Tayari <ilant@mellanox.com>,
	Guy Shapiro <guysh@mellanox.com>,
	Yossi Kuperman <yossiku@mellanox.com>,
	Network Development <netdev@vger.kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH net] xfrm: always flush state and policy upon
 NETDEV_DOWN/NETDEV_UNREGISTER events
Message-ID: <20260128102404.GC12149@unreal>
References: <1de734e2-1da6-4b5c-8e03-66af7f88d074@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1de734e2-1da6-4b5c-8e03-66af7f88d074@I-love.SAKURA.ne.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254188-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,i-love.sakura.ne.jp:email]
X-Rspamd-Queue-Id: 074A79F64E
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 12:32:08AM +0900, Tetsuo Handa wrote:
> syzbot is reporting that "struct xfrm_state" refcount is leaking.
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
> This is because currently xfrm_dev_down() (which is called upon NETDEV_DOWN
> event and NETDEV_UNREGISTER event) can release the reference to
> "struct net_device" taken by xfrm_dev_state_add() only if
> the NETIF_F_HW_ESP bit is set, but the NETIF_F_HW_ESP bit can be cleared
> by "ethtool -K $dev esp-hw-offload off" command.
> In other words, we cannot guess whether xfrm_dev_state_add() has taken a
> reference to "struct net_device" based on whether the NETIF_F_HW_ESP bit
> is currently set.
> 
> For recording why this patch does not re-introduce xfrm_dev_unregister(),
> my guessed history about this module's NETDEV_UNREGISTER handler is shown
> below.
> 
> Commit d77e38e612a0 ("xfrm: Add an IPsec hardware offloading API")
> introduced xfrm_dev_state_add(). That commit called xfrm_dev_state_add()
>  from xfrm_state_construct(), and introduced the NETDEV_UNREGISTER case
> to xfrm_dev_event(). But that commit implemented xfrm_dev_unregister() as
> a no-op, and implemented xfrm_dev_down() to call xfrm_dev_state_flush()
> only if (dev->features & NETIF_F_HW_ESP) != 0. I guess that that commit
> expected that NETDEV_DOWN event is fired before NETDEV_UNREGISTER event
> fires, and also assumed that xfrm_dev_state_add() is called only if
> (dev->features & NETIF_F_HW_ESP) != 0.
> 
> Commit ec30d78c14a8 ("xfrm: add xdst pcpu cache") added
> xfrm_policy_cache_flush() call to xfrm_dev_unregister(), but
> commit e4db5b61c572 ("xfrm: policy: remove pcpu policy cache") removed
> xfrm_policy_cache_flush() call from xfrm_dev_unregister() and also
> removed the NETDEV_UNREGISTER case from xfrm_dev_event() because
> xfrm_dev_unregister() again became no-op.
> 
> Commit 03891f820c21 ("xfrm: handle NETDEV_UNREGISTER for xfrm device")
> re-introduced the NETDEV_UNREGISTER case to xfrm_dev_event(), but that
> commit for unknown reason chose to share xfrm_dev_down() between the
> NETDEV_DOWN case and the NETDEV_UNREGISTER case. Therefore, I assumed
> that doing the same behavior for both cases is desirable. If something
> is wrong with this choice, please re-introduce xfrm_dev_unregister().
> 
> Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
> Fixes: d77e38e612a0 ("xfrm: Add an IPsec hardware offloading API")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Previous discussion is https://lkml.kernel.org/r/924f9cf5-599a-48f0-b1e3-94cd971965b0@I-love.SAKURA.ne.jp
> 
>  net/xfrm/xfrm_device.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index 52ae0e034d29..26e62b6a9db5 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -536,10 +536,8 @@ static int xfrm_api_check(struct net_device *dev)
>  
>  static int xfrm_dev_down(struct net_device *dev)
>  {
> -	if (dev->features & NETIF_F_HW_ESP) {
> -		xfrm_dev_state_flush(dev_net(dev), dev, true);
> -		xfrm_dev_policy_flush(dev_net(dev), dev, true);
> -	}
> +	xfrm_dev_state_flush(dev_net(dev), dev, true);
> +	xfrm_dev_policy_flush(dev_net(dev), dev, true);

I think this can work, but IMHO the more robust approach is to ensure that all
states and policies are removed when the NETIF_F_HW_ESP feature bit is cleared.

Would it be possible to handle this in NETDEV_FEAT_CHANGE?

Thanks.

>  
>  	return NOTIFY_DONE;
>  }
> -- 
> 2.47.3
> 

