Return-Path: <netdev+bounces-221405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E666B50722
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 22:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE821543A12
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F6E2FD1B6;
	Tue,  9 Sep 2025 20:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="em5FOxvg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8FB3570CF
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449966; cv=none; b=PlX0PTkYWahdJ6Lelc/heSARvUA6QYctTdQUp8dR6sTBaDdgiJ9ib69uUBTlPnCM/jbOhfy0rO0KTK9biA7f3iIhOwSZ7GIXVc1Yu20Ir87B5yqa3l39k/E/kJZiuWz4QCz4vatBcjdGF/AleqPgdAHKLsnDBcpJR7PlIaAigds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449966; c=relaxed/simple;
	bh=KwzOrY97+LrpdkX8pK/d1xaMT1gkKu/8RE7Eu4aLJMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bd+O/0QpzxbdKW+gQOgYJ5ER7SRNt2nhL/gDaA/iMkNvg6NQJ64YqCtdNzjhq3t89DKI/iezZZKHTC2NlZY5YOjrv8ftq/XJ7qvJmz6NgkJlDRW/fLLLKQsW01Fz54bcxcfXLrpzEOrdtHn8u5UZcyoFwCCdg2pkrnjgy/6VI4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=em5FOxvg; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757449965; x=1788985965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KwzOrY97+LrpdkX8pK/d1xaMT1gkKu/8RE7Eu4aLJMM=;
  b=em5FOxvgEenDAE/a+JDY8LQNAajP+wx+DtKEXZ/+H9bcKmf9AP130oJ5
   SQaqKote10/7zOAHdOkYp6nVV3a/DRgvBL8GBpJx1QSLnhaVpm6QtAgb5
   Wg439zIqvDYNhtaT0qxeFFEhCfhl5HnBIzYjvH5MM3CGjzShPq8Scjvb8
   gtUT1Z/W2rI91Oka7ZDF62l0/LhWA9k0Z5ezHndLSqadrM0/SxrUfKCEX
   Mz7jSI58qmf9uJqzmn/UNRrXhH+WzpTtb7VjW4rl4IyjcEYuDuPAUw8Rp
   vPcOJ7McrAs4+l959EskpaLEzO8D3Y+7hDzFzNS/xbnhRaRPH578BP0J6
   A==;
X-CSE-ConnectionGUID: WewFs3LMSkOjqLlrj/3CJg==
X-CSE-MsgGUID: N//5uuNlSxiXqA0FxVKDhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="59606780"
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="59606780"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 13:32:42 -0700
X-CSE-ConnectionGUID: fKe1SFbNQfGqZn7yXLK5fA==
X-CSE-MsgGUID: v6RTeAAKQH2JVlqSHxPn6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="173287034"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 09 Sep 2025 13:32:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 3/4] i40e: fix IRQ freeing in i40e_vsi_request_irq_msix error path
Date: Tue,  9 Sep 2025 13:32:33 -0700
Message-ID: <20250909203236.3603960-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250909203236.3603960-1-anthony.l.nguyen@intel.com>
References: <20250909203236.3603960-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Schmidt <mschmidt@redhat.com>

If request_irq() in i40e_vsi_request_irq_msix() fails in an iteration
later than the first, the error path wants to free the IRQs requested
so far. However, it uses the wrong dev_id argument for free_irq(), so
it does not free the IRQs correctly and instead triggers the warning:

 Trying to free already-free IRQ 173
 WARNING: CPU: 25 PID: 1091 at kernel/irq/manage.c:1829 __free_irq+0x192/0x2c0
 Modules linked in: i40e(+) [...]
 CPU: 25 UID: 0 PID: 1091 Comm: NetworkManager Not tainted 6.17.0-rc1+ #1 PREEMPT(lazy)
 Hardware name: [...]
 RIP: 0010:__free_irq+0x192/0x2c0
 [...]
 Call Trace:
  <TASK>
  free_irq+0x32/0x70
  i40e_vsi_request_irq_msix.cold+0x63/0x8b [i40e]
  i40e_vsi_request_irq+0x79/0x80 [i40e]
  i40e_vsi_open+0x21f/0x2f0 [i40e]
  i40e_open+0x63/0x130 [i40e]
  __dev_open+0xfc/0x210
  __dev_change_flags+0x1fc/0x240
  netif_change_flags+0x27/0x70
  do_setlink.isra.0+0x341/0xc70
  rtnl_newlink+0x468/0x860
  rtnetlink_rcv_msg+0x375/0x450
  netlink_rcv_skb+0x5c/0x110
  netlink_unicast+0x288/0x3c0
  netlink_sendmsg+0x20d/0x430
  ____sys_sendmsg+0x3a2/0x3d0
  ___sys_sendmsg+0x99/0xe0
  __sys_sendmsg+0x8a/0xf0
  do_syscall_64+0x82/0x2c0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  [...]
  </TASK>
 ---[ end trace 0000000000000000 ]---

Use the same dev_id for free_irq() as for request_irq().

I tested this with inserting code to fail intentionally.

Fixes: 493fb30011b3 ("i40e: Move q_vectors from pointer to array to array of pointers")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b83f823e4917..dd21d93d39dd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4156,7 +4156,7 @@ static int i40e_vsi_request_irq_msix(struct i40e_vsi *vsi, char *basename)
 		irq_num = pf->msix_entries[base + vector].vector;
 		irq_set_affinity_notifier(irq_num, NULL);
 		irq_update_affinity_hint(irq_num, NULL);
-		free_irq(irq_num, &vsi->q_vectors[vector]);
+		free_irq(irq_num, vsi->q_vectors[vector]);
 	}
 	return err;
 }
-- 
2.47.1


