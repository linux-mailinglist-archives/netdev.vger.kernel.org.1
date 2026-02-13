Return-Path: <netdev+bounces-258617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B5LIH40j2lGMgEAu9opvQ
	(envelope-from <netdev+bounces-258617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 15:26:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B391370D8
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 15:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13D62300720B
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 14:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E7323EA85;
	Fri, 13 Feb 2026 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IsgmTBVc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34B61E32D6
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770992762; cv=none; b=aXrqQ4bZ+8ygdlHRQXLB4u9kjXBBeHjyzFsOhYdvNLHcHRua6wFtEI5VmszPX3qvO1sn34uik3EKAJtTSKiyAogc8k9gUGdEwpqCX3N/VmhUHRS9r2aoA/tRgcJhjYE6M5Vt5X+58WZmx7KNSlh810wE0xuy1XqDT1ntckPuaRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770992762; c=relaxed/simple;
	bh=JwK4bQ3Nkka/Gjf8u+FCjEQEILWesdzY82NeJb2Ap8w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FQayzJRmSKKm7ykdg5/siqwVc30yEfz+hPvnRHKQu3gnYYCas/R4TQ2G4pMmbdjAqBfhkV7FfvTiC3UMhwEDFiSBe7oa9vmZB+CKydFTy+rHLCHbdmRwO1RAz3AsxOQEYIx8kquiYQNRdNoTGqhS5Fhj2xs3DzfD8LMX6pmlKfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IsgmTBVc; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-79431a41d9bso16794457b3.3
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 06:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770992760; x=1771597560; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f6AOJ1014bFbydYIWAgVI+ab+ehlIcx3b6JBxs/TWr4=;
        b=IsgmTBVciiM+lkph7d8uRnMVnbAqbYlNYp2JYkyv7Vd57aJukq8C0Y7k6ut7F5VKwe
         vyuw6VO5kuazWTpQRXWdOmuocoVADMZLfBoMZJKVQmlVOyYUY3JjvHQIcSr3SwnqJSmi
         cnUFJOCuILGmjSdZG4e5j5wxxF3X3RelrM1nBfSOtLLNWbyXAyxaFUg58M15EwEJcbwZ
         rA+XK6fPvLVTSVOtd6qs5occYDKhEnaUR7LI9yLTs7mjojjr+sktHuFrXXtuMp0TMAKt
         DXQWrVnAojWIGUw+GeTeVgLLIl38Se5aPaqdNca9V9jDJkOqodMpwVej/A93f9NmJNww
         Ak5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770992760; x=1771597560;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f6AOJ1014bFbydYIWAgVI+ab+ehlIcx3b6JBxs/TWr4=;
        b=p4TycCnNGOilcF+AaIIMsyuT2Vn4hU6C1ji7gYVWtUv1sTU9Xd0ziKZYd432CcVnVd
         gmaGf0LZ/lgOF7+cGS0VMJ4LB6+hkl42xpZQpAQk177IsLTXQNSPbi74aIk+7/3C5cEc
         Nq2qdw5iwehBxcO2REUQOgWVGgSEld577wWtRr7/OURwYycPEDj9oeNTKnGw440rk92n
         Uxsthcjnak3QI4GSu7KSmiRFH5vT1MA5ZyOJKG5480uOUbf5SZpGwxv7tahT9AGaLBLF
         YS36S6yP4Pod3MnXN1clJp4HmSYlNPflNAkUkmaIUd5e19XzivFcCH7WWr0HGG1sU/Ji
         ilSw==
X-Forwarded-Encrypted: i=1; AJvYcCXUsGmRonAyqfpcEl7IDHDFibsk5rQ5TiSX03a7n/xDyfjxHdKcVd3RmIIFDOEQXWpRJ4cpadA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyot9YuKCtvx6AB2XRABIwcI+DkNyA5uw0MfuiaWubkonXpdzZ
	s3UlvcpnWzHc1XGKEhdH0MIYynlmE7P2IBnFdIEPUzi619xGDb6UhWJ4EMu8gCgnwPS6xjNPzC2
	oaDunGAN0W2ip2Q==
X-Received: from ywb21.prod.google.com ([2002:a05:690c:9515:b0:794:d84a:353f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:86:b0:794:2019:2b7 with SMTP id 00721157ae682-7979e899689mr23007247b3.42.1770992759329;
 Fri, 13 Feb 2026 06:25:59 -0800 (PST)
Date: Fri, 13 Feb 2026 14:25:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260213142557.3059043-1-edumazet@google.com>
Subject: [PATCH net] macvlan: observe an RCU grace period in
 macvlan_common_newlink() error path
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, valis <sec@valis.email>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258617-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,valis.email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90B391370D8
X-Rspamd-Action: no action

valis reported that a race condition still happens after my prior patch.

macvlan_common_newlink() might have made @dev visible before
detecting an error, and its caller will directly call free_netdev(dev).

We must respect an RCU period, either in macvlan or the core networking
stack.

After adding a temporary mdelay(1000) in macvlan_forward_source_one()
to open the race window, valis repro was:

ip link add p1 type veth peer p2
ip link set address 00:00:00:00:00:20 dev p1
ip link set up dev p1
ip link set up dev p2
ip link add mv0 link p2 type macvlan mode source

(ip link add invalid% link p2 type macvlan mode source macaddr add
00:00:00:00:00:20 &) ; sleep 0.5 ; ping -c1 -I p1 1.2.3.4
PING 1.2.3.4 (1.2.3.4): 56 data bytes
RTNETLINK answers: Invalid argument

BUG: KASAN: slab-use-after-free in macvlan_forward_source
(drivers/net/macvlan.c:408 drivers/net/macvlan.c:444)
Read of size 8 at addr ffff888016bb89c0 by task e/175

CPU: 1 UID: 1000 PID: 175 Comm: e Not tainted 6.19.0-rc8+ #33 NONE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
Call Trace:
<IRQ>
dump_stack_lvl (lib/dump_stack.c:123)
print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
? macvlan_forward_source (drivers/net/macvlan.c:408 drivers/net/macvlan.c:444)
kasan_report (mm/kasan/report.c:597)
? macvlan_forward_source (drivers/net/macvlan.c:408 drivers/net/macvlan.c:444)
macvlan_forward_source (drivers/net/macvlan.c:408 drivers/net/macvlan.c:444)
? tasklet_init (kernel/softirq.c:983)
macvlan_handle_frame (drivers/net/macvlan.c:501)

Allocated by task 169:
kasan_save_stack (mm/kasan/common.c:58)
kasan_save_track (./arch/x86/include/asm/current.h:25
mm/kasan/common.c:70 mm/kasan/common.c:79)
__kasan_kmalloc (mm/kasan/common.c:419)
__kvmalloc_node_noprof (./include/linux/kasan.h:263 mm/slub.c:5657
mm/slub.c:7140)
alloc_netdev_mqs (net/core/dev.c:12012)
rtnl_create_link (net/core/rtnetlink.c:3648)
rtnl_newlink (net/core/rtnetlink.c:3830 net/core/rtnetlink.c:3957
net/core/rtnetlink.c:4072)
rtnetlink_rcv_msg (net/core/rtnetlink.c:6958)
netlink_rcv_skb (net/netlink/af_netlink.c:2550)
netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:1344)
netlink_sendmsg (net/netlink/af_netlink.c:1894)
__sys_sendto (net/socket.c:727 net/socket.c:742 net/socket.c:2206)
__x64_sys_sendto (net/socket.c:2209)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:131)

Freed by task 169:
kasan_save_stack (mm/kasan/common.c:58)
kasan_save_track (./arch/x86/include/asm/current.h:25
mm/kasan/common.c:70 mm/kasan/common.c:79)
kasan_save_free_info (mm/kasan/generic.c:587)
__kasan_slab_free (mm/kasan/common.c:287)
kfree (mm/slub.c:6674 mm/slub.c:6882)
rtnl_newlink (net/core/rtnetlink.c:3845 net/core/rtnetlink.c:3957
net/core/rtnetlink.c:4072)
rtnetlink_rcv_msg (net/core/rtnetlink.c:6958)
netlink_rcv_skb (net/netlink/af_netlink.c:2550)
netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:1344)
netlink_sendmsg (net/netlink/af_netlink.c:1894)
__sys_sendto (net/socket.c:727 net/socket.c:742 net/socket.c:2206)
__x64_sys_sendto (net/socket.c:2209)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:131)

Fixes: f8db6475a836 ("macvlan: fix error recovery in macvlan_common_newlink()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: valis <sec@valis.email>
---
 drivers/net/macvlan.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index c509228be84d1bb836cc221c1022d4037cd5c883..4433b8e95b6acc89b074dde16262bd38e6ee6840 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1572,6 +1572,11 @@ int macvlan_common_newlink(struct net_device *dev,
 		if (create)
 			macvlan_port_destroy(port->dev);
 	}
+	/* @dev might have been made visible before an error was detected.
+	 * Make sure to observe an RCU grace period before our caller
+	 * (rtnl_newlink()) frees it.
+	 */
+	synchronize_net();
 	return err;
 }
 EXPORT_SYMBOL_GPL(macvlan_common_newlink);
-- 
2.53.0.310.g728cabbaf7-goog


