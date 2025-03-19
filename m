Return-Path: <netdev+bounces-176068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 042A5A68986
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D16F37A1629
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 10:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4177E252917;
	Wed, 19 Mar 2025 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iCTsjA7v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m08hHwpv"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DE317A311
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380011; cv=none; b=RAZnPfnLYVQHC4yeEUMmDvL6MUaiWgv99WwCABJ0hrIOgxNG/hSiXvKifQk4XR/fPlfvBs5aX47gWAlCgbVM+556GI9QwxnsPirfOIZo/ykuGqY2OhkpKzaxv+pG8IfXKfejPOZbHa0twpXv6uWvTGluz8+4/tShod4qLZiuBB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380011; c=relaxed/simple;
	bh=BDUVO6GW7S6fdve/NnuJ4AEcsShUXzp/bOYEKxvDit8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cQSF5DMej/WlRelMh4VqWGAwTAs1bUEKepBlqbzxR7wy02VlLDUOUK9CH1LPYpTkj+zBaxp3vgdwKRyyeGonW9hml2mgFt64sxwAJ9ITFQocJMLbGPxkxiL5ocYgNlevdjApf3rit+zFYeh+67qvuw7ABMASYrPFs2CGCByFH80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iCTsjA7v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m08hHwpv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742380007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2A1JeoOMAoYrZ6soKOlYO6lqXRk+i4Kp3d88e7o1oJ0=;
	b=iCTsjA7vnu4uWXKyJ3UbrKZjSCC0UUkCo1uqk2cw5rv8qI+E2QZL5e2fU/XYvxDHjTE+X8
	pVHWoEL4ORz2QBi6m3W5hIOH6bXlMXsKf5XtvsOSQEigrB8kBiR6lkpV+W+ibe76vnSN32
	nOebf4h0AoMe72LJ5aENqXXwTJpaC58XMw7pEU+FvjmzEHSOa673i+gJ9uIn1f7BM7I6G3
	cg2J+GsNlpE+UCrJgQ4WJioYp/oQ3kMVvthwg2L3osq7bDYifUyhB87TRl3u5NRO33l6DM
	iqSkAHP5tW8qBo3fkWJSF2P/oN2AKPeHd1LzYR1sL7tXCypYIhEmEHXKFVbE3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742380007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2A1JeoOMAoYrZ6soKOlYO6lqXRk+i4Kp3d88e7o1oJ0=;
	b=m08hHwpveet5kl8+cqfCVKXefwtDyGgBCygy7gw6VfYwhgbjqCCcHAyMZr2J659VJkH727
	6wJWnxRAqjBObjDg==
Subject: [PATCH iwl-next v3 0/4] igb: XDP/ZC follow up
Date: Wed, 19 Mar 2025 11:26:38 +0100
Message-Id: <20250319-igb_irq-v3-0-b9ee902143dd@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN6b2mcC/12OQQ6CMBBFr0JmbU2pRcSV9zDG0HaASUjRFiuGc
 HdrTdS4/Pnz3p8ZPDpCD/tsBoeBPA02hs0qA93VtkVGJmYQXBRc8C2jVp3JXVlT1NJIg0rwEuL
 1xWFDUzIdge49sziNcIpNR34c3CNNhDz1b1vOP7aQM86UQV7utFGVaQ492dvoBkvT2mDyBPHLl
 l9WRFZq9fpPVrUW/+yyLE+XNOC06AAAAA==
