Return-Path: <netdev+bounces-133566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE304996486
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 11:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1BB7B233A0
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 09:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10758189B9D;
	Wed,  9 Oct 2024 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MbNrvE81"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B79C188920
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465097; cv=none; b=QmdzV1dIfIJ8nuKUPi0nlNqnjAfNzAFTdIln44a2l/rpiyZ+lbl8CMc5Erxh0EeO39D/ZGB3AAVUuGbp8D/gCVGdYWO480JKcLNRfS3tcvZF/L8WBtT2CwsQRYWF+qYodS2WraYDzUGs4fwOBc9Z4QUzgoPncVvMon/HIzmmYlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465097; c=relaxed/simple;
	bh=l+YWo9Vs04RelazyMAUswd97OfSGxlRxxmArV4fSApA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RBjQE6J1EhZgsMlrz8NZKshtjLNLPFd9kHZ6v/0EuGdcIgYB1CgRld363mniVAzMdoaz73yZ9FvGYFE++xv1u/Wcf8hqjTTBsuCTOKRbOv+rBbMfJQUhx2krulnMC33P6zHcxuGRuOFjNX+N78/GXK2rxjm4ofGDmu4WI5BsgeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MbNrvE81; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02fff66a83so9421310276.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 02:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728465094; x=1729069894; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8NVpx56jOSB/h3tSDix+tzqqh+wpJLjTBsRYxqGHQBg=;
        b=MbNrvE81Ug6TaItwguEUs0RVZ8NOZRNltLvUPmuxRuuA1NypO0DTHXprGw+kgRbqAM
         62wUYAAzL2lnX1H3KKzZafVHNFIACfxqUdvXlsE/Iqm1s88rHelj7pCNWu+ED7RhGJyH
         v2OiGn6yAe0fqSHIylY8Xc9WrVXd6xqsU1l2QdOgGOBEzaxAxMAa4Fcd2w/kP6KrJomO
         UmQQuL9Pa+kNPNVF9ufPy4xfWIp5JdxSDFM5nl/kuVyCNYNs0qyXACHO+KZiOks7/CHM
         qyal5G/MH916zyIg9GIICxGY/jfCPj8O+HP5pHsCNjD5ChKeqxNLDbufmvecqAz6Vm32
         D1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728465094; x=1729069894;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8NVpx56jOSB/h3tSDix+tzqqh+wpJLjTBsRYxqGHQBg=;
        b=UKnQ8xLPxCGoyDJo1uxhSl5fmAsjPe4lRKDEJI3GnVPN92r8CxZ4LEsPQwp+N5ej2c
         8+2PmsjoMqnWutHODP82Gng+PxZ9ucmNyoVb+Tg72hnLt397EFbiWCBTq4l5grQSTFl8
         bl3qcsAW589WHErNqRrTwUyMcmb++ganZtt7/afBkQNW0tl0gUIw3ofbzE2+6DtGKdsF
         fU6yVwt3S+2qSVDDTiObdRwQ+i3hBLCi9n80UgyAxkjGueUbiBYo+WEp+oWUFWq0FnR6
         /uSl7H3rwUsL4hMvhEqbxrLdhciArAWsxJU0gklymKuN/eGOHDzgrPmfr0bfyS34p0PI
         qwOg==
X-Gm-Message-State: AOJu0Yz4cXuh2u/RVmDczgxUmqJkiQ6u/gdckTOtNiCqYbX5Bh8NqoWf
	Gk7olGyeWG0SMUIPKiTbWHX8iCeFKk8HoMHtCNDWHima8TzK2rPeAw3+qyZfzRsDJgIeHwQtb68
	4Zf01R65Cng==
X-Google-Smtp-Source: AGHT+IHAG6Tnhl9HjX8VM3M59B1Hec/IwBYlbnl3Ch8OzJTjwR2YRYKMSwNpO3iqxmjvFg9lb/zL5k+FfFhUzQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:abad:0:b0:e11:44fb:af26 with SMTP id
 3f1490d57ef6-e28fe31ff16mr1352276.2.1728465093772; Wed, 09 Oct 2024 02:11:33
 -0700 (PDT)
Date: Wed,  9 Oct 2024 09:11:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009091132.2136321-1-edumazet@google.com>
Subject: [PATCH net] slip: make slhc_remember() more robust against malicious packets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+2ada1bc857496353be5a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot found that slhc_remember() was missing checks against
malicious packets [1].

slhc_remember() only checked the size of the packet was at least 20,
which is not good enough.

We need to make sure the packet includes the IPv4 and TCP header
that are supposed to be carried.

Add iph and th pointers to make the code more readable.

[1]

