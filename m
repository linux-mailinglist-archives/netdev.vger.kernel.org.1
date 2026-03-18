Return-Path: <netdev+bounces-269214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNANLRk0u2lFgwIAu9opvQ
	(envelope-from <netdev+bounces-269214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:24:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 571392C3CEE
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A147301461C
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F9B34DB66;
	Wed, 18 Mar 2026 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="UZlyd0rk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F9B34B1AC
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773876238; cv=none; b=uY768iz964fogNhQp2/bMdjRxcyhsy3pBy4q+pZK41zx+ikkYu1JrwyhY/HiB0caWpAToCqyRecrk6vp1aiE3MNXnV++UjxxTBf9In1PQEXmtdHhjSJoaVm4Ui/zYxi8SUwC1tIoZjANcwAshI1UvLWripW9JpkbeX+LXnTv7Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773876238; c=relaxed/simple;
	bh=9KLaqkpIx6dkXoMZd4ahr0esGw+qhMJ41IGqbZDn0PI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hbLsAvYK++44bEQE8X9UUU/5IudhrWZSCDQ85Q7H2OqajF+NKyroN56roeglmMNe8kUwCaUkP99G5C/E5bX1k2SsM1CCU+OuyvbGTeP2kIB1w7Az7cr5jpIJDOCJFVpoPSfF0rIHLLzji4jAt7tjoVkO2yaaXQ8tLRw6aCFcuq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=UZlyd0rk; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-128e3125372so280745c88.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 16:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1773876235; x=1774481035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PvN4ygrtaJRZUCXR1BWknZlQqD5Lstu+gjTz+1VOHWU=;
        b=UZlyd0rkev9ObUPv0mGCIcqjK+RtIdE+Orp1s5HTf5MkVZKO42JLrrFvb2zgwQdUDZ
         RN4OSIHoXFxsAKGXOFF2zl95jsUV+t4HJayibD6apWuPTS/WiIO1IbsXcg8n5fzJCNs5
         Ux8VgAVC/yc5HrBkZ0vO7XMEILSyqK1nfVYdj0LDrCP+EvJWIvDMWF2EjzvFsQAtJMmR
         qh2K7VJ1pdCUSDRujKqHHKuoQ+jv3I6M8uMoHg+gmF54gO48KZTTOZh2X21AqLwWjzwU
         y+KgpEzqN4Hc6rQ7Lb9IRG8iip2fTgr7z0n8fCWxDYtB1w4keLBNnmxRaVVV0skdwf9A
         8qOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773876235; x=1774481035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvN4ygrtaJRZUCXR1BWknZlQqD5Lstu+gjTz+1VOHWU=;
        b=jJMZ9CVniCZv/vh627+P2W2xl4JMK65A+hrZ6UMwAudB8C+msjyd6M6wV5/W9eULOy
         69nuFoDc3FercMbx4w7qrsRTTgKX3E2OGvUmqOw5fKjOpGVQxHJFcQ9/UYm+IfP0/Zs/
         XVg2rnctoBXdhmoTi21Arrsog7zOftZQ8+uxg+UUbWrYis1UewiRHN1bm4JzigOHtljV
         FPRaHsFI+zMMK0o3V99azC7PZeArgi6VIfKRKB4xCIIO8w74AZvHYsIp9HHIM6bd73Jr
         54/ErpieXiIUN1ccr6imWxt0zCQ3LKMtZC2jedk1U9+5IPF4FfRw9caCWhWNd1MtFX4/
         mroA==
X-Gm-Message-State: AOJu0YwCANw/dz8TEzn7LtdbTj+q8ndGC3VELKRrqbsQN0gliEeKqBjH
	viU+ubBv85vhCB/swQ0+wQQfaqaJjMRlkwRdh1RA4ssceXfMy1i9Iv8AAatrujIkqw==
X-Gm-Gg: ATEYQzyVyv4s17MthMeZHYNwtJziZuD8yS8VLvomVTYFGoolompVpfE1JQJZ4HVJc7j
	zPpsBPMUN4zag53hRU+tp1q36MAV6yvWFcoI9Gkz24FLv0KFAWVTH1CzMCT9pne8o6mkJ7cboxc
	u58oQv+jc+TktALeBN7pcJx4XVO2Gsv+djl7QQw9X7cXnUk4gzRDfxlKKokWIwT/4UxgKX15NVm
	sWet/0/GuwRDZ6cWYNd/91APJbvWNXGKNgcDwpXl9U5W8JO4ofX+Jgpg0X/d8+QHbcGHGolwfzc
	jmIQw1IPofiTUUvNIF/EmZkaC/b3nzlpYTp7A+djPAk/A+SxdtH+KH6Wxw2haq3yYJb8lwdqm8a
	BU7z770c742yDtwmB+itEZVmLwn21bRlSEx34aKYHgzg4+m/RL0EQa7yppje30kn5IgOO/QQtPl
	6IOP7xqiXSt0aD28EK8dUTYOD5pvtMkC44XWFZHysXZL8ufRiCGR74pA==
X-Received: by 2002:a05:7022:238e:b0:11d:fbf1:1e27 with SMTP id a92af1059eb24-12a6857adcdmr672879c88.19.1773876235233;
        Wed, 18 Mar 2026 16:23:55 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-129b413a749sm4874259c88.14.2026.03.18.16.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 16:23:54 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: security@kernel.org
Cc: netdev@vger.kernel.org,
	jv@jvosburgh.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] net: bonding: fix use-after-free in bond_xmit_broadcast()
Date: Wed, 18 Mar 2026 16:23:32 -0700
Message-ID: <20260318232332.3528647-1-xmei5@asu.edu>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,asu.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269214-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.960];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 571392C3CEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bond_xmit_broadcast() reuses the original skb for the last slave
(determined by bond_is_last_slave()) and clones it for others.
Concurrent slave enslave/release can mutate the slave list during
RCU-protected iteration, changing which slave is "last" mid-loop.
This causes the original skb to be either double-consumed or freed.

Always clone the skb for every slave and unconditionally free the
original after the loop, removing the racy bond_is_last_slave()
optimization.

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
 drivers/net/bonding/bond_main.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 33f414d03ab91..8e57bee13e4ad 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5310,7 +5310,6 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
 	struct bonding *bond = netdev_priv(bond_dev);
 	struct bond_up_slave *slaves;
 	bool xmit_suc = false;
-	bool skb_used = false;
 	int slaves_count, i;
 
 	if (all_slaves)
@@ -5326,24 +5325,18 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
 		if (!(bond_slave_is_up(slave) && slave->link == BOND_LINK_UP))
 			continue;
 
-		if (bond_is_last_slave(bond, slave)) {
-			skb2 = skb;
-			skb_used = true;
-		} else {
-			skb2 = skb_clone(skb, GFP_ATOMIC);
-			if (!skb2) {
-				net_err_ratelimited("%s: Error: %s: skb_clone() failed\n",
-						    bond_dev->name, __func__);
-				continue;
-			}
+		skb2 = skb_clone(skb, GFP_ATOMIC);
+		if (!skb2) {
+			net_err_ratelimited("%s: Error: %s: skb_clone() failed\n",
+					    bond_dev->name, __func__);
+			continue;
 		}
 
 		if (bond_dev_queue_xmit(bond, skb2, slave->dev) == NETDEV_TX_OK)
 			xmit_suc = true;
 	}
 
-	if (!skb_used)
-		dev_kfree_skb_any(skb);
+	dev_kfree_skb_any(skb);
 
 	if (xmit_suc)
 		return NETDEV_TX_OK;
-- 
2.43.0