X-Change-ID: 20250206-igb_irq-f5a4d4deb207
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Joe Damato <jdamato@fastly.com>, 
 Gerhard Engleder <gerhard@engleder-embedded.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>, Rinitha S <sx.rinitha@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Sweta Kumari <sweta.kumari@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=BDUVO6GW7S6fdve/NnuJ4AEcsShUXzp/bOYEKxvDit8=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBn2pvk+9rkL8hFeSRk1pcp99I0CaUrOal5F1ih3
 BlgV6X0a8OJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZ9qb5AAKCRDBk9HyqkZz
 grmfD/9S7GUByiyPNqD+QUhBJH9BCvxb/Hf6cxOoYgAAeEh89be2DNEory3f1n5JMaqwIvpRMvn
 1IDfdAJPQDEAj9Z13PQj4myfeCtPCdN5U3J2WK2/a2HIQoNT14WuSzJUTuLVCUZkMloawcSuCFB
 onh/sUok9W9J+UnBXdoeYczxK8c1zW8q13dvkXG8PFLfWP3cYmssYralkCFesaxOxqbM9PbcShd
 o+MoneRziUKIBY2TeCm2bpfR/2kejttFdQGoM01TQE3crLxtrE6tYsosaiCgx1HY5QH01r4437T
 JFnnBuUnTZVbO9lG+cjh/sM83AFTy4rL0rf/3ZngXPdN8vV1TJfFoeyRi3AY5mRb77TuGcdoTL2
 uq3ClapzM9s9Q+fOaQrn4CEtrVjLmN22Nu/yZAYPPdh24/fMys1sagbPR+x95ulEPvSTLs7vzm2
 Soyj7xTnBOF2P085lcdz6sOrvvNefQF3j+JvQv5aAQzq+Z5PzM4IFnQT1PARaxjNizYz95cwefV
 A8iEQ2wIYlgrdBSb++7qXhRmvbiH7zZNorsnpx217mlcCXGQTwqgC7hhFcaD7KVKhSQsOymVtff
 LtQLJ26gKeE1WGuHcB+DRYIPbPfoEEWXvMMLEbmd03DzNCo/zYodRFvuO6PJGLgI9NZ3a/cz57e
 +ahhaI+YluvQw1w==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

This is a follow up for the igb XDP/ZC implementation. The first three 
patches link the IRQs and queues to NAPI instances. This is required to 
bring back the XDP/ZC busy polling support. The last patch removes 
undesired IRQs (injected via igb watchdog) while busy polling with 
napi_defer_hard_irqs and gro_flush_timeout set.

I've dropped the tags for patch #2. Please, review and test again.

Test output:
|apl1:~/linux# uname -a
|Linux apl1 6.14.0-rc6+ #1 SMP PREEMPT_RT Wed Mar 19 08:31:00 CET 2025 x86_64 GNU/Linux
|apl1:~/linux# NETIF=enp2s0 ./tools/testing/selftests/drivers/net/queues.py
|TAP version 13
|1..4
|ok 1 queues.get_queues
|ok 2 queues.addremove_queues
|ok 3 queues.check_down
|ok 4 queues.check_xsk
|# Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
Changes in v3:
- Drop igb_set_queue_napi() in xsk code (Joe & Tony)
- Add tags
- Rebase to net-next
- Link to v2: https://lore.kernel.org/r/20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de

Changes in v2:
- Take RTNL lock in PCI error handlers (Joe)
- Fix typo in commit message (Gerhard)
- Use netif_napi_add_config() (Joe)
- Link to v1: https://lore.kernel.org/r/20250210-igb_irq-v1-0-bde078cdb9df@linutronix.de

---
Kurt Kanzenbach (4):
      igb: Link IRQs to NAPI instances
      igb: Link queues to NAPI instances
      igb: Add support for persistent NAPI config
      igb: Get rid of spurious interrupts

 drivers/net/ethernet/intel/igb/igb.h      |  5 +-
 drivers/net/ethernet/intel/igb/igb_main.c | 78 +++++++++++++++++++++++++++----
 drivers/net/ethernet/intel/igb/igb_xsk.c  |  1 +
 3 files changed, 73 insertions(+), 11 deletions(-)
---
base-commit: 23c9ff659140f97d44bf6fb59f89526a168f2b86
change-id: 20250206-igb_irq-f5a4d4deb207

Best regards,
-- 
Kurt Kanzenbach <kurt@linutronix.de>


