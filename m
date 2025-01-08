Return-Path: <netdev+bounces-156418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1B9A06547
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 20:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10DBF1618D6
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 19:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94834190468;
	Wed,  8 Jan 2025 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fi0c+5yI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBCE12B94
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736364229; cv=none; b=NdK9sfSTZd7ZBas9gfszqML/YLZPbxN72bat8RD/f+dVvXx4BS45cDa6004mXfwTQ0y0kz+jbl5QJbe030xMhvJZakV4P0dp+501qNCblbVpEpbncVcYYg3XPl+/exAfdgh82fBCmE4AtwvNNG1vUeLCWC9uDQN+Lc7AXQ/kxig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736364229; c=relaxed/simple;
	bh=ferYI6/ZnsMBLQu6KBfzwxpruW94tONr9Q3bSiCdu+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=krSCn5IPHOipWBp3nNG7ZBH+RVJ45vMTBCWAO/+ONBCN4B0P4ylgND0e+6nzosJJtF51Wcrnlio916dlp2npRxx34dnhbcDhV+5UpoO3b6BaO5NOD4rrykouoJSOdYKgJ8BrVP7cJyxTKNdzq7M35U9Acwlv4GgOqQuzLdaptWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fi0c+5yI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89720C4CED3;
	Wed,  8 Jan 2025 19:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736364228;
	bh=ferYI6/ZnsMBLQu6KBfzwxpruW94tONr9Q3bSiCdu+o=;
	h=From:To:Cc:Subject:Date:From;
	b=fi0c+5yIoye7qT6DSD5xGtxuE3+2kqwyjphHcQW8zB5CSAa/a1moPAP9eNLTjKKfk
	 pbpqOdcPeHw7VoGb+wP0fB5CLmo451LLCAoGJIoLJjgmUwnR73i/82IfxjT64vNu8A
	 zF94iBzPKOwtw6DZsqVyJf5YFNW/Zdl7Kel+5sqaPonMds1GvsEu3XCzTVYaiOiIzq
	 yNIkfqk8Blb8CeHwVwoyyDAFCM9yr0DlHpGbyqdumSNbpXGEcnAE10pyd4Cbd56y/e
	 K5dCWpxxZ5kiZV6Lk9XrlgThqWWYyuK3+pIzFB7aV7+6g32RSoLbS3ajS0HqW/TJTd
	 pObCRxh1oO68w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Potin Lai <potin.lai@quantatw.com>,
	Potin Lai <potin.lai.pt@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	sam@mendozajonas.com,
	fr0st61te@gmail.com,
	fercerpav@gmail.com
Subject: [PATCH net v2] Revert "net/ncsi: change from ndo_set_mac_address to dev_set_mac_address"
Date: Wed,  8 Jan 2025 11:23:46 -0800
Message-ID: <20250108192346.2646627-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Potin Lai <potin.lai@quantatw.com>

This reverts commit 790071347a0a1a89e618eedcd51c687ea783aeb3.

We are seeing kernel panic when enabling two NCSI interfaces at same
time. It looks like mutex lock is being used in softirq caused the
issue.

Kernel panic log:

  8021q: adding VLAN 0 to HW filter on device eth0
  ftgmac100 1e670000.ethernet eth0: NCSI: Handler for packet type 0x82 returned -19
  BUG: scheduling while atomic: systemd-network/697/0x00000100
  Modules linked in:
  8021q: adding VLAN 0 to HW filter on device eth1
  CPU: 0 PID: 697 Comm: systemd-network Tainted: G        W          6.6.62-8ea1fc6-dirty-cbd80d0-gcbd80d04d13c #1
  Hardware name: Generic DT based system
   unwind_backtrace from show_stack+0x18/0x1c
   show_stack from dump_stack_lvl+0x40/0x4c
   dump_stack_lvl from __schedule_bug+0x5c/0x70
   __schedule_bug from __schedule+0x884/0x968
   __schedule from schedule+0x58/0xa8
   schedule from schedule_preempt_disabled+0x14/0x18
   schedule_preempt_disabled from __mutex_lock.constprop.0+0x350/0x76c
   __mutex_lock.constprop.0 from ncsi_rsp_handler_oem_gma+0x104/0x1a0
   ncsi_rsp_handler_oem_gma from ncsi_rcv_rsp+0x120/0x2cc
   ncsi_rcv_rsp from __netif_receive_skb_one_core+0x60/0x84
   __netif_receive_skb_one_core from netif_receive_skb+0x38/0x148
   netif_receive_skb from ftgmac100_poll+0x358/0x444
   ftgmac100_poll from __napi_poll.constprop.0+0x34/0x1d0
   __napi_poll.constprop.0 from net_rx_action+0x350/0x43c
   net_rx_action from handle_softirqs+0x114/0x32c
   handle_softirqs from irq_exit+0x88/0xb8
   irq_exit from call_with_stack+0x18/0x20
   call_with_stack from __irq_usr+0x78/0xa0
  Exception stack(0xe075dfb0 to 0xe075dff8)
  dfa0:                                     00000000 00000000 00000000 00000020
  dfc0: 00000069 aefde3e0 00000000 00000000 00000000 00000000 00000000 aefde4e4
  dfe0: 01010101 aefddf20 a6b4331c a6b43618 600f0010 ffffffff

Fixes: 790071347a0a ("net/ncsi: change from ndo_set_mac_address to dev_set_mac_address")
Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Looks like we're not making any progress on this one, so let's
go with the revert for 6.13.

Original posting by Potin Lai:
  https://lore.kernel.org/20241129-potin-revert-ncsi-set-mac-addr-v1-1-94ea2cb596af@gmail.com

I added the Fixes tag and trimmed the kernel log.

CC: sam@mendozajonas.com
CC: fr0st61te@gmail.com
CC: fercerpav@gmail.com
---
 net/ncsi/ncsi-rsp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index e28be33bdf2c..0cd7b916d3f8 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -629,6 +629,7 @@ static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
 {
 	struct ncsi_dev_priv *ndp = nr->ndp;
 	struct net_device *ndev = ndp->ndev.dev;
+	const struct net_device_ops *ops = ndev->netdev_ops;
 	struct ncsi_rsp_oem_pkt *rsp;
 	struct sockaddr saddr;
 	u32 mac_addr_off = 0;
@@ -655,9 +656,7 @@ static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
 	/* Set the flag for GMA command which should only be called once */
 	ndp->gma_flag = 1;
 
-	rtnl_lock();
-	ret = dev_set_mac_address(ndev, &saddr, NULL);
-	rtnl_unlock();
+	ret = ops->ndo_set_mac_address(ndev, &saddr);
 	if (ret < 0)
 		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");
 
-- 
2.47.1