BUG: KMSAN: uninit-value in slhc_remember+0x2e8/0x7b0 drivers/net/slip/slhc.c:666
  slhc_remember+0x2e8/0x7b0 drivers/net/slip/slhc.c:666
  ppp_receive_nonmp_frame+0xe45/0x35e0 drivers/net/ppp/ppp_generic.c:2455
  ppp_receive_frame drivers/net/ppp/ppp_generic.c:2372 [inline]
  ppp_do_recv+0x65f/0x40d0 drivers/net/ppp/ppp_generic.c:2212
  ppp_input+0x7dc/0xe60 drivers/net/ppp/ppp_generic.c:2327
  pppoe_rcv_core+0x1d3/0x720 drivers/net/ppp/pppoe.c:379
  sk_backlog_rcv+0x13b/0x420 include/net/sock.h:1113
  __release_sock+0x1da/0x330 net/core/sock.c:3072
  release_sock+0x6b/0x250 net/core/sock.c:3626
  pppoe_sendmsg+0x2b8/0xb90 drivers/net/ppp/pppoe.c:903
  sock_sendmsg_nosec net/socket.c:729 [inline]
  __sock_sendmsg+0x30f/0x380 net/socket.c:744
  ____sys_sendmsg+0x903/0xb60 net/socket.c:2602
  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2656
  __sys_sendmmsg+0x3c1/0x960 net/socket.c:2742
  __do_sys_sendmmsg net/socket.c:2771 [inline]
  __se_sys_sendmmsg net/socket.c:2768 [inline]
  __x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2768
  x64_sys_call+0xb6e/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:308
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
  slab_post_alloc_hook mm/slub.c:4091 [inline]
  slab_alloc_node mm/slub.c:4134 [inline]
  kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4186
  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
  __alloc_skb+0x363/0x7b0 net/core/skbuff.c:678
  alloc_skb include/linux/skbuff.h:1322 [inline]
  sock_wmalloc+0xfe/0x1a0 net/core/sock.c:2732
  pppoe_sendmsg+0x3a7/0xb90 drivers/net/ppp/pppoe.c:867
  sock_sendmsg_nosec net/socket.c:729 [inline]
  __sock_sendmsg+0x30f/0x380 net/socket.c:744
  ____sys_sendmsg+0x903/0xb60 net/socket.c:2602
  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2656
  __sys_sendmmsg+0x3c1/0x960 net/socket.c:2742
  __do_sys_sendmmsg net/socket.c:2771 [inline]
  __se_sys_sendmmsg net/socket.c:2768 [inline]
  __x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2768
  x64_sys_call+0xb6e/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:308
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 5460 Comm: syz.2.33 Not tainted 6.12.0-rc2-syzkaller-00006-g87d6aab2389e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024

Fixes: b5451d783ade ("slip: Move the SLIP drivers")
Reported-by: syzbot+2ada1bc857496353be5a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/670646db.050a0220.3f80e.0027.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/slip/slhc.c | 57 ++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/net/slip/slhc.c b/drivers/net/slip/slhc.c
index 252cd757d3a2e5e1ed8c7dd059aa783ede48c953..ee9fd3a94b96fe11c02eb5da56deb876f6ac5a81 100644
--- a/drivers/net/slip/slhc.c
+++ b/drivers/net/slip/slhc.c
@@ -643,46 +643,57 @@ slhc_uncompress(struct slcompress *comp, unsigned char *icp, int isize)
 int
 slhc_remember(struct slcompress *comp, unsigned char *icp, int isize)
 {
-	struct cstate *cs;
-	unsigned ihl;
-
+	const struct tcphdr *th;
 	unsigned char index;
+	struct iphdr *iph;
+	struct cstate *cs;
+	unsigned int ihl;
 
-	if(isize < 20) {
-		/* The packet is shorter than a legal IP header */
+	/* The packet is shorter than a legal IP header.
+	 * Also make sure isize is positive.
+	 */
+	if (isize < (int)sizeof(struct iphdr)) {
+runt:
 		comp->sls_i_runt++;
-		return slhc_toss( comp );
+		return slhc_toss(comp);
 	}
+	iph = (struct iphdr *)icp;
 	/* Peek at the IP header's IHL field to find its length */
-	ihl = icp[0] & 0xf;
-	if(ihl < 20 / 4){
-		/* The IP header length field is too small */
-		comp->sls_i_runt++;
-		return slhc_toss( comp );
-	}
-	index = icp[9];
-	icp[9] = IPPROTO_TCP;
+	ihl = iph->ihl;
+	/* The IP header length field is too small,
+	 * or packet is shorter than the IP header followed
+	 * by minimal tcp header.
+	 */
+	if (ihl < 5 || isize < ihl * 4 + sizeof(struct tcphdr))
+		goto runt;
+
+	index = iph->protocol;
+	iph->protocol = IPPROTO_TCP;
 
 	if (ip_fast_csum(icp, ihl)) {
 		/* Bad IP header checksum; discard */
 		comp->sls_i_badcheck++;
-		return slhc_toss( comp );
+		return slhc_toss(comp);
 	}
-	if(index > comp->rslot_limit) {
+	if (index > comp->rslot_limit) {
 		comp->sls_i_error++;
 		return slhc_toss(comp);
 	}
-
+	th = (struct tcphdr *)(icp + ihl * 4);
+	if (th->doff < sizeof(struct tcphdr) / 4)
+		goto runt;
+	if (isize < ihl * 4 + th->doff * 4)
+		goto runt;
 	/* Update local state */
 	cs = &comp->rstate[comp->recv_current = index];
 	comp->flags &=~ SLF_TOSS;
-	memcpy(&cs->cs_ip,icp,20);
-	memcpy(&cs->cs_tcp,icp + ihl*4,20);
+	memcpy(&cs->cs_ip, iph, sizeof(*iph));
+	memcpy(&cs->cs_tcp, th, sizeof(*th));
 	if (ihl > 5)
-	  memcpy(cs->cs_ipopt, icp + sizeof(struct iphdr), (ihl - 5) * 4);
-	if (cs->cs_tcp.doff > 5)
-	  memcpy(cs->cs_tcpopt, icp + ihl*4 + sizeof(struct tcphdr), (cs->cs_tcp.doff - 5) * 4);
-	cs->cs_hsize = ihl*2 + cs->cs_tcp.doff*2;
+	  memcpy(cs->cs_ipopt, &iph[1], (ihl - 5) * 4);
+	if (th->doff > 5)
+	  memcpy(cs->cs_tcpopt, &th[1], (th->doff - 5) * 4);
+	cs->cs_hsize = ihl*2 + th->doff*2;
 	cs->initialized = true;
 	/* Put headers back on packet
 	 * Neither header checksum is recalculated
-- 
2.47.0.rc0.187.ge670bccf7e-goog


