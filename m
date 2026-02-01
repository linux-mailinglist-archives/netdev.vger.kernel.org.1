Return-Path: <netdev+bounces-255601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMxVDo1gf2kMpQIAu9opvQ
	(envelope-from <netdev+bounces-255601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 15:17:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD663C61EE
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 15:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B6333001019
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 14:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5CB2E5D17;
	Sun,  1 Feb 2026 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxDgYL0/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC17135898
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769955464; cv=none; b=Msir2B8rYDRGD9xdogEPaaGj/hsW9bZkuo3zUCl7jt8kErzre8CL20lVPX5Y0jloRK1oeEr/wmhni8b34CW6ticZygC5w88v0dB9cqnNyy+bCFyGAQhxv0x2e5E7bPlxBkC0iyxVzoxrYfcd733a4BcSyM+FTAC2pjLPczJMg7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769955464; c=relaxed/simple;
	bh=0V0S3ubTSH5zsGO8n1ROcYGArDoGOcCYtY6jH9jsuEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKf2QQnKNY7pBHoMtUviDyyQ3RGmbZpnAE2kCiPVVR7jEiiIxcJEHRsROCcuCyCJaB+t4vu734rB4MNZTEaQ12h/lJPgEjIaRzIJ1J8/fzk7nezxc/IDSA1DR2KrZIleVFcb4Ur2BsO9RAEdYe5PmN49r+1lZGflWJPf/tsHSAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxDgYL0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F614C4CEF7;
	Sun,  1 Feb 2026 14:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769955464;
	bh=0V0S3ubTSH5zsGO8n1ROcYGArDoGOcCYtY6jH9jsuEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FxDgYL0/4kxYbsQ3aYYyDuV6jLcYN03mBQ+EdFqBb7xn+AWeFZpaOUwQ9LJaA5yZi
	 nW8kdySPp8jELLg/MvBYgDyuzWgwx8s4NO0x8VGc4whlIPcbKNiMbc2ns+MDbkNtgs
	 r3pe5pyXrFRKlmgovgQC1oa/jddPczo6gUDT1Rv2Rdu7c6VgTBqvRFPXPI76Hzu9pK
	 T2w6s/REB0g35wE1C+hpD9DSN8XIlXj71pPRh1ilbQvGcMEwWr9lfRPvltHAmDkpDA
	 JGfUjH4p4f8PsTOEk7d3SdijlFVDKgkpj4s1Q8DA5H0KwNVnCZA9A45kYznwemH4rj
	 FiilWeHibxfsg==
Date: Sun, 1 Feb 2026 16:17:39 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Ilan Tayari <ilant@mellanox.com>,
	Guy Shapiro <guysh@mellanox.com>,
	Yossi Kuperman <yossiku@mellanox.com>,
	Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH net v2] xfrm: always flush state and policy upon
 NETDEV_UNREGISTER event
Message-ID: <20260201141739.GE34749@unreal>
References: <cea4b855-fe94-4b4e-9c2d-3cef7aac1be3@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cea4b855-fe94-4b4e-9c2d-3cef7aac1be3@I-love.SAKURA.ne.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255601-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: CD663C61EE
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 07:42:47PM +0900, Tetsuo Handa wrote:
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
> This is because commit d77e38e612a0 ("xfrm: Add an IPsec hardware
> offloading API") implemented xfrm_dev_unregister() as no-op despite
> xfrm_dev_state_add() from xfrm_state_construct() acquires a reference
> to "struct net_device".
> I guess that that commit expected that NETDEV_DOWN event is fired before
> NETDEV_UNREGISTER event fires, and also assumed that xfrm_dev_state_add()
> is called only if (dev->features & NETIF_F_HW_ESP) != 0.
> 
> Sabrina Dubroca identified steps to reproduce the same symptoms as below.
> 
>   echo 0 > /sys/bus/netdevsim/new_device
>   dev=$(ls -1 /sys/bus/netdevsim/devices/netdevsim0/net/)
>   ip xfrm state add src 192.168.13.1 dst 192.168.13.2 proto esp \
>      spi 0x1000 mode tunnel aead 'rfc4106(gcm(aes))' $key 128   \
>      offload crypto dev $dev dir out
>   ethtool -K $dev esp-hw-offload off
>   echo 0 > /sys/bus/netdevsim/del_device
> 
> Like these steps indicate, the NETIF_F_HW_ESP bit can be cleared after
> xfrm_dev_state_add() acquired a reference to "struct net_device".
> Also, xfrm_dev_state_add() does not check for the NETIF_F_HW_ESP bit
> when acquiring a reference to "struct net_device".
> 
> Commit 03891f820c21 ("xfrm: handle NETDEV_UNREGISTER for xfrm device")
> re-introduced the NETDEV_UNREGISTER event to xfrm_dev_event(), but that
> commit for unknown reason chose to share xfrm_dev_down() between the
> NETDEV_DOWN event and the NETDEV_UNREGISTER event.
> I guess that that commit missed the behavior in the previous paragraph.
> 
> Therefore, we need to re-introduce xfrm_dev_unregister() in order to
> release the reference to "struct net_device" by unconditionally flushing
> state and policy.
> 
> Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
> Fixes: d77e38e612a0 ("xfrm: Add an IPsec hardware offloading API")
> Cc: Sabrina Dubroca <sd@queasysnail.net>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> v2:
>   - Don't change xfrm_dev_down(), re-introduce xfrm_dev_unregister() instead.
> 
> v1:
>   - https://lkml.kernel.org/r/1de734e2-1da6-4b5c-8e03-66af7f88d074@I-love.SAKURA.ne.jp
> 
>  net/xfrm/xfrm_device.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

I believe this is the correct solution, but I do not feel confident enough to
add my Reviewed-by.

Steffen,

If you decide to take it, please queue it in your -next branch, so we will have enough
time to test in our regression. It seems too risky for -rc8.

Thanks

> 
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index 52ae0e034d29..550457e4c4f0 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -544,6 +544,14 @@ static int xfrm_dev_down(struct net_device *dev)
>  	return NOTIFY_DONE;
>  }
>  
> +static int xfrm_dev_unregister(struct net_device *dev)
> +{
> +	xfrm_dev_state_flush(dev_net(dev), dev, true);
> +	xfrm_dev_policy_flush(dev_net(dev), dev, true);
> +
> +	return NOTIFY_DONE;
> +}
> +
>  static int xfrm_dev_event(struct notifier_block *this, unsigned long event, void *ptr)
>  {
>  	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
> @@ -556,8 +564,10 @@ static int xfrm_dev_event(struct notifier_block *this, unsigned long event, void
>  		return xfrm_api_check(dev);
>  
>  	case NETDEV_DOWN:
> -	case NETDEV_UNREGISTER:
>  		return xfrm_dev_down(dev);
> +
> +	case NETDEV_UNREGISTER:
> +		return xfrm_dev_unregister(dev);
>  	}
>  	return NOTIFY_DONE;
>  }
> -- 
> 2.47.3
> 
> 

