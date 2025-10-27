Return-Path: <netdev+bounces-233305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A85C1168E
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 21:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451055636F7
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 20:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780603054FA;
	Mon, 27 Oct 2025 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpLYzdk/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D93424E4B4;
	Mon, 27 Oct 2025 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761597431; cv=none; b=WIC+i9OgdY56/lxhVmB70c+WGzLAGsZqIvOBjUnztY1Juc0MIqz3V5lJ6BkaCYtawJB56gb8qgL3ay3ZcKsJHcMJoVvpYdMzaeb3+GFf64r3rTXcjldCcW8MekAYA5+ua5TnRN7ROBwffzW0BgKdM2zQig1kaWBGWT+b1VRU9bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761597431; c=relaxed/simple;
	bh=6lY3BsqhQbFTxzhuIPudK7AkEkn6POgGkZeDfcPxB2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwGZUdh+/CO5KFu/Dsfr3AxrAXcTwBCSNrNFRzqrcS9EB9F47yY3IaSlxPRrbNMQrHU7nZv2nCwud14+TRTuOeYnXHxMu3WaJ1FYW8Teh+M1u8zK5gjc9JcV/vw45YOawKs7V6LRDKQgl6uNgQUw1q+1TM95PzlFrAkGCfcS7i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpLYzdk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A615C4CEF1;
	Mon, 27 Oct 2025 20:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761597430;
	bh=6lY3BsqhQbFTxzhuIPudK7AkEkn6POgGkZeDfcPxB2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IpLYzdk/zLNP6UX4LTpN+fRbiGwM28QfznWD4Nc5sYbq1jZK6PW8Pk5xb5M4JPlIT
	 PC+QIAL1enGh4RxdWnJ6P7KbBknGa2nmL0ZoVIXLGD4qGT0ba86tB4NlSqDMPVUrhZ
	 yOrCC+EiB8ceu4RBWHDNjYluIxZ6io78kTcbEhLVaKEqLiBQQn4ZjkWyoQCZwokUGg
	 euEVjO4/7jx1hq6X2FPUQWOIs55ldXhARNo+ZqngSv1M9JIIfnbxJVYDDK7IlCq1MB
	 wWmN36Tpx1hAZP1spDbXxU88dc60j59WGmkEyFjztdERkYC8zi1tvD9hDS5scxI4fq
	 qRrjCBMZ0tNJw==
Date: Mon, 27 Oct 2025 20:37:06 +0000
From: Simon Horman <horms@kernel.org>
To: clingfei <clf700383@gmail.com>
Cc: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com,
	davem@davemloft.net, edumazet@google.com,
	herbert@gondor.apana.org.au, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, steffen.klassert@secunet.com,
	syzkaller-bugs@googlegroups.com,
	SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>,
	Edward Adam Davis <eadavis@qq.com>
Subject: Re: [PATCH net] net: key: Fix potential integer overflow in
 set_ipsecrequest
Message-ID: <aP_X8sFJKWVycTn0@horms.kernel.org>
References: <68f1d9d6.050a0220.91a22.0419.GAE@google.com>
 <20251023122451.606435-1-1599101385@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023122451.606435-1-1599101385@qq.com>

+ Shaurya Rane and + Edward Adam Davis

On Thu, Oct 23, 2025 at 08:24:51PM +0800, clingfei wrote:
> syzbot found that there is a kernel bug in set_ipsecrequest:
> 
> skbuff: skb_over_panic: text:ffffffff8a1fdd63 len:392 put:16 head:ffff888073664d00 
> data:ffff888073664d00 tail:0x188 end:0x180 dev:<NULL>
> ------------[ cut here ]------------
> kernel BUG at net/core/skbuff.c:212!
> Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> CPU: 1 UID: 0 PID: 6012 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
> RIP: 0010:skb_panic+0x157/0x160 net/core/skbuff.c:212
> Code: c7 60 10 6e 8c 48 8b 74 24 08 48 8b 54 24 10 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 55 
> 41 57 41 56 e8 6e 54 f5 ff 48 83 c4 20 90 <0f> 0b cc cc cc cc cc cc cc 90 90 90 90 90 90 
> 90 90 90 90 90 90 90
> RSP: 0018:ffffc90003d5eb68 EFLAGS: 00010282
> RAX: 0000000000000088 RBX: dffffc0000000000 RCX: bc84b821dc35fd00
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: 0000000000000180 R08: ffffc90003d5e867 R09: 1ffff920007abd0c
> R10: dffffc0000000000 R11: fffff520007abd0d R12: ffff8880720b7b50
> R13: ffff888073664d00 R14: ffff888073664d00 R15: 0000000000000188
> FS:  000055555b9e7500(0000) GS:ffff888125e0c000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055555b9e7808 CR3: 000000007ead6000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  skb_over_panic net/core/skbuff.c:217 [inline]
>  skb_put+0x159/0x210 net/core/skbuff.c:2583
>  skb_put_zero include/linux/skbuff.h:2788 [inline]
>  set_ipsecrequest+0x73/0x680 net/key/af_key.c:3532
>  pfkey_send_migrate+0x11f2/0x1de0 net/key/af_key.c:3636
>  km_migrate+0x155/0x260 net/xfrm/xfrm_state.c:2838
>  xfrm_migrate+0x2020/0x2330 net/xfrm/xfrm_policy.c:4698
>  xfrm_do_migrate+0x796/0x900 net/xfrm/xfrm_user.c:3144
>  xfrm_user_rcv_msg+0x7a3/0xab0 net/xfrm/xfrm_user.c:3501
>  netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
>  xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3523
>  netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>  netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
>  netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
>  sock_sendmsg_nosec net/socket.c:727 [inline]
>  __sock_sendmsg+0x21c/0x270 net/socket.c:742
>  ____sys_sendmsg+0x505/0x830 net/socket.c:2630
>  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2684
>  __sys_sendmsg net/socket.c:2716 [inline]
>  __do_sys_sendmsg net/socket.c:2721 [inline]
>  __se_sys_sendmsg net/socket.c:2719 [inline]
>  __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2719
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The root cause is that there is an integer overflow when calling set_ipsecrequest, 
> causing the result of `pfkey_sockaddr_pair_size(family)` is not consistent with 
> that used in alloc_skb, thus exceeds the total buffer size and the kernel panic.
> 
> The issue was detected on bpf-next and linux-next, but the mainstream should also 
> have this problem.
> 
> This patch has been tested by syzbot and dit not trigger any issue:
> >
> > Hello,
> >
> > syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> >
> > Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
> > Tested-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
> >
> > Tested on:
> >
> > commit:         7361c864 selftests/bpf: Fix list_del() in arena list
> > git tree:       bpf-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1089f52f980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
> > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > patch:          https://syzkaller.appspot.com/x/patch.diff?x=12bf83cd980000
> >
> > Note: testing is done by a robot and is best-effort only.
> 
> 
> >From 6dc2deb09faf7d53707cc9e75e175b09644fd181 Mon Sep 17 00:00:00 2001
> From: Cheng Lingfei <clf700383@gmail.com>
> Date: Mon, 20 Oct 2025 13:48:54 +0800
> Subject: [PATCH] fix integer overflow in set_ipsecrequest
> 
> syzbot reported a kernel BUG in set_ipsecrequest() due to an skb_over_panic.
> 
> The mp->new_family and mp->old_family is u16, while set_ipsecrequest receives
> family as uint8_t,  causing a integer overflow and the later size_req calculation
> error, which exceeds the size used in alloc_skb, and ultimately triggered the
> kernel bug in skb_put.
> 
> Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
> Signed-off-by: Cheng Lingfei <clf700383@gmail.com>

