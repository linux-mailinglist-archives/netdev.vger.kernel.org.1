Return-Path: <netdev+bounces-267984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6y6jDpxUt2kwQAEAu9opvQ
	(envelope-from <netdev+bounces-267984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 01:53:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF0F293280
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 01:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DC033007647
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 00:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23F01EE7B7;
	Mon, 16 Mar 2026 00:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="AjG/Bq4g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF00A165F1A
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 00:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773622425; cv=none; b=qwENFJeD2pw5v7yUIQazwYzDbwDNK/UYy3ChSf3LdvH3V/E1b/dUD8yN3VidBBF3hxk9XbqYcRewjzzgV8zHxda8jjq5OvbiRfsLpoFnR1aEcWOCb87jcRAiYMlN6ZVDDfZJjkP+4bBk6YGwaOJsjFsAU8xcoxUsYGv+NthPhho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773622425; c=relaxed/simple;
	bh=1nO4S2vlkgn5Xi21VGC8wjgDNMDeQD8xYMIO5kDHuuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pa668awscRvfz0VSdUfVn13H/xM/VRaoAxi19ZjwDed/av3maBL3pa/Qxx9NpMcJ38FKZHz2WjTfKAXNM10ty6nN1ApeVgjlwGRDxfln6dzMFjiSW/FtcSa2BbZ7MC18lnkBPxDL7u0UMtpcr9f34tPzLtVaTgiHdsOjIQRkbEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=AjG/Bq4g; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso2182840eec.0
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 17:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1773622423; x=1774227223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xDYD6bcTgPPKAX26vSvCks1Tv1BDH896Po3U0pXc+6U=;
        b=AjG/Bq4gNq4rEJNGVb3pcKhs5M4a2bs+gtkufyqcIukeFyWJb6yOCT3a5+Jruz9WNv
         m7rH6TE+AKKBU//DzSILGhMVMzFe1q/LFMfIJma31CJWfYwCrVmncjybXRZh/CG2R3Eh
         bb6N0CxdnDKYST9OTm107fJNgpoHnVQKL0HxIZDUyfmieqrD3JNNBKCG/IBU3QlT2MfD
         kI9yyJVWj5fzdEjWXf86DU+58+hPECIpI6pssafPXPDHYKvYlEGuIy25dtXU3UT5+zY8
         3O60d+9pn9HwQaYwPSiO2t1IEHFGyqRVHId4yvgwF49b3rDhDnrp3K3mN8eSKMfGy+x8
         fDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773622423; x=1774227223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDYD6bcTgPPKAX26vSvCks1Tv1BDH896Po3U0pXc+6U=;
        b=k2yYqiw+ERXF+1fPCVKuOeYMP+yqVLbBsNh7eSKiALOKxKDVza/IlvmJsJsHhwyrpS
         02ZchMh7if5Cpp7XVnkCD7HynGElYBkTwXjSbQmdVTh+0+8FY8haN+XeOXvuXAioUsdB
         Cd8UO0dn1LIKmhr7ZbFDzCJvD4ZB693r0bG+mGmIzU1o8/MSVfh968EMOqf96WUi5dfq
         FpzEAV3XOSMOr9fa5cdYlVGyP/jADlOLkPSzwAK5G+ekFMnxXDFpu1dYFSeu0JA2fzGX
         Z0XaPY4yvUlPt060ob6QjYzs+adEr6S/xSHCefLG9AQsOUpQJO1pk9yJVz8qTBsLELRy
         ayzg==
X-Gm-Message-State: AOJu0YxepaeH8iJjZ3OHHvrV2MG4SuZQUQuhojW5wtODDQIeuJY7/Cyv
	QABxZDYLWhU5I0KuMWMnw1Rya0WrwUI6Q2hAbWbGfrDER3s3Cc9oiLVu1uq2G0QLbWcFEHCjsSI
	XqzLVnw==
X-Gm-Gg: ATEYQzxA2163ssYnq9SkuIhyusm8iRniYSl2xBSpqt2ebvxzR/KhIe6RScK/rh3ZCiY
	ml7ezgUQMNP6Y1+05B0GI+/VYUKt4g3Q2P+RFGE7mt4/VJA6F75ova0r7BHuCqUBkrT+5htDvwf
	+wYCgAL6ddc7fa/4t4bw841xSmsfdLmP5bhir96t8mFnhv5E+1JuNPiJQ/2KsUQTIIg+Jy9Oy8h
	pOGdEsODP2HWLtvmksCUVJl9D6TlrF9ylg3QfJNZWWLG/u4opFCVCpAThzsNAlAhIAWyQCYA6uG
	dwgDpmjMQYyn48/embm7pAGFxMfXcAHH+n9n8o+rK1bsHJBuNpSKtgQj1Bd0TbKVL1V1aX9NiOG
	P3XoTosSrFFFSoD4e6k9NesFGIdqLpYn4qObbQ46M6bZv/ijp9G1sz0vhxjXaRo18sgyo4+yj7B
	9JhqfDtnu/BX2b8JV7lG0ZEgXxN/j0k2pYurE60KSSCQYqGk7Mw6dG2w==
X-Received: by 2002:a05:7300:8184:b0:2c0:c1e0:2449 with SMTP id 5a478bee46e88-2c0c1e034f3mr840770eec.2.1773622422456;
        Sun, 15 Mar 2026 17:53:42 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3a12e2sm12789846eec.2.2026.03.15.17.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 17:53:42 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] udp_tunnel: fix NULL deref caused by udp_sock_create6 when CONFIG_IPV6=n
