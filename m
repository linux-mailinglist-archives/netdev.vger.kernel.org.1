Return-Path: <netdev+bounces-65905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5F383C490
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 15:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C281C23C26
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 14:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864CE63404;
	Thu, 25 Jan 2024 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="A2me9CP6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f100.google.com (mail-lf1-f100.google.com [209.85.167.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27794633F4
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706192334; cv=none; b=M36k8tcpufj4YSL3RSCV0Y8VcWS94/n4cmIeTynDJLL2RBXrBKsFTqjbLRb4MHGNorYc4WIE9q3DHlNmgnWelCl5TsY1DbZ88eEw58E5nKNUxmMh65NBlNmzJz424txgHqNAgOExmg4+/r+XtUWBQGNmGESGmr9I77XYnwZqqg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706192334; c=relaxed/simple;
	bh=u8wkyif+CjItPeovUFqu1TDrnLps0GEUOnAd9PbeJBI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cXpdubI4AZMy/VWKnzCWwtHjqbxAqyyrS/Jw4P/wgcIW32UP43rsCGm315GsS6RnA/WKVN66wnNolUTtmgo52uPwflvhbmDXjIx16q8QnSBpIStKlySzwn+n87jH5JYCs+LMZ73lgVLNKIlI4d2hZnRW5v+BfFAxccgwHiXtpnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=A2me9CP6; arc=none smtp.client-ip=209.85.167.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f100.google.com with SMTP id 2adb3069b0e04-5101f2dfdadso751647e87.2
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 06:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1706192330; x=1706797130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kfsAh3pdx8X0G7lrZg7WQIh4HeWxWjA68kz9iiJr3pw=;
        b=A2me9CP6dLlt2qm4VpTFcF+XjDV3anpKhEUFdypN0Puk/biHwp2go16iz153upTHF5
         7gMulGPc7U9N1u64MBQhH29wL2cq9uKQChofhaGURzC3q2MjW+/saNdqK+soGkrUNxjo
         ryrwYIy/+SyYcm9fnI6azANcqF8EOLcuGNvya1tq2vLJV5mNXmg9MWugiaKsboYaB488
         vUSf6SDboklpa1WYVtMmVJDGFZUd/4MjbshZpL41fJ49MbJBjmPd8QNI0GeAzCgCwgxC
         DsmH3cJrut/XI+xafsJ0HntjVyNio/TNJZFGBL33p/z6cCmknsZPHt9nCdvj98X+WySg
         Hgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706192330; x=1706797130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfsAh3pdx8X0G7lrZg7WQIh4HeWxWjA68kz9iiJr3pw=;
        b=siut7Vsi4PXlUL9KtyVdzf28Id2MIOiqeJJh/I3AzZkwHisFurW6qrwbrGwyqqa0ky
         X4HGqFWX0B3tCB2NfQ1AW7aOeQxAePwackJRt3LLaqGqt92KVPdUZPKNoBnQbJLzgST+
         fdWTdpySpGrvAmLqR3iJW53tY6H2JjUmuaQTx8c748JRZueruLINEBBdQfbEu7cU5i07
         gOohfHXFb80c+9UQfvv0YZiDik1TUMlzsln0EJ2MBso+I2JImuiGHVEyw0Z8/sLSa4qN
         geeiaMnZfn7KtlZGg9fEHfNoOfvcGRycnCUbH6Dh3SH3n8L8aoOOIYOvgMCpK5KVCPgA
         cU8Q==
X-Gm-Message-State: AOJu0YzYPyrP2BvSP01uyRlRHJubkbKm1/uPk7xLqxPqt29d9v7hOpkX
	2pYh9JOv1PC0kp/Cnuae7vrJIb783+uo6bO09lswfURbMrmsIh5rG2JlUh0i2r9bjxynCoQRraz
	8l+WDBO7U3vDgO9I0oBSumP+aPKJpsN92
X-Google-Smtp-Source: AGHT+IEialDFtfRXjs+00Mbzb6TPWniNZs/61JVe7HLGGk+MIU4NT5mS6+HNLqI9y63xIxylPGkNmOk/fV3v
X-Received: by 2002:a19:a409:0:b0:50e:aa8d:24b3 with SMTP id q9-20020a19a409000000b0050eaa8d24b3mr544819lfc.10.1706192330084;
        Thu, 25 Jan 2024 06:18:50 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id k14-20020a0565123d8e00b0050e74e17dacsm569304lfv.17.2024.01.25.06.18.49;
        Thu, 25 Jan 2024 06:18:50 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id AC50E6023E;
	Thu, 25 Jan 2024 15:18:49 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1rT0Z7-0086bS-Cl; Thu, 25 Jan 2024 15:18:49 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Leone Fernando <leone4fernando@gmail.com>
