Return-Path: <netdev+bounces-291085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJcBFnmHEWqdnAYAu9opvQ
	(envelope-from <netdev+bounces-291085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 12:54:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF525BE92F
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 12:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0EE7301C3EA
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289F83876A7;
	Sat, 23 May 2026 10:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="BMYCOxLG"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9782DE6FF;
	Sat, 23 May 2026 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779533671; cv=none; b=nZTZAN62N7x5hBPaXmIKljH1iCmAJj7lT5DZ5IQJLaLSozlM/XyGUTZ5w3KbkRfnXhH0oDLkVc3HfBafrhu30E8ZP7CnZZ3kJ0u6GZz/gP9GfSPGoCSsVAMj84WxujNFw3IHnzRDr7LjfPEmb8y84T0pu00UsWR6tJBBN1fZ7Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779533671; c=relaxed/simple;
	bh=zTz9Xujk5okwTtSW/xMyTH8S2TiMnq0G+0JeauP3jgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f62NERpQLIuFNCYCJB4dsnGd+6olX4okDDxt1VuiS9yIHkNZKVPgoId3M8ER+3AP6NOkrkBhbk9ot6+fF/Wy9YI0CpNI/Sew2/iI5eay1R8UBbC32YqBJro3PTjUt1VQJgtrhn+q9j1TKYf8yUL9v2nXU+O5Bb4JH4IUTF/flvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=BMYCOxLG; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.7])
	by mail.ispras.ru (Postfix) with ESMTPSA id 8FB8445F79A5;
	Sat, 23 May 2026 10:48:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8FB8445F79A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1779533318;
	bh=8I718NLjrOXhp1MUXTCsy+d8AWGiFC7W1rspmjLD5AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BMYCOxLGrOrud9ScziUNDU1ygAidUlF95YB1j+UDO4VAinUZRe4nufDZYRf3yp+4o
	 1hAGxGkzEvwngHl3OUm1BOvlL29qN45K90jazRSwbPp6Wd4SNlMlbTAMLCh/5wrqV1
	 bQ2U1uus6rCn94zb0F3C5OeRiAxt5JMfrTa/FIjU=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jie Deng <Jie.Deng1@synopsys.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH net 2/2] net: dwc-xlgmac: handle hw initialization failure in xlgmac_start()
Date: Sat, 23 May 2026 13:45:28 +0300
Message-ID: <20260523104740.295650-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523104740.295650-1-pchelkin@ispras.ru>
References: <20260523104740.295650-1-pchelkin@ispras.ru>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291085-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[ispras.ru:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ispras.ru:email,ispras.ru:mid,ispras.ru:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qemu.org:url]
X-Rspamd-Queue-Id: ADF525BE92F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hw_ops->init() can fail, thus leaving uninitialized TX and RX descriptor
objects.  Later when they are updated in xlgmac_dev_xmit(), there is a
NULL pointer dereference.

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 31 Comm: kworker/1:1 Not tainted 6.1.164+ #122
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
Workqueue: mld mld_ifc_work
RIP: 0010:xlgmac_dev_xmit+0x62f/0x1260 drivers/net/ethernet/synopsys/dwc-xlgmac-hw.c:827
Call Trace:
 <TASK>
 xlgmac_xmit+0xa14/0x1196 drivers/net/ethernet/synopsys/dwc-xlgmac-net.c:766
 __netdev_start_xmit include/linux/netdevice.h:4896 [inline]
 netdev_start_xmit include/linux/netdevice.h:4910 [inline]
 xmit_one net/core/dev.c:3683 [inline]
 dev_hard_start_xmit+0x126/0x680 net/core/dev.c:3699
 sch_direct_xmit+0x18a/0x7e0 net/sched/sch_generic.c:345
 __dev_xmit_skb net/core/dev.c:3920 [inline]
 __dev_queue_xmit+0x19ef/0x3da0 net/core/dev.c:4325
 dev_queue_xmit include/linux/netdevice.h:3051 [inline]
 neigh_resolve_output net/core/neighbour.c:1568 [inline]
 neigh_resolve_output+0x563/0x880 net/core/neighbour.c:1548
 neigh_output include/net/neighbour.h:545 [inline]
 ip6_finish_output2+0xb4f/0x2390 net/ipv6/ip6_output.c:138
 __ip6_finish_output+0x48c/0x1300 net/ipv6/ip6_output.c:205
 ip6_finish_output net/ipv6/ip6_output.c:216 [inline]
 NF_HOOK_COND include/linux/netfilter.h:291 [inline]
 ip6_output+0x250/0x910 net/ipv6/ip6_output.c:237
 dst_output include/net/dst.h:453 [inline]
 NF_HOOK.constprop.0+0x111/0x8a0 include/linux/netfilter.h:302
 mld_sendpack+0x67b/0xd40 net/ipv6/mcast.c:1825
 mld_send_cr net/ipv6/mcast.c:2126 [inline]
 mld_ifc_work+0x7a5/0xd80 net/ipv6/mcast.c:2656
 process_one_work+0x97f/0x1470 kernel/workqueue.c:2292
 worker_thread+0x5a1/0x1090 kernel/workqueue.c:2439
 kthread+0x2e1/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x22/0x30 arch/x86/entry/entry_64.S:295

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 65e0ace2c5cd ("net: dwc-xlgmac: Initial driver for DesignWare Enterprise Ethernet")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/net/ethernet/synopsys/dwc-xlgmac-net.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/synopsys/dwc-xlgmac-net.c b/drivers/net/ethernet/synopsys/dwc-xlgmac-net.c
index 37101dc50d04..1a6906f8fc44 100644
--- a/drivers/net/ethernet/synopsys/dwc-xlgmac-net.c
+++ b/drivers/net/ethernet/synopsys/dwc-xlgmac-net.c
@@ -564,7 +564,9 @@ static int xlgmac_start(struct xlgmac_pdata *pdata)
 	struct net_device *netdev = pdata->netdev;
 	int ret;
 
-	hw_ops->init(pdata);
+	ret = hw_ops->init(pdata);
+	if (ret)
+		goto err_init;
 	xlgmac_napi_enable(pdata, 1);
 
 	ret = xlgmac_request_irqs(pdata);
@@ -580,7 +582,7 @@ static int xlgmac_start(struct xlgmac_pdata *pdata)
 err_napi:
 	xlgmac_napi_disable(pdata, 1);
 	hw_ops->exit(pdata);
-
+err_init:
 	return ret;
 }
 
-- 
2.53.0


