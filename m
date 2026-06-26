Return-Path: <netdev+bounces-302124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H4XoFdo6PmpeBwkAu9opvQ
	(envelope-from <netdev+bounces-302124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 10:39:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E216CB6DC
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 10:39:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="un/GEyo+";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302124-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302124-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6073B303B188
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 08:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0B7314A8E;
	Fri, 26 Jun 2026 08:39:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7669B3E3D86
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 08:39:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782463189; cv=none; b=ZKtheSMK9uNhxPCPZfiWrSQjo7X7VgchEgVmVX4zJbINU4rcaM3b/0kbMAPPot4tR4tW4MfkqzAYhVkzWNnNNnAMASx0KIDtOHQgGOnKIyiStzh80TMZ3elcDArXFvAKSwK8xH2MKBPMUU75/xoqMkepEZA3lZ7UKImdloH+xYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782463189; c=relaxed/simple;
	bh=QKQjIOERkEL1hUXuP2xrqNYqby2u56uczdQvYl83iKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F23X+LftcFsOGdVfc2jBbOsDHdXX4hB9/Bg5BVln+wljleKVtPSh7mxcA7IIO3HfmmMYZjbOaacv75h820mR620F0nZAaMJKOK8yxqsTWVHAEQWU2RiHszMbliMqJbodUtn9GWgXXscdz1nFYbfpP1YYX9EKc94pbQwXn1NaFjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=un/GEyo+; arc=none smtp.client-ip=91.218.175.170
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782463175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PA6hCiGzE66fmjJHAfRH4gg5KTKAd+aVqbApVfB/ibk=;
	b=un/GEyo+tKyJYyVyG8EPnO3Z1mA/K0zoVG4thj9w1rO2hP1RH/KrJBkl2TW3TeTyj7LST9
	aeoRxwSaPhvEXQQQrzUcBehJzEbtNKW0OfC0xai39hKYxCesEEBSRJmwNxawy+e37Z2j+g
	ZKXX1KUQ2+zM/kQLoTAxbkxwMJcBmKY=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jgarzik@redhat.com>,
	Bruce Allan <bruce.w.allan@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] e1000e: fix IRQ leak when request_irq() fails in e1000_request_msix()
Date: Fri, 26 Jun 2026 16:39:16 +0800
Message-ID: <20260626083917.49745-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiayuan.chen@linux.dev,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jgarzik@redhat.com,m:bruce.w.allan@intel.com,m:intel-wired-lan@lists.osuosl.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302124-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9E216CB6DC

An internal syzbot instance reported the warning below.

comedi (comedi_parport) lets userspace request_irq() an arbitrary IRQ
number and can thus grab one of e1000e's MSI-X vectors. When
e1000_request_msix() then fails partway through, it returned without
freeing the vectors it had already requested; pci_disable_msix() later
tears those descriptors down while their irqaction is still attached,
leaking the /proc/irq entry.

Free the already requested IRQs on the error path.

genirq: Flags mismatch irq 28. 00200000 (eth1-tx-0) vs. 00200000 (comedi_parport)

remove_proc_entry: removing non-empty directory 'irq/27', leaking at least 'eth1-rx-0'
WARNING: fs/proc/generic.c:742 at remove_proc_entry+0x436/0x560, CPU#3: ip/445
Modules linked in:
CPU: 3 UID: 0 PID: 445 Comm: ip Not tainted 7.1.0+ #284 PREEMPT
RIP: 0010:remove_proc_entry (fs/proc/generic.c:742 (discriminator 4))
PKRU: 55555554
Call Trace:
<TASK>
unregister_irq_proc (kernel/irq/proc.c:406)
free_desc (kernel/irq/irqdesc.c:482)
irq_free_descs (kernel/irq/irqdesc.c:874 kernel/irq/irqdesc.c:865)
irq_domain_free_irqs (kernel/irq/irqdomain.c:1917)
msi_domain_free_locked.part.0 (kernel/irq/msi.c:1619 kernel/irq/msi.c:1645)
msi_domain_free_irqs_all_locked (kernel/irq/msi.c:1632)
pci_msi_teardown_msi_irqs (drivers/pci/msi/irqdomain.c:28)
pci_free_msi_irqs (drivers/pci/msi/msi.c:925)
pci_disable_msix (drivers/pci/msi/api.c:200 drivers/pci/msi/api.c:193)
e1000_request_irq (drivers/net/ethernet/intel/e1000e/netdev.c:2028)
e1000e_open (drivers/net/ethernet/intel/e1000e/netdev.c:4681)
__dev_open (net/core/dev.c:1702)
netif_change_flags (net/core/dev.c:9806)
do_setlink.isra.0 (net/core/rtnetlink.c:3207 (discriminator 1))
rtnetlink_rcv_msg (net/core/rtnetlink.c:7068)
netlink_rcv_skb (net/netlink/af_netlink.c:2556)

Fixes: 4662e82b2cb4 ("e1000e: add support for new 82574L part")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 808e5cddd6a9..19b9823c5679 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -2099,7 +2099,7 @@ void e1000e_set_interrupt_capability(struct e1000_adapter *adapter)
 static int e1000_request_msix(struct e1000_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
-	int err = 0, vector = 0;
+	int err = 0, vector = 0, i;
 
 	if (strlen(netdev->name) < (IFNAMSIZ - 5))
 		snprintf(adapter->rx_ring->name,
@@ -2111,7 +2111,7 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
 			  e1000_intr_msix_rx, 0, adapter->rx_ring->name,
 			  netdev);
 	if (err)
-		return err;
+		goto err_free;
 	adapter->rx_ring->itr_register = adapter->hw.hw_addr +
 	    E1000_EITR_82574(vector);
 	adapter->rx_ring->itr_val = adapter->itr;
@@ -2127,7 +2127,7 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
 			  e1000_intr_msix_tx, 0, adapter->tx_ring->name,
 			  netdev);
 	if (err)
-		return err;
+		goto err_free;
 	adapter->tx_ring->itr_register = adapter->hw.hw_addr +
 	    E1000_EITR_82574(vector);
 	adapter->tx_ring->itr_val = adapter->itr;
@@ -2136,11 +2136,16 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
 	err = request_irq(adapter->msix_entries[vector].vector,
 			  e1000_msix_other, 0, netdev->name, netdev);
 	if (err)
-		return err;
+		goto err_free;
 
 	e1000_configure_msix(adapter);
 
 	return 0;
+
+err_free:
+	for (i = vector - 1; i >= 0; i--)
+		free_irq(adapter->msix_entries[i].vector, netdev);
+	return err;
 }
 
 /**
-- 
2.43.0


