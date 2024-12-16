Return-Path: <netdev+bounces-152171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DED829F2FD7
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 12:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553DA167D01
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 11:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C519C204563;
	Mon, 16 Dec 2024 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Ysr3X+cq"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FC3204088
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734349875; cv=none; b=XE1tNAmqxRLNhqUXHfKDqPcA0N5e51uem5sPY0SWFTOjx+MHnvYNx1oiB7/GJooBdoCFa1qRaG6QFLsD62osJJlWDRxKIz6qwdS12ziDtjtfmMZucqbNdvQvVe0Hp7n6+5dMgnuKMCGkmTDpH1z5l1re+uwhS9EU0gP+73ZjICc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734349875; c=relaxed/simple;
	bh=lx/rrADmvlBXY7JFBmZBgDhQUvIECeUf7nHCpfcOw+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rnFgM/d3M0Z+vYyFNlWcCX6uZI/BipWkRjxohwel1QYzL8lu+sEn+bGlI8t+jIzkZAv6GBtRDgpNTQ7NeFomCSu3tcpmBdM37H8Yi4aPj4WHnb1S6o9C9DJIO8GpkPIFyuzcl7UXJ7snQQfNQ5UPjsU/0vmknmjQGE4VymRIdqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Ysr3X+cq; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tN9cp-00FkJC-O9; Mon, 16 Dec 2024 12:50:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From;
	bh=StyMjQR4o6IWRrkYThdMVu1OMi637Dwbzw0Efl1DqXk=; b=Ysr3X+cqh3pzU0RQTw76zAoXT7
	MDz603RaEJcGuwL6i+WwfAwgBqUDHAhInpKtFFCjB7GH5TJd16T2jrsbVSMihHHkM6t3XqVeRCoe6
	Nu8QIyOppntgoEM9JaNcW1pYNWo/nHSHBH9fUIrQevM5DmcDuXHhb7tVn59KdM8reaq/lV1RphSbd
	6kTri3kvSwyGjqN0RO5RhfY9pCIWTnd61umwio8ehS1capOQLam0bwrQJc57JDDDQfUa6Pj8dHhoq
	BpYER8K1wzUouZLh1vKKhDURGED539/WPwBLtMwm/k3DpVg/pckAk6+zUcwKOGJDyzaVU3kSCKtXz
	Sx5b9jAg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tN9co-0000X3-TE; Mon, 16 Dec 2024 12:50:59 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tN9cc-00DACF-Ir; Mon, 16 Dec 2024 12:50:46 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 16 Dec 2024 12:50:19 +0100
Subject: [PATCH net] net: Check for oversized requests in sock_kmalloc()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-sock-kmalloc-warn-v1-1-9cb7fdee5b32@rbox.co>
X-B4-Tracking: v=1; b=H4sIAPoTYGcC/x3MTQ5AMBBA4avIrE3Sjp+Fq4hF1WCCVlpBIu6us
 fwW7z0QOQhHaLIHAp8SxbsEnWdgZ+MmRhmSgRSVmnSB0dsFl82sq7d4meBQ6bomVVmqeoLU7YF
 Huf9nC44P6N73A5CkUW9oAAAA
X-Change-ID: 20241213-sock-kmalloc-warn-0166205c25b2
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Allocator explicitly rejects requests of order > MAX_PAGE_ORDER, triggering
a WARN_ON_ONCE_GFP().

Put a size limit in sock_kmalloc().

WARNING: CPU: 6 PID: 1676 at mm/page_alloc.c:4727 __alloc_pages_noprof+0x32e/0x3a0
Call Trace:
 ___kmalloc_large_node+0x71/0xf0
 __kmalloc_large_node_noprof+0x1b/0xf0
 __kmalloc_noprof+0x436/0x560
 sock_kmalloc+0x44/0x60
 ____sys_sendmsg+0x208/0x3a0
 ___sys_sendmsg+0x84/0xd0
 __sys_sendmsg+0x56/0xa0
 do_syscall_64+0x93/0x180
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
$ cat test.py
from socket import *
import os

n = 4096 << 10	# PAGE_SIZE << MAX_PAGE_ORDER
n += 1
data = bytes([0] * n)
os.system("sudo sysctl net.core.optmem_max=%d" % (n + 100))

s = socket(AF_INET, SOCK_STREAM)
cm = [(0, 0, data)]
s.sendmsg([b'x'], cm)

'''
s = socket(AF_ALG, SOCK_SEQPACKET)
s.bind(('hash', 'sha256'))
s.setsockopt(SOL_ALG, ALG_SET_KEY, data)
'''
---
 net/core/sock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 74729d20cd0099e748f4c4fe0be42a2d2d47e77a..1a81c5c09c9f8eb6f8a47624fe08b678b2ab19b0 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2773,7 +2773,8 @@ void *sock_kmalloc(struct sock *sk, int size, gfp_t priority)
 	int optmem_max = READ_ONCE(sock_net(sk)->core.sysctl_optmem_max);
 
 	if ((unsigned int)size <= optmem_max &&
-	    atomic_read(&sk->sk_omem_alloc) + size < optmem_max) {
+	    atomic_read(&sk->sk_omem_alloc) + size < optmem_max &&
+	    size <= PAGE_SIZE << MAX_PAGE_ORDER) {
 		void *mem;
 		/* First do the add, to avoid the race if kmalloc
 		 * might sleep.

---
base-commit: 922b4b955a03d19fea98938f33ef0e62d01f5159
change-id: 20241213-sock-kmalloc-warn-0166205c25b2

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