Firstly, this is not the correct way to structure a commit message.  Please
look at the example at [1] for an example of a well structure commit
message. And please look over [2] for documentation of how to structure
patch submissions, and [3] for documentation of the Networking subsystem's
processes.

[1] https://lore.kernel.org/all/7c6b33e4d6e6f2831992bb4631595b1aa1da35c1.1739899357.git.pabeni@redhat.com/
[2] https://docs.kernel.org/process/submitting-patches.html#submittingpatches
[3] https://docs.kernel.org/process/maintainer-netdev.html

Next, this patch is for IPsec code, and is a fix, so probably
it should target the ipsec tree. It should apply cleanly to,
and have been tested against that tree. And the target tree
should be noted in the Subject like this:

Subject: [PATCH ipsec] ...

And there should be a fixes tag.
According to the link in the Closes tag that would be

Fixes: 14ad6ed30a10 ("net: allow small head cache usage with large MAX_SKB_FRAGS values")

But that is not obviously correct to me. More on that in a moment.

> ---
>  net/key/af_key.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/key/af_key.c b/net/key/af_key.c
> index 2ebde0352245..08f4cde01994 100644
> --- a/net/key/af_key.c
> +++ b/net/key/af_key.c
> @@ -3518,7 +3518,7 @@ static int set_sadb_kmaddress(struct sk_buff *skb, const struct xfrm_kmaddress *
>  
>  static int set_ipsecrequest(struct sk_buff *skb,
>  			    uint8_t proto, uint8_t mode, int level,
> -			    uint32_t reqid, uint8_t family,
> +			    uint32_t reqid, uint16_t family,
>  			    const xfrm_address_t *src, const xfrm_address_t *dst)
>  {
>  	struct sadb_x_ipsecrequest *rq;

I agree that it would be better if family was 16-bits rather than 8-bits,
as the value passed is 16 bits, and pfkey_sockaddr_len() expects a 16 bit
argument. But I don't think this is sufficient to fix to the problem.

The lines following the hunk above are:

        u8 *sa;
        int socklen = pfkey_sockaddr_len(family);
        int size_req;

And the implementation of pfkey_sockaddr_len() is as follows:

static inline int pfkey_sockaddr_len(sa_family_t family)
{
        switch (family) {
        case AF_INET:
                return sizeof(struct sockaddr_in);
#if IS_ENABLED(CONFIG_IPV6)
        case AF_INET6:
                return sizeof(struct sockaddr_in6);
#endif                                                                                  }
        return 0;
}

Where AF_INET is 4 and AF_INET6 is 10. Both of which fit in 8 bits.

And 0 should be returned for any other value, including those with
bits in the upper byte of the 16-bit family set.

It seems to me that a combination of your change, and that proposed
by the following patches - which checks for a 0 return value from
set_ipsecrequest() - is needed.

- net: key: Validate address family in set_ipsecrequest()
  https://lore.kernel.org/all/CANNWa05pX3ratdawb2A6AUBocUgYo+EKZeHBZohQWuBC6_W1AA@mail.gmail.com/T/

- key: No support for family zero
  https://lore.kernel.org/all/tencent_57525DE2DDF41911CFDB8DF525A08D9D9207@qq.com/

Both of those patches cite the following
Fixes: 08de61beab8a ("[PFKEYV2]: Extension for dynamic update of endpoint address(es)")

Which seems correct to me.