Cc: netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net v2] ipmr: fix kernel panic when forwarding mcast packets
Date: Thu, 25 Jan 2024 15:18:47 +0100
Message-Id: <20240125141847.1931933-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The stacktrace was:
[   86.305548] BUG: kernel NULL pointer dereference, address: 0000000000000092
[   86.306815] #PF: supervisor read access in kernel mode
[   86.307717] #PF: error_code(0x0000) - not-present page
[   86.308624] PGD 0 P4D 0
[   86.309091] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   86.309883] CPU: 2 PID: 3139 Comm: pimd Tainted: G     U             6.8.0-6wind-knet #1
[   86.311027] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.1-0-g0551a4be2c-prebuilt.qemu-project.org 04/01/2014
[   86.312728] RIP: 0010:ip_mr_forward (/build/work/knet/net/ipv4/ipmr.c:1985)
[ 86.313399] Code: f9 1f 0f 87 85 03 00 00 48 8d 04 5b 48 8d 04 83 49 8d 44 c5 00 48 8b 40 70 48 39 c2 0f 84 d9 00 00 00 49 8b 46 58 48 83 e0 fe <80> b8 92 00 00 00 00 0f 84 55 ff ff ff 49 83 47 38 01 45 85 e4 0f
[   86.316565] RSP: 0018:ffffad21c0583ae0 EFLAGS: 00010246
[   86.317497] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   86.318596] RDX: ffff9559cb46c000 RSI: 0000000000000000 RDI: 0000000000000000
[   86.319627] RBP: ffffad21c0583b30 R08: 0000000000000000 R09: 0000000000000000
[   86.320650] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
[   86.321672] R13: ffff9559c093a000 R14: ffff9559cc00b800 R15: ffff9559c09c1d80
[   86.322873] FS:  00007f85db661980(0000) GS:ffff955a79d00000(0000) knlGS:0000000000000000
[   86.324291] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   86.325314] CR2: 0000000000000092 CR3: 000000002f13a000 CR4: 0000000000350ef0
[   86.326589] Call Trace:
[   86.327036]  <TASK>
[   86.327434] ? show_regs (/build/work/knet/arch/x86/kernel/dumpstack.c:479)
[   86.328049] ? __die (/build/work/knet/arch/x86/kernel/dumpstack.c:421 /build/work/knet/arch/x86/kernel/dumpstack.c:434)
[   86.328508] ? page_fault_oops (/build/work/knet/arch/x86/mm/fault.c:707)
[   86.329107] ? do_user_addr_fault (/build/work/knet/arch/x86/mm/fault.c:1264)
[   86.329756] ? srso_return_thunk (/build/work/knet/arch/x86/lib/retpoline.S:223)
[   86.330350] ? __irq_work_queue_local (/build/work/knet/kernel/irq_work.c:111 (discriminator 1))
[   86.331013] ? exc_page_fault (/build/work/knet/./arch/x86/include/asm/paravirt.h:693 /build/work/knet/arch/x86/mm/fault.c:1515 /build/work/knet/arch/x86/mm/fault.c:1563)
[   86.331702] ? asm_exc_page_fault (/build/work/knet/./arch/x86/include/asm/idtentry.h:570)
[   86.332468] ? ip_mr_forward (/build/work/knet/net/ipv4/ipmr.c:1985)
[   86.333183] ? srso_return_thunk (/build/work/knet/arch/x86/lib/retpoline.S:223)
[   86.333920] ipmr_mfc_add (/build/work/knet/./include/linux/rcupdate.h:782 /build/work/knet/net/ipv4/ipmr.c:1009 /build/work/knet/net/ipv4/ipmr.c:1273)
[   86.334583] ? __pfx_ipmr_hash_cmp (/build/work/knet/net/ipv4/ipmr.c:363)
[   86.335357] ip_mroute_setsockopt (/build/work/knet/net/ipv4/ipmr.c:1470)
[   86.336135] ? srso_return_thunk (/build/work/knet/arch/x86/lib/retpoline.S:223)
[   86.336854] ? ip_mroute_setsockopt (/build/work/knet/net/ipv4/ipmr.c:1470)
[   86.337679] do_ip_setsockopt (/build/work/knet/net/ipv4/ip_sockglue.c:944)
[   86.338408] ? __pfx_unix_stream_read_actor (/build/work/knet/net/unix/af_unix.c:2862)
[   86.339232] ? srso_return_thunk (/build/work/knet/arch/x86/lib/retpoline.S:223)
[   86.339809] ? aa_sk_perm (/build/work/knet/security/apparmor/include/cred.h:153 /build/work/knet/security/apparmor/net.c:181)
[   86.340342] ip_setsockopt (/build/work/knet/net/ipv4/ip_sockglue.c:1415)
[   86.340859] raw_setsockopt (/build/work/knet/net/ipv4/raw.c:836)
[   86.341408] ? security_socket_setsockopt (/build/work/knet/security/security.c:4561 (discriminator 13))
[   86.342116] sock_common_setsockopt (/build/work/knet/net/core/sock.c:3716)
[   86.342747] do_sock_setsockopt (/build/work/knet/net/socket.c:2313)
[   86.343363] __sys_setsockopt (/build/work/knet/./include/linux/file.h:32 /build/work/knet/net/socket.c:2336)
[   86.344020] __x64_sys_setsockopt (/build/work/knet/net/socket.c:2340)
[   86.344766] do_syscall_64 (/build/work/knet/arch/x86/entry/common.c:52 /build/work/knet/arch/x86/entry/common.c:83)
[   86.345433] ? srso_return_thunk (/build/work/knet/arch/x86/lib/retpoline.S:223)
[   86.346161] ? syscall_exit_work (/build/work/knet/./include/linux/audit.h:357 /build/work/knet/kernel/entry/common.c:160)
[   86.346938] ? srso_return_thunk (/build/work/knet/arch/x86/lib/retpoline.S:223)
[   86.347657] ? syscall_exit_to_user_mode (/build/work/knet/kernel/entry/common.c:215)
[   86.348538] ? srso_return_thunk (/build/work/knet/arch/x86/lib/retpoline.S:223)
[   86.349262] ? do_syscall_64 (/build/work/knet/./arch/x86/include/asm/cpufeature.h:171 /build/work/knet/arch/x86/entry/common.c:98)
[   86.349971] entry_SYSCALL_64_after_hwframe (/build/work/knet/arch/x86/entry/entry_64.S:129)

