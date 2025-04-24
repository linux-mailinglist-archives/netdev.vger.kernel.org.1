Return-Path: <netdev+bounces-185447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADFBA9A676
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6B01B86000
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 08:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AB0212FAB;
	Thu, 24 Apr 2025 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DwJjyCHB"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B4020F09A;
	Thu, 24 Apr 2025 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745484038; cv=none; b=p39F4n2NY0WcXG1y76m6OzJdY7KfaGa1aEZm2xmQK1jlJtuAbKhmX8DaNXko2ZV6MfaRHkY3QwBn1WNVR0f9g+SPrUFC3lglkyzbj9+hQeGl8f7TZEKle/OmjI0rrgRJqtC0WJkFyQEJBEATP9uqO2TYyytrGd9RMGiecmNPuEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745484038; c=relaxed/simple;
	bh=7Vx7ItJ/6faelSa7z2An9OsZOu9dQ1KbcJtEn0JBz7o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n6R1wLG5xE6686Cra7brsDoun8K3xbheyG3hs1kNZZvyOAxT8CwaO7RrmZq7tUhXXhAmmsafNVuA/z/f5wPj/Ko2k1bpgbEvQ2Tn77HMQNIfUdaFL1D68wEFGXZluPpgxHHEJoqqWepkby1CFapJuZyRJa2Kbqjb6yzXG6kubsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DwJjyCHB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745484034;
	bh=7Vx7ItJ/6faelSa7z2An9OsZOu9dQ1KbcJtEn0JBz7o=;
	h=From:Subject:Date:To:Cc:From;
	b=DwJjyCHB4qM6EABFTed8/oZxLcdx8V3sNngWjyiL5j948xR5XPidwz4eAUOeX/mYx
	 RJKbeghO3KU2SaheIYSosRhZ+mZp3CXgTA/OZxM3+BUtXbRIJSV7LIz7V6SzgiBXXi
	 T+0k0aPVeVDsk47spM1H9FAYEAZP9aBFJ5E4CeOf00vLm6tvg5ZITdHL16oh8PIXjM
	 Qehdzz2e610nWoTcFlo/uPArOVj8XjhWeU9mswW2XcAoB7W6QHODeMijJkz2SUHcRF
	 vfmj14jnWVoJ6sfqeIIpO0oBbeZcpU/qomUoOhscJIOlpA9rypRHtGMGsbuRKK1KR1
	 JzTJHU7Eneh8A==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3F1E917E0F66;
	Thu, 24 Apr 2025 10:40:33 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Subject: [PATCH net v2 0/2] net: ethernet: mtk-star-emac: fix several
 issues on rx/tx poll
Date: Thu, 24 Apr 2025 10:38:47 +0200
Message-Id: <20250424-mtk_star_emac-fix-spinlock-recursion-issue-v2-0-f3fde2e529d8@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJf4CWgC/5WOUW7CMBBErxLtdxfZJhTIF/eoEHLMtqxIbLrrR
 CCUu2MCPUA/Z2dn3txBSZgUmuoOQiMrp1iE+6ggnHz8IeRj0eCMW5nabrDP54NmLwfqfcBvvqJ
 eOHYpnFEoDPIsQFYdCOujDVtn1qF1FkrhRaj8z7AviJRh/zoK/Q4FnN9O65UwpL7n3FSRrhlfc
 OfmwIk1J7nNi0c7J/78/4wbLRq0tK3J10uz/DS7kLrOt0n8osBhP03TA48de2geAQAA
X-Change-ID: 20250418-mtk_star_emac-fix-spinlock-recursion-issue-4d1c9207cb21
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Biao Huang <biao.huang@mediatek.com>, 
 Yinghua Pan <ot_yinghua.pan@mediatek.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@collabora.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745484033; l=3317;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=7Vx7ItJ/6faelSa7z2An9OsZOu9dQ1KbcJtEn0JBz7o=;
 b=3rrhAI6FTXXn2kA6OC9IUtYowxwH4UUAeS18HEAmXgydiFFkjDb1Hqk+4sXkEBGTWS4CMD/PG
 1pk9oLrHJPGA9g5PyaD6b7svutfEQC/OemREgrRdoobK48OvS1GuF7x
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

