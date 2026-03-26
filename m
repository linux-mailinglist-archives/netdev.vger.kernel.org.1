Return-Path: <netdev+bounces-271912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MADUFGjnxGkz5AQAu9opvQ
	(envelope-from <netdev+bounces-271912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:59:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC42330C58
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 954D5303B2C1
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2308E336885;
	Thu, 26 Mar 2026 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="QoRQrDzL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8F8399358
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774511759; cv=none; b=oQlg+DFhFR/i8DX+0GX0kYPqfbHls0qoep+E43yUOMSCnYg7Uw9yq+qAez7UB+S/TNl0aAV6+AuLiiUrXsfloGG5WNMSuPeAclbpEPCiz5HS2pEU0tfP9xJ8VkKG7uigUnlxPjevXAh54FWi1a8lBS5wWESPIVl3NIiaYxUxomE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774511759; c=relaxed/simple;
	bh=vcHqgDeuGfqySo3jZ7qoRaDrqHifByPFSrxlUW4bsuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SvZC7nmMFNGGpYejkgKC/y9KXAS6x06pvt8p/jDf9esssrC24qN7xOqa+Ltc2X+PbuUuz72FhAnIRDWkPrK6hnGhr0suIP1RzkB2Z0TWEx2fU+okq0rmN8+LPbyip5gAz7+izvaraRVTp3NlQriGqju/KtAD6XD0it0L35jZ2o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=QoRQrDzL; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12a74039dc6so559225c88.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 00:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774511756; x=1775116556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LqmnfBcZEk2hLXjkNubvkLIKq53i6KM9D9kQbKWS0BA=;
        b=QoRQrDzL8+mMeBaF2H59E5HVp5ASry74j4vteoGt1BGNsrmgPWviQ83+8/pMzo/yi8
         YzagpY5LTWwl1z28WZ/t0kWll4ufW4S80UTtkjGTFSUv7AbnlC+e7xKdo6Ln7uTeur7I
         KgnRG5tnmQ7bH9Kn922ODdChBdy88w1Uelk4/Fga/HIPBAOZnwCp57f6xjaebbe9xRBC
         85PA+5xPuVSj4t44LUb8qJi9sgvZ3DP6091zUTbWSKrQboVex8A4FPMpzYOLbFEVBe/d
         zceZQEPAi32WP2kUC8iweCE1LmC4jjsnev+gY+jCU9Jp1EY9uxc3XzOXO95XbraWua2W
         COVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774511756; x=1775116556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqmnfBcZEk2hLXjkNubvkLIKq53i6KM9D9kQbKWS0BA=;
        b=oCnLPuwV6yvcGS7Pl5SObCF+7S3M/M6qmy0eHzLJZbyPxGVWuC7rNt43hOa0MVLYxE
         ZrASKYYqdhqTa4KPtG5Phw6GhoXLxmQUyMkniOl3O2ZbqoAHBNcClC8NeLMT5e6c5pvD
         bYRo3aM2Ogc0Re+vhxgtIJJEa44yHRWbyGw6FK8+dTXqPAkN0l0midVeyRMPKH/GvMA/
         ginPcZUY9rmMM6bOz/QdytoyRuG6cCxFp3M7XkRFDJO24hCIf4drnMXkJwLyQ/K9Ot84
         v6P89psAWtQhyDLUYjtMHmkGGOr2ecRmHOTA6TPbVwjhudkGg3LhGhaUbdhONagf92Bj
         zA5Q==
X-Gm-Message-State: AOJu0YyMq7xvo+y78PyOeVvSMoruo4/UQv2pUCmrv92CzpHiv+SnCm3I
	O6EQQgOqSZsiKg1qt94Cv58A1W4KEDZush7ubSeK/0F8Nwszapd9/RlbOpMlZxuiEA==
X-Gm-Gg: ATEYQzw40hrs2hNqhwi3+GPR+odAMQmFj+HxBhzO8cW/lDwPSt4cnaLXjbKTEPb3edg
	micVQLP8TcqZJRSgUzPP7DJws5y9Xm5rnofW9TkZhK5z6X6cTU8KL2KSopLWEAH7JO2h3JTVPT3
	z1XcV1tpUtCkKefeb4fFa/WUP8Mpv+JEOA9wUkhs0Fmqp5J4f9JyuJUdani01uzPxgyk1La8hUh
	T2D0OAuLwbzhuKU2soHDEiP3qOND8uWPBnXJp7pVqMZJuYXtlZLxnoZw7jaasCSAMGLrF+/JbwJ
	rXXgLYv7lbXZ+7aBBgIi+uh4cjOk85HExccd0T9FQvi59jjyGMWW5szhPsGXVM2RTN1czyEWu+U
	QAaCxC0getiKYvCUI4JyVmGtFTmR1XjreT7pSGhceZgR+aPuP6vWsp7qBFG+KeOBcWFf5qy68Nt
	Wfi869KKcoLaFBj/V1bL9WX3asWObNQZXxw9E3HNV1P/kPPJkFpzoZuA==
X-Received: by 2002:a05:7022:e2a:b0:11b:9386:826c with SMTP id a92af1059eb24-12a96f26a42mr3655772c88.41.1774511756490;
        Thu, 26 Mar 2026 00:55:56 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ec258c6sm1976044eec.4.2026.03.26.00.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 00:55:56 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: security@kernel.org
Cc: netdev@vger.kernel.org,
	pabeni@redhat.com,
	jv@jvosburgh.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v3] net: bonding: fix use-after-free in bond_xmit_broadcast()