The original packet in ipmr_cache_report() may be queued and then forwarded
with ip_mr_forward(). This last function has the assumption that the skb
dst is set.

After the below commit, the skb dst is dropped by ipv4_pktinfo_prepare(),
which causes the oops.

Fixes: bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP msg")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---

v1 -> v2:
 - rename keep_dst to drop_dst
 - add drop_dst arg to kdoc

 include/net/ip.h       | 2 +-
 net/ipv4/ip_sockglue.c | 6 ++++--
 net/ipv4/ipmr.c        | 2 +-
 net/ipv4/raw.c         | 2 +-
 net/ipv4/udp.c         | 2 +-
 5 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index de0c69c57e3c..25cb688bdc62 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -767,7 +767,7 @@ int ip_options_rcv_srr(struct sk_buff *skb, struct net_device *dev);
  *	Functions provided by ip_sockglue.c
  */
 
-void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb);
+void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb, bool drop_dst);
 void ip_cmsg_recv_offset(struct msghdr *msg, struct sock *sk,
 			 struct sk_buff *skb, int tlen, int offset);
 int ip_cmsg_send(struct sock *sk, struct msghdr *msg,
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 7aa9dc0e6760..21d2ffa919e9 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1363,12 +1363,13 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
  * ipv4_pktinfo_prepare - transfer some info from rtable to skb
  * @sk: socket
  * @skb: buffer
+ * @drop_dst: if true, drops skb dst
  *
  * To support IP_CMSG_PKTINFO option, we store rt_iif and specific
  * destination in skb->cb[] before dst drop.
  * This way, receiver doesn't make cache line misses to read rtable.
  */
-void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb)
+void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb, bool drop_dst)
 {
 	struct in_pktinfo *pktinfo = PKTINFO_SKB_CB(skb);
 	bool prepare = inet_test_bit(PKTINFO, sk) ||
@@ -1397,7 +1398,8 @@ void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb)
 		pktinfo->ipi_ifindex = 0;
 		pktinfo->ipi_spec_dst.s_addr = 0;
 	}
-	skb_dst_drop(skb);
+	if (drop_dst)
+		skb_dst_drop(skb);
 }
 
 int ip_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 9d6f59531b3a..362229836510 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1073,7 +1073,7 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		msg = (struct igmpmsg *)skb_network_header(skb);
 		msg->im_vif = vifi;
 		msg->im_vif_hi = vifi >> 8;
-		ipv4_pktinfo_prepare(mroute_sk, pkt);
+		ipv4_pktinfo_prepare(mroute_sk, pkt, false);
 		memcpy(skb->cb, pkt->cb, sizeof(skb->cb));
 		/* Add our header */
 		igmp = skb_put(skb, sizeof(struct igmphdr));
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 27da9d7294c0..aea89326c697 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -292,7 +292,7 @@ static int raw_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 	/* Charge it to the socket. */
 
-	ipv4_pktinfo_prepare(sk, skb);
+	ipv4_pktinfo_prepare(sk, skb, true);
 	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0) {
 		kfree_skb_reason(skb, reason);
 		return NET_RX_DROP;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 148ffb007969..f631b0a21af4 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2169,7 +2169,7 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 
 	udp_csum_pull_header(skb);
 
-	ipv4_pktinfo_prepare(sk, skb);
+	ipv4_pktinfo_prepare(sk, skb, true);
 	return __udp_queue_rcv_skb(sk, skb);
 
 csum_error:
-- 
2.39.2