Date: Sun, 15 Mar 2026 17:53:37 -0700
Message-ID: <20260316005337.1147633-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267984-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,asu.edu];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[asu.edu:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,asu.edu:dkim,asu.edu:email,asu.edu:mid]
X-Rspamd-Queue-Id: 9AF0F293280
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When CONFIG_IPV6 is disabled, the udp_sock_create6() function returns 0
(success) without actually creating a socket. Callers such as
fou_create() then proceed to dereference the uninitialized socket
pointer, resulting in a NULL pointer dereference.

Return -EPFNOSUPPORT instead, so callers correctly take their error
paths. There is only one caller of the vulnerable function and only
privileged users can trigger it.

The captured NULL deref crash:
[    0.489638] BUG: kernel NULL pointer dereference, address: 0000000000000018
[    0.489962] #PF: supervisor read access in kernel mode
[    0.490193] #PF: error_code(0x0000) - not-present page
[    0.490435] PGD 102a11067 P4D 102a11067 PUD 102a12067 PMD 0
[    0.490706] Oops: Oops: 0000 [#1] SMP NOPTI
[    0.490905] CPU: 0 UID: 0 PID: 140 Comm: exploit Not tainted 7.0.0-rc3+ #2 PREEMPTLAZY
[    0.491266] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[    0.491786] RIP: 0010:fou_nl_add_doit (net/ipv4/fou_core.c:590 net/ipv4/fou_core.c:764)
[    0.492009] Code: c5 48 85 c0 0f 84 04 02 00 00 48 8b 34 24 0f b7 44 24 1c 4c 8d 44 24 30 b9 07 00 00 00 0f b7 54 24 0c 4c 89 c7 48 89 6c 24 28 <4c> 8b 6e 18 66 89 45 0a 0f b6 44 24 10 66 89 55 0e 48 89 75 00 88
All code
========
   0:	c5 48 85             	(bad)
   3:	c0 0f 84             	rorb   $0x84,(%rdi)
   6:	04 02                	add    $0x2,%al
   8:	00 00                	add    %al,(%rax)
   a:	48 8b 34 24          	mov    (%rsp),%rsi
   e:	0f b7 44 24 1c       	movzwl 0x1c(%rsp),%eax
  13:	4c 8d 44 24 30       	lea    0x30(%rsp),%r8
  18:	b9 07 00 00 00       	mov    $0x7,%ecx
  1d:	0f b7 54 24 0c       	movzwl 0xc(%rsp),%edx
  22:	4c 89 c7             	mov    %r8,%rdi
  25:	48 89 6c 24 28       	mov    %rbp,0x28(%rsp)
  2a:*	4c 8b 6e 18          	mov    0x18(%rsi),%r13		<-- trapping instruction
  2e:	66 89 45 0a          	mov    %ax,0xa(%rbp)
  32:	0f b6 44 24 10       	movzbl 0x10(%rsp),%eax
  37:	66 89 55 0e          	mov    %dx,0xe(%rbp)
  3b:	48 89 75 00          	mov    %rsi,0x0(%rbp)
  3f:	88                   	.byte 0x88

Code starting with the faulting instruction
===========================================
   0:	4c 8b 6e 18          	mov    0x18(%rsi),%r13
   4:	66 89 45 0a          	mov    %ax,0xa(%rbp)
   8:	0f b6 44 24 10       	movzbl 0x10(%rsp),%eax
   d:	66 89 55 0e          	mov    %dx,0xe(%rbp)
  11:	48 89 75 00          	mov    %rsi,0x0(%rbp)
  15:	88                   	.byte 0x88
[    0.492846] RSP: 0018:ffffc900004a7a68 EFLAGS: 00010282
[    0.493095] RAX: 0000000000003201 RBX: 0000000000000000 RCX: 0000000000000007
[    0.493419] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc900004a7a98
[    0.493754] RBP: ffff888102882180 R08: ffffc900004a7a98 R09: ffff888102882180
[    0.494084] R10: 0000000000000001 R11: 0000000000000000 R12: ffffc900004a7a90
[    0.494399] R13: ffff8881008f7a00 R14: ffffc900004a7b20 R15: 0000000000000000
[    0.494744] FS:  0000000021ac2380(0000) GS:ffff888196dab000(0000) knlGS:0000000000000000
[    0.495126] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.495385] CR2: 0000000000000018 CR3: 0000000102a0a004 CR4: 0000000000772ef0
[    0.495723] PKRU: 55555554
[    0.495861] Call Trace:
[    0.495990]  <TASK>
[    0.496101]  genl_family_rcv_msg_doit.constprop.0 (net/netlink/genetlink.c:1114)
[    0.496362]  genl_rcv_msg (net/netlink/genetlink.c:1194 net/netlink/genetlink.c:1209)
[    0.496530]  ? __pfx_fou_nl_add_doit (net/ipv4/fou_core.c:755)
[    0.496757]  ? __pfx_genl_rcv_msg (net/netlink/genetlink.c:1200)
[    0.496962]  netlink_rcv_skb (net/netlink/af_netlink.c:2550)
[    0.497153]  genl_rcv (net/netlink/genetlink.c:1219)
[    0.497299]  netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:1344)
[    0.497476]  netlink_sendmsg (net/netlink/af_netlink.c:1894)
[    0.497669]  __sock_sendmsg (net/socket.c:727 (discriminator 1) net/socket.c:742 (discriminator 1))
[    0.497856]  __sys_sendto (./include/linux/file.h:62 (discriminator 1) ./include/linux/file.h:83 (discriminator 1) net/socket.c:2183 (discriminator 1))
[    0.498033]  __x64_sys_sendto (net/socket.c:2213 (discriminator 1) net/socket.c:2209 (discriminator 1) net/socket.c:2209 (discriminator 1))
[    0.498212]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
[    0.498381]  entry_SYSCALL_64_after_hwframe (net/arch/x86/entry/entry_64.S:130)
[    0.498610] RIP: 0033:0x41ce17
[    0.498763] Code: ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b5 0f 1f 00 f3 0f 1e fa 80 3d 4d 62 09 00 00 41 89 ca 74 10 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 69 c3 55 48 89 e5 53 48 83 ec 38 44 89 4d d0
All code
========
   0:	ff                   	(bad)
   1:	ff f7                	push   %rdi
   3:	d8 64 89 02          	fsubs  0x2(%rcx,%rcx,4)
   7:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
   e:	eb b5                	jmp    0xffffffffffffffc5
  10:	0f 1f 00             	nopl   (%rax)
  13:	f3 0f 1e fa          	endbr64
  17:	80 3d 4d 62 09 00 00 	cmpb   $0x0,0x9624d(%rip)        # 0x9626b
  1e:	41 89 ca             	mov    %ecx,%r10d
  21:	74 10                	je     0x33
  23:	b8 2c 00 00 00       	mov    $0x2c,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 69                	ja     0x9b
  32:	c3                   	ret
  33:	55                   	push   %rbp
  34:	48 89 e5             	mov    %rsp,%rbp
  37:	53                   	push   %rbx
  38:	48 83 ec 38          	sub    $0x38,%rsp
  3c:	44 89 4d d0          	mov    %r9d,-0x30(%rbp)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 69                	ja     0x71
   8:	c3                   	ret
   9:	55                   	push   %rbp
   a:	48 89 e5             	mov    %rsp,%rbp
   d:	53                   	push   %rbx
   e:	48 83 ec 38          	sub    $0x38,%rsp
  12:	44 89 4d d0          	mov    %r9d,-0x30(%rbp)
[    0.499591] RSP: 002b:00007ffd7730d918 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[    0.499950] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 000000000041ce17
[    0.500272] RDX: 000000000000002c RSI: 00000000004b3b20 RDI: 0000000000000003
[    0.500585] RBP: 00007ffd7730d970 R08: 00007ffd7730d94c R09: 000000000000000c
[    0.500923] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffd7730da88
[    0.501246] R13: 00007ffd7730da98 R14: 00000000004ad868 R15: 0000000000000001
[    0.501559]  </TASK>

Fixes: fd384412e199b ("udp_tunnel: Seperate ipv6 functions into its own file.")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 include/net/udp_tunnel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index d9c6d04bb3b5..fc1fc43345b5 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -52,7 +52,7 @@ int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
 static inline int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
 				   struct socket **sockp)
 {
-	return 0;
+	return -EPFNOSUPPORT;
 }
 #endif
 
-- 
2.43.0