Date: Thu, 26 Mar 2026 00:55:53 -0700
Message-ID: <20260326075553.3960562-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,asu.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271912-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BFC42330C58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bond_xmit_broadcast() reuses the original skb for the last slave
(determined by bond_is_last_slave()) and clones it for others.
Concurrent slave enslave/release can mutate the slave list during
RCU-protected iteration, changing which slave is "last" mid-loop.
This causes the original skb to be double-consumed (double-freed).

Replace the racy bond_is_last_slave() check with a simple index
comparison (i + 1 == slaves_count) against the pre-snapshot slave
count taken via READ_ONCE() before the loop.  This preserves the
zero-copy optimization for the last slave while making the "last"
determination stable against concurrent list mutations.

The UAF can trigger the following crash:

==================================================================
BUG: KASAN: slab-use-after-free in skb_clone
Read of size 8 at addr ffff888100ef8d40 by task exploit/147

CPU: 1 UID: 0 PID: 147 Comm: exploit Not tainted 7.0.0-rc3+ #4 PREEMPTLAZY
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:123)
 print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
 kasan_report (mm/kasan/report.c:597)
 skb_clone (include/linux/skbuff.h:1724 include/linux/skbuff.h:1792 include/linux/skbuff.h:3396 net/core/skbuff.c:2108)
 bond_xmit_broadcast (drivers/net/bonding/bond_main.c:5334)
 bond_start_xmit (drivers/net/bonding/bond_main.c:5567 drivers/net/bonding/bond_main.c:5593)
 dev_hard_start_xmit (include/linux/netdevice.h:5325 include/linux/netdevice.h:5334 net/core/dev.c:3871 net/core/dev.c:3887)
 __dev_queue_xmit (include/linux/netdevice.h:3601 net/core/dev.c:4838)
 ip6_finish_output2 (include/net/neighbour.h:540 include/net/neighbour.h:554 net/ipv6/ip6_output.c:136)
 ip6_finish_output (net/ipv6/ip6_output.c:208 net/ipv6/ip6_output.c:219)
 ip6_output (net/ipv6/ip6_output.c:250)
 ip6_send_skb (net/ipv6/ip6_output.c:1985)
 udp_v6_send_skb (net/ipv6/udp.c:1442)
 udpv6_sendmsg (net/ipv6/udp.c:1733)
 __sys_sendto (net/socket.c:730 net/socket.c:742 net/socket.c:2206)
 __x64_sys_sendto (net/socket.c:2209)
 do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
 </TASK>

Allocated by task 147:

Freed by task 147:

The buggy address belongs to the object at ffff888100ef8c80
 which belongs to the cache skbuff_head_cache of size 224
The buggy address is located 192 bytes inside of
 freed 224-byte region [ffff888100ef8c80, ffff888100ef8d60)

Memory state around the buggy address:
 ffff888100ef8c00: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888100ef8c80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888100ef8d00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                                    ^
 ffff888100ef8d80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff888100ef8e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Fixes: 4e5bd03ae346 ("net: bonding: fix bond_xmit_broadcast return value error bug")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: replace the costy patch with simple index comparison
v3: resend to netdev

 drivers/net/bonding/bond_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 33f414d03ab91..a5484d11553d1 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5326,7 +5326,7 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
 		if (!(bond_slave_is_up(slave) && slave->link == BOND_LINK_UP))
 			continue;
 
-		if (bond_is_last_slave(bond, slave)) {
+		if (i + 1 == slaves_count) {
 			skb2 = skb;
 			skb_used = true;
 		} else {
-- 
2.43.0