This patchset fixes two issues with the mtk-star-emac driver.

The first patch fixes spin lock recursion issues I've observed on the
Mediatek Genio 350-EVK board using this driver when the Ethernet
functionality is enabled on the board (requires a correct jumper and
DIP switch configuration, as well as enabling the device in the
devicetree).
The issues can be easily reproduced with apt install or ssh commands
especially and with the CONFIG_DEBUG_SPINLOCK parameter, when
one occurs, there is backtrace similar to this:
```
BUG: spinlock recursion on CPU#0, swapper/0/0
 lock: 0xffff00000db9cf20, .magic: dead4ead, .owner: swapper/0/0,
	.owner_cpu: 0
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted
	6.15.0-rc2-next-20250417-00001-gf6a27738686c-dirty #28 PREEMPT
Hardware name: MediaTek MT8365 Open Platform EVK (DT)
Call trace:
 show_stack+0x18/0x24 (C)
 dump_stack_lvl+0x60/0x80
 dump_stack+0x18/0x24
 spin_dump+0x78/0x88
 do_raw_spin_lock+0x11c/0x120
 _raw_spin_lock+0x20/0x2c
 mtk_star_handle_irq+0xc0/0x22c [mtk_star_emac]
 __handle_irq_event_percpu+0x48/0x140
 handle_irq_event+0x4c/0xb0
 handle_fasteoi_irq+0xa0/0x1bc
 handle_irq_desc+0x34/0x58
 generic_handle_domain_irq+0x1c/0x28
 gic_handle_irq+0x4c/0x120
 do_interrupt_handler+0x50/0x84
 el1_interrupt+0x34/0x68
 el1h_64_irq_handler+0x18/0x24
 el1h_64_irq+0x6c/0x70
 regmap_mmio_read32le+0xc/0x20 (P)
 _regmap_bus_reg_read+0x6c/0xac
 _regmap_read+0x60/0xdc
 regmap_read+0x4c/0x80
 mtk_star_rx_poll+0x2f4/0x39c [mtk_star_emac]
 __napi_poll+0x38/0x188
 net_rx_action+0x164/0x2c0
 handle_softirqs+0x100/0x244
 __do_softirq+0x14/0x20
 ____do_softirq+0x10/0x20
 call_on_irq_stack+0x24/0x64
 do_softirq_own_stack+0x1c/0x40
 __irq_exit_rcu+0xd4/0x10c
 irq_exit_rcu+0x10/0x1c
 el1_interrupt+0x38/0x68
 el1h_64_irq_handler+0x18/0x24
 el1h_64_irq+0x6c/0x70
 cpuidle_enter_state+0xac/0x320 (P)
 cpuidle_enter+0x38/0x50
 do_idle+0x1e4/0x260
 cpu_startup_entry+0x34/0x3c
 rest_init+0xdc/0xe0
 console_on_rootfs+0x0/0x6c
 __primary_switched+0x88/0x90
```

The second patch is a cleanup patch to fix a inconsistency in the
mtk_star_rx_poll function between the napi_complete_done api usage and
its description in documentation.

I've tested this patchset on Mediatek Genio 350-EVK board with a kernel
based on linux-next (tag: next-20250422).

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
Changes in v2:
- Add missing net subject-prefix for patchs and patchset
- Remove unneeded init for new local variables and order them in reverse
  christmas tree
- Add missing Fixes: tag in second patch commit message
- Link to v1: https://lore.kernel.org/r/20250422-mtk_star_emac-fix-spinlock-recursion-issue-v1-0-1e94ea430360@collabora.com

---
Louis-Alexis Eyraud (2):
      net: ethernet: mtk-star-emac: fix spinlock recursion issues on rx/tx poll
      net: ethernet: mtk-star-emac: rearm interrupts in rx_poll only when advised

 drivers/net/ethernet/mediatek/mtk_star_emac.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)
---
base-commit: 1d2c58af2b22324cc536113e010d1a38d443f888
change-id: 20250418-mtk_star_emac-fix-spinlock-recursion-issue-4d1c9207cb21

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>


